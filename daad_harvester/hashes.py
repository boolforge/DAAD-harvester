"""Streaming digests for retained evidence files."""

from __future__ import annotations

import hashlib
from pathlib import Path


DEFAULT_BLOCK_SIZE = 1024 * 1024


def sha256_file(path: Path, *, block_size: int = DEFAULT_BLOCK_SIZE) -> str:
    """Return a SHA-256 digest using bounded memory.

    The caller owns existence and repository-boundary validation. A positive block
    size is required so malformed callers cannot silently alter the streaming
    contract or create a nonterminating read loop.
    """

    if block_size <= 0:
        raise ValueError("block_size must be positive")
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(block_size), b""):
            digest.update(block)
    return digest.hexdigest()
