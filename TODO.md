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


This document provides a brutally honest, technically exhaustive critique of `daad_harvester`'s codebase, contrasting the **Tragic Reality** of the current state with the **Ideal Architectural Spec**, followed by a concrete, actionable forensic roadmap.

---

## 1. 🔍 Forensic Codebase Audit: Harsh Reality vs. Ideal Architecture

### Phase 1: Fingerprinting & Parser Logic (`daad_parser.py`, `fingerprint.py`)
* **Tragic Reality**:
  - The previous fingerprinting relied on shallow string heuristics (`b"DAAD"`, `b"Aventuras AD"`, 4-letter verb strings like `b"IR"`, `b"UP"`, `b"GO"`).
  - A RenPy `.data` archive or arbitrary binary containing generic bytes or the string `DAAD` accidentally bypassed the rejection filter, leading to absurd false positives where RenPy games were flagged as "DAAD 2" binaries.
  - Process table validation was weak, simply checking non-decreasing pointers without verifying whether the target addresses contained actual DAAD opcode byte streams (`DAADconds` and `DAADacts`).
* **Ideal Architectural Spec**:
  - **Instrumental Bytecode Disassembler & Structural Parser**:
    - Validate the 16-bit / 8-bit DAAD DDB header layout: Process Pointers Table (Processes 0..n), Objects Table, Locations Table, Vocabulary Table, and Message Tables.
    - Walk the opcode byte stream for Process 0 and Process 1 to verify valid DAAD Condition/Action opcodes (e.g., `AT`, `NOTAT`, `CARRIED`, `PRESENT`, `ISAT`, `GOTO`, `GET`, `DROP`, `MESSAGE`, `PRINT`).
    - Validate Vocabulary Table structure: word length indicators, bit-7 string compression / XOR encoding, and canonical verb/noun ID range mappings.
    - Zero tolerance for non-DAAD binaries: strict rejection of RenPy archives, PAWS, Quill, GAC, SWAN, HTML/PHP web pages, and raw container headers before signature check.

---

### Phase 2: Mass Discovery & Crawling (`discover.py`)
* **Tragic Reality**:
  - Crawlers for ZXDB, IFDB, WikiCAAD, and itch.io were failing or returning 0 results due to endpoint changes, rigid query parameters, or strict BeautifulSoup selectors.
  - No fallback mechanisms existed when specific APIs failed or returned zero hits, missing games that could easily be found via simple web search queries.
* **Ideal Architectural Spec**:
  - **Resilient Multi-Strategy Discovery Engine**:
    - Robust API client for ZXDB, IFDB, WikiCAAD, Internet Archive, GitHub, Aminet, and IF Archive with dynamic fallback query formats and URL normalizing.
    - **Automated Web Search Engine Crawler**: Integrated DuckDuckGo HTML / Web Search fallback query scraper searching for `DAAD adventure game download .dsk .tap .tzx .ddb .adf` to discover unindexed retro archives across the open web.
    - Deduplication, URL canonicalization, and deep link extraction for nested directory indices.

---

### Phase 3: Interactive TUI Dashboard (`tui.py`, `cli.py`)
* **Tragic Reality**:
  - The TUI was a passive, non-interactive display rendered in a `Live` loop at 2Hz.
  - Users could not interact with it: no keyboard navigation, no scrolling, no tab switching, no live search/filtering of discovered games, and no detail inspection view.
* **Ideal Architectural Spec**:
  - **Fully Interactive Async Terminal UI**:
    - Non-blocking, asynchronous keyboard event listener (`stdin` termios/raw mode).
    - **Tab Navigation**: Overview Stats, Live Verified DAAD Games Feed, Discovered Sources, and Live Event Logs.
    - **Interactive Filtering & Search**: Real-time text search filter across game titles, MD5s, and platforms.
    - **Detail Inspection Modal**: Select any verified DAAD game payload and inspect its complete forensic hash suite (MD5, SHA256, XXH64, CRC32), detected opcodes, vocabulary count, and source URL.
    - **Pipeline Manual Control**: Pause, resume, trigger phase re-scans, or inspect errors on demand.

---

### Phase 4: Unpacking & Forensic Hash Suite (`unpack.py`, `models.py`, `db.py`)
* **Tragic Reality**:
  - Disk/tape container formats (e.g., Spectrum TAP/TZX headers, Amstrad Extended DSK sector headers, Commodore D64 track headers) were fingerprinted with container headers attached.
* **Ideal Architectural Spec**:
  - Container header stripping: isolate raw DAAD DDB bytecode streams from emulator disk/tape container sectors.
  - Multi-algorithm cryptographic fingerprinting (MD5, SHA1, SHA256, CRC32, Adler32, XXH32, XXH64, XXH128) stored in SQLite WAL database.

---

## 🎯 Concrete Technical Roadmap

- [ ] **Task 1: Instrumental DAAD Bytecode Disassembler & Structural Parser**
  - [ ] Implement `DAADBytecodeParser` in `daad_parser.py` validating DDB process table offsets, condition/action opcodes, vocabulary headers, object/location tables, and system message pointers.
  - [ ] Reject all false positives (RenPy `.data`, PAWS, Quill, GAC, SWAN, HTML, raw compressed headers).

- [ ] **Task 2: Overhaul Mass Discovery Engine & Web Search Fallback**
  - [ ] Fix ZXDB, IFDB, WikiCAAD, itch.io API & HTML parsing logic.
  - [ ] Add DuckDuckGo web search crawler (`discover_web_search`) for automated query discovery.

- [ ] **Task 3: Interactive Async Terminal UI (Rich TUI)**
  - [ ] Implement non-blocking keyboard listener (`asyncio` reader for terminal key strokes).
  - [ ] Build interactive keybindings: `Tab` (switch tabs), `Up/Down` (scroll tables), `/` (search/filter), `Enter` (view detail view), `q` (quit).

- [ ] **Task 4: Container Header Stripping & Raw Bytecode Fingerprinting**
  - [ ] Extract raw DDB byte sequences from Spectrum `.TAP`/`.TZX` blocks and CPC `.DSK` sectors for pure payload hashing.

- [ ] **Task 5: Complete Verification & Test Suite**
  - [ ] Comprehensive unit tests for deep parser opcodes, zero false positives, discovery fallbacks, and TUI key event handling.
