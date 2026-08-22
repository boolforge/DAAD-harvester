"""Deterministic DAAD legacy `.CHR` container generation.

The known runtime contract loads a 2,048-byte character payload from offset
128 of a 2,176-byte file.  ADP's CHR writer additionally emits a bounded,
recognizable header profile.  Other 128-byte prefixes remain explicit bytes
whose unproven field semantics are not promoted.
"""

from __future__ import annotations

import struct
import zlib


CHR_HEADER_SIZE = 128
CHR_GLYPH_COUNT = 256
CHR_BYTES_PER_GLYPH = 8
CHR_PAYLOAD_SIZE = CHR_GLYPH_COUNT * CHR_BYTES_PER_GLYPH
CHR_FILE_SIZE = CHR_HEADER_SIZE + CHR_PAYLOAD_SIZE
ADP_CHR_TAG_OFFSET = 9
ADP_CHR_TAG = b"CHR"
ADP_CHR_WRITER_MARKER_OFFSET = 0x12
ADP_CHR_WRITER_MARKER = 2
ADP_CHR_GLYPH_HEIGHT_OFFSET = 0x41
ADP_CHR_GLYPH_HEIGHT = 8
ADP_CHR_TRAILER_WORD_OFFSET = 0x43
ADP_CHR_TRAILER_WORD = 0x0224


def build_daad_chr(*, header: bytes, glyph_bytes: bytes) -> bytes:
    """Build a deterministic legacy `.CHR` container from explicit byte regions."""

    if not isinstance(header, bytes) or not isinstance(glyph_bytes, bytes):
        raise TypeError("header and glyph_bytes must be bytes")
    if len(header) != CHR_HEADER_SIZE:
        raise ValueError("CHR header must be exactly 128 bytes")
    if len(glyph_bytes) != CHR_PAYLOAD_SIZE:
        raise ValueError("CHR glyph payload must be exactly 2048 bytes")
    return header + glyph_bytes


def build_blank_daad_chr() -> bytes:
    """Build the deterministic all-zero container fixture with no header claim."""

    return build_daad_chr(header=bytes(CHR_HEADER_SIZE), glyph_bytes=bytes(CHR_PAYLOAD_SIZE))


def validate_daad_chr(data: bytes) -> dict[str, object]:
    """Validate a bounded CHR container and any demonstrated ADP header fields."""

    if not isinstance(data, bytes):
        raise TypeError("CHR data must be bytes")
    if len(data) != CHR_FILE_SIZE:
        raise ValueError("CHR file must be exactly 2176 bytes")
    header = data[:CHR_HEADER_SIZE]
    evidence: dict[str, object] = {
        "technical_medium": "daad_legacy_chr",
        "file_size": CHR_FILE_SIZE,
        "header_size": CHR_HEADER_SIZE,
        "glyph_payload_size": CHR_PAYLOAD_SIZE,
        "glyph_count": CHR_GLYPH_COUNT,
        "bytes_per_glyph": CHR_BYTES_PER_GLYPH,
        "header_semantics": "opaque_explicit_bytes_not_promoted",
        "runtime_payload_offset": CHR_HEADER_SIZE,
    }
    adp_writer_profile = (
        header[ADP_CHR_TAG_OFFSET:ADP_CHR_TAG_OFFSET + len(ADP_CHR_TAG)] == ADP_CHR_TAG
        and header[ADP_CHR_WRITER_MARKER_OFFSET] == ADP_CHR_WRITER_MARKER
        and header[ADP_CHR_GLYPH_HEIGHT_OFFSET] == ADP_CHR_GLYPH_HEIGHT
        and int.from_bytes(
            header[ADP_CHR_TRAILER_WORD_OFFSET:ADP_CHR_TRAILER_WORD_OFFSET + 2],
            "little",
        ) == ADP_CHR_TRAILER_WORD
    )
    if adp_writer_profile:
        stem = header[1:9].decode("ascii", errors="replace").rstrip(" ")
        evidence.update(
            {
                "header_profile": "adp_legacy_chr_writer",
                "header_semantics": "adp_writer_fields_structurally_validated",
                "header_filename_stem": stem,
                "header_tag": ADP_CHR_TAG.decode("ascii"),
                "header_writer_marker": ADP_CHR_WRITER_MARKER,
                "glyph_height": ADP_CHR_GLYPH_HEIGHT,
                "header_trailer_word": ADP_CHR_TRAILER_WORD,
                "glyph_geometry": "256 glyphs × 8 rows × 8 bits",
                "glyph_bit_order": "most_significant_bit_leftmost",
            }
        )
    return evidence


def _png_chunk(kind: bytes, payload: bytes) -> bytes:
    """Return one deterministic PNG chunk for a bounded grayscale image."""

    return (
        struct.pack(">I", len(payload))
        + kind
        + payload
        + struct.pack(">I", zlib.crc32(kind + payload) & 0xFFFFFFFF)
    )


def render_adp_chr_glyph_atlas(data: bytes, *, scale: int = 1) -> tuple[bytes, dict[str, object]]:
    """Render the validated ADP-writer glyph payload as a deterministic grayscale PNG atlas.

    The atlas preserves byte-index order only.  It intentionally supplies no character
    labels or code-page semantics because those relationships have not been evidenced.
    """

    if not isinstance(scale, int) or isinstance(scale, bool) or scale < 1:
        raise ValueError("glyph atlas scale must be a positive integer")
    evidence = validate_daad_chr(data)
    if evidence.get("header_profile") != "adp_legacy_chr_writer":
        raise ValueError("glyph atlas requires the validated ADP legacy CHR writer profile")

    glyphs = data[CHR_HEADER_SIZE:]
    columns = 16
    rows = CHR_GLYPH_COUNT // columns
    width = columns * 8 * scale
    height = rows * ADP_CHR_GLYPH_HEIGHT * scale
    pixels = bytearray(width * height)
    for glyph_index in range(CHR_GLYPH_COUNT):
        glyph_x = (glyph_index % columns) * 8 * scale
        glyph_y = (glyph_index // columns) * ADP_CHR_GLYPH_HEIGHT * scale
        glyph_offset = glyph_index * CHR_BYTES_PER_GLYPH
        for row_index, packed_row in enumerate(glyphs[glyph_offset:glyph_offset + CHR_BYTES_PER_GLYPH]):
            for bit_index in range(8):
                value = 0xFF if packed_row & (0x80 >> bit_index) else 0x00
                pixel_x = glyph_x + bit_index * scale
                pixel_y = glyph_y + row_index * scale
                for scale_y in range(scale):
                    row_start = (pixel_y + scale_y) * width + pixel_x
                    pixels[row_start:row_start + scale] = bytes((value,)) * scale

    scanlines = b"".join(
        b"\x00" + bytes(pixels[row * width:(row + 1) * width])
        for row in range(height)
    )
    png = (
        b"\x89PNG\r\n\x1a\n"
        + _png_chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 0, 0, 0, 0))
        + _png_chunk(b"IDAT", zlib.compress(scanlines, level=9))
        + _png_chunk(b"IEND", b"")
    )
    atlas_evidence: dict[str, object] = {
        "derivative_format": "png",
        "decoder_profile": "adp_legacy_chr_writer",
        "glyph_count": CHR_GLYPH_COUNT,
        "glyph_geometry": "256 glyphs × 8 rows × 8 bits",
        "glyph_bit_order": "most_significant_bit_leftmost",
        "atlas_columns": columns,
        "atlas_rows": rows,
        "atlas_scale": scale,
        "width": width,
        "height": height,
        "glyph_index_mapping": "byte_index_only_no_code_page_claim",
    }
    return png, atlas_evidence
