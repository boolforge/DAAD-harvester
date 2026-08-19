import pytest
import sqlite3
from pathlib import Path
from daad_harvester.db import Database
from daad_harvester.models import SourceRecord, ArtifactRecord, GameRecord, SourceStatus, Platform

def test_db_init_and_tables(tmp_path):
    db_file = tmp_path / "test.db"
    db = Database(db_file)
    assert db_file.exists()

    with db.get_connection() as conn:
        cursor = conn.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = [row["name"] for row in cursor.fetchall()]
        assert "sources" in tables
        assert "artifacts" in tables
        assert "games" in tables


def test_database_migrates_legacy_sources_before_creating_new_indexes(tmp_path: Path):
    legacy_path = tmp_path / "legacy.db"
    with sqlite3.connect(legacy_path) as connection:
        connection.execute("CREATE TABLE sources (id INTEGER PRIMARY KEY, url TEXT, status TEXT, discovered_at TIMESTAMP)")
        connection.execute("CREATE TABLE artifacts (id INTEGER PRIMARY KEY, source_id INTEGER, sha256 TEXT, md5_full TEXT, is_daad_payload BOOLEAN)")
        connection.execute("CREATE TABLE games (id INTEGER PRIMARY KEY, game_id TEXT)")
    Database(legacy_path)
    with sqlite3.connect(legacy_path) as connection:
        source_columns = {row[1] for row in connection.execute("PRAGMA table_info(sources)")}
        indexes = {row[1] for row in connection.execute("PRAGMA index_list(sources)")}
    assert "source_role" in source_columns
    assert "idx_sources_role" in indexes

def test_sources_crud(tmp_path):
    db = Database(tmp_path / "test.db")

    # Add source
    src_id1 = db.add_source("https://example.com/game1.zip", "archive")
    assert src_id1 is not None

    # Deduplication check
    src_id1_dup = db.add_source("https://example.com/game1.zip", "archive")
    assert src_id1_dup == src_id1

    # Add second source
    src_id2 = db.add_source("https://example.com/game2.dsk", "archive")
    assert src_id2 != src_id1

    # Pending sources
    pending = db.get_pending_sources()
    assert len(pending) == 2

    # Update source status
    db.update_source_status(src_id1, status=SourceStatus.DOWNLOADED.value, http_status=200, content_type="application/zip", local_path="/tmp/game1.zip")

    pending_after = db.get_pending_sources()
    assert len(pending_after) == 1
    assert pending_after[0].id == src_id2

    all_sources = db.get_all_sources()
    assert len(all_sources) == 2
    s1 = next(s for s in all_sources if s.id == src_id1)
    assert s1.status == SourceStatus.DOWNLOADED.value
    assert s1.local_path == "/tmp/game1.zip"

def test_artifacts_and_games_crud(tmp_path):
    db = Database(tmp_path / "test.db")
    src_id = db.add_source("https://example.com/archive.zip", "archive")

    art = ArtifactRecord(
        id=None,
        source_id=src_id,
        original_filename="game.ddb",
        extracted_path="/tmp/extracted/game.ddb",
        archive_depth=1,
        file_size=1024,
        md5_full="md5full123",
        md5_5000="md55000123",
        sha256="sha256123",
        is_daad_payload=False
    )

    art_id = db.add_artifact(art)
    assert art_id is not None

    artifacts = db.get_all_artifacts()
    assert len(artifacts) == 1
    assert artifacts[0].original_filename == "game.ddb"
    assert artifacts[0].is_daad_payload is False

    # Update fingerprint
    db.update_artifact_fingerprint(art_id, is_daad_payload=True, daad_version_guess="DAAD v2.0", platform_hint=Platform.ZX.value)

    daad_artifacts = db.get_daad_artifacts()
    assert len(daad_artifacts) == 1
    assert daad_artifacts[0].is_daad_payload is True
    assert daad_artifacts[0].platform_hint == Platform.ZX.value

    # Add game record
    game = GameRecord(
        id=None,
        artifact_id=art_id,
        game_id="daad_test_game",
        title="Test Game",
        platform=Platform.ZX.value,
        language="es",
        year=1989,
        publisher="Aventuras AD",
        author="Tim Gilberts",
        detection_entry="ENTRY"
    )
    game_id = db.add_game(game)
    assert game_id is not None

    games = db.get_all_games()
    assert len(games) == 1
    assert games[0].game_id == "daad_test_game"
    assert games[0].publisher == "Aventuras AD"
