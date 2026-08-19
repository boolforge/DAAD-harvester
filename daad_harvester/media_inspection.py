"""Structural inspection for native retro-computing preservation media.

The unpacker uses this module before it attempts member extraction.  Its job is
not to guess that a payload is a DAAD game: it validates the outer medium,
reports the evidence required to reproduce that decision, and records when a
medium is valid but intentionally non-file-oriented (for example a pulse tape
or low-level protected track dump).
"""

from __future__ import annotations

from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any, Dict

from daad_harvester.dms import crc16_arc
from daad_harvester.platform_media import parse_tzx_blocks


@dataclass(frozen=True)
class MediaInspection:
    """A bounded, serializable outer-media parsing result."""

    parser: str
    status: str
    validation: str
    evidence: Dict[str, Any]

    def as_dict(self) -> Dict[str, Any]:
        return asdict(self)


def _result(
    parser: str,
    status: str,
    validation: str,
    **evidence: Any,
) -> MediaInspection:
    return MediaInspection(parser, status, validation, evidence)


def _inspect_cbm_tap(data: bytes) -> MediaInspection:
    if len(data) < 20:
        return _result("cbm-tap-v1-v2", "rejected", "truncated_header", size=len(data))
    signature = data[:12]
    if signature not in {b"C64-TAPE-RAW", b"C16-TAPE-RAW"}:
        return _result("cbm-tap-v1-v2", "rejected", "signature_mismatch")
    version = data[12]
    platform_code = data[13]
    declared_size = int.from_bytes(data[16:20], "little")
    actual_size = len(data) - 20
    if version not in {0, 1, 2}:
        return _result(
            "cbm-tap-v1-v2", "recognized_evidence", "unknown_version",
            version=version, platform_code=platform_code,
            declared_size=declared_size, actual_size=actual_size,
        )
    if declared_size != actual_size:
        return _result(
            "cbm-tap-v1-v2", "rejected", "declared_length_mismatch",
            version=version, platform_code=platform_code,
            declared_size=declared_size, actual_size=actual_size,
        )
    expected_platform = 2 if signature.startswith(b"C16") else 0
    platform_valid = platform_code == expected_platform or version == 0
    return _result(
        "cbm-tap-v1-v2",
        "recognized_evidence",
        "valid_pulse_stream" if platform_valid else "platform_header_mismatch",
        version=version,
        platform_code=platform_code,
        video_standard=data[14],
        declared_size=declared_size,
        pulse_bytes=actual_size,
    )


def _inspect_g64(data: bytes) -> MediaInspection:
    if len(data) < 12:
        return _result("cbm-g64", "rejected", "truncated_header", size=len(data))
    signature = data[:8]
    if signature not in {b"GCR-1541", b"GCR-1571"}:
        return _result("cbm-g64", "rejected", "signature_mismatch")
    version = data[8]
    track_count = data[9]
    track_size = int.from_bytes(data[10:12], "little")
    table_end = 12 + (track_count * 8)
    if version != 0 or not (1 <= track_count <= 168) or track_size < 256 or table_end > len(data):
        return _result(
            "cbm-g64", "rejected", "invalid_header_or_tables",
            version=version, track_count=track_count, track_size=track_size,
        )
    valid_tracks = 0
    invalid_tracks = 0
    for index in range(track_count):
        offset = int.from_bytes(data[12 + index * 4:16 + index * 4], "little")
        if not offset:
            continue
        if offset + 2 > len(data):
            invalid_tracks += 1
            continue
        stored_size = int.from_bytes(data[offset:offset + 2], "little")
        if not (1 <= stored_size <= track_size and offset + 2 + stored_size <= len(data)):
            invalid_tracks += 1
            continue
        valid_tracks += 1
    status = "recognized_evidence" if not invalid_tracks else "partial"
    validation = "valid_gcr_track_index" if not invalid_tracks else "invalid_gcr_track_offsets"
    return _result(
        "cbm-g64", status, validation, version=version, track_count=track_count,
        track_size=track_size, indexed_tracks=valid_tracks, invalid_tracks=invalid_tracks,
        disk_family="1571" if signature == b"GCR-1571" else "1541",
    )


def _inspect_p00(data: bytes) -> MediaInspection:
    if len(data) < 26:
        return _result("cbm-p00", "rejected", "truncated_header", size=len(data))
    if data[:8] != b"C64File\x00":
        return _result("cbm-p00", "rejected", "signature_mismatch")
    name = data[8:25].replace(b"\xa0", b" ").rstrip(b" \x00").decode("latin-1", "replace")
    return _result("cbm-p00", "recognized_evidence", "valid_wrapper", name=name, payload_size=len(data) - 26)


def _inspect_tzx(data: bytes) -> MediaInspection:
    if len(data) < 10 or not data.startswith(b"ZXTape!\x1a"):
        return _result("tzx-cdt", "rejected", "signature_mismatch")
    major, minor = data[8], data[9]
    if major != 1:
        return _result("tzx-cdt", "recognized_evidence", "unknown_major_version", major=major, minor=minor)
    blocks = parse_tzx_blocks(data)
    if blocks is None:
        return _result("tzx-cdt", "rejected", "invalid_or_truncated_block_stream", major=major, minor=minor)
    data_blocks = [block for block in blocks if block.data is not None]
    control_blocks = [block for block in blocks if block.relative_targets]
    return _result(
        "tzx-cdt",
        "recognized_evidence",
        "validated_tzx_v1_block_stream",
        major=major,
        minor=minor,
        block_count=len(blocks),
        data_block_count=len(data_blocks),
        control_block_count=len(control_blocks),
        block_types=sorted({block.kind for block in blocks}),
    )


def _inspect_msa(data: bytes) -> MediaInspection:
    if len(data) < 10 or data[:2] != b"\x0e\x0f":
        return _result("atari-msa", "rejected", "signature_mismatch")
    sectors = int.from_bytes(data[2:4], "big")
    sides = int.from_bytes(data[4:6], "big")
    first_track = int.from_bytes(data[6:8], "big")
    last_track = int.from_bytes(data[8:10], "big")
    valid = 1 <= sectors <= 64 and sides <= 1 and first_track <= last_track <= 255
    return _result(
        "atari-msa", "recognized_evidence" if valid else "rejected",
        "valid_geometry" if valid else "invalid_geometry", sectors=sectors,
        sides=sides, first_track=first_track, last_track=last_track,
    )


def _inspect_adf(data: bytes) -> MediaInspection:
    if len(data) < 2048 or len(data) % 512 or not data.startswith(b"DOS"):
        return _result("amiga-adf", "rejected", "invalid_boot_block")
    return _result(
        "amiga-adf", "recognized_evidence", "valid_boot_block",
        dos_type=data[:4].decode("latin-1", "replace"), blocks=len(data) // 512,
        root_block=int.from_bytes(data[8:12], "big"),
    )


def _inspect_dms(data: bytes) -> MediaInspection:
    if len(data) < 56 or not data.startswith(b"DMS!"):
        return _result("amiga-dms", "rejected", "signature_or_header_mismatch", size=len(data))
    stored_crc = int.from_bytes(data[54:56], "big")
    calculated_crc = crc16_arc(data[4:54])
    if stored_crc != calculated_crc:
        return _result(
            "amiga-dms", "rejected", "archive_header_crc_mismatch",
            stored_crc=stored_crc, calculated_crc=calculated_crc, archive_size=len(data),
        )
    general_info = int.from_bytes(data[10:12], "big")
    return _result(
        "amiga-dms", "recognized_evidence", "validated_archive_header",
        header_size=56,
        archive_size=len(data),
        creator_version=int.from_bytes(data[46:48], "big"),
        first_track=int.from_bytes(data[16:18], "big"),
        last_track=int.from_bytes(data[18:20], "big"),
        disk_type=int.from_bytes(data[50:52], "big"),
        default_mode=int.from_bytes(data[52:54], "big"),
        encrypted=bool(general_info & 0x0002),
        banner=bool(general_info & 0x0008),
        file_id=bool(general_info & 0x0100),
    )


def _inspect_fat(data: bytes) -> MediaInspection:
    if len(data) < 512 or data[510:512] != b"\x55\xaa":
        return _result("fat12-fat16", "rejected", "invalid_boot_signature")
    bytes_per_sector = int.from_bytes(data[11:13], "little")
    sectors_per_cluster = data[13]
    reserved = int.from_bytes(data[14:16], "little")
    fat_count = data[16]
    root_entries = int.from_bytes(data[17:19], "little")
    total_sectors = int.from_bytes(data[19:21], "little") or int.from_bytes(data[32:36], "little")
    sectors_per_fat = int.from_bytes(data[22:24], "little")
    if (
        bytes_per_sector not in {128, 256, 512, 1024}
        or not sectors_per_cluster
        or not reserved
        or not fat_count
        or not root_entries
        or not sectors_per_fat
        or not total_sectors
    ):
        return _result("fat12-fat16", "rejected", "invalid_bpb")
    root_sectors = (root_entries * 32 + bytes_per_sector - 1) // bytes_per_sector
    data_start = reserved + fat_count * sectors_per_fat + root_sectors
    data_sectors = total_sectors - data_start
    image_size = total_sectors * bytes_per_sector
    if data_sectors <= 0 or image_size > len(data):
        return _result("fat12-fat16", "rejected", "declared_geometry_out_of_range")
    cluster_count = data_sectors // sectors_per_cluster
    if cluster_count >= 65525:
        return _result("fat12-fat16", "recognized_evidence", "fat32_or_later_not_routed", cluster_count=cluster_count)
    fat_variant = "fat12" if cluster_count < 4085 else "fat16"
    return _result(
        "fat12-fat16", "recognized_evidence", "validated_fat_geometry",
        fat_variant=fat_variant,
        bytes_per_sector=bytes_per_sector,
        sectors_per_cluster=sectors_per_cluster,
        total_sectors=total_sectors,
        cluster_count=cluster_count,
    )


def _inspect_mz(data: bytes) -> MediaInspection:
    if len(data) < 28 or data[:2] not in {b"MZ", b"ZM"}:
        return _result("dos-mz", "rejected", "truncated_or_missing_mz_signature")
    bytes_last_page = int.from_bytes(data[2:4], "little")
    pages = int.from_bytes(data[4:6], "little")
    relocation_count = int.from_bytes(data[6:8], "little")
    header_paragraphs = int.from_bytes(data[8:10], "little")
    relocation_offset = int.from_bytes(data[24:26], "little")
    if not pages or bytes_last_page > 512:
        return _result("dos-mz", "rejected", "invalid_page_fields")
    declared_size = pages * 512 - (512 - bytes_last_page if bytes_last_page else 0)
    header_size = header_paragraphs * 16
    relocation_end = relocation_offset + relocation_count * 4
    if declared_size < header_size or declared_size > len(data) or relocation_end > header_size:
        return _result(
            "dos-mz", "rejected", "invalid_header_bounds",
            declared_size=declared_size, header_size=header_size, relocation_end=relocation_end,
        )
    return _result(
        "dos-mz", "recognized_evidence", "validated_mz_header",
        declared_size=declared_size,
        header_size=header_size,
        relocation_count=relocation_count,
        relocation_offset=relocation_offset,
    )


def _inspect_snapshot(extension: str, data: bytes) -> MediaInspection:
    # Snapshot formats are machine-state evidence, not raw executable members.
    known_size = len(data) in {49179, 131103, 147487}
    return _result(
        f"snapshot-{extension[1:]}", "recognized_evidence",
        "snapshot_requires_memory_map_reconstruction" if known_size else "snapshot_extension_only",
        size=len(data), extension=extension,
    )


def inspect_native_media(filename: str, data: bytes) -> MediaInspection:
    """Inspect a single artifact without executing, mounting, or guessing members."""

    extension = Path(filename).suffix.casefold()
    if data.startswith((b"C64-TAPE-RAW", b"C16-TAPE-RAW")):
        return _inspect_cbm_tap(data)
    if data.startswith((b"GCR-1541", b"GCR-1571")):
        return _inspect_g64(data)
    if data.startswith(b"C64File\x00"):
        return _inspect_p00(data)
    if data.startswith(b"ZXTape!\x1a"):
        return _inspect_tzx(data)
    if data.startswith(b"\x0e\x0f"):
        return _inspect_msa(data)
    if data.startswith(b"DOS") and len(data) % 512 == 0:
        return _inspect_adf(data)
    if data.startswith(b"DMS!") or extension == ".dms":
        return _inspect_dms(data)
    if len(data) >= 512 and data[510:512] == b"\x55\xaa":
        return _inspect_fat(data)
    if data.startswith((b"MZ", b"ZM")) or extension == ".exe":
        return _inspect_mz(data)
    if extension in {".sna", ".z80"}:
        return _inspect_snapshot(extension, data)
    if extension in {".rom", ".com", ".exe", ".prg"}:
        return _result("opaque-program-image", "recognized_evidence", "preserved_for_fingerprint", extension=extension, size=len(data))
    return _result("none", "unrecognized", "no_native_media_signature", extension=extension, size=len(data))
