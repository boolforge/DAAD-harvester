"""Tests for scripts/verify_game_corpus.py.

test_hash_mismatch_on_a_pre_convention_absolute_path_does_not_crash is a
regression test for a real bug found while auditing this file, the identical
class of bug already found and fixed in scripts/verify_reverse_corpus.py:
repository_path() returns a database row's extracted_path column unchanged
whenever it is already absolute and doesn't contain "/preservation_corpus/" --
meaning old rows (predating that convention) or corrupted ones aren't guaranteed
to resolve under ROOT. The "missing file" branch already guarded
`path.relative_to(ROOT)` against that; the "hash mismatch" branch right next to it
did not, so a wrong-hash artifact recorded with a pre-convention absolute path
crashed the whole verifier with an unhandled ValueError instead of reporting the
mismatch.
"""
import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

import verify_game_corpus as m  # noqa: E402


def _setup(tmp_path, monkeypatch):
    corpus = tmp_path / "preservation_corpus"
    corpus.mkdir()
    (corpus / "COVERAGE_LEDGER.md").write_text("x", encoding="utf-8")
    database = corpus / "state.db"
    monkeypatch.setattr(m, "ROOT", tmp_path)
    monkeypatch.setattr(m, "CORPUS", corpus)
    monkeypatch.setattr(m, "DATABASE", database)
    return corpus, database


def _seed_db(database, artifacts, source_count=1):
    connection = sqlite3.connect(database)
    connection.execute("CREATE TABLE sources (id INTEGER)")
    connection.execute(
        "CREATE TABLE artifacts (id INTEGER, source_id INTEGER, original_filename TEXT, "
        "extracted_path TEXT, sha256 TEXT)"
    )
    connection.executemany("INSERT INTO sources VALUES (?)", [(i,) for i in range(1, source_count + 1)])
    connection.executemany(
        "INSERT INTO artifacts VALUES (?, ?, ?, ?, ?)",
        [(a["id"], a.get("source_id", 1), a["filename"], a["path"], a["sha256"]) for a in artifacts],
    )
    connection.commit()
    connection.close()


def test_repository_path_maps_the_preservation_corpus_marker(tmp_path, monkeypatch):
    _setup(tmp_path, monkeypatch)
    result = m.repository_path("/some/old/machine/preservation_corpus/games/x.zip")
    assert result == m.CORPUS / "games/x.zip"


def test_repository_path_treats_a_plain_relative_string_as_root_relative(tmp_path, monkeypatch):
    _setup(tmp_path, monkeypatch)
    assert m.repository_path("games/x.zip") == tmp_path / "games/x.zip"


def test_repository_path_returns_a_pre_convention_absolute_path_unchanged(tmp_path, monkeypatch):
    _setup(tmp_path, monkeypatch)
    assert m.repository_path("/tmp/elsewhere/x.zip") == Path("/tmp/elsewhere/x.zip")


def test_safe_relative_handles_a_path_outside_root(tmp_path, monkeypatch):
    monkeypatch.setattr(m, "ROOT", tmp_path)
    outside = tmp_path.parent / f"{tmp_path.name}-outside"
    assert m.safe_relative(outside) == outside  # returned as-is, no crash


def test_main_passes_with_matching_hash(tmp_path, monkeypatch):
    corpus, database = _setup(tmp_path, monkeypatch)
    content = b"game bytes"
    (corpus / "x.zip").write_bytes(content)
    recorded_path = "/original/machine/preservation_corpus/x.zip"
    _seed_db(database, [{"id": 1, "filename": "x.zip", "path": recorded_path, "sha256": m.sha256(corpus / "x.zip")}])

    # main() prints rather than returning errors, so drive it directly and
    # capture its return code; content correctness is what matters here.
    import contextlib
    import io

    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        rc = m.main()
    assert rc == 0
    assert "verified" in buf.getvalue()


def test_main_reports_missing_file(tmp_path, monkeypatch, capsys):
    corpus, database = _setup(tmp_path, monkeypatch)
    _seed_db(database, [{"id": 1, "filename": "missing.zip", "path": "missing.zip", "sha256": "a" * 64}])

    rc = m.main()

    assert rc == 1
    assert "missing artifact 1" in capsys.readouterr().out


def test_main_reports_hash_mismatch(tmp_path, monkeypatch, capsys):
    corpus, database = _setup(tmp_path, monkeypatch)
    (corpus / "x.zip").write_bytes(b"real content")
    recorded_path = "/original/machine/preservation_corpus/x.zip"
    _seed_db(database, [{"id": 1, "filename": "x.zip", "path": recorded_path, "sha256": "0" * 64}])

    rc = m.main()

    out = capsys.readouterr().out
    assert rc == 1
    assert "hash mismatch for artifact 1" in out


def test_hash_mismatch_on_a_pre_convention_absolute_path_does_not_crash(tmp_path, monkeypatch, capsys):
    """The exact scenario that used to raise an unhandled ValueError."""
    corpus, database = _setup(tmp_path, monkeypatch)
    outside_target = tmp_path.parent / f"{tmp_path.name}-outside-target.bin"
    outside_target.write_bytes(b"real file, just not under this checkout")
    _seed_db(database, [{"id": 1, "filename": "old.zip", "path": str(outside_target), "sha256": "0" * 64}])

    rc = m.main()  # must not raise

    out = capsys.readouterr().out
    assert rc == 1
    assert "hash mismatch for artifact 1" in out


def test_main_reports_empty_retained_path(tmp_path, monkeypatch, capsys):
    corpus, database = _setup(tmp_path, monkeypatch)
    _seed_db(database, [{"id": 1, "filename": "x.zip", "path": "", "sha256": "a" * 64}])

    rc = m.main()

    assert rc == 1
    assert "has no retained path" in capsys.readouterr().out


def test_main_reports_missing_database(tmp_path, monkeypatch, capsys):
    corpus = tmp_path / "preservation_corpus"
    corpus.mkdir()
    monkeypatch.setattr(m, "ROOT", tmp_path)
    monkeypatch.setattr(m, "CORPUS", corpus)
    monkeypatch.setattr(m, "DATABASE", corpus / "state.db")

    rc = m.main()

    assert rc == 1
    assert "missing" in capsys.readouterr().out


def test_main_passes_against_the_real_repository():
    # The real, live check -- exactly what scripts/run_primary_workflow.py runs.
    assert m.main() == 0
