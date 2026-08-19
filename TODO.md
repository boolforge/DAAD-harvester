# DAAD Harvester — Preservation Work Register

> **Status baseline:** `main` and `origin/main` were verified identical at `177e931` on 2026-08-19. The deterministic suite has **203 passing tests**. This document is the authoritative forward roadmap; it replaces earlier audit notes that described superseded implementations and obsolete test counts.

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

- [ ] Create `docs/versions/` with a cited chronology of original DAAD, historical V1/V2 database generations, DAAD V2 releases, DRC V2/V3 output, and explicitly documented compatibility boundaries.
- [ ] Inventory official interpreter binaries for every platform, language, release variant, loader layout, expected filename, hash, license/source location, and known external-data convention.
- [ ] Document and classify derivatives/extensions separately from original DAAD: DRC, DAAD Ready!, Maluva, MSX2DAAD, DAAD Reborn / community ports, and any other evidence-backed compatible or derived runtime. “Derivative” must name its compatibility and deviation, not be assumed equivalent.
- [ ] Extend fingerprints only from actual format/interpreter specifications. Every claimed detector needs positive fixtures, near-miss fixtures, corruption fixtures, and stored evidence explaining its decision.
- [ ] Investigate historical multi-part commercial layouts using real retained artifacts; keep unresolved layouts as explicit archaeology targets, never guessed DDBs.

### 3. Sources and metadata

- [ ] Maintain a cited source register under `docs/sources/` for every catalog, archive, API, public release page, and interpreter source used by the project.
- [ ] Record source accessibility, robots/terms boundary, API/schema, direct-media contract, platform coverage, known failure modes, and last validated result.
- [ ] Re-validate every adapter live and use the outcome to repair selectors, rate limits, direct-media admission, catalog-only handling, and provenance fields.
- [ ] Expand the evidence catalog conservatively with source URLs for title/platform/release facts and keep binary-version facts distinct.

### 4. TUI and visual evidence

- [ ] Redesign the Rich TUI around legibility, terminal-safe responsive geometry, clearer hierarchy, detailed artifact inspection, and real operational feedback.
- [ ] Add selectable platform-inspired nostalgia themes that preserve accessibility: Spectrum, CPC, C64, Plus/4, MSX, PCW, Atari ST, Amiga, DOS, and a neutral forensic theme.
- [ ] Replace the compact GIF with an extended, readable, authentic live recording that shows discovery, queue inspection, source status, extraction, fingerprinting, version evidence, library organization, logs, and artifact details.
- [ ] Document capture dimensions, aspect-ratio rationale, theme, real input database, and reproducible recording command.

### 5. HTML reports, static library index, and publication

- [ ] Implement deterministic HTML report export from persisted outputs, including summary, source ledger, logs, platform/version/detection results, detection table preview and downloadable `.h`, and a library index with safe links to generated artifacts.
- [ ] Build a static report viewer with no invented data and clear empty/error states.
- [ ] Add GitHub Actions jobs for unit tests, static analysis, generated-report verification, static-site build, and GitHub Pages deployment.
- [ ] Configure and verify GitHub Pages at `https://boolforge.github.io/DAAD-harvester/` only after the workflow succeeds; record the verification URL and deployment run.

### 6. Deep audit and release gate

- [ ] Run the complete deterministic suite, mutation/corruption tests, CLI smoke tests, static analysis, documentation-link checks, report build, and source adapter contract tests.
- [ ] Run bounded real public-media audits across every platform where an unattended direct-media contract is presently available; preserve results and failures as evidence.
- [ ] Update `README.md`, this roadmap, modular docs, changelog/release notes, and the generated report truthfully from final evidence.
- [ ] Publish in small, reviewable commits to `main`; verify `HEAD == origin/main` after every milestone.
