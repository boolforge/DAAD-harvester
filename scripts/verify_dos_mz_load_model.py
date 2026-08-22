#!/usr/bin/env python3
"""Verify all retained DOS interpreter MZ headers without executing them."""

from __future__ import annotations

import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.dos_mz_load_model import DosMzLoadModelError, collect_dos_mz_load_model  # noqa: E402


def main() -> int:
    try:
        print(json.dumps(collect_dos_mz_load_model(ROOT), indent=2, sort_keys=True))
    except (DosMzLoadModelError, json.JSONDecodeError) as exc:
        print(f"DOS MZ load-model verification failed: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
