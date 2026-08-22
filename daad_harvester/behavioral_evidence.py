"""Validate fail-closed runtime-capture observations for future engine differential tests.

This module validates capture provenance and observable byte ranges. It never
interprets an emulator capture as complete game behavior or engine equivalence.
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path, PurePosixPath
from typing import Any


class BehavioralEvidenceError(ValueError):
    """Raised when a runtime-capture observation is incomplete or altered."""


SHA256_LENGTH = 64
REQUIRED_KEYS = {
    "schema_version",
    "record_id",
    "evidence_kind",
    "eligible_for_equivalence",
    "claim_boundary",
    "release",
    "emulator",
    "input",
    "checkpoint",
    "capture",
    "observable",
}


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _require_sha256(value: object, field: str) -> str:
    if not isinstance(value, str) or len(value) != SHA256_LENGTH:
        raise BehavioralEvidenceError(f"{field} must be a SHA-256 hex string")
    try:
        int(value, 16)
    except ValueError as exc:
        raise BehavioralEvidenceError(f"{field} must be a SHA-256 hex string") from exc
    return value


def _safe_relative_path(value: object, field: str) -> Path:
    if not isinstance(value, str):
        raise BehavioralEvidenceError(f"{field} must be a repository-relative path")
    candidate = PurePosixPath(value)
    if candidate.is_absolute() or ".." in candidate.parts:
        raise BehavioralEvidenceError(f"{field} must be a safe repository-relative path")
    return Path(*candidate.parts)


def _validate_file_reference(root: Path, value: object, field: str) -> None:
    if not isinstance(value, dict):
        raise BehavioralEvidenceError(f"{field} must be an object")
    path = _safe_relative_path(value.get("path"), f"{field}.path")
    expected = _require_sha256(value.get("sha256"), f"{field}.sha256")
    target = root / path
    if not target.is_file():
        raise BehavioralEvidenceError(f"{field}.path does not exist: {path.as_posix()}")
    if _sha256(target) != expected:
        raise BehavioralEvidenceError(f"{field}.sha256 differs from the retained file")


def validate_behavioral_observation(record: dict[str, Any], root: Path) -> None:
    """Validate one non-equivalence runtime-capture observation against retained files."""
    missing = REQUIRED_KEYS - record.keys()
    if missing:
        raise BehavioralEvidenceError(f"record is missing required keys: {', '.join(sorted(missing))}")
    if record["schema_version"] != 1:
        raise BehavioralEvidenceError("schema_version must be 1")
    if not isinstance(record["record_id"], str) or not record["record_id"].endswith("-v1"):
        raise BehavioralEvidenceError("record_id must be a versioned string ending in -v1")
    if record["evidence_kind"] != "runtime_capture_observation":
        raise BehavioralEvidenceError("evidence_kind must be runtime_capture_observation")
    if record["eligible_for_equivalence"] is not False:
        raise BehavioralEvidenceError("initial capture observations must not be eligible for equivalence")
    if not isinstance(record["claim_boundary"], str) or "not" not in record["claim_boundary"].lower():
        raise BehavioralEvidenceError("claim_boundary must explicitly deny a broader claim")

    release = record["release"]
    if not isinstance(release, dict) or release.get("platform") != "c64":
        raise BehavioralEvidenceError("release.platform must identify the observed C64 scope")
    _validate_file_reference(root, release.get("media"), "release.media")

    emulator = record["emulator"]
    if not isinstance(emulator, dict) or not all(isinstance(emulator.get(key), str) and emulator[key] for key in ("name", "version", "frontend")):
        raise BehavioralEvidenceError("emulator must identify a name, version, and frontend")
    if not isinstance(emulator.get("limit_cycles"), int) or emulator["limit_cycles"] <= 0:
        raise BehavioralEvidenceError("emulator.limit_cycles must be a positive integer")
    _validate_file_reference(root, emulator.get("command_log"), "emulator.command_log")
    _validate_file_reference(root, record["input"], "input")

    checkpoint = record["checkpoint"]
    if not isinstance(checkpoint, dict) or not isinstance(checkpoint.get("cycle"), int) or checkpoint["cycle"] <= 0:
        raise BehavioralEvidenceError("checkpoint.cycle must be a positive integer")
    _validate_file_reference(root, checkpoint.get("monitor_log"), "checkpoint.monitor_log")

    capture = record["capture"]
    if not isinstance(capture, dict):
        raise BehavioralEvidenceError("capture must be an object")
    _validate_file_reference(root, capture.get("snapshot"), "capture.snapshot")
    _validate_file_reference(root, capture.get("ram"), "capture.ram")

    observable = record["observable"]
    if not isinstance(observable, dict) or observable.get("kind") != "native_ddb_recovery":
        raise BehavioralEvidenceError("observable.kind must be native_ddb_recovery")
    if not isinstance(observable.get("ram_offset"), int) or observable["ram_offset"] < 0:
        raise BehavioralEvidenceError("observable.ram_offset must be a non-negative integer")
    if not isinstance(observable.get("size"), int) or observable["size"] <= 0:
        raise BehavioralEvidenceError("observable.size must be a positive integer")
    _validate_file_reference(root, observable.get("recovered_ddb"), "observable.recovered_ddb")

    ram_path = root / _safe_relative_path(capture["ram"].get("path"), "capture.ram.path")
    ddb_path = root / _safe_relative_path(observable["recovered_ddb"].get("path"), "observable.recovered_ddb.path")
    recovered = ram_path.read_bytes()[observable["ram_offset"]:observable["ram_offset"] + observable["size"]]
    if recovered != ddb_path.read_bytes():
        raise BehavioralEvidenceError("observable recovered DDB does not match the declared RAM range")


def load_behavioral_observation(path: Path, root: Path) -> dict[str, Any]:
    """Load and validate a JSON observation without invoking an emulator."""
    record = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(record, dict):
        raise BehavioralEvidenceError("behavioral observation must be a JSON object")
    validate_behavioral_observation(record, root)
    return record
