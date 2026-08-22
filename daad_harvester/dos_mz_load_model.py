"""Derive fail-closed DOS MZ header and relative-entry evidence from retained profiles."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any

from daad_harvester.analyzer_adapters import AdapterCatalogError, load_dos_i8086_load_model_admission


class DosMzLoadModelError(ValueError):
    """Raised when a retained DOS MZ profile lacks valid header evidence."""


FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS = (
    "official_mz_sha256", "loader_context_sha256", "dos_kernel_sha256", "command_com_sha256",
    "exec_transition_sha256", "bootstrap_medium_sha256", "snapshot_sha256", "machine_configuration",
    "actual_load_segment", "psp_mapping", "memory_allocation_mapping", "environment_block",
    "command_tail", "fcb_state", "handle_state", "dta_state", "i8086_registers", "stack_state",
)


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _word(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset:offset + 2], "little")


def parse_mz_header(data: bytes) -> dict[str, int]:
    """Parse and validate the bounded DOS MZ header needed for static loading."""
    if len(data) < 28 or data[:2] not in {b"MZ", b"ZM"}:
        raise DosMzLoadModelError("missing or truncated MZ signature")
    bytes_last_page = _word(data, 2)
    page_count = _word(data, 4)
    relocation_count = _word(data, 6)
    header_paragraphs = _word(data, 8)
    initial_ss = _word(data, 14)
    initial_sp = _word(data, 16)
    initial_ip = _word(data, 20)
    initial_cs = _word(data, 22)
    relocation_offset = _word(data, 24)
    overlay_number = _word(data, 26)
    if not page_count or bytes_last_page > 512:
        raise DosMzLoadModelError("invalid MZ page fields")
    declared_size = page_count * 512 - (512 - bytes_last_page if bytes_last_page else 0)
    header_size = header_paragraphs * 16
    if declared_size != len(data) or declared_size < header_size:
        raise DosMzLoadModelError("declared MZ size does not match retained file")
    relocation_end = relocation_offset + relocation_count * 4
    if relocation_offset < 28 or relocation_end > header_size:
        raise DosMzLoadModelError("MZ relocation table is outside the header")
    load_module_size = declared_size - header_size
    load_module = data[header_size:declared_size]
    load_module_sha256 = hashlib.sha256(load_module).hexdigest()
    entry_offset = initial_cs * 16 + initial_ip
    stack_offset = initial_ss * 16 + initial_sp
    if entry_offset >= load_module_size:
        raise DosMzLoadModelError("MZ relative CS:IP is outside the load module")
    for index in range(relocation_count):
        position = relocation_offset + index * 4
        relocation_offset_in_segment = _word(data, position)
        relocation_segment = _word(data, position + 2)
        if relocation_segment * 16 + relocation_offset_in_segment + 2 > load_module_size:
            raise DosMzLoadModelError("MZ relocation target is outside the load module")
    return {
        "declared_size": declared_size,
        "header_size": header_size,
        "load_module_size": load_module_size,
        "load_module_start": header_size,
        "load_module_end_exclusive": declared_size,
        "load_module_sha256": load_module_sha256,
        "relocation_count": relocation_count,
        "relocation_offset": relocation_offset,
        "initial_cs": initial_cs,
        "initial_ip": initial_ip,
        "relative_entry_offset": entry_offset,
        "initial_ss": initial_ss,
        "initial_sp": initial_sp,
        "relative_stack_offset": stack_offset,
        "overlay_number": overlay_number,
    }


def collect_dos_mz_load_model(root: Path) -> dict[str, Any]:
    """Collect validated MZ-only load facts for every retained i8086 profile."""
    admission_path = root / "reverse_engineering/workflows/dos_i8086_load_model_admission.json"
    try:
        load_dos_i8086_load_model_admission(admission_path)
    except AdapterCatalogError as exc:
        raise DosMzLoadModelError(f"DOS candidate-admission contract is invalid: {exc}") from exc
    profiles: list[dict[str, Any]] = []
    for record_path in sorted((root / "reverse_engineering/derived/i8086").glob("*/analysis-run.json")):
        record = json.loads(record_path.read_text(encoding="utf-8"))
        input_path = record.get("input_path")
        expected_hash = record.get("derived_from_sha256")
        if not isinstance(input_path, str) or not isinstance(expected_hash, str):
            raise DosMzLoadModelError(f"{record_path}: missing immutable input identity")
        path = root / input_path
        if not path.is_file() or _sha256(path) != expected_hash:
            raise DosMzLoadModelError(f"{record_path}: retained input identity differs")
        header = parse_mz_header(path.read_bytes())
        profiles.append({"artifact_id": record["artifact_id"], "input_sha256": expected_hash, **header})
    if len(profiles) != 22:
        raise DosMzLoadModelError(f"expected 22 retained DOS MZ profiles, found {len(profiles)}")
    return {
        "schema_version": 1,
        "admission_state": "mz_header_and_relative_entry_verified_psp_and_runtime_unresolved",
        "execution_eligible": False,
        "profile_count": len(profiles),
        "profiles": profiles,
        "remaining_requirements": [
            "DOS PSP and actual load-segment policy",
            "memory allocation and runtime environment evidence",
            "qualified reanalysis configuration and cross-tool disagreement record",
        ],
        "non_claim": "MZ header validation establishes container-relative fields only; it does not establish runtime behavior, source recovery, or a complete DOS load model.",
    }


def validate_dos_mz_launch_capture_contract(contract: dict[str, Any], root: Path) -> None:
    """Validate a null-only future DOS MZ launch-capture contract without execution."""
    ledger = collect_dos_mz_load_model(root)
    if contract.get("schema_version") != 1 or contract.get("execution_eligible") is not False:
        raise DosMzLoadModelError("DOS launch-capture contract must remain non-executable")
    if contract.get("future_launch_capture_required_fields") != list(FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS):
        raise DosMzLoadModelError("DOS future launch-capture schema differs from the required fields")
    observations = contract.get("launch_capture_observations")
    if not isinstance(observations, dict) or set(observations) != {profile["artifact_id"] for profile in ledger["profiles"]}:
        raise DosMzLoadModelError("DOS launch-capture contract must cover exactly the retained MZ profiles")
    if any(value is not None for value in observations.values()):
        raise DosMzLoadModelError("no official DOS MZ launch capture is currently admitted")
