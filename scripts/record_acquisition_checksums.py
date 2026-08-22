#!/usr/bin/env python3
"""Persist newly measured SHA-256 values from successful acquisition evidence.

A checksum is promoted only when the result records a fully unpacked source and
a computed SHA-256 measurement. Existing declared checksums are never replaced.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_REGISTRATIONS = ROOT / "research" / "authorized_candidate_sources.json"
DEFAULT_RESULTS = ROOT / "output" / "authorized-acquisition-spectrum-batch" / "authorized_acquisition_results.json"


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def measured_checksums(results: dict[str, Any]) -> dict[str, dict[str, str]]:
    """Return trustworthy SHA-256 claims indexed by candidate key."""

    checksums: dict[str, dict[str, str]] = {}
    for record in results.get("records") or []:
        verification = record.get("verification") or {}
        if (
            record.get("source_status_after_unpack") == "unpacked"
            and verification.get("status") == "checksum_measured"
            and verification.get("algorithm") == "sha256"
            and isinstance(verification.get("actual"), str)
            and len(verification["actual"]) == 64
        ):
            checksums[str(record["candidate_key"])] = {"algorithm": "sha256", "value": verification["actual"].casefold()}
    return checksums


def build(registrations: dict[str, Any], results: dict[str, Any]) -> dict[str, Any]:
    """Append source checksum claims to existing matching registrations only."""

    updates = measured_checksums(results)
    promoted = 0
    records: list[dict[str, Any]] = []
    for record in registrations.get("registrations") or []:
        updated = dict(record)
        checksum = updates.get(record.get("candidate_key"))
        if checksum and "source_checksum" not in updated:
            updated["source_checksum"] = checksum
            promoted += 1
        records.append(updated)
    records.sort(key=lambda record: record["candidate_key"])
    return {
        "schema_version": registrations.get("schema_version"),
        "purpose": registrations.get("purpose"),
        "registrations": records,
        "checksum_promotion_summary": {"new_source_checksums": promoted, "total_registrations": len(records)},
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--registrations", type=Path, default=DEFAULT_REGISTRATIONS)
    parser.add_argument("--results", type=Path, default=DEFAULT_RESULTS)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    result = build(load_json(args.registrations), load_json(args.results))
    if args.dry_run:
        print(f"Checksum promotion dry run: {result['checksum_promotion_summary']['new_source_checksums']} new source checksums.")
        return 0
    args.registrations.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"Source registry checksum promotion: {result['checksum_promotion_summary']['new_source_checksums']} new source checksums.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
