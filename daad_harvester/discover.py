"""Discovery adapters for publicly accessible DAAD game artifacts.

Each adapter is deliberately conservative: it may add only an HTTP(S) URL whose
path names a format the unpacking phase understands. Search pages, directory
indexes, purchase pages, and unverified static guesses are never queued as
download work items.
"""

from __future__ import annotations

import asyncio
import json
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
from daad_harvester.provenance import EvidenceConfidence, EvidenceKind, SourceRole, VersionEvidence

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
        ".t64",
        ".prg",
        ".p00",
        ".tap",
        ".tzx",
        ".cdt",
        ".adf",
        ".adz",
        ".st",
        ".msa",
        ".cas",
        ".img",
        ".com",
        ".exe",
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
    def _infer_platform_from_artifact_url(url: str) -> Optional[str]:
        """Infer only platform hints that are unambiguous from a direct artifact path."""
        path = unquote(urlparse(url).path).lower()
        if path.endswith((".tap", ".tap.zip", ".tzx", ".tzx.zip", ".cdt", ".cdt.zip")):
            return "zx"
        if path.endswith((".d64", ".d64.zip", ".t64", ".t64.zip")):
            return "c64"
        if path.endswith((".adf", ".adf.zip", ".adz", ".adz.zip")):
            return "amiga"
        if path.endswith((".st", ".st.zip", ".msa", ".msa.zip")):
            return "atarist"
        if any(marker in path for marker in ("plus4", "plus-4", "plus_4")) and path.endswith((".prg", ".prg.zip")):
            return "plus4"
        return None

    @staticmethod
    def _is_supported_artifact_url(url: str, artifact_filename: Optional[str] = None) -> bool:
        """Accept a direct artifact path or a vetted download endpoint with named media."""
        parsed = urlparse(url)
        if parsed.scheme not in {"http", "https"} or not parsed.netloc:
            return False
        path = unquote(parsed.path).lower()
        named_media = (artifact_filename or "").casefold()
        return any(path.endswith(suffix) for suffix in SUPPORTED_SOURCE_SUFFIXES) or any(
            named_media.endswith(suffix) for suffix in SUPPORTED_SOURCE_SUFFIXES
        )

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
        *,
        source_name: Optional[str] = None,
        source_record_url: Optional[str] = None,
        source_release_id: Optional[str] = None,
        release_version: Optional[str] = None,
        toolchain_claim: Optional[str] = None,
        provenance_json: Optional[str] = None,
        artifact_filename: Optional[str] = None,
    ) -> bool:
        """Persist one new supported direct download and report whether it was inserted."""
        canonical_url = self._canonical_url(url)
        if not self._is_supported_artifact_url(canonical_url, artifact_filename):
            logger.info("skipping_non_artifact_source", url=url)
            return False
        if canonical_url in self.discovered_urls or self.db.source_exists(canonical_url):
            logger.info("skipping_duplicate_source", url=canonical_url)
            return False

        platform = platform or self._infer_platform_from_artifact_url(canonical_url)
        known_game = find_known_game(title)
        if known_game:
            title = known_game.title
            year = year or known_game.year
            publisher = publisher or known_game.publisher

        source_id = self.db.add_source(
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
            source_name=source_name,
            source_role=SourceRole.GAME_MEDIA.value,
            source_record_url=source_record_url,
            source_release_id=source_release_id,
            release_version=release_version,
            toolchain_claim=toolchain_claim,
            provenance_json=provenance_json,
        )
        if source_id is not None:
            self._record_source_provenance(
                source_id, canonical_url, platform, release_version, toolchain_claim
            )
        self.discovered_urls.add(canonical_url)
        logger.info("discovered_source", url=canonical_url, tier=tier.value, title=title)
        return True

    def _record_source_provenance(
        self,
        source_id: int,
        source_url: str,
        platform: Optional[str],
        release_version: Optional[str],
        toolchain_claim: Optional[str],
    ) -> None:
        """Persist each discovery claim separately from later binary measurements."""
        if platform:
            self.db.add_version_evidence(
                VersionEvidence(
                    kind=EvidenceKind.PLATFORM_RELEASE.value,
                    value=platform,
                    confidence=EvidenceConfidence.STRONG.value,
                    source_url=source_url,
                    source_id=source_id,
                )
            )
        if release_version:
            self.db.add_version_evidence(
                VersionEvidence(
                    kind=EvidenceKind.RELEASE_VERSION.value,
                    value=release_version,
                    confidence=EvidenceConfidence.STRONG.value,
                    source_url=source_url,
                    source_id=source_id,
                )
            )
        if toolchain_claim:
            self.db.add_version_evidence(
                VersionEvidence(
                    kind=EvidenceKind.TOOLCHAIN_CLAIM.value,
                    value=toolchain_claim,
                    confidence=EvidenceConfidence.STRONG.value,
                    source_url=source_url,
                    source_id=source_id,
                )
            )

    def _add_catalog_record(
        self,
        url: str,
        tier: SourceTier,
        *,
        title: Optional[str],
        platform: Optional[str],
        source_name: str,
        source_role: SourceRole = SourceRole.RELEASE_CATALOG,
        source_release_id: Optional[str] = None,
        release_version: Optional[str] = None,
        toolchain_claim: Optional[str] = None,
        publisher: Optional[str] = None,
        provenance_json: Optional[str] = None,
    ) -> bool:
        """Persist a public catalog page as non-fetchable source evidence."""
        canonical_url = self._canonical_url(url)
        if canonical_url in self.discovered_urls or self.db.source_exists(canonical_url):
            return False
        known_game = find_known_game(title)
        source_id = self.db.add_source(
            url=canonical_url,
            source_tier=tier.value,
            initial_status="cataloged",
            title=known_game.title if known_game else title,
            platform=platform,
            publisher=publisher or (known_game.publisher if known_game else None),
            known_game_id=known_game.game_id if known_game else None,
            acquisition_priority=catalog_priority(known_game, platform),
            source_name=source_name,
            source_role=source_role.value,
            source_record_url=canonical_url,
            source_release_id=source_release_id,
            release_version=release_version,
            toolchain_claim=toolchain_claim,
            provenance_json=provenance_json,
        )
        if source_id is None:
            return False
        self._record_source_provenance(source_id, canonical_url, platform, release_version, toolchain_claim)
        self.discovered_urls.add(canonical_url)
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

    @staticmethod
    def _platform_from_archive_metadata(metadata: Dict[str, Any]) -> Optional[str]:
        """Infer a canonical target only from explicit IA collection/emulator metadata."""
        collections = " ".join(str(item).lower() for item in metadata.get("collection") or [])
        emulator = str(metadata.get("emulator") or "").lower()
        evidence = f"{collections} {emulator}"
        platform_markers = (
            ("plus4", ("plus4", "plus/4", "c16")),
            ("zx", ("spectrum", "sinclair", "zx")),
            ("cpc", ("amstrad_cpc", "cpc")),
            ("c64", ("commodore_64", "c64", "cbm64")),
            ("msx", ("msx",)),
            ("pcw", ("pcw",)),
            ("atarist", ("atari_st", "atarist")),
            ("amiga", ("amiga",)),
            ("dos", ("msdos", "ms-dos", "ibm_pc", "softwarelibrary_dos", "dosbox")),
        )
        for platform, markers in platform_markers:
            if any(marker in evidence for marker in markers):
                return platform
        return None

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
                metadata_fields = (metadata or {}).get("metadata") or {}
                archive_platform = self._platform_from_archive_metadata(metadata_fields)
                release_version = str(metadata_fields.get("version") or "").strip() or None
                files = (metadata or {}).get("files") or (metadata or {}).get("result") or []
                for file_info in files:
                    filename = file_info.get("name") or ""
                    download_url = f"https://archive.org/download/{quote(identifier, safe='')}/{quote(filename, safe='/')}"
                    if self._add_source(
                        download_url,
                        SourceTier.ARCHIVE,
                        title=title,
                        platform=archive_platform,
                        source_name="Internet Archive",
                        source_record_url=metadata_url,
                        source_release_id=str(identifier),
                        release_version=release_version,
                    ):
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
                if self._is_daad_related(title, href) and "/package/" in urlparse(full_url).path:
                    if self._add_catalog_record(
                        full_url,
                        SourceTier.ARCHIVE,
                        title=title or "Aminet DAAD package",
                        platform="amiga",
                        source_name="Aminet",
                        source_role=SourceRole.TOOL_DISTRIBUTION,
                        toolchain_claim="DAAD runtime/package",
                        provenance_json='{"adapter": "aminet", "tool_distribution": true}',
                    ):
                        inserted += 1
        self.logger_suite.log_discovery("AMINET AMIGA", url, inserted)
        return inserted

    @staticmethod
    def _page_title(soup: BeautifulSoup, fallback: str) -> str:
        """Extract a bounded human-readable title from a catalog page."""
        for selector in ("h1", "h2", "title"):
            node = soup.select_one(selector)
            if node and node.get_text(" ", strip=True):
                return node.get_text(" ", strip=True)[:200]
        return fallback

    async def discover_csdb(self, client: httpx.AsyncClient) -> int:
        """Discover direct C64 DAAD media through CSDb's public download endpoint."""
        search_url = "https://csdb.dk/search/?search=daad"
        content = await self._fetch_url(client, search_url)
        if not content:
            self.logger_suite.log_discovery("CSDB C64", search_url, 0, status="UNAVAILABLE")
            return 0
        soup = BeautifulSoup(content, "html.parser")
        title = self._page_title(soup, "CSDb DAAD release")
        inserted = 0
        for anchor in soup.find_all("a", href=True):
            href = urljoin(search_url, anchor["href"])
            filename = anchor.get_text(" ", strip=True)
            if "/release/download.php" not in urlparse(href).path:
                continue
            if not self._is_supported_artifact_url(href, filename):
                continue
            if self._add_source(
                href,
                SourceTier.ARCHIVE,
                title=title,
                platform="c64",
                source_name="CSDb",
                source_record_url=search_url,
                artifact_filename=filename,
                provenance_json='{"adapter": "csdb", "direct_download_endpoint": true}',
            ):
                inserted += 1
        self.logger_suite.log_discovery("CSDB C64", search_url, inserted)
        return inserted

    async def discover_plus4world(self, client: httpx.AsyncClient) -> int:
        """Discover Plus/4 DAAD media from verified Plus/4 World detail pages."""
        search_url = "https://plus4world.powweb.com/search/notes/DAAD"
        content = await self._fetch_url(client, search_url)
        if not content:
            self.logger_suite.log_discovery("PLUS/4 WORLD", search_url, 0, status="UNAVAILABLE")
            return 0
        search_soup = BeautifulSoup(content, "html.parser")
        detail_urls = {
            self._canonical_url(urljoin(search_url, anchor["href"]))
            for anchor in search_soup.find_all("a", href=True)
            if "/software/" in urlparse(urljoin(search_url, anchor["href"])).path
        }
        inserted = 0
        for detail_url in sorted(detail_urls)[:50]:
            detail = await self._fetch_url(client, detail_url)
            if not detail or "daad" not in detail.lower():
                continue
            detail_soup = BeautifulSoup(detail, "html.parser")
            title = self._page_title(detail_soup, "Plus/4 World DAAD release")
            cataloged = self._add_catalog_record(
                detail_url,
                SourceTier.API,
                title=title,
                platform="plus4",
                source_name="Plus/4 World",
                provenance_json='{"adapter": "plus4world", "daad_page_text": true}',
            )
            inserted += int(cataloged)
            for anchor in detail_soup.find_all("a", href=True):
                download_url = urljoin(detail_url, anchor["href"])
                filename = anchor.get_text(" ", strip=True)
                if self._add_source(
                    download_url,
                    SourceTier.ARCHIVE,
                    title=title,
                    platform="plus4",
                    source_name="Plus/4 World",
                    source_record_url=detail_url,
                    artifact_filename=filename,
                ):
                    inserted += 1
        self.logger_suite.log_discovery("PLUS/4 WORLD", search_url, inserted)
        return inserted

    async def discover_generation_msx(self, client: httpx.AsyncClient) -> int:
        """Record MSX Aventuras AD catalog pages as non-fetchable platform evidence."""
        catalog_url = "https://www.generation-msx.nl/company/aventuras-ad/292/software/"
        content = await self._fetch_url(client, catalog_url)
        if not content:
            self.logger_suite.log_discovery("GENERATION MSX", catalog_url, 0, status="UNAVAILABLE")
            return 0
        soup = BeautifulSoup(content, "html.parser")
        inserted = 0
        for anchor in soup.find_all("a", href=True):
            detail_url = self._canonical_url(urljoin(catalog_url, anchor["href"]))
            title = anchor.get_text(" ", strip=True)
            if not title or "/software/" not in urlparse(detail_url).path:
                continue
            if self._add_catalog_record(
                detail_url,
                SourceTier.API,
                title=title,
                platform="msx",
                source_name="Generation MSX",
                publisher="Aventuras AD",
                provenance_json='{"adapter": "generation_msx", "publisher_catalog": true}',
            ):
                inserted += 1
        self.logger_suite.log_discovery("GENERATION MSX", catalog_url, inserted)
        return inserted

    async def discover_computeremuzone(self, client: httpx.AsyncClient) -> int:
        """Discover per-target DAAD media through Computer Emuzone's engine index.

        Its `download.php?ind=` endpoints do not expose a suffix.  They are only
        admitted when found in the maintained DAAD engine table, with the
        adjacent platform badge supplying the expected media type and platform.
        """
        index_url = "https://computeremuzone.com/engine/daad?l=en"
        content = await self._fetch_url(client, index_url)
        if not content:
            self.logger_suite.log_discovery("COMPUTER EMUZONE", index_url, 0, status="UNAVAILABLE")
            return 0
        platform_badges = {
            "SP": "zx",
            "AMS": "cpc",
            "C64": "c64",
            "MSX": "msx",
            "MSX2": "msx",
            "PCW": "pcw",
            "ST": "atarist",
            "AG": "amiga",
            "PC": "dos",
        }
        soup = BeautifulSoup(content, "html.parser")
        inserted = 0
        seen: Set[tuple[str, str]] = set()
        for title_anchor in soup.find_all("a", href=True):
            game_url = self._canonical_url(urljoin(index_url, title_anchor["href"]))
            if "/ficha/" not in urlparse(game_url).path:
                continue
            title = title_anchor.get_text(" ", strip=True)
            if not title:
                continue
            row = title_anchor.find_parent("tr")
            if row is None:
                continue
            for download_anchor in row.find_all("a", href=True):
                download_url = self._canonical_url(urljoin(index_url, download_anchor["href"]))
                if "/download.php" not in urlparse(download_url).path:
                    continue
                badge = download_anchor.get_text(" ", strip=True).upper()
                platform = platform_badges.get(badge)
                if not platform or (download_url, platform) in seen:
                    continue
                seen.add((download_url, platform))
                release_id = (urlparse(download_url).query.split("ind=")[-1] or None)
                if self._add_source(
                    download_url,
                    SourceTier.ARCHIVE,
                    title=title,
                    platform=platform,
                    source_name="Computer Emuzone",
                    source_record_url=game_url,
                    source_release_id=release_id,
                    artifact_filename=f"{platform}.zip",
                    provenance_json=json.dumps({"adapter": "computeremuzone", "platform_badge": badge}),
                ):
                    inserted += 1
        self.logger_suite.log_discovery("COMPUTER EMUZONE", index_url, inserted)
        return inserted

    async def discover_atarimania(self, client: httpx.AsyncClient) -> int:
        """Catalog public Atari ST DAAD records returned by the maintained site search endpoint."""
        search_url = "https://www.atarimania.com/list_games_atari-st-_DAAD.html"
        content = await self._fetch_url(client, search_url)
        if not content:
            self.logger_suite.log_discovery("ATARIMANIA ST", search_url, 0, status="UNAVAILABLE")
            return 0
        soup = BeautifulSoup(content, "html.parser")
        inserted = 0
        for anchor in soup.find_all("a", href=True):
            detail_url = self._canonical_url(urljoin(search_url, anchor["href"]))
            title = anchor.get_text(" ", strip=True)
            if not title or "/game-atari-st-" not in urlparse(detail_url).path:
                continue
            if self._add_catalog_record(
                detail_url,
                SourceTier.API,
                title=title,
                platform="atarist",
                source_name="Atarimania",
                provenance_json='{"adapter": "atarimania", "platform": "atari-st"}',
            ):
                inserted += 1
        self.logger_suite.log_discovery("ATARIMANIA ST", search_url, inserted)
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

    @staticmethod
    def _platforms_from_page_text(text: str) -> tuple[str, ...]:
        """Extract only explicit official-target names from public release text."""
        lowered = text.casefold()
        markers = (
            ("zx", ("zx spectrum", "spectrum")),
            ("cpc", ("amstrad cpc", "cpc")),
            ("c64", ("commodore 64", "c64")),
            ("plus4", ("plus/4", "plus4", "c16")),
            ("msx", ("msx",)),
            ("pcw", ("amstrad pcw", "pcw")),
            ("atarist", ("atari st",)),
            ("amiga", ("amiga",)),
            ("dos", ("ms-dos", "dos", "ibm pc")),
        )
        return tuple(platform for platform, names in markers if any(name in lowered for name in names))

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
                page_text = game_soup.get_text(" ", strip=True)
                if not self._is_daad_related(page_text):
                    continue
                title = self._page_title(game_soup, "itch.io DAAD release")
                platforms = self._platforms_from_page_text(page_text)
                release_match = re.search(r"(?:version|release|revision)\s*[vr]?(\d+(?:\.\d+)*)", page_text, re.I)
                release_version = release_match.group(1) if release_match else None
                cataloged = self._add_catalog_record(
                    game_url,
                    SourceTier.FORUM,
                    title=title,
                    platform=platforms[0] if len(platforms) == 1 else None,
                    source_name="itch.io",
                    release_version=release_version,
                    provenance_json=json.dumps({"adapter": "itchio", "platforms": platforms}),
                )
                inserted += int(cataloged)
                for platform in platforms:
                    for source in self.db.get_all_sources():
                        if source.url == game_url and source.id is not None:
                            self.db.add_version_evidence(
                                VersionEvidence(
                                    kind=EvidenceKind.PLATFORM_RELEASE.value,
                                    value=platform,
                                    confidence=EvidenceConfidence.STRONG.value,
                                    source_url=game_url,
                                    source_id=source.id,
                                )
                            )
                for link in game_soup.find_all("a", href=True):
                    download_url = urljoin(game_url, link["href"])
                    filename = link.get_text(" ", strip=True)
                    if self._add_source(
                        download_url,
                        SourceTier.FORUM,
                        title=title,
                        platform=platforms[0] if len(platforms) == 1 else None,
                        source_name="itch.io",
                        source_record_url=game_url,
                        release_version=release_version,
                        artifact_filename=filename,
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
            "csdb": self.discover_csdb,
            "plus4world": self.discover_plus4world,
            "generation_msx": self.discover_generation_msx,
            "computeremuzone": self.discover_computeremuzone,
            "atarimania": self.discover_atarimania,
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
