# Clone-to-Contribution Continuation Guide

| Header field | Value |
| --- | --- |
| **Question** | How can a human contributor or an automated development agent continue DAAD Harvester from a plain clone without private prompts, model memory, hidden files, or undocumented workstation state? |
| **Evidence scope** | Repository bootstrap, deterministic primary verification, evidence vocabulary, change protocol, active-blocker handoff, optional-validator boundary, and review/recovery procedure. |
| **Status** | Mandatory contributor workflow; maintained alongside the self-contained regeneration policy and verification gates. |
| **Non-claims** | This guide does not assert that every historical format or game is already solved. It explains how to locate, reproduce, and close every recorded gap without treating an unresolved state as final support. |

> **Authoritative continuation rule.** A plain repository clone must contain sufficient versioned instructions, commands, tests, manifests, inputs, and evidence records for a new human or agent to verify the current state, understand the next task, make a bounded change, and prove its result. No preservation-critical action may depend on this conversation, an LLM prompt, an undisclosed credential, or a preconfigured personal workstation.

This guide complements the mandatory [self-contained regeneration policy](SELF_CONTAINED_REGENERATION.md). The policy defines what may be promoted as primary evidence; this guide defines how a new maintainer works safely and deterministically.

The repository-wide [requirements, evidence, and continuity contract](requirements/TRACEABILITY_AND_CONTINUITY.md) defines the mandatory handoff record for every concern and future change. Read it after this guide’s orientation sections when planning or reviewing a modification. The [atomic remote delivery policy](ATOMIC_REMOTE_DELIVERY.md) is equally mandatory once a bounded change has passed its relevant checks: validated work is committed and pushed before an unrelated concern begins.

> **Language requirement.** Write every project-authored contribution in **American English**: code comments, identifiers, documentation, tests, generated evidence, UI strings, script output, and commit messages. External sources, original code, archival material, websites, third-party documents, and retained artifact bytes may be in any language; do not translate, normalize, or alter them when they are preservation evidence in their documented immutable source paths. Report any authored-language exception immediately through the global issue record.

Keep official DAAD terminology and authentic game, person, and place names in their established spelling. A title such as *Chichén Itzá* is a proper name, not a license to add Spanish prose. Every such name must remain in the reviewed deterministic allowlist.

## 1. Distinguish host automation from historical target coverage

The project has two independent platform dimensions. **Host support** means the deterministic Python workflow runs on Linux, macOS, Windows, and Termux. **Target coverage** means the evidence model and native parsers cover DAAD artifacts for ZX Spectrum, Amstrad CPC, C64, Plus/4, MSX, PCW, Atari ST, Amiga, and IBM PC/DOS. A successful host run never proves every historical target is complete; the [format capability matrix](formats/FORMAT_CAPABILITY_MATRIX.md) and [coverage ledger](../preservation_corpus/COVERAGE_LEDGER.md) record the target-specific state.

| Workflow class | Required on every supported host | May be unavailable on some hosts | Authority |
| --- | --- | --- | --- |
| Primary preservation workflow | Native parsers, corpus/resource/manifests checks, deterministic report regeneration, byte/hash comparisons, tests, and documentation checks. | Never. A missing primary dependency is a release-blocking installation defect. | Sole authority for promoted reproducible result. |
| Acquisition/independent validator | Automation adapter, fixed configuration, bounded command, retained logs/captures, hash comparison to native result. | Yes. The adapter must report a clear `unavailable` capability state and the primary workflow remains valid. | Corroboration or acquisition only. |
| Interactive investigation | None. It must be converted into an automated bounded adapter or recorded as an investigation note. | N/A. | Never a promotion prerequisite. |

## 2. Clone and install

Use Python 3.10 or newer. The primary path requires only repository code and declared Python dependencies. Do **not** install VICE, Ghidra, radare2, a browser, or an LLM to verify retained primary evidence.

| Host | Prerequisites | Bootstrap |
| --- | --- | --- |
| Linux (Debian/Ubuntu) | `python3`, `python3-venv`, `python3-pip`, `git` | `sudo apt-get update && sudo apt-get install -y python3 python3-venv python3-pip git` |
| macOS | Python 3.10+, Git | Install Python and Git by the organization’s managed method, then use the common bootstrap. |
| Windows PowerShell | Python 3.10+ and Git on `PATH` | Use `py -3 -m venv .venv`, then `.\.venv\Scripts\Activate.ps1`. |
| Android Termux | `python`, `git` | `pkg update -y && pkg install -y python git` |

The common bootstrap is deliberately host-neutral:

```bash
git clone https://github.com/boolforge/DAAD-harvester.git
cd DAAD-harvester
python3 -m venv .venv
# POSIX shells:
source .venv/bin/activate
# Windows PowerShell instead:
# .\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -e ".[dev]"
```

If `python3` is unavailable on Windows, replace it with `py -3`. A missing optional validator is **not** an installation failure. A missing declared Python dependency, a failing native verifier, or a manifest hash mismatch is an actionable primary-workflow failure and must not be ignored.

## 3. First command: verify the committed state offline

Run the following before editing code, documentation, corpus state, or generated outputs. These commands do not need a network connection and do not invoke emulators or GUI applications.

```bash
# Independent read-only gates run concurrently and report all failures together:
python scripts/run_parallel_workflow.py --groups evidence publication analysis --workers 4

# Ordered release gate, including any commands that require sequencing:
python scripts/run_primary_workflow.py
# Equivalent expanded plan follows for diagnostics or individual reruns:
python scripts/verify_regeneration_manifest.py
python scripts/verify_runtime_resources.py
python scripts/verify_game_corpus.py
python scripts/verify_artifact_checksums.py
python scripts/verify_reverse_corpus.py
python scripts/check_docs.py
python -m pyflakes daad_harvester scripts
pytest -q
```

`python scripts/run_parallel_workflow.py --groups evidence publication analysis --workers 4` is the preferred fast path for independent read-only checks. Its allowlisted gates use isolated subprocesses, bounded concurrency, captured output, deterministic reporting, and aggregate failure status. `python scripts/run_primary_workflow.py --list` prints the exact ordered cross-host command plan without running it. `--quick` runs only the deterministic corpus/report/documentation verification portion. Neither form invokes a network endpoint, GUI application, emulator, external disassembler, or LLM.

`python scripts/verify_artifact_checksums.py --backfill` is the controlled historical repair command. It rereads retained bytes and fills only absent canonical digest fields; it fails rather than overwriting a stored mismatch. Normal verification is read-only and is part of the primary workflow, so a retained artifact with missing or divergent checksum evidence blocks promotion.

> A manifest mismatch is not database corruption by itself. It says that a hash-pinned state or generated output changed after a controlled operation and must be regenerated, remeasured, reviewed, and explicitly re-pinned in the same evidence change. Never edit a manifest hash merely to make a failure disappear.

## 4. Read in this order

| Order | Document or artifact | Why it is read before making changes |
| --- | --- | --- |
| 1 | [`README.md`](../README.md) | Project purpose, host installation, target matrix, and entry-level commands. |
| 2 | [Self-contained regeneration policy](SELF_CONTAINED_REGENERATION.md) | Primary versus external authority, manifest contract, and promotion gate. |
| 3 | [`TODO.md`](../TODO.md) | Active obligations, non-terminal blockers, and required closure rules. |
| 4 | [Format capability matrix](formats/FORMAT_CAPABILITY_MATRIX.md) | Required parser/media behavior and profile-dossier contract. |
| 5 | [Evidence model](schemas/EVIDENCE_MODEL.md) | What each persisted claim means and how confidence is bounded. |
| 6 | [Coverage ledger](../preservation_corpus/COVERAGE_LEDGER.md) | Exact current corpus scope, source outcomes, verified facts, and remaining loops. |
| 7 | Relevant platform/format/loader dossier | The retained sample, acceptance/rejection contract, and current implementation boundary. |
| 8 | Relevant tests and manifest entry | Executable contract, input/output hashes, and regression boundary. |

## 5. Vocabulary that must not be conflated

| Term | Meaning | Must not be mistaken for |
| --- | --- | --- |
| **Source** | A provenance record for a URL, archive, release, catalog page, or distribution. | A verified binary or game. |
| **Artifact** | Retained original, container, member, capture, or derived byte sequence with hashes. | A semantic DAAD claim by filename alone. |
| **Profile** | Documented physical/logical media contract with retained examples and acceptance/rejection tests. | A permanent whitelist that silently excludes future coherent variants. |
| **Primary result** | Repository-native, hash-pinned, network-free reproducible claim. | A screenshot, emulator observation, or external tool output alone. |
| **External validator** | Automated optional corroborator or acquisition producer. | A required dependency for regeneration. |
| **Blocker** | An explicit active implementation/research loop with a reproducer and closure criteria. | A final unsupported outcome. |

## 6. Change protocol: add or repair one evidence profile

Follow this sequence for every parser, loader, decompiler, runtime, or variant change.

1. **Retain and identify the input.** Preserve source URL/provenance, original bytes, SHA-256, and exact observed behavior. Do not normalize away the original medium.
2. **Write the contract.** Create or extend the relevant format-profile dossier with the question, evidence scope, non-claims, primary references, byte/geometry/load assumptions, and an explicit rejection boundary.
3. **Implement minimally and deterministically.** Change native code only enough to satisfy the measured contract. Do not broaden a rule from one platform or sample to another without evidence.
4. **Test failure as well as success.** Add generated positive fixtures, malformed/corruption fixtures, and at least one retained-real-artifact regression. Test cross-platform contamination and stale-state replacement where relevant.
5. **Regenerate through repository code.** Refresh only the affected corpus, fingerprint, library, report, and evidence outputs using committed commands. Re-run the offline gate.
6. **Register promoted evidence.** Add a manifest entry with all input/output hashes, declared dependencies, a local command, and an empty or explicit external-validator list.
7. **Update the ledger and documentation.** Record what changed, what exact claim is now verified, and what remains open. Update the static report if its state changed.
8. **Commit and push one layer at a time.** A commit may contain one coherent evidence claim and its direct code, tests, generated evidence, manifest, and documentation. Before committing, read `git diff --cached --name-only` and `git diff --cached --stat`; if the staged set tells more than one independently testable story, unstage and split it. Push immediately after the relevant gate passes, confirm remote/CI state, and only then begin an unrelated concern. Follow the [atomic remote delivery policy](ATOMIC_REMOTE_DELIVERY.md); do not accumulate locally validated changes or bundle methodology with unrelated implementation.

## 7. Working on a blocker

Every blocker must include a reproducer, the retained byte range or artifact, the platform/profile context, a precise current failure, and the verified closure condition. Use [`TODO.md`](../TODO.md) for the work obligation and the [coverage ledger](../preservation_corpus/COVERAGE_LEDGER.md) for corpus-specific status.

For a new observation, do not create an “unsupported” terminal category. Instead, record the input and run this loop:

```text
retained sample → primary/reference research → documented contract
→ native implementation → positive/negative/real-artifact tests
→ deterministic regeneration → manifest/report/ledger refresh → verification gate
```

If a live tool is needed to acquire a new observation, automate its bounded invocation where possible and retain its configuration, log, capture, and hashes. Then build a native verifier over the retained output. The acquisition runtime must not become a required future replay step.

### 7.1 Global conflict and issue recording rule

For the entire project, an issue is not merely a task comment or a failed terminal command. Every conflict, discrepancy, rejected hypothesis, malformed/corrupt or ambiguous input, test/CI failure, external-source disagreement, unexpected byte overlap, or implementation defect must be recorded immediately in versioned repository material before unrelated work continues. Add a concrete unchecked work item to [`TODO.md`](../TODO.md) and create or update a focused dossier, ledger row, or deterministic evidence record.

The observation record must contain the affected artifact/profile/component, exact symptom, retained path and hashes or external evidence source, byte range/reproducer/command where applicable, non-claim, candidate hypotheses, and next experiment. When the issue is fixed, **update the same record** with the root cause, implementation location and commit, positive/rejection/real-artifact regressions, regenerated output impact, verification command, and remaining boundary. Never delete an issue record just because a later pass is green; a resolution without recorded causal evidence is incomplete. See the normative [global conflict and issue lifecycle](requirements/TRACEABILITY_AND_CONTINUITY.md#71-global-conflict-and-issue-lifecycle).

### 7.2 American English and authentic-source boundary

The deterministic authored-language check is part of the primary workflow. Before review, run `python scripts/check_american_english.py` and treat a failure as an open issue. The check applies to every project-authored text surface and deliberately excludes the generated/retained `preservation_corpus/` plus original third-party mirrors under `reverse_engineering/public_sources/` and `reverse_engineering/public_implementations/`. The exclusion preserves evidence fidelity; it never authorizes non-English text in a new project-controlled file. The normative policy is [American English policy and evidence-language exception](requirements/TRACEABILITY_AND_CONTINUITY.md#72-american-english-policy-and-evidence-language-exception).

## 8. Optional validators and acquisition tools

Optional tools are automated where feasible, but their role remains explicit. An adapter must expose its install/capability state, use noninteractive arguments and bounded execution, retain outputs and logs, and compare them against native evidence. On a host where a validator cannot run, the adapter must emit an actionable `unavailable` result; it must not block the primary verification gate.

The required distinction is summarized in the [architecture workflows](reverse_engineering/ARCHITECTURE_WORKFLOWS.md) and the [authorization/handling policy](reverse_engineering/AUTHORIZATION_AND_HANDLING.md). Never silently replace a native parser result with an emulator screenshot, a disassembler report, or a model-generated interpretation.

## 9. Generated state, recovery, and review

`preservation_corpus/state.db`, extracted members, library manifests, reports, logs, and evidence JSON are versioned evidence outputs. Do not hand-edit SQLite rows or generated hashes. Use the relevant pipeline or regeneration script, inspect the resulting diff, and re-run the manifest verifier. If an experiment is not salvageable, restore a known version through the project’s documented version-control/recovery workflow rather than preserving a mixed generated state.

Before review, confirm all of the following:

```bash
git diff --check
python scripts/verify_regeneration_manifest.py
python scripts/check_docs.py
pytest -q
git status --short
```

Reviewers should be able to identify, from the commit alone, the exact input, claim, parser/reasoning change, tests, deterministic command, output hashes, documentation, and remaining boundary.

## References

[1]: [Project entry point and host installation](../README.md)
[2]: [Self-contained regeneration policy](SELF_CONTAINED_REGENERATION.md)
[3]: [Format capability matrix](formats/FORMAT_CAPABILITY_MATRIX.md)
[4]: [Evidence model](schemas/EVIDENCE_MODEL.md)
[5]: [Coverage ledger](../preservation_corpus/COVERAGE_LEDGER.md)
[6]: [Regeneration manifest](../preservation_corpus/regeneration_manifest.json)
