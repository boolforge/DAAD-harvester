"""Canonical evidence for promoted repository-native format generators."""

from __future__ import annotations

import json
from pathlib import Path

from daad_harvester.adf_generation import build_blank_adf_ofs, validate_blank_adf_ofs
from daad_harvester.chr_generation import render_adp_chr_glyph_atlas
from daad_harvester.dsk_generation import build_blank_cpc_system_dsk
from daad_harvester.media_inspection import inspect_native_media
from daad_harvester.platform_media import extract_tzx
from daad_harvester.tzx_generation import TzxStandardDataBlock, build_tzx_standard_data, validate_tzx_standard_data
from daad_harvester.unpack import compute_hashes


# Updated only through a reviewed fixture-generation change.
BLANK_CPC_SYSTEM_SHA256 = "ab33b5581e8141fd4c721a1cf6e6e98d30454e1a2632e1951168a678d10e495b"
BLANK_ADF_OFS_SHA256 = "0579352c016748a32e12cc5900ce04b0f69e05d9bd04c5fd52764fd38e161468"
STANDARD_TZX_SHA256 = "a6175d4413b42e61d9b5e2dd7956ba547a48ad48ca1c71b121ad9e5dcab48411"
TORREOSCURA_CHR_SHA256 = "715c0a6e717e9475d80cf5a6c2afbb7bff76dcdc235435bc51cebe02cbc6c6ba"
TORREOSCURA_CHR_ATLAS_SHA256 = "70e01c501e7630e81ea5c7e1073d8831ce2a99e07c9babf4ec9328eacaf7a9c1"
ROOT = Path(__file__).resolve().parents[1]
TORREOSCURA_CHR_PATH = ROOT / "preservation_corpus" / "extracted" / "depth2_918656c1_PARTE001.CHR"
TORREOSCURA_CHR_ATLAS_PATH = ROOT / "preservation_corpus" / "derived" / "pcw_chr" / "torreoscura_parte001_chr_atlas.png"
TORREOSCURA_CHR_ATLAS_METADATA_PATH = ROOT / "preservation_corpus" / "derived" / "pcw_chr" / "torreoscura_parte001_chr_atlas.json"


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


def generated_standard_tzx_fixture_evidence() -> dict[str, object]:
    """Return canonical evidence for a supported standard-block TZX pair."""

    header = b"\x00\x00DAAD GAME \x00\x00\x00\x00\x00\x00\x00"
    data = b"\xffPAYLOAD\x00"
    payload = build_tzx_standard_data([TzxStandardDataBlock(header), TzxStandardDataBlock(data)])
    checksums = compute_hashes(payload)
    inspection = inspect_native_media("generated-standard-data.tzx", payload)
    extracted = extract_tzx(payload)
    return {
        "schema_version": 1,
        "generator_id": "tzx-standard-data-synthetic-pair-v1",
        "technical_medium": "tzx_cdt_standard_data",
        "status": "generated_extraction_verified",
        "inputs": {
            "profile": "tzx_v1_20_standard_data_header_data_pair",
            "block_count": "2",
            "filesystem_claim": "none_tape_stream_with_supported_member_pair",
            "semantic_claim": "explicit_standard_data_bytes_no_loader_or_runtime_claim",
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
                "writer_validation": validate_tzx_standard_data(payload),
                "extracted_members": [
                    {"name": name, "byte_length": len(member)} for name, member in extracted
                ],
            },
        },
        "comparison_boundary": {
            "adp": "not_applicable_adp_has_no_tzx_writer_crosswalk",
            "authentic_release": "not_applicable_synthetic_fixture",
            "emulator": "not_applicable_container_fixture",
        },
    }


def retained_torreoscura_chr_atlas_evidence() -> dict[str, object]:
    """Return report-safe evidence for the retained validated PCW glyph atlas."""

    source = TORREOSCURA_CHR_PATH.read_bytes()
    atlas, atlas_evidence = render_adp_chr_glyph_atlas(source, scale=2)
    stored_atlas = TORREOSCURA_CHR_ATLAS_PATH.read_bytes()
    metadata = json.loads(TORREOSCURA_CHR_ATLAS_METADATA_PATH.read_text(encoding="utf-8"))
    source_hashes = compute_hashes(source)
    atlas_hashes = compute_hashes(atlas)
    return {
        "schema_version": 1,
        "generator_id": "pcw-torreoscura-validated-chr-atlas-v1",
        "technical_medium": "daad_legacy_chr_glyph_atlas",
        "status": "derived_profile_validated",
        "inputs": {
            "source_artifact": "PARTE001.CHR",
            "source_sha256": source_hashes["sha256"],
            "profile": "adp_legacy_chr_writer",
            "glyph_index_mapping": "byte_index_only_no_code_page_claim",
        },
        "output": {
            "byte_length": len(atlas),
            "sha256": atlas_hashes["sha256"],
            "checksums": atlas_hashes,
            "metadata_sha256": compute_hashes(TORREOSCURA_CHR_ATLAS_METADATA_PATH.read_bytes())["sha256"],
        },
        "native_validation": {
            "parser": "daad_harvester.chr_generation.render_adp_chr_glyph_atlas",
            "status": "derived_profile_validated",
            "validation": "validated_adp_legacy_chr_glyph_atlas",
            "evidence": {
                **atlas_evidence,
                "stored_output_matches_regeneration": stored_atlas == atlas,
                "stored_manifest_declares_source_sha256": metadata.get("source_sha256"),
                "stored_manifest_declares_derived_sha256": metadata.get("derived_sha256"),
            },
        },
        "comparison_boundary": {
            "authentic_release": "derived_from_retained_original_chr_bytes_not_a_reconstructed_historical_source",
            "character_mapping": "byte_index_only_no_code_page_claim",
            "runtime_bundle": "not_established",
            "web_tui_preview": "publication_pending",
        },
    }


def generated_fixtures_evidence() -> list[dict[str, object]]:
    """Return canonical evidence in stable generator-ID order."""

    return [
        generated_fixture_evidence(),
        generated_blank_adf_ofs_fixture_evidence(),
        generated_standard_tzx_fixture_evidence(),
        retained_torreoscura_chr_atlas_evidence(),
    ]


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
    _verify_record(evidence[2], STANDARD_TZX_SHA256, "validated_tzx_v1_block_stream")
    _verify_record(evidence[3], TORREOSCURA_CHR_ATLAS_SHA256, "validated_adp_legacy_chr_glyph_atlas")
    atlas_validation = evidence[3]["native_validation"]
    assert isinstance(atlas_validation, dict)
    atlas_details = atlas_validation["evidence"]
    assert isinstance(atlas_details, dict)
    if evidence[3]["inputs"]["source_sha256"] != TORREOSCURA_CHR_SHA256:
        raise RuntimeError("Torreoscura CHR source digest differs from the pinned retained input")
    if not atlas_details["stored_output_matches_regeneration"]:
        raise RuntimeError("Torreoscura CHR atlas differs from deterministic regeneration")
    if atlas_details["stored_manifest_declares_source_sha256"] != TORREOSCURA_CHR_SHA256:
        raise RuntimeError("Torreoscura CHR atlas manifest has an unexpected source digest")
    if atlas_details["stored_manifest_declares_derived_sha256"] != TORREOSCURA_CHR_ATLAS_SHA256:
        raise RuntimeError("Torreoscura CHR atlas manifest has an unexpected derived digest")
    return evidence
