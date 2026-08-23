"""Tests for daad_harvester.logging (the Loguru setup added by the ETL redesign)."""
import json

from loguru import logger

from daad_harvester.logging import log_event, setup_logger


def test_setup_logger_writes_json_file_sink(tmp_path):
    log_file = tmp_path / "harvester.json"
    setup_logger(log_file=log_file, log_level="INFO", rotation="100 MB", retention="1 day")

    logger.info("loguru_unit_test_message")
    logger.complete()  # flush the enqueue=True async sink before reading the file back

    assert log_file.exists()
    lines = [line for line in log_file.read_text(encoding="utf-8").splitlines() if line.strip()]
    assert lines, "expected at least one JSON log line"
    record = json.loads(lines[-1])
    assert record["record"]["message"] == "loguru_unit_test_message"


def test_setup_logger_without_log_file_does_not_raise():
    # Console-only configuration must also work when no log_file is supplied.
    setup_logger(log_file=None, log_level="DEBUG")
    logger.debug("console_only_message")


def test_log_event_formats_structured_payload(tmp_path, capsys):
    log_file = tmp_path / "events.json"
    setup_logger(log_file=log_file, log_level="INFO")

    log_event("phase_started", {"phase": "unpack", "count": 3})
    logger.complete()

    content = log_file.read_text(encoding="utf-8")
    assert "phase_started" in content
    assert "unpack" in content
