"""Report generator for execution summaries."""

from pathlib import Path
from typing import List, Dict, Any, Optional
from daad_harvester.db import Database
from daad_harvester.models import SourceStatus


class ReportGenerator:
    """Generates execution summary markdown report (scrape_report.md)."""

    def __init__(self, db: Database, output_dir: Path):
        self.db = db
        self.output_dir = output_dir

    def generate_report(self, collisions: Optional[List[Dict[str, Any]]] = None) -> Path:
        sources = self.db.get_all_sources()
        artifacts = self.db.get_all_artifacts()
        daad_artifacts = self.db.get_daad_artifacts()
        games = self.db.get_all_games()

        total_urls = len(sources)
        downloaded = sum(1 for s in sources if s.status == SourceStatus.DOWNLOADED.value)
        failed = sum(1 for s in sources if s.status == SourceStatus.ERROR.value)
        dead = sum(1 for s in sources if s.status == SourceStatus.DEAD.value)

        # Source tier breakdown
        tier_counts: Dict[str, int] = {}
        for s in sources:
            tier_counts[s.source_tier] = tier_counts.get(s.source_tier, 0) + 1

        # Platform distribution histogram
        platform_counts: Dict[str, int] = {}
        for g in games:
            platform_counts[g.platform] = platform_counts.get(g.platform, 0) + 1

        # Unreachable targets
        unreachable = [s for s in sources if s.status in (SourceStatus.ERROR.value, SourceStatus.DEAD.value)]

        md_content = f"""# DAAD Engine Harvester - Execution Summary Report

## 1. Overview Statistics
- **Total Discovered URLs:** {total_urls}
- **Successfully Downloaded:** {downloaded}
- **Failed / Network Error:** {failed}
- **Dead / 404 Targets:** {dead}
- **Total Extracted Artifacts:** {len(artifacts)}
- **Verified DAAD Payloads:** {len(daad_artifacts)}
- **ScummVM Catalog Entries Generated:** {len(games)}

## 2. Source Tier Breakdown
"""
        for tier, count in tier_counts.items():
            md_content += f"- **{tier.upper()}:** {count} URLs\n"

        md_content += "\n## 3. Platform Distribution\n"
        if platform_counts:
            for plat, count in platform_counts.items():
                md_content += f"- **{plat.upper()}:** {count} titles\n"
        else:
            md_content += "_No DAAD titles discovered in execution run._\n"

        md_content += "\n## 4. MD5 Collision Report (Potential Cross-Platform Ports / Duplicates)\n"
        if collisions:
            for col in collisions:
                md_content += f"- MD5 `{col['original']['md5_full']}`: `{col['original']['filename']}` <--> `{col['duplicate']['filename']}`\n"
        else:
            md_content += "_No duplicate MD5 collisions detected._\n"

        md_content += "\n## 5. Coverage Gaps & Unreachable Targets\n"
        if unreachable:
            for u in unreachable:
                md_content += f"- `{u.url}` (Status: **{u.status}**, HTTP: {u.http_status or 'N/A'})\n"
        else:
            md_content += "_No unreachable targets._\n"

        report_path = self.output_dir / "scrape_report.md"
        report_path.write_text(md_content, encoding="utf-8")
        return report_path
