"""Export evidence-backed DAAD acquisition and measurement provenance.

The catalog intentionally distinguishes source claims from measured properties:
publisher release revisions, toolchain claims, DDB format structure, and
interpreter identity each have separate fields and evidence records.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Dict, Iterable, List

from daad_harvester.db import Database
from daad_harvester.known_games import KnownGame, iter_known_games
from daad_harvester.models import ArtifactRecord, SourceRecord, VersionEvidenceRecord


class EvidenceCatalogExporter:
    """Writes a reviewable acquisition and binary-provenance manifest."""

    def __init__(self, db: Database, output_dir: Path):
        self.db = db
        self.output_dir = output_dir

    @staticmethod
    def _evidence_entry(evidence: VersionEvidenceRecord) -> Dict[str, Any]:
        return {
            "kind": evidence.kind,
            "value": evidence.value,
            "confidence": evidence.confidence,
            "source_url": evidence.source_url,
            "details_json": evidence.details_json,
            "observed_at": evidence.observed_at,
        }

    @classmethod
    def _source_entry(
        cls,
        source: SourceRecord,
        evidence: Iterable[VersionEvidenceRecord],
    ) -> Dict[str, Any]:
        return {
            "id": source.id,
            "url": source.url,
            "source_tier": source.source_tier,
            "source_name": source.source_name,
            "source_role": source.source_role,
            "source_record_url": source.source_record_url,
            "source_release_id": source.source_release_id,
            "status": source.status,
            "platform": source.platform,
            "title": source.title,
            "year": source.year,
            "publisher": source.publisher,
            "author": source.author,
            "language": source.language,
            "known_game_id": source.known_game_id,
            "priority": source.acquisition_priority,
            "release_version": source.release_version,
            "toolchain_claim": source.toolchain_claim,
            "provenance_json": source.provenance_json,
            "version_evidence": [cls._evidence_entry(item) for item in evidence],
        }

    @classmethod
    def _artifact_entry(
        cls,
        artifact: ArtifactRecord,
        evidence: Iterable[VersionEvidenceRecord],
    ) -> Dict[str, Any]:
        return {
            "id": artifact.id,
            "source_id": artifact.source_id,
            "original_filename": artifact.original_filename,
            "extracted_path": artifact.extracted_path,
            "sha256": artifact.sha256,
            "file_size": artifact.file_size,
            "container_format": artifact.container_format,
            "container_member": artifact.container_member,
            "is_daad_payload": artifact.is_daad_payload,
            "legacy_version_guess": artifact.daad_version_guess,
            "legacy_platform_hint": artifact.platform_hint,
            "measured_platform": artifact.measured_platform,
            "ddb_format": artifact.ddb_format,
            "ddb_major_version": artifact.ddb_major_version,
            "ddb_encoding": artifact.ddb_encoding,
            "interpreter_identity": artifact.interpreter_identity,
            "interpreter_version": artifact.interpreter_version,
            "fingerprint_confidence": artifact.fingerprint_confidence,
            "fingerprint_evidence_json": artifact.fingerprint_evidence_json,
            "version_evidence": [cls._evidence_entry(item) for item in evidence],
        }

    @classmethod
    def _game_entry(
        cls,
        game: KnownGame,
        sources: List[SourceRecord],
        source_evidence: Dict[int, List[VersionEvidenceRecord]],
    ) -> Dict[str, Any]:
        matched = [source for source in sources if source.known_game_id == game.game_id]
        return {
            "game_id": game.game_id,
            "title": game.title,
            "year": game.year,
            "publisher": game.publisher,
            "engine": {
                "family": game.engine_family,
                "catalog_version_evidence": game.engine_version_evidence,
                "binary_verification_required": True,
            },
            "platform_evidence": list(game.platforms),
            "evidence_urls": list(game.evidence_urls),
            "notes": game.notes or None,
            "queued_sources": [
                cls._source_entry(source, source_evidence.get(source.id or -1, []))
                for source in sorted(
                    matched,
                    key=lambda source: (-source.acquisition_priority, source.url),
                )
            ],
        }

    def build(self) -> Dict[str, Any]:
        """Build a serializable catalog without collapsing provenance layers."""
        sources = self.db.get_all_sources()
        artifacts = self.db.get_all_artifacts()
        source_evidence = {
            source.id: self.db.get_version_evidence(source_id=source.id)
            for source in sources
            if source.id is not None
        }
        artifact_evidence = {
            artifact.id: self.db.get_version_evidence(artifact_id=artifact.id)
            for artifact in artifacts
            if artifact.id is not None
        }
        games = [self._game_entry(game, sources, source_evidence) for game in iter_known_games()]
        queued_known_sources = sum(len(game["queued_sources"]) for game in games)
        return {
            "schema_version": 2,
            "purpose": "Evidence-backed DAAD acquisition planning and binary provenance",
            "version_policy": {
                "release_version": "Publisher release revision; never a DAAD engine version.",
                "toolchain_claim": "Source-provided build tool claim; not a binary measurement.",
                "ddb_format": "Measured only after container-aware structural validation.",
                "interpreter_identity": "Exact only for a trusted binary profile or embedded version evidence.",
                "unknowns": "Unknown values remain unknown; the exporter never fabricates an exact DAAD version.",
            },
            "priority_policy": (
                "Priority is evidence-led and must be platform-neutral among comparable "
                "verified catalog releases; source role controls whether a record is eligible for fetching."
            ),
            "summary": {
                "known_games": len(games),
                "all_sources": len(sources),
                "queued_known_sources": queued_known_sources,
                "unmatched_sources": sum(1 for source in sources if not source.known_game_id),
                "measured_artifacts": len(artifacts),
                "verified_daad_artifacts": sum(1 for artifact in artifacts if artifact.is_daad_payload),
            },
            "sources": [
                self._source_entry(source, source_evidence.get(source.id or -1, []))
                for source in sorted(sources, key=lambda source: (source.id or 0, source.url))
            ],
            "artifacts": [
                self._artifact_entry(artifact, artifact_evidence.get(artifact.id or -1, []))
                for artifact in sorted(artifacts, key=lambda artifact: (artifact.id or 0, artifact.original_filename))
            ],
            "games": games,
        }

    def write(self) -> Path:
        """Write the catalog JSON to the selected output directory."""
        self.output_dir.mkdir(parents=True, exist_ok=True)
        output_path = self.output_dir / "evidence_catalog.json"
        output_path.write_text(json.dumps(self.build(), indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        return output_path
