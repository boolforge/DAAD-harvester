"""Regression coverage for retained DOS MZ header and relative-entry evidence."""

from __future__ import annotations

import json
from copy import deepcopy
from pathlib import Path

import pytest

from daad_harvester.dos_mz_load_model import DosMzLoadModelError, EXPECTED_CANDIDATE_ADMISSION, collect_dos_mz_load_model, parse_mz_header, validate_dos_i8086_candidate_admission


ROOT = Path(__file__).resolve().parents[1]


def test_all_retained_dos_profiles_have_validated_mz_relative_entry_evidence() -> None:
    ledger = collect_dos_mz_load_model(ROOT)

    assert ledger["profile_count"] == 22
    assert ledger["execution_eligible"] is False
    assert {profile["relative_entry_offset"] for profile in ledger["profiles"]} == {0}
    assert {profile["overlay_number"] for profile in ledger["profiles"]} == {0}
    assert all(profile["load_module_start"] == profile["header_size"] for profile in ledger["profiles"])
    assert all(profile["load_module_end_exclusive"] == profile["declared_size"] for profile in ledger["profiles"])
    assert all(len(profile["load_module_sha256"]) == 64 for profile in ledger["profiles"])


def test_dos_candidate_admission_contract_preserves_psp_and_raw_base_zero_refusals() -> None:
    path = ROOT / "reverse_engineering/workflows/dos_i8086_load_model_admission.json"
    contract = json.loads(path.read_text(encoding="utf-8"))

    validate_dos_i8086_candidate_admission(contract)
    assert contract == EXPECTED_CANDIDATE_ADMISSION

    altered = deepcopy(contract)
    altered["fail_closed_conditions"].remove("missing_entry_or_load_segment")
    with pytest.raises(DosMzLoadModelError, match="candidate-admission contract differs: fail_closed_conditions"):
        validate_dos_i8086_candidate_admission(altered)


def test_mz_header_rejects_truncated_or_invalid_relative_entry() -> None:
    data = bytearray((ROOT / "reverse_engineering/artifacts/original/dos/daad-dos-inte1-official/INTE1.EXE").read_bytes())

    with pytest.raises(DosMzLoadModelError, match="missing or truncated MZ signature"):
        parse_mz_header(bytes(data[:10]))

    data[20:22] = (0xFFFF).to_bytes(2, "little")
    with pytest.raises(DosMzLoadModelError, match="relative CS:IP is outside"):
        parse_mz_header(bytes(data))
