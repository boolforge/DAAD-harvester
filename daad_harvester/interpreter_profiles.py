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
# https://github.com/daad-adventure-writer/daad revision
# 4a7e745235a12af5b397902dbd9214bc930c7680 (inspected 2026-08-19).
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
    # Historical Plus/4 disk releases conventionally store the runtime without
    # an extension. This name was observed in a real public release, but it is
    # deliberately only qualified filename evidence until an exact hash anchor
    # can be measured from an official historical distribution.
    InterpreterProfile("daad-plus4-ediplus4-historical", "plus4", ("ediplus4",)),
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
    InterpreterProfile("daad-amiga-edi1-official", "amiga", ("edi1", "edi1.prg"), "5f3bd8275d500d44fc41d7ae2a77e86593bd7075b6ad9fffde639265c0990952", language="en"),
    InterpreterProfile("daad-amiga-edi2-official", "amiga", ("edi2", "edi2.prg"), "6926ca43824c00098dcb6267a639aede2ae0640b2640be03fa9a1be965f37664", language="en"),
    InterpreterProfile("daad-amiga-sdi1-official", "amiga", ("sdi1", "sdi1.prg"), "105c27fc80bcb9183409d9774792a8486ec34207d9a29e21efc53e475558c7f7", language="es"),
    InterpreterProfile("daad-amiga-sdi2-official", "amiga", ("sdi2", "sdi2.prg"), "e083dcd70726c97204404fa48eea9db49d839a6af4218408c4d40520dd8ec338", language="es"),
    InterpreterProfile("daad-zx-ds48is-official", "zx", ("ds48is.p3f",), "e1e0f8ab8e2907eebeb24ada1bf2bb2d27b0622972239827eeb70f56ff5e0566", language="es"),
    InterpreterProfile("daad-cpc-dcpcis-official", "cpc", ("dcpcis.z80",), "8d312860b4ce8596b9f6152c1fbc0aa5f3525189daa564dc413bf3173a19659c", language="es"),
    InterpreterProfile("daad-c64-sdi64-official", "c64", ("sdi64.prg",), "767aa97d411ea025d20e25282ae0ac90360b4fb99af01392c38d2721aa7033ec", language="es"),
    InterpreterProfile("daad-plus4-sdiplus4-official", "plus4", ("sdiplus4.prg",), "f29050dfe9331634b985a8c5b8cb4ee3b164a4340e355c044284168b8610258c", language="es"),
    InterpreterProfile("daad-msx-msxsdi-official", "msx", ("msxsdi.z80",), "fcae12bd09bc949e1e6cf75b3d1ef87e66c322efe2de005e771fa3b5dd8ddbf8", language="es"),
    InterpreterProfile("daad-pcw-pcwsdi-official", "pcw", ("pcwsdi.bin",), "e52e2a8cc9e720805c7c6c7f8fe9fd706933c73696e695d7c1132063d4e52a7d", language="es"),
    InterpreterProfile("daad-atarist-edi2-official", "atarist", ("edi2.prg",), "6e1c18327066ead24985d6b9033353f16ca7e70e39863af5320d933194b38a72", language="en"),
    InterpreterProfile("daad-atarist-sdi1-official", "atarist", ("sdi1.prg",), "35a0c10701e59739e1bf7e701e1e1aa7f5bb5112f79445e8038be0502360a9f2", language="es"),
    InterpreterProfile("daad-atarist-sdi2-official", "atarist", ("sdi2.prg",), "04ac433d70777dc15434ec5d7c7002f28b30bc8f1f3ed5c0eef01ea6c245a9b1", language="es"),
    InterpreterProfile("daad-dos-inte2-official", "dos", ("inte2.exe",), "4cb3a608f331c20402ab1ad3c13968e86f3c909dc1ebad31d7a3e3b50312837f", language="en"),
    InterpreterProfile("daad-dos-inte3-official", "dos", ("inte3.exe",), "ea2494b657626db967f36d608b8cabe9ab82832f5d38266c8f1b6e40b9eb7aa3", language="en"),
    InterpreterProfile("daad-dos-intecga1-official", "dos", ("intecga1.exe",), "665ed57b5ad4b4168a70cc11634159081fc4f1f7ab57b49c75245755efb261c7", language="en"),
    InterpreterProfile("daad-dos-intecga2-official", "dos", ("intecga2.exe",), "ddc34e84977308c3f592d304473d8398c84b4d70666f0c35aed74e3b88b76d6d", language="en"),
    InterpreterProfile("daad-dos-intecga3-official", "dos", ("intecga3.exe",), "bdaaafe615ec073d81757e81504b3ffbed337a9bd4729d0aff203a4cbabadb4a", language="en"),
    InterpreterProfile("daad-dos-inted-official", "dos", ("inted.exe",), "d683e9c9a023e9996d811aa1a803bcc98d0fb3c91055f68ad3ceca4a59d1f9c9", language="en"),
    InterpreterProfile("daad-dos-intedm-official", "dos", ("intedm.exe",), "3e0d786ce8abdd3225af8f290a19fb3b9ba2fdc32106b401b6c7028e3e5065e1", language="en"),
    InterpreterProfile("daad-dos-intem1-official", "dos", ("intem1.exe",), "6b50665f29c1024cbad8fe7ee5be42e0eb3ad49e1db8071119bf0e9e1ed57594", language="en"),
    InterpreterProfile("daad-dos-intem2-official", "dos", ("intem2.exe",), "2ca22c899432c1ab0d96418961f91638ffd3438a8cf4e8f69b8f9419a0dec765", language="en"),
    InterpreterProfile("daad-dos-intem3-official", "dos", ("intem3.exe",), "a430e15fe634157eae3fc45324787a3e6b79fa15814cb98e709c71407d55c5fc", language="en"),
    InterpreterProfile("daad-dos-ints1-official", "dos", ("ints1.exe",), "af5a3b732f53ee75042715f618e8a3daec77833491b8582d428ad2ba203129b5", language="es"),
    InterpreterProfile("daad-dos-ints2-official", "dos", ("ints2.exe",), "39d7d99a40d77f466e648ded927b3c02bdef779411f7151ca51219be360a6455", language="es"),
    InterpreterProfile("daad-dos-ints3-official", "dos", ("ints3.exe",), "fef8c5eabf256094da57dae6787884243ca3dec98dbe7a3c7438c93509903de3", language="es"),
    InterpreterProfile("daad-dos-intscga1-official", "dos", ("intscga1.exe",), "bd36734b7909453a3784dfd9f819ba505a82df21f973a9992e58bec58f1e6191", language="es"),
    InterpreterProfile("daad-dos-intscga2-official", "dos", ("intscga2.exe",), "c478647bba2a3330c89c4233d3b51ba36d6357d7d7d30c7fe270287eab9034e6", language="es"),
    InterpreterProfile("daad-dos-intscga3-official", "dos", ("intscga3.exe",), "6a8f60d5dcbf5e650934eb452ddfd215325bc5a02fdaf3b9ddf4937afb765cb9", language="es"),
    InterpreterProfile("daad-dos-intsd-official", "dos", ("intsd.exe",), "797fcca14224a71cd03a02f476d12513f1d360921b24db2502544841b90a0567", language="es"),
    InterpreterProfile("daad-dos-intsdm-official", "dos", ("intsdm.exe",), "3a8187daf5ab46d3b6deaba955128477e13b5d62713e06f607fa040273514937", language="es"),
    InterpreterProfile("daad-dos-intsm1-official", "dos", ("intsm1.exe",), "b17f78e22dd71961a21eb94e7afbd85cc1ec104e3860339f40d1e1877db5be51", language="es"),
    InterpreterProfile("daad-dos-intsm2-official", "dos", ("intsm2.exe",), "27531111a82e9f5f62c6eae7efcc03175542a5ffe6f8d85677e88b3d4db16dab", language="es"),
    InterpreterProfile("daad-dos-intsm3-official", "dos", ("intsm3.exe",), "54baa0b227cd2c1849c90d6727de130c58cda3a8c0d8c2f8adf50585d3246f01", language="es"),
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


def identify_interpreter_file(path: Path, *, observed_filename: Optional[str] = None) -> Optional[InterpreterMatch]:
    """Identify one interpreter by actual bytes and its preserved media filename.

    Unpackers prefix stored paths with depth/hash information to prevent
    collisions. `observed_filename` therefore carries the original member name
    when it differs from the storage filename; the SHA-256 is always computed
    from the supplied physical path.
    """

    if not path.is_file():
        return None
    filename = (observed_filename or path.name).casefold()
    candidates = [profile for profile in OFFICIAL_INTERPRETER_PROFILES if filename in profile.filenames]
    digest = sha256(path.read_bytes()).hexdigest()
    # An immutable full-byte match is an identity claim in its own right.  This
    # handles documented package aliases (for example an MSX disk member named
    # DAAD.Z80) without borrowing a different platform's filename convention.
    exact_profiles = [
        profile for profile in OFFICIAL_INTERPRETER_PROFILES
        if profile.sha256 and digest == profile.sha256
    ]
    if len(exact_profiles) == 1:
        profile = exact_profiles[0]
        return InterpreterMatch(
            profile.profile_id, profile.platform, "verified", path.name, digest,
            profile.interpreter_version, profile.language,
        )
    if not candidates:
        return None
    candidate_platforms = {profile.platform for profile in candidates}
    # A historical filename alias may carry a byte-identical official runtime.
    # Resolve that only through an exact same-platform profile hash, never from
    # a cross-platform or text/filename resemblance.
    for profile in OFFICIAL_INTERPRETER_PROFILES:
        if (
            profile.platform in candidate_platforms
            and profile.sha256
            and digest == profile.sha256
        ):
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
