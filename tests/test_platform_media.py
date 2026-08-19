"""Native media-parser regressions for every official DAAD target family."""

from __future__ import annotations

import gzip
from pathlib import Path

import pytest

from daad_harvester.db import Database
from daad_harvester.platform_media import decompress_msa, extract_adf, extract_fat12
from daad_harvester.unpack import Unpacker


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
    header[80 * 4:81 * 4] = len(payload).to_bytes(4, "big")
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


def _unpacker(tmp_path: Path) -> Unpacker:
    return Unpacker(Database(tmp_path / "state.db"), extract_dir=tmp_path / "extracted")


def test_extracts_t64_c64_and_plus4_style_prg(tmp_path: Path) -> None:
    assert _unpacker(tmp_path).unpack_t64(_t64()) == [("ADVENTURE.prg", b"\x01\x08DDB")]


def test_extracts_correctly_offset_c64_d64_directory_entry(tmp_path: Path) -> None:
    assert _unpacker(tmp_path).unpack_d64(_d64()) == [("ADVENTURE", b"\x01\x08DAAD")]


def test_extracts_tzx_and_cdt_standard_blocks(tmp_path: Path) -> None:
    unpacker = _unpacker(tmp_path)
    assert unpacker.unpack_tzx(_tzx()) == [("GAME.bas", b"PAYLOAD")]
    assert unpacker.extract_container(tmp_path / "game.cdt", "game.cdt", _tzx()) == [("GAME.bas", b"PAYLOAD")]


def test_extracts_msx_and_dos_fat12_images(tmp_path: Path) -> None:
    image = _fat12_image()
    assert extract_fat12(image) == [("DAAD.DDB", b"DAAD.DDB")]
    unpacker = _unpacker(tmp_path)
    assert unpacker.extract_container(tmp_path / "game.dsk", "game.img", image) == [("DAAD.DDB", b"DAAD.DDB")]
    assert unpacker.extract_container(tmp_path / "game.st", "game.st", image) == [("DAAD.DDB", b"DAAD.DDB")]


def test_decodes_msa_then_extracts_atari_st_fat12(tmp_path: Path) -> None:
    raw = _fat12_image()
    # A valid MSA track needs enough sectors to contain the FAT fixture.
    msa = _msa(raw)
    assert decompress_msa(msa) == raw
    assert _unpacker(tmp_path).unpack_msa(msa) == [("DAAD.DDB", b"DAAD.DDB")]


@pytest.mark.parametrize("ffs", (False, True))
def test_extracts_amiga_ofs_and_ffs_adf(ffs: bool) -> None:
    assert extract_adf(_adf(ffs=ffs)) == [("DAAD.DDB", b"DAAD.DDB")]


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


def test_rejects_corrupt_platform_containers(tmp_path: Path) -> None:
    unpacker = _unpacker(tmp_path)
    assert unpacker.unpack_t64(b"C64 tape image") == []
    assert unpacker.unpack_tzx(b"ZXTape!\x1a\x01\x14\x10") == []
    assert unpacker.unpack_msa(b"\x0e\x0f\x00") == []
    assert unpacker.unpack_adf(b"DOS\x00" + b"\x00" * 1024) == []
