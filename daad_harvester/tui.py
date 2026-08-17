"""Advanced, Termux-friendly Rich TUI Dashboard for DAAD Harvester."""

import asyncio
import time
import sys
from pathlib import Path
from typing import Dict, Any, List, Optional, Callable
from rich.console import Console
from rich.layout import Layout
from rich.panel import Panel
from rich.table import Table
from rich.text import Text
from rich.live import Live

from daad_harvester import __version__
from daad_harvester.config import settings
from daad_harvester.db import Database


class TUIDashboard:
    """Termux-friendly, flicker-free Rich TUI Dashboard for real-time ETL monitoring and DAAD game feed."""

    def __init__(self, db: Database):
        self.db = db
        self.console = Console(force_terminal=True)
        self.start_time = time.time()
        self.active_phase = "INIT"

    def set_active_phase(self, phase_name: str) -> None:
        self.active_phase = phase_name

    def _make_header(self) -> Panel:
        grid = Table.grid(expand=True)
        grid.add_column(justify="left", ratio=1)
        grid.add_column(justify="right", ratio=1)
        grid.add_row(
            "[bold cyan]🗡️ DAAD ENGINE HARVESTER & FORENSIC SUITE[/bold cyan]",
            f"[bold green]v{__version__}[/bold green] | [bold yellow]Phase: {self.active_phase}[/bold yellow]"
        )
        return Panel(grid, style="bold white on blue")

    def _make_config_panel(self) -> Panel:
        table = Table(title="Configuration Settings", show_header=False, box=None, expand=True)
        table.add_column("Key", style="bold yellow")
        table.add_column("Value", style="cyan")

        table.add_row("Output Dir", str(settings.output_dir))
        table.add_row("Logs Dir", str(settings.logs_dir))
        table.add_row("DB Path", str(settings.db_path))
        table.add_row("Workers", str(settings.parallel_workers))
        table.add_row("Rate Limit", f"{settings.rate_limit_per_domain} req/s")
        table.add_row("Max Depth", str(settings.max_unpack_depth))

        return Panel(table, title="[bold magenta]System Config[/bold magenta]", border_style="magenta")

    def _make_stats_panel(self) -> Panel:
        sources = self.db.get_all_sources()
        artifacts = self.db.get_all_artifacts()
        daad_artifacts = [a for a in artifacts if a.is_daad_payload]
        games = self.db.get_all_games()

        downloaded_sources = sum(1 for s in sources if s.status == "downloaded")
        unpacked_sources = sum(1 for s in sources if s.status == "unpacked")
        dead_sources = sum(1 for s in sources if s.status == "dead")
        error_sources = sum(1 for s in sources if s.status == "error")

        elapsed = time.time() - self.start_time

        table = Table(title="Live ETL Pipeline Metrics", show_header=False, box=None, expand=True)
        table.add_column("Metric", style="bold white")
        table.add_column("Count", style="bold green", justify="right")

        table.add_row("Discovered Sources", str(len(sources)))
        table.add_row("Downloaded Sources", f"[cyan]{downloaded_sources}[/cyan]")
        table.add_row("Unpacked Sources", f"[blue]{unpacked_sources}[/blue]")
        table.add_row("Failed/Dead Sources", f"[red]{dead_sources + error_sources}[/red]")
        table.add_row("Extracted Artifacts", str(len(artifacts)))
        table.add_row("Verified DAAD Games", f"[bold gold1]{len(daad_artifacts)}[/bold gold1]")
        table.add_row("ScummVM Catalog Entries", f"[green]{len(games)}[/green]")
        table.add_row("Elapsed Time", f"{elapsed:.1f}s")

        return Panel(table, title="[bold green]ETL Statistics[/bold green]", border_style="green")

    def _make_daad_games_table(self) -> Panel:
        daad_arts = self.db.get_daad_artifacts()
        sources_by_id = {s.id: s for s in self.db.get_all_sources()}

        table = Table(title="Verified DAAD Games Feed (Live)", expand=True, show_lines=True)
        table.add_column("ID", style="dim", width=5)
        table.add_column("Game Title", style="bold yellow")
        table.add_column("Platform", style="cyan", width=10)
        table.add_column("Engine Version", style="green", width=14)
        table.add_column("MD5 (Full)", style="magenta", width=18)
        table.add_column("Size", justify="right", width=10)

        for art in daad_arts[-10:]:
            src = sources_by_id.get(art.source_id)
            title = art.title or (src.title if src else art.original_filename)
            if not title or title.lower() in ("src", "download", "file", "archive", "unnamed"):
                title = Path(art.original_filename).stem.replace("_", " ").title()

            platform = (art.platform_hint or "unknown").upper()
            version = art.daad_version_guess or "DAAD DDB"
            md5_short = art.md5_full[:16] + "..." if art.md5_full and len(art.md5_full) > 16 else (art.md5_full or "N/A")
            size_str = f"{art.file_size / 1024:.1f} KB" if art.file_size else "0 KB"

            table.add_row(str(art.id), title, platform, version, md5_short, size_str)

        return Panel(table, title="[bold gold1]DAAD Games Forensic Feed[/bold gold1]", border_style="gold1")

    def render(self) -> Layout:
        layout = Layout()
        layout.split(
            Layout(name="header", size=3),
            Layout(name="body", ratio=1),
            Layout(name="footer", size=14)
        )
        layout["header"].update(self._make_header())
        layout["body"].split_row(
            Layout(self._make_config_panel(), ratio=1),
            Layout(self._make_stats_panel(), ratio=1)
        )
        layout["footer"].update(self._make_daad_games_table())
        return layout

    async def run_live_tui_async(self, pipeline_coro_fn: Callable[[], Any]) -> None:
        """
        Runs the live interactive TUI using non-blocking, smooth 2Hz terminal refreshes
        to eliminate flickering and glibc/Termux C-library thread contention.
        """
        stop_event = asyncio.Event()

        async def update_loop():
            with Live(self.render(), console=self.console, refresh_per_second=2, transient=False) as live:
                while not stop_event.is_set():
                    live.update(self.render())
                    await asyncio.sleep(0.5)
                live.update(self.render())

        update_task = asyncio.create_task(update_loop())
        try:
            await pipeline_coro_fn()
        finally:
            stop_event.set()
            await update_task
