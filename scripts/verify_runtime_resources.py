#!/usr/bin/env python3
"""Verify manifest-backed supporting runtime resources retained for reconstruction."""

from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "preservation_corpus" / "runtime_resources" / "commodore" / "manifest.json"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def main() -> int:
    if not MANIFEST.is_file():
        print(f"Runtime-resource verification failed: missing {MANIFEST.relative_to(ROOT)}")
        return 1
    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    errors: list[str] = []
    directive = str(manifest.get("authorization_directive", ""))
    if "Universal institutional authorization" not in directive:
        errors.append("manifest lacks the universal institutional authorization directive")
    policy = (MANIFEST.parent / str(manifest.get("policy_reference", ""))).resolve()
    if not policy.is_file():
        errors.append("manifest policy reference does not resolve to a file")

    resources = manifest.get("resources", [])
    if not isinstance(resources, list) or not resources:
        errors.append("manifest has no runtime resources")
        resources = []
    seen_paths: set[str] = set()
    for resource in resources:
        if not isinstance(resource, dict):
            errors.append("manifest has a non-object runtime-resource entry")
            continue
        relative = str(resource.get("path", ""))
        if not relative or Path(relative).is_absolute() or relative in seen_paths:
            errors.append(f"invalid or duplicate resource path: {relative!r}")
            continue
        seen_paths.add(relative)
        path = MANIFEST.parent / relative
        if not path.is_file():
            errors.append(f"missing runtime resource: {relative}")
            continue
        if path.stat().st_size != resource.get("size"):
            errors.append(f"size mismatch for runtime resource: {relative}")
        if sha256(path) != resource.get("sha256"):
            errors.append(f"hash mismatch for runtime resource: {relative}")

    for capture in manifest.get("captures", []):
        if not isinstance(capture, dict):
            errors.append("manifest has a non-object capture entry")
            continue
        for field, checksum_field in (("snapshot", "snapshot_sha256"), ("ram", "ram_sha256")):
            recorded = capture.get(field)
            if recorded is None:
                continue
            if not capture.get(checksum_field):
                errors.append(f"capture {field} has no SHA-256")
                continue
            path = (MANIFEST.parent / str(recorded)).resolve()
            if not path.is_file():
                errors.append(f"missing capture {field}: {recorded!r}")
            elif sha256(path) != capture.get(checksum_field):
                errors.append(f"hash mismatch for capture {field}: {path.relative_to(ROOT)}")
        if not capture.get("result"):
            errors.append("capture has no measured result")

    c64_link = MANIFEST.parent / "C64"
    if not c64_link.is_symlink() or c64_link.resolve() != (MANIFEST.parent / "c64").resolve():
        errors.append("C64 VICE machine-directory link does not resolve to the retained C64 resources")
    plus4_link = MANIFEST.parent / "PLUS4"
    if not plus4_link.is_symlink() or plus4_link.resolve() != (MANIFEST.parent / "plus4").resolve():
        errors.append("Plus/4 VICE machine-directory link does not resolve to the retained Plus/4 resources")

    if errors:
        print("Runtime-resource verification failed:")
        print("\n".join(f"- {error}" for error in errors))
        return 1
    print(f"Runtime resources verified: {len(resources)} resources, {len(manifest.get('captures', []))} captures.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
