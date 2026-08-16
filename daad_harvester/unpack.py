"""Recursive unpacker module supporting archives, disk images, tape dumps, and memory snapshots."""

import os
import io
import zipfile
import tarfile
import hashlib
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
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, SourceRecord
from daad_harvester.exceptions import UnpackError

logger = structlog.get_logger(__name__)


def compute_hashes(data: bytes) -> Tuple[str, str, str]:
    """Computes full MD5, MD5 of first 5000 bytes, and SHA256 of data."""
    md5_full = hashlib.md5(data).hexdigest()
    md5_5000 = hashlib.md5(data[:5000]).hexdigest()
    sha256 = hashlib.sha256(data).hexdigest()
    return md5_full, md5_5000, sha256


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

    # --- Layer 1: Standard Archives ---

    def unpack_zip(self, file_path: Path) -> List[Tuple[str, bytes]]:
        extracted = []
        compressed_size = file_path.stat().st_size
        with zipfile.ZipFile(file_path, 'r') as zf:
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
                    logger.warning("zip_read_error", file=str(file_path), member=info.filename, error=str(exc))
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
        if py7zr is None:
            logger.warning("py7zr_not_available", file=str(file_path))
            return extracted
        try:
            with py7zr.SevenZipFile(file_path, mode='r') as archive:
                all_files = archive.readall()
                for fname, bio in all_files.items():
                    data = bio.read()
                    extracted.append((fname, data))
        except Exception as exc:
            logger.warning("7z_read_error", file=str(file_path), error=str(exc))
        return extracted

    def unpack_rar(self, file_path: Path) -> List[Tuple[str, bytes]]:
        extracted = []
        if rarfile is None:
            logger.warning("rarfile_not_available", file=str(file_path))
            return extracted
        try:
            with rarfile.RarFile(file_path) as rf:
                for info in rf.infolist():
                    if info.isdir():
                        continue
                    try:
                        data = rf.read(info.filename)
                        extracted.append((info.filename, data))
                    except Exception as exc:
                        logger.warning("rar_read_error", file=str(file_path), member=info.filename, error=str(exc))
        except Exception as exc:
            logger.warning("rar_open_error", file=str(file_path), error=str(exc))
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
        """Routes container data to proper unpacker based on extension/magic bytes."""
        ext = Path(filename).suffix.lower()

        if ext == '.zip':
            return self.unpack_zip(file_path)
        elif ext in ('.tar', '.gz', '.tgz', '.bz2', '.xz') or filename.endswith(('.tar.gz', '.tar.bz2', '.tar.xz')):
            return self.unpack_tar(file_path)
        elif ext == '.7z':
            return self.unpack_7z(file_path)
        elif ext == '.rar':
            return self.unpack_rar(file_path)
        elif ext == '.dsk':
            return self.unpack_dsk(data)
        elif ext == '.d64':
            return self.unpack_d64(data)
        elif ext == '.tap':
            return self.unpack_tap(data)

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

        md5_full, md5_5000, sha256 = compute_hashes(data)
        file_size = len(data)

        clean_filename = Path(filename).name or f"artifact_{md5_full[:8]}.bin"
        dest_filename = f"depth{depth}_{md5_full[:8]}_{clean_filename}"
        dest_path = self.extract_dir / dest_filename
        dest_path.parent.mkdir(parents=True, exist_ok=True)
        dest_path.write_bytes(data)

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
            is_daad_payload=False
        )
        artifact_id = self.db.add_artifact(artifact)
        artifact_ids.append(artifact_id)

        if depth >= settings.max_unpack_depth:
            return artifact_ids

        sub_items = self.extract_container(dest_path, filename, data)
        for sub_fname, sub_data in sub_items:
            sub_ids = self.unpack_artifact_recursive(
                source_id=source_id,
                filename=sub_fname,
                data=sub_data,
                depth=depth + 1
            )
            artifact_ids.extend(sub_ids)

        return artifact_ids

    def unpack_all_downloaded_sources(self) -> int:
        """Process all downloaded sources from DB."""
        sources = self.db.get_all_sources()
        total_artifacts = 0
        for src in sources:
            if src.status == "downloaded" and src.local_path:
                src_path = Path(src.local_path)
                if src_path.exists():
                    logger.info("unpacking_source", source_id=src.id, path=src.local_path)
                    data = src_path.read_bytes()
                    ids = self.unpack_artifact_recursive(
                        source_id=src.id,
                        filename=src_path.name,
                        data=data,
                        depth=0
                    )
                    total_artifacts += len(ids)

        logger.info("unpack_phase_completed", total_artifacts=total_artifacts)
        return total_artifacts
