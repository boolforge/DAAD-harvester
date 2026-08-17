import pytest
from pathlib import Path
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform
from daad_harvester.fingerprint import Fingerprinter
from daad_harvester.daad_parser import DAADParser

def test_fingerprint_positive_ddb():
    db = Database(Path(":memory:"))
    fingerprinter = Fingerprinter(db)

    # Valid DAAD DDB payload with valid process table pointers and DAAD Ready signature
    pointers = b"\x10\x00\x14\x00\x18\x00" + b"\x00" * 10 # Pointers: 16, 20, 24
    content = pointers + b"DAADREADY Header Proceso 0 1 2 COGER DEJAR MIRAR NORTE SUR ESTE OESTE"
    score, ver, platform = fingerprinter.analyze_daad_heuristics(content, "game.ddb")
    assert score >= 0.70
    assert ver is not None

def test_fingerprint_rejection_paws():
    db = Database(Path(":memory:"))
    fingerprinter = Fingerprinter(db)

    mock_paws_data = b"PAWS Engine Database Headers COGER DEJAR MIRAR"
    score, ver, platform = fingerprinter.analyze_daad_heuristics(mock_paws_data, "paws_game.dat")
    assert score == 0.0

def test_fingerprint_rejection_gac():
    db = Database(Path(":memory:"))
    fingerprinter = Fingerprinter(db)

    mock_gac_data = b"Graphic Adventure Creator Incentive Software COGER DEJAR MIRAR"
    score, ver, platform = fingerprinter.analyze_daad_heuristics(mock_gac_data, "gac_game.dat")
    assert score == 0.0

def test_fingerprint_rejection_php_index():
    db = Database(Path(":memory:"))
    fingerprinter = Fingerprinter(db)

    mock_php_data = b"<?php echo 'Hello World'; ?>" + b"\x00" * 100
    score, ver, platform = fingerprinter.analyze_daad_heuristics(mock_php_data, "index.php")
    assert score == 0.0

def test_fingerprint_rejection_renpy():
    db = Database(Path(":memory:"))
    fingerprinter = Fingerprinter(db)

    mock_renpy_data = b"RENPY archive data " + b"\x00" * 500
    score, ver, platform = fingerprinter.analyze_daad_heuristics(mock_renpy_data, "renpy.data")
    assert score == 0.0

def test_daad_parser_direct():
    parser = DAADParser()
    pointers = b"\x10\x00\x14\x00\x18\x00" + b"\x00" * 10
    content = pointers + b"DAADREADY Header Proceso 0 1 2 COGER DEJAR MIRAR NORTE SUR ESTE OESTE"
    result = parser.parse_ddb(content, "game.ddb")
    assert result["is_daad"] is True
    assert result["confidence"] >= 0.70
