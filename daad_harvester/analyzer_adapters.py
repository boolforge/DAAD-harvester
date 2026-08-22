"""Validate and select evidence-bounded static-analysis adapters.

An adapter describes a tool's CPU scope, pinned provenance, raw-load-model
compatibility, output capture, and commentary boundary.  It does not validate a
load model, execute a retained binary, or turn tool output into recovered source.
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any


CATALOG_SCHEMA_VERSION = 1
CONFIGURED = "configured"
CANDIDATE = "candidate"
VALID_STATES = frozenset({CONFIGURED, CANDIDATE})
VALID_ROLES = frozenset({"structured_analysis", "control_flow_analysis", "static_disassembly"})
VALID_RUNNERS = frozenset({"ghidra_headless_binary", "radare2_static", "architecture_static", "external_candidate"})
COMMENTARY_LAYERS = ("bytes", "decoded_instructions", "tool_hypotheses", "evidenced_behavior")
_ADAPTER_ID = re.compile(r"^[a-z0-9][a-z0-9-]*-v[1-9][0-9]*$")


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
