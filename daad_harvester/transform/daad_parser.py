"""Structural DAAD DDB recognition and parsing engine in the Transform layer.

Compatibility re-export: the implementation still lives in daad_harvester.daad_parser;
nothing has been moved here. Import from this path for the new transform.* layout, but
look in daad_harvester/daad_parser.py to actually read or change the logic. This one in
particular (DAAD DDB bytecode parsing) is delicate, fixture-verified domain logic --
do not attempt a "real" move without full parity testing against tests/test_daad_parser.py.
"""

from daad_harvester.daad_parser import DAADBytecodeParser, DAADParser, DDBHeader, MACHINE_IDS

__all__ = ["DAADParser", "DAADBytecodeParser", "DDBHeader", "MACHINE_IDS"]
