"""Capture ZXDAAD128 README load assumptions as external comparator discovery evidence.

This record does not execute ZXDAAD128, validate a retained artifact, or establish
historical ZX, Spectrum Next, runtime, or compatibility behavior.
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
REPOSITORY_URL = "https://github.com/cronomantic/ZXDAAD128"
REVISION = "fe714e0784cd4d152116c0d9b80aaba3b0afa76a"
SOURCE_URL = f"https://raw.githubusercontent.com/cronomantic/ZXDAAD128/{REVISION}/README.md"
RAW = ROOT / "research" / "sources" / "zxdaad128_README_fe714e0_2026-08-22.md.gz"
OUTPUT = ROOT / "research" / "sources" / "zxdaad128_load_boundary_2026-08-22.json"
AD0_SENTENCE = "The file with extension `.AD0` should be loaded with the bank 0 active at the address 0x6000 and jump to address 0x6002 in order to run."
OTHER_BANKS_SENTENCE = "The other files (if any), should be loaded at 0xC000 with the corresponding bank of the extension active."


def build_snapshot(readme: str) -> dict[str, object]:
    """Extract the exact documented modern load assumptions from retained bytes."""

    for sentence in (AD0_SENTENCE, OTHER_BANKS_SENTENCE):
        if sentence not in readme:
            raise ValueError("pinned ZXDAAD128 README lacks an expected load-assumption statement")
    return {
        "schema_version": 1,
        "purpose": "Discovery-only ZXDAAD128 documented load boundary; not a retained-artifact validation or platform-support claim.",
        "repository_url": REPOSITORY_URL,
        "revision": REVISION,
        "source_url": SOURCE_URL,
        "source_sha256": hashlib.sha256(readme.encode("utf-8")).hexdigest(),
        "documented_load_assumptions": {"ad0_bank": 0, "ad0_load_address": "0x6000", "ad0_entry_address": "0x6002", "other_bank_load_address": "0xC000"},
        "non_claims": [
            "This record does not install, execute, configure, or validate ZXDAAD128.",
            "It does not establish a load model, paging state, or runtime behavior for any retained historical artifact.",
            "It does not establish Spectrum Next support or compatibility with ZXDAAD128.",
        ],
    }


def _fetch() -> str:
    request = Request(SOURCE_URL, headers={"User-Agent": "DAAD-Harvester/1.0 source-capture"})
    with urlopen(request, timeout=30) as response:  # noqa: S310 - fixed public source URL.
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
        parser.error("committed ZXDAAD128 README snapshot is missing")
    try:
        readme = gzip.decompress(RAW.read_bytes()).decode("utf-8")
    except (OSError, UnicodeDecodeError) as error:
        raise ValueError("invalid compressed ZXDAAD128 README snapshot") from error
    expected = json.dumps(build_snapshot(readme), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not OUTPUT.is_file() or OUTPUT.read_text(encoding="utf-8") != expected:
            print("ZXDAAD128 load boundary record is stale", file=sys.stderr)
            return 1
        print("ZXDAAD128 load boundary record verified")
        return 0
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(expected, encoding="utf-8")
    print("ZXDAAD128 load boundary record generated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
