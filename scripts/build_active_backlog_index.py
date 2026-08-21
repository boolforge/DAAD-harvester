#!/usr/bin/env python3
"""Build a deterministic index of unchecked preservation work-register items.

The index is intentionally descriptive rather than a completion tracker: every
unchecked item remains independently represented, including broad requirements
whose child tasks may already have evidence.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
from typing import Any, Sequence

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_TODO = ROOT / "TODO.md"
DEFAULT_OUTPUT = ROOT / "preservation_corpus" / "active_backlog_index.json"


def classify(text: str) -> dict[str, Any]:
    lowered = text.lower()
    evidence_inputs: list[str] = []
    for label, terms in (
        ("retained original bytes", ("retained", "bytes", "artifact", "media")),
        ("native parser or validator", ("parser", "validator", "grammar", "format")),
        ("real-artifact regression", ("real-artifact", "regression", "corruption", "negative")),
        ("runtime or emulator observation", ("runtime", "emulator", "behavior", "interpreter")),
        ("independent external comparator", ("independent", "comparator", "tool", "source")),
        ("report or interface output", ("report", "web", "tui", "interface", "view")),
    ):
        if any(term in lowered for term in terms):
            evidence_inputs.append(label)
    if not evidence_inputs:
        evidence_inputs.append("repository evidence and deterministic tests")

    subsystems: list[str] = []
    for label, terms in (
        ("corpus and provenance", ("corpus", "provenance", "artifact", "source")),
        ("media and resource inspection", (".chr", ".dat", ".pic", ".ddb", "resource", "media")),
        ("runtime and reverse analysis", ("runtime", "interpreter", "decompil", "emulator", "scummvm")),
        ("web report and publication", ("web", "report", "publication", "pages", "derivative")),
        ("terminal interface", ("tui", "terminal", "keyboard")),
        ("tooling and workflow gates", ("workflow", "ci", "gate", "regenerat", "audit")),
    ):
        if any(term in lowered for term in terms):
            subsystems.append(label)
    if not subsystems:
        subsystems.append("preservation workflow")

    dependencies: list[str] = []
    if any(term in lowered for term in ("after", "until", "only after", "before", "when ")):
        dependencies.append("explicit sequencing or prerequisite evidence")
    if any(term in lowered for term in ("profile", "platform", "loader", "interpreter")):
        dependencies.append("profile/platform boundary")
    if not dependencies:
        dependencies.append("none stated; retain unresolved boundaries")

    if any(term in lowered for term in ("report", "web", "tui", "publication", "interface", "derivative")):
        impact = "report/TUI/web regeneration and accessibility checks"
    elif any(term in lowered for term in ("regenerat", "workflow", "ci", "manifest")):
        impact = "deterministic workflow, manifest, or CI regeneration"
    else:
        impact = "corpus, provenance, and regression data may require regeneration"

    if any(term in lowered for term in ("every", "all ", "complete", "exhaustive", "massive", "universal")):
        boundary = "broad gate; split into independently evidenced child deliveries"
    else:
        boundary = "single profile, evidence record, validator, or interface slice"

    return {
        "evidence_inputs": sorted(set(evidence_inputs)),
        "affected_subsystems": sorted(set(subsystems)),
        "dependencies": sorted(set(dependencies)),
        "required_real_artifact_regression": any(term in lowered for term in ("real-artifact", "real artifact", "retained", "corpus")),
        "regeneration_report_impact": impact,
        "atomic_delivery_boundary": boundary,
    }


def build_index(todo_text: str) -> dict[str, Any]:
    section = "Unsectioned"
    items: list[dict[str, Any]] = []
    for line_number, line in enumerate(todo_text.splitlines(), start=1):
        heading = re.match(r"^(#{1,4})\s+(.+?)\s*$", line)
        if heading:
            section = heading.group(2)
            continue
        match = re.match(r"^\s*- \[ \] (.+?)\s*$", line)
        if not match:
            continue
        text = match.group(1)
        items.append({"id": f"todo-{line_number:04d}", "line": line_number, "section": section, "text": text, **classify(text)})
    sections: dict[str, int] = {}
    for item in items:
        sections[item["section"]] = sections.get(item["section"], 0) + 1
    return {
        "schema_version": 1,
        "purpose": "Deterministic index of unchecked TODO work; this index never promotes child evidence to broad-task completion.",
        "todo_source": "TODO.md",
        "unchecked_item_count": len(items),
        "section_counts": dict(sorted(sections.items())),
        "items": items,
    }


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--todo", type=Path, default=DEFAULT_TODO)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    index = build_index(args.todo.read_text(encoding="utf-8"))
    expected = json.dumps(index, indent=2, ensure_ascii=False) + "\n"
    if args.check:
        if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
            print(f"Active backlog index failed: stale or missing {args.output}")
            return 1
        print(f"Active backlog index verified: {index['unchecked_item_count']} unchecked items.")
        return 0
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(expected, encoding="utf-8")
    print(f"Active backlog index generated: {index['unchecked_item_count']} unchecked items.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
