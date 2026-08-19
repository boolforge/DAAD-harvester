"""Regression coverage for bounded native-media inspection evidence."""

import json
from pathlib import Path

from daad_harvester.db import Database
from daad_harvester.dms import crc16_arc
from daad_harvester.media_inspection import inspect_native_media
from daad_harvester.unpack import Unpacker


def test_c64_tap_validates_declared_pulse_stream_length() -> None:
    payload = b"\x20\x30\x40"
    tap = b"C64-TAPE-RAW" + bytes((1, 0, 0, 0)) + len(payload).to_bytes(4, "little") + payload

    result = inspect_native_media("adventure.tap", tap)

    assert result.parser == "cbm-tap-v1-v2"
    assert result.status == "recognized_evidence"
    assert result.validation == "valid_pulse_stream"
    assert result.evidence["pulse_bytes"] == len(payload)


def test_plus4_tap_uses_c16_signature_and_platform_identity() -> None:
    payload = b"\x01\x02"
    tap = b"C16-TAPE-RAW" + bytes((2, 2, 0, 0)) + len(payload).to_bytes(4, "little") + payload

    result = inspect_native_media("plus4.tap", tap)

    assert result.status == "recognized_evidence"
    assert result.evidence["platform_code"] == 2


def test_tap_declared_length_mismatch_is_rejected() -> None:
    tap = b"C64-TAPE-RAW" + bytes((1, 0, 0, 0)) + (99).to_bytes(4, "little") + b"\x00"

    result = inspect_native_media("broken.tap", tap)

    assert result.status == "rejected"
    assert result.validation == "declared_length_mismatch"


def test_g64_validates_track_offsets_without_extracting_invented_members() -> None:
    track_count = 1
    track_size = 256
    track_offset = 20
    image = bytearray(b"GCR-1541" + bytes((0, track_count)) + track_size.to_bytes(2, "little"))
    image.extend(track_offset.to_bytes(4, "little"))
    image.extend(b"\x00" * 4)  # one speed-zone entry
    image.extend((4).to_bytes(2, "little") + b"\xff" * 4)

    result = inspect_native_media("protected.g64", bytes(image))

    assert result.status == "recognized_evidence"
    assert result.validation == "valid_gcr_track_index"
    assert result.evidence["indexed_tracks"] == 1


def test_g64_invalid_track_offset_is_partial_evidence_not_a_crash() -> None:
    image = b"GCR-1541" + bytes((0, 1)) + (256).to_bytes(2, "little") + (999).to_bytes(4, "little") + b"\x00" * 4

    result = inspect_native_media("broken.g64", image)

    assert result.status == "partial"
    assert result.validation == "invalid_gcr_track_offsets"


def test_p00_and_dms_are_preserved_as_distinct_evidence_families() -> None:
    p00 = b"C64File\x00" + b"DAAD GAME".ljust(17, b"\x00") + b"\x00" + b"\x01\x08PAYLOAD"
    dms_header = bytearray(b"DMS!" + b"\x00" * 52)
    dms_header[54:56] = crc16_arc(dms_header[4:54]).to_bytes(2, "big")
    dms = bytes(dms_header)

    p00_result = inspect_native_media("game.p00", p00)
    dms_result = inspect_native_media("archive.dms", dms)

    assert p00_result.parser == "cbm-p00"
    assert p00_result.validation == "valid_wrapper"
    assert dms_result.parser == "amiga-dms"
    assert dms_result.status == "recognized_evidence"
    assert dms_result.validation == "validated_archive_header"


def test_dms_header_crc_failure_is_rejected_before_unpacking() -> None:
    result = inspect_native_media("broken.dms", b"DMS!" + b"\x00" * 52)
    assert result.status == "recognized_evidence"  # all-zero DMS CRC is valid
    corrupted = bytearray(b"DMS!" + b"\x00" * 52)
    corrupted[10] = 1
    result = inspect_native_media("broken.dms", bytes(corrupted))
    assert result.status == "rejected"
    assert result.validation == "archive_header_crc_mismatch"


def test_media_evidence_is_json_serializable() -> None:
    result = inspect_native_media("unknown.bin", b"not media")
    encoded = json.dumps(result.evidence, sort_keys=True)
    assert "no_native_media_signature" not in encoded


def test_p00_unwraps_exact_prg_and_cbm_tap_does_not_use_spectrum_router(tmp_path: Path) -> None:
    unpacker = Unpacker(Database(tmp_path / "state.db"), tmp_path / "extract")
    prg = b"\x01\x08DAAD"
    p00 = b"C64File\x00" + b"ADVENTURE".ljust(17, b"\x00") + b"\x00" + prg
    c64_tap = b"C64-TAPE-RAW" + bytes((1, 0, 0, 0)) + (1).to_bytes(4, "little") + b"\x55"

    assert unpacker.extract_container(tmp_path / "game.p00", "game.p00", p00) == [("ADVENTURE.prg", prg)]
    assert unpacker.extract_container(tmp_path / "game.tap", "game.tap", c64_tap) == []
    assert unpacker.identify_container_format("game.tap", c64_tap) == "cbm-tap"
