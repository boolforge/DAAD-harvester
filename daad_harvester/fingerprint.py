"""Byte-level fingerprinting module for DAAD payloads, differentiating from PAWS, SWAN, and GAC."""

from pathlib import Path
from typing import Tuple, Optional, Dict
import structlog

from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, Platform
from daad_harvester.exceptions import FingerprintError

logger = structlog.get_logger(__name__)


class Fingerprinter:
    """Performs byte-level forensic analysis on artifacts to detect DAAD database payloads."""

    def __init__(self, db: Database):
        self.db = db

    def check_file_type_rejections(self, data: bytes, filename: str) -> bool:
        """Rejects non-binary files (HTML/PHP/text/RenPy), graphics, and container archives."""
        ext = Path(filename).suffix.lower()
        if ext in (".php", ".html", ".htm", ".xml", ".json", ".css", ".js", ".png", ".jpg", ".gif", ".py", ".cpp", ".h"):
            return True

        # Reject web / text tags
        data_start = data[:512].lower()
        if b"<?php" in data_start or b"<!doctype html" in data_start or b"<html" in data_start or b"<head" in data_start:
            return True

        # Reject RenPy / Non-DAAD engine payloads
        if b"renpy" in data_start or "renpy.data" in filename.lower() or filename.lower().endswith(".data"):
            if b"DAAD" not in data:
                return True

        # Reject direct archive magic bytes (should be extracted first)
        if data.startswith(b"PK\x03\x04") or data.startswith(b"7z\xbc\xaf\x27\x1c") or data.startswith(b"Rar!"):
            return True

        return False

    def check_paws_rejection(self, data: bytes) -> bool:
        """Returns True if file matches PAWS / The Quill signatures (should be rejected)."""
        if b"PAWS" in data or b"The Quill" in data or b"QUILL" in data or b"PAW" in data[:100]:
            return True
        return False

    def check_swan_rejection(self, data: bytes) -> bool:
        """Returns True if file matches SWAN signatures (should be rejected)."""
        if b"SWAN" in data[:200] or b"SWAN System" in data:
            return True
        return False

    def check_gac_rejection(self, data: bytes) -> bool:
        """Returns True if file matches Graphic Adventure Creator signatures (should be rejected)."""
        if b"Graphic Adventure Creator" in data or b"GAC" in data[:64] or b"Incentive Software" in data:
            return True
        return False

    def check_daad_process_table_structures(self, data: bytes) -> bool:
        """
        Validates DAAD process table header structures.
        DAAD databases start with header offsets pointing to Proceso 0, Proceso 1, Proceso 2, etc.
        Check if header values form plausible, ascending 16-bit offset pointers into file.
        """
        if len(data) < 32 or len(data) > 300000:
            return False

        # Inspect first 16 bytes for 16-bit little-endian offset pointers (Proceso 0 .. 7)
        pointers = []
        for i in range(0, 16, 2):
            ptr = data[i] | (data[i+1] << 8)
            pointers.append(ptr)

        p0, p1, p2 = pointers[0], pointers[1], pointers[2]
        file_len = len(data)

        # Check if pointers fall within reasonable boundaries of file size and are non-decreasing
        if 0 < p0 < file_len and 0 < p1 < file_len and 0 < p2 < file_len:
            if p0 <= p1 <= p2 and all(p <= file_len for p in pointers):
                return True

        return False

    def analyze_daad_heuristics(self, data: bytes, filename: str) -> Tuple[float, Optional[str], Optional[str]]:
        """
        Analyzes byte stream for DAAD database structures.
        Returns: (confidence_score, version_guess, platform_hint)
        """
        if len(data) < 32:
            return 0.0, None, None

        # Step 1: Explicit rejection checks
        if self.check_file_type_rejections(data, filename):
            return 0.0, None, None

        if self.check_paws_rejection(data) or self.check_swan_rejection(data) or self.check_gac_rejection(data):
            return 0.0, None, None

        score = 0.0
        version_guess = None
        platform_hint = Platform.UNKNOWN.value

        ext = Path(filename).suffix.lower()

        # Extension heuristic
        if ext == ".ddb":
            score += 0.50

        # Check Magic Bytes / Version Strings
        if b"DAAD" in data:
            score += 0.30
            version_guess = "DAAD v2.x"
        elif b"D.A.A.D" in data or b"Gilsoft" in data or b"Aventuras AD" in data:
            score += 0.25
            version_guess = "DAAD v1.x/v2.x"

        # Check Process Table Structure Pointers
        if self.check_daad_process_table_structures(data):
            score += 0.35
            if not version_guess:
                version_guess = "DAAD DDB"

        # Check DAADconds / DAADacts opcode sequence signatures or strings
        daad_signatures = [
            b"DAAD", b"D.A.A.D", b"Gilsoft", b"Aventuras AD", b"Tim Gilberts",
            b"DAADREADY", b"DAAD System", b"Proceso", b"PROCESO"
        ]
        if any(sig in data for sig in daad_signatures):
            score += 0.20

        # Check Vocabulary & Action Verbs / Keywords across Spanish and English DAAD releases
        vocab_keywords = [
            b"COGER", b"DEJAR", b"MIRAR", b"IR", b"NORTE", b"SUR", b"ESTE", b"OESTE",
            b"TAKE", b"DROP", b"LOOK", b"EXAMINE", b"INVENTARIO", b"INVENTORY",
            b"EMPUJAR", b"TIRAR", b"ABRIR", b"CERRAR", b"METER", b"SACAR"
        ]
        matching_keywords = sum(1 for kw in vocab_keywords if kw in data)
        if matching_keywords >= 4:
            score += 0.30
        elif matching_keywords >= 2:
            score += 0.20
        elif matching_keywords >= 1:
            score += 0.10

        # Platform heuristics based on file headers / sizes / binary signatures
        if data.startswith(b"MV - CPCEMU") or data.startswith(b"EXTENDED CPC DSK") or ext in (".dsk", ".cpc"):
            platform_hint = Platform.CPC.value
        elif data.startswith(b"Z80") or ext in (".z80", ".sna", ".tap", ".tzx"):
            platform_hint = Platform.ZX.value
        elif ext in (".d64", ".t64", ".prg"):
            platform_hint = Platform.C64.value
        elif ext in (".adf", ".adz") or b"DOS\x00" in data[:10]:
            platform_hint = Platform.AMIGA.value
        elif ext in (".st", ".msa", ".stx"):
            platform_hint = Platform.ATARIST.value
        elif ext in (".msx", ".dsk") and b"AB80" in data[:100]:
            platform_hint = Platform.MSX.value
        elif ext in (".exe", ".com", ".dat", ".ddb") or b"MS-DOS" in data:
            platform_hint = Platform.PC.value

        # Cap score between 0.0 and 1.0
        score = min(max(score, 0.0), 1.0)

        return score, version_guess, platform_hint

    def scan_artifact(self, artifact: ArtifactRecord) -> bool:
        """Reads artifact from disk, scores it, and updates DB if confidence >= 0.75."""
        path = Path(artifact.extracted_path)
        if not path.exists():
            return False

        try:
            data = path.read_bytes()
            score, version_guess, platform_hint = self.analyze_daad_heuristics(data, artifact.original_filename)

            is_daad = score >= 0.75
            self.db.update_artifact_fingerprint(
                artifact_id=artifact.id,
                is_daad_payload=is_daad,
                daad_version_guess=version_guess,
                platform_hint=platform_hint
            )

            if is_daad:
                logger.info("daad_payload_identified", artifact_id=artifact.id, filename=artifact.original_filename, score=score, version=version_guess, platform=platform_hint)
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
