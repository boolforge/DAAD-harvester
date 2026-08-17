"""Advanced Rich TUI Dashboard for DAAD Harvester."""

import asyncio
import time
from pathlib import Path
from typing import Dict, Any, List, Optional
from rich.console import Console
from rich.layout import Layout
from rich.panel import Panel
from rich.table import Table
from rich.text import Text
from rich.progress import Progress, SpinnerColumn, TextColumn, BarColumn, TaskProgressColumn
from rich.live import Live

from daad_harvester import __version__
from daad_harvester.config import settings
from daad_harvester.db import Database


class TUIDashboard:
    """Interactive / Advanced Rich TUI Dashboard for monitoring ETL phases and DAAD game discovery."""

    def __init__(self, db: Database):
        self.db = db
        self.console = Console()
        self.start_time = time.time()

    def _make_header(self) -> Panel:
        grid = Table.grid(expand=True)
        grid.add_column(justify="left", ratio=1)
        grid.add_column(justify="right", ratio=1)
        grid.add_row(
            "[bold cyan]DAAD ENGINE HARVESTER & FORENSIC SUITE[/bold cyan]",
            f"[bold green]v{__version__}[/bold green] | [yellow]ETL Status: ACTIVE[/yellow]"
        )
        return Panel(grid, style="bold white on blue")

    def _make_config_panel(self) -> Panel:
        table = Table(title="Configuration Settings", show_header=False, box=None, expand=True)
        table.add_column("Key", style="bold yellow")
        table.add_column("Value", style="cyan")

        table.add_row("Output Directory", str(settings.output_dir))
        table.add_row("Database Path", str(settings.db_path))
        table.add_row("Parallel Workers", str(settings.parallel_workers))
        table.add_row("Rate Limit / Domain", f"{settings.rate_limit_per_domain} req/s")
        table.add_row("Max Unpack Depth", str(settings.max_unpack_depth))
        table.add_row("Proxies Loaded", str(len(settings.proxy_list) if settings.proxy_list else 0))

        return Panel(table, title="[bold magenta]System Config[/bold magenta]", border_style="magenta")

    def _make_stats_panel(self) -> Panel:
        sources = self.db.get_all_sources()
        artifacts = self.db.get_all_artifacts()
        daad_artifacts = [a for a in artifacts if a.is_daad_payload]
        games = self.db.get_all_games()

        elapsed = time.time() - self.start_time

        table = Table(title="Live ETL Statistics", show_header=False, box=None, expand=True)
        table.add_column("Metric", style="bold white")
        table.add_column("Count", style="bold green", justify="right")

        table.add_row("Total Discovered Sources", str(len(sources)))
        table.add_row("Downloaded Sources", str(sum(1 for s in sources if s.status == "downloaded")))
        table.add_row("Extracted Artifacts", str(len(artifacts)))
        table.add_row("Verified DAAD Payloads", f"[bold gold1]{len(daad_artifacts)}[/bold gold1]")
        table.add_row("ScummVM Catalog Entries", str(len(games)))
        table.add_row("Elapsed Time", f"{elapsed:.1f}s")

        return Panel(table, title="[bold green]Metrics & Counters[/bold green]", border_style="green")

    def _make_daad_games_table(self) -> Panel:
        daad_arts = self.db.get_daad_artifacts()
        sources_by_id = {s.id: s for s in self.db.get_all_sources()}

        table = Table(title="Discovered DAAD Games (Live)", expand=True, show_lines=True)
        table.add_column("ID", style="dim", width=4)
        table.add_column("Title", style="bold yellow")
        table.add_column("Platform", style="cyan", width=10)
        table.add_column("Engine Version", style="green", width=14)
        table.add_column("MD5 Hash", style="magenta", width=18)
        table.add_column("Size", justify="right", width=10)

        for art in daad_arts[-8:]: # Display last 8 identified DAAD games
            src = sources_by_id.get(art.source_id)
            title = art.title or (src.title if src else art.original_filename)
            platform = (art.platform_hint or "unknown").upper()
            version = art.daad_version_guess or "DAAD DDB"
            md5_short = art.md5_full[:16] + "..." if len(art.md5_full) > 16 else art.md5_full
            size_str = f"{art.file_size / 1024:.1f} KB"

            table.add_row(str(art.id), title, platform, version, md5_short, size_str)

        return Panel(table, title="[bold gold1]DAAD Games Forensic Feed[/bold gold1]", border_style="gold1")

    def render(self) -> Layout:
        layout = Layout()
        layout.split(
            Layout(name="header", size=3),
            Layout(name="body", ratio=1),
            Layout(name="footer", size=12)
        )
        layout["header"].update(self._make_header())
        layout["body"].split_row(
            Layout(self._make_config_panel(), ratio=1),
            Layout(self._make_stats_panel(), ratio=1)
        )
        layout["footer"].update(self._make_daad_games_table())
        return layout

    def run_live_dashboard(self, duration_sec: int = 5) -> None:
        """Renders live TUI dashboard for duration_sec seconds or during pipeline execution."""
        with Live(self.render(), console=self.console, refresh_per_second=2) as live:
            end = time.time() + duration_sec
            while time.time() < end:
                time.sleep(0.5)
                live.update(self.render())
