"""Render versioned project Markdown into a self-contained GitHub Pages document site."""

from __future__ import annotations

import argparse
import html
from pathlib import Path
from typing import Sequence
from urllib.parse import urldefrag

from bs4 import BeautifulSoup
from markdown import markdown


ROOT = Path(__file__).resolve().parents[1]
DOCUMENTATION_DIRNAME = "documentation"

PAGE_STYLE = """
:root { color-scheme: dark; font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace; }
* { box-sizing: border-box; }
body { margin: 0; background: #0a0f0e; color: #e3eadf; line-height: 1.65; }
header { border-bottom: 1px solid #38463a; background: #101714; padding: 1rem clamp(1rem, 4vw, 4rem); }
header a { color: #c9ff5b; text-decoration: none; font-weight: 700; letter-spacing: .04em; }
main { max-width: 1100px; margin: 0 auto; padding: clamp(1.25rem, 5vw, 4rem); }
h1, h2, h3 { color: #f4f7ed; line-height: 1.2; margin-top: 2.2rem; }
h1 { font-size: clamp(2rem, 5vw, 3.4rem); border-bottom: 2px solid #c9ff5b; padding-bottom: .5rem; }
h2 { color: #c9ff5b; font-size: clamp(1.4rem, 3vw, 2rem); }
a { color: #c9ff5b; text-decoration-thickness: 1px; text-underline-offset: .2em; }
code, pre { background: #131c18; border: 1px solid #364538; border-radius: .35rem; }
code { padding: .1rem .3rem; }
pre { overflow-x: auto; padding: 1rem; }
pre code { border: 0; padding: 0; }
table { width: 100%; border-collapse: collapse; margin: 1.5rem 0; display: block; overflow-x: auto; }
th { color: #c9ff5b; text-align: left; background: #111915; }
th, td { border: 1px solid #364538; padding: .7rem; vertical-align: top; }
blockquote { border-left: 4px solid #c9ff5b; margin: 1.5rem 0; padding: .2rem 1rem; background: #111915; }
.lede { color: #b9c7ba; max-width: 75ch; }
.document-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(18rem, 1fr)); gap: 1rem; list-style: none; padding: 0; }
.document-list a { display: block; min-height: 8rem; padding: 1rem; border: 1px solid #475b4a; background: #101714; text-decoration: none; transition: background .16s ease-out, transform .16s ease-out; }
.document-list a:hover, .document-list a:focus-visible { background: #172219; transform: translateY(-2px); outline: 2px solid #c9ff5b; outline-offset: 2px; }
.document-list small { display: block; color: #b9c7ba; margin-top: .55rem; }
footer { border-top: 1px solid #38463a; color: #b9c7ba; margin-top: 4rem; padding-top: 1rem; font-size: .9rem; }
"""


def source_documents(source_root: Path) -> list[Path]:
    """Return every maintained public Markdown document in a stable order."""

    documents = [source_root / "README.md", source_root / "TODO.md"]
    docs_root = source_root / "docs"
    documents.extend(sorted(docs_root.rglob("*.md")))
    return [path for path in documents if path.is_file()]


def output_path(source: Path, source_root: Path, output_root: Path) -> Path:
    """Map a Markdown source path into the published documentation tree."""

    return output_root / source.relative_to(source_root).with_suffix(".html")


def title_for(source: Path) -> str:
    """Use the first Markdown level-one heading, falling back to the filename."""

    for line in source.read_text(encoding="utf-8").splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return source.stem.replace("_", " ")


def rewrite_markdown_links(rendered: str) -> str:
    """Keep repository-relative document links working after `.md` becomes `.html`."""

    soup = BeautifulSoup(rendered, "html.parser")
    for anchor in soup.find_all("a", href=True):
        href = str(anchor["href"])
        path, fragment = urldefrag(href)
        if path.lower().endswith(".md"):
            rewritten = f"{path[:-3]}.html"
            anchor["href"] = f"{rewritten}#{fragment}" if fragment else rewritten
    return str(soup)


def page_shell(*, title: str, body: str, index_href: str) -> str:
    """Build a standalone accessible document page with no runtime dependency."""

    escaped_title = html.escape(title)
    return f"""<!doctype html>
<html lang=\"en\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><title>{escaped_title} — DAAD Harvester</title><style>{PAGE_STYLE}</style></head>
<body><header><a href=\"{index_href}\">DAAD HARVESTER / DOCUMENTATION</a></header><main>{body}<footer>Generated deterministically from the versioned repository documentation by <code>scripts/build_pages_docs.py</code>.</footer></main></body></html>"""


def build_documentation(*, source_root: Path, output_root: Path) -> list[tuple[Path, str]]:
    """Render all source documents and return their stable navigation records."""

    documents = source_documents(source_root)
    records: list[tuple[Path, str]] = []
    for source in documents:
        destination = output_path(source, source_root, output_root)
        destination.parent.mkdir(parents=True, exist_ok=True)
        relative_index = Path("index.html")
        index_href = Path(
            *([".."] * len(destination.relative_to(output_root).parents[:-1])),
            relative_index,
        ).as_posix()
        rendered = markdown(
            source.read_text(encoding="utf-8"),
            extensions=["extra", "sane_lists", "toc"],
            output_format="html5",
        )
        destination.write_text(
            page_shell(title=title_for(source), body=rewrite_markdown_links(rendered), index_href=index_href),
            encoding="utf-8",
        )
        records.append((source.relative_to(source_root), title_for(source)))
    return records


def build_index(*, output_root: Path, records: list[tuple[Path, str]]) -> Path:
    """Create the public navigation page for every generated document."""

    entries = "\n".join(
        f'<li><a href="{relative.with_suffix(".html").as_posix()}"><strong>{html.escape(title)}</strong><small>{html.escape(relative.as_posix())}</small></a></li>'
        for relative, title in records
    )
    body = (
        "<p class=\"lede\">This static portal is generated in CI from the repository’s "
        "versioned Markdown. It publishes procedures, evidence contracts, formats, "
        "platform dossiers, reverse-engineering methods, and active work obligations. "
        "The report viewer remains available at <a href=\"../index.html\">the preservation report</a>.</p>"
        "<ul class=\"document-list\">"
        f"{entries}</ul>"
    )
    destination = output_root / "index.html"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(page_shell(title="Documentation index", body=body, index_href="index.html"), encoding="utf-8")
    return destination


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", type=Path, default=ROOT)
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=ROOT / "web" / "report-viewer" / "public" / DOCUMENTATION_DIRNAME,
    )
    args = parser.parse_args(argv)
    records = build_documentation(source_root=args.source_root.resolve(), output_root=args.output_dir.resolve())
    index = build_index(output_root=args.output_dir.resolve(), records=records)
    print(f"Published {len(records)} Markdown documents to {index}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
