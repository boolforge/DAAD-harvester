#!/usr/bin/env python3
"""Retain and manifest reproducible verification logs for the pinned ADP revision."""

from __future__ import annotations

import hashlib
import json
import shutil
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE_LOG = Path("/tmp/adp-build-test.log")
DESTINATION = ROOT / "reverse_engineering" / "public_implementations" / "adp" / "verification"
MANIFEST = ROOT / "reverse_engineering" / "manifests" / "adp_verification.json"


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> int:
    if not SOURCE_LOG.is_file():
        raise RuntimeError(f"Missing ADP verification log: {SOURCE_LOG}")
    DESTINATION.mkdir(parents=True, exist_ok=True)
    log = DESTINATION / "make-linux-test-2026-08-19.log"
    shutil.copyfile(SOURCE_LOG, log)
    manifest = {
        "schema_version": 1,
        "implementation": "adp-public-implementation",
        "revision": "379a6710de11a2378f3d76c25a4d71bca75073bf",
        "command": ["make", "-f", "Makefile-linux", "test"],
        "build_dependency_resolution": "SDL2 development files installed after initial environment failure; pinned source then built and executed its test target.",
        "result": "fixture_blocked",
        "scenario_summary": {"probed": 22, "passed": 18, "blocked": 4, "failed_behavioral_assertions": 0},
        "blocked_fixture_paths": [
            "games/original256/release/amiga-hd/part1.ddb",
            "games/original256/release/amiga-hd/part2.ddb"
        ],
        "finding": "The four blocked scenarios require two Amiga-HD DDB fixture paths absent from both the pinned source checkout and the retained Games-AD release bundles. The retained log reports 18 passing fixture images; this is not recorded as a behavioral regression.",
        "log": {"path": str(log.relative_to(ROOT)), "sha256": sha256(log), "size": log.stat().st_size},
        "non_claim": "This result validates only the executed pinned host test suite under the stated fixture set; it does not establish compatibility with every DAAD game or historical interpreter.",
    }
    MANIFEST.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"Recorded ADP verification log: {log.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
