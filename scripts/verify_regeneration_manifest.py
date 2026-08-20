#!/usr/bin/env python3
"""Enforce hash-pinned, repository-native regeneration entries."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "preservation_corpus" / "regeneration_manifest.json"
POLICY = ROOT / "docs" / "SELF_CONTAINED_REGENERATION.md"


def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def _relative_file(path_text: str) -> Path:
    path = (ROOT / path_text).resolve()
    if ROOT not in path.parents or not path.is_file():
        raise ValueError(f"manifest path is not a repository file: {path_text}")
    return path


def _verify_hashed_paths(entry_id: str, label: str, records: list[dict[str, str]]) -> int:
    checked = 0
    for record in records:
        path = _relative_file(record["path"])
        expected = record["sha256"]
        actual = _sha256(path)
        if actual != expected:
            raise AssertionError(
                f"{entry_id}: {label} hash mismatch for {record['path']}: {actual} != {expected}"
            )
        checked += 1
    return checked


def _run_native_command(entry_id: str, command: dict[str, object]) -> None:
    if command.get("runner") != "python":
        raise ValueError(f"{entry_id}: only repository-local Python commands are permitted")
    script = command.get("script")
    arguments = command.get("arguments")
    if not isinstance(script, str) or not isinstance(arguments, list) or not all(
        isinstance(argument, str) for argument in arguments
    ):
        raise ValueError(f"{entry_id}: invalid native command declaration")
    script_path = _relative_file(script)
    result = subprocess.run(
        [sys.executable, str(script_path), *arguments],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode:
        raise AssertionError(f"{entry_id}: native command failed:\n{result.stdout}{result.stderr}")


def main() -> int:
    if not POLICY.is_file():
        raise FileNotFoundError(f"required policy is missing: {POLICY.relative_to(ROOT)}")
    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    if manifest.get("schema_version") != 1 or manifest.get("policy") != "docs/SELF_CONTAINED_REGENERATION.md":
        raise ValueError("unsupported regeneration manifest schema or policy link")
    entries = manifest.get("entries")
    if not isinstance(entries, list) or not entries:
        raise ValueError("regeneration manifest has no entries")

    input_count = output_count = 0
    for entry in entries:
        entry_id = entry.get("id")
        if not isinstance(entry_id, str) or not entry_id:
            raise ValueError("regeneration entry has no stable id")
        if entry.get("primary_class") != "repository-native" or entry.get("requires_network") is not False:
            raise ValueError(f"{entry_id}: primary path must be repository-native and network-free")
        dependencies = entry.get("declared_dependencies")
        validators = entry.get("external_validators")
        if not isinstance(dependencies, list) or not dependencies or not isinstance(validators, list):
            raise ValueError(f"{entry_id}: dependencies and external validators must be explicit lists")
        inputs = entry.get("inputs")
        outputs = entry.get("outputs")
        command = entry.get("command")
        if not isinstance(inputs, list) or not isinstance(outputs, list) or not isinstance(command, dict):
            raise ValueError(f"{entry_id}: inputs, outputs, and command are required")
        input_count += _verify_hashed_paths(entry_id, "input", inputs)
        _run_native_command(entry_id, command)
        output_count += _verify_hashed_paths(entry_id, "output", outputs)
    print(
        f"Self-contained regeneration verified: {len(entries)} native entries, "
        f"{input_count} inputs, {output_count} outputs."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
