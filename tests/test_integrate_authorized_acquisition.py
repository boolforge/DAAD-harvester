from __future__ import annotations

import hashlib
from pathlib import Path

import pytest

from scripts.integrate_authorized_acquisition import verified_transfer_plan


def queue_entry(digest: str) -> dict:
    return {
        "candidate_key": "example|publisher|2024|unknown",
        "title": "Example",
        "publisher": "Publisher",
        "year": "2024",
        "language": "Unknown",
        "filename": "example.tap.zip",
        "source_url": "https://example.test/example.tap.zip",
        "source_record_url": "https://example.test/entry/1",
        "release_identity": {"title": "Example", "publisher": "Publisher", "year": "2024"},
        "reason": "authorized_by_institutional_directive",
        "source_checksum": {"algorithm": "sha256", "value": digest},
    }


def result(digest: str, *, unpacked: str = "unpacked") -> dict:
    return {
        "candidate_key": "example|publisher|2024|unknown",
        "source_id": 7,
        "source_status_after_unpack": unpacked,
        "verification": {"status": "checksum_measured", "algorithm": "sha256", "actual": digest},
    }


def test_verified_transfer_plan_requires_pinned_measured_unpacked_byte(tmp_path: Path) -> None:
    payload = b"authorized spectrum source"
    digest = hashlib.sha256(payload).hexdigest()
    staging = tmp_path / "staging"
    download = staging / "downloads" / "7_example.tap.zip"
    download.parent.mkdir(parents=True)
    download.write_bytes(payload)

    plan = verified_transfer_plan(
        {"queued": [queue_entry(digest)]},
        {"records": [result(digest)]},
        staging,
    )

    assert len(plan) == 1
    assert plan[0]["staged_path"] == download


def test_verified_transfer_plan_rejects_nonmatching_or_not_unpacked_result(tmp_path: Path) -> None:
    digest = hashlib.sha256(b"expected").hexdigest()
    staging = tmp_path / "staging"
    download = staging / "downloads" / "7_example.tap.zip"
    download.parent.mkdir(parents=True)
    download.write_bytes(b"different")

    with pytest.raises(ValueError, match="checksum"):
        verified_transfer_plan({"queued": [queue_entry(digest)]}, {"records": [result(digest)]}, staging)
    with pytest.raises(ValueError, match="unpack"):
        verified_transfer_plan(
            {"queued": [queue_entry(digest)]},
            {"records": [result(digest, unpacked="downloaded")]},
            staging,
        )
