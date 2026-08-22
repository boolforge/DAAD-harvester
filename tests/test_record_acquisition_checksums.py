from scripts.record_acquisition_checksums import build, measured_checksums


def result(key: str, *, status: str = "checksum_measured", unpacked: str = "unpacked") -> dict:
    return {
        "candidate_key": key,
        "source_status_after_unpack": unpacked,
        "verification": {"status": status, "algorithm": "sha256", "actual": "a" * 64},
    }


def test_measured_checksums_accepts_only_successful_sha256_unpacks() -> None:
    assert measured_checksums({"records": [result("one"), result("two", unpacked="error"), result("three", status="checksum_mismatch")]}) == {
        "one": {"algorithm": "sha256", "value": "a" * 64}
    }


def test_build_promotes_missing_checksum_without_overwriting_existing() -> None:
    registrations = {
        "schema_version": 1,
        "purpose": "test",
        "registrations": [
            {"candidate_key": "one"},
            {"candidate_key": "two", "source_checksum": {"algorithm": "sha1", "value": "b" * 40}},
        ],
    }
    output = build(registrations, {"records": [result("one"), result("two")]})
    assert output["checksum_promotion_summary"] == {"new_source_checksums": 1, "total_registrations": 2}
    assert output["registrations"][0]["source_checksum"] == {"algorithm": "sha256", "value": "a" * 64}
    assert output["registrations"][1]["source_checksum"] == {"algorithm": "sha1", "value": "b" * 40}
