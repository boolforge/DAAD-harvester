"""Tests for scripts/migrate_legacy_logs_to_json.py."""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from migrate_legacy_logs_to_json import (  # noqa: E402
    detect_format,
    migrate_file,
    parse_banner_file,
    parse_structlog_console_file,
)

BANNER_SAMPLE = """================================================================================
SESSION TAG:     20260822_065312
CATEGORY:        GENERAL ACTIVITY
TIMESTAMP:       2026-08-22T06:53:21.831374
MESSAGE         : Fingerprint phase complete: 76/1015 verified DAAD DDBs
LEVEL           : INFO
================================================================ drop

================================================================================
SESSION TAG:     20260819_111214
CATEGORY:        VERIFIED DAAD GAME
TIMESTAMP:       2026-08-19T11:12:15.000000
GAME ID         : 42
TITLE           : Jabato
FILE SIZE       : 45056 bytes
--- HASHES ---
MD5_FULL        : d41d8cd98f00b204e9800998ecf8427e
SHA256          : e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
================================================================ drop
"""

STRUCTLOG_SAMPLE = """reset_sources=0 backfilled_artifacts=0 event='database_backfill_and_rescan_completed' logger='daad_harvester.db' level='info' timestamp='2026-08-19T10:55:08.584183Z'
HTTP Request: GET https://computeremuzone.com/download.php?ind=415 "HTTP/1.1 403 Forbidden"
source_id=59 status_code=403 event='http_download_error' logger='daad_harvester.fetch' level='warning' timestamp='2026-08-19T12:25:33.493699Z'
"""

TRANSCRIPT_SAMPLE = """# Independent CP/M standard-profile listing attempts
2026-08-19T11:19:19Z
## cpcsys
cpmls: cannot read superblock (Missing address mark.)
"""


def test_detect_format_banner():
    assert detect_format(Path("x.log"), BANNER_SAMPLE) == "loggersuite_banner"


def test_detect_format_structlog():
    assert detect_format(Path("x.log"), STRUCTLOG_SAMPLE) == "structlog_console"


def test_detect_format_raw_transcript():
    assert detect_format(Path("x.log"), TRANSCRIPT_SAMPLE) == "raw_transcript"


def test_parse_banner_file_two_records_with_hashes():
    records = parse_banner_file(BANNER_SAMPLE)
    assert len(records) == 2

    first = records[0]
    assert first["session_tag"] == "20260822_065312"
    assert first["category"] == "GENERAL ACTIVITY"
    assert first["timestamp"] == "2026-08-22T06:53:21.831374"
    assert first["fields"]["message"] == "Fingerprint phase complete: 76/1015 verified DAAD DDBs"
    assert first["fields"]["level"] == "INFO"

    second = records[1]
    assert second["category"] == "VERIFIED DAAD GAME"
    assert second["fields"]["game_id"] == 42  # numeric coercion
    assert second["fields"]["title"] == "Jabato"
    assert second["fields"]["hashes"]["md5_full"] == "d41d8cd98f00b204e9800998ecf8427e"
    assert second["fields"]["hashes"]["sha256"].startswith("e3b0c442")


def test_parse_structlog_console_file_mixes_structlog_and_raw_lines():
    records = parse_structlog_console_file(STRUCTLOG_SAMPLE)
    assert len(records) == 3
    assert records[0]["type"] == "structlog"
    assert records[0]["fields"]["reset_sources"] == 0  # int, not the string "0"
    assert records[0]["fields"]["event"] == "database_backfill_and_rescan_completed"

    assert records[1]["type"] == "raw_line"
    assert "HTTP/1.1 403 Forbidden" in records[1]["text"]

    assert records[2]["type"] == "structlog"
    assert records[2]["fields"]["status_code"] == 403
    assert records[2]["fields"]["level"] == "warning"


def test_migrate_file_banner_roundtrip(tmp_path):
    src = tmp_path / "daad_general.log"
    src.write_text(BANNER_SAMPLE, encoding="utf-8")

    out = migrate_file(src)

    assert out == tmp_path / "daad_general.json"
    assert src.exists()  # original is never deleted
    payload = json.loads(out.read_text(encoding="utf-8"))
    assert payload["source_log_file"] == "daad_general.log"
    assert payload["format"] == "loggersuite_banner"
    assert payload["record_count"] == 2
    assert len(payload["records"]) == 2
    assert "migrated_at" in payload


def test_migrate_file_raw_transcript_preserves_full_text_verbatim(tmp_path):
    src = tmp_path / "weird_tool_output.log"
    src.write_text(TRANSCRIPT_SAMPLE, encoding="utf-8")

    out = migrate_file(src)
    payload = json.loads(out.read_text(encoding="utf-8"))

    assert payload["format"] == "raw_transcript"
    assert payload["text"] == TRANSCRIPT_SAMPLE
    assert "records" not in payload


def test_migrate_file_is_idempotent_on_record_content(tmp_path):
    src = tmp_path / "daad_general.log"
    src.write_text(BANNER_SAMPLE, encoding="utf-8")

    out1 = migrate_file(src)
    payload1 = json.loads(out1.read_text(encoding="utf-8"))
    out2 = migrate_file(src)
    payload2 = json.loads(out2.read_text(encoding="utf-8"))

    # migrated_at legitimately differs run to run; everything else must not.
    payload1.pop("migrated_at")
    payload2.pop("migrated_at")
    assert payload1 == payload2
