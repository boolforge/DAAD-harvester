"""Guards requirements-lock.txt against silently losing its pins.

Added after a concrete incident: two consecutive CI runs of the exact same commit
failed (both Python 3.10 and 3.12), then two later runs of a near-identical commit
(only a CI-debug workflow addition differed -- no .py file changed) passed cleanly,
and a from-scratch local reinstall in a brand-new venv reproduced the passing,
all-pinned resolution reliably. requirements.txt uses only ">=" floating minimums, no
lockfile, no pins -- exactly the condition under which `pip install` can silently
resolve a different dependency tree between two points in time. This does not prove
that was the cause (the raw CI failure logs were not retrievable), but it is the only
concrete difference identified, and pinning is the correct fix regardless: a
project built around reproducible, evidence-grade pipeline runs should not have its
CI depend on whatever happens to be latest-on-PyPI at run time.
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PIN_LINE = re.compile(r"^[A-Za-z0-9._-]+==[A-Za-z0-9.]+$")


def test_lockfile_exists_and_is_not_empty():
    lock_path = ROOT / "requirements-lock.txt"
    assert lock_path.exists()
    lines = [l for l in lock_path.read_text(encoding="utf-8").splitlines() if l.strip() and not l.startswith("#")]
    assert len(lines) > 10


def test_every_lockfile_line_is_an_exact_pin():
    lock_path = ROOT / "requirements-lock.txt"
    lines = [l for l in lock_path.read_text(encoding="utf-8").splitlines() if l.strip() and not l.startswith("#")]
    not_pinned = [l for l in lines if not PIN_LINE.match(l)]
    assert not not_pinned, f"lines without an exact '==' pin: {not_pinned}"


def test_lockfile_covers_every_top_level_requirement():
    """Every package named in requirements.txt (by its distribution name, case- and
    separator-insensitive) must have a corresponding pin in the lockfile."""

    def normalize(name: str) -> str:
        return re.sub(r"[-_.]+", "-", name).lower()

    req_names = set()
    for line in (ROOT / "requirements.txt").read_text(encoding="utf-8").splitlines():
        line = line.split(";")[0].strip()  # drop environment markers, e.g. "; sys_platform != ..."
        if not line or line.startswith("#"):
            continue
        name = re.split(r"[><=!~]", line, maxsplit=1)[0].strip()
        req_names.add(normalize(name))

    lock_names = set()
    for line in (ROOT / "requirements-lock.txt").read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        lock_names.add(normalize(line.split("==")[0]))

    missing = req_names - lock_names
    assert not missing, f"requirements.txt packages missing from requirements-lock.txt: {missing}"
