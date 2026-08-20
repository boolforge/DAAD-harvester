"""Regression coverage for native Jabato C64 runtime-RAM recovery verification."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "verify_jabato_c64_runtime_recovery.py"


def test_jabato_c64_runtime_recovery_is_verifiable_without_emulation() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "Side A / Part 1: native runtime DDB recovery verified" in result.stdout
    assert "Side B / Part 2: native runtime DDB recovery verified" in result.stdout
