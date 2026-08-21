# Requirements, Evidence, and Continuity Contract

| Header field | Value |
| --- | --- |
| **Question** | How does a clean clone let a human or deterministic agent understand, regenerate, inspect, audit, improve, recover, and continue every DAAD Harvester concern without private conversation context or a personal workstation? |
| **Evidence scope** | Implementation contract governing P0–P4 evidence records, source code, corpus state, deterministic verification, CI records, report/TUI consumers, and future contribution handoffs. |
| **Status** | implementation contract |
| **Implementation links** | [`../../scripts/run_primary_workflow.py`](../../scripts/run_primary_workflow.py), [`../../scripts/check_docs.py`](../../scripts/check_docs.py), [`../../scripts/verify_regeneration_manifest.py`](../../scripts/verify_regeneration_manifest.py), [`../../TODO.md`](../../TODO.md), [`../CONTRIBUTOR_CONTINUATION.md`](../CONTRIBUTOR_CONTINUATION.md) |
| **Non-claims** | This contract does not claim that every historical DAAD format, interpreter, game, derivative, decompiler semantic, or emulator-equivalence condition is already complete. It makes every unresolved condition visible, reproducible, and non-terminal. |

> **Continuity rule.** The repository is the complete operational handoff. A contributor must not need this conversation, an unavailable agent memory, a private prompt, a hidden credential, a personal filesystem, a GUI-only procedure, or an unrecorded tool invocation to decide what a current claim means or how to continue work on it.

> **American English rule.** All project-authored code, identifiers, comments, documentation, tests, generated evidence keys and values, scripts, commit messages, contributor guidance, report text, and progress communication use **American English exclusively**. A non-English string in project-authored material is an issue to record, correct, test where applicable, and close through the global issue lifecycle.

Authentic retained evidence is different from project-authored material. External sources, archival captures, original code, websites, third-party public-source mirrors, source comments, test fixtures, and historical documentation may be in **any language** and must remain authentic. Materials retained under `preservation_corpus/`, `reverse_engineering/public_sources/`, and `reverse_engineering/public_implementations/` are excluded from the authored-language check, must not be silently translated or normalized, and require English provenance metadata and explanatory documentation around the retained original.

Official project, product, person, place, and game names retain their authentic spelling even when that spelling includes a diacritic or a non-English word. The deterministic authored-language check has a narrow, reviewed allowlist for those proper nouns; it does not allow non-English explanatory prose, comments, labels, or behavior text.

## 1. The common path for people and agents

Humans and agents use the **same repository path**. A human may read prose and inspect rendered documents; an agent may consume the same Markdown, JSON manifests, structured command output, tests, and source code. Neither path is authoritative by itself: the deterministic verification commands and hash-pinned evidence establish reproducibility.

| Step | Human-oriented entry | Agent-oriented entry | Required deterministic evidence |
| --- | --- | --- |
| Orient | Root [`README.md`](../../README.md) and [documentation index](../README.md). | Same files; then `python scripts/run_primary_workflow.py --list`. | Repository revision, declared host requirements, and printed command plan. |
| Learn the vocabulary | [Contributor continuation guide](../CONTRIBUTOR_CONTINUATION.md) §§3–5. | Same guide and its tables. | Defined source/artifact/profile/primary/validator/blocker distinctions. |
| Identify work | [`TODO.md`](../../TODO.md), [coverage ledger](../../preservation_corpus/COVERAGE_LEDGER.md), platform/format dossiers, and failing verifier output. | Same files; parse explicit unchecked tasks and structured failure text. | A concrete input, precise claim/boundary, and closure condition. |
| Verify before change | `python scripts/run_primary_workflow.py`. | Identical command. | Manifest, runtime, corpus, reverse-corpus, report, docs, lint, and tests all pass or stop at a named failure. |
| Make a bounded change | Follow §4 of this document. | Identical sequence; no model inference is a runtime dependency. | Code/data/document/test diff linked to one claim. |
| Verify and hand off | Re-run the gate, review generated-state diff, update manifest/report/ledger, commit atomically. | Identical sequence with machine-readable exit statuses. | Clean/reviewable repository state and next blocker/continuation instruction. |

## 2. Traceability record required for every concern

Every project concern has one durable traceability record, even where its implementation is still incomplete. The record may be a focused dossier, a ledger row, a manifest entry, or an explicit blocker section; it must not be implicit in a commit message or an external conversation.

| Required field | Meaning | Typical repository location |
| --- | --- | --- |
| Identifier and objective | Stable short name and plain-language purpose. | `TODO.md`, dossier, ledger, or schema module. |
| Scope and non-claim | Exact platform/format/artifact boundary and what cannot be inferred. | Focused module header and contract table. |
| Evidence inputs | Retained source/original/container/member/capture identifiers and SHA-256 lineage. | `preservation_corpus/`, `reverse_engineering/`, source register, manifest. |
| Data contract | Persisted fields, byte/geometry/load semantics, and `unknown` representation. | `docs/schemas/`, format/platform dossier, typed model. |
| Responsible code | Parser, extractor, fingerprint, report, TUI, CI adapter, or verifier module. | `daad_harvester/`, `scripts/`, workflow. |
| Positive and rejection tests | Synthetic success, malformed/corrupt boundary, retained-real-artifact regression, and contamination isolation where applicable. | `tests/`. |
| Primary regeneration | Network-free local command and declared dependencies. | Manifest entry and `run_primary_workflow.py`. |
| Generated outputs | Exact files, hashes, report/library effect, and state mutation boundary. | `regeneration_manifest.json`, report, library, ledger. |
| Optional validation | Tool version/capability/configuration/log/capture comparison, explicitly non-primary. | Reverse-engineering/toolchain records and CI matrix. |
| Public representation | What the report, documentation portal, and TUI can display/download; absent fields remain absent. | [UI evidence contract](UI_EVIDENCE_CONTRACT.md). |
| Blocker/recovery/next action | Reproducer, non-terminal next loop, restoration boundary, and closure criterion. | `TODO.md`, ledger, dated audit, contributor guide. |

## 3. Repository control plane

The following files form the clone-only control plane. They are deliberately separate so readers can distinguish normative policy, current work, source code, generated evidence, and dated historical observations.

| Need | Authoritative entry point | What it provides |
| --- | --- | --- |
| Project purpose and install | [`README.md`](../../README.md) | Nine target platforms, host bootstrap, commands, public report URL, and top-level navigation. |
| Current obligations | [`TODO.md`](../../TODO.md) | Explicit unchecked requirements; blockers are work loops, not silent exclusions. |
| Documentation routing | [Documentation map](../DOCUMENTATION_MAP.md) | Directory ownership, module anatomy, and cross-reference discipline. |
| Future contributor workflow | [Contributor continuation guide](../CONTRIBUTOR_CONTINUATION.md) | Reading order, vocabulary, profile-change protocol, recovery, and atomic review. |
| Primary evidence boundary | [Self-contained regeneration policy](../SELF_CONTAINED_REGENERATION.md) | What may be promoted, manifest contract, and external-validator boundary. |
| Exact result replay | [`scripts/run_primary_workflow.py`](../../scripts/run_primary_workflow.py) | Host-neutral ordered primary gate; `--list` exposes the exact plan and `--quick` bounds investigations. |
| Corpus state | [Coverage ledger](../../preservation_corpus/COVERAGE_LEDGER.md) and [`state.db`](../../preservation_corpus/state.db) | Human-readable coverage and typed resumable provenance/artifact state. |
| Hash-pinned regeneration | [`regeneration_manifest.json`](../../preservation_corpus/regeneration_manifest.json) | Inputs, commands, outputs, hashes, and dependency declarations for promoted results. |
| Interface claims | [Static report contract](../schemas/STATIC_REPORT_CONTRACT.md) and [UI evidence contract](UI_EVIDENCE_CONTRACT.md) | Browser/TUI field meaning, permitted interactions, and unknown/download boundary. |
| CI/public delivery | [Pages report contract](../PAGES_REPORT.md) and [workflow](../../.github/workflows/pages.yml) | Evidence staging, static build, deployment, and post-deployment hash verification. |

## 4. Deterministic bounded-change protocol

This is the only acceptable loop for a new parser, format profile, interpreter identity, artifact, corpus mutation, report field, interface behavior, external validator, decompiler feature, or future ScummVM handoff component.

```text
Locate explicit objective/blocker
        ↓
Retain and hash input; document source/provenance and non-claim
        ↓
Write or update the focused contract and data semantics
        ↓
Implement deterministic repository-native behavior
        ↓
Add positive + rejection + real-artifact tests
        ↓
Regenerate affected state, report, library, and evidence outputs
        ↓
Re-pin manifest and update ledger/public representation
        ↓
Run primary gate; inspect diff; commit atomic evidence packet
        ↓
Record remaining blocker or verified closure for the next contributor
```

The workflow is intentionally strict. A contribution that only changes code, only changes corpus bytes, only changes UI copy, or only changes a checksum is incomplete if the associated contracts, tests, outputs, manifest effects, and continuation record no longer agree.

## 5. Clean-clone audit procedure

Run the following in order after installation. It is valid on Linux, macOS, Windows (using the appropriate Python launcher), and Termux subject to the documented host setup. It has no network, browser, emulator, GUI, or LLM dependency in its primary form.

```bash
python scripts/run_primary_workflow.py --list
python scripts/run_primary_workflow.py
git diff --check
git status --short
```

The full launcher verifies the regeneration manifest, runtime resources, retained game corpus, reverse-engineering corpus, static report, documentation integrity, static analysis, and tests. A nonzero exit is a diagnosis boundary: preserve the printed verifier failure, locate the corresponding input/contract/test/manifest entry, and repair the inconsistency. Do not overwrite a hash, remove a test, or downgrade a failure into an undocumented local exception.

## 6. Local/CI parity contract

CI is a clean-clone consumer, not a different product. The Pages workflow invokes `python scripts/run_primary_workflow.py` before it stages the public report; CI then builds the viewer and verifies the deployed page’s report JSON against the committed SHA-256. Local and CI results may differ only in **declared host metadata** such as OS image and patch-level Python version. They may not differ in evidence counts, verified manifest results, report hash, documentation validity, test outcome, or command ordering.[1]

| Comparison dimension | Local expectation | CI expectation | Unacceptable divergence |
| --- | --- | --- | --- |
| Primary command plan | `run_primary_workflow.py --list` | Same launcher in workflow. | A second hidden CI-only verification path. |
| Inputs | Versioned corpus, sources, manifests, reverse evidence. | Fresh checkout of the same revision. | Local-only originals, extracts, logs, binaries, or configuration. |
| Evidence results | Same verifier counts and hash outcomes. | Same counts/outcomes. | Changed artifact/source/derived count or manifest hash without a committed evidence change. |
| Report | `--check` succeeds for committed export. | Committed report is staged and public hash is checked. | Empty temporary corpus, stale JSON, or deployment not matching committed report bytes. |
| Optional tools | Explicit capability state; never needed for primary gate. | Explicit compatible-runner lane when configured. | A hidden manual/GPU/GUI dependency. |

## 7. Future-change documentation gate

Every future contribution must add or update the following before review. This rule applies equally to code, corpus, schema, tools, CI, web report, TUI, decompiler/recompiler, and future ScummVM work.

| Contribution element | Required accompanying record |
| --- | --- |
| Code behavior | Objective, source-module link, input/output contract, error/rejection behavior, tests, and deterministic command. |
| Corpus bytes | Source provenance, original/derived classification, hash lineage, state mutation, manifest impact, and public exposure boundary. |
| Format/profile | Profile dossier, acceptance/rejection rules, real-artifact regression, no-generalization statement, and linked matrix entry. |
| Interpreter/derivative | Exact identity boundary, platform scope, evidence grade, stale-claim handling, and comparison rule. |
| External tool | Version/capability declaration, noninteractive adapter, bounded logs/captures, native comparison, and unavailable-host behavior. |
| Web/TUI behavior | UI evidence contract update, real-report/test fixture, unknown/download behavior, accessibility/interaction notes, and user-visible path. |
| Generated result | Regeneration command, input/output hashes, manifest record, report/ledger refresh, and CI gate result. |
| Open issue | Reproducer, byte range/artifact, current failure, research links, next action, and objective closure criterion. |

`scripts/check_docs.py` enforces relative-link integrity, focused-module headers, Mermaid declaration validity, the global regeneration-policy link, and required continuation/traceability navigation. Code review and the primary gate enforce the remaining executable portions of this table.

## 7.1 Global conflict and issue lifecycle

This rule applies to **every** repository concern: code, corpus bytes, source acquisition, format grammar, checksum, parser decision, decompiler/recompiler, test, verifier, report, TUI, CI, external comparison, emulator observation, and future ScummVM work. A conflict is any disagreement, contradiction, unexpected range overlap, failed hypothesis, failed gate, failed assertion, corrupted/ambiguous input, divergent external result, rejected candidate rule, or implementation defect.

| Lifecycle state | Mandatory repository record | Required next transition |
| --- | --- | --- |
| `observed` | Stable issue identifier; affected artifact/profile/component; exact symptom; source URL or retained path and hash; byte range/reproducer/command when applicable; current non-claim; and next experiment. | Reproduce and classify with deterministic evidence. |
| `investigating` | Competing hypotheses, independent evidence links, retained outputs/logs where permitted, and every rejected rule or failed experiment. | Implement only a bounded, evidence-backed candidate. |
| `implemented_pending_verification` | Code location, expected behavioral change, positive and rejection tests, regeneration command, and generated-output boundary. | Run the relevant deterministic gate and inspect all changed evidence. |
| `resolved_verified` | Root cause; exact implementation and commit reference; real-artifact and malformed-input regression results; regenerated evidence/report/manifest effect; verification command; and remaining non-claims. | Preserve the record as historical resolution evidence. |
| `reopened` | New contradictory evidence, affected previous resolution, fresh reproducer, and revised closure criterion. | Return to `investigating`; never overwrite historical evidence. |

## 7.2 American English policy and evidence-language exception

Every clean-clone contributor must write and maintain project-controlled text in American English. This includes new code comments, exception text, test names, generated JSON schema values, documentation prose, UI labels, logs authored by repository scripts, and commit messages. The deterministic language validator checks the authored source set and treats a detected non-English marker as a documented issue, not a cosmetic suggestion.

The validator excludes immutable preservation-corpus outputs and external evidence whose original bytes, authentic titles, locale markers, websites, source comments, or historical-language commentary are evidence: `preservation_corpus/`, `reverse_engineering/public_sources/`, and `reverse_engineering/public_implementations/`. An exclusion does not permit new project prose in another language; it preserves source authenticity. English metadata must identify the source’s origin and relationship to the project.

> **No silent disappearance.** A passing later commit does not resolve an earlier issue unless the same issue record is updated with the reason, evidence, tests, regenerated outputs, and commit reference that demonstrate closure. Deleting a failing experiment, removing a test, changing a hash, or replacing a narrative without retaining the observed conflict is prohibited.

Every new issue must be added to [`TODO.md`](../../TODO.md) and a focused dossier, ledger entry, or generated evidence record before unrelated work proceeds. Every fix must update the same durable record and its status; where deterministic reproduction is possible, a verifier and regression test must make the observation and resolution replayable from a plain clone.

## 8. Recovery and handoff

Never edit `state.db`, generated report JSON, library manifests, detection tables, or manifest hashes by hand to force a passing result. Regenerate through the responsible script, examine the delta, and keep the original input lineage. If an experiment cannot be made coherent, restore a known committed version through normal version-control recovery and describe the failed reproducer in the applicable blocker/audit record.

At the end of a contribution, the next human or agent must be able to answer these questions from the clone alone:

1. What specific claim or capability changed?
2. Which retained bytes and documentation support it, and what does it **not** prove?
3. Which modules and tests implement and bound it?
4. Which command reproduces it, and which output hash/report/ledger fields must change?
5. What passed locally and in CI?
6. What remains unresolved, and what deterministic next action closes it?

If any question cannot be answered, the contribution is not yet a complete continuation handoff.

## References

[1]: [Primary workflow launcher](../../scripts/run_primary_workflow.py), [Pages CI workflow](../../.github/workflows/pages.yml), and [Pages report contract](../PAGES_REPORT.md).
