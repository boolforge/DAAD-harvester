"""Deep forensic parser for DAAD (Designed Action Artwork System) game databases (DDB).

This module performs byte-level structural validation of DAAD databases across 8-bit
(ZX Spectrum, Amstrad CPC, Commodore 64, MSX) and 16-bit (Amiga, Atari ST, MS-DOS) releases.
"""

import struct
from pathlib import Path
from typing import Dict, Any, Optional, List, Tuple
import structlog

logger = structlog.get_logger(__name__)

# Canonical DAAD vocabulary tokens (Spanish and English)
DAAD_SPANISH_VERBS = [
    b"INVE", b"MIRA", b"COGE", b"DEJA", b"IR", b"NORT", b"SUR", b"ESTE", b"OEST",
    b"SUBI", b"BAJA", b"ENTR", b"SALI", b"ABRI", b"CERR", b"EMPU", b"TIRA", b"MASH",
    b"HABL", b"DECI", b"PREG", b"DAR", b"PONE", b"QUIT", b"QUEM", b"LEER", b"EXAM"
]

DAAD_ENGLISH_VERBS = [
    b"INVE", b"LOOK", b"TAKE", b"DROP", b"GO", b"NORT", b"SOUT", b"EAST", b"WEST",
    b"UP", b"DOWN", b"ENTE", b"EXIT", b"OPEN", b"CLOS", b"PUSH", b"PULL", b"TALK",
    b"SAY", b"ASK", b"GIVE", b"PUT", b"REMO", b"BURN", b"READ", b"EXAM"
]

# Common DAAD System Messages (Spanish / English)
DAAD_SYSTEM_MESSAGES_ES = [
    b"Es muy oscuro", b"No ves nada", b"No puedes ir", b"Llevas contigo",
    b"No llevas nada", b"Esta cerrado", b"Esta abierto", b"No entiendo",
    b"Demasiado pesado", b"No hay espacio", b"Aventuras AD", b"DAAD"
]

DAAD_SYSTEM_MESSAGES_EN = [
    b"It is pitch dark", b"You can't see", b"You can't go", b"You are carrying",
    b"You have nothing", b"It is closed", b"It is open", b"I don't understand",
    b"Too heavy", b"No room left", b"Gilsoft", b"DAAD"
]


class DAADParser:
    """Forensic binary parser for DAAD DDB files and embedded payloads."""

    def is_explicit_rejection(self, data: bytes, filename: str) -> Tuple[bool, str]:
        """
        Checks if file must be rejected immediately (Non-DAAD formats, RenPy, PAWS, GAC, SWAN, HTML, direct archives).
        """
        fn_lower = filename.lower()
        ext = Path(filename).suffix.lower()

        # Reject non-binary code / web extensions
        if ext in (".php", ".html", ".htm", ".xml", ".json", ".css", ".js", ".py", ".cpp", ".h", ".c", ".txt", ".md"):
            return True, "web_or_source_extension"

        # Reject RenPy data files or binaries containing RenPy signatures
        if "renpy" in fn_lower or fn_lower.endswith(".data") or b"renpy" in data[:1024].lower() or b"Ren'Py" in data[:2048]:
            if b"DAAD" not in data and b"Aventuras AD" not in data:
                return True, "renpy_engine_payload"

        # Reject HTML / Web responses
        data_start = data[:512].lower()
        if b"<?php" in data_start or b"<!doctype html" in data_start or b"<html" in data_start or b"<head" in data_start:
            return True, "html_php_content"

        # Reject direct archive magic headers (must be unpacked first)
        if data.startswith(b"PK\x03\x04") or data.startswith(b"7z\xbc\xaf\x27\x1c") or data.startswith(b"Rar!"):
            return True, "raw_archive_header"

        # Reject Quill / PAWS / SWAN / GAC formats
        if b"The Quill" in data[:512] or b"QUILL" in data[:256] or b"PAWS" in data[:512] or (b"PAW" in data[:100] and b"DAAD" not in data):
            return True, "quill_paws_engine"

        if b"SWAN System" in data[:512] or b"SWAN" in data[:200]:
            return True, "swan_engine"

        if b"Graphic Adventure Creator" in data or b"Incentive Software" in data:
            return True, "gac_engine"

        return False, ""

    def validate_process_table_pointers(self, data: bytes) -> Tuple[bool, int, List[int]]:
        """
        Validates DAAD process table header.
        DAAD DDB databases start with 16-bit little-endian pointers to Proceso 0, 1, 2...
        Validates offset pointers fall strictly within file boundaries and are non-decreasing.
        """
        file_len = len(data)
        if file_len < 32 or file_len > 1048576: # DAAD games are between ~1KB and 1MB
            return False, 0, []

        pointers = []
        for i in range(0, 16, 2):
            ptr = data[i] | (data[i + 1] << 8)
            pointers.append(ptr)

        p0, p1, p2 = pointers[0], pointers[1], pointers[2]

        # In DAAD:
        # P0 is initialization process offset
        # P1 is main game loop offset
        # P2 is input parsing process offset
        if 0 < p0 < file_len and 0 < p1 < file_len and 0 < p2 < file_len:
            if p0 <= p1 <= p2 and all(p <= file_len for p in pointers if p > 0):
                # Count valid non-zero pointer sequences
                valid_ptrs = sum(1 for p in pointers if 0 < p < file_len)
                return True, valid_ptrs, pointers

        return False, 0, []

    def check_vocabulary(self, data: bytes) -> Tuple[int, str]:
        """Scans byte stream for DAAD vocabulary verb/noun tokens."""
        es_count = sum(1 for verb in DAAD_SPANISH_VERBS if verb in data)
        en_count = sum(1 for verb in DAAD_ENGLISH_VERBS if verb in data)

        lang = "es" if es_count >= en_count else "en"
        total = max(es_count, en_count)
        return total, lang

    def check_system_messages(self, data: bytes) -> int:
        """Scans byte stream for DAAD system text messages."""
        msg_count = 0
        for msg in DAAD_SYSTEM_MESSAGES_ES + DAAD_SYSTEM_MESSAGES_EN:
            if msg in data:
                msg_count += 1
        return msg_count

    def detect_platform(self, data: bytes, filename: str) -> str:
        """Determines target computing platform for DAAD game artifact."""
        ext = Path(filename).suffix.lower()

        if data.startswith(b"MV - CPCEMU") or data.startswith(b"EXTENDED CPC DSK") or ext in (".dsk", ".cpc"):
            return "cpc"
        if data.startswith(b"Z80") or ext in (".z80", ".sna", ".tap", ".tzx"):
            return "zx"
        if ext in (".d64", ".t64", ".prg"):
            return "c64"
        if ext in (".adf", ".adz") or b"DOS\x00" in data[:10]:
            return "amiga"
        if ext in (".st", ".msa", ".stx"):
            return "atarist"
        if ext in (".msx", ".dsk") and b"AB80" in data[:100]:
            return "msx"
        if ext in (".exe", ".com", ".dat", ".ddb") or b"MS-DOS" in data:
            return "pc"

        # Content heuristics
        if b"Aventuras AD" in data and len(data) < 49152:
            return "zx" # ZX Spectrum 48K default for small AD games

        return "unknown"

    def parse_ddb(self, data: bytes, filename: str = "") -> Dict[str, Any]:
        """
        Main entry point for deep forensic analysis of potential DAAD database.
        Returns detailed result dict with confidence, platform, language, and details.
        """
        is_rejected, reason = self.is_explicit_rejection(data, filename)
        if is_rejected:
            return {
                "is_daad": False,
                "confidence": 0.0,
                "version": None,
                "platform": "unknown",
                "language": "unknown",
                "reason": reason,
                "details": {}
            }

        score = 0.0
        version_guess = None
        ext = Path(filename).suffix.lower()

        # Step 1: Check Process Table Offset Pointers
        valid_ptrs_flag, num_ptrs, pointers = self.validate_process_table_pointers(data)
        if valid_ptrs_flag:
            score += 0.40
            version_guess = "DAAD DDB"

        # Step 2: Check Vocabulary Tokens
        vocab_matches, lang = self.check_vocabulary(data)
        if vocab_matches >= 6:
            score += 0.35
        elif vocab_matches >= 3:
            score += 0.25
        elif vocab_matches >= 1:
            score += 0.10

        # Step 3: Check System Messages
        sys_msgs_count = self.check_system_messages(data)
        if sys_msgs_count >= 2:
            score += 0.20

        # Step 4: Check Explicit DAAD Signatures
        daad_signatures = [
            (b"DAADREADY", 0.40, "DAAD Ready"),
            (b"DAAD READY", 0.40, "DAAD Ready"),
            (b"DAAD", 0.25, "DAAD Engine"),
            (b"D.A.A.D", 0.25, "DAAD Engine"),
            (b"Gilsoft", 0.20, "DAAD Gilsoft"),
            (b"Aventuras AD", 0.20, "Aventuras AD"),
            (b"Tim Gilberts", 0.20, "DAAD Author")
        ]

        found_sig = False
        for sig, weight, ver in daad_signatures:
            if sig in data:
                score += weight
                if not found_sig:
                    version_guess = ver
                    found_sig = True

        # Step 5: File Extension Bonus
        if ext == ".ddb":
            score += 0.15

        # Cap score at 1.0
        confidence = min(max(score, 0.0), 1.0)

        # DAAD verification rule: Must have process table pointers OR explicit DAAD signature + high vocabulary score
        is_daad = (valid_ptrs_flag and confidence >= 0.70) or (found_sig and vocab_matches >= 3 and confidence >= 0.70)

        # Detect platform
        platform = self.detect_platform(data, filename)

        return {
            "is_daad": is_daad,
            "confidence": round(confidence, 4),
            "version": version_guess or ("DAAD Game" if is_daad else None),
            "platform": platform,
            "language": lang if is_daad else "unknown",
            "details": {
                "process_pointers_valid": valid_ptrs_flag,
                "process_pointers": pointers[:4] if valid_ptrs_flag else [],
                "vocab_matches": vocab_matches,
                "sys_msgs_count": sys_msgs_count,
                "signature_found": found_sig
            }
        }
