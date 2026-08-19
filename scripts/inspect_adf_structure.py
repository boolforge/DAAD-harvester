#!/usr/bin/env python3
"""Emit bounded, read-only Amiga ADF directory and OFS-chain evidence as JSON."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from daad_harvester.platform_media import extract_adf


BLOCK_SIZE = 512


def word(block: bytes, index: int, *, signed: bool = False) -> int:
    return int.from_bytes(block[index * 4:(index + 1) * 4], "big", signed=signed)


def block(data: bytes, number: int) -> bytes | None:
    start = number * BLOCK_SIZE
    if number <= 0 or start + BLOCK_SIZE > len(data):
        return None
    return data[start:start + BLOCK_SIZE]


def name(header: bytes) -> str:
    offset = 108 * 4
    length = header[offset]
    if length > 30:
        return ""
    return header[offset + 1:offset + 1 + length].decode("latin-1", errors="replace")


def ofs_chain(data: bytes, first: int, byte_size: int) -> dict[str, object]:
    chain: list[int] = []
    payload_bytes = 0
    seen: set[int] = set()
    pointer = first
    while pointer:
        if pointer in seen:
            return {"blocks": chain, "payload_bytes": payload_bytes, "status": "cycle"}
        seen.add(pointer)
        current = block(data, pointer)
        if current is None:
            return {"blocks": chain, "payload_bytes": payload_bytes, "status": "out_of_range"}
        if word(current, 0) != 8:
            return {"blocks": chain, "payload_bytes": payload_bytes, "status": f"non_data_type_{word(current, 0)}"}
        chunk_size = word(current, 3)
        if chunk_size > 488:
            return {"blocks": chain, "payload_bytes": payload_bytes, "status": f"invalid_chunk_size_{chunk_size}"}
        chain.append(pointer)
        payload_bytes += chunk_size
        pointer = word(current, 4)
        if payload_bytes >= byte_size:
            return {"blocks": chain, "payload_bytes": payload_bytes, "status": "complete"}
    return {"blocks": chain, "payload_bytes": payload_bytes, "status": "short_chain"}


def inspect(path: Path) -> dict[str, object]:
    data = path.read_bytes()
    if len(data) < BLOCK_SIZE * 4 or len(data) % BLOCK_SIZE or not data.startswith(b"DOS"):
        raise ValueError("not a complete DOS-formatted ADF image")
    root_number = int.from_bytes(data[8:12], "big") or len(data) // BLOCK_SIZE // 2
    records: list[dict[str, object]] = []
    visited: set[int] = set()

    def walk(number: int, prefix: str, expected_secondary: int) -> None:
        directory = block(data, number)
        if directory is None or word(directory, 0) != 2 or word(directory, 127, signed=True) != expected_secondary:
            records.append({"block": number, "kind": "invalid_directory", "path": prefix})
            return
        for index in range(6, 78):
            entry_number = word(directory, index)
            chain_seen: set[int] = set()
            while entry_number and entry_number not in chain_seen and entry_number not in visited:
                chain_seen.add(entry_number)
                visited.add(entry_number)
                entry = block(data, entry_number)
                if entry is None or word(entry, 0) != 2 or word(entry, 1) != entry_number:
                    records.append({"block": entry_number, "kind": "invalid_header", "path": prefix})
                    break
                entry_name = name(entry)
                entry_path = f"{prefix}/{entry_name}" if prefix and entry_name else entry_name
                secondary = word(entry, 127, signed=True)
                if secondary == -3:
                    byte_size = word(entry, 81)
                    records.append(
                        {
                            "block": entry_number,
                            "kind": "file",
                            "path": entry_path,
                            "size": byte_size,
                            "first_data_block": word(entry, 4),
                            "ofs_chain": ofs_chain(data, word(entry, 4), byte_size),
                        }
                    )
                elif secondary == 2:
                    records.append({"block": entry_number, "kind": "directory", "path": entry_path})
                    walk(entry_number, entry_path, 2)
                else:
                    records.append({"block": entry_number, "kind": f"secondary_{secondary}", "path": entry_path})
                entry_number = word(entry, 124)

    walk(root_number, "", 1)
    return {
        "image": str(path),
        "size": len(data),
        "filesystem": "ffs" if data[3] & 1 else "ofs",
        "root_block": root_number,
        "reachable_records": records,
        "production_extractor_members": [
            {"path": member_path, "size": len(payload)}
            for member_path, payload in extract_adf(data)
        ],
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
