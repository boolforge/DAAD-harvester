"""Validate measured C64 PRG BASIC-loader load and entry evidence.

This contract verifies the PRG wrapper and BASIC-declared entry point only. It
does not infer C64 banking, I/O state, machine-code semantics, or behavior.
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any

from daad_harvester.media_inspection import inspect_native_media


class C64PrgLoadModelError(ValueError):
    """Raised when a C64 PRG load-model contract is incomplete or altered."""


EXPECTED_LOAD_ADDRESS = 0x0801
EXPECTED_SYS_TARGET = 2063
EXPECTED_MACHINE_CODE_OFFSET = 16


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def validate_c64_prg_load_model(contract: dict[str, Any], root: Path) -> None:
    """Validate a limited C64 PRG load and BASIC `SYS` entry admission contract."""
    if contract.get("schema_version") != 1:
        raise C64PrgLoadModelError("schema_version must be 1")
    if contract.get("admission_state") != "load_and_basic_entry_verified_banking_unresolved":
        raise C64PrgLoadModelError("admission_state must preserve the unresolved banking boundary")
    if contract.get("execution_eligible") is not False:
        raise C64PrgLoadModelError("contract must not enable retained execution")
    if not isinstance(contract.get("banking_io_state"), str) or "unresolved" not in contract["banking_io_state"]:
        raise C64PrgLoadModelError("banking_io_state must remain explicitly unresolved")
    if not isinstance(contract.get("profiles"), list) or len(contract["profiles"]) != 2:
        raise C64PrgLoadModelError("contract must define exactly two official C64 profiles")
    seen_ids: set[str] = set()
    for profile in contract["profiles"]:
        if not isinstance(profile, dict):
            raise C64PrgLoadModelError("profile must be an object")
        profile_id = profile.get("artifact_id")
        if not isinstance(profile_id, str) or profile_id in seen_ids:
            raise C64PrgLoadModelError("profiles must have unique artifact_id values")
        seen_ids.add(profile_id)
        path_value = profile.get("input_path")
        expected_hash = profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise C64PrgLoadModelError(f"{profile_id}: input_path must be safe and relative")
        if not isinstance(expected_hash, str) or len(expected_hash) != 64:
            raise C64PrgLoadModelError(f"{profile_id}: sha256 must be present")
        path = root / path_value
        if not path.is_file() or _sha256(path) != expected_hash:
            raise C64PrgLoadModelError(f"{profile_id}: retained PRG identity differs")
        data = path.read_bytes()
        inspection = inspect_native_media(path.name, data)
        if inspection.status != "recognized_evidence" or inspection.validation != "validated_c64_basic_sys_launcher":
            raise C64PrgLoadModelError(f"{profile_id}: C64 BASIC launcher structure is not validated")
        evidence = inspection.evidence
        if evidence.get("load_address") != EXPECTED_LOAD_ADDRESS or evidence.get("sys_target") != EXPECTED_SYS_TARGET:
            raise C64PrgLoadModelError(f"{profile_id}: unexpected BASIC load or SYS target")
        if evidence.get("machine_code_offset") != EXPECTED_MACHINE_CODE_OFFSET:
            raise C64PrgLoadModelError(f"{profile_id}: unexpected machine-code offset")
        if profile.get("entry_address") != EXPECTED_SYS_TARGET:
            raise C64PrgLoadModelError(f"{profile_id}: contract entry address must equal the declared SYS target")
        if data[EXPECTED_MACHINE_CODE_OFFSET] != 0x4C:
            raise C64PrgLoadModelError(f"{profile_id}: declared entry does not begin with the measured JMP opcode")


def load_c64_prg_load_model(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate a C64 PRG admission contract without executing it."""
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise C64PrgLoadModelError("load-model contract must be a JSON object")
    validate_c64_prg_load_model(contract, root)
    return contract
