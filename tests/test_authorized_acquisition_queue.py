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
    assert validate_registration(catalog_candidate, registration, global_policy()).allowed
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
    assert queue["queued_count"] == 28
    assert queue["discovery_required_count"] == 21
    assert queue["blocked_count"] == 0
    queued_keys = {item["candidate_key"] for item in queue["queued"]}
    assert "diosa de cozumel, la|aventuras a.d.|1990|spanish" in queued_keys
    assert "behind closed doors|zenobi software|1988|english" in queued_keys
    assert "behind closed doors 2: the sequel|zenobi software|1988|english" in queued_keys
    assert "cero absoluto|esp soft|2016|spanish" in queued_keys
    assert "behind closed doors 7|zenobi software|2018|english" in queued_keys
    assert "behind closed doors 8|pension productions|2020|english" in queued_keys
    assert "alien research centre 2|pension productions|2019|english" in queued_keys
    assert "behind closed doors 5|pension productions|2019|english" in queued_keys
    assert "behind closed doors 6|pension productions|2019|english" in queued_keys
    assert "daga oscura, la|eduardo josé villalobos galindo|2024|spanish" in queued_keys
    assert "dark dagger, the|eduardo josé villalobos galindo|2024|english" in queued_keys
    assert "errand boy, the|jose daniel carbonell|2021|english" in queued_keys
    assert "chico de los recados, el|jose daniel carbonell|2021|spanish" in queued_keys
    assert "elves of maroland, the|jose daniel carbonell|2024|english" in queued_keys
    assert "die, ragus!|sunteam|2023|english" in queued_keys
    assert "golden seas|sunteam|2022|english" in queued_keys
    assert "fuddo and slam|zenobi software|1988|english" in queued_keys
    assert "balrog and the cat, the|zenobi software|1988|english" in queued_keys
    assert "everyday tale of a seeker of gold, an|zenobi software|1986|english" in queued_keys
    assert "framed!|kennard douglas|2024|english" in queued_keys
    assert "barry basic and the quest for the perfect port|dee cooke|2020|english" in queued_keys
    assert "casa al otro lado de la tormenta, la|pablo martínez merino|2019|spanish" in queued_keys
    assert "aventura espacial, la|aventuras a.d.|1990|spanish" in queued_keys
    assert "aventura original, la|aventuras a.d., dinamic software|1989|spanish" in queued_keys
    assert {item["reason"] for item in queue["queued"]} == {"authorized_by_institutional_directive"}
    assert {item["reason"] for item in queue["discovery_required"]} == {"authorized_source_discovery_required"}
