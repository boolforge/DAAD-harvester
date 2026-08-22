import json
from pathlib import Path

from daad_harvester.acquisition import candidate_key, global_authorization_decision, validate_registration
from scripts.build_authorized_acquisition_queue import build


def candidate() -> dict[str, str]:
    return {
        "title": "Example Adventure",
        "publisher": "Example Publisher",
        "year": "2026",
        "language": "English",
    }


def global_policy() -> dict[str, str]:
    return {
        "authorization_state": "institutional_authorized",
        "directive": "docs/reverse_engineering/AUTHORIZATION_AND_HANDLING.md",
        "scope": "acquire_retain_execute_analyze_publish",
    }


def test_institutional_policy_authorizes_handling_but_requires_direct_source() -> None:
    assert global_authorization_decision(global_policy()).allowed is True
    decision = validate_registration(candidate(), None, global_policy())
    assert decision.allowed is False
    assert decision.reason == "authorized_source_discovery_required"


def test_institutional_authorization_requires_direct_source_identity() -> None:
    registration = {
        "candidate_key": candidate_key(candidate()),
        "source_url": "https://example.test/game.zip",
        "source_record_url": "https://example.test/metadata/example-adventure",
        "release_identity": {
            "title": "Example Adventure",
            "publisher": "Example Publisher",
            "year": "2026",
        },
    }
    decision = validate_registration(candidate(), registration, global_policy())
    assert decision.allowed is True
    assert decision.reason == "authorized_by_institutional_directive"


def test_institutional_authorization_rejects_mismatched_publication_identity() -> None:
    registration = {
        "candidate_key": candidate_key(candidate()),
        "source_url": "https://example.test/game.zip",
        "source_record_url": "https://example.test/metadata/example-adventure",
        "release_identity": {"title": "Example Adventure", "publisher": "Different Publisher", "year": "2026"},
    }
    assert validate_registration(candidate(), registration, global_policy()).reason == "release_identity_mismatch"


def test_per_source_authorization_remains_available_without_global_policy() -> None:
    registration = {
        "candidate_key": candidate_key(candidate()),
        "source_url": "https://example.test/game.zip",
        "authorization": {
            "kind": "official_free_download",
            "evidence_url": "https://example.test/license",
            "scope": "download",
        },
    }
    assert validate_registration(candidate(), registration).reason == "authorized"


def test_committed_queue_marks_unregistered_catalog_candidates_for_source_discovery() -> None:
    root = Path(__file__).parents[1]
    queue = build()
    committed = json.loads((root / "research" / "authorized_acquisition_queue.json").read_text(encoding="utf-8"))
    assert committed == queue
    assert queue["queued_count"] == 7
    assert queue["discovery_required_count"] == 42
    assert queue["blocked_count"] == 0
    queued_keys = {item["candidate_key"] for item in queue["queued"]}
    assert "diosa de cozumel, la|aventuras a.d.|1990|spanish" in queued_keys
    assert "behind closed doors|zenobi software|1988|english" in queued_keys
    assert "behind closed doors 2: the sequel|zenobi software|1988|english" in queued_keys
    assert {item["reason"] for item in queue["queued"]} == {"authorized_by_institutional_directive"}
    assert {item["reason"] for item in queue["discovery_required"]} == {"authorized_source_discovery_required"}
