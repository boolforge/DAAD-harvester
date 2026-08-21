"""Regression coverage for repository-native generator evidence."""

from __future__ import annotations

from daad_harvester.dsk_generation import build_blank_cpc_system_dsk
from daad_harvester.unpack import compute_hashes
from scripts import verify_native_generators


def test_generated_fixture_evidence_is_canonical_and_structurally_valid() -> None:
    evidence = verify_native_generators.generated_fixture_evidence()

    assert evidence["generator_id"] == "extended-dsk-blank-cpc-system-v1"
    assert evidence["status"] == "generated_structurally_valid"
    output = evidence["output"]
    assert isinstance(output, dict)
    assert output["byte_length"] == len(build_blank_cpc_system_dsk())
    assert output["sha256"] == "ab33b5581e8141fd4c721a1cf6e6e98d30454e1a2632e1951168a678d10e495b"
    assert output["md5_full"] == "4d628f542ee8a7b2bfee255606819485"
    assert output["checksums"] == compute_hashes(build_blank_cpc_system_dsk())
    validation = evidence["native_validation"]
    assert isinstance(validation, dict)
    assert validation["validation"] == "validated_cpc_dsk_track_stream"
    assert validation["evidence"]["cpm_directory_profile"] == "cpc_system"
