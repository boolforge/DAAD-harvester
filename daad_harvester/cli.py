"""CLI Interface for DAAD Harvester."""

import argparse
import asyncio
import sys
from pathlib import Path
import structlog

from daad_harvester import __version__
from daad_harvester.config import settings
from daad_harvester.db import Database
from daad_harvester.discover import Discoverer
from daad_harvester.fetch import Fetcher
from daad_harvester.unpack import Unpacker
from daad_harvester.fingerprint import Fingerprinter
from daad_harvester.synthesize import Synthesizer
from daad_harvester.report import ReportGenerator

logger = structlog.get_logger(__name__)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="DAAD Engine Game Harvester & Forensic Analysis Pipeline"
    )
    parser.add_argument(
        "--phase",
        choices=["discover", "fetch", "unpack", "fingerprint", "synthesize", "all"],
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
        "--version",
        action="version",
        version=f"%(prog)s {__version__}"
    )

    args = parser.parse_args()

    # Configure paths and settings
    settings.output_dir = args.output_dir.resolve()
    settings.db_path = settings.output_dir / "state.db"
    settings.parallel_workers = args.parallel
    if args.proxy_list:
        settings.proxy_list_file = args.proxy_list.resolve()
        settings.load_proxies()

    settings.output_dir.mkdir(parents=True, exist_ok=True)

    db = Database(settings.db_path)
    logger.info("starting_daad_harvester", phase=args.phase, db_path=str(settings.db_path))

    phase = args.phase

    async def run_pipeline():
        collisions = []

        # Phase 1: Discover
        if phase in ("discover", "all"):
            logger.info("executing_phase_discover")
            discoverer = Discoverer(db)
            await discoverer.run_all_discovery()

        # Phase 2: Fetch
        if phase in ("fetch", "all"):
            logger.info("executing_phase_fetch")
            fetcher = Fetcher(db, download_dir=settings.output_dir / "downloads")
            await fetcher.fetch_pending_sources(parallel=args.parallel)

        # Phase 3: Unpack
        if phase in ("unpack", "all"):
            logger.info("executing_phase_unpack")
            unpacker = Unpacker(db, extract_dir=settings.output_dir / "extracted")
            unpacker.unpack_all_downloaded_sources(parallel=getattr(args, "parallel", settings.parallel_workers))

        # Phase 4: Fingerprint
        if phase in ("fingerprint", "all"):
            logger.info("executing_phase_fingerprint")
            fingerprinter = Fingerprinter(db)
            fingerprinter.scan_all_artifacts()

        # Phase 5: Synthesize & Report
        if phase in ("synthesize", "all"):
            logger.info("executing_phase_synthesize")
            synthesizer = Synthesizer(db, output_dir=settings.output_dir)
            json_path, header_path, collisions = synthesizer.synthesize_catalog()

            reporter = ReportGenerator(db, output_dir=settings.output_dir)
            report_path = reporter.generate_report(collisions=collisions)

            logger.info("pipeline_completed_successfully", catalog=str(json_path), header=str(header_path), report=str(report_path))

    asyncio.run(run_pipeline())


if __name__ == "__main__":
    main()
