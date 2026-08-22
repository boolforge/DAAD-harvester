# Spectrum `.SDG` Graphics Database Profile

**Question**: Which byte-level properties of the retained source-250 Spectrum
`.SDG` members can be deterministically validated without claiming a graphics
decoder or renderer?

**Evidence scope**: This dossier records only the Plus3DOS wrapper, the
documented 19-byte Spectrum terminal-header layout, and the measured behavior
of the named retained R4 source-250 members. It is not a generic `.SDG`
recognizer.

**Non-claims**: This profile does not decode picture commands, render graphics,
interpret palettes or character sets, reconstruct cross-DDB semantics, or
identify raw and erased same-extension files as valid graphics databases.

| Field | Verified scope |
| --- | --- |
| **Profile** | Plus3DOS-wrapped Spectrum SDG with the documented 19-byte terminal header. |
| **Real artifacts** | Official R4 source-250 `BLANK.SDG`, `PART1.SDG`, and `PART2.SDG`, each 2,304 bytes with a 2,089-byte declared Plus3DOS payload. |
| **Native claim** | The wrapper checksum and declared lengths validate; the payload terminal header maps to Spectrum RAM `0xFFED`–`0xFFFF`, has required `FFFF` and `0000` sentinels, and carries in-range pointers. |
| **Boundary** | No picture-command, vector-rendering, palette, character-set, or cross-DDB decoding claim is made by this profile. |

## Container and terminal header

The pinned ADP specification defines a Spectrum SDG as a graphics database
whose header is placed at the end of the Spectrum 64K address space.[1] The
terminal region at `0xFFED` contains, in little-endian order, a spare address,
data-start pointer, picture-address-table pointer, window-table pointer,
extra-data pointer, character-set pointer, palette pointer, `FFFF`, picture
count, and `0000` end marker.[1]

The retained R4 members use the checked Plus3DOS wrapper already supported by
the native DDB parser: `PLUS3DOS\x1A`, declared total length, declared payload
length, load address, and header checksum. The retained 2,304-byte physical
member declares a 2,217-byte logical file containing a 2,089-byte SDG payload;
the remaining 87 bytes form a bounded physical record tail beyond the logical
file. The native validator excludes that tail from SDG parsing. The payload's final
19 bytes consequently map to `0xFFED`–`0xFFFF`. In the real `PART1.SDG`, the
terminal header reports one picture and data start `0xF7D7`; its pointer values
are within the declared load span. This is a container/pointer claim, not a
rendering claim.

The first terminal-header word is documented as spare metadata. It is retained
as `spare_word` in evidence but is not subject to the load-range predicate,
which applies only to the subsequent address fields.

| Validation rule | Native behavior |
| --- | --- |
| Plus3DOS signature, checksum, and declared lengths | Rejects a malformed wrapper before SDG interpretation; requires declared payload consistency within the logical file and permits only a sub-128-byte physical tail beyond it. |
| Payload has at least 19 bytes | Rejects a truncated terminal header. |
| Terminal `FFFF` and `0000` sentinels | Rejects a corrupted terminal marker. |
| Nonzero pointers fall within the computed load range | Rejects an out-of-range pointer. |
| Nonzero SDG data-start pointer equals computed load base | Rejects a conflicting storage/load model. |

## Explicit non-claims and divergent samples

Several retained source-250 `.SDG` members are not promoted by this profile:
all-`E5` data, raw zero-prefixed data with a non-SDG tail, and any same-name or
same-length member without a valid Plus3DOS wrapper and terminal-header
predicate remain explicit `unrecognized_sdg_profile` evidence. The extension
alone is insufficient.

The original DAAD manual independently uses `PARTx.SDG` naming for Spectrum
graphics packaging, supporting the bundle role without substituting for the
byte contract.[2] The complete ADP specification documents picture commands,
window records, palette behavior, and character-set content; those sections
remain an active native decoder and renderer task, requiring command-stream
validation, malformed-stream tests, and real-artifact rendering evidence.

## References

[1]: [ADP SDG specification](https://github.com/jlcebrian/ADP/blob/master/docs/SDG%20Specs.txt)
[2]: [Retained DAAD manual — Spectrum `PARTx.SDG` packaging references](../../reverse_engineering/public_sources/msx2daad-public-source/docs/DAAD_Manual_1991.md)
