"""Derive fail-closed DOS MZ header and relative-entry evidence from retained profiles."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any


class DosMzLoadModelError(ValueError):
    """Raised when a retained DOS MZ profile lacks valid header evidence."""


EXPECTED_CANDIDATE_ADMISSION = {
    "schema_version": 1,
    "purpose": "Fail-closed evidence contract for a future retained DOS i8086 COM or MZ static-analysis invocation.",
    "states": ["unclassified", "blocked", "admissible_for_candidate_comparison"],
    "common_required_evidence": ["artifact_hashes", "container_identification", "cpu_profile", "origin_or_load_segment", "entry_evidence", "cross_tool_disagreement_record"],
    "com_required_evidence": ["psp_relationship", "image_origin", "wrapper_or_delivery_container"],
    "mz_required_evidence": ["header_raw_bytes", "page_size_consistency", "header_paragraphs", "load_module_hash", "relocation_table_bounds", "initial_cs_ip", "initial_ss_sp", "allocation_fields", "psp_policy", "overlay_status"],
    "fail_closed_conditions": ["unknown_container", "invalid_or_truncated_mz_header", "relocation_outside_load_module", "unresolved_overlay", "extended_mz_derived_format", "missing_com_psp_or_origin", "missing_entry_or_load_segment", "raw_base_zero_only"],
    "analysis_boundary": "An admissible comparison may emit attributed tool decoding only. It does not recover source or establish behavior without separate evidence.",
}


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _word(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset:offset + 2], "little")


def validate_dos_i8086_candidate_admission(contract: dict[str, Any]) -> None:
    """Require the committed DOS candidate-admission boundary without promotion."""
    for field, expected in EXPECTED_CANDIDATE_ADMISSION.items():
        if contract.get(field) != expected:
            raise DosMzLoadModelError(f"DOS candidate-admission contract differs: {field}")


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
    candidate_admission = json.loads(admission_path.read_text(encoding="utf-8"))
    if not isinstance(candidate_admission, dict):
        raise DosMzLoadModelError("DOS candidate-admission contract must be an object")
    validate_dos_i8086_candidate_admission(candidate_admission)
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
