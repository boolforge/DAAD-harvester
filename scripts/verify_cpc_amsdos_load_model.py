#!/usr/bin/env python3
"""Verify retained CPC AMSDOS header observations without executing programs."""

from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.cpc_amsdos_load_model import CpcAmsdosLoadModelError, load_cpc_amsdos_load_model  # noqa: E402


def main() -> int:
    try:
        contract = load_cpc_amsdos_load_model(ROOT / "reverse_engineering/workflows/cpc_amsdos_load_model_admission.json", ROOT)
    except CpcAmsdosLoadModelError as exc:
        print(f"CPC AMSDOS load-model verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Verified {len(contract['profiles'])} CPC AMSDOS load/entry headers; CPC memory and runtime state remain unresolved.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
