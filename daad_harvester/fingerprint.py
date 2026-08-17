"""Byte-level fingerprinting module for DAAD payloads using DAADParser."""

from pathlib import Path
from typing import Tuple, Optional, Dict
import structlog

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform
from daad_harvester.daad_parser import DAADParser
from daad_harvester.exceptions import FingerprintError

logger = structlog.get_logger(__name__)


class Fingerprinter:
    """Performs forensic inspection on artifacts using DAADParser to identify true DAAD database payloads."""

    def __init__(self, db: Database):
        self.db = db
        self.parser = DAADParser()

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
            return is_daad
        except Exception as exc:
            logger.warning("scan_artifact_failed", artifact_id=artifact.id, error=str(exc))
            return False

    def scan_all_artifacts(self) -> int:
        """Scans all artifacts in database."""
        artifacts = self.db.get_all_artifacts()
        daad_count = 0
        for art in artifacts:
            if self.scan_artifact(art):
                daad_count += 1
        logger.info("fingerprint_phase_completed", total_scanned=len(artifacts), daad_detected=daad_count)
        return daad_count
