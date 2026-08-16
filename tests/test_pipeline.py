import asyncio
import io
import zipfile
from pathlib import Path
import pytest

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform, SourceStatus
from daad_harvester.unpack import Unpacker
from daad_harvester.fingerprint import Fingerprinter
from daad_harvester.synthesize import Synthesizer
from daad_harvester.report import ReportGenerator

@pytest.fixture
def temp_dir(tmp_path):
    return tmp_path

def test_full_pipeline_flow(temp_dir):
    db_path = temp_dir / "test_pipeline.db"
    db = Database(db_path)

    # 1. Add Source
    src_id = db.add_source("https://example.com/aventura_original.zip", "archive")
    assert src_id is not None

    # Update source as downloaded
    db.update_source_status(src_id, status=SourceStatus.DOWNLOADED.value, http_status=200, local_path=str(temp_dir / "src.zip"))

    # 2. Mock Zip Data with embedded DAAD payload
    zip_buffer = io.BytesIO()
    with zipfile.ZipFile(zip_buffer, "w") as zf:
        zf.writestr("aventura.ddb", b"\x00\x01DAAD Database Header Proceso 0 1 2 COGER DEJAR MIRAR NORTE SUR ESTE OESTE")
        zf.writestr("paws_game.dat", b"PAWS Header COGER DEJAR")
    zip_bytes = zip_buffer.getvalue()

    # 3. Unpack
    unpacker = Unpacker(db, extract_dir=temp_dir / "extracted")
    ids = unpacker.unpack_artifact_recursive(source_id=src_id, filename="aventura_original.zip", data=zip_bytes, depth=0)
    assert len(ids) == 3 # root archive + 2 files

    # 4. Fingerprint
    fingerprinter = Fingerprinter(db)
    daad_count = fingerprinter.scan_all_artifacts()
    assert daad_count == 1 # Only aventura.ddb should pass >= 0.75

    # 5. Synthesize
    synth = Synthesizer(db, output_dir=temp_dir / "output")
    json_path, header_path, collisions = synth.synthesize_catalog()

    assert json_path.exists()
    assert header_path.exists()

    # Verify header file content
    header_content = header_path.read_text()
    assert "#ifndef DAAD_DETECTION_TABLES_H" in header_content
    assert "daad_aventura" in header_content

    # 6. Report
    reporter = ReportGenerator(db, output_dir=temp_dir / "output")
    report_path = reporter.generate_report(collisions=collisions)
    assert report_path.exists()
    report_content = report_path.read_text()
    assert "Execution Summary Report" in report_content
    assert "Verified DAAD Payloads:** 1" in report_content
