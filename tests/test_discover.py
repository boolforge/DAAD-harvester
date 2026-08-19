import asyncio
from unittest.mock import AsyncMock, patch

import httpx
import pytest

from daad_harvester.db import Database
from daad_harvester.discover import Discoverer, RateLimiter
from daad_harvester.models import SourceTier


@pytest.mark.anyio
async def test_rate_limiter_allows_independent_domains_without_global_sleep():
    limiter = RateLimiter(rate_limit_per_second=10.0)
    start = asyncio.get_running_loop().time()
    await limiter.acquire("archive.example")
    await limiter.acquire("github.example")
    elapsed = asyncio.get_running_loop().time() - start

    assert elapsed < 0.05


@pytest.mark.anyio
async def test_rate_limiter_delays_second_request_to_the_same_domain():
    limiter = RateLimiter(rate_limit_per_second=10.0)
    start = asyncio.get_running_loop().time()
    await limiter.acquire("example.com")
    await limiter.acquire("example.com")
    elapsed = asyncio.get_running_loop().time() - start

    assert elapsed >= 0.05


def test_daad_relevance_filter_rejects_known_homonyms():
    assert Discoverer._is_daad_related("DAAD Ready game") is True
    assert Discoverer._is_daad_related("German-University-Courses-List", "DAAD scholarship data") is False
    assert Discoverer._is_daad_related("Koninklijke Met Raad en Daad") is False


def test_add_source_accepts_only_supported_direct_artifacts_and_deduplicates(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    assert discoverer._add_source("https://example.com/game.zip", SourceTier.ARCHIVE) is True
    assert discoverer._add_source("https://example.com/game.zip#fragment", SourceTier.ARCHIVE) is False
    assert discoverer._add_source("https://example.com/game-page", SourceTier.ARCHIVE) is False
    assert discoverer._add_source("https://example.com/index.html", SourceTier.ARCHIVE) is False

    pending = db.get_pending_sources()
    assert [source.url for source in pending] == ["https://example.com/game.zip"]


@pytest.mark.anyio
async def test_discover_internet_archive_uses_metadata_files_and_filters_homonyms(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    search_result = {
        "response": {
            "docs": [
                {"identifier": "daad-game", "title": "La Aventura Original (Aventuras AD)"},
                {"identifier": "homonym", "title": "Koninklijke Met Raad en Daad"},
            ]
        }
    }
    metadata_result = {
        "files": [
            {"name": "Aventura.d64"},
            {"name": "screenshot.jpg"},
        ]
    }

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.side_effect = [search_result, metadata_result, search_result, metadata_result, search_result, metadata_result]
        async with httpx.AsyncClient() as client:
            inserted = await discoverer.discover_internet_archive(client)

    assert inserted == 1
    pending = db.get_pending_sources()
    assert len(pending) == 1
    assert pending[0].url == "https://archive.org/download/daad-game/Aventura.d64"
    assert all("homonym" not in call.args[1] for call in mock_fetch.call_args_list[1:])


@pytest.mark.anyio
async def test_discoverer_github_uses_each_repos_own_default_branch_and_filters_homonyms(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    mock_json = {
        "items": [
            {
                "name": "daadminer",
                "description": "a DAAD tool",
                "owner": {"login": "haseebcheema"},
                "default_branch": "master",
            },
            {
                "name": "NextDAAD",
                "description": "DAAD Ready games",
                "owner": {"login": "absent42"},
                "default_branch": "main",
            },
            {
                "name": "German-University-Courses-List",
                "description": "A dataset of German university courses",
                "owner": {"login": "abrarum"},
                "default_branch": "main",
            },
        ]
    }

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.return_value = mock_json
        async with httpx.AsyncClient() as client:
            inserted = await discoverer.discover_github(client)

    urls = {source.url for source in db.get_pending_sources()}
    assert inserted == 2
    assert "https://github.com/haseebcheema/daadminer/archive/refs/heads/master.zip" in urls
    assert "https://github.com/absent42/NextDAAD/archive/refs/heads/main.zip" in urls
    assert not any("German-University" in url for url in urls)
    assert len(mock_fetch.call_args_list) == 5


@pytest.mark.anyio
async def test_discover_zxinfo_uses_documented_search_endpoint_and_download_host(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    response = {
        "hits": {
            "hits": [
                {
                    "_source": {
                        "title": "A Case of Murder",
                        "authoredWith": [{"title": "DAAD"}],
                        "releases": [
                            {"files": [{"path": "/zxdb/sinclair/entries/0042546/Case.tap.zip"}]}
                        ],
                    }
                },
                {
                    "_source": {
                        "title": "Unrelated game",
                        "releases": [{"files": [{"path": "/zxdb/nope.zip"}]}],
                    }
                },
            ]
        }
    }

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.return_value = response
        async with httpx.AsyncClient() as client:
            inserted = await discoverer.discover_zxdb(client)

    urls = {source.url for source in db.get_pending_sources()}
    assert inserted == 1
    assert urls == {"https://spectrumcomputing.co.uk/zxdb/sinclair/entries/0042546/Case.tap.zip"}
    requested_urls = [call.args[1] for call in mock_fetch.call_args_list]
    assert all("/v3/search?" in url for url in requested_urls)
    assert all("query=" in url and "contenttype=SOFTWARE" in url for url in requested_urls)
    assert all("/games/search" not in url for url in requested_urls)


def test_zxinfo_file_iterator_excludes_other_authoring_engines():
    hits = [
        {
            "_source": {
                "title": "A DAAD game",
                "releases": [
                    {
                        "files": [
                            {"path": "/zxdb/daad-game.tap.zip"},
                            {"path": "/zxdb/daad-game-paws.tap.zip"},
                            {"path": "/zxdb/daad-game.z80.zip"},
                        ]
                    }
                ],
            }
        }
    ]

    assert list(Discoverer._iter_zxinfo_files(hits)) == [("A DAAD game", "/zxdb/daad-game.tap.zip")]


@pytest.mark.anyio
async def test_discover_ifarchive_is_explicitly_skipped_without_a_daad_index(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    async with httpx.AsyncClient() as client:
        inserted = await discoverer.discover_ifarchive(client)

    assert inserted == 0
    assert db.get_all_sources() == []


@pytest.mark.anyio
async def test_web_search_uses_current_result_selector_and_only_direct_files(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    html = """
    <a class="result__a" href="https://duckduckgo.com/l/?uddg=https%3A%2F%2Fexample.com%2Fdaad.zip">DAAD ZIP</a>
    <a class="result__a" href="https://duckduckgo.com/l/?uddg=https%3A%2F%2Fexample.com%2Fgame-page">DAAD page</a>
    """

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.return_value = html
        async with httpx.AsyncClient() as client:
            inserted = await discoverer.discover_web_search(client)

    assert inserted == 1
    assert [source.url for source in db.get_pending_sources()] == ["https://example.com/daad.zip"]


@pytest.mark.anyio
async def test_itchio_does_not_request_root_account_pages(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    listing = """
    <a href="https://itch.io/login">Log in</a>
    <a href="https://maker.itch.io/daad-game">A DAAD game</a>
    """
    game_page = "<a href=\"/daad-game/purchase\">Download now</a>"

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.side_effect = [listing, game_page, listing, game_page, listing, game_page]
        async with httpx.AsyncClient() as client:
            inserted = await discoverer.discover_itchio(client)

    requested_urls = [call.args[1] for call in mock_fetch.call_args_list]
    assert inserted == 0
    assert "https://itch.io/login" not in requested_urls


@pytest.mark.anyio
async def test_run_all_discovery_wires_proxy_into_client_and_logs_adapter_exceptions(tmp_path, monkeypatch):
    from daad_harvester.config import settings

    monkeypatch.setattr(settings, "proxy_list", ["http://proxy.example:8080"])
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    captured_kwargs = {}
    real_async_client = httpx.AsyncClient

    class RecordingClient(real_async_client):
        def __init__(self, *args, **kwargs):
            captured_kwargs.update(kwargs)
            super().__init__(*args, **kwargs)

    no_op_methods = {
        name: AsyncMock(return_value=0)
        for name in [
            "discover_internet_archive", "discover_aminet", "discover_csdb",
            "discover_plus4world", "discover_generation_msx", "discover_computeremuzone", "discover_atarimania",
            "discover_github", "discover_itchio", "discover_ifdb", "discover_zxdb",
            "discover_wikicaad", "discover_world_of_spectrum", "discover_ifarchive", "discover_web_search",
        ]
    }
    with patch.multiple(discoverer, **no_op_methods), patch.object(discoverer, "load_canonical_seeds"), patch(
        "daad_harvester.discover.httpx.AsyncClient", RecordingClient
    ):
        await discoverer.run_all_discovery()

    assert captured_kwargs.get("proxy") == "http://proxy.example:8080"


def test_canonical_seed_catalog_is_empty_until_urls_are_verified(tmp_path):
    """A clean run must not enqueue speculative URLs before live discovery."""
    from daad_harvester.seeds import CANONICAL_DAAD_SEEDS

    assert CANONICAL_DAAD_SEEDS == []
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)

    assert discoverer.load_canonical_seeds() == 0
    assert db.get_all_sources() == []


@pytest.mark.anyio
async def test_discover_world_of_spectrum_uses_publisher_catalog_and_verified_detail_pages(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    publisher_html = """
    <a href="/archive/software/text-adventures/la-aventura-original-aventuras-ad-sa">La Aventura Original</a>
    <a href="/archive/software/games/unrelated">Unrelated game</a>
    """
    daad_detail_html = """
    <p>Comments: Authored with DAAD.</p>
    <a href="/pub/sinclair/games/a/AventuraOriginalLa.tzx.zip">TZX archive</a>
    <a href="/pub/sinclair/games/a/AventuraOriginalLa.z80.zip">Snapshot archive</a>
    <a href="https://www.rzxarchive.co.uk/a/aventuraoriginal.zip">External RZX archive</a>
    <a href="/pub/sinclair/screens/a/AventuraOriginalLa.scr">Screenshot</a>
    """

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.side_effect = [publisher_html, daad_detail_html]
        async with httpx.AsyncClient() as client:
            inserted = await discoverer.discover_world_of_spectrum(client)

    assert inserted == 1
    sources = db.get_pending_sources()
    assert len(sources) == 1
    assert sources[0].url == "https://worldofspectrum.org/pub/sinclair/games/a/AventuraOriginalLa.tzx.zip"
    assert sources[0].title == "La Aventura Original"
    assert sources[0].platform == "zx"


@pytest.mark.parametrize(
    ("metadata", "expected"),
    [
        ({"collection": ["softwarelibrary_sinclair_zx_spectrum"]}, "zx"),
        ({"collection": ["softwarelibrary_cpc_games"]}, "cpc"),
        ({"emulator": "vice-c64"}, "c64"),
        ({"collection": ["softwarelibrary_commodore_plus4"]}, "plus4"),
        ({"collection": ["softwarelibrary_msx"]}, "msx"),
        ({"collection": ["softwarelibrary_pcw"]}, "pcw"),
        ({"collection": ["softwarelibrary_atari_st"]}, "atarist"),
        ({"collection": ["softwarelibrary_amiga"]}, "amiga"),
        ({"collection": ["softwarelibrary_dos"]}, "dos"),
    ],
)
def test_internet_archive_platform_metadata_covers_all_official_targets(metadata, expected):
    assert Discoverer._platform_from_archive_metadata(metadata) == expected


@pytest.mark.anyio
async def test_internet_archive_cpc_metadata_preserves_platform_without_special_priority(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    search_result = {
        "response": {
            "docs": [
                {
                    "identifier": "chichen-cpc",
                    "title": "Ci-U-Than Trilogy III Chichen Itza (Aventuras AD)",
                }
            ]
        }
    }
    metadata_result = {
        "metadata": {"collection": ["softwarelibrary_cpc_games"], "emulator": "cpc6128"},
        "files": [{"name": "ChichenItza.dsk"}],
    }

    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.side_effect = [search_result, metadata_result] * 3
        async with httpx.AsyncClient() as client:
            inserted = await discoverer.discover_internet_archive(client)

    assert inserted == 1
    source = db.get_pending_sources()[0]
    assert source.known_game_id == "chichen_itza"
    assert source.platform == "cpc"
    assert source.acquisition_priority == 1000


@pytest.mark.anyio
async def test_csdb_accepts_vetted_download_endpoint_with_visible_d64_name(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    html = """
    <h1>The Revenge of Moriarty (DAAD) v1.1</h1>
    <a href="/release/download.php?id=226938">The_Revenge_of_Moriarty.d64</a>
    <a href="/release/download.php?id=233510">Solution.txt</a>
    """
    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock, return_value=html):
        async with httpx.AsyncClient() as client:
            assert await discoverer.discover_csdb(client) == 1
    source = db.get_all_sources()[0]
    assert source.platform == "c64"
    assert source.source_name == "CSDb"
    assert source.source_role == "game_media"
    assert source.source_record_url == "https://csdb.dk/search/?search=daad"
    assert source.url.endswith("release/download.php?id=226938")


@pytest.mark.anyio
async def test_plus4world_records_catalog_page_and_direct_prg_with_provenance(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    search_html = '<a href="/software/EightFeetUnder">Eight Feet Under</a>'
    detail_html = """
    <h1>Eight Feet Under</h1><p>DAAD adventure for Commodore Plus/4.</p>
    <a href="https://downloads.example/EightFeetUnder.prg">EightFeetUnder.prg</a>
    """
    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.side_effect = [search_html, detail_html]
        async with httpx.AsyncClient() as client:
            assert await discoverer.discover_plus4world(client) == 2
    sources = db.get_all_sources()
    catalog = next(item for item in sources if item.source_role == "release_catalog")
    media = next(item for item in sources if item.source_role == "game_media")
    assert catalog.status == "cataloged"
    assert catalog.platform == "plus4"
    assert media.platform == "plus4"
    assert media.url.endswith(".prg")


@pytest.mark.anyio
async def test_computeremuzone_catalogs_badged_endpoints_without_queuing_blocked_downloads(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    html = """
    <table><tr>
      <td><a href="/ficha/36/la-aventura-espacial?l=en">La Aventura Espacial</a></td>
      <td><a href="/download.php?ind=858">SP</a>
          <a href="/download.php?ind=286">AMS</a>
          <a href="/download.php?ind=991">C64</a>
          <a href="/download.php?ind=287">MSX</a>
          <a href="/download.php?ind=181">ST</a>
          <a href="/download.php?ind=650">AG</a>
          <a href="/download.php?ind=228">PC</a></td>
    </tr></table>
    """
    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock, return_value=html):
        async with httpx.AsyncClient() as client:
            assert await discoverer.discover_computeremuzone(client) == 7
    sources = db.get_all_sources()
    assert {source.platform for source in sources} == {"zx", "cpc", "c64", "msx", "atarist", "amiga", "dos"}
    assert all(source.source_name == "Computer Emuzone" for source in sources)
    assert all(source.status == "cataloged" for source in sources)
    assert all(source.source_role == "release_catalog" for source in sources)
    assert all(source.source_record_url == source.url for source in sources)
    assert {source.source_release_id for source in sources} == {"858", "286", "991", "287", "181", "650", "228"}


@pytest.mark.anyio
async def test_generation_msx_and_atarimania_remain_catalog_only(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    msx_html = '<a href="/software/aventuras-ad/chichen-itza/release/2097/">Chichen Itza</a>'
    st_html = '<h1>La Aventura Espacial</h1><p>Written with DAAD Adventure Writer.</p>'
    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.side_effect = [msx_html, st_html, None, None, None]
        async with httpx.AsyncClient() as client:
            assert await discoverer.discover_generation_msx(client) == 1
            assert await discoverer.discover_atarimania(client) == 1
    sources = db.get_all_sources()
    assert {(source.platform, source.status, source.source_name) for source in sources} == {
        ("msx", "cataloged", "Generation MSX"),
        ("atarist", "cataloged", "Atarimania"),
    }


@pytest.mark.anyio
async def test_aminet_is_retained_as_amiga_tool_provenance_not_download_work(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    html = '<a href="/package/game/role/daad-runtime">DAAD Amiga interpreter</a>'
    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock, return_value=html):
        async with httpx.AsyncClient() as client:
            assert await discoverer.discover_aminet(client) == 1
    source = db.get_all_sources()[0]
    assert source.status == "cataloged"
    assert source.platform == "amiga"
    assert source.source_role == "tool_distribution"
    assert source.toolchain_claim == "DAAD runtime/package"


@pytest.mark.anyio
async def test_itchio_records_all_explicit_platform_claims_without_queuing_purchase_page(tmp_path):
    db = Database(tmp_path / "test.db")
    discoverer = Discoverer(db)
    listing = '<a href="https://maker.itch.io/eight-feet-under">Eight Feet Under</a>'
    page = """
    <h1>Eight Feet Under</h1><p>DAAD Release R6 for ZX Spectrum, Amstrad CPC,
    Commodore 64, Commodore Plus/4, MSX, Amstrad PCW, Atari ST, Amiga and MS-DOS.</p>
    <a href="/eight-feet-under/purchase">Download now</a>
    """
    with patch.object(discoverer, "_fetch_url", new_callable=AsyncMock) as mock_fetch:
        mock_fetch.side_effect = [listing, page, listing, page, listing, page]
        async with httpx.AsyncClient() as client:
            assert await discoverer.discover_itchio(client) == 1
    source = db.get_all_sources()[0]
    assert source.status == "cataloged"
    assert source.release_version == "6"
    evidence = db.get_version_evidence(source_id=source.id)
    platforms = {item.value for item in evidence if item.kind == "platform_release"}
    assert platforms == {"zx", "cpc", "c64", "plus4", "msx", "pcw", "atarist", "amiga", "dos"}
