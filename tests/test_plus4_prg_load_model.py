"""Regression coverage for Plus/4-specific PRG wrapper observations."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.plus4_prg_load_model import Plus4PrgLoadModelError, load_plus4_prg_load_model, parse_plus4_prg_wrapper, validate_plus4_prg_load_model


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "reverse_engineering/workflows/plus4_prg_load_model_admission.json"


def test_plus4_prg_wrappers_validate_but_do_not_supply_machine_code_entry() -> None:
    contract = load_plus4_prg_load_model(CONTRACT, ROOT)
    parsed = parse_plus4_prg_wrapper((ROOT / contract["profiles"][0]["input_path"]).read_bytes())

    assert contract["execution_eligible"] is False
    assert parsed["load_address"] == 0x4001
    assert parsed["sys_target"] == 2063
    assert parsed["sys_target_within_loaded_image"] is False


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda contract: contract.__setitem__("execution_eligible", True), "must not enable execution"),
        (lambda contract: contract["profiles"][0].__setitem__("sha256", "0" * 64), "retained PRG identity differs"),
        (lambda contract: contract.__setitem__("admission_state", "entry_verified"), "must preserve the unresolved launcher target"),
    ],
)
def test_plus4_prg_contract_rejects_promotion_or_altered_identity(mutation, message: str) -> None:
    contract = deepcopy(load_plus4_prg_load_model(CONTRACT, ROOT))
    mutation(contract)

    with pytest.raises(Plus4PrgLoadModelError, match=message):
        validate_plus4_prg_load_model(contract, ROOT)
