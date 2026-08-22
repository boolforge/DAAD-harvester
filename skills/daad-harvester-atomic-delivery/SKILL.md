---
name: daad-harvester-atomic-delivery
description: Atomic Git delivery for DAAD Harvester. Use whenever an agent finishes a bounded change or prepares a release; require focused checks, staged-scope review, commit, remote push, and recovery without rewriting history.
---

# Atomic delivery

Complete one independently testable concern at a time. Run focused tests, the parallel scheduler, and any affected regeneration checks. Stage only the responsible code, tests, documentation, generated evidence, manifest, and TODO update. Inspect `git diff --cached --check`, `--name-only`, and `--stat` before committing.

Use `python scripts/agent_workflow.py commit --message "type(scope): evidence-backed change"` after staging. It rejects unstaged/untracked files, commits the reviewed scope, and pushes to `origin/HEAD` by default. Never force-push, rewrite shared history, or put credentials in commands, files, logs, or commits. If a push fails, preserve the same commit, record the exact failure, repair authentication safely, and retry it.
