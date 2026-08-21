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

from daad_harvester.provenance import normalize_platform


WIKICAAD_DAAD_URL = "https://wiki.caad.es/DAAD"
COMPUTER_EMUZONE_DAAD_URL = "https://computeremuzone.com/engine/daad?l=en"
CASA_AVENTURA_ORIGINAL_URL = "https://solutionarchive.com/game/id%2C2148/Aventura+Original%2C+La.html"
CASA_CHICHEN_ITZA_URL = "https://solutionarchive.com/game/id%2C2602/Chichen+Itza.html"
CPC_POWER_CHICHEN_ITZA_URL = "https://www.cpc-power.com/index.php?page=detail&num=549"
EIGHT_FEET_UNDER_URL = "https://8bitgames.itch.io/eight-feet-under"
CSDB_REVENGE_OF_MORIARTY_URL = "https://csdb.dk/release/?id=182937"
TORREOSCURA_PUBLISHER_DOWNLOADS_URL = "https://zonafi.es/torreoscura/descargas_eng.html"


@dataclass(frozen=True)
class KnownGame:
    """A canonical title with only externally supported historical facts."""

    game_id: str
    title: str
    aliases: Tuple[str, ...]
    year: Optional[int]
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
        platforms=("zx", "cpc", "c64", "msx", "atarist", "amiga", "dos"),
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
        platforms=("zx", "cpc", "c64", "msx", "atarist", "amiga", "dos"),
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
        platforms=("zx", "cpc", "c64", "msx", "pcw", "atarist", "amiga", "dos"),
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
        platforms=("zx", "cpc", "c64", "msx", "pcw", "atarist", "amiga", "dos"),
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
        platforms=("zx", "cpc", "c64", "msx", "pcw", "atarist", "amiga", "dos"),
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
        platforms=("zx", "cpc", "c64", "msx", "atarist", "amiga", "dos"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL, CASA_CHICHEN_ITZA_URL, CPC_POWER_CHICHEN_ITZA_URL),
        notes="CPC Power also records a dated 1991-10-14 CPC master variant; this is release evidence, not a DAAD compiler-version claim.",
    ),
    KnownGame(
        game_id="las_aventuras_de_rudolphine_rur",
        title="Las Aventuras de Rudolphine Rur",
        aliases=("Aventuras de Rudolphine Rur, Las",),
        year=2005,
        publisher="Dwalin",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; exact DDB/interpreter build must be measured from the platform artifact.",
        platforms=("zx", "cpc", "c64", "msx", "pcw", "atarist", "amiga", "dos"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL),
    ),
    KnownGame(
        game_id="beltalowda",
        title="Beltalowda",
        aliases=(),
        year=2025,
        publisher="molisoft",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; no compiler/interpreter version is catalog-asserted.",
        platforms=("zx",),
        evidence_urls=(COMPUTER_EMUZONE_DAAD_URL,),
    ),
    KnownGame(
        game_id="cero_absoluto",
        title="Cero Absoluto",
        aliases=(),
        year=2016,
        publisher="ESP Soft Adventure",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; no compiler/interpreter version is catalog-asserted.",
        platforms=("cpc",),
        evidence_urls=(COMPUTER_EMUZONE_DAAD_URL,),
    ),
    KnownGame(
        game_id="el_chico_de_los_recados",
        title="El Chico de los Recados",
        aliases=("The Errand Boy", "Chico de los Recados, El"),
        year=2021,
        publisher="Dwalin",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; exact DDB/interpreter build must be measured per language/platform edition.",
        platforms=("zx", "cpc", "msx", "dos"),
        evidence_urls=(WIKICAAD_DAAD_URL, COMPUTER_EMUZONE_DAAD_URL),
    ),
    KnownGame(
        game_id="el_misterio_de_la_isla_de_tokland",
        title="El Misterio de la Isla de Tökland",
        aliases=("El Misterio de la Isla de Tokland",),
        year=2015,
        publisher="ESP Soft Adventure",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; no compiler/interpreter version is catalog-asserted.",
        platforms=("cpc",),
        evidence_urls=(COMPUTER_EMUZONE_DAAD_URL,),
    ),
    KnownGame(
        game_id="nutca",
        title="Nutca",
        aliases=(),
        year=2023,
        publisher="Pulsa una Tecla",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; no compiler/interpreter version is catalog-asserted.",
        platforms=("zx",),
        evidence_urls=(COMPUTER_EMUZONE_DAAD_URL,),
    ),
    KnownGame(
        game_id="torreoscura",
        title="Torreoscura",
        aliases=(),
        year=2020,
        publisher="Commodore Plus",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; exact DDB/interpreter build must be measured from each release.",
        platforms=("zx", "cpc", "c64", "msx", "pcw", "dos"),
        evidence_urls=(COMPUTER_EMUZONE_DAAD_URL, TORREOSCURA_PUBLISHER_DOWNLOADS_URL),
    ),
    KnownGame(
        game_id="venganza_la_sierva_de_la_muerte",
        title="Venganza: La Sierva de la Muerte",
        aliases=("Venganza La Sierva de la Muerte", "Revenge"),
        year=2019,
        publisher="Physical Dreams",
        engine_family="DAAD",
        engine_version_evidence="DAAD engine-family evidence; no compiler/interpreter version is catalog-asserted.",
        platforms=("zx", "c64", "msx"),
        evidence_urls=(COMPUTER_EMUZONE_DAAD_URL,),
    ),
    KnownGame(
        game_id="eight_feet_under",
        title="Eight Feet Under - A Hibernated 1 Addon",
        aliases=("Eight Feet Under",),
        year=2019,
        publisher="Stefan Vogt / Pond Software Ltd.",
        engine_family="DAAD Adventure Writer",
        engine_version_evidence="Publisher states DAAD Adventure Writer. The documented R6 label is a game-release revision, not a DDB or interpreter version.",
        platforms=("zx", "cpc", "c64", "plus4", "msx", "atarist", "amiga", "dos"),
        evidence_urls=(EIGHT_FEET_UNDER_URL,),
        notes="Publisher download labels explicitly identify R6 packages for each listed platform; PCW is not claimed.",
    ),
    KnownGame(
        game_id="the_revenge_of_moriarty",
        title="The Revenge of Moriarty",
        aliases=("The Revenge of Moriarty (DAAD)", "The Revenge of Moriarty +DS"),
        year=2019,
        publisher="Unattributed original / Laxity preservation release",
        engine_family="DAAD",
        engine_version_evidence="CSDb's v1.1 label is a release/AKA label; it is not treated as a DAAD interpreter version.",
        platforms=("c64",),
        evidence_urls=(CSDB_REVENGE_OF_MORIARTY_URL,),
    ),
    KnownGame(
        game_id="los_elfos_de_maroland",
        title="Los Elfos de Maroland",
        aliases=("Los Elfos de Maroland - remake",),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="el_hobbit",
        title="El Hobbit",
        aliases=(),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="la_estrella_de_la_manana",
        title="La Estrella de la Mañana",
        aliases=("La Estrella de la Manana",),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="el_cetro_del_sol",
        title="El Cetro del Sol",
        aliases=(),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="tantalos",
        title="Tantalos",
        aliases=(),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="elf",
        title="Elf",
        aliases=(),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="mystery_city",
        title="Mystery City",
        aliases=(),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="en_busca_del_parser_perdido",
        title="En Busca del Parser Perdido",
        aliases=(),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="dona_elisa_de_avalon",
        title="Doña Elisa de Avalón",
        aliases=("Dona Elisa de Avalon",),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="golden_seas",
        title="Golden Seas",
        aliases=(),
        year=None,
        publisher="SunTeam",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="kings_ransom",
        title="King's Ransom",
        aliases=("Kings Ransom",),
        year=None,
        publisher="SunTeam",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="rite_of_the_druid",
        title="Rite of the Druid",
        aliases=(),
        year=None,
        publisher="Unattributed in WikiCAAD",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="the_mystery_of_markham_manor",
        title="The Mystery of Markham Manor",
        aliases=(),
        year=None,
        publisher="Taskmaster Software",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
    KnownGame(
        game_id="the_dragnet_case",
        title="The Dragnet Case",
        aliases=(),
        year=None,
        publisher="Taskmaster Software",
        engine_family="DAAD",
        engine_version_evidence="WikiCAAD engine-family evidence only; platform and binary version remain unmeasured.",
        platforms=(),
        evidence_urls=(WIKICAAD_DAAD_URL,),
    ),
)


_GAME_BY_NORMALIZED_TITLE: Dict[str, KnownGame] = {
    normalize_title(name): game
    for game in KNOWN_GAMES
    for name in (game.title, *game.aliases)
}


def find_known_game(title: Optional[str]) -> Optional[KnownGame]:
    """Return a catalog entry for an exact or unambiguous embedded title match.

    Archive titles often add a series name, year, publisher, language, or dump
    label around a canonical game name. Matching a complete canonical/alias
    token sequence handles that common structure without falling back to a
    broad fuzzy search.
    """
    normalized = normalize_title(title)
    exact = _GAME_BY_NORMALIZED_TITLE.get(normalized)
    if exact:
        return exact

    candidates = {
        game.game_id: game
        for name, game in _GAME_BY_NORMALIZED_TITLE.items()
        if len(name) >= 6 and f" {name} " in f" {normalized} "
    }
    return next(iter(candidates.values())) if len(candidates) == 1 else None


def acquisition_priority(game: Optional[KnownGame], platform: Optional[str]) -> int:
    """Prioritize evidence-backed releases without privileging one platform.

    Priority is an acquisition ordering value, not a quality or historical
    importance score. A known title with a source-confirmed target receives
    the same baseline on every official DAAD platform; source-specific evidence
    strength is applied by discovery adapters in a later stage.
    """
    if not game:
        return 0
    canonical_platform = normalize_platform(platform) or platform
    if canonical_platform in game.platforms:
        return 1000
    return 900


def iter_known_games() -> Iterable[KnownGame]:
    """Expose the catalog without allowing callers to mutate its container."""
    return iter(KNOWN_GAMES)
