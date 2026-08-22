from pathlib import Path
import subprocess

from daad_harvester import acquisition
from daad_harvester.db import Database
from daad_harvester.models import SourceStatus, SourceTier
from scripts.acquire_authorized_candidates import acquire_itchio_source


def candidate() -> dict[str, str]:
    return {"title": "Cero Absoluto", "publisher": "ESP Soft", "year": "2016", "language": "Spanish"}


def policy() -> dict[str, str]:
    return {
        "authorization_state": "institutional_authorized",
        "directive": "docs/reverse_engineering/AUTHORIZATION_AND_HANDLING.md",
        "scope": "acquire_retain_execute_analyze_publish",
    }


def registration() -> dict:
    return {
        "candidate_key": acquisition.candidate_key(candidate()),
        "source_url": "https://example.itch.io/cero",
        "source_record_url": "https://example.itch.io/cero",
        "release_identity": {"title": "Cero Absoluto", "publisher": "ESP Soft", "year": "2016"},
        "source_adapter": {"name": "itchio_downloader_free_v1", "page_url": "https://example.itch.io/cero", "upload_id": 42},
    }


def test_itch_adapter_registration_requires_canonical_page_and_upload_id() -> None:
    assert acquisition.validate_registration(candidate(), registration(), policy()).allowed
    invalid = registration()
    invalid["source_adapter"] = {"name": "itchio_downloader_free_v1", "page_url": "https://other.test", "upload_id": "42"}
    assert acquisition.validate_registration(candidate(), invalid, policy()).reason == "invalid_source_adapter_registration"


def test_itch_adapter_promotes_only_the_registered_upload(monkeypatch, tmp_path: Path) -> None:
    db = Database(tmp_path / "state.db")
    source_id = db.add_source("https://example.itch.io/cero", SourceTier.ARCHIVE.value)
    assert source_id is not None
    entry = {**candidate(), **registration(), "filename": "cero.zip"}

    def fake_run(command, **kwargs):
        adapter_dir = Path(command[command.index("--downloadDirectory") + 1])
        (adapter_dir / "game-42.zip").write_bytes(b"DAAD")
        (adapter_dir / "game-99.zip").write_bytes(b"wrong upload")
        return subprocess.CompletedProcess(command, 0, stdout="adapter completed")

    monkeypatch.setattr("scripts.acquire_authorized_candidates.subprocess.run", fake_run)
    acquire_itchio_source(db, source_id, entry, tmp_path)
    source = next(record for record in db.get_all_sources() if record.id == source_id)
    assert source.status == SourceStatus.DOWNLOADED.value
    assert Path(source.local_path).read_bytes() == b"DAAD"
    assert (tmp_path / "logs" / f"itchio_{source_id}.log").read_text(encoding="utf-8") == "adapter completed"
