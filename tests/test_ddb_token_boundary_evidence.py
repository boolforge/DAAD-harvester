"""Regression coverage for the retained DDB token/text boundary blocker record."""

from __future__ import annotations

from daad_harvester.ddb_token_boundary_evidence import retained_token_boundary_blocker_evidence


def test_retained_token_boundary_conflict_is_explicit_and_reproducible() -> None:
    evidence = retained_token_boundary_blocker_evidence()

    assert evidence["status"] == "rejected_probe_defect_closed"
    assert evidence["profile"]["platform"] == "dos"
    assert evidence["token_block_start"] == 0x251
    overlap = evidence["unbounded_probe_overlap"]
    assert overlap["candidate_token_index"] == 0x100
    assert overlap["candidate_token_byte_start"] == 0x386
    assert overlap["candidate_token_byte_end"] == 0x387
    assert overlap["text_references"]
    assert overlap["text_references"][0]["source_offset"] == 0x386
    assert evidence["adp_bounded_scan_overlap"] is None
