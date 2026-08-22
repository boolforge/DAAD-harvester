from copy import deepcopy
from pathlib import Path
import pytest
from daad_harvester.c64_entry_state_admission import C64EntryStateAdmissionError,load_c64_entry_state_admission,validate_c64_entry_state_admission
ROOT=Path(__file__).resolve().parents[1]; CONTRACT=ROOT/"reverse_engineering/workflows/c64_prg_entry_state_admission.json"
def test_c64_entry_contract_stays_fail_closed_without_official_capture():
 c=load_c64_entry_state_admission(CONTRACT); assert c["execution_eligible"] is False; assert all(p["entry_state_observation"] is None for p in c["profiles"])
@pytest.mark.parametrize("mutation,msg",[(lambda c:c.__setitem__("execution_eligible",True),"must not enable execution"),(lambda c:c["profiles"][0].__setitem__("basic_sys_entry",0),"SYS 2063"),(lambda c:c["profiles"][0].__setitem__("entry_state_observation",{"emulator":"default"}),"no official C64 entry-state capture")])
def test_c64_entry_contract_rejects_promotion_or_incomplete_observation(mutation,msg):
 c=deepcopy(load_c64_entry_state_admission(CONTRACT)); mutation(c)
 with pytest.raises(C64EntryStateAdmissionError,match=msg): validate_c64_entry_state_admission(c)
