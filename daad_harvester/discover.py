"""Discovery module for crawling retro-computing archives and IF databases for DAAD games."""

import asyncio
import random
import re
from urllib.parse import urljoin, urlparse
from typing import List, Set, Optional, Dict, Any
import httpx
from bs4 import BeautifulSoup
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import SourceTier, SourceStatus

logger = structlog.get_logger(__name__)


class RateLimiter:
    """Per-domain rate limiter."""

    def __init__(self, rate_limit_per_second: float = 1.0):
        self.interval = 1.0 / max(rate_limit_per_second, 0.1)
        self.last_called: Dict[str, float] = {}
        self._lock = asyncio.Lock()

    async def acquire(self, domain: str) -> None:
        async with self._lock:
            now = asyncio.get_event_loop().time()
            last = self.last_called.get(domain, 0.0)
            elapsed = now - last
            if elapsed < self.interval:
                await asyncio.sleep(self.interval - elapsed)
            self.last_called[domain] = asyncio.get_event_loop().time()


class Discoverer:
    """Crawls external databases, archives, and repositories to discover potential DAAD game files."""

    def __init__(self, db: Database):
        self.db = db
        self.rate_limiter = RateLimiter(settings.rate_limit_per_domain)
        self.discovered_urls: Set[str] = set()

    def _get_random_user_agent(self) -> str:
        return random.choice(settings.user_agents)

    def _get_proxy(self) -> Optional[str]:
        if settings.proxy_list:
            return random.choice(settings.proxy_list)
        return None

    async def _fetch_url(
        self, client: httpx.AsyncClient, url: str, is_json: bool = False
    ) -> Optional[Any]:
        domain = urlparse(url).netloc
        await self.rate_limiter.acquire(domain)

        headers = {"User-Agent": self._get_random_user_agent()}
        proxy = self._get_proxy()

        attempt = 0
        backoff = settings.backoff_base

        while attempt < settings.max_retries:
            try:
                logger.info("fetching_discovery_url", url=url, attempt=attempt + 1)
                proxy_mounts = {"all://": proxy} if proxy else None
                response = await client.get(url, headers=headers, follow_redirects=True, timeout=settings.request_timeout)
                if response.status_code == 200:
                    return response.json() if is_json else response.text
                elif response.status_code in (404, 410):
                    logger.warning("discovery_url_not_found", url=url, status_code=response.status_code)
                    return None
                else:
                    logger.warning("discovery_url_http_error", url=url, status_code=response.status_code)
            except Exception as exc:
                logger.warning("discovery_fetch_exception", url=url, error=str(exc))

            attempt += 1
            if attempt < settings.max_retries:
                sleep_time = min(backoff * (2 ** (attempt - 1)) + random.uniform(0, 0.5), settings.backoff_max)
                await asyncio.sleep(sleep_time)

        return None

    def _add_source(self, url: str, tier: SourceTier) -> None:
        if url not in self.discovered_urls:
            self.discovered_urls.add(url)
            self.db.add_source(url=url, source_tier=tier.value)
            logger.info("discovered_source", url=url, tier=tier.value)

    # --- Discovery Crawlers ---

    async def discover_ifdb(self, client: httpx.AsyncClient) -> None:
        """Query IFDB API for DAAD tags."""
        tags = ["daad", "daad ready", "aventuras ad"]
        for tag in tags:
            url = f"https://ifdb.org/search?searchfor=tag:{tag}&xml=1"
            content = await self._fetch_url(client, url)
            if content:
                soup = BeautifulSoup(content, "xml")
                for link in soup.find_all("link"):
                    href = link.text or link.get("href")
                    if href and any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z"]):
                        self._add_source(href, SourceTier.API)

    async def discover_zxdb(self, client: httpx.AsyncClient) -> None:
        """Query ZXDB API for DAAD Spectrum games."""
        url = "https://zxdb.zxinfo.org/api/v2/games?engine=DAAD"
        data = await self._fetch_url(client, url, is_json=True)
        if isinstance(data, list):
            for entry in data:
                for dl in entry.get("downloads", []):
                    if "url" in dl:
                        self._add_source(dl["url"], SourceTier.API)
        elif isinstance(data, dict) and "hits" in data:
            for hit in data["hits"]:
                for dl in hit.get("downloads", []):
                    if "url" in dl:
                        self._add_source(dl["url"], SourceTier.API)

    async def discover_spectrum_computing(self, client: httpx.AsyncClient) -> None:
        """Query Spectrum Computing for DAAD entries and downloads."""
        urls = [
            "https://spectrumcomputing.co.uk/entry/30013/ZX-Spectrum/DAAD",
            "https://spectrumcomputing.co.uk/index.php?cat=96&id=30013"
        ]
        for url in urls:
            content = await self._fetch_url(client, url)
            if content:
                soup = BeautifulSoup(content, "html.parser")
                for a in soup.find_all("a", href=True):
                    href = a["href"]
                    if any(ext in href.lower() for ext in [".zip", ".tap", ".tzx", ".dsk", ".tzx.zip", ".tap.zip", "download"]):
                        full_url = urljoin(url, href)
                        self._add_source(full_url, SourceTier.ARCHIVE)

    async def discover_wikicaad(self, client: httpx.AsyncClient) -> None:
        """Query WikiCAAD API for DAAD game entries."""
        url = "https://wiki.caad.es/api.php?action=query&list=search&srsearch=DAAD&format=json"
        data = await self._fetch_url(client, url, is_json=True)
        if data and "query" in data and "search" in data["query"]:
            for item in data["query"]["search"]:
                title = item.get("title")
                if title:
                    page_url = f"https://wiki.caad.es/{title.replace(' ', '_')}"
                    content = await self._fetch_url(client, page_url)
                    if content:
                        soup = BeautifulSoup(content, "html.parser")
                        for a in soup.find_all("a", href=True):
                            href = a["href"]
                            if any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z"]):
                                full_url = urljoin(page_url, href)
                                self._add_source(full_url, SourceTier.API)

    async def discover_ifarchive(self, client: httpx.AsyncClient) -> None:
        """Traverse IF Archive directories for DAAD files."""
        dirs = [
            "https://www.ifarchive.org/indexes/if-archive/games/spanish/",
            "https://www.ifarchive.org/indexes/if-archive/games/pc/",
            "https://www.ifarchive.org/indexes/if-archive/programming/daad/"
        ]
        for base_url in dirs:
            content = await self._fetch_url(client, base_url)
            if content:
                soup = BeautifulSoup(content, "html.parser")
                for a in soup.find_all("a", href=True):
                    href = a["href"]
                    if not href.startswith("?") and not href.startswith("/"):
                        full_url = urljoin(base_url, href)
                        if any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z"]):
                            self._add_source(full_url, SourceTier.ARCHIVE)

    async def run_all_discovery(self) -> None:
        """Executes all discovery tasks asynchronously."""
        logger.info("starting_discovery_phase")
        async with httpx.AsyncClient(follow_redirects=True) as client:
            tasks = [
                self.discover_ifdb(client),
                self.discover_zxdb(client),
                self.discover_spectrum_computing(client),
                self.discover_wikicaad(client),
                self.discover_ifarchive(client)
            ]
            await asyncio.gather(*tasks, return_exceptions=True)
        logger.info("discovery_phase_complete", total_discovered=len(self.discovered_urls))
