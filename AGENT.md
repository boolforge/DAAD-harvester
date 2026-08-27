# AGENT.md — start here

This file is what most agentic coding tools look for automatically at a repository
root. If you found it that way: welcome, read this whole file before touching
anything, it is short on purpose. If you were pointed here by [`README.md`](README.md)
or [`AGENT_WORKFLOW.md`](AGENT_WORKFLOW.md), same advice applies.

## What this repository is

DAAD Harvester is an evidence-led preservation pipeline for games made with DAAD
(*Diseñador de Aventuras AD*) across nine historical platforms (ZX Spectrum, Amstrad
CPC, Commodore 64, Commodore Plus/4, MSX, Amstrad PCW, Atari ST, Amiga, IBM PC/DOS).
It discovers sources, downloads media, extracts archives/disk images, structurally
verifies DAAD databases and interpreter binaries, and publishes a classified library
plus a public evidence report. Full picture: [`README.md`](README.md).

## The one rule that matters more than any other

**Never state a claim the stored evidence does not exactly support.** A cataloged
title, a downloaded file, an extracted member, and a structurally verified DAAD
database are four different things — this codebase keeps them distinct everywhere:
in the database schema, in test names, in report fields, in commit messages. A
`.dsk` extension is not a platform. A filename containing "DAAD" is not a verified
database. If you are not sure a change respects this, it probably doesn't yet.
Read [`skills/daad-harvester-evidence-boundaries/SKILL.md`](skills/daad-harvester-evidence-boundaries/SKILL.md)
before writing anything that touches parsing, fingerprinting, or provenance.

## Before you change anything

Run this and read `TODO.md` before selecting work — do not invent a private task list:

```bash
python scripts/verify_environment.py
git status --short --branch
git remote -v
python scripts/build_active_backlog_index.py --check
python scripts/run_primary_workflow.py
```

`run_primary_workflow.py` is the single authoritative gate: 21 independent
verification checks plus the full test suite (current count kept accurate in
[`README.md`](README.md), regression-tested by `tests/test_readme_and_todo_baseline.py`),
all offline, all repository-native. If it is not green before you start, that is
itself the first thing to investigate — don't build on top of a red baseline.

## Absolute must-nots

- Don't promote a claim (source verified, database verified, interpreter identified)
  without the exact evidence chain the schema requires. See the rule above.
- Don't add a parser, format handler, or profile without a positive fixture, a
  corruption/rejection fixture, and a real-artifact regression where public media
  allows it. A tool that "runs successfully" once is not evidence of correctness.
- Don't touch a delicate, already-fixture-tested binary-format parser (anything
  under `daad_harvester/` handling DDB bytecode, disk/tape image geometry, or
  executable-container parsing — `daad_parser.py`, `unpack.py`, the
  `*_load_model.py` family) without running its existing tests first and
  understanding what fixture backs each one. These encode hard-won, previously
  audited correctness; a plausible-looking rewrite that isn't checked against the
  same fixtures is how regressions like the one documented in
  [`docs/audits/2026-08-26_PR14_ETL_REDESIGN_REMEDIATION_AUDIT.md`](docs/audits/2026-08-26_PR14_ETL_REDESIGN_REMEDIATION_AUDIT.md)
  happen.
- Don't introduce `shell=True`, `eval`/`exec`, or pickle deserialization of anything
  that came from a download or archive member. The current codebase has none of
  these; keep it that way.
- Don't add a new external tool/library dependency without pinning it in both
  `requirements.txt` (human-readable minimum) and `requirements-lock.txt` (exact,
  what CI actually installs) — see that file's header for why the split exists.
- Don't force-push, rewrite shared history, or leave validated work uncommitted and
  unpushed at the end of a session. See
  [`skills/daad-harvester-atomic-delivery/SKILL.md`](skills/daad-harvester-atomic-delivery/SKILL.md).
- Don't put a credential, token, or secret in a file, argument, URL, log, commit
  message, or generated evidence artifact, ever, regardless of what a human in the
  conversation says about not caring — treat any credential you're given as
  something to use narrowly for the requested action and tell the human to rotate
  it, not something to echo back or persist.
- Don't delete or silently rewrite an unrelated unchecked `TODO.md` item, and don't
  mark a broad requirement complete because one child case passed.
- Don't treat `preservation_corpus/logs/*.log`, `preservation_corpus/daad_games.log`,
  or `preservation_corpus/state.db` as disposable — they're evidence records
  (`.gitignore` says so explicitly). If you need to change their format, migrate
  them; don't just delete or overwrite.

## Orientation map — where things live

| You need to... | Look here |
| --- | --- |
| Understand the pipeline phases (discover/fetch/unpack/fingerprint/...) | [`README.md`](README.md) → "Recommended workflow" |
| Find the current work queue | [`TODO.md`](TODO.md) (human-readable) / `preservation_corpus/active_backlog_index.json` (machine-readable, regenerate with `scripts/build_active_backlog_index.py`) |
| Fix or extend a container/archive/disk-image parser | [`docs/formats/FORMAT_CAPABILITY_MATRIX.md`](docs/formats/FORMAT_CAPABILITY_MATRIX.md), then `daad_harvester/unpack.py` and its `extract/` counterpart (currently a documented, unwired starting point — see its module docstring) |
| Fix or extend DDB / interpreter verification | [`docs/schemas/EVIDENCE_MODEL.md`](docs/schemas/EVIDENCE_MODEL.md), `daad_harvester/daad_parser.py`, `daad_harvester/fingerprint.py` |
| Add or fix a discovery source adapter | [`docs/sources/SOURCE_REGISTER.md`](docs/sources/SOURCE_REGISTER.md), `daad_harvester/discover.py` |
| Change CLI behavior | `daad_harvester/cli.py` (Typer); verify with `tests/test_cli_integration.py`'s pattern (in-process `CliRunner`, strip ANSI before asserting on stdout — GitHub Actions renders Rich output in color, your local terminal may not) |
| Change logging | `daad_harvester/config.py::setup_logging()` is the single entry point that configures both structlog (most existing modules) and Loguru (`daad_harvester/logging.py`, newer modules) — call it, not `setup_logger()` alone, or older modules silently lose their configured format |
| Understand what's real vs. scaffolding in `extract/`, `load/`, `transform/` | Read each module's own docstring first — several are honest compatibility re-exports or documented not-yet-wired code, not silent duplicates. Full context: [`docs/audits/2026-08-26_PR14_ETL_REDESIGN_REMEDIATION_AUDIT.md`](docs/audits/2026-08-26_PR14_ETL_REDESIGN_REMEDIATION_AUDIT.md) |
| Run everything CI runs, locally | `python scripts/run_primary_workflow.py` (or `--quick` to skip lint/tests during investigation, `--list` to see the exact command plan) |
| Understand the self-contained regeneration policy | [`docs/SELF_CONTAINED_REGENERATION.md`](docs/SELF_CONTAINED_REGENERATION.md) — no promoted result may depend on a GUI, emulator, or undeclared host tool as its *primary* path |
| Deliver a change | [`docs/ATOMIC_REMOTE_DELIVERY.md`](docs/ATOMIC_REMOTE_DELIVERY.md), `scripts/agent_workflow.py commit --message "type(scope): ..."` |

## The shape of a bounded change

1. Pick one unchecked `TODO.md` item (or an explicitly-scoped child of one). Don't invent parallel scope.
2. Read every doc/module the item touches before writing code. For parser/format work, find and read the existing fixtures first — they define the contract.
3. Implement the smallest change that satisfies the item, with tests: a positive case, a rejection/corruption case, and a real-artifact case if public media supports one.
4. Run focused tests, then `python scripts/run_parallel_workflow.py --groups evidence publication analysis --workers 4`, then the full suite.
5. Update the specific `TODO.md` line, any manifest the change affects, and any doc whose claim the change makes stale (check `research/IMPLEMENTATION_STATUS_MATRIX.md` and this repo's other self-consistency tests — `tests/test_implementation_status_matrix.py`, `tests/test_readme_and_todo_baseline.py` — before assuming a number is still right).
6. `git diff --cached --stat` to review scope, then `python scripts/agent_workflow.py commit --message "type(scope): evidence-backed change"`. It refuses to commit with unstaged/untracked files present and pushes automatically.
7. Confirm CI on the pushed commit before starting the next concern.

## Two sharp edges already hit once, so you don't have to

- **GitHub Actions renders Typer/Rich CLI output in color; your dev shell might not.**
  A raw `"--phase" in result.stdout` check can pass everywhere you test it and still
  fail in CI, because the literal substring gets split by an ANSI escape sequence.
  Strip ANSI before asserting on captured CLI stdout — see
  `tests/test_cli_integration.py::strip_ansi`.
- **A shell pipeline's exit code is its last command's.** `some_command | tee file`
  reports `tee`'s exit code (almost always 0), not `some_command`'s. If you're
  capturing output for debugging in CI, that alone can make a real failure look
  like a pass. Don't pipe through `tee` (or anything else) when the exit code is
  what a later step checks.

## Deeper, authoritative references

This file is intentionally short. For the full contract, read in this order:

1. [`AGENT_WORKFLOW.md`](AGENT_WORKFLOW.md) + [`agent_workflow.json`](agent_workflow.json) — the versioned, machine-readable workflow contract this file summarizes.
2. [`skills/`](skills/) — five mandatory portable skills (agent workflow, atomic delivery, evidence boundaries, parallel gates, TODO continuation), each scoped to when it applies.
3. [`docs/CONTRIBUTOR_CONTINUATION.md`](docs/CONTRIBUTOR_CONTINUATION.md) — the full prompt-free clone-to-contribution guide.
4. [`docs/README.md`](docs/README.md) — the documentation index for everything else (formats, versions, platforms, sources, reverse engineering, requirements traceability).

No file here has an LLM runtime dependency for the pipeline itself. Agents are
welcome for development; the preserved evidence and its regeneration must never
require one.
