"""Library builder module organizing classified DAAD artifacts into platform folders.

Compatibility re-export: the implementation still lives in daad_harvester.library;
nothing has been moved here. Import from this path for the new load.* layout, but
look in daad_harvester/library.py to actually read or change the logic.
"""

from daad_harvester.library import LibraryBuilder

__all__ = ["LibraryBuilder"]
