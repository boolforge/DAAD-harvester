"""Integration tests for structural DDB and interpreter-aware fingerprinting."""

from __future__ import annotations

from hashlib import md5, sha256
from pathlib import Path

import pytest

from daad_harvester.db import Database
from daad_harvester.fingerprint import Fingerprinter
from daad_harvester.interpreter_profiles import InterpreterProfile, identify_interpreter_file
from daad_harvester.models import ArtifactRecord
from daad_harvester.provenance import EvidenceKind
from tests.ddb_fixtures import make_ddb


PLATFORMS = ("zx", "cpc", "c64", "plus4", "msx", "pcw", "atarist", "amiga", "dos")


def _artifact(db: Database, path: Path, *, filename: str | None = None) -> ArtifactRecord:
    source_id = db.add_source(f"https://example.invalid/{path.name}", "fixture", platform=None)
    assert source_id is not None
    data = path.read_bytes()
    return ArtifactRecord(
        id=None,
        source_id=source_id,
        original_filename=filename or path.name,
        extracted_path=str(path),
        archive_depth=1,
        file_size=len(data),
        md5_full=md5(data).hexdigest(),
        md5_5000=md5(data[-5000:]).hexdigest(),
        sha256=sha256(data).hexdigest(),
    )


@pytest.mark.parametrize("platform", PLATFORMS)
def test_fingerprint_persists_verified_target_aware_measurement(tmp_path: Path, platform: str) -> None:
    db = Database(tmp_path / "state.db")
    payload_path = tmp_path / f"{platform}.ddb"
    payload_path.write_bytes(make_ddb(platform, major=3))
    artifact = _artifact(db, payload_path)
    artifact.id = db.add_artifact(artifact)

    assert Fingerprinter(db).scan_artifact(artifact) is True

    persisted = db.get_all_artifacts()[0]
    assert persisted.is_daad_payload is True
    assert persisted.measured_platform == platform
    assert persisted.ddb_format == "daad-v3"
    assert persisted.ddb_major_version == 3
    assert persisted.fingerprint_confidence == "verified"
    assert persisted.daad_version_guess == "DAAD DDB v3"
    kinds = {item.kind for item in db.get_version_evidence(artifact_id=artifact.id)}
    assert {EvidenceKind.DDB_FORMAT.value, EvidenceKind.PLATFORM_RELEASE.value} <= kinds


def test_fingerprint_correlates_neighbouring_interpreter_filename_without_overclaiming_exact_hash(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    payload_path = tmp_path / "adventure.ddb"
    payload_path.write_bytes(make_ddb("cpc"))
    # A repacked/modified runtime retains useful strong bundle evidence but is
    # not falsely called an exact official binary without its known SHA-256.
    (tmp_path / "DCPCIE.Z80").write_bytes(b"modified interpreter")
    artifact = _artifact(db, payload_path)
    artifact.id = db.add_artifact(artifact)

    assert Fingerprinter(db).scan_artifact(artifact) is True
    persisted = db.get_all_artifacts()[0]
    assert persisted.interpreter_identity == "daad-cpc-dcpcie-official"
    assert persisted.interpreter_version is None
    evidence = db.get_version_evidence(artifact_id=artifact.id)
    interpreter = next(item for item in evidence if item.kind == EvidenceKind.INTERPRETER_IDENTITY.value)
    assert interpreter.confidence == "strong"


def test_fingerprint_uses_persisted_original_name_for_prefixed_neighbour_runtime(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    payload_path = tmp_path / "depth2_payload_adventure.ddb"
    payload_path.write_bytes(make_ddb("cpc"))
    runtime_path = tmp_path / "depth2_7447b560_DCPCIE.Z80"
    runtime_path.write_bytes(b"modified interpreter")
    artifact = _artifact(db, payload_path, filename="ADVENTURE.DDB")
    artifact.id = db.add_artifact(artifact)
    runtime_artifact = _artifact(db, runtime_path, filename="DCPCIE.Z80")
    runtime_artifact.id = db.add_artifact(runtime_artifact)

    assert Fingerprinter(db).scan_artifact(artifact) is True
    persisted = next(item for item in db.get_all_artifacts() if item.id == artifact.id)
    assert persisted.interpreter_identity == "daad-cpc-dcpcie-official"
    assert persisted.fingerprint_confidence == "verified"


def test_historical_plus4_runtime_name_is_qualified_interpreter_evidence_only(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    runtime_path = tmp_path / "depth2_a4aff539_EDIPLUS4"
    runtime_path.write_bytes(b"historical plus4 runtime")
    artifact = _artifact(db, runtime_path, filename="EDIPLUS4")
    artifact.id = db.add_artifact(artifact)

    assert Fingerprinter(db).scan_artifact(artifact) is False
    persisted = db.get_all_artifacts()[0]
    assert persisted.is_daad_payload is False
    assert persisted.interpreter_identity == "daad-plus4-ediplus4-historical"
    assert persisted.fingerprint_confidence == "strong"
    evidence = db.get_version_evidence(artifact_id=artifact.id)
    assert evidence[0].kind == EvidenceKind.INTERPRETER_IDENTITY.value
    assert evidence[0].confidence == "strong"


def test_exact_runtime_profile_records_platform_hint_without_measured_ddb_platform(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch,
) -> None:
    import daad_harvester.interpreter_profiles as profiles

    runtime_path = tmp_path / "stored_pcw_runtime"
    runtime_path.write_bytes(b"exact official pcw runtime")
    digest = sha256(runtime_path.read_bytes()).hexdigest()
    monkeypatch.setattr(
        profiles,
        "OFFICIAL_INTERPRETER_PROFILES",
        (InterpreterProfile("official-pcw", "pcw", ("pcwedi.bin",), digest),),
    )
    db = Database(tmp_path / "state.db")
    artifact = _artifact(db, runtime_path, filename="PCWEDI.BIN")
    artifact.id = db.add_artifact(artifact)

    assert Fingerprinter(db).scan_artifact(artifact) is False

    persisted = db.get_all_artifacts()[0]
    assert persisted.interpreter_identity == "official-pcw"
    assert persisted.platform_hint == "pcw"
    assert persisted.measured_platform is None
    assert persisted.is_daad_payload is False


def test_interpreter_alias_upgrades_only_on_same_platform_official_hash(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    import daad_harvester.interpreter_profiles as profiles

    runtime_path = tmp_path / "stored_member"
    runtime_path.write_bytes(b"verified historical alias")
    digest = sha256(runtime_path.read_bytes()).hexdigest()
    monkeypatch.setattr(
        profiles,
        "OFFICIAL_INTERPRETER_PROFILES",
        (
            InterpreterProfile("official-plus4", "plus4", ("ediplus4.prg",), digest),
            InterpreterProfile("historical-plus4-alias", "plus4", ("ediplus4",)),
            InterpreterProfile("unrelated-zx", "zx", ("ediplus4",), digest),
        ),
    )

    match = identify_interpreter_file(runtime_path, observed_filename="EDIPLUS4")
    assert match is not None
    assert match.profile_id == "official-plus4"
    assert match.confidence == "verified"


def test_interpreter_exact_hash_identifies_documented_filename_alias(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    import daad_harvester.interpreter_profiles as profiles

    runtime_path = tmp_path / "DAAD.Z80"
    runtime_path.write_bytes(b"official msx package alias")
    digest = sha256(runtime_path.read_bytes()).hexdigest()
    monkeypatch.setattr(
        profiles,
        "OFFICIAL_INTERPRETER_PROFILES",
        (InterpreterProfile("official-msx", "msx", ("msxedi.z80",), digest),),
    )

    match = identify_interpreter_file(runtime_path, observed_filename="DAAD.Z80")

    assert match is not None
    assert match.profile_id == "official-msx"
    assert match.confidence == "verified"


def test_non_ddb_does_not_inherit_unrelated_sibling_interpreter(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    import daad_harvester.interpreter_profiles as profiles

    db = Database(tmp_path / "state.db")
    disk_path = tmp_path / "MSX.DSK"
    disk_path.write_bytes(b"not a ddb or interpreter")
    sibling_path = tmp_path / "EDI1.PRG"
    sibling_path.write_bytes(b"unrelated atari runtime")
    digest = sha256(sibling_path.read_bytes()).hexdigest()
    monkeypatch.setattr(
        profiles,
        "OFFICIAL_INTERPRETER_PROFILES",
        (InterpreterProfile("official-atarist", "atarist", ("edi1.prg",), digest),),
    )
    disk = _artifact(db, disk_path, filename="MSX.DSK")
    disk.id = db.add_artifact(disk)
    sibling = _artifact(db, sibling_path, filename="EDI1.PRG")
    sibling.id = db.add_artifact(sibling)

    assert Fingerprinter(db).scan_artifact(disk) is False

    persisted = next(item for item in db.get_all_artifacts() if item.id == disk.id)
    assert persisted.interpreter_identity is None
    assert db.get_version_evidence(artifact_id=disk.id) == []


def test_fingerprint_finds_embedded_structural_ddb(tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    path = tmp_path / "disk_member.bin"
    path.write_bytes(b"boot sector" * 7 + make_ddb("amiga", major=2) + b"trailer")
    artifact = _artifact(db, path, filename="game.adf")
    artifact.id = db.add_artifact(artifact)

    assert Fingerprinter(db).scan_artifact(artifact) is True
    persisted = db.get_all_artifacts()[0]
    assert persisted.measured_platform == "amiga"
    assert '"embedded_offset"' in (persisted.fingerprint_evidence_json or "")


@pytest.mark.parametrize(
    ("name", "payload"),
    [
        ("paws.dat", b"PAWS Engine Database"),
        ("gac.dat", b"Graphic Adventure Creator"),
        ("index.php", b"<?php echo 'not daad'; ?>"),
        ("renpy.data", b"RENPY archive data"),
    ],
)
def test_fingerprint_rejects_other_formats(tmp_path: Path, name: str, payload: bytes) -> None:
    db = Database(tmp_path / "state.db")
    path = tmp_path / name
    path.write_bytes(payload + b"\x00" * 500)
    artifact = _artifact(db, path)
    artifact.id = db.add_artifact(artifact)
    assert Fingerprinter(db).scan_artifact(artifact) is False
    assert db.get_all_artifacts()[0].is_daad_payload is False


def test_interpreter_profile_exact_hash_is_marked_verified(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    import daad_harvester.interpreter_profiles as profiles

    path = tmp_path / "INTE1.EXE"
    path.write_bytes(b"official fixture binary")
    digest = sha256(path.read_bytes()).hexdigest()
    monkeypatch.setattr(
        profiles,
        "OFFICIAL_INTERPRETER_PROFILES",
        (InterpreterProfile("fixture-dos-runtime", "dos", ("inte1.exe",), digest, "fixture-1.0"),),
    )
    match = identify_interpreter_file(path)
    assert match is not None
    assert match.confidence == "verified"
    assert match.profile_id == "fixture-dos-runtime"
    assert match.interpreter_version == "fixture-1.0"


def test_official_profile_catalog_has_exact_anchors_for_all_platforms() -> None:
    from daad_harvester.interpreter_profiles import OFFICIAL_INTERPRETER_PROFILES

    platforms = {profile.platform for profile in OFFICIAL_INTERPRETER_PROFILES if profile.sha256}
    assert platforms == set(PLATFORMS)
    assert all(len(profile.sha256 or "") == 64 for profile in OFFICIAL_INTERPRETER_PROFILES if profile.sha256)
