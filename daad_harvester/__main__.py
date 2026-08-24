"""Entrypoint module executing the Typer CLI when invoked as `python -m daad_harvester`."""

from daad_harvester.cli import app

if __name__ == "__main__":
    app()
