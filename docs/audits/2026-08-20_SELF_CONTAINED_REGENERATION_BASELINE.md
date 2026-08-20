# Global Self-Contained Regeneration Baseline Audit — 2026-08-20

| Audit field | Value |
| --- | --- |
| **Question** | Which current DAAD Harvester result families already have a repository-native regeneration or integrity path, and which must not yet be treated as self-contained primary results? |
| **Evidence scope** | P1 local command outputs, committed manifests, and hash verification under the mandatory [self-contained regeneration standard](../SELF_CONTAINED_REGENERATION.md). |
| **Status** | baseline audit; mandatory conversion register, not a final-completeness claim |
| **Commands executed** | `python3 scripts/verify_regeneration_manifest.py`; `python3 scripts/verify_game_corpus.py`; `python3 scripts/verify_runtime_resources.py`; `python3 scripts/verify_reverse_corpus.py`; `python3 scripts/check_docs.py`; `pytest -q` |
| **Non-claims** | A successful integrity verifier does not recreate original physical media, prove a tool’s semantic interpretation, or establish emulator equivalence. It proves the specific retained primary inputs and outputs can be checked without invoking an external application. |

> **SELF-CONTAINED REGENERATION: REQUIRED.** This audit applies the permanent global directive to all preservation domains. A result with an external tool history is not disqualified, but the tool must be classified as acquisition-only or an independent validator until a repository-native primary path is committed, hash-pinned, and tested.

## Audit result summary

| Domain | Repository-native command | Observed baseline result | Primary-path classification | Mandatory next action |
| --- | --- | --- | --- | --- |
| Original C64 Jabato raw-TAP evidence | `scripts/regenerate_jabato_c64_tap_evidence.py --check` | Recreates and byte-verifies the two committed raw-TAP reports from retained TAP, RAM, and DDB inputs. | **Registered primary path** in the regeneration manifest. | Extend from reference-linked partial frames to generic complete physical payload recovery. |
| Original C64 Jabato runtime DDB recovery | `scripts/verify_jabato_c64_runtime_recovery.py` | Structurally validates and byte-compares Part 1 and Part 2 directly from retained 64 KiB RAM captures. | **Registered primary path** in the regeneration manifest. | Add native recovery verifiers for ASS D64 comparison once the controlled variant path is acquired. |
| Retained all-platform game corpus | `scripts/verify_game_corpus.py` | Verifies 249 source records and 59 retained artifacts against the committed SQLite ledger and SHA-256 values. | **Registered repository-native integrity path.** | Add corruption regression and a deterministic report fixture before treating the ledger as a registered primary report source. |
| Commodore supporting runtime resources | `scripts/verify_runtime_resources.py` | Verifies eight firmware/resources and four captures against the committed manifest, authorization directive, and symlink layout. | **Registered repository-native integrity path.** | Retain native conversion/extraction checks for every capture result. |
| Reverse-engineering corpus | `scripts/verify_reverse_corpus.py` | Verifies 42 originals, 769 public-source files, 2,580 ADP mirror files, two comparison records, and 294 derived outputs. | **Registered repository-native integrity path only.** | Native semantic regeneration of any promoted decompilation remains required. |
| Static report and Pages artifact | Existing static exporter and report tests. | Browser-safe export is deterministic from persisted state, but a globally registered clean-input/output report fixture is not yet retained. | **Conversion required.** | Add a committed minimal state fixture, native report regeneration command, output hash, and manifest entry. |
| TUI recordings/screenshots | Retained capture materials and capture documentation. | Some recording creation historically uses terminal/recording facilities outside the core parser. | **Conversion required.** | Retain an input state fixture and native deterministic renderer or mark the media as non-primary illustrative evidence. |
| Format/media parsers | Native Python parser tests and real-artifact fixtures. | Parser acceptance/rejection is already tested locally, but each promoted corpus output is not yet manifest-registered. | **Conversion required.** | Attach all promoted parser reports to declared input/output manifests; retain optional external tools only as validators. |

## Native registry baseline

The committed [`regeneration_manifest.json`](../../preservation_corpus/regeneration_manifest.json) now contains five network-free primary entries. Its verifier checks 16 immutable inputs and 12 outputs, then runs only source-controlled Python commands. The first two entries cover original Side A/Side B raw-TAP evidence and original-runtime RAM-to-DDB recovery. The remaining entries validate the all-platform retained corpus ledger, Commodore runtime-resource ledger, and reverse-engineering corpus records. VICE, c64tapedecode, ADP, Ghidra, radare2, and architecture-specific disassemblers are explicitly classified as non-primary corroborators or acquisition-time tools.[1]

The registry is intentionally small at this baseline. A low registry count is not evidence that other domains are exempt; it is a visible conversion backlog. Each domain in the table must either gain a registered primary path or remain explicitly non-promoted until it does.

## External-tool disposition

| Tool or service family | Retained scientific role | Permitted current classification | Prohibited role |
| --- | --- | --- | --- |
| VICE and other emulators | Acquire controlled runtime captures; independently test observed behavior. | Acquisition-time runtime producer and validator. | Required executable for regenerating a promoted downstream hash or report. |
| Ghidra, radare2, and static disassemblers | Produce redundant comparison artifacts and aid investigation. | Independent analysis validator. | Sole primary source of a promoted decompilation or semantic claim. |
| ADP, c64tapedecode, and public implementations | Compare behavior/bytes against independently retained tools. | Independent corroborator. | Substitution for native extraction or structural validation. |
| Browser sessions, archive sites, and APIs | Discover and acquire source material. | Provenance/acquisition method. | Required network dependency for rerunning a promoted result. |
| Screenshot, terminal-recording, and visualization software | Produce illustrative material from retained states. | Non-primary presentation output until a native reproducible renderer is registered. | Sole evidence for a binary, loader, or runtime conclusion. |

## Enforcement outcome

The global policy is linked and checked from the root README, documentation index, research methodology, evidence model, static-report contract, authorization/handling policy, and architecture-specific workflow contract. The documentation checker fails if any of those required policy links disappears. The full test suite contains the manifest verifier, making an invalid registered native path a continuous-integration failure even though external package installation remains best-effort and non-primary.[2]

## Required follow-through

The next audit iteration must register the all-platform game-corpus and runtime-resource integrity paths, then establish a clean fixture for static report regeneration. Reverse-engineering outputs require the stricter distinction documented above: native hash verification may preserve and compare externally generated artifacts, but no semantic conclusion should be promoted until a repository-native transformation or verifier covers the exact claim. This rule remains active for every future source, platform, loader, decompiler, report, and ScummVM evidence record.

## References

[1]: [Hash-pinned regeneration manifest](../../preservation_corpus/regeneration_manifest.json), [manifest verifier](../../scripts/verify_regeneration_manifest.py), [C64 TAP report command](../../scripts/regenerate_jabato_c64_tap_evidence.py), and [C64 runtime recovery command](../../scripts/verify_jabato_c64_runtime_recovery.py)
[2]: [Global self-contained regeneration standard](../SELF_CONTAINED_REGENERATION.md), [documentation policy-link gate](../../scripts/check_docs.py), and [manifest regression test](../../tests/test_regeneration_manifest.py)
