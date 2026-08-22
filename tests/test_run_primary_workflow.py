"""Regression coverage for the cross-host primary verification launcher."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys

from scripts import run_primary_workflow


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "run_primary_workflow.py"


def test_primary_workflow_lists_all_native_gates_without_external_tools() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--list"],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "active backlog index:" in result.stdout
    assert "regeneration manifest:" in result.stdout
    assert "runtime resources:" in result.stdout
    assert "retained game corpus:" in result.stdout
    assert "complete artifact checksums:" in result.stdout
    assert "public artifact manifest:" in result.stdout
    assert "native format generators:" in result.stdout
    assert "reverse-engineering corpus:" in result.stdout
    assert "static preservation report:" in result.stdout
    assert "documentation integrity:" in result.stdout
    assert "regression suite:" in result.stdout
    assert "x64sc" not in result.stdout
    assert "ghidra" not in result.stdout.casefold()


def test_primary_workflow_defaults_to_parallel_scheduler(monkeypatch) -> None:
    calls: list[list[str]] = []

    def fake_run(command, **kwargs):
        calls.append(list(command))
        return None

    monkeypatch.setattr(run_primary_workflow.subprocess, "run", fake_run)
    run_primary_workflow.run_workflow(include_tests=False)

    assert len(calls) == 2
    assert calls[0][1].endswith("scripts/verify_environment.py")
    assert calls[1][1].endswith("scripts/run_parallel_workflow.py")
    assert "--workers" in calls[1]
    assert "4" in calls[1]


def test_primary_workflow_ordered_mode_keeps_declared_gate_plan(monkeypatch) -> None:
    calls: list[list[str]] = []

    def fake_run(command, **kwargs):
        calls.append(list(command))
        return None

    monkeypatch.setattr(run_primary_workflow.subprocess, "run", fake_run)
    run_primary_workflow.run_workflow(include_tests=False, ordered=True)

    assert len(calls) == len(run_primary_workflow.workflow_commands(include_tests=False)) + 1
    assert calls[0][1].endswith("scripts/verify_environment.py")
    assert calls[1][1].endswith("scripts/build_active_backlog_index.py")
