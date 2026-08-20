"""Regression coverage for native ASS Jabato C64 scene-variant verification."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "verify_jabato_c64_ass_scene_variant.py"


def test_ass_jabato_scene_variant_verifies_without_emulation() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "ASS Part 1: scene member runtime DDB is byte-identical to original" in result.stdout
    assert "ASS Part 2: scene member runtime DDB is byte-identical to original" in result.stdout
