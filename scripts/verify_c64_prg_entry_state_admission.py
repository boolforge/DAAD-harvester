#!/usr/bin/env python3
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[1]; sys.path.insert(0,str(ROOT))
from daad_harvester.c64_entry_state_admission import C64EntryStateAdmissionError,load_c64_entry_state_admission
try:
 c=load_c64_entry_state_admission(ROOT/"reverse_engineering/workflows/c64_prg_entry_state_admission.json")
except C64EntryStateAdmissionError as e:
 print(f"C64 entry-state admission verification failed: {e}",file=sys.stderr); raise SystemExit(1)
print(f"Verified {len(c['profiles'])} official C64 PRG admission requirements; no official entry capture is retained.")
