"""Interpreter-aware DAAD fingerprinting module in the Transform layer.

Compatibility re-export: the implementation still lives in daad_harvester.fingerprint;
nothing has been moved here. Import from this path for the new transform.* layout, but
look in daad_harvester/fingerprint.py to actually read or change the logic.
"""

from daad_harvester.fingerprint import Fingerprinter

__all__ = ["Fingerprinter"]
