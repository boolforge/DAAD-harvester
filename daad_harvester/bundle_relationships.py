"""Profile-scoped bundle-relationship evidence.

This module records measured membership in one retained technical medium.  It does
not infer a runtime load, DDB pointer, semantic equivalence, or relation across
platforms merely because names or extensions coincide.
"""

from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
from typing import Iterable

from daad_harvester.models import ArtifactRecord


PCW_PROFILE = "pcw_cpm_cpc_system_same_disk_stem_companion_v1"
PCW_CHR_PROFILE = "daad-legacy-chr"
PCW_DAT_PROFILE = "daad-pcw-dat-v1"


@dataclass(frozen=True)
class DiskMember:
    """One filename and exact byte identity re-extracted from a validated DSK."""

    name: str
    data: bytes

    @property
    def sha256(self) -> str:
        return sha256(self.data).hexdigest()


def _canonical_member_name(value: str) -> str:
    normalized = value.upper()
    if not normalized or normalized != value.upper() or "/" in normalized or "\\" in normalized:
        raise ValueError("invalid disk member name")
    return normalized


def _member_index(members: Iterable[DiskMember]) -> dict[str, DiskMember]:
    index: dict[str, DiskMember] = {}
    for member in members:
        name = _canonical_member_name(member.name)
        if name in index:
            raise ValueError(f"duplicate disk member name: {name}")
        index[name] = member
    return index


def _artifact_index(artifacts: Iterable[ArtifactRecord], source_id: int) -> dict[tuple[str, str], ArtifactRecord]:
    index: dict[tuple[str, str], ArtifactRecord] = {}
    for artifact in artifacts:
        if artifact.source_id != source_id:
            continue
        key = (_canonical_member_name(artifact.original_filename), artifact.sha256)
        if key in index:
            raise ValueError(f"duplicate retained artifact identity for {key[0]}")
        index[key] = artifact
    return index


def _companion_record(
    member: DiskMember,
    artifact: ArtifactRecord,
    *,
    role: str,
    expected_parser: str,
    expected_validation: str,
) -> dict[str, object]:
    if artifact.media_parser != expected_parser or artifact.media_validation != expected_validation:
        raise ValueError(
            f"{member.name} does not carry the required {expected_parser} native evidence"
        )
    return {
        "artifact_id": artifact.id,
        "filename": member.name,
        "role": role,
        "sha256": member.sha256,
        "native_parser": artifact.media_parser,
        "native_validation": artifact.media_validation,
        "relationship_state": "measured_same_disk_membership",
    }


def validate_pcw_same_disk_companions(
    *,
    source_id: int,
    disk_artifact: ArtifactRecord,
    ddb_artifact: ArtifactRecord,
    disk_members: Iterable[DiskMember],
    source_artifacts: Iterable[ArtifactRecord],
) -> dict[str, object]:
    """Validate a PCW DDB's same-disk CHR/DAT neighbors by exact re-extraction.

    The native DSK extractor establishes the only membership predicate.  The
    matching stem is a bounded bundle-association convention for this observed
    profile; it is not treated as a DDB-internal pointer or runtime load proof.
    """

    if disk_artifact.source_id != source_id or ddb_artifact.source_id != source_id:
        raise ValueError("disk and DDB must belong to the requested source")
    if disk_artifact.original_filename.upper() not in {"TO.DSK", "TO2.DSK"}:
        raise ValueError("unsupported PCW disk identity")
    if not ddb_artifact.is_daad_payload or ddb_artifact.measured_platform != "pcw":
        raise ValueError("DDB lacks validated PCW structural evidence")
    ddb_name = _canonical_member_name(ddb_artifact.original_filename)
    if not ddb_name.endswith(".DDB"):
        raise ValueError("validated PCW DDB must use the observed .DDB member convention")

    members = _member_index(disk_members)
    artifacts = _artifact_index(source_artifacts, source_id)
    ddb_member = members.get(ddb_name)
    if ddb_member is None:
        raise ValueError(f"DDB is absent from the selected disk: {ddb_name}")
    if ddb_member.sha256 != ddb_artifact.sha256:
        raise ValueError(f"DDB bytes do not match the retained artifact: {ddb_name}")

    stem = ddb_name.removesuffix(".DDB")
    companion_specs = (
        (f"{stem}.CHR", "character_resource", PCW_CHR_PROFILE, "validated_legacy_chr_container"),
        (f"{stem}.DAT", "resource_table", PCW_DAT_PROFILE, "validated_pcw_v1_resource_directory"),
    )
    companions: list[dict[str, object]] = []
    for expected_name, role, parser, validation in companion_specs:
        member = members.get(expected_name)
        if member is None:
            raise ValueError(f"required same-disk companion is absent: {expected_name}")
        artifact = artifacts.get((expected_name, member.sha256))
        if artifact is None:
            raise ValueError(f"same-disk companion has no matching retained artifact: {expected_name}")
        companions.append(
            _companion_record(
                member,
                artifact,
                role=role,
                expected_parser=parser,
                expected_validation=validation,
            )
        )

    return {
        "schema_version": 1,
        "profile": PCW_PROFILE,
        "relationship_state": "validated_same_disk_stem_companions",
        "source_id": source_id,
        "disk": {
            "artifact_id": disk_artifact.id,
            "filename": _canonical_member_name(disk_artifact.original_filename),
            "sha256": disk_artifact.sha256,
            "membership_method": "native_cpc_dsk_cpm_extraction",
        },
        "ddb": {
            "artifact_id": ddb_artifact.id,
            "filename": ddb_name,
            "sha256": ddb_artifact.sha256,
            "measured_platform": ddb_artifact.measured_platform,
            "ddb_format": ddb_artifact.ddb_format,
        },
        "companions": companions,
        "non_claims": [
            "Same-disk membership and filename stem matching do not establish a DDB-internal reference.",
            "This record does not establish runtime load order, requiredness, or semantic equivalence.",
            "This PCW profile does not generalize to same-named members on another disk or platform.",
        ],
    }
