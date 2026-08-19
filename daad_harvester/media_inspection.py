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
    return _result("tzx-cdt", "recognized_evidence", "valid_header", major=major, minor=minor)


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
    return _result(
        "amiga-dms", "recognized_evidence", "header_present_pending_full_track_decode",
        header_size=56, archive_size=len(data),
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
    if extension in {".sna", ".z80"}:
        return _inspect_snapshot(extension, data)
    if extension in {".rom", ".com", ".exe", ".prg"}:
        return _result("opaque-program-image", "recognized_evidence", "preserved_for_fingerprint", extension=extension, size=len(data))
    return _result("none", "unrecognized", "no_native_media_signature", extension=extension, size=len(data))
