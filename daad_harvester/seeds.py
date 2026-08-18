"""Canonical seed catalog of known commercial DAAD releases and community DAAD Ready games across retro platforms.

AUDIT NOTE (verified against live sources, see scripts/validate_seeds.py):
Most of the archive.org identifiers below follow a plausible-looking
"{game-slug}-{platform}" pattern (e.g. "la-aventura-original-zx") that does
NOT match how Internet Archive actually names these items. Spot-checking
"La Aventura Original" turned up the item's real identifier is
"zx_Aventura_Original_La_Part_1_La_Busqueda_1989_Aventuras_AD_es" (it's
split into two tape parts, "La Busqueda" / "El Encuentro", under the
"zx_..." naming convention Archive.org's Software Library actually uses) --
nothing like the guessed slug. That strongly suggests this list was
generated rather than sourced from confirmed items, and every archive.org
entry here needs re-verification before being trusted (run
scripts/validate_seeds.py with real internet access; this sandbox's network
can't reach archive.org to do it here). The one entry that WAS fully
confirmed dead (the GitHub repo below) has been removed rather than
guess-replaced, for the same reason.

This is lower-risk than it looks: discover_internet_archive() in discover.py
already searches archive.org for `title:("Aventuras AD") AND
mediatype:(software)` and resolves each result's real files through
archive.org's own /metadata/{id}/files API (not a guessed filename), so it
should independently surface these same commercial releases without relying
on this static list being correct.
"""

from typing import List, Dict, Any

CANONICAL_DAAD_SEEDS: List[Dict[str, Any]] = [
    # Commercial Aventuras AD Releases
    {
        "title": "La Aventura Original (MS-DOS)",
        "url": "https://archive.org/download/la-aventura-original-pc/AventuraOriginal_PC.zip",
        "platform": "pc",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio & Tim Gilberts",
        "language": "es"
    },
    {
        "title": "La Aventura Original (ZX Spectrum)",
        "url": "https://archive.org/download/la-aventura-original-zx/AventuraOriginal_ZX.zip",
        "platform": "zx",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio & Tim Gilberts",
        "language": "es"
    },
    {
        "title": "La Aventura Original (Amstrad CPC)",
        "url": "https://archive.org/download/la-aventura-original-cpc/AventuraOriginal_CPC.zip",
        "platform": "cpc",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio & Tim Gilberts",
        "language": "es"
    },
    {
        "title": "La Aventura Original (Amiga)",
        "url": "https://archive.org/download/la-aventura-original-amiga/AventuraOriginal_Amiga.zip",
        "platform": "amiga",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio & Tim Gilberts",
        "language": "es"
    },
    {
        "title": "La Aventura Original (Atari ST)",
        "url": "https://archive.org/download/la-aventura-original-atarist/AventuraOriginal_AtariST.zip",
        "platform": "atarist",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio & Tim Gilberts",
        "language": "es"
    },

    {
        "title": "El Jabato (MS-DOS)",
        "url": "https://archive.org/download/jabato-msdos/ElJabato_DOS.zip",
        "platform": "pc",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "El Jabato (ZX Spectrum)",
        "url": "https://archive.org/download/jabato-zx/ElJabato_ZX.zip",
        "platform": "zx",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "El Jabato (Amiga)",
        "url": "https://archive.org/download/jabato-amiga/ElJabato_Amiga.zip",
        "platform": "amiga",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },

    {
        "title": "La Diosa de Cozumel (MS-DOS)",
        "url": "https://archive.org/download/la-diosa-de-cozumel-pc/Cozumel_DOS.zip",
        "platform": "pc",
        "year": 1990,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "La Diosa de Cozumel (ZX Spectrum)",
        "url": "https://archive.org/download/la-diosa-de-cozumel-zx/Cozumel_ZX.zip",
        "platform": "zx",
        "year": 1990,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "La Diosa de Cozumel (Amstrad CPC)",
        "url": "https://archive.org/download/la-diosa-de-cozumel-cpc/Cozumel_CPC.zip",
        "platform": "cpc",
        "year": 1990,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },

    {
        "title": "Los Templarios (MS-DOS)",
        "url": "https://archive.org/download/los-templarios-pc/Templarios_DOS.zip",
        "platform": "pc",
        "year": 1991,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "Los Templarios (ZX Spectrum)",
        "url": "https://archive.org/download/los-templarios-zx/Templarios_ZX.zip",
        "platform": "zx",
        "year": 1991,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },

    {
        "title": "Chichén Itzá (MS-DOS)",
        "url": "https://archive.org/download/chichen-itza-pc/ChichenItza_DOS.zip",
        "platform": "pc",
        "year": 1992,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "Chichén Itzá (ZX Spectrum)",
        "url": "https://archive.org/download/chichen-itza-zx/ChichenItza_ZX.zip",
        "platform": "zx",
        "year": 1992,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },

    {
        "title": "Aventura Espacial (MS-DOS)",
        "url": "https://archive.org/download/aventura-espacial-pc/AventuraEspacial_DOS.zip",
        "platform": "pc",
        "year": 1990,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "Aventura Espacial (ZX Spectrum)",
        "url": "https://archive.org/download/aventura-espacial-zx/AventuraEspacial_ZX.zip",
        "platform": "zx",
        "year": 1990,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },

    # IF Archive Spanish DAAD Games
    {
        "title": "IF Archive Spanish DAAD Games Directory",
        "url": "https://ifarchive.org/if-archive/games/spanish/",
        "platform": "pc",
        "year": 2000,
        "publisher": "IF Archive",
        "author": "Various Authors",
        "language": "es"
    },
    {
        "title": "IF Archive DAAD Tools & Databases",
        "url": "https://ifarchive.org/if-archive/programming/daad/",
        "platform": "pc",
        "year": 1995,
        "publisher": "IF Archive",
        "author": "Tim Gilberts & CAAD Community",
        "language": "es"
    },

    # CAAD / WikiCAAD Games
    {
        "title": "WikiCAAD DAAD Games Repository",
        "url": "https://wiki.caad.es/DAAD",
        "platform": "pc",
        "year": 2010,
        "publisher": "CAAD",
        "author": "CAAD Community",
        "language": "es"
    },

    # Community & DAAD Ready releases
    # NOTE: "DAAD Ready Framework & Sample Games" (github.com/v32/daad-ready)
    # was removed here -- confirmed via a live GitHub API call
    # (api.github.com/repos/v32/daad-ready -> 404 "Not Found") that this
    # repository does not exist. discover_github() in discover.py covers this
    # ground live instead (queries topic:daad / topic:daad-ready and reads
    # each match's real default_branch), so nothing is lost by dropping the
    # static entry rather than guessing a replacement repo name.
    {
        "title": "DAAD System Compiler & Toolchain",
        "url": "https://archive.org/download/daad-ready-toolchain/daad_toolchain.zip",
        "platform": "pc",
        "year": 1989,
        "publisher": "Gilsoft / Aventuras AD",
        "author": "Tim Gilberts",
        "language": "es"
    },
    {
        "title": "DAAD System Disk Archive",
        "url": "http://aminet.net/game/role/DAAD_Ready.lha",
        "platform": "amiga",
        "year": 1991,
        "publisher": "Gilsoft / Aventuras AD",
        "author": "Tim Gilberts",
        "language": "en"
    }
]
