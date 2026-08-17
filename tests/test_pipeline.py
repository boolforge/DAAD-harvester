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

    # 2. Mock Zip Data with embedded valid DAAD payload and a PAWS payload
    # Construct valid DAAD DDB byte stream
    header = bytearray(32)
    header[0], header[1] = 0x20, 0x00 # P0 = 32
    header[2], header[3] = 0x30, 0x00 # P1 = 48
    header[4], header[5] = 0x40, 0x00 # P2 = 64

    payload = bytearray(128)
    payload[:32] = header

    p0_bytes = bytes([0x01, 0x01, 0x01, 0x05, 0x09, 0x0A, 0x81, 0x02, 0xFE])
    payload[32:32 + len(p0_bytes)] = p0_bytes

    p1_bytes = bytes([0x00, 0x00, 0x0B, 0x01, 0x8C, 0x01, 0xFE])
    payload[48:48 + len(p1_bytes)] = p1_bytes

    payload.extend(b"Es muy oscuro No ves nada Llevas contigo DAADREADY")
    payload.extend(b"INVE MIRA COGE DEJA NORT SUR ESTE OEST")

    zip_buffer = io.BytesIO()
    with zipfile.ZipFile(zip_buffer, "w") as zf:
        zf.writestr("aventura.ddb", bytes(payload))
        zf.writestr("paws_game.dat", b"PAWS Header COGER DEJAR")
    zip_bytes = zip_buffer.getvalue()

    # 3. Unpack
    unpacker = Unpacker(db, extract_dir=temp_dir / "extracted")
    ids = unpacker.unpack_artifact_recursive(source_id=src_id, filename="aventura_original.zip", data=zip_bytes, depth=0)
    assert len(ids) == 3 # root archive + 2 files

    # 4. Fingerprint
    fingerprinter = Fingerprinter(db)
    daad_count = fingerprinter.scan_all_artifacts()
    assert daad_count == 1 # Only aventura.ddb should pass

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
