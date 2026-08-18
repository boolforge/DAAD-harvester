import pytest
import asyncio
import httpx
from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

from daad_harvester.db import Database
from daad_harvester.discover import Discoverer, RateLimiter
from daad_harvester.models import SourceTier

@pytest.mark.anyio
async def test_rate_limiter():
    limiter = RateLimiter(rate_limit_per_second=10.0)
    start = asyncio.get_event_loop().time()
    await limiter.acquire("example.com")
    await limiter.acquire("example.com")
    elapsed = asyncio.get_event_loop().time() - start
    assert elapsed >= 0.05

@pytest.mark.anyio
async def test_discoverer_zxdb_mock(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    mock_json = [
        {
            "id": 1234,
            "title": "Aventura Original",
            "downloads": [
                {"url": "https://example.com/aventura.zip"}
            ]
        }
    ]

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.return_value = mock_json
        async with httpx.AsyncClient() as client:
            await discoverer.discover_zxdb(client)

    pending = db.get_pending_sources()
    assert len(pending) == 1
    assert pending[0].url == "https://example.com/aventura.zip"
    assert pending[0].source_tier == SourceTier.API.value

@pytest.mark.anyio
async def test_discoverer_ifarchive_mock(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    mock_html = """
    <html>
      <body>
        <a href="game1.zip">Game 1 ZIP</a>
        <a href="game2.dsk">Game 2 DSK</a>
        <a href="readme.txt">Readme</a>
      </body>
    </html>
    """

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.return_value = mock_html
        async with httpx.AsyncClient() as client:
            await discoverer.discover_ifarchive(client)

    pending = db.get_pending_sources()
    assert len(pending) == 6
    urls = [p.url for p in pending]
    assert any("game1.zip" in u for u in urls)
    assert any("game2.dsk" in u for u in urls)


@pytest.mark.anyio
async def test_discoverer_github_uses_each_repos_own_default_branch(tmp_path):
    """Regression test: discover_github used to hardcode
    '/archive/refs/heads/main.zip' for every match. Verified live against
    the real GitHub API that this 404s for repos on 'master' (e.g.
    nataliapc/msx2daad, haseebcheema/daadminer are both real DAAD-topic
    repos using 'master', not 'main'). The search API returns each repo's
    actual default_branch; this must be used instead of a hardcoded guess."""
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    mock_json = {
        "items": [
            {
                "name": "daadminer",
                "description": "a daad tool",
                "owner": {"login": "haseebcheema"},
                "default_branch": "master",
            },
            {
                "name": "NextDAAD",
                "description": "daad ready games",
                "owner": {"login": "absent42"},
                "default_branch": "main",
            },
            {
                # Defensively: a repo missing default_branch entirely
                # (e.g. an unusual API response) should still fall back to
                # "main" rather than crashing.
                "name": "daad-legacy-tools",
                "description": "daad toolchain",
                "owner": {"login": "someone"},
            },
        ]
    }

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.return_value = mock_json
        async with httpx.AsyncClient() as client:
            await discoverer.discover_github(client)

    urls = {p.url for p in db.get_pending_sources()}
    assert "https://github.com/haseebcheema/daadminer/archive/refs/heads/master.zip" in urls
    assert "https://github.com/absent42/NextDAAD/archive/refs/heads/main.zip" in urls
    assert "https://github.com/someone/daad-legacy-tools/archive/refs/heads/main.zip" in urls
    # Never the old hardcoded-regardless-of-reality behavior for the master repo:
    assert "https://github.com/haseebcheema/daadminer/archive/refs/heads/main.zip" not in urls


@pytest.mark.anyio
async def test_run_all_discovery_wires_proxy_into_client(tmp_path, monkeypatch):
    """Regression test: Discoverer._get_proxy() existed but was never passed
    to httpx.AsyncClient, so --proxy-list had zero effect on the discovery
    phase (mirrors the same bug fixed in Fetcher)."""
    from daad_harvester.config import settings

    monkeypatch.setattr(settings, "proxy_list", ["http://proxy.example:8080"])
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    captured_kwargs = {}
    real_async_client = httpx.AsyncClient

    class RecordingClient(real_async_client):
        def __init__(self, *args, **kwargs):
            captured_kwargs.update(kwargs)
            super().__init__(*args, **kwargs)

    no_op_methods = {
        name: AsyncMock()
        for name in [
            "discover_internet_archive", "discover_aminet", "discover_github",
            "discover_itchio", "discover_ifdb", "discover_zxdb",
            "discover_wikicaad", "discover_ifarchive", "discover_web_search",
        ]
    }

    with patch.multiple(discoverer, **no_op_methods), \
         patch.object(discoverer, "load_canonical_seeds"), \
         patch("daad_harvester.discover.httpx.AsyncClient", RecordingClient):
        await discoverer.run_all_discovery()

    assert captured_kwargs.get("proxy") == "http://proxy.example:8080"
