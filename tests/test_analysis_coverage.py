"""Regression coverage for the retained static-analysis coverage ledger."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.analysis_coverage import AnalysisCoverageError, collect_analysis_coverage


ROOT = Path(__file__).resolve().parents[1]


def test_retained_binary_analysis_coverage_is_deterministic_and_refuses_execution() -> None:
    first = collect_analysis_coverage(ROOT)
    second = collect_analysis_coverage(ROOT)

    assert first == second
    assert first["profile_count"] == 42
    assert first["architecture_counts"] == {"i8086": 22, "m68000": 8, "mos6502": 2, "mos8501": 2, "z80": 8}
    assert {profile["cross_tool_disagreement_state"] for profile in first["profiles"]} == {"not_recorded"}
    assert {profile["retained_execution_state"] for profile in first["profiles"]} == {"refused_pending_full_load_model"}
    assert all(len(profile["configured_analyzer_lanes"]) == 3 for profile in first["profiles"])
    assert all(profile["container_evidence_reference"].startswith("docs/reverse_engineering/") for profile in first["profiles"])
    assert {profile["container_evidence_progress"] for profile in first["profiles"] if profile["architecture"] == "i8086"} == {"mz_header_load_module_and_relative_entry_verified_psp_runtime_unresolved"}


def test_analysis_coverage_rejects_missing_load_model(tmp_path: Path) -> None:
    source = ROOT / "reverse_engineering/derived/z80/daad-zx-ds48ie-official/analysis-run.json"
    target = tmp_path / "reverse_engineering/derived/z80/daad-zx-ds48ie-official"
    target.mkdir(parents=True)
    payload = __import__("json").loads(source.read_text(encoding="utf-8"))
    del payload["load_model"]
    (target / "analysis-run.json").write_text(__import__("json").dumps(payload), encoding="utf-8")

    with pytest.raises(AnalysisCoverageError, match="missing required keys: load_model"):
        collect_analysis_coverage(tmp_path)


def test_analysis_coverage_rejects_duplicate_profile_identity(tmp_path: Path) -> None:
    source = ROOT / "reverse_engineering/derived/z80/daad-zx-ds48ie-official/analysis-run.json"
    payload = __import__("json").loads(source.read_text(encoding="utf-8"))
    for name in ("first", "second"):
        target = tmp_path / "reverse_engineering/derived/z80" / name
        target.mkdir(parents=True)
        (target / "analysis-run.json").write_text(__import__("json").dumps(deepcopy(payload)), encoding="utf-8")

    with pytest.raises(AnalysisCoverageError, match="duplicate artifact_id"):
        collect_analysis_coverage(tmp_path)
