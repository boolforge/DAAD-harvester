# Atari ST PRG Segment and Relocation Boundary

| Header field | Value |
| --- | --- |
| **Question** | What container facts can be verified for four retained Atari ST interpreter PRGs before a TOS runtime model exists? |
| **Evidence scope** | Immutable identities, `0x601A` PRG headers, text/data/BSS lengths, and bounded relocation streams. |
| **Status** | Four PRG containers validate; text/data relocation streams begin at offset 16 and terminate inside each retained file. |
| **Non-claims** | The contract does not establish TOS basepage allocation, process entry, GEMDOS/AES state, source recovery, or runtime behavior. |

The validator checks big-endian segment arithmetic and the compact Atari PRG
relocation stream. It rejects segment overflow, an out-of-image first offset,
an out-of-image delta, missing terminator, trailing relocation bytes, altered
identity, or execution promotion. It reads files only.

Each contract also binds the measured symbol-table size and relocation count.
The retained profiles have zero symbol-table bytes and bounded counts of 708 or
717 relocation sites. These are container observations, not an effective TOS
load address, process entry, symbol recovery, or runtime result.

```bash
python3 scripts/verify_atari_st_prg_load_model.py
```

## References

[1]: [Atari ST platform dossier](../platforms/ATARI_ST.md)
[2]: [Architecture-family macroplan](AUTONOMOUS_ARCHITECTURE_FAMILY_MACROPLAN.md)
