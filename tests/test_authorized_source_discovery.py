from scripts import discover_authorized_candidate_sources as discovery


def candidate() -> dict[str, str]:
    return {
        "candidate_key": "diosa de cozumel, la|aventuras a.d.|1990|spanish",
        "title": "Diosa de Cozumel, La",
        "publisher": "Aventuras A.D.",
        "year": "1990",
        "language": "Spanish",
    }


def test_title_only_archive_match_is_not_promoted(monkeypatch) -> None:
    def fake_fetch(url: str, timeout: int = 20) -> dict:
        if "advancedsearch" in url:
            return {"response": {"docs": [{"identifier": "framed-2004", "title": "Diosa de Cozumel, La"}]}}
        return {
            "metadata": {"identifier": "framed-2004", "title": "Diosa de Cozumel, La", "year": "2004", "creator": "Someone Else"},
            "files": [{"name": "game.adf", "sha1": "abc"}],
        }

    monkeypatch.setattr(discovery, "fetch_json", fake_fetch)
    boundary, title_only = discovery.matching_direct_files(candidate())
    assert boundary == []
    assert len(title_only) == 1
    assert title_only[0]["release_boundary_match"] is False


def test_matching_year_and_publisher_promotes_binary_source(monkeypatch) -> None:
    def fake_fetch(url: str, timeout: int = 20) -> dict:
        if "advancedsearch" in url:
            return {"response": {"docs": [{"identifier": "diosa-1990", "title": "Diosa de Cozumel, La"}]}}
        return {
            "metadata": {"identifier": "diosa-1990", "title": "Diosa de Cozumel, La", "year": "1990", "creator": "Aventuras A.D."},
            "files": [{"name": "diosa.adf", "sha1": "abc", "md5": "def"}, {"name": "metadata.xml"}],
        }

    monkeypatch.setattr(discovery, "fetch_json", fake_fetch)
    boundary, title_only = discovery.matching_direct_files(candidate())
    assert len(boundary) == 1
    assert title_only == []
    assert boundary[0]["filename"] == "diosa.adf"
    assert boundary[0]["archive_sha1"] == "abc"


def test_discovery_requires_institutional_policy() -> None:
    queue = {"discovery_required": [candidate()]}
    policy = {"authorization_state": "unapproved"}
    try:
        discovery.discover(queue, policy, workers=1)
    except ValueError as error:
        assert "Global authorization policy rejected" in str(error)
    else:
        raise AssertionError("Expected unauthorized policy to fail closed")
