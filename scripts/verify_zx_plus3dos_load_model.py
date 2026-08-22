#!/usr/bin/env python3
"""Verify retained ZX PLUS3DOS header observations without executing them."""

from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.zx_plus3dos_load_model import ZxPlus3DosLoadModelError, load_zx_plus3dos_load_model  # noqa: E402


def main() -> int:
    try:
        contract = load_zx_plus3dos_load_model(ROOT / "reverse_engineering/workflows/zx_plus3dos_load_model_admission.json", ROOT)
    except ZxPlus3DosLoadModelError as exc:
        print(f"ZX PLUS3DOS load-model verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Verified {len(contract['profiles'])} ZX PLUS3DOS headers; payload execution remains unresolved.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
