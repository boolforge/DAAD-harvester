"""Dedicated logger for DAAD game discoveries writing to daad_games.log."""

import json
from datetime import datetime
from pathlib import Path
from typing import Dict, Any, Optional
import structlog

from daad_harvester.config import settings

logger = structlog.get_logger(__name__)


class DAADGamesLogger:
    """Writes dedicated, structured records of verified DAAD games to daad_games.log."""

    def __init__(self, log_path: Optional[Path] = None):
        self.log_path = log_path or (settings.output_dir / "daad_games.log")
        self.log_path.parent.mkdir(parents=True, exist_ok=True)

    def log_daad_game(self, game_info: Dict[str, Any]) -> None:
        """
        Appends a formatted, timestamped record for a verified DAAD game to daad_games.log.
        """
        now = datetime.now().isoformat()

        entry_lines = [
            f"================================================================================",
            f"TIMESTAMP:       {now}",
            f"GAME ID:         {game_info.get('game_id', 'N/A')}",
            f"TITLE:           {game_info.get('title', 'Unknown Title')}",
            f"PLATFORM:        {game_info.get('platform', 'unknown').upper()}",
            f"VERSION GUESS:   {game_info.get('daad_version_guess', 'DAAD DDB')}",
            f"LANGUAGE:        {game_info.get('language', 'es')}",
            f"FILENAME:        {game_info.get('filename', 'N/A')}",
            f"FILE SIZE:       {game_info.get('file_size', 0)} bytes",
            f"SOURCE URL:      {game_info.get('source_url', 'N/A')}",
            f"EXTRACTED PATH:  {game_info.get('extracted_path', 'N/A')}",
            f"--- HASHES ---",
            f"MD5 (Full):      {game_info.get('md5_full', 'N/A')}",
            f"MD5 (5KB Head):  {game_info.get('md5_5000', 'N/A')}",
            f"SHA-256:         {game_info.get('sha256', 'N/A')}",
            f"SHA-1:           {game_info.get('sha1', 'N/A')}",
            f"CRC32:           {game_info.get('crc32', 'N/A')}",
            f"XXH64:           {game_info.get('xxh64', 'N/A')}",
            f"================================================================================\n"
        ]

        text_block = "\n".join(entry_lines)

        try:
            with open(self.log_path, "a", encoding="utf-8") as f:
                f.write(text_block)
            logger.info("daad_game_logged_to_file", title=game_info.get("title"), path=str(self.log_path))
        except Exception as exc:
            logger.error("failed_to_write_daad_games_log", error=str(exc))
