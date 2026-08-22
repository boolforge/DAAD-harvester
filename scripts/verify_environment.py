#!/usr/bin/env python3
"""Verify the portable command-line prerequisites for DAAD Harvester."""

from __future__ import annotations

import argparse
from dataclasses import dataclass
import shutil
import sqlite3
import sys
from typing import Iterable


@dataclass(frozen=True)
class Requirement:
    name: str
    commands: tuple[str, ...]


REQUIRED = (
    Requirement("python", ("python3", "python")),
    Requirement("git", ("git",)),
    Requirement("sqlite3", ("sqlite3",)),
    Requirement("archive extractor", ("7z", "7zz", "unzip")),
)


def missing_requirements(requirements: Iterable[Requirement] = REQUIRED) -> list[str]:
    missing = [item.name for item in requirements if not any(shutil.which(command) for command in item.commands)]
    if sys.version_info < (3, 10):
        missing.append("python>=3.10")
    if sqlite3.sqlite_version_info < (3, 35, 0):
        missing.append("sqlite3>=3.35")
    return missing


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.parse_args()
    missing = missing_requirements()
    if missing:
        print("Environment preflight failed:")
        for item in missing:
            print(f"- missing or unsupported: {item}")
        return 1
    print(
        "Environment preflight verified: Python >=3.10, Git, sqlite3 >=3.35, "
        "and an archive extractor are available."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
