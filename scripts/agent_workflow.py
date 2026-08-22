#!/usr/bin/env python3
"""Portable agent handoff and atomic-delivery wrapper.

The wrapper delegates verification to the repository scheduler and delegates
credential handling to Git. It never accepts, stores, or prints credentials.
"""

from __future__ import annotations

import argparse
from pathlib import Path
import subprocess
import sys
from typing import Sequence

ROOT = Path(__file__).resolve().parents[1]


def run(command: list[str], *, capture: bool = False) -> subprocess.CompletedProcess[str]:
    return subprocess.run(command, cwd=ROOT, check=False, text=True, capture_output=capture)


def commit_and_push(message: str, *, no_push: bool) -> int:
    if not message.strip():
        raise ValueError("commit message must not be empty")
    unstaged = run(["git", "diff", "--name-only"], capture=True)
    untracked = run(["git", "ls-files", "--others", "--exclude-standard"], capture=True)
    if unstaged.returncode or untracked.returncode:
        raise RuntimeError("could not inspect working-tree state")
    if unstaged.stdout.strip() or untracked.stdout.strip():
        raise RuntimeError("working tree has unstaged or untracked files; stage or clean them before delivery")
    staged = run(["git", "diff", "--cached", "--check"], capture=True)
    if staged.returncode:
        raise RuntimeError(staged.stderr.strip() or staged.stdout.strip() or "staged diff check failed")
    names = run(["git", "diff", "--cached", "--name-only"], capture=True)
    if not names.stdout.strip():
        raise RuntimeError("no staged files; stage one bounded concern before delivery")
    stats = run(["git", "diff", "--cached", "--stat"], capture=True)
    print("Staged files:\n" + names.stdout.rstrip())
    print("Staged statistics:\n" + stats.stdout.rstrip())
    commit = run(["git", "commit", "-m", message])
    if commit.returncode:
        return commit.returncode
    if no_push:
        print("Commit created; push was explicitly disabled.")
        return 0
    push = run(["git", "push", "origin", "HEAD"])
    if push.returncode:
        print("Commit created, but push failed; retry the same reviewed commit after repairing authentication.", file=sys.stderr)
        return push.returncode
    print("Verified commit pushed to origin.")
    return 0


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="action", required=True)
    verify = subparsers.add_parser("verify", help="run the repository scheduler")
    verify.add_argument("--workers", type=int, default=4)
    verify.add_argument("--timeout", type=float, default=300.0)
    commit = subparsers.add_parser("commit", help="commit a clean staged concern and push it")
    commit.add_argument("--message", required=True)
    commit.add_argument("--no-push", action="store_true", help="explicitly disable remote push for recovery/debugging")
    args = parser.parse_args(argv)
    try:
        if args.action == "verify":
            preflight = run([sys.executable, str(ROOT / "scripts" / "verify_environment.py")])
            if preflight.returncode:
                return preflight.returncode
            command = [
                sys.executable,
                str(ROOT / "scripts" / "run_parallel_workflow.py"),
                "--groups", "evidence", "publication", "analysis",
                "--workers", str(args.workers), "--timeout", str(args.timeout),
            ]
            return run(command).returncode
        return commit_and_push(args.message, no_push=args.no_push)
    except (RuntimeError, ValueError) as exc:
        print(f"Agent workflow blocked: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
