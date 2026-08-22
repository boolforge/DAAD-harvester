#!/usr/bin/env python3
"""Verify retained Amiga Hunk container facts without executing them."""

from __future__ import annotations

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.amiga_hunk_load_model import AmigaHunkLoadModelError, load_amiga_hunk_load_model  # noqa: E402


def main() -> int:
    try:
        contract = load_amiga_hunk_load_model(ROOT / "reverse_engineering/workflows/amiga_hunk_load_model_admission.json", ROOT)
    except AmigaHunkLoadModelError as exc:
        print(f"Amiga Hunk load-model verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Verified {len(contract['profiles'])} Amiga Hunk containers; AmigaOS runtime remains unresolved.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
