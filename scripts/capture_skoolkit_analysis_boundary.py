"""Capture SkoolKit README analysis boundaries as discovery-only evidence."""
from __future__ import annotations
import argparse
import gzip
import hashlib
import json
import sys
from pathlib import Path
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parents[1]
REPOSITORY_URL = "https://github.com/skoolkid/skoolkit"
REVISION = "760eeaa012926b4220ea5a370a2bdf99ba098eb0"
SOURCE_URL = f"https://raw.githubusercontent.com/skoolkid/skoolkit/{REVISION}/README.md"
RAW = ROOT / "research" / "sources" / "skoolkit_README_760eeaa_2026-08-22.md.gz"
OUTPUT = ROOT / "research" / "sources" / "skoolkit_analysis_boundary_2026-08-22.json"
STATIC = "(an attempt to identify routines and data blocks by static analysis) from a"
EXECUTION = "to generate a much better control file that more reliably distinguishes code"


def build_snapshot(readme: str) -> dict[str, object]:
    if STATIC not in readme or EXECUTION not in readme or "code execution map produced by an emulator" not in readme:
        raise ValueError("pinned SkoolKit README lacks expected analysis-boundary statements")
    return {"schema_version": 1, "purpose": "Discovery-only SkoolKit analysis boundary; not a native result or platform-support claim.", "repository_url": REPOSITORY_URL, "revision": REVISION, "source_url": SOURCE_URL, "source_sha256": hashlib.sha256(readme.encode()).hexdigest(), "documented_inputs": ["SNA snapshot", "SZX snapshot", "Z80 snapshot", "raw memory file"], "documented_boundaries": ["Static classification is described as an attempt.", "Improved code/data distinction uses an emulator-produced execution map."], "non_claims": ["This record does not install, execute, or validate SkoolKit.", "It does not establish retained-artifact control/data classification, a historical load model, runtime behavior, or Spectrum Next support.", "It does not replace repository-native evidence or preserve an emulator result."]}


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
        parser.error("committed SkoolKit README snapshot is missing")
    try:
        readme = gzip.decompress(RAW.read_bytes()).decode()
    except (OSError, UnicodeDecodeError) as error:
        raise ValueError("invalid compressed SkoolKit README snapshot") from error
    expected = json.dumps(build_snapshot(readme), indent=2, sort_keys=True) + "\n"
    if args.check:
        if not OUTPUT.is_file() or OUTPUT.read_text() != expected:
            print("SkoolKit analysis boundary record is stale", file=sys.stderr)
            return 1
        print("SkoolKit analysis boundary record verified")
        return 0
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(expected)
    print("SkoolKit analysis boundary record generated")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
