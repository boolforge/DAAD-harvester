"""Regression coverage for complete retained-artifact checksum verification."""

from __future__ import annotations

from pathlib import Path

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.unpack import compute_hashes
from scripts import verify_artifact_checksums


def _add_artifact(db: Database, path: Path, *, sha256: str = "", all_hashes: bool = False) -> int:
    payload = path.read_bytes()
    hashes = compute_hashes(payload) if all_hashes else {}
    source_id = db.add_source("https://example.invalid/artifact.bin", "fixture")
    artifact = ArtifactRecord(
        id=None,
        source_id=source_id,
        original_filename=path.name,
        extracted_path=str(path),
        archive_depth=1,
        file_size=len(payload),
        md5_full=hashes.get("md5_full", ""),
        md5_5000=hashes.get("md5_5000", ""),
        sha256=sha256 or hashes.get("sha256", ""),
        sha1=hashes.get("sha1"),
        crc32=hashes.get("crc32"),
        md5_tail5000=hashes.get("md5_tail5000"),
        sha224=hashes.get("sha224"),
        sha384=hashes.get("sha384"),
        sha512=hashes.get("sha512"),
        sha3_256=hashes.get("sha3_256"),
        sha3_512=hashes.get("sha3_512"),
        blake2b=hashes.get("blake2b"),
        blake2s=hashes.get("blake2s"),
        adler32=hashes.get("adler32"),
        xxh32=hashes.get("xxh32"),
        xxh64=hashes.get("xxh64"),
        xxh128=hashes.get("xxh128"),
    )
    return db.add_artifact(artifact)


def test_backfill_populates_all_canonical_checksum_fields(tmp_path: Path) -> None:
    corpus = tmp_path / "preservation_corpus"
    path = corpus / "extracted" / "artifact.bin"
    path.parent.mkdir(parents=True)
    path.write_bytes(b"retained checksum evidence")
    db = Database(corpus / "state.db")
    artifact_id = _add_artifact(db, path)

    verified, backfilled, errors = verify_artifact_checksums.verify(
        database=corpus / "state.db", corpus_root=corpus, backfill=True
    )

    assert errors == []
    assert (verified, backfilled) == (1, 1)
    stored = next(artifact for artifact in db.get_all_artifacts() if artifact.id == artifact_id)
    expected = compute_hashes(path.read_bytes())
    assert all(getattr(stored, field) == expected[field] for field in verify_artifact_checksums.CHECKSUM_FIELDS)


def test_backfill_rejects_stored_checksum_mismatch_without_rewriting_it(tmp_path: Path) -> None:
    corpus = tmp_path / "preservation_corpus"
    path = corpus / "extracted" / "artifact.bin"
    path.parent.mkdir(parents=True)
    path.write_bytes(b"retained checksum evidence")
    db = Database(corpus / "state.db")
    artifact_id = _add_artifact(db, path, sha256="0" * 64, all_hashes=False)

    verified, backfilled, errors = verify_artifact_checksums.verify(
        database=corpus / "state.db", corpus_root=corpus, backfill=True
    )

    assert (verified, backfilled) == (0, 0)
    assert any("stored checksum mismatch" in error and "sha256" in error for error in errors)
    stored = next(artifact for artifact in db.get_all_artifacts() if artifact.id == artifact_id)
    assert stored.sha256 == "0" * 64
