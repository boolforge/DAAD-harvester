# Ghidra Headless Adapter Health Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Does the configured Ghidra 12.1.3 headless adapter launch reproducibly for every currently configured processor-language binding without reading a retained DAAD artifact? |
| **Scope** | One Linux x86_64 host; exact Ghidra 12.1.3 launcher, repository export script, and four controlled instruction fixtures. |
| **Result** | The four unique processor-language bindings completed twice with byte-identical deterministic exports. The machine-readable result is [`ghidra_headless_health.json`](../../reverse_engineering/workflows/ghidra_headless_health.json). |
| **Admission effect** | None. The configured adapter remains a corroborative structured-analysis lane only; this record does not add a retained-byte authorization. |

## Observed command boundary

The health check used Ghidra's documented headless launcher with a new temporary
project directory for each run, a recorded processor language, and the
repository's pinned `ExportDAADAnalysis.java` post-script. It wrote output and
launcher logs only under a temporary directory outside the repository. Each
fixture used a stable `fixture-*.bin` filename because the exporter’s metadata
records the imported program name. The launcher, script, fixture bytes, two-run
comparison, and deterministic export hashes are all captured in the
machine-readable record.

The repository-owned reproducer is optional because it requires the pinned
Ghidra extraction and Java prerequisite on the local host:

```bash
python3 scripts/run_ghidra_headless_fixture_health.py \
  --ghidra-root /path/to/ghidra_12.1.3_PUBLIC
```

It verifies the hash-bound Linux launcher and exporter before creating any
temporary fixture. It accepts no retained DAAD input argument and compares all
four committed exports across two runs for each processor profile.

The fixtures were intentionally minimal: Z80 `00 c9`, MOS 6502/8501 `ea 60`,
68000 `4e 71 4e 75`, and i8086 real mode `90 c3`. No retained DAAD artifact,
extracted interpreter, game image, or acquired source was opened. The local
Ghidra distribution contained the four configured language IDs and launched with
OpenJDK 21.0.11. The official 12.1.3 documentation requires a 64-bit Java 21
runtime and development kit and documents headless operation through the
`support/analyzeHeadless` launcher. [1] [2]

## Decoding and decompilation boundary

The Z80 fixture emitted a short decoded listing. The MOS 6502, 68000, and i8086
fixtures exported their files successfully but did not create a function or a
decompilation body under the raw base-zero invocation. That is an expected
absence in this health check, not a failure to be concealed and not a reason to
invent entry points. In particular, a future retained analysis must provide a
separately evidenced loader, base, entry, or trace model before empty or inferred
function output can support a stronger statement.

> Byte-identical exports from a synthetic fixture establish only a narrow
> host-and-command reproducibility observation. They do not recover source,
> validate a DAAD interpreter origin, establish a DOS or Windows target result,
> prove a function boundary, or show runtime behavior.

## Cross-platform status

The official Ghidra documentation lists Windows 10 or later, Linux, and macOS
as supported platforms. It describes prebuilt native components for Windows
x86_64, Windows ARM64 through x86 emulation, and Linux x86_64. [1] This record
contains only Linux x86_64 execution evidence. Windows x86_64 and ARM64 entries
are deliberately `documented_unchecked` and name `analyzeHeadless.bat`, Java 21,
and writable temporary projects as prerequisites. They must receive an isolated
fixture run and recorded outputs on those hosts before their status changes.

## Reusable implementation decision

The exporter remains a native Ghidra Java script because it uses the documented
headless post-script API directly and has no additional Python packaging layer.
Ghidra's bundled PyGhidra capability is useful for separately scoped Python
automation, but it is not required to execute this exporter and is therefore not
added as an undeclared preservation dependency. [1] Any future Python helper
must be pinned, independently health-checked, and kept outside the native
preservation-critical path until it earns a bounded contract.

## References

1. [Ghidra 12.1.3 Getting Started](https://github.com/NationalSecurityAgency/ghidra/blob/Ghidra_12.1.3_build/GhidraDocs/GettingStarted.md)
2. [Ghidra Headless Analyzer documentation](https://github.com/NationalSecurityAgency/ghidra/blob/Ghidra_12.1.3_build/Ghidra/Features/Base/src/main/help/help/topics/HeadlessAnalyzer/HeadlessAnalyzer.htm)
3. [Ghidra 12.1.3 release and SHA-256](https://github.com/NationalSecurityAgency/ghidra/releases/tag/Ghidra_12.1.3_build)
