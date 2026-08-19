"""Tests for Fetcher Content-Type and web payload rejection."""

import pytest
import httpx
from unittest.mock import AsyncMock, patch

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.fetch import Fetcher
from daad_harvester.models import SourceStatus


def test_fetcher_rejects_html_and_json(tmp_path):
    db = Database(tmp_path / "test.db")
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")

    html_chunk = b"<!DOCTYPE html><html><head><title>Error 404</title></head><body>Not Found</body></html>"
    json_chunk = b'{"status": "error", "message": "Access Denied"}'
    binary_chunk = b"\x00\x01\x02\x03\x04\x05\x06\x07DAAD"

    assert fetcher._is_invalid_web_payload(html_chunk, "text/html") is True
    assert fetcher._is_invalid_web_payload(json_chunk, "application/json") is True
    assert fetcher._is_invalid_web_payload(binary_chunk, "application/octet-stream") is False


class _FakeStreamResponse:
    """Minimal stand-in for the object `async with client.stream(...) as resp` yields."""

    def __init__(self, status_code, content_type="application/octet-stream", body=b"DAAD" + b"\x00" * 60):
        self.status_code = status_code
        self.headers = {"Content-Type": content_type}
        self._body = body

    async def aiter_bytes(self, chunk_size=65536):
        yield self._body


class _FakeStreamCM:
    """Stand-in for the context manager client.stream(...) returns: real httpx
    only attempts the connection inside __aenter__, not when stream() itself
    is called, so failures must raise there to behave like the real thing."""

    def __init__(self, *, error: Exception | None = None, response: "_FakeStreamResponse | None" = None):
        self._error = error
        self._response = response

    async def __aenter__(self):
        if self._error is not None:
            raise self._error
        return self._response

    async def __aexit__(self, *exc_info):
        return False


class _FakeWaybackClient:
    """Fails every direct request; succeeds once the wayback fallback fires."""

    def __init__(self, dead_url: str, wayback_ok_url: str):
        self.dead_url = dead_url
        self.wayback_ok_url = wayback_ok_url
        self.stream_urls: list[str] = []
        self.cdx_calls = 0

    def stream(self, method, url, **kwargs):
        self.stream_urls.append(url)
        if url == self.wayback_ok_url:
            return _FakeStreamCM(response=_FakeStreamResponse(200))
        return _FakeStreamCM(error=httpx.ConnectError("simulated: domain does not resolve"))

    async def get(self, url, **kwargs):
        # _query_wayback_cdx's target; only the CDX API is fetched via .get()
        self.cdx_calls += 1
        return httpx.Response(
            200,
            json=[["urlkey", "timestamp", "original"], ["x", "20200101000000", self.dead_url]],
            request=httpx.Request("GET", url),
        )


@pytest.mark.anyio
async def test_fetch_source_falls_back_to_wayback_after_connection_errors_exhausted(tmp_path, monkeypatch):
    """Regression test: wayback fallback used to only trigger on an explicit
    HTTP 404/410 response. Most dead retro-computing sites fail with a
    connection/DNS error instead (the domain itself is gone), which never
    got a wayback attempt at all. This locks in that connection failures now
    get ONE wayback attempt, made only after direct retries are exhausted
    (not on every transient blip)."""
    monkeypatch.setattr(settings, "max_retries", 3)
    monkeypatch.setattr(settings, "backoff_base", 0.001)
    monkeypatch.setattr(settings, "backoff_max", 0.002)

    db = Database(tmp_path / "test.db")
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")

    dead_url = "https://this-domain-does-not-resolve-anymore.example/game.zip"
    wayback_url = f"https://web.archive.org/web/20200101000000id_/{dead_url}"
    source_id = db.add_source(url=dead_url, source_tier="archive")
    source = db.get_pending_sources()[0]

    fake_client = _FakeWaybackClient(dead_url=dead_url, wayback_ok_url=wayback_url)
    ok = await fetcher.fetch_source(source, fake_client)

    assert ok is True
    # Exactly 3 failed attempts on the dead URL, then the wayback attempt --
    # not a wayback attempt after every single failure.
    assert fake_client.stream_urls == [dead_url, dead_url, dead_url, wayback_url]
    assert fake_client.cdx_calls == 1

    updated = db.get_all_sources()
    match = [s for s in updated if s.id == source_id][0]
    assert match.status == SourceStatus.DOWNLOADED.value


@pytest.mark.anyio
async def test_fetch_source_falls_back_to_wayback_on_dead_link_http_status(tmp_path, monkeypatch):
    """Coverage for the *original* wayback path (HTTP 404/410), which had no
    dedicated test before this session despite being the primary fallback
    mechanism -- added alongside the connection-error path above so both
    triggers for the same fallback are actually verified, not just one."""
    monkeypatch.setattr(settings, "max_retries", 3)
    monkeypatch.setattr(settings, "backoff_base", 0.001)
    monkeypatch.setattr(settings, "backoff_max", 0.002)

    db = Database(tmp_path / "test.db")
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")

    dead_url = "https://still-online-but-file-removed.example/game.zip"
    wayback_url = f"https://web.archive.org/web/20200101000000id_/{dead_url}"
    source_id = db.add_source(url=dead_url, source_tier="archive")
    source = db.get_pending_sources()[0]

    class _Fake404Client(_FakeWaybackClient):
        def stream(self, method, url, **kwargs):
            self.stream_urls.append(url)
            if url == self.wayback_ok_url:
                return _FakeStreamCM(response=_FakeStreamResponse(200))
            return _FakeStreamCM(response=_FakeStreamResponse(404))

    fake_client = _Fake404Client(dead_url=dead_url, wayback_ok_url=wayback_url)
    ok = await fetcher.fetch_source(source, fake_client)

    assert ok is True
    # A 404 is definitive -- wayback should be tried immediately, not only
    # after burning through all direct retries like the connection-error case.
    assert fake_client.stream_urls == [dead_url, wayback_url]
    assert fake_client.cdx_calls == 1

    updated = db.get_all_sources()
    match = [s for s in updated if s.id == source_id][0]
    assert match.status == SourceStatus.DOWNLOADED.value


@pytest.mark.anyio
async def test_fetch_pending_sources_wires_proxy_into_client(tmp_path, monkeypatch):
    """Regression test: Fetcher._get_proxy() existed but was never passed to
    httpx.AsyncClient, so --proxy-list had zero effect on the fetch phase."""
    monkeypatch.setattr(settings, "proxy_list", ["http://proxy.example:9999"])

    db = Database(tmp_path / "test.db")
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")
    db.add_source(url="https://example.com/proxy-wiring-test.zip", source_tier="archive")

    captured_kwargs = {}
    real_async_client = httpx.AsyncClient

    class RecordingClient(real_async_client):
        def __init__(self, *args, **kwargs):
            captured_kwargs.update(kwargs)
            super().__init__(*args, **kwargs)

    with patch("daad_harvester.fetch.httpx.AsyncClient", RecordingClient), \
         patch.object(fetcher, "fetch_source", new=AsyncMock(return_value=True)):
        await fetcher.fetch_pending_sources(parallel=1)

    assert captured_kwargs.get("proxy") == "http://proxy.example:9999"



class _SingleResponseClient:
    """Minimal stream client that always yields a predefined response."""

    def __init__(self, response: _FakeStreamResponse):
        self.response = response

    def stream(self, method, url, **kwargs):
        return _FakeStreamCM(response=self.response)


@pytest.mark.anyio
async def test_fetch_source_rejects_empty_success_response(tmp_path, monkeypatch):
    monkeypatch.setattr(settings, "max_retries", 1)
    db = Database(tmp_path / "test.db")
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")
    source_id = db.add_source("https://example.com/empty.zip", "archive")
    source = db.get_pending_sources()[0]

    success = await fetcher.fetch_source(
        source,
        _SingleResponseClient(_FakeStreamResponse(200, body=b"")),
    )

    assert success is False
    updated = next(item for item in db.get_all_sources() if item.id == source_id)
    assert updated.status == SourceStatus.ERROR.value
    assert updated.http_status == 200
    assert updated.content_type == "application/octet-stream"
    assert list((tmp_path / "downloads").iterdir()) == []


@pytest.mark.anyio
async def test_fetch_source_persists_final_http_failure_status(tmp_path, monkeypatch):
    monkeypatch.setattr(settings, "max_retries", 1)
    db = Database(tmp_path / "test.db")
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")
    source_id = db.add_source("https://example.com/unavailable.zip", "archive")
    source = db.get_pending_sources()[0]

    success = await fetcher.fetch_source(
        source,
        _SingleResponseClient(_FakeStreamResponse(503, content_type="text/plain", body=b"temporarily unavailable")),
    )

    assert success is False
    updated = next(item for item in db.get_all_sources() if item.id == source_id)
    assert updated.status == SourceStatus.ERROR.value
    assert updated.http_status == 503
    assert updated.content_type == "text/plain"


@pytest.mark.anyio
async def test_fetch_pending_sources_honors_priority_order_and_batch_limit(tmp_path):
    db = Database(tmp_path / "test.db")
    low_id = db.add_source("https://example.com/low.zip", "archive", acquisition_priority=0)
    medium_id = db.add_source("https://example.com/medium.zip", "archive", acquisition_priority=1000)
    high_id = db.add_source("https://example.com/high.zip", "archive", acquisition_priority=1200)
    fetcher = Fetcher(db, download_dir=tmp_path / "downloads")
    fetched_ids = []

    async def record_fetch(source, client):
        fetched_ids.append(source.id)
        return True

    with patch.object(fetcher, "fetch_source", new=AsyncMock(side_effect=record_fetch)):
        successful = await fetcher.fetch_pending_sources(parallel=1, max_sources=2)

    assert successful == 2
    assert fetched_ids == [high_id, medium_id]
    assert low_id not in fetched_ids
