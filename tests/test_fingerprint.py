import pytest
from pathlib import Path
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform
from daad_harvester.fingerprint import Fingerprinter

def test_fingerprint_positive_ddb():
    db = Database(Path(":memory:"))
    fingerprinter = Fingerprinter(db)

    # Mock DAAD DDB payload
    mock_daad_data = b"\x00\x01DAAD Database Header Proceso 0 1 2 COGER DEJAR MIRAR NORTE SUR ESTE OESTE"
    score, ver, platform = fingerprinter.analyze_daad_heuristics(mock_daad_data, "game.ddb")
    assert score >= 0.75
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
