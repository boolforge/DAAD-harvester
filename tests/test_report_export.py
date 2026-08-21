"""Tests for the static preservation-report JSON contract."""

from __future__ import annotations

import json
from hashlib import sha256
from pathlib import Path

from daad_harvester.db import Database
from daad_harvester.known_games import iter_known_games
from daad_harvester.models import ArtifactRecord
from daad_harvester.report_export import StaticReportExporter
from daad_harvester.unpack import compute_hashes


def test_static_report_export_uses_real_evidence_and_omits_local_paths(tmp_path: Path) -> None:
    output_dir = tmp_path / "output"
    db = Database(output_dir / "state.db")
    known_game = next(iter_known_games())
    source_id = db.add_source(
        "https://example.invalid/adventure.d64",
        "archive",
        title=known_game.title,
        platform="c64",
        known_game_id=known_game.game_id,
    )
    payload = b"recorded artifact"
    hashes = compute_hashes(payload)
    retained = output_dir / "extracted" / "adventure.ddb"
    retained.parent.mkdir(parents=True)
    retained.write_bytes(payload)
    artifact = ArtifactRecord(
        id=None, source_id=source_id, original_filename="ADVENTURE.DDB", extracted_path=str(retained),
        file_size=len(payload), md5_full=hashes["md5_full"], md5_5000=hashes["md5_5000"], sha256=hashes["sha256"], sha1=hashes["sha1"], crc32=hashes["crc32"], md5_tail5000=hashes["md5_tail5000"], sha224=hashes["sha224"], sha384=hashes["sha384"], sha512=hashes["sha512"], sha3_256=hashes["sha3_256"], sha3_512=hashes["sha3_512"], blake2b=hashes["blake2b"], blake2s=hashes["blake2s"], adler32=hashes["adler32"], xxh32=hashes["xxh32"], xxh64=hashes["xxh64"], xxh128=hashes["xxh128"],
        archive_depth=1, container_format="c64-d64", container_member="ADVENTURE.DDB",
        media_parser="c64-d64", media_status="extracted", media_validation="validated_member_emission",
        is_daad_payload=True, measured_platform="c64", ddb_format="daad-v3", fingerprint_confidence="verified",
    )
    db.add_artifact(artifact)
    (output_dir / "detection_tables.h").write_text("#define DAAD_TEST 1\n", encoding="utf-8")

    path = StaticReportExporter(db, output_dir).write()
    report = json.loads(path.read_text(encoding="utf-8"))
    assert report["summary"]["verified_daad_artifacts"] == 1
    assert report["detections"]["available"] is True
    assert report["detections"]["download_path"] == "detection_tables.h"
    assert report["detections"]["generator"] == "daad_harvester.synthesize.Synthesizer"
    assert report["detections"]["sha256"] == sha256(b"#define DAAD_TEST 1\n").hexdigest()
    assert report["generator_evidence"]["available"] is True
    generators = report["generator_evidence"]["generators"]
    assert len(generators) == 3
    native_generator = generators[0]
    assert native_generator["generator_id"] == "extended-dsk-blank-cpc-system-v1"
    assert native_generator["status"] == "generated_structurally_valid"
    assert native_generator["output"]["sha256"] == "ab33b5581e8141fd4c721a1cf6e6e98d30454e1a2632e1951168a678d10e495b"
    assert native_generator["output"]["md5_full"] == "4d628f542ee8a7b2bfee255606819485"
    assert len(native_generator["output"]["checksums"]) == 17
    assert native_generator["output"]["checksums"]["sha256"] == native_generator["output"]["sha256"]
    assert native_generator["native_validation"]["validation"] == "validated_cpc_dsk_track_stream"
    assert native_generator["inputs"]["filesystem_claim"] == "none"
    assert native_generator["comparison_boundary"]["authentic_release"] == "not_applicable_blank_fixture"
    native_adf_generator = generators[1]
    assert native_adf_generator["generator_id"] == "adf-ofs-blank-standard-dd-v1"
    assert native_adf_generator["native_validation"]["validation"] == "validated_adf_ofs_ffs_structure"
    assert native_adf_generator["inputs"]["filesystem_claim"] == "empty_ofs_filesystem_no_members"
    native_tzx_generator = generators[2]
    assert native_tzx_generator["generator_id"] == "tzx-standard-data-synthetic-pair-v1"
    assert native_tzx_generator["status"] == "generated_extraction_verified"
    assert native_tzx_generator["native_validation"]["evidence"]["extracted_members"] == [
        {"name": "DAAD GAME.bas", "byte_length": 7}
    ]
    assert "extracted_path" not in report["catalog"]["artifacts"][0]
    matrix = next(item for item in report["game_port_matrix"] if item["game_id"] == known_game.game_id)
    assert matrix["source_platforms"] == ["c64"]
    assert matrix["measured_artifact_platforms"] == ["c64"]
    assert matrix["artifacts"][0]["sha256"] == hashes["sha256"]
    assert matrix["artifacts"][0]["checksums"] == hashes
    assert matrix["artifacts"][0]["evidence_state"] == "verified_ddb"
    assert matrix["artifacts"][0]["source_platform"] == "c64"
    assert matrix["artifacts"][0]["artifact_platform_hint"] is None
    assert matrix["artifacts"][0]["measured_platform"] == "c64"
    assert matrix["artifacts"][0]["archive_depth"] == 1
    assert matrix["artifacts"][0]["container_format"] == "c64-d64"
    assert matrix["artifacts"][0]["container_member"] == "ADVENTURE.DDB"
    assert matrix["artifacts"][0]["media_parser"] == "c64-d64"
    assert matrix["artifacts"][0]["media_status"] == "extracted"
    assert matrix["artifacts"][0]["media_validation"] == "validated_member_emission"
    assert matrix["artifacts"][0]["lineage_role"] == "extracted_medium"
    assert "runnable game port" in matrix["boundary"]


def test_static_report_ignores_mutable_live_log_tails(tmp_path: Path) -> None:
    output_dir = tmp_path / "output"
    db = Database(output_dir / "state.db")
    logs_dir = output_dir / "logs"
    logs_dir.mkdir(parents=True)
    general_log = logs_dir / "daad_general.log"
    games_log = logs_dir / "daad_games.log"
    general_log.write_text("first mutable event\n", encoding="utf-8")
    games_log.write_text("first game event\n", encoding="utf-8")

    exporter = StaticReportExporter(db, output_dir, generated_at="2000-01-01T00:00:00+00:00")
    first = exporter.write().read_bytes()

    general_log.write_text("second mutable event\n", encoding="utf-8")
    games_log.write_text("second game event\n", encoding="utf-8")
    second = exporter.write().read_bytes()
    report = json.loads(second)

    assert second == first
    assert report["logs"]["general"][0].startswith("Mutable operational logs are intentionally excluded")
    assert report["logs"]["games"][0].startswith("Per-game live log tails are not exported")
