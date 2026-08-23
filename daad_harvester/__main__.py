"""Entrypoint module executing Typer CLI when invoked as `python -m daad_harvester`."""

from daad_harvester.cli import app

if __name__ == "__main__":
    app()
