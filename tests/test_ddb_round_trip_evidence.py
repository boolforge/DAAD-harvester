"""Regression coverage for deterministic retained DDB round-trip evidence."""

from __future__ import annotations

from daad_harvester.ddb_round_trip_evidence import retained_ddb_round_trip_evidence


def test_retained_round_trip_evidence_has_complete_digests_and_visible_boundaries() -> None:
    evidence = retained_ddb_round_trip_evidence()

    assert evidence["schema_version"] == 1
    assert evidence["fixture_count"] == 1
    record = evidence["records"][0]
    assert record["profile_id"] == "legacy-v2-dos-little-raw-blank-r4"
    assert record["byte_comparison"] == {
        "byte_identical": True,
        "first_difference": None,
    }
    assert record["source_digests"] == record["recompiled_digests"]
    assert len(record["source_digests"]) == 17
    assert all(record["source_digests"].values())
    assert record["semantic_status"] == "structurally_bounded"
    assert record["opaque_ranges"]
