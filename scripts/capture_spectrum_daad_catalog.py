#!/usr/bin/env python3
"""Capture Spectrum Computing's public DAAD relationship catalog reproducibly.

The source is discovery evidence only.  A relationship row records the fields shown
by the public catalog and intentionally does not establish a downloadable binary,
engine profile, language, license, or edition equivalence.  The primary path uses a
committed raw HTML snapshot; network refresh is explicit and never occurs in
``--check`` mode.

    python scripts/capture_spectrum_daad_catalog.py --fetch
    python scripts/capture_spectrum_daad_catalog.py --check
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import json
import re
import sys
from pathlib import Path
from urllib.request import Request, urlopen

from bs4 import BeautifulSoup


ROOT = Path(__file__).resolve().parents[1]
SOURCE_URL = "https://spectrumcomputing.co.uk/entry/30013/ZX-Spectrum/DAAD"
DEFAULT_RAW = ROOT / "research" / "sources" / "spectrumcomputing_daad_2026-08-22.html.gz"
LEGACY_UNCOMPRESSED_RAW = ROOT / "research" / "sources" / "spectrumcomputing_daad_2026-08-22.html"
DEFAULT_OUTPUT = ROOT / "research" / "sources" / "spectrumcomputing_daad_relationships_2026-08-22.json"
ENTRY_PATH = re.compile(r"^/entry/(\d+)/([^/]+)/(.+)$")
YEAR = re.compile(r"^\s*(\d{4})\s*$")


def _compact_text(node: object) -> str:
    """Collapse presentation whitespace without normalizing catalog spelling."""

    if not hasattr(node, "get_text"):
        return ""
    return " ".join(node.get_text(" ", strip=True).split())


def _column_text(column: object, label: str) -> str:
    """Get desktop text while dropping duplicated mobile-only labels."""

    if not hasattr(column, "find_all"):
        return ""
    for label_node in column.find_all("b", class_="visible-xs visible-sm"):
        label_node.decompose()
    value = _compact_text(column)
    return value.removeprefix(label).strip()


def parse_relationship_catalog(html: str, source_url: str = SOURCE_URL) -> list[dict[str, object]]:
    """Parse only rows in the public DAAD authored/executed relationship panel.

    A malformed panel, missing entry link, or a non-four-column row is rejected so
    that a changed site layout cannot silently yield an empty or shifted catalog.
    """

    soup = BeautifulSoup(html, "html.parser")
    panel = soup.find(id="collapse_authored")
    if panel is None:
        raise ValueError("Spectrum Computing DAAD relationship panel is missing")

    records: list[dict[str, object]] = []
    seen_release_ids: set[str] = set()
    for row in panel.select("div.row.zxdb_stripes"):
        columns = row.find_all("div", recursive=False)
        if len(columns) != 4:
            raise ValueError("Spectrum Computing relationship row does not have four columns")
        title_link = columns[0].find("a", href=True)
        publisher_link = columns[1].find("a", href=True)
        if title_link is None or publisher_link is None:
            raise ValueError("Spectrum Computing relationship row lacks title or publisher link")
        match = ENTRY_PATH.fullmatch(title_link["href"])
        if match is None:
            raise ValueError(f"unexpected Spectrum Computing release path: {title_link['href']!r}")
        release_id, platform_path, _slug = match.groups()
        if release_id in seen_release_ids:
            raise ValueError(f"duplicate Spectrum Computing release identifier: {release_id}")
        seen_release_ids.add(release_id)
        raw_year = _column_text(columns[2], "Release Year:")
        if raw_year and not YEAR.fullmatch(raw_year):
            raise ValueError(f"unexpected Spectrum Computing release year: {raw_year!r}")
        records.append(
            {
                "catalog_entry_url": f"https://spectrumcomputing.co.uk{title_link['href']}",
                "catalog_release_id": release_id,
                "catalog_platform_path": platform_path,
                "displayed_publisher": _compact_text(publisher_link),
                "displayed_title": _compact_text(title_link),
                "displayed_year": int(raw_year) if raw_year else None,
                "language": None,
                "relationship_state": "catalog_relationship_only",
            }
        )
    if not records:
        raise ValueError("Spectrum Computing relationship panel contains no release rows")
    return records


def build_snapshot(raw_html: str, source_url: str = SOURCE_URL) -> dict[str, object]:
    """Return a deterministic derived record tied to exact raw source bytes."""

    records = parse_relationship_catalog(raw_html, source_url)
    return {
        "schema_version": 1,
        "purpose": "Public Spectrum Computing DAAD relationship catalog captured as discovery evidence only.",
        "source_url": source_url,
        "source_sha256": hashlib.sha256(raw_html.encode("utf-8")).hexdigest(),
        "relationship_label": "Programs authored (or executed) with this title",
        "record_count": len(records),
        "policy": (
            "A row records only the displayed catalog relationship, entry URL, publisher, "
            "platform path, and year when present. It neither authorizes download nor "
            "establishes language, DAAD format support, release equivalence, or binary identity."
        ),
        "records": records,
    }


def _fetch(url: str) -> str:
    request = Request(url, headers={"User-Agent": "DAAD-Harvester/1.0 catalog-capture"})
    with urlopen(request, timeout=30) as response:  # noqa: S310 - URL is explicit CLI input.
        content_type = response.headers.get_content_type()
        if content_type != "text/html":
            raise ValueError(f"Spectrum Computing returned {content_type!r}, not HTML")
        return response.read().decode(response.headers.get_content_charset() or "utf-8")


def _read_raw_snapshot(raw_path: Path) -> str:
    """Read the committed compressed HTML without changing its logical source bytes."""

    try:
        return gzip.decompress(raw_path.read_bytes()).decode("utf-8")
    except (OSError, UnicodeDecodeError) as error:
        raise ValueError(f"invalid gzip HTML snapshot: {raw_path}") from error


def _write_raw_snapshot(raw_path: Path, raw_html: str) -> None:
    """Store HTML in a deterministic binary container suitable for Git evidence retention."""

    raw_path.parent.mkdir(parents=True, exist_ok=True)
    raw_path.write_bytes(gzip.compress(raw_html.encode("utf-8"), mtime=0))


def _expected_json(raw_path: Path, source_url: str) -> str:
    raw_html = _read_raw_snapshot(raw_path)
    return json.dumps(build_snapshot(raw_html, source_url), indent=2, sort_keys=True) + "\n"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fetch", action="store_true", help="refresh the committed raw source snapshot explicitly")
    parser.add_argument("--migrate-raw", action="store_true", help="convert the legacy uncompressed source snapshot to deterministic gzip")
    parser.add_argument("--check", action="store_true", help="verify the derived JSON against the committed raw source")
    parser.add_argument("--source-url", default=SOURCE_URL)
    parser.add_argument("--raw-path", type=Path, default=DEFAULT_RAW)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args(argv)
    if sum((args.fetch, args.migrate_raw, args.check)) > 1:
        parser.error("--fetch, --migrate-raw, and --check are mutually exclusive")

    if args.fetch:
        _write_raw_snapshot(args.raw_path, _fetch(args.source_url))
    if args.migrate_raw:
        if args.raw_path != DEFAULT_RAW or not LEGACY_UNCOMPRESSED_RAW.is_file():
            parser.error("the legacy uncompressed DAAD source snapshot is unavailable")
        _write_raw_snapshot(args.raw_path, LEGACY_UNCOMPRESSED_RAW.read_text(encoding="utf-8"))
        LEGACY_UNCOMPRESSED_RAW.unlink()

    if not args.raw_path.is_file():
        parser.error(f"raw source snapshot is missing: {args.raw_path}")
    expected = _expected_json(args.raw_path, args.source_url)
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            print(
                "Spectrum Computing DAAD relationship snapshot is stale; "
                "regenerate it from the committed raw snapshot",
                file=sys.stderr,
            )
            return 1
        print(f"Spectrum Computing DAAD relationship snapshot verified: {json.loads(expected)['record_count']} records.")
        return 0

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(expected, encoding="utf-8")
    print(f"Spectrum Computing DAAD relationship snapshot generated: {json.loads(expected)['record_count']} records.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
