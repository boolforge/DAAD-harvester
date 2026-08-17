"""Byte-level fingerprinting module for DAAD payloads using DAADParser."""

from pathlib import Path
from typing import Tuple, Optional
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord
from daad_harvester.daad_parser import DAADParser
from daad_harvester.daad_logger import LoggerSuite

logger = structlog.get_logger(__name__)


class Fingerprinter:
    """Performs forensic inspection on artifacts using DAADParser to identify true DAAD database payloads."""

    def __init__(self, db: Database):
        self.db = db
        self.parser = DAADParser()
        self.logger_suite = LoggerSuite(settings.logs_dir)

    def analyze_daad_heuristics(self, data: bytes, filename: str) -> Tuple[float, Optional[str], Optional[str]]:
        """Backwards-compatible interface returning (confidence_score, version_guess, platform_hint)."""
        res = self.parser.parse_ddb(data, filename)
        return res["confidence"], res["version"], res["platform"]

    def scan_artifact(self, artifact: ArtifactRecord) -> bool:
        """Reads artifact from disk, parses it with DAADParser, and updates DB if valid DAAD payload."""
        path = Path(artifact.extracted_path)
        if not path.exists():
            return False

        try:
            data = path.read_bytes()
            analysis = self.parser.parse_ddb(data, artifact.original_filename)

            is_daad = analysis["is_daad"]
            version_guess = analysis["version"]
            platform_hint = analysis["platform"]
            confidence = analysis["confidence"]

            # If top-level analysis is false, scan for embedded DDB process table
            if not is_daad:
                embedded = self.parser.find_embedded_ddb(data)
                if embedded:
                    offset, ddb_bytes = embedded
                    sub_analysis = self.parser.parse_ddb(ddb_bytes, artifact.original_filename)
                    if sub_analysis["is_daad"]:
                        is_daad = True
                        version_guess = sub_analysis["version"] or "Embedded DAAD DDB"
                        platform_hint = sub_analysis["platform"]
                        confidence = sub_analysis["confidence"]
                        analysis = sub_analysis
                        logger.info("embedded_ddb_found", artifact_id=artifact.id, offset=offset)

            self.db.update_artifact_fingerprint(
                artifact_id=artifact.id,
                is_daad_payload=is_daad,
                daad_version_guess=version_guess,
                platform_hint=platform_hint
            )

            if is_daad:
                logger.info(
                    "daad_payload_identified",
                    artifact_id=artifact.id,
                    filename=artifact.original_filename,
                    confidence=confidence,
                    version=version_guess,
                    platform=platform_hint,
                    details=analysis["details"]
                )

                sources = {s.id: s for s in self.db.get_all_sources()}
                source = sources.get(artifact.source_id)

                title = artifact.title or (source.title if source else artifact.original_filename)
                if not title or title.lower() in ("src", "download", "file", "archive", "unnamed"):
                    title = Path(artifact.original_filename).stem.replace("_", " ").title()

                game_info = {
                    "game_id": f"art_{artifact.id}",
                    "title": title,
                    "platform": platform_hint or "unknown",
                    "daad_version_guess": version_guess or "DAAD DDB",
                    "language": artifact.language or "es",
                    "filename": artifact.original_filename,
                    "file_size": artifact.file_size,
                    "source_url": source.url if source else "N/A",
                    "extracted_path": artifact.extracted_path,
                    "md5_full": artifact.md5_full,
                    "md5_5000": artifact.md5_5000,
                    "sha256": artifact.sha256,
                    "sha1": artifact.sha1,
                    "crc32": artifact.crc32,
                    "xxh64": artifact.xxh64
                }
                self.logger_suite.log_game(game_info, status_prefix="IDENTIFIED DAAD PAYLOAD")

            return is_daad
        except Exception as exc:
            logger.warning("scan_artifact_failed", artifact_id=artifact.id, error=str(exc))
            self.logger_suite.log_error("FINGERPRINTER", str(exc), {"artifact_id": artifact.id})
            return False

    def scan_all_artifacts(self) -> int:
        """Scans all artifacts in database."""
        artifacts = self.db.get_all_artifacts()
        daad_count = 0
        for art in artifacts:
            if self.scan_artifact(art):
                daad_count += 1
        logger.info("fingerprint_phase_completed", total_scanned=len(artifacts), daad_detected=daad_count)
        self.logger_suite.log_general(f"Fingerprint phase complete: {daad_count}/{len(artifacts)} DAAD games detected")
        return daad_count
