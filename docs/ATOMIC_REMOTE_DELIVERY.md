# Atomic Remote Delivery Policy

| Header field | Value |
| --- | --- |
| **Question** | How must a human or agent deliver DAAD Harvester changes so that validated work never remains locally accumulated, unreviewable, or dependent on one workstation? |
| **Evidence scope** | Commit boundaries, focused and full verification, staging hygiene, remote push confirmation, CI observation, and recovery after a failed verification or push. |
| **Non-claims** | This policy does not replace the self-contained regeneration policy, authorize force-pushing, or make an in-progress experiment a releasable result. It governs delivery of already coherent work. |

> **Mandatory delivery rule.** Do not begin a separate concern after a coherent change has passed its relevant verification. Stage that one concern, inspect its diff, create an atomic commit, and push it to the configured remote immediately. A local pass is not a shared project state.

This policy complements the [self-contained regeneration policy](SELF_CONTAINED_REGENERATION.md): the regeneration policy defines what evidence may be promoted; this document defines how a validated change is safely shared so another clean clone can inspect and continue it.

## 1. What is an atomic delivery?

One commit must represent one independently understandable change. It contains only the code, retained inputs, generated outputs, tests, documentation, manifest updates, and work-register change required by that concern. It must not mix a browser layout refinement with an unrelated corpus ingestion, a documentation update with half-written checksum repair code, or timestamped transient logs with retained evidence.

| Delivery unit | Required contents | Must be separate from |
| --- | --- | --- |
| Native behavior change | Responsible source module, positive/rejection regression, contract/documentation update. | Unrelated corpus mutation or UI redesign. |
| Corpus/evidence change | Retained bytes, state/catalog/report outputs, required manifests, verifier result, coverage/claim documentation. | Unrelated source refactor. |
| Public/TUI consumer change | Consumer code, real-data regression or build check, interface contract, changed generated report if required. | Incomplete data-generation implementation. |
| Documentation/control-plane change | Documentation, navigation links, checker/test changes, work-register entry. | Incomplete implementation presented as completed. |

### Layer boundary rule

The following layers are independently testable claims and therefore default to **separate commits**: (1) native data model/export or parser behavior, (2) regenerated corpus/report/manifest evidence, (3) Pages or TUI consumer behavior, (4) tests for one changed layer, and (5) methodology or documentation-control-plane work. A generated output belongs with the smallest behavior change that deterministically produces it; it never licenses unrelated consumer work to join the same commit.

Documentation-only work must ship as a documentation-only commit whenever it does not alter executable behavior. A contributor must stop and split a staged set if its file list tells more than one independently testable story. “It is convenient to push together” is not a valid reason to merge concerns.

## 2. Required delivery sequence

After completing one bounded concern, run its focused tests and every required regeneration/check that its change touches. Inspect the staged diff before committing. A full primary gate is required when the concern affects corpus state, a manifest-pinned output, a primary verifier, or shared documentation navigation.

```bash
# 1. Inspect the boundary. Never stage blindly.
git status --short
git diff --check
git diff -- <paths-for-one-concern>

# 2. Run the relevant deterministic checks.
python scripts/run_primary_workflow.py --quick
# Add focused tests/build commands required by the concern.

# 3. Stage only the reviewed delivery unit.
git add <reviewed-paths>
git diff --cached --check
git diff --cached --name-only
git diff --cached --stat

# 4. Commit and publish immediately.
git commit -m "type(scope): concise evidence-backed change"
git push origin main

# 5. Confirm the shared state and observe CI.
git status --short
git log -1 --oneline
gh run list --repo boolforge/DAAD-harvester --limit 5
```

The primary launcher is the authoritative cross-host command plan. Use its `--list` option to see every native gate; do not maintain a private shell sequence that differs from CI.

> **Staged-scope stop.** Before `git commit`, read the staged file list and staged statistics. If the change combines native behavior, a regenerated artifact, a user interface, and methodology in a way that cannot be described as one independently testable claim, unstage and split it. Push the first verified layer before beginning the next one.

## 3. Staging hygiene and maximum local accumulation

The maximum permitted accumulation is **one currently bounded concern that has not yet passed its relevant checks**. Once those checks pass, it must be pushed before a distinct concern begins. If a change exposes an additional requirement, record it in `TODO.md`, but do not fold its implementation into the already verified commit.

Timestamped operational logs, browser build directories, temporary captures, and local staging directories are not delivery inputs. Retain an output only when a documented contract or manifest requires it; otherwise leave it unstaged. Preserve original byte evidence exactly and never normalize it merely to silence a whitespace check.

### Process-defect record

An earlier evidence-interface delivery combined more changed output and consumer surface than this policy permits. The published history remains intact because it is already shared evidence, but it is recorded as a delivery-process defect rather than normalized as acceptable practice. The corrective action is this layer boundary rule, staged-stat review, separate documentation commits, and immediate pushes after each focused gate. Future contributors must apply the correction prospectively; they must not rewrite shared history to conceal it.

## 4. Failure and recovery

| Condition | Required response | Forbidden shortcut |
| --- | --- | --- |
| Focused or primary check fails | Stop staging, retain the diagnostic, fix the same bounded concern, and rerun the failed check. | Committing a known failure as if it were evidence. |
| Manifest/report mismatch | Regenerate from the documented command, review the changed bytes, re-pin only the regenerated verified output in the same evidence change. | Editing a hash to suppress the mismatch. |
| Push fails | Inspect authentication/remote state, repair the push path, then retry the same reviewed commit. | Rewriting history or discarding the commit. |
| CI differs from local | Treat the difference as a reproducibility defect, retain the CI log, and close it with a regression before claiming parity. | Calling the local run sufficient. |

## 5. Human and agent handoff

A human can follow the command sequence above verbatim. A deterministic agent can read this policy, [`TODO.md`](../TODO.md), the [continuation guide](CONTRIBUTOR_CONTINUATION.md), and the primary launcher’s structured command plan to take the same bounded action. Neither path may depend on an unavailable conversation, private model memory, a personal checkout, or a hidden unstaged patch.

## References

[1]: [Self-contained regeneration policy](SELF_CONTAINED_REGENERATION.md)
[2]: [Clone-to-contribution continuation guide](CONTRIBUTOR_CONTINUATION.md)
[3]: [Requirements, evidence, and continuity contract](requirements/TRACEABILITY_AND_CONTINUITY.md)
