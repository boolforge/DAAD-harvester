"""Known DAAD interpreter binary profiles.

Profiles are deliberately conservative.  A full SHA-256 match against an
officially distributed interpreter establishes an exact binary identity.  A
filename match is useful bundle evidence, but it is never presented as an
exact runtime version because users may have modified or repacked the binary.
"""

from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
from pathlib import Path
from typing import Iterable, Optional


@dataclass(frozen=True)
class InterpreterProfile:
    """A platform-specific DAAD interpreter identity anchor."""

    profile_id: str
    platform: str
    filenames: tuple[str, ...]
    sha256: Optional[str] = None
    interpreter_version: Optional[str] = None
    language: Optional[str] = None


# SHA-256 values are measured from the public official DAAD distribution at
# https://github.com/daad-adventure-writer/daad (master, inspected 2026-08-19).
# The profile IDs identify the *binary* rather than falsely asserting a full
# historical DAAD product release number that the binary itself does not expose.
OFFICIAL_INTERPRETER_PROFILES: tuple[InterpreterProfile, ...] = (
    InterpreterProfile(
        "daad-zx-ds48ie-official", "zx", ("ds48ie.p3f",),
        "d599b14576cb46f72b34b106f6ad1079cdf0d346ed9ac44e89db7dbd0c0eb3d6",
        language="en",
    ),
    InterpreterProfile(
        "daad-cpc-dcpcie-official", "cpc", ("dcpcie.z80",),
        "7447b56073a6e65242214c505496742346a35de0e81777ed91ea44a2f115ee41",
        language="en",
    ),
    InterpreterProfile(
        "daad-c64-edi64-official", "c64", ("edi64.prg",),
        "c462192db2a552f079aa7d521f3ae23a3d5c066120b42108a905085e923932c5",
        language="en",
    ),
    InterpreterProfile(
        "daad-plus4-ediplus4-official", "plus4", ("ediplus4.prg",),
        "9df2d6b35d5e138c80e3a38674afd565fe9564f27205d79d24d654d407949523",
        language="en",
    ),
    InterpreterProfile(
        "daad-msx-msxedi-official", "msx", ("msxedi.z80",),
        "1df91cff49dc2dcb42f2e4321644b6e088a0ac63159444bb937a9bff5848a4ca",
        language="en",
    ),
    InterpreterProfile(
        "daad-pcw-pcwedi-official", "pcw", ("pcwedi.bin",),
        "358eb0d236db0a2b43fdc66f843eb8e2eed097f77db24e195c14bae5fbb309a2",
        language="en",
    ),
    InterpreterProfile(
        "daad-atarist-edi1-official", "atarist", ("edi1.prg",),
        "ecc25e01611b1b3f2546c63b67220011f1793809cb177543030d5b626520c7fd",
        language="en",
    ),
    InterpreterProfile(
        "daad-dos-inte1-official", "dos", ("inte1.exe",),
        "1070941c6fa8e73a3b5357be72db97d1f1a6b48ab01fbe895470586ef3a47617",
        language="en",
    ),
    # The public bundle contains Amiga interpreter files inside an ADF image;
    # the filename profile becomes exact only after phase-4 ADF extraction.
    InterpreterProfile(
        "daad-amiga-edi-runtime", "amiga", ("edi1", "edi2", "edi1.prg", "edi2.prg"),
        language="en",
    ),
    # Conservative Spanish sibling filename evidence, intentionally without a
    # blanket hash/version claim until an exact payload profile is registered.
    InterpreterProfile("daad-zx-ds48is-runtime", "zx", ("ds48is.p3f",), language="es"),
    InterpreterProfile("daad-cpc-dcpcis-runtime", "cpc", ("dcpcis.z80",), language="es"),
    InterpreterProfile("daad-c64-sdi64-runtime", "c64", ("sdi64.prg",), language="es"),
    InterpreterProfile("daad-plus4-sdiplus4-runtime", "plus4", ("sdiplus4.prg",), language="es"),
    InterpreterProfile("daad-msx-msxsdi-runtime", "msx", ("msxsdi.z80",), language="es"),
    InterpreterProfile("daad-pcw-pcwsdi-runtime", "pcw", ("pcwsdi.bin",), language="es"),
    InterpreterProfile("daad-atarist-sdi-runtime", "atarist", ("sdi1.prg", "sdi2.prg"), language="es"),
    InterpreterProfile("daad-dos-ints-runtime", "dos", ("ints1.exe", "ints2.exe", "ints3.exe"), language="es"),
    InterpreterProfile("daad-amiga-sdi-runtime", "amiga", ("sdi1", "sdi2", "sdi1.prg", "sdi2.prg"), language="es"),
)


@dataclass(frozen=True)
class InterpreterMatch:
    """An observed interpreter candidate and the evidence that identified it."""

    profile_id: str
    platform: str
    confidence: str
    filename: str
    sha256: str
    interpreter_version: Optional[str]
    language: Optional[str]


def identify_interpreter_file(path: Path) -> Optional[InterpreterMatch]:
    """Identify one interpreter file by exact hash or conservative filename match."""

    if not path.is_file():
        return None
    filename = path.name.casefold()
    candidates = [profile for profile in OFFICIAL_INTERPRETER_PROFILES if filename in profile.filenames]
    if not candidates:
        return None
    digest = sha256(path.read_bytes()).hexdigest()
    for profile in candidates:
        if profile.sha256 and digest == profile.sha256:
            return InterpreterMatch(
                profile.profile_id, profile.platform, "verified", path.name, digest,
                profile.interpreter_version, profile.language,
            )
    profile = candidates[0]
    return InterpreterMatch(
        profile.profile_id, profile.platform, "strong", path.name, digest,
        profile.interpreter_version, profile.language,
    )


def identify_interpreters(paths: Iterable[Path]) -> list[InterpreterMatch]:
    """Return deterministic, de-duplicated interpreter observations for files."""

    found: dict[tuple[str, str], InterpreterMatch] = {}
    for path in paths:
        match = identify_interpreter_file(path)
        if match is not None:
            found[(match.profile_id, match.sha256)] = match
    return sorted(found.values(), key=lambda item: (item.platform, item.profile_id, item.filename))
