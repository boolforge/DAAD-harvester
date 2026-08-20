"""Regression coverage for the cross-host primary verification launcher."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "run_primary_workflow.py"


def test_primary_workflow_lists_all_native_gates_without_external_tools() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--list"],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "regeneration manifest:" in result.stdout
    assert "runtime resources:" in result.stdout
    assert "retained game corpus:" in result.stdout
    assert "complete artifact checksums:" in result.stdout
    assert "public artifact manifest:" in result.stdout
    assert "reverse-engineering corpus:" in result.stdout
    assert "static preservation report:" in result.stdout
    assert "documentation integrity:" in result.stdout
    assert "regression suite:" in result.stdout
    assert "x64sc" not in result.stdout
    assert "ghidra" not in result.stdout.casefold()
