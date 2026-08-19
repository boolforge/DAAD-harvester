/* Ghidra-derived function 00002532 FUN_00002532 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_00002532(void)

{
  uint uVar1;
  ushort in_D0w;
  short sVar2;
  uint in_D1;
  undefined2 *puVar3;
  undefined2 *puVar4;
  
  if (((DAT_000018f6 & 2) == 0) || (in_D0w != DAT_000039fa)) {
    _DAT_000039de = in_D0w;
    _DAT_000039e0 = (uint *)(DAT_0000398c + 10 + (uint)in_D0w * 0x30);
    uVar1 = *_DAT_000039e0;
    if (uVar1 == 0) goto LAB_000025b0;
    if (uVar1 != DAT_00003a00) {
      _DAT_000039e4 = uVar1;
      if ((uVar1 != DAT_00003a08) && (DAT_00003a08 <= uVar1)) {
                    /* WARNING: Bad instruction - Truncating control flow here */
        halt_baddata();
      }
      sVar2 = 2;
      puVar3 = (undefined2 *)((uVar1 - 0x300a) + DAT_00003998);
      puVar4 = &DAT_000039f0;
      do {
        _DAT_00003980 = puVar3 + 1;
        *puVar4 = *puVar3;
        sVar2 = sVar2 + -1;
        puVar3 = _DAT_00003980;
        puVar4 = puVar4 + 1;
      } while (sVar2 != -1);
      if ((DAT_00003a0c & 0x8000) != 0) {
        DAT_000039f0 = DAT_00003a0c & 0x7fff;
        _DAT_00003980 = DAT_00003984;
        FUN_00002638();
      }
    }
  }
  else if (*DAT_000039fc == 0) {
LAB_000025b0:
    return (ulonglong)in_D1;
  }
  DAT_000018f6 = DAT_000018f6 | 2;
  return CONCAT44(1,in_D1);
}



/* Ghidra-derived function 00002638 FUN_00002638 */

undefined4 FUN_00002638(void)

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
LAB_00002644:
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
        if (uVar6 == 0) goto LAB_00002644;
      }
      puVar10 = unaff_A3 + 1;
      *unaff_A3 = unaff_D4;
      sVar5 = 8;
      uVar6 = uVar6 - 1;
      unaff_A3 = puVar10;
    } while (uVar6 != 0);
  } while( true );
}



/* Ghidra-derived function 000026d0 FUN_000026d0 */

ulonglong FUN_000026d0(void)

{
  undefined1 uVar1;
  int iVar2;
  int in_D0;
  byte bVar4;
  short sVar3;
  uint in_D1;
  short sVar5;
  int extraout_A0;
  undefined2 *puVar6;
  undefined2 *puVar7;
  undefined2 uVar8;
  
  iVar2 = DAT_000039fc;
  uVar1 = DAT_000039d7;
  if ((((DAT_0000398c._0_2_ != 0) || ((DAT_00001921 & 0x20) != 0)) || ((DAT_000018f6 & 2) == 0)) ||
     ((*(byte *)(DAT_000039fc + 5) & 0x10) != 0)) {
    return (ulonglong)in_D1;
  }
  DAT_00003a06 = DAT_00003a20;
  DAT_00003a07 = DAT_00003a21;
  if ((*(byte *)(DAT_000039fc + 5) & 1) == 0) {
    DAT_00003a7c = (undefined1)(*(ushort *)(DAT_000039fc + 6) >> 3);
    DAT_00003a05 = (undefined1)(*(ushort *)(DAT_000039fc + 8) >> 3);
    DAT_00003a06 = (undefined1)(*(ushort *)(DAT_000039fc + 6) / 6);
    DAT_00003a04 = DAT_00003a06;
    DAT_00003a07 = DAT_00003a05;
  }
  bVar4 = (char)(DAT_00003a0e >> 3) - 1;
  if ((*(byte *)(DAT_000039fc + 5) & 1) == 0) {
    DAT_00003a00._2_1_ = (undefined1)(DAT_00003a0c / 6);
    DAT_00003a00._3_1_ = bVar4;
    DAT_00003a7d = (char)(DAT_00003a0c >> 3);
  }
  else if (DAT_00003a1f <= bVar4) {
    bVar4 = DAT_00003a1f;
  }
  DAT_00003a08._2_1_ = DAT_00003a1f;
  if (in_D0 != 0) {
    DAT_000039d7 = DAT_000039d6;
    uVar8 = 0;
    FUN_00003040();
    *(undefined1 *)CONCAT22(uVar8,0x39d7) = uVar1;
    return CONCAT44(in_D0,in_D1);
  }
  if (DAT_000039ba == '\0') {
    FUN_00003520((short)DAT_0000399c,bVar4 + 1);
    FUN_00003596();
    FUN_00003492();
    if ((*(byte *)(iVar2 + 5) & 1) == 0) {
      FUN_00003598();
      sVar5 = (ushort)*(byte *)(extraout_A0 + 0xb) - (ushort)*(byte *)(extraout_A0 + 10);
      sVar3 = (ushort)*(byte *)(extraout_A0 + 10) << 1;
      puVar6 = (undefined2 *)(sVar3 + 0xff8240);
      puVar7 = (undefined2 *)(extraout_A0 + 0xc + (int)sVar3);
      do {
        *puVar6 = *puVar7;
        sVar5 = sVar5 + -1;
        puVar6 = puVar6 + 1;
        puVar7 = puVar7 + 1;
      } while (sVar5 != -1);
    }
    FUN_00003602();
    return (ulonglong)in_D1;
  }
  FUN_00003520((short)DAT_0000399c,bVar4 + 1);
  FUN_00003492();
  if ((*(byte *)(iVar2 + 5) & 1) == 0) {
    sVar5 = (ushort)*(byte *)(iVar2 + 0xb) - (ushort)*(byte *)(iVar2 + 10);
    sVar3 = (ushort)*(byte *)(iVar2 + 10) << 1;
    puVar6 = (undefined2 *)(&DAT_000039ae + sVar3);
    puVar7 = (undefined2 *)(iVar2 + 0xc + (int)sVar3);
    do {
      *puVar6 = *puVar7;
      sVar5 = sVar5 + -1;
      puVar6 = puVar6 + 1;
      puVar7 = puVar7 + 1;
    } while (sVar5 != -1);
  }
  return (ulonglong)in_D1;
}



/* Ghidra-derived function 00003040 FUN_00003040 */

void FUN_00003040(void)

{
  ushort uVar1;
  undefined1 uVar3;
  undefined2 uVar2;
  short sVar4;
  short sVar5;
  uint uVar6;
  short sVar7;
  ushort uVar8;
  uint unaff_D5;
  int extraout_A1;
  int iVar9;
  int unaff_A3;
  
  FUN_0000350a();
  FUN_00003596();
  sVar7 = (DAT_00003a1f + 1) * 8;
  iVar9 = extraout_A1;
  while (sVar7 = sVar7 + -1, sVar7 != -1) {
    sVar4 = 0;
    uVar8 = (ushort)DAT_00003a99;
    if ((unaff_D5 & 4) != 0) {
      uVar6 = 0;
      do {
        sVar5 = sVar4;
        uVar3 = 0;
        if ((DAT_00003a28 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar9 + sVar5) = uVar3;
        uVar1 = (short)uVar6 + 1;
        uVar6 = (uint)uVar1;
        sVar4 = sVar5 + 2;
      } while ((short)uVar1 < DAT_000039d2);
      sVar4 = sVar5 + 1;
      uVar8 = uVar8 - 1;
    }
    if ((unaff_D5 & 2) != 0) {
      uVar8 = uVar8 >> 1;
      while (uVar8 = uVar8 - 1, uVar8 != 0xffff) {
        uVar6 = 0;
        do {
          uVar2 = 0;
          if ((DAT_00003a28 & '\x01' << (uVar6 & 7)) != 0) {
            uVar2 = 0xffff;
          }
          *(undefined2 *)(iVar9 + sVar4) = uVar2;
          sVar4 = sVar4 + 2;
          uVar1 = (short)uVar6 + 1;
          uVar6 = (uint)uVar1;
        } while ((short)uVar1 < DAT_000039d2);
      }
    }
    if ((unaff_D5 & 1) != 0) {
      uVar6 = 0;
      do {
        uVar3 = 0;
        if ((DAT_00003a28 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar9 + sVar4) = uVar3;
        sVar4 = sVar4 + 2;
        uVar8 = (short)uVar6 + 1;
        uVar6 = (uint)uVar8;
      } while ((short)uVar8 < DAT_000039d2);
    }
    iVar9 = unaff_A3 + iVar9;
  }
  FUN_00003602();
  return;
}



/* Ghidra-derived function 0000310a FUN_0000310a */

undefined8 FUN_0000310a(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_00003118();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003118 FUN_00003118 */

void FUN_00003118(void)

{
  char in_D0b;
  
  FUN_00003140();
  if (in_D0b == '\b') {
    FUN_000031aa();
    FUN_00003140();
    return;
  }
  if (in_D0b == '\r') {
                    /* WARNING: Call to offcut address within same function */
    func_0x0000314a();
    FUN_00003140();
    return;
  }
  FUN_000031dc();
  if ((DAT_00003a95 & 1) != 0) {
    DAT_00003a97 = DAT_00003a97 | 0x80;
    FUN_000031dc();
    DAT_00003a97 = DAT_00003a97 & 0x7f;
    FUN_000031aa();
  }
  return;
}



/* Ghidra-derived function 00003140 FUN_00003140 */

void FUN_00003140(void)

{
  if ((DAT_00003a95 & 1) != 0) {
    DAT_00003a97 = DAT_00003a97 | 0x80;
    FUN_000031dc();
    DAT_00003a97 = DAT_00003a97 & 0x7f;
    FUN_000031aa();
  }
  return;
}



/* Ghidra-derived function 00003148 FUN_00003148 */

void FUN_00003148(void)

{
  DAT_00003a97 = DAT_00003a97 | 0x80;
  FUN_000031dc();
  DAT_00003a97 = DAT_00003a97 & 0x7f;
  FUN_000031aa();
  return;
}



/* Ghidra-derived function 00003166 FUN_00003166 */

void FUN_00003166(void)

{
  undefined4 in_D0;
  
  while ((char)(DAT_00003a1e + DAT_00003a20) != DAT_00003a22) {
    in_D0 = FUN_000031dc();
  }
  if ((char)(DAT_00003a1f + DAT_00003a21) == DAT_00003a23) {
    FUN_00003394(in_D0,DAT_00003a1f + DAT_00003a21);
  }
  else {
    DAT_00003a23 = DAT_00003a23 + '\x01';
  }
  DAT_00003a22 = DAT_00003a20;
  return;
}



/* Ghidra-derived function 000031aa FUN_000031aa */

void FUN_000031aa(void)

{
  if (DAT_00003a22 == DAT_00003a20) {
    if (DAT_00003a23 != DAT_00003a21) {
      DAT_00003a23 = DAT_00003a23 + -1;
      DAT_00003a22 = DAT_00003a1e + DAT_00003a20 + -1;
    }
  }
  else {
    DAT_00003a22 = DAT_00003a22 + -1;
  }
  return;
}



/* Ghidra-derived function 000031dc FUN_000031dc */

void FUN_000031dc(void)

{
  if ((char)(DAT_00003a1e + DAT_00003a20) == DAT_00003a22) {
    FUN_00003166();
  }
  if (DAT_0000398c._0_2_ == 0) {
    FUN_0000329a();
  }
  else {
    FUN_00003226();
  }
  DAT_00003a22 = DAT_00003a22 + '\x01';
  return;
}



/* Ghidra-derived function 00003226 FUN_00003226 */

void FUN_00003226(void)

{
  ushort uVar1;
  byte bVar2;
  int iVar3;
  uint uVar4;
  short sVar5;
  byte bVar6;
  byte *pbVar7;
  int in_A1;
  int unaff_A2;
  
  iVar3 = (uint)(DAT_00003a22 >> 1) * (uint)DAT_000039ce +
          (uint)DAT_00003a23 * 8 * (uint)DAT_000039d0;
  if ((DAT_00003a20 & 1) != 0) {
    iVar3 = iVar3 + 1;
  }
  sVar5 = 0;
  do {
    pbVar7 = (byte *)(in_A1 + iVar3);
    uVar4 = 0;
    do {
      bVar6 = *pbVar7;
      bVar2 = 0;
      if ((DAT_00003a28 & '\x01' << (uVar4 & 7)) != 0) {
        bVar2 = ~*(byte *)(unaff_A2 + sVar5);
      }
      if ((DAT_00003a27 & '\x01' << (uVar4 & 7)) != 0) {
        bVar2 = *(byte *)(unaff_A2 + sVar5) | bVar2;
      }
      if ((DAT_00003a95 & 0x80) == 0) {
        bVar6 = 0;
      }
      *pbVar7 = bVar6 ^ bVar2;
      pbVar7 = pbVar7 + 2;
      uVar1 = (short)uVar4 + 1;
      uVar4 = (uint)uVar1;
    } while ((short)uVar1 < DAT_000039d2);
    iVar3 = (uint)DAT_000039d0 + iVar3;
    sVar5 = sVar5 + 1;
  } while (sVar5 < 8);
  return;
}



/* Ghidra-derived function 0000329a FUN_0000329a */

void FUN_0000329a(void)

{
  ushort uVar1;
  ushort uVar2;
  ushort uVar3;
  int iVar4;
  byte bVar6;
  uint uVar5;
  short sVar7;
  ushort uVar8;
  undefined1 *puVar9;
  undefined1 *puVar10;
  int in_A1;
  int unaff_A2;
  int iVar11;
  undefined1 *puVar12;
  undefined1 *puVar13;
  
  bVar6 = (DAT_00003a22 >> 2) * '\x03';
  if ((DAT_00003a06 & 2) != 0) {
    bVar6 = bVar6 + 1;
  }
  iVar4 = (uint)(bVar6 >> 1) * (uint)DAT_000039ce + (uint)DAT_00003a23 * 8 * (uint)DAT_000039d0;
  iVar11 = 1;
  if ((bVar6 & 1) != 0) {
    iVar4 = iVar4 + 1;
    iVar11 = (short)DAT_000039ce + -1;
  }
  sVar7 = 0;
  puVar10 = (undefined1 *)(in_A1 + iVar4);
  puVar12 = puVar10 + iVar11;
  iVar4 = (int)(short)((DAT_00003a22 & 3) << 2);
  uVar2 = *(ushort *)(&DAT_000039bc + iVar4);
  uVar1 = *(ushort *)(iVar4 + 0x39be);
  do {
    uVar5 = 0;
    puVar9 = puVar10;
    puVar13 = puVar12;
    do {
      uVar8 = CONCAT11(*puVar9,*puVar13);
      uVar3 = 0;
      if ((DAT_00003a28 & '\x01' << (uVar5 & 7)) != 0) {
        uVar3 = (ushort)(byte)~*(byte *)(unaff_A2 + sVar7);
      }
      if ((DAT_00003a27 & '\x01' << (uVar5 & 7)) != 0) {
        uVar3 = (ushort)(byte)(*(byte *)(unaff_A2 + sVar7) | (byte)uVar3);
      }
      if ((DAT_00003a95 & 0x80) == 0) {
        uVar8 = uVar2 & uVar8;
      }
      uVar8 = uVar8 ^ (uVar3 >> 2) << (uVar1 & 0x3f);
      *puVar13 = (char)uVar8;
      *puVar9 = (char)(uVar8 >> 8);
      puVar9 = puVar9 + 2;
      puVar13 = puVar13 + 2;
      uVar8 = (short)uVar5 + 1;
      uVar5 = (uint)uVar8;
    } while ((short)uVar8 < DAT_000039d2);
    puVar10 = puVar10 + DAT_000039d0;
    puVar12 = puVar12 + DAT_000039d0;
    sVar7 = sVar7 + 1;
  } while (sVar7 < 8);
  return;
}



/* Ghidra-derived function 0000336a FUN_0000336a */

undefined8 FUN_0000336a(void)

{
  byte bVar1;
  undefined4 in_D0;
  undefined4 in_D1;
  
  bVar1 = DAT_00003a97 & 1;
  DAT_00003a97 = DAT_00003a97 | 1;
  if (bVar1 == 0) {
    FUN_00003148();
  }
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003394 FUN_00003394 */

void FUN_00003394(void)

{
  ushort uVar1;
  undefined1 uVar3;
  undefined2 uVar2;
  int extraout_D1;
  short sVar4;
  short sVar5;
  short sVar7;
  uint uVar6;
  short sVar8;
  ushort uVar9;
  uint unaff_D5;
  int extraout_A1;
  int iVar10;
  int iVar11;
  int unaff_A3;
  
  FUN_0000350a();
  FUN_00003596();
  iVar11 = extraout_A1 + extraout_D1 * 8;
  sVar8 = (ushort)DAT_00003a1f << 3;
  iVar10 = extraout_A1;
  while (sVar8 = sVar8 + -1, sVar8 != -1) {
    sVar4 = 0;
    uVar9 = (ushort)DAT_00003a99;
    if ((unaff_D5 & 4) != 0) {
      sVar7 = 0;
      do {
        sVar5 = sVar4;
        *(undefined1 *)(iVar10 + sVar5) = *(undefined1 *)(iVar11 + sVar5);
        sVar7 = sVar7 + 1;
        sVar4 = sVar5 + 2;
      } while (sVar7 < DAT_000039d2);
      sVar4 = sVar5 + 1;
      uVar9 = uVar9 - 1;
    }
    if ((unaff_D5 & 2) != 0) {
      uVar9 = uVar9 >> 1;
      while (uVar9 = uVar9 - 1, uVar9 != 0xffff) {
        sVar7 = 0;
        do {
          *(undefined2 *)(iVar10 + sVar4) = *(undefined2 *)(iVar11 + sVar4);
          sVar4 = sVar4 + 2;
          sVar7 = sVar7 + 1;
        } while (sVar7 < DAT_000039d2);
      }
    }
    if ((unaff_D5 & 1) != 0) {
      sVar7 = 0;
      do {
        *(undefined1 *)(iVar10 + sVar4) = *(undefined1 *)(iVar11 + sVar4);
        sVar4 = sVar4 + 2;
        sVar7 = sVar7 + 1;
      } while (sVar7 < DAT_000039d2);
    }
    iVar11 = unaff_A3 + iVar11;
    iVar10 = unaff_A3 + iVar10;
  }
  sVar8 = 7;
  do {
    sVar4 = 0;
    uVar9 = (ushort)DAT_00003a99;
    if ((unaff_D5 & 4) != 0) {
      uVar6 = 0;
      do {
        sVar7 = sVar4;
        uVar3 = 0;
        if ((DAT_00003a28 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar10 + sVar7) = uVar3;
        uVar1 = (short)uVar6 + 1;
        uVar6 = (uint)uVar1;
        sVar4 = sVar7 + 2;
      } while ((short)uVar1 < DAT_000039d2);
      sVar4 = sVar7 + 1;
      uVar9 = uVar9 - 1;
    }
    if ((unaff_D5 & 2) != 0) {
      uVar9 = uVar9 >> 1;
      while (uVar9 = uVar9 - 1, uVar9 != 0xffff) {
        uVar6 = 0;
        do {
          uVar2 = 0;
          if ((DAT_00003a28 & '\x01' << (uVar6 & 7)) != 0) {
            uVar2 = 0xffff;
          }
          *(undefined2 *)(iVar10 + sVar4) = uVar2;
          sVar4 = sVar4 + 2;
          uVar1 = (short)uVar6 + 1;
          uVar6 = (uint)uVar1;
        } while ((short)uVar1 < DAT_000039d2);
      }
    }
    if ((unaff_D5 & 1) != 0) {
      uVar6 = 0;
      do {
        uVar3 = 0;
        if ((DAT_00003a28 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar10 + sVar4) = uVar3;
        sVar4 = sVar4 + 2;
        uVar9 = (short)uVar6 + 1;
        uVar6 = (uint)uVar9;
      } while ((short)uVar9 < DAT_000039d2);
    }
    iVar10 = unaff_A3 + iVar10;
    sVar8 = sVar8 + -1;
  } while (sVar8 != -1);
  FUN_00003602();
  return;
}



/* Ghidra-derived function 00003492 FUN_00003492 */

void FUN_00003492(void)

{
  short unaff_D3w;
  short sVar1;
  uint unaff_D4;
  uint uVar2;
  ushort uVar3;
  uint unaff_D5;
  undefined1 *in_A1;
  undefined1 *unaff_A2;
  undefined1 *puVar4;
  undefined1 *puVar5;
  int unaff_A3;
  int unaff_A4;
  
  sVar1 = unaff_D3w * 8 + -1;
  do {
    uVar2 = unaff_D4;
    puVar4 = in_A1;
    if ((unaff_D5 & 4) != 0) {
      *in_A1 = *unaff_A2;
      in_A1[2] = unaff_A2[1];
      puVar4 = unaff_A2 + 3;
      in_A1[4] = unaff_A2[2];
      unaff_A2 = unaff_A2 + 4;
      in_A1[6] = *puVar4;
      puVar4 = in_A1 + 7;
      uVar2 = (uint)(ushort)((short)unaff_D4 - 1);
    }
    if ((unaff_D5 & 2) != 0) {
      uVar2 = uVar2 >> 1 & 0x7fff;
      while (uVar3 = (short)uVar2 - 1, uVar2 = (uint)uVar3, uVar3 != 0xffff) {
        *puVar4 = *unaff_A2;
        puVar4[1] = unaff_A2[4];
        puVar4[2] = unaff_A2[1];
        puVar4[3] = unaff_A2[5];
        puVar4[4] = unaff_A2[2];
        puVar4[5] = unaff_A2[6];
        puVar5 = puVar4 + 7;
        puVar4[6] = unaff_A2[3];
        puVar4 = puVar4 + 8;
        *puVar5 = unaff_A2[7];
        unaff_A2 = unaff_A2 + 8;
      }
    }
    if ((unaff_D5 & 1) != 0) {
      *puVar4 = *unaff_A2;
      puVar4[2] = unaff_A2[1];
      puVar5 = unaff_A2 + 3;
      puVar4[4] = unaff_A2[2];
      unaff_A2 = unaff_A2 + 4;
      puVar4[6] = *puVar5;
    }
    unaff_A2 = unaff_A2 + unaff_A4;
    in_A1 = in_A1 + unaff_A3;
    sVar1 = sVar1 + -1;
  } while (sVar1 != -1);
  return;
}



/* Ghidra-derived function 0000350a FUN_0000350a */

void FUN_0000350a(void)

{
  return;
}



/* Ghidra-derived function 00003520 FUN_00003520 */

void FUN_00003520(void)

{
  return;
}



/* Ghidra-derived function 00003596 FUN_00003596 */

void FUN_00003596(void)

{
  FUN_000035a8();
  do {
  } while (cRam000035da == '\0');
  cRam000035da = 0;
  return;
}



/* Ghidra-derived function 00003598 FUN_00003598 */

void FUN_00003598(void)

{
  do {
  } while (cRam000035da == '\0');
  cRam000035da = 0;
  return;
}



/* Ghidra-derived function 000035a8 FUN_000035a8 */

void FUN_000035a8(void)

{
  DAT_000035e0 = DAT_00000068;
  DAT_00000068 = 0x35d2;
  puRam000035dc = PTR_DAT_00000070;
  PTR_DAT_00000070 = (undefined *)0x35c4;
  uRam000035da = 0;
  return;
}



/* Ghidra-derived function 00003602 FUN_00003602 */

void FUN_00003602(void)

{
  DAT_00000068 = DAT_000035e0;
  PTR_DAT_00000070 = puRam000035dc;
  return;
}



