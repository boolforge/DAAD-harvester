import json
from pathlib import Path

from scripts.register_discovered_candidate_sources import build, preferred_match, same_identity


def test_identity_normalizes_case_and_publisher_territory() -> None:
    assert same_identity(
        {"title": "From out of a Dark Night Sky", "publisher": "Zenobi Software", "year": "1989", "language": "English"},
        {"title": "From Out of a Dark Night Sky", "publisher": "Zenobi Software (UK)", "year": "1989", "language": "English"},
    )


def test_identity_accepts_official_subtitle_and_release_month_but_not_numeric_sequel() -> None:
    candidate = {"title": "Behind Closed Doors 8", "publisher": "Pension Productions", "year": "2020", "language": "English"}
    assert same_identity(candidate, {"title": "Behind Closed Doors 8 - The Pandemic", "publisher": "Pension Productions (UK)", "year": "2020/Apr", "language": "English"})
    assert not same_identity({**candidate, "title": "Behind Closed Doors"}, {"title": "Behind Closed Doors 2: The Sequel", "publisher": "Pension Productions (UK)", "year": "2020/Apr", "language": "English"})


def test_preferred_match_selects_tzx_before_other_representations() -> None:
    matches = [
        {"filename": "game.z80.zip", "release_boundary_match": True},
        {"filename": "game.tzx.zip", "release_boundary_match": True},
    ]
    assert preferred_match(matches) == matches[1]


def test_build_adds_only_verified_new_candidate(tmp_path: Path) -> None:
    candidate = {"title": "Example", "publisher": "Example Publisher", "year": "1988", "language": "English"}
    key = "example|example publisher|1988|english"
    candidates_path = tmp_path / "candidates.json"
    discovery_path = tmp_path / "discovery.json"
    registrations_path = tmp_path / "registrations.json"
    candidates_path.write_text(json.dumps({"candidates": [candidate]}), encoding="utf-8")
    discovery_path.write_text(json.dumps({"records": [{
        "candidate_key": key,
        "matches": [
            {"filename": "example.z80.zip", "release_boundary_match": True, "source_url": "https://example.test/z80", "source_record_url": "https://example.test/entry/1", "source_release_id": "1", "release_boundary_evidence": {"title": "Example", "publisher": "Example Publisher", "year": "1988", "language": "English"}},
            {"filename": "example.tzx.zip", "release_boundary_match": True, "source_url": "https://example.test/tzx", "source_record_url": "https://example.test/entry/1", "source_release_id": "1", "release_boundary_evidence": {"title": "Example", "publisher": "Example Publisher", "year": "1988", "language": "English"}},
        ],
    }]}), encoding="utf-8")
    registrations_path.write_text(json.dumps({"schema_version": 1, "purpose": "test", "registrations": []}), encoding="utf-8")
    result = build(candidates_path, discovery_path, registrations_path)
    assert result["merge_summary"] == {"new_registrations": 1, "total_registrations": 1}
    assert result["registrations"][0]["filename"] == "example.tzx.zip"


def test_build_rejects_mismatched_identity_evidence(tmp_path: Path) -> None:
    candidate = {"title": "Example", "publisher": "Example Publisher", "year": "1988", "language": "English"}
    key = "example|example publisher|1988|english"
    candidates_path = tmp_path / "candidates.json"
    discovery_path = tmp_path / "discovery.json"
    registrations_path = tmp_path / "registrations.json"
    candidates_path.write_text(json.dumps({"candidates": [candidate]}), encoding="utf-8")
    discovery_path.write_text(json.dumps({"records": [{"candidate_key": key, "matches": [{"filename": "example.tzx.zip", "release_boundary_match": True, "source_url": "https://example.test/tzx", "source_record_url": "https://example.test/entry/1", "release_boundary_evidence": {"title": "Wrong", "year": "1988"}}]}]}), encoding="utf-8")
    registrations_path.write_text(json.dumps({"schema_version": 1, "purpose": "test", "registrations": []}), encoding="utf-8")
    assert build(candidates_path, discovery_path, registrations_path)["registrations"] == []
