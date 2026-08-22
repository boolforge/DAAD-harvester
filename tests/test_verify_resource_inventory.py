import sqlite3
from pathlib import Path

from scripts.verify_resource_inventory import verify


def test_retained_inventory_is_complete() -> None:
    total, missing = verify(Path(__file__).parents[1] / "preservation_corpus" / "state.db")
    assert total == 1015
    assert missing == {}


def test_inventory_rejects_invalid_hash(tmp_path: Path) -> None:
    source = Path(__file__).parents[1] / "preservation_corpus" / "state.db"
    database = tmp_path / "state.db"
    database.write_bytes(source.read_bytes())
    connection = sqlite3.connect(database)
    connection.execute("UPDATE artifacts SET sha256 = 'invalid' WHERE id = 1")
    connection.commit()
    connection.close()
    total, missing = verify(database)
    assert total == 1015
    assert missing["sha256_hex"] == 1
