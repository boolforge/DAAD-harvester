#!/usr/bin/env python3
"""Extract a named machine RAM module from a VICE snapshot deterministically.

The VICE snapshot header and module framing are documented by the VICE manual.
For the C64, the C64MEM payload begins with four memory-configuration bytes
followed by the exact 64 KiB RAM image. This tool emits that RAM byte range
without attempting to interpret or normalize it.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


MAGIC = b"VICE Snapshot File\x1a"
HEADER_SIZE = 58
MODULE_HEADER_SIZE = 22
MODULE_RAM_LAYOUTS = {"C64MEM": (4, 65536)}


def _u32le(data: bytes) -> int:
    return int.from_bytes(data, "little")


def parse_modules(snapshot: bytes) -> list[tuple[str, int, int, bytes]]:
    """Return `(name, major, minor, payload)` tuples from a VICE snapshot."""
    if len(snapshot) < HEADER_SIZE or not snapshot.startswith(MAGIC):
        raise ValueError("not a complete VICE snapshot")
    modules: list[tuple[str, int, int, bytes]] = []
    offset = HEADER_SIZE
    while offset < len(snapshot):
        if len(snapshot) - offset < MODULE_HEADER_SIZE:
            raise ValueError(f"truncated VICE module header at offset {offset}")
        name_bytes = snapshot[offset:offset + 16]
        name = name_bytes.split(b"\0", 1)[0].decode("ascii", "replace")
        major = snapshot[offset + 16]
        minor = snapshot[offset + 17]
        size = _u32le(snapshot[offset + 18:offset + 22])
        if size < MODULE_HEADER_SIZE or offset + size > len(snapshot):
            raise ValueError(f"invalid VICE module size {size} for {name!r} at offset {offset}")
        modules.append((name, major, minor, snapshot[offset + MODULE_HEADER_SIZE:offset + size]))
        offset += size
    return modules


def extract_ram(snapshot: bytes, module_name: str = "C64MEM") -> tuple[bytes, dict[str, object]]:
    """Extract a raw RAM range and reproducibility metadata from `module_name`."""
    layout = MODULE_RAM_LAYOUTS.get(module_name)
    if layout is None:
        raise ValueError(f"unsupported RAM module {module_name!r}")
    config_size, ram_size = layout
    modules = parse_modules(snapshot)
    for name, major, minor, payload in modules:
        if name != module_name:
            continue
        if len(payload) < config_size + ram_size:
            raise ValueError(f"{module_name} payload is too short: {len(payload)} bytes")
        ram = payload[config_size:config_size + ram_size]
        return ram, {
            "module": name,
            "module_version": {"major": major, "minor": minor},
            "configuration_bytes_hex": payload[:config_size].hex(),
            "ram_offset_in_module": config_size,
            "ram_size": len(ram),
            "modules": [
                {"name": mod_name, "major": mod_major, "minor": mod_minor, "payload_size": len(mod_payload)}
                for mod_name, mod_major, mod_minor, mod_payload in modules
            ],
        }
    raise ValueError(f"snapshot has no {module_name} module")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("snapshot", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--metadata", type=Path, required=True)
    args = parser.parse_args()

    snapshot = args.snapshot.read_bytes()
    ram, metadata = extract_ram(snapshot)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(ram)
    metadata.update(
        {
            "schema_version": 1,
            "snapshot_path": str(args.snapshot),
            "snapshot_sha256": hashlib.sha256(snapshot).hexdigest(),
            "output_path": str(args.output),
            "output_sha256": hashlib.sha256(ram).hexdigest(),
        }
    )
    args.metadata.parent.mkdir(parents=True, exist_ok=True)
    args.metadata.write_text(json.dumps(metadata, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
