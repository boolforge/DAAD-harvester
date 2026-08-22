"""Regression coverage for CPC AMSDOS container-relative load and entry facts."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.cpc_amsdos_load_model import CpcAmsdosLoadModelError, load_cpc_amsdos_load_model, parse_amsdos_binary_header, validate_cpc_amsdos_load_model


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "reverse_engineering/workflows/cpc_amsdos_load_model_admission.json"


def test_retained_cpc_amsdos_headers_provide_bounded_load_and_entry_facts() -> None:
    contract = load_cpc_amsdos_load_model(CONTRACT, ROOT)
    fields = parse_amsdos_binary_header((ROOT / contract["profiles"][0]["input_path"]).read_bytes())

    assert contract["execution_eligible"] is False
    assert all(profile["entry_environment_observation"] is None for profile in contract["profiles"])
    assert fields["load_address"] == 0x0840
    assert fields["entry_address"] == 0x2417
    assert fields["stored_payload_size"] == 7395


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda contract: contract.__setitem__("execution_eligible", True), "must not enable execution"),
        (lambda contract: contract["profiles"][0].__setitem__("sha256", "0" * 64), "retained CPC identity differs"),
        (lambda contract: contract["profiles"][1].__setitem__("entry_address", 0), "entry_address differs"),
    ],
)
def test_cpc_amsdos_contract_rejects_promotion_or_changed_header_facts(mutation, message: str) -> None:
    contract = deepcopy(load_cpc_amsdos_load_model(CONTRACT, ROOT))
    mutation(contract)

    with pytest.raises(CpcAmsdosLoadModelError, match=message):
        validate_cpc_amsdos_load_model(contract, ROOT)


def test_cpc_amsdos_contract_rejects_unbound_entry_environment_observation() -> None:
    contract = deepcopy(load_cpc_amsdos_load_model(CONTRACT, ROOT))
    contract["profiles"][0]["entry_environment_observation"] = {"emulator": "default"}

    with pytest.raises(CpcAmsdosLoadModelError, match="no official CPC entry-environment capture"):
        validate_cpc_amsdos_load_model(contract, ROOT)
