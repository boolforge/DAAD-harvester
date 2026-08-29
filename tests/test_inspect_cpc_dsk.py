"""Tests for scripts/inspect_cpc_dsk.py.

test_parse_tracks_truncated_extended_size_table_raises_clean_value_error is a
regression test for a real bug found while auditing this file: a header claiming
more tracks*sides than the actual (truncated) data could back raised an unhandled
IndexError from a direct `size_table[index]` read, instead of the descriptive
ValueError every other malformed-input path in this file raises. Reproduced first
with a minimal crafted header before fixing, exactly as reproduced here.
"""
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from inspect_cpc_dsk import decode_name, directory_entries, inspect, parse_tracks  # noqa: E402


def _build_dsk(tracks=1, sides=1, sector_size_code=2, extended=False, extra_tail=b""):
    """Builds a minimal, valid (non-extended by default) CPC DSK image with one
    sector per track, filled with 0xE5 bytes, for use as a parse_tracks fixture."""
    sector_size = 128 << sector_size_code
    track_size = 0x100 + sector_size

    disk_info = bytearray(0x100)
    disk_info[0:16] = (b"EXTENDED CPC DSK" if extended else b"MV - CPCEMU")[:16].ljust(16, b" ")
    disk_info[0x30] = tracks
    disk_info[0x31] = sides
    if extended:
        disk_info[0x34:0x34 + tracks * sides] = bytes([track_size // 256] * (tracks * sides))
    else:
        disk_info[0x32:0x34] = track_size.to_bytes(2, "little")

    out = bytearray(disk_info)
    for t in range(tracks * sides):
        track_header = bytearray(0x100)
        track_header[0:10] = b"Track-Info"
        track_header[0x10] = t
        track_header[0x11] = 0
        track_header[0x15] = 1
        descriptor = bytearray(8)
        descriptor[0], descriptor[1], descriptor[2], descriptor[3] = t, 0, 0xC1, sector_size_code
        track_header[0x18:0x20] = descriptor
        out += track_header + bytes([0xE5]) * sector_size
    return bytes(out) + extra_tail


def _directory_entry(user=0, name="GAME", extension="BAS", records=1, blocks=(1,)):
    entry = bytearray(32)
    entry[0] = user
    entry[1:9] = name.ljust(8).encode("ascii")
    entry[9:12] = extension.ljust(3).encode("ascii")
    entry[15] = records
    for i, block in enumerate(blocks):
        entry[16 + i] = block
    return bytes(entry)


def test_decode_name_valid_uppercase():
    assert decode_name(b"GAME    ") == "GAME"


def test_decode_name_strips_high_bit_cpm_attribute_flags():
    # CP/M uses the top bit of filename bytes for read-only/system attribute
    # flags; the underlying character must still be recovered correctly.
    assert decode_name(bytes([0xC1, 0xC2, 0xC3, 0x20, 0x20, 0x20, 0x20, 0x20])) == "ABC"


def test_decode_name_rejects_invalid_characters():
    assert decode_name(b"lower   ") == ""  # lowercase not in the allowed set
    assert decode_name(b"\x01\x02\x03\x04\x05\x06\x07\x08") == ""


def test_parse_tracks_rejects_short_or_unsigned_data():
    with pytest.raises(ValueError, match="not a complete CPC DSK image"):
        parse_tracks(b"too short")
    with pytest.raises(ValueError, match="not a complete CPC DSK image"):
        parse_tracks(b"NOT A REAL SIGNATURE".ljust(0x200, b"\x00"))


def test_parse_tracks_happy_path_non_extended():
    data = _build_dsk(tracks=2, sides=1)
    tracks = parse_tracks(data)
    assert len(tracks) == 2
    assert tracks[0]["cylinder"] == 0
    assert tracks[1]["cylinder"] == 1
    assert tracks[0]["sectors"][0]["id"] == 0xC1
    assert tracks[0]["sectors"][0]["size"] == 512


def test_parse_tracks_happy_path_extended():
    data = _build_dsk(tracks=2, sides=1, extended=True)
    tracks = parse_tracks(data)
    assert len(tracks) == 2
    assert tracks[0]["track_size"] == 0x100 + 512


def test_parse_tracks_rejects_trailing_bytes():
    data = _build_dsk(tracks=1, sides=1, extra_tail=b"\x00" * 16)
    with pytest.raises(ValueError, match="trailing bytes"):
        parse_tracks(data)


def test_parse_tracks_truncated_extended_size_table_raises_clean_value_error():
    """Regression test: a header claiming far more tracks*sides than the actual
    file can back a size table for must raise ValueError, not IndexError."""
    disk_info = bytearray(0x200)
    disk_info[0:16] = b"EXTENDED CPC DSK"
    disk_info[0x30] = 100  # tracks
    disk_info[0x31] = 5    # sides -- claims 500 entries, only ~460 bytes exist
    data = bytes(disk_info)

    with pytest.raises(ValueError, match="missing from truncated extended size table"):
        parse_tracks(data)


def test_directory_entries_parses_valid_entry():
    window = _directory_entry(user=0, name="GAME", extension="BAS", records=3, blocks=(1, 2))
    window = window.ljust(64, b"\x00")

    entries = directory_entries(window)

    assert len(entries) == 1
    assert entries[0] == {
        "user": 0,
        "filename": "GAME.BAS",
        "extent": 0,
        "records": 3,
        "blocks": [1, 2],
    }


def test_directory_entries_skips_deleted_entries():
    entry = bytearray(_directory_entry())
    entry[0] = 0xE5  # deleted marker
    assert directory_entries(bytes(entry)) == []


def test_directory_entries_skips_entries_with_zero_records():
    entry = _directory_entry(records=0)
    assert directory_entries(entry) == []


def test_directory_entries_skips_entries_with_no_allocation_blocks():
    entry = _directory_entry(blocks=())
    assert directory_entries(entry) == []


def test_inspect_end_to_end(tmp_path):
    dsk_path = tmp_path / "test.dsk"
    dsk_path.write_bytes(_build_dsk(tracks=1, sides=1))

    result = inspect(dsk_path)

    assert result["track_count"] == 1
    assert result["size"] == len(dsk_path.read_bytes())
    assert isinstance(result["directory_candidates"], list)
