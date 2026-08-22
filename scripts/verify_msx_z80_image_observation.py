#!/usr/bin/env python3
"""Verify retained MSX image identity and leading-jump observations without execution."""

from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.msx_z80_image_observation import MsxZ80ImageObservationError, load_msx_z80_image_observation  # noqa: E402


def main() -> int:
    try:
        contract = load_msx_z80_image_observation(ROOT / "reverse_engineering/workflows/msx_z80_image_observation.json", ROOT)
    except MsxZ80ImageObservationError as exc:
        print(f"MSX image observation verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Verified {len(contract['profiles'])} MSX image observations; load and executable entry remain unresolved.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
