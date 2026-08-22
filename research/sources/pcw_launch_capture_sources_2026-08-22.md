# PCW Future Launch-Capture Source Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Which machine and CP/M context fields must a future official PCW interpreter launch capture retain? |
| **Evidence scope** | PCW CP/M and hardware documentation, not an observation of either retained DAAD image launching. |
| **Non-claims** | No hash-bound `PCWEDI.BIN` or `PCWSDI.BIN` launch capture is retained. The documented fields do not establish an effective entry, runtime behavior, or CP/M version for either image. |

John Elliott’s XBIOS analysis describes PCW CP/M zero-page paging state, banked
BDOS/BIOS, CP/M transient program area, and model/version-dependent layouts.
The hardware reference identifies the PCW paging ports and standard CP/M bank
arrangements. Together they support a future capture schema that binds the
exact official image, loader/disk and CP/M images, transition trace, snapshot,
model/version, registers, paging, zero page, TPA, and BDOS vector bytes.

## References

1. [Amstrad XBIOS Internals](https://www.seasip.info/Cpm/xbiosint.html)
2. [Amstrad PCW Hardware Reference](http://www.systemed.net/pcw/hardware.html)
