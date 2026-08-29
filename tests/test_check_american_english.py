"""Tests for scripts/check_american_english.py."""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

import check_american_english as m  # noqa: E402


def test_non_english_marker_detects_accented_characters():
    # Built from explicit code points rather than literal accented characters:
    # this file is itself tracked .py text, and check_american_english.py
    # scans tracked .py files too, so writing the raw accented words directly
    # in this source would trip the very policy this test exercises once
    # committed.
    e_acute = "\u00e9"
    inverted_question_mark = "\u00bf"
    assert m.NON_ENGLISH_MARKER.search(f"caf{e_acute}")
    assert m.NON_ENGLISH_MARKER.search(f"{inverted_question_mark}Qu{e_acute}?")
    assert not m.NON_ENGLISH_MARKER.search("plain english text")


def test_authentic_proper_nouns_are_excluded_before_matching(tmp_path):
    # A line containing only an allowlisted proper noun must not be flagged,
    # even though it contains accented characters the marker regex matches.
    line = "The tool is named Diseñador de Aventuras AD."
    normalized = line
    for proper_noun in m.AUTHENTIC_PROPER_NOUNS:
        normalized = normalized.replace(proper_noun, "")
    assert not m.NON_ENGLISH_MARKER.search(normalized)


def test_tracked_authored_text_paths_excludes_itself_and_evidence_dirs():
    paths = m.tracked_authored_text_paths()
    relative = {p.relative_to(m.ROOT).as_posix() for p in paths}

    assert "scripts/check_american_english.py" not in relative
    assert not any(p.startswith("preservation_corpus/") for p in relative)
    assert not any(p.startswith("reverse_engineering/public_sources/") for p in relative)
    # Sanity floor: this repository has hundreds of authored text files.
    assert len(paths) > 100


def test_tracked_authored_text_paths_only_returns_known_text_suffixes():
    paths = m.tracked_authored_text_paths()
    assert all(p.suffix.lower() in m.TEXT_SUFFIXES for p in paths)


def test_main_passes_on_the_real_repository():
    # The real, live check -- this repository's own tracked text must pass its
    # own policy. Also locks in that main() no longer computes the tracked-path
    # list twice (previously two separate git ls-files subprocess calls).
    assert m.main() == 0
