"""CLI Interface for DAAD Harvester."""

import argparse
import asyncio
from pathlib import Path
import structlog

from daad_harvester import __version__
from daad_harvester.config import settings, setup_logging
from daad_harvester.db import Database
from daad_harvester.discover import Discoverer
from daad_harvester.fetch import Fetcher
from daad_harvester.unpack import Unpacker
from daad_harvester.fingerprint import Fingerprinter
from daad_harvester.synthesize import Synthesizer
from daad_harvester.report import ReportGenerator
from daad_harvester.catalog import EvidenceCatalogExporter
from daad_harvester.tui import TUIDashboard

logger = structlog.get_logger(__name__)


def main() -> None:
    parser = argparse.ArgumentParser(
        prog="daad-harvester",
        description="DAAD Engine Game Harvester & Forensic Analysis Pipeline"
    )
    parser.add_argument(
        "--phase",
        choices=["discover", "catalog", "fetch", "unpack", "fingerprint", "synthesize", "all"],
        default="all",
        help="Pipeline phase to execute (default: all)"
    )
    parser.add_argument(
        "--resume",
        action="store_true",
        help="Resume pipeline using existing state database"
    )
    parser.add_argument(
        "--parallel",
        type=int,
        default=settings.parallel_workers,
        help=f"Parallel download workers (default: {settings.parallel_workers})"
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=settings.output_dir,
        help="Output directory for catalog and reports"
    )
    parser.add_argument(
        "--proxy-list",
        type=Path,
        default=None,
        help="Path to proxy list text file"
    )
    parser.add_argument(
        "--log-file",
        type=Path,
        default=settings.log_file,
        help=f"Path to log file (default: {settings.log_file})"
    )
    parser.add_argument(
        "--log-level",
        type=str,
        default=settings.log_level,
        help=f"Log level (default: {settings.log_level})"
    )
    parser.add_argument(
        "--tui",
        action="store_true",
        help="Launch live interactive TUI dashboard display during pipeline execution"
    )
    parser.add_argument(
        "--version",
        action="version",
        version=f"%(prog)s {__version__}"
    )

    args = parser.parse_args()

    # Configure paths and settings
    settings.output_dir = args.output_dir.resolve()
    settings.db_path = settings.output_dir / "state.db"
    settings.logs_dir = settings.output_dir / "logs"
    settings.parallel_workers = args.parallel
    if args.proxy_list:
        settings.proxy_list_file = args.proxy_list.resolve()
        settings.load_proxies()
    if args.log_file:
        settings.log_file = args.log_file.resolve()
    settings.log_level = args.log_level

    setup_logging(log_file=settings.log_file, log_level=settings.log_level, rotate_old=True)

    settings.output_dir.mkdir(parents=True, exist_ok=True)

    db = Database(settings.db_path)
    db.backfill_and_rescan_session()

    logger.info("starting_daad_harvester", phase=args.phase, db_path=str(settings.db_path))

    phase = args.phase
    dashboard = TUIDashboard(db) if args.tui else None

    async def run_pipeline():
        collisions = []

        # Phase 1: Discover
        if phase in ("discover", "all"):
            if dashboard:
                dashboard.set_active_phase("1. DISCOVER")
            logger.info("executing_phase_discover")
            discoverer = Discoverer(db)
            await discoverer.run_all_discovery()

        # Phase 2: Evidence catalog
        if phase in ("catalog", "all"):
            if dashboard:
                dashboard.set_active_phase("2. CATALOG")
            logger.info("executing_phase_catalog")
            catalog_path = EvidenceCatalogExporter(db, output_dir=settings.output_dir).write()
            logger.info("evidence_catalog_written", catalog=str(catalog_path))

        # Phase 3: Fetch
        if phase in ("fetch", "all"):
            if dashboard:
                dashboard.set_active_phase("3. FETCH")
            logger.info("executing_phase_fetch")
            fetcher = Fetcher(db, download_dir=settings.output_dir / "downloads")
            await fetcher.fetch_pending_sources(parallel=args.parallel)

        # Phase 4: Unpack
        if phase in ("unpack", "all"):
            if dashboard:
                dashboard.set_active_phase("4. UNPACK")
            logger.info("executing_phase_unpack")
            unpacker = Unpacker(db, extract_dir=settings.output_dir / "extracted")
            unpacker.unpack_all_downloaded_sources(parallel=getattr(args, "parallel", settings.parallel_workers))

        # Phase 5: Fingerprint
        if phase in ("fingerprint", "all"):
            if dashboard:
                dashboard.set_active_phase("5. FINGERPRINT")
            logger.info("executing_phase_fingerprint")
            fingerprinter = Fingerprinter(db)
            fingerprinter.scan_all_artifacts()

        # Phase 6: Synthesize & Report
        if phase in ("synthesize", "all"):
            if dashboard:
                dashboard.set_active_phase("6. SYNTHESIZE")
            logger.info("executing_phase_synthesize")
            synthesizer = Synthesizer(db, output_dir=settings.output_dir)
            json_path, header_path, collisions = synthesizer.synthesize_catalog()

            reporter = ReportGenerator(db, output_dir=settings.output_dir)
            report_path = reporter.generate_report(collisions=collisions)

            logger.info("pipeline_completed_successfully", catalog=str(json_path), header=str(header_path), report=str(report_path))

        if dashboard:
            dashboard.set_active_phase("COMPLETED")

    if args.tui:
        asyncio.run(dashboard.run_live_tui_async(run_pipeline))
    else:
        asyncio.run(run_pipeline())


if __name__ == "__main__":
    main()
