"""Validate retained CPC AMSDOS program headers and declared entry boundaries."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any


class CpcAmsdosLoadModelError(ValueError):
    """Raised when a retained CPC AMSDOS program contract is invalid or altered."""


HEADER_SIZE = 128
FUTURE_CAPTURE_REQUIRED_FIELDS = [
    "official_program_sha256",
    "snapshot_sha256",
    "snapshot_format",
    "emulator_name",
    "emulator_version",
    "machine_model",
    "loader_transition_sha256",
    "entry_pc",
    "z80_registers_sha256",
    "gate_array_configuration",
    "gate_array_ram_configuration",
    "upper_rom_number",
    "firmware_rom_sha256",
    "pio_state_sha256",
    "psg_state_sha256",
    "memory_dump_sha256",
    "memory_dump_size",
]


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parse_amsdos_binary_header(data: bytes) -> dict[str, int]:
    """Validate only AMSDOS binary-header facts needed for bounded loading."""
    if len(data) < HEADER_SIZE:
        raise CpcAmsdosLoadModelError("truncated AMSDOS header")
    binary_type = data[0x12]
    if binary_type != 0x02:
        raise CpcAmsdosLoadModelError("retained CPC header is not AMSDOS binary type 2")
    load_address = int.from_bytes(data[0x15:0x17], "little")
    logical_size = int.from_bytes(data[0x18:0x1A], "little")
    entry_address = int.from_bytes(data[0x1A:0x1C], "little")
    real_size = int.from_bytes(data[0x40:0x43], "little")
    stored_checksum = int.from_bytes(data[0x43:0x45], "little")
    computed_checksum = sum(data[:0x43]) & 0xFFFF
    stored_payload_size = len(data) - HEADER_SIZE
    if stored_checksum != computed_checksum:
        raise CpcAmsdosLoadModelError("AMSDOS header checksum differs")
    if logical_size != stored_payload_size or real_size != stored_payload_size:
        raise CpcAmsdosLoadModelError("AMSDOS declared payload size differs")
    if not load_address <= entry_address < load_address + stored_payload_size:
        raise CpcAmsdosLoadModelError("AMSDOS entry is outside the loaded payload")
    return {
        "binary_type": binary_type,
        "load_address": load_address,
        "entry_address": entry_address,
        "logical_payload_size": logical_size,
        "real_payload_size": real_size,
        "stored_payload_size": stored_payload_size,
        "stored_header_checksum": stored_checksum,
    }


def validate_cpc_amsdos_load_model(contract: dict[str, Any], root: Path) -> None:
    """Validate two CPC header observations while retaining runtime refusal gates."""
    if contract.get("schema_version") != 1:
        raise CpcAmsdosLoadModelError("schema_version must be 1")
    if contract.get("admission_state") != "amsdos_header_load_and_entry_verified_memory_unresolved":
        raise CpcAmsdosLoadModelError("admission_state must retain unresolved CPC memory state")
    if contract.get("execution_eligible") is not False:
        raise CpcAmsdosLoadModelError("AMSDOS header facts must not enable execution")
    if contract.get("future_capture_required_fields") != FUTURE_CAPTURE_REQUIRED_FIELDS:
        raise CpcAmsdosLoadModelError("contract must preserve the CPC future-capture field schema")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or len(profiles) != 2:
        raise CpcAmsdosLoadModelError("contract must contain exactly two CPC profiles")
    seen: set[str] = set()
    for profile in profiles:
        if not isinstance(profile, dict):
            raise CpcAmsdosLoadModelError("profile must be an object")
        identifier = profile.get("artifact_id")
        if not isinstance(identifier, str) or identifier in seen:
            raise CpcAmsdosLoadModelError("profile artifact_id values must be unique")
        seen.add(identifier)
        path_value = profile.get("input_path")
        expected_hash = profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise CpcAmsdosLoadModelError(f"{identifier}: unsafe input path")
        if not isinstance(expected_hash, str) or len(expected_hash) != 64:
            raise CpcAmsdosLoadModelError(f"{identifier}: missing SHA-256")
        path = root / path_value
        if not path.is_file() or _sha256(path) != expected_hash:
            raise CpcAmsdosLoadModelError(f"{identifier}: retained CPC identity differs")
        fields = parse_amsdos_binary_header(path.read_bytes())
        for name in ("load_address", "entry_address", "logical_payload_size", "stored_header_checksum"):
            if profile.get(name) != fields[name]:
                raise CpcAmsdosLoadModelError(f"{identifier}: {name} differs from retained header")
        if profile.get("entry_environment_observation") is not None:
            raise CpcAmsdosLoadModelError(f"{identifier}: no official CPC entry-environment capture is currently admitted")


def load_cpc_amsdos_load_model(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate the committed CPC AMSDOS contract without execution."""
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise CpcAmsdosLoadModelError("CPC AMSDOS contract must be a JSON object")
    validate_cpc_amsdos_load_model(contract, root)
    return contract
