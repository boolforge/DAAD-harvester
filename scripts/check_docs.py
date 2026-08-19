#!/usr/bin/env python3
"""Deterministic documentation integrity checks for the DAAD corpus."""

from __future__ import annotations

import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
LINK_RE = re.compile(r"(?<!!)\[[^\]]*\]\(([^)\s]+)(?:\s+[^)]*)?\)")
IGNORED_PREFIXES = ("http://", "https://", "mailto:", "#", "data:")
FOCUSED_DIRECTORIES = (
    "versions",
    "interpreters",
    "derivatives",
    "platforms",
    "formats",
    "reverse_engineering",
    "schemas",
    "sources",
)
LEGACY_OR_INDEX = {
    "README.md",
    "DAAD_CHRONOLOGY.md",
    "COMPATIBILITY_TAXONOMY.md",
    "PLATFORM_RUNTIME_MEDIA.md",
    "FORMAT_CAPABILITY_MATRIX.md",
    "SOURCE_REGISTER.md",
}
REQUIRED_MARKERS = ("**Question**", "**Evidence scope**", "**Non-claims**", "## References")


def check_relative_links(errors: list[str]) -> int:
    checked = 0
    for document in sorted(DOCS.rglob("*.md")):
        text = document.read_text(encoding="utf-8")
        for raw_target in LINK_RE.findall(text):
            target = raw_target.strip("<>").split("#", 1)[0]
            if not target or target.startswith(IGNORED_PREFIXES):
                continue
            candidate = ROOT / target.lstrip("/") if target.startswith("/") else (document.parent / target).resolve()
            checked += 1
            if not candidate.exists():
                errors.append(f"missing relative link: {document.relative_to(ROOT)} -> {raw_target}")
    return checked


def check_focused_module_headers(errors: list[str]) -> int:
    checked = 0
    for directory in FOCUSED_DIRECTORIES:
        for document in sorted((DOCS / directory).glob("*.md")):
            if document.name in LEGACY_OR_INDEX:
                continue
            checked += 1
            text = document.read_text(encoding="utf-8")
            for marker in REQUIRED_MARKERS:
                if marker not in text:
                    errors.append(f"missing required marker {marker!r}: {document.relative_to(ROOT)}")
    return checked


def check_mermaid_sources(errors: list[str]) -> int:
    checked = 0
    for diagram in sorted((DOCS / "diagrams").glob("*.mmd")):
        checked += 1
        text = diagram.read_text(encoding="utf-8").lstrip()
        if not any(text.startswith(prefix) for prefix in ("flowchart", "graph", "sequenceDiagram", "classDiagram", "stateDiagram")):
            errors.append(f"unrecognized Mermaid declaration: {diagram.relative_to(ROOT)}")
    return checked


def main() -> int:
    errors: list[str] = []
    links = check_relative_links(errors)
    modules = check_focused_module_headers(errors)
    diagrams = check_mermaid_sources(errors)
    if errors:
        print("Documentation integrity check failed:")
        print("\n".join(f"- {error}" for error in errors))
        return 1
    print(f"Documentation integrity check passed: {links} relative links, {modules} focused modules, {diagrams} Mermaid sources.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
