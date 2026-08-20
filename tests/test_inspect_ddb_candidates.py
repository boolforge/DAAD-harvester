"""Real-artifact regression for structural DDB candidate reporting."""

from __future__ import annotations

import importlib.util
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/inspect_ddb_candidates.py"
SPEC = importlib.util.spec_from_file_location("inspect_ddb_candidates", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
INSPECTOR = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = INSPECTOR
SPEC.loader.exec_module(INSPECTOR)


def test_retained_jabato_credits_ram_reports_embedded_v1_ddb() -> None:
    credits_ram = (
        ROOT
        / "preservation_corpus/derived/commodore_loader/vice/jabato_side_a_tap_credits.ram"
    )
    result = INSPECTOR.inspect(credits_ram)
    candidate = next(item for item in result["candidates"] if item["offset"] == 0x3880)

    assert candidate["validated"] is True
    assert candidate["ddb_format"] == "daad-v1-legacy"
    assert candidate["platform"] == "c64"
    assert candidate["payload_size"] == 24_899
    assert result["embedded"] == {"offset": 0x3880, "size": 24_899}
