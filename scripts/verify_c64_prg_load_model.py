#!/usr/bin/env python3
"""Verify the retained official C64 PRG load and BASIC-entry admission contract."""

from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.c64_prg_load_model import C64PrgLoadModelError, load_c64_prg_load_model  # noqa: E402


def main() -> int:
    try:
        contract = load_c64_prg_load_model(ROOT / "reverse_engineering/workflows/c64_prg_load_model_admission.json", ROOT)
    except C64PrgLoadModelError as exc:
        print(f"C64 PRG load-model verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Verified {len(contract['profiles'])} official C64 PRG BASIC load/entry profile(s); banking and I/O remain unresolved.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
