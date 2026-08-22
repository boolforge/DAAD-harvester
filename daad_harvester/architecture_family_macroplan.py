"""Validate the autonomous architecture-family verification macroplan ledger."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any


class ArchitectureFamilyMacroplanError(ValueError):
    """Raised when a workstream omits an evidence gate or crosses families."""


REQUIRED_WORKSTREAM_IDS = {
    "c64_mos6502",
    "plus4_mos8501",
    "z80_by_platform",
    "amiga_m68000",
    "atari_st_m68000",
    "dos_i8086",
    "behavioral_evidence",
    "scummvm_readiness",
}

ALLOWED_ANALYSIS_STATES = {
    "raw_base_unverified",
    "container_or_partial_load_verified",
    "qualified_analysis_pending_disagreement",
    "behavioral_evidence_only",
    "not_ready_for_implementation",
}


def validate_architecture_family_macroplan(ledger: dict[str, Any]) -> None:
    """Validate autonomous workstream boundaries without executing retained inputs."""
    if ledger.get("schema_version") != 1:
        raise ArchitectureFamilyMacroplanError("schema_version must be 1")
    workstreams = ledger.get("workstreams")
    if not isinstance(workstreams, list):
        raise ArchitectureFamilyMacroplanError("workstreams must be a list")
    seen: set[str] = set()
    for stream in workstreams:
        if not isinstance(stream, dict):
            raise ArchitectureFamilyMacroplanError("workstream must be an object")
        identifier = stream.get("id")
        if not isinstance(identifier, str) or identifier in seen:
            raise ArchitectureFamilyMacroplanError("workstream ids must be unique strings")
        seen.add(identifier)
        population = stream.get("population")
        if not isinstance(population, int) or population < 0:
            raise ArchitectureFamilyMacroplanError(f"{identifier}: population must be non-negative")
        for field in ("verified_fields", "unresolved_fields"):
            value = stream.get(field)
            if not isinstance(value, list) or not value or not all(isinstance(item, str) and item for item in value):
                raise ArchitectureFamilyMacroplanError(f"{identifier}: {field} must be a non-empty string list")
        if stream.get("analysis_state") not in ALLOWED_ANALYSIS_STATES:
            raise ArchitectureFamilyMacroplanError(f"{identifier}: invalid analysis_state")
        if stream.get("disagreement_state") not in {"not_recorded", "not_applicable_before_qualified_analysis", "recorded"}:
            raise ArchitectureFamilyMacroplanError(f"{identifier}: invalid disagreement_state")
        if not isinstance(stream.get("last_validated_commit"), str) or len(stream["last_validated_commit"]) != 7:
            raise ArchitectureFamilyMacroplanError(f"{identifier}: last_validated_commit must be a short commit id")
        if not isinstance(stream.get("next_reproducer"), str) or not stream["next_reproducer"].startswith("python3 "):
            raise ArchitectureFamilyMacroplanError(f"{identifier}: next_reproducer must be a deterministic Python command")
        forbidden = stream.get("forbidden_cross_family_evidence")
        if not isinstance(forbidden, list) or not forbidden or not all(isinstance(item, str) and item for item in forbidden):
            raise ArchitectureFamilyMacroplanError(f"{identifier}: cross-family boundary must be explicit")
    if seen != REQUIRED_WORKSTREAM_IDS:
        missing = sorted(REQUIRED_WORKSTREAM_IDS - seen)
        extra = sorted(seen - REQUIRED_WORKSTREAM_IDS)
        raise ArchitectureFamilyMacroplanError(f"workstream ids differ; missing={missing}, extra={extra}")


def load_architecture_family_macroplan(path: Path) -> dict[str, Any]:
    """Load and validate the committed macroplan ledger."""
    ledger = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(ledger, dict):
        raise ArchitectureFamilyMacroplanError("macroplan must be a JSON object")
    validate_architecture_family_macroplan(ledger)
    return ledger
