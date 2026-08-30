#!/usr/bin/env python3
"""Verify retained reverse-engineering corpus paths and recorded hashes."""

from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
MANIFEST_ROOT = ROOT / "reverse_engineering" / "manifests"


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def safe_relative(path: Path) -> Path | str:
    """Format `path` for an error message without ever raising.

    Every path here is built as `ROOT / manifest_supplied_string`. Path's `/`
    operator silently discards the left side when the right side is itself an
    absolute path (`ROOT / "/etc/passwd"` == `Path("/etc/passwd")`), so a
    malformed or malicious manifest entry can produce a `path` that isn't
    actually under ROOT at all. `path.relative_to(ROOT)` raises ValueError in
    that case -- unacceptable in an error-reporting helper, since it would
    crash the verifier while it is trying to report a *different* problem
    (originally found and fixed here: the "hash mismatch" branches called
    relative_to(ROOT) unconditionally while the "missing file" branches next
    to them already guarded it, so a mismatched hash on an out-of-root path
    crashed this script instead of reporting the mismatch)."""
    if path.is_absolute() and ROOT in path.parents:
        return path.relative_to(ROOT)
    return path


def load(name: str) -> dict[str, object]:
    return json.loads((MANIFEST_ROOT / name).read_text(encoding="utf-8"))


def verify_originals(errors: list[str]) -> int:
    manifest = load("official_interpreters.json")
    artifacts = manifest.get("artifacts", [])
    if not isinstance(artifacts, list) or len(artifacts) != manifest.get("entry_count"):
        errors.append("official_interpreters.json entry_count does not match artifacts")
        return 0
    for artifact in artifacts:
        if not isinstance(artifact, dict):
            errors.append("non-object original artifact manifest entry")
            continue
        storage = artifact.get("storage", {})
        path = ROOT / str(storage.get("path", ""))
        expected = artifact.get("sha256")
        if not path.is_file():
            errors.append(f"missing original artifact: {safe_relative(path)}")
        elif sha256(path) != expected:
            errors.append(f"original artifact hash mismatch: {safe_relative(path)}")
    return len(artifacts)


def verify_public_sources(errors: list[str]) -> int:
    manifest = load("public_sources.json")
    sources = manifest.get("sources", [])
    checked = 0
    if not isinstance(sources, list):
        errors.append("public_sources.json sources is not an array")
        return checked
    for source in sources:
        if not isinstance(source, dict):
            errors.append("non-object public source manifest entry")
            continue
        root = ROOT / str(source.get("storage", ""))
        for item in source.get("files", []):
            if not isinstance(item, dict):
                errors.append(f"non-object file record in {source.get('id')}")
                continue
            path = root / str(item.get("path", ""))
            checked += 1
            if not path.is_file():
                errors.append(f"missing public source file: {safe_relative(path)}")
            elif sha256(path) != item.get("sha256"):
                errors.append(f"public source hash mismatch: {safe_relative(path)}")
    return checked


def verify_third_party_manifest(errors: list[str]) -> int:
    manifest = load("third_party_comparisons.json")
    if not isinstance(manifest.get("candidates"), list):
        errors.append("third_party_comparisons.json candidates is not an array")
        return 0
    return len(manifest["candidates"])


def verify_adp_implementation(errors: list[str]) -> int:
    manifest = load("adp_implementation.json")
    checked = 0
    for category, storage_key, list_key, count_key in (
        ("ADP source", "source_storage", "source_files", "source_file_count"),
        ("ADP release", "release_storage", "release_files", "release_file_count"),
    ):
        files = manifest.get(list_key, [])
        if not isinstance(files, list) or len(files) != manifest.get(count_key):
            errors.append(f"{category} manifest count mismatch")
            continue
        root = ROOT / str(manifest.get(storage_key, ""))
        for item in files:
            if not isinstance(item, dict):
                errors.append(f"non-object {category} manifest record")
                continue
            path = root / str(item.get("path", ""))
            checked += 1
            if not path.is_file():
                errors.append(f"missing {category} file: {safe_relative(path)}")
            elif sha256(path) != item.get("sha256"):
                errors.append(f"{category} hash mismatch: {safe_relative(path)}")
    return checked


def verify_adp_verification(errors: list[str]) -> int:
    manifest = load("adp_verification.json")
    log = manifest.get("log", {})
    if not isinstance(log, dict):
        errors.append("ADP verification log record is not an object")
        return 0
    path = ROOT / str(log.get("path", ""))
    if not path.is_file():
        errors.append(f"missing ADP verification log: {safe_relative(path)}")
    elif sha256(path) != log.get("sha256"):
        errors.append(f"ADP verification log hash mismatch: {safe_relative(path)}")
    summary = manifest.get("scenario_summary", {})
    if not isinstance(summary, dict) or summary.get("probed") != summary.get("passed", 0) + summary.get("blocked", 0) + summary.get("failed_behavioral_assertions", 0):
        errors.append("ADP verification scenario summary does not reconcile")
    return 1


def verify_derived_outputs(errors: list[str]) -> int:
    original_manifest = load("official_interpreters.json")
    known_hashes = {
        artifact.get("artifact_id"): artifact.get("sha256")
        for artifact in original_manifest.get("artifacts", [])
        if isinstance(artifact, dict)
    }
    checked = 0
    for run_path in sorted((ROOT / "reverse_engineering" / "derived").glob("**/analysis-run.json")):
        run = json.loads(run_path.read_text(encoding="utf-8"))
        artifact_id = run.get("artifact_id")
        if artifact_id not in known_hashes:
            errors.append(f"derived run has unknown artifact ID: {run_path.relative_to(ROOT)}")
        elif run.get("derived_from_sha256") != known_hashes[artifact_id]:
            errors.append(f"derived run input hash mismatch: {run_path.relative_to(ROOT)}")
        for output in run.get("outputs", []):
            if not isinstance(output, dict):
                errors.append(f"non-object derived output record: {run_path.relative_to(ROOT)}")
                continue
            path = ROOT / str(output.get("path", ""))
            checked += 1
            if not path.is_file():
                errors.append(f"missing derived output: {safe_relative(path)}")
            elif sha256(path) != output.get("sha256"):
                errors.append(f"derived output hash mismatch: {safe_relative(path)}")
        for record in run.get("tool_records", []):
            if not isinstance(record, dict):
                errors.append(f"non-object tool record: {run_path.relative_to(ROOT)}")
                continue
            path = ROOT / str(record.get("output", ""))
            if not path.is_file():
                errors.append(f"missing tool record output: {safe_relative(path)}")
            elif sha256(path) != record.get("sha256"):
                errors.append(f"tool record hash mismatch: {safe_relative(path)}")
    return checked


def main() -> int:
    errors: list[str] = []
    originals = verify_originals(errors)
    sources = verify_public_sources(errors)
    comparisons = verify_third_party_manifest(errors)
    adp = verify_adp_implementation(errors)
    adp_verification = verify_adp_verification(errors)
    derived = verify_derived_outputs(errors)
    if errors:
        print("Reverse-engineering corpus verification failed:")
        print("\n".join(f"- {error}" for error in errors))
        return 1
    print(f"Reverse-engineering corpus verified: {originals} originals, {sources} public source files, {adp} ADP mirror files, {adp_verification} ADP verification record, {comparisons} third-party comparison records, {derived} derived outputs.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
