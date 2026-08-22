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


def test_entry_inspection_accepts_exact_release_identity(monkeypatch) -> None:
    monkeypatch.setattr(spectrum, "fetch_html", lambda url: entry_html())
    records = spectrum.inspect_entry(candidate(), "https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors")
    assert len(records) == 1
    assert records[0]["filename"] == "BehindClosedDoors.tzx.zip"
    assert records[0]["source_release_id"] == "5998"
    assert records[0]["release_boundary_evidence"]["publisher"] == "Zenobi Software (UK)"
    assert records[0]["external_source_terms"] == "personal_usage_only_no_third_party_offering"


def test_entry_inspection_rejects_identity_mismatch(monkeypatch) -> None:
    monkeypatch.setattr(spectrum, "fetch_html", lambda url: entry_html(year="1989"))
    assert spectrum.inspect_entry(candidate(), "https://spectrumcomputing.co.uk/entry/5998/ZX-Spectrum/Behind_Closed_Doors") == []


def test_direct_game_downloads_excludes_non_game_media() -> None:
    soup = spectrum.BeautifulSoup(entry_html(), "html.parser")
    assert spectrum.direct_game_downloads(soup) == [{
        "source_url": "https://spectrumcomputing.co.uk/pub/sinclair/games/b/BehindClosedDoors.tzx.zip",
        "filename": "BehindClosedDoors.tzx.zip",
    }]
