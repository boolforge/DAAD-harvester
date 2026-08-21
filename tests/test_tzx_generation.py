"""Regression tests for deterministic bounded TZX/CDT generation."""

from __future__ import annotations

import pytest

from daad_harvester.media_inspection import inspect_native_media
from daad_harvester.platform_media import extract_tzx, parse_tzx_blocks
from daad_harvester.tzx_generation import (
    TZX_HEADER,
    TzxStandardDataBlock,
    build_tzx_standard_data,
    validate_tzx_standard_data,
)


def test_standard_tzx_generation_is_deterministic_and_parser_round_trips() -> None:
    blocks = [TzxStandardDataBlock(b"\xffDAAD\x00", pause_ms=1000), TzxStandardDataBlock(b"\xffNEXT\x01", pause_ms=0)]
    first = build_tzx_standard_data(blocks)

    assert first == build_tzx_standard_data(blocks)
    assert first.startswith(TZX_HEADER)
    parsed = parse_tzx_blocks(first)
    assert parsed is not None
    assert [block.kind for block in parsed] == ["standard_data", "standard_data"]
    assert [block.data for block in parsed] == [item.data for item in blocks]
    evidence = validate_tzx_standard_data(first)
    assert evidence["pause_ms"] == [1000, 0]
    assert evidence["data_lengths"] == [6, 6]
    assert extract_tzx(first) == [("tzx_0.bin", blocks[0].data), ("tzx_1.bin", blocks[1].data)]
    assert inspect_native_media("fixture.cdt", first).validation == "validated_tzx_v1_block_stream"


def test_standard_tzx_generation_preserves_explicit_header_data_pair_for_extraction() -> None:
    header = b"\x00\x00DAAD GAME \x00\x00\x00\x00\x00\x00\x00"
    data = b"\xffPAYLOAD\x00"
    stream = build_tzx_standard_data([TzxStandardDataBlock(header), TzxStandardDataBlock(data)])

    assert extract_tzx(stream) == [("DAAD GAME.bas", b"PAYLOAD")]


def test_standard_tzx_generation_rejects_invalid_inputs_and_corruption() -> None:
    with pytest.raises(ValueError, match="at least one"):
        build_tzx_standard_data([])
    with pytest.raises(ValueError, match="1 through"):
        build_tzx_standard_data([TzxStandardDataBlock(b"")])
    with pytest.raises(ValueError, match="pause_ms"):
        build_tzx_standard_data([TzxStandardDataBlock(b"\xff", pause_ms=65536)])
    with pytest.raises(TypeError, match="blocks"):
        build_tzx_standard_data(b"not a block sequence")

    corrupted = bytearray(build_tzx_standard_data([TzxStandardDataBlock(b"\xffDATA")]))
    corrupted[13:15] = (0xFFFF).to_bytes(2, "little")
    with pytest.raises(ValueError, match="complete supported"):
        validate_tzx_standard_data(bytes(corrupted))
