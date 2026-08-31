#!/usr/bin/env python3
"""Verify retained game-corpus paths and hashes against its SQLite evidence ledger."""

from __future__ import annotations

import hashlib
import sqlite3
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CORPUS = ROOT / "preservation_corpus"
DATABASE = CORPUS / "state.db"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def repository_path(recorded: str) -> Path:
    """Map an acquisition-time absolute corpus path to this checkout."""

    marker = "/preservation_corpus/"
    if marker in recorded:
        return CORPUS / recorded.split(marker, 1)[1]
    path = Path(recorded)
    return path if path.is_absolute() else ROOT / path


def safe_relative(path: Path) -> Path | str:
    """Format `path` for an error message without ever raising.

    repository_path() can return an absolute path taken straight from a
    database row's extracted_path column, unchanged, if that row predates the
    "/preservation_corpus/"-relative convention or was ever corrupted --
    meaning it is not guaranteed to be under ROOT. `path.relative_to(ROOT)`
    raises ValueError in that case; reproduced and fixed here after finding
    the identical bug in scripts/verify_reverse_corpus.py, whose hash-
    mismatch branches called relative_to(ROOT) unconditionally while their
    neighboring missing-file branches already guarded it."""
    if ROOT in path.parents:
        return path.relative_to(ROOT)
    return path


def main() -> int:
    errors: list[str] = []
    if not DATABASE.is_file():
        print(f"Game corpus verification failed: missing {DATABASE.relative_to(ROOT)}")
        return 1
    if not (CORPUS / "COVERAGE_LEDGER.md").is_file():
        errors.append("missing preservation_corpus/COVERAGE_LEDGER.md")

    connection = sqlite3.connect(DATABASE)
    connection.row_factory = sqlite3.Row
    sources = connection.execute("SELECT COUNT(*) AS count FROM sources").fetchone()["count"]
    rows = connection.execute(
        "SELECT id, source_id, original_filename, extracted_path, sha256 FROM artifacts ORDER BY id"
    ).fetchall()
    connection.close()
    if not rows:
        errors.append("game corpus contains no artifact rows")

    for row in rows:
        recorded = row["extracted_path"]
        expected = row["sha256"]
        label = f"artifact {row['id']} ({row['original_filename']})"
        if not recorded:
            errors.append(f"{label} has no retained path")
            continue
        path = repository_path(recorded)
        if not path.is_file():
            errors.append(f"missing {label}: {safe_relative(path)}")
            continue
        if not expected:
            errors.append(f"{label} has no SHA-256")
        elif sha256(path) != expected:
            errors.append(f"hash mismatch for {label}: {safe_relative(path)}")

    if errors:
        print("Game corpus verification failed:")
        print("\n".join(f"- {error}" for error in errors))
        return 1
    print(f"Game corpus verified: {sources} sources, {len(rows)} retained artifacts.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
