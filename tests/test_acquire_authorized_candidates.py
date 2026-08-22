import hashlib
from pathlib import Path

import pytest

from scripts.acquire_authorized_candidates import platform_for_source, selected_entries, verify_checksum


def entry() -> dict:
    return {
        "candidate_key": "diosa de cozumel, la|aventuras a.d.|1990|spanish",
        "title": "Diosa de Cozumel, La",
        "publisher": "Aventuras A.D.",
        "year": "1990",
        "language": "Spanish",
        "reason": "authorized_by_institutional_directive",
        "source_url": "https://archive.example.test/diosa.adf",
        "source_record_url": "https://archive.example.test/metadata/diosa",
        "source_release_id": "diosa-1990",
        "release_identity": {"title": "Diosa de Cozumel, La", "publisher": "Aventuras A.D.", "year": "1990"},
        "source_checksum": {"algorithm": "sha1", "value": "ignored"},
    }


def test_platform_is_inferred_only_from_direct_binary_filename() -> None:
    assert platform_for_source(entry()) == "amiga"
    assert platform_for_source({"source_url": "https://example.test/archive.zip"}) is None


def test_checksum_verification_requires_matching_declared_digest(tmp_path: Path) -> None:
    payload = tmp_path / "diosa.adf"
    payload.write_bytes(b"DAAD")
    digest = hashlib.sha1(b"DAAD").hexdigest()
    assert verify_checksum(payload, {"algorithm": "sha1", "value": digest})["status"] == "checksum_verified"
    assert verify_checksum(payload, {"algorithm": "sha1", "value": "0" * 40})["status"] == "checksum_mismatch"
    assert verify_checksum(payload, None)["status"] == "no_declared_source_checksum"


def test_selection_accepts_only_complete_authorized_entries() -> None:
    queue = {"queued": [entry()]}
    assert selected_entries(queue, None) == [entry()]
    incomplete = entry()
    del incomplete["release_identity"]
    with pytest.raises(ValueError, match="lacks release_identity"):
        selected_entries({"queued": [incomplete]}, None)


def test_selection_rejects_non_authorized_queue_entries() -> None:
    blocked = entry()
    blocked["reason"] = "authorized_source_discovery_required"
    with pytest.raises(ValueError, match="not authorized"):
        selected_entries({"queued": [blocked]}, None)
