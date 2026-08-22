# radare2 Controlled-Fixture Health Record — 2026-08-22

| Header field | Value |
| --- | --- |
| **Question** | Does the configured radare2 5.5.0 binary produce repeatable raw-base-zero listings for every configured processor group without reading a retained DAAD artifact? |
| **Evidence scope** | One hash-bound Linux x86_64 `r2` executable, four literal instruction fixtures, and two temporary runs per fixture. |
| **Result** | The Z80, MOS 6502/8501, 68000, and i8086 fixture listings were byte-identical across repeated runs and are hash-bound in `radare2_fixture_health.json`. |
| **Admission effect** | None. The result is controlled host-tool health evidence; retained DAAD inputs remain blocked by their platform-specific load-model and evidence contracts. |

The temporary-only reproducer is:

```bash
python3 scripts/run_radare2_fixture_health.py --r2-path /usr/bin/r2
```

The recorded commands use `r2 -N -q`, an explicit architecture and bit width,
and `pd 2` over literal fixture bytes. The runner accepts only an executable
path, writes each fixture inside a temporary directory, and has no retained
artifact argument.

> Repeated radare2 output establishes neither recovered source nor an actual
> DAAD entry point, container, memory map, function boundary, or runtime
> behavior. The fixture origin is deliberately raw zero and cannot substitute
> for platform-specific origin or load evidence.

## References

1. [radare2 project](https://github.com/radareorg/radare2)
