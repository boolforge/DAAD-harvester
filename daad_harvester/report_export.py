"""Static JSON report export for the preservation-report viewer.

The viewer consumes this public-safe contract rather than opening the SQLite
state database. It joins existing pipeline outputs without promoting unknown
values or exposing local extraction paths.
"""

from __future__ import annotations

import json
from hashlib import sha256
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict

from daad_harvester.catalog import EvidenceCatalogExporter
from daad_harvester.db import Database
from daad_harvester.generator_evidence import verify_native_generators


ARTIFACT_CHECKSUM_FIELDS = (
    "md5_full", "md5_5000", "md5_tail5000", "sha1", "sha224", "sha256",
    "sha384", "sha512", "sha3_256", "sha3_512", "blake2b", "blake2s",
    "crc32", "adler32", "xxh32", "xxh64", "xxh128",
)


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
    def _lineage_role(artifact: Dict[str, Any]) -> str:
        """Classify retained lineage without inferring the member's semantics."""

        if artifact.get("media_status") == "runtime_recovered":
            return "derived_recovery"
        if artifact.get("archive_depth", 0) == 0 and artifact.get("container_format"):
            return "source_container"
        if artifact.get("container_format"):
            return "extracted_medium"
        if artifact.get("container_member"):
            return "extracted_member"
        return "retained_byte"

    @staticmethod
    def _catalog_title_matrix(catalog: Dict[str, Any]) -> list[Dict[str, Any]]:
        """Join explicit source-game associations to retained artifacts safely.

        The matrix deliberately preserves three separate layers: catalog-declared
        platforms, source-declared platforms, and platforms measured on retained
        artifacts.  It does not call any layer a runnable or verified game port.
        """

        artifacts_by_source: dict[int, list[Dict[str, Any]]] = {}
        for artifact in catalog["artifacts"]:
            source_id = artifact.get("source_id")
            if isinstance(source_id, int):
                artifacts_by_source.setdefault(source_id, []).append(artifact)

        matrix: list[Dict[str, Any]] = []
        for game in catalog["games"]:
            source_entries = game["queued_sources"]
            source_platforms = sorted(
                {str(source["platform"]) for source in source_entries if source.get("platform")}
            )
            linked_artifacts: list[Dict[str, Any]] = []
            for source in source_entries:
                source_id = source.get("id")
                if not isinstance(source_id, int):
                    continue
                for artifact in artifacts_by_source.get(source_id, []):
                    measured_platform = artifact.get("measured_platform")
                    linked_artifacts.append(
                        {
                            "artifact_id": artifact["id"],
                            "source_id": source_id,
                            "source_platform": source.get("platform"),
                            "original_filename": artifact["original_filename"],
                            "sha256": artifact["sha256"],
                            "checksums": {
                                field: artifact.get(field) for field in ARTIFACT_CHECKSUM_FIELDS
                            },
                            "file_size": artifact["file_size"],
                            "archive_depth": artifact.get("archive_depth", 0),
                            "artifact_platform_hint": artifact.get("legacy_platform_hint"),
                            "measured_platform": measured_platform,
                            "container_format": artifact.get("container_format"),
                            "container_member": artifact.get("container_member"),
                            "media_parser": artifact.get("media_parser"),
                            "media_status": artifact.get("media_status"),
                            "media_validation": artifact.get("media_validation"),
                            "lineage_role": StaticReportExporter._lineage_role(artifact),
                            "is_daad_payload": artifact["is_daad_payload"],
                            "ddb_format": artifact.get("ddb_format"),
                            "interpreter_identity": artifact.get("interpreter_identity"),
                            "evidence_state": "verified_ddb" if artifact["is_daad_payload"] else "retained_artifact",
                        }
                    )
            linked_artifacts.sort(
                key=lambda item: (
                    item["source_id"],
                    item["archive_depth"],
                    item["artifact_id"],
                    item["original_filename"],
                )
            )
            measured_platforms = sorted(
                {
                    str(artifact["measured_platform"])
                    for artifact in linked_artifacts
                    if artifact.get("measured_platform")
                }
            )
            matrix.append(
                {
                    "game_id": game["game_id"],
                    "title": game["title"],
                    "catalog_platforms": list(game["platform_evidence"]),
                    "source_platforms": source_platforms,
                    "measured_artifact_platforms": measured_platforms,
                    "source_count": len(source_entries),
                    "artifacts": linked_artifacts,
                    "boundary": (
                        "Catalog platforms, source platforms, and measured artifact platforms are distinct "
                        "evidence layers; this matrix does not assert a runnable game port."
                    ),
                }
            )
        return matrix

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
        generator_entries = verify_native_generators()
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
            "game_port_matrix": self._catalog_title_matrix(catalog),
            "generator_evidence": {
                "available": True,
                "generators": generator_entries,
                "boundary": (
                    "Generator evidence proves only the listed deterministic output and native structural "
                    "validation. Filesystem population, authentic-release equivalence, and target execution "
                    "remain explicit per-generator comparison fields."
                ),
            },
            "detections": {
                "available": bool(detection_text),
                "download_path": "detection_tables.h" if detection_text else None,
                "entry_count": len(catalog_entries),
                "preview": detection_text[:12000],
                "sha256": sha256(detection_text.encode("utf-8")).hexdigest() if detection_text else None,
                "generator": "daad_harvester.synthesize.Synthesizer",
                "input_catalog": "daad_catalog.json",
                "boundary": (
                    "Generated ScummVM-oriented detection metadata; not proof of a complete engine, "
                    "a runnable title, or emulator-equivalent behavior."
                ),
            },
            "library": library,
            "logs": {
                "general": [
                    "Mutable operational logs are intentionally excluded from this deterministic static report.",
                    "Run the local pipeline or inspect committed issue records for reproducible execution evidence.",
                ],
                "games": [
                    "Per-game live log tails are not exported because they change outside the committed evidence contract.",
                    "Use source, artifact, checksum, and report records for portable preservation evidence.",
                ],
            },
        }

    def write(self) -> Path:
        self.output_dir.mkdir(parents=True, exist_ok=True)
        output_path = self.output_dir / "report_data.json"
        output_path.write_text(json.dumps(self.build(), indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        return output_path
