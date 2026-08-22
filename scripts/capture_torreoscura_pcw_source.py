"""Capture the public Torreoscura PCW download index as discovery evidence only.

The committed path verifies retained HTML bytes without network access. It records the
site's PCW DAAD port declaration and the direct archive link, but does not acquire
media, establish publisher/year identity, or claim byte equivalence.
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import json
import sys
from pathlib import Path
from urllib.request import Request, urlopen

from bs4 import BeautifulSoup

ROOT = Path(__file__).resolve().parents[1]
SOURCE_URL = "https://zonafi.es/torreoscura/descargas.html"
RAW = ROOT / "research" / "sources" / "torreoscura_pcw_download_index_2026-08-22.html.gz"
OUTPUT = ROOT / "research" / "sources" / "torreoscura_pcw_download_index_2026-08-22.json"
PCW_TEXT = "Versión Amstrad PCW"
PCW_ARCHIVE = "https://zonafi.es/torreoscura/to_pcw.zip"


def build_snapshot(html: str) -> dict[str, object]:
    soup = BeautifulSoup(html, "html.parser")
    links = [link for link in soup.find_all("a", href=True) if " ".join(link.get_text(" ", strip=True).split()) == PCW_TEXT]
    if len(links) != 1:
        raise ValueError("public download index lacks exactly one PCW link")
    href = links[0]["href"]
    if href != "to_pcw.zip":
        raise ValueError(f"unexpected PCW archive link: {href!r}")
    return {
        "schema_version": 1,
        "purpose": "Public author-site discovery evidence for Torreoscura's PCW download link; not media identity or acquisition evidence.",
        "source_url": SOURCE_URL,
        "source_sha256": hashlib.sha256(html.encode("utf-8")).hexdigest(),
        "pcw_link_text": PCW_TEXT,
        "pcw_archive_url": PCW_ARCHIVE,
        "non_claims": [
            "The archive has not been acquired or checksum measured by this record.",
            "The page does not establish release metadata, byte equivalence, loader behavior, or PARTE000.PIC grammar.",
        ],
    }


def _fetch() -> str:
    request = Request(SOURCE_URL, headers={"User-Agent": "DAAD-Harvester/1.0 source-capture"})
    with urlopen(request, timeout=30) as response:  # noqa: S310 - fixed public source URL.
        if response.headers.get_content_type() != "text/html":
            raise ValueError("public download index is not HTML")
        return response.read().decode(response.headers.get_content_charset() or "utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fetch", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    if args.fetch:
        RAW.parent.mkdir(parents=True, exist_ok=True)
        RAW.write_bytes(gzip.compress(_fetch().encode("utf-8"), mtime=0))
    if not RAW.is_file():
        parser.error("committed raw source snapshot is missing")
    try:
        html = gzip.decompress(RAW.read_bytes()).decode("utf-8")
    except (OSError, UnicodeDecodeError) as error:
        raise ValueError("invalid compressed source snapshot") from error
    expected = json.dumps(build_snapshot(html), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not OUTPUT.is_file() or OUTPUT.read_text(encoding="utf-8") != expected:
            print("Torreoscura PCW discovery record is stale", file=sys.stderr)
            return 1
        print("Torreoscura PCW discovery record verified")
        return 0
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(expected, encoding="utf-8")
    print("Torreoscura PCW discovery record generated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
