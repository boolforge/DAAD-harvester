"""Regression coverage for the native official-R4 MSX disk verifier."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "verify_official_daad_r4_msx_disk.py"


def test_official_r4_msx_disk_evidence_regenerates_without_external_tools() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "Official DAAD R4 MSX disk verified: 5 native FAT12 members, exact hashes." in result.stdout
