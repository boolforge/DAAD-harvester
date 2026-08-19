"""Evidence-backed DAAD game catalog used to prioritize acquisition.

The catalog separates source-backed statements from properties that must be
measured from an actual binary. In particular, a title being made with DAAD
does not prove a specific compiler or interpreter build for every platform
release. `engine_version_evidence` is therefore deliberately explicit about
that boundary.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, Iterable, Optional, Tuple
import re
import unicodedata


WIKICAAD_DAAD_URL = "https://wiki.caad.es/DAAD"
COMPUTER_EMUZONE_DAAD_URL = "https://computeremuzone.com/engine/daad?l=en"
CASA_AVENTURA_ORIGINAL_URL = "https://solutionarchive.com/game/id%2C2148/Aventura+Original%2C+La.html"
CASA_CHICHEN_ITZA_URL = "https://solutionarchive.com/game/id%2C2602/Chichen+Itza.html"
CPC_POWER_CHICHEN_ITZA_URL = "https://www.cpc-power.com/index.php?page=detail&num=549"


@dataclass(frozen=True)
class KnownGame:
    """A canonical title with only externally supported historical facts."""

    game_id: str
    title: str
    aliases: Tuple[str, ...]
    year: int
    publisher: str
    engine_family: str
    engine_version_evidence: str
    platforms: Tuple[str, ...]
    evidence_urls: Tuple[str, ...]
    notes: str = ""


def normalize_title(value: Optional[str]) -> str:
    """Normalize human title variants without relying on source-specific slugs."""
    normalized = unicodedata.normalize("NFKD", value or "")
    normalized = "".join(ch for ch in normalized if not unicodedata.combining(ch))
    normalized = normalized.casefold().replace("&", " and ")
    normalized = re.sub(r"[^a-z0-9]+", " ", normalized)
    return " ".join(normalized.split())


KNOWN_GAMES: Tuple[KnownGame, ...] = (
    KnownGame(
        game_id="la_aventura_original",
        title="La Aventura Original",
        aliases=("Aventura Original, La", "The Original Adventure"),
        year=1989,
        publisher="Aventuras AD",
        engine_family="DAAD",
        engine_version_evidence="Exact commercial DAAD build unverified; fingerprint a platform payload before claiming a version.",
        platforms=("zx", "cpc", "c64", "msx", "atarist", "amiga", "pc"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL, CASA_AVENTURA_ORIGINAL_URL),
    ),
    KnownGame(
        game_id="jabato",
        title="Jabato",
        aliases=("El Jabato",),
        year=1989,
        publisher="Aventuras AD",
        engine_family="DAAD",
        engine_version_evidence="Exact commercial DAAD build unverified; fingerprint a platform payload before claiming a version.",
        platforms=("zx", "cpc", "c64", "msx", "atarist", "amiga", "pc"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL),
    ),
    KnownGame(
        game_id="cozumel",
        title="Cozumel",
        aliases=("La Diosa de Cozumel", "Diosa de Cozumel, La", "Ci-U-Than Trilogy I"),
        year=1990,
        publisher="Aventuras AD",
        engine_family="DAAD",
        engine_version_evidence="Exact commercial DAAD build unverified; fingerprint a platform payload before claiming a version.",
        platforms=("zx", "cpc", "c64", "msx", "pcw", "atarist", "amiga", "pc"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL),
    ),
    KnownGame(
        game_id="la_aventura_espacial",
        title="La Aventura Espacial",
        aliases=("Aventura Espacial, La",),
        year=1990,
        publisher="Aventuras AD",
        engine_family="DAAD",
        engine_version_evidence="Exact commercial DAAD build unverified; fingerprint a platform payload before claiming a version.",
        platforms=("zx", "cpc", "c64", "msx", "pcw", "atarist", "amiga", "pc"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL),
    ),
    KnownGame(
        game_id="los_templos_sagrados",
        title="Los Templos Sagrados",
        aliases=("Templos Sagrados, Los", "Ci-U-Than Trilogy II"),
        year=1991,
        publisher="Aventuras AD",
        engine_family="DAAD",
        engine_version_evidence="Exact commercial DAAD build unverified; fingerprint a platform payload before claiming a version.",
        platforms=("zx", "cpc", "c64", "msx", "pcw", "atarist", "amiga", "pc"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL),
    ),
    KnownGame(
        game_id="chichen_itza",
        title="Chichén Itzá",
        aliases=("Chichen Itza", "Ci-U-Than Trilogy III"),
        year=1992,
        publisher="Aventuras AD",
        engine_family="DAAD",
        engine_version_evidence="Exact commercial DAAD build unverified; fingerprint a platform payload before claiming a version.",
        platforms=("zx", "cpc", "c64", "msx", "atarist", "amiga", "pc"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL, CASA_CHICHEN_ITZA_URL, CPC_POWER_CHICHEN_ITZA_URL),
        notes="CPC Power also records a dated 1991-10-14 CPC master variant; this is release evidence, not a DAAD compiler-version claim.",
    ),
)


_GAME_BY_NORMALIZED_TITLE: Dict[str, KnownGame] = {
    normalize_title(name): game
    for game in KNOWN_GAMES
    for name in (game.title, *game.aliases)
}


def find_known_game(title: Optional[str]) -> Optional[KnownGame]:
    """Return the catalog entry for an exact canonical or alias title match."""
    return _GAME_BY_NORMALIZED_TITLE.get(normalize_title(title))


def acquisition_priority(game: Optional[KnownGame], platform: Optional[str]) -> int:
    """Prioritize proven historical titles and fill the CPC evidence gap first.

    Priority is an acquisition ordering value, not a quality or historical
    importance score. Unknown sources remain eligible and receive zero.
    """
    if not game:
        return 0
    if platform == "cpc":
        return 1200
    if platform in game.platforms:
        return 1000
    return 900


def iter_known_games() -> Iterable[KnownGame]:
    """Expose the catalog without allowing callers to mutate its container."""
    return iter(KNOWN_GAMES)
