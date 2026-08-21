"""Discovery module for crawling retro-computing archives, APIs, web search engines, and repositories for DAAD games."""

import asyncio
import random
import re
from urllib.parse import urljoin, urlparse, quote, unquote
from typing import Set, Optional, Dict, Any
import httpx
from bs4 import BeautifulSoup
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import SourceTier
from daad_harvester.seeds import CANONICAL_DAAD_SEEDS
from daad_harvester.daad_logger import LoggerSuite

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
    """Crawls external databases, retro archives, web search engines, and repositories to discover DAAD games."""

    def __init__(self, db: Database):
        self.db = db
        self.rate_limiter = RateLimiter(settings.rate_limit_per_domain)
        self.discovered_urls: Set[str] = set()
        self.logger_suite = LoggerSuite(settings.logs_dir)

    def _get_random_user_agent(self) -> str:
        return random.choice(settings.user_agents)

    def _get_proxy(self) -> Optional[str]:
        # Mirrors Fetcher._get_proxy() in fetch.py -- see the note there on
        # why this is "one proxy per run" rather than true per-request
        # rotation. Was previously never wired into the AsyncClient at all,
        # so --proxy-list had zero effect on the discovery phase either.
        if settings.proxy_list:
            return random.choice(settings.proxy_list)
        return None

    async def _fetch_url(
        self, client: httpx.AsyncClient, url: str, is_json: bool = False
    ) -> Optional[Any]:
        domain = urlparse(url).netloc
        await self.rate_limiter.acquire(domain)

        headers = {
            "User-Agent": self._get_random_user_agent(),
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,json;q=0.8,*/*;q=0.7"
        }

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
        url_lower = url.lower().split('?')[0].split('#')[0]
        rejected_exts = (
            ".php", ".html", ".htm", ".xml", ".json", ".css", ".js", ".py", ".cpp", ".h", ".c",
            ".nes", ".sfc", ".smc", ".z64", ".v64", ".n64", ".gba", ".gbc", ".gb", ".nds", ".3ds", ".iso",
            ".mp3", ".mp4", ".wav", ".flac", ".ogg", ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".avi", ".mkv"
        )
        if any(url_lower.endswith(ext) for ext in rejected_exts):
            logger.info("skipping_rejected_extension_source", url=url)
            return

        # Ensure source is a direct binary file or valid endpoint
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
        count = 0
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
            count += 1
        self.logger_suite.log_discovery("CANONICAL SEEDS", "built-in", count, status="LOADED")

    # --- Discovery Crawlers ---

    async def discover_internet_archive(self, client: httpx.AsyncClient) -> None:
        """Query Internet Archive Advanced Search API for DAAD games and collections."""
        queries = [
            'q=title:(DAAD)+AND+mediatype:(software)',
            'q=title:("Aventuras AD")+AND+mediatype:(software)',
            'q=title:("DAAD Ready")+AND+mediatype:(software)'
        ]
        found = 0
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
                                    found += 1
        self.logger_suite.log_discovery("INTERNET ARCHIVE", "archive.org", found)

    async def discover_aminet(self, client: httpx.AsyncClient) -> None:
        """Query Aminet Amiga software database for DAAD releases."""
        url = "http://aminet.net/search?query=daad"
        found = 0
        content = await self._fetch_url(client, url)
        if content:
            soup = BeautifulSoup(content, "html.parser")
            for a in soup.find_all("a", href=True):
                href = a["href"]
                if href.endswith(".lha") or href.endswith(".readme"):
                    full_url = urljoin("http://aminet.net", href)
                    if full_url.endswith(".lha"):
                        self._add_source(full_url, SourceTier.ARCHIVE, platform="amiga")
                        found += 1
        self.logger_suite.log_discovery("AMINET AMIGA", url, found)

    async def discover_github(self, client: httpx.AsyncClient) -> None:
        """Query GitHub Search API for open source DAAD Ready games and compilers."""
        queries = [
            "%22DAAD+Ready%22",
            "daad+aventura",
            "topic:daad",
            "topic:daad-ready",
            "topic:aventuras-ad"
        ]
        found = 0
        for q in queries:
            url = f"https://api.github.com/search/repositories?q={q}&sort=updated"
            data = await self._fetch_url(client, url, is_json=True)
            if data and "items" in data:
                for repo in data["items"]:
                    repo_name = repo.get("name", "")
                    description = repo.get("description", "") or ""
                    owner = repo.get("owner", {}).get("login")
                    # The search API returns each repo's actual default branch;
                    # hardcoding "main" 404s on every repo still using "master"
                    # (verified live: 2 of 5 real DAAD-topic repos are on
                    # "master", e.g. nataliapc/msx2daad, haseebcheema/daadminer).
                    default_branch = repo.get("default_branch") or "main"

                    text = f"{repo_name} {description}".lower()
                    if any(kw in text for kw in ["daad", "ddb", "aventuras ad", "gilsoft", "drc", "undaad", "maluva"]):
                        if owner and repo_name:
                            zip_url = f"https://github.com/{owner}/{repo_name}/archive/refs/heads/{default_branch}.zip"
                            self._add_source(zip_url, SourceTier.API, title=repo_name)
                            found += 1
        self.logger_suite.log_discovery("GITHUB REPOSITORIES", "api.github.com", found)

    async def discover_itchio(self, client: httpx.AsyncClient) -> None:
        """Query itch.io for DAAD adventure game entries and extract direct download links where available."""
        tags = ["daad", "daad-ready", "aventuras-ad"]
        found = 0
        for tag in tags:
            url = f"https://itch.io/games/tag-{tag}"
            content = await self._fetch_url(client, url)
            if content:
                soup = BeautifulSoup(content, "html.parser")
                for a in soup.find_all("a", href=True):
                    href = a["href"]
                    if "itch.io" in href and not any(href.endswith(ext) for ext in ["/community", "/comments", "/devlog"]):
                        # Deep inspect itch.io game page to find direct archive links if available
                        game_page = await self._fetch_url(client, href)
                        if game_page:
                            game_soup = BeautifulSoup(game_page, "html.parser")
                            extracted_any = False
                            for dl_link in game_soup.find_all("a", href=True):
                                dl_href = dl_link["href"]
                                if any(dl_href.lower().split('?')[0].endswith(ext) for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".7z", ".rar", ".lha"]):
                                    full_dl = urljoin(href, dl_href)
                                    title = dl_link.get_text(strip=True) or "Itch.io DAAD Game"
                                    self._add_source(full_dl, SourceTier.FORUM, title=title)
                                    found += 1
                                    extracted_any = True
                            if not extracted_any:
                                # Keep reference if downloadable
                                pass
        self.logger_suite.log_discovery("ITCH.IO", "itch.io", found)

    async def discover_ifdb(self, client: httpx.AsyncClient) -> None:
        """Query IFDB API for DAAD tags.

        URL format fixed against IFDB's own API docs (ifdb.org/api/search),
        whose documented example is `?xml&game&searchfor=Deep+Space+Drifter`
        -- bare `xml` and `game` flags, in that order, not `xml=1` with no
        `game` flag at all. Missing `game` means the search type is never
        told "search for games" as opposed to lists/polls/tags/etc, which
        the API's own PHP source keys off explicitly.
        """
        tags = ["daad", "daad ready", "aventuras ad"]
        found = 0
        for tag in tags:
            url = f"https://ifdb.org/search?xml&game&searchfor=tag:{tag}"
            content = await self._fetch_url(client, url)
            if content:
                soup = BeautifulSoup(content, "xml")
                for game in soup.find_all("game"):
                    title = game.find("title").get_text(strip=True) if game.find("title") else "IFDB Game"
                    for link in game.find_all("url"):
                        href = link.get_text(strip=True)
                        if href and any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z", ".lha"]):
                            self._add_source(href, SourceTier.API, title=title)
                            found += 1
        self.logger_suite.log_discovery("IFDB", "ifdb.org", found)

    async def discover_zxdb(self, client: httpx.AsyncClient) -> None:
        """Query the ZXInfo API (Thomas Kolbeck's open front-end for ZXDB) for DAAD Spectrum games.

        NOTE: "zxdb.zxinfo.org" (the previous host here) does not correspond to
        any documented ZXDB/ZXInfo service; the real, currently-live API lives
        at api.zxinfo.dk (v3). Verified via web search that the domain and a
        legacy `/api/zxinfo/games/{id}` path exist; the exact v3 search query
        parameters below are a best-effort guess and should be spot-checked
        against https://api.zxinfo.dk/v3/ (Swagger UI) since that page needs a
        browser to render and couldn't be fully inspected from here.
        """
        urls = [
            "https://api.zxinfo.dk/v3/games/search?search=DAAD",
            "https://api.zxinfo.dk/v3/games/search?search=Aventuras+AD",
        ]
        found = 0
        for url in urls:
            data = await self._fetch_url(client, url, is_json=True)
            if isinstance(data, list):
                for entry in data:
                    title = entry.get("title")
                    for dl in entry.get("downloads", []):
                        if "url" in dl:
                            self._add_source(dl["url"], SourceTier.API, title=title, platform="zx")
                            found += 1
            elif isinstance(data, dict) and "hits" in data:
                for hit in data["hits"]:
                    title = hit.get("title")
                    for dl in hit.get("downloads", []):
                        if "url" in dl:
                            self._add_source(dl["url"], SourceTier.API, title=title, platform="zx")
                            found += 1
        self.logger_suite.log_discovery("ZXDB SPECTRUM", "zxdb.zxinfo.org", found)

    async def discover_wikicaad(self, client: httpx.AsyncClient) -> None:
        """Query WikiCAAD API for DAAD game entries."""
        url = "https://wiki.caad.es/api.php?action=query&list=search&srsearch=DAAD&format=json"
        found = 0
        data = await self._fetch_url(client, url, is_json=True)
        if data and "query" in data and "search" in data["query"]:
            for item in data["query"]["search"]:
                title = item.get("title")
                if title:
                    page_url = f"https://wiki.caad.es/{quote(title.replace(' ', '_'))}"
                    content = await self._fetch_url(client, page_url)
                    if content:
                        soup = BeautifulSoup(content, "html.parser")
                        for a in soup.find_all("a", href=True):
                            href = a["href"]
                            if any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z", ".lha"]):
                                full_url = urljoin(page_url, href)
                                self._add_source(full_url, SourceTier.API, title=title)
                                found += 1
        self.logger_suite.log_discovery("WIKICAAD", url, found)

    async def discover_ifarchive(self, client: httpx.AsyncClient) -> None:
        """Traverse IF Archive directories for DAAD files.

        NOTE: dropped the "/indexes/" prefix these paths had. Confirmed live
        that "/if-archive/programming/", "/if-archive/programming/javascript/"
        etc. serve real directory listings at ifarchive.org directly;
        "/indexes/if-archive/" only turned up as the bare top-level
        category-overview page in search results, never as a working prefix
        for a specific subdirectory like games/spanish. Not 100% certain
        (couldn't fetch either form directly to compare), but this matches
        every confirmed-working example found, and there's no evidence the
        old "/indexes/" form ever worked for a subdirectory like this.
        """
        dirs = [
            "https://ifarchive.org/if-archive/games/spanish/",
            "https://ifarchive.org/if-archive/games/pc/",
            "https://ifarchive.org/if-archive/programming/daad/"
        ]
        found = 0
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
                        found += 1
        self.logger_suite.log_discovery("IF ARCHIVE", "ifarchive.org", found)

    async def discover_web_search(self, client: httpx.AsyncClient) -> None:
        """Fallback web search engine discovery via DuckDuckGo HTML scraping for DAAD adventure games."""
        search_queries = [
            "DAAD adventure game download .dsk .tap .tzx .ddb",
            "Aventuras AD DAAD games spectrum cpc amiga dos",
            "DAAD Ready games zip download"
        ]
        found = 0
        for query in search_queries:
            url = f"https://html.duckduckgo.com/html/?q={quote(query)}"
            content = await self._fetch_url(client, url)
            if content:
                soup = BeautifulSoup(content, "html.parser")
                for a in soup.find_all("a", class_="result__url", href=True):
                    href = a["href"]
                    # Unescape DuckDuckGo link redirect parameter if present
                    if "/l/?" in href and "uddg=" in href:
                        match = re.search(r'uddg=([^&]+)', href)
                        if match:
                            href = unquote(match.group(1))

                    if any(ext in href.lower() for ext in [".zip", ".dsk", ".tap", ".tzx", ".ddb", ".rar", ".7z", ".lha"]):
                        title = a.get_text(strip=True) or "Web Search Discovered Game"
                        self._add_source(href, SourceTier.FORUM, title=title)
                        found += 1
        self.logger_suite.log_discovery("WEB SEARCH FALLBACK", "duckduckgo.com", found)

    async def run_all_discovery(self) -> None:
        """Executes all discovery tasks asynchronously with high parallel concurrency."""
        logger.info("starting_discovery_phase")
        self.load_canonical_seeds()

        async with httpx.AsyncClient(follow_redirects=True, proxy=self._get_proxy()) as client:
            tasks = [
                self.discover_internet_archive(client),
                self.discover_aminet(client),
                self.discover_github(client),
                self.discover_itchio(client),
                self.discover_ifdb(client),
                self.discover_zxdb(client),
                self.discover_wikicaad(client),
                self.discover_ifarchive(client),
                self.discover_web_search(client)
            ]
            await asyncio.gather(*tasks, return_exceptions=True)
        logger.info("discovery_phase_complete", total_discovered=len(self.discovered_urls))
