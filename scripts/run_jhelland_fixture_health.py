#!/usr/bin/env python3
"""Health-check a pinned j-helland source copy using upstream fixtures only."""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import subprocess
import tempfile
from pathlib import Path


SOURCE_REVISION = "1979e794d1cbcd92714d0863a2fd17fd89af4fcd"
REPAIR_LINES = ("#include <cstdio>", "#include <cstdlib>", "#include <stdexcept>")


def _run(command: list[str], cwd: Path) -> str:
    completed = subprocess.run(command, cwd=cwd, check=True, capture_output=True, text=True)
    return completed.stdout


def run(source: Path) -> dict[str, object]:
    if not source.is_dir():
        raise RuntimeError(f"source directory does not exist: {source}")
    revision = _run(["git", "rev-parse", "HEAD"], source).strip()
    if revision != SOURCE_REVISION:
        raise RuntimeError(f"source revision mismatch: expected {SOURCE_REVISION}, got {revision}")
    for command in ("cmake", "nasm", "python3"):
        if shutil.which(command) is None:
            raise RuntimeError(f"required command is unavailable: {command}")
    with tempfile.TemporaryDirectory(prefix="daad-jhelland-health-") as directory:
        workspace = Path(directory) / "source"
        shutil.copytree(source, workspace, ignore=shutil.ignore_patterns(".git", "build*", "cmake-build"))
        translation_unit = workspace / "src" / "instruction.cpp"
        translation_unit.write_text("\n".join(REPAIR_LINES) + "\n" + translation_unit.read_text(encoding="utf-8"), encoding="utf-8")
        build = workspace / "build"
        _run(["cmake", "-S", str(workspace), "-B", str(build), "-DCMAKE_BUILD_TYPE=Release"], workspace)
        _run(["cmake", "--build", str(build), "--parallel"], workspace)
        output = _run(["python3", "test.py", "--directory", "asm", "--executable", str(build / "disassemble-8086")], workspace)
    records = tuple(line for line in output.splitlines() if line.startswith("OK "))
    if len(records) != 19:
        raise RuntimeError(f"upstream fixture result count mismatch: expected 19 OK records, got {len(records)}")
    return {
        "schema_version": 1,
        "tool": "j-helland/8086-disassembler",
        "source_revision": SOURCE_REVISION,
        "repair_lines": list(REPAIR_LINES),
        "fixture_count": len(records),
        "fixture_result_sha256": hashlib.sha256(("\n".join(records) + "\n").encode()).hexdigest(),
        "non_claim": "An isolated repaired-source upstream fixture round trip is not a retained DAAD invocation, DOS load model, recovered source, or runtime behavior."
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", required=True, type=Path)
    args = parser.parse_args()
    try:
        print(json.dumps(run(args.source), indent=2, sort_keys=True))
    except (RuntimeError, subprocess.CalledProcessError) as exc:
        print(f"j-helland fixture health check failed: {exc}")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
