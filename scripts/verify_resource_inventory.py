#!/usr/bin/env python3
"""Verify that every retained artifact has an auditable inventory record."""

from __future__ import annotations

import argparse
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DB = ROOT / "preservation_corpus" / "state.db"
REQUIRED = (
    "source_id",
    "original_filename",
    "extracted_path",
    "file_size",
    "sha256",
    "media_parser",
    "media_status",
    "media_validation",
    "media_evidence_json",
)


def verify(db_path: Path = DEFAULT_DB) -> tuple[int, dict[str, int]]:
    connection = sqlite3.connect(db_path)
    total = connection.execute("SELECT COUNT(*) FROM artifacts").fetchone()[0]
    missing: dict[str, int] = {}
    for column in REQUIRED:
        query = f"SELECT COUNT(*) FROM artifacts WHERE {column} IS NULL OR CAST({column} AS TEXT) = ''"
        count = connection.execute(query).fetchone()[0]
        if count:
            missing[column] = count
    invalid_sizes = connection.execute(
        "SELECT COUNT(*) FROM artifacts WHERE file_size < 0"
    ).fetchone()[0]
    if invalid_sizes:
        missing["nonnegative_file_size"] = invalid_sizes
    invalid_hashes = connection.execute(
        "SELECT COUNT(*) FROM artifacts WHERE length(sha256) != 64 OR sha256 GLOB '*[^0-9a-fA-F]*'"
    ).fetchone()[0]
    if invalid_hashes:
        missing["sha256_hex"] = invalid_hashes
    connection.close()
    return total, missing


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--db", type=Path, default=DEFAULT_DB)
    args = parser.parse_args()
    total, missing = verify(args.db)
    if missing:
        print(f"Resource inventory failed for {total} artifacts:")
        for field, count in sorted(missing.items()):
            print(f"- {field}: {count}")
        return 1
    print(f"Resource inventory verified: {total} artifacts have identity, lineage, SHA-256, parser result, and evidence JSON.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
