"""Native media-parser regressions for every official DAAD target family."""

from __future__ import annotations

import gzip
import io
from pathlib import Path
import zipfile

import pytest

from daad_harvester.db import Database
from daad_harvester.platform_media import (
    decompress_msa,
    extract_adf,
    extract_c64_tap_kernal_packets,
    extract_fat12,
    extract_fat16,
    parse_tzx_blocks,
)
from daad_harvester.unpack import Unpacker
from tests.ddb_fixtures import make_legacy_ddb


def _fat12_image(payload: bytes = b"DAAD.DDB") -> bytes:
    sectors = 4
    image = bytearray(sectors * 512)
    image[11:13] = (512).to_bytes(2, "little")
    image[13] = 1
    image[14:16] = (1).to_bytes(2, "little")
    image[16] = 1
    image[17:19] = (16).to_bytes(2, "little")
    image[19:21] = sectors.to_bytes(2, "little")
    image[21] = 0xF0
    image[22:24] = (1).to_bytes(2, "little")
    image[510:512] = b"\x55\xaa"
    # FAT: media/reserved clusters then cluster 2 -> EOF.
    image[512:517] = b"\xf0\xff\xff\xff\x0f"
    root = 1024
    image[root:root + 8] = b"DAAD    "
    image[root + 8:root + 11] = b"DDB"
    image[root + 26:root + 28] = (2).to_bytes(2, "little")
    image[root + 28:root + 32] = len(payload).to_bytes(4, "little")
    image[1536:1536 + len(payload)] = payload
    return bytes(image)


def _fat16_nested_image(payload: bytes = b"FAT16.DDB") -> bytes:
    # BPB geometry creates 4,085 data clusters, the first valid FAT16 threshold.
    data_clusters = 4085
    sectors_per_fat = 16
    sectors = 1 + sectors_per_fat + 1 + data_clusters
    image = bytearray(sectors * 512)
    image[11:13] = (512).to_bytes(2, "little")
    image[13] = 1
    image[14:16] = (1).to_bytes(2, "little")
    image[16] = 1
    image[17:19] = (16).to_bytes(2, "little")
    image[19:21] = sectors.to_bytes(2, "little")
    image[21] = 0xF8
    image[22:24] = sectors_per_fat.to_bytes(2, "little")
    image[510:512] = b"\x55\xaa"
    fat = 512
    for cluster, value in ((0, 0xFFF8), (1, 0xFFFF), (2, 0xFFFF), (3, 0xFFFF)):
        image[fat + cluster * 2:fat + cluster * 2 + 2] = value.to_bytes(2, "little")
    root = (1 + sectors_per_fat) * 512
    image[root:root + 8] = b"LEVEL1  "
    image[root + 11] = 0x10
    image[root + 26:root + 28] = (2).to_bytes(2, "little")
    data_start = (1 + sectors_per_fat + 1) * 512
    image[data_start:data_start + 8] = b"DAAD    "  # cluster 2 directory
    image[data_start + 8:data_start + 11] = b"DDB"
    image[data_start + 26:data_start + 28] = (3).to_bytes(2, "little")
    image[data_start + 28:data_start + 32] = len(payload).to_bytes(4, "little")
    image[data_start + 512:data_start + 512 + len(payload)] = payload  # cluster 3
    return bytes(image)


def _lfn_entry(name: str, short_name: bytes) -> bytes:
    encoded = (name + "\x00").encode("utf-16le").ljust(26, b"\xff")
    entry = bytearray(32)
    entry[0] = 0x41
    entry[1:11] = encoded[:10]
    entry[11] = 0x0F
    entry[13] = 0
    for value in short_name:
        entry[13] = (((entry[13] & 1) << 7) + (entry[13] >> 1) + value) & 0xFF
    entry[14:26] = encoded[10:22]
    entry[28:32] = encoded[22:26]
    return bytes(entry)


def _t64(payload: bytes = b"DDB") -> bytes:
    data = bytearray(160)
    data[:32] = b"C64 tape image file".ljust(32, b" ")
    data[34:36] = (1).to_bytes(2, "little")
    data[36:38] = (1).to_bytes(2, "little")
    entry = 64
    data[entry] = 1
    data[entry + 2:entry + 4] = (0x0801).to_bytes(2, "little")
    data[entry + 4:entry + 6] = (0x0801 + len(payload)).to_bytes(2, "little")
    data[entry + 8:entry + 12] = (128).to_bytes(4, "little")
    data[entry + 16:entry + 32] = b"ADVENTURE".ljust(16, b" ")
    data[128:128 + len(payload)] = payload
    return bytes(data)


def _c64_tap_packet(value: int, *, valid_parity: bool = True) -> bytes:
    """Build one KERNAL-compatible raw-TAP packet for bounded extraction tests."""
    pulses = bytearray([46] * 20 + [89, 74])
    bits = [(value >> bit) & 1 for bit in range(8)]
    parity = 1 ^ (value.bit_count() & 1)
    if not valid_parity:
        parity ^= 1
    bits.append(parity)
    for bit in bits:
        first, second = ((74, 46) if bit else (46, 74))
        pulses.extend((first, second))
    header = bytearray(b"C64-TAPE-RAW")
    header.extend((1, 0, 0, 0))
    header.extend(len(pulses).to_bytes(4, "little"))
    return bytes(header + pulses)


def _tzx() -> bytes:
    header = b"\x00\x00GAME      \x00\x00\x00\x00\x00\x00\x00"
    body = b"\xffPAYLOAD\x00"
    return (
        b"ZXTape!\x1a\x01\x14"
        + b"\x10" + (1000).to_bytes(2, "little") + len(header).to_bytes(2, "little") + header
        + b"\x10" + (1000).to_bytes(2, "little") + len(body).to_bytes(2, "little") + body
    )


def _msa(raw: bytes) -> bytes:
    # One track, one side, four 512-byte sectors, stored raw inside MSA.
    return b"\x0e\x0f" + (4).to_bytes(2, "big") + b"\x00\x00\x00\x00\x00\x00" + len(raw).to_bytes(2, "big") + raw


def _adf(*, ffs: bool = False, payload: bytes = b"DAAD.DDB") -> bytes:
    image = bytearray(901120)
    image[:4] = b"DOS" + bytes((1 if ffs else 0,))
    image[8:12] = (880).to_bytes(4, "big")
    root = memoryview(image)[880 * 512:(880 + 1) * 512]
    root[:4] = (2).to_bytes(4, "big")
    root[6 * 4:7 * 4] = (100).to_bytes(4, "big")
    root[127 * 4:128 * 4] = (1).to_bytes(4, "big", signed=True)
    header = memoryview(image)[100 * 512:101 * 512]
    header[:4] = (2).to_bytes(4, "big")
    header[4:8] = (100).to_bytes(4, "big")
    header[2 * 4:3 * 4] = (1).to_bytes(4, "big")
    header[4 * 4:5 * 4] = (101).to_bytes(4, "big")
    header[81 * 4:82 * 4] = len(payload).to_bytes(4, "big")
    name_at = 108 * 4
    header[name_at] = 8
    header[name_at + 1:name_at + 9] = b"DAAD.DDB"
    header[127 * 4:128 * 4] = (-3).to_bytes(4, "big", signed=True)
    if ffs:
        header[77 * 4:78 * 4] = (101).to_bytes(4, "big")
        image[101 * 512:101 * 512 + len(payload)] = payload
    else:
        block = memoryview(image)[101 * 512:102 * 512]
        block[:4] = (8).to_bytes(4, "big")
        block[4:8] = (100).to_bytes(4, "big")
        block[3 * 4:4 * 4] = len(payload).to_bytes(4, "big")
        block[24:24 + len(payload)] = payload
    return bytes(image)


def _d64(payload: bytes = b"\x01\x08DAAD") -> bytes:
    image = bytearray(174848)
    directory_offset = (17 * 21 + 1) * 256
    image[directory_offset:directory_offset + 2] = b"\x00\x00"
    entry = directory_offset + 2
    image[entry] = 0x82
    image[entry + 1:entry + 3] = b"\x01\x00"
    image[entry + 3:entry + 19] = b"ADVENTURE".ljust(16, b"\xa0")
    image[1] = len(payload) + 1
    image[2:2 + len(payload)] = payload
    return bytes(image)


def _d71_second_side(payload: bytes = b"\x01\x08D71") -> bytes:
    image = bytearray(349696)
    # The side-one BAM directory points to a normal side-two file chain.
    directory_offset = (17 * 21 + 1) * 256
    image[directory_offset:directory_offset + 2] = b"\x00\x00"
    entry = directory_offset + 2
    image[entry] = 0x82
    image[entry + 1:entry + 3] = b"\x24\x00"  # track 36, sector 0
    image[entry + 3:entry + 19] = b"SECOND SIDE".ljust(16, b"\xa0")
    side_two = 174848
    image[side_two + 1] = len(payload) + 1
    image[side_two + 2:side_two + 2 + len(payload)] = payload
    return bytes(image)


def _unpacker(tmp_path: Path) -> Unpacker:
    return Unpacker(Database(tmp_path / "state.db"), extract_dir=tmp_path / "extracted")


def test_extracts_t64_c64_and_plus4_style_prg(tmp_path: Path) -> None:
    assert _unpacker(tmp_path).unpack_t64(_t64()) == [("ADVENTURE.prg", b"\x01\x08DDB")]


def test_extracts_parity_valid_c64_raw_tap_kernal_packet(tmp_path: Path) -> None:
    tap = _c64_tap_packet(0xA5)
    expected = [("c64tap_kernal_packet_000.bin", b"\xa5")]
    assert extract_c64_tap_kernal_packets(tap) == expected
    assert _unpacker(tmp_path).extract_container(tmp_path / "packet.tap", "packet.tap", tap) == expected


def test_rejects_c64_raw_tap_packet_with_bad_parity() -> None:
    assert extract_c64_tap_kernal_packets(_c64_tap_packet(0xA5, valid_parity=False)) == []


def test_retained_jabato_side_a_raw_tap_recovers_rom_packets() -> None:
    source = (
        Path(__file__).resolve().parents[1]
        / "preservation_corpus/extracted/depth1_8dfc7ab2_Jabato (1989)(Aventuras AD)(Side A).tap"
    )
    members = extract_c64_tap_kernal_packets(source.read_bytes())
    assert [len(payload) for _, payload in members] == [202, 202, 299, 299]
    assert members[0][1].startswith(b"\x89\x88\x87\x86\x85\x84\x83\x82\x81\x03\x9f\x02\xc0\x03JABATO 1")


def test_extracts_correctly_offset_c64_d64_directory_entry(tmp_path: Path) -> None:
    assert _unpacker(tmp_path).unpack_d64(_d64()) == [("ADVENTURE", b"\x01\x08DAAD")]


def test_extracts_d71_file_chain_from_second_side(tmp_path: Path) -> None:
    unpacker = _unpacker(tmp_path)
    image = _d71_second_side()
    assert unpacker.unpack_d71(image) == [("SECOND SIDE", b"\x01\x08D71")]
    assert unpacker.identify_container_format("adventure.d71", image) == "c64-d71"


def test_extracts_tzx_and_cdt_standard_blocks(tmp_path: Path) -> None:
    unpacker = _unpacker(tmp_path)
    assert unpacker.unpack_tzx(_tzx()) == [("GAME.bas", b"PAYLOAD")]
    assert unpacker.extract_container(tmp_path / "game.cdt", "game.cdt", _tzx()) == [("GAME.bas", b"PAYLOAD")]


def test_tzx_scans_standardized_timing_control_metadata_and_extension_blocks() -> None:
    tape = bytearray(b"ZXTape!\x1a\x01\x14")
    tape += b"\x12\x00\x00\x00\x00"  # pure tone
    tape += b"\x13\x02\x01\x00\x02\x00"  # pulse sequence
    tape += b"\x15" + b"\x00" * 5 + b"\x01\x00\x00\x80"  # direct recording
    tape += b"\x18" + (0).to_bytes(4, "little")  # CSW block boundary
    tape += b"\x19" + (0).to_bytes(4, "little")  # generalized block boundary
    tape += b"\x20\x00\x00\x21\x01G\x22"  # pause and group
    tape += b"\x24\x02\x00\x25"  # loop markers
    tape += b"\x26\x01\x00\x01\x00\x27"  # call/return target
    tape += b"\x28\x01\x00\x00"  # empty selector record
    tape += b"\x2a\x00\x00\x00\x00\x2b\x01\x00\x00\x00\x01"
    tape += b"\x30\x01T\x31\x00\x01M\x32\x01\x00\x00\x33\x01\x00\x00\x00"
    tape += b"\x35" + b"DAAD-HARVESTER  " + (0).to_bytes(4, "little")
    tape += b"\x5aXTape!\x1a\x01\x14"
    blocks = parse_tzx_blocks(bytes(tape))
    assert blocks is not None
    assert [block.kind for block in blocks] == [
        "pure_tone", "pulse_sequence", "direct_recording", "csw_recording", "generalized_data",
        "pause_or_stop", "group_start", "group_end", "loop_start", "loop_end", "call_sequence",
        "return", "select", "stop_48k", "set_signal_level", "text_description", "message",
        "archive_info", "hardware_info", "custom_info", "glue",
    ]
    assert blocks[10].relative_targets == (1,)


def test_tzx_rejects_unknown_truncated_and_invalid_control_target_blocks() -> None:
    header = b"ZXTape!\x1a\x01\x14"
    assert parse_tzx_blocks(header + b"\x99") is None
    assert parse_tzx_blocks(header + b"\x11" + b"\x00" * 17) is None
    assert parse_tzx_blocks(header + b"\x23\xff\xff") is None


def test_extracts_msx_and_dos_fat12_images(tmp_path: Path) -> None:
    image = _fat12_image()
    assert extract_fat12(image) == [("DAAD.DDB", b"DAAD.DDB")]
    unpacker = _unpacker(tmp_path)
    assert unpacker.extract_container(tmp_path / "game.dsk", "game.img", image) == [("DAAD.DDB", b"DAAD.DDB")]
    assert unpacker.extract_container(tmp_path / "game.dsk", "game.dsk", image) == [("DAAD.DDB", b"DAAD.DDB")]
    assert unpacker.extract_container(tmp_path / "game.st", "game.st", image) == [("DAAD.DDB", b"DAAD.DDB")]


def test_extracts_nested_dos_fat16_filesystem(tmp_path: Path) -> None:
    image = _fat16_nested_image()
    assert extract_fat16(image) == [("LEVEL1/DAAD.DDB", b"FAT16.DDB")]
    assert _unpacker(tmp_path).unpack_fat(image) == [("LEVEL1/DAAD.DDB", b"FAT16.DDB")]


def test_fat16_validates_and_recovers_long_filename_records() -> None:
    image = bytearray(_fat16_nested_image())
    root = (1 + 16) * 512
    short_name = b"ADVENT~1DDB"
    image[root + 32:root + 64] = _lfn_entry("DAAD123.ddb", short_name)
    image[root + 64:root + 72] = short_name[:8]
    image[root + 72:root + 75] = short_name[8:]
    image[root + 64 + 26:root + 64 + 28] = (3).to_bytes(2, "little")
    image[root + 64 + 28:root + 64 + 32] = len(b"FAT16.DDB").to_bytes(4, "little")
    assert extract_fat16(bytes(image)) == [
        ("LEVEL1/DAAD.DDB", b"FAT16.DDB"),
        ("DAAD123.ddb", b"FAT16.DDB"),
    ]


def test_decodes_msa_then_extracts_atari_st_fat12(tmp_path: Path) -> None:
    raw = _fat12_image()
    # A valid MSA track needs enough sectors to contain the FAT fixture.
    msa = _msa(raw)
    assert decompress_msa(msa) == raw
    assert _unpacker(tmp_path).unpack_msa(msa) == [("DAAD.DDB", b"DAAD.DDB")]


@pytest.mark.parametrize("ffs", (False, True))
def test_extracts_amiga_ofs_and_ffs_adf(ffs: bool) -> None:
    assert extract_adf(_adf(ffs=ffs)) == [("DAAD.DDB", b"DAAD.DDB")]


def test_extracts_ffs_file_across_validated_extension_block() -> None:
    image = bytearray(_adf(ffs=True, payload=b"A" * 512))
    header = memoryview(image)[100 * 512:101 * 512]
    header[81 * 4:82 * 4] = (1024).to_bytes(4, "big")
    header[126 * 4:127 * 4] = (102).to_bytes(4, "big")
    extension = memoryview(image)[102 * 512:103 * 512]
    extension[:4] = (2).to_bytes(4, "big")
    extension[1 * 4:2 * 4] = (102).to_bytes(4, "big")
    extension[77 * 4:78 * 4] = (103).to_bytes(4, "big")
    extension[127 * 4:128 * 4] = (-3).to_bytes(4, "big", signed=True)
    image[103 * 512:104 * 512] = b"B" * 512
    assert extract_adf(bytes(image)) == [("DAAD.DDB", b"A" * 512 + b"B" * 512)]


def test_extracts_game_data_from_retained_amiga_chichen_itza_adf() -> None:
    """Regression: the retained OFS image uses FileHeaderBlock word 81 for size."""

    image = Path(__file__).resolve().parents[1] / "preservation_corpus" / "downloads" / "245_Chichen_Itza_1991_Aventuras_AD_ES_cr_QTX.adf"
    members = dict(extract_adf(image.read_bytes()))
    assert len(members) == 19
    assert len(members["PART1.DDB"]) == 42804
    assert len(members["PART2.DDB"]) == 43990


def test_extracts_gzipped_adz(tmp_path: Path) -> None:
    adz = gzip.compress(_adf())
    assert _unpacker(tmp_path).unpack_adz(adz) == [("DAAD.DDB", b"DAAD.DDB")]


def test_splits_msx_cas_records(tmp_path: Path) -> None:
    cas_header = b"\x1f\xa6\xde\xba\xcc\x13\x7d\x74"
    data = cas_header + b"ADVENTURE " + b"DDB-A" + cas_header + b"SECOND    " + b"DDB-B"
    assert _unpacker(tmp_path).unpack_cas(data) == [
        ("ADVENTURE.casbin", b"ADVENTURE DDB-A"),
        ("SECOND.casbin", b"SECOND    DDB-B"),
    ]


def test_recursive_unpack_records_media_and_member_provenance(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.invalid/game.dsk", "fixture", platform="msx")
    assert source_id is not None
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    ids = unpacker.unpack_artifact_recursive(source_id, "game.dsk", _fat12_image())
    assert len(ids) == 2
    root, member = db.get_all_artifacts()
    assert root.container_format == "disk-image"
    assert root.container_member is None
    assert member.container_member == "DAAD.DDB"


def test_recursive_unpack_materializes_verified_embedded_ddb_once(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.invalid/loader.bin", "fixture", platform="zx")
    assert source_id is not None
    payload = make_legacy_ddb("zx")
    loader = b"LOADER" + payload + b"TRAILER"
    artifacts = _unpacker(tmp_path).unpack_artifact_recursive(source_id, "loader.bin", loader)

    assert len(artifacts) == 2
    parent, child = db.get_all_artifacts()
    assert parent.original_filename == "loader.bin"
    assert parent.media_evidence_json is not None and '"embedded_ddb"' in parent.media_evidence_json
    assert child.original_filename == "loader__embedded_000006.ddb"
    assert child.archive_depth == 1
    assert child.container_member == child.original_filename
    assert Path(child.extracted_path).read_bytes() == payload


def test_reunpacks_retained_root_without_source_download_path(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.invalid/game.adf", "fixture", platform="amiga")
    assert source_id is not None
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    first_ids = unpacker.unpack_artifact_recursive(source_id, "game.adf", _adf())
    assert len(first_ids) == 2
    derived_path = next(artifact.extracted_path for artifact in db.get_all_artifacts() if artifact.archive_depth == 1)
    assert unpacker.reunpack_retained_source(source_id) == 2
    assert len(db.get_all_artifacts()) == 2
    assert Path(derived_path).is_file()


def test_retains_distinct_equal_byte_container_members(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.invalid/game.zip", "fixture")
    assert source_id is not None
    archive = io.BytesIO()
    with zipfile.ZipFile(archive, "w") as handle:
        handle.writestr("PART1.CHR", b"shared-character-data")
        handle.writestr("PART2.CHR", b"shared-character-data")
    unpacker = Unpacker(db, extract_dir=tmp_path / "extracted")
    unpacker.unpack_artifact_recursive(source_id, "game.zip", archive.getvalue())
    assert [artifact.original_filename for artifact in db.get_all_artifacts()] == [
        "game.zip", "PART1.CHR", "PART2.CHR"
    ]


def test_rejects_corrupt_platform_containers(tmp_path: Path) -> None:
    unpacker = _unpacker(tmp_path)
    assert unpacker.unpack_t64(b"C64 tape image") == []
    assert unpacker.unpack_tzx(b"ZXTape!\x1a\x01\x14\x10") == []
    assert unpacker.unpack_msa(b"\x0e\x0f\x00") == []
    assert unpacker.unpack_adf(b"DOS\x00" + b"\x00" * 1024) == []
