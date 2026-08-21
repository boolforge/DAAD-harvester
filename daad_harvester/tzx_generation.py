"""Deterministic TZX/CDT standard-speed block generation.

The initial writer only serializes explicit standard-speed data records. It
does not create Spectrum/CPC headers, flags, checksums, pulse traces, turbo
records, custom-loader blocks, or execution claims; supplied payload bytes are
preserved exactly as the caller provides them.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Sequence

from daad_harvester.platform_media import parse_tzx_blocks


TZX_HEADER = b"ZXTape!\x1a\x01\x14"
TZX_STANDARD_DATA_BLOCK_ID = 0x10


@dataclass(frozen=True)
class TzxStandardDataBlock:
    """One explicit TZX standard-speed data record without inferred semantics."""

    data: bytes
    pause_ms: int = 1000


def _validate_block(block: TzxStandardDataBlock) -> None:
    if not isinstance(block, TzxStandardDataBlock):
        raise TypeError("every block must be a TzxStandardDataBlock")
    if not isinstance(block.data, bytes):
        raise TypeError("standard data must be bytes")
    if not 1 <= len(block.data) <= 0xFFFF:
        raise ValueError("standard data must contain 1 through 65535 bytes")
    if not isinstance(block.pause_ms, int) or not 0 <= block.pause_ms <= 0xFFFF:
        raise ValueError("pause_ms must be an unsigned 16-bit integer")


def build_tzx_standard_data(blocks: Sequence[TzxStandardDataBlock]) -> bytes:
    """Build deterministic TZX v1.20 bytes from explicit standard data blocks."""

    if not isinstance(blocks, Sequence) or isinstance(blocks, (bytes, bytearray, str)):
        raise TypeError("blocks must be a sequence of TzxStandardDataBlock values")
    if not blocks:
        raise ValueError("at least one standard data block is required")
    output = bytearray(TZX_HEADER)
    for block in blocks:
        _validate_block(block)
        output.append(TZX_STANDARD_DATA_BLOCK_ID)
        output += block.pause_ms.to_bytes(2, "little")
        output += len(block.data).to_bytes(2, "little")
        output += block.data
    return bytes(output)


def validate_tzx_standard_data(data: bytes) -> dict[str, object]:
    """Validate the exact first-wave TZX generation profile using the parser."""

    if not isinstance(data, bytes):
        raise TypeError("TZX data must be bytes")
    if not data.startswith(TZX_HEADER):
        raise ValueError("fixture must use the exact TZX v1.20 header")
    parsed = parse_tzx_blocks(data)
    if not parsed:
        raise ValueError("fixture must contain complete supported TZX blocks")
    pauses: list[int] = []
    lengths: list[int] = []
    for block in parsed:
        if block.block_id != TZX_STANDARD_DATA_BLOCK_ID or block.kind != "standard_data" or block.data is None:
            raise ValueError("fixture contains a nonstandard data block")
        if len(block.body) < 5:
            raise ValueError("standard data body is truncated")
        pause = int.from_bytes(block.body[:2], "little")
        declared_length = int.from_bytes(block.body[2:4], "little")
        if declared_length != len(block.data) or declared_length == 0:
            raise ValueError("standard data length does not match payload")
        pauses.append(pause)
        lengths.append(declared_length)
    return {
        "tape_variant": "tzx_v1_20_standard_data",
        "version": {"major": 1, "minor": 20},
        "block_count": len(parsed),
        "block_kinds": [block.kind for block in parsed],
        "pause_ms": pauses,
        "data_lengths": lengths,
        "semantic_claim": "explicit_standard_data_bytes_no_loader_or_runtime_claim",
    }
