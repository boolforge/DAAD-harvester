# Cross-Tool Verification Protocol

| Header field | Value |
| --- | --- |
| **Question** | How are disassembly and decompilation outputs independently checked before they become a qualified reverse-engineering finding? |
| **Evidence scope** | P1 reproducible multi-tool outputs and measured behavior; P2 public derivative-source comparison where applicable. |
| **Status** | implementation contract |
| **Implementation links** | [`ARCHITECTURE_WORKFLOWS.md`](ARCHITECTURE_WORKFLOWS.md), [`../schemas/REVERSE_ENGINEERING_MANIFEST.md`](../schemas/REVERSE_ENGINEERING_MANIFEST.md), [`../versions/COMPATIBILITY_BOUNDARIES.md`](../versions/COMPATIBILITY_BOUNDARIES.md) |
| **Non-claims** | Agreement between two tools does not prove historical source-level intent, and disagreement does not automatically prove a binary is invalid. |

## Required independent checks

| Claim type | Primary evidence | Independent check | Result if disagreement remains |
| --- | --- | --- | --- |
| Architecture/load model | Header/container/known profile evidence. | Second tool configuration and manual byte-range review. | Record competing models; do not promote code-flow claim. |
| Entry point/control flow | Disassembler control-flow graph. | Independent disassembler or emulator trace where authorized. | Preserve both graphs and unresolved branch set. |
| Procedure boundary | Tool function inference. | Cross-reference/call-site analysis and derivative-source comparison when relevant. | Label `inferred_function_boundary`. |
| Pseudocode behavior | Decompiler output tied to function range. | Original instruction trace and independent decompiler/disassembler review. | Label `tool_derived_hypothesis`. |
| Runtime/DDB behavior | Artifact analysis. | Structural DDB parser/profile/bundle evidence. | Keep runtime and DDB claims separate. |

## No-majority rule

Tool count does not replace evidence quality. A majority of decompilers can share the same incorrect load model; therefore verification must include byte-level ranges, memory map, external entry evidence, and—where lawful/available—observable behavior. The manifest records tool agreement/disagreement explicitly rather than collapsing all outputs into a preferred text file.

## References

[1]: [Architecture-specific workflows](ARCHITECTURE_WORKFLOWS.md)
[2]: [Reverse-engineering manifest schema](../schemas/REVERSE_ENGINEERING_MANIFEST.md)
[3]: [Compatibility boundaries](../versions/COMPATIBILITY_BOUNDARIES.md)
