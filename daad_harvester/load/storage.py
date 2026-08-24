"""SQLAlchemy SQLite storage engine for resilient pipeline state management.

Integration status, verified empirically while auditing the original version of this
module: StorageEngine.__init__ always constructs self.legacy_db = Database(db_path)
first, and Database's own __init__ runs `CREATE TABLE IF NOT EXISTS sources (...)`
against the same db_path. Because SourceEntity below ALSO declares
__tablename__ = "sources" against that same file, by the time init_storage() calls
Base.metadata.create_all(), the "sources" table already exists -- and create_all()
uses checkfirst=True by default, so it silently does nothing for that table rather
than validating or reconciling the two schemas. In the current wiring, that means:
  - legacy_db (the raw-SQL Database class) remains the actual source of truth for
    every column read or written by the pipeline.
  - SourceEntity/get_session() are real, working SQLAlchemy objects, but nothing in
    the pipeline calls get_session() yet, so they have no effect today.
This is left in place as a deliberate, clearly-labeled scaffold for a future
migration -- NOT because it is currently doing the state tracking its class
docstring below describes. See test_load_storage.py for a test that locks in this
documented behavior so it cannot silently change without the test noticing.
"""

from pathlib import Path
from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    create_engine,
)
from sqlalchemy.orm import DeclarativeBase, Session, sessionmaker

from daad_harvester.db import Database


class Base(DeclarativeBase):
    """Base declarative model for SQLAlchemy tables."""
    pass


class SourceEntity(Base):
    """SQLAlchemy model for pipeline sources."""
    __tablename__ = "sources"

    id = Column(Integer, primary_key=True, autoincrement=True)
    url = Column(String, unique=True, index=True)
    source_tier = Column(String, nullable=True)
    status = Column(String, index=True, default="pending")
    http_status = Column(Integer, nullable=True)
    content_type = Column(String, nullable=True)
    local_path = Column(String, nullable=True)
    title = Column(String, nullable=True)
    platform = Column(String, nullable=True)
    year = Column(Integer, nullable=True)
    publisher = Column(String, nullable=True)
    author = Column(String, nullable=True)
    language = Column(String, nullable=True)
    known_game_id = Column(String, nullable=True)
    acquisition_priority = Column(Integer, default=0)
    source_name = Column(String, nullable=True)
    source_role = Column(String, nullable=True)
    source_record_url = Column(String, nullable=True)
    source_release_id = Column(String, nullable=True)
    release_version = Column(String, nullable=True)
    toolchain_claim = Column(String, nullable=True)
    provenance_json = Column(Text, nullable=True)
    discovered_at = Column(String, nullable=True)
    processed_at = Column(String, nullable=True)


class StorageEngine:
    """SQLAlchemy scaffold wrapping the legacy sqlite Database class.

    legacy_db remains the actual source of truth today; see the module docstring
    above for why Base.metadata.create_all() is currently a no-op for SourceEntity.
    """

    def __init__(self, db_path: Path) -> None:
        """Initializes SQLAlchemy storage engine with SQLite database file path.

        Args:
            db_path: Path to state.db SQLite database file.
        """
        self.db_path = Path(db_path)
        if self.db_path != Path(":memory:") and str(self.db_path) != ":memory:":
            self.db_path.parent.mkdir(parents=True, exist_ok=True)

        self.engine = create_engine(f"sqlite:///{self.db_path}", echo=False)
        self.SessionLocal = sessionmaker(bind=self.engine)
        self.legacy_db = Database(self.db_path)

    def init_storage(self) -> None:
        """Creates tables and runs database backfill/migrations."""
        Base.metadata.create_all(bind=self.engine)
        self.legacy_db.backfill_and_rescan_session()

    def get_session(self) -> Session:
        """Returns a new SQLAlchemy Session instance."""
        return self.SessionLocal()
