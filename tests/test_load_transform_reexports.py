"""Tests for the load.*/transform.* compatibility re-export modules.

These modules exist purely so cli.py can import from the new package layout
(daad_harvester.load.*, daad_harvester.transform.*) while the actual implementation
still lives in the flat legacy modules. Every test here asserts object identity, not
just equal behavior: if a future change accidentally turns one of these into a real
(divergent) copy instead of a re-export, `is` will catch it immediately, before the
two implementations can silently drift apart.
"""
from daad_harvester.daad_parser import DAADBytecodeParser as LegacyDAADBytecodeParser
from daad_harvester.daad_parser import DAADParser as LegacyDAADParser
from daad_harvester.daad_parser import DDBHeader as LegacyDDBHeader
from daad_harvester.fingerprint import Fingerprinter as LegacyFingerprinter
from daad_harvester.library import LibraryBuilder as LegacyLibraryBuilder
from daad_harvester.report import ReportGenerator as LegacyReportGenerator
from daad_harvester.report_export import StaticReportExporter as LegacyStaticReportExporter
from daad_harvester.synthesize import Synthesizer as LegacySynthesizer

from daad_harvester.load.organize import LibraryBuilder
from daad_harvester.load.report import ReportGenerator, StaticReportExporter
from daad_harvester.load.synthesize import Synthesizer
from daad_harvester.transform.daad_parser import DAADBytecodeParser, DAADParser, DDBHeader
from daad_harvester.transform.fingerprint import Fingerprinter


def test_load_organize_reexports_the_same_class_object():
    assert LibraryBuilder is LegacyLibraryBuilder


def test_load_report_reexports_the_same_class_objects():
    assert ReportGenerator is LegacyReportGenerator
    assert StaticReportExporter is LegacyStaticReportExporter


def test_load_synthesize_reexports_the_same_class_object():
    assert Synthesizer is LegacySynthesizer


def test_transform_fingerprint_reexports_the_same_class_object():
    assert Fingerprinter is LegacyFingerprinter


def test_transform_daad_parser_reexports_the_same_objects():
    assert DAADParser is LegacyDAADParser
    assert DAADBytecodeParser is LegacyDAADBytecodeParser
    assert DDBHeader is LegacyDDBHeader
