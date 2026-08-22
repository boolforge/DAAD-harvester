#!/usr/bin/env python3
"""Health-check a pinned lybrown/dis checkout with a controlled MOS 6502 fixture.

This optional external-tool harness accepts only the exact pinned Perl script,
creates a literal NOP/RTS fixture in a temporary directory, and invokes the
script with explicit raw origin and code-entry arguments. It never reads a
retained DAAD artifact and deliberately has no MOS 8501 mode.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import tempfile
from pathlib import Path


SOURCE_REVISION = "b4954cc90f210a64a3c63e87101a9a8786cd0247"
SCRIPT_SHA256 = "0d5d8d82b69c2998a86f66fe00482eb2ea4f65dc8d188a439a5521b1ddfe04f7"
FIXTURE = bytes.fromhex("ea60")
EXPECTED_LISTING = "    opt h-\n    org $0000\n    nop    \t\t; 0000: EA\n    rts    \t\t; 0001: 60\n"


def sha256_file(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(dis_path: Path) -> dict[str, object]:
    if not dis_path.is_file():
        raise RuntimeError(f"lybrown/dis script is not a file: {dis_path}")
    if sha256_file(dis_path) != SCRIPT_SHA256:
        raise RuntimeError("lybrown/dis script SHA-256 does not match the pinned candidate")
    with tempfile.TemporaryDirectory(prefix="daad-lybrown-dis-") as temporary:
        fixture_path = Path(temporary) / "nop-rts.bin"
        fixture_path.write_bytes(FIXTURE)
        command = [str(dis_path), "-t", "raw", "-o", "0000", "-c", "0000", str(fixture_path)]
        first = subprocess.run(command, check=True, capture_output=True, text=True).stdout
        second = subprocess.run(command, check=True, capture_output=True, text=True).stdout
    if first != second:
        raise RuntimeError("lybrown/dis listing was not byte-identical across two fixture runs")
    if first != EXPECTED_LISTING:
        raise RuntimeError("lybrown/dis listing differs from the pinned MOS 6502 fixture expectation")
    return {
        "schema_version": 1,
        "tool": "lybrown/dis",
        "source_revision": SOURCE_REVISION,
        "script_sha256": SCRIPT_SHA256,
        "architecture": "mos6502",
        "fixture_hex": FIXTURE.hex(),
        "fixture_sha256": hashlib.sha256(FIXTURE).hexdigest(),
        "listing_sha256": hashlib.sha256(first.encode("utf-8")).hexdigest(),
        "origin": "0x0000",
        "entry": "0x0000",
        "listing": first,
        "unsupported_architectures": {"mos8501": "No MOS 8501 mode or equivalence is claimed by this harness."},
        "non_claim": "Controlled MOS 6502 static tracing at raw origin zero is not recovered source, a retained DAAD load model, or runtime behavior."
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dis-path", required=True, type=Path, help="exact pinned lybrown/dis Perl script")
    args = parser.parse_args()
    print(json.dumps(run(args.dis_path), indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
