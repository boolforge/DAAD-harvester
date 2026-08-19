/* Ghidra-derived function ram:0000 RST0 */

/* WARNING: Control flow encountered bad instruction data */

void RST0(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0008 RST1 */

void RST1(void)

{
  char in_F;
  
  if (-1 < in_F) {
    return;
  }
  RST7();
  return;
}



/* Ghidra-derived function ram:0010 RST2 */

void RST2(void)

{
  return;
}



/* Ghidra-derived function ram:0018 RST3 */

/* WARNING: Control flow encountered bad instruction data */

void RST3(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0020 RST4 */

/* WARNING: Control flow encountered bad instruction data */

void RST4(void)

{
  byte in_F;
  
  if (!(bool)(in_F >> 6 & 1)) {
    RST0();
                    /* WARNING: Bad instruction - Truncating control flow here */
    halt_baddata();
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0028 RST5 */

/* WARNING: Control flow encountered bad instruction data */

void RST5(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0030 RST6 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST6(short param_1,undefined2 param_2)

{
  char cVar1;
  byte bVar2;
  short sVar3;
  
  DAT_ram_cfd4 = (undefined1)((ushort)param_2 >> 8);
  sRamd011 = param_1 + -4;
  sVar3 = -0x2f30;
  DAT_ram_d0cf = DAT_ram_d0cf & 0xbf;
  cVar1 = DAT_ram_cfd8;
  if (DAT_ram_cfd8 == '\0') {
    func_0xc845(8);
    cVar1 = func_0xccad();
  }
  func_0xb078(cVar1);
  func_0xca54();
  func_0xc7ed();
  *(byte *)(sVar3 + -1) = *(byte *)(sVar3 + -1) & 0xfb;
  func_0xca93();
  LAB_ram_cf3a = 0xd;
  _DAT_ram_cfb3 = &LAB_ram_cf3a;
  *(undefined1 *)(sVar3 + -7) = 0x78;
  bVar2 = (byte)(_DAT_ram_cfd7 >> 8);
  if (bVar2 != 0) {
                    /* WARNING: Could not recover jumptable at 0x0077. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    (*(code *)((ushort)bVar2 << 8 | _DAT_ram_cfd7 & 0xff))(bVar2);
    return;
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0038 RST7 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void RST7(undefined2 param_1)

{
  byte in_F;
  char cVar1;
  undefined1 uVar2;
  byte bVar3;
  short sVar4;
  
  uVar2 = (undefined1)((ushort)param_1 >> 8);
  if ((in_F & 1) == 0) {
    return;
  }
  sVar4 = -0x2f30;
  DAT_ram_d0cf = DAT_ram_d0cf & 0xbf;
  cVar1 = DAT_ram_cfd8;
  DAT_ram_cfd4 = uVar2;
  if (DAT_ram_cfd8 == '\0') {
    func_0xc845(8);
    cVar1 = func_0xccad();
  }
  func_0xb078(cVar1);
  func_0xca54();
  func_0xc7ed();
  *(byte *)(sVar4 + -1) = *(byte *)(sVar4 + -1) & 0xfb;
  func_0xca93();
  LAB_ram_cf3a = 0xd;
  _DAT_ram_cfb3 = &LAB_ram_cf3a;
  *(undefined1 *)(sVar4 + -7) = 0x78;
  bVar3 = (byte)(_DAT_ram_cfd7 >> 8);
  if (bVar3 != 0) {
                    /* WARNING: Could not recover jumptable at 0x0077. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    (*(code *)((ushort)bVar3 << 8 | _DAT_ram_cfd7 & 0xff))(bVar3);
    return;
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0066 NMI_ISR */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void NMI_ISR(undefined1 *param_1,short param_2)

{
  byte bVar1;
  
  *param_1 = 0xd;
  _DAT_ram_cfb3 = param_1;
  *(undefined1 *)(param_2 + -7) = 0x78;
  bVar1 = (byte)(_DAT_ram_cfd7 >> 8);
  if (bVar1 != 0) {
                    /* WARNING: Could not recover jumptable at 0x0077. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    (*(code *)((ushort)bVar1 << 8 | _DAT_ram_cfd7 & 0xff))(bVar1);
    return;
  }
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



