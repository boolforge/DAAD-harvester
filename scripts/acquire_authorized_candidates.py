#!/usr/bin/env python3
"""Acquire only release-verified entries from the authorized candidate queue."""

from __future__ import annotations

import argparse
import asyncio
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
from typing import Any, Iterable

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.fetch import Fetcher
from daad_harvester.models import SourceStatus, SourceTier
from daad_harvester.unpack import Unpacker

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_QUEUE = ROOT / "research" / "authorized_acquisition_queue.json"
DEFAULT_OUTPUT_DIR = ROOT / "output" / "authorized-acquisition"
ITCHIO_DOWNLOADER_VERSION = "1.2.0"

PLATFORM_BY_SUFFIX = {
    ".adf": "amiga", ".adz": "amiga", ".dms": "amiga",
    ".d64": "c64", ".d71": "c64", ".t64": "c64", ".tap": "c64", ".p00": "c64",
    ".dsk": "cpc", ".cdt": "cpc", ".tzx": "zx",
    ".msa": "atarist", ".st": "atarist", ".ipf": "atarist", ".stx": "atarist",
    ".cas": "msx", ".rom": "msx",
}


def platform_for_source(entry: dict[str, Any]) -> str | None:
    """Infer a canonical platform only from the registered binary filename."""

    filename = str(entry.get("filename") or Path(entry["source_url"]).name)
    return PLATFORM_BY_SUFFIX.get(Path(filename).suffix.casefold())


def verify_checksum(path: Path, claim: dict[str, Any] | None) -> dict[str, Any]:
    """Measure and compare a declared source checksum without accepting a mismatch."""

    if not claim:
        return {
            "status": "checksum_measured",
            "algorithm": "sha256",
            "actual": hashlib.sha256(path.read_bytes()).hexdigest(),
        }
    algorithm = str(claim.get("algorithm") or "").casefold()
    expected = str(claim.get("value") or "").casefold()
    if algorithm not in {"sha1", "sha256"} or not expected:
        return {"status": "invalid_declared_source_checksum", "algorithm": algorithm, "expected": expected}
    digest = hashlib.new(algorithm, path.read_bytes()).hexdigest()
    return {
        "status": "checksum_verified" if digest == expected else "checksum_mismatch",
        "algorithm": algorithm,
        "expected": expected,
        "actual": digest,
    }


def is_itchio_adapter(entry: dict[str, Any]) -> bool:
    return (entry.get("source_adapter") or {}).get("name") == "itchio_downloader_free_v1"


def register_sources(db: Database, entries: Iterable[dict[str, Any]]) -> dict[str, int]:
    """Add queue entries to the canonical source ledger by candidate identity."""

    ids: dict[str, int] = {}
    for entry in entries:
        provenance = {
            "acquisition_basis": entry.get("authorization_basis"),
            "candidate_key": entry["candidate_key"],
            "release_identity": entry["release_identity"],
            "source_checksum": entry.get("source_checksum"),
            "canonical_source_url": entry["source_url"],
            "source_adapter": entry.get("source_adapter"),
            "external_source_terms": entry.get("external_source_terms"),
        }
        source_id = db.add_source(
            entry["source_url"],
            SourceTier.ARCHIVE.value,
            title=entry["title"],
            platform=platform_for_source(entry),
            year=int(entry["year"]),
            publisher=entry["publisher"],
            language=entry["language"],
            acquisition_priority=100,
            source_name="itch.io" if is_itchio_adapter(entry) else "Internet Archive",
            source_role="game_media",
            source_record_url=entry["source_record_url"],
            source_release_id=entry.get("source_release_id"),
            provenance_json=json.dumps(provenance, sort_keys=True),
        )
        if source_id is None:
            raise RuntimeError(f"Could not register authorized source: {entry['candidate_key']}")
        ids[entry["candidate_key"]] = source_id
    return ids


def acquire_itchio_source(db: Database, source_id: int, entry: dict[str, Any], output_dir: Path) -> None:
    """Download a free itch.io upload through the pinned, noninteractive adapter."""

    adapter = entry["source_adapter"]
    upload_id = adapter["upload_id"]
    adapter_dir = output_dir / "adapter_downloads" / str(source_id)
    adapter_dir.mkdir(parents=True, exist_ok=True)
    log_path = output_dir / "logs" / f"itchio_{source_id}.log"
    log_path.parent.mkdir(parents=True, exist_ok=True)
    command = [
        "pnpm", "dlx", f"itchio-downloader@{ITCHIO_DOWNLOADER_VERSION}",
        "--url", entry["source_url"], "--downloadDirectory", str(adapter_dir),
    ]
    environment = {**os.environ, "CI": "1"}
    try:
        completed = subprocess.run(
            command, cwd=ROOT, env=environment, text=True,
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=240, check=False,
        )
    except (OSError, subprocess.TimeoutExpired) as error:
        log_path.write_text(f"adapter execution failure: {type(error).__name__}: {error}\n", encoding="utf-8")
        db.update_source_status(source_id, SourceStatus.ERROR.value)
        return
    log_path.write_text(completed.stdout, encoding="utf-8")
    expected_name = f"game-{upload_id}"
    payloads = sorted(path for path in adapter_dir.iterdir() if path.is_file() and path.stem == expected_name)
    if completed.returncode != 0 or len(payloads) != 1:
        db.update_source_status(source_id, SourceStatus.ERROR.value)
        return
    target = output_dir / "downloads" / f"{source_id}_{entry['filename']}"
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(payloads[0], target)
    db.update_source_status(source_id, SourceStatus.DOWNLOADED.value, http_status=200, content_type="application/zip", local_path=str(target))


def selected_entries(queue: dict[str, Any], max_candidates: int | None) -> list[dict[str, Any]]:
    """Return the bounded queue slice, rejecting malformed or unauthorized records."""

    entries = list(queue.get("queued") or [])
    if max_candidates is not None:
        entries = entries[:max_candidates]
    for entry in entries:
        if entry.get("reason") not in {"authorized", "authorized_by_institutional_directive"}:
            raise ValueError(f"Queue entry is not authorized: {entry.get('candidate_key')}")
        for field in ("candidate_key", "source_url", "source_record_url", "release_identity"):
            if not entry.get(field):
                raise ValueError(f"Queue entry lacks {field}: {entry.get('candidate_key')}")
    return entries


async def acquire(entries: list[dict[str, Any]], output_dir: Path, parallel: int) -> dict[str, Any]:
    """Register, fetch, checksum-verify, and unpack one bounded authorized batch."""

    output_dir.mkdir(parents=True, exist_ok=True)
    settings.output_dir = output_dir
    settings.db_path = output_dir / "state.db"
    settings.logs_dir = output_dir / "logs"
    settings.logs_dir.mkdir(parents=True, exist_ok=True)
    db = Database(settings.db_path)
    source_ids = register_sources(db, entries)
    direct_source_ids = [source_ids[entry["candidate_key"]] for entry in entries if not is_itchio_adapter(entry)]
    if direct_source_ids:
        await Fetcher(db, download_dir=output_dir / "downloads").fetch_pending_sources(
            parallel=max(1, parallel), source_ids=direct_source_ids
        )
    adapter_entries = [entry for entry in entries if is_itchio_adapter(entry)]
    if adapter_entries:
        semaphore = asyncio.Semaphore(max(1, parallel))

        async def bounded_adapter_acquisition(entry: dict[str, Any]) -> None:
            async with semaphore:
                await asyncio.to_thread(acquire_itchio_source, db, source_ids[entry["candidate_key"]], entry, output_dir)

        await asyncio.gather(*(bounded_adapter_acquisition(entry) for entry in adapter_entries))
    sources = {source.id: source for source in db.get_all_sources()}
    results: list[dict[str, Any]] = []
    unpacker = Unpacker(db, extract_dir=output_dir / "extracted")
    for entry in entries:
        source_id = source_ids[entry["candidate_key"]]
        source = sources[source_id]
        result: dict[str, Any] = {
            "candidate_key": entry["candidate_key"],
            "source_id": source_id,
            "source_url": entry["source_url"],
            "source_status_after_fetch": source.status,
        }
        if source.status != SourceStatus.DOWNLOADED.value or not source.local_path:
            result["verification"] = {"status": "download_not_available_for_verification"}
            results.append(result)
            continue
        verification = verify_checksum(Path(source.local_path), entry.get("source_checksum"))
        result["verification"] = verification
        if verification["status"] not in {"checksum_verified", "checksum_measured"}:
            Path(source.local_path).unlink(missing_ok=True)
            db.update_source_status(source_id, SourceStatus.ERROR.value)
            result["source_status_after_unpack"] = SourceStatus.ERROR.value
            results.append(result)
            continue
        result["emitted_artifact_count"] = unpacker.unpack_source_single(source)
        result["source_status_after_unpack"] = next(item for item in db.get_all_sources() if item.id == source_id).status
        results.append(result)
    return {
        "schema_version": 1,
        "purpose": "Execution evidence for a bounded, authorized catalog acquisition batch.",
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "queue": str(DEFAULT_QUEUE.relative_to(ROOT)),
        "output_dir": str(output_dir),
        "requested_count": len(entries),
        "declared_checksum_verified_count": sum(item.get("verification", {}).get("status") == "checksum_verified" for item in results),
        "measured_checksum_count": sum(item.get("verification", {}).get("status") == "checksum_measured" for item in results),
        "integrity_confirmed_count": sum(item.get("verification", {}).get("status") in {"checksum_verified", "checksum_measured"} for item in results),
        "unpacked_source_count": sum(item.get("source_status_after_unpack") == SourceStatus.UNPACKED.value for item in results),
        "records": results,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--queue", type=Path, default=DEFAULT_QUEUE)
    parser.add_argument("--output-dir", type=Path, default=DEFAULT_OUTPUT_DIR)
    parser.add_argument("--max-candidates", type=int, default=None)
    parser.add_argument("--parallel", type=int, default=2)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    queue = json.loads(args.queue.read_text(encoding="utf-8"))
    entries = selected_entries(queue, args.max_candidates)
    if args.dry_run:
        print(f"Authorized acquisition dry run: {len(entries)} queued candidates selected.")
        return 0
    output_dir = args.output_dir.resolve()
    result = asyncio.run(acquire(entries, output_dir, args.parallel))
    result_path = output_dir / "authorized_acquisition_results.json"
    result_path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(
        "Authorized acquisition completed: "
        f"{result['declared_checksum_verified_count']} matched declared checksums, "
        f"{result['measured_checksum_count']} newly measured checksums, "
        f"{result['unpacked_source_count']} unpacked, out of {result['requested_count']} requested."
    )
    print(f"Execution evidence: {result_path}")
    return 0 if result["integrity_confirmed_count"] == len(entries) else 1


if __name__ == "__main__":
    raise SystemExit(main())
