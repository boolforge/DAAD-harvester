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


def test_tzx_inspection_requires_validated_block_stream() -> None:
    valid = b"ZXTape!\x1a\x01\x14" + b"\x20\x00\x00"
    result = inspect_native_media("tape.cdt", valid)
    assert result.validation == "validated_tzx_v1_block_stream"
    assert result.evidence["block_count"] == 1

    invalid = b"ZXTape!\x1a\x01\x14\x99"
    result = inspect_native_media("tape.tzx", invalid)
    assert result.status == "rejected"
    assert result.validation == "invalid_or_truncated_block_stream"


def test_fat_and_dos_mz_headers_capture_structured_evidence() -> None:
    fat = bytearray(4 * 512)
    fat[11:13] = (512).to_bytes(2, "little")
    fat[13] = fat[14] = fat[16] = 1
    fat[17:19] = (16).to_bytes(2, "little")
    fat[19:21] = (4).to_bytes(2, "little")
    fat[22:24] = (1).to_bytes(2, "little")
    fat[510:512] = b"\x55\xaa"
    result = inspect_native_media("disk.img", bytes(fat))
    assert result.validation == "validated_fat_geometry"
    assert result.evidence["fat_variant"] == "fat12"

    mz = bytearray(64)
    mz[:2] = b"MZ"
    mz[2:4] = (64).to_bytes(2, "little")
    mz[4:6] = (1).to_bytes(2, "little")
    mz[8:10] = (2).to_bytes(2, "little")
    mz[24:26] = (28).to_bytes(2, "little")
    result = inspect_native_media("DAAD.EXE", bytes(mz))
    assert result.validation == "validated_mz_header"
    assert result.evidence["declared_size"] == 64


def test_stx_and_ipf_preservation_media_record_protection_evidence() -> None:
    stx = bytearray(b"RSY\x00" + (0x0300).to_bytes(2, "little") + (1).to_bytes(2, "little") + b"\x00\x00" + b"\x01\x01" + b"\x00" * 4)
    stx.extend((32).to_bytes(4, "little") + (0).to_bytes(4, "little") + (1).to_bytes(2, "little") + (1).to_bytes(2, "little") + (0).to_bytes(2, "little") + b"\x00\x00")
    stx.extend(b"\x00" * 14 + b"\x88\x00")
    result = inspect_native_media("protected.stx", bytes(stx))
    assert result.validation == "validated_pasti_track_records"
    assert result.evidence["protected_tracks"] == 1
    assert result.evidence["timing_or_status_tracks"] >= 1

    result = inspect_native_media("preservation.ipf", b"CAPS\x00\x00\x00\x0c\x00\x00\x00\x00")
    assert result.parser == "sps-ipf"
    assert result.validation == "validated_initial_caps_record"


def test_msx_rom_header_records_vectors_and_does_not_guess_mapper() -> None:
    rom = bytearray(0x10000)
    rom[:2] = b"AB"
    rom[2:4] = (0x4010).to_bytes(2, "little")
    result = inspect_native_media("adventure.rom", bytes(rom))
    assert result.parser == "msx-rom"
    assert result.validation == "validated_msx_ab_cartridge_header"
    assert result.evidence["entry_vectors"] == {"init": 0x4010}
    assert result.evidence["mapper_assessment"] == "banked_size_requires_mapper_identification"


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
