"""Regression tests for bounded deterministic legacy `.CHR` generation."""

from __future__ import annotations

from pathlib import Path

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
from daad_harvester.media_inspection import inspect_native_media


def test_blank_chr_fixture_is_deterministic_and_structurally_partitioned() -> None:
    fixture = build_blank_daad_chr()

    assert fixture == build_blank_daad_chr()
    assert len(fixture) == CHR_FILE_SIZE
    evidence = validate_daad_chr(fixture)
    assert evidence["glyph_count"] == CHR_GLYPH_COUNT
    assert evidence["runtime_payload_offset"] == CHR_HEADER_SIZE
    assert fixture[CHR_HEADER_SIZE:] == bytes(CHR_PAYLOAD_SIZE)
    inspection = inspect_native_media("fixture.chr", fixture)
    assert inspection.validation == "validated_legacy_chr_container"
    assert inspection.evidence["header_semantics"] == "opaque_explicit_bytes_not_promoted"


def test_chr_builder_preserves_explicit_header_and_glyph_bytes() -> None:
    header = bytes(range(CHR_HEADER_SIZE))
    glyphs = bytes(index % 256 for index in range(CHR_PAYLOAD_SIZE))

    fixture = build_daad_chr(header=header, glyph_bytes=glyphs)

    assert fixture[:CHR_HEADER_SIZE] == header
    assert fixture[CHR_HEADER_SIZE:] == glyphs


def test_retained_torreoscura_pcw_chr_matches_adp_writer_header_profile() -> None:
    root = Path(__file__).resolve().parents[1]
    chr_path = next((root / "preservation_corpus" / "extracted").glob("**/*PARTE001.CHR"))

    evidence = validate_daad_chr(chr_path.read_bytes())

    assert evidence["header_profile"] == "adp_legacy_chr_writer"
    assert evidence["header_filename_stem"] == "D1"
    assert evidence["header_tag"] == "CHR"
    assert evidence["glyph_geometry"] == "256 glyphs × 8 rows × 8 bits"
    inspection = inspect_native_media(chr_path.name, chr_path.read_bytes())
    assert inspection.evidence["header_semantics"] == "adp_writer_fields_structurally_validated"


def test_chr_builder_and_validator_reject_invalid_bounds() -> None:
    with pytest.raises(ValueError, match="128"):
        build_daad_chr(header=b"", glyph_bytes=bytes(CHR_PAYLOAD_SIZE))
    with pytest.raises(ValueError, match="2048"):
        build_daad_chr(header=bytes(CHR_HEADER_SIZE), glyph_bytes=b"")
    with pytest.raises(TypeError, match="bytes"):
        build_daad_chr(header=bytearray(CHR_HEADER_SIZE), glyph_bytes=bytes(CHR_PAYLOAD_SIZE))
    with pytest.raises(ValueError, match="2176"):
        validate_daad_chr(b"\x00" * (CHR_FILE_SIZE - 1))
    inspection = inspect_native_media("short.chr", b"\x00" * (CHR_FILE_SIZE - 1))
    assert inspection.status == "rejected"
    assert inspection.validation == "invalid_chr_container_size"
