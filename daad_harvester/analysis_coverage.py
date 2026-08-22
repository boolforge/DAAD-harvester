"""Derive a fail-closed coverage ledger from retained static-analysis records.

The ledger inventories existing derived records. It does not assess correctness
of disassembly, infer runtime behavior, or authorize another retained-byte run.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any


class AnalysisCoverageError(ValueError):
    """Raised when a retained analysis record cannot support a coverage entry."""


REQUIRED_ANALYSIS_KEYS = {
    "schema_version",
    "analysis_state",
    "architecture",
    "artifact_id",
    "derived_from_sha256",
    "input_path",
    "load_model",
    "non_claim",
    "outputs",
    "tool_records",
}


def _current_contract_progress(artifact_id: str, architecture: str) -> tuple[str, str]:
    """Return independent current container-evidence progress for a retained profile."""
    if architecture == "i8086":
        return (
            "mz_header_load_module_and_relative_entry_verified_psp_runtime_unresolved",
            "docs/reverse_engineering/DOS_MZ_HEADER_LOAD_MODEL_LEDGER.md",
        )
    if artifact_id.startswith("daad-c64-"):
        return ("prg_wrapper_verified_official_entry_state_not_observed", "docs/reverse_engineering/C64_PRG_ENTRY_STATE_ADMISSION.md")
    if artifact_id.startswith("daad-plus4-"):
        return ("prg_wrapper_verified_launcher_target_unresolved", "docs/reverse_engineering/PLUS4_PRG_LOAD_MODEL_ADMISSION.md")
    if artifact_id.startswith("daad-zx-"):
        return ("plus3dos_header_and_payload_bounds_verified_execution_unresolved", "docs/reverse_engineering/ZX_PLUS3DOS_LOAD_MODEL_ADMISSION.md")
    if artifact_id.startswith("daad-cpc-"):
        return ("amsdos_header_load_and_entry_verified_memory_unresolved", "docs/reverse_engineering/CPC_AMSDOS_LOAD_MODEL_ADMISSION.md")
    if artifact_id.startswith("daad-msx-"):
        return ("image_identity_and_leading_jump_observed_load_unresolved", "docs/reverse_engineering/MSX_Z80_IMAGE_OBSERVATION.md")
    if artifact_id.startswith("daad-pcw-"):
        return ("image_identity_and_bdos_call_observed_load_unresolved", "docs/reverse_engineering/PCW_Z80_IMAGE_OBSERVATION.md")
    if artifact_id.startswith("daad-amiga-"):
        return ("hunk_container_and_relocations_verified_runtime_unresolved", "docs/reverse_engineering/AMIGA_HUNK_LOAD_MODEL_ADMISSION.md")
    if artifact_id.startswith("daad-atarist-"):
        return ("prg_segments_and_relocations_verified_runtime_unresolved", "docs/reverse_engineering/ATARI_ST_PRG_LOAD_MODEL_ADMISSION.md")
    raise AnalysisCoverageError(f"{artifact_id}: no independent container-evidence progress contract")


def _load_record(path: Path) -> dict[str, Any]:
    payload = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(payload, dict):
        raise AnalysisCoverageError(f"{path}: analysis record must be an object")
    missing = REQUIRED_ANALYSIS_KEYS - payload.keys()
    if missing:
        raise AnalysisCoverageError(f"{path}: missing required keys: {', '.join(sorted(missing))}")
    if payload["schema_version"] != 1:
        raise AnalysisCoverageError(f"{path}: unsupported schema version")
    if not isinstance(payload["artifact_id"], str) or not payload["artifact_id"]:
        raise AnalysisCoverageError(f"{path}: artifact_id must be a non-empty string")
    if not isinstance(payload["architecture"], str) or not payload["architecture"]:
        raise AnalysisCoverageError(f"{path}: architecture must be a non-empty string")
    if not isinstance(payload["load_model"], str) or not payload["load_model"]:
        raise AnalysisCoverageError(f"{path}: load_model must be explicit")
    if not isinstance(payload["outputs"], list) or not payload["outputs"]:
        raise AnalysisCoverageError(f"{path}: outputs must be a non-empty list")
    if not isinstance(payload["tool_records"], list) or not payload["tool_records"]:
        raise AnalysisCoverageError(f"{path}: tool_records must be a non-empty list")
    return payload


def collect_analysis_coverage(root: Path) -> dict[str, Any]:
    """Return a deterministic, fail-closed inventory of retained analysis records."""
    entries: list[dict[str, Any]] = []
    seen_artifact_ids: set[str] = set()
    for path in sorted((root / "reverse_engineering/derived").glob("**/analysis-run.json")):
        record = _load_record(path)
        artifact_id = record["artifact_id"]
        if artifact_id in seen_artifact_ids:
            raise AnalysisCoverageError(f"duplicate artifact_id: {artifact_id}")
        seen_artifact_ids.add(artifact_id)
        tools = sorted({tool["tool"] for tool in record["tool_records"] if isinstance(tool, dict) and isinstance(tool.get("tool"), str)})
        if not tools:
            raise AnalysisCoverageError(f"{path}: no named analyzer lane")
        outputs = sorted(
            {output["path"]: output["sha256"] for output in record["outputs"] if isinstance(output, dict) and isinstance(output.get("path"), str) and isinstance(output.get("sha256"), str)}.items()
        )
        if not outputs:
            raise AnalysisCoverageError(f"{path}: outputs lack path/hash identity")
        raw_load = record["load_model"] == "raw_binary_base_0_unverified"
        progress_state, progress_reference = _current_contract_progress(artifact_id, record["architecture"])
        entries.append(
            {
                "artifact_id": artifact_id,
                "architecture": record["architecture"],
                "input_sha256": record["derived_from_sha256"],
                "analysis_state": record["analysis_state"],
                "load_model": record["load_model"],
                "container_evidence_progress": progress_state,
                "container_evidence_reference": progress_reference,
                "configured_analyzer_lanes": tools,
                "output_hashes": [{"path": output_path, "sha256": output_hash} for output_path, output_hash in outputs],
                "cross_tool_disagreement_state": "not_recorded",
                "retained_execution_state": "refused_pending_full_load_model" if raw_load else "not_admitted",
                "non_claim": record["non_claim"],
            }
        )
    if not entries:
        raise AnalysisCoverageError("no retained analysis records found")
    architecture_counts: dict[str, int] = {}
    for entry in entries:
        architecture_counts[entry["architecture"]] = architecture_counts.get(entry["architecture"], 0) + 1
    return {
        "schema_version": 1,
        "purpose": "Deterministic coverage inventory of existing retained static-analysis records; it does not authorize retained-byte analysis or establish recovered source or runtime behavior.",
        "profile_count": len(entries),
        "architecture_counts": dict(sorted(architecture_counts.items())),
        "profiles": entries,
    }
