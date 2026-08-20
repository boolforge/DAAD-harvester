#!/usr/bin/env python3
"""Verify or backfill the canonical complete checksum suite for retained bytes.

The verifier rereads every artifact path in the selected SQLite ledger and
compares all fields produced by ``daad_harvester.unpack.compute_hashes``.  Its
default mode is read-only and fails on absent digests, missing retained bytes,
or a stored mismatch. ``--backfill`` fills only absent digest fields; it never
overwrites a mismatching stored checksum because a mismatch is an integrity
event, not an invitation to rewrite history.
"""

from __future__ import annotations

import argparse
from pathlib import Path
import sys
from typing import Sequence


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.db import Database  # noqa: E402
from daad_harvester.unpack import compute_hashes  # noqa: E402


DEFAULT_CORPUS = ROOT / "preservation_corpus"
CHECKSUM_FIELDS = tuple(compute_hashes(b"").keys())


def repository_path(recorded: str, corpus_root: Path) -> Path:
    """Map an acquisition-time corpus path to the selected clean checkout."""

    marker = "/preservation_corpus/"
    if marker in recorded:
        return corpus_root / recorded.split(marker, 1)[1]
    path = Path(recorded)
    return path if path.is_absolute() else ROOT / path


def _missing_or_mismatching(artifact: object, computed: dict[str, str]) -> tuple[list[str], list[str]]:
    missing = [field for field in CHECKSUM_FIELDS if not getattr(artifact, field)]
    mismatching = [
        field for field in CHECKSUM_FIELDS
        if getattr(artifact, field) and getattr(artifact, field) != computed[field]
    ]
    return missing, mismatching


def verify(*, database: Path, corpus_root: Path, backfill: bool) -> tuple[int, int, list[str]]:
    """Return ``(verified_count, backfilled_count, errors)`` for the selected ledger."""

    db = Database(database)
    errors: list[str] = []
    verified = 0
    backfilled = 0
    for artifact in db.get_all_artifacts():
        label = f"artifact {artifact.id} ({artifact.original_filename})"
        if not artifact.extracted_path:
            errors.append(f"{label} has no retained bytes path")
            continue
        path = repository_path(artifact.extracted_path, corpus_root)
        if not path.is_file():
            errors.append(f"missing retained bytes for {label}: {path}")
            continue
        computed = compute_hashes(path.read_bytes())
        empty_algorithms = [field for field in CHECKSUM_FIELDS if not computed.get(field)]
        if empty_algorithms:
            errors.append(f"checksum implementation unavailable for {label}: {', '.join(empty_algorithms)}")
            continue
        missing, mismatching = _missing_or_mismatching(artifact, computed)
        if mismatching:
            errors.append(f"stored checksum mismatch for {label}: {', '.join(mismatching)}")
            continue
        if missing:
            if not backfill:
                errors.append(f"missing stored checksum(s) for {label}: {', '.join(missing)}")
                continue
            if artifact.id is None:
                errors.append(f"{label} cannot be backfilled without a database identifier")
                continue
            db.update_artifact_checksums(artifact.id, computed)
            backfilled += 1
        verified += 1
    return verified, backfilled, errors


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--database", type=Path, default=DEFAULT_CORPUS / "state.db")
    parser.add_argument("--corpus-root", type=Path, default=DEFAULT_CORPUS)
    parser.add_argument("--backfill", action="store_true", help="fill only absent checksum fields after rereading retained bytes")
    args = parser.parse_args(argv)
    if not args.database.is_file():
        print(f"Artifact checksum verification failed: missing database {args.database}")
        return 1
    verified, backfilled, errors = verify(
        database=args.database,
        corpus_root=args.corpus_root,
        backfill=args.backfill,
    )
    if errors:
        print("Artifact checksum verification failed:")
        print("\n".join(f"- {error}" for error in errors))
        return 1
    action = f", backfilled {backfilled}" if args.backfill else ""
    print(f"Artifact checksum verification passed: {verified} retained artifacts{action}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
