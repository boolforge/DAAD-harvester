#!/usr/bin/env python3
"""Verify retained Plus/4 PRG wrapper observations without executing them."""

from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.plus4_prg_load_model import Plus4PrgLoadModelError, load_plus4_prg_load_model  # noqa: E402


def main() -> int:
    try:
        contract = load_plus4_prg_load_model(ROOT / "reverse_engineering/workflows/plus4_prg_load_model_admission.json", ROOT)
    except Plus4PrgLoadModelError as exc:
        print(f"Plus/4 PRG load-model verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Verified {len(contract['profiles'])} Plus/4 PRG wrappers; launcher target and TED/ROM/RAM state remain unresolved.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
