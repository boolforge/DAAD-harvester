"""Interactive, Async, Termux-friendly Rich TUI Dashboard for DAAD Harvester."""

import asyncio
import sys
import time
import termios
import tty
from pathlib import Path
from typing import Any, Callable
from rich.console import Console
from rich.layout import Layout
from rich.panel import Panel
from rich.table import Table
from rich.text import Text
from rich.live import Live
from rich.markup import escape

from daad_harvester import __version__
from daad_harvester.config import settings
from daad_harvester.db import Database


class TUIDashboard:
    """Fully interactive, async, non-blocking Rich TUI Dashboard with key bindings, scrolling, and tabs."""

    def __init__(self, db: Database):
        self.db = db
        self.console = Console(force_terminal=True)
        self.start_time = time.time()
        self.active_phase = "INIT"

        # Interactive state
        self.active_tab = 0  # 0: Verified Games, 1: Discovered Sources, 2: System Config & Metrics
        self.tabs = ["1. VERIFIED DAAD GAMES", "2. DISCOVERED SOURCES", "3. SYSTEM CONFIG & METRICS"]
        self.selected_index = 0
        self.search_filter = ""
        self.in_search_mode = False
        self.paused = False

    def set_active_phase(self, phase_name: str) -> None:
        self.active_phase = phase_name

    def handle_key_input(self, key: str) -> None:
        """Processes interactive keyboard shortcuts."""
        if self.in_search_mode:
            if key in ("\r", "\n", "\x1b"):  # Enter or Escape exits search mode
                self.in_search_mode = False
            elif key in ("\x7f", "\x08"):  # Backspace
                self.search_filter = self.search_filter[:-1]
                self.selected_index = 0
            elif len(key) == 1 and key.isprintable():
                self.search_filter += key
                self.selected_index = 0
            return

        if key in ("\t", "t", "T"):  # Tab key to switch tabs
            self.active_tab = (self.active_tab + 1) % len(self.tabs)
            self.selected_index = 0
        elif key in ("w", "k", "A", "\x1b[A"):  # Up / Arrow Up
            self.selected_index = max(0, self.selected_index - 1)
        elif key in ("s", "j", "B", "\x1b[B"):  # Down / Arrow Down
            self.selected_index += 1
        elif key in ("/", "f", "F"):  # Enter search mode
            self.in_search_mode = True
            self.search_filter = ""
            self.selected_index = 0
        elif key in ("c", "C"):  # Clear search filter
            self.search_filter = ""
            self.selected_index = 0
        elif key in ("p", "P"):  # Pause toggle
            self.paused = not self.paused

    def _make_header(self) -> Panel:
        grid = Table.grid(expand=True)
        grid.add_column(justify="left", ratio=1)
        grid.add_column(justify="right", ratio=1)

        tab_headers = []
        for i, name in enumerate(self.tabs):
            if i == self.active_tab:
                tab_headers.append(f"[bold black on yellow] {name} [/bold black on yellow]")
            else:
                tab_headers.append(f"[dim white] {name} [/dim white]")

        tabs_str = " | ".join(tab_headers)
        status_str = f"[bold green]v{__version__}[/bold green] | [bold yellow]Phase: {self.active_phase}[/bold yellow]"
        if self.paused:
            status_str += " | [bold red]PAUSED[/bold red]"

        grid.add_row(
            "[bold cyan]🗡️ DAAD HARVESTER & FORENSIC SUITE[/bold cyan]",
            status_str
        )
        grid.add_row(
            Text.from_markup(tabs_str),
            f"[bold magenta]Filter: '{escape(self.search_filter)}'[/bold magenta]" if self.search_filter else "[dim]Filter: (none)[/dim]"
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

        if self.search_filter:
            sf = self.search_filter.lower()
            daad_arts = [
                a for a in daad_arts
                if sf in (a.title or "").lower() or sf in (a.original_filename or "").lower() or sf in (a.platform_hint or "").lower() or sf in (a.md5_full or "").lower()
            ]

        total_count = len(daad_arts)
        page_size = 12

        if total_count == 0:
            self.selected_index = 0
            display_arts = []
        else:
            self.selected_index = max(0, min(self.selected_index, total_count - 1))
            start_idx = max(0, min(self.selected_index - (page_size // 2), total_count - page_size))
            start_idx = max(0, start_idx)
            display_arts = daad_arts[start_idx:start_idx + page_size]

        table = Table(title=f"Verified DAAD Games Feed (Showing {len(display_arts)} of {total_count})", expand=True, show_lines=True)
        table.add_column("ID", style="dim", width=5)
        table.add_column("Game Title", style="bold yellow")
        table.add_column("Platform", style="cyan", width=10)
        table.add_column("Engine Version", style="green", width=14)
        table.add_column("MD5 (Full)", style="magenta", width=18)
        table.add_column("Size", justify="right", width=10)

        for art in display_arts:
            src = sources_by_id.get(art.source_id)
            title = art.title or (src.title if src else art.original_filename)
            if not title or title.lower() in ("src", "download", "file", "archive", "unnamed"):
                title = Path(art.original_filename).stem.replace("_", " ").title()

            platform = (art.platform_hint or "unknown").upper()
            version = art.daad_version_guess or "DAAD DDB"
            md5_short = art.md5_full[:16] + "..." if art.md5_full and len(art.md5_full) > 16 else (art.md5_full or "N/A")
            size_str = f"{art.file_size / 1024:.1f} KB" if art.file_size else "0 KB"

            actual_idx = daad_arts.index(art)
            style = "bold white on blue" if actual_idx == self.selected_index else None
            # Wrap in Text() (not raw str) so titles/filenames pulled from harvested
            # archives can never be misparsed as Rich markup (e.g. "Game [1988].zip").
            table.add_row(str(art.id), Text(title), Text(platform), Text(version), Text(md5_short), Text(size_str), style=style)

        title_str = "[bold gold1]DAAD Games Forensic Feed[/bold gold1]"
        if self.in_search_mode:
            title_str += f" | [bold red]SEARCH MODE: {escape(self.search_filter)}_[/bold red]"
        return Panel(table, title=title_str, border_style="gold1")

    def _make_sources_table(self) -> Panel:
        sources = self.db.get_all_sources()
        if self.search_filter:
            sf = self.search_filter.lower()
            sources = [s for s in sources if sf in s.url.lower() or sf in (s.title or "").lower() or sf in s.status.lower()]

        total_count = len(sources)
        page_size = 12

        if total_count == 0:
            self.selected_index = 0
            display_sources = []
        else:
            self.selected_index = max(0, min(self.selected_index, total_count - 1))
            start_idx = max(0, min(self.selected_index - (page_size // 2), total_count - page_size))
            start_idx = max(0, start_idx)
            display_sources = sources[start_idx:start_idx + page_size]

        table = Table(title=f"Discovered Sources Catalog (Showing {len(display_sources)} of {total_count})", expand=True, show_lines=True)
        table.add_column("ID", style="dim", width=5)
        table.add_column("Title / Source Name", style="bold cyan")
        table.add_column("URL", style="dim white")
        table.add_column("Tier", style="yellow", width=10)
        table.add_column("Status", style="green", width=12)

        for s in display_sources:
            title = s.title or "Discovered Resource"
            actual_idx = sources.index(s)
            style = "bold white on blue" if actual_idx == self.selected_index else None
            # Text() wrapping: titles/URLs are external, untrusted content and must
            # never be interpreted as Rich markup (see _make_daad_games_table).
            table.add_row(str(s.id), Text(title), Text(s.url[:45] + "..."), Text(s.source_tier), Text(s.status), style=style)

        return Panel(table, title="[bold cyan]Discovered Sources Feed[/bold cyan]", border_style="cyan")

    def render(self) -> Layout:
        layout = Layout()
        layout.split(
            Layout(name="header", size=4),
            Layout(name="body", ratio=1),
            Layout(name="footer", size=3)
        )
        layout["header"].update(self._make_header())

        if self.active_tab == 0:
            layout["body"].update(self._make_daad_games_table())
        elif self.active_tab == 1:
            layout["body"].update(self._make_sources_table())
        else:
            layout["body"].split_row(
                Layout(self._make_config_panel(), ratio=1),
                Layout(self._make_stats_panel(), ratio=1)
            )

        # NOTE: the key-hint labels ([Tab], [/], etc.) must escape their literal
        # brackets with a backslash. Rich's markup parser treats *any* unescaped
        # "[...]" as a style tag -- "[/]" in particular is the bare "close last
        # tag" instruction, so an unescaped version here closes "bold yellow"
        # early and the trailing explicit [/bold yellow] then has nothing left
        # to close, raising rich.errors.MarkupError and crashing the whole TUI.
        footer_text = (
            r"[bold yellow]\[Tab][/bold yellow] Switch Tab  |  "
            r"[bold yellow]\[Up/Down][/bold yellow] Select/Scroll  |  "
            r"[bold yellow]\[/][/bold yellow] Search  |  "
            r"[bold yellow]\[C][/bold yellow] Clear Filter  |  "
            r"[bold yellow]\[P][/bold yellow] Pause"
        )
        layout["footer"].update(Panel(Text.from_markup(footer_text, justify="center"), style="bold white on black"))
        return layout

    async def run_live_tui_async(self, pipeline_coro_fn: Callable[[], Any]) -> None:
        """
        Runs the live interactive TUI with asynchronous non-blocking keyboard input.
        Ensures terminal mode cleanup on exit or exception.
        """
        stop_event = asyncio.Event()

        # Keyboard event loop using termios raw mode with safe TTY check
        async def listen_keys():
            if not sys.stdin or not hasattr(sys.stdin, "isatty") or not sys.stdin.isatty():
                return
            old_settings = None
            try:
                fd = sys.stdin.fileno()
                old_settings = termios.tcgetattr(fd)
                tty.setraw(fd)
                loop = asyncio.get_event_loop()
                reader = asyncio.StreamReader()
                protocol = asyncio.StreamReaderProtocol(reader)
                await loop.connect_read_pipe(lambda: protocol, sys.stdin)

                while not stop_event.is_set():
                    ch = await reader.read(1)
                    if not ch:
                        break
                    key = ch.decode("utf-8", errors="ignore")
                    self.handle_key_input(key)
            except Exception:
                pass
            finally:
                if old_settings is not None:
                    try:
                        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
                    except Exception:
                        pass

        async def update_loop():
            with Live(self.render(), console=self.console, refresh_per_second=4, transient=False) as live:
                while not stop_event.is_set():
                    while self.paused and not stop_event.is_set():
                        live.update(self.render())
                        await asyncio.sleep(0.2)
                    live.update(self.render())
                    await asyncio.sleep(0.25)
                live.update(self.render())

        key_task = asyncio.create_task(listen_keys())
        update_task = asyncio.create_task(update_loop())
        try:
            await pipeline_coro_fn()
        finally:
            stop_event.set()
            key_task.cancel()
            await update_task
