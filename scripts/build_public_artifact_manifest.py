#!/usr/bin/env python3
"""Build or verify the browser-safe manifest for all authorized retained bytes.

The manifest is deterministic: it contains one public entry per retained
artifact, never a workstation extraction path. Each entry is rebuilt from the
SQLite evidence ledger and reread bytes, carries the complete canonical digest
suite, and receives an opaque ID-prefixed public filename under ``artifacts/``.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
import sys
from typing import Any, Sequence


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.db import Database  # noqa: E402
from daad_harvester.unpack import compute_hashes  # noqa: E402


CORPUS = ROOT / "preservation_corpus"
CHECKSUM_FIELDS = tuple(compute_hashes(b"").keys())


def repository_path(recorded: str, corpus_root: Path) -> Path:
    """Map an acquisition-time corpus path into this clean checkout."""

    marker = "/preservation_corpus/"
    if marker in recorded:
        return corpus_root / recorded.split(marker, 1)[1]
    path = Path(recorded)
    return path if path.is_absolute() else ROOT / path


def public_filename(artifact_id: int, original_filename: str) -> str:
    """Return a portable, traversal-free, ID-prefixed public artifact name."""

    basename = Path(original_filename).name
    safe = re.sub(r"[^A-Za-z0-9._-]+", "_", basename).strip("._") or "artifact.bin"
    return f"artifacts/{artifact_id:06d}_{safe}"


def artifact_state(artifact: Any) -> str:
    if artifact.is_daad_payload:
        return "verified_ddb"
    if artifact.interpreter_identity:
        return "identified_interpreter"
    return "retained_artifact"


def build_manifest(*, database: Path, corpus_root: Path) -> dict[str, Any]:
    """Reread retained artifacts and return their public deployment manifest."""

    db = Database(database)
    sources = {source.id: source for source in db.get_all_sources()}
    entries: list[dict[str, Any]] = []
    for artifact in sorted(db.get_all_artifacts(), key=lambda item: item.id or 0):
        if artifact.id is None:
            raise ValueError(f"artifact without database ID: {artifact.original_filename}")
        if not artifact.extracted_path:
            raise ValueError(f"artifact {artifact.id} has no retained bytes path")
        path = repository_path(artifact.extracted_path, corpus_root)
        if not path.is_file():
            raise ValueError(f"missing retained bytes for artifact {artifact.id}: {path}")
        payload = path.read_bytes()
        hashes = compute_hashes(payload)
        missing = [field for field in CHECKSUM_FIELDS if not hashes.get(field)]
        if missing:
            raise ValueError(f"checksum implementation unavailable for artifact {artifact.id}: {', '.join(missing)}")
        mismatch = [field for field in CHECKSUM_FIELDS if getattr(artifact, field) != hashes[field]]
        if mismatch:
            raise ValueError(f"stored checksum mismatch for artifact {artifact.id}: {', '.join(mismatch)}")
        source = sources.get(artifact.source_id)
        entries.append(
            {
                "artifact_id": artifact.id,
                "source_id": artifact.source_id,
                "original_filename": artifact.original_filename,
                "public_path": public_filename(artifact.id, artifact.original_filename),
                "file_size": len(payload),
                "checksums": {field: hashes[field] for field in CHECKSUM_FIELDS},
                "evidence_state": artifact_state(artifact),
                "media": {
                    "container_format": artifact.container_format,
                    "container_member": artifact.container_member,
                    "measured_platform": artifact.measured_platform,
                    "platform_hint": artifact.platform_hint,
                    "ddb_format": artifact.ddb_format,
                    "interpreter_identity": artifact.interpreter_identity,
                },
                "source": {
                    "url": source.url if source else None,
                    "title": source.title if source else None,
                    "platform": source.platform if source else None,
                    "status": source.status if source else None,
                },
            }
        )
    return {
        "schema_version": 1,
        "purpose": "Deterministic public deployment map for authorized retained DAAD preservation artifacts",
        "public_root": "artifacts",
        "artifact_count": len(entries),
        "checksums": list(CHECKSUM_FIELDS),
        "artifacts": entries,
    }


def write_manifest(manifest: dict[str, Any], output: Path) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, default=CORPUS / "state.db")
    parser.add_argument("--corpus-root", type=Path, default=CORPUS)
    parser.add_argument("--output", type=Path, default=CORPUS / "public_artifacts_manifest.json")
    parser.add_argument("--check", action="store_true", help="verify the committed output matches deterministic regeneration")
    args = parser.parse_args(argv)
    try:
        manifest = build_manifest(database=args.database, corpus_root=args.corpus_root)
    except ValueError as exc:
        print(f"Public artifact manifest failed: {exc}")
        return 1
    expected = json.dumps(manifest, indent=2, ensure_ascii=False) + "\n"
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            print(f"Public artifact manifest failed: stale or missing {args.output}")
            return 1
        print(f"Public artifact manifest verified: {manifest['artifact_count']} retained artifacts.")
        return 0
    write_manifest(manifest, args.output)
    print(f"Public artifact manifest generated: {manifest['artifact_count']} retained artifacts.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
