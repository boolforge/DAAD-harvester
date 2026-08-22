from __future__ import annotations

import hashlib
from pathlib import Path

import pytest

from daad_harvester.hashes import sha256_file


def test_sha256_file_matches_standard_digest_across_small_blocks(tmp_path: Path) -> None:
    path = tmp_path / "evidence.bin"
    payload = (b"DAAD-harvester\x00" * 97) + b"tail"
    path.write_bytes(payload)

    assert sha256_file(path, block_size=7) == hashlib.sha256(payload).hexdigest()


def test_sha256_file_rejects_nonpositive_block_sizes(tmp_path: Path) -> None:
    path = tmp_path / "evidence.bin"
    path.write_bytes(b"evidence")

    with pytest.raises(ValueError, match="positive"):
        sha256_file(path, block_size=0)
