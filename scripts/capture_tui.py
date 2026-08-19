#!/usr/bin/env python3
"""Render a real DAAD Harvester TUI state to SVG for documentation.

The script uses the production TUIDashboard renderer and an existing state
SQLite database. It does not fabricate rows or redraw the interface.
"""

from __future__ import annotations

import argparse
from pathlib import Path

from rich.console import Console
from rich._export_format import CONSOLE_SVG_FORMAT

from daad_harvester.db import Database
from daad_harvester.tui import TUIDashboard


def main() -> None:
    parser = argparse.ArgumentParser(description="Export a live DAAD Harvester TUI state as SVG")
    parser.add_argument("--db", type=Path, required=True, help="Path to a DAAD Harvester state.db")
    parser.add_argument("--output", type=Path, required=True, help="Destination SVG path")
    parser.add_argument("--tab", type=int, default=1, choices=(0, 1, 2), help="TUI tab to render")
    parser.add_argument("--phase", default="COMPLETED", help="Phase label displayed in the capture")
    parser.add_argument("--width", type=int, default=160, help="Terminal width used for the capture")
    args = parser.parse_args()

    db = Database(args.db)
    dashboard = TUIDashboard(db)
    dashboard.active_tab = args.tab
    dashboard.set_active_phase(args.phase)

    console = Console(record=True, force_terminal=True, width=args.width, color_system="truecolor")
    console.print(dashboard.render())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    local_font_format = CONSOLE_SVG_FORMAT.replace(
        "font-family: Fira Code, monospace;",
        'font-family: "DejaVu Sans Mono", "Liberation Mono", monospace;',
    )
    console.save_svg(
        str(args.output),
        title="DAAD Harvester live TUI capture",
        code_format=local_font_format,
        font_aspect_ratio=0.60,
    )


if __name__ == "__main__":
    main()
