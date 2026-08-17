"""Dedicated log management suite for DAAD Harvester with rotating, tagged logs in a dedicated logs directory."""

import logging
import sys
from datetime import datetime
from pathlib import Path
from typing import Dict, Any, Optional
import structlog


# Global run timestamp tag for the active harvester session
SESSION_TAG = datetime.now().strftime("%Y%m%d_%H%M%S")


def rotate_log_file(log_path: Path) -> Optional[Path]:
    """
    If log_path exists and is non-empty, renames it to a timestamped backup file:
    e.g. daad_games_20260817_123045.log.
    Returns the rotated path if rotated, else None.
    """
    if log_path.exists() and log_path.stat().st_size > 0:
        now_str = datetime.now().strftime("%Y%m%d_%H%M%S")
        stem = log_path.stem
        ext = log_path.suffix or ".log"
        rotated_name = f"{stem}_{now_str}{ext}"
        rotated_path = log_path.parent / rotated_name

        if rotated_path.exists():
            ms_str = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
            rotated_path = log_path.parent / f"{stem}_{ms_str}{ext}"

        try:
            log_path.rename(rotated_path)
            return rotated_path
        except Exception:
            pass
    return None


class LoggerSuite:
    """
    Manages dedicated, tagged rotating log files in a specific logs/ directory:
      - daad_general.log (Overall system activity & lifecycle)
      - daad_games.log (Verified DAAD games & metadata)
      - daad_errors.log (System errors, exceptions & network failures)
      - daad_compression_errors.log (Archive extraction & container unpack errors)
      - daad_downloads.log (Download attempts, status HTTP, Wayback fallback & OK/Fail records)
      - daad_discovery.log (Crawl results, seed loads, found URLs & domain responses)
    """

    def __init__(self, logs_dir: Path, session_tag: str = SESSION_TAG, auto_rotate: bool = True):
        self.logs_dir = Path(logs_dir)
        self.logs_dir.mkdir(parents=True, exist_ok=True)
        self.session_tag = session_tag

        self.general_log_path = self.logs_dir / "daad_general.log"
        self.games_log_path = self.logs_dir / "daad_games.log"
        self.errors_log_path = self.logs_dir / "daad_errors.log"
        self.compression_errors_log_path = self.logs_dir / "daad_compression_errors.log"
        self.downloads_log_path = self.logs_dir / "daad_downloads.log"
        self.discovery_log_path = self.logs_dir / "daad_discovery.log"

        if auto_rotate:
            for p in [
                self.general_log_path,
                self.games_log_path,
                self.errors_log_path,
                self.compression_errors_log_path,
                self.downloads_log_path,
                self.discovery_log_path
            ]:
                rotate_log_file(p)

    def _append_record(self, log_path: Path, header: str, data: Dict[str, Any]) -> None:
        """Appends a structured, timestamped block tagged with the session ID."""
        now = datetime.now().isoformat()
        lines = [
            f"================================================================================",
            f"SESSION TAG:     {self.session_tag}",
            f"CATEGORY:        {header}",
            f"TIMESTAMP:       {now}"
        ]

        for k, v in data.items():
            if k == "hashes" and isinstance(v, dict):
                lines.append("--- HASHES ---")
                for hk, hv in v.items():
                    lines.append(f"{hk.upper():<16}: {hv}")
            else:
                formatted_key = k.upper().replace("_", " ")
                lines.append(f"{formatted_key:<16}: {v}")

        lines.append("================================================================ drop\n")
        text_block = "\n".join(lines)

        try:
            with open(log_path, "a", encoding="utf-8") as f:
                f.write(text_block)
        except Exception as exc:
            logging.error(f"Failed writing to log file {log_path}: {exc}")

    def log_general(self, message: str, level: str = "INFO", **kwargs: Any) -> None:
        data = {"message": message, "level": level, **kwargs}
        self._append_record(self.general_log_path, "GENERAL ACTIVITY", data)

    def log_game(self, game_info: Dict[str, Any], status_prefix: str = "VERIFIED DAAD GAME") -> None:
        game_data = {
            "game_id": game_info.get("game_id", "N/A"),
            "title": game_info.get("title", "Unknown Title"),
            "platform": str(game_info.get("platform", "unknown")).upper(),
            "version_guess": game_info.get("daad_version_guess", "DAAD DDB"),
            "language": game_info.get("language", "es"),
            "filename": game_info.get("filename", "N/A"),
            "file_size": f"{game_info.get('file_size', 0)} bytes",
            "source_url": game_info.get("source_url", "N/A"),
            "extracted_path": game_info.get("extracted_path", "N/A"),
            "hashes": {
                "md5_full": game_info.get("md5_full", "N/A"),
                "md5_5000": game_info.get("md5_5000", "N/A"),
                "sha256": game_info.get("sha256", "N/A"),
                "sha1": game_info.get("sha1", "N/A"),
                "crc32": game_info.get("crc32", "N/A"),
                "xxh64": game_info.get("xxh64", "N/A")
            }
        }
        self._append_record(self.games_log_path, status_prefix, game_data)

    def log_error(self, component: str, error_msg: str, context: Optional[Dict[str, Any]] = None) -> None:
        data = {"component": component, "error": error_msg}
        if context:
            data.update(context)
        self._append_record(self.errors_log_path, "SYSTEM ERROR", data)

    def log_compression_error(self, file_path: str, archive_type: str, error_msg: str, tool_used: str = "N/A") -> None:
        data = {
            "file_path": file_path,
            "archive_type": archive_type,
            "tool_used": tool_used,
            "error": error_msg
        }
        self._append_record(self.compression_errors_log_path, "COMPRESSION / EXTRACTION ERROR", data)

    def log_download(self, url: str, status: str, http_code: Optional[int] = None, local_path: Optional[str] = None, wayback_used: bool = False, error: Optional[str] = None) -> None:
        data = {
            "url": url,
            "status": status,
            "http_code": http_code if http_code is not None else "N/A",
            "local_path": local_path or "N/A",
            "wayback_used": wayback_used
        }
        if error:
            data["error"] = error
        self._append_record(self.downloads_log_path, "DOWNLOAD STATUS", data)

    def log_discovery(self, source_name: str, url: str, items_found: int, status: str = "OK", details: Optional[str] = None) -> None:
        data = {
            "source_name": source_name,
            "url": url,
            "items_found": items_found,
            "status": status
        }
        if details:
            data["details"] = details
        self._append_record(self.discovery_log_path, "DISCOVERY CRAWL", data)


# Backwards compatible alias for DAADGamesLogger
class DAADGamesLogger:
    def __init__(self, log_path: Optional[Path] = None, auto_rotate: bool = True):
        logs_dir = log_path.parent if log_path else Path("./output/logs")
        self.suite = LoggerSuite(logs_dir=logs_dir, auto_rotate=auto_rotate)

    def log_daad_game(self, game_info: Dict[str, Any], status_prefix: str = "VERIFIED DAAD GAME") -> None:
        self.suite.log_game(game_info, status_prefix=status_prefix)
