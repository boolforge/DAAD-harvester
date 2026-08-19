"""Tests for the static preservation-report JSON contract."""

from __future__ import annotations

import json
from hashlib import md5, sha256
from pathlib import Path

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.report_export import StaticReportExporter


def test_static_report_export_uses_real_evidence_and_omits_local_paths(tmp_path: Path) -> None:
    output_dir = tmp_path / "output"
    db = Database(output_dir / "state.db")
    source_id = db.add_source("https://example.invalid/adventure.d64", "archive", platform="c64")
    payload = b"recorded artifact"
    retained = output_dir / "extracted" / "adventure.ddb"
    retained.parent.mkdir(parents=True)
    retained.write_bytes(payload)
    artifact = ArtifactRecord(
        id=None, source_id=source_id, original_filename="ADVENTURE.DDB", extracted_path=str(retained), archive_depth=1,
        file_size=len(payload), md5_full=md5(payload).hexdigest(), md5_5000=md5(payload).hexdigest(), sha256=sha256(payload).hexdigest(),
        is_daad_payload=True, measured_platform="c64", ddb_format="daad-v3", fingerprint_confidence="verified",
    )
    db.add_artifact(artifact)
    (output_dir / "detection_tables.h").write_text("#define DAAD_TEST 1\n", encoding="utf-8")

    path = StaticReportExporter(db, output_dir).write()
    report = json.loads(path.read_text(encoding="utf-8"))
    assert report["summary"]["verified_daad_artifacts"] == 1
    assert report["detections"]["available"] is True
    assert report["detections"]["download_path"] == "detection_tables.h"
    assert "extracted_path" not in report["catalog"]["artifacts"][0]
