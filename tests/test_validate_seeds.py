"""Tests for scripts/validate_seeds.py's pass/fail judgment logic.

Real network calls against archive.org etc. aren't exercised here (this repo's
own test suite shouldn't depend on third-party site availability) -- these
test that a given HTTP response is judged correctly, and that _check_one
handles a total connection failure without crashing.
"""

import httpx
import pytest

from scripts.validate_seeds import _check_one, _judge


@pytest.mark.anyio
async def test_judge_accepts_real_binary_response():
    resp = httpx.Response(200, headers={"content-type": "application/zip"}, request=httpx.Request("GET", "https://example.com/game.zip"))
    title, ok, detail = await _judge("A Game", "https://example.com/game.zip", resp)
    assert ok is True
    assert "200" in detail


def test_judge_rejects_html_error_page_even_with_200():
    """A server can answer 200 OK while serving an HTML error/redirect page
    instead of the actual file -- this must not be counted as a live seed."""
    import asyncio

    resp = httpx.Response(200, headers={"content-type": "text/html; charset=utf-8"}, request=httpx.Request("GET", "https://example.com/game.zip"))
    title, ok, detail = asyncio.run(_judge("A Game", "https://example.com/game.zip", resp))
    assert ok is False
    assert "text/html" in detail


def test_judge_rejects_404():
    import asyncio

    resp = httpx.Response(404, request=httpx.Request("GET", "https://example.com/gone.zip"))
    title, ok, detail = asyncio.run(_judge("A Game", "https://example.com/gone.zip", resp))
    assert ok is False
    assert "404" in detail


@pytest.mark.anyio
async def test_check_one_reports_connection_errors_without_raising():
    """A totally unreachable host (DNS failure, refused connection, etc.)
    must be reported as a normal failure, not propagate an exception and
    abort the whole validation run for every other seed."""

    class _AlwaysFailsClient:
        async def head(self, url, **kwargs):
            raise httpx.ConnectError("simulated: name does not resolve")

    title, ok, detail = await _check_one(_AlwaysFailsClient(), {"title": "Dead Seed", "url": "https://nonexistent.example/x.zip"})
    assert ok is False
    assert "Dead Seed" == title
    assert "connection error" in detail
