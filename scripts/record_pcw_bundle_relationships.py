#!/usr/bin/env python3
"""Record bounded PCW DDB companion co-residency from retained DSK bytes.

The command is profile-scoped to source 253's Torreoscura PCW disks.  It uses the
native CPC/CP/M DSK extractor, matches members by exact SHA-256, and records only
same-disk membership plus the observed filename-stem convention.  It does not
claim an internal DDB reference, runtime load behavior, or cross-platform link.

    python scripts/record_pcw_bundle_relationships.py --write
    python scripts/record_pcw_bundle_relationships.py --check
"""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from tempfile import TemporaryDirectory

from daad_harvester.artifact_paths import resolve_retained_artifact_path
from daad_harvester.bundle_relationships import DiskMember, validate_pcw_same_disk_companions
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.unpack import Unpacker


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DB = ROOT / "preservation_corpus" / "state.db"
DEFAULT_OUTPUT = ROOT / "preservation_corpus" / "derived" / "pcw_bundle" / "torreoscura_same_disk_relationships.json"
TORREOSCURA_SOURCE_ID = 253


def _extract_members(db: Database, disk_path: Path) -> list[DiskMember]:
    """Run the existing native DSK extraction without retaining temporary files."""

    with TemporaryDirectory(prefix="daad-pcw-bundle-") as temporary_directory:
        unpacker = Unpacker(db, extract_dir=Path(temporary_directory))
        return [DiskMember(name, data) for name, data in unpacker.unpack_dsk(disk_path.read_bytes())]


def _artifact_by_identity(
    artifacts: list[ArtifactRecord], source_id: int, filename: str, sha256: str
) -> ArtifactRecord | None:
    return next(
        (
            artifact
            for artifact in artifacts
            if artifact.source_id == source_id
            and artifact.original_filename.upper() == filename.upper()
            and artifact.sha256 == sha256
        ),
        None,
    )


def build_relationships(db: Database, source_id: int = TORREOSCURA_SOURCE_ID) -> list[dict[str, object]]:
    """Re-extract every retained PCW DSK and return only evidenced DDB relations."""

    artifacts = db.get_all_artifacts()
    source_artifacts = [artifact for artifact in artifacts if artifact.source_id == source_id]
    relationships: list[dict[str, object]] = []
    disks = sorted(
        (
            artifact
            for artifact in source_artifacts
            if artifact.original_filename.upper() in {"TO.DSK", "TO2.DSK"}
        ),
        key=lambda artifact: artifact.original_filename.upper(),
    )
    if len(disks) != 2:
        raise ValueError("Torreoscura source does not retain both expected PCW disk artifacts")

    for disk in disks:
        disk_path = resolve_retained_artifact_path(disk.extracted_path, ROOT)
        members = _extract_members(db, disk_path)
        if not members:
            raise ValueError(f"native DSK extraction did not recover PCW members: {disk.original_filename}")
        member_names = {member.name.upper() for member in members}
        ddb_members = sorted(name for name in member_names if name.endswith(".DDB"))
        if len(ddb_members) != 1:
            raise ValueError(f"expected exactly one DDB in {disk.original_filename}, found {ddb_members!r}")
        ddb_name = ddb_members[0]
        ddb_member = next(member for member in members if member.name.upper() == ddb_name)
        ddb_artifact = _artifact_by_identity(source_artifacts, source_id, ddb_name, ddb_member.sha256)
        if ddb_artifact is None:
            raise ValueError(f"no retained DDB matches native disk member {ddb_name}")
        relationships.append(
            validate_pcw_same_disk_companions(
                source_id=source_id,
                disk_artifact=disk,
                ddb_artifact=ddb_artifact,
                disk_members=members,
                source_artifacts=source_artifacts,
            )
        )
    return relationships


def build_output(db: Database, source_id: int = TORREOSCURA_SOURCE_ID) -> dict[str, object]:
    relationships = build_relationships(db, source_id)
    return {
        "schema_version": 1,
        "purpose": "PCW same-disk DDB companion relationship evidence; no runtime or semantic relation is inferred.",
        "source_id": source_id,
        "relationship_count": len(relationships),
        "relationships": relationships,
    }


def _expected_text(db: Database, source_id: int) -> str:
    return json.dumps(build_output(db, source_id), indent=2, sort_keys=True) + "\n"


def _persist_artifact_evidence(db: Database, output: dict[str, object]) -> None:
    for relationship in output["relationships"]:
        if not isinstance(relationship, dict):
            raise ValueError("invalid relationship output")
        ddb = relationship.get("ddb")
        if not isinstance(ddb, dict) or not isinstance(ddb.get("artifact_id"), int):
            raise ValueError("relationship output lacks a DDB artifact identity")
        evidence = json.dumps(relationship, sort_keys=True)
        db.update_artifact_bundle_relationship(ddb["artifact_id"], evidence)


def _database_is_current(db: Database, output: dict[str, object]) -> bool:
    by_id = {artifact.id: artifact for artifact in db.get_all_artifacts()}
    for relationship in output["relationships"]:
        ddb = relationship["ddb"]
        assert isinstance(ddb, dict)
        artifact = by_id.get(ddb["artifact_id"])
        if artifact is None or artifact.bundle_relationship_json != json.dumps(relationship, sort_keys=True):
            return False
    return True


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true", help="persist evidence and write the derived relationship record")
    parser.add_argument("--check", action="store_true", help="verify output and persisted evidence against retained DSK bytes")
    parser.add_argument("--db", type=Path, default=DEFAULT_DB)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--source-id", type=int, default=TORREOSCURA_SOURCE_ID)
    args = parser.parse_args(argv)
    if args.write == args.check:
        parser.error("select exactly one of --write or --check")

    db = Database(args.db)
    expected = _expected_text(db, args.source_id)
    output = json.loads(expected)
    if args.write:
        _persist_artifact_evidence(db, output)
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(expected, encoding="utf-8")
        print(
            "PCW bundle relationships recorded: "
            f"{output['relationship_count']} DDB records, "
            f"output SHA-256 {hashlib.sha256(expected.encode('utf-8')).hexdigest()}, "
            f"database SHA-256 {hashlib.sha256(args.db.read_bytes()).hexdigest()}."
        )
        return 0

    if not args.output.is_file() or args.output.read_text(encoding="utf-8") != expected:
        print("PCW bundle relationship output is stale; run with --write", file=sys.stderr)
        return 1
    if not _database_is_current(db, output):
        print("PCW bundle relationship evidence is stale in the artifact database; run with --write", file=sys.stderr)
        return 1
    print(f"PCW bundle relationships verified: {output['relationship_count']} DDB records.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
