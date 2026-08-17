# DAAD Harvester - Forensic Audit, Brutal Reality & Roadmap (TODO.md)

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
