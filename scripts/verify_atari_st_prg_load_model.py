#!/usr/bin/env python3
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[1]; sys.path.insert(0,str(ROOT))
from daad_harvester.atari_st_prg_load_model import AtariStPrgLoadModelError,load_atari_st_prg_load_model
try:
    c=load_atari_st_prg_load_model(ROOT/"reverse_engineering/workflows/atari_st_prg_load_model_admission.json",ROOT)
except AtariStPrgLoadModelError as e:
    print(f"Atari ST PRG load-model verification failed: {e}",file=sys.stderr); raise SystemExit(1)
print(f"Verified {len(c['profiles'])} Atari ST PRG containers; TOS runtime remains unresolved.")
