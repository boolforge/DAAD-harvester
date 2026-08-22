"""Regression coverage for MSX image and leading-jump observations."""

from __future__ import annotations

from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.msx_z80_image_observation import MsxZ80ImageObservationError, load_msx_z80_image_observation, parse_msx_z80_image_prefix, validate_msx_z80_image_observation


ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "reverse_engineering/workflows/msx_z80_image_observation.json"


def test_msx_images_have_immutable_leading_jump_observations_without_entry_promotion() -> None:
    contract = load_msx_z80_image_observation(CONTRACT, ROOT)
    observed = parse_msx_z80_image_prefix((ROOT / contract["profiles"][0]["input_path"]).read_bytes())

    assert contract["execution_eligible"] is False
    assert observed["leading_jump_offset"] == 0
    assert observed["leading_jump_target"] == 0xCF3A
    assert observed["image_size"] == 8400


@pytest.mark.parametrize(
    ("mutation", "message"),
    [
        (lambda contract: contract.__setitem__("execution_eligible", True), "must not enable execution"),
        (lambda contract: contract["profiles"][0].__setitem__("sha256", "0" * 64), "retained MSX image identity differs"),
        (lambda contract: contract["profiles"][1].__setitem__("leading_jump_target", 0), "leading_jump_target differs"),
        (lambda contract: contract["profiles"][0].__setitem__("leading_jump_offset", 1), "leading_jump_offset differs"),
    ],
)
def test_msx_image_observation_rejects_promotion_or_changed_bytes(mutation, message: str) -> None:
    contract = deepcopy(load_msx_z80_image_observation(CONTRACT, ROOT))
    mutation(contract)

    with pytest.raises(MsxZ80ImageObservationError, match=message):
        validate_msx_z80_image_observation(contract, ROOT)
