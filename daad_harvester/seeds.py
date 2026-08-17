"""Canonical seed catalog of known commercial DAAD releases and community DAAD Ready games across retro platforms."""

from typing import List, Dict, Any

CANONICAL_DAAD_SEEDS: List[Dict[str, Any]] = [
    # Commercial Aventuras AD releases across ZX Spectrum, Amstrad CPC, C64, Amiga, Atari ST, MS-DOS, MSX
    {
        "title": "La Aventura Original",
        "url": "https://archive.org/download/la-aventura-original-pc/AventuraOriginal_PC.zip",
        "platform": "pc",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio & Tim Gilberts",
        "language": "es"
    },
    {
        "title": "La Aventura Original (Spectrum)",
        "url": "https://archive.org/download/la-aventura-original-zx/AventuraOriginal_ZX.zip",
        "platform": "zx",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio & Tim Gilberts",
        "language": "es"
    },
    {
        "title": "El Jabato",
        "url": "https://archive.org/download/jabato-msdos/ElJabato_DOS.zip",
        "platform": "pc",
        "year": 1989,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "La Diosa de Cozumel",
        "url": "https://archive.org/download/la-diosa-de-cozumel-pc/Cozumel_DOS.zip",
        "platform": "pc",
        "year": 1990,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "Los Templarios",
        "url": "https://archive.org/download/los-templarios-pc/Templarios_DOS.zip",
        "platform": "pc",
        "year": 1991,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "Chichén Itzá",
        "url": "https://archive.org/download/chichen-itza-pc/ChichenItza_DOS.zip",
        "platform": "pc",
        "year": 1992,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },
    {
        "title": "Aventura Espacial",
        "url": "https://archive.org/download/aventura-espacial-pc/AventuraEspacial_DOS.zip",
        "platform": "pc",
        "year": 1990,
        "publisher": "Aventuras AD",
        "author": "Andrés Samudio",
        "language": "es"
    },

    # Community & DAAD Ready releases
    {
        "title": "DAAD Ready Framework & Sample Games",
        "url": "https://github.com/v32/daad-ready/archive/refs/heads/master.zip",
        "platform": "pc",
        "year": 2021,
        "publisher": "DAAD Ready Community",
        "author": "Urbano / Tim Gilberts",
        "language": "es"
    },
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
