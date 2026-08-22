"""Validate evidence requirements for official C64 PRG entry-state admission."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any


class C64EntryStateAdmissionError(ValueError):
    """Raised when official C64 entry state is promoted without measured evidence."""


REQUIRED_CAPTURE_FIELDS = (
    "official_prg_sha256",
    "capture_sha256",
    "emulator_name",
    "emulator_version",
    "machine_model",
    "processor_port_ddr",
    "processor_port_data",
    "basic_rom_visible",
    "kernal_rom_visible",
    "io_visible",
    "ram_under_rom_visible",
    "entry_pc",
)


def validate_c64_entry_state_admission(contract: dict[str, Any]) -> None:
    """Require an official hash-bound entry capture before a C64 promotion."""
    if contract.get("schema_version") != 1:
        raise C64EntryStateAdmissionError("schema_version must be 1")
    if contract.get("execution_eligible") is not False:
        raise C64EntryStateAdmissionError("C64 entry-state admission must not enable execution")
    if contract.get("required_capture_fields") != list(REQUIRED_CAPTURE_FIELDS):
        raise C64EntryStateAdmissionError("contract must preserve the C64 future-capture field schema")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or {item.get("artifact_id") for item in profiles if isinstance(item, dict)} != {"daad-c64-edi64-official", "daad-c64-sdi64-official"}:
        raise C64EntryStateAdmissionError("contract must bind both official C64 PRG profiles")
    for profile in profiles:
        if not isinstance(profile.get("prg_sha256"), str) or len(profile["prg_sha256"]) != 64:
            raise C64EntryStateAdmissionError("official C64 PRG SHA-256 is required")
        if profile.get("basic_sys_entry") != 2063:
            raise C64EntryStateAdmissionError("contract must retain the measured BASIC SYS 2063 declaration")
        observation = profile.get("entry_state_observation")
        if observation is not None:
            raise C64EntryStateAdmissionError(f"{profile['artifact_id']}: no official C64 entry-state capture is currently admitted")
    if contract.get("admission_state") != "official_entry_state_not_observed":
        raise C64EntryStateAdmissionError("official C64 entry state remains not observed until a matching capture is retained")


def load_c64_entry_state_admission(path: Path) -> dict[str, Any]:
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise C64EntryStateAdmissionError("C64 entry-state contract must be a JSON object")
    validate_c64_entry_state_admission(contract)
    return contract
