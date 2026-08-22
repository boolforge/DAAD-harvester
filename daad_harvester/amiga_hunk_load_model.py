"""Validate bounded Amiga Hunk executable container structure without execution."""

from __future__ import annotations

import hashlib
import json
import struct
from pathlib import Path
from typing import Any


class AmigaHunkLoadModelError(ValueError):
    """Raised when a retained Amiga Hunk container is malformed or altered."""


HUNK_HEADER = 0x3F3
HUNK_CODE = 0x3E9
HUNK_RELOC32 = 0x3EC
HUNK_END = 0x3F2
FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS = ("official_hunk_sha256", "loader_context_sha256", "kickstart_rom_sha256", "amigados_identity", "loadseg_transition_sha256", "bootstrap_medium_sha256", "snapshot_sha256", "machine_configuration", "segment_list_mapping", "segment_allocation_addresses", "process_context", "cli_context", "m68000_registers", "stack_state", "library_device_state")


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _word(data: bytes, offset: int) -> tuple[int, int]:
    if offset + 4 > len(data):
        raise AmigaHunkLoadModelError("truncated Hunk word")
    return struct.unpack_from(">I", data, offset)[0], offset + 4


def parse_amiga_hunk_executable(data: bytes) -> dict[str, int]:
    """Validate the retained one-code-hunk and HUNK_RELOC32 container subset."""
    offset = 0
    marker, offset = _word(data, offset)
    if marker != HUNK_HEADER:
        raise AmigaHunkLoadModelError("missing HUNK_HEADER")
    name_words, offset = _word(data, offset)
    if name_words != 0:
        raise AmigaHunkLoadModelError("unexpected resident-name hunk in retained executable")
    table_size, offset = _word(data, offset)
    first_hunk, offset = _word(data, offset)
    last_hunk, offset = _word(data, offset)
    if table_size != 1 or first_hunk != 0 or last_hunk != 0:
        raise AmigaHunkLoadModelError("expected exactly one allocated Hunk")
    declared_size_word, offset = _word(data, offset)
    declared_code_longwords = declared_size_word & 0x3FFFFFFF
    marker, offset = _word(data, offset)
    if marker != HUNK_CODE:
        raise AmigaHunkLoadModelError("expected HUNK_CODE after header")
    code_longwords, offset = _word(data, offset)
    if code_longwords != declared_code_longwords:
        raise AmigaHunkLoadModelError("HUNK_CODE size differs from header allocation")
    code_size = code_longwords * 4
    if offset + code_size > len(data):
        raise AmigaHunkLoadModelError("truncated HUNK_CODE payload")
    offset += code_size
    marker, offset = _word(data, offset)
    if marker != HUNK_RELOC32:
        raise AmigaHunkLoadModelError("expected HUNK_RELOC32 after code payload")
    relocation_count = 0
    while True:
        count, offset = _word(data, offset)
        if count == 0:
            break
        target_hunk, offset = _word(data, offset)
        if target_hunk != 0:
            raise AmigaHunkLoadModelError("relocation target exceeds retained one-Hunk table")
        if count > code_longwords or offset + (count * 4) > len(data):
            raise AmigaHunkLoadModelError("unbounded HUNK_RELOC32 offset group")
        for _ in range(count):
            relocation_offset, offset = _word(data, offset)
            if relocation_offset % 2 or relocation_offset + 4 > code_size:
                raise AmigaHunkLoadModelError("HUNK_RELOC32 offset lies outside code payload")
        relocation_count += count
    marker, offset = _word(data, offset)
    if marker != HUNK_END or offset != len(data):
        raise AmigaHunkLoadModelError("expected terminal HUNK_END with no trailing bytes")
    return {"code_longwords": code_longwords, "code_size": code_size, "relocation_count": relocation_count}


def validate_amiga_hunk_load_model(contract: dict[str, Any], root: Path) -> None:
    """Validate four retained Amiga Hunk containers without enabling execution."""
    if contract.get("schema_version") != 1:
        raise AmigaHunkLoadModelError("schema_version must be 1")
    if contract.get("admission_state") != "hunk_container_and_relocations_verified_runtime_unresolved":
        raise AmigaHunkLoadModelError("admission_state must retain unresolved Amiga runtime")
    if contract.get("execution_eligible") is not False:
        raise AmigaHunkLoadModelError("Hunk container facts must not enable execution")
    if contract.get("future_launch_capture_required_fields") != list(FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS):
        raise AmigaHunkLoadModelError("Amiga future launch-capture schema differs from the required fields")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or len(profiles) != 4:
        raise AmigaHunkLoadModelError("contract must contain exactly four Amiga profiles")
    seen: set[str] = set()
    for profile in profiles:
        if not isinstance(profile, dict):
            raise AmigaHunkLoadModelError("profile must be an object")
        identifier = profile.get("artifact_id")
        if not isinstance(identifier, str) or identifier in seen:
            raise AmigaHunkLoadModelError("profile artifact_id values must be unique")
        seen.add(identifier)
        path_value = profile.get("input_path")
        expected_hash = profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise AmigaHunkLoadModelError(f"{identifier}: unsafe input path")
        if not isinstance(expected_hash, str) or len(expected_hash) != 64:
            raise AmigaHunkLoadModelError(f"{identifier}: missing SHA-256")
        path = root / path_value
        if not path.is_file() or _sha256(path) != expected_hash:
            raise AmigaHunkLoadModelError(f"{identifier}: retained Amiga identity differs")
        fields = parse_amiga_hunk_executable(path.read_bytes())
        for field in ("code_longwords", "code_size", "relocation_count"):
            if profile.get(field) != fields[field]:
                raise AmigaHunkLoadModelError(f"{identifier}: {field} differs from retained Hunk records")
        if profile.get("launch_capture_observation") is not None:
            raise AmigaHunkLoadModelError(f"{identifier}: no official Amiga launch capture is currently admitted")


def load_amiga_hunk_load_model(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate the committed Amiga Hunk contract without execution."""
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise AmigaHunkLoadModelError("Amiga Hunk contract must be a JSON object")
    validate_amiga_hunk_load_model(contract, root)
    return contract
