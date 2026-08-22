#!/usr/bin/env python3
"""Verify retained PCW image and BDOS-call observations without execution."""

from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.pcw_z80_image_observation import PcwZ80ImageObservationError, load_pcw_z80_image_observation  # noqa: E402


def main() -> int:
    try:
        contract = load_pcw_z80_image_observation(ROOT / "reverse_engineering/workflows/pcw_z80_image_observation.json", ROOT)
    except PcwZ80ImageObservationError as exc:
        print(f"PCW image observation verification failed: {exc}", file=sys.stderr)
        return 1
    print(f"Verified {len(contract['profiles'])} PCW image observations; CP/M load and entry remain unresolved.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
