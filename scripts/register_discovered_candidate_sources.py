#!/usr/bin/env python3
"""Merge release-boundary discovery records into the authorized source registry.

Only a source record with an exact publication identity may be registered. The
registrar selects one preferred playable media representation per candidate and
never replaces a pre-existing registration.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_CANDIDATES = ROOT / "research" / "catalog_discovery_candidates.json"
DEFAULT_DISCOVERY = ROOT / "research" / "candidate_spectrum_source_discovery.json"
DEFAULT_REGISTRATIONS = ROOT / "research" / "authorized_candidate_sources.json"
PREFERRED_SUFFIXES = (".tzx.zip", ".tap.zip", ".dsk.zip", ".adf.zip", ".tzx", ".tap", ".dsk", ".adf")


def normalize(value: str) -> str:
    return " ".join("".join(char for char in value.casefold() if char.isalnum() or char.isspace()).split())


def normalized_publisher(value: str) -> str:
    return normalize(re.sub(r"\([^)]*\)", " ", value))


def title_matches(expected: str, observed: str) -> bool:
    if normalize(expected) == normalize(observed):
        return True
    expected_text = " ".join(expected.split()).casefold()
    observed_text = " ".join(observed.split()).casefold()
    return observed_text.startswith(expected_text + " - ") or observed_text.startswith(expected_text + ": ")


def year_matches(expected: str, observed: str) -> bool:
    return re.match(rf"^{re.escape(expected)}(?:$|[/.-])", observed.strip()) is not None


def same_identity(candidate: dict[str, Any], evidence: dict[str, Any]) -> bool:
    return (
        title_matches(str(candidate["title"]), str(evidence.get("title") or ""))
        and normalized_publisher(str(evidence.get("publisher") or "")) == normalized_publisher(str(candidate["publisher"]))
        and year_matches(str(candidate["year"]), str(evidence.get("year") or ""))
        and normalize(str(evidence.get("language") or "")) == normalize(str(candidate["language"]))
    )


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def preferred_match(matches: list[dict[str, Any]]) -> dict[str, Any] | None:
    """Select a canonical source representation without conflating file variants."""

    eligible = [match for match in matches if match.get("release_boundary_match") is True]
    for suffix in PREFERRED_SUFFIXES:
        for match in eligible:
            if str(match.get("filename") or "").casefold().endswith(suffix):
                return match
    return None


def build(
    candidates_path: Path = DEFAULT_CANDIDATES,
    discovery_path: Path = DEFAULT_DISCOVERY,
    registrations_path: Path = DEFAULT_REGISTRATIONS,
) -> dict[str, Any]:
    candidates = {
        "|".join(str(item[field]).strip().casefold() for field in ("title", "publisher", "year", "language")): item
        for item in load_json(candidates_path)["candidates"]
    }
    registrations_payload = load_json(registrations_path)
    if registrations_payload.get("schema_version") != 1:
        raise ValueError("Unsupported registration schema")
    registrations = list(registrations_payload.get("registrations") or [])
    existing = {record["candidate_key"] for record in registrations}
    proposed = 0
    for record in load_json(discovery_path).get("records") or []:
        candidate_key = record.get("candidate_key")
        candidate = candidates.get(candidate_key)
        if not candidate or candidate_key in existing:
            continue
        match = preferred_match(list(record.get("matches") or []))
        if not match:
            continue
        evidence = match.get("release_boundary_evidence") or {}
        if not same_identity(candidate, evidence):
            continue
        registrations.append(
            {
                "candidate_key": candidate_key,
                "source_url": match["source_url"],
                "source_record_url": match["source_record_url"],
                "source_release_id": match.get("source_release_id"),
                "filename": match["filename"],
                "release_identity": {
                    "title": candidate["title"],
                    "publisher": candidate["publisher"],
                    "year": candidate["year"],
                },
                "source_evidence": "Release identity matched by the Spectrum Computing adapter against title, publisher, year, and language.",
                "external_source_terms": match.get("external_source_terms"),
            }
        )
        existing.add(candidate_key)
        proposed += 1
    registrations.sort(key=lambda record: record["candidate_key"])
    return {
        "schema_version": 1,
        "purpose": registrations_payload.get("purpose"),
        "registrations": registrations,
        "merge_summary": {"new_registrations": proposed, "total_registrations": len(registrations)},
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--candidates", type=Path, default=DEFAULT_CANDIDATES)
    parser.add_argument("--discovery", type=Path, default=DEFAULT_DISCOVERY)
    parser.add_argument("--registrations", type=Path, default=DEFAULT_REGISTRATIONS)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    result = build(args.candidates, args.discovery, args.registrations)
    if args.dry_run:
        print(f"Source registration dry run: {result['merge_summary']['new_registrations']} new registrations.")
        return 0
    args.registrations.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"Source registry updated: {result['merge_summary']['new_registrations']} new registrations, {result['merge_summary']['total_registrations']} total.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
