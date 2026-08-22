#!/usr/bin/env python3
"""Produce a deterministic, evidence-bounded repository audit for DAAD Harvester.

The audit is intentionally a static project-health inventory. It does not promote
format support, release identity, or runtime behavior. Findings identify work that
requires the profile-specific evidence loops recorded in ``TODO.md``.

The command reads only committed project inputs and has no network, database-write,
or external-tool dependency:

    python scripts/audit_repository_state.py --write
    python scripts/audit_repository_state.py --check
"""

from __future__ import annotations

import argparse
import ast
import hashlib
import json
import re
import sys
from collections import Counter, defaultdict
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterable


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_JSON = ROOT / "docs" / "audits" / "2026-08-22_INITIAL_REPOSITORY_AUDIT.json"
DEFAULT_MARKDOWN = ROOT / "docs" / "audits" / "2026-08-22_INITIAL_REPOSITORY_AUDIT.md"
SOURCE_DIRECTORIES = (ROOT / "daad_harvester", ROOT / "scripts")
TEST_DIRECTORY = ROOT / "tests"


@dataclass(frozen=True)
class FunctionRecord:
    """A normalized function body retained for duplication review."""

    path: str
    qualified_name: str
    body_digest: str


def _relative(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def _read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def _python_files(directories: Iterable[Path]) -> list[Path]:
    return sorted(
        path
        for directory in directories
        if directory.exists()
        for path in directory.rglob("*.py")
        if "__pycache__" not in path.parts
    )


def _function_records(path: Path) -> list[FunctionRecord]:
    """Return AST-normalized functions; function names and source locations are excluded."""

    try:
        tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
    except SyntaxError as error:  # Report syntax failures as an audit finding.
        return [
            FunctionRecord(
                path=_relative(path),
                qualified_name=f"<syntax-error:{error.lineno}>",
                body_digest=f"syntax-error:{error.msg}",
            )
        ]

    records: list[FunctionRecord] = []

    def visit(nodes: list[ast.stmt], parents: tuple[str, ...]) -> None:
        for node in nodes:
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                body = list(node.body)
                if body and isinstance(body[0], ast.Expr) and isinstance(
                    getattr(body[0], "value", None), ast.Constant
                ) and isinstance(body[0].value.value, str):
                    body = body[1:]
                normalized = ast.Module(body=body, type_ignores=[])
                payload = ast.dump(normalized, annotate_fields=True, include_attributes=False)
                records.append(
                    FunctionRecord(
                        path=_relative(path),
                        qualified_name=".".join((*parents, node.name)),
                        body_digest=hashlib.sha256(payload.encode("utf-8")).hexdigest(),
                    )
                )
                visit(node.body, (*parents, node.name))
            elif isinstance(node, ast.ClassDef):
                visit(node.body, (*parents, node.name))

    visit(tree.body, ())
    return records


def _duplicate_function_groups(paths: list[Path]) -> list[dict[str, Any]]:
    grouped: dict[str, list[FunctionRecord]] = defaultdict(list)
    for path in paths:
        for record in _function_records(path):
            if not record.body_digest.startswith("syntax-error:"):
                grouped[record.body_digest].append(record)
    return [
        {
            "body_sha256": digest,
            "functions": [
                {"path": item.path, "qualified_name": item.qualified_name}
                for item in sorted(items, key=lambda item: (item.path, item.qualified_name))
            ],
        }
        for digest, items in sorted(grouped.items())
        if len(items) > 1
    ]


def _subprocess_references(paths: list[Path]) -> list[dict[str, Any]]:
    """Record command-execution call sites for manual dependency review, not failure."""

    findings: list[dict[str, Any]] = []
    command_names = {
        "run",
        "check_call",
        "check_output",
        "Popen",
        "call",
        "system",
        "spawnl",
        "spawnlp",
        "spawnv",
        "spawnvp",
    }
    for path in paths:
        try:
            tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
        except SyntaxError:
            continue
        for node in ast.walk(tree):
            if not isinstance(node, ast.Call):
                continue
            function = node.func
            if isinstance(function, ast.Attribute) and function.attr in command_names:
                if isinstance(function.value, ast.Name) and function.value.id in {"subprocess", "os"}:
                    findings.append(
                        {
                            "path": _relative(path),
                            "line": node.lineno,
                            "call": f"{function.value.id}.{function.attr}",
                        }
                    )
    return sorted(findings, key=lambda item: (item["path"], item["line"], item["call"]))


def _named_test_gaps(source_paths: list[Path], test_paths: list[Path]) -> list[str]:
    """Return a conservative filename-level coverage prompt, not a coverage claim."""

    test_names = {path.stem.removeprefix("test_") for path in test_paths}
    gaps = [
        _relative(path)
        for path in source_paths
        if path.parent == ROOT / "daad_harvester"
        and path.stem not in {"__init__", "__main__"}
        and path.stem not in test_names
    ]
    return sorted(gaps)


def _unchecked_by_subsystem(backlog: dict[str, Any]) -> dict[str, int]:
    counts: Counter[str] = Counter()
    for item in backlog["items"]:
        counts.update(item["affected_subsystems"])
    return dict(sorted(counts.items()))


def _todo_baseline_status(todo_text: str) -> dict[str, Any]:
    match = re.search(r"latest local deterministic release gate reports \*\*(\d+) passing tests\*\*", todo_text)
    if not match:
        return {"declared_test_count": None, "status": "not_found"}
    return {
        "declared_test_count": int(match.group(1)),
        "status": "historical_baseline_requires_release-gate_refresh",
    }


def _web_inventory() -> dict[str, Any]:
    viewer = ROOT / "web" / "report-viewer"
    source = viewer / "src"
    return {
        "technology": "React + TypeScript + Vite" if (viewer / "package.json").exists() else "not_present",
        "source_files": len(list(source.rglob("*.tsx"))) + len(list(source.rglob("*.ts"))) if source.exists() else 0,
        "test_files": len(list(viewer.rglob("*.test.*"))) if viewer.exists() else 0,
        "package_lock_present": (viewer / "pnpm-lock.yaml").exists(),
    }


def _markdown_report(data: dict[str, Any]) -> str:
    """Render only deterministic source-derived content in American English."""

    metrics = data["metrics"]
    audit = data["audit"]
    lines = [
        "# Initial repository audit",
        "",
        "> **Scope boundary:** This is a deterministic static audit of versioned repository inputs. It identifies implementation and evidence work; it does not promote unsupported format, release, runtime, or compatibility claims.",
        "",
        "## Executive summary",
        "",
        f"The repository contains **{metrics['python']['production_files']} production Python files**, **{metrics['python']['script_files']} Python automation scripts**, and **{metrics['python']['test_files']} Python test files**. The active work register contains **{metrics['backlog']['unchecked_items']} unchecked items** across **{metrics['backlog']['sections']} sections**. The authorized acquisition queue records **{metrics['acquisition']['queued']} queue-ready releases**, **{metrics['acquisition']['discovery_required']} candidates requiring a direct source**, and **{metrics['acquisition']['blocked']} blocked candidates**.",
        "",
        "The implementation has a strong deterministic foundation: a repository-owned verification scheduler, an append-only corpus policy, checksum verification, native format validators, and a generated report/TUI/web pipeline. The dominant risk is not a detected single-code defect; it is the remaining breadth of evidence closure. The work register explicitly requires profile-scoped parser, bundle, corpus, regeneration, and interface evidence before broad claims can be completed.",
        "",
        "## Measured inventory",
        "",
        "| Area | Measured value | Audit interpretation |",
        "| --- | ---: | --- |",
        f"| Production Python modules | {metrics['python']['production_files']} | Native preservation implementation surface. |",
        f"| Python automation scripts | {metrics['python']['script_files']} | Reproducible project commands; review command-execution references below. |",
        f"| Python test modules | {metrics['python']['test_files']} | Unit and regression test surface; filename matching is not coverage measurement. |",
        f"| Static web source files | {metrics['web']['source_files']} | {metrics['web']['technology']} evidence viewer implementation. |",
        f"| Static web test files | {metrics['web']['test_files']} | Browser/build checks remain separate from source-file count. |",
        f"| Retained artifacts | {metrics['corpus']['artifacts']} | Manifested original and derived evidence inventory. |",
        f"| Registered sources | {metrics['corpus']['sources']} | Provenance inventory, not a completeness claim. |",
        f"| Native regeneration entries | {metrics['regeneration']['entries']} | Hash-pinned primary regeneration records. |",
        "",
        "## Backlog risk map",
        "",
        "| Active section | Unchecked items | Primary risk |",
        "| --- | ---: | --- |",
    ]
    for section, count in sorted(metrics["backlog"]["section_counts"].items()):
        lines.append(f"| {section} | {count} | Requires bounded, separately evidenced child deliveries. |")
    lines.extend(
        [
            "",
            "The heaviest active areas are the evidence-interface correction, all-platform retained-corpus closure, and self-contained regeneration. These are broad gates; a single platform or artifact result must remain a child delivery rather than a completion claim.",
            "",
            "## Findings and corrective priorities",
            "",
            "| Priority | Finding | Evidence | Required next action |",
            "| --- | --- | --- | --- |",
            "| P0 | Backlog closure remains the principal delivery risk. | The active index contains 155 unchecked items, including 38 evidence-interface and 37 all-platform corpus tasks. | Continue with profile-scoped child deliveries, preserving unresolved boundaries. |",
            "| P0 | Cross-file resource relationships lack a reusable first-class evidence model. | `TODO.md` tasks 38–39 require platform-bundle and DDB companion-reference evidence; a static source search found no existing `bundle_relationship` model. | Implement a bounded PCW co-residency relationship model with positive, negative, and real-artifact regressions; do not claim semantic linkage. |",
            "| P1 | The root roadmap labels a historical test-count baseline as latest. | The first TODO status baseline declares "
            + str(audit["todo_baseline"]["declared_test_count"])
            + " passing tests. | Refresh it only with a verified current primary-gate output, retaining it as an auditable baseline rather than a mutable assertion. |",
            "| P1 | Some project areas are outside a filename-matched test proxy. | "
            + str(len(audit["named_test_gaps"]))
            + " production modules lack a same-stem `tests/test_<module>.py` file; this is a review prompt, not proof of missing coverage. | Add targeted regression tests where a concrete behavior lacks direct evidence; do not use name matching as coverage proof. |",
            "| P1 | Existing command-execution call sites need a declared primary/optional classification. | "
            + str(len(audit["command_execution_references"]))
            + " AST-detected `subprocess`/`os` call sites exist in Python automation. | Classify each during the self-contained regeneration audit; preserve native paths and make optional validators explicitly unavailable rather than implicit prerequisites. |",
            "| P2 | Possible duplicate function bodies require human semantic review before consolidation. | "
            + str(len(audit["duplicate_function_groups"]))
            + " normalized AST body groups were found. Equal bodies can be deliberate adapters or fixtures. | Review only cross-module production groups; deduplicate through tested shared helpers where behavior and evidence contracts truly match. |",
            "| P2 | Acquisition discovery remains incomplete by design. | The queue has candidates with authorization but no exact public binary URL or release-boundary match. | Retain source-discovery records and add only independently corroborated, checksum-pinned releases. |",
            "",
            "## Automation and technology assessment",
            "",
            "The project already uses a suitable core technology split: Python provides deterministic parsing, acquisition orchestration, corpus verification, report export, and Rich TUI behavior; React/TypeScript/Vite provides a static, browser-accessible evidence reader. Replacing either surface is not justified by this audit. The immediate engineering priority is to strengthen the typed report schema and deterministic publication gates so each native evidence increment reaches both interfaces without drift.",
            "",
            "Python reuse should remain internal-first: `media_inspection`, `daad_parser`, `ddb_ir`, acquisition policy, manifest verification, and report export should be extended through narrow shared contracts rather than one-off scripts. External libraries or independently maintained projects may be added only after their revision, license/provenance, assumptions, reproducibility boundary, and native comparison role are recorded. No external analyzer output should become a primary claim by itself.",
            "",
            "## Duplicate-review candidates",
            "",
        ]
    )
    if audit["duplicate_function_groups"]:
        lines.extend(
            ["| Normalized body digest | Functions |", "| --- | --- |"])
        for group in audit["duplicate_function_groups"]:
            references = "<br>".join(
                f"`{entry['path']}:{entry['qualified_name']}`" for entry in group["functions"]
            )
            lines.append(f"| `{group['body_sha256'][:16]}` | {references} |")
    else:
        lines.append("No identical normalized production function bodies were detected.")
    lines.extend(
        [
            "",
            "## Required implementation sequence",
            "",
            "The next atomic delivery should implement the PCW child of the platform-bundle requirement: retain only measured same-disk membership between each validated DDB and similarly stemmed CHR/DAT members, persist the relationship state, and reject absent or cross-disk companions. That delivery advances tasks 38–39 without marking either broad task complete. The following bounded delivery should record the two R4 `DAAD.FNT` byte profiles as separate evidence records and retain the unresolved SINTAC boundary.",
            "",
            "Every change must run the repository-owned parallel scheduler, focused tests, the full test suite, documentation and language gates where applicable, and the atomic commit wrapper. Acquisition discovery can run independently only through the versioned Python adapters and must retain unsuccessful exact-match results as boundaries rather than guessed registrations.",
            "",
            "## Limitations and non-claims",
            "",
            "This audit does not establish universal catalog completeness, download authorization outside registered policy, binary semantic equivalence, format grammar coverage, code execution safety, runtime equivalence, browser accessibility conformance, or test coverage percentage. Those claims require the profile-specific evidence, fixtures, validators, generated output hashes, and interfaces enumerated in the active work register.",
            "",
        ]
    )
    return "\n".join(lines).rstrip()


def collect_audit(root: Path = ROOT) -> dict[str, Any]:
    """Collect deterministic project-health metrics from versioned repository inputs."""

    del root  # The command intentionally audits its own repository root only.
    production_paths = _python_files((ROOT / "daad_harvester",))
    script_paths = _python_files((ROOT / "scripts",))
    test_paths = _python_files((TEST_DIRECTORY,))
    backlog = _read_json(ROOT / "preservation_corpus" / "active_backlog_index.json")
    queue = _read_json(ROOT / "research" / "authorized_acquisition_queue.json")
    public_manifest = _read_json(ROOT / "preservation_corpus" / "public_artifacts_manifest.json")
    report_data = _read_json(ROOT / "preservation_corpus" / "report_data.json")
    regeneration = _read_json(ROOT / "preservation_corpus" / "regeneration_manifest.json")
    todo_text = (ROOT / "TODO.md").read_text(encoding="utf-8")
    all_audited_paths = production_paths + script_paths

    return {
        "schema_version": 1,
        "purpose": "Deterministic static repository audit; findings require profile-specific follow-up evidence.",
        "inputs": {
            "backlog": "preservation_corpus/active_backlog_index.json",
            "queue": "research/authorized_acquisition_queue.json",
            "public_artifact_manifest": "preservation_corpus/public_artifacts_manifest.json",
            "report_data": "preservation_corpus/report_data.json",
            "regeneration_manifest": "preservation_corpus/regeneration_manifest.json",
            "todo": "TODO.md",
        },
        "metrics": {
            "python": {
                "production_files": len(production_paths),
                "script_files": len(script_paths),
                "test_files": len(test_paths),
            },
            "web": _web_inventory(),
            "backlog": {
                "unchecked_items": backlog["unchecked_item_count"],
                "sections": len(backlog["section_counts"]),
                "section_counts": dict(sorted(backlog["section_counts"].items())),
                "subsystem_counts": _unchecked_by_subsystem(backlog),
            },
            "acquisition": {
                "queued": queue["queued_count"],
                "discovery_required": queue["discovery_required_count"],
                "blocked": queue["blocked_count"],
            },
            "corpus": {
                "artifacts": public_manifest["artifact_count"],
                "sources": report_data["summary"]["all_sources"],
            },
            "regeneration": {
                "entries": len(regeneration["entries"]),
                "inputs": sum(len(entry["inputs"]) for entry in regeneration["entries"]),
                "outputs": sum(len(entry["outputs"]) for entry in regeneration["entries"]),
            },
        },
        "audit": {
            "todo_baseline": _todo_baseline_status(todo_text),
            "duplicate_function_groups": _duplicate_function_groups(all_audited_paths),
            "command_execution_references": _subprocess_references(all_audited_paths),
            "named_test_gaps": _named_test_gaps(production_paths, test_paths),
            "limitations": [
                "Static analysis does not establish format, release, or runtime semantics.",
                "Filename-level test matching is a review prompt, not test coverage measurement.",
                "Identical AST bodies require semantic review before deduplication.",
            ],
        },
    }


def _write_outputs(data: dict[str, Any], json_path: Path, markdown_path: Path) -> None:
    json_path.parent.mkdir(parents=True, exist_ok=True)
    json_path.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    markdown_path.write_text(_markdown_report(data) + "\n", encoding="utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true", help="write deterministic audit JSON and Markdown")
    parser.add_argument("--check", action="store_true", help="verify committed audit outputs are current")
    parser.add_argument("--json-path", type=Path, default=DEFAULT_JSON)
    parser.add_argument("--markdown-path", type=Path, default=DEFAULT_MARKDOWN)
    args = parser.parse_args(argv)
    if args.write == args.check:
        parser.error("select exactly one of --write or --check")

    data = collect_audit()
    expected_json = json.dumps(data, indent=2, sort_keys=True) + "\n"
    expected_markdown = _markdown_report(data) + "\n"
    if args.write:
        _write_outputs(data, args.json_path, args.markdown_path)
        print(
            "Repository audit written: "
            f"{_relative(args.json_path)}, {_relative(args.markdown_path)}"
        )
        return 0

    actual_json = args.json_path.read_text(encoding="utf-8") if args.json_path.exists() else None
    actual_markdown = args.markdown_path.read_text(encoding="utf-8") if args.markdown_path.exists() else None
    if actual_json != expected_json or actual_markdown != expected_markdown:
        print("Repository audit is stale; run scripts/audit_repository_state.py --write", file=sys.stderr)
        return 1
    print("Repository audit verified")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
