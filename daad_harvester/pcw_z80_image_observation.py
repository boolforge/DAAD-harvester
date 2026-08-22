"""Validate immutable PCW Z80 image observations without assuming CP/M execution."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any


class PcwZ80ImageObservationError(ValueError):
    """Raised when a retained PCW image observation differs from retained bytes."""


BDOS_CALL_OFFSET = 16
BDOS_CALL_BYTES = b"\xcd\x05\x00"
FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS = (
    "official_image_sha256",
    "loader_or_disk_context_sha256",
    "cpm_system_image_sha256",
    "ccp_to_tpa_transition_sha256",
    "snapshot_sha256",
    "machine_model",
    "cpm_version",
    "z80_registers",
    "pcw_memory_paging",
    "zero_page_bank_state",
    "tpa_range",
    "bdos_vector_bytes",
)


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parse_pcw_z80_image_prefix(data: bytes) -> dict[str, int]:
    """Measure the demonstrated leading BDOS-call sequence without executing it."""
    if len(data) < BDOS_CALL_OFFSET + len(BDOS_CALL_BYTES):
        raise PcwZ80ImageObservationError("truncated PCW Z80 image")
    if data[BDOS_CALL_OFFSET:BDOS_CALL_OFFSET + len(BDOS_CALL_BYTES)] != BDOS_CALL_BYTES:
        raise PcwZ80ImageObservationError("expected leading CP/M BDOS call bytes differ")
    return {"bdos_call_offset": BDOS_CALL_OFFSET, "bdos_call_target": 5, "image_size": len(data)}


def validate_pcw_z80_image_observation(contract: dict[str, Any], root: Path) -> None:
    """Validate two PCW image observations while retaining all CP/M assumptions unresolved."""
    if contract.get("schema_version") != 1:
        raise PcwZ80ImageObservationError("schema_version must be 1")
    if contract.get("admission_state") != "image_identity_and_bdos_call_observed_load_unresolved":
        raise PcwZ80ImageObservationError("admission_state must preserve unresolved PCW load conditions")
    if contract.get("execution_eligible") is not False:
        raise PcwZ80ImageObservationError("PCW image observation must not enable execution")
    if contract.get("future_launch_capture_required_fields") != list(FUTURE_LAUNCH_CAPTURE_REQUIRED_FIELDS):
        raise PcwZ80ImageObservationError("PCW future launch-capture schema differs from the required fields")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or len(profiles) != 2:
        raise PcwZ80ImageObservationError("contract must contain exactly two PCW profiles")
    seen: set[str] = set()
    for profile in profiles:
        if not isinstance(profile, dict):
            raise PcwZ80ImageObservationError("profile must be an object")
        identifier = profile.get("artifact_id")
        if not isinstance(identifier, str) or identifier in seen:
            raise PcwZ80ImageObservationError("profile artifact_id values must be unique")
        seen.add(identifier)
        path_value = profile.get("input_path")
        expected_hash = profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise PcwZ80ImageObservationError(f"{identifier}: unsafe input path")
        if not isinstance(expected_hash, str) or len(expected_hash) != 64:
            raise PcwZ80ImageObservationError(f"{identifier}: missing SHA-256")
        path = root / path_value
        if not path.is_file() or _sha256(path) != expected_hash:
            raise PcwZ80ImageObservationError(f"{identifier}: retained PCW image identity differs")
        observed = parse_pcw_z80_image_prefix(path.read_bytes())
        for field in ("bdos_call_offset", "bdos_call_target", "image_size"):
            if profile.get(field) != observed[field]:
                raise PcwZ80ImageObservationError(f"{identifier}: {field} differs from retained bytes")
        if profile.get("launch_capture_observation") is not None:
            raise PcwZ80ImageObservationError(f"{identifier}: no official PCW launch capture is currently admitted")


def load_pcw_z80_image_observation(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate the PCW image observation contract without execution."""
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise PcwZ80ImageObservationError("PCW observation must be a JSON object")
    validate_pcw_z80_image_observation(contract, root)
    return contract
