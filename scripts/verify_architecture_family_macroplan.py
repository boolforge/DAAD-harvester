#!/usr/bin/env python3
"""Validate the autonomous architecture-family macroplan ledger."""

from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.architecture_family_macroplan import ArchitectureFamilyMacroplanError, load_architecture_family_macroplan  # noqa: E402


def main() -> int:
    try:
        ledger = load_architecture_family_macroplan(ROOT / "reverse_engineering/workflows/architecture_family_macroplan.json")
    except ArchitectureFamilyMacroplanError as exc:
        print(f"Architecture-family macroplan verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Architecture-family macroplan verified: {len(ledger['workstreams'])} independent workstreams.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
