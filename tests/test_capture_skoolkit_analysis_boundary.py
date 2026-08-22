from __future__ import annotations

import pytest

from scripts.capture_skoolkit_analysis_boundary import EXECUTION, STATIC, build_snapshot


def test_build_snapshot_records_static_and_emulator_boundaries() -> None:
    snapshot = build_snapshot(f"{STATIC}\n{EXECUTION}\ncode execution map produced by an emulator")

    assert snapshot["documented_inputs"] == ["SNA snapshot", "SZX snapshot", "Z80 snapshot", "raw memory file"]
    assert "Static classification is described as an attempt." in snapshot["documented_boundaries"]


def test_build_snapshot_rejects_missing_boundary_statement() -> None:
    with pytest.raises(ValueError, match="lacks expected analysis-boundary statements"):
        build_snapshot(STATIC)
