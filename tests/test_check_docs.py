"""Regression coverage for mandatory documentation navigation contracts."""

from __future__ import annotations

from scripts import check_docs


def test_traceability_contract_is_discoverable_from_every_required_entry_point() -> None:
    errors: list[str] = []

    checked = check_docs.check_traceability_navigation(errors)

    assert checked == len(check_docs.TRACEABILITY_NAVIGATION_DOCUMENTS)
    assert errors == []


def test_clean_clone_continuation_is_discoverable_and_contains_the_required_workflow() -> None:
    errors: list[str] = []

    checked = check_docs.check_clean_clone_continuation(errors)

    assert checked == len(check_docs.CLEAN_CLONE_CONTINUATION_REQUIREMENTS)
    assert errors == []


def test_atomic_remote_delivery_policy_is_discoverable_from_every_required_entry_point() -> None:
    errors: list[str] = []

    checked = check_docs.check_atomic_delivery_navigation(errors)

    assert checked == len(check_docs.ATOMIC_DELIVERY_NAVIGATION_DOCUMENTS)
    assert errors == []


def test_relative_links_cover_root_level_agent_and_readme_docs() -> None:
    """Root-level files (AGENT.md, README.md, ...) are what an agent or a human
    reads first -- they need the same link protection as everything under docs/,
    which check_relative_links did not originally provide."""
    errors: list[str] = []

    checked = check_docs.check_relative_links(errors)

    assert errors == []
    root_markdown_files = list(check_docs.ROOT.glob("*.md"))
    assert check_docs.ROOT / "AGENT.md" in root_markdown_files
    assert check_docs.ROOT / "README.md" in root_markdown_files
    # A sanity floor, not an exact count: docs/ alone already had hundreds of
    # links before this change, so this only fails if root-level files stop
    # being scanned entirely.
    assert checked > 545


def test_full_documentation_integrity_gate_passes() -> None:
    assert check_docs.main() == 0
