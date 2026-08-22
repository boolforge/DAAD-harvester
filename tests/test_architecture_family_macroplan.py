"""Regression coverage for the autonomous architecture-family macroplan."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.architecture_family_macroplan import ArchitectureFamilyMacroplanError, load_architecture_family_macroplan, validate_architecture_family_macroplan


ROOT = Path(__file__).resolve().parents[1]
LEDGER = ROOT / "reverse_engineering/workflows/architecture_family_macroplan.json"


def test_macroplan_covers_all_independent_architecture_workstreams() -> None:
    ledger = load_architecture_family_macroplan(LEDGER)

    assert len(ledger["workstreams"]) == 8
    assert next(stream for stream in ledger["workstreams"] if stream["id"] == "c64_mos6502")["population"] == 2
    assert next(stream for stream in ledger["workstreams"] if stream["id"] == "dos_i8086")["population"] == 22


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda ledger: ledger["workstreams"].pop(), "workstream ids differ"),
        (lambda ledger: ledger["workstreams"][0].__setitem__("last_validated_commit", "bad"), "short commit id"),
        (lambda ledger: ledger["workstreams"][1].__setitem__("forbidden_cross_family_evidence", []), "cross-family boundary"),
        (lambda ledger: ledger["workstreams"][2].__setitem__("analysis_state", "done"), "invalid analysis_state"),
    ],
)
def test_macroplan_rejects_missing_gates_or_cross_family_boundary(mutation, message: str) -> None:
    ledger = deepcopy(load_architecture_family_macroplan(LEDGER))
    mutation(ledger)

    with pytest.raises(ArchitectureFamilyMacroplanError, match=message):
        validate_architecture_family_macroplan(ledger)
