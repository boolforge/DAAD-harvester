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
    assert decision.reason == "source_specific_authorization_required"


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
    assert decision.allowed is False
    assert decision.reason == "source_specific_authorization_required"


def test_institutional_authorization_accepts_documented_creator_publisher_variance() -> None:
    catalog_candidate = {"title": "Errand Boy, The", "publisher": "Jose Daniel Carbonell", "year": "2021", "language": "English"}
    registration = {
        "candidate_key": candidate_key(catalog_candidate),
        "source_url": "https://example.test/ErrandBoyThe(EN).dsk.zip",
        "source_record_url": "https://example.test/entry/38332",
        "release_identity": {"title": "Errand Boy, The", "publisher": "Jose Daniel Carbonell", "year": "2021"},
        "catalog_identity_variance": {"kind": "catalog_publisher_is_source_creator", "source_creator": "Jose Daniel Carbonell Cob (Spain)", "source_publisher": "Dwalin"},
        "source_release_identity": {"title": "The Errand Boy", "publisher": "Dwalin", "creator": "Jose Daniel Carbonell Cob (Spain)", "year": "2021"},
    }
    assert validate_registration(catalog_candidate, registration, global_policy()).reason == "source_specific_authorization_required"
    registration.pop("catalog_identity_variance")
    assert validate_registration(catalog_candidate, registration, global_policy()).reason == "invalid_catalog_creator_variance"


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
    assert queue["queued_count"] == 0
    assert queue["discovery_required_count"] == 79
    assert queue["blocked_count"] == 0
    queued_keys = {item["candidate_key"] for item in queue["queued"]}
    assert not queued_keys
    assert {item["reason"] for item in queue["queued"]} == set()
    assert {item["reason"] for item in queue["discovery_required"]} == {"source_specific_authorization_required"}
    discovery_keys = {item["candidate_key"] for item in queue["discovery_required"]}
    assert "behind closed doors|zenobi software|1988|english" in discovery_keys
    assert "cero absoluto|esp soft|2016|spanish" in discovery_keys
    assert "errand boy, the|jose daniel carbonell|2021|english" in discovery_keys
    assert "aventura original, la|aventuras a.d., dinamic software|1989|spanish" in discovery_keys
    assert "beltalowda|molisoft|2025|unknown" in discovery_keys
    assert "a case of murder 128k|taskmaster software (uk)|2023|unknown" in discovery_keys
    assert sum(item["reason"] == "source_specific_authorization_required" for item in queue["discovery_required"]) == 79
    observed_language_keys = {
        "13 rue del percebe: el nacimiento de la leyenda|manuel mart\u00ednez pe\u00f1a|2023|unknown",
        "a case of murder 128k|taskmaster software (uk)|2023|unknown",
    }
    assert all(item.get("source_observed_identity") for item in queue["discovery_required"] if item["candidate_key"] in observed_language_keys)
