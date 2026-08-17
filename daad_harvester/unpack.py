"""Recursive unpacker module supporting archives, disk images, tape dumps, and memory snapshots."""

import os
import io
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
from typing import List, Tuple, Optional
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

import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, SourceRecord, SourceStatus
from daad_harvester.exceptions import UnpackError

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


def compute_hashes(data: bytes) -> Tuple[str, str, str, str, str]:
    """Computes full MD5, MD5 of first 5000 bytes, SHA256, SHA1, and CRC32 of data."""
    md5_full = hashlib.md5(data).hexdigest()
    md5_5000 = hashlib.md5(data[:5000]).hexdigest()
    sha256 = hashlib.sha256(data).hexdigest()
    sha1 = hashlib.sha1(data).hexdigest()
    crc32 = f"{zlib.crc32(data) & 0xFFFFFFFF:08x}" if 'zlib' in globals() else ""
    return md5_full, md5_5000, sha256, sha1, crc32


class Unpacker:
    """Recursive unpacker handling multi-layer archive and disk image container extraction."""

    def __init__(self, db: Database, extract_dir: Optional[Path] = None):
        self.db = db
        self.extract_dir = extract_dir or (settings.output_dir / "extracted")
        self.extract_dir.mkdir(parents=True, exist_ok=True)

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
                        logger.warning("cli_unpack_failed", file=str(file_path), exe=exe, stderr=res.stderr.decode('utf-8', errors='ignore'))
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

        missing_tools = [exe for exe in tools if not shutil.which(exe)]
        logger.warning(
            "cli_unpack_tool_not_found_or_failed",
            file=str(file_path),
            archive_type=archive_type,
            tested_tools=tested_tools,
            recommended_install=f"Consider installing system packages for {archive_type}: {', '.join(missing_tools)}" if missing_tools else "All candidate tools were tried but failed."
        )
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

        # If fallbacks failed as well, log member read errors that occurred earlier
        for member, err in read_errors:
            logger.warning("zip_read_error", file=str(file_path), member=member, error=err)

        return extracted

    def unpack_tar(self, file_path: Path) -> List[Tuple[str, bytes]]:
        extracted = []
        compressed_size = file_path.stat().st_size
        with tarfile.open(file_path, 'r:*') as tf:
            total_uncompressed = sum(member.size for member in tf.getmembers() if member.isfile())
            if self._is_zip_bomb(compressed_size, total_uncompressed):
                logger.warning("tar_zip_bomb_detected", file=str(file_path))
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
        else:
            logger.warning("py7zr_not_available_using_cli", file=str(file_path))

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

        return extracted

    # --- Layer 2: Disk Images ---

    def unpack_dsk(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Parse CPC / Spectrum +3 .dsk disk image and extract file payloads."""
        extracted = []
        if len(data) < 0x100 or not (data.startswith(b"EXTENDED CPC DSK") or data.startswith(b"MV - CPCEMU")):
            return []

        try:
            sides = data[0x31]
            tracks = data[0x30]

            # Parse track and sector structures to collect filesystem files
            files_map: dict[str, bytearray] = {}
            pos = 0x100
            for t in range(tracks):
                for s in range(sides):
                    if pos + 0x100 > len(data):
                        break
                    if data[pos:pos+10] == b"Track-Info":
                        sec_size = data[pos+0x14]
                        sec_count = data[pos+0x15]
                        pos += 0x100
                        sector_bytes = (128 << sec_size) if sec_size <= 7 else 512
                        track_data = data[pos:pos + (sec_count * sector_bytes)]
                        pos += (sec_count * sector_bytes)

                        # Process CP/M catalog on initial tracks
                        if t in (0, 1, 2):
                            for entry_offset in range(0, len(track_data) - 32, 32):
                                user_num = track_data[entry_offset]
                                if user_num in range(16):
                                    raw_fname = track_data[entry_offset+1:entry_offset+9].decode('ascii', errors='ignore').strip()
                                    raw_ext = track_data[entry_offset+9:entry_offset+12].decode('ascii', errors='ignore').strip()
                                    if raw_fname and not raw_fname.startswith('\xe5'):
                                        fname = f"{raw_fname}.{raw_ext}" if raw_ext else raw_fname
                                        if fname not in files_map:
                                            files_map[fname] = bytearray()
                                        files_map[fname].extend(track_data)

            for fname, fbytes in files_map.items():
                extracted.append((fname, bytes(fbytes)))
        except Exception as exc:
            logger.warning("dsk_parse_error", error=str(exc))

        return extracted

    def unpack_d64(self, data: bytes) -> List[Tuple[str, bytes]]:
        """Parse C64 .d64 disk image."""
        extracted = []
        if len(data) not in (174848, 196608, 175531, 197371):
            return extracted

        try:
            def track_sector_offset(t: int, s: int) -> int:
                sectors_before = 0
                for tr in range(1, t):
                    if tr <= 17:
                        sectors_before += 21
                    elif tr <= 24:
                        sectors_before += 19
                    elif tr <= 30:
                        sectors_before += 18
                    else:
                        sectors_before += 17
                return (sectors_before + s) * 256

            curr_t, curr_s = 18, 1
            visited = set()
            while curr_t != 0 and (curr_t, curr_s) not in visited:
                visited.add((curr_t, curr_s))
                offset = track_sector_offset(curr_t, curr_s)
                if offset + 256 > len(data):
                    break
                sec_data = data[offset:offset+256]
                curr_t, curr_s = sec_data[0], sec_data[1]

                for entry_idx in range(8):
                    entry = sec_data[entry_idx*32 : (entry_idx+1)*32]
                    file_type = entry[2]
                    if file_type != 0:
                        raw_name = entry[5:21].replace(b'\xa0', b' ').decode('ascii', errors='ignore').strip()
                        file_t, file_s = entry[3], entry[4]

                        file_bytes = bytearray()
                        ft, fs = file_t, file_s
                        fvisited = set()
                        while ft != 0 and (ft, fs) not in fvisited:
                            fvisited.add((ft, fs))
                            foff = track_sector_offset(ft, fs)
                            if foff + 256 > len(data):
                                break
                            fsec = data[foff:foff+256]
                            ft, fs = fsec[0], fsec[1]
                            if ft == 0:
                                file_bytes.extend(fsec[1:fs+1])
                            else:
                                file_bytes.extend(fsec[2:256])

                        if raw_name and len(file_bytes) > 0:
                            extracted.append((raw_name, bytes(file_bytes)))
        except Exception as exc:
            logger.warning("d64_parse_error", error=str(exc))

        return extracted

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
                extracted.append((f"{fname}.{ext}", block_data[1:-1])) # Strip flag byte & parity checksum
                pending_header = None
            else:
                extracted.append((f"block_{block_idx}.bin", block_data))
            block_idx += 1

        return extracted

    # --- Container Router ---

    def extract_container(self, file_path: Path, filename: str, data: bytes) -> List[Tuple[str, bytes]]:
        """Routes container data to proper unpacker based on extension and magic byte sniffing."""
        ext = Path(filename).suffix.lower()

        # Magic byte sniffing
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
        is_d64 = len(data) in (174848, 196608, 175531, 197371) or ext == '.d64'
        is_tap = ext == '.tap'

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
        if is_tap:
            res = self.unpack_tap(data)
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

        md5_full, md5_5000, sha256, sha1, crc32 = compute_hashes(data)
        file_size = len(data)

        clean_filename = sanitize_filename(filename)
        dest_filename = f"depth{depth}_{md5_full[:8]}_{clean_filename}"
        dest_path = self.extract_dir / dest_filename

        # If file exists on disk with matching file size, skip re-writing to disk
        if dest_path.exists() and dest_path.stat().st_size == file_size:
            try:
                existing_sha256 = hashlib.sha256(dest_path.read_bytes()).hexdigest()
                if existing_sha256 != sha256:
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
            md5_full=md5_full,
            md5_5000=md5_5000,
            sha256=sha256,
            sha1=sha1,
            crc32=crc32,
            unpacked=False,
            is_daad_payload=False
        )
        artifact_id = self.db.add_artifact(artifact)
        artifact_ids.append(artifact_id)

        if depth >= settings.max_unpack_depth:
            self.db.update_artifact_unpacked(artifact_id, unpacked=True)
            return artifact_ids

        try:
            sub_items = self.extract_container(dest_path, filename, data)
            for sub_fname, sub_data in sub_items:
                sub_ids = self.unpack_artifact_recursive(
                    source_id=source_id,
                    filename=sub_fname,
                    data=sub_data,
                    depth=depth + 1
                )
                artifact_ids.extend(sub_ids)
            self.db.update_artifact_unpacked(artifact_id, unpacked=True)
        except Exception as exc:
            logger.warning("artifact_unpack_exception", artifact_id=artifact_id, error=str(exc))

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
            self.db.update_source_status(src.id, status=SourceStatus.PARTIALLY_UNPACKED.value)
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
