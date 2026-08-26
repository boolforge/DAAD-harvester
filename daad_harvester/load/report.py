"""Report generator module exporting static preservation reports and data contracts.

Compatibility re-export: the implementations still live in daad_harvester.report and
daad_harvester.report_export; nothing has been moved here. Import from this path for
the new load.* layout, but look in those two modules to actually read or change the logic.
"""

from daad_harvester.report import ReportGenerator
from daad_harvester.report_export import StaticReportExporter

__all__ = ["ReportGenerator", "StaticReportExporter"]
