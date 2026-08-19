/* Ghidra-derived function ram:0000 RST0 */

void RST0(byte param_1)

{
  byte in_F;
  
  RST7(*(char *)CONCAT11(param_1,param_1) + (in_F & 1) + '{' + (0xfe < param_1),0x4e01,
       CONCAT11(param_1,param_1 + 1));
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0008 RST1 */

void RST1(char *param_1)

{
  byte in_F;
  
  RST7(*param_1 + (in_F & 1) + '{' + (0xfe < (byte)param_1),0x4e01,(byte)param_1 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0010 RST2 */

void RST2(char param_1,byte param_2)

{
  byte in_F;
  
  RST7(param_1 + (in_F & 1) + '{' + (0xfe < param_2),param_2 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0018 RST3 */

void RST3(char param_1,byte param_2)

{
  RST7(param_1 + '\\' + (0xfe < param_2),param_2 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0020 RST4 */

void RST4(char param_1,byte param_2)

{
  RST7(param_1 + '\\' + (0xfe < param_2),param_2 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0028 RST5 */

void RST5(char param_1,byte param_2)

{
  RST7(param_1 + '\\' + (0xfe < param_2),param_2 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0030 RST6 */

void RST6(char param_1,byte param_2)

{
  RST7(param_1 + '\\' + (0xfe < param_2),param_2 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0038 RST7 */

void RST7(char param_1,byte param_2)

{
  RST7(param_1 + '\\' + (0xfe < param_2),param_2 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



/* Ghidra-derived function ram:0066 NMI_ISR */

void NMI_ISR(char param_1,byte param_2)

{
  RST7(param_1 + '\\' + (0xfe < param_2),param_2 + 1);
  RST7();
  RST7();
  RST7();
  RST7();
  return;
}



