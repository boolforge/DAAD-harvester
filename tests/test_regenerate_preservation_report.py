"""Regression coverage for byte-stable native preservation-report regeneration."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys

from daad_harvester.db import Database
from daad_harvester.report_export import StaticReportExporter


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "regenerate_preservation_report.py"


def test_report_exporter_honors_explicit_timestamp(tmp_path: Path) -> None:
    report = StaticReportExporter(
        Database(tmp_path / "state.db"), tmp_path, generated_at="2000-01-01T00:00:00+00:00"
    ).build()

    assert report["generated_at"] == "2000-01-01T00:00:00+00:00"


def test_committed_preservation_report_regenerates_natively() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--check"],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "Static preservation report regenerated and verified natively" in result.stdout
