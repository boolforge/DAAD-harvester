"""SQLite state database interface for DAAD Harvester."""

import sqlite3
import structlog
from pathlib import Path
from typing import List, Optional, Dict
from datetime import datetime

from daad_harvester.models import SourceRecord, ArtifactRecord, GameRecord

logger = structlog.get_logger(__name__)

SCHEMA_SQL = """
CREATE TABLE IF NOT EXISTS sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    url TEXT UNIQUE,
    source_tier TEXT,
    status TEXT,
    http_status INTEGER,
    content_type TEXT,
    local_path TEXT,
    title TEXT,
    platform TEXT,
    year INTEGER,
    publisher TEXT,
    author TEXT,
    language TEXT,
    discovered_at TIMESTAMP,
    processed_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS artifacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source_id INTEGER,
    original_filename TEXT,
    extracted_path TEXT,
    archive_depth INTEGER,
    file_size INTEGER,
    md5_full TEXT,
    md5_5000 TEXT,
    sha256 TEXT,
    sha1 TEXT,
    crc32 TEXT,
    md5_tail5000 TEXT,
    sha224 TEXT,
    sha384 TEXT,
    sha512 TEXT,
    sha3_256 TEXT,
    sha3_512 TEXT,
    blake2b TEXT,
    blake2s TEXT,
    adler32 TEXT,
    xxh32 TEXT,
    xxh64 TEXT,
    xxh128 TEXT,
    unpacked BOOLEAN DEFAULT 0,
    is_daad_payload BOOLEAN DEFAULT 0,
    daad_version_guess TEXT,
    platform_hint TEXT,
    title TEXT,
    year INTEGER,
    publisher TEXT,
    author TEXT,
    language TEXT,
    FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE IF NOT EXISTS games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    artifact_id INTEGER,
    game_id TEXT,
    title TEXT,
    platform TEXT,
    language TEXT,
    year INTEGER,
    publisher TEXT,
    author TEXT,
    detection_entry TEXT,
    FOREIGN KEY (artifact_id) REFERENCES artifacts(id)
);

CREATE INDEX IF NOT EXISTS idx_sources_url ON sources(url);
CREATE INDEX IF NOT EXISTS idx_sources_status ON sources(status);
CREATE INDEX IF NOT EXISTS idx_artifacts_sha256 ON artifacts(sha256);
CREATE INDEX IF NOT EXISTS idx_artifacts_md5_full ON artifacts(md5_full);
CREATE INDEX IF NOT EXISTS idx_artifacts_is_daad ON artifacts(is_daad_payload);
CREATE INDEX IF NOT EXISTS idx_games_game_id ON games(game_id);
"""


class Database:
    def __init__(self, db_path: Path):
        self.db_path = db_path
        if self.db_path != Path(":memory:") and str(self.db_path) != ":memory:":
            self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self.init_db()

    def get_connection(self) -> sqlite3.Connection:
        conn = sqlite3.connect(self.db_path, timeout=30.0)
        conn.execute("PRAGMA foreign_keys = ON;")
        if self.db_path != Path(":memory:") and str(self.db_path) != ":memory:":
            conn.execute("PRAGMA journal_mode = WAL;")
            conn.execute("PRAGMA synchronous = NORMAL;")
            conn.execute("PRAGMA busy_timeout = 30000;")
        conn.row_factory = sqlite3.Row
        return conn

    def init_db(self) -> None:
        """Initialize database tables and run migrations if columns are missing."""
        with self.get_connection() as conn:
            conn.executescript(SCHEMA_SQL)
            cursor = conn.execute("PRAGMA table_info(artifacts)")
            cols = {row["name"] for row in cursor.fetchall()}
            extra_cols = [
                "sha1", "crc32", "md5_tail5000", "sha224", "sha384", "sha512",
                "sha3_256", "sha3_512", "blake2b", "blake2s", "adler32",
                "xxh32", "xxh64", "xxh128"
            ]
            for col in extra_cols:
                if col not in cols:
                    conn.execute(f"ALTER TABLE artifacts ADD COLUMN {col} TEXT;")

            if "unpacked" not in cols:
                conn.execute("ALTER TABLE artifacts ADD COLUMN unpacked BOOLEAN DEFAULT 0;")

            for col in ["title", "year", "publisher", "author", "language"]:
                if col not in cols:
                    conn.execute(f"ALTER TABLE artifacts ADD COLUMN {col} TEXT;")

            cursor_s = conn.execute("PRAGMA table_info(sources)")
            cols_s = {row["name"] for row in cursor_s.fetchall()}
            for col in ["title", "platform", "year", "publisher", "author", "language"]:
                if col not in cols_s:
                    conn.execute(f"ALTER TABLE sources ADD COLUMN {col} TEXT;")
            conn.commit()

    def backfill_and_rescan_session(self) -> Dict[str, int]:
        """
        Scans existing records for missing/incomplete fields due to software changes or interrupted runs.
        Resets failed sources for retry if local files exist, and ensures authentic data backfilling.
        """
        stats = {"reset_sources": 0, "backfilled_artifacts": 0, "cleared_stale_games": 0}
        with self.get_connection() as conn:
            # 1. Reset 'error' status for sources that actually have local files downloaded
            cursor = conn.execute("SELECT id, local_path FROM sources WHERE status = 'error' AND local_path IS NOT NULL")
            for row in cursor.fetchall():
                p = Path(row["local_path"])
                if p.exists() and p.stat().st_size > 0:
                    conn.execute("UPDATE sources SET status = 'downloaded' WHERE id = ?", (row["id"],))
                    stats["reset_sources"] += 1

            # 2. Re-link artifact metadata from source records if artifact metadata is missing
            conn.execute("""
                UPDATE artifacts
                SET title = COALESCE(artifacts.title, sources.title),
                    year = COALESCE(artifacts.year, sources.year),
                    publisher = COALESCE(artifacts.publisher, sources.publisher),
                    author = COALESCE(artifacts.author, sources.author),
                    language = COALESCE(artifacts.language, sources.language)
                FROM sources
                WHERE artifacts.source_id = sources.id
                  AND (artifacts.title IS NULL OR artifacts.year IS NULL OR artifacts.publisher IS NULL)
            """)

            # 3. Clear games table to ensure synthesized catalog is fresh during new pipeline run
            cursor_g = conn.execute("DELETE FROM games")
            stats["cleared_stale_games"] = cursor_g.rowcount

            conn.commit()

        logger.info("database_backfill_and_rescan_completed", **stats)
        return stats

    # --- Sources operations ---

    def add_source(
        self,
        url: str,
        source_tier: str,
        title: Optional[str] = None,
        platform: Optional[str] = None,
        year: Optional[int] = None,
        publisher: Optional[str] = None,
        author: Optional[str] = None,
        language: Optional[str] = None
    ) -> Optional[int]:
        now = datetime.now().isoformat()
        with self.get_connection() as conn:
            try:
                cursor = conn.execute(
                    """
                    INSERT INTO sources (
                        url, source_tier, status, title, platform, year, publisher, author, language, discovered_at
                    ) VALUES (?, ?, 'pending', ?, ?, ?, ?, ?, ?, ?)
                    """,
                    (url, source_tier, title, platform, year, publisher, author, language, now)
                )
                conn.commit()
                return cursor.lastrowid
            except sqlite3.IntegrityError:
                cursor = conn.execute("SELECT id FROM sources WHERE url = ?", (url,))
                row = cursor.fetchone()
                src_id = row["id"] if row else None
                if src_id and (title or platform or year or publisher or author or language):
                    conn.execute(
                        """
                        UPDATE sources
                        SET title = COALESCE(?, title),
                            platform = COALESCE(?, platform),
                            year = COALESCE(?, year),
                            publisher = COALESCE(?, publisher),
                            author = COALESCE(?, author),
                            language = COALESCE(?, language)
                        WHERE id = ?
                        """,
                        (title, platform, year, publisher, author, language, src_id)
                    )
                    conn.commit()
                return src_id

    def source_exists(self, url: str) -> bool:
        """Return whether a source URL is already persisted, regardless of status."""
        with self.get_connection() as conn:
            row = conn.execute("SELECT 1 FROM sources WHERE url = ?", (url,)).fetchone()
        return row is not None

    def _row_to_source(self, row: sqlite3.Row) -> SourceRecord:
        keys = row.keys()
        return SourceRecord(
            id=row["id"],
            url=row["url"],
            source_tier=row["source_tier"],
            status=row["status"],
            http_status=row["http_status"],
            content_type=row["content_type"],
            local_path=row["local_path"],
            title=row["title"] if "title" in keys else None,
            platform=row["platform"] if "platform" in keys else None,
            year=row["year"] if "year" in keys else None,
            publisher=row["publisher"] if "publisher" in keys else None,
            author=row["author"] if "author" in keys else None,
            language=row["language"] if "language" in keys else None,
            discovered_at=row["discovered_at"],
            processed_at=row["processed_at"],
        )

    def get_pending_sources(self) -> List[SourceRecord]:
        with self.get_connection() as conn:
            cursor = conn.execute("SELECT * FROM sources WHERE status IN ('pending', 'error')")
            return [self._row_to_source(row) for row in cursor.fetchall()]

    def update_source_status(
        self,
        source_id: int,
        status: str,
        http_status: Optional[int] = None,
        content_type: Optional[str] = None,
        local_path: Optional[str] = None
    ) -> None:
        now = datetime.now().isoformat()
        with self.get_connection() as conn:
            conn.execute(
                """
                UPDATE sources
                SET status = ?, http_status = ?, content_type = ?, local_path = ?, processed_at = ?
                WHERE id = ?
                """,
                (status, http_status, content_type, local_path, now, source_id)
            )
            conn.commit()

    def get_all_sources(self) -> List[SourceRecord]:
        with self.get_connection() as conn:
            cursor = conn.execute("SELECT * FROM sources")
            return [self._row_to_source(row) for row in cursor.fetchall()]

    # --- Artifacts operations ---

    def add_artifact(self, artifact: ArtifactRecord) -> int:
        with self.get_connection() as conn:
            cursor = conn.execute(
                "SELECT id FROM artifacts WHERE source_id = ? AND sha256 = ? AND archive_depth = ?",
                (artifact.source_id, artifact.sha256, artifact.archive_depth)
            )
            row = cursor.fetchone()
            if row:
                return row["id"]

            cursor = conn.execute(
                """
                INSERT INTO artifacts (
                    source_id, original_filename, extracted_path, archive_depth,
                    file_size, md5_full, md5_5000, sha256, sha1, crc32,
                    md5_tail5000, sha224, sha384, sha512, sha3_256, sha3_512,
                    blake2b, blake2s, adler32, xxh32, xxh64, xxh128,
                    unpacked, is_daad_payload, daad_version_guess, platform_hint,
                    title, year, publisher, author, language
                ) VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                )
                """,
                (
                    artifact.source_id,
                    artifact.original_filename,
                    artifact.extracted_path,
                    artifact.archive_depth,
                    artifact.file_size,
                    artifact.md5_full,
                    artifact.md5_5000,
                    artifact.sha256,
                    artifact.sha1,
                    artifact.crc32,
                    artifact.md5_tail5000,
                    artifact.sha224,
                    artifact.sha384,
                    artifact.sha512,
                    artifact.sha3_256,
                    artifact.sha3_512,
                    artifact.blake2b,
                    artifact.blake2s,
                    artifact.adler32,
                    artifact.xxh32,
                    artifact.xxh64,
                    artifact.xxh128,
                    artifact.unpacked,
                    artifact.is_daad_payload,
                    artifact.daad_version_guess,
                    artifact.platform_hint,
                    artifact.title,
                    artifact.year,
                    artifact.publisher,
                    artifact.author,
                    artifact.language
                )
            )
            conn.commit()
            return cursor.lastrowid

    def update_artifact_unpacked(self, artifact_id: int, unpacked: bool = True) -> None:
        with self.get_connection() as conn:
            conn.execute(
                "UPDATE artifacts SET unpacked = ? WHERE id = ?",
                (unpacked, artifact_id)
            )
            conn.commit()

    def update_artifact_fingerprint(
        self,
        artifact_id: int,
        is_daad_payload: bool,
        daad_version_guess: Optional[str] = None,
        platform_hint: Optional[str] = None
    ) -> None:
        with self.get_connection() as conn:
            conn.execute(
                """
                UPDATE artifacts
                SET is_daad_payload = ?, daad_version_guess = ?, platform_hint = ?
                WHERE id = ?
                """,
                (is_daad_payload, daad_version_guess, platform_hint, artifact_id)
            )
            conn.commit()

    def _row_to_artifact(self, row: sqlite3.Row) -> ArtifactRecord:
        keys = row.keys()
        return ArtifactRecord(
            id=row["id"],
            source_id=row["source_id"],
            original_filename=row["original_filename"],
            extracted_path=row["extracted_path"],
            archive_depth=row["archive_depth"],
            file_size=row["file_size"],
            md5_full=row["md5_full"],
            md5_5000=row["md5_5000"],
            sha256=row["sha256"],
            sha1=row["sha1"] if "sha1" in keys else None,
            crc32=row["crc32"] if "crc32" in keys else None,
            md5_tail5000=row["md5_tail5000"] if "md5_tail5000" in keys else None,
            sha224=row["sha224"] if "sha224" in keys else None,
            sha384=row["sha384"] if "sha384" in keys else None,
            sha512=row["sha512"] if "sha512" in keys else None,
            sha3_256=row["sha3_256"] if "sha3_256" in keys else None,
            sha3_512=row["sha3_512"] if "sha3_512" in keys else None,
            blake2b=row["blake2b"] if "blake2b" in keys else None,
            blake2s=row["blake2s"] if "blake2s" in keys else None,
            adler32=row["adler32"] if "adler32" in keys else None,
            xxh32=row["xxh32"] if "xxh32" in keys else None,
            xxh64=row["xxh64"] if "xxh64" in keys else None,
            xxh128=row["xxh128"] if "xxh128" in keys else None,
            unpacked=bool(row["unpacked"]) if "unpacked" in keys else False,
            is_daad_payload=bool(row["is_daad_payload"]),
            daad_version_guess=row["daad_version_guess"],
            platform_hint=row["platform_hint"],
            title=row["title"] if "title" in keys else None,
            year=row["year"] if "year" in keys else None,
            publisher=row["publisher"] if "publisher" in keys else None,
            author=row["author"] if "author" in keys else None,
            language=row["language"] if "language" in keys else None
        )

    def get_all_artifacts(self) -> List[ArtifactRecord]:
        with self.get_connection() as conn:
            cursor = conn.execute("SELECT * FROM artifacts")
            return [self._row_to_artifact(row) for row in cursor.fetchall()]

    def get_daad_artifacts(self) -> List[ArtifactRecord]:
        with self.get_connection() as conn:
            cursor = conn.execute("SELECT * FROM artifacts WHERE is_daad_payload = 1")
            return [self._row_to_artifact(row) for row in cursor.fetchall()]

    # --- Games operations ---

    def add_game(self, game: GameRecord) -> int:
        with self.get_connection() as conn:
            cursor = conn.execute(
                """
                INSERT INTO games (
                    artifact_id, game_id, title, platform, language,
                    year, publisher, author, detection_entry
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    game.artifact_id,
                    game.game_id,
                    game.title,
                    game.platform,
                    game.language,
                    game.year,
                    game.publisher,
                    game.author,
                    game.detection_entry
                )
            )
            conn.commit()
            return cursor.lastrowid

    def get_all_games(self) -> List[GameRecord]:
        with self.get_connection() as conn:
            cursor = conn.execute("SELECT * FROM games")
            return [
                GameRecord(
                    id=row["id"],
                    artifact_id=row["artifact_id"],
                    game_id=row["game_id"],
                    title=row["title"],
                    platform=row["platform"],
                    language=row["language"],
                    year=row["year"],
                    publisher=row["publisher"],
                    author=row["author"],
                    detection_entry=row["detection_entry"]
                )
                for row in cursor.fetchall()
            ]
