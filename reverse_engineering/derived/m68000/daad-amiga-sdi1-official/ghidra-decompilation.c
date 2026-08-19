/* Ghidra-derived function 00001682 FUN_00001682 */

void FUN_00001682(void)

{
  char *in_A0;
  
  for (; *in_A0 == ' '; in_A0 = in_A0 + 1) {
  }
  return;
}



/* Ghidra-derived function 00001690 FUN_00001690 */

void FUN_00001690(void)

{
  char cVar1;
  char *in_A0;
  bool bVar2;
  
  bVar2 = *in_A0 == '\0';
  cVar1 = FUN_000016b0();
  if ((!bVar2) && ((cVar1 < '\x15' || (('\x1f' < cVar1 && ((cVar1 < 'A' || ('Z' < cVar1)))))))) {
    return;
  }
  return;
}



/* Ghidra-derived function 000016b0 FUN_000016b0 */

void FUN_000016b0(void)

{
  char in_D0b;
  
  if ('/' < in_D0b) {
    return;
  }
  return;
}



/* Ghidra-derived function 000017ac FUN_000017ac */

void FUN_000017ac(void)

{
  char in_D0b;
  int unaff_D4;
  char *pcVar1;
  char *pcVar2;
  int unaff_A6;
  
  pcVar1 = &DAT_00001e74 + unaff_D4;
  for (pcVar2 = (char *)(unaff_A6 + unaff_D4 * 2 + (uint)*(ushort *)(unaff_A6 + 0x1a));
      ((char)unaff_D4 != *(char *)(unaff_A6 + 3) &&
      (((in_D0b != -1 && (in_D0b != *pcVar1)) || (*pcVar2 == -1)))); pcVar2 = pcVar2 + 2) {
    unaff_D4 = unaff_D4 + 1;
    pcVar1 = pcVar1 + 1;
  }
  return;
}



/* Ghidra-derived function 000018ce FUN_000018ce */

void FUN_000018ce(void)

{
  byte in_D0b;
  char extraout_D1b;
  char extraout_D1b_00;
  int unaff_A6;
  undefined1 uVar1;
  undefined1 uVar2;
  
  uVar1 = in_D0b == *(byte *)(unaff_A6 + 3);
  if (*(byte *)(unaff_A6 + 3) <= in_D0b) {
    return;
  }
  FUN_000019ec();
  do {
    uVar2 = uVar1;
    FUN_00001938();
    uVar1 = 1;
  } while ((bool)uVar2);
  if (((DAT_00001d67 & 0x10) != 0) && ((extraout_D1b == -0x56 || (extraout_D1b == -0x76)))) {
    uVar1 = 1;
    FUN_00001938();
    FUN_00001938();
    if ((bool)uVar1) {
      FUN_00001926();
      FUN_0000257e();
    }
    else {
      FUN_00001926();
    }
  }
  do {
    FUN_0000257e();
    FUN_00001938();
  } while (extraout_D1b_00 != -0x2f);
  return;
}



/* Ghidra-derived function 00001926 FUN_00001926 */

void FUN_00001926(void)

{
  FUN_0000257e();
  return;
}



/* Ghidra-derived function 00001938 FUN_00001938 */

void FUN_00001938(void)

{
  int unaff_A4;
  int unaff_A6;
  
  if (*(char *)(unaff_A6 + unaff_A4) != -0xb) {
    return;
  }
  return;
}



/* Ghidra-derived function 0000194e FUN_0000194e */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_0000194e(void)

{
  undefined4 in_D0;
  uint uVar1;
  undefined1 uVar2;
  undefined1 unaff_D2b;
  int unaff_A6;
  
  _DAT_00001daa = 0;
  _DAT_00001dae = 0;
  DAT_00001da7 = (byte)in_D0;
  if (DAT_00001da7 != 0xff) {
    if (*(byte *)(unaff_A6 + 3) <= DAT_00001da7) {
      FUN_00001b8e();
      FUN_00001b00();
      FUN_000027a2();
      FUN_00003764();
      return 0xffffffff;
    }
    uVar1 = FUN_00001ac0();
    if ((uVar1 & 0x80) != 0) {
      _DAT_00001daa = _DAT_00001daa | 0x80;
    }
    if ((uVar1 & 0x40) != 0) {
      _DAT_00001daa = _DAT_00001daa | 0x8000;
    }
    uVar2 = FUN_000019c2();
    _DAT_00001daa = CONCAT13(uVar2,_DAT_00001dab);
    FUN_00001a3c();
    _DAT_00001dab = CONCAT12(unaff_D2b,_DAT_00001dac);
    _DAT_00001dae = FUN_000019d4();
  }
  return in_D0;
}



/* Ghidra-derived function 000019c2 FUN_000019c2 */

undefined1 FUN_000019c2(void)

{
  uint in_D1;
  
  return (&DAT_00001e74)[in_D1 & 0xff];
}



/* Ghidra-derived function 000019d4 FUN_000019d4 */

undefined2 FUN_000019d4(void)

{
  uint in_D1;
  int unaff_A6;
  
  return *(undefined2 *)(unaff_A6 + (in_D1 & 0xff) * 2 + (uint)*(ushort *)(unaff_A6 + 0x1e));
}



/* Ghidra-derived function 000019ec FUN_000019ec */

void FUN_000019ec(void)

{
  return;
}



/* Ghidra-derived function 00001a3c FUN_00001a3c */

void FUN_00001a3c(void)

{
  FUN_00001a48();
  return;
}



/* Ghidra-derived function 00001a48 FUN_00001a48 */

undefined8 FUN_00001a48(void)

{
  uint uVar1;
  uint uVar2;
  undefined4 in_D1;
  char extraout_D1b;
  short extraout_D1w;
  short sVar3;
  ushort unaff_D2w;
  ushort uVar4;
  char cVar5;
  char unaff_D3b;
  short sVar6;
  undefined1 *puVar7;
  undefined1 *extraout_A1;
  int unaff_A6;
  
  uVar1 = FUN_00001ac0();
  uVar2 = uVar1 & 0xffffff3f;
  if (((uVar1 & 0x40) != 0) && ((char)uVar2 != '\0')) {
    uVar4 = unaff_D2w;
    if (unaff_D3b != '\t') {
      sVar6 = *(byte *)(unaff_A6 + 3) - 1;
      sVar3 = 0;
      uVar4 = (ushort)uVar1 & 0xff3f;
      puVar7 = &DAT_00001e74;
      do {
        uVar2 = CONCAT31((int3)(uVar2 >> 8),puVar7[sVar3]);
        if (puVar7[sVar3] == extraout_D1b) {
          uVar2 = FUN_00001a48();
          puVar7 = extraout_A1;
          sVar3 = extraout_D1w;
        }
        sVar3 = sVar3 + 1;
        sVar6 = sVar6 + -1;
      } while (sVar6 != -1);
    }
    uVar2 = CONCAT22((short)(uVar2 >> 0x10),uVar4);
  }
  cVar5 = (byte)uVar2 + (byte)unaff_D2w;
  if (CARRY1((byte)uVar2,(byte)unaff_D2w)) {
    cVar5 = -1;
  }
  return CONCAT44(CONCAT31((int3)(uVar2 >> 8),cVar5),in_D1);
}



/* Ghidra-derived function 00001ac0 FUN_00001ac0 */

undefined1 FUN_00001ac0(void)

{
  ushort in_D1w;
  int unaff_A6;
  
  return *(undefined1 *)(unaff_A6 + (uint)in_D1w + (uint)*(ushort *)(unaff_A6 + 0x1c));
}



/* Ghidra-derived function 00001b00 FUN_00001b00 */

void FUN_00001b00(void)

{
  DAT_00001d67 = DAT_00001d67 & 0xfd;
  FUN_00001b54();
  FUN_00001b54();
  FUN_00001b54();
  FUN_00001b54();
  FUN_00001b54();
  FUN_00001b54();
  FUN_00001b54();
  FUN_00001b54();
  FUN_00001b54();
  FUN_0000257e();
  return;
}



/* Ghidra-derived function 00001b54 FUN_00001b54 */

void FUN_00001b54(void)

{
  char cVar1;
  uint unaff_D2;
  uint unaff_D3;
  byte *unaff_A4;
  bool bVar2;
  
  cVar1 = '0';
  while (bVar2 = unaff_D3 <= unaff_D2, unaff_D2 = unaff_D2 - unaff_D3, bVar2) {
    cVar1 = cVar1 + '\x01';
  }
  if ((cVar1 != '0') || ((*unaff_A4 & 2) != 0)) {
    *unaff_A4 = *unaff_A4 | 2;
    FUN_0000257e();
  }
  return;
}



/* Ghidra-derived function 00001b80 FUN_00001b80 */

void FUN_00001b80(void)

{
  FUN_00001bf8();
  FUN_00001b8e();
  return;
}



/* Ghidra-derived function 00001b8e FUN_00001b8e */

void FUN_00001b8e(void)

{
  byte bVar1;
  int unaff_D6;
  int unaff_A4;
  int unaff_A6;
  
  do {
    bVar1 = ~*(byte *)(unaff_A4 + unaff_D6);
    if (bVar1 == 10) {
      bVar1 = DAT_00001d69 & 0x40;
      DAT_00001d69 = DAT_00001d69 & 0xbf;
      if (bVar1 != 0) {
        FUN_0000257a();
      }
      return;
    }
    if (bVar1 == *(byte *)(unaff_A6 + 2)) {
      DAT_00001d67 = DAT_00001d67 | 0x20;
LAB_00001bb8:
      DAT_00001d67 = DAT_00001d67 | 0x10;
      FUN_000018ce();
    }
    else {
      if (bVar1 == 0x40) {
        DAT_00001d67 = DAT_00001d67 & 0xdf;
        goto LAB_00001bb8;
      }
      FUN_0000257e();
    }
    unaff_A4 = unaff_A4 + 1;
  } while( true );
}



/* Ghidra-derived function 00001bf8 FUN_00001bf8 */

void FUN_00001bf8(void)

{
  return;
}



/* Ghidra-derived function 000021ac FUN_000021ac */

void FUN_000021ac(void)

{
  ushort uVar1;
  byte bVar2;
  short sVar4;
  uint uVar3;
  char *pcVar6;
  char *pcVar7;
  ushort *puVar8;
  byte *pbVar9;
  bool bVar10;
  ushort uVar5;
  
  DAT_00003f2e = DAT_00003f42;
  if ((DAT_00001d9d & 7) != 0) {
    FUN_000028de();
  }
  FUN_00001b80();
  FUN_000027a2();
  DAT_00003eb5 = DAT_00003eb5 & 0xbf;
  DAT_00003eb2 = 0xff;
  FUN_00001b80();
  FUN_00002546();
  FUN_00003afc();
  DAT_00003f2a = DAT_00003eae;
  if ((((char)DAT_00001da5 < '\0') && ((DAT_00001da5 & 0x7f) >> 6 != 0)) &&
     ((DAT_00001da5 & 0x3f) >> 5 != 0)) {
    func_0x000024be();
    func_0x000024d6();
  }
  else {
    DAT_00003d53 = '\0';
    LAB_00003cda = 0xd;
    DAT_00003cd6 = &LAB_00003cda;
  }
code_r0x00002240:
  if ((DAT_00001d68 & 0x10) != 0) goto code_r0x00002270;
  bVar10 = DAT_00001da4 == '\0';
  if (bVar10) goto code_r0x00002270;
  uVar1 = FUN_00003740();
  if (!bVar10) {
    do {
      if (uVar1 == 0x7f) {
        if (*DAT_00003cd6 != '\r') {
          sVar4 = 0x78;
          pcVar7 = DAT_00003cd6;
          do {
            pcVar6 = pcVar7 + 1;
            if (*pcVar7 == '\r') break;
            sVar4 = sVar4 + -1;
            pcVar7 = pcVar6;
          } while (sVar4 != -1);
          pcVar6 = pcVar6 + (-2 - (int)DAT_00003cd6);
          pcVar7 = DAT_00003cd6;
          do {
            *pcVar7 = pcVar7[1];
            uVar1 = (short)pcVar6 - 1;
            pcVar6 = (char *)(uint)uVar1;
            pcVar7 = pcVar7 + 1;
          } while (uVar1 != 0xffff);
code_r0x0000245a:
          DAT_00003d53 = DAT_00003d53 + -1;
          func_0x000024be();
          FUN_000038b8();
          FUN_000038b8();
          func_0x000024d6();
        }
      }
      else {
        bVar2 = (byte)uVar1;
        if (bVar2 == 8) {
          if (DAT_00003cd6 != &LAB_00003cda) {
            sVar4 = 0x78;
            pcVar7 = DAT_00003cd6;
            do {
              pcVar6 = pcVar7 + 1;
              if (*pcVar7 == '\r') break;
              sVar4 = sVar4 + -1;
              pcVar7 = pcVar6;
            } while (sVar4 != -1);
            pcVar6 = pcVar6 + (-1 - (int)DAT_00003cd6);
            pcVar7 = DAT_00003cd6 + -1;
            do {
              *pcVar7 = pcVar7[1];
              uVar1 = (short)pcVar6 - 1;
              pcVar6 = (char *)(uint)uVar1;
              pcVar7 = pcVar7 + 1;
            } while (uVar1 != 0xffff);
            FUN_000038b8();
            DAT_00003cd6 = DAT_00003cd6 + -1;
            goto code_r0x0000245a;
          }
        }
        else if (uVar1 == 0xff44) {
          if (DAT_00003cd6 != &LAB_00003cda) {
            DAT_00003cd6 = DAT_00003cd6 + -1;
            FUN_000038b8();
          }
        }
        else if (uVar1 == 0xff43) {
          if (*DAT_00003cd6 != '\r') {
            DAT_00003cd6 = DAT_00003cd6 + 1;
            FUN_000038b8();
          }
        }
        else if (bVar2 == 0xd) {
          if (DAT_00003d53 != '\0') {
            func_0x000024be();
            func_0x000024f8();
            FUN_0000257a();
            DAT_00003d54 = 'x';
            DAT_00001da5 = DAT_00001da5 & 0x3f;
            goto code_r0x00002346;
          }
        }
        else if (DAT_00003d53 != DAT_00003d54) {
          puVar8 = (ushort *)0x3f50;
          do {
            uVar5 = *puVar8;
            if (uVar5 == 0) {
              if ((bVar2 < 0x20) || ('z' < (char)bVar2)) goto code_r0x00002236;
              goto code_r0x000022da;
            }
            puVar8 = puVar8 + 1;
          } while (bVar2 != (byte)uVar5);
          uVar1 = uVar5 >> 8;
code_r0x000022da:
          sVar4 = 0x78;
          pcVar7 = DAT_00003cd6;
          do {
            pcVar6 = pcVar7;
            if (*pcVar6 == '\r') break;
            sVar4 = sVar4 + -1;
            pcVar7 = pcVar6 + 1;
          } while (sVar4 != -1);
          uVar3 = (int)pcVar6 - (int)DAT_00003cd6;
          do {
            pcVar6[1] = *pcVar6;
            pcVar6 = pcVar6 + -1;
            uVar5 = (short)uVar3 - 1;
            uVar3 = (uint)uVar5;
          } while (uVar5 != 0xffff);
          DAT_00003d53 = DAT_00003d53 + '\x01';
          *DAT_00003cd6 = (char)uVar1;
          DAT_00003cd6 = DAT_00003cd6 + 1;
          func_0x000024be();
          func_0x000024d6();
        }
      }
code_r0x00002236:
      if ((DAT_00001da5 & 1) == 0) goto code_r0x00002240;
code_r0x00002270:
      uVar1 = FUN_00003764();
    } while( true );
  }
  func_0x000024be();
  DAT_00001da5 = DAT_00001da5 | 0xc0;
code_r0x00002346:
  func_0x00003b10();
  if ((DAT_00001da5 & 8) != 0) {
    FUN_0000363e();
  }
  DAT_00003eb5 = DAT_00003eb5 | 0x40;
  FUN_000028de();
  if ((DAT_00001da5 & 0x80) == 0) {
    if ((DAT_00001da5 & 0x10) != 0) {
      FUN_00001b80();
    }
    for (pbVar9 = (byte *)0x3cfa; *pbVar9 != 0xd; pbVar9 = pbVar9 + 1) {
      if ((DAT_00001da5 & 0x10) != 0) {
        FUN_000038b8();
      }
      bVar2 = *pbVar9;
      if ((bVar2 < 0x1a) || (0x1f < bVar2)) {
        if ((0x60 < bVar2) && (bVar2 < 0x7b)) {
          bVar2 = bVar2 & 0xdf;
          goto code_r0x000023ca;
        }
      }
      else {
        bVar2 = bVar2 | 1;
code_r0x000023ca:
        *pbVar9 = bVar2;
      }
    }
    if ((DAT_00001da5 & 0x10) != 0) {
      FUN_0000257a();
    }
  }
  return;
}



/* Ghidra-derived function 00002528 FUN_00002528 */

void FUN_00002528(void)

{
  undefined1 in_D0b;
  short sVar1;
  undefined *puVar2;
  
  sVar1 = 7;
  puVar2 = &DAT_00003ed6;
  DAT_00003ed2 = in_D0b;
  do {
    puVar2[8] = puVar2[1];
    puVar2 = puVar2 + 0xc;
    sVar1 = sVar1 + -1;
  } while (sVar1 != -1);
  return;
}



/* Ghidra-derived function 00002546 FUN_00002546 */

void FUN_00002546(void)

{
  short sVar1;
  char cVar2;
  
  sVar1 = (DAT_00003ecb + 1) * (ushort)DAT_00003eca -
          (((ushort)DAT_00003ece - (ushort)DAT_00003ecc) + 1);
  if ((sVar1 < 0x79) && (cVar2 = (char)sVar1, cVar2 <= DAT_00003d74)) {
    DAT_00003d54 = cVar2;
  }
  return;
}



/* Ghidra-derived function 0000257a FUN_0000257a */

/* WARNING: Removing unreachable block (ram,0x00002584) */
/* WARNING: Removing unreachable block (ram,0x00002590) */
/* WARNING: Removing unreachable block (ram,0x0000259a) */
/* WARNING: Removing unreachable block (ram,0x000025a8) */
/* WARNING: Removing unreachable block (ram,0x000025ac) */
/* WARNING: Removing unreachable block (ram,0x000025b6) */
/* WARNING: Removing unreachable block (ram,0x00002676) */
/* WARNING: Removing unreachable block (ram,0x0000269e) */
/* WARNING: Removing unreachable block (ram,0x000025ca) */
/* WARNING: Removing unreachable block (ram,0x00002660) */
/* WARNING: Removing unreachable block (ram,0x00002670) */
/* WARNING: Removing unreachable block (ram,0x00002680) */
/* WARNING: Removing unreachable block (ram,0x00002698) */
/* WARNING: Removing unreachable block (ram,0x0000268e) */
/* WARNING: Removing unreachable block (ram,0x00002666) */
/* WARNING: Removing unreachable block (ram,0x000025d2) */
/* WARNING: Removing unreachable block (ram,0x000025dc) */
/* WARNING: Removing unreachable block (ram,0x000025e0) */
/* WARNING: Removing unreachable block (ram,0x000025ea) */
/* WARNING: Removing unreachable block (ram,0x000025f0) */
/* WARNING: Removing unreachable block (ram,0x000025f6) */
/* WARNING: Removing unreachable block (ram,0x00002600) */
/* WARNING: Removing unreachable block (ram,0x00002604) */
/* WARNING: Removing unreachable block (ram,0x00002622) */
/* WARNING: Removing unreachable block (ram,0x0000262c) */
/* WARNING: Removing unreachable block (ram,0x0000263e) */

undefined4 FUN_0000257a(void)

{
  byte bVar1;
  undefined4 uVar2;
  
  FUN_000027a2();
  bVar1 = DAT_00003eb5 & 0x80;
  DAT_00003eb5 = DAT_00003eb5 & 0x7f;
  if (bVar1 == 0) {
    uVar2 = FUN_000026ae();
  }
  else {
    uVar2 = FUN_000038b8();
  }
  return uVar2;
}



/* Ghidra-derived function 0000257e FUN_0000257e */

void FUN_0000257e(void)

{
  undefined3 uVar1;
  undefined3 extraout_var;
  uint in_D0;
  char cVar2;
  byte bVar3;
  int iVar4;
  int extraout_A1;
  int unaff_A6;
  
  if (((in_D0 & 0x80) != 0) && ((DAT_00001d67 & 4) != 0)) {
    iVar4 = (int)*(short *)(unaff_A6 + 8);
    cVar2 = (char)in_D0 + -0x7f;
    uVar1 = (undefined3)(in_D0 >> 8);
    do {
      do {
        iVar4 = iVar4 + 1;
      } while ((*(byte *)(unaff_A6 + -1 + (int)(short)iVar4) & 0x80) == 0);
      cVar2 = cVar2 + -1;
    } while (cVar2 != '\0');
    while (bVar3 = *(byte *)(unaff_A6 + (short)iVar4), in_D0 = CONCAT31(uVar1,bVar3 + 0x80),
          bVar3 < 0x80) {
      FUN_000025c2();
      iVar4 = extraout_A1 + 1;
      uVar1 = extraout_var;
    }
  }
  bVar3 = (byte)in_D0;
  if (bVar3 == 0xd) {
    FUN_000027a2();
    bVar3 = DAT_00003eb5 & 0x80;
    DAT_00003eb5 = DAT_00003eb5 & 0x7f;
    if (bVar3 == 0) {
      FUN_000026ae();
    }
    else {
      FUN_000038b8();
    }
  }
  else if (bVar3 < 0x10) {
    if (bVar3 == 0xf) {
      DAT_00003eb5 = DAT_00003eb5 & 0xfe;
    }
    else if (bVar3 == 0xe) {
      DAT_00003eb5 = DAT_00003eb5 | 1;
    }
    else {
      FUN_000027a2();
      if ((char)in_D0 == '\v') {
        FUN_0000363e();
      }
      else if ((char)in_D0 == '\f') {
        FUN_0000372a();
      }
    }
  }
  else {
    if ((DAT_00003eb5 & 1) != 0) {
      in_D0 = in_D0 | 0x80;
    }
    if ((DAT_00003eb5 & 0x40) != 0) {
      if (((char)in_D0 != ' ') && ((char)in_D0 != -0x60)) {
        if (DAT_00001d04 == 'P') {
          in_D0 = FUN_000027a2();
        }
        DAT_00003eb5 = DAT_00003eb5 & 0xdf;
        *DAT_00001d00 = (char)in_D0;
        DAT_00001d00 = DAT_00001d00 + 1;
        DAT_00001d04 = DAT_00001d04 + '\x01';
        return;
      }
      if ((DAT_00003eb5 & 0x20) != 0) {
        return;
      }
      FUN_000027a2(in_D0);
      if ((DAT_00003eb5 & 0x20) != 0) {
        return;
      }
    }
    FUN_0000275c();
  }
  return;
}



/* Ghidra-derived function 000025c2 FUN_000025c2 */

void FUN_000025c2(void)

{
  uint in_D0;
  byte bVar1;
  
  bVar1 = (byte)in_D0;
  if (bVar1 == 0xd) {
    FUN_000027a2();
    bVar1 = DAT_00003eb5 & 0x80;
    DAT_00003eb5 = DAT_00003eb5 & 0x7f;
    if (bVar1 == 0) {
      FUN_000026ae();
    }
    else {
      FUN_000038b8();
    }
  }
  else if (bVar1 < 0x10) {
    if (bVar1 == 0xf) {
      DAT_00003eb5 = DAT_00003eb5 & 0xfe;
    }
    else if (bVar1 == 0xe) {
      DAT_00003eb5 = DAT_00003eb5 | 1;
    }
    else {
      FUN_000027a2();
      if ((char)in_D0 == '\v') {
        FUN_0000363e();
      }
      else if ((char)in_D0 == '\f') {
        FUN_0000372a();
      }
    }
  }
  else {
    if ((DAT_00003eb5 & 1) != 0) {
      in_D0 = in_D0 | 0x80;
    }
    if ((DAT_00003eb5 & 0x40) != 0) {
      if (((char)in_D0 != ' ') && ((char)in_D0 != -0x60)) {
        if (DAT_00001d04 == 'P') {
          in_D0 = FUN_000027a2();
        }
        DAT_00003eb5 = DAT_00003eb5 & 0xdf;
        *DAT_00001d00 = (char)in_D0;
        DAT_00001d00 = DAT_00001d00 + 1;
        DAT_00001d04 = DAT_00001d04 + '\x01';
        return;
      }
      if ((DAT_00003eb5 & 0x20) != 0) {
        return;
      }
      FUN_000027a2(in_D0);
      if ((DAT_00003eb5 & 0x20) != 0) {
        return;
      }
    }
    FUN_0000275c();
  }
  return;
}



/* Ghidra-derived function 000026ae FUN_000026ae */

uint FUN_000026ae(void)

{
  uint uVar1;
  int iVar2;
  int unaff_A6;
  undefined8 uVar3;
  
  uVar3 = FUN_000038b8();
  uVar1 = (uint)((ulonglong)uVar3 >> 0x20);
  DAT_00003eb2 = DAT_00003eb2 + -1;
  if (DAT_00003eb2 == '\0') {
    uVar1 = uVar1 & 0xffff0000;
    DAT_00003eb2 = DAT_00003ecb;
    if (((DAT_00001d66 & 0x40) == 0) && ((DAT_00003eb5 & 2) == 0)) {
      FUN_00001bf8(uVar1,(int)uVar3);
      DAT_00003f26 = DAT_00003ed5;
      DAT_00003eb5 = 2;
      for (iVar2 = 0x20; *(char *)(unaff_A6 + iVar2) != -0xb; iVar2 = iVar2 + 1) {
        FUN_0000257e();
      }
      DAT_00003eb5 = DAT_00003f46;
      if (((DAT_00001da5 & 2) == 0) || (DAT_00001da4 == '\0')) {
        FUN_00003764();
      }
      else {
        FUN_00003740();
      }
      while (DAT_00003ece != DAT_00003ecc) {
        FUN_000038b8();
        FUN_000038b8();
        FUN_000038b8();
      }
    }
  }
  return uVar1;
}



/* Ghidra-derived function 000026b4 FUN_000026b4 */

void FUN_000026b4(void)

{
  uint in_D0;
  int iVar1;
  int unaff_A6;
  
  DAT_00003eb2 = DAT_00003eb2 + -1;
  if (DAT_00003eb2 == '\0') {
    DAT_00003eb2 = DAT_00003ecb;
    if (((DAT_00001d66 & 0x40) == 0) && ((DAT_00003eb5 & 2) == 0)) {
      FUN_00001bf8(in_D0 & 0xffff0000);
      DAT_00003f26 = DAT_00003ed5;
      DAT_00003eb5 = 2;
      for (iVar1 = 0x20; *(char *)(unaff_A6 + iVar1) != -0xb; iVar1 = iVar1 + 1) {
        FUN_0000257e();
      }
      DAT_00003eb5 = DAT_00003f46;
      if (((DAT_00001da5 & 2) == 0) || (DAT_00001da4 == '\0')) {
        FUN_00003764();
      }
      else {
        FUN_00003740();
      }
      while (DAT_00003ece != DAT_00003ecc) {
        FUN_000038b8();
        FUN_000038b8();
        FUN_000038b8();
      }
    }
  }
  return;
}



/* Ghidra-derived function 0000275c FUN_0000275c */

void FUN_0000275c(void)

{
  byte bVar1;
  char in_D0b;
  
  FUN_000038b8();
  bVar1 = DAT_00003eb5;
  DAT_00003eb5 = DAT_00003eb5 & 0x7f;
  if ((char)(DAT_00003eca + DAT_00003ecc) == DAT_00003ece) {
    if ((in_D0b == ' ') && ((bVar1 & 0x40) != 0)) {
      DAT_00003eb5 = DAT_00003eb5 | 0x20;
    }
    FUN_000026b4();
    DAT_00003eb5 = DAT_00003eb5 | 0x80;
  }
  return;
}



/* Ghidra-derived function 000027a2 FUN_000027a2 */

void FUN_000027a2(void)

{
  byte bVar1;
  ushort uVar2;
  
  if (((DAT_00003eb5 & 0x40) != 0) && (DAT_00001d04 != 0)) {
    bVar1 = (DAT_00003eca + DAT_00003ecc) - DAT_00003ece;
    if ((char)(DAT_00003eca + DAT_00003ecc) != DAT_00003ece) {
      if (bVar1 == DAT_00001d04) {
        DAT_00003eb5 = DAT_00003eb5 | 0x20;
      }
      else if (bVar1 < DAT_00001d04) {
        FUN_000026ae();
      }
    }
    uVar2 = (ushort)DAT_00001d04;
    while (uVar2 = uVar2 - 1, uVar2 != 0xffff) {
      FUN_0000275c();
    }
    DAT_00001d00 = &DAT_00001d05;
    DAT_00001d04 = 0;
    return;
  }
  return;
}



/* Ghidra-derived function 000027fe FUN_000027fe */

void FUN_000027fe(void)

{
  DAT_00003eb5 = DAT_00003eb5 & 0xdf;
  DAT_00001d00 = &DAT_00001d05;
  DAT_00001d04 = 0;
  return;
}



/* Ghidra-derived function 000028de FUN_000028de */

void FUN_000028de(void)

{
  byte in_D0b;
  short sVar1;
  undefined4 *puVar2;
  undefined4 *puVar3;
  
  if (in_D0b != DAT_00003f42) {
    FUN_000027a2();
    sVar1 = 2;
    puVar2 = (undefined4 *)&DAT_00003eca;
    puVar3 = (undefined4 *)(&DAT_00003ed6 + (uint)DAT_00003f42 * 0xc);
    do {
      *puVar3 = *puVar2;
      sVar1 = sVar1 + -1;
      puVar2 = puVar2 + 1;
      puVar3 = puVar3 + 1;
    } while (sVar1 != -1);
    sVar1 = 2;
    puVar2 = (undefined4 *)(&DAT_00003ed6 + (uint)in_D0b * 0xc);
    puVar3 = (undefined4 *)&DAT_00003eca;
    DAT_00003f22 = in_D0b;
    do {
      *puVar3 = *puVar2;
      sVar1 = sVar1 + -1;
      puVar2 = puVar2 + 1;
      puVar3 = puVar3 + 1;
    } while (sVar1 != -1);
    FUN_00002940();
    if (DAT_00003f22 == 8) {
      FUN_000035d2();
    }
  }
  return;
}



/* Ghidra-derived function 00002940 FUN_00002940 */

void FUN_00002940(void)

{
  DAT_00003f25 = (&DAT_00003e96)[(short)(ushort)(byte)(DAT_00003eca & 3 | (DAT_00003ecc & 3) << 2)]
                 + (DAT_00003eca >> 2) * '\x03';
  DAT_00003f24 = (DAT_00003ecc >> 2) * '\x03';
  if ((DAT_00003ecc & 3) != 0) {
    DAT_00003f24 = ((DAT_00003ecc & 3) - 1) + DAT_00003f24;
  }
  return;
}



/* Ghidra-derived function 00002a02 FUN_00002a02 */

void FUN_00002a02(void)

{
  short sVar1;
  undefined4 *puVar2;
  undefined4 *puVar3;
  undefined4 *puVar4;
  undefined4 *puVar5;
  
  DAT_00003fd4 = DAT_00003fb4;
  DAT_00003fd8 = DAT_00003fb8;
  DAT_00003fdc = DAT_00003fbc;
  DAT_00003fe0 = DAT_00003fc0;
  DAT_00003fe4 = DAT_00003fc4;
  DAT_00003fe8 = DAT_00003fc8;
  DAT_00003fec = DAT_00003fcc;
  DAT_00003ff0 = DAT_00003fd0;
  puVar2 = (undefined4 *)(DAT_00004086 + 0x28);
  puVar4 = (undefined4 *)(DAT_0000408a + 0x28);
  sVar1 = 1999;
  do {
    *puVar4 = *puVar2;
    puVar4[1] = puVar2[1];
    puVar3 = puVar2 + 3;
    puVar5 = puVar4 + 3;
    puVar4[2] = puVar2[2];
    puVar2 = puVar2 + 4;
    puVar4 = puVar4 + 4;
    *puVar5 = *puVar3;
    sVar1 = sVar1 + -1;
  } while (sVar1 != -1);
  return;
}



/* Ghidra-derived function 00002aac FUN_00002aac */

void FUN_00002aac(void)

{
  short sVar1;
  byte *in_A1;
  
  sVar1 = (ushort)(byte)(in_A1[2] >> 4 | in_A1[1] & 0xf0) << 4;
  *(ushort *)((int)&DAT_00003fb4 + (int)(short)((*in_A1 & 0xf) << 1)) =
       CONCAT11((char)((ushort)sVar1 >> 8),in_A1[3] >> 4 | (byte)sVar1);
  FUN_00003b26();
  return;
}



/* Ghidra-derived function 00002f30 FUN_00002f30 */

undefined4 FUN_00002f30(void)

{
  uint *puVar1;
  byte bVar2;
  byte bVar3;
  char cVar4;
  short sVar5;
  uint unaff_D4;
  ushort uVar6;
  uint uVar7;
  uint uVar8;
  uint uVar9;
  uint unaff_D7;
  uint *unaff_A2;
  uint *puVar10;
  uint *puVar11;
  uint *unaff_A3;
  uint *puVar12;
  
  puVar1 = (uint *)((int)unaff_A3 + unaff_D4);
  cVar4 = '\b';
  sVar5 = 8;
  uVar9 = *unaff_A2;
  puVar11 = unaff_A2 + 1;
LAB_00002f3c:
  do {
    do {
      do {
        uVar7 = uVar9;
        if (puVar1 == unaff_A3) {
          return 0;
        }
        uVar6 = (ushort)uVar7 & 0xf;
        uVar8 = uVar7 >> 4;
        cVar4 = cVar4 + -1;
        puVar10 = puVar11;
        if (cVar4 == '\0') {
          puVar10 = puVar11 + 1;
          uVar8 = *puVar11;
          cVar4 = '\b';
        }
        bVar3 = (byte)uVar6;
        bVar2 = (char)unaff_D4 << 1 | (uVar7 & 1) != 0;
        uVar9 = CONCAT31(CONCAT21(CONCAT11(bVar2,(char)(unaff_D4 >> 0x18) << 1 |
                                                 (bVar3 >> 1 & 1) != 0),
                                  (char)(unaff_D4 >> 0x10) << 1 | (bVar3 >> 2 & 1) != 0),
                         (char)(unaff_D4 >> 8) << 1 | bVar3 >> 3 != 0);
        sVar5 = sVar5 + -1;
        puVar12 = unaff_A3;
        if (sVar5 == 0) {
          puVar12 = unaff_A3 + 1;
          *unaff_A3 = uVar9;
          sVar5 = 8;
        }
        unaff_D4 = uVar9 << 8 | (uint)bVar2;
        uVar9 = uVar8;
        puVar11 = puVar10;
        unaff_A3 = puVar12;
      } while ((unaff_D7 & 1 << uVar6) == 0);
      uVar6 = (byte)uVar8 & 0xf;
      uVar9 = uVar8 >> 4;
      cVar4 = cVar4 + -1;
      if (cVar4 == '\0') {
        puVar11 = puVar10 + 1;
        uVar9 = *puVar10;
        cVar4 = '\b';
      }
    } while ((uVar8 & 0xf) == 0);
    do {
      while( true ) {
        if (puVar1 == unaff_A3) {
          return 0;
        }
        bVar2 = (char)unaff_D4 << 1 | (uVar7 & 1) != 0;
        unaff_D4 = CONCAT31(CONCAT21(CONCAT11(bVar2,(char)(unaff_D4 >> 0x18) << 1 |
                                                    (bVar3 >> 1 & 1) != 0),
                                     (char)(unaff_D4 >> 0x10) << 1 | (bVar3 >> 2 & 1) != 0),
                            (char)(unaff_D4 >> 8) << 1 | bVar3 >> 3 != 0);
        sVar5 = sVar5 + -1;
        if (sVar5 == 0) break;
        unaff_D4 = unaff_D4 << 8 | (uint)bVar2;
        uVar6 = uVar6 - 1;
        if (uVar6 == 0) goto LAB_00002f3c;
      }
      puVar10 = unaff_A3 + 1;
      *unaff_A3 = unaff_D4;
      sVar5 = 8;
      uVar6 = uVar6 - 1;
      unaff_A3 = puVar10;
    } while (uVar6 != 0);
  } while( true );
}



/* Ghidra-derived function 00002fc8 FUN_00002fc8 */

ulonglong FUN_00002fc8(void)

{
  uint uVar1;
  undefined1 uVar2;
  int iVar3;
  int in_D0;
  uint in_D1;
  
  iVar3 = DAT_00003ea8;
  uVar2 = DAT_00003e85;
  if ((((DAT_00001d91 & 0x20) != 0) || ((DAT_00001d66 & 2) == 0)) ||
     ((*(byte *)(DAT_00003ea8 + 5) & 0x10) != 0)) {
    return (ulonglong)in_D1;
  }
  DAT_00003eae = DAT_00003ecc;
  DAT_00003eaf = DAT_00003ecd;
  if ((*(byte *)(DAT_00003ea8 + 5) & 1) == 0) {
    DAT_00003eaf = (undefined1)(*(ushort *)(DAT_00003ea8 + 8) >> 3);
    uVar1 = *(ushort *)(DAT_00003ea8 + 6) / 6;
    DAT_00003eae = (char)uVar1;
    if (((uVar1 & 3) != 0) && (((ushort)uVar1 & 3) != 3)) {
      DAT_00003eae = DAT_00003eae + '\x01';
    }
    DAT_00003f24 = (undefined1)(*(ushort *)(DAT_00003ea8 + 6) >> 3);
    DAT_00003eac = DAT_00003eae;
    DAT_00003ead = DAT_00003eaf;
  }
  if ((*(byte *)(DAT_00003ea8 + 5) & 1) == 0) {
    DAT_00003ea8._2_2_ = CONCAT11((char)(DAT_00003eb8 / 6),(char)(DAT_00003eba >> 3) + -1);
    DAT_00003f25 = (char)(DAT_00003eb8 >> 3);
  }
  DAT_00003eb2 = DAT_00003ecb;
  if (in_D0 == 0) {
    if (DAT_00003e64 == '\0') {
      FUN_00003536();
      if ((*(byte *)(iVar3 + 5) & 1) == 0) {
        FUN_00003130();
        FUN_00003b26();
      }
    }
    else {
      FUN_00003536();
      if ((*(byte *)(iVar3 + 5) & 1) == 0) {
        FUN_00003130();
        return (ulonglong)in_D1;
      }
    }
    return (ulonglong)in_D1;
  }
  DAT_00003e85 = DAT_00003e84;
  FUN_00003652();
  DAT_00003e85 = uVar2;
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003130 FUN_00003130 */

void FUN_00003130(void)

{
  short sVar1;
  short sVar2;
  int in_A0;
  int in_A1;
  undefined2 *puVar3;
  undefined2 *puVar4;
  
  sVar2 = ((ushort)*(byte *)(in_A0 + 0xb) - (ushort)*(byte *)(in_A0 + 10)) + 1;
  sVar1 = (ushort)*(byte *)(in_A0 + 10) << 1;
  puVar3 = (undefined2 *)(in_A1 + sVar1);
  puVar4 = (undefined2 *)(in_A0 + 0xc + (int)sVar1);
  while (sVar2 = sVar2 + -1, sVar2 != -1) {
    *puVar3 = *puVar4;
    puVar3 = puVar3 + 1;
    puVar4 = puVar4 + 1;
  }
  return;
}



/* Ghidra-derived function 00003336 FUN_00003336 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003336(void)

{
  undefined4 *puVar1;
  int iVar2;
  char cVar4;
  undefined4 uVar3;
  
  FUN_000028de();
  FUN_0000363e();
  FUN_000034ea();
  cVar4 = FUN_00003764();
  iVar2 = DAT_0000403c;
  if (cVar4 != '\x1b') {
    FUN_000028de();
    uVar3 = FUN_00003608();
    return uVar3;
  }
  if (DAT_00004070 != 0) {
    _DAT_00dff09a = DAT_00004072;
    puVar1 = (undefined4 *)(DAT_00000004 + -0xa2);
    *(undefined4 *)(DAT_0000403c + -4) = 0x50a;
    (*(code *)*puVar1)();
    puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
    *(undefined4 *)(iVar2 + -4) = 0x51c;
    (*(code *)*puVar1)();
    puVar1 = (undefined4 *)(DAT_00000004 + -0x150);
    *(undefined4 *)(iVar2 + -4) = 0x528;
    (*(code *)*puVar1)();
    *(undefined2 *)(DAT_00004064 + 0x1c) = 9;
    puVar1 = (undefined4 *)(DAT_00000004 + -0x1c8);
    *(undefined4 *)(iVar2 + -4) = 0x53a;
    (*(code *)*puVar1)();
  }
  puVar1 = (undefined4 *)(DAT_00000004 + -0x1c2);
  *(undefined4 *)(iVar2 + -4) = 0x546;
  (*(code *)*puVar1)();
  *(undefined4 *)(iVar2 + -4) = 0x54e;
  FUN_00003cb6();
  *(undefined4 *)(iVar2 + -4) = 0x556;
  FUN_00003c44();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xae);
  *(undefined4 *)(iVar2 + -4) = 0x568;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
  *(undefined4 *)(iVar2 + -4) = 0x57a;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0x150);
  *(undefined4 *)(iVar2 + -4) = 0x586;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
  *(undefined4 *)(iVar2 + -4) = 0x598;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
  *(undefined4 *)(iVar2 + -4) = 0x5aa;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
  *(undefined4 *)(iVar2 + -4) = 0x5bc;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
  *(undefined4 *)(iVar2 + -4) = 0x5ce;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0x1c2);
  *(undefined4 *)(iVar2 + -4) = 0x5da;
  (*(code *)*puVar1)();
  *(undefined4 *)(iVar2 + -4) = 0x5e2;
  FUN_00003cb6();
  *(undefined4 *)(iVar2 + -4) = 0x5ea;
  FUN_00003c44();
  puVar1 = (undefined4 *)(DAT_0000400c + -0x48);
  *(undefined4 *)(iVar2 + -4) = 0x5f8;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_0000400c + -0x42);
  *(undefined4 *)(iVar2 + -4) = 0x606;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
  *(undefined4 *)(iVar2 + -4) = 0x618;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
  *(undefined4 *)(iVar2 + -4) = 0x62a;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0x19e);
  *(undefined4 *)(iVar2 + -4) = 0x636;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0x19e);
  *(undefined4 *)(iVar2 + -4) = 0x642;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00000004 + -0x19e);
  *(undefined4 *)(iVar2 + -4) = 0x64e;
  (*(code *)*puVar1)();
  return 0;
}



/* Ghidra-derived function 00003364 FUN_00003364 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003364(void)

{
  byte bVar1;
  undefined4 *puVar2;
  int iVar3;
  uint uVar4;
  int unaff_D5;
  uint unaff_D6;
  char *in_A0;
  undefined1 unaff_A6b;
  ushort uVar5;
  
  s_audio_device_000040ed[0] = *in_A0;
  s_audio_device_000040ed[1] = in_A0[1];
  s_audio_device_000040ed[2] = in_A0[2];
  do {
    s_audio_device_000040ed[3] = '\0';
    iRam0000401c = (**(code **)(DAT_00004014 + -0x54))(unaff_A6b);
    if (iRam0000401c != 0) {
      uRam000041a0 = unaff_D6;
      if (unaff_D6 == 0) {
        iVar3 = (**(code **)(DAT_00004014 + -0x66))();
        if (iVar3 != 0) {
          bVar1 = DAT_00001d66 & 8;
          DAT_00001d66 = DAT_00001d66 & 0xf7;
          if ((bVar1 != 0) && (0x1b009 < uRam000041a0)) {
            uRam000041a0 = 0x1b00a;
          }
          goto code_r0x000033d2;
        }
      }
      else {
code_r0x000033d2:
        uVar4 = (**(code **)(DAT_00004014 + -0x1e))();
        if (uVar4 != 0) {
          if (unaff_D5 == 0) {
code_r0x00003438:
            uVar4 = (**(code **)(DAT_00004014 + -0x2a))((short)uVar4);
            if (uVar4 == uRam000041a0) {
              (**(code **)(DAT_00004014 + -0x24))();
              (**(code **)(DAT_00004014 + -0x5a))();
              return 0;
            }
          }
          else {
            uVar5 = (ushort)uVar4;
            iVar3 = (**(code **)(DAT_00004014 + -0x42))(uVar5);
            if (iVar3 != -1) {
              iVar3 = (**(code **)(DAT_00004014 + -0x2a))(uVar5);
              uVar4 = (uint)uVar5;
              if (iVar3 == 6) {
                uRam000041a0 = (uint)DAT_00003ebc;
                goto code_r0x00003438;
              }
            }
          }
          (**(code **)(DAT_00004014 + -0x24))();
        }
      }
      (**(code **)(DAT_00004014 + -0x5a))();
    }
    iVar3 = (**(code **)(DAT_00004014 + -0x84))();
    if (iVar3 == 0xcd) {
      return 0xffffffff;
    }
    if (iVar3 != 0xe2) {
      FUN_000028de();
      FUN_0000363e();
      FUN_000034ea();
      FUN_00003764();
      iVar3 = DAT_0000403c;
      if (DAT_00004070 != 0) {
        _DAT_00dff09a = DAT_00004072;
        puVar2 = (undefined4 *)(DAT_00000004 + -0xa2);
        *(undefined4 *)(DAT_0000403c + -4) = 0x50a;
        (*(code *)*puVar2)();
        puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
        *(undefined4 *)(iVar3 + -4) = 0x51c;
        (*(code *)*puVar2)();
        puVar2 = (undefined4 *)(DAT_00000004 + -0x150);
        *(undefined4 *)(iVar3 + -4) = 0x528;
        (*(code *)*puVar2)();
        *(undefined2 *)(DAT_00004064 + 0x1c) = 9;
        puVar2 = (undefined4 *)(DAT_00000004 + -0x1c8);
        *(undefined4 *)(iVar3 + -4) = 0x53a;
        (*(code *)*puVar2)();
      }
      puVar2 = (undefined4 *)(DAT_00000004 + -0x1c2);
      *(undefined4 *)(iVar3 + -4) = 0x546;
      (*(code *)*puVar2)();
      *(undefined4 *)(iVar3 + -4) = 0x54e;
      FUN_00003cb6();
      *(undefined4 *)(iVar3 + -4) = 0x556;
      FUN_00003c44();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xae);
      *(undefined4 *)(iVar3 + -4) = 0x568;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
      *(undefined4 *)(iVar3 + -4) = 0x57a;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0x150);
      *(undefined4 *)(iVar3 + -4) = 0x586;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
      *(undefined4 *)(iVar3 + -4) = 0x598;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
      *(undefined4 *)(iVar3 + -4) = 0x5aa;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
      *(undefined4 *)(iVar3 + -4) = 0x5bc;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
      *(undefined4 *)(iVar3 + -4) = 0x5ce;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0x1c2);
      *(undefined4 *)(iVar3 + -4) = 0x5da;
      (*(code *)*puVar2)();
      *(undefined4 *)(iVar3 + -4) = 0x5e2;
      FUN_00003cb6();
      *(undefined4 *)(iVar3 + -4) = 0x5ea;
      FUN_00003c44();
      puVar2 = (undefined4 *)(DAT_0000400c + -0x48);
      *(undefined4 *)(iVar3 + -4) = 0x5f8;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_0000400c + -0x42);
      *(undefined4 *)(iVar3 + -4) = 0x606;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
      *(undefined4 *)(iVar3 + -4) = 0x618;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
      *(undefined4 *)(iVar3 + -4) = 0x62a;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0x19e);
      *(undefined4 *)(iVar3 + -4) = 0x636;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0x19e);
      *(undefined4 *)(iVar3 + -4) = 0x642;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00000004 + -0x19e);
      *(undefined4 *)(iVar3 + -4) = 0x64e;
      (*(code *)*puVar2)();
      return 0;
    }
    FUN_000028de();
    FUN_0000363e();
    FUN_000034ea();
    FUN_00003764();
    FUN_000028de();
    FUN_00003608();
  } while( true );
}



/* Ghidra-derived function 000034ea FUN_000034ea */

undefined8 FUN_000034ea(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_00001b8e();
  FUN_000027a2();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003512 FUN_00003512 */

undefined8 FUN_00003512(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_000034ea();
  s_datchrddbscr1part1_chr_000040fa[0x16] = -0xb;
  FUN_00001b8e();
  FUN_000027a2();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003536 FUN_00003536 */

undefined8 FUN_00003536(void)

{
  int iVar1;
  int iVar2;
  undefined4 in_D0;
  undefined4 in_D1;
  short unaff_D3w;
  short sVar3;
  int unaff_D4;
  uint uVar4;
  ushort uVar5;
  int unaff_D6;
  ushort *in_A0;
  undefined1 *puVar6;
  undefined1 *puVar7;
  undefined1 *puVar8;
  undefined1 *puVar9;
  undefined1 *puVar10;
  undefined1 *puVar11;
  undefined1 *puVar12;
  undefined1 *unaff_A5;
  undefined1 *puVar13;
  
  iVar1 = (uint)DAT_00003f44 + (uint)DAT_00003ecd * 8 * (uint)*in_A0;
  iVar2 = (uint)*in_A0 - unaff_D4;
  sVar3 = unaff_D3w * 8 + -1;
  puVar13 = (undefined1 *)(*(int *)(in_A0 + 4) + iVar1);
  puVar8 = (undefined1 *)(*(int *)(in_A0 + 6) + iVar1);
  puVar10 = (undefined1 *)(*(int *)(in_A0 + 8) + iVar1);
  puVar12 = (undefined1 *)(*(int *)(in_A0 + 10) + iVar1);
  uVar4 = unaff_D4 - 1U;
  do {
    do {
      puVar6 = puVar13 + 1;
      *puVar13 = *unaff_A5;
      puVar7 = puVar8 + 1;
      *puVar8 = unaff_A5[1];
      puVar13 = unaff_A5 + 3;
      puVar9 = puVar10 + 1;
      *puVar10 = unaff_A5[2];
      unaff_A5 = unaff_A5 + 4;
      puVar11 = puVar12 + 1;
      *puVar12 = *puVar13;
      uVar5 = (short)uVar4 - 1;
      uVar4 = (uint)uVar5;
      puVar13 = puVar6;
      puVar8 = puVar7;
      puVar10 = puVar9;
      puVar12 = puVar11;
    } while (uVar5 != 0xffff);
    puVar13 = puVar6 + iVar2;
    puVar8 = puVar7 + iVar2;
    puVar10 = puVar9 + iVar2;
    puVar12 = puVar11 + iVar2;
    unaff_A5 = unaff_A5 + unaff_D6 * 4;
    sVar3 = sVar3 + -1;
    uVar4 = unaff_D4 - 1U;
  } while (sVar3 != -1);
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 000035d2 FUN_000035d2 */

undefined8 FUN_000035d2(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  short sVar1;
  undefined1 *puVar2;
  undefined1 *puVar3;
  undefined1 *puVar4;
  undefined1 *puVar5;
  undefined1 *puVar6;
  undefined1 *puVar7;
  
  sVar1 = 7999;
  puVar2 = *(undefined1 **)(DAT_00004044 + 0xc0);
  puVar3 = *(undefined1 **)(DAT_00004044 + 0xc4);
  puVar4 = *(undefined1 **)(DAT_00004044 + 200);
  puVar5 = *(undefined1 **)(DAT_00004044 + 0xcc);
  puVar7 = DAT_00003e6c;
  do {
    *puVar7 = *puVar2;
    puVar7[1] = *puVar3;
    puVar6 = puVar7 + 3;
    puVar7[2] = *puVar4;
    puVar7 = puVar7 + 4;
    *puVar6 = *puVar5;
    sVar1 = sVar1 + -1;
    puVar2 = puVar2 + 1;
    puVar3 = puVar3 + 1;
    puVar4 = puVar4 + 1;
    puVar5 = puVar5 + 1;
  } while (sVar1 != -1);
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003608 FUN_00003608 */

undefined8 FUN_00003608(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  short sVar1;
  undefined1 *puVar2;
  undefined1 *puVar3;
  undefined1 *puVar4;
  undefined1 *puVar5;
  undefined1 *puVar6;
  undefined1 *puVar7;
  
  sVar1 = 7999;
  puVar2 = *(undefined1 **)(DAT_00004044 + 0xc0);
  puVar3 = *(undefined1 **)(DAT_00004044 + 0xc4);
  puVar4 = *(undefined1 **)(DAT_00004044 + 200);
  puVar5 = *(undefined1 **)(DAT_00004044 + 0xcc);
  puVar7 = DAT_00003e6c;
  do {
    *puVar2 = *puVar7;
    *puVar3 = puVar7[1];
    puVar6 = puVar7 + 3;
    *puVar4 = puVar7[2];
    puVar7 = puVar7 + 4;
    *puVar5 = *puVar6;
    sVar1 = sVar1 + -1;
    puVar2 = puVar2 + 1;
    puVar3 = puVar3 + 1;
    puVar4 = puVar4 + 1;
    puVar5 = puVar5 + 1;
  } while (sVar1 != -1);
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 0000363e FUN_0000363e */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8 FUN_0000363e(void)

{
  ushort uVar1;
  ushort uVar2;
  uint uVar3;
  undefined8 uVar4;
  undefined1 uVar5;
  uint uVar6;
  uint uVar7;
  uint uVar8;
  short sVar9;
  ushort uVar10;
  ushort *puVar11;
  undefined1 *puVar12;
  
  uVar4 = FUN_000027fe();
  _DAT_00003eae = _DAT_00003ecc;
  DAT_00003eb2 = DAT_00003ecb;
  puVar11 = DAT_00004086;
  if (DAT_00003e65 != '\0') {
    puVar11 = DAT_0000408a;
  }
  uVar3 = (uint)DAT_00003ecd;
  uVar1 = *puVar11;
  uVar6 = (uint)DAT_00003f44;
  uVar2 = *puVar11;
  uVar7 = (uint)DAT_00003f45;
  uVar8 = 0;
  do {
    puVar12 = (undefined1 *)
              (*(int *)((int)puVar11 + (short)((short)uVar8 << 2) + 8) +
              uVar6 + uVar3 * 8 * (uint)uVar1);
    uVar5 = 0;
    if ((DAT_00003ed4 & '\x01' << (uVar8 & 7)) != 0) {
      uVar5 = 0xff;
    }
    sVar9 = (DAT_00003ecb + 1) * 8;
    while (sVar9 = sVar9 + -1, sVar9 != -1) {
      uVar10 = (ushort)DAT_00003f45;
      while (uVar10 = uVar10 - 1, uVar10 != 0xffff) {
        *puVar12 = uVar5;
        puVar12 = puVar12 + 1;
      }
      puVar12 = puVar12 + (uVar2 - uVar7);
    }
    uVar10 = (short)uVar8 + 1;
    uVar8 = (uint)uVar10;
  } while ((char)uVar10 < *(char *)((int)puVar11 + 5));
  return uVar4;
}



/* Ghidra-derived function 00003652 FUN_00003652 */

undefined8 FUN_00003652(void)

{
  ushort uVar1;
  ushort uVar2;
  uint uVar3;
  undefined4 in_D0;
  undefined1 uVar4;
  undefined4 in_D1;
  uint uVar5;
  uint uVar6;
  uint uVar7;
  short sVar8;
  ushort uVar9;
  ushort *puVar10;
  undefined1 *puVar11;
  
  puVar10 = DAT_00004086;
  if (DAT_00003e65 != '\0') {
    puVar10 = DAT_0000408a;
  }
  uVar3 = (uint)DAT_00003ecd;
  uVar1 = *puVar10;
  uVar5 = (uint)DAT_00003f44;
  uVar2 = *puVar10;
  uVar6 = (uint)DAT_00003f45;
  uVar7 = 0;
  do {
    puVar11 = (undefined1 *)
              (*(int *)((int)puVar10 + (short)((short)uVar7 << 2) + 8) +
              uVar5 + uVar3 * 8 * (uint)uVar1);
    uVar4 = 0;
    if ((DAT_00003ed4 & '\x01' << (uVar7 & 7)) != 0) {
      uVar4 = 0xff;
    }
    sVar8 = (DAT_00003ecb + 1) * 8;
    while (sVar8 = sVar8 + -1, sVar8 != -1) {
      uVar9 = (ushort)DAT_00003f45;
      while (uVar9 = uVar9 - 1, uVar9 != 0xffff) {
        *puVar11 = uVar4;
        puVar11 = puVar11 + 1;
      }
      puVar11 = puVar11 + (uVar2 - uVar6);
    }
    uVar9 = (short)uVar7 + 1;
    uVar7 = (uint)uVar9;
  } while ((char)uVar9 < *(char *)((int)puVar10 + 5));
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 0000372a FUN_0000372a */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_0000372a(void)

{
  short sVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  undefined4 uVar5;
  int iVar6;
  
  FUN_00002528();
  if (((DAT_00001da5 & 4) == 0) || (DAT_00001da4 == 0)) {
    (**(code **)(DAT_00000004 + -0x78))();
    register0x00000000 = 0;
  }
  else {
    (**(code **)(DAT_00000004 + -0x78))();
    register0x00000000 = (uint)DAT_00001da4 << 6;
  }
  (**(code **)(DAT_00000004 + -0x132))();
  (**(code **)(DAT_00000004 + -0x7e))();
  do {
    bVar2 = *(byte *)(DAT_0000404c + 0xf);
    bVar3 = *(byte *)(*(int *)(DAT_00004048 + 0x56) + 0xf);
    uVar4 = (**(code **)(DAT_00000004 + -0x13e))();
    uVar5 = 0;
    if ((uVar4 & 1 << (bVar2 & 0x1f)) != 0) {
      uVar5 = FUN_0000380e();
    }
    do {
      if ((uVar4 & 1 << (bVar3 & 0x1f)) == 0) goto LAB_000037f4;
      iVar6 = (**(code **)(DAT_00000004 + -0x174))();
      uVar5 = 0;
    } while (iVar6 == 0);
    sVar1 = *(short *)(iVar6 + 0x18);
    (**(code **)(DAT_00000004 + -0x17a))();
  } while ((sVar1 != 0xe8) && (sVar1 != 0xe9));
  uVar5 = 0xd;
LAB_000037f4:
  DAT_0000408a._0_2_ = *(undefined2 *)(DAT_00004044 + 0x10);
  DAT_00004086._2_2_ = *(undefined2 *)(DAT_00004044 + 0x12);
  return uVar5;
}



/* Ghidra-derived function 00003740 FUN_00003740 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003740(void)

{
  short sVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  undefined4 uVar5;
  int iVar6;
  
  (**(code **)(DAT_00000004 + -0x78))();
  register0x00000000 = (uint)DAT_00001da4 << 6;
  (**(code **)(DAT_00000004 + -0x132))();
  (**(code **)(DAT_00000004 + -0x7e))();
  do {
    bVar2 = *(byte *)(DAT_0000404c + 0xf);
    bVar3 = *(byte *)(*(int *)(DAT_00004048 + 0x56) + 0xf);
    uVar4 = (**(code **)(DAT_00000004 + -0x13e))();
    uVar5 = 0;
    if ((uVar4 & 1 << (bVar2 & 0x1f)) != 0) {
      uVar5 = FUN_0000380e();
    }
    do {
      if ((uVar4 & 1 << (bVar3 & 0x1f)) == 0) goto LAB_000037f4;
      iVar6 = (**(code **)(DAT_00000004 + -0x174))();
      uVar5 = 0;
    } while (iVar6 == 0);
    sVar1 = *(short *)(iVar6 + 0x18);
    (**(code **)(DAT_00000004 + -0x17a))();
  } while ((sVar1 != 0xe8) && (sVar1 != 0xe9));
  uVar5 = 0xd;
LAB_000037f4:
  DAT_0000408a._0_2_ = *(undefined2 *)(DAT_00004044 + 0x10);
  DAT_00004086._2_2_ = *(undefined2 *)(DAT_00004044 + 0x12);
  return uVar5;
}



/* Ghidra-derived function 00003764 FUN_00003764 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003764(void)

{
  short sVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  undefined4 uVar5;
  int iVar6;
  
  (**(code **)(DAT_00000004 + -0x78))();
  ram0x0000406e = 0;
  (**(code **)(DAT_00000004 + -0x132))();
  (**(code **)(DAT_00000004 + -0x7e))();
  do {
    bVar2 = *(byte *)(DAT_0000404c + 0xf);
    bVar3 = *(byte *)(*(int *)(DAT_00004048 + 0x56) + 0xf);
    uVar4 = (**(code **)(DAT_00000004 + -0x13e))();
    uVar5 = 0;
    if ((uVar4 & 1 << (bVar2 & 0x1f)) != 0) {
      uVar5 = FUN_0000380e();
    }
    do {
      if ((uVar4 & 1 << (bVar3 & 0x1f)) == 0) goto LAB_000037f4;
      iVar6 = (**(code **)(DAT_00000004 + -0x174))();
      uVar5 = 0;
    } while (iVar6 == 0);
    sVar1 = *(short *)(iVar6 + 0x18);
    (**(code **)(DAT_00000004 + -0x17a))();
  } while ((sVar1 != 0xe8) && (sVar1 != 0xe9));
  uVar5 = 0xd;
LAB_000037f4:
  DAT_0000408a._0_2_ = *(undefined2 *)(DAT_00004044 + 0x10);
  DAT_00004086._2_2_ = *(undefined2 *)(DAT_00004044 + 0x12);
  return uVar5;
}



/* Ghidra-derived function 0000380e FUN_0000380e */

uint FUN_0000380e(void)

{
  uint uVar1;
  char cVar3;
  uint uVar2;
  
  uVar1 = FUN_0000385e();
  if ((char)uVar1 != -0x65) {
    return uVar1 & 0xffff00ff;
  }
  uVar1 = FUN_0000385e();
  if ((char)uVar1 == ' ') {
    cVar3 = FUN_0000385e();
    if (cVar3 == 'A') {
      uVar1 = 0x44;
    }
    else {
      uVar1 = 0x43;
    }
  }
  do {
    uVar2 = uVar1 | 0xff00;
    if ('?' < (char)uVar1) {
      return uVar2;
    }
    uVar1 = FUN_0000385e();
  } while ((char)uVar1 != '~');
  return uVar2;
}



/* Ghidra-derived function 0000385e FUN_0000385e */

undefined1 FUN_0000385e(void)

{
  undefined1 uVar1;
  int iVar2;
  
  while( true ) {
    iVar2 = (**(code **)(DAT_00000004 + -0x174))();
    if (iVar2 != 0) break;
    (**(code **)(DAT_00000004 + -0x180))();
  }
  (**(code **)(DAT_00000004 + -0x132))();
  uVar1 = DAT_000040ac;
  iVar2 = DAT_00004050;
  *(undefined2 *)(DAT_00004050 + 0x1c) = 2;
  *(undefined1 **)(iVar2 + 0x28) = &DAT_000040ac;
  *(undefined4 *)(iVar2 + 0x24) = 1;
  (**(code **)(DAT_00000004 + -0x1ce))();
  return uVar1;
}



/* Ghidra-derived function 000038b8 FUN_000038b8 */

undefined8 FUN_000038b8(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_000038c6();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 000038c6 FUN_000038c6 */

void FUN_000038c6(void)

{
  char in_D0b;
  
  FUN_000038ee();
  if (in_D0b == '\b') {
    FUN_000039e8();
    FUN_000038ee();
    return;
  }
  if (in_D0b == '\r') {
    FUN_000038f4();
    FUN_000038ee();
    return;
  }
  FUN_00003a1a();
  if ((DAT_00003f41 & 1) != 0) {
    DAT_00003f43 = DAT_00003f43 | 0x80;
    FUN_00003a1a();
    DAT_00003f43 = DAT_00003f43 & 0x7f;
    FUN_000039e8();
  }
  return;
}



/* Ghidra-derived function 000038ee FUN_000038ee */

void FUN_000038ee(void)

{
  if ((DAT_00003f41 & 1) != 0) {
    DAT_00003f43 = DAT_00003f43 | 0x80;
    FUN_00003a1a();
    DAT_00003f43 = DAT_00003f43 & 0x7f;
    FUN_000039e8();
  }
  return;
}



/* Ghidra-derived function 000038f4 FUN_000038f4 */

void FUN_000038f4(void)

{
  bool in_ZF;
  
  if (!in_ZF) {
    DAT_00003f43 = DAT_00003f43 | 0x80;
    FUN_00003a1a();
    DAT_00003f43 = DAT_00003f43 & 0x7f;
    FUN_000039e8();
  }
  return;
}



/* Ghidra-derived function 000038f6 FUN_000038f6 */

void FUN_000038f6(void)

{
  DAT_00003f43 = DAT_00003f43 | 0x80;
  FUN_00003a1a();
  DAT_00003f43 = DAT_00003f43 & 0x7f;
  FUN_000039e8();
  return;
}



/* Ghidra-derived function 00003914 FUN_00003914 */

void FUN_00003914(void)

{
  char cVar1;
  byte bVar2;
  
  cVar1 = DAT_00003ecb;
  if ((byte)(DAT_00003ecb + DAT_00003ecd) == DAT_00003ecf) {
    bVar2 = DAT_00003ecd;
    DAT_00003ead = DAT_00003ecb + DAT_00003ecd;
    DAT_00003ea8._3_1_ = 0;
    (**(code **)(DAT_00000004 + -0x84))
              (0,8,(uint)DAT_00003f44 * 8,(uint)DAT_00003ecd * 8,
               (uint)(byte)(DAT_00003f45 + DAT_00003f44) * 8 + -1,
               (uint)(byte)(DAT_00003ead + 1) * 8 + -1);
    (**(code **)(DAT_00004010 + -0x192))();
    (**(code **)(DAT_00004010 + -0x18c))();
    FUN_00003652();
    (**(code **)(DAT_00000004 + -0x8a))();
    DAT_00003ea8._3_1_ = cVar1;
    DAT_00003ead = bVar2;
  }
  else {
    DAT_00003ecf = DAT_00003ecf + '\x01';
  }
  DAT_00003ece = DAT_00003ecc;
  return;
}



/* Ghidra-derived function 000039e8 FUN_000039e8 */

void FUN_000039e8(void)

{
  if (DAT_00003ece == DAT_00003ecc) {
    if (DAT_00003ecf != DAT_00003ecd) {
      DAT_00003ecf = DAT_00003ecf + -1;
      DAT_00003ece = DAT_00003eca + DAT_00003ecc + -1;
    }
  }
  else {
    DAT_00003ece = DAT_00003ece + -1;
  }
  return;
}



/* Ghidra-derived function 00003a1a FUN_00003a1a */

void FUN_00003a1a(void)

{
  if ((char)(DAT_00003eca + DAT_00003ecc) == DAT_00003ece) {
    FUN_00003914();
  }
  FUN_00003a56();
  DAT_00003ece = DAT_00003ece + '\x01';
  return;
}



/* Ghidra-derived function 00003a56 FUN_00003a56 */

void FUN_00003a56(void)

{
  int iVar1;
  ushort uVar2;
  ushort uVar3;
  ushort uVar4;
  uint uVar5;
  ushort uVar6;
  byte bVar8;
  uint uVar7;
  short sVar9;
  ushort uVar10;
  ushort *in_A0;
  ushort *puVar11;
  int unaff_A2;
  
  uVar5 = (uint)DAT_00003ecf;
  uVar4 = *in_A0;
  bVar8 = (DAT_00003ece >> 2) * '\x03';
  if ((DAT_00003eae & 2) != 0) {
    bVar8 = bVar8 + 1;
  }
  iVar1 = (int)(short)((DAT_00003ece & 3) << 2);
  uVar3 = *(ushort *)(&DAT_00003e66 + iVar1);
  uVar2 = *(ushort *)((int)&DAT_00003e68 + iVar1);
  uVar7 = 0;
  do {
    puVar11 = (ushort *)
              (*(int *)((int)in_A0 + (short)((short)uVar7 << 2) + 8) +
              (uint)bVar8 + uVar5 * 8 * (uint)uVar4);
    sVar9 = 0;
    do {
      uVar10 = *puVar11;
      uVar6 = 0;
      if ((DAT_00003ed4 & '\x01' << (uVar7 & 7)) != 0) {
        uVar6 = (ushort)(byte)~*(byte *)(unaff_A2 + sVar9);
      }
      if ((DAT_00003ed3 & '\x01' << (uVar7 & 7)) != 0) {
        uVar6 = (ushort)(byte)(*(byte *)(unaff_A2 + sVar9) | (byte)uVar6);
      }
      if ((DAT_00003f41 & 0x80) == 0) {
        uVar10 = uVar3 & uVar10;
      }
      uVar10 = uVar10 ^ (uVar6 >> 2) << (uVar2 & 0x3f);
      *(char *)((int)puVar11 + 1) = (char)uVar10;
      *(char *)puVar11 = (char)(uVar10 >> 8);
      puVar11 = (ushort *)((int)(short)*in_A0 + (int)puVar11);
      sVar9 = sVar9 + 1;
    } while (sVar9 != 8);
    uVar10 = (short)uVar7 + 1;
    uVar7 = (uint)uVar10;
  } while ((char)uVar10 < *(char *)((int)in_A0 + 5));
  return;
}



/* Ghidra-derived function 00003afc FUN_00003afc */

undefined8 FUN_00003afc(void)

{
  byte bVar1;
  undefined4 in_D0;
  undefined4 in_D1;
  
  bVar1 = DAT_00003f43 & 1;
  DAT_00003f43 = DAT_00003f43 | 1;
  if (bVar1 == 0) {
    FUN_000038f6();
  }
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003b26 FUN_00003b26 */

void FUN_00003b26(void)

{
  (**(code **)(DAT_00004010 + -0xc0))();
  return;
}



/* Ghidra-derived function 00003ba6 FUN_00003ba6 */

ulonglong FUN_00003ba6(void)

{
  int *piVar1;
  int in_D0;
  int iVar2;
  int iVar3;
  undefined4 uVar4;
  uint in_D1;
  uint extraout_D1;
  
  iVar2 = (**(code **)(DAT_00000004 + -0x14a))();
  if (iVar2 != -1) {
    iVar3 = (**(code **)(DAT_00000004 + -0xc6))();
    if (iVar3 != 0) {
      *(char *)(iVar3 + 0xf) = (char)iVar2;
      *(undefined1 *)(iVar3 + 0xe) = 0;
      uVar4 = (**(code **)(DAT_00000004 + -0x126))();
      *(undefined4 *)(iVar3 + 0x10) = uVar4;
      *(undefined1 *)(iVar3 + 8) = 4;
      *(char *)(iVar3 + 9) = (char)in_D1;
      *(int *)(iVar3 + 10) = in_D0;
      if (in_D0 == 0) {
        piVar1 = (int *)(iVar3 + 0x14);
        *piVar1 = (int)piVar1;
        *piVar1 = *piVar1 + 4;
        *(undefined4 *)(iVar3 + 0x18) = 0;
        *(int **)(iVar3 + 0x1c) = piVar1;
      }
      else {
        (**(code **)(DAT_00000004 + -0x162))();
        in_D1 = extraout_D1;
      }
      return CONCAT44(iVar3,in_D1);
    }
    (**(code **)(DAT_00000004 + -0x150))();
  }
  return (ulonglong)in_D1;
}



/* Ghidra-derived function 00003c44 FUN_00003c44 */

void FUN_00003c44(void)

{
  int in_D0;
  
  if (*(int *)(in_D0 + 10) != 0) {
    (**(code **)(DAT_00000004 + -0x168))();
  }
  (**(code **)(DAT_00000004 + -0x150))(in_D0);
  (**(code **)(DAT_00000004 + -0xd2))();
  return;
}



/* Ghidra-derived function 00003cb6 FUN_00003cb6 */

void FUN_00003cb6(void)

{
  int in_D0;
  
  *(undefined1 *)(in_D0 + 8) = 0xff;
  *(undefined4 *)(in_D0 + 0x14) = 0xffffffff;
  *(undefined4 *)(in_D0 + 0x18) = 0xffffffff;
  (**(code **)(DAT_00000004 + -0xd2))();
  return;
}



