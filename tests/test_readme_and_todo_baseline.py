"""Guards README.md's and TODO.md's numeric baseline claims against silent drift.

research/IMPLEMENTATION_STATUS_MATRIX.md already has this protection
(test_implementation_status_matrix.py), and it caught real drift more than once
during development. README.md and TODO.md's headers make the same class of claim --
passing-test count, source count, artifact count -- with no equivalent protection,
and had in fact already drifted before this test was added: README.md said "247
passing tests" and TODO.md's header said "544 passing tests, 267 sources" while a
live run reported 609 passing tests and 265 sources.

pytest's own collection (not a full run) gives the live passing-test count cheaply
(well under a second); the source/artifact counts reuse the same sqlite query
test_implementation_status_matrix.py uses, so both tests measure the corpus the same
way.
"""
import re
import sqlite3
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def _live_passing_test_count() -> int:
    result = subprocess.run(
        [sys.executable, "-m", "pytest", "--collect-only", "-q"],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=True,
    )
    match = re.search(r"^(\d+) tests? collected", result.stdout, re.MULTILINE)
    assert match, f"could not parse collected test count from:\n{result.stdout[-500:]}"
    return int(match.group(1))


def _live_sources_and_artifacts() -> tuple[int, int]:
    with sqlite3.connect(ROOT / "preservation_corpus" / "state.db") as connection:
        sources = connection.execute("SELECT COUNT(*) FROM sources").fetchone()[0]
        artifacts = connection.execute("SELECT COUNT(*) FROM artifacts").fetchone()[0]
    return sources, artifacts


def test_readme_passing_test_count_matches_live_collection():
    text = (ROOT / "README.md").read_text(encoding="utf-8")
    match = re.search(r"current suite contains \*\*([0-9,]+) passing tests\*\*", text)
    assert match, "README.md must state the current passing-test count in the expected form"
    documented = int(match.group(1).replace(",", ""))
    assert documented == _live_passing_test_count()


def test_todo_status_baseline_matches_live_state():
    text = (ROOT / "TODO.md").read_text(encoding="utf-8")
    match = re.search(
        r"reports \*\*([0-9,]+) passing tests\*\*, \*\*([0-9,]+) sources\*\*, "
        r"\*\*([0-9,]+) retained artifacts\*\*",
        text,
    )
    assert match, "TODO.md's status baseline must state tests/sources/artifacts in the expected form"
    documented_tests, documented_sources, documented_artifacts = (
        int(v.replace(",", "")) for v in match.groups()
    )

    live_sources, live_artifacts = _live_sources_and_artifacts()

    assert documented_tests == _live_passing_test_count()
    assert documented_sources == live_sources
    assert documented_artifacts == live_artifacts
