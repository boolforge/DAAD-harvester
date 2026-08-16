"""Synthesizer module generating C++ detection tables (detection_tables.h) and JSON catalog (daad_catalog.json)."""

import json
import re
from pathlib import Path
from typing import List, Dict, Any, Tuple, Optional
import structlog

from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.models import ArtifactRecord, GameRecord, Platform
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
    """Computes catalog data and serializes output into ScummVM detection_tables.h and daad_catalog.json."""

    def __init__(self, db: Database, output_dir: Optional[Path] = None):
        self.db = db
        self.output_dir = output_dir or settings.output_dir
        self.output_dir.mkdir(parents=True, exist_ok=True)

    def generate_cpp_entry(self, record: Dict[str, Any]) -> str:
        """Generates a single C++ ADGameDescription struct block."""
        platform_cpp = PLATFORM_MAP_SCUMMVM.get(record["platform"], "Common::kPlatformUnknown")

        cpp = f"""\t{{
\t\t"{record['game_id']}",
\t\t"{record['title']} ({record['platform'].upper()}/{record['year'] or 'Unknown'})",
\t\tAD_ENTRY1s("{record['filename']}", "{record['md5_full']}", {record['file_size']}),
\t\tCommon::ES_ESP,
\t\t{platform_cpp},
\t\tADGF_NO_FLAGS,
\t\tGUIO0()
\t}},"""
        return cpp

    def synthesize_catalog(self) -> Tuple[Path, Path, List[Dict[str, Any]]]:
        """Reads DAAD payload artifacts from DB, constructs GameRecords, and writes output files."""
        artifacts = self.db.get_daad_artifacts()

        catalog_entries: List[Dict[str, Any]] = []
        collisions: List[Dict[str, Any]] = []
        seen_md5s: Dict[str, Dict[str, Any]] = {}

        for art in artifacts:
            clean_name = Path(art.original_filename).stem
            game_slug = f"daad_{slugify(clean_name)}"
            platform = art.platform_hint or Platform.UNKNOWN.value

            entry_dict = {
                "artifact_id": art.id,
                "game_id": game_slug,
                "title": clean_name.replace('_', ' ').replace('-', ' ').title(),
                "platform": platform,
                "language": "es",
                "year": None,
                "publisher": "Aventuras AD" if "ad" in clean_name.lower() else None,
                "author": None,
                "filename": art.original_filename,
                "md5_full": art.md5_full,
                "md5_5000": art.md5_5000,
                "file_size": art.file_size,
                "sha256": art.sha256
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
