"""Deterministic DAAD legacy `.CHR` container generation.

The known runtime contract loads a 2,048-byte character payload from offset
128 of a 2,176-byte file. The 128-byte prefix is retained as explicit opaque
container metadata because its full field semantics are not yet promoted.
"""

from __future__ import annotations


CHR_HEADER_SIZE = 128
CHR_GLYPH_COUNT = 256
CHR_BYTES_PER_GLYPH = 8
CHR_PAYLOAD_SIZE = CHR_GLYPH_COUNT * CHR_BYTES_PER_GLYPH
CHR_FILE_SIZE = CHR_HEADER_SIZE + CHR_PAYLOAD_SIZE


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
    """Validate the bounded outer container and glyph payload partition only."""

    if not isinstance(data, bytes):
        raise TypeError("CHR data must be bytes")
    if len(data) != CHR_FILE_SIZE:
        raise ValueError("CHR file must be exactly 2176 bytes")
    return {
        "technical_medium": "daad_legacy_chr",
        "file_size": CHR_FILE_SIZE,
        "header_size": CHR_HEADER_SIZE,
        "glyph_payload_size": CHR_PAYLOAD_SIZE,
        "glyph_count": CHR_GLYPH_COUNT,
        "bytes_per_glyph": CHR_BYTES_PER_GLYPH,
        "header_semantics": "opaque_explicit_bytes_not_promoted",
        "runtime_payload_offset": CHR_HEADER_SIZE,
    }
