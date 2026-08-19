"""Committed runtime-resource manifest regression."""

from __future__ import annotations

from scripts import verify_runtime_resources


def test_committed_runtime_resource_manifest_verifies() -> None:
    assert verify_runtime_resources.main() == 0
