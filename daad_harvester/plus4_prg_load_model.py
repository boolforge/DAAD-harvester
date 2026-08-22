"""Validate Plus/4 PRG wrapper and BASIC-line evidence without C64 assumptions."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any


class Plus4PrgLoadModelError(ValueError):
    """Raised when a retained Plus/4 PRG wrapper or launcher line is altered."""


EXPECTED_LOAD_ADDRESS = 0x4001
EXPECTED_SYS_TARGET = 2063
EXPECTED_BASIC_LINE_END = 16


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parse_plus4_prg_wrapper(data: bytes) -> dict[str, int | bool]:
    """Validate only the observed Plus/4 PRG and single BASIC-line structure."""
    if len(data) < EXPECTED_BASIC_LINE_END + 1:
        raise Plus4PrgLoadModelError("truncated Plus/4 PRG wrapper")
    load_address = int.from_bytes(data[:2], "little")
    next_line = int.from_bytes(data[2:4], "little")
    line_number = int.from_bytes(data[4:6], "little")
    if load_address != EXPECTED_LOAD_ADDRESS:
        raise Plus4PrgLoadModelError("unexpected Plus/4 PRG load address")
    if next_line != 0x400D or line_number != 1 or data[6] != 0x9E:
        raise Plus4PrgLoadModelError("unrecognized Plus/4 BASIC launcher structure")
    if data[7:11] != b"2063" or data[11:14] != b":\x8f\x00" or data[14:16] != b"\x00\x00":
        raise Plus4PrgLoadModelError("unexpected Plus/4 BASIC SYS line bytes")
    sys_target = int(data[7:11])
    image_start = load_address
    image_end = load_address + len(data) - 2
    return {
        "load_address": load_address,
        "basic_line_number": line_number,
        "sys_target": sys_target,
        "basic_program_end_offset": EXPECTED_BASIC_LINE_END,
        "image_start": image_start,
        "image_end_exclusive": image_end,
        "sys_target_within_loaded_image": image_start <= sys_target < image_end,
    }


def validate_plus4_prg_load_model(contract: dict[str, Any], root: Path) -> None:
    """Validate the two retained Plus/4 PRG wrapper observations fail closed."""
    if contract.get("schema_version") != 1:
        raise Plus4PrgLoadModelError("schema_version must be 1")
    if contract.get("admission_state") != "prg_wrapper_verified_launcher_target_unresolved":
        raise Plus4PrgLoadModelError("admission_state must preserve the unresolved launcher target")
    if contract.get("execution_eligible") is not False:
        raise Plus4PrgLoadModelError("Plus/4 wrapper evidence must not enable execution")
    profiles = contract.get("profiles")
    if not isinstance(profiles, list) or len(profiles) != 2:
        raise Plus4PrgLoadModelError("contract must contain two Plus/4 profiles")
    identifiers: set[str] = set()
    for profile in profiles:
        if not isinstance(profile, dict):
            raise Plus4PrgLoadModelError("profile must be an object")
        identifier = profile.get("artifact_id")
        if not isinstance(identifier, str) or identifier in identifiers:
            raise Plus4PrgLoadModelError("profiles must have unique artifact_id values")
        identifiers.add(identifier)
        path_value = profile.get("input_path")
        expected_hash = profile.get("sha256")
        if not isinstance(path_value, str) or path_value.startswith("/") or ".." in Path(path_value).parts:
            raise Plus4PrgLoadModelError(f"{identifier}: unsafe input path")
        if not isinstance(expected_hash, str) or len(expected_hash) != 64:
            raise Plus4PrgLoadModelError(f"{identifier}: missing SHA-256")
        path = root / path_value
        if not path.is_file() or _sha256(path) != expected_hash:
            raise Plus4PrgLoadModelError(f"{identifier}: retained PRG identity differs")
        parsed = parse_plus4_prg_wrapper(path.read_bytes())
        for name, value in parsed.items():
            if profile.get(name) != value:
                raise Plus4PrgLoadModelError(f"{identifier}: {name} differs from retained PRG wrapper")
        if parsed["sys_target_within_loaded_image"]:
            raise Plus4PrgLoadModelError(f"{identifier}: expected unresolved SYS target must remain outside the PRG image")


def load_plus4_prg_load_model(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate the Plus/4 wrapper contract without executing the PRGs."""
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract, dict):
        raise Plus4PrgLoadModelError("Plus/4 contract must be a JSON object")
    validate_plus4_prg_load_model(contract, root)
    return contract
