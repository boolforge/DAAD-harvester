"""Integrate checksum-verified authorized acquisition outputs into the retained corpus.

The command is deliberately fail-closed.  It accepts only successful execution
records whose measured bytes equal the source checksum pinned in the current
authorized queue.  It then copies the original archive into the committed
corpus, records provenance, and reuses the native unpacker and fingerprinter.
No network request is made by this integration path.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import shutil
from typing import Any
from urllib.parse import urlparse

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.fingerprint import Fingerprinter
from daad_harvester.models import SourceStatus, SourceTier
from daad_harvester.unpack import Unpacker

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_QUEUE = ROOT / "research" / "authorized_acquisition_queue.json"
DEFAULT_RESULTS = ROOT / "output" / "spectrum-observed-acquisition" / "authorized_acquisition_results.json"
DEFAULT_STAGING = ROOT / "output" / "spectrum-observed-acquisition"
DEFAULT_CORPUS = ROOT / "preservation_corpus"


def sha256(path: Path) -> str:
    """Return the complete SHA-256 digest of one retained byte sequence."""

    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def source_name(entry: dict[str, Any]) -> str:
    """Describe a source host without converting host provenance into media evidence."""

    host = urlparse(str(entry["source_record_url"])).netloc.casefold()
    return "Spectrum Computing" if host == "spectrumcomputing.co.uk" else host or "registered source"


def queue_by_key(queue: dict[str, Any]) -> dict[str, dict[str, Any]]:
    """Return unique, currently authorized queue entries keyed by candidate identity."""

    entries: dict[str, dict[str, Any]] = {}
    for entry in queue.get("queued") or []:
        key = entry.get("candidate_key")
        if not isinstance(key, str) or key in entries:
            raise ValueError("authorized queue has missing or duplicate candidate keys")
        if entry.get("reason") not in {"authorized", "authorized_by_institutional_directive"}:
            raise ValueError(f"queue entry is not authorized: {key}")
        entries[key] = entry
    return entries


def verified_transfer_plan(
    queue: dict[str, Any],
    results: dict[str, Any],
    staging: Path,
) -> list[dict[str, Any]]:
    """Validate completed local downloads against their pinned queue checksums."""

    entries = queue_by_key(queue)
    plan: list[dict[str, Any]] = []
    seen: set[str] = set()
    for result in results.get("records") or []:
        key = result.get("candidate_key")
        if not isinstance(key, str) or key in seen:
            raise ValueError("acquisition results have missing or duplicate candidate keys")
        seen.add(key)
        entry = entries.get(key)
        if entry is None:
            raise ValueError(f"acquisition result is absent from the authorized queue: {key}")
        if result.get("source_status_after_unpack") != SourceStatus.UNPACKED.value:
            raise ValueError(f"acquisition did not unpack successfully: {key}")
        verification = result.get("verification") or {}
        expected = entry.get("source_checksum") or {}
        if (
            expected.get("algorithm") != "sha256"
            or not isinstance(expected.get("value"), str)
            or verification.get("algorithm") != "sha256"
            or verification.get("status") not in {"checksum_measured", "checksum_verified"}
            or verification.get("actual") != expected["value"]
        ):
            raise ValueError(f"acquisition checksum does not equal the current source pin: {key}")
        stage_source_id = result.get("source_id")
        if not isinstance(stage_source_id, int):
            raise ValueError(f"acquisition result has no staging source identifier: {key}")
        staged_path = staging / "downloads" / f"{stage_source_id}_{entry['filename']}"
        if not staged_path.is_file():
            raise FileNotFoundError(f"missing staged acquisition byte: {staged_path}")
        if sha256(staged_path) != expected["value"]:
            raise ValueError(f"staged byte checksum differs from result and source pin: {key}")
        plan.append({"candidate_key": key, "entry": entry, "staged_path": staged_path})
    if not plan:
        raise ValueError("acquisition result contains no verified transfer records")
    return sorted(plan, key=lambda item: item["candidate_key"])


def _register_corpus_source(db: Database, entry: dict[str, Any]) -> int:
    provenance = {
        "acquisition_basis": entry.get("authorization_basis"),
        "candidate_key": entry["candidate_key"],
        "release_identity": entry["release_identity"],
        "source_observed_identity": entry.get("source_observed_identity"),
        "source_checksum": entry["source_checksum"],
        "canonical_source_url": entry["source_url"],
        "external_source_terms": entry.get("external_source_terms"),
    }
    source_id = db.add_source(
        entry["source_url"],
        SourceTier.ARCHIVE.value,
        title=entry["title"],
        platform="zx",
        year=int(entry["year"]),
        publisher=entry["publisher"],
        language=entry["language"],
        acquisition_priority=100,
        source_name=source_name(entry),
        source_role="game_media",
        source_record_url=entry["source_record_url"],
        source_release_id=entry.get("source_release_id"),
        provenance_json=json.dumps(provenance, sort_keys=True),
    )
    if source_id is None:
        raise RuntimeError(f"could not register corpus source: {entry['candidate_key']}")
    return source_id


def integrate(plan: list[dict[str, Any]], corpus: Path) -> dict[str, Any]:
    """Copy verified roots, unpack them natively, and rescan the affected corpus."""

    settings.output_dir = corpus
    settings.db_path = corpus / "state.db"
    settings.logs_dir = corpus / "logs"
    db = Database(settings.db_path)
    downloads = corpus / "downloads"
    downloads.mkdir(parents=True, exist_ok=True)
    unpacker = Unpacker(db, extract_dir=corpus / "extracted")
    integrated: list[dict[str, Any]] = []
    for item in plan:
        entry = item["entry"]
        staged_path = item["staged_path"]
        source_id = _register_corpus_source(db, entry)
        target = downloads / f"{source_id}_{entry['filename']}"
        expected = entry["source_checksum"]["value"]
        if target.exists():
            if sha256(target) != expected:
                raise ValueError(f"retained corpus byte conflicts with source pin: {target}")
        else:
            shutil.copyfile(staged_path, target)
        db.update_source_status(
            source_id,
            SourceStatus.DOWNLOADED.value,
            http_status=200,
            content_type="application/zip" if target.name.casefold().endswith(".zip") else "application/octet-stream",
            local_path=str(target.resolve()),
        )
        source = next(record for record in db.get_all_sources() if record.id == source_id)
        emitted = unpacker.unpack_source_single(source)
        integrated.append(
            {
                "candidate_key": entry["candidate_key"],
                "source_id": source_id,
                "retained_download": str(target.relative_to(corpus)),
                "sha256": expected,
                "emitted_artifact_count": emitted,
            }
        )
    verified_ddbs = Fingerprinter(db).scan_all_artifacts()
    return {
        "schema_version": 1,
        "purpose": "Native corpus integration of previously acquired, checksum-pinned authorized sources.",
        "input_count": len(plan),
        "integrated": integrated,
        "verified_ddb_count_after_rescan": verified_ddbs,
    }


def integration_report(plan: list[dict[str, Any]], corpus: Path) -> dict[str, Any]:
    """Render a deterministic summary from the persisted corpus after integration."""

    db = Database(corpus / "state.db")
    sources = {source.url: source for source in db.get_all_sources()}
    artifacts = db.get_all_artifacts()
    records: list[dict[str, Any]] = []
    for item in plan:
        entry = item["entry"]
        source = sources.get(entry["source_url"])
        if source is None or source.status != SourceStatus.UNPACKED.value:
            raise ValueError(f"verified acquisition is not retained and unpacked in corpus: {entry['candidate_key']}")
        source_artifacts = [artifact for artifact in artifacts if artifact.source_id == source.id]
        root_matches = [
            artifact for artifact in source_artifacts
            if artifact.archive_depth == 0 and artifact.sha256 == entry["source_checksum"]["value"]
        ]
        if len(root_matches) != 1:
            raise ValueError(f"corpus root does not match the pinned source checksum: {entry['candidate_key']}")
        records.append(
            {
                "candidate_key": entry["candidate_key"],
                "source_id": source.id,
                "root_artifact_id": root_matches[0].id,
                "root_sha256": root_matches[0].sha256,
                "artifact_count": len(source_artifacts),
                "verified_ddb_count": sum(artifact.is_daad_payload for artifact in source_artifacts),
            }
        )
    return {
        "schema_version": 1,
        "purpose": "Deterministic retained-corpus summary for checksum-pinned authorized acquisition integration.",
        "input_count": len(records),
        "records": records,
        "boundary": (
            "A retained root, native extraction, and structural DDB scan are recorded here. "
            "A source identity or artifact count does not establish release completeness, runtime equivalence, or unsupported media semantics."
        ),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--queue", type=Path, default=DEFAULT_QUEUE)
    parser.add_argument("--results", type=Path, default=DEFAULT_RESULTS)
    parser.add_argument("--staging", type=Path, default=DEFAULT_STAGING)
    parser.add_argument("--corpus", type=Path, default=DEFAULT_CORPUS)
    parser.add_argument("--integration-report", type=Path, help="Write a deterministic persisted-corpus integration summary.")
    parser.add_argument("--apply", action="store_true", help="Copy into the corpus and run native unpacking and fingerprinting.")
    args = parser.parse_args()
    plan = verified_transfer_plan(
        json.loads(args.queue.read_text(encoding="utf-8")),
        json.loads(args.results.read_text(encoding="utf-8")),
        args.staging,
    )
    if not args.apply and args.integration_report is None:
        print(json.dumps({"verified_transfer_count": len(plan), "candidate_keys": [item["candidate_key"] for item in plan]}, indent=2))
        return 0
    if args.apply:
        integrate(plan, args.corpus)
    report = integration_report(plan, args.corpus)
    if args.integration_report is not None:
        args.integration_report.parent.mkdir(parents=True, exist_ok=True)
        args.integration_report.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
