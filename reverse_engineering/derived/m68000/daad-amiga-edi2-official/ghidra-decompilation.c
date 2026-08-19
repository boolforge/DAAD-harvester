/* Ghidra-derived function 00001432 FUN_00001432 */

undefined4 FUN_00001432(void)

{
  byte *in_A0;
  
  if ((*in_A0 != 0xff) && (0x31 < *in_A0)) {
    DAT_00001ce6 = *in_A0;
    DAT_00001ce7 = in_A0[1];
  }
  return 0;
}



/* Ghidra-derived function 00001626 FUN_00001626 */

void FUN_00001626(void)

{
  char *in_A0;
  
  for (; *in_A0 == ' '; in_A0 = in_A0 + 1) {
  }
  return;
}



/* Ghidra-derived function 00001634 FUN_00001634 */

void FUN_00001634(void)

{
  char cVar1;
  char *in_A0;
  bool bVar2;
  
  bVar2 = *in_A0 == '\0';
  cVar1 = FUN_00001648();
  if ((!bVar2) && ((cVar1 < 'A' || ('Z' < cVar1)))) {
    return;
  }
  return;
}



/* Ghidra-derived function 00001648 FUN_00001648 */

void FUN_00001648(void)

{
  char in_D0b;
  
  if ('/' < in_D0b) {
    return;
  }
  return;
}



/* Ghidra-derived function 00001744 FUN_00001744 */

void FUN_00001744(void)

{
  char in_D0b;
  int unaff_D4;
  char *pcVar1;
  char *pcVar2;
  int unaff_A6;
  
  pcVar1 = &DAT_00001db8 + unaff_D4;
  for (pcVar2 = (char *)(unaff_A6 + unaff_D4 * 2 + (uint)*(ushort *)(unaff_A6 + 0x1a));
      ((char)unaff_D4 != *(char *)(unaff_A6 + 3) &&
      (((in_D0b != -1 && (in_D0b != *pcVar1)) || (*pcVar2 == -1)))); pcVar2 = pcVar2 + 2) {
    unaff_D4 = unaff_D4 + 1;
    pcVar1 = pcVar1 + 1;
  }
  return;
}



/* Ghidra-derived function 0000185e FUN_0000185e */

void FUN_0000185e(void)

{
  byte in_D0b;
  char extraout_D1b;
  int unaff_A6;
  undefined1 uVar1;
  undefined1 uVar2;
  
  uVar1 = in_D0b == *(byte *)(unaff_A6 + 3);
  if (*(byte *)(unaff_A6 + 3) <= in_D0b) {
    return;
  }
  FUN_0000194a();
  do {
    uVar2 = uVar1;
    FUN_00001896();
    uVar1 = 1;
  } while ((bool)uVar2);
  uVar1 = (DAT_00001cab & 0x10) == 0;
  if (!(bool)uVar1) {
    do {
      FUN_00001896();
    } while (!(bool)uVar1);
    do {
      uVar2 = uVar1;
      FUN_00001896();
      uVar1 = 1;
    } while ((bool)uVar2);
  }
  do {
    FUN_0000249e();
    FUN_00001896();
  } while (extraout_D1b != -0x2f);
  return;
}



/* Ghidra-derived function 00001896 FUN_00001896 */

void FUN_00001896(void)

{
  int unaff_A4;
  int unaff_A6;
  
  if (*(char *)(unaff_A6 + unaff_A4) != -0xb) {
    return;
  }
  return;
}



/* Ghidra-derived function 000018ac FUN_000018ac */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_000018ac(void)

{
  undefined4 in_D0;
  uint uVar1;
  undefined1 uVar2;
  undefined1 unaff_D2b;
  int unaff_A6;
  
  _DAT_00001cee = 0;
  _DAT_00001cf2 = 0;
  DAT_00001ceb = (byte)in_D0;
  if (DAT_00001ceb != 0xff) {
    if (*(byte *)(unaff_A6 + 3) <= DAT_00001ceb) {
      FUN_00001aec();
      FUN_00001a5e();
      FUN_000026c2();
      FUN_00003684();
      return 0xffffffff;
    }
    uVar1 = FUN_00001a1e();
    if ((uVar1 & 0x80) != 0) {
      _DAT_00001cee = _DAT_00001cee | 0x80;
    }
    if ((uVar1 & 0x40) != 0) {
      _DAT_00001cee = _DAT_00001cee | 0x8000;
    }
    uVar2 = FUN_00001920();
    _DAT_00001cee = CONCAT13(uVar2,_DAT_00001cef);
    FUN_0000199a();
    _DAT_00001cef = CONCAT12(unaff_D2b,_DAT_00001cf0);
    _DAT_00001cf2 = FUN_00001932();
  }
  return in_D0;
}



/* Ghidra-derived function 00001920 FUN_00001920 */

undefined1 FUN_00001920(void)

{
  uint in_D1;
  
  return (&DAT_00001db8)[in_D1 & 0xff];
}



/* Ghidra-derived function 00001932 FUN_00001932 */

undefined2 FUN_00001932(void)

{
  uint in_D1;
  int unaff_A6;
  
  return *(undefined2 *)(unaff_A6 + (in_D1 & 0xff) * 2 + (uint)*(ushort *)(unaff_A6 + 0x1e));
}



/* Ghidra-derived function 0000194a FUN_0000194a */

void FUN_0000194a(void)

{
  return;
}



/* Ghidra-derived function 0000199a FUN_0000199a */

void FUN_0000199a(void)

{
  FUN_000019a6();
  return;
}



/* Ghidra-derived function 000019a6 FUN_000019a6 */

undefined8 FUN_000019a6(void)

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
  
  uVar1 = FUN_00001a1e();
  uVar2 = uVar1 & 0xffffff3f;
  if (((uVar1 & 0x40) != 0) && ((char)uVar2 != '\0')) {
    uVar4 = unaff_D2w;
    if (unaff_D3b != '\t') {
      sVar6 = *(byte *)(unaff_A6 + 3) - 1;
      sVar3 = 0;
      uVar4 = (ushort)uVar1 & 0xff3f;
      puVar7 = &DAT_00001db8;
      do {
        uVar2 = CONCAT31((int3)(uVar2 >> 8),puVar7[sVar3]);
        if (puVar7[sVar3] == extraout_D1b) {
          uVar2 = FUN_000019a6();
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



/* Ghidra-derived function 00001a1e FUN_00001a1e */

undefined1 FUN_00001a1e(void)

{
  ushort in_D1w;
  int unaff_A6;
  
  return *(undefined1 *)(unaff_A6 + (uint)in_D1w + (uint)*(ushort *)(unaff_A6 + 0x1c));
}



/* Ghidra-derived function 00001a5e FUN_00001a5e */

void FUN_00001a5e(void)

{
  DAT_00001cab = DAT_00001cab & 0xfd;
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_00001ab2();
  FUN_0000249e();
  return;
}



/* Ghidra-derived function 00001ab2 FUN_00001ab2 */

void FUN_00001ab2(void)

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
    FUN_0000249e();
  }
  return;
}



/* Ghidra-derived function 00001ade FUN_00001ade */

void FUN_00001ade(void)

{
  FUN_00001b3e();
  FUN_00001aec();
  return;
}



/* Ghidra-derived function 00001aec FUN_00001aec */

void FUN_00001aec(void)

{
  byte bVar1;
  int unaff_D6;
  int unaff_A4;
  int unaff_A6;
  
  for (; (byte)~*(byte *)(unaff_A4 + unaff_D6) != 10; unaff_A4 = unaff_A4 + 1) {
    if ((byte)~*(byte *)(unaff_A4 + unaff_D6) == *(byte *)(unaff_A6 + 2)) {
      DAT_00001cab = DAT_00001cab | 0x10;
      FUN_0000185e();
    }
    else {
      FUN_0000249e();
    }
  }
  bVar1 = DAT_00001cad & 0x40;
  DAT_00001cad = DAT_00001cad & 0xbf;
  if (bVar1 != 0) {
    FUN_0000249a();
  }
  return;
}



/* Ghidra-derived function 00001b3e FUN_00001b3e */

void FUN_00001b3e(void)

{
  return;
}



/* Ghidra-derived function 000020f0 FUN_000020f0 */

void FUN_000020f0(void)

{
  short sVar1;
  byte bVar2;
  uint uVar3;
  byte *pbVar5;
  byte *pbVar6;
  bool bVar7;
  ushort uVar4;
  
  DAT_00003e32 = DAT_00003e46;
  if ((DAT_00001ce1 & 7) != 0) {
    FUN_000027fe();
  }
  FUN_00001ade();
  FUN_000026c2();
  DAT_00003db9 = DAT_00003db9 & 0xbf;
  DAT_00003db6 = 0xff;
  FUN_00001ade();
  FUN_00002466();
  FUN_00003a1c();
  DAT_00003e2e = DAT_00003db2;
  if ((((char)DAT_00001ce9 < '\0') && ((DAT_00001ce9 & 0x7f) >> 6 != 0)) &&
     ((DAT_00001ce9 & 0x3f) >> 5 != 0)) {
    func_0x000023de();
    func_0x000023f6();
  }
  else {
    DAT_00003c73 = '\0';
    LAB_00003bfa = 0xd;
    DAT_00003bf6 = &LAB_00003bfa;
  }
code_r0x00002184:
  if ((DAT_00001cac & 0x10) != 0) goto code_r0x000021b4;
  bVar7 = DAT_00001ce8 == '\0';
  if (bVar7) goto code_r0x000021b4;
  sVar1 = FUN_00003660();
  if (bVar7) {
    func_0x000023de();
    DAT_00001ce9 = DAT_00001ce9 | 0xc0;
code_r0x00002278:
    func_0x00003a30();
    if ((DAT_00001ce9 & 8) != 0) {
      FUN_0000355e();
    }
    DAT_00003db9 = DAT_00003db9 | 0x40;
    FUN_000027fe();
    if ((DAT_00001ce9 & 0x80) == 0) {
      if ((DAT_00001ce9 & 0x10) != 0) {
        FUN_00001ade();
      }
      for (pbVar6 = (byte *)0x3c1a; *pbVar6 != 0xd; pbVar6 = pbVar6 + 1) {
        if ((DAT_00001ce9 & 0x10) != 0) {
          FUN_000037d8();
        }
        bVar2 = *pbVar6;
        if ((0x60 < bVar2) && (bVar2 < 0x7b)) {
          *pbVar6 = bVar2 & 0xdf;
        }
      }
      if ((DAT_00001ce9 & 0x10) != 0) {
        FUN_0000249a();
      }
    }
    return;
  }
  do {
    if (sVar1 == 0x7f) {
      if (*DAT_00003bf6 != 0xd) {
        sVar1 = 0x78;
        pbVar6 = DAT_00003bf6;
        do {
          pbVar5 = pbVar6 + 1;
          if (*pbVar6 == 0xd) break;
          sVar1 = sVar1 + -1;
          pbVar6 = pbVar5;
        } while (sVar1 != -1);
        pbVar5 = pbVar5 + (-2 - (int)DAT_00003bf6);
        pbVar6 = DAT_00003bf6;
        do {
          *pbVar6 = pbVar6[1];
          uVar4 = (short)pbVar5 - 1;
          pbVar5 = (byte *)(uint)uVar4;
          pbVar6 = pbVar6 + 1;
        } while (uVar4 != 0xffff);
code_r0x0000237a:
        DAT_00003c73 = DAT_00003c73 + -1;
        func_0x000023de();
        FUN_000037d8();
        FUN_000037d8();
        func_0x000023f6();
      }
    }
    else {
      bVar2 = (byte)sVar1;
      if (bVar2 == 8) {
        if (DAT_00003bf6 != &LAB_00003bfa) {
          sVar1 = 0x78;
          pbVar6 = DAT_00003bf6;
          do {
            pbVar5 = pbVar6 + 1;
            if (*pbVar6 == 0xd) break;
            sVar1 = sVar1 + -1;
            pbVar6 = pbVar5;
          } while (sVar1 != -1);
          pbVar5 = pbVar5 + (-1 - (int)DAT_00003bf6);
          pbVar6 = DAT_00003bf6 + -1;
          do {
            *pbVar6 = pbVar6[1];
            uVar4 = (short)pbVar5 - 1;
            pbVar5 = (byte *)(uint)uVar4;
            pbVar6 = pbVar6 + 1;
          } while (uVar4 != 0xffff);
          FUN_000037d8();
          DAT_00003bf6 = DAT_00003bf6 + -1;
          goto code_r0x0000237a;
        }
      }
      else if (sVar1 == -0xbc) {
        if (DAT_00003bf6 != &LAB_00003bfa) {
          DAT_00003bf6 = DAT_00003bf6 + -1;
          FUN_000037d8();
        }
      }
      else if (sVar1 == -0xbd) {
        if (*DAT_00003bf6 != 0xd) {
          DAT_00003bf6 = DAT_00003bf6 + 1;
          FUN_000037d8();
        }
      }
      else if (bVar2 == 0xd) {
        if (DAT_00003c73 != '\0') {
          func_0x000023de();
          func_0x00002418();
          FUN_0000249a();
          DAT_00003c74 = 'x';
          DAT_00001ce9 = DAT_00001ce9 & 0x3f;
          goto code_r0x00002278;
        }
      }
      else if (((DAT_00003c73 != DAT_00003c74) && (0x1f < bVar2)) && ((char)bVar2 < '{')) {
        sVar1 = 0x78;
        pbVar6 = DAT_00003bf6;
        do {
          pbVar5 = pbVar6;
          if (*pbVar5 == 0xd) break;
          sVar1 = sVar1 + -1;
          pbVar6 = pbVar5 + 1;
        } while (sVar1 != -1);
        uVar3 = (int)pbVar5 - (int)DAT_00003bf6;
        do {
          pbVar5[1] = *pbVar5;
          pbVar5 = pbVar5 + -1;
          uVar4 = (short)uVar3 - 1;
          uVar3 = (uint)uVar4;
        } while (uVar4 != 0xffff);
        DAT_00003c73 = DAT_00003c73 + '\x01';
        *DAT_00003bf6 = bVar2;
        DAT_00003bf6 = DAT_00003bf6 + 1;
        func_0x000023de();
        func_0x000023f6();
      }
    }
    if ((DAT_00001ce9 & 1) == 0) goto code_r0x00002184;
code_r0x000021b4:
    sVar1 = FUN_00003684();
  } while( true );
}



/* Ghidra-derived function 00002448 FUN_00002448 */

void FUN_00002448(void)

{
  undefined1 in_D0b;
  short sVar1;
  undefined *puVar2;
  
  sVar1 = 7;
  puVar2 = &DAT_00003dda;
  DAT_00003dd6 = in_D0b;
  do {
    puVar2[8] = puVar2[1];
    puVar2 = puVar2 + 0xc;
    sVar1 = sVar1 + -1;
  } while (sVar1 != -1);
  return;
}



/* Ghidra-derived function 00002466 FUN_00002466 */

void FUN_00002466(void)

{
  short sVar1;
  char cVar2;
  
  sVar1 = (DAT_00003dcf + 1) * (ushort)DAT_00003dce -
          (((ushort)DAT_00003dd2 - (ushort)DAT_00003dd0) + 1);
  if ((sVar1 < 0x79) && (cVar2 = (char)sVar1, cVar2 <= DAT_00003c94)) {
    DAT_00003c74 = cVar2;
  }
  return;
}



/* Ghidra-derived function 0000249a FUN_0000249a */

/* WARNING: Removing unreachable block (ram,0x000024a4) */
/* WARNING: Removing unreachable block (ram,0x000024b0) */
/* WARNING: Removing unreachable block (ram,0x000024ba) */
/* WARNING: Removing unreachable block (ram,0x000024c8) */
/* WARNING: Removing unreachable block (ram,0x000024cc) */
/* WARNING: Removing unreachable block (ram,0x000024d6) */
/* WARNING: Removing unreachable block (ram,0x00002596) */
/* WARNING: Removing unreachable block (ram,0x000025be) */
/* WARNING: Removing unreachable block (ram,0x000024ea) */
/* WARNING: Removing unreachable block (ram,0x00002580) */
/* WARNING: Removing unreachable block (ram,0x00002590) */
/* WARNING: Removing unreachable block (ram,0x000025a0) */
/* WARNING: Removing unreachable block (ram,0x000025b8) */
/* WARNING: Removing unreachable block (ram,0x000025ae) */
/* WARNING: Removing unreachable block (ram,0x00002586) */
/* WARNING: Removing unreachable block (ram,0x000024f2) */
/* WARNING: Removing unreachable block (ram,0x000024fc) */
/* WARNING: Removing unreachable block (ram,0x00002500) */
/* WARNING: Removing unreachable block (ram,0x0000250a) */
/* WARNING: Removing unreachable block (ram,0x00002510) */
/* WARNING: Removing unreachable block (ram,0x00002516) */
/* WARNING: Removing unreachable block (ram,0x00002520) */
/* WARNING: Removing unreachable block (ram,0x00002524) */
/* WARNING: Removing unreachable block (ram,0x00002542) */
/* WARNING: Removing unreachable block (ram,0x0000254c) */
/* WARNING: Removing unreachable block (ram,0x0000255e) */

undefined4 FUN_0000249a(void)

{
  byte bVar1;
  undefined4 uVar2;
  
  FUN_000026c2();
  bVar1 = DAT_00003db9 & 0x80;
  DAT_00003db9 = DAT_00003db9 & 0x7f;
  if (bVar1 == 0) {
    uVar2 = FUN_000025ce();
  }
  else {
    uVar2 = FUN_000037d8();
  }
  return uVar2;
}



/* Ghidra-derived function 0000249e FUN_0000249e */

void FUN_0000249e(void)

{
  undefined3 uVar1;
  undefined3 extraout_var;
  uint in_D0;
  char cVar2;
  byte bVar3;
  int iVar4;
  int extraout_A1;
  int unaff_A6;
  
  if (((in_D0 & 0x80) != 0) && ((DAT_00001cab & 4) != 0)) {
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
      FUN_000024e2();
      iVar4 = extraout_A1 + 1;
      uVar1 = extraout_var;
    }
  }
  bVar3 = (byte)in_D0;
  if (bVar3 == 0xd) {
    FUN_000026c2();
    bVar3 = DAT_00003db9 & 0x80;
    DAT_00003db9 = DAT_00003db9 & 0x7f;
    if (bVar3 == 0) {
      FUN_000025ce();
    }
    else {
      FUN_000037d8();
    }
  }
  else if (bVar3 < 0x10) {
    if (bVar3 == 0xf) {
      DAT_00003db9 = DAT_00003db9 & 0xfe;
    }
    else if (bVar3 == 0xe) {
      DAT_00003db9 = DAT_00003db9 | 1;
    }
    else {
      FUN_000026c2();
      if ((char)in_D0 == '\v') {
        FUN_0000355e();
      }
      else if ((char)in_D0 == '\f') {
        FUN_0000364a();
      }
    }
  }
  else {
    if ((DAT_00003db9 & 1) != 0) {
      in_D0 = in_D0 | 0x80;
    }
    if ((DAT_00003db9 & 0x40) != 0) {
      if (((char)in_D0 != ' ') && ((char)in_D0 != -0x60)) {
        if (DAT_00001c48 == 'P') {
          in_D0 = FUN_000026c2();
        }
        DAT_00003db9 = DAT_00003db9 & 0xdf;
        *DAT_00001c44 = (char)in_D0;
        DAT_00001c44 = DAT_00001c44 + 1;
        DAT_00001c48 = DAT_00001c48 + '\x01';
        return;
      }
      if ((DAT_00003db9 & 0x20) != 0) {
        return;
      }
      FUN_000026c2(in_D0);
      if ((DAT_00003db9 & 0x20) != 0) {
        return;
      }
    }
    FUN_0000267c();
  }
  return;
}



/* Ghidra-derived function 000024e2 FUN_000024e2 */

void FUN_000024e2(void)

{
  uint in_D0;
  byte bVar1;
  
  bVar1 = (byte)in_D0;
  if (bVar1 == 0xd) {
    FUN_000026c2();
    bVar1 = DAT_00003db9 & 0x80;
    DAT_00003db9 = DAT_00003db9 & 0x7f;
    if (bVar1 == 0) {
      FUN_000025ce();
    }
    else {
      FUN_000037d8();
    }
  }
  else if (bVar1 < 0x10) {
    if (bVar1 == 0xf) {
      DAT_00003db9 = DAT_00003db9 & 0xfe;
    }
    else if (bVar1 == 0xe) {
      DAT_00003db9 = DAT_00003db9 | 1;
    }
    else {
      FUN_000026c2();
      if ((char)in_D0 == '\v') {
        FUN_0000355e();
      }
      else if ((char)in_D0 == '\f') {
        FUN_0000364a();
      }
    }
  }
  else {
    if ((DAT_00003db9 & 1) != 0) {
      in_D0 = in_D0 | 0x80;
    }
    if ((DAT_00003db9 & 0x40) != 0) {
      if (((char)in_D0 != ' ') && ((char)in_D0 != -0x60)) {
        if (DAT_00001c48 == 'P') {
          in_D0 = FUN_000026c2();
        }
        DAT_00003db9 = DAT_00003db9 & 0xdf;
        *DAT_00001c44 = (char)in_D0;
        DAT_00001c44 = DAT_00001c44 + 1;
        DAT_00001c48 = DAT_00001c48 + '\x01';
        return;
      }
      if ((DAT_00003db9 & 0x20) != 0) {
        return;
      }
      FUN_000026c2(in_D0);
      if ((DAT_00003db9 & 0x20) != 0) {
        return;
      }
    }
    FUN_0000267c();
  }
  return;
}



/* Ghidra-derived function 000025ce FUN_000025ce */

uint FUN_000025ce(void)

{
  uint uVar1;
  int iVar2;
  int unaff_A6;
  undefined8 uVar3;
  
  uVar3 = FUN_000037d8();
  uVar1 = (uint)((ulonglong)uVar3 >> 0x20);
  DAT_00003db6 = DAT_00003db6 + -1;
  if (DAT_00003db6 == '\0') {
    uVar1 = uVar1 & 0xffff0000;
    DAT_00003db6 = DAT_00003dcf;
    if (((DAT_00001caa & 0x40) == 0) && ((DAT_00003db9 & 2) == 0)) {
      FUN_00001b3e(uVar1,(int)uVar3);
      DAT_00003e2a = DAT_00003dd9;
      DAT_00003db9 = 2;
      for (iVar2 = 0x20; *(char *)(unaff_A6 + iVar2) != -0xb; iVar2 = iVar2 + 1) {
        FUN_0000249e();
      }
      DAT_00003db9 = DAT_00003e4a;
      if (((DAT_00001ce9 & 2) == 0) || (DAT_00001ce8 == '\0')) {
        FUN_00003684();
      }
      else {
        FUN_00003660();
      }
      while (DAT_00003dd2 != DAT_00003dd0) {
        FUN_000037d8();
        FUN_000037d8();
        FUN_000037d8();
      }
    }
  }
  return uVar1;
}



/* Ghidra-derived function 000025d4 FUN_000025d4 */

void FUN_000025d4(void)

{
  uint in_D0;
  int iVar1;
  int unaff_A6;
  
  DAT_00003db6 = DAT_00003db6 + -1;
  if (DAT_00003db6 == '\0') {
    DAT_00003db6 = DAT_00003dcf;
    if (((DAT_00001caa & 0x40) == 0) && ((DAT_00003db9 & 2) == 0)) {
      FUN_00001b3e(in_D0 & 0xffff0000);
      DAT_00003e2a = DAT_00003dd9;
      DAT_00003db9 = 2;
      for (iVar1 = 0x20; *(char *)(unaff_A6 + iVar1) != -0xb; iVar1 = iVar1 + 1) {
        FUN_0000249e();
      }
      DAT_00003db9 = DAT_00003e4a;
      if (((DAT_00001ce9 & 2) == 0) || (DAT_00001ce8 == '\0')) {
        FUN_00003684();
      }
      else {
        FUN_00003660();
      }
      while (DAT_00003dd2 != DAT_00003dd0) {
        FUN_000037d8();
        FUN_000037d8();
        FUN_000037d8();
      }
    }
  }
  return;
}



/* Ghidra-derived function 0000267c FUN_0000267c */

void FUN_0000267c(void)

{
  byte bVar1;
  char in_D0b;
  
  FUN_000037d8();
  bVar1 = DAT_00003db9;
  DAT_00003db9 = DAT_00003db9 & 0x7f;
  if ((char)(DAT_00003dce + DAT_00003dd0) == DAT_00003dd2) {
    if ((in_D0b == ' ') && ((bVar1 & 0x40) != 0)) {
      DAT_00003db9 = DAT_00003db9 | 0x20;
    }
    FUN_000025d4();
    DAT_00003db9 = DAT_00003db9 | 0x80;
  }
  return;
}



/* Ghidra-derived function 000026c2 FUN_000026c2 */

void FUN_000026c2(void)

{
  byte bVar1;
  ushort uVar2;
  
  if (((DAT_00003db9 & 0x40) != 0) && (DAT_00001c48 != 0)) {
    bVar1 = (DAT_00003dce + DAT_00003dd0) - DAT_00003dd2;
    if ((char)(DAT_00003dce + DAT_00003dd0) != DAT_00003dd2) {
      if (bVar1 == DAT_00001c48) {
        DAT_00003db9 = DAT_00003db9 | 0x20;
      }
      else if (bVar1 < DAT_00001c48) {
        FUN_000025ce();
      }
    }
    uVar2 = (ushort)DAT_00001c48;
    while (uVar2 = uVar2 - 1, uVar2 != 0xffff) {
      FUN_0000267c();
    }
    DAT_00001c44 = &DAT_00001c49;
    DAT_00001c48 = 0;
    return;
  }
  return;
}



/* Ghidra-derived function 0000271e FUN_0000271e */

void FUN_0000271e(void)

{
  DAT_00003db9 = DAT_00003db9 & 0xdf;
  DAT_00001c44 = &DAT_00001c49;
  DAT_00001c48 = 0;
  return;
}



/* Ghidra-derived function 000027fe FUN_000027fe */

void FUN_000027fe(void)

{
  byte in_D0b;
  short sVar1;
  undefined4 *puVar2;
  undefined4 *puVar3;
  
  if (in_D0b != DAT_00003e46) {
    FUN_000026c2();
    sVar1 = 2;
    puVar2 = (undefined4 *)&DAT_00003dce;
    puVar3 = (undefined4 *)(&DAT_00003dda + (uint)DAT_00003e46 * 0xc);
    do {
      *puVar3 = *puVar2;
      sVar1 = sVar1 + -1;
      puVar2 = puVar2 + 1;
      puVar3 = puVar3 + 1;
    } while (sVar1 != -1);
    sVar1 = 2;
    puVar2 = (undefined4 *)(&DAT_00003dda + (uint)in_D0b * 0xc);
    puVar3 = (undefined4 *)&DAT_00003dce;
    DAT_00003e26 = in_D0b;
    do {
      *puVar3 = *puVar2;
      sVar1 = sVar1 + -1;
      puVar2 = puVar2 + 1;
      puVar3 = puVar3 + 1;
    } while (sVar1 != -1);
    FUN_00002860();
    if (DAT_00003e26 == 8) {
      FUN_000034f2();
    }
  }
  return;
}



/* Ghidra-derived function 00002860 FUN_00002860 */

void FUN_00002860(void)

{
  DAT_00003e29 = (&DAT_00003d9a)[(short)(ushort)(byte)(DAT_00003dce & 3 | (DAT_00003dd0 & 3) << 2)]
                 + (DAT_00003dce >> 2) * '\x03';
  DAT_00003e28 = (DAT_00003dd0 >> 2) * '\x03';
  if ((DAT_00003dd0 & 3) != 0) {
    DAT_00003e28 = ((DAT_00003dd0 & 3) - 1) + DAT_00003e28;
  }
  return;
}



/* Ghidra-derived function 00002922 FUN_00002922 */

void FUN_00002922(void)

{
  short sVar1;
  undefined4 *puVar2;
  undefined4 *puVar3;
  undefined4 *puVar4;
  undefined4 *puVar5;
  
  DAT_00003ebc = DAT_00003e9c;
  DAT_00003ec0 = DAT_00003ea0;
  DAT_00003ec4 = DAT_00003ea4;
  DAT_00003ec8 = DAT_00003ea8;
  DAT_00003ecc = DAT_00003eac;
  DAT_00003ed0 = DAT_00003eb0;
  DAT_00003ed4 = DAT_00003eb4;
  DAT_00003ed8 = DAT_00003eb8;
  puVar2 = (undefined4 *)(DAT_00003f6e + 0x28);
  puVar4 = (undefined4 *)(DAT_00003f72 + 0x28);
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



/* Ghidra-derived function 000029cc FUN_000029cc */

void FUN_000029cc(void)

{
  short sVar1;
  byte *in_A1;
  
  sVar1 = (ushort)(byte)(in_A1[2] >> 4 | in_A1[1] & 0xf0) << 4;
  *(ushort *)((int)&DAT_00003e9c + (int)(short)((*in_A1 & 0xf) << 1)) =
       CONCAT11((char)((ushort)sVar1 >> 8),in_A1[3] >> 4 | (byte)sVar1);
  FUN_00003a46();
  return;
}



/* Ghidra-derived function 00002e50 FUN_00002e50 */

undefined4 FUN_00002e50(void)

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
LAB_00002e5c:
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
        if (uVar6 == 0) goto LAB_00002e5c;
      }
      puVar10 = unaff_A3 + 1;
      *unaff_A3 = unaff_D4;
      sVar5 = 8;
      uVar6 = uVar6 - 1;
      unaff_A3 = puVar10;
    } while (uVar6 != 0);
  } while( true );
}



/* Ghidra-derived function 00002ee8 FUN_00002ee8 */

ulonglong FUN_00002ee8(void)

{
  uint uVar1;
  undefined1 uVar2;
  int iVar3;
  int in_D0;
  uint in_D1;
  
  iVar3 = DAT_00003dac;
  uVar2 = DAT_00003d89;
  if ((((DAT_00001cd5 & 0x20) != 0) || ((DAT_00001caa & 2) == 0)) ||
     ((*(byte *)(DAT_00003dac + 5) & 0x10) != 0)) {
    return (ulonglong)in_D1;
  }
  DAT_00003db2 = DAT_00003dd0;
  DAT_00003db3 = DAT_00003dd1;
  if ((*(byte *)(DAT_00003dac + 5) & 1) == 0) {
    DAT_00003db3 = (undefined1)(*(ushort *)(DAT_00003dac + 8) >> 3);
    uVar1 = *(ushort *)(DAT_00003dac + 6) / 6;
    DAT_00003db2 = (char)uVar1;
    if (((uVar1 & 3) != 0) && (((ushort)uVar1 & 3) != 3)) {
      DAT_00003db2 = DAT_00003db2 + '\x01';
    }
    DAT_00003e28 = (undefined1)(*(ushort *)(DAT_00003dac + 6) >> 3);
    DAT_00003db0 = DAT_00003db2;
    DAT_00003db1 = DAT_00003db3;
  }
  if ((*(byte *)(DAT_00003dac + 5) & 1) == 0) {
    DAT_00003dac._2_2_ = CONCAT11((char)(DAT_00003dbc / 6),(char)(DAT_00003dbe >> 3) + -1);
    DAT_00003e29 = (char)(DAT_00003dbc >> 3);
  }
  DAT_00003db6 = DAT_00003dcf;
  if (in_D0 == 0) {
    if (DAT_00003d68 == '\0') {
      FUN_00003456();
      if ((*(byte *)(iVar3 + 5) & 1) == 0) {
        FUN_00003050();
        FUN_00003a46();
      }
    }
    else {
      FUN_00003456();
      if ((*(byte *)(iVar3 + 5) & 1) == 0) {
        FUN_00003050();
        return (ulonglong)in_D1;
      }
    }
    return (ulonglong)in_D1;
  }
  DAT_00003d89 = DAT_00003d88;
  FUN_00003572();
  DAT_00003d89 = uVar2;
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003050 FUN_00003050 */

void FUN_00003050(void)

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



/* Ghidra-derived function 00003256 FUN_00003256 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003256(void)

{
  undefined4 *puVar1;
  int iVar2;
  char cVar4;
  undefined4 uVar3;
  
  FUN_000027fe();
  FUN_0000355e();
  FUN_0000340a();
  cVar4 = FUN_00003684();
  iVar2 = DAT_00003f24;
  if (cVar4 != '\x1b') {
    FUN_000027fe();
    uVar3 = FUN_00003528();
    return uVar3;
  }
  if (DAT_00003f58 != 0) {
    _DAT_00dff09a = DAT_00003f5a;
    puVar1 = (undefined4 *)(DAT_00000004 + -0xa2);
    *(undefined4 *)(DAT_00003f24 + -4) = 0x50a;
    (*(code *)*puVar1)();
    puVar1 = (undefined4 *)(DAT_00000004 + -0xd2);
    *(undefined4 *)(iVar2 + -4) = 0x51c;
    (*(code *)*puVar1)();
    puVar1 = (undefined4 *)(DAT_00000004 + -0x150);
    *(undefined4 *)(iVar2 + -4) = 0x528;
    (*(code *)*puVar1)();
    *(undefined2 *)(DAT_00003f4c + 0x1c) = 9;
    puVar1 = (undefined4 *)(DAT_00000004 + -0x1c8);
    *(undefined4 *)(iVar2 + -4) = 0x53a;
    (*(code *)*puVar1)();
  }
  puVar1 = (undefined4 *)(DAT_00000004 + -0x1c2);
  *(undefined4 *)(iVar2 + -4) = 0x546;
  (*(code *)*puVar1)();
  *(undefined4 *)(iVar2 + -4) = 0x54e;
  FUN_00003bd6();
  *(undefined4 *)(iVar2 + -4) = 0x556;
  FUN_00003b64();
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
  FUN_00003bd6();
  *(undefined4 *)(iVar2 + -4) = 0x5ea;
  FUN_00003b64();
  puVar1 = (undefined4 *)(DAT_00003ef4 + -0x48);
  *(undefined4 *)(iVar2 + -4) = 0x5f8;
  (*(code *)*puVar1)();
  puVar1 = (undefined4 *)(DAT_00003ef4 + -0x42);
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



/* Ghidra-derived function 00003284 FUN_00003284 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003284(void)

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
  
  s_audio_device_00003fd5[0] = *in_A0;
  s_audio_device_00003fd5[1] = in_A0[1];
  s_audio_device_00003fd5[2] = in_A0[2];
  do {
    s_audio_device_00003fd5[3] = '\0';
    iRam00003f04 = (**(code **)(DAT_00003efc + -0x54))(unaff_A6b);
    if (iRam00003f04 != 0) {
      uRam00004088 = unaff_D6;
      if (unaff_D6 == 0) {
        iVar3 = (**(code **)(DAT_00003efc + -0x66))();
        if (iVar3 != 0) {
          bVar1 = DAT_00001caa & 8;
          DAT_00001caa = DAT_00001caa & 0xf7;
          if ((bVar1 != 0) && (0x1b009 < uRam00004088)) {
            uRam00004088 = 0x1b00a;
          }
          goto code_r0x000032f2;
        }
      }
      else {
code_r0x000032f2:
        uVar4 = (**(code **)(DAT_00003efc + -0x1e))();
        if (uVar4 != 0) {
          if (unaff_D5 == 0) {
code_r0x00003358:
            uVar4 = (**(code **)(DAT_00003efc + -0x2a))((short)uVar4);
            if (uVar4 == uRam00004088) {
              (**(code **)(DAT_00003efc + -0x24))();
              (**(code **)(DAT_00003efc + -0x5a))();
              return 0;
            }
          }
          else {
            uVar5 = (ushort)uVar4;
            iVar3 = (**(code **)(DAT_00003efc + -0x42))(uVar5);
            if (iVar3 != -1) {
              iVar3 = (**(code **)(DAT_00003efc + -0x2a))(uVar5);
              uVar4 = (uint)uVar5;
              if (iVar3 == 6) {
                uRam00004088 = (uint)DAT_00003dc0;
                goto code_r0x00003358;
              }
            }
          }
          (**(code **)(DAT_00003efc + -0x24))();
        }
      }
      (**(code **)(DAT_00003efc + -0x5a))();
    }
    iVar3 = (**(code **)(DAT_00003efc + -0x84))();
    if (iVar3 == 0xcd) {
      return 0xffffffff;
    }
    if (iVar3 != 0xe2) {
      FUN_000027fe();
      FUN_0000355e();
      FUN_0000340a();
      FUN_00003684();
      iVar3 = DAT_00003f24;
      if (DAT_00003f58 != 0) {
        _DAT_00dff09a = DAT_00003f5a;
        puVar2 = (undefined4 *)(DAT_00000004 + -0xa2);
        *(undefined4 *)(DAT_00003f24 + -4) = 0x50a;
        (*(code *)*puVar2)();
        puVar2 = (undefined4 *)(DAT_00000004 + -0xd2);
        *(undefined4 *)(iVar3 + -4) = 0x51c;
        (*(code *)*puVar2)();
        puVar2 = (undefined4 *)(DAT_00000004 + -0x150);
        *(undefined4 *)(iVar3 + -4) = 0x528;
        (*(code *)*puVar2)();
        *(undefined2 *)(DAT_00003f4c + 0x1c) = 9;
        puVar2 = (undefined4 *)(DAT_00000004 + -0x1c8);
        *(undefined4 *)(iVar3 + -4) = 0x53a;
        (*(code *)*puVar2)();
      }
      puVar2 = (undefined4 *)(DAT_00000004 + -0x1c2);
      *(undefined4 *)(iVar3 + -4) = 0x546;
      (*(code *)*puVar2)();
      *(undefined4 *)(iVar3 + -4) = 0x54e;
      FUN_00003bd6();
      *(undefined4 *)(iVar3 + -4) = 0x556;
      FUN_00003b64();
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
      FUN_00003bd6();
      *(undefined4 *)(iVar3 + -4) = 0x5ea;
      FUN_00003b64();
      puVar2 = (undefined4 *)(DAT_00003ef4 + -0x48);
      *(undefined4 *)(iVar3 + -4) = 0x5f8;
      (*(code *)*puVar2)();
      puVar2 = (undefined4 *)(DAT_00003ef4 + -0x42);
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
    FUN_000027fe();
    FUN_0000355e();
    FUN_0000340a();
    FUN_00003684();
    FUN_000027fe();
    FUN_00003528();
  } while( true );
}



/* Ghidra-derived function 0000340a FUN_0000340a */

undefined8 FUN_0000340a(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_00001aec();
  FUN_000026c2();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003432 FUN_00003432 */

undefined8 FUN_00003432(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_0000340a();
  s_datchrddbscr2part1_chr_00003fe2[0x16] = -0xb;
  FUN_00001aec();
  FUN_000026c2();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003456 FUN_00003456 */

undefined8 FUN_00003456(void)

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
  
  iVar1 = (uint)DAT_00003e48 + (uint)DAT_00003dd1 * 8 * (uint)*in_A0;
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



/* Ghidra-derived function 000034f2 FUN_000034f2 */

undefined8 FUN_000034f2(void)

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
  puVar2 = *(undefined1 **)(DAT_00003f2c + 0xc0);
  puVar3 = *(undefined1 **)(DAT_00003f2c + 0xc4);
  puVar4 = *(undefined1 **)(DAT_00003f2c + 200);
  puVar5 = *(undefined1 **)(DAT_00003f2c + 0xcc);
  puVar7 = DAT_00003d70;
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



/* Ghidra-derived function 00003528 FUN_00003528 */

undefined8 FUN_00003528(void)

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
  puVar2 = *(undefined1 **)(DAT_00003f2c + 0xc0);
  puVar3 = *(undefined1 **)(DAT_00003f2c + 0xc4);
  puVar4 = *(undefined1 **)(DAT_00003f2c + 200);
  puVar5 = *(undefined1 **)(DAT_00003f2c + 0xcc);
  puVar7 = DAT_00003d70;
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



/* Ghidra-derived function 0000355e FUN_0000355e */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8 FUN_0000355e(void)

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
  
  uVar4 = FUN_0000271e();
  _DAT_00003db2 = _DAT_00003dd0;
  DAT_00003db6 = DAT_00003dcf;
  puVar11 = DAT_00003f6e;
  if (DAT_00003d69 != '\0') {
    puVar11 = DAT_00003f72;
  }
  uVar3 = (uint)DAT_00003dd1;
  uVar1 = *puVar11;
  uVar6 = (uint)DAT_00003e48;
  uVar2 = *puVar11;
  uVar7 = (uint)DAT_00003e49;
  uVar8 = 0;
  do {
    puVar12 = (undefined1 *)
              (*(int *)((int)puVar11 + (short)((short)uVar8 << 2) + 8) +
              uVar6 + uVar3 * 8 * (uint)uVar1);
    uVar5 = 0;
    if ((DAT_00003dd8 & '\x01' << (uVar8 & 7)) != 0) {
      uVar5 = 0xff;
    }
    sVar9 = (DAT_00003dcf + 1) * 8;
    while (sVar9 = sVar9 + -1, sVar9 != -1) {
      uVar10 = (ushort)DAT_00003e49;
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



/* Ghidra-derived function 00003572 FUN_00003572 */

undefined8 FUN_00003572(void)

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
  
  puVar10 = DAT_00003f6e;
  if (DAT_00003d69 != '\0') {
    puVar10 = DAT_00003f72;
  }
  uVar3 = (uint)DAT_00003dd1;
  uVar1 = *puVar10;
  uVar5 = (uint)DAT_00003e48;
  uVar2 = *puVar10;
  uVar6 = (uint)DAT_00003e49;
  uVar7 = 0;
  do {
    puVar11 = (undefined1 *)
              (*(int *)((int)puVar10 + (short)((short)uVar7 << 2) + 8) +
              uVar5 + uVar3 * 8 * (uint)uVar1);
    uVar4 = 0;
    if ((DAT_00003dd8 & '\x01' << (uVar7 & 7)) != 0) {
      uVar4 = 0xff;
    }
    sVar8 = (DAT_00003dcf + 1) * 8;
    while (sVar8 = sVar8 + -1, sVar8 != -1) {
      uVar9 = (ushort)DAT_00003e49;
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



/* Ghidra-derived function 0000364a FUN_0000364a */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_0000364a(void)

{
  short sVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  undefined4 uVar5;
  int iVar6;
  
  FUN_00002448();
  if (((DAT_00001ce9 & 4) == 0) || (DAT_00001ce8 == 0)) {
    (**(code **)(DAT_00000004 + -0x78))();
    register0x00000000 = 0;
  }
  else {
    (**(code **)(DAT_00000004 + -0x78))();
    register0x00000000 = (uint)DAT_00001ce8 << 6;
  }
  (**(code **)(DAT_00000004 + -0x132))();
  (**(code **)(DAT_00000004 + -0x7e))();
  do {
    bVar2 = *(byte *)(DAT_00003f34 + 0xf);
    bVar3 = *(byte *)(*(int *)(DAT_00003f30 + 0x56) + 0xf);
    uVar4 = (**(code **)(DAT_00000004 + -0x13e))();
    uVar5 = 0;
    if ((uVar4 & 1 << (bVar2 & 0x1f)) != 0) {
      uVar5 = FUN_0000372e();
    }
    do {
      if ((uVar4 & 1 << (bVar3 & 0x1f)) == 0) goto LAB_00003714;
      iVar6 = (**(code **)(DAT_00000004 + -0x174))();
      uVar5 = 0;
    } while (iVar6 == 0);
    sVar1 = *(short *)(iVar6 + 0x18);
    (**(code **)(DAT_00000004 + -0x17a))();
  } while ((sVar1 != 0xe8) && (sVar1 != 0xe9));
  uVar5 = 0xd;
LAB_00003714:
  DAT_00003f72._0_2_ = *(undefined2 *)(DAT_00003f2c + 0x10);
  DAT_00003f6e._2_2_ = *(undefined2 *)(DAT_00003f2c + 0x12);
  return uVar5;
}



/* Ghidra-derived function 00003660 FUN_00003660 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003660(void)

{
  short sVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  undefined4 uVar5;
  int iVar6;
  
  (**(code **)(DAT_00000004 + -0x78))();
  register0x00000000 = (uint)DAT_00001ce8 << 6;
  (**(code **)(DAT_00000004 + -0x132))();
  (**(code **)(DAT_00000004 + -0x7e))();
  do {
    bVar2 = *(byte *)(DAT_00003f34 + 0xf);
    bVar3 = *(byte *)(*(int *)(DAT_00003f30 + 0x56) + 0xf);
    uVar4 = (**(code **)(DAT_00000004 + -0x13e))();
    uVar5 = 0;
    if ((uVar4 & 1 << (bVar2 & 0x1f)) != 0) {
      uVar5 = FUN_0000372e();
    }
    do {
      if ((uVar4 & 1 << (bVar3 & 0x1f)) == 0) goto LAB_00003714;
      iVar6 = (**(code **)(DAT_00000004 + -0x174))();
      uVar5 = 0;
    } while (iVar6 == 0);
    sVar1 = *(short *)(iVar6 + 0x18);
    (**(code **)(DAT_00000004 + -0x17a))();
  } while ((sVar1 != 0xe8) && (sVar1 != 0xe9));
  uVar5 = 0xd;
LAB_00003714:
  DAT_00003f72._0_2_ = *(undefined2 *)(DAT_00003f2c + 0x10);
  DAT_00003f6e._2_2_ = *(undefined2 *)(DAT_00003f2c + 0x12);
  return uVar5;
}



/* Ghidra-derived function 00003684 FUN_00003684 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_00003684(void)

{
  short sVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  undefined4 uVar5;
  int iVar6;
  
  (**(code **)(DAT_00000004 + -0x78))();
  ram0x00003f56 = 0;
  (**(code **)(DAT_00000004 + -0x132))();
  (**(code **)(DAT_00000004 + -0x7e))();
  do {
    bVar2 = *(byte *)(DAT_00003f34 + 0xf);
    bVar3 = *(byte *)(*(int *)(DAT_00003f30 + 0x56) + 0xf);
    uVar4 = (**(code **)(DAT_00000004 + -0x13e))();
    uVar5 = 0;
    if ((uVar4 & 1 << (bVar2 & 0x1f)) != 0) {
      uVar5 = FUN_0000372e();
    }
    do {
      if ((uVar4 & 1 << (bVar3 & 0x1f)) == 0) goto LAB_00003714;
      iVar6 = (**(code **)(DAT_00000004 + -0x174))();
      uVar5 = 0;
    } while (iVar6 == 0);
    sVar1 = *(short *)(iVar6 + 0x18);
    (**(code **)(DAT_00000004 + -0x17a))();
  } while ((sVar1 != 0xe8) && (sVar1 != 0xe9));
  uVar5 = 0xd;
LAB_00003714:
  DAT_00003f72._0_2_ = *(undefined2 *)(DAT_00003f2c + 0x10);
  DAT_00003f6e._2_2_ = *(undefined2 *)(DAT_00003f2c + 0x12);
  return uVar5;
}



/* Ghidra-derived function 0000372e FUN_0000372e */

uint FUN_0000372e(void)

{
  uint uVar1;
  char cVar3;
  uint uVar2;
  
  uVar1 = FUN_0000377e();
  if ((char)uVar1 != -0x65) {
    return uVar1 & 0xffff00ff;
  }
  uVar1 = FUN_0000377e();
  if ((char)uVar1 == ' ') {
    cVar3 = FUN_0000377e();
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
    uVar1 = FUN_0000377e();
  } while ((char)uVar1 != '~');
  return uVar2;
}



/* Ghidra-derived function 0000377e FUN_0000377e */

undefined1 FUN_0000377e(void)

{
  undefined1 uVar1;
  int iVar2;
  
  while( true ) {
    iVar2 = (**(code **)(DAT_00000004 + -0x174))();
    if (iVar2 != 0) break;
    (**(code **)(DAT_00000004 + -0x180))();
  }
  (**(code **)(DAT_00000004 + -0x132))();
  uVar1 = DAT_00003f94;
  iVar2 = DAT_00003f38;
  *(undefined2 *)(DAT_00003f38 + 0x1c) = 2;
  *(undefined1 **)(iVar2 + 0x28) = &DAT_00003f94;
  *(undefined4 *)(iVar2 + 0x24) = 1;
  (**(code **)(DAT_00000004 + -0x1ce))();
  return uVar1;
}



/* Ghidra-derived function 000037d8 FUN_000037d8 */

undefined8 FUN_000037d8(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_000037e6();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 000037e6 FUN_000037e6 */

void FUN_000037e6(void)

{
  char in_D0b;
  
  FUN_0000380e();
  if (in_D0b == '\b') {
    FUN_00003908();
    FUN_0000380e();
    return;
  }
  if (in_D0b == '\r') {
    FUN_00003814();
    FUN_0000380e();
    return;
  }
  FUN_0000393a();
  if ((DAT_00003e45 & 1) != 0) {
    DAT_00003e47 = DAT_00003e47 | 0x80;
    FUN_0000393a();
    DAT_00003e47 = DAT_00003e47 & 0x7f;
    FUN_00003908();
  }
  return;
}



/* Ghidra-derived function 0000380e FUN_0000380e */

void FUN_0000380e(void)

{
  if ((DAT_00003e45 & 1) != 0) {
    DAT_00003e47 = DAT_00003e47 | 0x80;
    FUN_0000393a();
    DAT_00003e47 = DAT_00003e47 & 0x7f;
    FUN_00003908();
  }
  return;
}



/* Ghidra-derived function 00003814 FUN_00003814 */

void FUN_00003814(void)

{
  bool in_ZF;
  
  if (!in_ZF) {
    DAT_00003e47 = DAT_00003e47 | 0x80;
    FUN_0000393a();
    DAT_00003e47 = DAT_00003e47 & 0x7f;
    FUN_00003908();
  }
  return;
}



/* Ghidra-derived function 00003816 FUN_00003816 */

void FUN_00003816(void)

{
  DAT_00003e47 = DAT_00003e47 | 0x80;
  FUN_0000393a();
  DAT_00003e47 = DAT_00003e47 & 0x7f;
  FUN_00003908();
  return;
}



/* Ghidra-derived function 00003834 FUN_00003834 */

void FUN_00003834(void)

{
  char cVar1;
  byte bVar2;
  
  cVar1 = DAT_00003dcf;
  if ((byte)(DAT_00003dcf + DAT_00003dd1) == DAT_00003dd3) {
    bVar2 = DAT_00003dd1;
    DAT_00003db1 = DAT_00003dcf + DAT_00003dd1;
    DAT_00003dac._3_1_ = 0;
    (**(code **)(DAT_00000004 + -0x84))
              (0,8,(uint)DAT_00003e48 * 8,(uint)DAT_00003dd1 * 8,
               (uint)(byte)(DAT_00003e49 + DAT_00003e48) * 8 + -1,
               (uint)(byte)(DAT_00003db1 + 1) * 8 + -1);
    (**(code **)(DAT_00003ef8 + -0x192))();
    (**(code **)(DAT_00003ef8 + -0x18c))();
    FUN_00003572();
    (**(code **)(DAT_00000004 + -0x8a))();
    DAT_00003dac._3_1_ = cVar1;
    DAT_00003db1 = bVar2;
  }
  else {
    DAT_00003dd3 = DAT_00003dd3 + '\x01';
  }
  DAT_00003dd2 = DAT_00003dd0;
  return;
}



/* Ghidra-derived function 00003908 FUN_00003908 */

void FUN_00003908(void)

{
  if (DAT_00003dd2 == DAT_00003dd0) {
    if (DAT_00003dd3 != DAT_00003dd1) {
      DAT_00003dd3 = DAT_00003dd3 + -1;
      DAT_00003dd2 = DAT_00003dce + DAT_00003dd0 + -1;
    }
  }
  else {
    DAT_00003dd2 = DAT_00003dd2 + -1;
  }
  return;
}



/* Ghidra-derived function 0000393a FUN_0000393a */

void FUN_0000393a(void)

{
  if ((char)(DAT_00003dce + DAT_00003dd0) == DAT_00003dd2) {
    FUN_00003834();
  }
  FUN_00003976();
  DAT_00003dd2 = DAT_00003dd2 + '\x01';
  return;
}



/* Ghidra-derived function 00003976 FUN_00003976 */

void FUN_00003976(void)

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
  
  uVar5 = (uint)DAT_00003dd3;
  uVar4 = *in_A0;
  bVar8 = (DAT_00003dd2 >> 2) * '\x03';
  if ((DAT_00003db2 & 2) != 0) {
    bVar8 = bVar8 + 1;
  }
  iVar1 = (int)(short)((DAT_00003dd2 & 3) << 2);
  uVar3 = *(ushort *)(&DAT_00003d6a + iVar1);
  uVar2 = *(ushort *)((int)&DAT_00003d6c + iVar1);
  uVar7 = 0;
  do {
    puVar11 = (ushort *)
              (*(int *)((int)in_A0 + (short)((short)uVar7 << 2) + 8) +
              (uint)bVar8 + uVar5 * 8 * (uint)uVar4);
    sVar9 = 0;
    do {
      uVar10 = *puVar11;
      uVar6 = 0;
      if ((DAT_00003dd8 & '\x01' << (uVar7 & 7)) != 0) {
        uVar6 = (ushort)(byte)~*(byte *)(unaff_A2 + sVar9);
      }
      if ((DAT_00003dd7 & '\x01' << (uVar7 & 7)) != 0) {
        uVar6 = (ushort)(byte)(*(byte *)(unaff_A2 + sVar9) | (byte)uVar6);
      }
      if ((DAT_00003e45 & 0x80) == 0) {
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



/* Ghidra-derived function 00003a1c FUN_00003a1c */

undefined8 FUN_00003a1c(void)

{
  byte bVar1;
  undefined4 in_D0;
  undefined4 in_D1;
  
  bVar1 = DAT_00003e47 & 1;
  DAT_00003e47 = DAT_00003e47 | 1;
  if (bVar1 == 0) {
    FUN_00003816();
  }
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003a46 FUN_00003a46 */

void FUN_00003a46(void)

{
  (**(code **)(DAT_00003ef8 + -0xc0))();
  return;
}



/* Ghidra-derived function 00003ac6 FUN_00003ac6 */

ulonglong FUN_00003ac6(void)

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



/* Ghidra-derived function 00003b64 FUN_00003b64 */

void FUN_00003b64(void)

{
  int in_D0;
  
  if (*(int *)(in_D0 + 10) != 0) {
    (**(code **)(DAT_00000004 + -0x168))();
  }
  (**(code **)(DAT_00000004 + -0x150))(in_D0);
  (**(code **)(DAT_00000004 + -0xd2))();
  return;
}



/* Ghidra-derived function 00003bd6 FUN_00003bd6 */

void FUN_00003bd6(void)

{
  int in_D0;
  
  *(undefined1 *)(in_D0 + 8) = 0xff;
  *(undefined4 *)(in_D0 + 0x14) = 0xffffffff;
  *(undefined4 *)(in_D0 + 0x18) = 0xffffffff;
  (**(code **)(DAT_00000004 + -0xd2))();
  return;
}



