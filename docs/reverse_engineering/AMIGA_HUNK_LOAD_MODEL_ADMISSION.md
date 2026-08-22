# Amiga Hunk Container and Relocation Boundary

| Header field | Value |
| --- | --- |
| **Question** | What executable-container facts can be proven for the four retained Amiga interpreter profiles before an AmigaOS runtime model exists? |
| **Evidence scope** | Immutable executable identities, big-endian Hunk header, one allocated code segment, bounded `HUNK_RELOC32` records, and terminal `HUNK_END`. |
| **Status** | Four one-code-segment Hunk containers validate; two record 498 relocations and two record none. |
| **Non-claims** | The contract does not establish LoadSeg allocation addresses, AmigaOS entry, library bases, process state, source recovery, or runtime behavior. |

The four retained profiles begin with `HUNK_HEADER` and define one Hunk allocation
table entry. Each contains one `HUNK_CODE` record, a bounded `HUNK_RELOC32`
record sequence, and a terminal `HUNK_END`. The English profiles each contain
498 bounded relocation offsets; the Spanish profiles each contain 508 bounded
relocation offsets. The validator rejects an altered checksum identity,
unbounded relocation group, relocation outside the code payload, unexpected
target Hunk, or trailing bytes after `HUNK_END`.[1] [2]

```bash
python3 scripts/verify_amiga_hunk_load_model.py
```

The verifier reads and structurally validates the container only. It does not
run AmigaOS, allocate Hunk segments, resolve libraries, invoke a disassembler,
or execute any retained byte.

## References

[1]: [Amiga Hunk source record](../../research/sources/amiga_hunk_format_sources_2026-08-22.md)
[2]: [Architecture-family macroplan](AUTONOMOUS_ARCHITECTURE_FAMILY_MACROPLAN.md)
