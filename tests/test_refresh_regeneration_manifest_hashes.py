from __future__ import annotations

import copy

import pytest

from scripts.refresh_regeneration_manifest_hashes import ROOT, refresh, sha256


def test_refresh_updates_only_selected_declared_entry() -> None:
    policy_path = "docs/SELF_CONTAINED_REGENERATION.md"
    manifest = {
        "entries": [
            {
                "id": "selected",
                "inputs": [{"path": policy_path, "sha256": "stale"}],
                "outputs": [],
            },
            {
                "id": "untouched",
                "inputs": [{"path": policy_path, "sha256": "preserve"}],
                "outputs": [],
            },
        ]
    }

    refreshed = refresh(copy.deepcopy(manifest), {"selected"})

    assert refreshed["entries"][0]["inputs"][0]["sha256"] == sha256(ROOT / policy_path)
    assert refreshed["entries"][1]["inputs"][0]["sha256"] == "preserve"


def test_refresh_rejects_unknown_entry_identifier() -> None:
    with pytest.raises(ValueError, match="unknown regeneration manifest IDs"):
        refresh({"entries": [{"id": "known", "inputs": [], "outputs": []}]}, {"unknown"})
