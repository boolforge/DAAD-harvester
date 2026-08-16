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
