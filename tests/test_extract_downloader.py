"""Tests for daad_harvester.extract.downloader, all using httpx.MockTransport (no real
network calls, appropriate for a fast/deterministic CI job).
"""
import hashlib
from pathlib import Path

import httpx
import pytest

from daad_harvester.extract.downloader import Downloader, RateLimitExceededError, TransientNetworkError
from daad_harvester.transform.models import SourceModel, SourceStatus


@pytest.fixture(autouse=True)
def _fast_rate_limit(monkeypatch):
    # Avoid real per-domain rate-limit sleeps slowing the suite down; behavior of
    # _rate_limit_domain itself is simple enough not to need its own dedicated test.
    monkeypatch.setattr("daad_harvester.config.settings.rate_limit_per_domain", 0.0)


def _client(handler) -> httpx.AsyncClient:
    return httpx.AsyncClient(transport=httpx.MockTransport(handler))


def test_verify_defaults_to_true_not_disabled():
    # Regression guard for the TLS-verification regression found in the original PR:
    # this module must never pass verify=False when constructing its own client.
    # (Checked against the actual call line, not the whole function source, since the
    # docstring above legitimately mentions "verify=False" in its explanation.)
    import inspect

    source = inspect.getsource(Downloader.download_batch)
    call_line = next(line for line in source.splitlines() if "httpx.AsyncClient(" in line)
    assert "verify=False" not in call_line
    assert "proxy=proxy, limits=limits" in call_line


@pytest.mark.asyncio
async def test_download_source_success_writes_file_and_hashes(tmp_path):
    body = b"PK\x03\x04fake zip content for testing"

    def handler(request):
        return httpx.Response(200, content=body, headers={"Content-Type": "application/zip"})

    downloader = Downloader(download_dir=tmp_path, max_concurrent=2)
    source = SourceModel(id=1, source_name="test", url="https://example.com/game.zip", role="media")

    async with _client(handler) as client:
        result = await downloader.download_source(client, source)

    assert result.status == SourceStatus.FETCHED
    assert result.size_bytes == len(body)
    assert result.sha256 == hashlib.sha256(body).hexdigest()
    assert result.download_path is not None
    assert Path(result.download_path).read_bytes() == body


@pytest.mark.asyncio
async def test_download_source_rejects_html_for_media_role(tmp_path):
    def handler(request):
        return httpx.Response(200, content=b"<html>not found</html>", headers={"Content-Type": "text/html"})

    downloader = Downloader(download_dir=tmp_path)
    source = SourceModel(id=2, source_name="test", url="https://example.com/game.zip", role="media")

    async with _client(handler) as client:
        result = await downloader.download_source(client, source)

    assert result.status == SourceStatus.FAILED
    assert "HTML" in result.error_message


@pytest.mark.asyncio
async def test_download_source_empty_body_marks_failed(tmp_path):
    def handler(request):
        return httpx.Response(200, content=b"")

    downloader = Downloader(download_dir=tmp_path)
    source = SourceModel(id=3, source_name="test", url="https://example.com/game.zip")

    async with _client(handler) as client:
        result = await downloader.download_source(client, source)

    assert result.status == SourceStatus.FAILED
    assert "Empty response" in result.error_message


@pytest.mark.asyncio
async def test_fetch_url_handles_429_rate_limit_then_succeeds(tmp_path):
    calls = {"n": 0}

    def handler(request):
        calls["n"] += 1
        if calls["n"] == 1:
            return httpx.Response(429, headers={"Retry-After": "0"})
        return httpx.Response(200, content=b"ok")

    downloader = Downloader(download_dir=tmp_path)
    async with _client(handler) as client:
        response = await downloader.fetch_url(client, "https://example.com/x")

    assert response.status_code == 200
    assert calls["n"] == 2


@pytest.mark.asyncio
async def test_fetch_url_429_raises_rate_limit_error_type_after_exhausting_retries(tmp_path):
    def handler(request):
        return httpx.Response(429, headers={"Retry-After": "0"})

    downloader = Downloader(download_dir=tmp_path)
    async with _client(handler) as client:
        with pytest.raises(RateLimitExceededError):
            await downloader.fetch_url(client, "https://example.com/x")


@pytest.mark.asyncio
async def test_fetch_url_retries_transient_error_then_succeeds(tmp_path):
    calls = {"n": 0}

    def handler(request):
        calls["n"] += 1
        if calls["n"] < 3:
            return httpx.Response(503)
        return httpx.Response(200, content=b"ok")

    downloader = Downloader(download_dir=tmp_path)
    async with _client(handler) as client:
        response = await downloader.fetch_url(client, "https://example.com/x")

    assert response.status_code == 200
    assert calls["n"] == 3


@pytest.mark.asyncio
async def test_fetch_url_raises_after_exhausting_retries(tmp_path):
    def handler(request):
        return httpx.Response(503)

    downloader = Downloader(download_dir=tmp_path)
    async with _client(handler) as client:
        with pytest.raises(TransientNetworkError):
            await downloader.fetch_url(client, "https://example.com/x")


@pytest.mark.asyncio
async def test_download_batch_processes_all_sources(tmp_path, monkeypatch):
    def handler(request):
        return httpx.Response(200, content=b"data", headers={"Content-Type": "application/octet-stream"})

    real_async_client = httpx.AsyncClient

    def patched_async_client(*args, **kwargs):
        kwargs.pop("proxy", None)
        kwargs.pop("limits", None)
        kwargs["transport"] = httpx.MockTransport(handler)
        return real_async_client(**kwargs)

    monkeypatch.setattr(httpx, "AsyncClient", patched_async_client)

    downloader = Downloader(download_dir=tmp_path, max_concurrent=4)
    sources = [
        SourceModel(id=i, source_name="test", url=f"https://example{i}.com/x.zip") for i in range(3)
    ]
    results = await downloader.download_batch(sources)

    assert len(results) == 3
    assert all(r.status == SourceStatus.FETCHED for r in results)
