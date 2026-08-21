"""Deterministic bounded Amiga ADF/OFS fixture generation.

The initial writer creates only a standard double-density, empty DOS0/OFS
filesystem image. It does not emulate magnetic-track timing, install boot code,
create files/directories, or claim a runnable historical release. Every value
that would otherwise depend on a host, clock, or locale is an explicit input.
"""

from __future__ import annotations

from dataclasses import dataclass


ADF_BLOCK_SIZE = 512
ADF_DD_BLOCK_COUNT = 1760
ADF_DD_BYTE_LENGTH = ADF_BLOCK_SIZE * ADF_DD_BLOCK_COUNT
ADF_ROOT_BLOCK = ADF_DD_BLOCK_COUNT // 2
ADF_BITMAP_BLOCK = ADF_ROOT_BLOCK + 1
ADF_BOOT_BLOCK_SIZE = ADF_BLOCK_SIZE * 2

_ROOT_CHECKSUM_OFFSET = 20
_ROOT_HASH_TABLE_OFFSET = 24
_ROOT_HASH_TABLE_ENTRIES = 72
_ROOT_BITMAP_FLAG_OFFSET = 78 * 4
_ROOT_BITMAP_PAGE_OFFSET = 79 * 4
_ROOT_NAME_LENGTH_OFFSET = 108 * 4
_ROOT_NAME_OFFSET = _ROOT_NAME_LENGTH_OFFSET + 1
_ROOT_ACCESS_DATE_OFFSET = 118 * 4
_ROOT_CREATION_DATE_OFFSET = 121 * 4
_ROOT_SECONDARY_TYPE_OFFSET = 127 * 4


@dataclass(frozen=True)
class AmigaTimestamp:
    """Explicit Amiga filesystem timestamp tuple without host-clock conversion."""

    days: int = 0
    minutes: int = 0
    ticks: int = 0


def _require_u32(value: int, name: str) -> None:
    if not isinstance(value, int) or not 0 <= value <= 0xFFFFFFFF:
        raise ValueError(f"{name} must be an unsigned 32-bit integer")


def _write_u32(buffer: bytearray, offset: int, value: int) -> None:
    _require_u32(value, f"32-bit field at {offset}")
    buffer[offset:offset + 4] = value.to_bytes(4, "big")


def _read_u32(buffer: bytes, offset: int) -> int:
    return int.from_bytes(buffer[offset:offset + 4], "big")


def adf_normal_checksum(block: bytes, checksum_offset: int) -> int:
    """Return the big-endian two's-complement metadata checksum value."""

    if len(block) % 4 or not 0 <= checksum_offset <= len(block) - 4 or checksum_offset % 4:
        raise ValueError("checksum field must be a 32-bit aligned field in a word-aligned block")
    total = 0
    for offset in range(0, len(block), 4):
        value = 0 if offset == checksum_offset else _read_u32(block, offset)
        total = (total + value) & 0xFFFFFFFF
    return (-total) & 0xFFFFFFFF


def adf_boot_checksum(block: bytes, checksum_offset: int = 4) -> int:
    """Return the Amiga boot-block end-around-carry one's-complement checksum."""

    if len(block) % 4 or not 0 <= checksum_offset <= len(block) - 4 or checksum_offset % 4:
        raise ValueError("boot checksum field must be 32-bit aligned")
    total = 0
    for offset in range(0, len(block), 4):
        value = 0 if offset == checksum_offset else _read_u32(block, offset)
        previous = total
        total = (total + value) & 0xFFFFFFFF
        if total < previous:
            total = (total + 1) & 0xFFFFFFFF
    return (~total) & 0xFFFFFFFF


def _encoded_volume_name(volume_name: str) -> bytes:
    if not isinstance(volume_name, str):
        raise TypeError("volume_name must be text")
    try:
        encoded = volume_name.encode("latin-1")
    except UnicodeEncodeError as error:
        raise ValueError("volume_name must be Latin-1 encodable") from error
    if not 1 <= len(encoded) <= 30:
        raise ValueError("volume_name must encode to 1 through 30 bytes")
    if any(byte < 0x20 for byte in encoded):
        raise ValueError("volume_name cannot contain control bytes")
    return encoded


def _validate_timestamp(timestamp: AmigaTimestamp) -> None:
    if not isinstance(timestamp, AmigaTimestamp):
        raise TypeError("timestamp must be an AmigaTimestamp")
    _require_u32(timestamp.days, "timestamp.days")
    _require_u32(timestamp.minutes, "timestamp.minutes")
    _require_u32(timestamp.ticks, "timestamp.ticks")


def _write_bitmap(image: bytearray) -> None:
    """Initialize the first bitmap page with root/bitmap allocation marked used."""

    bitmap = bytearray(b"\xff" * ADF_BLOCK_SIZE)
    _write_u32(bitmap, 0, 0)
    for block_number in (ADF_ROOT_BLOCK, ADF_BITMAP_BLOCK):
        map_index = block_number - 2
        word_offset = 4 + (map_index // 32) * 4
        current = _read_u32(bitmap, word_offset)
        _write_u32(bitmap, word_offset, current & ~(1 << (map_index % 32)))
    _write_u32(bitmap, 0, adf_normal_checksum(bitmap, 0))
    start = ADF_BITMAP_BLOCK * ADF_BLOCK_SIZE
    image[start:start + ADF_BLOCK_SIZE] = bitmap


def build_blank_adf_ofs(
    *,
    volume_name: str = "EMPTY",
    timestamp: AmigaTimestamp = AmigaTimestamp(),
) -> bytes:
    """Build a deterministic empty standard-DD DOS0/OFS ADF fixture.

    The result includes a boot area, root block, and allocation bitmap. It has
    no boot code, files, directories, or game/runtime identity.
    """

    name = _encoded_volume_name(volume_name)
    _validate_timestamp(timestamp)
    image = bytearray(ADF_DD_BYTE_LENGTH)

    boot = bytearray(ADF_BOOT_BLOCK_SIZE)
    boot[:4] = b"DOS\x00"
    _write_u32(boot, 8, ADF_ROOT_BLOCK)
    _write_u32(boot, 4, adf_boot_checksum(boot))
    image[:ADF_BOOT_BLOCK_SIZE] = boot

    root = bytearray(ADF_BLOCK_SIZE)
    _write_u32(root, 0, 2)
    _write_u32(root, 12, _ROOT_HASH_TABLE_ENTRIES)
    _write_u32(root, _ROOT_BITMAP_FLAG_OFFSET, 0xFFFFFFFF)
    _write_u32(root, _ROOT_BITMAP_PAGE_OFFSET, ADF_BITMAP_BLOCK)
    root[_ROOT_NAME_LENGTH_OFFSET] = len(name)
    root[_ROOT_NAME_OFFSET:_ROOT_NAME_OFFSET + len(name)] = name
    for offset in (_ROOT_ACCESS_DATE_OFFSET, _ROOT_CREATION_DATE_OFFSET):
        _write_u32(root, offset, timestamp.days)
        _write_u32(root, offset + 4, timestamp.minutes)
        _write_u32(root, offset + 8, timestamp.ticks)
    _write_u32(root, _ROOT_SECONDARY_TYPE_OFFSET, 1)
    _write_u32(root, _ROOT_CHECKSUM_OFFSET, adf_normal_checksum(root, _ROOT_CHECKSUM_OFFSET))
    root_start = ADF_ROOT_BLOCK * ADF_BLOCK_SIZE
    image[root_start:root_start + ADF_BLOCK_SIZE] = root
    _write_bitmap(image)
    return bytes(image)


def validate_blank_adf_ofs(
    data: bytes,
    *,
    volume_name: str = "EMPTY",
    timestamp: AmigaTimestamp = AmigaTimestamp(),
) -> dict[str, object]:
    """Strictly validate the exact bounded blank ADF/OFS fixture profile."""

    expected_name = _encoded_volume_name(volume_name)
    _validate_timestamp(timestamp)
    if not isinstance(data, bytes):
        raise TypeError("ADF data must be bytes")
    if len(data) != ADF_DD_BYTE_LENGTH:
        raise ValueError("fixture must use standard double-density ADF length")
    boot = data[:ADF_BOOT_BLOCK_SIZE]
    if boot[:4] != b"DOS\x00":
        raise ValueError("fixture must declare DOS0/OFS")
    if _read_u32(boot, 8) != ADF_ROOT_BLOCK:
        raise ValueError("boot root pointer does not match standard-DD root block")
    if _read_u32(boot, 4) != adf_boot_checksum(boot):
        raise ValueError("boot checksum does not validate")
    if any(boot[12:]):
        raise ValueError("bounded blank fixture must not contain boot code")

    root_start = ADF_ROOT_BLOCK * ADF_BLOCK_SIZE
    root = data[root_start:root_start + ADF_BLOCK_SIZE]
    if _read_u32(root, 0) != 2 or _read_u32(root, _ROOT_SECONDARY_TYPE_OFFSET) != 1:
        raise ValueError("root block type or secondary type is invalid")
    if _read_u32(root, 12) != _ROOT_HASH_TABLE_ENTRIES:
        raise ValueError("root hash-table size is invalid")
    if _read_u32(root, _ROOT_CHECKSUM_OFFSET) != adf_normal_checksum(root, _ROOT_CHECKSUM_OFFSET):
        raise ValueError("root checksum does not validate")
    if any(root[_ROOT_HASH_TABLE_OFFSET:_ROOT_BITMAP_FLAG_OFFSET]):
        raise ValueError("bounded blank fixture must not contain root hash entries")
    if _read_u32(root, _ROOT_BITMAP_FLAG_OFFSET) != 0xFFFFFFFF:
        raise ValueError("root bitmap flag is invalid")
    if _read_u32(root, _ROOT_BITMAP_PAGE_OFFSET) != ADF_BITMAP_BLOCK:
        raise ValueError("root bitmap page is invalid")
    if root[_ROOT_NAME_LENGTH_OFFSET] != len(expected_name) or root[
        _ROOT_NAME_OFFSET:_ROOT_NAME_OFFSET + len(expected_name)
    ] != expected_name:
        raise ValueError("root volume name is invalid")
    for offset in (_ROOT_ACCESS_DATE_OFFSET, _ROOT_CREATION_DATE_OFFSET):
        actual = tuple(_read_u32(root, offset + index * 4) for index in range(3))
        expected = (timestamp.days, timestamp.minutes, timestamp.ticks)
        if actual != expected:
            raise ValueError("root timestamp is invalid")

    bitmap_start = ADF_BITMAP_BLOCK * ADF_BLOCK_SIZE
    bitmap = data[bitmap_start:bitmap_start + ADF_BLOCK_SIZE]
    if _read_u32(bitmap, 0) != adf_normal_checksum(bitmap, 0):
        raise ValueError("bitmap checksum does not validate")
    for block_number in (ADF_ROOT_BLOCK, ADF_BITMAP_BLOCK):
        map_index = block_number - 2
        word = _read_u32(bitmap, 4 + (map_index // 32) * 4)
        if word & (1 << (map_index % 32)):
            raise ValueError("allocated root/bitmap block is marked free")
    return {
        "adf_variant": "ofs_dd_blank",
        "block_size": ADF_BLOCK_SIZE,
        "blocks": ADF_DD_BLOCK_COUNT,
        "root_block": ADF_ROOT_BLOCK,
        "bitmap_block": ADF_BITMAP_BLOCK,
        "volume_name": volume_name,
        "timestamp": {
            "days": timestamp.days,
            "minutes": timestamp.minutes,
            "ticks": timestamp.ticks,
        },
        "filesystem_claim": "empty_ofs_filesystem_no_members",
    }
