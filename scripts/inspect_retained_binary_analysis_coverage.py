#!/usr/bin/env python3
"""Print the deterministic retained-binary static-analysis coverage ledger."""

from __future__ import annotations

import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from daad_harvester.analysis_coverage import AnalysisCoverageError, collect_analysis_coverage  # noqa: E402


def main() -> int:
    try:
        print(json.dumps(collect_analysis_coverage(ROOT), indent=2, sort_keys=True))
    except (AnalysisCoverageError, json.JSONDecodeError) as exc:
        print(f"retained binary analysis coverage check failed: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
