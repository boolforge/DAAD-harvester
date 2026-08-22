"""Regression coverage for ZX PLUS3DOS header observations."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.zx_plus3dos_load_model import ZxPlus3DosLoadModelError, load_zx_plus3dos_load_model, parse_plus3dos_header, validate_zx_plus3dos_load_model


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "reverse_engineering/workflows/zx_plus3dos_load_model_admission.json"


def test_retained_zx_plus3dos_headers_validate_without_executable_promotion() -> None:
    contract = load_zx_plus3dos_load_model(CONTRACT, ROOT)
    fields = parse_plus3dos_header((ROOT / contract["profiles"][1]["input_path"]).read_bytes())

    assert contract["execution_eligible"] is False
    assert fields["physical_tail_size"] == 946
    assert fields["declared_payload"] == 8142


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda contract: contract.__setitem__("execution_eligible", True), "must not enable execution"),
        (lambda contract: contract["profiles"][0].__setitem__("sha256", "0" * 64), "retained P3F identity differs"),
        (lambda contract: contract["profiles"][1].__setitem__("physical_tail_size", 0), "physical tail fact differs"),
    ],
)
def test_zx_plus3dos_contract_rejects_promotion_or_changed_facts(mutation, message: str) -> None:
    contract = deepcopy(load_zx_plus3dos_load_model(CONTRACT, ROOT))
    mutation(contract)

    with pytest.raises(ZxPlus3DosLoadModelError, match=message):
        validate_zx_plus3dos_load_model(contract, ROOT)
