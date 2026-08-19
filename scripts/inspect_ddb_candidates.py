#!/usr/bin/env python3
"""Report structural DDB-header candidates in one or more retained artifact files."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from daad_harvester.daad_parser import DAADParser, MACHINE_IDS


def inspect(path: Path) -> dict[str, object]:
    data = path.read_bytes()
    parser = DAADParser()
    candidates: list[dict[str, object]] = []
    upper = max(0, len(data) - 34)
    for offset in range(upper + 1):
        major = data[offset]
        if major not in {1, 2, 3} or (data[offset + 1] >> 4) not in MACHINE_IDS:
            continue
        legacy_marker = data[offset + 2] == 0x5F
        mode = "legacy" if legacy_marker else "modern_or_other"
        analysis = parser.parse_ddb(data[offset:], f"embedded_{path.name}.ddb")
        candidates.append(
            {
                "offset": offset,
                "major_byte": major,
                "machine_language_byte": data[offset + 1],
                "legacy_marker": legacy_marker,
                "mode": mode,
                "validated": bool(analysis["is_daad"]),
                "reason": analysis["reason"],
            }
        )
    embedded = parser.find_embedded_ddb(data)
    direct = parser.parse_ddb(data, path.name)
    return {
        "path": str(path),
        "size": len(data),
        "direct": {key: direct[key] for key in ("is_daad", "reason", "ddb_format", "platform", "version")},
        "embedded": None if embedded is None else {"offset": embedded[0], "size": len(embedded[1])},
        "candidate_count": len(candidates),
        "candidates": candidates,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="+", type=Path)
    args = parser.parse_args()
    print(json.dumps([inspect(path) for path in args.paths], indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
