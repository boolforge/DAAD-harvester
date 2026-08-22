#!/usr/bin/env python3
"""Health-check a local radare2 binary with committed temporary fixtures only."""

from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import tempfile
from pathlib import Path
from typing import Any

from daad_harvester.analyzer_adapters import load_radare2_fixture_health


ROOT = Path(__file__).resolve().parents[1]


def sha256_file(path: Path) -> str:
    """Return a SHA-256 digest for the local binary or controlled fixture."""
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(r2_path: Path) -> dict[str, Any]:
    """Run every committed radare2 fixture twice in a temporary directory."""
    workflow = json.loads((ROOT / "reverse_engineering/workflows/toolchain.json").read_text(encoding="utf-8"))
    health = load_radare2_fixture_health(ROOT / "reverse_engineering/workflows/radare2_fixture_health.json", workflow)
    if not r2_path.is_file() or not r2_path.stat().st_mode & 0o111:
        raise RuntimeError(f"radare2 binary is not executable: {r2_path}")
    if sha256_file(r2_path) != health["tool"]["binary_sha256"]:
        raise RuntimeError("radare2 binary SHA-256 does not match the committed health evidence")
    results: list[dict[str, Any]] = []
    with tempfile.TemporaryDirectory(prefix="daad-radare2-health-") as temporary:
        temporary_root = Path(temporary)
        for profile in health["processor_profiles"]:
            fixture = temporary_root / profile["fixture_filename"]
            fixture.write_bytes(bytes.fromhex(profile["fixture_hex"]))
            if sha256_file(fixture) != profile["fixture_sha256"]:
                raise RuntimeError("controlled radare2 fixture SHA-256 differs from the committed health record")
            listings: list[bytes] = []
            for _ in range(profile["repeat_run_count"]):
                command = [str(r2_path), "-N", "-q", "-a", profile["radare_arch"], "-b", str(profile["bits"]), "-c", "pd 2", str(fixture)]
                listing = subprocess.run(command, check=True, capture_output=True).stdout
                if hashlib.sha256(listing).hexdigest() != profile["listing_sha256"]:
                    raise RuntimeError("radare2 fixture listing SHA-256 differs from the committed health record")
                listings.append(listing)
            if listings[0] != listings[1]:
                raise RuntimeError("radare2 fixture listings were not byte-identical across two runs")
            results.append({"architectures": profile["architectures"], "fixture_sha256": profile["fixture_sha256"], "listing_sha256": profile["listing_sha256"]})
    return {"schema_version": 1, "tool": health["tool"], "fixture_results": results, "non_claim": "Controlled radare2 fixture listings are host-scoped tool health evidence only; they do not authorize or analyze retained DAAD inputs."}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--r2-path", required=True, type=Path, help="exact radare2 executable to health-check")
    args = parser.parse_args()
    print(json.dumps(run(args.r2_path), indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
