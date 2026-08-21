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
    "requirements",
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
REGENERATION_POLICY_LINK = "SELF_CONTAINED_REGENERATION.md"
REGENERATION_POLICY_DOCUMENTS = (
    ROOT / "README.md",
    DOCS / "README.md",
    DOCS / "CONTRIBUTOR_CONTINUATION.md",
    DOCS / "RESEARCH_METHODOLOGY.md",
    DOCS / "schemas" / "EVIDENCE_MODEL.md",
    DOCS / "schemas" / "STATIC_REPORT_CONTRACT.md",
    DOCS / "reverse_engineering" / "AUTHORIZATION_AND_HANDLING.md",
    DOCS / "reverse_engineering" / "ARCHITECTURE_WORKFLOWS.md",
)
TRACEABILITY_DOCUMENT = DOCS / "requirements" / "TRACEABILITY_AND_CONTINUITY.md"
TRACEABILITY_NAVIGATION_DOCUMENTS = (
    ROOT / "README.md",
    DOCS / "README.md",
    DOCS / "DOCUMENTATION_MAP.md",
    DOCS / "CONTRIBUTOR_CONTINUATION.md",
)
ATOMIC_DELIVERY_DOCUMENT = DOCS / "ATOMIC_REMOTE_DELIVERY.md"
ATOMIC_DELIVERY_NAVIGATION_DOCUMENTS = (
    ROOT / "README.md",
    DOCS / "README.md",
    DOCS / "CONTRIBUTOR_CONTINUATION.md",
)
GLOBAL_ISSUE_LIFECYCLE_REQUIREMENTS = (
    (
        TRACEABILITY_DOCUMENT,
        (
            "## 7.1 Global conflict and issue lifecycle",
            "**No silent disappearance.**",
            "resolved_verified",
        ),
    ),
    (
        DOCS / "CONTRIBUTOR_CONTINUATION.md",
        (
            "### 7.1 Global conflict and issue recording rule",
            "update the same record",
        ),
    ),
)


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


def check_regeneration_policy_links(errors: list[str]) -> int:
    """Ensure core policy surfaces cannot silently omit the global rule."""
    checked = 0
    policy = DOCS / REGENERATION_POLICY_LINK
    if not policy.is_file():
        errors.append(f"missing self-contained regeneration policy: {policy.relative_to(ROOT)}")
        return checked
    for document in REGENERATION_POLICY_DOCUMENTS:
        checked += 1
        if REGENERATION_POLICY_LINK not in document.read_text(encoding="utf-8"):
            errors.append(
                f"missing self-contained regeneration policy link: {document.relative_to(ROOT)}"
            )
    return checked


def check_traceability_navigation(errors: list[str]) -> int:
    """Ensure clean-clone continuation can discover the traceability contract."""

    checked = 0
    if not TRACEABILITY_DOCUMENT.is_file():
        errors.append(f"missing traceability contract: {TRACEABILITY_DOCUMENT.relative_to(ROOT)}")
        return checked
    required_link = "requirements/TRACEABILITY_AND_CONTINUITY.md"
    for document in TRACEABILITY_NAVIGATION_DOCUMENTS:
        checked += 1
        if required_link not in document.read_text(encoding="utf-8"):
            errors.append(f"missing traceability navigation link: {document.relative_to(ROOT)}")
    return checked


def check_atomic_delivery_navigation(errors: list[str]) -> int:
    """Ensure clean-clone contributors can discover the delivery discipline."""

    checked = 0
    if not ATOMIC_DELIVERY_DOCUMENT.is_file():
        errors.append(f"missing atomic remote delivery policy: {ATOMIC_DELIVERY_DOCUMENT.relative_to(ROOT)}")
        return checked
    required_link = "ATOMIC_REMOTE_DELIVERY.md"
    for document in ATOMIC_DELIVERY_NAVIGATION_DOCUMENTS:
        checked += 1
        if required_link not in document.read_text(encoding="utf-8"):
            errors.append(f"missing atomic remote delivery policy link: {document.relative_to(ROOT)}")
    return checked


def check_global_issue_lifecycle(errors: list[str]) -> int:
    """Ensure issue observation and verified-resolution updates stay mandatory."""

    checked = 0
    for document, markers in GLOBAL_ISSUE_LIFECYCLE_REQUIREMENTS:
        checked += 1
        if not document.is_file():
            errors.append(f"missing global issue lifecycle document: {document.relative_to(ROOT)}")
            continue
        text = document.read_text(encoding="utf-8")
        for marker in markers:
            if marker not in text:
                errors.append(
                    f"missing global issue lifecycle marker {marker!r}: {document.relative_to(ROOT)}"
                )
    return checked


def main() -> int:
    errors: list[str] = []
    links = check_relative_links(errors)
    modules = check_focused_module_headers(errors)
    diagrams = check_mermaid_sources(errors)
    policy_documents = check_regeneration_policy_links(errors)
    traceability_documents = check_traceability_navigation(errors)
    atomic_delivery_documents = check_atomic_delivery_navigation(errors)
    issue_lifecycle_documents = check_global_issue_lifecycle(errors)
    if errors:
        print("Documentation integrity check failed:")
        print("\n".join(f"- {error}" for error in errors))
        return 1
    print(
        "Documentation integrity check passed: "
        f"{links} relative links, {modules} focused modules, {diagrams} Mermaid sources, "
        f"{policy_documents} required regeneration-policy links, "
        f"{traceability_documents} traceability-navigation links, "
        f"{atomic_delivery_documents} atomic-delivery navigation links, "
        f"{issue_lifecycle_documents} global issue-lifecycle documents."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
