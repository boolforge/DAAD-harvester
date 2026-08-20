"""Tests for the static preservation-report JSON contract."""

from __future__ import annotations

import json
from hashlib import md5, sha1, sha256
from pathlib import Path

from daad_harvester.db import Database
from daad_harvester.known_games import iter_known_games
from daad_harvester.models import ArtifactRecord
from daad_harvester.report_export import StaticReportExporter


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
    retained = output_dir / "extracted" / "adventure.ddb"
    retained.parent.mkdir(parents=True)
    retained.write_bytes(payload)
    artifact = ArtifactRecord(
        id=None, source_id=source_id, original_filename="ADVENTURE.DDB", extracted_path=str(retained), archive_depth=1,
        file_size=len(payload), md5_full=md5(payload).hexdigest(), md5_5000=md5(payload).hexdigest(), sha1=sha1(payload).hexdigest(), sha256=sha256(payload).hexdigest(), crc32="4c489e91", xxh64="c4e1a1da48f74b26",
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
    assert "extracted_path" not in report["catalog"]["artifacts"][0]
    matrix = next(item for item in report["game_port_matrix"] if item["game_id"] == known_game.game_id)
    assert matrix["source_platforms"] == ["c64"]
    assert matrix["measured_artifact_platforms"] == ["c64"]
    assert matrix["artifacts"][0]["sha256"] == sha256(payload).hexdigest()
    assert matrix["artifacts"][0]["checksums"] == {
        "sha256": sha256(payload).hexdigest(),
        "sha1": sha1(payload).hexdigest(),
        "md5_full": md5(payload).hexdigest(),
        "md5_5000": md5(payload).hexdigest(),
        "crc32": "4c489e91",
        "xxh64": "c4e1a1da48f74b26",
    }
    assert matrix["artifacts"][0]["evidence_state"] == "verified_ddb"
    assert "runnable game port" in matrix["boundary"]
