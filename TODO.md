# DAAD Harvester - Forensic Audit, Brutal Reality & Roadmap (TODO.md)

## ✅ Stability fixes (branch `fix/tui-crash-and-fingerprint-hang`)

Everything below this section is the original roadmap (accuracy/feature
work). This section documents a separate, prior problem: across the ~15
commits that produced that roadmap, the app itself never actually ran
correctly, despite a fully green test suite at every step. Root causes and
fixes, in order of severity:

1. **`--tui` crashed on every single run** (`rich.errors.MarkupError` in
   `tui.py`'s footer). The key-hint labels (`[Tab]`, `[/]`, `[C]`, `[P]`...)
   were unescaped, so Rich's markup parser tried to interpret them as style
   tags instead of literal text; `[/]` in particular is Rich's "close last
   tag" instruction, which closed a span early and crashed the next explicit
   close tag. Since `--tui` is the flagship mode shown in the README, this
   alone made the app "not work" as experienced by a real user. Fixed by
   escaping literal brackets (`\[Tab]`) and by wrapping all harvested/
   dynamic content (game titles, source titles, URLs, the search filter) in
   `rich.text.Text(...)` or `rich.markup.escape(...)` before it reaches any
   Rich-rendered string, since archive filenames routinely contain brackets
   too (`Game [1988] [Cracked].zip`) and would have hit the same crash the
   moment a real game was catalogued.
2. **Fingerprint phase could hang for minutes on realistic files**
   (`daad_parser.py::find_embedded_ddb`). It sliced `data[offset:]` (to the
   *end* of the buffer) on every one of its ~32k scan iterations instead of
   a bounded window, so cost scaled with file size: a 20MB file alone took
   ~48s, worse than linearly. A 93MB real download from this session's test
   run would have taken minutes on this step alone. Fixed by bounding the
   slice to a fixed window (justified by the 16-bit pointer format itself,
   which can't reference beyond 65535 bytes from its own header) -- now
   flat at ~0.1s regardless of file size.
3. **`synthesize.py::generate_cpp_entry` could emit invalid C++.** Titles/
   filenames are external, untrusted strings embedded directly into C++
   `"..."` literals with no escaping; a `"` or `\` in a title (both common
   in the wild) would silently produce a `detection_tables.h` that fails to
   compile, with nothing in the Python pipeline ever raising an error.
   Fixed with a `cpp_escape()` helper, covered by a test that checks quote
   balance in the generated output.
4. **Zip-bomb threshold (10x) was rejecting legitimate retro disk images**
   as false-positive bombs -- .dsk/.tap images are mostly zero-padding and
   routinely compress 20-50x+. Raised to 100x (still far below genuine
   bombs, which are typically 1000x+); `max_unpack_depth` bounds worst-case
   expansion regardless.
5. **Test suite gave false confidence.** All 38 original tests passed
   throughout, including on the exact commit that shipped the TUI crash,
   because `test_tui.py` only drove `handle_key_input()` (pure state logic)
   and never called `.render()` -- the method that actually touches Rich's
   markup parser. Added `tests/test_tui_rendering.py` (renders through a
   real `Console`, including with bracket-laden titles/filenames/search
   input -- confirmed to fail against the pre-fix code, not just pass
   trivially against the post-fix code) plus a performance regression test
   for `find_embedded_ddb` and C++-escaping tests for `synthesize.py`.
6. **No CI existed.** Added `.github/workflows/tests.yml` (lint + full test
   suite + a CLI smoke test, on every push and PR).

Not done in this pass, and worth knowing about before relying on it: the
**live discovery scrapers' correctness against the real, current ZXDB/IFDB/
itch.io/Internet Archive/WikiCAAD sites could not be exercised** from the
sandboxed environment this fix was developed in (only github.com and a few
package-registry domains were reachable). The pipeline was verified
end-to-end against real downloads that *were* reachable (GitHub-hosted DAAD
repos), including the fingerprint phase against a real 93MB artifact, and
that path is solid. If any of the non-GitHub discovery sources are still
returning bad results, that needs checking with normal internet access.

---

## ✅ 2026-08-17 audit: found the non-GitHub sources *were* broken, plus a bigger issue

Followed up on the "not done in this pass" gap above using `web_search` /
`web_fetch` (available even though this sandbox's own outbound network still
can't reach these sites directly). Findings, most to least severe:

1. **The canonical seed catalog (`seeds.py`) is largely fabricated.** Its
   ~19 archive.org URLs follow a plausible `{game-slug}-{platform}` pattern
   (e.g. `la-aventura-original-zx`) that isn't how Archive.org actually names
   items. Confirmed via live search that the real "La Aventura Original"
   ZX item is `zx_Aventura_Original_La_Part_1_La_Busqueda_1989_Aventuras_AD_es`
   -- nothing like the guessed slug, and split into two tape-part items the
   static list doesn't account for at all. The one seed that was fully
   checkable end-to-end (`github.com/v32/daad-ready`) is confirmed 404 via
   the live GitHub API. **This means the harvester's supposed
   highest-confidence starting data is probably mostly dead**, on top of
   whatever live discovery finds. Rather than guess-replace 19 URLs and risk
   repeating the exact same mistake, added `scripts/validate_seeds.py`
   (real HTTP checks, content-type aware -- a 200 that serves an HTML error
   page doesn't count as alive) and a weekly, non-blocking
   `validate-seeds.yml` CI job. Removed the one seed confirmed dead;
   everything else still needs a real run of that script to sort out (this
   sandbox can't reach archive.org to do it here -- see script docstring).
2. **`discover_zxdb` pointed at a domain that doesn't exist.**
   `zxdb.zxinfo.org` doesn't correspond to any documented ZXDB/ZXInfo
   service; live search confirms the real API is `api.zxinfo.dk` (v3).
   Fixed the domain; the exact v3 query-parameter schema is a best-effort
   guess flagged in a code comment, since that API's docs are a
   JS-rendered Swagger page this environment couldn't fully inspect --
   worth a manual spot-check.
3. **`discover_github` hardcoded `/archive/refs/heads/main.zip` for every
   match.** Verified live: 2 of 5 real repos matching `topic:daad` use
   `master`, not `main` (`nataliapc/msx2daad`, `haseebcheema/daadminer`) --
   both would 404. Now reads each repo's actual `default_branch` from the
   same API response instead of assuming. Regression test added.
4. **`--proxy-list` silently did nothing, in both discovery and fetch.**
   `_get_proxy()` was defined in both `discover.py` and `fetch.py` but never
   called anywhere -- `httpx.AsyncClient(...)` was constructed without a
   `proxy=` argument in either module. Wired it in (one proxy chosen per
   pipeline run, not true per-request rotation -- see comment in `fetch.py`
   for the tradeoff and how to extend it later if needed). Regression tests
   added for both call sites.
5. **Wayback fallback only triggered on HTTP 404/410.** Most genuinely dead
   retro-computing sites fail with a connection/DNS error instead (the
   domain itself has lapsed), which never got a wayback attempt at all.
   Extended the fallback to also try wayback once direct retries are
   exhausted on a connection-level exception, not just on an explicit dead
   status code. Regression test added (asserts it fires exactly once, after
   exhausting retries -- not on every transient blip).
6. `wiki.caad.es`'s MediaWiki search API usage was spot-checked and looks
   correct (the site is real, active, and uses the standard MediaWiki
   `action=query&list=search` API + clean-URL article paths the code
   assumes) -- not changed. `itch.io`, `aminet.net`, `ifarchive.org`, and
   the DuckDuckGo HTML scraper's `result__url` CSS class were **not**
   individually re-verified in this pass (time/search-budget tradeoff, and
   the seed-validator script's approach generalizes better than more
   one-off spot-checks); flagging so nobody assumes they were.
7. Minor: `--version`/`--help` displayed `__main__.py` as the program name
   (argparse defaults to `sys.argv[0]` when invoked via `python -m ...`);
   set `prog="daad-harvester"` explicitly. Cleaned up two pyflakes-flagged
   dead locals in `daad_parser.py` (kept the explanatory comment about why
   verb/noun IDs aren't validated yet). Full pyflakes run across
   `daad_harvester/`, `scripts/`, and `tests/` is otherwise clean.

**Deliberately not done:** a from-scratch rewrite. The architecture itself
(async pipeline, SQLite state, Pydantic settings, real bytecode disassembly)
is sound -- the repeated "overhauls" in the git history look like they were
chasing symptoms of unverified claims (both AI-generated seed data and
AI-generated "fixes" that were never actually run), not a fundamentally
broken design. Rewriting it again would risk the same pattern a third time.

---


This document provides a brutally honest, technically exhaustive critique of `daad_harvester`'s codebase, contrasting the **Tragic Reality** of the current state with the **Ideal Architectural Spec**, followed by a concrete, actionable forensic roadmap.

---

## 1. 🔍 Forensic Codebase Audit: Harsh Reality vs. Ideal Architecture

### Phase 1: Fingerprinting & Parser Logic (`daad_parser.py`, `fingerprint.py`) -- ✅ DONE
* **Formerly**: shallow string heuristics (`b"DAAD"`, `b"Aventuras AD"`) with weak, non-decreasing-pointer-only process table validation -- exactly the false-positive-prone approach described below stayed accurate until this was implemented.
* **Now (confirmed present in code + covered by tests)**: `DAADBytecodeParser` in `daad_parser.py` validates the process pointer table (`p0 <= p1 <= p2`, in-bounds) and actually disassembles the Process 0/1 opcode stream against real DAAD condition/action tables, rejecting anything that doesn't decode as valid DAAD bytecode. `tests/test_daad_parser.py` and `tests/test_fingerprint.py` cover rejection of RenPy `.data`, PAWS, GAC, and raw HTML/PHP specifically (`test_renpy_payload_rejection`, `test_fingerprint_rejection_paws`, `test_fingerprint_rejection_gac`, `test_html_php_rejection`, `test_fingerprint_rejection_php_index`).
* **Still open**: Vocabulary table structure (word length indicators, bit-7 compression/XOR encoding, canonical verb/noun ID range validation) is explicitly not implemented -- see the comment in `daad_parser.py` where the verb/noun ID bytes are consumed but not yet validated.

---

### Phase 2: Mass Discovery & Crawling (`discover.py`) -- ⚠️ PARTIALLY DONE, see 2026-08-17 audit above
* ZXDB was pointed at a nonexistent domain (fixed today); GitHub discovery hardcoded the wrong branch for ~40% of real matches (fixed today); the DuckDuckGo web-search fallback exists in code (`discover_web_search`) but its CSS selector assumption wasn't re-verified. IFDB, WikiCAAD, itch.io, Aminet, IF Archive were spot-checked (WikiCAAD looks right) or not re-checked at all -- see the audit section above for exactly which. Deduplication and URL canonicalization exist (`Discoverer.discovered_urls`, `_add_source`'s extension/dedup filtering).

---

### Phase 3: Interactive TUI Dashboard (`tui.py`, `cli.py`) -- ✅ MOSTLY DONE
* **Formerly**: passive, non-interactive `Live` display.
* **Now (confirmed present in code + covered by tests)**: async keyboard handling, tab navigation across 3 tabs, live text search/filtering (`tests/test_tui.py::test_tui_dashboard_navigation`, `test_tui_dashboard_search_filter`), pause/resume (exercised in `test_render_survives_many_update_cycles`), all rendering through real Rich `Console` output without crashing on adversarial input (`tests/test_tui_rendering.py`, plus an ad-hoc 123-case stress test in today's audit covering null bytes, raw ANSI escapes, out-of-range/negative selection, and empty state across all tabs -- 0 crashes).
* **Still open**: no per-game "Detail Inspection Modal" (full hash suite / detected opcodes / vocabulary count on a selected item) -- grepped for `detail`/`modal` in `tui.py`, genuinely not there yet.

---

### Phase 4: Unpacking & Forensic Hash Suite (`unpack.py`, `models.py`, `db.py`) -- ❓ NOT AUDITED THIS PASS
* Multi-algorithm hashing (MD5/SHA1/SHA256/CRC32/XXH32/64/128/etc.) is confirmed present in the DB schema and `test_unpack.py::test_compute_hashes`. A `.dsk` (CPC/Spectrum +3) parser exists (`unpack.py`'s `extract_container` routing). Whether `.tap`/`.tzx`/D64-style container *header stripping* (isolating raw DDB bytes from emulator container framing, as opposed to just archive extraction) is fully implemented was not specifically re-checked in this pass -- `unpack.py` is the largest module (700+ lines) and got a lighter pass than the network-facing modules above, which were prioritized since they were the ones actually confirmed broken.

---

## 🎯 Concrete Technical Roadmap

- [x] **Task 1: Instrumental DAAD Bytecode Disassembler & Structural Parser** -- done, see Phase 1 above. Vocabulary table validation remains open.

- [ ] **Task 2: Overhaul Mass Discovery Engine & Web Search Fallback**
  - [x] Fix ZXDB (wrong domain -- fixed 2026-08-17)
  - [x] Fix GitHub discovery (wrong hardcoded branch -- fixed 2026-08-17)
  - [x] Verify/fix IFDB, itch.io, Aminet, IF Archive, DuckDuckGo scraper against live sites (2026-08-18: itch.io tag URLs and DuckDuckGo selectors confirmed correct live, no change; IFDB URL format fixed to match ifdb.org's own documented API example (`?xml&game&searchfor=`, was `?searchfor=...&xml=1`, missing the `game` type flag entirely); IF Archive paths fixed by dropping an unconfirmed `/indexes/` prefix that had no working precedent in any live example found, vs. multiple confirmed-working `/if-archive/...` paths without it. Aminet's exact query param wasn't conclusively confirmed either way -- left unchanged, no evidence of breakage)
  - [x] DuckDuckGo web search crawler exists (`discover_web_search`) -- selector assumptions unverified

- [x] **Task 3: Interactive Async Terminal UI (Rich TUI)** -- tabs/search/nav/pause done, see Phase 3 above.
  - [ ] Detail Inspection Modal (Enter-to-inspect full hash suite / opcodes / vocab count) still not implemented

- [ ] **Task 4: Container Header Stripping & Raw Bytecode Fingerprinting** -- not audited this pass, see Phase 4 above.

- [x] **Task 5: Complete Verification & Test Suite** -- 55 tests passing across parser opcodes, false-positive rejection, discovery (incl. today's default-branch/proxy regression tests), fetch (incl. today's wayback/proxy regression tests), TUI key handling and rendering, unpack, and the new seed validator. Pyflakes clean across `daad_harvester/`, `scripts/`, `tests/`. Real end-to-end pipeline test exists (`test_pipeline.py::test_full_pipeline_flow`).
