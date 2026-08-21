"""Deterministic DRC-compatible DDB fixture builders for structural tests.

The byte layout follows the public DRC `drb.php` header/process-table writer.
Fixtures intentionally model database structure, not a made-up DAAD signature.
"""

from __future__ import annotations

from daad_harvester.daad_parser import (
    HEADER_SIZE,
    LEGACY_HEADER_SIZE,
    LEGACY_V1_HEADER_SIZE,
    MACHINE_IDS,
)


PLATFORM_MACHINE_IDS = {
    "dos": 0x0,
    "zx": 0x1,
    "c64": 0x2,
    "cpc": 0x3,
    "msx": 0x4,
    "atarist": 0x5,
    "amiga": 0x6,
    "pcw": 0x7,
    "plus4": 0xE,
}


def _write_word(data: bytearray, offset: int, value: int, endianness: str) -> None:
    data[offset:offset + 2] = value.to_bytes(2, endianness)


def make_ddb(platform: str, *, major: int = 2, spanish: bool = False) -> bytes:
    """Return a minimal structurally valid DRC-compatible DDB for one target."""

    machine_id = PLATFORM_MACHINE_IDS[platform]
    _, base_address, endianness = MACHINE_IDS[machine_id]
    size = 256
    data = bytearray(size)
    data[0] = major
    data[1] = (machine_id << 4) | int(spanish)
    data[2] = 95
    data[3:8] = bytes((1, 1, 1, 1, 1))

    # Header pointer order from DRC drb.php: compressed text, process list,
    # object/location/message/system-message/connections/vocabulary/state/name/
    # attributes/extra, then spare/file length.
    relative_pointers = (0, 240, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208)
    for index, value in enumerate(relative_pointers):
        _write_word(data, 8 + (index * 2), 0 if value == 0 else base_address + value, endianness)
    _write_word(data, 8 + (12 * 2), base_address + size, endianness)

    # Condact stream: non-empty and terminated by DAAD's end-of-entry marker.
    data[HEADER_SIZE:HEADER_SIZE + 3] = b"\x01\x00\xff"
    # One verb/noun/condact-address entry followed by DRC's zero process-end mark.
    data[220:224] = bytes((1, 1)) + (base_address + HEADER_SIZE).to_bytes(2, endianness)
    data[224] = 0
    # Final process pointer table, one pointer because process_count is 1.
    _write_word(data, 240, base_address + 220, endianness)
    return bytes(data)


def make_legacy_ddb(platform: str, *, major: int = 2, spanish: bool = False) -> bytes:
    """Return a compact V1/V2 DDB matching the MSX2DAAD interpreter header.

    The historical header has file-relative offsets and a literal 0x5F control
    marker. The fixture includes an in-bounds token stream, vocabulary pointer,
    process table, entry, and 0xFF-terminated condact stream.
    """

    machine_id = PLATFORM_MACHINE_IDS[platform]
    _, _, modern_endianness = MACHINE_IDS[machine_id]
    endianness = "big" if platform in {"atarist", "amiga"} else "little"
    size = 96
    data = bytearray(size)
    data[0] = major
    data[1] = (machine_id << 4) | int(spanish)
    data[2] = 0x5F
    data[3:8] = bytes((1, 1, 1, 1, 1))
    assert modern_endianness in {"big", "little"}

    # V1 has eleven section pointers and file length at $001E; V2 adds the
    # extra-object-attributes pointer and moves file length to $0020.
    header_size = LEGACY_V1_HEADER_SIZE if major == 1 else LEGACY_HEADER_SIZE
    pointers = [header_size, 72, 0, 0, 0, 0, 0, 40, 0, 0, 0]
    if major != 1:
        pointers.append(0)
    for index, value in enumerate(pointers):
        _write_word(data, 8 + (index * 2), value, endianness)
    _write_word(data, 8 + (len(pointers) * 2), size, endianness)
    data[header_size] = 0x80  # minimal compressed-token terminator
    data[40] = 0x80  # bounded vocabulary placeholder
    data[56:60] = bytes((1, 1)) + (64).to_bytes(2, endianness)
    data[60] = 0  # end of process-entry list
    # DONE has no operands, so the following 0xFF is an actual end-of-entry
    # marker rather than a byte accidentally consumed as an operand.
    data[64:66] = b"\x16\xff"
    _write_word(data, 72, 56, endianness)
    return bytes(data)


def wrap_commodore(ddb: bytes, platform: str) -> bytes:
    """Add DRC's two-byte C64/Plus4 PRG load address wrapper."""

    machine_id = PLATFORM_MACHINE_IDS[platform]
    _, base_address, _ = MACHINE_IDS[machine_id]
    return base_address.to_bytes(2, "little") + ddb


def wrap_plus3dos(ddb: bytes) -> bytes:
    """Add a checksummed +3DOS wrapper equivalent to DRC's `-3h` writer."""

    total_size = len(ddb) + 128
    header = bytearray(128)
    header[:8] = b"PLUS3DOS"
    header[8] = 0x1A
    header[9] = 1
    header[10] = 0
    header[11:15] = total_size.to_bytes(4, "little")
    header[15] = 3
    header[16:18] = len(ddb).to_bytes(2, "little")
    header[18:20] = (0x8400).to_bytes(2, "little")
    header[127] = sum(header[:127]) & 0xFF
    return bytes(header) + ddb
