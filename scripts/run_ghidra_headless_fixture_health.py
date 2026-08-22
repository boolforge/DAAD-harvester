#!/usr/bin/env python3
"""Health-check a local Ghidra release with controlled fixtures only.

The harness accepts a Ghidra extraction root, verifies the pinned headless
launcher and repository exporter, and executes the committed fixtures twice in
temporary directories. It has no retained-input argument and never reads DAAD
artifact, corpus, or derived-analysis paths.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import tempfile
from pathlib import Path
from typing import Any

from daad_harvester.analyzer_adapters import load_ghidra_headless_health


ROOT = Path(__file__).resolve().parents[1]
EXPORT_NAMES = (
    "ghidra-listing.txt",
    "ghidra-functions.tsv",
    "ghidra-decompilation.c",
    "ghidra-metadata.json",
)
LINUX_HOST_ID = "linux-x86_64-java-21"


def sha256_file(path: Path) -> str:
    """Return the SHA-256 digest of a local fixture, launcher, or export."""
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _linux_host(health: dict[str, Any]) -> dict[str, Any]:
    """Return the committed Linux host profile for this controlled harness."""
    for host in health["host_profiles"]:
        if host["host_id"] == LINUX_HOST_ID:
            return host
    raise RuntimeError("Ghidra health contract lacks the Linux fixture host")


def _fixture_command(
    headless: Path,
    project_directory: Path,
    project_name: str,
    fixture_path: Path,
    language: str,
    script_directory: Path,
    output_directory: Path,
) -> list[str]:
    """Build a headless command for one temporary controlled fixture."""
    return [
        str(headless),
        str(project_directory),
        project_name,
        "-import",
        str(fixture_path),
        "-processor",
        language,
        "-overwrite",
        "-scriptPath",
        str(script_directory),
        "-postScript",
        "ExportDAADAnalysis.java",
        str(output_directory),
        "-deleteProject",
    ]


def run(ghidra_root: Path) -> dict[str, Any]:
    """Execute and verify the committed repeated controlled-fixture checks."""
    workflow = json.loads((ROOT / "reverse_engineering/workflows/toolchain.json").read_text(encoding="utf-8"))
    health = load_ghidra_headless_health(
        ROOT / "reverse_engineering/workflows/ghidra_headless_health.json", workflow
    )
    host = _linux_host(health)
    headless = ghidra_root / host["headless_launcher"]
    if not headless.is_file() or not headless.stat().st_mode & 0o111:
        raise RuntimeError(f"Ghidra headless launcher is not executable: {headless}")
    expected_launcher_sha256 = host["headless_launcher_sha256"]
    if sha256_file(headless) != expected_launcher_sha256:
        raise RuntimeError("Ghidra headless launcher SHA-256 does not match the committed host evidence")

    export_script = ROOT / health["export_script"]["relative_path"]
    if not export_script.is_file() or sha256_file(export_script) != health["export_script"]["sha256"]:
        raise RuntimeError("Ghidra exporter SHA-256 does not match the committed health evidence")

    results: list[dict[str, Any]] = []
    with tempfile.TemporaryDirectory(prefix="daad-ghidra-health-") as temporary:
        temporary_root = Path(temporary)
        for profile in health["processor_profiles"]:
            fixture_path = temporary_root / profile["fixture_filename"]
            fixture_path.write_bytes(bytes.fromhex(profile["fixture_hex"]))
            if sha256_file(fixture_path) != profile["fixture_sha256"]:
                raise RuntimeError("controlled Ghidra fixture SHA-256 differs from the committed health record")
            repeated_exports: list[dict[str, bytes]] = []
            for repeat in range(1, profile["repeat_run_count"] + 1):
                project_directory = temporary_root / f"project-{profile['fixture_filename']}-{repeat}"
                output_directory = temporary_root / f"output-{profile['fixture_filename']}-{repeat}"
                project_directory.mkdir()
                output_directory.mkdir()
                command = _fixture_command(
                    headless,
                    project_directory,
                    f"Fixture{repeat}",
                    fixture_path,
                    profile["ghidra_language"],
                    export_script.parent,
                    output_directory,
                )
                subprocess.run(command, check=True, capture_output=True, text=True)
                exports = {name: (output_directory / name).read_bytes() for name in EXPORT_NAMES}
                if any(hashlib.sha256(value).hexdigest() != profile["deterministic_exports"][name] for name, value in exports.items()):
                    raise RuntimeError("Ghidra fixture export SHA-256 differs from the committed health record")
                repeated_exports.append(exports)
            if repeated_exports[0] != repeated_exports[1]:
                raise RuntimeError("Ghidra fixture exports were not byte-identical across two runs")
            results.append(
                {
                    "architectures": profile["architectures"],
                    "fixture_filename": profile["fixture_filename"],
                    "fixture_sha256": profile["fixture_sha256"],
                    "export_sha256": profile["deterministic_exports"],
                    "repeat_run_count": profile["repeat_run_count"],
                }
            )
    return {
        "schema_version": 1,
        "tool": health["tool"],
        "host_id": host["host_id"],
        "headless_launcher_sha256": expected_launcher_sha256,
        "fixture_results": results,
        "non_claim": "Controlled Ghidra fixtures are host-scoped derived-tool health evidence only; they do not authorize or analyze retained DAAD inputs.",
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--ghidra-root", required=True, type=Path, help="extracted Ghidra release root")
    args = parser.parse_args()
    print(json.dumps(run(args.ghidra_root), indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
