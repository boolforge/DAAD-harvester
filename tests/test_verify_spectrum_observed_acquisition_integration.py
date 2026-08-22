from __future__ import annotations

import pytest

from scripts.verify_spectrum_observed_acquisition_integration import observed_source_plan


def entry(*, observed: bool, checksum_algorithm: str = "sha256") -> dict:
    result = {
        "candidate_key": "example|publisher|2024|unknown",
        "source_checksum": {"algorithm": checksum_algorithm, "value": "a" * 64},
    }
    if observed:
        result["source_observed_identity"] = {"language": "English"}
    return result


def test_observed_source_plan_keeps_only_checksum_pinned_observed_entries() -> None:
    plan = observed_source_plan(
        {"registrations": [entry(observed=False), entry(observed=True), entry(observed=True, checksum_algorithm="sha1")]}
    )

    assert len(plan) == 1
    assert plan[0]["entry"]["candidate_key"] == "example|publisher|2024|unknown"


def test_observed_source_plan_rejects_missing_observed_source_records() -> None:
    with pytest.raises(ValueError, match="no checksum-pinned observed-source"):
        observed_source_plan({"registrations": [entry(observed=False)]})
