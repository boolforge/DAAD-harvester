#!/usr/bin/env python3
"""Emit bounded CPC DSK geometry and candidate CP/M directory evidence as JSON."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


NAME = re.compile(r"^[A-Z0-9!#$%&'()@^_`{}~-]+$")


def decode_name(raw: bytes) -> str:
    value = bytes(item & 0x7F for item in raw).decode("ascii", errors="ignore").strip(" \x00")
    return value if NAME.fullmatch(value) else ""


def parse_tracks(data: bytes) -> list[dict[str, object]]:
    if len(data) < 0x200 or not data.startswith((b"MV - CPCEMU", b"EXTENDED CPC DSK")):
        raise ValueError("not a complete CPC DSK image")
    tracks, sides = data[0x30], data[0x31]
    extended = data.startswith(b"EXTENDED CPC DSK")
    fixed_track_size = int.from_bytes(data[0x32:0x34], "little")
    size_table = data[0x34:0x34 + tracks * sides] if extended else b""
    position = 0x100
    parsed: list[dict[str, object]] = []
    for index in range(tracks * sides):
        if extended and index >= len(size_table):
            raise ValueError(f"track {index} missing from truncated extended size table")
        track_size = size_table[index] * 256 if extended else fixed_track_size
        if not track_size:
            continue
        if position + track_size > len(data):
            raise ValueError(f"track {index} exceeds image")
        header = data[position:position + 0x100]
        if not header.startswith(b"Track-Info"):
            raise ValueError(f"track {index} has no Track-Info header")
        sector_position = position + 0x100
        sectors: list[dict[str, object]] = []
        for sector_index in range(header[0x15]):
            descriptor = header[0x18 + sector_index * 8:0x20 + sector_index * 8]
            if len(descriptor) != 8:
                raise ValueError(f"track {index} has truncated sector descriptor")
            size = int.from_bytes(descriptor[6:8], "little") or (128 << descriptor[3])
            if sector_position + size > position + track_size:
                raise ValueError(f"track {index} sector {sector_index} exceeds track")
            sectors.append(
                {
                    "id": descriptor[2],
                    "size": size,
                    "data": data[sector_position:sector_position + size],
                }
            )
            sector_position += size
        parsed.append(
            {
                "physical_index": index,
                "cylinder": header[0x10],
                "head": header[0x11],
                "track_size": track_size,
                "sectors": sectors,
            }
        )
        position += track_size
    if position != len(data):
        raise ValueError("trailing bytes after final track")
    return parsed


def directory_entries(window: bytes) -> list[dict[str, object]]:
    entries: list[dict[str, object]] = []
    for offset in range(0, len(window) - 31, 32):
        entry = window[offset:offset + 32]
        user = entry[0]
        if user == 0xE5:
            continue
        name, extension = decode_name(entry[1:9]), decode_name(entry[9:12])
        if user <= 15 and name and entry[15] and any(entry[16:32]):
            entries.append(
                {
                    "user": user,
                    "filename": f"{name}.{extension}" if extension else name,
                    "extent": entry[12] + 32 * (entry[14] & 0x3F),
                    "records": entry[15],
                    "blocks": [block for block in entry[16:32] if block],
                }
            )
    return entries


def inspect(path: Path) -> dict[str, object]:
    data = path.read_bytes()
    tracks = parse_tracks(data)
    stream = b"".join(sector["data"] for track in tracks for sector in track["sectors"])
    candidates: list[dict[str, object]] = []
    for offset in range(0, len(stream) - 2047, 128):
        entries = directory_entries(stream[offset:offset + 2048])
        if entries:
            candidates.append({"stream_offset": offset, "entry_count": len(entries), "entries": entries})
    return {
        "image": str(path),
        "size": len(data),
        "track_count": len(tracks),
        "tracks": [
            {
                key: value
                for key, value in track.items()
                if key != "sectors"
            }
            | {"sector_ids": [sector["id"] for sector in track["sectors"]], "sector_sizes": [sector["size"] for sector in track["sectors"]]}
            for track in tracks
        ],
        "directory_candidates": candidates,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("image", type=Path)
    parser.add_argument("--pretty", action="store_true")
    args = parser.parse_args()
    print(json.dumps(inspect(args.image), indent=2 if args.pretty else None, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
