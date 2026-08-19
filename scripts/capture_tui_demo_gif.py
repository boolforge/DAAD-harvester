#!/usr/bin/env python3
"""Capture a real DAAD Harvester TUI interaction sequence as an animated GIF.

The script drives `TUIDashboard.handle_key_input()` and renders the production
layout against a persisted state database. It is intentionally a reproducible
recording of real UI states, not a hand-drawn animation or a mockup.
"""

from __future__ import annotations

import argparse
import io
import subprocess
import tempfile
from pathlib import Path

from PIL import Image, ImageChops
from rich._export_format import CONSOLE_SVG_FORMAT
from rich.console import Console

from daad_harvester.db import Database
from daad_harvester.tui import TUIDashboard


def export_svg(dashboard: TUIDashboard, target: Path, width: int) -> None:
    console = Console(file=io.StringIO(), record=True, force_terminal=True, width=width, color_system="truecolor")
    console.print(dashboard.render())
    local_font_format = CONSOLE_SVG_FORMAT.replace(
        "font-family: Fira Code, monospace;",
        'font-family: "DejaVu Sans Mono", "Liberation Mono", monospace;',
    )
    console.save_svg(
        str(target),
        title="DAAD Harvester live interactive TUI",
        code_format=local_font_format,
        font_aspect_ratio=0.60,
    )


def rasterize(svg_path: Path, png_path: Path, width: int) -> None:
    pixel_width = width * 12 + 16
    subprocess.run(
        [
            "chromium", "--headless", "--no-sandbox", "--disable-gpu", "--hide-scrollbars",
            f"--window-size={pixel_width},720", f"--screenshot={png_path}", svg_path.resolve().as_uri(),
        ],
        check=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    image = Image.open(png_path).convert("RGB")
    # Crop only browser canvas whitespace; all TUI pixels remain intact.
    background = Image.new("RGB", image.size, (255, 255, 255))
    bounds = ImageChops.difference(image, background).getbbox()
    if bounds:
        left, top, right, bottom = bounds
        image.crop((max(0, left - 2), max(0, top - 2), min(image.width, right + 2), min(image.height, bottom + 2))).save(png_path)
    else:
        image.save(png_path)


def add_frame(dashboard: TUIDashboard, frame_dir: Path, index: int, width: int) -> Path:
    svg_path = frame_dir / f"frame-{index:02d}.svg"
    png_path = frame_dir / f"frame-{index:02d}.png"
    export_svg(dashboard, svg_path, width)
    rasterize(svg_path, png_path, width)
    return png_path


def main() -> None:
    parser = argparse.ArgumentParser(description="Capture a real interactive DAAD Harvester TUI GIF")
    parser.add_argument("--db", type=Path, required=True, help="Path to a completed DAAD Harvester state.db")
    parser.add_argument("--output", type=Path, required=True, help="GIF destination")
    parser.add_argument("--width", type=int, default=160, help="Terminal width")
    args = parser.parse_args()

    dashboard = TUIDashboard(Database(args.db))
    dashboard.set_active_phase("COMPLETED · LIBRARY READY")

    with tempfile.TemporaryDirectory(prefix="daad-tui-demo-") as temp_dir:
        frame_dir = Path(temp_dir)
        frame_paths = []

        # 1. Priority queue at the completed real run.
        dashboard.active_tab = 1
        frame_paths.append(add_frame(dashboard, frame_dir, 1, args.width))
        # 2. Real selection/scroll interaction.
        for _ in range(3):
            dashboard.handle_key_input("s")
        frame_paths.append(add_frame(dashboard, frame_dir, 2, args.width))
        # 3. Search interaction driven through the same key handler as the live TUI.
        dashboard.handle_key_input("/")
        for char in "chichen":
            dashboard.handle_key_input(char)
        frame_paths.append(add_frame(dashboard, frame_dir, 3, args.width))
        # 4. Clear the filter and switch to real system metrics.
        dashboard.handle_key_input("\n")
        dashboard.handle_key_input("c")
        dashboard.handle_key_input("\t")
        frame_paths.append(add_frame(dashboard, frame_dir, 4, args.width))
        # 5. Pause state is also an actual dashboard interaction.
        dashboard.handle_key_input("p")
        frame_paths.append(add_frame(dashboard, frame_dir, 5, args.width))
        # 6. Return to the verified-payload feed.
        dashboard.handle_key_input("p")
        dashboard.handle_key_input("\t")
        frame_paths.append(add_frame(dashboard, frame_dir, 6, args.width))
        # 7. Return to the queue with the library-ready phase visible.
        dashboard.handle_key_input("\t")
        frame_paths.append(add_frame(dashboard, frame_dir, 7, args.width))

        frames = [Image.open(path).convert("P", palette=Image.Palette.ADAPTIVE, colors=256) for path in frame_paths]
        args.output.parent.mkdir(parents=True, exist_ok=True)
        frames[0].save(
            args.output,
            save_all=True,
            append_images=frames[1:],
            duration=[1400, 900, 1300, 1300, 900, 1100, 1400],
            loop=0,
            disposal=2,
            optimize=True,
        )


if __name__ == "__main__":
    main()
