"""Discovery module for crawling retro-computing archives, APIs, and repositories for DAAD games."""

import asyncio
import random
import re
from urllib.parse import urljoin, urlparse, quote
from typing import List, Set, Optional, Dict, Any
import httpx
from bs4 import BeautifulSoup
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import SourceTier, SourceStatus
from daad_harvester.seeds import CANONICAL_DAAD_SEEDS

logger = structlog.get_logger(__name__)


class RateLimiter:
    """Per-domain rate limiter."""

    def __init__(self, rate_limit_per_second: float = 2.0):
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
    """Crawls external databases, archives, and repositories across mass retro ecosystems to discover DAAD games."""

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

        attempt = 0
        backoff = settings.backoff_base

        while attempt < settings.max_retries:
            try:
                logger.info("fetching_discovery_url", url=url, attempt=attempt + 1)
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

    def _add_source(
        self,
        url: str,
        tier: SourceTier,
        title: Optional[str] = None,
        platform: Optional[str] = None,
        year: Optional[int] = None,
        publisher: Optional[str] = None,
        author: Optional[str] = None,
        language: Optional[str] = None
    ) -> None:
        if url not in self.discovered_urls:
            self.discovered_urls.add(url)
            self.db.add_source(
                url=url,
                source_tier=tier.value,
                title=title,
                platform=platform,
                year=year,
                publisher=publisher,
                author=author,
                language=language
            )
            logger.info("discovered_source", url=url, tier=tier.value, title=title)

    def load_canonical_seeds(self) -> None:
        """Loads built-in canonical DAAD seed releases into database."""
        for seed in CANONICAL_DAAD_SEEDS:
            self._add_source(
                url=seed["url"],
                tier=SourceTier.API,
                title=seed.get("title"),
                platform=seed.get("platform"),
                year=seed.get("year"),
                publisher=seed.get("publisher"),
                author=seed.get("author"),
                language=seed.get("language")
            )

    # --- Discovery Crawlers ---

    async def discover_internet_archive(self, client: httpx.AsyncClient) -> None:
        """Query Internet Archive Advanced Search API for DAAD games and collections."""
        queries = [
            'q=title:(DAAD)+AND+mediatype:(software)',
            'q=title:("Aventuras AD")+AND+mediatype:(software)',
            'q=title:("DAAD Ready")+AND+mediatype:(software)'
        ]
        for q in queries:
            url = f"https://archive.org/advancedsearch.php?{q}&fl[]=identifier,title,mediatype&sort[]=downloads+desc&rows=50&page=1&output=json"
            data = await self._fetch_url(client, url, is_json=True)
            if data and "response" in data and "docs" in data["response"]:
                for doc in data["response"]["docs"]:
                    identifier = doc.get("identifier")
                    title = doc.get("title")
                    if identifier:
                        files_url = f"https://archive.org/metadata/{identifier}/files"
                        files_data = await self._fetch_url(client, files_url, is_json=True)
                        if files_data and "result" in files_data:
                            for file_info in files_data["result"]:
                                fname = file_info.get("name", "")
                                if any(fname.lower().endswith(ext) for ext in [".zip", ".dsk", ".tap", ".tzx", ".d64", ".adf", ".st", ".ddb", ".7z", ".rar", ".lha"]):
                                    dl_url = f"https://archive.org/download/{identifier}/{fname}"
                                    self._add_source(dl_url, SourceTier.ARCHIVE, title=title)

    async def discover_aminet(self, client: httpx.AsyncClient) -> None:
        """Query Aminet Amiga software database for DAAD releases."""
        url = "http://aminet.net/search?query=daad"
        content = await self._fetch_url(client, url)
        if content:
            soup = BeautifulSoup(content, "html.parser")
            for a in soup.find_all("a", href=True):
                href = a["href"]
                if href.endswith(".lha") or href.endswith(".readme"):
                    full_url = urljoin("http://aminet.net", href)
                    if full_url.endswith(".lha"):
                        self._add_source(full_url, SourceTier.ARCHIVE, platform="amiga")

    async def discover_github(self, client: httpx.AsyncClient) -> None:
        """Query GitHub Search API for open source DAAD Ready games and compilers, with strict filtering."""
        queries = [
            "%22DAAD+Ready%22",
            "daad+aventura",
            "topic:daad",
            "topic:daad-ready",
            "topic:aventuras-ad"
        ]
        for q in queries:
            url = f"https://api.github.com/search/repositories?q={q}&sort=updated"
            data = await self._fetch_url(client, url, is_json=True)
            if data and "items" in data:
                for repo in data["items"]:
                    repo_name = repo.get("name", "")
                    description = repo.get("description", "") or ""
                    owner = repo.get("owner", {}).get("login")

                    # Strict filter: Must contain DAAD keywords in name, description, or topics
                    text = f"{repo_name} {description}".lower()
                    if any(kw in text for kw in ["daad", "ddb", "aventuras ad", "gilsoft", "drc", "undaad", "maluva"]):
                        if owner and repo_name:
                            zip_url = f"https://github.com/{owner}/{repo_name}/archive/refs/heads/main.zip"
                            self._add_source(zip_url, SourceTier.API, title=repo_name)

    async def discover_itchio(self, client: httpx.AsyncClient) -> None:
        """Query itch.io for DAAD adventure game entries."""
        tags = ["daad", "daad-ready", "aventuras-ad"]
        for tag in tags:
            url = f"https://itch.io/games/tag-{tag}"
            content = await self._fetch_url(client, url)
            if content:
                soup = BeautifulSoup(content, "html.parser")
                for a in soup.find_all("a", href=True):
                    href = a["href"]
                    if "itch.io/" in href and not href.endswith(("/community", "/comments", "/devlog")):
                        if any(term in href.lower() for term in ["game", "daad", "aventura", "download"]):
                            self._add_source(href, SourceTier.FORUM)

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
                    if href and any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z", ".lha"]):
                        self._add_source(href, SourceTier.API)

    async def discover_zxdb(self, client: httpx.AsyncClient) -> None:
        """Query ZXDB API for DAAD Spectrum games."""
        url = "https://zxdb.zxinfo.org/api/v2/games?engine=DAAD"
        data = await self._fetch_url(client, url, is_json=True)
        if isinstance(data, list):
            for entry in data:
                title = entry.get("title")
                for dl in entry.get("downloads", []):
                    if "url" in dl:
                        self._add_source(dl["url"], SourceTier.API, title=title, platform="zx")
        elif isinstance(data, dict) and "hits" in data:
            for hit in data["hits"]:
                title = hit.get("title")
                for dl in hit.get("downloads", []):
                    if "url" in dl:
                        self._add_source(dl["url"], SourceTier.API, title=title, platform="zx")

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
                        self._add_source(full_url, SourceTier.ARCHIVE, platform="zx")

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
                            if any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z", ".lha"]):
                                full_url = urljoin(page_url, href)
                                self._add_source(full_url, SourceTier.API, title=title)

    async def discover_ifarchive(self, client: httpx.AsyncClient) -> None:
        """Traverse IF Archive directories for DAAD files."""
        dirs = [
            "https://ifarchive.org/indexes/if-archive/games/spanish/",
            "https://ifarchive.org/indexes/if-archive/games/pc/",
            "https://ifarchive.org/indexes/if-archive/programming/daad/"
        ]
        for base_url in dirs:
            content = await self._fetch_url(client, base_url)
            if content:
                soup = BeautifulSoup(content, "html.parser")
                for a in soup.find_all("a", href=True):
                    href = a["href"].strip()
                    if href.startswith("?") or href.startswith("#") or "unbox.ifarchive.org" in href:
                        continue
                    if any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z", ".lha"]):
                        full_url = urljoin(base_url, href).split("#")[0]
                        self._add_source(full_url, SourceTier.ARCHIVE)

    async def run_all_discovery(self) -> None:
        """Executes all discovery tasks asynchronously with high parallel concurrency."""
        logger.info("starting_discovery_phase")
        self.load_canonical_seeds()

        async with httpx.AsyncClient(follow_redirects=True) as client:
            tasks = [
                self.discover_internet_archive(client),
                self.discover_aminet(client),
                self.discover_github(client),
                self.discover_itchio(client),
                self.discover_ifdb(client),
                self.discover_zxdb(client),
                self.discover_spectrum_computing(client),
                self.discover_wikicaad(client),
                self.discover_ifarchive(client)
            ]
            await asyncio.gather(*tasks, return_exceptions=True)
        logger.info("discovery_phase_complete", total_discovered=len(self.discovered_urls))
