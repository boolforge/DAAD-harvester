"""Regression coverage for deterministic retained DDB round-trip evidence."""

from __future__ import annotations

from daad_harvester.ddb_round_trip_evidence import retained_ddb_round_trip_evidence


def test_retained_round_trip_evidence_has_complete_digests_and_visible_boundaries() -> None:
    evidence = retained_ddb_round_trip_evidence()

    assert evidence["schema_version"] == 1
    assert evidence["fixture_count"] == 2
    records = {record["profile_id"]: record for record in evidence["records"]}
    assert set(records) == {
        "legacy-v2-dos-little-raw-blank-r4",
        "legacy-v1-c64-little-0x3880-raw-jabato-ass-part1",
    }
    for record in records.values():
        assert record["byte_comparison"] == {
            "byte_identical": True,
            "first_difference": None,
        }
        assert record["source_digests"] == record["recompiled_digests"]
        assert len(record["source_digests"]) == 17
        assert all(record["source_digests"].values())
        assert record["semantic_status"] == "structurally_bounded"
        assert record["opaque_ranges"]
    assert records["legacy-v1-c64-little-0x3880-raw-jabato-ass-part1"]["profile"]["base_address"] == 0x3880
