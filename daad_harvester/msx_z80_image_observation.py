"""Validate immutable MSX Z80 image and leading-jump observations fail closed."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any


class MsxZ80ImageObservationError(ValueError):
    """Raised when an MSX image observation or identity does not match retained bytes."""


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parse_msx_z80_image_prefix(data: bytes) -> dict[str, int]:
    """Measure the first Z80 absolute jump without inferring a load address."""
    if len(data) < 3:
        raise MsxZ80ImageObservationError("truncated MSX Z80 image")
    if data[0] != 0xC3:
        raise MsxZ80ImageObservationError("MSX image does not begin with absolute JP opcode")
    return {"leading_jump_target": int.from_bytes(data[1:3], "little"), "image_size": len(data)}


def validate_msx_z80_image_observation(contract: dict[str, Any], root: Path) -> None:
    """Validate two MSX image observations without granting execution eligibility."""
    if contract.get("schema_version") != 1:
        raise MsxZ80ImageObservationError("schema_version must be 1")
    if contract.get("admission_state") != "image_identity_and_leading_jump_observed_load_unresolved":
        raise MsxZ80ImageObservationError("admission_state must preserve unresolved load conditions")
    if contract.get("execution_eligible") is not False:
        raise MsxZ80ImageObservationError("MSX image observation must not enable execution")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or len(profiles) != 2:
        raise MsxZ80ImageObservationError("contract must contain exactly two MSX profiles")
    seen: set[str] = set()
    for profile in profiles:
        if not isinstance(profile, dict):
            raise MsxZ80ImageObservationError("profile must be an object")
        identifier = profile.get("artifact_id")
        if not isinstance(identifier, str) or identifier in seen:
            raise MsxZ80ImageObservationError("profile artifact_id values must be unique")
        seen.add(identifier)
        path_value = profile.get("input_path")
        expected_hash = profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise MsxZ80ImageObservationError(f"{identifier}: unsafe input path")
        if not isinstance(expected_hash, str) or len(expected_hash) != 64:
            raise MsxZ80ImageObservationError(f"{identifier}: missing SHA-256")
        path = root / path_value
        if not path.is_file() or _sha256(path) != expected_hash:
            raise MsxZ80ImageObservationError(f"{identifier}: retained MSX image identity differs")
        observed = parse_msx_z80_image_prefix(path.read_bytes())
        for field in ("leading_jump_target", "image_size"):
            if profile.get(field) != observed[field]:
                raise MsxZ80ImageObservationError(f"{identifier}: {field} differs from retained bytes")


def load_msx_z80_image_observation(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate the MSX image observation contract without execution."""
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise MsxZ80ImageObservationError("MSX observation must be a JSON object")
    validate_msx_z80_image_observation(contract, root)
    return contract
