#!/usr/bin/env python3
"""Build a deterministic review manifest for every retained artifact."""

from __future__ import annotations

import argparse
from collections import Counter
import json
from pathlib import Path
import sqlite3

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DB = ROOT / "preservation_corpus" / "state.db"
DEFAULT_OUTPUT = ROOT / "preservation_corpus" / "resource_review_manifest.json"


def build(db_path: Path = DEFAULT_DB) -> dict[str, object]:
    connection = sqlite3.connect(db_path)
    connection.row_factory = sqlite3.Row
    rows = connection.execute(
        """SELECT id, source_id, original_filename, extracted_path, file_size, sha256,
                  media_parser, media_status, media_validation, container_format, platform_hint
           FROM artifacts ORDER BY id"""
    ).fetchall()
    artifacts: list[dict[str, object]] = []
    for row in rows:
        status = str(row["media_status"])
        if status == "recognized_evidence":
            evidence_state = "recognized_evidence"
            next_action = "Preserve profile-scoped parser evidence and verify cross-file relationships before promotion."
        elif status == "rejected":
            evidence_state = "explicit_rejection"
            next_action = "Retain the rejection boundary and add a profile-specific reproducer before reconsidering support."
        else:
            evidence_state = "review_required"
            next_action = "Inspect the bounded parser outcome, record a profile-specific support loop, and do not infer semantics from the filename."
        artifacts.append(
            {
                "artifact_id": row["id"],
                "source_id": row["source_id"],
                "original_filename": row["original_filename"],
                "extracted_path": row["extracted_path"],
                "file_size": row["file_size"],
                "sha256": row["sha256"],
                "parser": row["media_parser"],
                "parser_status": status,
                "parser_validation": row["media_validation"],
                "container_format": row["container_format"],
                "platform_hint": row["platform_hint"],
                "evidence_state": evidence_state,
                "support_loop": {
                    "required": evidence_state == "review_required",
                    "state": "active" if evidence_state == "review_required" else "closed_with_boundary",
                },
                "next_action": next_action,
                "reproducer": {
                    "command": "python scripts/verify_resource_inventory.py --db preservation_corpus/state.db",
                    "scope": "retained artifact inventory and evidence-record completeness",
                },
            }
        )
    connection.close()
    extensions = Counter()
    for artifact in artifacts:
        filename = str(artifact["original_filename"])
        suffix = Path(filename).suffix.casefold() or "<extensionless>"
        extensions[suffix] += 1
    return {
        "schema_version": 1,
        "purpose": "Deterministic review state for every retained resource; unknown and rejected records remain visible.",
        "source": "preservation_corpus/state.db",
        "artifact_count": len(artifacts),
        "summary": {
            "evidence_states": dict(sorted(Counter(str(a["evidence_state"]) for a in artifacts).items())),
            "parser_statuses": dict(sorted(Counter(str(a["parser_status"]) for a in artifacts).items())),
            "parsers": dict(sorted(Counter(str(a["parser"]) for a in artifacts).items())),
            "container_formats": dict(sorted(Counter(str(a["container_format"]) for a in artifacts).items())),
            "platform_hints": dict(sorted(Counter(str(a["platform_hint"]) for a in artifacts).items())),
            "observed_extensions": dict(sorted(extensions.items())),
        },
        "artifacts": artifacts,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--db", type=Path, default=DEFAULT_DB)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = json.dumps(build(args.db), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            print(f"Resource review manifest is stale: {args.output}")
            return 1
        print(f"Resource review manifest verified: {json.loads(expected)['artifact_count']} artifacts.")
        return 0
    args.output.write_text(expected, encoding="utf-8")
    print(f"Resource review manifest generated: {json.loads(expected)['artifact_count']} artifacts.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
