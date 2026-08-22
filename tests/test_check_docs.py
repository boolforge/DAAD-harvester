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


def test_full_documentation_integrity_gate_passes() -> None:
    assert check_docs.main() == 0
