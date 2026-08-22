#!/usr/bin/env python3
"""Capture pinned official DAAD changelog evidence for the CPC `DAAD.FNT` role.

The captured line records only the official source-package statement that
`DAAD.FNT` is the standard CPC font used by the CPC tape loader. It neither
establishes glyph grammar, a renderer, runtime behavior, nor equivalence for
similarly named FNT files.

    python scripts/capture_official_daad_fnt_cpc_evidence.py --fetch
    python scripts/capture_official_daad_fnt_cpc_evidence.py --check
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import json
import sys
from pathlib import Path
from urllib.request import Request, urlopen


ROOT = Path(__file__).resolve().parents[1]
REVISION = "4a7e745235a12af5b397902dbd9214bc930c7680"
SOURCE_URL = f"https://raw.githubusercontent.com/daad-adventure-writer/daad/{REVISION}/CHANGELOG.md"
DEFAULT_RAW = ROOT / "research" / "sources" / f"daad_official_changelog_{REVISION}.md.gz"
DEFAULT_OUTPUT = ROOT / "research" / "sources" / "daad_official_fnt_cpc_evidence.json"
FNT_LINE = "* DAAD.FNT: the DAAD standard CPC font (this file is used by the CPC tape loader)"
CPC_LOADER_LINES = (
    "* DLPART1.BAS: CPC tape loader template for DAAD adventures with loading screen, loads PART1",
    "* DLPART2.BAS: CPC tape loader template for DAAD adventures with loading screen, loads PART2",
)


def parse_changelog(changelog: str) -> dict[str, object]:
    """Extract the exact documented CPC FNT statement and required loader context."""

    lines = changelog.splitlines()
    try:
        index = lines.index(FNT_LINE)
    except ValueError as error:
        raise ValueError("official DAAD changelog lacks the exact CPC DAAD.FNT statement") from error
    if index < 2 or lines[index - 1] != CPC_LOADER_LINES[1] or lines[index - 2] != CPC_LOADER_LINES[0]:
        raise ValueError("official DAAD changelog lacks the required CPC tape-loader context")
    section_start = max((position for position, line in enumerate(lines[:index]) if line == "## DAAD R3"), default=-1)
    if section_start == -1:
        raise ValueError("official DAAD changelog lacks the DAAD R3 section")
    return {
        "release_section": "DAAD R3",
        "documented_path": r"DAAD\TAPMAST\DAAD.FNT",
        "exact_statement": FNT_LINE.removeprefix("* "),
        "cpc_loader_context": [line.removeprefix("* ") for line in CPC_LOADER_LINES],
    }


def build_snapshot(changelog: str, source_url: str = SOURCE_URL) -> dict[str, object]:
    """Build deterministic source evidence from one pinned raw changelog snapshot."""

    return {
        "schema_version": 1,
        "purpose": "Pinned official DAAD changelog evidence for the documented CPC DAAD.FNT tape-loader role.",
        "source_url": source_url,
        "source_revision": REVISION,
        "source_sha256": hashlib.sha256(changelog.encode("utf-8")).hexdigest(),
        "source_claim": parse_changelog(changelog),
        "boundary": (
            "This source statement identifies a documented CPC package role only. It does not establish "
            "the 896-byte R4 members' glyph grammar, character mapping, byte packing, rendering, runtime "
            "load success, erased-file meaning, or equivalence with SINTAC FNT3/FNT4."
        ),
    }


def _fetch(url: str) -> str:
    request = Request(url, headers={"User-Agent": "DAAD-Harvester/1.0 official-source-capture"})
    with urlopen(request, timeout=30) as response:  # noqa: S310 - URL is an explicit pinned CLI input.
        content_type = response.headers.get_content_type()
        if content_type not in {"text/plain", "text/markdown"}:
            raise ValueError(f"official DAAD source returned {content_type!r}, not text")
        return response.read().decode(response.headers.get_content_charset() or "utf-8")


def _read_raw_snapshot(raw_path: Path) -> str:
    try:
        return gzip.decompress(raw_path.read_bytes()).decode("utf-8")
    except (OSError, UnicodeDecodeError) as error:
        raise ValueError(f"invalid gzip official DAAD changelog snapshot: {raw_path}") from error


def _write_raw_snapshot(raw_path: Path, changelog: str) -> None:
    raw_path.parent.mkdir(parents=True, exist_ok=True)
    raw_path.write_bytes(gzip.compress(changelog.encode("utf-8"), mtime=0))


def _expected_json(raw_path: Path, source_url: str) -> str:
    return json.dumps(build_snapshot(_read_raw_snapshot(raw_path), source_url), indent=2, sort_keys=True) + "\n"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fetch", action="store_true", help="refresh the committed raw snapshot explicitly")
    parser.add_argument("--check", action="store_true", help="verify derived evidence against the committed raw snapshot")
    parser.add_argument("--source-url", default=SOURCE_URL)
    parser.add_argument("--raw-path", type=Path, default=DEFAULT_RAW)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args(argv)
    if args.fetch and args.check:
        parser.error("--fetch and --check are mutually exclusive")
    if args.fetch:
        _write_raw_snapshot(args.raw_path, _fetch(args.source_url))
    if not args.raw_path.is_file():
        parser.error(f"raw source snapshot is missing: {args.raw_path}")
    expected = _expected_json(args.raw_path, args.source_url)
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            print("Official DAAD CPC FNT evidence is stale; regenerate it from the committed raw snapshot", file=sys.stderr)
            return 1
        print("Official DAAD CPC FNT evidence verified")
        return 0
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(expected, encoding="utf-8")
    print("Official DAAD CPC FNT evidence generated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
