#!/usr/bin/env python3
"""Run independent repository verification gates concurrently.

Only commands declared in ``GATE_GROUPS`` may run. Each gate is a subprocess
with an isolated working directory and captured output. The scheduler never
parallelizes commands that are known to regenerate shared files; those remain
owned by the ordered primary workflow.
"""

from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
import os
from pathlib import Path
import subprocess
import sys
from typing import Sequence

ROOT = Path(__file__).resolve().parents[1]


@dataclass(frozen=True)
class Gate:
    name: str
    arguments: tuple[str, ...]


GATE_GROUPS: dict[str, tuple[Gate, ...]] = {
    "evidence": (
        Gate("runtime resources", ("scripts/verify_runtime_resources.py",)),
        Gate("retained game corpus", ("scripts/verify_game_corpus.py",)),
        Gate("complete artifact checksums", ("scripts/verify_artifact_checksums.py",)),
        Gate("reverse-engineering corpus", ("scripts/verify_reverse_corpus.py",)),
        Gate("native format generators", ("scripts/verify_native_generators.py",)),
    ),
    "publication": (
        Gate("pyflakes", ("-m", "pyflakes", "daad_harvester", "scripts")),
        Gate("active backlog index", ("scripts/build_active_backlog_index.py", "--check")),
        Gate("regeneration manifest", ("scripts/verify_regeneration_manifest.py",)),
        Gate("public artifact manifest", ("scripts/build_public_artifact_manifest.py", "--check")),
        Gate("static preservation report", ("scripts/regenerate_preservation_report.py", "--check")),
        Gate("documentation integrity", ("scripts/check_docs.py",)),
        Gate("American English authored-text policy", ("scripts/check_american_english.py",)),
    ),
    "analysis": (
        Gate("DDB native round trips", ("scripts/verify_ddb_round_trips.py", "--check")),
        Gate("DDB token-boundary negative regression", ("scripts/verify_ddb_token_boundary_blocker.py", "--check")),
    ),
}


def _run_gate(gate: Gate) -> tuple[str, int, str]:
    result = subprocess.run(
        [sys.executable, *gate.arguments],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=False,
    )
    output = (result.stdout + result.stderr).strip()
    return gate.name, result.returncode, output


def run_parallel(*, groups: Sequence[str], workers: int) -> int:
    unknown = sorted(set(groups) - set(GATE_GROUPS))
    if unknown:
        raise ValueError(f"unknown gate groups: {', '.join(unknown)}")
    gates = [gate for group in groups for gate in GATE_GROUPS[group]]
    max_workers = max(1, min(workers, len(gates)))
    failures: list[tuple[str, int, str]] = []
    print(f"Running {len(gates)} independent gates with {max_workers} workers.", flush=True)
    with ThreadPoolExecutor(max_workers=max_workers, thread_name_prefix="daad-gate") as pool:
        futures = {pool.submit(_run_gate, gate): gate for gate in gates}
        results = [future.result() for future in as_completed(futures)]
    for name, returncode, output in sorted(results, key=lambda item: item[0]):
        if returncode:
            failures.append((name, returncode, output))
            print(f"FAIL {name} (exit {returncode})\n{output}", flush=True)
        else:
            last_line = output.splitlines()[-1] if output else "completed"
            print(f"PASS {name}: {last_line}", flush=True)
    if failures:
        print(f"{len(failures)} parallel gate(s) failed.", flush=True)
        return 1
    print("All parallel gates verified.", flush=True)
    return 0


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--groups", nargs="+", choices=sorted(GATE_GROUPS), default=list(GATE_GROUPS))
    parser.add_argument("--workers", type=int, default=max(1, min(8, os.cpu_count() or 1)))
    args = parser.parse_args(argv)
    if args.workers < 1:
        parser.error("--workers must be at least 1")
    return run_parallel(groups=args.groups, workers=args.workers)


if __name__ == "__main__":
    raise SystemExit(main())
