from copy import deepcopy
from pathlib import Path
import pytest
from daad_harvester.atari_st_prg_load_model import AtariStPrgLoadModelError,load_atari_st_prg_load_model,parse_atari_st_prg,validate_atari_st_prg_load_model
ROOT=Path(__file__).resolve().parents[1]; CONTRACT=ROOT/"reverse_engineering/workflows/atari_st_prg_load_model_admission.json"
def test_retained_atari_prgs_validate_without_execution_promotion():
 c=load_atari_st_prg_load_model(CONTRACT,ROOT); f=parse_atari_st_prg((ROOT/c["profiles"][0]["input_path"]).read_bytes()); assert c["execution_eligible"] is False; assert f["first_relocation_offset"]==16; assert f["relocation_stream_size"]==712
@pytest.mark.parametrize("field,value,msg",[("execution_eligible",True,"must not enable execution"),("sha256","0"*64,"retained Atari ST identity differs"),("data_size",0,"data_size differs")])
def test_atari_prg_contract_rejects_promotion_or_changed_facts(field,value,msg):
 c=deepcopy(load_atari_st_prg_load_model(CONTRACT,ROOT)); (c.__setitem__(field,value) if field=="execution_eligible" else c["profiles"][0].__setitem__(field,value))
 with pytest.raises(AtariStPrgLoadModelError,match=msg): validate_atari_st_prg_load_model(c,ROOT)
