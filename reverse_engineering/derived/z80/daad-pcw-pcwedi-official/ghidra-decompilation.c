/* Ghidra-derived function ram:0000 RST0 */

/* WARNING: Control flow encountered bad instruction data */

void RST0(undefined1 param_1)

{
  short sVar1;
  undefined1 *puVar2;
  undefined1 *puVar3;
  
  if (uRam0001 < 0xe9f6) {
                    /* WARNING: Call to offcut address within same function */
    func_0x0005(param_1,9,uRam0001 + 0x160a,0x124);
    RST0();
    return;
  }
  puVar2 = &DAT_ram_c080;
  sVar1 = 0x2174;
  puVar3 = &DAT_ram_0180;
  do {
    *puVar2 = *puVar3;
    puVar2 = puVar2 + 1;
    puVar3 = puVar3 + 1;
    sVar1 = sVar1 + -1;
  } while (sVar1 != 0);
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0010 RST2 */

void RST2(void)

{
  func_0x0005();
  RST0();
  return;
}



/* Ghidra-derived function ram:0028 RST5 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Instruction at (ram,0x009c) overlaps instruction at (ram,0x009a)
    */
/* WARNING: This function may have set the stack pointer */
/* WARNING: Removing unreachable block (ram,0x0048) */
/* WARNING: Removing unreachable block (ram,0x0098) */
/* WARNING: Removing unreachable block (ram,0x009c) */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST5(byte param_1,undefined2 param_2,undefined1 *param_3,short param_4)

{
  bool bVar1;
  undefined1 uVar2;
  byte in_F;
  bool bVar3;
  byte bVar4;
  char cVar5;
  byte bVar6;
  undefined1 *puVar7;
  short sVar8;
  
  *param_3 = (char)((ushort)param_3 >> 8);
  if ((in_F >> 6 & 1) == 0) {
    bVar3 = param_1 < 0xc3;
    bVar4 = param_1 + 0x3d;
  }
  else {
    bVar6 = (byte)param_2;
    bVar1 = ((bVar6 & 0xf) + 1 & 0x10) != 0;
    bVar3 = 0xfe < bVar6;
    bVar4 = param_1;
    param_1 = bVar6 + 1;
    if ((byte)(bVar6 + 1) == 0) {
      halt();
      uVar2 = BCDadjust(bVar6,bVar3,bVar1);
      BCDadjustCarry(uVar2,bVar3,bVar1);
      hasEvenParity(uVar2);
      *(char *)CONCAT11(bVar6,bVar6) = (char)((ushort)param_2 >> 8);
      puVar7 = (undefined1 *)CONCAT11(bVar6 + 1,0xd);
      RST7(uVar2);
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      *puVar7 = (char)((ushort)puVar7 >> 8);
      return;
    }
  }
  DAT_ram_3231 = (bVar4 - param_1) - bVar3;
  DAT_io_00c3 = DAT_ram_3231;
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  _DAT_ram_ff3f = 0xcd;
  RST7();
  _DAT_ram_ff3f = 0xce;
  RST7();
  _DAT_ram_ff3f = 0xcf;
  RST7();
  _DAT_ram_ff3f = 0xd0;
  RST7();
  _DAT_ram_ff3f = 0xd1;
  RST7();
  _DAT_ram_ff3f = 0xd2;
  RST7();
  _DAT_ram_ff3f = 0xd3;
  RST7();
  _DAT_ram_ff3f = 0xd4;
  RST7();
  _DAT_ram_ff3f = 0xd5;
  RST7();
  _DAT_ram_ff3f = 0xd6;
  RST7();
  _DAT_ram_ff3f = 0xd7;
  RST7();
  _DAT_ram_ff3f = 0xd8;
  RST7();
  _DAT_ram_ff3f = 0xd9;
  RST7();
  _DAT_ram_ff3f = 0xda;
  RST7();
  _DAT_ram_ff3f = 0xdb;
  RST7();
  _DAT_ram_ff3f = 0xdc;
  RST7();
  _DAT_ram_ff3f = 0xdd;
  RST7();
  _DAT_ram_ff3f = 0xde;
  RST7();
  _DAT_ram_ff3f = 0xdf;
  RST7();
  _DAT_ram_ff3f = 0xe0;
  RST7();
  _DAT_ram_ff3f = 0xe1;
  RST7();
  _DAT_ram_ff3f = 0xe2;
  RST7();
  _DAT_ram_ff3f = 0xe3;
  RST7();
  _DAT_ram_ff3f = 0xe4;
  RST7();
  _DAT_ram_ff3f = 0xe5;
  RST7();
  _DAT_ram_ff3f = 0xe6;
  RST7();
  _DAT_ram_ff3f = 0xe7;
  RST7();
  _DAT_ram_ff3f = 0xe8;
  RST7();
  _DAT_ram_ff3f = 0xe9;
  RST7();
  _DAT_ram_ff3f = 0xea;
  RST7();
  _DAT_ram_ff3f = 0xeb;
  RST7();
  _DAT_ram_ff3f = 0xec;
  RST7();
  _DAT_ram_ff3f = 0xed;
  RST7();
  _DAT_ram_ff3f = 0xee;
  RST7();
  _DAT_ram_ff3f = 0xef;
  RST7();
  _DAT_ram_ff3f = 0xf0;
  RST7();
  _DAT_ram_ff3f = 0xf1;
  RST7();
  _DAT_ram_ff3f = 0xf2;
  RST7();
  _DAT_ram_ff3f = 0xf3;
  RST7();
  _DAT_ram_ff3f = 0xf4;
  RST7();
  _DAT_ram_ff3f = 0xf5;
  RST7();
  _DAT_ram_ff3f = 0xf6;
  RST7();
  _DAT_ram_ff3f = 0xf7;
  RST7();
  _DAT_ram_ff3f = 0xf8;
  RST7();
  _DAT_ram_ff3f = 0xf9;
  RST7();
  _DAT_ram_ff3f = 0xfa;
  RST7();
  _DAT_ram_ff3f = 0xfb;
  RST7();
  _DAT_ram_ff3f = 0xfc;
  RST7();
  _DAT_ram_ff3f = 0xfd;
  RST7();
  _DAT_ram_ff3f = 0xfe;
  RST7();
  _DAT_ram_ff3f = 0xff;
  RST7();
  _DAT_ram_ff3f = 0x100;
  RST7();
  _DAT_ram_ff3f = 0x101;
  RST7();
  _DAT_ram_ff3f = 0x102;
  RST7();
  _DAT_ram_ff3f = 0x103;
  RST7();
  *(byte *)(param_4 + -1) = *(byte *)(param_4 + -1) | 1;
  _DAT_ram_e0f6 = _DAT_ram_ff41 + -4;
  sVar8 = -0x1e0c;
  DAT_ram_e1f3 = DAT_ram_e1f3 & 0xbf;
  cVar5 = DAT_ram_e0be;
  if (DAT_ram_e0be == '\0') {
    _DAT_ram_ff41 = 0x122;
    cVar5 = func_0xd401(8);
  }
  _DAT_ram_ff41 = 0x125;
  func_0xc14e(cVar5);
  _DAT_ram_ff41 = 0x128;
  func_0xd614();
  _DAT_ram_ff41 = 299;
  func_0xd37f();
  if (DAT_ram_e0be == '\0') {
    _DAT_ram_ff41 = 0x132;
    func_0xd3f2(0);
  }
  *(byte *)(sVar8 + -1) = *(byte *)(sVar8 + -1) & 0xfb;
  _DAT_ram_ff41 = 0x139;
  func_0xd653();
  LAB_ram_df11 = 0xd;
  _DAT_ram_e0b5 = &LAB_ram_df11;
  *(undefined1 *)(sVar8 + -7) = 0x78;
  bVar4 = (byte)(_DAT_ram_e0bd >> 8);
  if (bVar4 != 0) {
                    /* WARNING: Could not recover jumptable at 0x014d. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    (*(code *)((ushort)bVar4 << 8 | _DAT_ram_e0bd & 0xff))(bVar4);
    return;
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0030 RST6 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Instruction at (ram,0x009c) overlaps instruction at (ram,0x009a)
    */
/* WARNING: This function may have set the stack pointer */
/* WARNING: Removing unreachable block (ram,0x0048) */
/* WARNING: Removing unreachable block (ram,0x0098) */
/* WARNING: Removing unreachable block (ram,0x009c) */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST6(char param_1,undefined2 param_2,undefined2 param_3,short param_4)

{
  bool bVar1;
  bool bVar2;
  undefined1 uVar3;
  char cVar4;
  byte bVar6;
  undefined1 *puVar5;
  short sVar7;
  
  bVar6 = (byte)((ushort)param_3 >> 8);
  bVar1 = ((bVar6 & 0xf) + 1 & 0x10) != 0;
  bVar2 = 0xfe < bVar6;
  if ((byte)(bVar6 + 1) == '\0') {
    halt();
    cVar4 = (char)param_2;
    uVar3 = BCDadjust(cVar4,bVar2,bVar1);
    BCDadjustCarry(uVar3,bVar2,bVar1);
    hasEvenParity(uVar3);
    *(char *)CONCAT11(cVar4,cVar4) = (char)((ushort)param_2 >> 8);
    puVar5 = (undefined1 *)CONCAT11(cVar4 + '\x01',0xd);
    RST7(uVar3);
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    RST7();
    *puVar5 = (char)((ushort)puVar5 >> 8);
    return;
  }
  DAT_ram_3231 = (param_1 - (bVar6 + 1)) - bVar2;
  DAT_io_00c3 = DAT_ram_3231;
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  _DAT_ram_ff3f = 0xcd;
  RST7();
  _DAT_ram_ff3f = 0xce;
  RST7();
  _DAT_ram_ff3f = 0xcf;
  RST7();
  _DAT_ram_ff3f = 0xd0;
  RST7();
  _DAT_ram_ff3f = 0xd1;
  RST7();
  _DAT_ram_ff3f = 0xd2;
  RST7();
  _DAT_ram_ff3f = 0xd3;
  RST7();
  _DAT_ram_ff3f = 0xd4;
  RST7();
  _DAT_ram_ff3f = 0xd5;
  RST7();
  _DAT_ram_ff3f = 0xd6;
  RST7();
  _DAT_ram_ff3f = 0xd7;
  RST7();
  _DAT_ram_ff3f = 0xd8;
  RST7();
  _DAT_ram_ff3f = 0xd9;
  RST7();
  _DAT_ram_ff3f = 0xda;
  RST7();
  _DAT_ram_ff3f = 0xdb;
  RST7();
  _DAT_ram_ff3f = 0xdc;
  RST7();
  _DAT_ram_ff3f = 0xdd;
  RST7();
  _DAT_ram_ff3f = 0xde;
  RST7();
  _DAT_ram_ff3f = 0xdf;
  RST7();
  _DAT_ram_ff3f = 0xe0;
  RST7();
  _DAT_ram_ff3f = 0xe1;
  RST7();
  _DAT_ram_ff3f = 0xe2;
  RST7();
  _DAT_ram_ff3f = 0xe3;
  RST7();
  _DAT_ram_ff3f = 0xe4;
  RST7();
  _DAT_ram_ff3f = 0xe5;
  RST7();
  _DAT_ram_ff3f = 0xe6;
  RST7();
  _DAT_ram_ff3f = 0xe7;
  RST7();
  _DAT_ram_ff3f = 0xe8;
  RST7();
  _DAT_ram_ff3f = 0xe9;
  RST7();
  _DAT_ram_ff3f = 0xea;
  RST7();
  _DAT_ram_ff3f = 0xeb;
  RST7();
  _DAT_ram_ff3f = 0xec;
  RST7();
  _DAT_ram_ff3f = 0xed;
  RST7();
  _DAT_ram_ff3f = 0xee;
  RST7();
  _DAT_ram_ff3f = 0xef;
  RST7();
  _DAT_ram_ff3f = 0xf0;
  RST7();
  _DAT_ram_ff3f = 0xf1;
  RST7();
  _DAT_ram_ff3f = 0xf2;
  RST7();
  _DAT_ram_ff3f = 0xf3;
  RST7();
  _DAT_ram_ff3f = 0xf4;
  RST7();
  _DAT_ram_ff3f = 0xf5;
  RST7();
  _DAT_ram_ff3f = 0xf6;
  RST7();
  _DAT_ram_ff3f = 0xf7;
  RST7();
  _DAT_ram_ff3f = 0xf8;
  RST7();
  _DAT_ram_ff3f = 0xf9;
  RST7();
  _DAT_ram_ff3f = 0xfa;
  RST7();
  _DAT_ram_ff3f = 0xfb;
  RST7();
  _DAT_ram_ff3f = 0xfc;
  RST7();
  _DAT_ram_ff3f = 0xfd;
  RST7();
  _DAT_ram_ff3f = 0xfe;
  RST7();
  _DAT_ram_ff3f = 0xff;
  RST7();
  _DAT_ram_ff3f = 0x100;
  RST7();
  _DAT_ram_ff3f = 0x101;
  RST7();
  _DAT_ram_ff3f = 0x102;
  RST7();
  _DAT_ram_ff3f = 0x103;
  RST7();
  *(byte *)(param_4 + -1) = *(byte *)(param_4 + -1) | 1;
  _DAT_ram_e0f6 = _DAT_ram_ff41 + -4;
  sVar7 = -0x1e0c;
  DAT_ram_e1f3 = DAT_ram_e1f3 & 0xbf;
  cVar4 = DAT_ram_e0be;
  if (DAT_ram_e0be == '\0') {
    _DAT_ram_ff41 = 0x122;
    cVar4 = func_0xd401(8);
  }
  _DAT_ram_ff41 = 0x125;
  func_0xc14e(cVar4);
  _DAT_ram_ff41 = 0x128;
  func_0xd614();
  _DAT_ram_ff41 = 299;
  func_0xd37f();
  if (DAT_ram_e0be == '\0') {
    _DAT_ram_ff41 = 0x132;
    func_0xd3f2(0);
  }
  *(byte *)(sVar7 + -1) = *(byte *)(sVar7 + -1) & 0xfb;
  _DAT_ram_ff41 = 0x139;
  func_0xd653();
  LAB_ram_df11 = 0xd;
  _DAT_ram_e0b5 = &LAB_ram_df11;
  *(undefined1 *)(sVar7 + -7) = 0x78;
  bVar6 = (byte)(_DAT_ram_e0bd >> 8);
  if (bVar6 != 0) {
                    /* WARNING: Could not recover jumptable at 0x014d. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    (*(code *)((ushort)bVar6 << 8 | _DAT_ram_e0bd & 0xff))(bVar6);
    return;
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0038 RST7 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Instruction at (ram,0x009c) overlaps instruction at (ram,0x009a)
    */
/* WARNING: This function may have set the stack pointer */
/* WARNING: Removing unreachable block (ram,0x0048) */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST7(undefined2 param_1,short param_2)

{
  undefined1 uVar1;
  byte in_F;
  byte bVar2;
  char cVar3;
  undefined1 *puVar4;
  short sVar5;
  
  if ((in_F >> 6 & 1) == 0) {
                    /* WARNING: Bad instruction - Truncating control flow here */
    halt_baddata();
  }
  cVar3 = (char)param_1;
  if ((in_F >> 6 & 1) != 0) {
    puVar4 = (undefined1 *)CONCAT11(cVar3,cVar3);
    if ((in_F >> 6 & 1) != 0) {
      uVar1 = BCDadjust(cVar3,in_F & 1,in_F >> 4 & 1);
      BCDadjustCarry(uVar1,in_F & 1,in_F >> 4 & 1);
      hasEvenParity(uVar1);
      *puVar4 = (char)((ushort)param_1 >> 8);
      puVar4 = (undefined1 *)CONCAT11(cVar3 + '\x01',0xd);
      RST7(uVar1);
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      RST7();
      *puVar4 = (char)((ushort)puVar4 >> 8);
      return;
    }
    bVar2 = FUN_ram_14c3(0xc3d4);
    cVar3 = ((bVar2 + 0x3d) - (char)puVar4) - (bVar2 < 0xc3);
    register0x44 = (BADSPACEBASE *)&stack0x0002;
    DAT_io_00c3 = cVar3;
  }
  *(undefined2 *)((short)register0x44 + -2) = 0xb4;
  DAT_ram_3231 = cVar3;
  RST7();
  *(undefined2 *)((short)register0x44 + -2) = 0xb5;
  RST7();
  *(undefined2 *)((short)register0x44 + -2) = 0xb6;
  RST7();
  *(undefined2 *)((short)register0x44 + -2) = 0xb7;
  RST7();
  *(undefined2 *)((short)register0x44 + -2) = 0xb8;
  RST7();
  *(undefined2 *)((short)register0x44 + -2) = 0xb9;
  RST7();
  *(undefined2 *)((short)register0x44 + -2) = 0xba;
  RST7();
  *(undefined2 *)((short)register0x44 + -2) = 0xbb;
  RST7();
  _DAT_ram_ff3f = 0xcd;
  RST7();
  _DAT_ram_ff3f = 0xce;
  RST7();
  _DAT_ram_ff3f = 0xcf;
  RST7();
  _DAT_ram_ff3f = 0xd0;
  RST7();
  _DAT_ram_ff3f = 0xd1;
  RST7();
  _DAT_ram_ff3f = 0xd2;
  RST7();
  _DAT_ram_ff3f = 0xd3;
  RST7();
  _DAT_ram_ff3f = 0xd4;
  RST7();
  _DAT_ram_ff3f = 0xd5;
  RST7();
  _DAT_ram_ff3f = 0xd6;
  RST7();
  _DAT_ram_ff3f = 0xd7;
  RST7();
  _DAT_ram_ff3f = 0xd8;
  RST7();
  _DAT_ram_ff3f = 0xd9;
  RST7();
  _DAT_ram_ff3f = 0xda;
  RST7();
  _DAT_ram_ff3f = 0xdb;
  RST7();
  _DAT_ram_ff3f = 0xdc;
  RST7();
  _DAT_ram_ff3f = 0xdd;
  RST7();
  _DAT_ram_ff3f = 0xde;
  RST7();
  _DAT_ram_ff3f = 0xdf;
  RST7();
  _DAT_ram_ff3f = 0xe0;
  RST7();
  _DAT_ram_ff3f = 0xe1;
  RST7();
  _DAT_ram_ff3f = 0xe2;
  RST7();
  _DAT_ram_ff3f = 0xe3;
  RST7();
  _DAT_ram_ff3f = 0xe4;
  RST7();
  _DAT_ram_ff3f = 0xe5;
  RST7();
  _DAT_ram_ff3f = 0xe6;
  RST7();
  _DAT_ram_ff3f = 0xe7;
  RST7();
  _DAT_ram_ff3f = 0xe8;
  RST7();
  _DAT_ram_ff3f = 0xe9;
  RST7();
  _DAT_ram_ff3f = 0xea;
  RST7();
  _DAT_ram_ff3f = 0xeb;
  RST7();
  _DAT_ram_ff3f = 0xec;
  RST7();
  _DAT_ram_ff3f = 0xed;
  RST7();
  _DAT_ram_ff3f = 0xee;
  RST7();
  _DAT_ram_ff3f = 0xef;
  RST7();
  _DAT_ram_ff3f = 0xf0;
  RST7();
  _DAT_ram_ff3f = 0xf1;
  RST7();
  _DAT_ram_ff3f = 0xf2;
  RST7();
  _DAT_ram_ff3f = 0xf3;
  RST7();
  _DAT_ram_ff3f = 0xf4;
  RST7();
  _DAT_ram_ff3f = 0xf5;
  RST7();
  _DAT_ram_ff3f = 0xf6;
  RST7();
  _DAT_ram_ff3f = 0xf7;
  RST7();
  _DAT_ram_ff3f = 0xf8;
  RST7();
  _DAT_ram_ff3f = 0xf9;
  RST7();
  _DAT_ram_ff3f = 0xfa;
  RST7();
  _DAT_ram_ff3f = 0xfb;
  RST7();
  _DAT_ram_ff3f = 0xfc;
  RST7();
  _DAT_ram_ff3f = 0xfd;
  RST7();
  _DAT_ram_ff3f = 0xfe;
  RST7();
  _DAT_ram_ff3f = 0xff;
  RST7();
  _DAT_ram_ff3f = 0x100;
  RST7();
  _DAT_ram_ff3f = 0x101;
  RST7();
  _DAT_ram_ff3f = 0x102;
  RST7();
  _DAT_ram_ff3f = 0x103;
  RST7();
  *(byte *)(param_2 + -1) = *(byte *)(param_2 + -1) | 1;
  _DAT_ram_e0f6 = _DAT_ram_ff41 + -4;
  sVar5 = -0x1e0c;
  DAT_ram_e1f3 = DAT_ram_e1f3 & 0xbf;
  cVar3 = DAT_ram_e0be;
  if (DAT_ram_e0be == '\0') {
    _DAT_ram_ff41 = 0x122;
    cVar3 = func_0xd401(8);
  }
  _DAT_ram_ff41 = 0x125;
  func_0xc14e(cVar3);
  _DAT_ram_ff41 = 0x128;
  func_0xd614();
  _DAT_ram_ff41 = 299;
  func_0xd37f();
  if (DAT_ram_e0be == '\0') {
    _DAT_ram_ff41 = 0x132;
    func_0xd3f2(0);
  }
  *(byte *)(sVar5 + -1) = *(byte *)(sVar5 + -1) & 0xfb;
  _DAT_ram_ff41 = 0x139;
  func_0xd653();
  LAB_ram_df11 = 0xd;
  _DAT_ram_e0b5 = &LAB_ram_df11;
  *(undefined1 *)(sVar5 + -7) = 0x78;
  bVar2 = (byte)(_DAT_ram_e0bd >> 8);
  if (bVar2 != 0) {
                    /* WARNING: Could not recover jumptable at 0x014d. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    (*(code *)((ushort)bVar2 << 8 | _DAT_ram_e0bd & 0xff))(bVar2);
    return;
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0066 NMI_ISR */

void NMI_ISR(undefined1 *param_1)

{
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  RST7();
  *param_1 = (char)((ushort)param_1 >> 8);
  return;
}



/* Ghidra-derived function ram:14c3 FUN_ram_14c3 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_ram_14c3(undefined2 param_1,undefined2 param_2,undefined2 param_3,short param_4)

{
  bool bVar1;
  byte bVar2;
  byte bVar3;
  undefined2 in_AF;
  char cVar4;
  byte bVar5;
  byte *pbVar6;
  
  cVar4 = (char)((ushort)in_AF >> 8) + -0x7f;
  bVar2 = (byte)in_AF & 0x28;
  pbVar6 = pbRam0108;
  do {
    do {
      bVar5 = *pbVar6;
      pbVar6 = pbVar6 + 1;
    } while ((bVar5 & 0x80) == 0);
    cVar4 = cVar4 + -1;
  } while (cVar4 != '\0');
  for (; bVar5 = *pbVar6, bVar5 < 0x80; pbVar6 = pbVar6 + 1) {
    func_0xd4de(bVar5);
    bVar2 = 0;
  }
  bVar3 = bVar5 + 0x80;
  if (bVar5 == 0x8d) {
    func_0xd614(param_1,param_3,param_2);
    bVar2 = *(byte *)(param_4 + -10);
    *(byte *)(param_4 + -10) = *(byte *)(param_4 + -10) & 0x7f;
    if ((bVar2 & 0x80) == 0) {
      func_0xd573();
    }
  }
  else {
    bVar5 = bVar5 + 0x80;
    if (bVar3 < 0x10) {
      if (bVar5 == 0xf) {
        *(byte *)(param_4 + -10) = *(byte *)(param_4 + -10) & 0xfe;
      }
      else if (bVar3 == 0xe) {
        *(byte *)(param_4 + -10) = *(byte *)(param_4 + -10) | 1;
      }
      else {
        func_0xd614();
        if (bVar3 == 0xb) {
          func_0xd43b();
        }
        else if (bVar3 == 0xc) {
          func_0xd370(DAT_ram_e1e5);
        }
      }
    }
    else {
      if ((*(byte *)(param_4 + -10) & 1) != 0) {
        bVar5 = bVar5 | 0x80;
      }
      bVar1 = (*(byte *)(param_4 + -10) & 0x40) == 0;
      if (!bVar1) {
        bVar3 = bVar2 | SBORROW1(bVar5,' ') << 2 | bVar5 < 0x20 | ((char)(bVar5 - 0x20) < '\0') << 7
        ;
        if ((bVar5 != 0x20) &&
           (bVar3 = bVar2 | SBORROW1(bVar5,-0x60) << 2 | bVar5 < 0xa0 |
                    ((char)(bVar5 + 0x60) < '\0') << 7, bVar5 != 0xa0)) {
          if (DAT_ram_e0bf == '(') {
            func_0xd614();
          }
          *(byte *)(param_4 + -10) = *(byte *)(param_4 + -10) & 0xdf;
          *_DAT_ram_e0e8 = bVar5;
          DAT_ram_e0bf = DAT_ram_e0bf + '\x01';
          _DAT_ram_e0e8 = _DAT_ram_e0e8 + 1;
          return;
        }
        bVar1 = (*(byte *)(param_4 + -10) & 0x20) == 0;
        if (!bVar1) {
          return;
        }
        func_0xd614(CONCAT11(bVar5,bVar3 | bVar1 << 6) | 0x10);
        bVar1 = (*(byte *)(param_4 + -10) & 0x20) == 0;
      }
      if (bVar1) {
        func_0xd5e7();
      }
    }
  }
  return;
}



