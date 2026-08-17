"""Tests for Fetcher Content-Type and web payload rejection."""

import pytest
from daad_harvester.db import Database
from daad_harvester.fetch import Fetcher


def test_fetcher_rejects_html_and_json(tmp_path):
    db = Database(tmp_path / "test.db")
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")

    html_chunk = b"<!DOCTYPE html><html><head><title>Error 404</title></head><body>Not Found</body></html>"
    json_chunk = b'{"status": "error", "message": "Access Denied"}'
    binary_chunk = b"\x00\x01\x02\x03\x04\x05\x06\x07DAAD"

    assert fetcher._is_invalid_web_payload(html_chunk, "text/html") is True
    assert fetcher._is_invalid_web_payload(json_chunk, "application/json") is True
    assert fetcher._is_invalid_web_payload(binary_chunk, "application/octet-stream") is False
