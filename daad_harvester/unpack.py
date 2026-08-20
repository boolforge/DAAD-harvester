"""Recursive unpacker module supporting archives, disk images, tape dumps, and memory snapshots."""

import json
import re
import zlib
import zipfile
import tarfile
import hashlib
import subprocess
import shutil
import tempfile
import concurrent.futures
from pathlib import Path
from typing import List, Tuple, Optional, Dict
try:
    import py7zr
except ImportError:
    py7zr = None

try:
    import rarfile
except ImportError:
    rarfile = None

try:
    import zipfile_deflate64
except ImportError:
    zipfile_deflate64 = None

try:
    import xxhash
except ImportError:
    xxhash = None

import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, SourceRecord, SourceStatus
from daad_harvester.daad_logger import LoggerSuite
from daad_harvester.platform_media import (
    decompress_adz,
    decompress_dms,
    decompress_msa,
    extract_adf,
    extract_c64_tap_kernal_packets,
    extract_fat,
    extract_msx_cas,
    extract_p00,
    extract_t64,
    extract_tzx,
)
from daad_harvester.media_inspection import inspect_native_media
from daad_harvester.daad_parser import DAADParser

logger = structlog.get_logger(__name__)


SPECIAL_SYMBOLS = set(r'\/:*?"<>|')


def escape_string(s: str) -> str:
    r"""
    Escape strings inspired by ScummVM dumper-companion.py:
    - escape char: \x81
    - unallowed filename chars (\/:*?"<>|)
    - control chars < 0x20 and non-printable ranges
    """
    new_name = ""
    for char in s:
        if char == "\x81":
            new_name += "\x81\x79"
        elif char in SPECIAL_SYMBOLS or ord(char) < 0x20 or ord(char) == 0x7F or (0x80 <= ord(char) <= 0x9F):
            new_name += "\x81" + chr(0x80 + (ord(char) & 0x7F))
        else:
            new_name += char
    return new_name


def punyencode(orig: str) -> str:
    """Punyencode strings to sanitize non-ASCII or reserved characters safely."""
    s = escape_string(orig)
    try:
        encoded = s.encode("punycode").decode("ascii")
    except Exception:
        encoded = "".join(c if c.isalnum() or c in "._-" else "_" for c in orig)

    if len(encoded) == 0:
        return orig

    compare = encoded
    if encoded[-1] == "-":
        compare = encoded[:-1]
    if orig != compare or (compare and compare[-1] in " ."):
        return "xn--" + encoded
    return orig


def sanitize_filename(filename: str) -> str:
    """Sanitize filename using ScummVM punycode rules and filesystem cleaning."""
    if not filename:
        return "unnamed"

    clean_name = filename.replace("\\", "/").split("/")[-1]
    sanitized = punyencode(clean_name)
    sanitized = re.sub(r'[\x00-\x1f\x7f-\x9f\\/:*?"<>|]', '_', sanitized)
    sanitized = sanitized.strip(" .")
    if not sanitized:
        sanitized = "unnamed"
    return sanitized


def safe_write_bytes(dest_path: Path, data: bytes) -> Path:
    """Writes bytes to dest_path safely. If write fails due to OS/filesystem errors, falls back to safe hash name."""
    dest_path.parent.mkdir(parents=True, exist_ok=True)
    try:
        dest_path.write_bytes(data)
        return dest_path
    except (OSError, PermissionError) as exc:
        logger.warning("disk_write_error_trying_fallback", path=str(dest_path), error=str(exc))
        md5_hash = hashlib.md5(data).hexdigest()[:12]
        fallback_path = dest_path.parent / f"fallback_{md5_hash}.bin"
        try:
            fallback_path.write_bytes(data)
            return fallback_path
        except Exception as exc2:
            logger.error("fallback_disk_write_failed", path=str(fallback_path), error=str(exc2))
            raise exc2


def compute_hashes(data: bytes) -> Dict[str, str]:
    """Computes full suite of cryptographic, fast xxhash, and checksum algorithms."""
    md5_full = hashlib.md5(data).hexdigest()
    md5_5000 = hashlib.md5(data[:5000]).hexdigest()
    md5_tail5000 = hashlib.md5(data[-5000:] if len(data) >= 5000 else data).hexdigest()
    sha1 = hashlib.sha1(data).hexdigest()
    sha224 = hashlib.sha224(data).hexdigest()
    sha256 = hashlib.sha256(data).hexdigest()
    sha384 = hashlib.sha384(data).hexdigest()
    sha512 = hashlib.sha512(data).hexdigest()
    sha3_256 = hashlib.sha3_256(data).hexdigest()
    sha3_512 = hashlib.sha3_512(data).hexdigest()
    blake2b = hashlib.blake2b(data).hexdigest()
    blake2s = hashlib.blake2s(data).hexdigest()
    crc32 = f"{zlib.crc32(data) & 0xFFFFFFFF:08x}"
    adler32 = f"{zlib.adler32(data) & 0xFFFFFFFF:08x}"

    xxh32 = xxhash.xxh32(data).hexdigest() if xxhash else ""
    xxh64 = xxhash.xxh64(data).hexdigest() if xxhash else ""
    xxh128 = xxhash.xxh128(data).hexdigest() if xxhash else ""

    return {
        "md5_full": md5_full,
        "md5_5000": md5_5000,
        "md5_tail5000": md5_tail5000,
        "sha1": sha1,
        "sha224": sha224,
        "sha256": sha256,
        "sha384": sha384,
        "sha512": sha512,
        "sha3_256": sha3_256,
        "sha3_512": sha3_512,
        "blake2b": blake2b,
        "blake2s": blake2s,
        "crc32": crc32,
        "adler32": adler32,
        "xxh32": xxh32,
        "xxh64": xxh64,
        "xxh128": xxh128,
    }


class Unpacker:
    """Recursive unpacker handling multi-layer archive and disk image container extraction."""

    def __init__(self, db: Database, extract_dir: Optional[Path] = None):
        self.db = db
        self.extract_dir = extract_dir or (settings.output_dir / "extracted")
        self.extract_dir.mkdir(parents=True, exist_ok=True)
        self.logger_suite = LoggerSuite(settings.logs_dir)

    def _is_zip_bomb(self, compressed_size: int, uncompressed_size: int) -> bool:
        """Zip bomb protection check (10x ratio default limit)."""
        if compressed_size == 0:
            return False
        return (uncompressed_size / compressed_size) > settings.zip_bomb_max_ratio

    def _unpack_via_cli(self, file_path: Path, archive_type: str = "7z") -> List[Tuple[str, bytes]]:
        """Fallback unpacking using system CLI tools (7z, 7za, 7zr, unzip, unar, bsdtar, unrar, arj, unarj, lha, lhasa, cabextract). Note: zoo and arc formats are handled directly via unar."""
        tool_map = {
            "zip": ["7z", "7za", "7zr", "unzip", "unar", "bsdtar"],
            "7z": ["7z", "7za", "7zr", "unar", "bsdtar"],
            "rar": ["unrar", "7z", "7za", "7zr", "unar", "bsdtar"],
            "arj": ["arj", "unarj", "7z", "7za", "unar", "bsdtar"],
            "lha": ["lha", "lhasa", "7z", "7za", "unar", "bsdtar"],
            "lzh": ["lha", "lhasa", "7z", "7za", "unar", "bsdtar"],
            "zoo": ["unar", "7z"],
            "arc": ["unar", "7z"],
            "cab": ["cabextract", "7z", "7za", "unar"],
            "tar": ["bsdtar", "tar", "7z", "7za", "unar"],
        }
        tools = tool_map.get(archive_type, ["7z", "7za", "7zr", "unar", "bsdtar"])

        tested_tools = []
        for exe in tools:
            if not shutil.which(exe):
                continue

            tested_tools.append(exe)
            try:
                with tempfile.TemporaryDirectory() as tmpdir:
                    tmp_path = Path(tmpdir)
                    if exe in ("7z", "7za", "7zr"):
                        cmd = [exe, "x", "-y", f"-o{tmpdir}", str(file_path)]
                    elif exe == "unzip":
                        cmd = [exe, "-q", "-o", str(file_path), "-d", tmpdir]
                    elif exe == "unar":
                        cmd = [exe, "-o", tmpdir, "-f", str(file_path)]
                    elif exe in ("bsdtar", "tar"):
                        cmd = [exe, "-xf", str(file_path), "-C", tmpdir]
                    elif exe in ("unrar", "arj"):
                        cmd = [exe, "x", "-y", str(file_path), f"{tmpdir}/"]
                    elif exe == "unarj":
                        cmd = [exe, "x", str(file_path)]
                    elif exe in ("lha", "lhasa"):
                        cmd = [exe, "xI", f"-w={tmpdir}", str(file_path)]
                    elif exe == "zoo":
                        cmd = [exe, "x//", str(file_path)]
                    elif exe in ("nomarch", "arc"):
                        cmd = [exe, "-x", str(file_path)]
                    elif exe == "cabextract":
                        cmd = [exe, "-q", "-d", tmpdir, str(file_path)]
                    else:
                        continue

                    res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=tmpdir, timeout=60)
                    if res.returncode != 0:
                        err_text = res.stderr.decode('utf-8', errors='ignore')
                        logger.warning("cli_unpack_failed", file=str(file_path), exe=exe, stderr=err_text)
                        self.logger_suite.log_compression_error(str(file_path), archive_type, err_text, tool_used=exe)
                        continue

                    extracted = []
                    for p in tmp_path.rglob("*"):
                        if p.is_file():
                            rel_name = p.relative_to(tmp_path).as_posix()
                            extracted.append((rel_name, p.read_bytes()))

                    if extracted:
                        return extracted
            except Exception as exc:
                logger.warning("cli_unpack_exception", file=str(file_path), exe=exe, error=str(exc))
                self.logger_suite.log_compression_error(str(file_path), archive_type, str(exc), tool_used=exe)

        missing_tools = [exe for exe in tools if not shutil.which(exe)]
        msg = f"Consider installing system packages for {archive_type}: {', '.join(missing_tools)}" if missing_tools else "All candidate tools were tried but failed."
        logger.warning(
            "cli_unpack_tool_not_found_or_failed",
            file=str(file_path),
            archive_type=archive_type,
            tested_tools=tested_tools,
            recommended_install=msg
        )
        self.logger_suite.log_compression_error(str(file_path), archive_type, msg, tool_used="CLI Fallback Suite")
        return []

    # --- Layer 1: Standard Archives ---

    def unpack_zip(self, file_path: Path) -> List[Tuple[str, bytes]]:
        extracted = []
        compressed_size = file_path.stat().st_size
        has_read_error = False
        read_errors = []

        zip_cls = zipfile_deflate64.ZipFile if zipfile_deflate64 is not None else zipfile.ZipFile

        try:
            with zip_cls(file_path, 'r') as zf:
                total_uncompressed = sum(info.file_size for info in zf.infolist())
                if self._is_zip_bomb(compressed_size, total_uncompressed):
                    logger.warning("zip_bomb_detected", file=str(file_path))
                    self.logger_suite.log_compression_error(str(file_path), "zip", "Zip bomb ratio limit exceeded")
                    return []

                for info in zf.infolist():
                    if info.is_dir():
                        continue
                    try:
                        data = zf.read(info.filename)
                        extracted.append((info.filename, data))
                    except Exception as exc:
                        read_errors.append((info.filename, str(exc)))
                        has_read_error = True

                if not has_read_error and extracted:
                    return extracted
        except Exception as exc:
            read_errors.append(("*archive_open*", str(exc)))
            has_read_error = True

        # Fallback to CLI tools and py7zr
        cli_extracted = self._unpack_via_cli(file_path, archive_type="zip")
        if cli_extracted:
            return cli_extracted

        if py7zr is not None:
            try:
                py7zr_extracted = []
                with py7zr.SevenZipFile(file_path, mode='r') as archive:
                    all_files = archive.readall()
                    for fname, bio in all_files.items():
                        py7zr_extracted.append((fname, bio.read()))
                if py7zr_extracted:
                    return py7zr_extracted
            except Exception as exc:
                logger.warning("zip_py7zr_fallback_failed", file=str(file_path), error=str(exc))

        for member, err in read_errors:
            logger.warning("zip_read_error", file=str(file_path), member=member, error=err)
            self.logger_suite.log_compression_error(str(file_path), "zip", f"Member {member}: {err}")

        return extracted

    def unpack_tar(self, file_path: Path) -> List[Tuple[str, bytes]]:
        extracted = []
        compressed_size = file_path.stat().st_size
        try:
            with tarfile.open(file_path, 'r:*') as tf:
                total_uncompressed = sum(member.size for member in tf.getmembers() if member.isfile())
                if self._is_zip_bomb(compressed_size, total_uncompressed):
                    logger.warning("tar_zip_bomb_detected", file=str(file_path))
                    self.logger_suite.log_compression_error(str(file_path), "tar", "Zip bomb ratio limit exceeded")
                    return []
                for member in tf.getmembers():
                    if not member.isfile():
                        continue
                    try:
                        f = tf.extractfile(member)
                        if f:
                            data = f.read()
                            extracted.append((member.name, data))
                    except Exception as exc:
                        logger.warning("tar_read_error", file=str(file_path), member=member.name, error=str(exc))
                        self.logger_suite.log_compression_error(str(file_path), "tar", f"Member {member.name}: {exc}")
        except Exception as exc:
            self.logger_suite.log_compression_error(str(file_path), "tar", str(exc))
        return extracted

    def unpack_7z(self, file_path: Path) -> List[Tuple[str, bytes]]:
        extracted = []
        if py7zr is not None:
            try:
                with py7zr.SevenZipFile(file_path, mode='r') as archive:
                    all_files = archive.readall()
                    for fname, bio in all_files.items():
                        data = bio.read()
                        extracted.append((fname, data))
                if extracted:
                    return extracted
            except Exception as exc:
                logger.warning("7z_py7zr_error_trying_cli", file=str(file_path), error=str(exc))

        return self._unpack_via_cli(file_path, archive_type="7z")

    def unpack_rar(self, file_path: Path) -> List[Tuple[str, bytes]]:
        extracted = []
        rar_errors = []
        if rarfile is not None:
            try:
                with rarfile.RarFile(file_path) as rf:
                    for info in rf.infolist():
                        if info.isdir():
                            continue
                        try:
                            data = rf.read(info.filename)
                            extracted.append((info.filename, data))
                        except Exception as exc:
                            rar_errors.append((info.filename, str(exc)))
                if extracted and not rar_errors:
                    return extracted
            except Exception as exc:
                rar_errors.append(("*archive_open*", str(exc)))

        cli_extracted = self._unpack_via_cli(file_path, archive_type="rar")
        if cli_extracted:
            return cli_extracted

        for member, err in rar_errors:
            logger.warning("rar_read_error", file=str(file_path), member=member, error=err)
            self.logger_suite.log_compression_error(str(file_path), "rar", f"Member {member}: {err}")

        return extracted

    # --- Layer 2: Disk Images ---

    def unpack_dsk(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Extract CP/M files from standard and extended CPC DSK images.

        A DSK track contains a header followed by individual sectors. The old
        implementation treated each full track as every directory entry's
        payload, which created garbage filenames and duplicated unrelated
        sectors. This parser rebuilds the logical sector stream, reads CP/M
        directory extents, and follows their 1 KiB allocation blocks.
        """
        if len(data) < 0x200 or not (data.startswith(b"EXTENDED CPC DSK") or data.startswith(b"MV - CPCEMU")):
            return []

        try:
            tracks, sides = data[0x30], data[0x31]
            if not tracks or not sides:
                return []

            extended = data.startswith(b"EXTENDED CPC DSK")
            fixed_track_size = int.from_bytes(data[0x32:0x34], "little")
            track_sizes = data[0x34:0x34 + tracks * sides] if extended else b""
            pos = 0x100
            logical_sectors = bytearray()

            for track_index in range(tracks * sides):
                track_size = (track_sizes[track_index] * 256) if extended else fixed_track_size
                if not track_size:
                    continue
                if pos + min(track_size, 0x100) > len(data):
                    break

                track_header = data[pos:pos + 0x100]
                if not track_header.startswith(b"Track-Info"):
                    pos += track_size
                    continue

                sector_count = track_header[0x15]
                sector_pos = pos + 0x100
                track_end = min(pos + track_size, len(data))
                for sector_index in range(sector_count):
                    descriptor_offset = 0x18 + sector_index * 8
                    descriptor = track_header[descriptor_offset:descriptor_offset + 8]
                    if len(descriptor) != 8:
                        break
                    sector_size = descriptor[6] | (descriptor[7] << 8)
                    if not sector_size:
                        size_code = descriptor[3]
                        if size_code > 7:
                            break
                        sector_size = 128 << size_code
                    if sector_pos + sector_size > track_end:
                        break
                    logical_sectors.extend(data[sector_pos:sector_pos + sector_size])
                    sector_pos += sector_size
                pos += track_size

            if len(logical_sectors) < 1024:
                return []

            def decode_cpm_name(raw: bytes) -> str:
                cleaned = bytes(byte & 0x7F for byte in raw).decode("ascii", errors="ignore").strip(" \x00")
                if not cleaned or not re.fullmatch(r"[A-Za-z0-9!#$%&'()@^_`{}~-]+", cleaned):
                    return ""
                return cleaned

            file_extents: Dict[str, List[Tuple[int, int, bytes]]] = {}
            # Standard CPC data formats reserve a small number of initial
            # directory blocks. Scanning the first 2 KiB covers the common
            # 64-entry directory while validating every entry before use.
            for entry_offset in range(0, min(len(logical_sectors), 2048) - 31, 32):
                entry = logical_sectors[entry_offset:entry_offset + 32]
                user_number = entry[0]
                if user_number > 15 or user_number == 0xE5:
                    continue
                base_name = decode_cpm_name(entry[1:9])
                extension = decode_cpm_name(entry[9:12])
                record_count = entry[15]
                if not base_name or record_count == 0:
                    continue
                filename = f"{base_name}.{extension}" if extension else base_name
                extent_number = entry[12] + 32 * (entry[14] & 0x3F)
                blocks = bytes(block for block in entry[16:32] if block)
                if not blocks:
                    continue
                file_extents.setdefault(filename, []).append((extent_number, record_count, blocks))

            extracted: List[Tuple[str, bytes]] = []
            for filename, extents in file_extents.items():
                file_data = bytearray()
                for _, record_count, blocks in sorted(extents):
                    extent_data = bytearray()
                    for block_number in blocks:
                        start = block_number * 1024
                        if start >= len(logical_sectors):
                            continue
                        extent_data.extend(logical_sectors[start:start + 1024])
                    file_data.extend(extent_data[:record_count * 128])
                if file_data:
                    extracted.append((filename, bytes(file_data)))
            return extracted
        except Exception as exc:
            logger.warning("dsk_parse_error", error=str(exc))
            return []

    def _unpack_cbm_dos(self, data: bytes, sides: int = 1) -> List[Tuple[str, bytes]]:
        """Extract bounded CBM DOS file chains from D64 and D71 sector images."""
        extracted: List[Tuple[str, bytes]] = []
        base_size = 174848 * sides
        error_size = base_size + (683 * sides)
        if len(data) not in {base_size, error_size}:
            return extracted

        def track_sector_offset(track: int, sector: int) -> int:
            if not (1 <= track <= 35 * sides):
                raise ValueError("track outside image geometry")
            if track > 35:
                return 174848 + track_sector_offset(track - 35, sector)
            sector_count = 21 if track <= 17 else 19 if track <= 24 else 18 if track <= 30 else 17
            if not (0 <= sector < sector_count):
                raise ValueError("sector outside track geometry")
            sectors_before = sum(
                21 if current <= 17 else 19 if current <= 24 else 18 if current <= 30 else 17
                for current in range(1, track)
            )
            return (sectors_before + sector) * 256

        try:
            directory_track, directory_sector = 18, 1
            directory_seen = set()
            while directory_track and (directory_track, directory_sector) not in directory_seen:
                directory_seen.add((directory_track, directory_sector))
                offset = track_sector_offset(directory_track, directory_sector)
                directory = data[offset:offset + 256]
                if len(directory) != 256:
                    break
                directory_track, directory_sector = directory[0], directory[1]
                for entry_index in range(8):
                    entry = directory[2 + entry_index * 32:34 + entry_index * 32]
                    if len(entry) != 32 or not (entry[0] & 0x07):
                        continue
                    filename = entry[3:19].replace(b"\xa0", b" ").decode("ascii", errors="ignore").strip()
                    file_track, file_sector = entry[1], entry[2]
                    chain_seen = set()
                    payload = bytearray()
                    valid_chain = bool(filename)
                    while file_track and (file_track, file_sector) not in chain_seen:
                        chain_seen.add((file_track, file_sector))
                        sector_offset = track_sector_offset(file_track, file_sector)
                        sector = data[sector_offset:sector_offset + 256]
                        if len(sector) != 256:
                            valid_chain = False
                            break
                        file_track, file_sector = sector[0], sector[1]
                        if file_track == 0:
                            # Terminal byte one gives the used-byte count plus
                            # one; only bytes two through count are payload.
                            if not (1 <= file_sector <= 255):
                                valid_chain = False
                                break
                            payload.extend(sector[2:file_sector + 1])
                        else:
                            payload.extend(sector[2:])
                    if file_track != 0:
                        valid_chain = False  # loop or invalid chain
                    if valid_chain and payload:
                        extracted.append((filename, bytes(payload)))
        except (ValueError, IndexError) as exc:
            logger.warning("cbm_dos_parse_error", error=str(exc), sides=sides)
        return extracted

    def unpack_d64(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Parse a one-sided 35-track C64 D64 sector image."""
        return self._unpack_cbm_dos(data, sides=1)

    def unpack_d71(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Parse a double-sided 70-track C128/D71 CBM DOS sector image."""
        return self._unpack_cbm_dos(data, sides=2)

    def unpack_t64(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Extract Commodore 64/Plus4 T64 tape members."""
        return extract_t64(data)

    def unpack_cbm_tap(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Recover bounded parity-validated C64 KERNAL packets from raw TAP."""
        return extract_c64_tap_kernal_packets(data)

    def unpack_p00(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Unwrap a Commodore P00 program image into its original PRG bytes."""
        return extract_p00(data)

    def unpack_tzx(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Extract ZX Spectrum TZX or CPC CDT standard data blocks."""
        return extract_tzx(data)

    def unpack_fat(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Extract MSX, Atari ST, and DOS FAT12/FAT16 filesystem members."""
        return extract_fat(data)

    def unpack_fat12(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Compatibility entry point for callers requesting generic floppy media."""
        return self.unpack_fat(data)

    def unpack_msa(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Decode an Atari ST MSA image and extract its FAT12 members."""
        decoded = decompress_msa(data)
        return extract_fat(decoded) if decoded is not None else []

    def unpack_adf(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Extract Amiga OFS/FFS ADF members."""
        return extract_adf(data)

    def unpack_adz(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Expand a gzip ADZ image then extract Amiga OFS/FFS members."""
        decoded = decompress_adz(data)
        return extract_adf(decoded) if decoded is not None else []

    def unpack_dms(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Decode a validated DMS archive and extract its Amiga filesystem members."""
        decoded = decompress_dms(data)
        return extract_adf(decoded) if decoded is not None else []

    def unpack_cas(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Split MSX CAS tape records into recursively fingerprintable members."""
        return extract_msx_cas(data)

    # --- Layer 3: Tape Dumps ---

    def unpack_tap(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Parse ZX Spectrum .tap tape dump, associating headers with data blocks."""
        extracted = []
        pos = 0
        block_idx = 0
        pending_header: Optional[Tuple[str, str]] = None

        while pos + 2 < len(data):
            block_len = data[pos] | (data[pos+1] << 8)
            pos += 2
            if pos + block_len > len(data):
                break
            block_data = data[pos:pos+block_len]
            pos += block_len

            if len(block_data) == 19 and block_data[0] == 0x00:
                header_type = block_data[1]
                filename = block_data[2:12].decode('ascii', errors='ignore').strip()
                ext_map = {0: "bas", 1: "num", 2: "chr", 3: "bin"}
                ext = ext_map.get(header_type, "dat")
                pending_header = (filename or f"file_{block_idx}", ext)
            elif pending_header and len(block_data) > 0 and block_data[0] == 0xFF:
                fname, ext = pending_header
                extracted.append((f"{fname}.{ext}", block_data[1:-1]))
                pending_header = None
            else:
                extracted.append((f"block_{block_idx}.bin", block_data))
            block_idx += 1

        return extracted

    # --- Container Router ---

    @staticmethod
    def identify_container_format(filename: str, data: bytes) -> Optional[str]:
        """Classify a persisted media/container member for provenance metadata."""
        ext = Path(filename).suffix.casefold()
        if data.startswith((b"PK\x03\x04", b"PK\x05\x06", b"PK\x07\x08")) or ext == ".zip":
            return "zip"
        if data.startswith(b"ZXTape!\x1a") or ext in {".tzx", ".cdt"}:
            return "tzx" if ext != ".cdt" else "cdt"
        if data.startswith((b"EXTENDED CPC DSK", b"MV - CPCEMU")):
            return "cpc-dsk"
        if data.startswith((b"C64-TAPE-RAW", b"C16-TAPE-RAW")):
            return "cbm-tap"
        if data.startswith((b"GCR-1541", b"GCR-1571")):
            return "c64-g64"
        if data.startswith(b"C64File\x00"):
            return "commodore-p00"
        if len(data) in (174848, 175531) or ext == ".d64":
            return "c64-d64"
        if len(data) in (349696, 351062) or ext == ".d71":
            return "c64-d71"
        if ext == ".t64":
            return "c64-t64"
        if data.startswith(b"\x0e\x0f") or ext == ".msa":
            return "atari-msa"
        if data.startswith(b"DOS") and len(data) % 512 == 0:
            return "amiga-adf"
        if data.startswith(b"\x1f\x8b") and ext == ".adz":
            return "amiga-adz"
        if data.startswith(b"DMS!") or ext == ".dms":
            return "amiga-dms"
        if ext == ".tap":
            return "zx-tap"
        if ext == ".cas":
            return "msx-cas"
        if ext == ".st":
            return "atari-st"
        if ext == ".dsk":
            return "disk-image"
        if ext in {".prg", ".p00"}:
            return "commodore-prg"
        if ext in {".com", ".exe"}:
            return "dos-executable"
        return None

    def extract_container(self, file_path: Path, filename: str, data: bytes) -> List[Tuple[str, bytes]]:
        """Routes container data to proper unpacker based on extension and magic byte sniffing."""
        ext = Path(filename).suffix.lower()

        is_zip = data.startswith(b"PK\x03\x04") or data.startswith(b"PK\x05\x06") or data.startswith(b"PK\x07\x08") or ext == '.zip'
        is_7z = data.startswith(b"7z\xbc\xaf\x27\x1c") or ext == '.7z'
        is_rar = data.startswith(b"Rar!\x1a\x07") or ext == '.rar'
        is_tar = (len(data) >= 512 and data[257:262] in (b"ustar", b"GNUtar")) or ext in ('.tar', '.gz', '.tgz', '.bz2', '.xz') or filename.endswith(('.tar.gz', '.tar.bz2', '.tar.xz'))
        is_arj = data.startswith(b"\x60\xea") or ext == '.arj'
        is_lha = (len(data) >= 7 and data[2:7] in (b"-lh0-", b"-lh1-", b"-lh2-", b"-lh3-", b"-lh4-", b"-lh5-", b"-lh6-", b"-lh7-", b"-lzs-", b"-lz5-")) or ext in ('.lha', '.lzh')
        is_zoo = data.startswith(b"ZOO ") or ext == '.zoo'
        is_arc = data.startswith(b"\x1a") or ext == '.arc'
        is_cab = data.startswith(b"MSCF") or ext == '.cab'
        is_dsk = len(data) >= 0x100 and (data.startswith(b"EXTENDED CPC DSK") or data.startswith(b"MV - CPCEMU"))
        is_d64 = len(data) in (174848, 175531) or ext == '.d64'
        is_d71 = len(data) in (349696, 351062) or ext == '.d71'
        is_t64 = ext == '.t64' or (len(data) >= 40 and b"c64 tape image" in data[:40].lower())
        is_p00 = data.startswith(b"C64File\x00") or ext == ".p00"
        is_cbm_tap = data.startswith((b"C64-TAPE-RAW", b"C16-TAPE-RAW"))
        is_g64 = data.startswith((b"GCR-1541", b"GCR-1571")) or ext in {".g64", ".g71"}
        is_tap = ext == '.tap'
        is_tzx = ext in {'.tzx', '.cdt'} or data.startswith(b"ZXTape!\x1a")
        is_msa = ext == '.msa' or data.startswith(b"\x0e\x0f")
        is_adf = ext == '.adf' or (len(data) % 512 == 0 and data.startswith(b"DOS"))
        is_adz = ext == '.adz'
        is_dms = data.startswith(b"DMS!") or ext == '.dms'
        is_cas = ext == '.cas'
        is_fat12 = ext in {'.st', '.img', '.dsk'} or (len(data) >= 512 and data[510:512] == b"\x55\xaa")

        if is_zip:
            res = self.unpack_zip(file_path)
            if res:
                return res
        if is_7z:
            res = self.unpack_7z(file_path)
            if res:
                return res
        if is_rar:
            res = self.unpack_rar(file_path)
            if res:
                return res
        if is_tar:
            res = self.unpack_tar(file_path)
            if res:
                return res
        if is_arj:
            res = self._unpack_via_cli(file_path, archive_type="arj")
            if res:
                return res
        if is_lha:
            res = self._unpack_via_cli(file_path, archive_type="lha")
            if res:
                return res
        if is_zoo:
            res = self._unpack_via_cli(file_path, archive_type="zoo")
            if res:
                return res
        if is_arc:
            res = self._unpack_via_cli(file_path, archive_type="arc")
            if res:
                return res
        if is_cab:
            res = self._unpack_via_cli(file_path, archive_type="cab")
            if res:
                return res
        if is_dsk:
            res = self.unpack_dsk(data)
            if res:
                return res
        if is_d64:
            res = self.unpack_d64(data)
            if res:
                return res
        if is_d71:
            res = self.unpack_d71(data)
            if res:
                return res
        if is_t64:
            res = self.unpack_t64(data)
            if res:
                return res
        if is_p00:
            res = self.unpack_p00(data)
            if res:
                return res
        if is_cbm_tap:
            res = self.unpack_cbm_tap(data)
            if res:
                return res
        if is_g64:
            # GCR images remain structurally inspected and retained as
            # evidence. They are not Spectrum TAP blocks and must never be
            # passed through the Spectrum extractor.
            return []
        if is_tap:
            res = self.unpack_tap(data)
            if res:
                return res
        if is_tzx:
            res = self.unpack_tzx(data)
            if res:
                return res
        if is_msa:
            res = self.unpack_msa(data)
            if res:
                return res
        if is_adz:
            res = self.unpack_adz(data)
            if res:
                return res
        if is_dms:
            res = self.unpack_dms(data)
            if res:
                return res
        if is_adf:
            res = self.unpack_adf(data)
            if res:
                return res
        if is_cas:
            res = self.unpack_cas(data)
            if res:
                return res
        if is_fat12:
            res = self.unpack_fat12(data)
            if res:
                return res

        return []

    def unpack_artifact_recursive(
        self,
        source_id: int,
        filename: str,
        data: bytes,
        depth: int = 0
    ) -> List[int]:
        """Recursively unpacks files up to settings.max_unpack_depth (5 levels)."""
        artifact_ids = []

        hashes = compute_hashes(data)
        file_size = len(data)
        inspection = inspect_native_media(filename, data)

        clean_filename = sanitize_filename(filename)
        dest_filename = f"depth{depth}_{hashes['md5_full'][:8]}_{clean_filename}"
        dest_path = self.extract_dir / dest_filename

        if dest_path.exists() and dest_path.stat().st_size == file_size:
            try:
                existing_sha256 = hashlib.sha256(dest_path.read_bytes()).hexdigest()
                if existing_sha256 != hashes["sha256"]:
                    dest_path = safe_write_bytes(dest_path, data)
            except Exception:
                dest_path = safe_write_bytes(dest_path, data)
        else:
            dest_path = safe_write_bytes(dest_path, data)

        artifact = ArtifactRecord(
            id=None,
            source_id=source_id,
            original_filename=filename,
            extracted_path=str(dest_path),
            archive_depth=depth,
            file_size=file_size,
            md5_full=hashes["md5_full"],
            md5_5000=hashes["md5_5000"],
            sha256=hashes["sha256"],
            sha1=hashes["sha1"],
            crc32=hashes["crc32"],
            md5_tail5000=hashes["md5_tail5000"],
            sha224=hashes["sha224"],
            sha384=hashes["sha384"],
            sha512=hashes["sha512"],
            sha3_256=hashes["sha3_256"],
            sha3_512=hashes["sha3_512"],
            blake2b=hashes["blake2b"],
            blake2s=hashes["blake2s"],
            adler32=hashes["adler32"],
            xxh32=hashes["xxh32"],
            xxh64=hashes["xxh64"],
            xxh128=hashes["xxh128"],
            unpacked=False,
            is_daad_payload=False,
            container_format=self.identify_container_format(filename, data),
            container_member=filename if depth else None,
            media_parser=inspection.parser,
            media_status=inspection.status,
            media_validation=inspection.validation,
            media_evidence_json=json.dumps(inspection.evidence, sort_keys=True),
        )
        artifact_id = self.db.add_artifact(artifact)
        artifact_ids.append(artifact_id)

        if depth >= settings.max_unpack_depth:
            self.db.update_artifact_unpacked(artifact_id, unpacked=True)
            evidence = dict(inspection.evidence)
            evidence["depth_limit"] = settings.max_unpack_depth
            self.db.update_artifact_media(
                artifact_id,
                parser=inspection.parser,
                status="recognized_evidence" if inspection.status != "unrecognized" else inspection.status,
                validation="recursion_depth_limit",
                evidence_json=json.dumps(evidence, sort_keys=True),
            )
            return artifact_ids

        try:
            sub_items = self.extract_container(dest_path, filename, data)
            embedded_ddb = None
            if not sub_items and len(data) >= 34:
                embedded_ddb = DAADParser().find_embedded_ddb(data)
                if embedded_ddb is not None and embedded_ddb[0] > 0:
                    offset, payload = embedded_ddb
                    sub_items = [
                        (
                            f"{Path(filename).stem}__embedded_{offset:06x}.ddb",
                            payload,
                        )
                    ]
            for sub_fname, sub_data in sub_items:
                sub_ids = self.unpack_artifact_recursive(
                    source_id=source_id,
                    filename=sub_fname,
                    data=sub_data,
                    depth=depth + 1
                )
                artifact_ids.extend(sub_ids)
            self.db.update_artifact_unpacked(artifact_id, unpacked=True)
            evidence = dict(inspection.evidence)
            evidence["members_emitted"] = len(sub_items)
            if embedded_ddb is not None and embedded_ddb[0] > 0:
                evidence["embedded_ddb"] = {
                    "offset": embedded_ddb[0],
                    "size": len(embedded_ddb[1]),
                    "address_model": "container_relative_range",
                }
            container_format = artifact.container_format
            if sub_items:
                status = "extracted"
                validation = "validated_member_emission"
            elif inspection.status != "unrecognized":
                status = inspection.status
                validation = inspection.validation
            elif container_format:
                status = "recognized_evidence"
                validation = "container_recognized_without_member_emission"
            else:
                status = inspection.status
                validation = inspection.validation
            self.db.update_artifact_media(
                artifact_id,
                parser=inspection.parser if inspection.parser != "none" else (container_format or "none"),
                status=status,
                validation=validation,
                evidence_json=json.dumps(evidence, sort_keys=True),
            )
        except Exception as exc:
            logger.warning("artifact_unpack_exception", artifact_id=artifact_id, error=str(exc))
            self.logger_suite.log_compression_error(str(dest_path), "recursive", str(exc))
            evidence = dict(inspection.evidence)
            evidence["exception"] = str(exc)
            self.db.update_artifact_media(
                artifact_id,
                parser=inspection.parser,
                status="partial",
                validation="unpack_exception",
                evidence_json=json.dumps(evidence, sort_keys=True),
            )

        return artifact_ids

    def unpack_source_single(self, src: SourceRecord) -> int:
        if not src.local_path:
            return 0
        src_path = Path(src.local_path)
        if not src_path.exists():
            return 0

        logger.info("unpacking_source", source_id=src.id, path=src.local_path)
        try:
            data = src_path.read_bytes()
            ids = self.unpack_artifact_recursive(
                source_id=src.id,
                filename=src_path.name,
                data=data,
                depth=0
            )
            self.db.update_source_status(src.id, status=SourceStatus.UNPACKED.value)
            return len(ids)
        except Exception as exc:
            logger.error("source_unpack_failed", source_id=src.id, error=str(exc))
            self.logger_suite.log_compression_error(src.local_path, "source", str(exc))
            self.db.update_source_status(src.id, status=SourceStatus.PARTIALLY_UNPACKED.value)
            return 0

    def reunpack_retained_source(self, source_id: int) -> int:
        """Refresh one source from its retained depth-zero artifact.

        Parser improvements must be applicable to a self-contained corpus even
        when a historical source record has no usable download path. Existing
        rows are hash-deduplicated; newly recovered members are appended with
        their measured bytes and the original root is never discarded.
        """

        roots = [
            artifact
            for artifact in self.db.get_all_artifacts()
            if artifact.source_id == source_id and artifact.archive_depth == 0
        ]
        if len(roots) != 1:
            logger.warning("retained_reunpack_requires_one_root", source_id=source_id, root_count=len(roots))
            return 0
        root = roots[0]
        root_path = Path(root.extracted_path)
        if not root_path.is_file():
            logger.warning("retained_reunpack_root_missing", source_id=source_id, path=str(root_path))
            return 0
        logger.info("reunpacking_retained_source", source_id=source_id, path=str(root_path))
        try:
            root_data = root_path.read_bytes()
            stale_paths = self.db.clear_derived_artifacts(source_id)
            extract_root = self.extract_dir.resolve()
            for stale_path in stale_paths:
                path = Path(stale_path)
                try:
                    path.resolve().relative_to(extract_root)
                    path.unlink(missing_ok=True)
                except (OSError, ValueError):
                    logger.warning("retained_reunpack_stale_path_not_removed", source_id=source_id, path=stale_path)
            ids = self.unpack_artifact_recursive(source_id, root.original_filename, root_data)
            self.db.update_source_status(source_id, status=SourceStatus.UNPACKED.value)
            return len(ids)
        except Exception as exc:
            logger.error("retained_reunpack_failed", source_id=source_id, error=str(exc))
            self.logger_suite.log_compression_error(str(root_path), "retained_reunpack", str(exc))
            self.db.update_source_status(source_id, status=SourceStatus.PARTIALLY_UNPACKED.value)
            return 0

    def unpack_all_downloaded_sources(self, parallel: int = 4) -> int:
        """Process all downloaded sources from DB in parallel, skipping already unpacked sources."""
        sources = self.db.get_all_sources()
        pending_sources = [
            src for src in sources
            if src.status in ("downloaded", "partially_unpacked", "failed") and src.local_path
        ]

        if not pending_sources:
            logger.info("no_downloaded_sources_to_unpack")
            return 0

        total_artifacts = 0
        max_workers = min(parallel, max(1, len(pending_sources)))
        with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:
            futures = [executor.submit(self.unpack_source_single, src) for src in pending_sources]
            for future in concurrent.futures.as_completed(futures):
                try:
                    total_artifacts += future.result()
                except Exception as exc:
                    logger.error("parallel_unpack_exception", error=str(exc))

        logger.info("unpack_phase_completed", total_artifacts=total_artifacts)
        return total_artifacts
