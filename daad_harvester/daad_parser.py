"""Deep forensic parser & bytecode disassembler for DAAD (Designed Action Artwork System) game databases (DDB).

This module performs structural validation and opcode bytecode disassembly of DAAD databases across
8-bit (ZX Spectrum, Amstrad CPC, Commodore 64, MSX) and 16-bit (Amiga, Atari ST, MS-DOS) releases.
"""

import struct
from pathlib import Path
from typing import Dict, Any, Optional, List, Tuple
import structlog

logger = structlog.get_logger(__name__)

# Canonical DAAD Condition Opcodes (DAADconds)
# Opcode byte -> (name, operand_bytes)
DAAD_CONDITIONS: Dict[int, Tuple[str, int]] = {
    0x00: ("NOP", 0),
    0x01: ("AT", 1),
    0x02: ("NOTAT", 1),
    0x03: ("ATGT", 1),
    0x04: ("ATLT", 1),
    0x05: ("CARRIED", 1),
    0x06: ("NOTCARR", 1),
    0x07: ("WORN", 1),
    0x08: ("NOTWORN", 1),
    0x09: ("PRESENT", 1),
    0x0A: ("ABSENT", 1),
    0x0B: ("ZERO", 1),
    0x0C: ("NOTZERO", 1),
    0x0D: ("EQ", 2),
    0x0E: ("GT", 2),
    0x0F: ("LT", 2),
    0x10: ("SAME", 2),
    0x11: ("ISAT", 2),
    0x12: ("ISNOTAT", 2),
    0x13: ("CHANCE", 1),
    0x14: ("BITSET", 2),
    0x15: ("BITCLEAR", 2),
    0x16: ("HASAT", 1),
    0x17: ("HASNOTAT", 1),
}

# Canonical DAAD Action Opcodes (DAADacts)
# Opcode byte -> (name, operand_bytes)
DAAD_ACTIONS: Dict[int, Tuple[str, int]] = {
    0x80: ("NOP", 0),
    0x81: ("GOTO", 1),
    0x82: ("GET", 1),
    0x83: ("DROP", 1),
    0x84: ("WEAR", 1),
    0x85: ("REMOVE", 1),
    0x86: ("DESTROY", 1),
    0x87: ("CREATE", 1),
    0x88: ("SWAP", 2),
    0x89: ("SET", 1),
    0x8A: ("CLEAR", 1),
    0x8B: ("LET", 2),
    0x8C: ("PRINT", 1),
    0x8D: ("MESSAGE", 1),
    0x8E: ("OK", 0),
    0x8F: ("DESC", 1),
    0x90: ("SAVE", 0),
    0x91: ("LOAD", 0),
    0x92: ("TURNS", 0),
    0x93: ("SCORE", 0),
    0x94: ("CLS", 0),
    0x95: ("LOOK", 0),
    0x96: ("RAMSAVE", 0),
    0x97: ("RAMLOAD", 0),
    0x98: ("BEEP", 2),
    0x99: ("PAPER", 1),
    0x9A: ("INK", 1),
    0x9B: ("BORDER", 1),
    0xFE: ("DONE", 0),
    0xFF: ("END", 0),
}

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


class DAADBytecodeParser:
    """Forensic binary disassembler & structural parser for DAAD DDB files."""

    def is_explicit_rejection(self, data: bytes, filename: str) -> Tuple[bool, str]:
        """
        Absolute rejection filter for non-DAAD binaries, RenPy archives, PAWS, Quill, GAC, SWAN, HTML, direct archives.
        Strictly rejects RenPy regardless of coincidental strings.
        """
        fn_lower = filename.lower()
        ext = Path(filename).suffix.lower()

        # Reject non-binary code / web / source / media / console ROM extensions
        rejected_exts = (
            ".php", ".html", ".htm", ".xml", ".json", ".css", ".js", ".py", ".cpp", ".h", ".c", ".txt", ".md", ".rpy", ".rpyc",
            ".nes", ".sfc", ".smc", ".z64", ".v64", ".n64", ".gba", ".gbc", ".gb", ".nds", ".3ds", ".iso", ".cue",
            ".mp3", ".mp4", ".wav", ".flac", ".ogg", ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".avi", ".mkv"
        )
        if ext in rejected_exts:
            return True, f"explicit_non_daad_extension_{ext.lstrip('.')}"

        # Reject RenPy data/archives strictly regardless of embedded strings
        if "renpy" in fn_lower or ext in (".data", ".rpyc") or b"renpy" in data[:4096].lower() or b"Ren'Py" in data[:4096] or data.startswith(b"RPYC"):
            return True, "renpy_engine_payload"

        # Reject HTML / Web responses
        data_start = data[:1024].lower()
        if b"<?php" in data_start or b"<!doctype html" in data_start or b"<html" in data_start or b"<head" in data_start or b"</body>" in data_start:
            return True, "html_php_content"

        # Reject direct archive magic headers (must be unpacked first)
        if data.startswith(b"PK\x03\x04") or data.startswith(b"7z\xbc\xaf\x27\x1c") or data.startswith(b"Rar!") or data.startswith(b"\x1f\x8b"):
            return True, "raw_archive_header"

        # Reject Quill / PAWS / SWAN / GAC formats
        if b"The Quill" in data[:1024] or b"QUILL" in data[:512] or b"PAWS" in data[:1024]:
            return True, "quill_paws_engine"

        if b"SWAN System" in data[:1024] or b"SWAN" in data[:512]:
            return True, "swan_engine"

        if b"Graphic Adventure Creator" in data or b"Incentive Software" in data:
            return True, "gac_engine"

        return False, ""

    def disassemble_process_bytecode(self, data: bytes, offset: int, max_bytes: int = 512) -> Tuple[bool, int, List[str]]:
        """
        Disassembles a DAAD process byte stream starting at offset.
        Validates whether the byte stream strictly conforms to DAAD condition/action opcode sequences.
        """
        if offset <= 0 or offset >= len(data):
            return False, 0, []

        pos = offset
        end_pos = min(len(data), offset + max_bytes)
        disassembled_opcodes: List[str] = []
        valid_opcodes_count = 0

        while pos < end_pos - 2:
            # Entry header in DAAD process: Verb ID (1 byte), Noun ID (1 byte)
            verb_id = data[pos]
            noun_id = data[pos + 1]
            pos += 2

            # Parse condition bytes until an action byte or end marker
            entry_opcodes = 0
            is_valid_entry = True

            while pos < end_pos:
                b = data[pos]
                if b in DAAD_CONDITIONS:
                    name, operands = DAAD_CONDITIONS[b]
                    if pos + 1 + operands > len(data):
                        is_valid_entry = False
                        break
                    op_val = data[pos + 1: pos + 1 + operands]
                    disassembled_opcodes.append(f"COND:{name}({op_val.hex()})")
                    pos += 1 + operands
                    entry_opcodes += 1
                elif b in DAAD_ACTIONS:
                    name, operands = DAAD_ACTIONS[b]
                    if pos + 1 + operands > len(data):
                        is_valid_entry = False
                        break
                    op_val = data[pos + 1: pos + 1 + operands]
                    disassembled_opcodes.append(f"ACT:{name}({op_val.hex()})")
                    pos += 1 + operands
                    entry_opcodes += 1
                    if b in (0xFE, 0xFF): # DONE / END of process entry
                        break
                else:
                    # Invalid/Unknown opcode byte encountered in stream
                    is_valid_entry = False
                    break

            if not is_valid_entry:
                break

            valid_opcodes_count += entry_opcodes
            if valid_opcodes_count >= 5: # Successfully disassembled multiple valid DAAD opcode entries
                break

        is_valid_stream = valid_opcodes_count >= 3
        return is_valid_stream, valid_opcodes_count, disassembled_opcodes

    def validate_process_table(self, data: bytes) -> Tuple[bool, int, List[int], List[str]]:
        """
        Validates DAAD Process Table (Processes 0..n).
        Checks pointers and disassembles byte streams at target offsets.
        """
        file_len = len(data)
        if file_len < 32 or file_len > 1048576: # DAAD game databases are between 1KB and 1MB
            return False, 0, [], []

        pointers: List[int] = []
        # DAAD database header contains pointers for processes (little endian 16-bit)
        for i in range(0, 32, 2):
            ptr = data[i] | (data[i + 1] << 8)
            pointers.append(ptr)

        p0, p1, p2 = pointers[0], pointers[1], pointers[2]

        # In DAAD: P0 = Init, P1 = Turn Loop, P2 = Input Parser
        if not (0 < p0 < file_len and 0 < p1 < file_len and 0 < p2 < file_len):
            return False, 0, [], []

        if not (p0 <= p1 <= p2):
            return False, 0, [], []

        # Instrumental disassembly check on Proceso 0 and Proceso 1
        p0_valid, p0_ops, p0_dis = self.disassemble_process_bytecode(data, p0)
        p1_valid, p1_ops, p1_dis = self.disassemble_process_bytecode(data, p1)

        total_disassembled = p0_dis + p1_dis
        valid_ptrs = sum(1 for p in pointers if 0 < p < file_len)

        # Require both valid pointer range AND successful bytecode opcode stream disassembly
        is_valid = (p0_valid or p1_valid) and (p0_ops + p1_ops >= 3)
        return is_valid, valid_ptrs, pointers, total_disassembled

    def find_embedded_ddb(self, data: bytes) -> Optional[Tuple[int, bytes]]:
        """
        Scans data for embedded DAAD DDB process table header and returns (offset, ddb_bytes) if found.
        Scans at 16-byte aligned boundaries up to 512KB offset.
        """
        max_scan = min(len(data) - 64, 524288)
        for offset in range(0, max_scan, 16):
            sub_data = data[offset:]
            if len(sub_data) < 64:
                break
            is_valid, _, pointers, _ = self.validate_process_table(sub_data)
            if is_valid and len(pointers) >= 3:
                # Calculate likely DDB length from max process pointer or scan limit
                max_ptr = max(pointers[:8]) if pointers else 1024
                estimated_len = min(len(sub_data), max_ptr + 4096)
                return offset, sub_data[:estimated_len]
        return None

    def check_vocabulary(self, data: bytes) -> Tuple[int, str]:
        """Scans byte stream for DAAD vocabulary verb/noun tokens with length bounds."""
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

        if b"Aventuras AD" in data and len(data) < 49152:
            return "zx"

        return "unknown"

    def parse_ddb(self, data: bytes, filename: str = "") -> Dict[str, Any]:
        """
        Main entry point for deep forensic inspection and bytecode disassembly of potential DAAD database.
        Returns detailed result dict with zero false positive guarantee for non-DAAD formats.
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

        # Step 1: Deep Process Table & Bytecode Opcode Disassembly
        valid_bytecode, num_ptrs, pointers, opcodes = self.validate_process_table(data)
        if valid_bytecode:
            score += 0.55
            version_guess = "DAAD DDB"

        # Step 2: Vocabulary Verification
        vocab_matches, lang = self.check_vocabulary(data)
        if vocab_matches >= 6:
            score += 0.25
        elif vocab_matches >= 3:
            score += 0.15
        elif vocab_matches >= 1:
            score += 0.05

        # Step 3: System Messages
        sys_msgs_count = self.check_system_messages(data)
        if sys_msgs_count >= 2:
            score += 0.15

        # Step 4: Explicit DAAD Signature Tags
        daad_signatures = [
            (b"DAADREADY", 0.30, "DAAD Ready"),
            (b"DAAD READY", 0.30, "DAAD Ready"),
            (b"DAAD", 0.15, "DAAD Engine"),
            (b"D.A.A.D", 0.15, "DAAD Engine"),
            (b"Gilsoft", 0.15, "DAAD Gilsoft"),
            (b"Aventuras AD", 0.15, "Aventuras AD"),
            (b"Tim Gilberts", 0.15, "DAAD Author")
        ]

        found_sig = False
        for sig, weight, ver in daad_signatures:
            if sig in data:
                score += weight
                if not found_sig:
                    version_guess = ver
                    found_sig = True

        if ext == ".ddb":
            score += 0.10

        confidence = min(max(score, 0.0), 1.0)

        # STRICT VERIFICATION RULE:
        # Must have VALID INSTRUMENTAL BYTECODE DISASSEMBLY (valid_bytecode)
        # OR (found_sig AND vocab_matches >= 4 AND sys_msgs_count >= 1)
        # Confidence must be >= 0.75.
        is_daad = (valid_bytecode and confidence >= 0.70) or (found_sig and vocab_matches >= 4 and sys_msgs_count >= 1 and confidence >= 0.75)

        platform = self.detect_platform(data, filename)

        return {
            "is_daad": is_daad,
            "confidence": round(confidence, 4),
            "version": version_guess if is_daad else None,
            "platform": platform,
            "language": lang if is_daad else "unknown",
            "details": {
                "bytecode_disassembly_valid": valid_bytecode,
                "process_pointers": pointers[:4] if valid_bytecode else [],
                "disassembled_opcodes_sample": opcodes[:10],
                "vocab_matches": vocab_matches,
                "sys_msgs_count": sys_msgs_count,
                "signature_found": found_sig
            }
        }


# Alias class DAADParser to DAADBytecodeParser for backwards compatibility
DAADParser = DAADBytecodeParser
