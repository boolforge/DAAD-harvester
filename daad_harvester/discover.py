"""Discovery adapters for publicly accessible DAAD game artifacts.

Each adapter is deliberately conservative: it may add only an HTTP(S) URL whose
path names a format the unpacking phase understands. Search pages, directory
indexes, purchase pages, and unverified static guesses are never queued as
download work items.
"""

from __future__ import annotations

import asyncio
import random
import re
from typing import Any, Dict, Iterable, Optional, Set
from urllib.parse import quote, unquote, urljoin, urlparse

import httpx
import structlog
from bs4 import BeautifulSoup

from daad_harvester.config import settings
from daad_harvester.daad_logger import LoggerSuite
from daad_harvester.db import Database
from daad_harvester.models import SourceTier
from daad_harvester.seeds import CANONICAL_DAAD_SEEDS
from daad_harvester.known_games import acquisition_priority as catalog_priority, find_known_game

logger = structlog.get_logger(__name__)


SUPPORTED_SOURCE_SUFFIXES = frozenset(
    {
        ".zip",
        ".7z",
        ".rar",
        ".tar",
        ".gz",
        ".tgz",
        ".bz2",
        ".xz",
        ".arj",
        ".lha",
        ".lzh",
        ".zoo",
        ".arc",
        ".cab",
        ".dsk",
        ".d64",
        ".tap",
        ".tzx",
        ".adf",
        ".st",
        ".ddb",
    }
)

DAAD_USER_AGENT = "DAAD-Harvester/1.0 (+https://github.com/boolforge/DAAD-harvester)"
ARCHIVE_METADATA_URL = "https://archive.org/metadata/{identifier}"
ZXINFO_SEARCH_URL = "https://api.zxinfo.dk/v3/search"
SPECTRUM_COMPUTING_BASE_URL = "https://spectrumcomputing.co.uk"
WORLD_OF_SPECTRUM_PUBLISHER_URL = "https://worldofspectrum.org/archive/publishers/Aventuras-AD-SA"


class RateLimiter:
    """Coordinates independent per-domain request schedules without global sleeps."""

    def __init__(self, rate_limit_per_second: float = 2.0):
        self.interval = 1.0 / max(rate_limit_per_second, 0.1)
        self.last_called: Dict[str, float] = {}
        self._lock = asyncio.Lock()

    async def acquire(self, domain: str) -> None:
        loop = asyncio.get_running_loop()
        async with self._lock:
            now = loop.time()
            next_allowed = self.last_called.get(domain, 0.0) + self.interval
            wait_for = max(0.0, next_allowed - now)
            # Reserve the time slot before sleeping. Requests for another
            # domain can now calculate their own schedule immediately.
            self.last_called[domain] = now + wait_for
        if wait_for:
            await asyncio.sleep(wait_for)


class Discoverer:
    """Finds downloadable DAAD-related artifacts from independently validated sources."""

    def __init__(self, db: Database):
        self.db = db
        self.rate_limiter = RateLimiter(settings.rate_limit_per_domain)
        self.discovered_urls: Set[str] = set()
        self.logger_suite = LoggerSuite(settings.logs_dir)

    def _get_proxy(self) -> Optional[str]:
        """Choose one proxy for this discovery run when a proxy list is configured."""
        return random.choice(settings.proxy_list) if settings.proxy_list else None

    @staticmethod
    def _canonical_url(url: str) -> str:
        """Normalize insignificant fragments while preserving query-bearing downloads."""
        return url.strip().split("#", 1)[0]

    @staticmethod
    def _is_supported_artifact_url(url: str) -> bool:
        parsed = urlparse(url)
        if parsed.scheme not in {"http", "https"} or not parsed.netloc:
            return False
        path = unquote(parsed.path).lower()
        return any(path.endswith(suffix) for suffix in SUPPORTED_SOURCE_SUFFIXES)

    @staticmethod
    def _is_daad_related(*values: Any) -> bool:
        """Reject obvious homonyms while retaining DAAD games, tools, and authorship metadata."""
        text = " ".join(str(value or "") for value in values).lower()
        normalized = re.sub(r"[^a-z0-9]+", " ", text).strip()
        if any(
            marker in normalized
            for marker in (
                "raad en daad",
                "daad scholarship",
                "german university",
                "university course",
                "study in germany",
            )
        ):
            return False
        return any(
            marker in text
            for marker in (
                "daad",
                "ddb",
                "aventuras ad",
                "msx2daad",
                "maluva",
                "undaad",
                "gilsoft",
            )
        )

    async def _fetch_url(
        self, client: httpx.AsyncClient, url: str, is_json: bool = False
    ) -> Optional[Any]:
        """Fetch text or JSON with bounded retries and source-visible diagnostics."""
        domain = urlparse(url).netloc
        await self.rate_limiter.acquire(domain)
        headers = {
            "User-Agent": DAAD_USER_AGENT,
            "Accept": "application/json" if is_json else "text/html,application/xhtml+xml;q=0.9,*/*;q=0.7",
        }

        for attempt in range(1, settings.max_retries + 1):
            try:
                logger.info("fetching_discovery_url", url=url, attempt=attempt)
                response = await client.get(
                    url,
                    headers=headers,
                    follow_redirects=True,
                    timeout=settings.request_timeout,
                )
                if response.status_code == 200:
                    try:
                        return response.json() if is_json else response.text
                    except ValueError as exc:
                        logger.warning("discovery_invalid_payload", url=url, error=str(exc))
                        return None
                if response.status_code in (404, 410):
                    logger.warning("discovery_url_not_found", url=url, status_code=response.status_code)
                    return None
                logger.warning("discovery_url_http_error", url=url, status_code=response.status_code)
            except httpx.HTTPError as exc:
                logger.warning("discovery_fetch_exception", url=url, error=str(exc))

            if attempt < settings.max_retries:
                backoff = min(
                    settings.backoff_base * (2 ** (attempt - 1)) + random.uniform(0, 0.5),
                    settings.backoff_max,
                )
                await asyncio.sleep(backoff)
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
        language: Optional[str] = None,
    ) -> bool:
        """Persist one new supported direct download and report whether it was inserted."""
        canonical_url = self._canonical_url(url)
        if not self._is_supported_artifact_url(canonical_url):
            logger.info("skipping_non_artifact_source", url=url)
            return False
        if canonical_url in self.discovered_urls or self.db.source_exists(canonical_url):
            logger.info("skipping_duplicate_source", url=canonical_url)
            return False

        known_game = find_known_game(title)
        if known_game:
            title = known_game.title
            year = year or known_game.year
            publisher = publisher or known_game.publisher

        self.db.add_source(
            url=canonical_url,
            source_tier=tier.value,
            title=title,
            platform=platform,
            year=year,
            publisher=publisher,
            author=author,
            language=language,
            known_game_id=known_game.game_id if known_game else None,
            acquisition_priority=catalog_priority(known_game, platform),
        )
        self.discovered_urls.add(canonical_url)
        logger.info("discovered_source", url=canonical_url, tier=tier.value, title=title)
        return True

    def load_canonical_seeds(self) -> int:
        """Load only manually verified direct-download seeds, if a maintainer adds any."""
        inserted = 0
        for seed in CANONICAL_DAAD_SEEDS:
            inserted += self._add_source(
                url=seed["url"],
                tier=SourceTier.API,
                title=seed.get("title"),
                platform=seed.get("platform"),
                year=seed.get("year"),
                publisher=seed.get("publisher"),
                author=seed.get("author"),
                language=seed.get("language"),
            )
        self.logger_suite.log_discovery(
            "MANUAL VERIFIED SEEDS", "built-in", inserted, status="OK"
        )
        return inserted

    async def discover_internet_archive(self, client: httpx.AsyncClient) -> int:
        """Discover supported artifacts via Internet Archive search and canonical metadata."""
        queries = (
            'title:("Aventuras AD") AND mediatype:software',
            'title:("DAAD Ready") AND mediatype:software',
            'creator:("Aventuras AD") AND mediatype:software',
        )
        inserted = 0
        for query in queries:
            params = {
                "q": query,
                "fl[]": ["identifier", "title"],
                "rows": 50,
                "page": 1,
                "output": "json",
            }
            url = f"https://archive.org/advancedsearch.php?{httpx.QueryParams(params)}"
            data = await self._fetch_url(client, url, is_json=True)
            documents = ((data or {}).get("response") or {}).get("docs") or []
            for document in documents:
                identifier = document.get("identifier")
                title = document.get("title") or identifier
                if not identifier or not self._is_daad_related(title):
                    continue
                metadata_url = ARCHIVE_METADATA_URL.format(identifier=quote(identifier, safe=""))
                metadata = await self._fetch_url(client, metadata_url, is_json=True)
                files = (metadata or {}).get("files") or (metadata or {}).get("result") or []
                for file_info in files:
                    filename = file_info.get("name") or ""
                    download_url = f"https://archive.org/download/{quote(identifier, safe='')}/{quote(filename, safe='/')}"
                    if self._add_source(download_url, SourceTier.ARCHIVE, title=title):
                        inserted += 1
        self.logger_suite.log_discovery("INTERNET ARCHIVE", "archive.org", inserted)
        return inserted

    async def discover_aminet(self, client: httpx.AsyncClient) -> int:
        """Discover Amiga DAAD tooling and artifacts from Aminet's DAAD search."""
        url = "https://aminet.net/search?query=daad"
        content = await self._fetch_url(client, url)
        inserted = 0
        if content:
            soup = BeautifulSoup(content, "html.parser")
            for anchor in soup.find_all("a", href=True):
                href = anchor["href"]
                title = anchor.get_text(" ", strip=True)
                full_url = urljoin(url, href)
                if self._is_daad_related(title, href) and self._add_source(
                    full_url, SourceTier.ARCHIVE, title=title or None, platform="amiga"
                ):
                    inserted += 1
        self.logger_suite.log_discovery("AMINET AMIGA", url, inserted)
        return inserted

    async def discover_github(self, client: httpx.AsyncClient) -> int:
        """Discover DAAD repositories through GitHub's public repository search API."""
        queries = ("\"DAAD Ready\"", "daad aventura", "topic:daad", "topic:daad-ready", "topic:aventuras-ad")
        inserted = 0
        for query in queries:
            url = f"https://api.github.com/search/repositories?{httpx.QueryParams({'q': query, 'sort': 'updated'})}"
            data = await self._fetch_url(client, url, is_json=True)
            for repo in (data or {}).get("items") or []:
                repo_name = repo.get("name") or ""
                description = repo.get("description") or ""
                owner = (repo.get("owner") or {}).get("login")
                if not owner or not repo_name or not self._is_daad_related(repo_name, description):
                    continue
                branch = repo.get("default_branch") or "main"
                archive_url = (
                    f"https://github.com/{quote(owner, safe='')}/{quote(repo_name, safe='')}"
                    f"/archive/refs/heads/{quote(branch, safe='/')}.zip"
                )
                if self._add_source(archive_url, SourceTier.API, title=repo_name):
                    inserted += 1
        self.logger_suite.log_discovery("GITHUB REPOSITORIES", "api.github.com", inserted)
        return inserted

    async def discover_itchio(self, client: httpx.AsyncClient) -> int:
        """Inspect public DAAD tag pages without queueing purchase or game pages as files."""
        inserted = 0
        seen_game_pages: Set[str] = set()
        for tag in ("daad", "daad-ready", "aventuras-ad"):
            listing_url = f"https://itch.io/games/tag-{tag}"
            content = await self._fetch_url(client, listing_url)
            if not content:
                continue
            soup = BeautifulSoup(content, "html.parser")
            for anchor in soup.find_all("a", href=True):
                game_url = self._canonical_url(urljoin(listing_url, anchor["href"]))
                parsed = urlparse(game_url)
                path_parts = [part for part in parsed.path.split("/") if part]
                if (
                    parsed.netloc == "itch.io"
                    or not parsed.netloc.endswith(".itch.io")
                    or len(path_parts) != 1
                    or game_url in seen_game_pages
                ):
                    continue
                seen_game_pages.add(game_url)
                game_page = await self._fetch_url(client, game_url)
                if not game_page:
                    continue
                game_soup = BeautifulSoup(game_page, "html.parser")
                for link in game_soup.find_all("a", href=True):
                    download_url = urljoin(game_url, link["href"])
                    if self._add_source(
                        download_url,
                        SourceTier.FORUM,
                        title=link.get_text(" ", strip=True) or None,
                    ):
                        inserted += 1
        self.logger_suite.log_discovery("ITCH.IO", "itch.io", inserted)
        return inserted

    async def discover_ifdb(self, client: httpx.AsyncClient) -> int:
        """Discover directly linked DAAD archives from IFDB's XML search endpoint."""
        inserted = 0
        for tag in ("daad", "daad ready", "aventuras ad"):
            url = f"https://ifdb.org/search?{httpx.QueryParams({'searchfor': f'tag:{tag}', 'xml': 1})}"
            content = await self._fetch_url(client, url)
            if not content:
                continue
            soup = BeautifulSoup(content, "xml")
            for game in soup.find_all("game"):
                title_node = game.find("title")
                title = title_node.get_text(strip=True) if title_node else "IFDB DAAD game"
                for link in game.find_all("url"):
                    if self._add_source(link.get_text(strip=True), SourceTier.API, title=title):
                        inserted += 1
        self.logger_suite.log_discovery("IFDB", "ifdb.org", inserted)
        return inserted

    @staticmethod
    def _iter_zxinfo_files(hits: Iterable[Dict[str, Any]]) -> Iterable[tuple[str, str]]:
        """Yield title/path pairs from the documented ZXInfo v3 full-search response."""
        for hit in hits:
            entry = hit.get("_source", hit)
            title = entry.get("title") or "ZXInfo DAAD artifact"
            authored_with = " ".join(
                item.get("title", "") for item in entry.get("authoredWith", [])
            )
            if not Discoverer._is_daad_related(title, entry.get("remarks"), authored_with):
                continue
            for release in entry.get("releases", []) or []:
                for file_info in release.get("files", []) or []:
                    path = file_info.get("path")
                    path_lower = unquote(path or "").lower()
                    is_snapshot = path_lower.endswith((".z80", ".z80.zip", ".sna", ".sna.zip", ".szx", ".szx.zip"))
                    is_other_engine = any(engine in path_lower for engine in ("paws", "quill", "gac", "swan"))
                    if path and not is_snapshot and not is_other_engine:
                        yield title, path

    async def discover_zxdb(self, client: httpx.AsyncClient) -> int:
        """Discover ZX Spectrum artifacts through the documented ZXInfo v3 search API."""
        inserted = 0
        for query in ("DAAD", "Aventuras AD"):
            url = f"{ZXINFO_SEARCH_URL}?{httpx.QueryParams({'query': query, 'contenttype': 'SOFTWARE', 'mode': 'full', 'size': 100})}"
            data = await self._fetch_url(client, url, is_json=True)
            hits = ((data or {}).get("hits") or {}).get("hits") or []
            for title, path in self._iter_zxinfo_files(hits):
                download_url = urljoin(SPECTRUM_COMPUTING_BASE_URL, path)
                if self._add_source(download_url, SourceTier.API, title=title, platform="zx"):
                    inserted += 1
        self.logger_suite.log_discovery("ZXINFO ZXDB", "api.zxinfo.dk", inserted)
        return inserted

    async def discover_wikicaad(self, client: httpx.AsyncClient) -> int:
        """Discover direct archives linked by WikiCAAD pages returned from its MediaWiki API."""
        api_url = "https://wiki.caad.es/api.php?action=query&list=search&srsearch=DAAD&format=json"
        data = await self._fetch_url(client, api_url, is_json=True)
        inserted = 0
        for item in ((data or {}).get("query") or {}).get("search") or []:
            title = item.get("title")
            if not title:
                continue
            page_url = f"https://wiki.caad.es/{quote(title.replace(' ', '_'))}"
            content = await self._fetch_url(client, page_url)
            if not content:
                continue
            soup = BeautifulSoup(content, "html.parser")
            for anchor in soup.find_all("a", href=True):
                if self._add_source(urljoin(page_url, anchor["href"]), SourceTier.API, title=title):
                    inserted += 1
        self.logger_suite.log_discovery("WIKICAAD", api_url, inserted)
        return inserted

    async def discover_world_of_spectrum(self, client: httpx.AsyncClient) -> int:
        """Discover direct ZX artifacts from World of Spectrum's Aventuras AD catalogue.

        The adapter starts from the publisher's bounded catalogue, then verifies
        the DAAD authorship statement on every game detail page. It does not
        crawl general Spectrum directories or queue the page URLs themselves.
        """
        content = await self._fetch_url(client, WORLD_OF_SPECTRUM_PUBLISHER_URL)
        inserted = 0
        if not content:
            self.logger_suite.log_discovery(
                "WORLD OF SPECTRUM", WORLD_OF_SPECTRUM_PUBLISHER_URL, inserted, status="UNAVAILABLE"
            )
            return inserted

        publisher_soup = BeautifulSoup(content, "html.parser")
        game_pages: Dict[str, str] = {}
        for anchor in publisher_soup.find_all("a", href=True):
            game_url = self._canonical_url(urljoin(WORLD_OF_SPECTRUM_PUBLISHER_URL, anchor["href"]))
            if "/archive/software/text-adventures/" not in urlparse(game_url).path:
                continue
            title = anchor.get_text(" ", strip=True)
            if title:
                game_pages[game_url] = title

        for game_url, title in game_pages.items():
            game_page = await self._fetch_url(client, game_url)
            if not game_page:
                continue
            game_soup = BeautifulSoup(game_page, "html.parser")
            if "authored with daad" not in game_soup.get_text(" ", strip=True).lower():
                continue
            for anchor in game_soup.find_all("a", href=True):
                artifact_url = urljoin(game_url, anchor["href"])
                parsed_artifact = urlparse(artifact_url)
                artifact_path = unquote(parsed_artifact.path).lower()
                if (
                    parsed_artifact.netloc not in {"worldofspectrum.org", "www.worldofspectrum.org"}
                    or not artifact_path.endswith((".tap.zip", ".tzx.zip", ".dsk.zip"))
                ):
                    continue
                if self._add_source(artifact_url, SourceTier.ARCHIVE, title=title, platform="zx"):
                    inserted += 1

        self.logger_suite.log_discovery(
            "WORLD OF SPECTRUM", WORLD_OF_SPECTRUM_PUBLISHER_URL, inserted
        )
        return inserted

    async def discover_ifarchive(self, client: httpx.AsyncClient) -> int:
        """Do not crawl IF Archive until a DAAD-specific, maintained index is available."""
        del client
        self.logger_suite.log_discovery(
            "IF ARCHIVE", "ifarchive.org", 0, status="SKIPPED_UNVERIFIED_INDEX",
            details="No maintained DAAD-specific IF Archive index is currently configured.",
        )
        return 0

    async def discover_web_search(self, client: httpx.AsyncClient) -> int:
        """Use DuckDuckGo HTML only as a conservative direct-file fallback."""
        inserted = 0
        for query in (
            "DAAD adventure game download .dsk .tap .tzx .ddb",
            "Aventuras AD DAAD games spectrum cpc amiga dos",
            "DAAD Ready games zip download",
        ):
            search_url = f"https://html.duckduckgo.com/html/?q={quote(query)}"
            content = await self._fetch_url(client, search_url)
            if not content:
                continue
            soup = BeautifulSoup(content, "html.parser")
            for anchor in soup.select("a.result__a, a.result__url"):
                href = anchor.get("href", "")
                match = re.search(r"[?&]uddg=([^&]+)", href)
                if match:
                    href = unquote(match.group(1))
                if self._add_source(href, SourceTier.FORUM, title=anchor.get_text(" ", strip=True) or None):
                    inserted += 1
        self.logger_suite.log_discovery("WEB SEARCH FALLBACK", "duckduckgo.com", inserted)
        return inserted

    async def run_all_discovery(self) -> None:
        """Run all configured adapters and surface individual adapter failures in the log."""
        logger.info("starting_discovery_phase")
        self.load_canonical_seeds()
        crawlers = {
            "internet_archive": self.discover_internet_archive,
            "aminet": self.discover_aminet,
            "github": self.discover_github,
            "itchio": self.discover_itchio,
            "ifdb": self.discover_ifdb,
            "zxinfo": self.discover_zxdb,
            "wikicaad": self.discover_wikicaad,
            "world_of_spectrum": self.discover_world_of_spectrum,
            "ifarchive": self.discover_ifarchive,
            "web_search": self.discover_web_search,
        }
        async with httpx.AsyncClient(follow_redirects=True, proxy=self._get_proxy()) as client:
            names = list(crawlers)
            results = await asyncio.gather(
                *(crawlers[name](client) for name in names), return_exceptions=True
            )
        for name, result in zip(names, results):
            if isinstance(result, Exception):
                logger.error("discovery_adapter_failed", adapter=name, error=str(result))
        logger.info("discovery_phase_complete", total_discovered=len(self.discovered_urls))
