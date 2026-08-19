"""Resilient downloader module with proxy rotation, wayback fallback, Content-Type inspection, and magic byte filtering."""

import asyncio
import hashlib
import random
from pathlib import Path
from typing import Optional
from urllib.parse import urlparse, quote
import httpx
import aiofiles
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import SourceRecord, SourceStatus
from daad_harvester.daad_logger import LoggerSuite

logger = structlog.get_logger(__name__)


# Non-binary text/web Content-Types that should be rejected immediately during fetch phase
REJECTED_CONTENT_TYPES = (
    "text/html",
    "text/xml",
    "application/json",
    "application/javascript",
    "text/css",
    "text/javascript",
    "application/xml"
)


class Fetcher:
    """Handles downloading files from discovered URLs with deduplication, magic byte validation, and Wayback fallback."""

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

    # NOTE on scope: _get_proxy() picks randomly, but httpx.AsyncClient (used
    # in fetch_pending_sources below) binds its `proxy=` at construction time
    # for the whole client / connection pool -- it can't be swapped per
    # request without giving up connection reuse. This wires a proxy chosen
    # ONCE per pipeline run (real fix for "--proxy-list has zero effect",
    # which was the actual bug: _get_proxy() was defined and never called
    # anywhere). True per-request rotation would mean building one pooled
    # client per proxy and round-robining requests across them; worth doing
    # if a single proxy getting rate-limited/blocked turns out to matter in
    # practice, but that's a bigger change than this bug warranted.

    async def _query_wayback_cdx(self, url: str, client: httpx.AsyncClient) -> Optional[str]:
        """Query Internet Archive CDX API for dead link recovery."""
        cdx_url = f"https://web.archive.org/cdx/search/cdx?url={quote(url)}&output=json&limit=1&filter=statuscode:200"
        try:
            logger.info("querying_wayback_cdx", original_url=url)
            resp = await client.get(cdx_url, timeout=settings.request_timeout)
            if resp.status_code == 200:
                data = resp.json()
                if len(data) > 1:  # Row 0 is header, Row 1 is data
                    timestamp = data[1][1]
                    original = data[1][2]
                    wayback_url = f"https://web.archive.org/web/{timestamp}id_/{original}"
                    logger.info("wayback_url_found", original_url=url, wayback_url=wayback_url)
                    return wayback_url
        except Exception as exc:
            logger.warning("wayback_cdx_query_failed", url=url, error=str(exc))
        return None

    def _is_invalid_web_payload(self, first_chunk: bytes, content_type: str) -> bool:
        """Determines whether streamed response is non-binary web page, JSON error, or HTML."""
        ct_lower = content_type.lower()

        # Direct Content-Type rejection for web/JSON
        if any(ct in ct_lower for ct in REJECTED_CONTENT_TYPES):
            return True

        # Magic byte rejection for raw HTML / JSON
        chunk_start = first_chunk[:128].strip().lower()
        if chunk_start.startswith((b"<!doctype html", b"<html", b"<?php", b"<head", b"{", b"[")):
            return True

        return False

    async def fetch_source(self, source: SourceRecord, client: httpx.AsyncClient) -> bool:
        """Download a single source record, streaming to disk and recording metadata."""
        url_to_fetch = source.url
        is_wayback = False
        attempt = 0
        backoff = settings.backoff_base
        last_http_status: Optional[int] = None
        last_content_type: Optional[str] = None

        while attempt < settings.max_retries:
            headers = {"User-Agent": self._get_random_user_agent()}
            target_path: Optional[Path] = None
            try:
                logger.info("downloading_source", source_id=source.id, url=url_to_fetch, attempt=attempt + 1)
                async with client.stream("GET", url_to_fetch, headers=headers, follow_redirects=True, timeout=settings.request_timeout) as resp:
                    if resp.status_code == 200:
                        content_type = resp.headers.get("Content-Type", "application/octet-stream")
                        last_http_status = resp.status_code
                        last_content_type = content_type

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
                        first_chunk_checked = False
                        is_rejected = False
                        bytes_written = 0

                        async with aiofiles.open(target_path, "wb") as f:
                            async for chunk in resp.aiter_bytes(chunk_size=65536):
                                if not first_chunk_checked:
                                    first_chunk_checked = True
                                    if self._is_invalid_web_payload(chunk, content_type):
                                        logger.warning(
                                            "rejecting_non_binary_web_download",
                                            source_id=source.id,
                                            url=url_to_fetch,
                                            content_type=content_type
                                        )
                                        is_rejected = True
                                        break

                                await f.write(chunk)
                                sha256_hash.update(chunk)
                                bytes_written += len(chunk)

                        if is_rejected:
                            if target_path and target_path.exists():
                                target_path.unlink(missing_ok=True)
                            self.db.update_source_status(
                                source_id=source.id,
                                status=SourceStatus.ERROR.value,
                                http_status=resp.status_code,
                                content_type=content_type
                            )
                            self.logger_suite.log_download(
                                url=source.url,
                                status="REJECTED_NON_BINARY_WEB",
                                http_code=resp.status_code
                            )
                            return False

                        if bytes_written == 0:
                            if target_path.exists():
                                target_path.unlink(missing_ok=True)
                            logger.warning("rejecting_empty_download", source_id=source.id, url=url_to_fetch)
                            self.db.update_source_status(
                                source_id=source.id,
                                status=SourceStatus.ERROR.value,
                                http_status=resp.status_code,
                                content_type=content_type,
                            )
                            self.logger_suite.log_download(
                                url=source.url,
                                status="REJECTED_EMPTY_DOWNLOAD",
                                http_code=resp.status_code,
                            )
                            return False

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
                        last_http_status = resp.status_code
                        last_content_type = resp.headers.get("Content-Type")
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
                        last_http_status = resp.status_code
                        last_content_type = resp.headers.get("Content-Type")
                        logger.warning("http_download_error", source_id=source.id, status_code=resp.status_code)
            except Exception as exc:
                if target_path and target_path.exists():
                    target_path.unlink(missing_ok=True)
                logger.warning("download_exception", source_id=source.id, url=url_to_fetch, error=str(exc))

                # Wayback fallback previously only triggered on an explicit
                # HTTP 404/410 response. In practice, most dead retro-computing
                # sites don't answer with a clean 404 at all -- the domain has
                # lapsed, DNS doesn't resolve, or the connection is refused --
                # which lands here as an exception, not a status code, and
                # this class of failure never got a wayback attempt. Try it
                # once we're out of direct retries (exceptions can be
                # transient, so don't skip the normal retry/backoff first).
                if not is_wayback and attempt + 1 >= settings.max_retries:
                    logger.warning("source_unreachable_trying_wayback", source_id=source.id, url=url_to_fetch)
                    wayback_url = await self._query_wayback_cdx(source.url, client)
                    if wayback_url:
                        url_to_fetch = wayback_url
                        is_wayback = True
                        attempt = 0
                        continue

            attempt += 1
            if attempt < settings.max_retries:
                sleep_time = min(backoff * (2 ** (attempt - 1)) + random.uniform(0, 0.5), settings.backoff_max)
                await asyncio.sleep(sleep_time)

        self.db.update_source_status(
            source_id=source.id,
            status=SourceStatus.ERROR.value,
            http_status=last_http_status,
            content_type=last_content_type,
        )
        self.logger_suite.log_download(
            url=source.url,
            status="FAILED_ERROR",
            error="Max retries exceeded"
        )
        return False

    async def fetch_pending_sources(self, parallel: int = 8, max_sources: Optional[int] = None) -> int:
        """Fetch pending sources in database priority order, optionally with a bounded batch."""
        pending = self.db.get_pending_sources()
        if max_sources is not None:
            pending = pending[:max_sources]
        if not pending:
            logger.info("no_pending_sources_to_fetch")
            return 0

        logger.info("starting_fetch_phase", count=len(pending), parallel=parallel, max_sources=max_sources)
        semaphore = asyncio.Semaphore(parallel)

        async with httpx.AsyncClient(follow_redirects=True, proxy=self._get_proxy()) as client:
            async def worker(source: SourceRecord):
                async with semaphore:
                    return await self.fetch_source(source, client)

            results = await asyncio.gather(*[worker(src) for src in pending], return_exceptions=True)
            successful = sum(1 for r in results if r is True)
            logger.info("fetch_phase_completed", total=len(pending), successful=successful)
            return successful
