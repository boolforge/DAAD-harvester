"""Regression coverage for deterministic Pages documentation rendering."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "build_pages_docs.py"


def test_pages_documentation_builder_renders_and_rewrites_markdown_links(tmp_path: Path) -> None:
    source_root = tmp_path / "source"
    docs = source_root / "docs"
    docs.mkdir(parents=True)
    (source_root / "README.md").write_text("# Root guide\n\nRead [format](docs/format.md).\n", encoding="utf-8")
    (source_root / "TODO.md").write_text("# Active work\n\n- [ ] Preserve evidence\n", encoding="utf-8")
    (docs / "format.md").write_text("# Format contract\n\n| Field | Value |\n| --- | --- |\n| Status | measured |\n", encoding="utf-8")
    output_root = tmp_path / "public" / "documentation"

    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--source-root", str(source_root), "--output-dir", str(output_root)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stdout + result.stderr
    assert "Published 3 Markdown documents" in result.stdout
    assert (output_root / "index.html").is_file()
    rendered_root = (output_root / "README.html").read_text(encoding="utf-8")
    assert 'href="docs/format.html"' in rendered_root
    assert "Root guide" in rendered_root
    rendered_format = (output_root / "docs" / "format.html").read_text(encoding="utf-8")
    assert "<table>" in rendered_format
