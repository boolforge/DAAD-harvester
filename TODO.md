# DAAD Harvester — Preservation Work Register

> **Status baseline:** The 2026-08-19 documentation-expansion audit recorded **210 passing tests**, a passing CLI/report smoke path, a passing static-report production build, and a passing permanent documentation-integrity check. Subsequent retained-corpus work added real-Amiga, CPC, ZX loader, VICE snapshot, runtime-resource, C64 V1, raw-TAP, multipart Jabato, verified ASS scene-runtime comparison, and self-contained-regeneration regressions; the latest complete release gate reports **240 passing tests**, **61 retained artifacts**, seven hash-pinned native-regeneration entries, and a passing mandatory policy-link check. The static report is live at `https://boolforge.github.io/DAAD-harvester/` following successful Pages run `32235035851`. This document is the authoritative forward roadmap; it replaces earlier audit notes that described superseded implementations and obsolete test counts.

## Preservation standard

DAAD Harvester must never label a source, container, interpreter, game database, platform, release, compiler generation, or derivative as verified unless the stored evidence supports that exact claim. A feature is complete only when it has a documented format contract, bounded implementation, deterministic negative and corruption tests, real-artifact validation where public media is available, provenance output, and a clear user-facing statement of any remaining boundary.

## Self-contained regeneration requirement

- [ ] Audit every promoted preservation claim and classify its regeneration path as **repository-native**, **declared Python/package dependency**, or **external independent validator**. A claim may not require an external GUI application, emulator, proprietary tool, or undeclared local resource for its primary regeneration.
- [ ] Add deterministic repository commands and CI-safe tests for every primary extraction, structural validation, byte comparison, report, and evidence artifact. Retained media and committed reference fixtures must be sufficient to reproduce the expected hashes and evidence tables after a documented environment setup.
- [ ] Reclassify VICE, Ghidra, radare2, c64tapedecode, and comparable programs as optional cross-validation evidence only. Preserve their command logs and results, but implement and test an equivalent repository-native primary path before any support claim is promoted.
- [ ] Make all emulator-derived state claims explicitly reproducible from retained snapshots or native parsed inputs with a committed extraction script; where live emulation remains necessary to acquire a new state, record it as an acquisition method rather than a regeneration prerequisite.
- [ ] Publish the self-contained regeneration requirement verbatim in the project policy, README, contributor guidance, corpus/evidence contracts, format dossiers, reverse-engineering methodology, and release checklist. Every document that introduces an evidence level or support claim must link to this requirement.
- [ ] Add an automated policy check that rejects new promoted-evidence records lacking a native regeneration command, committed input manifest, declared dependencies, output-hash assertions, and an explicit classification for every external validator.
- [ ] Require a self-contained-regeneration attestation in every commit-level audit and release gate. CI must fail if a required primary result invokes an undeclared executable, network endpoint, external emulator, GUI program, or non-committed input.
- [ ] Audit existing reports, screenshots, recordings, static-site artifacts, binary analyses, decompilations, media extractions, DDB outputs, and emulator observations. Replace non-self-contained primary paths or downgrade them to optional corroboration until a native regeneration path is committed and tested.

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
- [ ] Implement native Commodore raw-TAP V0/V1/V2 pulse-stream decoding with exact declared-length validation, overflow semantics, conventional ROM-loader block recovery, byte-level provenance, corruption fixtures, and an explicit evidence path for custom-loader streams that cannot use conventional framing.
- [ ] Reconstruct the C64 KERNAL software-servo reader used by the retained *Jabato* Side A later stream from the preserved `read.s` implementation: model `cmp0` adaptation, synchronization, duplicate-pass/error handling, pointer setup, and checksums; reproduce every byte of the verified `$3880`–`$99C2` Part 1 DDB from original pulses; and add block-level runtime/ADP identity regressions before claiming complete physical recovery.

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

- [ ] Replace restrictive handling statuses with the institutional-authority directive: all acquired original bytes, extracted members, third-party materials, tool outputs, decompilations, and execution records are retained, analyzed, run where safe, and published; provenance fields remain evidentiary rather than blocking.
- [ ] Complete every retained-corpus objective end-to-end—acquisition, execution, extraction, analysis, comparison, documentation, publication, regression, and audit—while preserving original/derived distinctions and reproducibility records.
- [x] Record per-artifact authorization, license, source URL, acquisition date, checksum, platform/architecture, and redistribution status for the retained official interpreter profile corpus.
- [x] Ingest the user-documented authorization record by reference into each official original-binary manifest and record its scope without placing sensitive permission correspondence in generated reports.
- [ ] Record the user-documented European/international preservation-agreement reference as a scope-level provenance record linked from every retained interpreter and game-corpus manifest, without exposing sensitive correspondence.
- [ ] Apply the user-confirmed universal authorization scope to all retained corpus classes, while preserving individual source URL, acquisition, hash, platform, lineage, and analysis-tool records for every committed item.
- [x] Create a machine-readable inventory that distinguishes original binary, public original source, public derivative source, disassembly, decompiler output, symbol map, and analytical notes.
- [x] Define reproducible, architecture-specific workflows for Z80, 6502/8501, 68000, and 8086-class DAAD artifacts, including tool version pins, raw-mode base assumptions, command logs, and one successful exact-hash pilot per family.
- [x] Analyze every retained official exact-hash interpreter profile whose provenance/authorization gate is satisfied; preserve immutable originals separately from derived output and never label generated pseudocode as recovered source.
- [ ] Cross-check each derived interpretation with independent tools, known DDB/runtime behavior, checksums, entry-point mappings, and reproducible test fixtures before documentation claims are promoted.
- [ ] Discover public third-party disassemblies/decompilations by platform and version; retain their provenance and verify input-byte hashes, architecture/load assumptions, and claimed ranges against locally generated analysis before use.
- [ ] Retain the confirmed relevant `jlcebrian/ADP` public implementation at a pinned revision; record its license, stated platform/version scope, source/binary composition, and independent comparison outcome before incorporating its claims.
- [ ] Commit every accepted third-party comparison artifact, raw local disassembly, decompiler output, symbol/control-flow export, tool configuration, command log, and output hash in the self-contained reverse-engineering corpus.
- [ ] Retain comparative inputs in immutable `third_party/` paths and generated local outputs in separate tool/version-qualified paths; no documentation-only reference may substitute for an accepted artifact.
- [ ] Add focused reverse-engineering dossiers, schema/provenance contracts, audit records, and CI-safe integrity checks without redistributing restricted original binaries or proprietary-source equivalents.

### 8. All-platform retained game corpus and regression suite

- [ ] Apply the global completion rule to every parser, media format, loader, runtime variant, DDB structure, companion asset, and decompiler construct: an unsupported observation must enter a retained-sample research, implementation, differential-check, and regression loop until verified support exists; no terminal unsupported omission is permitted.
- [ ] Enforce blocker closure: every temporary blocker record must culminate in a verified implementation, real-artifact regression, refreshed corpus output, and evidence-backed support claim. A measured but unresolved state is an investigation checkpoint only and may never be accepted as the final result for any platform, format, loader, interpreter, DDB structure, derivative, or game variant.
- [ ] For every blocker, perform deep external research before selecting a solution: inspect primary documentation and source where available, multiple independent preservation archives/catalogs, public implementations and tools, platform-specific technical references, and comparable artifact variants. Retain source URLs, downloaded/hashed research materials where permitted, conclusions, counter-evidence, and byte-level validation against the authorized corpus; then implement, test, and iterate until verified closure.
- [ ] When an authorized source endpoint is captcha-protected, rate-limited, or otherwise non-automatable, retain the exact access outcome and continue acquisition through independent accessible archives, mirrors, catalog-linked variants, and primary releases. The blocked endpoint must remain a provenance record, never a reason to halt comparison or closure work.
- [ ] Treat release-scene, crack, dump, trainer, and archival tags as provenance metadata rather than game semantics. Acquire and compare alternate/original variants whenever possible, identify byte-level loader/intro/interpreter modifications, and validate all conclusions against retained artifacts before modeling runtime behavior.
- [ ] Make every cracked, scene-modified, trained, fixed, translated, compilation, and archival release fully functional: preserve and execute its exact loader/intro path, recover its game data and embedded runtime behavior, distinguish modifications from the underlying game, and add real-artifact regressions plus emulator evidence until that variant reaches verified support.
- [ ] Apply this closure rule universally to every DAAD system, software and hardware platform, game, release, compiler/runtime version, historical or modern derivative, interpreter, media/container form, compression/protection scheme, loader, encoding, companion resource, and game-specific fork. No category, artifact, or variation is exempt from complete verified treatment.
- [ ] Maintain an equal-priority execution and evidence matrix for ZX Spectrum, Amstrad CPC, C64, Plus/4, MSX, Amstrad PCW, Atari ST, Amiga, and IBM PC/DOS, including all known software/runtime derivatives; no platform-specific investigation may be mistaken for a platform priority or permit another platform to fall outside active coverage tracking.
- [ ] Apply the institutional preservation authorization globally to supporting runtime resources required for reproducibility—including firmware, system ROMs, emulator dependencies, compilers, and reference media—while retaining each resource’s origin URL, acquisition timestamp, authorization context, version, SHA-256, and role in the evidence chain.
- [ ] Persist the universal institutional authorization directive verbatim in the project policy, corpus manifests, acquisition/reverse-engineering records, and CI-verifiable documentation: all required artifacts and tools may be acquired, retained, executed, analyzed, disassembled, decompiled, recompiled, compared, and published for the project’s scientific preservation mission, without category- or platform-specific exceptions.
- [ ] Build deterministic emulator-backed reconstruction workflows for every target whose loaders or protected media cannot be resolved statically; retain command scripts, bounded snapshots or RAM ranges, runtime configuration, execution limits, and byte-level comparisons as corpus evidence.
- [ ] Treat missing supporting firmware or a runtime dependency as a named acquisition/provenance task, not a terminal blocker: find, retain, hash, validate, and regression-test the resource under the same institutional authorization and global completion rule.
- [ ] Close the retained C64 *Jabato vs. Imperio: Libertad* tape loop: reconcile both original raw pulse streams, their controlled title/credits/loading paths, and active runtime representations; reproduce the recovered Side A Part 1 and Side B Part 2 ranges from pulses alone, compare both originals against the ASS D64 variant, implement the resulting parser/loader support, and add real-artifact regressions before promotion.
- [ ] Close the ADP-to-original C64 *Jabato* evidence loop: retain fixture provenance and hashes, preserve the verified byte-identical `JABATO-C64 1.DDB` to Side A RAM `$3880` and `JABATO-C64 2.DDB` to Side B RAM `$3880` comparisons, and convert every accepted relation into deterministic extraction and regression checks without treating ADP as a physical tape-loader substitute.
- [x] Retain acquisition batch 001 as committed originals, extracts, source database, command logs, classified library, coverage ledger, structural-candidate evidence, and CI hash verifier; the first slice covers Amiga, C64, CPC, Plus/4, and ZX.
- [x] Resolve the retained Amiga Chichén Itzá OFS ADF loop: extract all 19 files, preserve equal-byte members with distinct names, verify `PART1.DDB` and `PART2.DDB` as legacy V2 Amiga DDBs, and refresh stale descendants through a tested `--reunpack-source` workflow.
- [ ] Define an artifact-level authorization/retention gate for DAAD game downloads that is independent from interpreter authorization and records source terms, rights evidence, download URL, timestamps, and SHA-256.
- [ ] Run Harvester discovery/acquisition across ZX Spectrum, CPC, C64, Plus/4, MSX, PCW, Atari ST, Amiga, and IBM PC/DOS sources; preserve every candidate and outcome in a resumable source ledger.
- [ ] Compare every retained original/extracted game member and executable neighbor against official interpreter hashes and structural runtime evidence; retain every differing or unmatched interpreter candidate as a new immutable variant for separate analysis.
- [ ] Commit accepted game originals under a platform/game/source hierarchy and all safe extracted members under a separate lineage-preserving tree, with original-to-member checksum and parser evidence manifests.
- [ ] Convert accepted real artifacts into regression fixtures/manifests for media inspection, recursive unpacking, DDB validation, interpreter correlation, organization, and static-report output without fabricating detections.
- [ ] Publish platform coverage, failures, unavailable items, rights-restricted records, extraction statuses, and test use in dated audit documents and the report corpus.
- [ ] Produce a source-by-source coverage ledger proving which reachable catalogs, queries, pages, and downloads were exhausted; record inaccessible, missing, duplicate, and unresolved historical items as explicit gaps rather than asserting unverifiable universal completeness.

### 9. DAAD game decompiler research and differential implementation

- [ ] Inventory every reachable public DAAD game decompiler, decompiler-like tool, compiler inverse, source recovery project, and format reader; retain complete pinned source/release inputs and document exact platform/version/format scope.
- [ ] Build a modular DAAD game/DDB preservation decompiler, comparable in purpose to UnDAAD but broader and evidence-linked; recover vocabulary, messages, locations, objects, connections, processes, condacts, flags, attributes, graphics/media references, and DSF/SCE-like output with byte-range lineage, confidence, ambiguity, and tool/version metadata.
- [ ] Implement platform-aware profiles for ZX Spectrum, CPC, C64, Plus/4, MSX, PCW, Atari ST, Amiga, and IBM PC/DOS, separating shared DDB semantics from platform loader/media/runtime differences.
- [ ] Replace any single-axis version classification with a multi-axis evidence profile covering DDB structure, compiler lineage, runtime/interpreter lineage, target/load model, media/loader package, graphics/sound companions, encoding/language, derivative/fork family, and game-specific variation.
- [ ] Differentially compare the new decompiler with every retained public implementation/decompiler and independently reproduce disagreements against original bytes, traces, and known game fixtures.
- [ ] Add exhaustive real-artifact regression tests, deterministic output fixtures, source-map/evidence manifests, documentation, and report integration before promoting any recovered interpretation beyond its evidence level.
- [ ] Keep the DAAD game/DDB decompiler explicitly separate from interpreter-binary disassembly/decompilation while linking both evidence layers through runtime version, media lineage, and measured execution behavior.
- [ ] Enforce corpus-complete decompiler coverage: every discovered DAAD-ecosystem artifact must have a manifest, multi-axis profile, decompilation output or explicit blocker record, output hashes, and regression status; newly acquired artifacts automatically join the required coverage set.

### 10. Universal decompile–recompile round-trip verification

- [ ] Define a lossless, version-neutral intermediate representation for every measured DDB byte range, including header fields, section ordering, padding, reserved bytes, compiler-specific layout choices, load address, and companion/loader provenance.
- [ ] Implement a compiler for that representation which can emit each verified historical and modern DAAD/derivative target layout without normalizing away source-byte distinctions.
- [ ] Require `original bytes → decompile → IR → recompile → byte-for-byte comparison` for every retained DDB and every newly acquired DDB candidate; persist input/output SHA-256 values, differing byte ranges, tool versions, target/load model, and deterministic reproducer commands.
- [ ] When a round trip differs, automatically classify the discrepancy as unknown structure, semantic ambiguity, compiler-layout choice, companion/load-model dependency, or implementation defect; retain the mismatch and iterate until either byte identity is achieved or the exact blocking construct receives a dedicated support loop.
- [ ] Add higher-order differential checks: decompile/recompile cycles across supported profiles, semantic process/condact traces where executable evidence is safe, independently derived interpreter behavior, and comparisons against retained public tools such as UnDAAD and ADP.
- [ ] Make byte identity, or a documented and actively iterated byte-range blocker, a mandatory promotion gate for every decompiler/compiler profile. No variant may be treated as complete solely because it produces plausible text output.

### 11. Future ScummVM DAAD engine

- [ ] After corpus coverage, native-media support, DDB decompiler/compiler round-trip evidence, and interpreter/runtime profiles are mature, conduct a separate ScummVM feasibility and architecture study for a universal DAAD engine.
- [ ] Research and retain the current ScummVM engine-development documentation, coding standards, comment conventions, build/test requirements, review expectations, merged-engine histories, and comparable parser/VM engine patterns before writing ScummVM-facing code.
- [ ] Map the DAAD preservation intermediate representation, platform load models, interpreter behavior evidence, graphics/audio companions, and detector metadata to ScummVM subsystems without importing uncertain reverse-engineering claims as runtime behavior.
- [ ] Build the eventual engine through upstream-quality tests, detector fixtures, save/load validation, cross-platform execution evidence, reviewable commits, and feedback-driven alignment with current ScummVM project practices.

### 12. Final emulator-equivalence and ScummVM integration gate

- [ ] Preserve execution order: do not begin native ScummVM engine source implementation until exhaustive all-platform acquisition, format/loader support, game-embedded interpreter analysis, full decompiler/compiler coverage with round-trip evidence, original-runtime differential evidence, and the corpus-completeness audit have passed their explicit gates.
- [ ] Implement the universal DAAD engine directly as a native ScummVM engine, using ScummVM subsystems, coding conventions, detector model, build system, test infrastructure, and review standards from its first production source file; no standalone engine may substitute for this deliverable.
- [ ] Define a platform-neutral behavioral evidence format that records deterministic input scripts, frame/cycle boundaries, DDB/runtime state, flags, locations, object state, messages, graphics, audio events, disk/tape/loader transitions, save states, screenshots, and checksums for every retained executable game path.
- [ ] Run the universal DAAD engine and each corresponding original target runtime under controlled emulators with the same scripted inputs. Compare observable behavior and captured state at every defined checkpoint across all historical and modern DAAD versions, derivatives, platforms, target/load models, and game-specific forks.
- [ ] Treat every behavioral discrepancy—including a single byte, state transition, parser result, timing-sensitive load, graphic cell, text encoding difference, audio event, or save/load divergence—as a retained reproducible defect record. Diagnose, correct, retest, and repeat until equivalence is demonstrated or the exact condition is represented by an active support loop.
- [ ] Execute massive iterative differential testing over the full authorized corpus, including repeated decompile/recompile checks, interpreter comparisons, emulator snapshots, controlled interaction paths, malformed-but-retained structures, and cross-tool disagreement cases. Preserve all scripts, captures, hashes, expected results, and failure deltas.
- [ ] Require a final independent audit of source, tests, corpus manifests, provenance, reverse-engineering claims, security boundaries, build reproducibility, behavioral-equivalence records, and unresolved loops before declaring the universal engine ready for ScummVM-facing work.
- [ ] Only after the final audit passes, create and maintain a ScummVM fork; integrate the DAAD engine through its current coding, architecture, detector, build, test, documentation, review, and contribution practices. Run the complete equivalence suite again in the fork and iterate on every discrepancy before proposing any upstream-quality integration milestone.
