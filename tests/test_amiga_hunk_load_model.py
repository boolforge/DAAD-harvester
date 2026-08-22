"""Regression coverage for bounded Amiga Hunk container observations."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.amiga_hunk_load_model import AmigaHunkLoadModelError, load_amiga_hunk_load_model, parse_amiga_hunk_executable, validate_amiga_hunk_load_model


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "reverse_engineering/workflows/amiga_hunk_load_model_admission.json"


def test_retained_amiga_hunks_validate_bounded_code_and_relocations_without_execution_promotion() -> None:
    contract = load_amiga_hunk_load_model(CONTRACT, ROOT)
    fields = parse_amiga_hunk_executable((ROOT / contract["profiles"][0]["input_path"]).read_bytes())

    assert contract["execution_eligible"] is False
    assert fields == {"code_longwords": 4159, "code_size": 16636, "relocation_count": 498}


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda contract: contract.__setitem__("execution_eligible", True), "must not enable execution"),
        (lambda contract: contract["profiles"][0].__setitem__("sha256", "0" * 64), "retained Amiga identity differs"),
        (lambda contract: contract["profiles"][1].__setitem__("code_size", 0), "code_size differs"),
    ],
)
def test_amiga_hunk_contract_rejects_promotion_or_changed_container_facts(mutation, message: str) -> None:
    contract = deepcopy(load_amiga_hunk_load_model(CONTRACT, ROOT))
    mutation(contract)

    with pytest.raises(AmigaHunkLoadModelError, match=message):
        validate_amiga_hunk_load_model(contract, ROOT)
