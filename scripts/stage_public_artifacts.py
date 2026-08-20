#!/usr/bin/env python3
"""Stage manifest-approved retained bytes for static Pages deployment.

This script is intentionally the only path that copies corpus bytes to a
public artifact directory. It re-reads database paths, checks containment and
all manifest digests, then copies each byte under its manifest-provided public
path. It never accepts a browser-originated filename or arbitrary source path.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import shutil
import sys
from typing import Sequence


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.db import Database  # noqa: E402
from daad_harvester.unpack import compute_hashes  # noqa: E402
if __package__:
    from scripts.build_public_artifact_manifest import CORPUS, CHECKSUM_FIELDS, repository_path  # noqa: E402
else:
    from build_public_artifact_manifest import CORPUS, CHECKSUM_FIELDS, repository_path  # noqa: E402


def safe_destination(stage_dir: Path, public_path: str) -> Path:
    relative = Path(public_path)
    candidate = stage_dir / relative
    resolved_stage = stage_dir.resolve()
    resolved_candidate = candidate.resolve()
    if relative.is_absolute() or (resolved_candidate != resolved_stage and resolved_stage not in resolved_candidate.parents):
        raise ValueError(f"public path escapes staging root: {public_path}")
    return candidate


def stage(*, database: Path, corpus_root: Path, manifest_path: Path, stage_dir: Path) -> int:
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    if manifest.get("public_root") != "artifacts" or not isinstance(manifest.get("artifacts"), list):
        raise ValueError("invalid public artifact manifest contract")
    db = Database(database)
    artifacts = {artifact.id: artifact for artifact in db.get_all_artifacts() if artifact.id is not None}
    staged = 0
    seen_paths: set[str] = set()
    for entry in manifest["artifacts"]:
        artifact_id = entry.get("artifact_id")
        public_path = entry.get("public_path")
        if not isinstance(artifact_id, int) or not isinstance(public_path, str) or public_path in seen_paths:
            raise ValueError("invalid or duplicate artifact manifest entry")
        seen_paths.add(public_path)
        artifact = artifacts.get(artifact_id)
        if artifact is None or artifact.original_filename != entry.get("original_filename"):
            raise ValueError(f"manifest artifact identity mismatch: {artifact_id}")
        if not artifact.extracted_path:
            raise ValueError(f"manifest artifact has no retained path: {artifact_id}")
        source = repository_path(artifact.extracted_path, corpus_root)
        if not source.is_file():
            raise ValueError(f"missing retained bytes for manifest artifact {artifact_id}: {source}")
        payload = source.read_bytes()
        computed = compute_hashes(payload)
        if len(payload) != entry.get("file_size") or any(computed[field] != entry.get("checksums", {}).get(field) for field in CHECKSUM_FIELDS):
            raise ValueError(f"manifest byte mismatch for artifact {artifact_id}")
        destination = safe_destination(stage_dir, public_path)
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, destination)
        if destination.read_bytes() != payload:
            raise ValueError(f"staged copy mismatch for artifact {artifact_id}")
        staged += 1
    return staged


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, default=CORPUS / "state.db")
    parser.add_argument("--corpus-root", type=Path, default=CORPUS)
    parser.add_argument("--manifest", type=Path, default=CORPUS / "public_artifacts_manifest.json")
    parser.add_argument("--stage-dir", type=Path, required=True)
    args = parser.parse_args(argv)
    try:
        staged = stage(database=args.database, corpus_root=args.corpus_root, manifest_path=args.manifest, stage_dir=args.stage_dir)
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        print(f"Public artifact staging failed: {exc}")
        return 1
    print(f"Public artifacts staged and verified: {staged} retained artifacts.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
