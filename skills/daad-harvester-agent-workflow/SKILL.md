---
name: daad-harvester-agent-workflow
description: Portable agent workflow for DAAD Harvester. Use for every operation on this repository, including TODO work, coding, evidence generation, testing, documentation, scheduling, commits, and remote delivery; always use the versioned scheduler and preserve the Git handoff.
---

# DAAD Harvester agent workflow

Use this skill **for every repository operation**. Treat Git as the durable handoff between agents, services, machines, and sessions. Do not rely on private prompts, hidden files, remembered context, local-only schedulers, or workstation state.

## Bootstrap

1. Run `git status --short --branch` and `git remote -v` without printing credentials.
2. Read `TODO.md`, `AGENT_WORKFLOW.md`, `agent_workflow.json`, and `preservation_corpus/active_backlog_index.json`.
3. Refresh and verify the task index:

   ```bash
   python scripts/build_active_backlog_index.py
   python scripts/build_active_backlog_index.py --check
   ```

4. Select one bounded concern. Never delete unrelated TODO items or mark a broad requirement complete because one child check passes.

## Mandatory scheduler

Always use the repository-owned scheduler instead of an agent-private scheduling implementation:

```bash
python scripts/run_parallel_workflow.py \
  --groups evidence publication analysis \
  --workers 4 --timeout 300
```

The scheduler uses an explicit allowlist, isolated subprocesses, bounded concurrency, captured diagnostics, deterministic result ordering, and aggregate failure status. Run only allowlisted read-only gates concurrently. Keep shared-file regeneration and dependent operations ordered or isolated.

Use `python scripts/run_primary_workflow.py` for the full project gate; it uses the parallel scheduler by default. Use `--ordered` only for strict recovery or sequencing diagnostics.

## Change protocol

Read the relevant contract, profile dossier, source module, tests, manifest, and blocker record. Implement the smallest evidence-backed change. Add positive, rejection/corruption, and retained-real-artifact regressions where applicable. Regenerate only outputs owned by the concern through repository-native commands. Update the relevant TODO, dossier, ledger, manifest, or report while preserving unresolved boundaries.

Run focused tests, the mandatory parallel scheduler, and `python -m pytest -q` before delivery.

## Atomic Git delivery

Stage exactly one reviewed concern and use the portable wrapper:

```bash
git diff --check
git add <reviewed-paths>
python scripts/agent_workflow.py commit \
  --message "type(scope): evidence-backed change"
```

The wrapper rejects unstaged or untracked files, checks the staged diff, prints staged names and statistics, commits, and pushes to `origin/HEAD` by default. Use `--no-push` only for an explicitly documented recovery case. Never force-push or rewrite shared history. If push fails, preserve the commit, record the exact failure, repair authentication safely, and retry the same reviewed commit.

## Security and portability

Never place tokens, passwords, cookies, private URLs, or credentials in skill files, source files, arguments, URLs, logs, commits, or evidence. Delegate authentication to the configured Git client. This skill requires only a clean repository, Python 3.10+, Git, and declared project dependencies; it is independent of any particular agent, model, service, operating system, CI provider, or conversation.

## Handoff

Leave one explicit state: **clean and synchronized**, with passing checks and `HEAD` matching upstream; or **bounded in progress**, with only the current concern, failed/pending check, exact next command, and corresponding TODO item documented. Temporary logs and local extracted files are not handoff state.

Read `AGENT_WORKFLOW.md` for the full contract, `agent_workflow.json` for machine-readable defaults, and `docs/PARALLEL_WORKFLOW.md` for group boundaries and concurrency behavior.
