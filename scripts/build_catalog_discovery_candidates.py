#!/usr/bin/env python3
"""Build catalog-only candidates absent from the retained DAAD corpus."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_SOURCE = ROOT / "research" / "sources" / "solutionarchive_daad_2026-08-22.md"
DEFAULT_CATALOG = ROOT / "preservation_corpus" / "daad_catalog.json"
DEFAULT_OUTPUT = ROOT / "research" / "catalog_discovery_candidates.json"


def normalize(value: str) -> str:
    folded = unicodedata.normalize("NFKD", value.casefold())
    return "".join(char for char in folded if not unicodedata.combining(char))


def source_rows(path: Path) -> list[dict[str, str]]:
    rows: list[dict[str, str]] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith("|"):
            fields = [field.strip() for field in line.strip("|").split("|")]
        elif "\t" in line:
            fields = [field.strip() for field in line.split("\t")]
        else:
            continue
        if len(fields) >= 4 and fields[0] and fields[0] != "Title" and fields[0] != "---":
            rows.append({"title": fields[0], "publisher": fields[1], "year": fields[2], "language": fields[3]})
    return rows


def build(source: Path = DEFAULT_SOURCE, catalog: Path = DEFAULT_CATALOG) -> dict[str, object]:
    catalog_rows = json.loads(catalog.read_text(encoding="utf-8"))
    known_titles = {normalize(str(row.get("title", ""))) for row in catalog_rows}
    candidates = [
        {
            **row,
            "evidence_grade": "catalog_only",
            "source_url": "https://solutionarchive.com/list/system%2C34/",
            "source_snapshot": str(source.relative_to(ROOT)),
            "acquisition_status": "not_attempted",
            "license_status": "unverified",
            "byte_hash": None,
            "promotion_status": "blocked_pending_primary_or_authorized_source",
        }
        for row in source_rows(source)
        if normalize(row["title"]) not in known_titles
    ]
    return {
        "schema_version": 1,
        "purpose": "Catalog-only discovery candidates absent from the retained byte corpus.",
        "source_snapshot": str(source.relative_to(ROOT)),
        "catalog": str(catalog.relative_to(ROOT)),
        "source_record_count": len(source_rows(source)),
        "candidate_count": len(candidates),
        "policy": "Discovery records never authorize download, redistribution, or semantic promotion.",
        "candidates": candidates,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument("--catalog", type=Path, default=DEFAULT_CATALOG)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = json.dumps(build(args.source, args.catalog), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            print(f"Catalog discovery manifest is stale: {args.output}")
            return 1
        print(f"Catalog discovery manifest verified: {json.loads(expected)['candidate_count']} candidates from {json.loads(expected)['source_record_count']} source records.")
        return 0
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(expected, encoding="utf-8")
    print(f"Catalog discovery manifest generated: {json.loads(expected)['candidate_count']} candidates.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
