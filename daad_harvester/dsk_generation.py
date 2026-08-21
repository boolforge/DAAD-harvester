"""Deterministic Extended CPC DSK container writer.

This module writes only the documented Extended DSK container grammar.  It does
not create a CP/M filesystem, infer a platform from a filename, or establish
bootability.  Callers must supply every formatted track, sector descriptor, and
payload explicitly; native inspection and optional extraction are independent
validation steps.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Sequence


EXTENDED_DSK_SIGNATURE = b"EXTENDED CPC DSK File\r\nDisk-Info\r\n"
TRACK_INFO_SIGNATURE = b"Track-Info\r\n"
_DISK_HEADER_SIZE = 0x100
_TRACK_HEADER_SIZE = 0x100
_MAX_TRACK_SIDES = 204


@dataclass(frozen=True)
class ExtendedDskSector:
    """One explicit Extended DSK sector descriptor and exact payload."""

    sector_id: int
    size_code: int
    data: bytes
    fdc_status_1: int = 0
    fdc_status_2: int = 0


@dataclass(frozen=True)
class ExtendedDskTrack:
    """One formatted track/side record in canonical on-disk order."""

    track: int
    side: int
    sectors: tuple[ExtendedDskSector, ...]
    gap_3_length: int = 0x2A
    filler_byte: int = 0xE5


def _require_byte(value: int, name: str) -> None:
    if not isinstance(value, int) or not 0 <= value <= 0xFF:
        raise ValueError(f"{name} must be an unsigned byte")


def _padded_track_size(payload_size: int) -> int:
    raw_size = _TRACK_HEADER_SIZE + payload_size
    return (raw_size + 0xFF) & ~0xFF


def _encode_track(record: ExtendedDskTrack) -> bytes:
    if not record.sectors:
        raise ValueError("a formatted track requires at least one sector")
    if len(record.sectors) > 29:
        raise ValueError("a track cannot encode more than 29 sector descriptors")
    _require_byte(record.track, "track")
    _require_byte(record.side, "side")
    _require_byte(record.gap_3_length, "gap_3_length")
    _require_byte(record.filler_byte, "filler_byte")

    header = bytearray(_TRACK_HEADER_SIZE)
    header[: len(TRACK_INFO_SIGNATURE)] = TRACK_INFO_SIGNATURE
    header[0x10] = record.track
    header[0x11] = record.side
    header[0x14] = record.sectors[0].size_code
    header[0x15] = len(record.sectors)
    header[0x16] = record.gap_3_length
    header[0x17] = record.filler_byte

    payloads: list[bytes] = []
    for index, sector in enumerate(record.sectors):
        _require_byte(sector.sector_id, f"sector {index} ID")
        if not isinstance(sector.size_code, int) or not 0 <= sector.size_code <= 7:
            raise ValueError(f"sector {index} size_code must be in 0..7")
        _require_byte(sector.fdc_status_1, f"sector {index} FDC status 1")
        _require_byte(sector.fdc_status_2, f"sector {index} FDC status 2")
        if not isinstance(sector.data, bytes):
            raise TypeError(f"sector {index} data must be bytes")
        if len(sector.data) > 0xFFFF:
            raise ValueError(f"sector {index} payload exceeds Extended DSK length field")
        descriptor = 0x18 + index * 8
        header[descriptor:descriptor + 8] = bytes(
            (
                record.track,
                record.side,
                sector.sector_id,
                sector.size_code,
                sector.fdc_status_1,
                sector.fdc_status_2,
            )
        ) + len(sector.data).to_bytes(2, "little")
        payloads.append(sector.data)

    encoded = bytes(header) + b"".join(payloads)
    return encoded.ljust(_padded_track_size(sum(map(len, payloads))), b"\x00")


def build_extended_dsk(
    *,
    tracks: int,
    sides: int,
    track_records: Sequence[Optional[ExtendedDskTrack]],
    creator: str = "DAAD-HARVEST",
) -> bytes:
    """Build an Extended DSK image from explicit ordered track/side records.

    ``track_records`` must contain exactly ``tracks * sides`` entries ordered as
    track 0 side 0, track 0 side 1, then ascending tracks. ``None`` represents
    an explicit unformatted track. No filesystem, directory, bootstrap, or
    platform classification is created by this container writer.
    """

    if not isinstance(tracks, int) or not isinstance(sides, int):
        raise TypeError("tracks and sides must be integers")
    total_tracks = tracks * sides
    if not 1 <= tracks <= _MAX_TRACK_SIDES or not 1 <= sides <= _MAX_TRACK_SIDES:
        raise ValueError("tracks and sides must be positive and bounded")
    if total_tracks > _MAX_TRACK_SIDES:
        raise ValueError("track × side geometry exceeds Extended DSK table capacity")
    if len(track_records) != total_tracks:
        raise ValueError("track_records must contain exactly tracks × sides entries")
    try:
        creator_bytes = creator.encode("ascii")
    except UnicodeEncodeError as error:
        raise ValueError("creator must be ASCII") from error
    if len(creator_bytes) > 14:
        raise ValueError("creator must fit the 14-byte Extended DSK creator field")

    encoded_tracks: list[bytes] = []
    track_sizes: list[int] = []
    for index, record in enumerate(track_records):
        expected_track, expected_side = divmod(index, sides)
        if record is None:
            encoded_tracks.append(b"")
            track_sizes.append(0)
            continue
        if (record.track, record.side) != (expected_track, expected_side):
            raise ValueError(
                "track record order must be canonical "
                f"(expected track {expected_track} side {expected_side})"
            )
        encoded = _encode_track(record)
        units = len(encoded) // 0x100
        if not 1 <= units <= 0xFF:
            raise ValueError("encoded track length is outside Extended DSK table range")
        encoded_tracks.append(encoded)
        track_sizes.append(units)

    header = bytearray(_DISK_HEADER_SIZE)
    header[: len(EXTENDED_DSK_SIGNATURE)] = EXTENDED_DSK_SIGNATURE
    header[0x22:0x22 + len(creator_bytes)] = creator_bytes
    header[0x30] = tracks
    header[0x31] = sides
    header[0x34:0x34 + total_tracks] = bytes(track_sizes)
    return bytes(header) + b"".join(encoded_tracks)


def build_blank_cpc_system_dsk(*, creator: str = "DAAD-HARVEST") -> bytes:
    """Build a deterministic blank 40-track CPC-system DSK container.

    It has conventional system-sector identifiers and filler payloads but does
    not contain a populated CP/M directory or a bootable game.
    """

    records = tuple(
        ExtendedDskTrack(
            track=track,
            side=0,
            sectors=tuple(
                ExtendedDskSector(sector_id=0x41 + offset, size_code=2, data=b"\xE5" * 512)
                for offset in range(9)
            ),
        )
        for track in range(40)
    )
    return build_extended_dsk(tracks=40, sides=1, track_records=records, creator=creator)
