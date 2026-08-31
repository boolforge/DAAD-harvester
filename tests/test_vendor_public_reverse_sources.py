"""Tests for scripts/vendor_public_reverse_sources.py's should_copy() policy boundary.

Only should_copy() is tested here: main() requires real .audit/upstream-* workspace
checkouts of five external repositories, which this environment does not have and a
unit test should not fabricate. should_copy() is the one pure, self-contained
function -- and it is the exact policy this file's own docstring states ("Only
source, build, documentation, and license files are copied. Binary release payloads
are deliberately excluded"), so it is worth pinning down precisely.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))

from vendor_public_reverse_sources import should_copy  # noqa: E402


def test_should_copy_accepts_known_source_extensions():
    for name in ("main.c", "loader.asm", "build.sh", "config.yaml", "notes.md"):
        assert should_copy(Path(name)), name


def test_should_copy_is_case_insensitive_on_extension():
    assert should_copy(Path("Loader.ASM"))
    assert should_copy(Path("README.MD"))


def test_should_copy_accepts_license_and_readme_by_exact_name_regardless_of_extension():
    assert should_copy(Path("LICENSE"))
    assert should_copy(Path("License.txt"))
    assert should_copy(Path("COPYING"))
    assert should_copy(Path("Makefile"))


def test_should_copy_rejects_binary_and_unlisted_extensions():
    for name in ("game.ddb", "interpreter.exe", "sprite.bin", "archive.zip"):
        assert not should_copy(Path(name)), name


def test_should_copy_rejects_extensionless_files_not_on_the_allowlist():
    assert not should_copy(Path("Dockerfile"))
    assert not should_copy(Path("some-binary-tool"))
