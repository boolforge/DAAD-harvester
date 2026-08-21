"""Run the complete deterministic, repository-native primary verification gate.

This host-neutral Python launcher is the single entry point for a clean clone
to verify retained primary evidence.  It invokes only repository-local Python
scripts and declared Python modules; it never opens a GUI, downloads data,
starts an emulator, or uses an LLM.  Optional external-tool adapters are
separate corroboration/acquisition workflows and are intentionally excluded.
"""

from __future__ import annotations

import argparse
from pathlib import Path
import subprocess
import sys
from typing import Sequence


ROOT = Path(__file__).resolve().parents[1]


def workflow_commands(*, include_tests: bool) -> list[tuple[str, tuple[str, ...]]]:
    """Return the ordered, cross-host-safe primary verification commands."""

    commands = [
        ("active backlog index", ("scripts/build_active_backlog_index.py", "--check")),
        ("regeneration manifest", ("scripts/verify_regeneration_manifest.py",)),
        ("runtime resources", ("scripts/verify_runtime_resources.py",)),
        ("retained game corpus", ("scripts/verify_game_corpus.py",)),
        ("complete artifact checksums", ("scripts/verify_artifact_checksums.py",)),
        ("public artifact manifest", ("scripts/build_public_artifact_manifest.py", "--check")),
        ("native format generators", ("scripts/verify_native_generators.py",)),
        ("retained DDB native round trips", ("scripts/verify_ddb_round_trips.py", "--check")),
        ("DDB token-boundary negative regression", ("scripts/verify_ddb_token_boundary_blocker.py", "--check")),
        ("reverse-engineering corpus", ("scripts/verify_reverse_corpus.py",)),
        ("static preservation report", ("scripts/regenerate_preservation_report.py", "--check")),
        ("documentation integrity", ("scripts/check_docs.py",)),
        ("American English authored-text policy", ("scripts/check_american_english.py",)),
    ]
    if include_tests:
        commands.extend(
            [
                ("static analysis", ("-m", "pyflakes", "daad_harvester", "scripts")),
                ("regression suite", ("-m", "pytest", "-q")),
            ]
        )
    return commands


def run_workflow(*, include_tests: bool) -> None:
    """Execute the ordered gate and stop at the first actionable failure."""

    for label, arguments in workflow_commands(include_tests=include_tests):
        command = [sys.executable, *arguments]
        print(f"==> {label}: {' '.join(command)}", flush=True)
        subprocess.run(command, cwd=ROOT, check=True)


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--quick",
        action="store_true",
        help="run deterministic corpus/report/documentation verification without lint or pytest",
    )
    parser.add_argument(
        "--list",
        action="store_true",
        help="print the ordered command plan without executing it",
    )
    args = parser.parse_args(argv)
    include_tests = not args.quick
    if args.list:
        for label, arguments in workflow_commands(include_tests=include_tests):
            print(f"{label}: {sys.executable} {' '.join(arguments)}")
        return 0
    run_workflow(include_tests=include_tests)
    print("Primary deterministic workflow verified.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
