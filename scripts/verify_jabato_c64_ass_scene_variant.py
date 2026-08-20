#!/usr/bin/env python3
"""Verify the retained ASS Jabato C64 scene variant without live emulation.

The committed RAM captures were acquired from bounded scene-member executions.
This primary verifier uses only retained PRGs, RAM images, materialized DDBs,
and the native DAAD parser to prove the comparison result without VICE or ADP.
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
        "part": "Part 1",
        "member": ROOT / "preservation_corpus/extracted/depth1_a05bba25_JABATO P.1",
        "member_sha256": "528d6b6f9c47153f6a7b64316a2b9c46f90020089de3212fe7568a7e31914af0",
        "ram": ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_c64_ass_part1_mirar.ram",
        "scene_ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_ass_part1_post_mirar.ddb",
        "original_ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_a_tap_second_space_part1.ddb",
        "expected_sha256": "7ffbee6ca3e614011b30261a74022d199ee3345843a0525e92dc9cb5b7bdb5e6",
        "expected_size": 24899,
    },
    {
        "part": "Part 2",
        "member": ROOT / "preservation_corpus/extracted/depth1_20a1cd01_JABATO P.2",
        "member_sha256": "65e8e2b2358caecf302a367374d87993c685bb76b894e11da51e8aa7a0eba6c7",
        "ram": ROOT / "preservation_corpus/derived/commodore_loader/vice/jabato_c64_ass_part2_mirar.ram",
        "scene_ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_ass_part2_post_mirar.ddb",
        "original_ddb": ROOT / "preservation_corpus/derived/commodore_loader/jabato_side_b_tap_post_input_12_part2.ddb",
        "expected_sha256": "ee3b41f61fc01c27ad776e271f313a2e3fc88875cc9c8e0debebe6904fa48e69",
        "expected_size": 24680,
    },
)


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def main() -> int:
    parser = DAADParser()
    for case in CASES:
        member = case["member"]
        ram = case["ram"]
        scene_ddb = case["scene_ddb"]
        original_ddb = case["original_ddb"]
        assert all(isinstance(path, Path) for path in (member, ram, scene_ddb, original_ddb))
        if _sha256(member.read_bytes()) != case["member_sha256"]:
            raise AssertionError(f"ASS {case['part']}: retained scene member hash differs")
        ram_bytes = ram.read_bytes()
        if len(ram_bytes) != 65536:
            raise AssertionError(f"ASS {case['part']}: retained RAM must be exactly 64 KiB")
        expected_size = int(case["expected_size"])
        recovered = ram_bytes[0x3880:0x3880 + expected_size]
        if _sha256(recovered) != case["expected_sha256"]:
            raise AssertionError(f"ASS {case['part']}: recovered $3880 range hash differs")
        analysis = parser.parse_ddb(recovered, scene_ddb.name)
        if not analysis["is_daad"] or analysis["platform"] != "c64" or analysis["ddb_major_version"] != 1:
            raise AssertionError(f"ASS {case['part']}: native DDB validation failed: {analysis['reason']}")
        if recovered != scene_ddb.read_bytes() or recovered != original_ddb.read_bytes():
            raise AssertionError(f"ASS {case['part']}: scene/original DDB bytes differ")
        print(f"ASS {case['part']}: scene member runtime DDB is byte-identical to original")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
