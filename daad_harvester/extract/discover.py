"""High-speed web scraping and source discovery layer using selectolax and BeautifulSoup."""

from typing import List, Set
from selectolax.parser import HTMLParser
from bs4 import BeautifulSoup

from daad_harvester.transform.models import SourceModel, SourceStatus


class ScrapingEngine:
    """Fast HTML parsing and link extraction engine using selectolax with BeautifulSoup lxml fallback."""

    @staticmethod
    def extract_links_selectolax(html_content: str, base_url: str) -> List[str]:
        """Extracts absolute hyper-links from HTML text using selectolax for maximum performance.

        Args:
            html_content: Raw HTML text.
            base_url: Base URL string for resolving relative links.

        Returns:
            List of extracted URL strings.
        """
        urls: Set[str] = set()
        tree = HTMLParser(html_content)
        for node in tree.css("a[href]"):
            href = node.attributes.get("href")
            if href and not href.startswith(("javascript:", "mailto:", "#")):
                if href.startswith("http://") or href.startswith("https://"):
                    urls.add(href)
                elif href.startswith("/"):
                    parts = base_url.split("/")
                    domain = f"{parts[0]}//{parts[2]}"
                    urls.add(f"{domain}{href}")
                else:
                    base = base_url.rsplit("/", 1)[0]
                    urls.add(f"{base}/{href}")
        return list(urls)

    @staticmethod
    def parse_html_bs4(html_content: str) -> BeautifulSoup:
        """Parses HTML content using BeautifulSoup with lxml backend.

        Args:
            html_content: Raw HTML string.

        Returns:
            BeautifulSoup object.
        """
        return BeautifulSoup(html_content, "lxml")


class DiscoveryAdapter:
    """Base class for domain-specific DAAD catalog discovery adapters."""

    source_name: str = "generic"

    def parse_catalog_page(self, html_content: str, url: str) -> List[SourceModel]:
        """Parses a catalog webpage and returns discovered candidate sources.

        Args:
            html_content: HTML source.
            url: Page URL.

        Returns:
            List of candidate SourceModel instances.
        """
        links = ScrapingEngine.extract_links_selectolax(html_content, url)
        candidates: List[SourceModel] = []

        media_extensions = (".zip", ".tap", ".tzx", ".dsk", ".d64", ".d71", ".t64", ".prg", ".p00", ".cas", ".adf", ".adz", ".dms", ".msa", ".st")

        for link in links:
            lower_link = link.lower()
            role = "media" if lower_link.endswith(media_extensions) else "catalog"
            status = SourceStatus.PENDING if role == "media" else SourceStatus.CATALOGED

            candidates.append(
                SourceModel(
                    source_name=self.source_name,
                    url=link,
                    role=role,
                    status=status,
                    priority=20 if role == "media" else 80,
                    provenance_json={"discovered_from": url},
                )
            )
        return candidates


class SpectrumComputingAdapter(DiscoveryAdapter):
    """Adapter for Spectrum Computing DAAD release records."""
    source_name = "Spectrum Computing"


class Plus4WorldAdapter(DiscoveryAdapter):
    """Adapter for Plus/4 World releases."""
    source_name = "Plus/4 World"


class CSDbAdapter(DiscoveryAdapter):
    """Adapter for CSDb Commodore records."""
    source_name = "CSDb"


class InternetArchiveAdapter(DiscoveryAdapter):
    """Adapter for Internet Archive DAAD preservation collections."""
    source_name = "Internet Archive"
