import json
from pathlib import Path

from scripts.build_catalog_discovery_candidates import build, source_rows, spectrum_rows


def test_public_snapshot_is_parsed_and_kept_catalog_only() -> None:
    root = Path(__file__).parents[1]
    result = build(
        root / "research" / "sources" / "solutionarchive_daad_2026-08-22.md",
        root / "preservation_corpus" / "daad_catalog.json",
    )
    assert result["schema_version"] == 2
    assert result["source_record_count"] == 92
    assert result["candidate_count"] == 79
    assert all(item["evidence_grade"] == "catalog_only" for item in result["candidates"])
    assert all(item["byte_hash"] is None for item in result["candidates"])
    assert all(item["promotion_status"] == "blocked_pending_primary_or_authorized_source" for item in result["candidates"])
    spectrum_candidates = [
        item
        for item in result["candidates"]
        if item["source_snapshot"] == "research/sources/spectrumcomputing_daad_relationships_2026-08-22.json"
    ]
    assert len(spectrum_candidates) == 30
    assert all(item["language"] == "Unknown" for item in spectrum_candidates)
    assert {item["platform"] for item in spectrum_candidates} == {"ZX-Spectrum", "ZX-Spectrum_Next"}


def test_committed_candidate_manifest_is_deterministic() -> None:
    root = Path(__file__).parents[1]
    expected = build()
    actual = json.loads((root / "research" / "catalog_discovery_candidates.json").read_text(encoding="utf-8"))
    assert actual == expected
    assert len(source_rows(root / "research" / "sources" / "solutionarchive_daad_2026-08-22.md")) == 50
    assert len(spectrum_rows(root / "research" / "sources" / "spectrumcomputing_daad_relationships_2026-08-22.json")) == 42
