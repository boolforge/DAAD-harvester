"""Canonical evidence for promoted repository-native format generators."""

from __future__ import annotations

from daad_harvester.adf_generation import build_blank_adf_ofs, validate_blank_adf_ofs
from daad_harvester.dsk_generation import build_blank_cpc_system_dsk
from daad_harvester.media_inspection import inspect_native_media
from daad_harvester.unpack import compute_hashes


# Updated only through a reviewed fixture-generation change.
BLANK_CPC_SYSTEM_SHA256 = "ab33b5581e8141fd4c721a1cf6e6e98d30454e1a2632e1951168a678d10e495b"
BLANK_ADF_OFS_SHA256 = "0579352c016748a32e12cc5900ce04b0f69e05d9bd04c5fd52764fd38e161468"


def generated_fixture_evidence() -> dict[str, object]:
    """Return canonical evidence for the first promoted native DSK generator."""

    payload = build_blank_cpc_system_dsk()
    checksums = compute_hashes(payload)
    inspection = inspect_native_media("generated-blank-cpc-system.dsk", payload)
    return {
        "schema_version": 1,
        "generator_id": "extended-dsk-blank-cpc-system-v1",
        "technical_medium": "extended_cpc_dsk",
        "status": "generated_structurally_valid",
        "inputs": {
            "creator": "DAAD-HARVEST",
            "profile": "blank_cpc_system_40x1_9x512",
            "filesystem_claim": "none",
        },
        "output": {
            "byte_length": len(payload),
            "sha256": checksums["sha256"],
            "md5_full": checksums["md5_full"],
            "checksums": checksums,
        },
        "native_validation": {
            "parser": inspection.parser,
            "status": inspection.status,
            "validation": inspection.validation,
            "evidence": inspection.evidence,
        },
        "comparison_boundary": {
            "adp": "source_crosswalk_only",
            "authentic_release": "not_applicable_blank_fixture",
            "emulator": "not_applicable_container_fixture",
        },
    }


def generated_blank_adf_ofs_fixture_evidence() -> dict[str, object]:
    """Return canonical evidence for the bounded native ADF/OFS fixture."""

    payload = build_blank_adf_ofs()
    checksums = compute_hashes(payload)
    inspection = inspect_native_media("generated-blank-adf-ofs.adf", payload)
    return {
        "schema_version": 1,
        "generator_id": "adf-ofs-blank-standard-dd-v1",
        "technical_medium": "amiga_adf_ofs",
        "status": "generated_structurally_valid",
        "inputs": {
            "profile": "blank_adf_ofs_dd_1760x512",
            "volume_name": "EMPTY",
            "timestamp": "0_days_0_minutes_0_ticks",
            "filesystem_claim": "empty_ofs_filesystem_no_members",
        },
        "output": {
            "byte_length": len(payload),
            "sha256": checksums["sha256"],
            "md5_full": checksums["md5_full"],
            "checksums": checksums,
        },
        "native_validation": {
            "parser": inspection.parser,
            "status": inspection.status,
            "validation": inspection.validation,
            "evidence": {
                **inspection.evidence,
                "writer_validation": validate_blank_adf_ofs(payload),
            },
        },
        "comparison_boundary": {
            "adp": "source_crosswalk_timestamp_nondeterminism_recorded",
            "authentic_release": "not_applicable_blank_fixture",
            "emulator": "not_applicable_container_fixture",
        },
    }


def generated_fixtures_evidence() -> list[dict[str, object]]:
    """Return canonical evidence in stable generator-ID order."""

    return [generated_fixture_evidence(), generated_blank_adf_ofs_fixture_evidence()]


def _verify_record(evidence: dict[str, object], expected_sha256: str, validation_name: str) -> None:
    output = evidence["output"]
    validation = evidence["native_validation"]
    assert isinstance(output, dict)
    assert isinstance(validation, dict)
    if expected_sha256 == "PENDING":
        raise RuntimeError(
            f"{evidence['generator_id']} SHA-256 is not pinned; run with --print-evidence and review the output"
        )
    if output["sha256"] != expected_sha256:
        raise RuntimeError(
            f"native fixture SHA-256 differs for {evidence['generator_id']}: "
            f"expected {expected_sha256}, got {output['sha256']}"
        )
    if validation["validation"] != validation_name:
        raise RuntimeError(f"native fixture failed inspection for {evidence['generator_id']}: {validation}")


def verify_native_generators() -> list[dict[str, object]]:
    """Validate all promoted fixtures and return canonical evidence records."""

    evidence = generated_fixtures_evidence()
    _verify_record(evidence[0], BLANK_CPC_SYSTEM_SHA256, "validated_cpc_dsk_track_stream")
    _verify_record(evidence[1], BLANK_ADF_OFS_SHA256, "validated_adf_ofs_ffs_structure")
    return evidence
