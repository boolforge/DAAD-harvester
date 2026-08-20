import json
from pathlib import Path

from daad_harvester.db import Database
from daad_harvester.library import LibraryBuilder
from daad_harvester.models import ArtifactRecord


def _add_artifact(db, source_id, path, filename, *, is_daad=False, platform_hint=None, sha256=None):
    data = path.read_bytes() if path.exists() else b""
    return db.add_artifact(
        ArtifactRecord(
            id=None,
            source_id=source_id,
            original_filename=filename,
            extracted_path=str(path),
            archive_depth=1,
            file_size=len(data),
            md5_full="a" * 32,
            md5_5000="b" * 32,
            sha256=sha256 or (("c" if filename.endswith(".dsk") else "d") * 64),
            is_daad_payload=is_daad,
            platform_hint=platform_hint,
        )
    )


def test_library_builder_classifies_and_materializes_artifacts(tmp_path):
    db = Database(tmp_path / "state.db")
    cpc_source = db.add_source(
        "https://example.com/chichen.dsk",
        "archive",
        title="Chichén Itzá",
        platform="cpc",
        known_game_id="chichen_itza",
        acquisition_priority=1200,
    )
    unknown_source = db.add_source("https://example.com/candidate.zip", "archive", title="Candidate")
    dsk = tmp_path / "CHICHEN.DSK"
    dsk.write_bytes(b"EXTENDED CPC DSK" + b"\x00" * 256)
    archive = tmp_path / "candidate.zip"
    archive.write_bytes(b"PK\x03\x04example")

    _add_artifact(db, cpc_source, dsk, "79_CHICHEN.DSK", is_daad=True, platform_hint="unknown")
    _add_artifact(db, unknown_source, archive, "candidate.zip")

    manifest_path = LibraryBuilder(db, tmp_path).build()
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    ready, container = manifest["artifacts"]

    assert manifest["summary"] == {"archive": 1, "ready_to_use": 1}
    assert ready["game_id"] == "chichen_itza"
    assert ready["classification"] == "ready_to_use"
    assert ready["ready_to_use"] is True
    assert ready["binary_verified_daad"] is True
    assert ready["platform"] == "cpc"
    assert ready["library_path"] == "library/CPC/chichen_itza/ready_to_use/CHICHEN.DSK"
    assert (tmp_path / ready["library_path"]).read_bytes() == dsk.read_bytes()
    assert container["classification"] == "archive"
    assert container["ready_to_use"] is False
    assert (tmp_path / container["library_path"]).exists()


def test_library_builder_records_missing_artifacts_without_creating_a_false_library_file(tmp_path):
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.com/missing.tap", "archive", platform="zx")
    missing = tmp_path / "not-present.tap"
    _add_artifact(db, source_id, missing, "MISSING.TAP")

    manifest = json.loads(LibraryBuilder(db, tmp_path).build().read_text(encoding="utf-8"))
    entry = manifest["artifacts"][0]

    assert entry["classification"] == "ready_to_use"
    assert entry["materialization"] == "missing_source_file"
    assert not (tmp_path / entry["library_path"]).exists()


def test_library_builder_retains_duplicate_member_names_as_distinct_paths(tmp_path):
    db = Database(tmp_path / "state.db")
    source_id = db.add_source(
        "https://example.com/chichen.tap", "archive", title="Chichén Itzá", platform="zx", known_game_id="chichen_itza"
    )
    part1, part2 = tmp_path / "part1.ddb", tmp_path / "part2.ddb"
    part1.write_bytes(b"part-one")
    part2.write_bytes(b"part-two")
    _add_artifact(db, source_id, part1, "CODE__embedded_002400.ddb", is_daad=True, platform_hint="zx", sha256="d" * 64)
    _add_artifact(db, source_id, part2, "CODE__embedded_002400.ddb", is_daad=True, platform_hint="zx", sha256="e" * 64)

    manifest = json.loads(LibraryBuilder(db, tmp_path).build().read_text(encoding="utf-8"))
    entries = manifest["artifacts"]
    assert len({entry["library_path"] for entry in entries}) == 2
    assert any("__artifact_" in entry["library_path"] for entry in entries)
    assert {Path(tmp_path / entry["library_path"]).read_bytes() for entry in entries} == {b"part-one", b"part-two"}


def test_library_builder_places_verified_ddb_in_ready_to_use(tmp_path):
    db = Database(tmp_path / "state.db")
    source_id = db.add_source(
        "https://example.com/jabato.tap", "archive", title="Jabato", platform="c64", known_game_id="jabato"
    )
    ddb = tmp_path / "jabato_part2.ddb"
    ddb.write_bytes(b"verified-daad-database")
    _add_artifact(db, source_id, ddb, "jabato_part2.ddb", is_daad=True, platform_hint="c64")

    manifest = json.loads(LibraryBuilder(db, tmp_path).build().read_text(encoding="utf-8"))
    entry = manifest["artifacts"][0]

    assert entry["classification"] == "ready_to_use"
    assert entry["ready_to_use"] is True
    assert entry["library_path"] == "library/C64/jabato/ready_to_use/jabato_part2.ddb"
