import pytest
from pathlib import Path
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform
from daad_harvester.synthesize import Synthesizer

def test_synthesize_output(tmp_path):
    test_dir = tmp_path / "synth_out"
    test_db = test_dir / "test.db"

    db = Database(test_db)

    # Add mock DAAD artifact
    src_id = db.add_source("http://example.com/test.zip", "archive")
    art = ArtifactRecord(
        id=None,
        source_id=src_id,
        original_filename="aventura.ddb",
        extracted_path="/tmp/aventura.ddb",
        archive_depth=1,
        file_size=47104,
        md5_full="a1b2c3d4e5f67890a1b2c3d4e5f67890",
        md5_5000="11223344556677889900112233445566",
        sha256="abc123sha256",
        is_daad_payload=True,
        daad_version_guess="DAAD v2.x",
        platform_hint=Platform.ZX.value
    )
    db.add_artifact(art)

    synth = Synthesizer(db, output_dir=test_dir)
    json_path, header_path, collisions = synth.synthesize_catalog()

    assert json_path.exists()
    assert header_path.exists()

    header_text = header_path.read_text()
    assert "#ifndef DAAD_DETECTION_TABLES_H" in header_text
    assert "a1b2c3d4e5f67890a1b2c3d4e5f67890" in header_text
    assert "Common::kPlatformZXSpectrum" in header_text
    assert "AD_END_MARKER" in header_text
