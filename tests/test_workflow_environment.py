from __future__ import annotations

import os
from pathlib import Path

from scripts.workflow_environment import repository_python_environment


def test_repository_environment_prepends_root_and_preserves_variables(tmp_path: Path) -> None:
    inherited = {"PYTHONPATH": f"/external{os.pathsep}{tmp_path}", "PRESERVED": "yes"}

    environment = repository_python_environment(tmp_path, inherited)

    assert environment["PYTHONPATH"].split(os.pathsep) == [str(tmp_path.resolve()), "/external"]
    assert environment["PRESERVED"] == "yes"


def test_repository_environment_deduplicates_existing_root(tmp_path: Path) -> None:
    root = tmp_path.resolve()
    environment = repository_python_environment(root, {"PYTHONPATH": f"{root}{os.pathsep}/external{os.pathsep}{root}"})

    assert environment["PYTHONPATH"].split(os.pathsep) == [str(root), "/external"]
