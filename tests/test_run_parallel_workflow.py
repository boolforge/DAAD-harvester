import subprocess

import pytest

from scripts import run_parallel_workflow
from scripts.run_parallel_workflow import GATE_GROUPS, run_parallel


def test_gate_groups_are_named_and_nonempty() -> None:
    assert set(GATE_GROUPS) == {"evidence", "publication", "analysis"}
    assert all(GATE_GROUPS[group] for group in GATE_GROUPS)
    names = [gate.name for gates in GATE_GROUPS.values() for gate in gates]
    assert len(names) == len(set(names))


def test_unknown_group_is_rejected() -> None:
    with pytest.raises(ValueError, match="unknown gate groups"):
        run_parallel(groups=["missing"], workers=1)


def test_worker_count_is_clamped_and_group_runs() -> None:
    assert run_parallel(groups=["publication"], workers=999) == 0


def test_timeout_must_be_positive() -> None:
    with pytest.raises(ValueError, match="timeout"):
        run_parallel(groups=["publication"], workers=1, timeout=0)


def test_timeout_is_reported_as_gate_failure(monkeypatch, capsys) -> None:
    def timed_out(*args, **kwargs):
        raise subprocess.TimeoutExpired(cmd=args[0], timeout=kwargs["timeout"], output="partial")

    monkeypatch.setattr(run_parallel_workflow.subprocess, "run", timed_out)
    assert run_parallel(groups=["publication"], workers=1, timeout=0.01) == 1
    assert "timed out after 0.01s" in capsys.readouterr().out
