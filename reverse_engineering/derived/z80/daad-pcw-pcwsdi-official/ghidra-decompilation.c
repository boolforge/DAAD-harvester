/* Ghidra-derived function ram:0000 RST0 */

/* WARNING: Control flow encountered bad instruction data */

void RST0(undefined1 param_1)

{
  short sVar1;
  undefined1 *puVar2;
  undefined1 *puVar3;
  
  if (uRam0001 < 0xead9) {
                    /* WARNING: Call to offcut address within same function */
    func_0x0005(param_1,9,uRam0001 + 0x1527,0x124);
    RST0();
    return;
  }
  puVar2 = &DAT_ram_c080;
  sVar1 = 0x2257;
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
/* WARNING: Possible PIC construction at 0x0125: Changing call to branch */
/* WARNING: Removing unreachable block (ram,0x0128) */
/* WARNING: Removing unreachable block (ram,0x012f) */
/* WARNING: Removing unreachable block (ram,0x0132) */
/* WARNING: Removing unreachable block (ram,0xc1a1) */
/* WARNING: Removing unreachable block (ram,0x014d) */
/* WARNING: This function may have set the stack pointer */
/* WARNING: Removing unreachable block (ram,0x009e) */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST5(char param_1,ushort param_2,undefined1 param_3,undefined1 param_4,short param_5)

{
  byte in_F;
  char cVar1;
  undefined2 uVar2;
  
  cVar1 = (char)param_2;
  *(undefined1 *)CONCAT11(cVar1,param_3) = param_4;
  if ((in_F >> 6 & 1) == 0) {
    if ((in_F & 1) == 0) {
      param_1 = func_0x7ac3(param_2 & 0xff);
    }
    if ((in_F & 1) == 0) {
      param_1 = FUN_ram_03c3();
    }
    register0x44 = (BADSPACEBASE *)&stack0x0002;
  }
  else {
    *(char *)CONCAT11(param_1,param_1) = cVar1;
    *(char *)CONCAT11(param_1,param_1) = param_1;
    if ((char)(param_1 + '\x01') == '\0') {
      *(undefined1 *)CONCAT11(param_1,param_1 + '\x01') = 0;
      *(char *)CONCAT11(param_1,cVar1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = (char)(param_2 >> 8);
      uVar2 = CONCAT11(cVar1 + '\x01',0xd);
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
      _DAT_ram_2b00 = uVar2;
      return;
    }
  }
  *(undefined2 *)((short)register0x44 + -2) = 0xb4;
  DAT_ram_3231 = param_1;
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
  *(byte *)(param_5 + -1) = *(byte *)(param_5 + -1) | 1;
  _DAT_ram_e1d7 = _DAT_ram_ff41 + -4;
  DAT_ram_e2d6 = DAT_ram_e2d6 & 0xbf;
  cVar1 = DAT_ram_e19f;
  if (DAT_ram_e19f == '\0') {
    _DAT_ram_ff41 = 0x122;
    cVar1 = func_0xd4de(8);
  }
  _DAT_ram_ff41 = 0x125;
  func_0xc14e(cVar1);
  _DAT_ram_ff41 = 0x128;
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0030 RST6 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Possible PIC construction at 0x0125: Changing call to branch */
/* WARNING: Removing unreachable block (ram,0x0128) */
/* WARNING: Removing unreachable block (ram,0x012f) */
/* WARNING: Removing unreachable block (ram,0x0132) */
/* WARNING: Removing unreachable block (ram,0xc1a1) */
/* WARNING: Removing unreachable block (ram,0x014d) */
/* WARNING: This function may have set the stack pointer */
/* WARNING: Removing unreachable block (ram,0x009e) */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST6(char param_1,undefined2 param_2,ushort param_3,short param_4)

{
  byte in_F;
  char cVar1;
  undefined2 uVar2;
  
  if ((in_F >> 6 & 1) == 0) {
    if ((in_F & 1) == 0) {
      param_1 = func_0x7ac3(param_3 >> 8);
    }
    if ((in_F & 1) == 0) {
      param_1 = FUN_ram_03c3();
    }
    register0x44 = (BADSPACEBASE *)&stack0x0002;
  }
  else {
    cVar1 = (char)param_2;
    *(char *)CONCAT11(param_1,param_1) = cVar1;
    *(char *)CONCAT11(param_1,param_1) = param_1;
    if ((char)(param_1 + '\x01') == '\0') {
      *(undefined1 *)CONCAT11(param_1,param_1 + '\x01') = 0;
      *(char *)CONCAT11(param_1,cVar1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = param_1;
      *(char *)CONCAT11(cVar1,param_1) = (char)((ushort)param_2 >> 8);
      uVar2 = CONCAT11(cVar1 + '\x01',0xd);
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
      _DAT_ram_2b00 = uVar2;
      return;
    }
  }
  *(undefined2 *)((short)register0x44 + -2) = 0xb4;
  DAT_ram_3231 = param_1;
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
  *(byte *)(param_4 + -1) = *(byte *)(param_4 + -1) | 1;
  _DAT_ram_e1d7 = _DAT_ram_ff41 + -4;
  DAT_ram_e2d6 = DAT_ram_e2d6 & 0xbf;
  cVar1 = DAT_ram_e19f;
  if (DAT_ram_e19f == '\0') {
    _DAT_ram_ff41 = 0x122;
    cVar1 = func_0xd4de(8);
  }
  _DAT_ram_ff41 = 0x125;
  func_0xc14e(cVar1);
  _DAT_ram_ff41 = 0x128;
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0038 RST7 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Possible PIC construction at 0x0125: Changing call to branch */
/* WARNING: Removing unreachable block (ram,0x0128) */
/* WARNING: Removing unreachable block (ram,0x012f) */
/* WARNING: Removing unreachable block (ram,0x0132) */
/* WARNING: Removing unreachable block (ram,0xc1a1) */
/* WARNING: Removing unreachable block (ram,0x014d) */
/* WARNING: This function may have set the stack pointer */
/* WARNING: Removing unreachable block (ram,0x009e) */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST7(char param_1,undefined2 param_2,undefined2 param_3,undefined1 param_4,short param_5)

{
  char cVar1;
  undefined1 uVar3;
  undefined2 uVar2;
  
  cVar1 = (char)param_2;
  uVar3 = (undefined1)((ushort)param_3 >> 8);
  if ((char)(param_1 + '\x01') == '\0') {
    *(undefined1 *)CONCAT11(uVar3,param_1 + '\x01') = 0;
    *(undefined1 *)CONCAT11(uVar3,cVar1) = uVar3;
    *(undefined1 *)CONCAT11(cVar1,param_1) = param_4;
    *(undefined1 *)CONCAT11(cVar1,param_1) = param_4;
    *(undefined1 *)CONCAT11(cVar1,param_1) = param_4;
    *(char *)CONCAT11(cVar1,param_1) = (char)((ushort)param_2 >> 8);
    uVar2 = CONCAT11(cVar1 + '\x01',0xd);
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
    _DAT_ram_2b00 = uVar2;
    return;
  }
  DAT_ram_3231 = param_1;
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
  *(byte *)(param_5 + -1) = *(byte *)(param_5 + -1) | 1;
  _DAT_ram_e1d7 = _DAT_ram_ff41 + -4;
  DAT_ram_e2d6 = DAT_ram_e2d6 & 0xbf;
  cVar1 = DAT_ram_e19f;
  if (DAT_ram_e19f == '\0') {
    _DAT_ram_ff41 = 0x122;
    cVar1 = func_0xd4de(8);
  }
  _DAT_ram_ff41 = 0x125;
  func_0xc14e(cVar1);
  _DAT_ram_ff41 = 0x128;
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0066 NMI_ISR */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void NMI_ISR(undefined2 param_1)

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
  _DAT_ram_2b00 = param_1;
  return;
}



/* Ghidra-derived function ram:03c3 FUN_ram_03c3 */

/* WARNING: Control flow encountered bad instruction data */

void FUN_ram_03c3(undefined1 *param_1,undefined1 *param_2,short param_3)

{
  byte bVar1;
  byte bVar2;
  undefined2 in_stack_00000000;
  
  func_0xc988(*param_1,in_stack_00000000);
  bVar2 = (byte)((ushort)in_stack_00000000 >> 8);
  bVar1 = func_0xc962();
  if ((!CARRY1(bVar1,bVar2)) &&
     (((byte)(bVar1 + bVar2) == DAT_ram_e30b || ((byte)(bVar1 + bVar2) < DAT_ram_e30b)))) {
    if (DAT_ram_e2d8 < DAT_ram_e2fc) {
      *param_2 = 0xfe;
      *(char *)(param_3 + 1) = *(char *)(param_3 + 1) + '\x01';
      func_0xcea1(0x1b24,&DAT_ram_e2fc);
                    /* WARNING: Bad instruction - Truncating control flow here */
      halt_baddata();
    }
    if (DAT_ram_e1d9 != '\0') {
      DAT_ram_e1d9 = cRam0103;
    }
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



