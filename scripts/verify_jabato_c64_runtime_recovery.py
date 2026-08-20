#!/usr/bin/env python3
"""Verify original Jabato C64 DDB recovery from retained runtime RAM evidence.

This command performs a native structural parse and byte comparison against
committed RAM captures. It intentionally does not invoke VICE: the retained
captures are immutable acquisition inputs, while this script is the primary
repository-local regeneration and verification path for the recovered DDBs.
"""

from __future__ import annotations

import hashlib
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.daad_parser import DAADParser  # noqa: E402


CASES = (
    {
        "side": "A / Part 1",
        "ram": ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_side_a_tap_credits.ram",
        "ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_a_tap_second_space_part1.ddb",
        "expected_sha256": "7ffbee6ca3e614011b30261a74022d199ee3345843a0525e92dc9cb5b7bdb5e6",
        "expected_size": 24899,
    },
    {
        "side": "B / Part 2",
        "ram": ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_side_b_tap_post_input_12.ram",
        "ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_b_tap_post_input_12_part2.ddb",
        "expected_sha256": "ee3b41f61fc01c27ad776e271f313a2e3fc88875cc9c8e0debebe6904fa48e69",
        "expected_size": 24680,
    },
)


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def main() -> int:
    parser = DAADParser()
    for case in CASES:
        ram = case["ram"]
        ddb = case["ddb"]
        assert isinstance(ram, Path) and isinstance(ddb, Path)
        if len(ram.read_bytes()) != 65536:
            raise AssertionError(f"{case['side']}: retained RAM must be exactly 64 KiB")
        offset = 0x3880
        expected_size = int(case["expected_size"])
        recovered = ram.read_bytes()[offset:offset + expected_size]
        if len(recovered) != expected_size:
            raise AssertionError(f"{case['side']}: RAM range is truncated")
        analysis = parser.parse_ddb(recovered, ddb.name)
        if not analysis["is_daad"] or analysis["platform"] != "c64" or analysis["ddb_major_version"] != 1:
            raise AssertionError(f"{case['side']}: native DDB validation failed: {analysis['reason']}")
        if _sha256(recovered) != case["expected_sha256"]:
            raise AssertionError(f"{case['side']}: recovered RAM range hash differs")
        if recovered != ddb.read_bytes():
            raise AssertionError(f"{case['side']}: committed DDB differs from recovered RAM range")
        print(f"Side {case['side']}: native runtime DDB recovery verified")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
