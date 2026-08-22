"""Regression coverage for the global self-contained regeneration gate."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "verify_regeneration_manifest.py"


def test_registered_primary_regeneration_paths_are_self_contained() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "Self-contained regeneration verified: 12 native entries, 33 inputs, 21 outputs." in result.stdout
