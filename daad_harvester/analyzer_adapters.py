"""Validate and select evidence-bounded static-analysis adapters.

An adapter describes a tool's CPU scope, pinned provenance, raw-load-model
compatibility, output capture, and commentary boundary.  It does not validate a
load model, execute a retained binary, or turn tool output into recovered source.
"""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path
from typing import Any


CATALOG_SCHEMA_VERSION = 1
GHIDRA_HEALTH_SCHEMA_VERSION = 1
CONFIGURED = "configured"
CANDIDATE = "candidate"
VALID_STATES = frozenset({CONFIGURED, CANDIDATE})
VALID_ROLES = frozenset({"structured_analysis", "control_flow_analysis", "static_disassembly"})
VALID_RUNNERS = frozenset({"ghidra_headless_binary", "radare2_static", "architecture_static", "external_candidate"})
VALID_ADMISSION_STATES = frozenset({"discovery", "health_checked", "blocked_by_load_model"})
VALID_GHIDRA_HOST_STATUSES = frozenset({"health_checked", "documented_unchecked", "blocked"})
COMMENTARY_LAYERS = ("bytes", "decoded_instructions", "tool_hypotheses", "evidenced_behavior")
_ADAPTER_ID = re.compile(r"^[a-z0-9][a-z0-9-]*-v[1-9][0-9]*$")
_SHA256 = re.compile(r"^[0-9a-f]{64}$")


class AdapterCatalogError(ValueError):
    """Raised when an analyzer-adapter catalog is incomplete or contradictory."""


def _require_string(mapping: dict[str, Any], key: str, label: str) -> str:
    value = mapping.get(key)
    if not isinstance(value, str) or not value.strip():
        raise AdapterCatalogError(f"{label}: {key} must be a non-empty string")
    return value


def _require_string_list(mapping: dict[str, Any], key: str, label: str) -> list[str]:
    value = mapping.get(key)
    if not isinstance(value, list) or not value or any(not isinstance(item, str) or not item for item in value):
        raise AdapterCatalogError(f"{label}: {key} must be a non-empty list of strings")
    if len(set(value)) != len(value):
        raise AdapterCatalogError(f"{label}: {key} must not contain duplicates")
    return value


def validate_catalog(catalog: dict[str, Any], workflow: dict[str, Any] | None = None) -> None:
    """Validate adapter metadata and, when supplied, its toolchain compatibility."""

    if catalog.get("schema_version") != CATALOG_SCHEMA_VERSION:
        raise AdapterCatalogError("catalog: unsupported schema_version")
    _require_string(catalog, "purpose", "catalog")
    if catalog.get("commentary_layers") != list(COMMENTARY_LAYERS):
        raise AdapterCatalogError("catalog: commentary_layers must preserve the four evidence layers")
    adapters = catalog.get("adapters")
    if not isinstance(adapters, list) or not adapters:
        raise AdapterCatalogError("catalog: adapters must be a non-empty list")

    ids: set[str] = set()
    configured_by_architecture: dict[str, set[str]] = {}
    workflow_architectures = (workflow or {}).get("architectures", {})
    workflow_tools = (workflow or {}).get("tools", {})
    if workflow is not None and (not isinstance(workflow_architectures, dict) or not isinstance(workflow_tools, dict)):
        raise AdapterCatalogError("workflow: architectures and tools must be mappings")

    for adapter in adapters:
        if not isinstance(adapter, dict):
            raise AdapterCatalogError("catalog: every adapter must be a mapping")
        adapter_id = _require_string(adapter, "adapter_id", "adapter")
        if not _ADAPTER_ID.fullmatch(adapter_id) or adapter_id in ids:
            raise AdapterCatalogError(f"adapter: invalid or duplicate adapter_id: {adapter_id!r}")
        ids.add(adapter_id)
        state = _require_string(adapter, "state", adapter_id)
        if state not in VALID_STATES:
            raise AdapterCatalogError(f"{adapter_id}: unknown state {state!r}")
        role = _require_string(adapter, "role", adapter_id)
        if role not in VALID_ROLES:
            raise AdapterCatalogError(f"{adapter_id}: unknown role {role!r}")
        architectures = _require_string_list(adapter, "architectures", adapter_id)
        _require_string_list(adapter, "load_model_compatibility", adapter_id)
        _require_string(adapter, "commentary_boundary", adapter_id)
        runner = _require_string(adapter, "runner", adapter_id)
        if runner not in VALID_RUNNERS:
            raise AdapterCatalogError(f"{adapter_id}: unknown runner {runner!r}")
        tool = adapter.get("tool")
        if not isinstance(tool, dict):
            raise AdapterCatalogError(f"{adapter_id}: tool must be a mapping")
        _require_string(tool, "name", adapter_id)
        _require_string(tool, "pin", adapter_id)
        _require_string(tool, "provenance_url", adapter_id)

        if state == CONFIGURED:
            if runner == "external_candidate":
                raise AdapterCatalogError(f"{adapter_id}: configured adapters need an executable runner")
            _require_string(adapter, "record_tool", adapter_id)
            output = adapter.get("output")
            if not isinstance(output, dict):
                raise AdapterCatalogError(f"{adapter_id}: configured adapter requires output capture")
            _require_string(output, "filename", adapter_id)
            if output.get("capture") != "combined_stdout_stderr":
                raise AdapterCatalogError(f"{adapter_id}: output capture must retain combined stdout and stderr")
            for architecture in architectures:
                configured_by_architecture.setdefault(architecture, set()).add(role)
            if workflow is not None:
                workflow_key = _require_string(tool, "workflow_key", adapter_id)
                if workflow_key not in workflow_tools:
                    raise AdapterCatalogError(f"{adapter_id}: unknown workflow tool {workflow_key!r}")
                for architecture in architectures:
                    config = workflow_architectures.get(architecture)
                    if not isinstance(config, dict):
                        raise AdapterCatalogError(f"{adapter_id}: unknown workflow architecture {architecture!r}")
                    if config.get("load_model") not in adapter["load_model_compatibility"]:
                        raise AdapterCatalogError(f"{adapter_id}: incompatible load model for {architecture}")
        elif runner != "external_candidate":
            raise AdapterCatalogError(f"{adapter_id}: unconfigured candidates must use external_candidate runner")

    if workflow is not None:
        for architecture in workflow_architectures:
            roles = configured_by_architecture.get(architecture, set())
            if roles != VALID_ROLES:
                raise AdapterCatalogError(f"catalog: {architecture} lacks configured redundant-role coverage")


def load_catalog(path: Path, workflow: dict[str, Any] | None = None) -> dict[str, Any]:
    """Load and validate a repository-owned adapter catalog."""

    try:
        catalog = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise AdapterCatalogError(f"catalog: invalid JSON: {exc.msg}") from exc
    if not isinstance(catalog, dict):
        raise AdapterCatalogError("catalog: top level must be a mapping")
    validate_catalog(catalog, workflow)
    return catalog


def adapters_for_architecture(catalog: dict[str, Any], architecture: str, *, state: str = CONFIGURED) -> list[dict[str, Any]]:
    """Return deterministically ordered adapters for one explicit CPU architecture."""

    if state not in VALID_STATES:
        raise AdapterCatalogError(f"selection: unknown state {state!r}")
    selected = [
        adapter
        for adapter in catalog["adapters"]
        if adapter["state"] == state and architecture in adapter["architectures"]
    ]
    return sorted(selected, key=lambda adapter: (adapter.get("execution_order", 0), adapter["adapter_id"]))


def commentary_template(adapter: dict[str, Any]) -> dict[str, str]:
    """Return mandatory headings that prevent tool output from becoming source claims."""

    identifier = adapter["adapter_id"]
    return {
        "bytes": f"Immutable bytes and hash for {identifier}",
        "decoded_instructions": f"Instructions decoded by {identifier} at the stated load model",
        "tool_hypotheses": f"Tool-derived control-flow or pseudocode hypotheses from {identifier}",
        "evidenced_behavior": "Behavior supported separately by native parsing, load-model evidence, or runtime observation",
    }


def validate_candidate_matrix(matrix: dict[str, Any]) -> None:
    """Validate that unconfigured research candidates cannot silently execute."""

    if matrix.get("schema_version") != 1:
        raise AdapterCatalogError("candidate matrix: unsupported schema_version")
    _require_string(matrix, "purpose", "candidate matrix")
    candidates = matrix.get("candidates")
    if not isinstance(candidates, list) or not candidates:
        raise AdapterCatalogError("candidate matrix: candidates must be a non-empty list")
    identifiers: set[str] = set()
    for candidate in candidates:
        if not isinstance(candidate, dict):
            raise AdapterCatalogError("candidate matrix: every candidate must be a mapping")
        identifier = _require_string(candidate, "candidate_id", "candidate")
        if not _ADAPTER_ID.fullmatch(identifier) or identifier in identifiers:
            raise AdapterCatalogError(f"candidate matrix: invalid or duplicate candidate_id {identifier!r}")
        identifiers.add(identifier)
        if _require_string(candidate, "admission_state", identifier) not in VALID_ADMISSION_STATES:
            raise AdapterCatalogError(f"{identifier}: unknown admission_state")
        _require_string_list(candidate, "architectures", identifier)
        source = candidate.get("source")
        if not isinstance(source, dict):
            raise AdapterCatalogError(f"{identifier}: source must be a mapping")
        _require_string(source, "repository_url", identifier)
        pin = _require_string(source, "revision", identifier)
        if len(pin) != 40 or any(character not in "0123456789abcdef" for character in pin):
            raise AdapterCatalogError(f"{identifier}: source revision must be a lowercase Git SHA-1")
        _require_string(source, "license_status", identifier)
        if candidate.get("execution_eligible") is not False:
            raise AdapterCatalogError(f"{identifier}: unconfigured candidate must not be execution eligible")
        _require_string_list(candidate, "comparison_roles", identifier)
        _require_string_list(candidate, "blockers", identifier)
        _require_string(candidate, "non_claim", identifier)


def load_candidate_matrix(path: Path) -> dict[str, Any]:
    """Load and validate the non-executable research candidate matrix."""

    try:
        matrix = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise AdapterCatalogError(f"candidate matrix: invalid JSON: {exc.msg}") from exc
    if not isinstance(matrix, dict):
        raise AdapterCatalogError("candidate matrix: top level must be a mapping")
    validate_candidate_matrix(matrix)
    return matrix


def validate_ghidra_headless_health(health: dict[str, Any], workflow: dict[str, Any]) -> None:
    """Validate a controlled-fixture Ghidra health record without authorizing analysis."""

    if health.get("schema_version") != GHIDRA_HEALTH_SCHEMA_VERSION:
        raise AdapterCatalogError("Ghidra health: unsupported schema_version")
    _require_string(health, "purpose", "Ghidra health")
    _require_string(health, "non_claim", "Ghidra health")
    tool = health.get("tool")
    if not isinstance(tool, dict):
        raise AdapterCatalogError("Ghidra health: tool must be a mapping")
    if _require_string(tool, "name", "Ghidra health") != "Ghidra":
        raise AdapterCatalogError("Ghidra health: tool name must be Ghidra")
    _require_string(tool, "version", "Ghidra health")
    _require_string(tool, "release_url", "Ghidra health")
    if not _SHA256.fullmatch(_require_string(tool, "release_sha256", "Ghidra health")):
        raise AdapterCatalogError("Ghidra health: release_sha256 must be a lowercase SHA-256")

    export_script = health.get("export_script")
    if not isinstance(export_script, dict):
        raise AdapterCatalogError("Ghidra health: export_script must be a mapping")
    _require_string(export_script, "relative_path", "Ghidra health")
    if not _SHA256.fullmatch(_require_string(export_script, "sha256", "Ghidra health")):
        raise AdapterCatalogError("Ghidra health: export_script SHA-256 must be lowercase")

    profiles = health.get("processor_profiles")
    if not isinstance(profiles, list) or not profiles:
        raise AdapterCatalogError("Ghidra health: processor_profiles must be a non-empty list")
    observed_architectures: set[str] = set()
    for profile in profiles:
        if not isinstance(profile, dict):
            raise AdapterCatalogError("Ghidra health: every processor profile must be a mapping")
        architectures = _require_string_list(profile, "architectures", "Ghidra processor profile")
        for architecture in architectures:
            if architecture in observed_architectures:
                raise AdapterCatalogError(f"Ghidra health: duplicate architecture {architecture!r}")
            config = workflow.get("architectures", {}).get(architecture)
            if not isinstance(config, dict):
                raise AdapterCatalogError(f"Ghidra health: unknown workflow architecture {architecture!r}")
            if _require_string(profile, "ghidra_language", "Ghidra processor profile") != config.get("ghidra_language"):
                raise AdapterCatalogError(f"Ghidra health: language does not match toolchain for {architecture}")
            observed_architectures.add(architecture)
        fixture_hex = _require_string(profile, "fixture_hex", "Ghidra processor profile")
        try:
            fixture = bytes.fromhex(fixture_hex)
        except ValueError as exc:
            raise AdapterCatalogError("Ghidra health: fixture_hex must be hexadecimal") from exc
        if not fixture:
            raise AdapterCatalogError("Ghidra health: fixture_hex must not be empty")
        fixture_sha256 = _require_string(profile, "fixture_sha256", "Ghidra processor profile")
        if hashlib.sha256(fixture).hexdigest() != fixture_sha256:
            raise AdapterCatalogError("Ghidra health: fixture SHA-256 does not match fixture_hex")
        exports = profile.get("deterministic_exports")
        if not isinstance(exports, dict) or set(exports) != {
            "ghidra-listing.txt", "ghidra-functions.tsv", "ghidra-decompilation.c", "ghidra-metadata.json"
        }:
            raise AdapterCatalogError("Ghidra health: deterministic export inventory is incomplete")
        if any(not isinstance(value, str) or not _SHA256.fullmatch(value) for value in exports.values()):
            raise AdapterCatalogError("Ghidra health: deterministic export hashes must be lowercase SHA-256 values")
        if profile.get("repeat_exports_byte_identical") is not True:
            raise AdapterCatalogError("Ghidra health: fixture record must state repeat export comparison")

    workflow_architectures = set(workflow.get("architectures", {}))
    if observed_architectures != workflow_architectures:
        raise AdapterCatalogError("Ghidra health: processor profiles must cover each workflow architecture exactly once")

    hosts = health.get("host_profiles")
    if not isinstance(hosts, list) or not hosts:
        raise AdapterCatalogError("Ghidra health: host_profiles must be a non-empty list")
    host_ids: set[str] = set()
    for host in hosts:
        if not isinstance(host, dict):
            raise AdapterCatalogError("Ghidra health: every host profile must be a mapping")
        host_id = _require_string(host, "host_id", "Ghidra host profile")
        if host_id in host_ids:
            raise AdapterCatalogError(f"Ghidra health: duplicate host_id {host_id!r}")
        host_ids.add(host_id)
        if _require_string(host, "status", host_id) not in VALID_GHIDRA_HOST_STATUSES:
            raise AdapterCatalogError(f"Ghidra health: unknown host status for {host_id}")
        _require_string(host, "platform", host_id)
        _require_string(host, "headless_launcher", host_id)
        _require_string_list(host, "prerequisites", host_id)
        _require_string(host, "boundary", host_id)


def load_ghidra_headless_health(path: Path, workflow: dict[str, Any]) -> dict[str, Any]:
    """Load the controlled-fixture Ghidra health record and validate its boundaries."""

    try:
        health = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise AdapterCatalogError(f"Ghidra health: invalid JSON: {exc.msg}") from exc
    if not isinstance(health, dict):
        raise AdapterCatalogError("Ghidra health: top level must be a mapping")
    validate_ghidra_headless_health(health, workflow)
    return health
