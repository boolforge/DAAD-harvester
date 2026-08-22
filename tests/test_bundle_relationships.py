from __future__ import annotations

from hashlib import sha256

import pytest

from daad_harvester.bundle_relationships import (
    DiskMember,
    PCW_PROFILE,
    validate_pcw_same_disk_companions,
)
from daad_harvester.models import ArtifactRecord


def artifact(
    artifact_id: int,
    filename: str,
    data: bytes,
    *,
    media_parser: str | None = None,
    media_validation: str | None = None,
    is_daad_payload: bool = False,
    measured_platform: str | None = None,
    ddb_format: str | None = None,
) -> ArtifactRecord:
    return ArtifactRecord(
        id=artifact_id,
        source_id=253,
        original_filename=filename,
        extracted_path=f"preservation_corpus/extracted/{filename}",
        archive_depth=2,
        file_size=len(data),
        md5_full="0" * 32,
        md5_5000="0" * 32,
        sha256=sha256(data).hexdigest(),
        media_parser=media_parser,
        media_validation=media_validation,
        is_daad_payload=is_daad_payload,
        measured_platform=measured_platform,
        ddb_format=ddb_format,
    )


def validated_part_one() -> tuple[ArtifactRecord, ArtifactRecord, list[DiskMember], list[ArtifactRecord]]:
    ddb_data = b"part-one-ddb"
    chr_data = b"part-one-chr"
    dat_data = b"part-one-dat"
    disk = artifact(1307, "TO.DSK", b"to-disk")
    ddb = artifact(
        1311,
        "PARTE001.DDB",
        ddb_data,
        is_daad_payload=True,
        measured_platform="pcw",
        ddb_format="daad-v2-legacy",
    )
    chr_artifact = artifact(
        1309,
        "PARTE001.CHR",
        chr_data,
        media_parser="daad-legacy-chr",
        media_validation="validated_legacy_chr_container",
    )
    dat_artifact = artifact(
        1310,
        "PARTE001.DAT",
        dat_data,
        media_parser="daad-pcw-dat-v1",
        media_validation="validated_pcw_v1_resource_directory",
    )
    return (
        disk,
        ddb,
        [
            DiskMember("PARTE001.DDB", ddb_data),
            DiskMember("PARTE001.CHR", chr_data),
            DiskMember("PARTE001.DAT", dat_data),
        ],
        [ddb, chr_artifact, dat_artifact],
    )


def test_validated_pcw_disk_relationship_records_only_measured_co_residency() -> None:
    disk, ddb, members, artifacts = validated_part_one()

    evidence = validate_pcw_same_disk_companions(
        source_id=253,
        disk_artifact=disk,
        ddb_artifact=ddb,
        disk_members=members,
        source_artifacts=artifacts,
    )

    assert evidence["profile"] == PCW_PROFILE
    assert evidence["relationship_state"] == "validated_same_disk_stem_companions"
    assert evidence["disk"]["filename"] == "TO.DSK"
    assert [companion["filename"] for companion in evidence["companions"]] == [
        "PARTE001.CHR",
        "PARTE001.DAT",
    ]
    assert all(
        companion["relationship_state"] == "measured_same_disk_membership"
        for companion in evidence["companions"]
    )
    assert "DDB-internal reference" in evidence["non_claims"][0]


def test_validator_rejects_missing_same_disk_dat_companion() -> None:
    disk, ddb, members, artifacts = validated_part_one()

    with pytest.raises(ValueError, match="required same-disk companion is absent: PARTE001.DAT"):
        validate_pcw_same_disk_companions(
            source_id=253,
            disk_artifact=disk,
            ddb_artifact=ddb,
            disk_members=members[:-1],
            source_artifacts=artifacts,
        )


def test_validator_rejects_cross_disk_ddb_membership() -> None:
    disk, ddb, members, artifacts = validated_part_one()

    with pytest.raises(ValueError, match="DDB is absent from the selected disk: PARTE001.DDB"):
        validate_pcw_same_disk_companions(
            source_id=253,
            disk_artifact=disk,
            ddb_artifact=ddb,
            disk_members=[
                DiskMember("PARTE002.DDB", b"part-two-ddb"),
                DiskMember("PARTE002.CHR", b"part-two-chr"),
                DiskMember("PARTE002.DAT", b"part-two-dat"),
            ],
            source_artifacts=artifacts,
        )


def test_validator_rejects_unvalidated_companion_profile() -> None:
    disk, ddb, members, artifacts = validated_part_one()
    artifacts[-1].media_parser = "none"

    with pytest.raises(ValueError, match="does not carry the required daad-pcw-dat-v1 native evidence"):
        validate_pcw_same_disk_companions(
            source_id=253,
            disk_artifact=disk,
            ddb_artifact=ddb,
            disk_members=members,
            source_artifacts=artifacts,
        )
