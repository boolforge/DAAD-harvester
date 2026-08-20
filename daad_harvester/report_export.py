"""Static JSON report export for the preservation-report viewer.

The viewer consumes this public-safe contract rather than opening the SQLite
state database. It joins existing pipeline outputs without promoting unknown
values or exposing local extraction paths.
"""

from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict

from daad_harvester.catalog import EvidenceCatalogExporter
from daad_harvester.db import Database


class StaticReportExporter:
    """Write a reviewable, frontend-safe summary of recorded pipeline evidence."""

    def __init__(self, db: Database, output_dir: Path, *, generated_at: str | None = None):
        self.db = db
        self.output_dir = output_dir
        self.generated_at = generated_at

    @staticmethod
    def _read_json(path: Path, fallback: Any) -> Any:
        if not path.is_file():
            return fallback
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            return fallback

    @staticmethod
    def _tail(path: Path, limit: int = 120) -> list[str]:
        if not path.is_file():
            return []
        try:
            return path.read_text(encoding="utf-8", errors="replace").splitlines()[-limit:]
        except OSError:
            return []

    def build(self) -> Dict[str, Any]:
        catalog = EvidenceCatalogExporter(self.db, self.output_dir).build()
        # Extraction paths are operational/private machine locations, not web
        # report fields. The library manifest is the durable public link model.
        for artifact in catalog["artifacts"]:
            artifact.pop("extracted_path", None)
        detection_path = self.output_dir / "detection_tables.h"
        detection_text = detection_path.read_text(encoding="utf-8", errors="replace") if detection_path.is_file() else ""
        library = self._read_json(
            self.output_dir / "library" / "manifest.json",
            {"schema_version": 1, "summary": {}, "artifacts": [], "unavailable": True},
        )
        catalog_entries = self._read_json(self.output_dir / "daad_catalog.json", [])
        log_candidates = {
            "general": self.output_dir / "logs" / "daad_general.log",
            "games": self.output_dir / "daad_games.log",
        }
        return {
            "schema_version": 1,
            "generated_at": self.generated_at or datetime.now(timezone.utc).isoformat(),
            "purpose": "Static DAAD preservation evidence report",
            "policy": {
                "unknowns": "Unknown values remain unknown; no report field establishes an unmeasured DAAD version.",
                "paths": "Local extraction paths are intentionally omitted. Library paths are relative retained-artifact links.",
                "verified": "A verified DDB is a structurally validated payload; interpreter binary identity has independent evidence.",
            },
            "summary": {
                **catalog["summary"],
                "detection_entries": len(catalog_entries),
                "library_summary": library.get("summary", {}),
            },
            "catalog": catalog,
            "detections": {
                "available": bool(detection_text),
                "download_path": "detection_tables.h" if detection_text else None,
                "entry_count": len(catalog_entries),
                "preview": detection_text[:12000],
            },
            "library": library,
            "logs": {name: self._tail(path) for name, path in log_candidates.items()},
        }

    def write(self) -> Path:
        self.output_dir.mkdir(parents=True, exist_ok=True)
        output_path = self.output_dir / "report_data.json"
        output_path.write_text(json.dumps(self.build(), indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        return output_path
