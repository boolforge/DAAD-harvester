"""Capture py8dis documentation as a CPU-capability boundary record.

The committed path regenerates a discovery-only record from retained upstream README
bytes. It establishes neither py8dis output nor Z80 compatibility, and does not run,
install, or rely on py8dis for any preservation claim.
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
REPOSITORY_URL = "https://github.com/ZornsLemma/py8dis"
REVISION = "2a6046356e20e93c4a2d484bc04bd5d74d66254e"
SOURCE_URL = f"https://raw.githubusercontent.com/ZornsLemma/py8dis/{REVISION}/README.md"
RAW = ROOT / "research" / "sources" / "py8dis_README_2a604635_2026-08-22.md.gz"
OUTPUT = ROOT / "research" / "sources" / "py8dis_capability_boundary_2026-08-22.json"
CAPABILITY_SENTENCE = (
    "py8dis is a programmable static tracing disassembler written in Python. "
    "It can currently disassemble 6502, 65C02 and 8080 code, and could be extended "
    "without too much difficulty to other 8-bit CPUs in the future."
)


def build_snapshot(readme: str) -> dict[str, object]:
    """Return the exact documented CPU-capability boundary from retained bytes."""

    if CAPABILITY_SENTENCE not in readme:
        raise ValueError("pinned py8dis README lacks the expected CPU-capability statement")
    return {
        "schema_version": 1,
        "purpose": "Discovery-only py8dis capability boundary; not a Z80 comparator result or platform-support claim.",
        "repository_url": REPOSITORY_URL,
        "revision": REVISION,
        "source_url": SOURCE_URL,
        "source_sha256": hashlib.sha256(readme.encode("utf-8")).hexdigest(),
        "documented_cpu_support": ["6502", "65C02", "8080"],
        "z80_capability": "not included in the retained README's explicit current CPU-support statement",
        "non_claims": [
            "This record does not install, execute, configure, or validate py8dis.",
            "It does not establish Z80 instruction support, a Spectrum Next load model, or a DAAD interpreter result.",
            "It does not replace the repository-native primary evidence path or any independent comparator run.",
        ],
    }


def _fetch() -> str:
    request = Request(SOURCE_URL, headers={"User-Agent": "DAAD-Harvester/1.0 source-capture"})
    with urlopen(request, timeout=30) as response:  # noqa: S310 - fixed public source URL.
        return response.read().decode(response.headers.get_content_charset() or "utf-8")


def main(argv: list[str] | None = None) -> int:
    """Capture public documentation explicitly or verify committed bytes offline."""

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fetch", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    if args.fetch:
        RAW.parent.mkdir(parents=True, exist_ok=True)
        RAW.write_bytes(gzip.compress(_fetch().encode("utf-8"), mtime=0))
    if not RAW.is_file():
        parser.error("committed py8dis README snapshot is missing")
    try:
        readme = gzip.decompress(RAW.read_bytes()).decode("utf-8")
    except (OSError, UnicodeDecodeError) as error:
        raise ValueError("invalid compressed py8dis README snapshot") from error
    expected = json.dumps(build_snapshot(readme), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not OUTPUT.is_file() or OUTPUT.read_text(encoding="utf-8") != expected:
            print("py8dis capability boundary record is stale", file=sys.stderr)
            return 1
        print("py8dis capability boundary record verified")
        return 0
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(expected, encoding="utf-8")
    print("py8dis capability boundary record generated")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
