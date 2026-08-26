"""Tests for daad_harvester.extract.discover.

The link-resolution tests below are regression tests: the original version of
extract_links_selectolax hand-rolled URL joining instead of using urllib.parse.urljoin,
and silently mishandled protocol-relative links ("//cdn.example.com/x") and "../"
relative paths -- both real patterns on the older, less-standardized retro-computing
sites this tool targets.
"""
from daad_harvester.extract.discover import DiscoveryAdapter, ScrapingEngine
from daad_harvester.transform.models import SourceStatus


def test_absolute_links_pass_through():
    html = '<a href="https://example.com/game.zip">game</a>'
    links = ScrapingEngine.extract_links_selectolax(html, "https://source.example/index.html")
    assert links == ["https://example.com/game.zip"]


def test_protocol_relative_link_resolves_to_correct_domain():
    html = '<a href="//cdn.example.com/game.zip">game</a>'
    links = ScrapingEngine.extract_links_selectolax(html, "https://source.example/index.html")
    assert links == ["https://cdn.example.com/game.zip"]


def test_root_relative_link_resolves_against_source_domain():
    html = '<a href="/downloads/game.zip">game</a>'
    links = ScrapingEngine.extract_links_selectolax(html, "https://source.example/catalog/index.html")
    assert links == ["https://source.example/downloads/game.zip"]


def test_relative_link_resolves_against_current_directory():
    html = '<a href="game.zip">game</a>'
    links = ScrapingEngine.extract_links_selectolax(html, "https://source.example/catalog/index.html")
    assert links == ["https://source.example/catalog/game.zip"]


def test_parent_relative_link_resolves_dot_dot_segments():
    html = '<a href="../archive/game.zip">game</a>'
    links = ScrapingEngine.extract_links_selectolax(html, "https://source.example/catalog/sub/index.html")
    # A naive rsplit-based join would produce ".../catalog/sub/../archive/game.zip"
    # with the ".." segment left unresolved; urljoin collapses it correctly.
    assert links == ["https://source.example/catalog/archive/game.zip"]


def test_excluded_href_schemes_are_skipped():
    html = """
    <a href="javascript:void(0)">js</a>
    <a href="mailto:test@example.com">mail</a>
    <a href="#section">anchor</a>
    <a href="/real.zip">real</a>
    """
    links = ScrapingEngine.extract_links_selectolax(html, "https://source.example/")
    assert links == ["https://source.example/real.zip"]


def test_discovery_adapter_classifies_media_vs_catalog_links():
    html = """
    <a href="/catalog/page2.html">next</a>
    <a href="/downloads/game.tzx">download</a>
    """
    adapter = DiscoveryAdapter()
    adapter.source_name = "Test Source"
    candidates = adapter.parse_catalog_page(html, "https://source.example/catalog/page1.html")

    by_url = {c.url: c for c in candidates}
    media = by_url["https://source.example/downloads/game.tzx"]
    catalog = by_url["https://source.example/catalog/page2.html"]

    assert media.role == "media"
    assert media.status == SourceStatus.PENDING
    assert media.priority == 20

    assert catalog.role == "catalog"
    assert catalog.status == SourceStatus.CATALOGED
    assert catalog.priority == 80
