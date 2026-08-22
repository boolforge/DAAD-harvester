import json
from pathlib import Path

from scripts.build_resource_review_manifest import build


def test_review_manifest_covers_every_retained_artifact() -> None:
    root = Path(__file__).parents[1]
    manifest = build(root / "preservation_corpus" / "state.db")
    assert manifest["artifact_count"] == 784
    artifacts = manifest["artifacts"]
    assert len(artifacts) == 784
    assert manifest["summary"]["evidence_states"] == {
        "explicit_rejection": 20,
        "recognized_evidence": 146,
        "review_required": 618,
    }
    assert manifest["summary"]["observed_extensions"]["<extensionless>"] > 0
    assert "None" in manifest["summary"]["container_formats"]
    assert "None" in manifest["summary"]["platform_hints"]
    assert {entry["evidence_state"] for entry in artifacts} == {
        "recognized_evidence",
        "explicit_rejection",
        "review_required",
    }
    assert all(entry["next_action"] and entry["reproducer"]["command"] for entry in artifacts)


def test_committed_review_manifest_is_deterministic() -> None:
    root = Path(__file__).parents[1]
    expected = build(root / "preservation_corpus" / "state.db")
    actual = json.loads((root / "preservation_corpus" / "resource_review_manifest.json").read_text(encoding="utf-8"))
    assert actual == expected
