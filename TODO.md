# DAAD Harvester — Preservation Work Register

> **Status baseline:** The 2026-08-19 documentation-expansion audit recorded **210 passing tests**, a passing CLI/report smoke path, a passing static-report production build, and a passing permanent documentation-integrity check. The static report is live at `https://boolforge.github.io/DAAD-harvester/` following successful Pages run `32235035851`. This document is the authoritative forward roadmap; it replaces earlier audit notes that described superseded implementations and obsolete test counts.

## Preservation standard

DAAD Harvester must never label a source, container, interpreter, game database, platform, release, compiler generation, or derivative as verified unless the stored evidence supports that exact claim. A feature is complete only when it has a documented format contract, bounded implementation, deterministic negative and corruption tests, real-artifact validation where public media is available, provenance output, and a clear user-facing statement of any remaining boundary.

## Completed foundation

- [x] Canonical official target vocabulary: ZX Spectrum, Amstrad CPC, Commodore 64, Commodore Plus/4, MSX, Amstrad PCW, Atari ST, Amiga, and IBM PC/DOS.
- [x] Platform-neutral source, artifact, and version-evidence persistence, including catalog-only source status and normalized source roles.
- [x] Modern DRC V2/V3 structural DDB validation across all canonical targets.
- [x] Historical compact V1/V2 structural DDB validation derived from the MSX2DAAD interpreter header and loader contract.
- [x] Exact interpreter identity through same-platform official SHA-256 profiles, with qualified runtime filename evidence kept separate.
- [x] Initial native media adapters and provenance for supported archive, tape, disk, filesystem, and compressed-image families.
- [x] Current all-platform discovery adapters, including direct-media versus catalog-only source contracts.
- [x] A first all-platform audit run, bounded real public-media validation, and an honest regenerated TUI recording.
- [x] Existing GitHub Actions unit-test and CLI-smoke workflow.

## Critical work in progress

### 0. Granular documentation architecture

- [x] Replace broad topic monographs with a focused-module tree: one technical responsibility per file, with directory indexes and bidirectional cross-references.
- [x] Separate conceptual narrative, byte schemas, state/flow diagrams, platform dossiers, source records, reproducible artifact manifests, and dated audit results into distinct documents.
- [x] Add a documentation migration map that identifies each legacy broad document, its destination modules, and its retained index role.
- [x] Add permanent automated local-link, focused-header/reference, and Mermaid-declaration checks before publication; source-led claims remain routed through the relevant ledger.

### 1. Complete format and archive coverage

- [x] Publish `docs/formats/FORMAT_CAPABILITY_MATRIX.md` listing every input family, extension, magic, platform ambiguity, wrapper, expected member model, implementation owner, test corpus, and real-artifact result.
- [x] Validate DMS archive and every track through CRC-16/ARC plus additive checksum; decode NOCOMP, SIMPLE, QUICK, MEDIUM, DEEP, HEAVY1, and HEAVY2 with deterministic mode fixtures and bounded failure paths.
- [x] Validate typed TZX/CDT v1.20 block streams, including all standardized data, control-flow, metadata, and extension boundaries, while retaining control evidence rather than replaying tape control graphs.
- [x] Extract bounded FAT12/FAT16 filesystems, including validated VFAT short/long-name association and directory chains; validate DOS MZ header structure; inspect DMS, STX/Pasti, and SPS/IPF preservation evidence.
- [x] Extract FFS files spanning validated Amiga extension-header chains without silently truncating continuation blocks.
- [ ] Replace any “limited,” heuristic, or filename-dependent path with documented native parsing or a deliberately rejected unsupported state. Do not silently fall back to blind copying.
- [ ] Cover the complete required family of DAAD-relevant containers and media: TAP/TZX/CDT; +3DOS; CPC standard/extended DSK; C64/Plus4 D64, T64, PRG, P00; MSX/PCW/DOS FAT12/FAT16 DSK; MSX CAS and ROM; Atari ST ST, MSA, STX/IPF evidence; Amiga ADF, ADZ, DMS, LHA/LZH; DOS COM/EXE; and nested ZIP/7z/RAR/LHA/ARJ/cab/gzip/tar where legally and technically applicable.
- [ ] Add strict bounds, checksum/geometry validation, corruption cases, recursive provenance, decompression limits, and negative controls for every parser.
- [ ] Add public real-artifact audit fixtures or reproducible acquisition manifests where redistribution is not permitted.

### 2. Versions, interpreters, and derivatives

- [x] Create `docs/versions/` with a cited chronology of original DAAD, historical V1/V2 database generations, DAAD V2 releases, DRC V2/V3 output, and explicitly documented compatibility boundaries.
- [x] Inventory registered official interpreter binaries across all nine canonical platforms, including measured SHA-256 anchors, language/variant metadata where present, filename aliases, and source-controlled distribution provenance.
- [x] Document and classify derivatives/extensions separately from original DAAD: DRC, DAAD Ready!, Maluva, MSX2DAAD, PCDAAD, UnDAAD, and compatibility boundaries. “Derivative” names its supported format and deviation; it is not assumed equivalent.
- [x] Extend fingerprints only from actual format/interpreter specifications, with structural, corruption, and profile-correlation regressions that persist decision evidence.
- [ ] Investigate historical multi-part commercial layouts using real retained artifacts; keep unresolved layouts as explicit archaeology targets, never guessed DDBs.

### 3. Sources and metadata

- [x] Maintain a cited source register under `docs/sources/` for the catalog, archive, API, public release-page, format, and interpreter sources used by the project.
- [x] Record source accessibility, robots/terms boundary, API/schema, direct-media contract, platform coverage, known failure modes, and last validated result in the source register and audit notes.
- [ ] Re-validate every adapter live and use the outcome to repair selectors, rate limits, direct-media admission, catalog-only handling, and provenance fields.
- [ ] Expand the evidence catalog conservatively with source URLs for title/platform/release facts and keep binary-version facts distinct.

### 4. TUI and visual evidence

- [x] Redesign the Rich TUI around legibility, terminal-safe responsive geometry, clearer hierarchy, detailed artifact inspection, and real operational feedback.
- [x] Add selectable platform-inspired nostalgia themes that preserve accessibility: Spectrum, CPC, C64, Plus/4, MSX, PCW, Atari ST, Amiga, DOS, and a neutral forensic theme.
- [x] Replace the compact GIF with an extended, readable, authentic interaction recording backed by a real retained audit database; it shows evidence, selection, inspector, theme, filter, queue, metrics, and pause states without invented detections.
- [x] Document capture dimensions, aspect-ratio rationale, theme, real input database, and reproducible recording command.

### 5. HTML reports, static library index, and publication

- [x] Implement deterministic static-report export from persisted outputs, including summary, source ledger, logs, platform/version/detection results, detection table preview/download state, and a library manifest index with safe relative links.
- [x] Build a static report viewer with no invented data and clear loading/error states.
- [x] Add GitHub Actions jobs for unit tests, static analysis, generated-report verification, static-site build, and GitHub Pages deployment.
- [x] Configure and verify GitHub Pages at `https://boolforge.github.io/DAAD-harvester/` after successful deployment run `32235035851`.

### 6. Deep audit and release gate

- [x] Run the complete deterministic suite, corruption regressions, CLI report smoke test, static analysis, documentation-link checks, and report build.
- [x] Run a fresh bounded public-media audit through discovery, fetch, native unpack, fingerprint, organization, and report export; preserve the `174`-source, five-download, 37-artifact, zero-verified-DDB outcome and source failure in `docs/audits/2026-08-19_FINAL_LIVE_AUDIT.md`.
- [x] Update `README.md`, this roadmap, modular docs, and the generated report truthfully from final evidence.
- [x] Publish in small, reviewable commits to `main`; verify `HEAD == origin/main` after every milestone.
- [x] Record the modular-documentation audit, report build, CLI/report smoke test, and remaining native-archive release gate in `docs/audits/2026-08-19_DOCUMENTATION_EXPANSION_AUDIT.md`.

### 7. Authorization-gated reverse-engineering corpus

- [ ] Record per-artifact authorization, license, source URL, acquisition date, checksum, platform/architecture, and redistribution status before storing any original binary or derived analysis.
- [ ] Create a machine-readable inventory that distinguishes original binary, public original source, public derivative source, disassembly, decompiler output, symbol map, and analytical notes.
- [ ] Define reproducible, architecture-specific workflows for Z80, 6502/8501, 68000, and 8086-class DAAD artifacts, including tool version pins, load addresses, memory maps, and command logs.
- [ ] Analyze only artifacts whose provenance/authorization gate is satisfied; preserve immutable originals separately from disassembly/decompilation output and never label generated pseudocode as recovered source.
- [ ] Cross-check each derived interpretation with independent tools, known DDB/runtime behavior, checksums, entry-point mappings, and reproducible test fixtures before documentation claims are promoted.
- [ ] Add focused reverse-engineering dossiers, schema/provenance contracts, audit records, and CI-safe integrity checks without redistributing restricted original binaries or proprietary-source equivalents.
