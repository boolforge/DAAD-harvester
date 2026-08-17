"""Synthesizer module generating C++ detection tables (detection_tables.h), JSON catalog (daad_catalog.json), and logging to daad_games.log."""

import json
import re
from pathlib import Path
from typing import List, Dict, Any, Tuple, Optional
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, GameRecord, Platform
from daad_harvester.daad_logger import DAADGamesLogger
from daad_harvester.exceptions import SynthesizeError

logger = structlog.get_logger(__name__)


PLATFORM_MAP_SCUMMVM = {
    Platform.ZX.value: "Common::kPlatformZXSpectrum",
    Platform.CPC.value: "Common::kPlatformAmstradCPC",
    Platform.C64.value: "Common::kPlatformC64",
    Platform.AMIGA.value: "Common::kPlatformAmiga",
    Platform.ATARIST.value: "Common::kPlatformAtariST",
    Platform.MSX.value: "Common::kPlatformMSX",
    Platform.PC.value: "Common::kPlatformDOS",
    Platform.ORIC.value: "Common::kPlatformOric",
    Platform.UNKNOWN.value: "Common::kPlatformUnknown",
}


def slugify(text: str) -> str:
    """Generates clean slug for game_id."""
    text = text.lower()
    text = re.sub(r'[^a-z0-9_]+', '_', text)
    text = text.strip('_')
    return text or "daad_game"


class Synthesizer:
    """Computes catalog data and serializes output into ScummVM detection_tables.h, daad_catalog.json, and daad_games.log."""

    def __init__(self, db: Database, output_dir: Optional[Path] = None):
        self.db = db
        self.output_dir = output_dir or settings.output_dir
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.daad_logger = DAADGamesLogger(self.output_dir / "daad_games.log", auto_rotate=False)

    def generate_cpp_entry(self, record: Dict[str, Any]) -> str:
        """Generates a single C++ ADGameDescription struct block with full hash suite annotations."""
        platform_cpp = PLATFORM_MAP_SCUMMVM.get(record["platform"], "Common::kPlatformUnknown")

        cpp = f"""\t// MD5 Head (5KB): {record.get('md5_5000', 'N/A')} | SHA-256: {record.get('sha256', 'N/A')} | SHA-1: {record.get('sha1', 'N/A')} | CRC32: {record.get('crc32', 'N/A')} | XXH64: {record.get('xxh64', 'N/A')}
\t{{
\t\t"{record['game_id']}",
\t\t"{record['title']} ({record['platform'].upper()}/{record['year'] or 'Unknown'})",
\t\tAD_ENTRY1s("{record['filename']}", "{record['md5_full']}", {record['file_size']}),
\t\tCommon::ES_ESP,
\t\t{platform_cpp},
\t\tADGF_NO_FLAGS,
\t\tGUIO0()
\t}},"""
        return cpp

    def _is_generic_name(self, name: str) -> bool:
        """Returns True if filename or title looks like generic auto-generated string."""
        n = name.lower().strip()
        if re.match(r'^\d+_source_\d+$', n) or re.match(r'^\d+_index', n) or n in ("index", "index.php", "renpy.data", "unnamed"):
            return True
        if re.match(r'^file_\d+$', n) or re.match(r'^block_\d+$', n) or re.match(r'^depth\d+_', n):
            return True
        return False

    def _determine_title_and_slug(self, art: ArtifactRecord, source: Optional[Any]) -> Tuple[str, str]:
        """Determines clean game title and game_id slug using artifact, source metadata, or parent URL."""
        title = art.title
        if not title and source:
            title = source.title

        art_stem = Path(art.original_filename).stem

        if not title or self._is_generic_name(title):
            if art_stem and not self._is_generic_name(art_stem) and art_stem.lower() not in ("src", "download", "file", "archive"):
                title = art_stem.replace('_', ' ').replace('-', ' ').title()

        if not title or self._is_generic_name(title):
            if source and source.url:
                url_filename = Path(source.url.rsplit('#', 1)[0].rsplit('?', 1)[0]).stem
                if not self._is_generic_name(url_filename):
                    title = url_filename.replace('_', ' ').replace('-', ' ').title()
            if (not title or self._is_generic_name(title)) and source and source.local_path:
                source_stem = Path(source.local_path).stem
                if not self._is_generic_name(source_stem):
                    title = source_stem.replace('_', ' ').replace('-', ' ').title()

        if not title or self._is_generic_name(title):
            title = art_stem.replace('_', ' ').replace('-', ' ').title()

        title = re.sub(r'^\d+[\s_-]*', '', title).strip() or "DAAD Game"
        slug = slugify(title)
        if not slug.startswith("daad_"):
            game_slug = f"daad_{slug}"
        else:
            game_slug = slug

        return title, game_slug

    def synthesize_catalog(self) -> Tuple[Path, Path, List[Dict[str, Any]]]:
        """Reads DAAD payload artifacts from DB, constructs GameRecords, writes output files, and logs to daad_games.log."""
        artifacts = self.db.get_daad_artifacts()
        sources_by_id = {s.id: s for s in self.db.get_all_sources()}

        catalog_entries: List[Dict[str, Any]] = []
        collisions: List[Dict[str, Any]] = []
        seen_md5s: Dict[str, Dict[str, Any]] = {}

        for art in artifacts:
            source = sources_by_id.get(art.source_id)
            title, game_slug = self._determine_title_and_slug(art, source)

            platform = art.platform_hint or (source.platform if source and source.platform else Platform.UNKNOWN.value)
            year = art.year or (source.year if source else None)
            publisher = art.publisher or (source.publisher if source else None)
            author = art.author or (source.author if source else None)
            language = art.language or (source.language if source else "es")

            entry_dict = {
                "artifact_id": art.id,
                "game_id": game_slug,
                "title": title,
                "platform": platform,
                "language": language,
                "year": year,
                "publisher": publisher,
                "author": author,
                "filename": art.original_filename,
                "file_size": art.file_size,
                "daad_version_guess": art.daad_version_guess,
                "extracted_path": art.extracted_path,
                "source_url": source.url if source else "N/A",
                "md5_full": art.md5_full,
                "md5_5000": art.md5_5000,
                "md5_tail5000": art.md5_tail5000,
                "sha256": art.sha256,
                "sha1": art.sha1,
                "crc32": art.crc32,
                "sha224": art.sha224,
                "sha384": art.sha384,
                "sha512": art.sha512,
                "sha3_256": art.sha3_256,
                "sha3_512": art.sha3_512,
                "blake2b": art.blake2b,
                "blake2s": art.blake2s,
                "adler32": art.adler32,
                "xxh32": art.xxh32,
                "xxh64": art.xxh64,
                "xxh128": art.xxh128
            }

            if art.md5_full in seen_md5s:
                collisions.append({
                    "original": seen_md5s[art.md5_full],
                    "duplicate": entry_dict
                })
                logger.info("md5_collision_detected", md5=art.md5_full, file1=seen_md5s[art.md5_full]["filename"], file2=art.original_filename)

            seen_md5s[art.md5_full] = entry_dict

            cpp_code = self.generate_cpp_entry(entry_dict)
            entry_dict["detection_entry"] = cpp_code

            # Log to dedicated daad_games.log
            self.daad_logger.log_daad_game(entry_dict, status_prefix="VERIFIED CATALOG ENTRY")

            game_record = GameRecord(
                id=None,
                artifact_id=art.id,
                game_id=entry_dict["game_id"],
                title=entry_dict["title"],
                platform=entry_dict["platform"],
                language=entry_dict["language"],
                year=entry_dict["year"],
                publisher=entry_dict["publisher"],
                author=entry_dict["author"],
                detection_entry=cpp_code
            )
            self.db.add_game(game_record)
            catalog_entries.append(entry_dict)

        # Write daad_catalog.json
        json_path = self.output_dir / "daad_catalog.json"
        json_path.write_text(json.dumps(catalog_entries, indent=2, ensure_ascii=False), encoding="utf-8")

        # Write detection_tables.h
        cpp_entries_str = "\n".join([e["detection_entry"] for e in catalog_entries])

        cpp_header_content = f"""/* ScummVM - Graphic Adventure Engine
 * Detection tables generated for DAAD engine integration.
 */

#ifndef DAAD_DETECTION_TABLES_H
#define DAAD_DETECTION_TABLES_H

#include "engines/advancedDetector.h"

namespace DAAD {{

static const ADGameDescription gameDescriptions[] = {{
{cpp_entries_str}
\tAD_END_MARKER
}};

}} // End of namespace DAAD

#endif // DAAD_DETECTION_TABLES_H
"""
        header_path = self.output_dir / "detection_tables.h"
        header_path.write_text(cpp_header_content, encoding="utf-8")

        logger.info("synthesize_completed", catalog_entries=len(catalog_entries), collisions=len(collisions))
        return json_path, header_path, collisions
