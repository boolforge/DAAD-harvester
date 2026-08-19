"""Build a classified, provenance-preserving local game library.

The library is a post-processing view of downloaded artifacts. It never
changes or deletes the extraction tree and it distinguishes runnable releases
from archives, support files, and unverified candidates.
"""

from __future__ import annotations

import json
import os
import re
import shutil
from collections import Counter
from pathlib import Path
from typing import Any, Dict, Optional

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform, SourceRecord


RUNNABLE_EXTENSIONS = {
    ".adf", ".adz", ".com", ".d64", ".dsk", ".exe", ".msa", ".prg",
    ".rom", ".st", ".tap", ".t64", ".tzx",
}
ARCHIVE_EXTENSIONS = {".7z", ".arj", ".cab", ".lha", ".lzh", ".rar", ".tar", ".zip"}


def _path_component(value: str, fallback: str) -> str:
    """Return a portable directory component derived from trusted local metadata."""
    normalized = re.sub(r"[^A-Za-z0-9._-]+", "_", value.strip()).strip("._-")
    return normalized[:96] or fallback


def _artifact_classification(artifact: ArtifactRecord) -> str:
    extension = Path(artifact.original_filename).suffix.lower()
    if extension in RUNNABLE_EXTENSIONS:
        return "ready_to_use"
    if extension in ARCHIVE_EXTENSIONS:
        return "archive"
    return "support_or_unknown"


class LibraryBuilder:
    """Materialize classified game folders from persisted artifact records."""

    def __init__(self, db: Database, output_dir: Path):
        self.db = db
        self.output_dir = output_dir
        self.library_dir = output_dir / "library"

    @staticmethod
    def _source_platform(artifact: ArtifactRecord, source: Optional[SourceRecord]) -> str:
        hint = artifact.platform_hint
        if hint and hint != Platform.UNKNOWN.value:
            return hint
        return source.platform if source and source.platform else Platform.UNKNOWN.value

    @staticmethod
    def _game_identity(artifact: ArtifactRecord, source: Optional[SourceRecord]) -> tuple[str, str]:
        if source and source.known_game_id:
            return source.known_game_id, source.title or source.known_game_id
        title = artifact.title or (source.title if source else None) or Path(artifact.original_filename).stem
        return _path_component(title, "unmatched_candidate").lower(), title

    @staticmethod
    def _materialize(source: Path, destination: Path) -> str:
        """Hard-link when possible; copy as a portable fallback."""
        destination.parent.mkdir(parents=True, exist_ok=True)
        if destination.exists():
            if destination.stat().st_size == source.stat().st_size:
                return "existing"
            destination.unlink()
        try:
            os.link(source, destination)
            return "hardlink"
        except OSError:
            shutil.copy2(source, destination)
            return "copy"

    def build(self) -> Path:
        """Build the library tree and return the manifest path.

        A source file is included only when it exists on disk. The manifest
        records omitted rows rather than fabricating a ready-to-use result.
        """
        self.library_dir.mkdir(parents=True, exist_ok=True)
        sources = {source.id: source for source in self.db.get_all_sources()}
        entries: list[Dict[str, Any]] = []
        summary: Counter[str] = Counter()

        for artifact in self.db.get_all_artifacts():
            source = sources.get(artifact.source_id)
            source_path = Path(artifact.extracted_path)
            classification = _artifact_classification(artifact)
            platform = self._source_platform(artifact, source)
            game_id, title = self._game_identity(artifact, source)
            platform_component = _path_component(platform.upper(), "UNKNOWN")
            game_component = _path_component(game_id, "unmatched_candidate")
            display_filename = re.sub(r"^\d+_", "", artifact.original_filename)
            artifact_component = _path_component(display_filename, f"artifact_{artifact.id}")
            destination = self.library_dir / platform_component / game_component / classification / artifact_component

            entry: Dict[str, Any] = {
                "artifact_id": artifact.id,
                "source_id": artifact.source_id,
                "game_id": game_id,
                "title": title,
                "platform": platform,
                "classification": classification,
                "ready_to_use": classification == "ready_to_use",
                "binary_verified_daad": artifact.is_daad_payload,
                "daad_version_guess": artifact.daad_version_guess,
                "source_url": source.url if source else None,
                "sha256": artifact.sha256,
                "size": artifact.file_size,
                "original_filename": artifact.original_filename,
                "source_path": str(source_path),
                "library_path": str(destination.relative_to(self.output_dir)),
            }

            if source_path.is_file():
                entry["materialization"] = self._materialize(source_path, destination)
                summary[classification] += 1
            else:
                entry["materialization"] = "missing_source_file"
                summary["missing_source_file"] += 1
            entries.append(entry)

        manifest = {
            "schema_version": 1,
            "purpose": "Classified local game library with retained provenance",
            "classification_policy": {
                "ready_to_use": "Direct disk, tape, executable, ROM, or program image retained under platform/game folders.",
                "archive": "Archive container retained for provenance but not claimed to be directly runnable.",
                "support_or_unknown": "Auxiliary or unknown-format artifact retained without a runnable claim.",
            },
            "summary": dict(sorted(summary.items())),
            "artifacts": entries,
        }
        manifest_path = self.library_dir / "manifest.json"
        manifest_path.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        return manifest_path
