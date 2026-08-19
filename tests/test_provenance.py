"""Regression tests for normalized all-platform provenance metadata."""

import json
from pathlib import Path

from daad_harvester.catalog import EvidenceCatalogExporter

import pytest

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.provenance import (
    CANONICAL_PLATFORMS,
    EvidenceConfidence,
    EvidenceKind,
    SourceRole,
    VersionEvidence,
    normalize_platform,
)


@pytest.mark.parametrize(
    ("alias", "expected"),
    [
        ("ZX Spectrum", "zx"),
        ("Amstrad CPC", "cpc"),
        ("CBM64", "c64"),
        ("Commodore Plus/4", "plus4"),
        ("C16", "plus4"),
        ("MSX2", "msx"),
        ("Amstrad PCW", "pcw"),
        ("Atari ST", "atarist"),
        ("Amiga", "amiga"),
        ("IBM PC DOS", "dos"),
        ("MS-DOS", "dos"),
    ],
)
def test_normalize_platform_aliases(alias: str, expected: str) -> None:
    assert normalize_platform(alias) == expected


def test_all_official_targets_have_canonical_identifiers() -> None:
    assert CANONICAL_PLATFORMS == (
        "zx", "cpc", "c64", "plus4", "msx", "pcw", "atarist", "amiga", "dos",
    )


def test_version_evidence_requires_exactly_one_subject() -> None:
    with pytest.raises(ValueError, match="linked"):
        VersionEvidence(
            kind=EvidenceKind.DDB_FORMAT.value,
            value="drc-v3",
            confidence=EvidenceConfidence.VERIFIED.value,
        )

    with pytest.raises(ValueError, match="cannot target"):
        VersionEvidence(
            kind=EvidenceKind.DDB_FORMAT.value,
            value="drc-v3",
            confidence=EvidenceConfidence.VERIFIED.value,
            source_id=1,
            artifact_id=1,
        )


def _artifact(source_id: int, path: Path) -> ArtifactRecord:
    return ArtifactRecord(
        id=None,
        source_id=source_id,
        original_filename="daad.ddb",
        extracted_path=str(path),
        archive_depth=1,
        file_size=128,
        md5_full="a" * 32,
        md5_5000="b" * 32,
        sha256="c" * 64,
    )


def test_database_persists_source_and_artifact_provenance(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source(
        url="https://example.invalid/barron-wood.zip",
        source_tier="archive",
        title="The Secret of Barron Wood",
        platform="IBM PC DOS",
        source_name="Publisher download",
        source_role=SourceRole.GAME_MEDIA.value,
        source_record_url="https://example.invalid/barron-wood",
        source_release_id="barron-wood-1.08",
        release_version="1.08",
        toolchain_claim="DAAD Ready A1",
        provenance_json='{"publisher_page": true}',
    )
    assert source_id is not None

    source = db.get_all_sources()[0]
    assert source.platform == "dos"
    assert source.source_role == SourceRole.GAME_MEDIA.value
    assert source.release_version == "1.08"
    assert source.toolchain_claim == "DAAD Ready A1"

    db.add_version_evidence(
        VersionEvidence(
            kind=EvidenceKind.RELEASE_VERSION.value,
            value="1.08",
            confidence=EvidenceConfidence.STRONG.value,
            source_url=source.source_record_url,
            source_id=source_id,
        )
    )
    assert [(item.kind, item.value) for item in db.get_version_evidence(source_id=source_id)] == [
        (EvidenceKind.RELEASE_VERSION.value, "1.08")
    ]

    artifact_id = db.add_artifact(_artifact(source_id, tmp_path / "daad.ddb"))
    db.update_artifact_fingerprint(
        artifact_id=artifact_id,
        is_daad_payload=True,
        daad_version_guess="DRC DAAD v3",
        platform_hint="pc",
        measured_platform="IBM PC DOS",
        ddb_format="drc-v3",
        ddb_major_version=3,
        ddb_encoding="8-bit",
        interpreter_identity="pcdaad-unknown-build",
        fingerprint_confidence=EvidenceConfidence.VERIFIED.value,
        fingerprint_evidence_json='{"header": "valid"}',
    )
    db.add_version_evidence(
        VersionEvidence(
            kind=EvidenceKind.DDB_FORMAT.value,
            value="drc-v3",
            confidence=EvidenceConfidence.VERIFIED.value,
            artifact_id=artifact_id,
        )
    )

    artifact = db.get_all_artifacts()[0]
    assert artifact.platform_hint == "dos"
    assert artifact.measured_platform == "dos"
    assert artifact.ddb_format == "drc-v3"
    assert artifact.ddb_major_version == 3
    assert artifact.interpreter_identity == "pcdaad-unknown-build"
    assert artifact.fingerprint_confidence == EvidenceConfidence.VERIFIED.value
    assert [(item.kind, item.value) for item in db.get_version_evidence(artifact_id=artifact_id)] == [
        (EvidenceKind.DDB_FORMAT.value, "drc-v3")
    ]


def test_catalog_export_keeps_claims_and_measurements_distinct(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source(
        "https://example.invalid/efu-dos.zip",
        "archive",
        title="Eight Feet Under",
        platform="DOS",
        source_role=SourceRole.GAME_MEDIA.value,
        release_version="R6",
        toolchain_claim="DAAD Adventure Writer",
    )
    assert source_id is not None
    db.add_version_evidence(
        VersionEvidence(
            kind=EvidenceKind.RELEASE_VERSION.value,
            value="R6",
            confidence=EvidenceConfidence.STRONG.value,
            source_id=source_id,
        )
    )
    payload = json.loads(EvidenceCatalogExporter(db, tmp_path).write().read_text(encoding="utf-8"))
    source = payload["sources"][0]
    assert payload["schema_version"] == 2
    assert source["platform"] == "dos"
    assert source["source_role"] == SourceRole.GAME_MEDIA.value
    assert source["release_version"] == "R6"
    assert source["toolchain_claim"] == "DAAD Adventure Writer"
    assert source["version_evidence"] == [
        {
            "kind": EvidenceKind.RELEASE_VERSION.value,
            "value": "R6",
            "confidence": EvidenceConfidence.STRONG.value,
            "source_url": None,
            "details_json": None,
            "observed_at": source["version_evidence"][0]["observed_at"],
        }
    ]
    assert "ddb_format" in payload["version_policy"]


def test_version_evidence_is_idempotent(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.invalid/game.tap", "archive")
    assert source_id is not None
    evidence = VersionEvidence(
        kind=EvidenceKind.DAAD_FAMILY.value,
        value="DAAD",
        confidence=EvidenceConfidence.STRONG.value,
        source_id=source_id,
    )
    assert db.add_version_evidence(evidence) == db.add_version_evidence(evidence)
    assert len(db.get_version_evidence(source_id=source_id)) == 1
