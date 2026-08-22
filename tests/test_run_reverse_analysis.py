from __future__ import annotations

import hashlib
import json
from pathlib import Path

from scripts import run_reverse_analysis


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _fixture(tmp_path: Path, monkeypatch) -> tuple[dict, dict, Path, Path]:
    monkeypatch.setattr(run_reverse_analysis, "ROOT", tmp_path)
    monkeypatch.setattr(run_reverse_analysis, "DERIVED_ROOT", tmp_path / "derived")
    source = tmp_path / "original.bin"
    source.write_bytes(b"immutable-original")
    artifact = {
        "artifact_id": "sample-i8086",
        "architecture": "i8086",
        "sha256": _sha256(source),
        "storage": {"path": "original.bin"},
    }
    workflow = {"architectures": {"i8086": {"load_model": "raw_binary_base_0_unverified"}}}
    target = tmp_path / "derived" / "i8086" / "sample-i8086"
    target.mkdir(parents=True)
    output = target / "static.txt"
    output.write_text("disassembly\n", encoding="utf-8")
    relative_output = str(output.relative_to(tmp_path))
    record = {
        "schema_version": 1,
        "artifact_id": artifact["artifact_id"],
        "derived_from_sha256": artifact["sha256"],
        "architecture": artifact["architecture"],
        "input_path": artifact["storage"]["path"],
        "load_model": workflow["architectures"]["i8086"]["load_model"],
        "analysis_state": "generated_unverified_load_model",
        "non_claim": "Outputs are tool-derived static analysis of original bytes at the stated raw load model; they are not recovered source code or verified runtime semantics.",
        "outputs": [{"path": relative_output, "size": output.stat().st_size, "sha256": _sha256(output)}],
        "tool_records": [
            {"tool": "radare2", "output": relative_output, "sha256": _sha256(output)},
            {"tool": "architecture_static", "output": relative_output, "sha256": _sha256(output)},
        ],
    }
    record_path = target / "analysis-run.json"
    record_path.write_text(json.dumps(record, indent=2) + "\n", encoding="utf-8")
    return artifact, workflow, output, record_path


def test_verify_retained_analysis_is_read_only_and_accepts_matching_record(tmp_path, monkeypatch) -> None:
    artifact, workflow, output, record_path = _fixture(tmp_path, monkeypatch)
    before_output = output.read_bytes()
    before_record = record_path.read_bytes()

    assert run_reverse_analysis.verify(artifact, workflow) == []
    assert output.read_bytes() == before_output
    assert record_path.read_bytes() == before_record


def test_verify_rejects_corrupted_retained_analysis_output(tmp_path, monkeypatch) -> None:
    artifact, workflow, output, _ = _fixture(tmp_path, monkeypatch)
    output.write_text("corrupted\n", encoding="utf-8")

    errors = run_reverse_analysis.verify(artifact, workflow)

    assert any("derived output SHA-256 mismatch" in error for error in errors)
    assert any("tool-record SHA-256 mismatch" in error for error in errors)
