"""Catalog synthesizer module building detection tables and JSON artifacts.

Compatibility re-export: the implementation still lives in daad_harvester.synthesize;
nothing has been moved here. Import from this path for the new load.* layout, but
look in daad_harvester/synthesize.py to actually read or change the logic.
"""

from daad_harvester.synthesize import Synthesizer

__all__ = ["Synthesizer"]
