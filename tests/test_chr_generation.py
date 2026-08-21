"""Regression tests for bounded deterministic legacy `.CHR` generation."""

from __future__ import annotations

import pytest

from daad_harvester.chr_generation import (
    CHR_FILE_SIZE,
    CHR_GLYPH_COUNT,
    CHR_HEADER_SIZE,
    CHR_PAYLOAD_SIZE,
    build_blank_daad_chr,
    build_daad_chr,
    validate_daad_chr,
)


def test_blank_chr_fixture_is_deterministic_and_structurally_partitioned() -> None:
    fixture = build_blank_daad_chr()

    assert fixture == build_blank_daad_chr()
    assert len(fixture) == CHR_FILE_SIZE
    evidence = validate_daad_chr(fixture)
    assert evidence["glyph_count"] == CHR_GLYPH_COUNT
    assert evidence["runtime_payload_offset"] == CHR_HEADER_SIZE
    assert fixture[CHR_HEADER_SIZE:] == bytes(CHR_PAYLOAD_SIZE)


def test_chr_builder_preserves_explicit_header_and_glyph_bytes() -> None:
    header = bytes(range(CHR_HEADER_SIZE))
    glyphs = bytes(index % 256 for index in range(CHR_PAYLOAD_SIZE))

    fixture = build_daad_chr(header=header, glyph_bytes=glyphs)

    assert fixture[:CHR_HEADER_SIZE] == header
    assert fixture[CHR_HEADER_SIZE:] == glyphs


def test_chr_builder_and_validator_reject_invalid_bounds() -> None:
    with pytest.raises(ValueError, match="128"):
        build_daad_chr(header=b"", glyph_bytes=bytes(CHR_PAYLOAD_SIZE))
    with pytest.raises(ValueError, match="2048"):
        build_daad_chr(header=bytes(CHR_HEADER_SIZE), glyph_bytes=b"")
    with pytest.raises(TypeError, match="bytes"):
        build_daad_chr(header=bytearray(CHR_HEADER_SIZE), glyph_bytes=bytes(CHR_PAYLOAD_SIZE))
    with pytest.raises(ValueError, match="2176"):
        validate_daad_chr(b"\x00" * (CHR_FILE_SIZE - 1))
