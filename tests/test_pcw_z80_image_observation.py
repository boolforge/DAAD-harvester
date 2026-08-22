"""Regression coverage for PCW image and CP/M BDOS-call observations."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.pcw_z80_image_observation import PcwZ80ImageObservationError, load_pcw_z80_image_observation, parse_pcw_z80_image_prefix, validate_pcw_z80_image_observation


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "reverse_engineering/workflows/pcw_z80_image_observation.json"


def test_pcw_images_have_hash_bound_bdos_call_observations_without_execution_promotion() -> None:
    contract = load_pcw_z80_image_observation(CONTRACT, ROOT)
    observed = parse_pcw_z80_image_prefix((ROOT / contract["profiles"][0]["input_path"]).read_bytes())

    assert contract["execution_eligible"] is False
    assert observed["bdos_call_offset"] == 16
    assert observed["bdos_call_target"] == 5
    assert observed["image_size"] == 8692


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda contract: contract.__setitem__("execution_eligible", True), "must not enable execution"),
        (lambda contract: contract["profiles"][0].__setitem__("sha256", "0" * 64), "retained PCW image identity differs"),
        (lambda contract: contract["profiles"][1].__setitem__("bdos_call_offset", 0), "bdos_call_offset differs"),
    ],
)
def test_pcw_image_observation_rejects_promotion_or_changed_bytes(mutation, message: str) -> None:
    contract = deepcopy(load_pcw_z80_image_observation(CONTRACT, ROOT))
    mutation(contract)

    with pytest.raises(PcwZ80ImageObservationError, match=message):
        validate_pcw_z80_image_observation(contract, ROOT)
