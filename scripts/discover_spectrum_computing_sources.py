#!/usr/bin/env python3
"""Discover release-boundary ZX downloads from Spectrum Computing.

The adapter records public candidate URLs only when the source entry confirms
an exact title, publisher, year, language, and a game-media download. It never
modifies the acquisition registry or downloads the game bytes.
"""

from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path
import re
import time
from typing import Any
from urllib.parse import quote, urljoin
from urllib.request import Request, urlopen

from bs4 import BeautifulSoup

from daad_harvester.acquisition import global_authorization_decision
ROOT = Path(__file__).resolve().parents[1]
SUPPORTED_SUFFIXES = frozenset({
    ".zip", ".7z", ".rar", ".tar", ".gz", ".tgz", ".bz2", ".xz", ".dsk", ".d64", ".d71",
    ".t64", ".tap", ".tzx", ".cdt", ".adf", ".adz", ".dms", ".msa", ".st", ".ipf", ".stx",
    ".cas", ".rom", ".prg", ".p00", ".com", ".exe",
})


def normalize(value: str) -> str:
    return " ".join("".join(char for char in value.casefold() if char.isalnum() or char.isspace()).split())


DEFAULT_QUEUE = ROOT / "research" / "authorized_acquisition_queue.json"
DEFAULT_POLICY = ROOT / "research" / "acquisition_policy.json"
DEFAULT_OUTPUT = ROOT / "research" / "candidate_spectrum_source_discovery.json"
BASE_URL = "https://spectrumcomputing.co.uk"


def fetch_html(url: str, timeout: int = 20) -> str:
    request = Request(url, headers={"User-Agent": "DAAD-Harvester/1.0 evidence discovery"})
    with urlopen(request, timeout=timeout) as response:  # nosec B310: bounded public archive URL
        return response.read().decode("utf-8", errors="replace")


def search_entry_urls(title: str) -> list[str]:
    """Return bounded, unique ZX entry URLs from Spectrum Computing's public search."""

    url = f"{BASE_URL}/list?quick=s&text={quote(title)}"
    soup = BeautifulSoup(fetch_html(url), "html.parser")
    entries = {
        urljoin(BASE_URL, anchor["href"])
        for anchor in soup.find_all("a", href=True)
        if re.match(r"^/entry/\d+/ZX-Spectrum/", anchor["href"])
    }
    return sorted(entries)[:30]


def value_between(page_text: str, label: str, following_label: str) -> str | None:
    """Extract a visible labelled value from Spectrum Computing's entry layout."""

    match = re.search(
        rf"\b{re.escape(label)}:\s*(.*?)\s*\b{re.escape(following_label)}:",
        page_text,
        flags=re.IGNORECASE | re.DOTALL,
    )
    return " ".join(match.group(1).split()) if match else None


def normalized_publisher(value: str) -> str:
    return normalize(re.sub(r"\([^)]*\)", " ", value))


def publisher_matches(expected: str, observed: str | None) -> bool:
    return observed is not None and normalized_publisher(expected) == normalized_publisher(observed)


def direct_game_downloads(soup: BeautifulSoup) -> list[dict[str, str]]:
    """Return download links confined to Spectrum Computing's game-media path."""

    files: list[dict[str, str]] = []
    for anchor in soup.find_all("a", href=True):
        url = urljoin(BASE_URL, anchor["href"])
        path = Path(url.split("?", 1)[0])
        if "/pub/sinclair/games/" not in url or path.suffix.casefold() not in SUPPORTED_SUFFIXES:
            continue
        files.append({"source_url": url, "filename": path.name})
    unique = {(entry["source_url"], entry["filename"]): entry for entry in files}
    return [unique[key] for key in sorted(unique)]


def inspect_entry(candidate: dict[str, Any], entry_url: str) -> list[dict[str, Any]]:
    """Return release-boundary source records from one public entry, or none."""

    soup = BeautifulSoup(fetch_html(entry_url), "html.parser")
    text = soup.get_text(" ", strip=True)
    title = value_between(text, "Title", "Release Date")
    year = value_between(text, "Release Date", "Original Publisher")
    publisher = value_between(text, "Original Publisher", "Creators")
    language = value_between(text, "Message Language", "Machine Type")
    if not (
        title and normalize(title) == normalize(str(candidate["title"]))
        and year == str(candidate["year"])
        and publisher_matches(str(candidate["publisher"]), publisher)
        and language and normalize(language) == normalize(str(candidate["language"]))
    ):
        return []
    entry_match = re.search(r"/entry/(\d+)/", entry_url)
    entry_id = entry_match.group(1) if entry_match else None
    terms = "personal_usage_only_no_third_party_offering" if "personal usage" in text.casefold() else None
    return [
        {
            **file_info,
            "source_record_url": entry_url,
            "source_release_id": entry_id,
            "release_boundary_match": True,
            "release_boundary_evidence": {
                "title": title,
                "publisher": publisher,
                "year": year,
                "language": language,
            },
            "external_source_terms": terms,
        }
        for file_info in direct_game_downloads(soup)
    ]


def discover_candidate(candidate: dict[str, Any]) -> dict[str, Any]:
    matches: list[dict[str, Any]] = []
    for entry_url in search_entry_urls(str(candidate["title"])):
        matches.extend(inspect_entry(candidate, entry_url))
    matches.sort(key=lambda record: (record["source_record_url"], record["filename"]))
    return {
        "candidate_key": candidate["candidate_key"],
        "title": candidate["title"],
        "publisher": candidate["publisher"],
        "year": candidate["year"],
        "language": candidate["language"],
        "status": "release_boundary_source_discovered" if matches else "no_release_boundary_source_match",
        "matches": matches,
    }


def discover(queue: dict[str, Any], policy: dict[str, Any], workers: int) -> dict[str, Any]:
    decision = global_authorization_decision(policy)
    if not decision.allowed:
        raise ValueError(f"Global authorization policy rejected: {decision.reason}")
    candidates = list(queue.get("discovery_required") or [])

    def one(candidate: dict[str, Any]) -> dict[str, Any]:
        try:
            return discover_candidate(candidate)
        except Exception as exc:  # retain source-specific diagnostics rather than fabricating a miss
            return {
                "candidate_key": candidate["candidate_key"],
                "title": candidate["title"],
                "publisher": candidate["publisher"],
                "year": candidate["year"],
                "language": candidate["language"],
                "status": "discovery_error",
                "error": f"{type(exc).__name__}: {exc}",
                "matches": [],
            }

    with ThreadPoolExecutor(max_workers=max(1, min(workers, 8))) as executor:
        records = list(executor.map(one, candidates))
    records.sort(key=lambda record: record["candidate_key"])
    return {
        "schema_version": 1,
        "purpose": "Spectrum Computing direct ZX game-media discovery for institutionally authorized catalog candidates; no bytes are downloaded in this phase.",
        "source_homepage": BASE_URL,
        "generated_at_epoch": int(time.time()),
        "input_candidate_count": len(candidates),
        "release_boundary_source_candidate_count": sum(bool(record["matches"]) for record in records),
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
    print(
        "Spectrum Computing discovery completed: "
        f"{result['release_boundary_source_candidate_count']} release-boundary matches out of {result['input_candidate_count']} candidates."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
