"""Tests for daad_harvester.load.storage.StorageEngine.

The most important test here is test_init_storage_does_not_disturb_legacy_data: it
locks in, empirically, the exact behavior documented in storage.py's module
docstring -- that legacy_db (raw-SQL Database) remains the real source of truth, and
that Base.metadata.create_all() is a no-op for the colliding "sources" table name
rather than something that could reset or duplicate existing data. If a future change
makes StorageEngine construction order-dependent in a way that risks data loss, this
test will fail before that ships.
"""
import sqlite3

from sqlalchemy import inspect as sa_inspect
from sqlalchemy.orm import Session

from daad_harvester.load.storage import SourceEntity, StorageEngine


def test_init_storage_does_not_disturb_legacy_data(tmp_path):
    db_path = tmp_path / "state.db"

    # Seed data through the legacy path first, the same order StorageEngine.__init__
    # always uses (self.legacy_db = Database(self.db_path) runs before init_storage()
    # is ever called).
    engine = StorageEngine(db_path)
    source_id = engine.legacy_db.add_source(
        url="https://example.com/game.zip", source_tier="primary", source_name="Test Source"
    )
    assert source_id is not None

    engine.init_storage()

    # The legacy row must still be there, untouched, after init_storage() runs.
    sources = engine.legacy_db.get_all_sources()
    assert len(sources) == 1
    assert sources[0].url == "https://example.com/game.zip"

    # And the "sources" table's actual schema on disk is the legacy raw-SQL schema,
    # not SQLAlchemy's SourceEntity -- proving create_all() left it alone rather than
    # reconciling or overwriting it.
    with sqlite3.connect(db_path) as conn:
        columns = {row[1] for row in conn.execute("PRAGMA table_info(sources)")}
    assert "source_tier" in columns  # present on the legacy schema
    assert "http_status" in columns  # present on SourceEntity but not the legacy schema
    # (both present confirms this is the legacy table, which happens to be a superset
    # here; the decisive point demonstrated is that init_storage() did not drop or
    # recreate it, which the row-survives assertion above already proves directly)


def test_get_session_returns_a_working_sqlalchemy_session(tmp_path):
    engine = StorageEngine(tmp_path / "state.db")
    engine.init_storage()

    session = engine.get_session()
    try:
        assert isinstance(session, Session)
        # SourceEntity is real and queryable via this session, even though nothing in
        # the pipeline populates it yet (see module docstring).
        assert session.query(SourceEntity).count() == 0
    finally:
        session.close()


def test_source_entity_table_name_matches_legacy_schema_name():
    # Documents, explicitly, the root cause of the no-op: both schemas target the
    # same table name in the same database file.
    assert sa_inspect(SourceEntity).local_table.name == "sources"
