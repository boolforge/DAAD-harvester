import pytest
from pathlib import Path
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform
from daad_harvester.synthesize import Synthesizer, cpp_escape

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


def test_cpp_escape_quotes_and_backslashes():
    """Titles/filenames come from harvested archives -- external, untrusted
    strings -- and get embedded directly inside C++ "..." string literals in
    detection_tables.h. Without escaping, a title containing '"' or '\\'
    (both common in the wild, e.g. a 5.25" floppy disk or a Windows-style
    path) silently produces a detection_tables.h that fails to compile,
    with nothing in the Python pipeline ever raising an error about it."""
    assert cpp_escape('Aventura "Especial" 5.25" Disk') == 'Aventura \\"Especial\\" 5.25\\" Disk'
    assert cpp_escape("C:\\Games\\daad.exe") == "C:\\\\Games\\\\daad.exe"
    assert cpp_escape(None) == ""
    assert cpp_escape(1988) == "1988"
    # Embedded control characters (e.g. a stray CR/LF/NUL in scraped
    # metadata) must not be able to break out of the string literal.
    assert "\n" not in cpp_escape("Title\nwith\nnewlines")
    assert "\x00" not in cpp_escape("Title\x00null")


def test_synthesize_output_escapes_quotes_in_title(tmp_path):
    """End-to-end: a quote/backslash-bearing title must not corrupt the
    generated C++ header -- every quote inside a string literal must be
    preceded by a backslash, keeping the literal well-formed."""
    test_dir = tmp_path / "synth_out2"
    db = Database(test_dir / "test.db")

    src_id = db.add_source("http://example.com/test2.zip", "archive")
    art = ArtifactRecord(
        id=None,
        source_id=src_id,
        original_filename='La "Diosa" de Cozumel.ddb',
        extracted_path="/tmp/diosa.ddb",
        archive_depth=1,
        file_size=1024,
        md5_full="1" * 32,
        md5_5000="2" * 32,
        sha256="3" * 64,
        is_daad_payload=True,
        title='La "Diosa" de Cozumel',
        platform_hint=Platform.AMIGA.value,
    )
    db.add_artifact(art)

    synth = Synthesizer(db, output_dir=test_dir)
    json_path, header_path, _ = synth.synthesize_catalog()

    header_text = header_path.read_text()
    assert 'La \\"Diosa\\" de Cozumel' in header_text

    # Sanity check that every unescaped quote is a real literal delimiter:
    # after stripping escaped quotes, remaining quotes on generated-entry
    # lines must come in pairs (well-formed open/close), never an odd count.
    import re
    for line in header_text.splitlines():
        if '"' not in line:
            continue
        unescaped = re.sub(r'\\.', '', line)  # drop \" and \\ pairs
        assert unescaped.count('"') % 2 == 0, f"unbalanced quote in: {line!r}"
