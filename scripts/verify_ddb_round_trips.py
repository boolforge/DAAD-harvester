#!/usr/bin/env python3
"""Generate or verify retained native DDB byte-identical round-trip evidence."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Sequence

from daad_harvester.ddb_round_trip_evidence import (
    REPOSITORY_ROOT,
    retained_ddb_round_trip_evidence,
)


DEFAULT_OUTPUT = REPOSITORY_ROOT / "preservation_corpus/ddb_round_trip_evidence.json"


def canonical_json(evidence: dict[str, object]) -> str:
    """Return the checked-in, deterministic JSON representation."""

    return json.dumps(evidence, indent=2, sort_keys=True) + "\n"


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument(
        "--write",
        action="store_true",
        help="regenerate the committed round-trip evidence file",
    )
    mode.add_argument(
        "--check",
        action="store_true",
        help="fail unless the committed evidence file matches native regeneration",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=DEFAULT_OUTPUT,
        help="evidence JSON path (default: preservation_corpus/ddb_round_trip_evidence.json)",
    )
    arguments = parser.parse_args(argv)
    rendered = canonical_json(retained_ddb_round_trip_evidence())
    if arguments.write:
        arguments.output.parent.mkdir(parents=True, exist_ok=True)
        arguments.output.write_text(rendered, encoding="utf-8")
    elif arguments.check:
        if not arguments.output.is_file():
            raise SystemExit(f"missing round-trip evidence: {arguments.output}")
        existing = arguments.output.read_text(encoding="utf-8")
        if existing != rendered:
            raise SystemExit(
                f"round-trip evidence is stale: regenerate with {Path(__file__).name} --write"
            )
    print(rendered, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
