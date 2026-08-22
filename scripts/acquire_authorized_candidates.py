#!/usr/bin/env python3
"""Acquire, verify, and unpack release-verified catalog candidates.

Only entries in the versioned authorized acquisition queue can be processed. The
runner uses the ordinary source database, downloader, and recursive unpacker in
a caller-selected output directory; it never promotes an unverified discovery
match or silently changes the committed preservation corpus.
"""

from __future__ import annotations

import argparse
import asyncio
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
from typing import Any, Iterable

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.fetch import Fetcher
from daad_harvester.models import SourceStatus, SourceTier
from daad_harvester.unpack import Unpacker

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_QUEUE = ROOT / "research" / "authorized_acquisition_queue.json"
DEFAULT_OUTPUT_DIR = ROOT / "output" / "authorized-acquisition"

PLATFORM_BY_SUFFIX = {
    ".adf": "amiga", ".adz": "amiga", ".dms": "amiga",
    ".d64": "c64", ".d71": "c64", ".t64": "c64", ".tap": "c64", ".p00": "c64",
    ".dsk": "cpc", ".cdt": "cpc", ".tzx": "zx",
    ".msa": "atarist", ".st": "atarist", ".ipf": "atarist", ".stx": "atarist",
    ".cas": "msx", ".rom": "msx",
}


def platform_for_source(entry: dict[str, Any]) -> str | None:
    """Infer a canonical platform only from the direct binary filename."""

    filename = str(entry.get("filename") or Path(entry["source_url"]).name)
    return PLATFORM_BY_SUFFIX.get(Path(filename).suffix.casefold())


def verify_checksum(path: Path, claim: dict[str, Any] | None) -> dict[str, Any]:
    """Measure and compare a declared source checksum without accepting a missing claim."""

    if not claim:
        return {"status": "no_declared_source_checksum"}
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


def register_sources(db: Database, entries: Iterable[dict[str, Any]]) -> dict[str, int]:
    """Add queue entries to the canonical source ledger and return source IDs by URL."""

    ids: dict[str, int] = {}
    for entry in entries:
        provenance = {
            "acquisition_basis": entry.get("authorization_basis"),
            "candidate_key": entry["candidate_key"],
            "release_identity": entry["release_identity"],
            "source_checksum": entry.get("source_checksum"),
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
            source_name="Internet Archive",
            source_role="game_media",
            source_record_url=entry["source_record_url"],
            source_release_id=entry.get("source_release_id"),
            provenance_json=json.dumps(provenance, sort_keys=True),
        )
        if source_id is None:
            raise RuntimeError(f"Could not register authorized source: {entry['source_url']}")
        ids[entry["source_url"]] = source_id
    return ids


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
    await Fetcher(db, download_dir=output_dir / "downloads").fetch_pending_sources(
        parallel=max(1, parallel), source_ids=source_ids.values()
    )
    sources = {source.id: source for source in db.get_all_sources()}
    results: list[dict[str, Any]] = []
    unpacker = Unpacker(db, extract_dir=output_dir / "extracted")
    for entry in entries:
        source_id = source_ids[entry["source_url"]]
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
        if verification["status"] != "checksum_verified":
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
        "checksum_verified_count": sum(item.get("verification", {}).get("status") == "checksum_verified" for item in results),
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
        f"{result['checksum_verified_count']} checksum-verified, "
        f"{result['unpacked_source_count']} unpacked, out of {result['requested_count']} requested."
    )
    print(f"Execution evidence: {result_path}")
    return 0 if result["checksum_verified_count"] == len(entries) else 1


if __name__ == "__main__":
    raise SystemExit(main())
