"""Shared process environment for repository-local Python verification commands."""

from __future__ import annotations

import os
from pathlib import Path
from typing import Mapping


def repository_python_environment(root: Path, inherited: Mapping[str, str] | None = None) -> dict[str, str]:
    """Return an environment that makes the repository package importable.

    Direct execution of a file under ``scripts/`` makes Python place that directory,
    rather than the repository root, first on ``sys.path``. The returned environment
    keeps every inherited variable and prepends the resolved repository root to
    ``PYTHONPATH`` so direct scripts and their repository-native subprocesses share
    the same import contract on local machines and clean CI runners.
    """

    environment = dict(os.environ if inherited is None else inherited)
    root_text = str(root.resolve())
    existing = environment.get("PYTHONPATH", "")
    entries = [entry for entry in existing.split(os.pathsep) if entry and entry != root_text]
    environment["PYTHONPATH"] = os.pathsep.join([root_text, *entries])
    return environment
