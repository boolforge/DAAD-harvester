---
name: daad-harvester-todo-continuation
description: TODO continuation for DAAD Harvester. Use whenever an agent starts, resumes, prioritizes, or hands off repository work; preserve every pending task, use the machine-readable backlog, and leave reproducible next steps.
---

# TODO continuation

Start from Git, not conversation memory. Read `TODO.md`, regenerate `preservation_corpus/active_backlog_index.json`, and inspect the current branch and remote. Select one bounded unchecked item or an explicitly documented child of a broad item. Do not delete, reorder, or silently rewrite unrelated pending tasks. Do not mark a task complete without its stated evidence, tests, regenerated outputs, and boundary record.

Use the backlog index to group evidence inputs, affected subsystems, dependencies, real-artifact requirements, report impact, and atomic-delivery boundaries. Work independent groups in parallel only when their commands are read-only and isolated. Keep dependent or shared-write operations ordered. Before handoff, run the scheduler and full tests, commit and push the verified concern, and record either a synchronized HEAD or a bounded next command plus its failing check.
