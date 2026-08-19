"""Interpreter-aware DAAD fingerprinting.

A game database is verified only after target-aware DDB structural validation.
Interpreter binaries are then correlated through official profile hashes or
qualified runtime filenames; source claims and measured properties remain
separate in SQLite's provenance ledger.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Iterable, Optional, Tuple

import structlog

from daad_harvester.config import settings
from daad_harvester.daad_logger import LoggerSuite
from daad_harvester.daad_parser import DAADParser
from daad_harvester.db import Database
from daad_harvester.interpreter_profiles import InterpreterMatch, identify_interpreter_file
from daad_harvester.models import ArtifactRecord
from daad_harvester.provenance import EvidenceConfidence, EvidenceKind, VersionEvidence

logger = structlog.get_logger(__name__)


class Fingerprinter:
    """Perform structural DDB and neighbouring-interpreter forensic analysis."""

    def __init__(self, db: Database):
        self.db = db
        self.parser = DAADParser()
        self.logger_suite = LoggerSuite(settings.logs_dir)

    def analyze_daad_heuristics(self, data: bytes, filename: str) -> Tuple[float, Optional[str], Optional[str]]:
        """Compatibility shim for callers expecting score/version/platform tuple."""
        result = self.parser.parse_ddb(data, filename)
        return result["confidence"], result["version"], result["platform"]

    @staticmethod
    def _candidate_interpreter_paths(path: Path) -> Iterable[Path]:
        """Inspect the artifact and its immediate extracted bundle siblings only."""
        yield path
        try:
            yield from (candidate for candidate in path.parent.iterdir() if candidate.is_file())
        except OSError:
            return

    @staticmethod
    def _best_interpreter_match(matches: list[InterpreterMatch], platform: Optional[str]) -> Optional[InterpreterMatch]:
        relevant = [match for match in matches if platform is None or match.platform == platform]
        if not relevant:
            return None
        return sorted(
            relevant,
            key=lambda match: (match.confidence != EvidenceConfidence.VERIFIED.value, match.profile_id, match.filename),
        )[0]

    @staticmethod
    def _match_details(matches: list[InterpreterMatch]) -> list[dict[str, Optional[str]]]:
        return [
            {
                "profile_id": match.profile_id,
                "platform": match.platform,
                "confidence": match.confidence,
                "filename": match.filename,
                "sha256": match.sha256,
                "interpreter_version": match.interpreter_version,
                "language": match.language,
            }
            for match in matches
        ]

    def _identify_candidate_interpreters(self, path: Path) -> list[InterpreterMatch]:
        """Identify nearby extracted members using persisted original filenames.

        The unpacker deliberately prefixes physical storage names with depth and
        hash material. Runtime filename evidence must therefore be recovered
        from artifact provenance, not inferred from that safe storage path.
        """

        original_names: dict[str, str] = {}
        for candidate_artifact in self.db.get_all_artifacts():
            try:
                original_names[str(Path(candidate_artifact.extracted_path).resolve())] = candidate_artifact.original_filename
            except OSError:
                continue
        found: dict[tuple[str, str], InterpreterMatch] = {}
        for candidate in self._candidate_interpreter_paths(path):
            try:
                observed = original_names.get(str(candidate.resolve()), candidate.name)
            except OSError:
                observed = candidate.name
            match = identify_interpreter_file(candidate, observed_filename=observed)
            if match is not None:
                found[(match.profile_id, match.sha256)] = match
        return sorted(found.values(), key=lambda item: (item.platform, item.profile_id, item.filename))

    def _record_interpreter_only(self, artifact: ArtifactRecord, matches: list[InterpreterMatch]) -> None:
        best = self._best_interpreter_match(matches, None)
        if best is None:
            return
        evidence = json.dumps({"interpreter_matches": self._match_details(matches)}, sort_keys=True)
        self.db.update_artifact_fingerprint(
            artifact.id,
            False,
            interpreter_identity=best.profile_id,
            interpreter_version=best.interpreter_version,
            fingerprint_confidence=best.confidence,
            fingerprint_evidence_json=evidence,
        )
        self.db.add_version_evidence(
            VersionEvidence(
                kind=EvidenceKind.INTERPRETER_IDENTITY.value,
                value=best.profile_id,
                confidence=best.confidence,
                artifact_id=artifact.id,
                details_json=evidence,
            )
        )

    def scan_artifact(self, artifact: ArtifactRecord) -> bool:
        """Measure one artifact and persist explainable, source-scoped evidence."""
        path = Path(artifact.extracted_path)
        if artifact.id is None or not path.is_file():
            return False
        try:
            data = path.read_bytes()
            analysis = self.parser.parse_ddb(data, artifact.original_filename)
            embedded_offset: Optional[int] = None
            # Archive roots are provenance containers, not runnable payloads.
            # Their extracted members are persisted independently by Unpacker,
            # so scanning inside the raw ZIP/RAR/7z bytes would double-count a
            # verified DDB and create a misleading ready-to-use artifact.
            if not analysis["is_daad"] and analysis["reason"] != "raw_archive_header":
                embedded = self.parser.find_embedded_ddb(data)
                if embedded is not None:
                    embedded_offset, embedded_data = embedded
                    analysis = self.parser.parse_ddb(embedded_data, f"embedded_{artifact.original_filename}.ddb")

            matches = self._identify_candidate_interpreters(path)
            own_match = identify_interpreter_file(path, observed_filename=artifact.original_filename)
            if own_match is not None and all(
                (match.profile_id, match.sha256) != (own_match.profile_id, own_match.sha256)
                for match in matches
            ):
                matches.append(own_match)
                matches.sort(key=lambda item: (item.platform, item.profile_id, item.filename))
            if not analysis["is_daad"]:
                self._record_interpreter_only(artifact, matches)
                return False

            platform = analysis["platform"]
            interpreter = self._best_interpreter_match(matches, platform)
            evidence_details = dict(analysis["details"])
            evidence_details["embedded_offset"] = embedded_offset
            evidence_details["interpreter_matches"] = self._match_details(matches)
            evidence_json = json.dumps(evidence_details, sort_keys=True)
            ddb_format = analysis["ddb_format"]
            legacy_version = analysis["version"]

            self.db.update_artifact_fingerprint(
                artifact_id=artifact.id,
                is_daad_payload=True,
                daad_version_guess=legacy_version,
                platform_hint=platform,
                measured_platform=platform,
                ddb_format=ddb_format,
                ddb_major_version=analysis["ddb_major_version"],
                ddb_encoding=analysis["ddb_encoding"],
                interpreter_identity=interpreter.profile_id if interpreter else None,
                interpreter_version=interpreter.interpreter_version if interpreter else None,
                fingerprint_confidence=EvidenceConfidence.VERIFIED.value,
                fingerprint_evidence_json=evidence_json,
            )
            self.db.add_version_evidence(
                VersionEvidence(
                    kind=EvidenceKind.DDB_FORMAT.value,
                    value=ddb_format,
                    confidence=EvidenceConfidence.VERIFIED.value,
                    artifact_id=artifact.id,
                    details_json=evidence_json,
                )
            )
            self.db.add_version_evidence(
                VersionEvidence(
                    kind=EvidenceKind.PLATFORM_RELEASE.value,
                    value=platform,
                    confidence=EvidenceConfidence.VERIFIED.value,
                    artifact_id=artifact.id,
                    details_json=evidence_json,
                )
            )
            if interpreter is not None:
                self.db.add_version_evidence(
                    VersionEvidence(
                        kind=EvidenceKind.INTERPRETER_IDENTITY.value,
                        value=interpreter.profile_id,
                        confidence=interpreter.confidence,
                        artifact_id=artifact.id,
                        details_json=evidence_json,
                    )
                )

            logger.info(
                "daad_payload_verified",
                artifact_id=artifact.id,
                filename=artifact.original_filename,
                ddb_format=ddb_format,
                platform=platform,
                interpreter=interpreter.profile_id if interpreter else None,
            )
            self._log_verified_game(artifact, legacy_version, platform, interpreter)
            return True
        except (OSError, ValueError, TypeError, json.JSONDecodeError) as exc:
            logger.warning("fingerprint_scan_failed", artifact_id=artifact.id, error=str(exc))
            self.logger_suite.log_error("FINGERPRINTER", str(exc), {"artifact_id": artifact.id})
            return False

    def _log_verified_game(
        self,
        artifact: ArtifactRecord,
        legacy_version: str,
        platform: str,
        interpreter: Optional[InterpreterMatch],
    ) -> None:
        sources = {source.id: source for source in self.db.get_all_sources()}
        source = sources.get(artifact.source_id)
        title = artifact.title or (source.title if source else None) or Path(artifact.original_filename).stem.replace("_", " ").title()
        self.logger_suite.log_game(
            {
                "game_id": f"art_{artifact.id}",
                "title": title,
                "platform": platform,
                "daad_version_guess": legacy_version,
                "interpreter_identity": interpreter.profile_id if interpreter else None,
                "interpreter_confidence": interpreter.confidence if interpreter else None,
                "language": artifact.language or (source.language if source else None) or "unknown",
                "filename": artifact.original_filename,
                "file_size": artifact.file_size,
                "source_url": source.url if source else "N/A",
                "extracted_path": artifact.extracted_path,
                "sha256": artifact.sha256,
            },
            status_prefix="VERIFIED DAAD DDB",
        )

    def scan_all_artifacts(self) -> int:
        """Fingerprint all currently persisted artifacts."""
        artifacts = self.db.get_all_artifacts()
        verified = sum(1 for artifact in artifacts if self.scan_artifact(artifact))
        logger.info("fingerprint_phase_completed", total_scanned=len(artifacts), daad_detected=verified)
        self.logger_suite.log_general(f"Fingerprint phase complete: {verified}/{len(artifacts)} verified DAAD DDBs")
        return verified
