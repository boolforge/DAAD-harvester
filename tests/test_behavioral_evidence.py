"""Regression coverage for fail-closed runtime-capture observations."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.behavioral_evidence import BehavioralEvidenceError, load_behavioral_observation, validate_behavioral_observation


ROOT = Path(__file__).resolve().parents[1]
RECORD = ROOT / "reverse_engineering/workflows/behavioral_evidence/jabato_c64_side_a_capture_observation.json"


def test_jabato_capture_observation_validates_without_invoking_an_emulator() -> None:
    record = load_behavioral_observation(RECORD, ROOT)

    assert record["eligible_for_equivalence"] is False
    assert record["checkpoint"]["cycle"] == 396422219
    assert record["observable"]["ram_offset"] == 0x3880


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda record: record.__setitem__("eligible_for_equivalence", True), "must not be eligible"),
        (lambda record: record["release"]["media"].__setitem__("path", "/tmp/guessed.tap"), "safe repository-relative"),
        (lambda record: record["emulator"].__setitem__("version", ""), "name, version, and frontend"),
        (lambda record: record["capture"]["ram"].__setitem__("sha256", "0" * 64), "differs from the retained file"),
        (lambda record: record["observable"].__setitem__("size", 1), "does not match the declared RAM range"),
    ],
)
def test_behavioral_observation_rejects_missing_or_altered_evidence(mutation, message: str) -> None:
    record = deepcopy(load_behavioral_observation(RECORD, ROOT))
    mutation(record)

    with pytest.raises(BehavioralEvidenceError, match=message):
        validate_behavioral_observation(record, ROOT)
