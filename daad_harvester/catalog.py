"""Export the evidence-backed acquisition catalog before binary verification.

This module reports what is known from public game databases separately from
what is only inferred after fingerprinting an actual downloaded payload.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Dict, List

from daad_harvester.db import Database
from daad_harvester.known_games import KnownGame, iter_known_games


class EvidenceCatalogExporter:
    """Writes a reviewable acquisition manifest from static evidence and queued sources."""

    def __init__(self, db: Database, output_dir: Path):
        self.db = db
        self.output_dir = output_dir

    @staticmethod
    def _game_entry(game: KnownGame, sources: List[Any]) -> Dict[str, Any]:
        matched = [source for source in sources if source.known_game_id == game.game_id]
        return {
            "game_id": game.game_id,
            "title": game.title,
            "year": game.year,
            "publisher": game.publisher,
            "engine": {
                "family": game.engine_family,
                "version_evidence": game.engine_version_evidence,
                "binary_verification_required": True,
            },
            "platform_evidence": list(game.platforms),
            "evidence_urls": list(game.evidence_urls),
            "notes": game.notes or None,
            "queued_sources": [
                {
                    "url": source.url,
                    "source_tier": source.source_tier,
                    "status": source.status,
                    "platform": source.platform,
                    "priority": source.acquisition_priority,
                }
                for source in sorted(
                    matched,
                    key=lambda source: (-source.acquisition_priority, source.url),
                )
            ],
        }

    def build(self) -> Dict[str, Any]:
        """Build a serializable catalog without claiming unmeasured binary versions."""
        sources = self.db.get_all_sources()
        games = [self._game_entry(game, sources) for game in iter_known_games()]
        queued_known_sources = sum(len(game["queued_sources"]) for game in games)
        return {
            "schema_version": 1,
            "purpose": "Evidence-backed DAAD acquisition planning",
            "version_policy": (
                "Exact DAAD version labels are emitted only after a downloaded "
                "payload is fingerprinted; catalog entries retain source-backed "
                "engine-family and platform evidence."
            ),
            "priority_policy": (
                "Known commercial Aventuras AD titles are prioritized over unknown "
                "discoveries, and their verified CPC variants receive the highest "
                "acquisition priority."
            ),
            "summary": {
                "known_games": len(games),
                "all_sources": len(sources),
                "queued_known_sources": queued_known_sources,
                "unmatched_sources": sum(1 for source in sources if not source.known_game_id),
            },
            "games": games,
        }

    def write(self) -> Path:
        """Write the catalog JSON to the selected output directory."""
        self.output_dir.mkdir(parents=True, exist_ok=True)
        output_path = self.output_dir / "evidence_catalog.json"
        output_path.write_text(json.dumps(self.build(), indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        return output_path
