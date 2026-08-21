#!/usr/bin/env python3
"""Generate or verify the retained DDB token/text boundary blocker evidence."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Sequence

from daad_harvester.ddb_token_boundary_evidence import (
    REPOSITORY_ROOT,
    retained_token_boundary_blocker_evidence,
)


DEFAULT_OUTPUT = REPOSITORY_ROOT / "preservation_corpus/ddb_token_boundary_blocker.json"


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--write", action="store_true")
    mode.add_argument("--check", action="store_true")
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    arguments = parser.parse_args(argv)
    rendered = json.dumps(retained_token_boundary_blocker_evidence(), indent=2, sort_keys=True) + "\n"
    if arguments.write:
        arguments.output.parent.mkdir(parents=True, exist_ok=True)
        arguments.output.write_text(rendered, encoding="utf-8")
    elif arguments.check:
        if not arguments.output.is_file() or arguments.output.read_text(encoding="utf-8") != rendered:
            raise SystemExit("token-boundary blocker evidence is missing or stale; run with --write")
    print(rendered, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
