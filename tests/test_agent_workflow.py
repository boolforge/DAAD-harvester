import json
from pathlib import Path
from types import SimpleNamespace

import pytest

from scripts import agent_workflow
from scripts.validate_skill_scaffold import validate


def test_skill_scaffold_is_complete_and_mandatory() -> None:
    assert validate() == []


def test_machine_readable_contract_points_to_versioned_workflow() -> None:
    root = Path(__file__).resolve().parents[1]
    contract = json.loads((root / "agent_workflow.json").read_text(encoding="utf-8"))

    assert contract["scheduler"] == "scripts/run_parallel_workflow.py"
    assert contract["backlog_source"] == "TODO.md"
    assert contract["default_parallel_groups"] == ["evidence", "publication", "analysis"]
    assert contract["delivery"]["push_required_after_verified_commit"] is True
    assert contract["delivery"]["force_push_allowed"] is False
    assert "Credentials never" in contract["secret_policy"]


def test_empty_commit_message_is_rejected() -> None:
    with pytest.raises(ValueError, match="must not be empty"):
        agent_workflow.commit_and_push(" ", no_push=True)


def test_unstaged_or_untracked_files_block_delivery(monkeypatch) -> None:
    def fake_run(command, **kwargs):
        if command[:3] == ["git", "diff", "--name-only"]:
            return SimpleNamespace(returncode=0, stdout="dirty.py\n", stderr="")
        return SimpleNamespace(returncode=0, stdout="", stderr="")

    monkeypatch.setattr(agent_workflow, "run", fake_run)
    with pytest.raises(RuntimeError, match="unstaged or untracked"):
        agent_workflow.commit_and_push("feat(test): bounded delivery", no_push=True)


def test_staged_delivery_requires_no_push_opt_out(monkeypatch, capsys) -> None:
    calls: list[list[str]] = []

    def fake_run(command, **kwargs):
        calls.append(command)
        if command[:3] == ["git", "diff", "--name-only"] or command[:4] == ["git", "ls-files", "--others", "--exclude-standard"]:
            return SimpleNamespace(returncode=0, stdout="", stderr="")
        if command[:3] == ["git", "diff", "--cached"] and command[-1] == "--check":
            return SimpleNamespace(returncode=0, stdout="", stderr="")
        if command[-1] == "--name-only":
            return SimpleNamespace(returncode=0, stdout="file.py\n", stderr="")
        if command[-1] == "--stat":
            return SimpleNamespace(returncode=0, stdout=" file.py | 1 +\n", stderr="")
        if command[0:2] == ["git", "commit"]:
            return SimpleNamespace(returncode=0, stdout="", stderr="")
        raise AssertionError(f"unexpected command: {command}")

    monkeypatch.setattr(agent_workflow, "run", fake_run)
    assert agent_workflow.commit_and_push("feat(test): bounded delivery", no_push=True) == 0
    assert "push was explicitly disabled" in capsys.readouterr().out
    assert ["git", "commit", "-m", "feat(test): bounded delivery"] in calls
