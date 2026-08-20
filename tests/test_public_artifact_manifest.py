"""Regressions for deterministic public retained-artifact publication."""

from __future__ import annotations

from pathlib import Path

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.unpack import compute_hashes
from scripts import build_public_artifact_manifest, stage_public_artifacts


def _fixture(tmp_path: Path) -> tuple[Path, Path, Path]:
    corpus = tmp_path / "preservation_corpus"
    retained = corpus / "extracted" / "Tape Name [1988].tap"
    retained.parent.mkdir(parents=True)
    retained.write_bytes(b"all-media retained payload")
    database = corpus / "state.db"
    db = Database(database)
    source_id = db.add_source("https://example.invalid/tape.tap", "fixture", platform="zx")
    hashes = compute_hashes(retained.read_bytes())
    db.add_artifact(ArtifactRecord(
        id=None, source_id=source_id, original_filename=retained.name, extracted_path=str(retained), archive_depth=1,
        file_size=retained.stat().st_size, md5_full=hashes["md5_full"], md5_5000=hashes["md5_5000"], sha256=hashes["sha256"],
        sha1=hashes["sha1"], crc32=hashes["crc32"], md5_tail5000=hashes["md5_tail5000"], sha224=hashes["sha224"], sha384=hashes["sha384"],
        sha512=hashes["sha512"], sha3_256=hashes["sha3_256"], sha3_512=hashes["sha3_512"], blake2b=hashes["blake2b"], blake2s=hashes["blake2s"],
        adler32=hashes["adler32"], xxh32=hashes["xxh32"], xxh64=hashes["xxh64"], xxh128=hashes["xxh128"], container_format="tap",
    ))
    return corpus, database, retained


def test_manifest_and_staging_publish_exact_retained_bytes_without_local_path(tmp_path: Path) -> None:
    corpus, database, retained = _fixture(tmp_path)
    manifest = build_public_artifact_manifest.build_manifest(database=database, corpus_root=corpus)
    manifest_path = corpus / "public_artifacts_manifest.json"
    build_public_artifact_manifest.write_manifest(manifest, manifest_path)

    entry = manifest["artifacts"][0]
    assert entry["public_path"].startswith("artifacts/000001_")
    assert "extracted" not in entry["public_path"]
    assert entry["checksums"] == compute_hashes(retained.read_bytes())

    staged = tmp_path / "public"
    assert stage_public_artifacts.stage(database=database, corpus_root=corpus, manifest_path=manifest_path, stage_dir=staged) == 1
    assert (staged / entry["public_path"]).read_bytes() == retained.read_bytes()


def test_staging_rejects_path_escape(tmp_path: Path) -> None:
    corpus, database, _ = _fixture(tmp_path)
    manifest = build_public_artifact_manifest.build_manifest(database=database, corpus_root=corpus)
    manifest["artifacts"][0]["public_path"] = "../escaped.bin"
    manifest_path = corpus / "bad_manifest.json"
    build_public_artifact_manifest.write_manifest(manifest, manifest_path)

    try:
        stage_public_artifacts.stage(database=database, corpus_root=corpus, manifest_path=manifest_path, stage_dir=tmp_path / "public")
    except ValueError as exc:
        assert "escapes staging root" in str(exc)
    else:
        raise AssertionError("path escape must be rejected")
