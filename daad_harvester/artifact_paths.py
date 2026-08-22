"""Portable resolution of retained artifact paths stored by earlier checkouts."""

from __future__ import annotations

from pathlib import Path


PRESERVATION_CORPUS = "preservation_corpus"


def resolve_retained_artifact_path(stored_path: str, repository_root: Path) -> Path:
    """Resolve a retained artifact from its recorded path in the current checkout.

    Artifact rows historically retained absolute paths. A clean checkout commonly
    has a different parent directory, so an existing relative suffix rooted at
    ``preservation_corpus`` is reconstructed under ``repository_root``. Direct
    paths remain supported when they already exist. The fallback never resolves a
    path outside the current repository and never accepts a missing file.
    """

    recorded = Path(stored_path)
    if recorded.is_file():
        return recorded
    parts = recorded.parts
    try:
        corpus_index = parts.index(PRESERVATION_CORPUS)
    except ValueError as error:
        raise ValueError(f"retained artifact path lacks {PRESERVATION_CORPUS!r}: {stored_path}") from error
    root = repository_root.resolve()
    candidate = (root / Path(*parts[corpus_index:])).resolve()
    if root not in candidate.parents or not candidate.is_file():
        raise ValueError(f"retained artifact bytes are unavailable: {candidate}")
    return candidate
