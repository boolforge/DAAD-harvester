from __future__ import annotations

import json
from pathlib import Path

import pytest

from scripts import generate_analysis_commentary_scaffold as scaffold


def _record(artifact_id: str, architecture: str = "z80") -> dict:
    return {
        "analysis_state": "generated_unverified_load_model",
        "architecture": architecture,
        "artifact_id": artifact_id,
        "derived_from_sha256": "a" * 64,
        "input_path": f"reverse_engineering/artifacts/original/{architecture}/{artifact_id}/INTERPRETER.BIN",
        "load_model": "raw_binary_base_0_unverified",
        "non_claim": "Tool output is not recovered source.",
        "outputs": [{"path": f"reverse_engineering/derived/{architecture}/{artifact_id}/listing.txt", "sha256": "b" * 64, "size": 7}],
        "tool_records": [{"tool": "radare2", "output": f"reverse_engineering/derived/{architecture}/{artifact_id}/listing.txt", "returncode": 0, "sha256": "b" * 64}],
    }


def test_render_is_deterministic_and_preserves_layered_boundaries(tmp_path: Path) -> None:
    derived = tmp_path / "derived"
    for architecture, artifact_id in (("z80", "later"), ("i8086", "first")):
        record_path = derived / architecture / artifact_id / "analysis-run.json"
        record_path.parent.mkdir(parents=True)
        record_path.write_text(json.dumps(_record(artifact_id, architecture)), encoding="utf-8")

    output = tmp_path / "COMMENTARY_REVIEW_SCAFFOLD.md"
    assert scaffold.generate(derived_root=derived, output=output) == 0
    text = output.read_text(encoding="utf-8")

    assert text.index("`i8086` — `first`") < text.index("`z80` — `later`")
    assert "Immutable bytes" in text
    assert "Decoded-instruction review:** Pending" in text
    assert "Tool-hypothesis review:** Pending" in text
    assert "Independently evidenced behavior:** Pending" in text
    assert "recovered source code or verified runtime behavior" in text
    assert scaffold.generate(derived_root=derived, output=output, check=True) == 0


def test_rejects_absolute_or_parent_escaping_paths(tmp_path: Path) -> None:
    derived = tmp_path / "derived"
    record = _record("unsafe")
    record["input_path"] = "/private/unsafe.bin"
    record_path = derived / "z80" / "unsafe" / "analysis-run.json"
    record_path.parent.mkdir(parents=True)
    record_path.write_text(json.dumps(record), encoding="utf-8")

    with pytest.raises(ValueError, match="repository-relative"):
        scaffold.load_records(derived)


def test_repository_scaffold_matches_all_retained_analysis_records() -> None:
    records = scaffold.load_records()

    assert len(records) == 42
    assert all(record["load_model"] == "raw_binary_base_0_unverified" for record in records)
    assert scaffold.generate(check=True) == 0
