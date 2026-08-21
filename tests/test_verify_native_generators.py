"""Regression coverage for repository-native generator evidence."""

from __future__ import annotations

import hashlib

from daad_harvester.dsk_generation import build_blank_cpc_system_dsk
from scripts import verify_native_generators


def test_generated_fixture_evidence_is_canonical_and_structurally_valid() -> None:
    evidence = verify_native_generators.generated_fixture_evidence()

    assert evidence["generator_id"] == "extended-dsk-blank-cpc-system-v1"
    assert evidence["status"] == "generated_structurally_valid"
    assert evidence["output"] == {
        "byte_length": len(build_blank_cpc_system_dsk()),
        "sha256": hashlib.sha256(build_blank_cpc_system_dsk()).hexdigest(),
        "md5_full": hashlib.md5(build_blank_cpc_system_dsk()).hexdigest(),
    }
    validation = evidence["native_validation"]
    assert isinstance(validation, dict)
    assert validation["validation"] == "validated_cpc_dsk_track_stream"
    assert validation["evidence"]["cpm_directory_profile"] == "cpc_system"
