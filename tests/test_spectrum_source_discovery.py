from scripts import discover_spectrum_computing_sources as spectrum


def candidate() -> dict[str, str]:
    return {
        "candidate_key": "behind closed doors|zenobi software|1988|english",
        "title": "Behind Closed Doors",
        "publisher": "Zenobi Software",
        "year": "1988",
        "language": "English",
    }


def entry_html(*, publisher: str = "Zenobi Software (UK)", year: str = "1988") -> str:
    return f"""
    <html><body>
      <div>Title: Behind Closed Doors Release Date: {year} Original Publisher: {publisher} Creators: John Wilson</div>
      <div>Message Language: English Machine Type: ZX-Spectrum 48K</div>
      <p>Games may only be downloaded for personal usage and are not to be offered to third parties.</p>
      <a href="/pub/sinclair/games/b/BehindClosedDoors.tzx.zip">TZX</a>
      <a href="/pub/sinclair/screens/b/BehindClosedDoors.scr">screenshot</a>
    </body></html>
    """


def test_fetch_html_retries_transient_archive_error(monkeypatch) -> None:
    calls = {"count": 0}

    class Response:
        def __enter__(self):
            return self

        def __exit__(self, *args):
            return False

        def read(self) -> bytes:
            return b"<html>ok</html>"

    def fake_urlopen(request, timeout):
        calls["count"] += 1
        if calls["count"] == 1:
            raise TimeoutError("temporary")
        return Response()

    monkeypatch.setattr(spectrum, "urlopen", fake_urlopen)
    monkeypatch.setattr(spectrum.time, "sleep", lambda seconds: None)
    assert spectrum.fetch_html("https://example.test") == "<html>ok</html>"
    assert calls["count"] == 2


def test_entry_inspection_accepts_exact_release_identity(monkeypatch) -> None:
    monkeypatch.setattr(spectrum, "fetch_html", lambda url: entry_html())
    records = spectrum.inspect_entry(candidate(), "https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors")
    assert len(records) == 1
    assert records[0]["filename"] == "BehindClosedDoors.tzx.zip"
    assert records[0]["source_release_id"] == "5998"
    assert records[0]["release_boundary_evidence"]["publisher"] == "Zenobi Software (UK)"
    assert records[0]["external_source_terms"] == "personal_usage_only_no_third_party_offering"


def test_year_matches_accepts_release_month_but_rejects_other_year() -> None:
    assert spectrum.year_matches("2020", "2020/Apr")
    assert spectrum.year_matches("2020", "2020")
    assert not spectrum.year_matches("2020", "2019/Dec")


def test_title_matches_accepts_documented_subtitle_but_not_numeric_sequel() -> None:
    assert spectrum.title_matches("Behind Closed Doors 8", "Behind Closed Doors 8 - The Pandemic")
    assert spectrum.title_matches("Behind Closed Doors 7", "Behind Closed Doors 7: Happiness is a Warm Pussy")
    assert not spectrum.title_matches("Behind Closed Doors", "Behind Closed Doors 2: The Sequel")


def test_entry_inspection_rejects_identity_mismatch(monkeypatch) -> None:
    monkeypatch.setattr(spectrum, "fetch_html", lambda url: entry_html(year="1989"))
    assert spectrum.inspect_entry(candidate(), "https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors") == []


def test_direct_game_downloads_accepts_current_zxdb_game_path() -> None:
    soup = spectrum.BeautifulSoup('<a href="/zxdb/sinclair/entries/0035686/BehindClosedDoors8-ThePandemic.tap.zip">TAP</a>', "html.parser")
    assert spectrum.direct_game_downloads(soup) == [{
        "source_url": "https://spectrumcomputing.co.uk/zxdb/sinclair/entries/0035686/BehindClosedDoors8-ThePandemic.tap.zip",
        "filename": "BehindClosedDoors8-ThePandemic.tap.zip",
    }]


def test_direct_game_downloads_excludes_non_game_media() -> None:
    soup = spectrum.BeautifulSoup(entry_html(), "html.parser")
    assert spectrum.direct_game_downloads(soup) == [{
        "source_url": "https://spectrumcomputing.co.uk/pub/sinclair/games/b/BehindClosedDoors.tzx.zip",
        "filename": "BehindClosedDoors.tzx.zip",
    }]


def test_linked_spectrum_entry_is_used_without_a_title_search(monkeypatch) -> None:
    linked_candidate = {
        **candidate(),
        "catalog_source_url": "https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors",
        "catalog_platform": "ZX-Spectrum",
    }
    searched: list[str] = []
    monkeypatch.setattr(spectrum, "fetch_html", lambda url: entry_html())
    monkeypatch.setattr(spectrum, "search_entry_urls", lambda title: searched.append(title) or [])

    result = spectrum.discover_candidate(linked_candidate)

    assert result["status"] == "release_boundary_source_discovered"
    assert len(result["matches"]) == 1
    assert searched == []


def test_unknown_language_is_not_inferred_but_can_retain_observed_source_evidence(monkeypatch) -> None:
    unknown_language_candidate = {**candidate(), "language": "Unknown"}
    monkeypatch.setattr(spectrum, "fetch_html", lambda url: entry_html())

    records = spectrum.inspect_entry(
        unknown_language_candidate,
        "https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors",
    )

    assert records[0]["release_boundary_evidence"]["language"] == "English"


def test_spectrum_next_catalog_path_is_explicitly_outside_zx_adapter_scope() -> None:
    next_candidate = {**candidate(), "catalog_platform": "ZX-Spectrum_Next"}

    result = spectrum.discover_candidate(next_candidate)

    assert result["status"] == "unsupported_catalog_platform_path"
    assert result["matches"] == []


def test_discovery_snapshot_accepts_a_fixed_capture_epoch(monkeypatch) -> None:
    monkeypatch.setattr(
        spectrum,
        "discover_candidate",
        lambda item: {**item, "status": "no_release_boundary_source_match", "matches": []},
    )
    queue = {"discovery_required": [candidate()]}
    policy = {
        "authorization_state": "institutional_authorized",
        "directive": "docs/reverse_engineering/AUTHORIZATION_AND_HANDLING.md",
        "scope": "acquire_retain_execute_analyze_publish",
    }

    result = spectrum.discover(queue, policy, workers=1, generated_at_epoch=1_787_378_470)

    assert result["generated_at_epoch"] == 1_787_378_470
    assert result["input_candidate_count"] == 1
