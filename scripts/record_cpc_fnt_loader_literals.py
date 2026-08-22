#!/usr/bin/env python3
"""Record exact `DAAD.FNT` byte literals in retained official CPC loader templates.

This is source-package and byte-literal evidence only. It does not decode CPC
BASIC, prove a load call, establish runtime success, or extend FNT glyph grammar.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_OUTPUT = ROOT / "preservation_corpus" / "derived" / "cpc_fnt" / "official_tapmast_loader_literals.json"
SOURCE_ID = 250
FNT_PATH = "preservation_corpus/extracted/depth1_dcd3ab68_DAAD.FNT"
FNT_SHA256 = "fb10eff788f33453e39027e80ee14e022302a31d21d34cfc457ef974f378c15a"
LOADERS = (
    ("DLPART1.BAS", "preservation_corpus/extracted/depth1_469e2636_DLPART1.BAS", "2291b9fbaaf3d7b764650f65fd317336f7e8e95541e30b311ccd9d6103e44df6"),
    ("DLPART2.BAS", "preservation_corpus/extracted/depth1_19c8e032_DLPART2.BAS", "cd410d16d479ec4263c9b1ab08955b9f03b1ff32aba30c79342e181927f1bd09"),
)
LITERAL = b"DAAD.FNT"
LITERAL_TOKEN = b'"!DAAD.FNT",'


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def literal_offsets(data: bytes) -> list[int]:
    """Return every exact byte offset of the observed FNT filename literal."""

    offsets: list[int] = []
    start = 0
    while True:
        token_offset = data.find(LITERAL_TOKEN, start)
        if token_offset < 0:
            return offsets
        offsets.append(token_offset + 2)
        start = token_offset + len(LITERAL_TOKEN)


def build(root: Path = ROOT) -> dict[str, object]:
    """Build a deterministic, exact-identity record for the two official loaders."""

    fnt = root / FNT_PATH
    if digest(fnt) != FNT_SHA256:
        raise ValueError("retained CPC FNT does not match the expected exact byte identity")
    loaders: list[dict[str, object]] = []
    for name, relative_path, expected_sha256 in LOADERS:
        path = root / relative_path
        actual = digest(path)
        if actual != expected_sha256:
            raise ValueError(f"retained {name} does not match the expected exact byte identity")
        offsets = literal_offsets(path.read_bytes())
        if offsets != [195]:
            raise ValueError(f"{name} lacks the expected single DAAD.FNT literal at byte offset 195")
        loaders.append({"filename": name, "path": relative_path, "sha256": actual, "literal": "DAAD.FNT", "literal_offsets": offsets})
    return {
        "schema_version": 1,
        "purpose": "Exact retained-byte literal evidence connecting official CPC DLPART loader templates with the byte-identified DAAD.FNT resource.",
        "profile": "official_cpc_tapmast_daad_fnt_literal_v1",
        "source_id": SOURCE_ID,
        "fnt": {"path": FNT_PATH, "sha256": FNT_SHA256, "native_profile": "daad-cpc-standard-tape-loader-font"},
        "loaders": loaders,
        "relationship_state": "observed_exact_filename_literal",
        "documentation_evidence": "research/sources/daad_official_fnt_cpc_evidence.json",
        "non_claims": [
            "A filename literal does not prove a tokenized BASIC load call or runtime load success.",
            "This record does not establish glyph grammar, rendering, character mapping, or proportional-width semantics.",
            "This exact source-package profile does not generalize to similarly named loaders or FNT files.",
        ],
    }


def render(root: Path = ROOT) -> str:
    return json.dumps(build(root), indent=2, sort_keys=True) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--write", action="store_true")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if args.write == args.check:
        parser.error("select exactly one of --write or --check")
    expected = render()
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            raise AssertionError(f"CPC FNT loader literal record is stale: {args.output}")
        print("CPC FNT loader literals verified")
    else:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(expected, encoding="utf-8")
        print("CPC FNT loader literals written")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
