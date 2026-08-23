"""Enterprise Typer CLI application for DAAD Harvester ETL pipeline."""

import asyncio
from pathlib import Path
from typing import List, Optional
import typer
from loguru import logger

from daad_harvester import __version__
from daad_harvester.config import settings
from daad_harvester.logging import setup_logger
from daad_harvester.load.storage import StorageEngine
from daad_harvester.extract.unpack import Unpacker
from daad_harvester.transform.fingerprint import Fingerprinter
from daad_harvester.load.organize import LibraryBuilder
from daad_harvester.load.synthesize import Synthesizer
from daad_harvester.load.report import ReportGenerator, StaticReportExporter
from daad_harvester.catalog import EvidenceCatalogExporter
from daad_harvester.discover import Discoverer
from daad_harvester.fetch import Fetcher
from daad_harvester.tui import TUIDashboard


app = typer.Typer(
    name="daad-harvester",
    help="DAAD Engine Game Harvester & Forensic Analysis Pipeline",
    add_completion=False,
)


def version_callback(value: bool) -> None:
    """Callback function displaying package version."""
    if value:
        typer.echo(f"daad-harvester {__version__}")
        raise typer.Exit()


@app.command()
def main(
    phase: str = typer.Option(
        "all",
        "--phase",
        help="Pipeline phase: discover, catalog, fetch, unpack, fingerprint, synthesize, organize, report, all",
    ),
    resume: bool = typer.Option(
        False,
        "--resume",
        help="Resume pipeline using existing state database",
    ),
    parallel: int = typer.Option(
        settings.parallel_workers,
        "--parallel",
        help="Parallel execution workers count",
    ),
    max_sources: Optional[int] = typer.Option(
        None,
        "--max-sources",
        help="Maximum pending sources to fetch",
    ),
    fetch_source: List[int] = typer.Option(
        [],
        "--fetch-source",
        help="Fetch only specific pending source ID(s)",
    ),
    reunpack_source: List[int] = typer.Option(
        [],
        "--reunpack-source",
        help="Reprocess specific source ID(s) with current media parsers",
    ),
    output_dir: Path = typer.Option(
        settings.output_dir,
        "--output-dir",
        help="Output directory for catalog and reports",
    ),
    proxy_list: Optional[Path] = typer.Option(
        None,
        "--proxy-list",
        help="Path to proxy list text file",
    ),
    log_file: Path = typer.Option(
        settings.log_file,
        "--log-file",
        help="Path to structured JSON log file",
    ),
    log_level: str = typer.Option(
        settings.log_level,
        "--log-level",
        help="Log level threshold (DEBUG, INFO, WARNING, ERROR)",
    ),
    tui: bool = typer.Option(
        False,
        "--tui",
        help="Launch interactive TUI dashboard during execution",
    ),
    version: Optional[bool] = typer.Option(
        None,
        "--version",
        callback=version_callback,
        is_eager=True,
        help="Show version and exit",
    ),
) -> None:
    """Executes specified pipeline phase or full ETL pipeline."""
    # Configure global settings
    settings.output_dir = output_dir.resolve()
    settings.db_path = settings.output_dir / "state.db"
    settings.logs_dir = settings.output_dir / "logs"
    settings.parallel_workers = parallel
    if proxy_list:
        settings.proxy_list_file = proxy_list.resolve()
        settings.load_proxies()
    settings.log_file = log_file.resolve()
    settings.log_level = log_level

    setup_logger(log_file=settings.log_file, log_level=settings.log_level)
    settings.output_dir.mkdir(parents=True, exist_ok=True)

    storage = StorageEngine(settings.db_path)
    storage.init_storage()
    db = storage.legacy_db

    logger.info("Starting DAAD Harvester pipeline", phase=phase, db_path=str(settings.db_path))

    dashboard = TUIDashboard(db) if tui else None

    async def run_pipeline() -> None:
        # Phase 1: Discover
        if phase in ("discover", "all"):
            if dashboard:
                dashboard.set_active_phase("1. DISCOVER")
            logger.info("Executing Phase: DISCOVER")
            discoverer = Discoverer(db)
            await discoverer.run_all_discovery()

        # Phase 2: Evidence Catalog
        if phase in ("catalog", "all"):
            if dashboard:
                dashboard.set_active_phase("2. CATALOG")
            logger.info("Executing Phase: CATALOG")
            catalog_path = EvidenceCatalogExporter(db, output_dir=settings.output_dir).write()
            logger.info(f"Evidence catalog written to {catalog_path}")

        # Phase 3: Fetch
        if phase in ("fetch", "all"):
            if dashboard:
                dashboard.set_active_phase("3. FETCH")
            logger.info("Executing Phase: FETCH")
            fetcher = Fetcher(db, download_dir=settings.output_dir / "downloads")
            await fetcher.fetch_pending_sources(
                parallel=parallel,
                max_sources=max_sources,
                source_ids=fetch_source or None,
            )

        # Phase 4: Unpack
        if phase in ("unpack", "all"):
            if dashboard:
                dashboard.set_active_phase("4. UNPACK")
            logger.info("Executing Phase: UNPACK")
            unpacker = Unpacker(db, extract_dir=settings.output_dir / "extracted")
            if reunpack_source:
                for src_id in reunpack_source:
                    unpacker.reunpack_retained_source(src_id)
            else:
                unpacker.unpack_all_downloaded_sources(parallel=parallel)

        # Phase 5: Fingerprint
        if phase in ("fingerprint", "all"):
            if dashboard:
                dashboard.set_active_phase("5. FINGERPRINT")
            logger.info("Executing Phase: FINGERPRINT")
            fingerprinter = Fingerprinter(db)
            fingerprinter.scan_all_artifacts()

        # Phase 6: Synthesize & Report
        if phase in ("synthesize", "all"):
            if dashboard:
                dashboard.set_active_phase("6. SYNTHESIZE")
            logger.info("Executing Phase: SYNTHESIZE")
            synthesizer = Synthesizer(db, output_dir=settings.output_dir)
            json_path, header_path, collisions = synthesizer.synthesize_catalog()

            reporter = ReportGenerator(db, output_dir=settings.output_dir)
            report_path = reporter.generate_report(collisions=collisions)
            logger.info(f"Pipeline synthesis complete: {json_path}, {report_path}")

        # Phase 7: Organize Library
        if phase in ("organize", "all"):
            if dashboard:
                dashboard.set_active_phase("7. ORGANIZE")
            logger.info("Executing Phase: ORGANIZE")
            library_path = LibraryBuilder(db, output_dir=settings.output_dir).build()
            logger.info(f"Library organized at {library_path}")

        # Phase 8: Report Export
        if phase in ("report", "all"):
            if dashboard:
                dashboard.set_active_phase("8. REPORT EXPORT")
            logger.info("Executing Phase: REPORT EXPORT")
            report_data_path = StaticReportExporter(db, output_dir=settings.output_dir).write()
            logger.info(f"Static report data exported to {report_data_path}")

        if dashboard:
            dashboard.set_active_phase("COMPLETED")

    if tui and dashboard:
        asyncio.run(dashboard.run_live_tui_async(run_pipeline))
    else:
        asyncio.run(run_pipeline())


if __name__ == "__main__":
    app()
