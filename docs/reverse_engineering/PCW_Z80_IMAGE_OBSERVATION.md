# PCW Z80 Image and CP/M BDOS-Call Boundary

| Header field | Value |
| --- | --- |
| **Question** | What can be measured directly from the two retained original PCW interpreter-image files before their PCW CP/M loading environment is known? |
| **Evidence scope** | Immutable original-image hashes, sizes, and the measured `CALL 0x0005` byte sequence at file offset 16. |
| **Status** | Both images contain the observed BDOS-call bytes; CP/M loading and executable entry remain unresolved. |
| **Non-claims** | The observation does not establish a transient-program load address, effective entry, CP/M version, PCW bank or firmware state, source recovery, or runtime behavior. |

Both retained PCW images contain `CD 05 00` at file offset 16, the Z80
encoding of an absolute call to address `0x0005`. This is a byte observation,
not proof that the call executes or that the binaries were loaded by a specific
CP/M transient-program convention. The PCW dossier therefore keeps disk and
runtime provenance separate from exact interpreter identity.[1]

```bash
python3 scripts/verify_pcw_z80_image_observation.py
```

The verifier reads retained bytes only; it does not start CP/M, mount a PCW
disk, launch an emulator, or disassemble either image.

Every profile therefore records `launch_capture_observation: null`. A future
official capture must bind the exact image and loader/disk context, CP/M system
image, CCP-to-TPA transition, snapshot, model and CP/M version, register set,
PCW paging and zero-page bank state, TPA range, and BDOS vector bytes. A generic
emulator default, an unrelated CP/M capture, or another PCW title cannot fill
this field.[3] [4]

## References

[1]: [Amstrad PCW platform dossier](../platforms/AMSTRAD_PCW.md)
[2]: [Architecture-family macroplan](AUTONOMOUS_ARCHITECTURE_FAMILY_MACROPLAN.md)
[3]: [Amstrad XBIOS Internals](https://www.seasip.info/Cpm/xbiosint.html)
[4]: [Amstrad PCW Hardware Reference](http://www.systemed.net/pcw/hardware.html)
