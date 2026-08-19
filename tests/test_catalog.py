import json

from daad_harvester.catalog import EvidenceCatalogExporter
from daad_harvester.db import Database
from daad_harvester.discover import Discoverer
from daad_harvester.known_games import KNOWN_GAMES, acquisition_priority, find_known_game
from daad_harvester.models import SourceTier


def test_known_game_catalog_matches_aliases_without_claiming_an_exact_engine_build():
    cozumel = find_known_game("La Diosa de Cozumel")
    chichen = find_known_game("Chichen Itza")

    assert cozumel is not None
    assert cozumel.game_id == "cozumel"
    assert chichen is not None
    assert chichen.game_id == "chichen_itza"
    assert "Exact commercial DAAD build unverified" in chichen.engine_version_evidence
    assert acquisition_priority(chichen, "cpc") == acquisition_priority(chichen, "zx") == 1000


def test_expanded_catalog_keeps_release_revision_and_binary_version_distinct():
    eight_feet = find_known_game("Eight Feet Under")
    rudolphine = find_known_game("Aventuras de Rudolphine Rur, Las")
    golden_seas = find_known_game("Golden Seas")

    assert eight_feet is not None
    assert eight_feet.platforms == ("zx", "cpc", "c64", "plus4", "msx", "atarist", "amiga", "dos")
    assert "R6" in eight_feet.engine_version_evidence
    assert rudolphine is not None and "pcw" in rudolphine.platforms
    assert golden_seas is not None and golden_seas.year is None
    assert golden_seas.platforms == ()


def test_discovery_persists_catalog_identity_and_orders_cpc_first(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    assert discoverer._add_source(
        "https://example.com/unknown.zip", SourceTier.ARCHIVE, title="Unknown DAAD candidate", platform="zx"
    )
    assert discoverer._add_source(
        "https://example.com/chichen.zip", SourceTier.ARCHIVE, title="Chichen Itza", platform="cpc"
    )
    assert discoverer._add_source(
        "https://example.com/cozumel.zip", SourceTier.ARCHIVE, title="La Diosa de Cozumel", platform="zx"
    )

    pending = db.get_pending_sources()
    assert [source.known_game_id for source in pending] == ["chichen_itza", "cozumel", None]
    assert pending[0].acquisition_priority == 1000
    assert pending[0].title == "Chichén Itzá"
    assert pending[0].year == 1992
    assert pending[0].publisher == "Aventuras AD"


def test_discovery_requires_explicit_cpc_evidence_for_ambiguous_disk_images(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    assert discoverer._add_source(
        "https://example.com/ChichenItza.dsk.zip", SourceTier.ARCHIVE, title="Chichen Itza"
    )

    source = db.get_pending_sources()[0]
    assert source.platform is None
    assert source.known_game_id == "chichen_itza"
    assert source.acquisition_priority == 900


def test_evidence_catalog_export_keeps_source_evidence_separate_from_binary_verification(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    discoverer._add_source(
        "https://example.com/aventura.dsk", SourceTier.ARCHIVE, title="La Aventura Original", platform="cpc"
    )

    output_path = EvidenceCatalogExporter(db, tmp_path).write()
    payload = json.loads(output_path.read_text(encoding="utf-8"))
    aventura = next(game for game in payload["games"] if game["game_id"] == "la_aventura_original")

    assert payload["summary"]["known_games"] == len(KNOWN_GAMES)
    assert payload["summary"]["known_games"] > 6
    assert payload["summary"]["queued_known_sources"] == 1
    assert aventura["engine"]["family"] == "DAAD"
    assert aventura["engine"]["binary_verification_required"] is True
    assert aventura["queued_sources"][0]["platform"] == "cpc"
    assert aventura["queued_sources"][0]["priority"] == 1000
