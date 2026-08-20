"""Regression coverage for repository-native Jabato C64 TAP evidence regeneration."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "regenerate_jabato_c64_tap_evidence.py"


def test_committed_jabato_tap_reports_regenerate_natively() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--check"],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "Side A: native evidence report verified" in result.stdout
    assert "Side B: native evidence report verified" in result.stdout
