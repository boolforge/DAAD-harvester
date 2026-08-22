"""Validate retained ZX PLUS3DOS header facts without inferring execution state."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any


class ZxPlus3DosLoadModelError(ValueError):
    """Raised when a retained ZX PLUS3DOS header or identity is invalid."""


HEADER_SIZE = 128
FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS = (
    "official_p3f_sha256", "disk_or_loader_context_sha256", "plus3dos_rom_sha256",
    "loader_transition_sha256", "bootstrap_sector_sha256", "snapshot_sha256",
    "machine_model", "z80_registers", "port_7ffd", "port_1ffd", "bankm",
    "bank678", "ram_page_mapping", "rom_selection", "stack_state", "plus3dos_vector_bytes",
)


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parse_plus3dos_header(data: bytes) -> dict[str, int]:
    """Validate only checksum and declared plus3DOS header/payload boundaries."""
    if len(data) < HEADER_SIZE or not data.startswith(b"PLUS3DOS\x1a"):
        raise ZxPlus3DosLoadModelError("missing or truncated PLUS3DOS header")
    stored_checksum = data[127]
    computed_checksum = sum(data[:127]) & 0xFF
    if stored_checksum != computed_checksum:
        raise ZxPlus3DosLoadModelError("PLUS3DOS header checksum differs")
    declared_total = int.from_bytes(data[11:15], "little")
    declared_payload = int.from_bytes(data[16:18], "little")
    load_address = int.from_bytes(data[18:20], "little")
    if declared_total < HEADER_SIZE or declared_total > len(data):
        raise ZxPlus3DosLoadModelError("PLUS3DOS declared total is outside retained file")
    if declared_payload != declared_total - HEADER_SIZE:
        raise ZxPlus3DosLoadModelError("PLUS3DOS declared payload does not match declared total")
    return {
        "declared_total": declared_total,
        "declared_payload": declared_payload,
        "header_load_address": load_address,
        "physical_tail_size": len(data) - declared_total,
    }


def validate_zx_plus3dos_load_model(contract: dict[str, Any], root: Path) -> None:
    """Validate two ZX wrapper observations while preserving all execution gates."""
    if contract.get("schema_version") != 1:
        raise ZxPlus3DosLoadModelError("schema_version must be 1")
    if contract.get("admission_state") != "plus3dos_header_verified_payload_execution_unresolved":
        raise ZxPlus3DosLoadModelError("admission_state must retain unresolved payload execution")
    if contract.get("execution_eligible") is not False:
        raise ZxPlus3DosLoadModelError("PLUS3DOS header facts must not enable execution")
    if contract.get("future_launch_capture_required_fields") != list(FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS):
        raise ZxPlus3DosLoadModelError("ZX future launch-capture schema differs from the required fields")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or len(profiles) != 2:
        raise ZxPlus3DosLoadModelError("contract must contain exactly two ZX profiles")
    seen: set[str] = set()
    for profile in profiles:
        if not isinstance(profile, dict):
            raise ZxPlus3DosLoadModelError("profile must be an object")
        identifier = profile.get("artifact_id")
        if not isinstance(identifier, str) or identifier in seen:
            raise ZxPlus3DosLoadModelError("profile artifact_id values must be unique")
        seen.add(identifier)
        path_value = profile.get("input_path")
        expected_hash = profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise ZxPlus3DosLoadModelError(f"{identifier}: unsafe input path")
        if not isinstance(expected_hash, str) or len(expected_hash) != 64:
            raise ZxPlus3DosLoadModelError(f"{identifier}: missing SHA-256")
        path = root / path_value
        if not path.is_file() or _sha256(path) != expected_hash:
            raise ZxPlus3DosLoadModelError(f"{identifier}: retained P3F identity differs")
        fields = parse_plus3dos_header(path.read_bytes())
        if profile.get("declared_total") != fields["declared_total"] or profile.get("declared_payload") != fields["declared_payload"]:
            raise ZxPlus3DosLoadModelError(f"{identifier}: declared header facts differ")
        if profile.get("physical_tail_size") != fields["physical_tail_size"]:
            raise ZxPlus3DosLoadModelError(f"{identifier}: physical tail fact differs")
        if profile.get("launch_capture_observation") is not None:
            raise ZxPlus3DosLoadModelError(f"{identifier}: no official ZX launch capture is currently admitted")


def load_zx_plus3dos_load_model(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate the committed ZX PLUS3DOS contract without execution."""
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise ZxPlus3DosLoadModelError("ZX PLUS3DOS contract must be a JSON object")
    validate_zx_plus3dos_load_model(contract, root)
    return contract
