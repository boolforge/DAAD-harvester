"""Capture redasm README processor-table boundaries as discovery-only evidence."""
from __future__ import annotations

import argparse
import gzip
import hashlib
import json
import sys
from pathlib import Path
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parents[1]
REPOSITORY_URL = "https://github.com/redasm-dev/redasm"
REVISION = "113245ef02090602978e461fcb7031b75da448d6"
SOURCE_URL = f"https://raw.githubusercontent.com/redasm-dev/redasm/{REVISION}/README.md"
RAW = ROOT / "research" / "sources" / "redasm_README_113245ef_2026-08-22.md.gz"
OUTPUT = ROOT / "research" / "sources" / "redasm_capability_boundary_2026-08-22.json"
PROCESSOR_HEADING = "### Processors (CPU architectures)"
NEXT_SECTION = "### Analyzers"
PROCESSOR_TABLE_MARKERS = (
    "| **x86 / x86_64** | 16-bit, 32-bit and 64-bit Intel/AMD | **S** |",
    "| **MIPS** | MIPS32, big and little endian, delay slot aware | **A** |",
    "| **ARM / Thumb** | ARM32 and Thumb instruction sets | **B** |",
    "| **ARM64** | AArch64 | **A** |",
)
DOCUMENTED_PROCESSORS = [
    {
        "architecture": "x86 / x86_64",
        "description": "16-bit, 32-bit and 64-bit Intel/AMD",
        "status": "S",
    },
    {
        "architecture": "MIPS",
        "description": "MIPS32, big and little endian, delay slot aware",
        "status": "A",
    },
    {
        "architecture": "ARM / Thumb",
        "description": "ARM32 and Thumb instruction sets",
        "status": "B",
    },
    {"architecture": "ARM64", "description": "AArch64", "status": "A"},
]


def _processor_table(readme: str) -> str:
    _, heading, after_heading = readme.partition(PROCESSOR_HEADING)
    table, next_section, _ = after_heading.partition(NEXT_SECTION)
    if not heading or not next_section:
        raise ValueError("pinned redasm README lacks the expected processor-table section")
    return table


def build_snapshot(readme: str) -> dict[str, object]:
    processor_table = _processor_table(readme)
    if any(marker not in processor_table for marker in PROCESSOR_TABLE_MARKERS):
        raise ValueError("pinned redasm README lacks expected processor-table markers")
    if "Z80" in processor_table:
        raise ValueError("pinned redasm README does not retain the expected non-Z80 processor table")
    return {
        "schema_version": 1,
        "purpose": "Discovery-only redasm processor-table boundary; not a native result or platform-support claim.",
        "repository_url": REPOSITORY_URL,
        "revision": REVISION,
        "source_url": SOURCE_URL,
        "source_sha256": hashlib.sha256(readme.encode()).hexdigest(),
        "documented_processors": DOCUMENTED_PROCESSORS,
        "documented_boundaries": [
            "The retained README processor table lists x86 / x86_64, MIPS, ARM / Thumb, and ARM64.",
            "Z80 is not listed in the retained README processor table.",
        ],
        "non_claims": [
            "This record does not install, execute, configure, or validate redasm.",
            "It does not claim that redasm lacks a possible Z80 plugin or configuration outside the retained processor table.",
            "It does not establish Z80, MSX, Spectrum, or Spectrum Next analysis support, a historical load model, runtime behavior, control/data classification, or an interpreter-analysis result.",
            "It does not replace repository-native evidence, retained original bytes, or a reproducible disagreement record.",
        ],
    }


def _fetch() -> str:
    request = Request(SOURCE_URL, headers={"User-Agent": "DAAD-Harvester/1.0 source-capture"})
    with urlopen(request, timeout=30) as response:  # noqa: S310
        return response.read().decode(response.headers.get_content_charset() or "utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fetch", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    if args.fetch:
        RAW.parent.mkdir(parents=True, exist_ok=True)
        RAW.write_bytes(gzip.compress(_fetch().encode(), mtime=0))
    if not RAW.is_file():
        parser.error("committed redasm README snapshot is missing")
    try:
        readme = gzip.decompress(RAW.read_bytes()).decode()
    except (OSError, UnicodeDecodeError) as error:
        raise ValueError("invalid compressed redasm README snapshot") from error
    expected = json.dumps(build_snapshot(readme), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not OUTPUT.is_file() or OUTPUT.read_text() != expected:
            print("redasm capability boundary record is stale", file=sys.stderr)
            return 1
        print("redasm capability boundary record verified")
        return 0
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(expected)
    print("redasm capability boundary record generated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
