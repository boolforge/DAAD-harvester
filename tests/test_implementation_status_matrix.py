import re
import sqlite3
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
MATRIX = ROOT / "research" / "IMPLEMENTATION_STATUS_MATRIX.md"


def test_operational_baseline_counts_match_live_repository_state() -> None:
    text = MATRIX.read_text(encoding="utf-8")
    match = re.search(
        r"contains ([0-9,]+) Python modules.*?, ([0-9,]+) operational scripts, "
        r"and ([0-9,]+) focused test modules\. The retained corpus contains "
        r"([0-9,]+) artifact records from ([0-9,]+) sources\.",
        text,
    )
    assert match, "operational baseline must expose measurable repository counts"
    documented = tuple(int(value.replace(",", "")) for value in match.groups())
    with sqlite3.connect(ROOT / "preservation_corpus" / "state.db") as connection:
        sources = connection.execute("SELECT COUNT(*) FROM sources").fetchone()[0]
        artifacts = connection.execute("SELECT COUNT(*) FROM artifacts").fetchone()[0]
    measured = (
        len(list((ROOT / "daad_harvester").glob("*.py"))),
        len(list((ROOT / "scripts").glob("*.py"))),
        len(list((ROOT / "tests").glob("test_*.py"))),
        artifacts,
        sources,
    )
    assert documented == measured
