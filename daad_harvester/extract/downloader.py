"""Asynchronous network extraction engine utilizing httpx, tenacity, and connection pooling.

Integration status: this module is NOT YET wired into daad_harvester.fetch.Fetcher (the
active fetch implementation). Known gaps relative to Fetcher, to close before any future
migration replaces it:
  - No Internet Archive Wayback Machine fallback for dead links (Fetcher._query_wayback_cdx).
  - Content-type rejection here checks only the Content-Type header; Fetcher additionally
    sniffs the first response bytes for HTML/JSON magic bytes, which catches servers that
    mislabel error pages as binary content.
  - download_batch() picks one proxy per batch, same limitation as Fetcher._get_proxy():
    httpx.AsyncClient binds `proxy=` once at construction for the whole connection pool,
    so true per-request rotation would need one pooled client per proxy.
"""

import asyncio
import random
import hashlib
from pathlib import Path
from typing import Dict, List, Optional
import httpx
from tenacity import (
    retry,
    retry_if_exception_type,
    stop_after_attempt,
    wait_exponential,
)
from loguru import logger

from daad_harvester.config import settings
from daad_harvester.transform.models import SourceModel, SourceStatus


class TransientNetworkError(Exception):
    """Exception raised for transient HTTP or network failures triggering retry."""
    pass


class RateLimitExceededError(TransientNetworkError):
    """Exception raised when HTTP 429 Rate Limit is encountered."""
    pass


class Downloader:
    """Asynchronous pipeline fetcher with connection pooling, tenacity retries, and rate-limiting."""

    def __init__(
        self,
        download_dir: Path,
        max_concurrent: int = 8,
        user_agents: Optional[List[str]] = None,
        proxies: Optional[List[str]] = None,
    ) -> None:
        """Initializes Downloader with configuration parameters.

        Args:
            download_dir: Directory where downloaded raw binaries are saved.
            max_concurrent: Maximum simultaneous async workers.
            user_agents: List of User-Agent headers to rotate.
            proxies: Optional list of proxy URLs.
        """
        self.download_dir = Path(download_dir)
        self.download_dir.mkdir(parents=True, exist_ok=True)
        self.semaphore = asyncio.Semaphore(max_concurrent)
        self.user_agents = user_agents or settings.user_agents
        self.proxies = proxies or settings.proxy_list
        self._domain_locks: Dict[str, asyncio.Lock] = {}
        self._last_request_time: Dict[str, float] = {}

    def _get_random_headers(self) -> Dict[str, str]:
        """Generates random request headers with rotated User-Agent."""
        ua = random.choice(self.user_agents) if self.user_agents else "DAAD-Harvester/2.0"
        return {
            "User-Agent": ua,
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
            "Accept-Language": "en-US,en;q=0.5",
        }

    def _get_proxy(self) -> Optional[str]:
        """Returns a random proxy URL if available."""
        return random.choice(self.proxies) if self.proxies else None

    async def _rate_limit_domain(self, domain: str) -> None:
        """Enforces per-domain rate limiting."""
        if domain not in self._domain_locks:
            self._domain_locks[domain] = asyncio.Lock()

        async with self._domain_locks[domain]:
            now = asyncio.get_event_loop().time()
            last_time = self._last_request_time.get(domain, 0.0)
            elapsed = now - last_time
            delay = settings.rate_limit_per_domain - elapsed
            if delay > 0:
                await asyncio.sleep(delay)
            self._last_request_time[domain] = asyncio.get_event_loop().time()

    # Bound to `settings` values at class-definition time (import time), which is safe
    # here: unlike parallel_workers/output_dir/log_level, max_retries/backoff_base/
    # backoff_max have no CLI flag and are never mutated after Settings() is
    # constructed, so this always reflects the configured (or DAAD_-env-overridden)
    # value rather than silently hardcoding numbers the rest of the app can't tune.
    @retry(
        retry=retry_if_exception_type(TransientNetworkError),
        stop=stop_after_attempt(settings.max_retries),
        wait=wait_exponential(multiplier=settings.backoff_base, min=settings.backoff_base, max=settings.backoff_max),
        reraise=True,
    )
    async def fetch_url(self, client: httpx.AsyncClient, url: str) -> httpx.Response:
        """Fetches a URL asynchronously with tenacity exponential backoff retries.

        Args:
            client: Shared httpx.AsyncClient instance.
            url: Target URL string.

        Returns:
            httpx.Response object.

        Raises:
            TransientNetworkError: On retryable HTTP status codes (429, 502, 503, 504) or timeout.
            httpx.HTTPStatusError: On non-retryable 4xx errors.
        """
        headers = self._get_random_headers()
        domain = httpx.URL(url).host
        await self._rate_limit_domain(domain)

        try:
            response = await client.get(url, headers=headers, follow_redirects=True, timeout=settings.request_timeout)
            if response.status_code == 429:
                retry_after = response.headers.get("Retry-After")
                wait_secs = float(retry_after) if retry_after and retry_after.isdigit() else 5.0
                logger.warning(f"HTTP 429 Rate limited for {url}. Waiting {wait_secs}s...")
                await asyncio.sleep(wait_secs)
                raise RateLimitExceededError(f"429 Rate limit on {url}")

            if response.status_code in (500, 502, 503, 504):
                raise TransientNetworkError(f"HTTP {response.status_code} server error for {url}")

            response.raise_for_status()
            return response
        except (httpx.TimeoutException, httpx.NetworkError) as exc:
            logger.warning(f"Network error fetching {url}: {exc}")
            raise TransientNetworkError(f"Network error: {exc}") from exc

    async def download_source(self, client: httpx.AsyncClient, source: SourceModel) -> SourceModel:
        """Downloads binary content for a SourceModel entry and writes to disk.

        Args:
            client: Shared httpx.AsyncClient instance.
            source: SourceModel data contract.

        Returns:
            Updated SourceModel instance with file size, sha256, and local file path.
        """
        async with self.semaphore:
            logger.info(f"Downloading source ID {source.id}: {source.url}")
            try:
                response = await self.fetch_url(client, source.url)
                content = response.content

                if not content:
                    source.status = SourceStatus.FAILED
                    source.error_message = "Empty response body"
                    return source

                content_type = response.headers.get("Content-Type", "").lower()
                if "text/html" in content_type and source.role == "media":
                    source.status = SourceStatus.FAILED
                    source.error_message = f"Expected binary media but received HTML (Content-Type: {content_type})"
                    return source

                sha256_hash = hashlib.sha256(content).hexdigest()
                filename = Path(source.url.split("?")[0].split("#")[0]).name or f"source_{source.id}.bin"
                dest_path = self.download_dir / f"{source.id}_{filename}"

                dest_path.write_bytes(content)

                source.status = SourceStatus.FETCHED
                source.content_type = content_type
                source.size_bytes = len(content)
                source.sha256 = sha256_hash
                source.download_path = str(dest_path)
                source.error_message = None
                logger.info(f"Successfully fetched source {source.id} ({len(content)} bytes, SHA256: {sha256_hash[:8]}...)")
            except Exception as exc:
                source.status = SourceStatus.FAILED
                source.error_message = str(exc)
                logger.error(f"Failed fetching source {source.id} ({source.url}): {exc}")

            return source

    async def download_batch(self, sources: List[SourceModel]) -> List[SourceModel]:
        """Executes concurrent downloading for a list of pending sources using connection pooling.

        Args:
            sources: List of SourceModel contracts.

        Returns:
            List of updated SourceModel contracts.
        """
        proxy = self._get_proxy()
        limits = httpx.Limits(max_keepalive_connections=20, max_connections=50)
        # verify defaults to True (httpx's own default). The original version of this
        # module set verify=False unconditionally, silently disabling TLS certificate
        # validation for every request -- a real security regression with no
        # corresponding comment explaining why, found while auditing this PR.
        async with httpx.AsyncClient(proxy=proxy, limits=limits) as client:
            tasks = [self.download_source(client, src) for src in sources]
            return await asyncio.gather(*tasks)
