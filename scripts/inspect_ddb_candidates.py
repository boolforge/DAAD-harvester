#!/usr/bin/env python3
"""Report structural DDB-header candidates in one or more retained artifact files."""

from __future__ import annotations

import argparse
from dataclasses import asdict
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
        wrapper = {"format": "embedded_candidate"}
        validated = parser._validate_at(data, offset, wrapper, allow_trailing=True)
        if validated is None:
            validated = parser._validate_at(
                data, offset, wrapper, allow_trailing=True, legacy=True
            )
        analysis = parser.parse_ddb(data[offset:], f"embedded_{path.name}.ddb")
        candidate: dict[str, object] = {
            "offset": offset,
            "major_byte": major,
            "machine_language_byte": data[offset + 1],
            "legacy_marker": legacy_marker,
            "mode": mode,
            "validated": validated is not None,
            "reason": (
                f"verified_structural_{validated['header'].layout}_ddb"
                if validated is not None
                else analysis["reason"]
            ),
        }
        if validated is not None:
            header = validated["header"]
            candidate["ddb_format"] = (
                f"daad-v{header.major_version}"
                if header.layout == "drc"
                else f"daad-v{header.major_version}-legacy"
            )
            candidate["platform"] = header.platform
            candidate["payload_size"] = validated["payload_size"]
        if legacy_marker:
            header = parser._parse_legacy_header(data, offset)
            if header is not None:
                candidate["legacy_header"] = asdict(header)
                candidate["legacy_available_size"] = len(data) - offset
                candidate["legacy_expected_size"] = header.expected_size
                candidate["legacy_pointer_offsets"] = [
                    parser._pointer_index(pointer, header) for pointer in header.pointers
                ]
        candidates.append(candidate)
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
