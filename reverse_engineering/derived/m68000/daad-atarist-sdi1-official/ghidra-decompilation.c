/* Ghidra-derived function 00002628 FUN_00002628 */

/* WARNING: Control flow encountered bad instruction data */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_00002628(void)

{
  uint uVar1;
  ushort in_D0w;
  short sVar2;
  uint in_D1;
  undefined2 *puVar3;
  undefined2 *puVar4;
  
  if (((DAT_00001982 & 2) == 0) || (in_D0w != DAT_00003a36)) {
    _DAT_00003a1a = in_D0w;
    _DAT_00003a1c = (uint *)(DAT_000039c8 + 10 + (uint)in_D0w * 0x30);
    uVar1 = *_DAT_00003a1c;
    if (uVar1 == 0) goto LAB_000026a6;
    if (uVar1 != DAT_00003a3c) {
      _DAT_00003a20 = uVar1;
      if ((uVar1 != DAT_00003a44) && (DAT_00003a44 <= uVar1)) {
                    /* WARNING: Bad instruction - Truncating control flow here */
        halt_baddata();
      }
      sVar2 = 2;
      puVar3 = (undefined2 *)((uVar1 - 0x300a) + DAT_000039d4);
      puVar4 = &DAT_00003a2c;
      do {
        _DAT_000039bc = puVar3 + 1;
        *puVar4 = *puVar3;
        sVar2 = sVar2 + -1;
        puVar3 = _DAT_000039bc;
        puVar4 = puVar4 + 1;
      } while (sVar2 != -1);
      if ((DAT_00003a48 & 0x8000) != 0) {
        DAT_00003a2c = DAT_00003a48 & 0x7fff;
        _DAT_000039bc = DAT_000039c0;
        FUN_0000272e();
      }
    }
  }
  else if (*DAT_00003a38 == 0) {
LAB_000026a6:
    return (ulonglong)in_D1;
  }
  DAT_00001982 = DAT_00001982 | 2;
  return CONCAT44(1,in_D1);
}



/* Ghidra-derived function 0000272e FUN_0000272e */

undefined4 FUN_0000272e(void)

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
LAB_0000273a:
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
        if (uVar6 == 0) goto LAB_0000273a;
      }
      puVar10 = unaff_A3 + 1;
      *unaff_A3 = unaff_D4;
      sVar5 = 8;
      uVar6 = uVar6 - 1;
      unaff_A3 = puVar10;
    } while (uVar6 != 0);
  } while( true );
}



/* Ghidra-derived function 000027c6 FUN_000027c6 */

ulonglong FUN_000027c6(void)

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
  
  iVar2 = DAT_00003a38;
  uVar1 = DAT_00003a13;
  if ((((DAT_000039c8._0_2_ != 0) || ((DAT_000019ad & 0x20) != 0)) || ((DAT_00001982 & 2) == 0)) ||
     ((*(byte *)(DAT_00003a38 + 5) & 0x10) != 0)) {
    return (ulonglong)in_D1;
  }
  DAT_00003a42 = DAT_00003a5c;
  DAT_00003a43 = DAT_00003a5d;
  if ((*(byte *)(DAT_00003a38 + 5) & 1) == 0) {
    DAT_00003ab8 = (undefined1)(*(ushort *)(DAT_00003a38 + 6) >> 3);
    DAT_00003a41 = (undefined1)(*(ushort *)(DAT_00003a38 + 8) >> 3);
    DAT_00003a42 = (undefined1)(*(ushort *)(DAT_00003a38 + 6) / 6);
    DAT_00003a40 = DAT_00003a42;
    DAT_00003a43 = DAT_00003a41;
  }
  bVar4 = (char)(DAT_00003a4a >> 3) - 1;
  if ((*(byte *)(DAT_00003a38 + 5) & 1) == 0) {
    DAT_00003a3c._2_1_ = (undefined1)(DAT_00003a48 / 6);
    DAT_00003a3c._3_1_ = bVar4;
    DAT_00003ab9 = (char)(DAT_00003a48 >> 3);
  }
  else if (DAT_00003a5b <= bVar4) {
    bVar4 = DAT_00003a5b;
  }
  DAT_00003a44._2_1_ = DAT_00003a5b;
  if (in_D0 != 0) {
    DAT_00003a13 = DAT_00003a12;
    uVar8 = 0;
    FUN_00003160();
    *(undefined1 *)CONCAT22(uVar8,0x3a13) = uVar1;
    return CONCAT44(in_D0,in_D1);
  }
  if (DAT_000039f6 == '\0') {
    FUN_00003640((short)DAT_000039d8,bVar4 + 1);
    FUN_000036b6();
    FUN_000035b2();
    if ((*(byte *)(iVar2 + 5) & 1) == 0) {
      FUN_000036b8();
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
    FUN_00003722();
    return (ulonglong)in_D1;
  }
  FUN_00003640((short)DAT_000039d8,bVar4 + 1);
  FUN_000035b2();
  if ((*(byte *)(iVar2 + 5) & 1) == 0) {
    sVar5 = (ushort)*(byte *)(iVar2 + 0xb) - (ushort)*(byte *)(iVar2 + 10);
    sVar3 = (ushort)*(byte *)(iVar2 + 10) << 1;
    puVar6 = (undefined2 *)(&DAT_000039ea + sVar3);
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



/* Ghidra-derived function 00003160 FUN_00003160 */

void FUN_00003160(void)

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
  
  FUN_0000362a();
  FUN_000036b6();
  sVar7 = (DAT_00003a5b + 1) * 8;
  iVar9 = extraout_A1;
  while (sVar7 = sVar7 + -1, sVar7 != -1) {
    sVar4 = 0;
    uVar8 = (ushort)DAT_00003ad5;
    if ((unaff_D5 & 4) != 0) {
      uVar6 = 0;
      do {
        sVar5 = sVar4;
        uVar3 = 0;
        if ((DAT_00003a64 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar9 + sVar5) = uVar3;
        uVar1 = (short)uVar6 + 1;
        uVar6 = (uint)uVar1;
        sVar4 = sVar5 + 2;
      } while ((short)uVar1 < DAT_00003a0e);
      sVar4 = sVar5 + 1;
      uVar8 = uVar8 - 1;
    }
    if ((unaff_D5 & 2) != 0) {
      uVar8 = uVar8 >> 1;
      while (uVar8 = uVar8 - 1, uVar8 != 0xffff) {
        uVar6 = 0;
        do {
          uVar2 = 0;
          if ((DAT_00003a64 & '\x01' << (uVar6 & 7)) != 0) {
            uVar2 = 0xffff;
          }
          *(undefined2 *)(iVar9 + sVar4) = uVar2;
          sVar4 = sVar4 + 2;
          uVar1 = (short)uVar6 + 1;
          uVar6 = (uint)uVar1;
        } while ((short)uVar1 < DAT_00003a0e);
      }
    }
    if ((unaff_D5 & 1) != 0) {
      uVar6 = 0;
      do {
        uVar3 = 0;
        if ((DAT_00003a64 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar9 + sVar4) = uVar3;
        sVar4 = sVar4 + 2;
        uVar8 = (short)uVar6 + 1;
        uVar6 = (uint)uVar8;
      } while ((short)uVar8 < DAT_00003a0e);
    }
    iVar9 = unaff_A3 + iVar9;
  }
  FUN_00003722();
  return;
}



/* Ghidra-derived function 0000322a FUN_0000322a */

undefined8 FUN_0000322a(void)

{
  undefined4 in_D0;
  undefined4 in_D1;
  
  FUN_00003238();
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 00003238 FUN_00003238 */

void FUN_00003238(void)

{
  char in_D0b;
  
  FUN_00003260();
  if (in_D0b == '\b') {
    FUN_000032ca();
    FUN_00003260();
    return;
  }
  if (in_D0b == '\r') {
                    /* WARNING: Call to offcut address within same function */
    func_0x0000326a();
    FUN_00003260();
    return;
  }
  FUN_000032fc();
  if ((DAT_00003ad1 & 1) != 0) {
    DAT_00003ad3 = DAT_00003ad3 | 0x80;
    FUN_000032fc();
    DAT_00003ad3 = DAT_00003ad3 & 0x7f;
    FUN_000032ca();
  }
  return;
}



/* Ghidra-derived function 00003260 FUN_00003260 */

void FUN_00003260(void)

{
  if ((DAT_00003ad1 & 1) != 0) {
    DAT_00003ad3 = DAT_00003ad3 | 0x80;
    FUN_000032fc();
    DAT_00003ad3 = DAT_00003ad3 & 0x7f;
    FUN_000032ca();
  }
  return;
}



/* Ghidra-derived function 00003268 FUN_00003268 */

void FUN_00003268(void)

{
  DAT_00003ad3 = DAT_00003ad3 | 0x80;
  FUN_000032fc();
  DAT_00003ad3 = DAT_00003ad3 & 0x7f;
  FUN_000032ca();
  return;
}



/* Ghidra-derived function 00003286 FUN_00003286 */

void FUN_00003286(void)

{
  undefined4 in_D0;
  
  while ((char)(DAT_00003a5a + DAT_00003a5c) != DAT_00003a5e) {
    in_D0 = FUN_000032fc();
  }
  if ((char)(DAT_00003a5b + DAT_00003a5d) == DAT_00003a5f) {
    FUN_000034b4(in_D0,DAT_00003a5b + DAT_00003a5d);
  }
  else {
    DAT_00003a5f = DAT_00003a5f + '\x01';
  }
  DAT_00003a5e = DAT_00003a5c;
  return;
}



/* Ghidra-derived function 000032ca FUN_000032ca */

void FUN_000032ca(void)

{
  if (DAT_00003a5e == DAT_00003a5c) {
    if (DAT_00003a5f != DAT_00003a5d) {
      DAT_00003a5f = DAT_00003a5f + -1;
      DAT_00003a5e = DAT_00003a5a + DAT_00003a5c + -1;
    }
  }
  else {
    DAT_00003a5e = DAT_00003a5e + -1;
  }
  return;
}



/* Ghidra-derived function 000032fc FUN_000032fc */

void FUN_000032fc(void)

{
  if ((char)(DAT_00003a5a + DAT_00003a5c) == DAT_00003a5e) {
    FUN_00003286();
  }
  if (DAT_000039c8._0_2_ == 0) {
    FUN_000033ba();
  }
  else {
    FUN_00003346();
  }
  DAT_00003a5e = DAT_00003a5e + '\x01';
  return;
}



/* Ghidra-derived function 00003346 FUN_00003346 */

void FUN_00003346(void)

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
  
  iVar3 = (uint)(DAT_00003a5e >> 1) * (uint)DAT_00003a0a +
          (uint)DAT_00003a5f * 8 * (uint)DAT_00003a0c;
  if ((DAT_00003a5c & 1) != 0) {
    iVar3 = iVar3 + 1;
  }
  sVar5 = 0;
  do {
    pbVar7 = (byte *)(in_A1 + iVar3);
    uVar4 = 0;
    do {
      bVar6 = *pbVar7;
      bVar2 = 0;
      if ((DAT_00003a64 & '\x01' << (uVar4 & 7)) != 0) {
        bVar2 = ~*(byte *)(unaff_A2 + sVar5);
      }
      if ((DAT_00003a63 & '\x01' << (uVar4 & 7)) != 0) {
        bVar2 = *(byte *)(unaff_A2 + sVar5) | bVar2;
      }
      if ((DAT_00003ad1 & 0x80) == 0) {
        bVar6 = 0;
      }
      *pbVar7 = bVar6 ^ bVar2;
      pbVar7 = pbVar7 + 2;
      uVar1 = (short)uVar4 + 1;
      uVar4 = (uint)uVar1;
    } while ((short)uVar1 < DAT_00003a0e);
    iVar3 = (uint)DAT_00003a0c + iVar3;
    sVar5 = sVar5 + 1;
  } while (sVar5 < 8);
  return;
}



/* Ghidra-derived function 000033ba FUN_000033ba */

void FUN_000033ba(void)

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
  
  bVar6 = (DAT_00003a5e >> 2) * '\x03';
  if ((DAT_00003a42 & 2) != 0) {
    bVar6 = bVar6 + 1;
  }
  iVar4 = (uint)(bVar6 >> 1) * (uint)DAT_00003a0a + (uint)DAT_00003a5f * 8 * (uint)DAT_00003a0c;
  iVar11 = 1;
  if ((bVar6 & 1) != 0) {
    iVar4 = iVar4 + 1;
    iVar11 = (short)DAT_00003a0a + -1;
  }
  sVar7 = 0;
  puVar10 = (undefined1 *)(in_A1 + iVar4);
  puVar12 = puVar10 + iVar11;
  iVar4 = (int)(short)((DAT_00003a5e & 3) << 2);
  uVar2 = *(ushort *)(&DAT_000039f8 + iVar4);
  uVar1 = *(ushort *)(iVar4 + 0x39fa);
  do {
    uVar5 = 0;
    puVar9 = puVar10;
    puVar13 = puVar12;
    do {
      uVar8 = CONCAT11(*puVar9,*puVar13);
      uVar3 = 0;
      if ((DAT_00003a64 & '\x01' << (uVar5 & 7)) != 0) {
        uVar3 = (ushort)(byte)~*(byte *)(unaff_A2 + sVar7);
      }
      if ((DAT_00003a63 & '\x01' << (uVar5 & 7)) != 0) {
        uVar3 = (ushort)(byte)(*(byte *)(unaff_A2 + sVar7) | (byte)uVar3);
      }
      if ((DAT_00003ad1 & 0x80) == 0) {
        uVar8 = uVar2 & uVar8;
      }
      uVar8 = uVar8 ^ (uVar3 >> 2) << (uVar1 & 0x3f);
      *puVar13 = (char)uVar8;
      *puVar9 = (char)(uVar8 >> 8);
      puVar9 = puVar9 + 2;
      puVar13 = puVar13 + 2;
      uVar8 = (short)uVar5 + 1;
      uVar5 = (uint)uVar8;
    } while ((short)uVar8 < DAT_00003a0e);
    puVar10 = puVar10 + DAT_00003a0c;
    puVar12 = puVar12 + DAT_00003a0c;
    sVar7 = sVar7 + 1;
  } while (sVar7 < 8);
  return;
}



/* Ghidra-derived function 0000348a FUN_0000348a */

undefined8 FUN_0000348a(void)

{
  byte bVar1;
  undefined4 in_D0;
  undefined4 in_D1;
  
  bVar1 = DAT_00003ad3 & 1;
  DAT_00003ad3 = DAT_00003ad3 | 1;
  if (bVar1 == 0) {
    FUN_00003268();
  }
  return CONCAT44(in_D0,in_D1);
}



/* Ghidra-derived function 000034b4 FUN_000034b4 */

void FUN_000034b4(void)

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
  
  FUN_0000362a();
  FUN_000036b6();
  iVar11 = extraout_A1 + extraout_D1 * 8;
  sVar8 = (ushort)DAT_00003a5b << 3;
  iVar10 = extraout_A1;
  while (sVar8 = sVar8 + -1, sVar8 != -1) {
    sVar4 = 0;
    uVar9 = (ushort)DAT_00003ad5;
    if ((unaff_D5 & 4) != 0) {
      sVar7 = 0;
      do {
        sVar5 = sVar4;
        *(undefined1 *)(iVar10 + sVar5) = *(undefined1 *)(iVar11 + sVar5);
        sVar7 = sVar7 + 1;
        sVar4 = sVar5 + 2;
      } while (sVar7 < DAT_00003a0e);
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
        } while (sVar7 < DAT_00003a0e);
      }
    }
    if ((unaff_D5 & 1) != 0) {
      sVar7 = 0;
      do {
        *(undefined1 *)(iVar10 + sVar4) = *(undefined1 *)(iVar11 + sVar4);
        sVar4 = sVar4 + 2;
        sVar7 = sVar7 + 1;
      } while (sVar7 < DAT_00003a0e);
    }
    iVar11 = unaff_A3 + iVar11;
    iVar10 = unaff_A3 + iVar10;
  }
  sVar8 = 7;
  do {
    sVar4 = 0;
    uVar9 = (ushort)DAT_00003ad5;
    if ((unaff_D5 & 4) != 0) {
      uVar6 = 0;
      do {
        sVar7 = sVar4;
        uVar3 = 0;
        if ((DAT_00003a64 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar10 + sVar7) = uVar3;
        uVar1 = (short)uVar6 + 1;
        uVar6 = (uint)uVar1;
        sVar4 = sVar7 + 2;
      } while ((short)uVar1 < DAT_00003a0e);
      sVar4 = sVar7 + 1;
      uVar9 = uVar9 - 1;
    }
    if ((unaff_D5 & 2) != 0) {
      uVar9 = uVar9 >> 1;
      while (uVar9 = uVar9 - 1, uVar9 != 0xffff) {
        uVar6 = 0;
        do {
          uVar2 = 0;
          if ((DAT_00003a64 & '\x01' << (uVar6 & 7)) != 0) {
            uVar2 = 0xffff;
          }
          *(undefined2 *)(iVar10 + sVar4) = uVar2;
          sVar4 = sVar4 + 2;
          uVar1 = (short)uVar6 + 1;
          uVar6 = (uint)uVar1;
        } while ((short)uVar1 < DAT_00003a0e);
      }
    }
    if ((unaff_D5 & 1) != 0) {
      uVar6 = 0;
      do {
        uVar3 = 0;
        if ((DAT_00003a64 & '\x01' << (uVar6 & 7)) != 0) {
          uVar3 = 0xff;
        }
        *(undefined1 *)(iVar10 + sVar4) = uVar3;
        sVar4 = sVar4 + 2;
        uVar9 = (short)uVar6 + 1;
        uVar6 = (uint)uVar9;
      } while ((short)uVar9 < DAT_00003a0e);
    }
    iVar10 = unaff_A3 + iVar10;
    sVar8 = sVar8 + -1;
  } while (sVar8 != -1);
  FUN_00003722();
  return;
}



/* Ghidra-derived function 000035b2 FUN_000035b2 */

void FUN_000035b2(void)

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



/* Ghidra-derived function 0000362a FUN_0000362a */

void FUN_0000362a(void)

{
  return;
}



/* Ghidra-derived function 00003640 FUN_00003640 */

void FUN_00003640(void)

{
  return;
}



/* Ghidra-derived function 000036b6 FUN_000036b6 */

void FUN_000036b6(void)

{
  FUN_000036c8();
  do {
  } while (cRam000036fa == '\0');
  cRam000036fa = 0;
  return;
}



/* Ghidra-derived function 000036b8 FUN_000036b8 */

void FUN_000036b8(void)

{
  do {
  } while (cRam000036fa == '\0');
  cRam000036fa = 0;
  return;
}



/* Ghidra-derived function 000036c8 FUN_000036c8 */

void FUN_000036c8(void)

{
  DAT_00003700 = DAT_00000068;
  DAT_00000068 = 0x36f2;
  puRam000036fc = PTR_DAT_00000070;
  PTR_DAT_00000070 = (undefined *)0x36e4;
  uRam000036fa = 0;
  return;
}



/* Ghidra-derived function 00003722 FUN_00003722 */

void FUN_00003722(void)

{
  DAT_00000068 = DAT_00003700;
  PTR_DAT_00000070 = puRam000036fc;
  return;
}



