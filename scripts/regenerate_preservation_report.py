#!/usr/bin/env python3
"""Regenerate or verify the committed static preservation report without a browser.

The real retained corpus is the input. A fixed recorded timestamp removes the
only wall-clock field, so the report is byte-stable and checkable from a clone
using repository source and declared Python dependencies only.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
CORPUS = ROOT / "preservation_corpus"
REPORT = CORPUS / "report_data.json"
REPORT_TIMESTAMP = "2026-08-20T19:58:31.210270+00:00"
sys.path.insert(0, str(ROOT))

from daad_harvester.db import Database  # noqa: E402
from daad_harvester.report_export import StaticReportExporter  # noqa: E402


def _render() -> str:
    db = Database(CORPUS / "state.db")
    report = StaticReportExporter(db, CORPUS, generated_at=REPORT_TIMESTAMP).build()
    return json.dumps(report, indent=2, ensure_ascii=False) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="Verify the committed report without modifying it.")
    args = parser.parse_args()
    if not (CORPUS / "state.db").is_file():
        raise FileNotFoundError("missing committed preservation_corpus/state.db")
    rendered = _render()
    if args.check:
        if not REPORT.is_file() or REPORT.read_text(encoding="utf-8") != rendered:
            raise AssertionError("committed report differs; rerun regenerate_preservation_report.py")
        print("Static preservation report regenerated and verified natively")
    else:
        REPORT.write_text(rendered, encoding="utf-8")
        print("Static preservation report regenerated natively")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
