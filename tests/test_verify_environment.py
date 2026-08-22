import sys

from scripts.verify_environment import missing_requirements


def test_current_environment_has_required_tools() -> None:
    assert missing_requirements() == []


def test_old_python_is_rejected(monkeypatch) -> None:
    monkeypatch.setattr(sys, "version_info", (3, 9, 0))
    assert "python>=3.10" in missing_requirements(())
