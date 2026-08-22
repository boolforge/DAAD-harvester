"""Regression coverage for the official C64 PRG load and BASIC-entry contract."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.c64_prg_load_model import C64PrgLoadModelError, load_c64_prg_load_model, validate_c64_prg_load_model


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "reverse_engineering/workflows/c64_prg_load_model_admission.json"


def test_official_c64_prg_load_model_verifies_without_execution() -> None:
    contract = load_c64_prg_load_model(CONTRACT, ROOT)

    assert contract["execution_eligible"] is False
    assert contract["admission_state"] == "load_and_basic_entry_verified_banking_unresolved"
    assert [profile["entry_address"] for profile in contract["profiles"]] == [2063, 2063]


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda contract: contract.__setitem__("execution_eligible", True), "must not enable retained execution"),
        (lambda contract: contract.__setitem__("banking_io_state", "verified"), "explicitly unresolved"),
        (lambda contract: contract["profiles"][0].__setitem__("entry_address", 0), "must equal the declared SYS target"),
        (lambda contract: contract["profiles"][0].__setitem__("sha256", "0" * 64), "retained PRG identity differs"),
    ],
)
def test_c64_prg_load_model_rejects_unjustified_promotion_or_altered_identity(mutation, message: str) -> None:
    contract = deepcopy(load_c64_prg_load_model(CONTRACT, ROOT))
    mutation(contract)

    with pytest.raises(C64PrgLoadModelError, match=message):
        validate_c64_prg_load_model(contract, ROOT)
