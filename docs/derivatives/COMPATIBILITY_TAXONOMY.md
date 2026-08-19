# DAAD Derivatives and Compatibility Taxonomy

## Why classification matters

Shared terminology does not establish behavioral identity. A preservation pipeline must distinguish original runtime material, compiler output, extensions, independent interpreters, extractors, migration tools, and editors. This classification prevents a compatible runtime from being reported as an original interpreter or an extractor from being mistaken for executable media.

| Component | Classification | Evidence-backed relationship | Harvester treatment |
| --- | --- | --- | --- |
| DAAD / DC | Original authoring and DOS compiler lineage | The official project presents a multi-machine authoring system with target-specific interpreters.[1] | Baseline vocabulary and interpreter profiles. |
| DRC | Modern compiler replacement | Documented replacement for the original DOS DC compiler.[2] | DRC V2/V3 DDB layouts are structurally parsed. |
| Maluva | Runtime-side extension | Extends selected targets with external graphics, text, and save/load mechanisms.[2] | Preserve extension media and claims separately from core DDB identity. |
| MSX2DAAD | Independent compatible interpreter | Documents V2/Maluva compatibility and V3 auto-detection from v3.0.0, with documented differences.[3] | Do not label as original MSX runtime without its own hash/source evidence. |
| PCDAAD | DOS VGA/VESA compatible runtime | Documents both supported behavior and explicit feature divergences.[4] | Treat as a separate runtime family, not a transparent replacement. |
| DAAD Ready | Packaging/build/test suite | Uses a modern tool ecosystem around DAAD-oriented targets.[5] | Source-side/package evidence, not a runtime identity. |
| UnDAAD | Database extractor | Archaeology/reference tool for database recovery.[5] | Useful analysis reference; not proof a payload is executable. |
| PAWS2DAAD / unPAWs | Migration/extraction tools | Related-system conversion and extraction tooling.[5] | Explicitly non-DAAD binary evidence. |
| EAAD | Source editor/generator | Source-side authoring aid.[5] | Not an interpreter or DDB-format verifier. |

## Compatibility reporting model

Each artifact may accumulate several true statements. For example, an MSX disk could contain a structurally verified V3 DDB, an MSX2DAAD loader name, and external Maluva assets. These are distinct evidence items:

| Claim | Permitted evidence | Prohibited shortcut |
| --- | --- | --- |
| “V3 DDB” | Successful measured DDB V3 structural validation. | Calling every `.ddb` V3. |
| “Official MSX interpreter binary” | Exact SHA-256 against a tracked official profile. | Matching `MSXEDI.Z80` by name only. |
| “MSX2DAAD-compatible” | A documented derivative runtime or its exact profile plus a documented format match. | Inferring compatibility from the MSX platform. |
| “Uses Maluva” | Recognized extension layout/assets and provenance. | Treating all external graphics as Maluva. |

> **Compatibility is feature-scoped.** When a derivative documents a difference—such as PCDAAD’s unsupported calls or MSX2DAAD’s V3 behavior—the difference is preservation evidence, not a defect to hide.[3] [4]

## References

[1]: https://github.com/daad-adventure-writer/daad "Official DAAD distribution"
[2]: https://medium.com/@uto_dev/maluva-and-drc-e1f655f9cff1 "Maluva and DRC"
[3]: https://github.com/nataliapc/msx2daad "MSX2DAAD"
[4]: https://github.com/Utodev/PCDAAD "PCDAAD"
[5]: https://uto.speccy.org/ "Uto project index"
