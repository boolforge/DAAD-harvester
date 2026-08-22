"""Regression tests for bounded deterministic legacy `.CHR` generation."""

from __future__ import annotations

from pathlib import Path
import struct
import zlib

import pytest

from daad_harvester.chr_generation import (
    CHR_FILE_SIZE,
    CHR_GLYPH_COUNT,
    CHR_HEADER_SIZE,
    CHR_PAYLOAD_SIZE,
    build_blank_daad_chr,
    build_daad_chr,
    render_adp_chr_glyph_atlas,
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


def _validated_adp_chr(*, first_glyph: bytes = b"\x00" * 8) -> bytes:
    header = bytearray(CHR_HEADER_SIZE)
    header[9:12] = b"CHR"
    header[0x12] = 2
    header[0x41] = 8
    header[0x43:0x45] = (0x0224).to_bytes(2, "little")
    return build_daad_chr(header=bytes(header), glyph_bytes=first_glyph + bytes(CHR_PAYLOAD_SIZE - 8))


def _decode_grayscale_png(png: bytes) -> tuple[int, int, bytes]:
    assert png.startswith(b"\x89PNG\r\n\x1a\n")
    cursor = 8
    chunks: dict[bytes, list[bytes]] = {}
    while cursor < len(png):
        length = struct.unpack(">I", png[cursor:cursor + 4])[0]
        kind = png[cursor + 4:cursor + 8]
        payload = png[cursor + 8:cursor + 8 + length]
        assert struct.unpack(">I", png[cursor + 8 + length:cursor + 12 + length])[0] == zlib.crc32(kind + payload) & 0xFFFFFFFF
        chunks.setdefault(kind, []).append(payload)
        cursor += 12 + length
    width, height, bit_depth, color_type, *_ = struct.unpack(">IIBBBBB", chunks[b"IHDR"][0])
    assert (bit_depth, color_type) == (8, 0)
    raw = zlib.decompress(b"".join(chunks[b"IDAT"]))
    return width, height, raw


def test_adp_chr_atlas_is_deterministic_and_preserves_msb_leftmost_rows() -> None:
    atlas, evidence = render_adp_chr_glyph_atlas(_validated_adp_chr(first_glyph=b"\x80" * 8), scale=2)

    assert atlas == render_adp_chr_glyph_atlas(_validated_adp_chr(first_glyph=b"\x80" * 8), scale=2)[0]
    assert evidence["glyph_index_mapping"] == "byte_index_only_no_code_page_claim"
    assert (evidence["width"], evidence["height"]) == (256, 256)
    width, height, raw = _decode_grayscale_png(atlas)
    assert (width, height) == (256, 256)
    assert raw[0] == 0
    assert raw[1:3] == b"\xff\xff"
    assert raw[3:17] == b"\x00" * 14
    assert raw[(8 * (width + 1)) + 1:(8 * (width + 1)) + 3] == b"\xff\xff"


def test_adp_chr_atlas_rejects_nonprofile_container_and_invalid_scale() -> None:
    with pytest.raises(ValueError, match="validated ADP legacy"):
        render_adp_chr_glyph_atlas(build_blank_daad_chr())
    with pytest.raises(ValueError, match="positive integer"):
        render_adp_chr_glyph_atlas(_validated_adp_chr(), scale=0)
    with pytest.raises(ValueError, match="positive integer"):
        render_adp_chr_glyph_atlas(_validated_adp_chr(), scale=True)


def test_retained_chr_atlas_has_real_profile_dimensions() -> None:
    root = Path(__file__).resolve().parents[1]
    chr_path = next((root / "preservation_corpus" / "extracted").glob("**/*PARTE001.CHR"))

    atlas, evidence = render_adp_chr_glyph_atlas(chr_path.read_bytes())

    width, height, raw = _decode_grayscale_png(atlas)
    assert (width, height) == (128, 128)
    assert evidence["decoder_profile"] == "adp_legacy_chr_writer"
    assert evidence["glyph_index_mapping"] == "byte_index_only_no_code_page_claim"
    assert len(raw) == height * (width + 1)


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
