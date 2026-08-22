"""Regression coverage for retained DOS MZ header and relative-entry evidence."""

from __future__ import annotations

from pathlib import Path

import pytest

from daad_harvester.dos_mz_load_model import DosMzLoadModelError, collect_dos_mz_load_model, parse_mz_header, validate_dos_mz_launch_capture_contract


ROOT = Path(__file__).resolve().parents[1]
LAUNCH_CONTRACT = ROOT / "reverse_engineering/workflows/dos_mz_launch_capture_admission.json"


def test_all_retained_dos_profiles_have_validated_mz_relative_entry_evidence() -> None:
    ledger = collect_dos_mz_load_model(ROOT)

    assert ledger["profile_count"] == 22
    assert ledger["execution_eligible"] is False
    assert {profile["relative_entry_offset"] for profile in ledger["profiles"]} == {0}
    assert {profile["overlay_number"] for profile in ledger["profiles"]} == {0}
    assert all(profile["load_module_start"] == profile["header_size"] for profile in ledger["profiles"])
    assert all(profile["load_module_end_exclusive"] == profile["declared_size"] for profile in ledger["profiles"])
    assert all(len(profile["load_module_sha256"]) == 64 for profile in ledger["profiles"])


def test_future_dos_launch_capture_contract_is_null_only_and_complete() -> None:
    import json

    contract = json.loads(LAUNCH_CONTRACT.read_text(encoding="utf-8"))
    validate_dos_mz_launch_capture_contract(contract, ROOT)
    contract["launch_capture_observations"]["daad-dos-inte1-official"] = {"actual_load_segment": "generic"}
    with pytest.raises(DosMzLoadModelError, match="no official DOS MZ launch capture"):
        validate_dos_mz_launch_capture_contract(contract, ROOT)


def test_mz_header_rejects_truncated_or_invalid_relative_entry() -> None:
    data = bytearray((ROOT / "reverse_engineering/artifacts/original/dos/daad-dos-inte1-official/INTE1.EXE").read_bytes())

    with pytest.raises(DosMzLoadModelError, match="missing or truncated MZ signature"):
        parse_mz_header(bytes(data[:10]))

    data[20:22] = (0xFFFF).to_bytes(2, "little")
    with pytest.raises(DosMzLoadModelError, match="relative CS:IP is outside"):
        parse_mz_header(bytes(data))
