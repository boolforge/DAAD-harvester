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


def test_extensionless_retained_jabato_members_are_structural_c64_basic_sys_prgs() -> None:
    root = Path(__file__).resolve().parents[1]
    for filename in ("depth1_a05bba25_JABATO P.1", "depth1_20a1cd01_JABATO P.2"):
        result = inspect_native_media(filename, (root / "preservation_corpus" / "extracted" / filename).read_bytes())
        assert result.parser == "c64-basic-sys-prg"
        assert result.status == "recognized_evidence"
        assert result.validation == "validated_c64_basic_sys_launcher"
        assert result.evidence["load_address"] == 0x0801
        assert result.evidence["sys_target"] == 2061


def test_c64_basic_sys_prg_rejects_nondecimal_target() -> None:
    invalid = b"\x01\x08\x0B\x08\xEF\x00\x9E20A3\x00\x00\x00\x78"
    result = inspect_native_media("unknown", invalid)
    assert result.parser == "c64-basic-sys-prg"
    assert result.status == "rejected"
    assert result.validation == "non_decimal_sys_target"


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


def test_msx_dos_fat12_without_ibm_boot_trailer_is_strictly_recognized() -> None:
    image = bytearray(1440 * 512)
    image[:3] = b"\xeb\xfe\x90"
    image[11:13] = (512).to_bytes(2, "little")
    image[13] = 2
    image[14:16] = (1).to_bytes(2, "little")
    image[16] = 2
    image[17:19] = (112).to_bytes(2, "little")
    image[19:21] = (1440).to_bytes(2, "little")
    image[21] = 0xF9
    image[22:24] = (3).to_bytes(2, "little")
    image[24:26] = (9).to_bytes(2, "little")
    image[26:28] = (2).to_bytes(2, "little")

    result = inspect_native_media("MSX.DSK", bytes(image))

    assert result.status == "recognized_evidence"
    assert result.validation == "validated_msx_dos_fat12_geometry"
    assert result.evidence["boot_convention"] == "msx-dos-eb-fe-90"


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


def test_cpc_dsk_inspection_validates_track_and_sector_boundaries() -> None:
    dsk = bytearray(0x300)
    signature = b"EXTENDED CPC DSK File"
    dsk[:len(signature)] = signature
    dsk[0x30:0x32] = b"\x01\x01"
    dsk[0x34] = 2  # 512-byte track record
    track_signature = b"Track-Info\r\n"
    dsk[0x100:0x100 + len(track_signature)] = track_signature
    dsk[0x115] = 1
    dsk[0x118 + 3] = 2
    dsk[0x118 + 6:0x118 + 8] = (256).to_bytes(2, "little")
    result = inspect_native_media("adventure.dsk", bytes(dsk))
    assert result.validation == "validated_cpc_dsk_track_stream"
    assert result.evidence["sector_count"] == 1
    assert result.evidence["cpm_directory_extraction_eligible"] is False


def test_retained_cpc_dsk_records_nonstandard_cpm_geometry() -> None:
    image = Path(__file__).resolve().parents[1] / "preservation_corpus" / "downloads" / "110_Aventura_Original_La_1989_Aventuras_AD_es_cpm_version.dsk"
    result = inspect_native_media(image.name, image.read_bytes())
    assert result.validation == "validated_cpc_dsk_track_stream"
    assert result.evidence["cpm_directory_profile"] == "nonstandard_mixed_geometry"
    assert result.evidence["cpm_directory_extraction_eligible"] is False
    assert result.evidence["present_tracks"] == 40


def test_retained_torreoscura_pcw_dat_validates_resource_directories() -> None:
    root = Path(__file__).resolve().parents[1]
    expected = {
        "depth2_0d5b9dbf_PARTE001.DAT": 20,
        "depth2_b9b758eb_PARTE002.DAT": 10,
    }
    for filename, picture_count in expected.items():
        result = inspect_native_media(filename, (root / "preservation_corpus" / "extracted" / filename).read_bytes())
        assert result.parser == "daad-pcw-dat-v1"
        assert result.status == "recognized_evidence"
        assert result.validation == "validated_pcw_v1_resource_directory"
        assert result.evidence["picture_count"] == picture_count
        assert len(result.evidence["resources"]) == picture_count
        assert all(entry["payload_offset"] >= result.evidence["payload_floor"] for entry in result.evidence["resources"])
        assert all(entry["payload_end"] <= (root / "preservation_corpus" / "extracted" / filename).stat().st_size for entry in result.evidence["resources"])
        assert result.evidence["resource_payload_codec"] == "unresolved_profile_specific_support_loop"


def test_pcw_dat_rejects_resource_offset_before_fixed_directory() -> None:
    data = bytearray(6 + 2560)
    data[2:4] = (4).to_bytes(2, "little")
    data[4:6] = (1).to_bytes(2, "little")
    data[6:10] = (0xA05).to_bytes(4, "little")

    result = inspect_native_media("broken.dat", bytes(data))

    assert result.parser == "daad-pcw-dat-v1"
    assert result.status == "rejected"
    assert result.validation == "resource_offset_out_of_bounds"


def test_pcw_dat_rejects_resource_payload_past_file_end() -> None:
    data = bytearray(6 + 2560 + 6)
    data[2:4] = (4).to_bytes(2, "little")
    data[4:6] = (1).to_bytes(2, "little")
    data[6:10] = (6 + 2560).to_bytes(4, "little")
    resource = 6 + 2560
    data[resource:resource + 2] = (8).to_bytes(2, "little")
    data[resource + 2:resource + 4] = (8).to_bytes(2, "little")
    data[resource + 4:resource + 6] = (1).to_bytes(2, "little")

    result = inspect_native_media("broken.dat", bytes(data))

    assert result.parser == "daad-pcw-dat-v1"
    assert result.status == "rejected"
    assert result.validation == "resource_payload_out_of_bounds"


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
