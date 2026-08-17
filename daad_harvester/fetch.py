"""Resilient downloader module with proxy rotation, wayback fallback, and deduplication."""

import asyncio
import hashlib
import random
from pathlib import Path
from typing import Optional, Tuple
from urllib.parse import urlparse, quote
import httpx
import aiofiles
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import SourceRecord, SourceStatus, SourceTier
from daad_harvester.daad_logger import LoggerSuite
from daad_harvester.exceptions import FetchError

logger = structlog.get_logger(__name__)


class Fetcher:
    """Handles downloading files from discovered URLs with deduplication and Wayback fallback."""

    def __init__(self, db: Database, download_dir: Optional[Path] = None):
        self.db = db
        self.download_dir = download_dir or (settings.output_dir / "downloads")
        self.download_dir.mkdir(parents=True, exist_ok=True)
        self.logger_suite = LoggerSuite(settings.logs_dir)

    def _get_random_user_agent(self) -> str:
        return random.choice(settings.user_agents)

    def _get_proxy(self) -> Optional[str]:
        if settings.proxy_list:
            return random.choice(settings.proxy_list)
        return None

    async def _query_wayback_cdx(self, url: str, client: httpx.AsyncClient) -> Optional[str]:
        """Query Internet Archive CDX API for dead link recovery."""
        cdx_url = f"https://web.archive.org/cdx/search/cdx?url={quote(url)}&output=json&limit=1&filter=statuscode:200"
        try:
            logger.info("querying_wayback_cdx", original_url=url)
            resp = await client.get(cdx_url, timeout=settings.request_timeout)
            if resp.status_code == 200:
                data = resp.json()
                if len(data) > 1: # Row 0 is header, Row 1 is data
                    timestamp = data[1][1]
                    original = data[1][2]
                    wayback_url = f"https://web.archive.org/web/{timestamp}id_/{original}"
                    logger.info("wayback_url_found", original_url=url, wayback_url=wayback_url)
                    return wayback_url
        except Exception as exc:
            logger.warning("wayback_cdx_query_failed", url=url, error=str(exc))
        return None

    async def fetch_source(self, source: SourceRecord, client: httpx.AsyncClient) -> bool:
        """Download a single source record, streaming to disk and recording metadata."""
        url_to_fetch = source.url
        is_wayback = False
        attempt = 0
        backoff = settings.backoff_base

        while attempt < settings.max_retries:
            headers = {"User-Agent": self._get_random_user_agent()}
            try:
                logger.info("downloading_source", source_id=source.id, url=url_to_fetch, attempt=attempt + 1)
                async with client.stream("GET", url_to_fetch, headers=headers, follow_redirects=True, timeout=settings.request_timeout) as resp:
                    if resp.status_code == 200:
                        content_type = resp.headers.get("Content-Type", "application/octet-stream")

                        filename = None
                        cd_header = resp.headers.get("Content-Disposition", "")
                        if "filename=" in cd_header:
                            parts = cd_header.split("filename=")
                            if len(parts) > 1:
                                filename = parts[1].strip("\"' ;")

                        if not filename:
                            parsed_path = urlparse(source.url).path.split('#')[0].rstrip('/')
                            filename = Path(parsed_path).name

                        if not filename or '.' not in filename or len(filename) > 80:
                            filename = f"source_{source.id}.bin"

                        target_path = self.download_dir / f"{source.id}_{filename}"

                        sha256_hash = hashlib.sha256()
                        async with aiofiles.open(target_path, "wb") as f:
                            async for chunk in resp.aiter_bytes(chunk_size=65536):
                                await f.write(chunk)
                                sha256_hash.update(chunk)

                        logger.info("download_success", source_id=source.id, target_path=str(target_path))

                        self.db.update_source_status(
                            source_id=source.id,
                            status=SourceStatus.DOWNLOADED.value,
                            http_status=resp.status_code,
                            content_type=content_type,
                            local_path=str(target_path)
                        )
                        self.logger_suite.log_download(
                            url=source.url,
                            status="DOWNLOADED_OK",
                            http_code=resp.status_code,
                            local_path=str(target_path),
                            wayback_used=is_wayback
                        )
                        return True

                    elif resp.status_code in (404, 410) and not is_wayback:
                        logger.warning("source_404_dead_trying_wayback", source_id=source.id, url=url_to_fetch)
                        wayback_url = await self._query_wayback_cdx(source.url, client)
                        if wayback_url:
                            url_to_fetch = wayback_url
                            is_wayback = True
                            attempt = 0
                            continue
                        else:
                            self.db.update_source_status(
                                source_id=source.id,
                                status=SourceStatus.DEAD.value,
                                http_status=resp.status_code
                            )
                            self.logger_suite.log_download(
                                url=source.url,
                                status="DEAD_404",
                                http_code=resp.status_code,
                                wayback_used=False
                            )
                            return False
                    else:
                        logger.warning("http_download_error", source_id=source.id, status_code=resp.status_code)
            except Exception as exc:
                logger.warning("download_exception", source_id=source.id, url=url_to_fetch, error=str(exc))

            attempt += 1
            if attempt < settings.max_retries:
                sleep_time = min(backoff * (2 ** (attempt - 1)) + random.uniform(0, 0.5), settings.backoff_max)
                await asyncio.sleep(sleep_time)

        self.db.update_source_status(
            source_id=source.id,
            status=SourceStatus.ERROR.value
        )
        self.logger_suite.log_download(
            url=source.url,
            status="FAILED_ERROR",
            error="Max retries exceeded"
        )
        return False

    async def fetch_pending_sources(self, parallel: int = 8) -> int:
        """Fetch all pending sources from database in parallel."""
        pending = self.db.get_pending_sources()
        if not pending:
            logger.info("no_pending_sources_to_fetch")
            return 0

        logger.info("starting_fetch_phase", count=len(pending), parallel=parallel)
        semaphore = asyncio.Semaphore(parallel)

        async with httpx.AsyncClient(follow_redirects=True) as client:
            async def worker(source: SourceRecord):
                async with semaphore:
                    return await self.fetch_source(source, client)

            results = await asyncio.gather(*[worker(src) for src in pending], return_exceptions=True)
            successful = sum(1 for r in results if r is True)
            logger.info("fetch_phase_completed", total=len(pending), successful=successful)
            return successful
