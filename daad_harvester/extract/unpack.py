"""Recursive media unpacking module for archives, disk images, tape dumps, and memory snapshots."""

import re
import zlib
import zipfile
import hashlib
from pathlib import Path
from typing import Any, List, Tuple, Optional, Dict

try:
    import zipfile_deflate64
except ImportError:
    zipfile_deflate64 = None

try:
    import xxhash
except ImportError:
    xxhash = None

from loguru import logger

from daad_harvester.config import settings
from daad_harvester.media_inspection import inspect_native_media


SPECIAL_SYMBOLS = set(r'\/:*?"<>|')


def escape_string(s: str) -> str:
    """Escapes problematic filename characters."""
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
    """Writes bytes to dest_path safely. Falls back to hash name if OS error occurs."""
    dest_path.parent.mkdir(parents=True, exist_ok=True)
    try:
        dest_path.write_bytes(data)
        return dest_path
    except (OSError, PermissionError) as exc:
        logger.warning(f"Disk write error at {dest_path}: {exc}, using fallback path.")
        md5_hash = hashlib.md5(data).hexdigest()[:12]
        fallback_path = dest_path.parent / f"fallback_{md5_hash}.bin"
        fallback_path.write_bytes(data)
        return fallback_path


def compute_hashes(data: bytes) -> Dict[str, str]:
    """Computes cryptographic and fast checksum hashes for binary payloads."""
    md5_full = hashlib.md5(data).hexdigest()
    md5_5000 = hashlib.md5(data[:5000]).hexdigest()
    md5_tail5000 = hashlib.md5(data[-5000:] if len(data) >= 5000 else data).hexdigest()
    sha1 = hashlib.sha1(data).hexdigest()
    sha256 = hashlib.sha256(data).hexdigest()
    crc32 = f"{zlib.crc32(data) & 0xFFFFFFFF:08x}"
    adler32 = f"{zlib.adler32(data) & 0xFFFFFFFF:08x}"

    xxh32 = xxhash.xxh32(data).hexdigest() if xxhash else ""
    xxh64 = xxhash.xxh64(data).hexdigest() if xxhash else ""

    return {
        "md5_full": md5_full,
        "md5_5000": md5_5000,
        "md5_tail5000": md5_tail5000,
        "sha1": sha1,
        "sha256": sha256,
        "crc32": crc32,
        "adler32": adler32,
        "xxh32": xxh32,
        "xxh64": xxh64,
    }


class Unpacker:
    """Recursive unpacker handling multi-layer archive and disk image container extraction."""

    def __init__(self, db: Any, extract_dir: Optional[Path] = None):
        self.db = db
        self.extract_dir = extract_dir or (settings.output_dir / "extracted")
        self.extract_dir.mkdir(parents=True, exist_ok=True)

    def _is_zip_bomb(self, compressed_size: int, uncompressed_size: int) -> bool:
        """Zip bomb protection check."""
        if compressed_size == 0:
            return False
        return (uncompressed_size / compressed_size) > settings.zip_bomb_max_ratio

    def unpack_zip(self, file_path: Path) -> List[Tuple[str, bytes]]:
        """Extracts zip archive entries."""
        extracted = []
        compressed_size = file_path.stat().st_size
        zip_cls = zipfile_deflate64.ZipFile if zipfile_deflate64 is not None else zipfile.ZipFile

        try:
            with zip_cls(file_path, 'r') as zf:
                total_uncompressed = sum(info.file_size for info in zf.infolist())
                if self._is_zip_bomb(compressed_size, total_uncompressed):
                    logger.warning(f"Zip bomb detected for {file_path}")
                    return []

                for info in zf.infolist():
                    if info.is_dir():
                        continue
                    try:
                        data = zf.read(info.filename)
                        extracted.append((info.filename, data))
                    except Exception as exc:
                        logger.warning(f"Failed reading member {info.filename} in zip {file_path}: {exc}")
        except Exception as exc:
            logger.warning(f"Failed opening zip archive {file_path}: {exc}")

        return extracted

    def unpack_artifact_recursive(
        self,
        source_id: int,
        filename: str,
        data: bytes,
        depth: int = 0
    ) -> List[int]:
        """Recursively unpacks files up to max_unpack_depth."""
        artifact_ids = []

        hashes = compute_hashes(data)
        file_size = len(data)
        inspection = inspect_native_media(filename, data)

        clean_filename = sanitize_filename(filename)
        dest_filename = f"depth{depth}_{hashes['md5_full'][:8]}_{clean_filename}"
        dest_path = self.extract_dir / dest_filename

        dest_path = safe_write_bytes(dest_path, data)

        from daad_harvester.models import ArtifactRecord
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
            adler32=hashes["adler32"],
            xxh32=hashes["xxh32"],
            xxh64=hashes["xxh64"],
            unpacked=False,
            is_daad_payload=False,
            container_format=inspection.parser if inspection.parser != "none" else None,
            container_member=filename if depth else None,
            media_parser=inspection.parser,
            media_status=inspection.status,
            media_validation=inspection.validation,
            media_evidence_json=str(inspection.evidence),
        )
        artifact_id = self.db.add_artifact(artifact)
        artifact_ids.append(artifact_id)

        if depth >= settings.max_unpack_depth:
            self.db.update_artifact_unpacked(artifact_id, unpacked=True)
            return artifact_ids

        return artifact_ids
