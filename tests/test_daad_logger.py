"""Tests for daad_harvester.daad_logger.

This module is imported and used by six other production modules (config.py,
discover.py, fetch.py, fingerprint.py, synthesize.py, unpack.py) but had no test
coverage at all before this file -- found while auditing the codebase for modules
with real usage but no corresponding tests.
"""
from datetime import datetime
from pathlib import Path

from daad_harvester.daad_logger import DAADGamesLogger, LoggerSuite, rotate_log_file


def test_rotate_log_file_noop_on_missing_file(tmp_path):
    assert rotate_log_file(tmp_path / "missing.log") is None


def test_rotate_log_file_noop_on_empty_file(tmp_path):
    empty = tmp_path / "empty.log"
    empty.touch()
    assert rotate_log_file(empty) is None
    assert empty.exists()  # untouched


def test_rotate_log_file_renames_nonempty_file(tmp_path):
    original = tmp_path / "daad_general.log"
    original.write_text("existing content", encoding="utf-8")

    rotated = rotate_log_file(original)

    assert rotated is not None
    assert not original.exists()
    assert rotated.exists()
    assert rotated.read_text(encoding="utf-8") == "existing content"
    assert rotated.name.startswith("daad_general_")
    assert rotated.suffix == ".log"


def test_rotate_log_file_disambiguates_same_second_collision(tmp_path, monkeypatch):
    """Two rotations landing on the same second-precision timestamp must not
    silently overwrite one another; the function falls back to microsecond
    precision when the first candidate name is already taken."""
    original = tmp_path / "daad_general.log"
    original.write_text("first", encoding="utf-8")

    fixed_now = datetime(2026, 8, 26, 12, 0, 0)

    class _FixedDatetime(datetime):
        @classmethod
        def now(cls, tz=None):
            return fixed_now

    monkeypatch.setattr("daad_harvester.daad_logger.datetime", _FixedDatetime)

    first_rotated = rotate_log_file(original)
    assert first_rotated.read_text(encoding="utf-8") == "first"

    # Recreate the log file and rotate again at the exact same fixed timestamp.
    original.write_text("second", encoding="utf-8")
    second_rotated = rotate_log_file(original)

    assert second_rotated != first_rotated
    assert second_rotated.read_text(encoding="utf-8") == "second"
    assert first_rotated.read_text(encoding="utf-8") == "first"  # untouched


def test_logger_suite_creates_all_six_log_paths(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="20260826_120000")

    assert suite.general_log_path == tmp_path / "daad_general.log"
    assert suite.games_log_path == tmp_path / "daad_games.log"
    assert suite.errors_log_path == tmp_path / "daad_errors.log"
    assert suite.compression_errors_log_path == tmp_path / "daad_compression_errors.log"
    assert suite.downloads_log_path == tmp_path / "daad_downloads.log"
    assert suite.discovery_log_path == tmp_path / "daad_discovery.log"


def test_logger_suite_auto_rotate_moves_preexisting_content_away(tmp_path):
    (tmp_path / "daad_general.log").write_text("stale run", encoding="utf-8")

    LoggerSuite(logs_dir=tmp_path, session_tag="20260826_120000")

    # The constructor's auto-rotation should have moved the stale content to a
    # timestamped sibling, leaving the canonical path free for this session.
    rotated_files = list(tmp_path.glob("daad_general_*.log"))
    assert len(rotated_files) == 1
    assert rotated_files[0].read_text(encoding="utf-8") == "stale run"
    assert not (tmp_path / "daad_general.log").exists()


def test_log_general_writes_expected_banner_fields(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG123", auto_rotate=False)

    suite.log_general("pipeline started", level="INFO", phase="unpack")

    content = suite.general_log_path.read_text(encoding="utf-8")
    assert "=" * 80 in content
    assert "SESSION TAG:     TAG123" in content
    assert "CATEGORY:        GENERAL ACTIVITY" in content
    assert "MESSAGE" in content and "pipeline started" in content
    assert "PHASE" in content and "unpack" in content


def test_log_general_appends_rather_than_overwrites(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)

    suite.log_general("first message")
    suite.log_general("second message")

    content = suite.general_log_path.read_text(encoding="utf-8")
    assert "first message" in content
    assert "second message" in content
    assert content.count("=" * 80) == 2


def test_log_game_writes_to_games_log_with_nested_hashes(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)

    suite.log_game(
        {
            "game_id": 42,
            "title": "Jabato",
            "platform": "zx",
            "file_size": 45056,
            "md5_full": "d41d8cd98f00b204e9800998ecf8427e",
            "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b85",
        }
    )

    content = suite.games_log_path.read_text(encoding="utf-8")
    assert "CATEGORY:        VERIFIED DAAD GAME" in content
    assert "TITLE" in content and "Jabato" in content
    assert "PLATFORM" in content and "ZX" in content  # uppercased
    assert "45056 bytes" in content
    assert "--- HASHES ---" in content
    assert "MD5_FULL" in content and "d41d8cd98f00b204e9800998ecf8427e" in content
    assert "SHA256" in content


def test_log_game_defaults_missing_fields_to_na(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)

    suite.log_game({})

    content = suite.games_log_path.read_text(encoding="utf-8")
    assert "Unknown Title" in content
    assert "N/A" in content


def test_log_error_writes_to_errors_log_with_context(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)

    suite.log_error("fetch", "connection refused", context={"url": "https://example.com"})

    content = suite.errors_log_path.read_text(encoding="utf-8")
    assert "CATEGORY:        SYSTEM ERROR" in content
    assert "COMPONENT" in content and "fetch" in content
    assert "connection refused" in content
    assert "URL" in content and "https://example.com" in content


def test_log_compression_error_writes_expected_fields(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)

    suite.log_compression_error("/tmp/game.zip", "zip", "CRC mismatch", tool_used="python-zipfile")

    content = suite.compression_errors_log_path.read_text(encoding="utf-8")
    assert "CATEGORY:        COMPRESSION / EXTRACTION ERROR" in content
    assert "CRC mismatch" in content
    assert "python-zipfile" in content


def test_log_download_writes_expected_fields_and_defaults(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)

    suite.log_download("https://example.com/x.zip", status="OK", http_code=200, wayback_used=True)

    content = suite.downloads_log_path.read_text(encoding="utf-8")
    assert "CATEGORY:        DOWNLOAD STATUS" in content
    assert "https://example.com/x.zip" in content
    assert "200" in content
    assert "True" in content  # wayback_used
    assert "LOCAL PATH" in content and "N/A" in content  # default for omitted local_path


def test_log_discovery_writes_expected_fields(tmp_path):
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)

    suite.log_discovery("Spectrum Computing", "https://example.com/catalog", items_found=12)

    content = suite.discovery_log_path.read_text(encoding="utf-8")
    assert "CATEGORY:        DISCOVERY CRAWL" in content
    assert "Spectrum Computing" in content
    assert "ITEMS FOUND" in content and "12" in content


def test_append_record_failure_is_logged_not_raised(tmp_path, caplog):
    """Writing to a path that cannot be opened must not crash the caller --
    consistent with the rest of the pipeline's evidence-first philosophy of
    recording failures rather than propagating exceptions."""
    suite = LoggerSuite(logs_dir=tmp_path, session_tag="TAG", auto_rotate=False)
    # Point at a path inside a location that cannot exist as a directory.
    suite.general_log_path = tmp_path / "daad_general.log" / "impossible" / "path.log"

    suite.log_general("this should not raise")  # must not raise

    assert "Failed writing to log file" in caplog.text


def test_daad_games_logger_backwards_compatible_alias(tmp_path):
    logger = DAADGamesLogger(log_path=tmp_path / "daad_games.log", auto_rotate=False)

    logger.log_daad_game({"title": "Templos Sagrados"})

    content = (tmp_path / "daad_games.log").read_text(encoding="utf-8")
    assert "Templos Sagrados" in content


def test_daad_games_logger_defaults_logs_dir_when_no_path_given(tmp_path, monkeypatch):
    monkeypatch.chdir(tmp_path)  # avoid creating a real ./output/logs in the repo

    logger = DAADGamesLogger(log_path=None, auto_rotate=False)

    assert logger.suite.logs_dir == Path("./output/logs")
    assert (tmp_path / "output" / "logs").is_dir()
