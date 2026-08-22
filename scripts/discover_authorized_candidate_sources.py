#!/usr/bin/env python3
"""Discover direct Internet Archive binary URLs for globally authorized candidates.

This phase discovers candidate-specific direct URLs only. It does not download bytes,
modify the corpus, or promote an item to byte-measured evidence.
"""

from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path
import time
from typing import Any
from urllib.parse import quote
from urllib.request import Request, urlopen

from daad_harvester.acquisition import global_authorization_decision

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_QUEUE = ROOT / "research" / "authorized_acquisition_queue.json"
DEFAULT_POLICY = ROOT / "research" / "acquisition_policy.json"
DEFAULT_OUTPUT = ROOT / "research" / "candidate_direct_source_discovery.json"
SUPPORTED_SUFFIXES = frozenset({
    ".zip", ".7z", ".rar", ".tar", ".gz", ".tgz", ".bz2", ".xz", ".dsk", ".d64", ".d71",
    ".t64", ".tap", ".tzx", ".cdt", ".adf", ".adz", ".dms", ".msa", ".st", ".ipf", ".stx",
    ".cas", ".rom", ".prg", ".p00", ".com", ".exe",
})


def normalize(value: str) -> str:
    return " ".join("".join(char for char in value.casefold() if char.isalnum() or char.isspace()).split())


def archive_title_matches(candidate_title: str, archive_title: str, publisher: str) -> bool:
    """Match a title exactly, allowing only a trailing publisher decoration."""

    expected = normalize(candidate_title)
    observed = normalize(archive_title)
    publisher_normalized = normalize(publisher)
    if observed == expected:
        return True
    if publisher_normalized and observed == f"{expected} {publisher_normalized}":
        return True
    return False


def fetch_json(url: str, timeout: int = 20) -> dict[str, Any]:
    request = Request(url, headers={"User-Agent": "DAAD-Harvester/1.0 evidence discovery"})
    with urlopen(request, timeout=timeout) as response:  # nosec B310: bounded public API URL
        return json.loads(response.read().decode("utf-8"))


def matching_direct_files(candidate: dict[str, Any]) -> tuple[list[dict[str, str]], list[dict[str, str]]]:
    title = candidate["title"]
    query = quote(f'title:("{title}") AND mediatype:software', safe="")
    search_url = f"https://archive.org/advancedsearch.php?q={query}&fl[]=identifier&fl[]=title&rows=20&page=1&output=json"
    payload = fetch_json(search_url)
    boundary_matches: list[dict[str, str]] = []
    title_only_matches: list[dict[str, str]] = []
    for item in (payload.get("response") or {}).get("docs") or []:
        identifier = str(item.get("identifier") or "")
        archive_title = str(item.get("title") or "")
        if not identifier or not archive_title_matches(title, archive_title, str(candidate["publisher"])):
            continue
        metadata_url = f"https://archive.org/metadata/{quote(identifier, safe='')}"
        metadata = fetch_json(metadata_url)
        metadata_fields = metadata.get("metadata") or {}
        boundary_text = " ".join(
            str(metadata_fields.get(field) or "")
            for field in ("identifier", "title", "creator", "publisher", "year", "date", "description")
        ) + f" {identifier}"
        year_match = str(candidate["year"]) in boundary_text
        publisher_match = normalize(candidate["publisher"]) in normalize(boundary_text)
        for file_info in metadata.get("files") or []:
            name = str(file_info.get("name") or "")
            suffix = Path(name).suffix.casefold()
            if suffix not in SUPPORTED_SUFFIXES:
                continue
            record = {
                    "source_url": f"https://archive.org/download/{quote(identifier, safe='')}/{quote(name, safe='/')}",
                    "source_record_url": metadata_url,
                    "source_release_id": identifier,
                    "filename": name,
                    "archive_sha1": str(file_info.get("sha1") or "") or None,
                    "archive_md5": str(file_info.get("md5") or "") or None,
                    "release_boundary_match": year_match and publisher_match,
                    "release_boundary_evidence": boundary_text,
                }
            if year_match and publisher_match:
                boundary_matches.append(record)
            else:
                title_only_matches.append(record)
    sorter = lambda entry: (entry["source_release_id"], entry["filename"])
    return sorted(boundary_matches, key=sorter), sorted(title_only_matches, key=sorter)


def discover(queue: dict[str, Any], policy: dict[str, Any], workers: int) -> dict[str, Any]:
    decision = global_authorization_decision(policy)
    if not decision.allowed:
        raise ValueError(f"Global authorization policy rejected: {decision.reason}")
    candidates = list(queue.get("discovery_required") or [])

    def one(candidate: dict[str, Any]) -> dict[str, Any]:
        try:
            matches, title_only_matches = matching_direct_files(candidate)
            return {
                "candidate_key": candidate["candidate_key"],
                "title": candidate["title"],
                "publisher": candidate["publisher"],
                "year": candidate["year"],
                "language": candidate["language"],
                "status": "release_boundary_source_discovered" if matches else "title_only_source_match" if title_only_matches else "no_exact_source_match",
                "matches": matches,
                "title_only_matches": title_only_matches,
            }
        except Exception as exc:  # record a source-level error; do not hide it
            return {
                "candidate_key": candidate["candidate_key"],
                "title": candidate["title"],
                "publisher": candidate["publisher"],
                "year": candidate["year"],
                "language": candidate["language"],
                "status": "discovery_error",
                "error": f"{type(exc).__name__}: {exc}",
                "matches": [],
                "title_only_matches": [],
            }

    with ThreadPoolExecutor(max_workers=max(1, min(workers, 8))) as executor:
        records = list(executor.map(one, candidates))
    records.sort(key=lambda item: item["candidate_key"])
    return {
        "schema_version": 1,
        "purpose": "Direct Internet Archive source discovery for institutionally authorized catalog candidates; no bytes are downloaded in this phase.",
        "generated_at_epoch": int(time.time()),
        "authorization_policy": str(DEFAULT_POLICY.relative_to(ROOT)),
        "candidate_queue": str(DEFAULT_QUEUE.relative_to(ROOT)),
        "input_candidate_count": len(candidates),
        "release_boundary_source_candidate_count": sum(bool(record["matches"]) for record in records),
        "title_only_source_candidate_count": sum(bool(record["title_only_matches"]) for record in records),
        "records": records,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--queue", type=Path, default=DEFAULT_QUEUE)
    parser.add_argument("--policy", type=Path, default=DEFAULT_POLICY)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--workers", type=int, default=4)
    args = parser.parse_args()
    queue = json.loads(args.queue.read_text(encoding="utf-8"))
    policy = json.loads(args.policy.read_text(encoding="utf-8"))
    result = discover(queue, policy, args.workers)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"Direct-source discovery completed: {result['release_boundary_source_candidate_count']} release-boundary matches, {result['title_only_source_candidate_count']} title-only matches, out of {result['input_candidate_count']} candidates.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
