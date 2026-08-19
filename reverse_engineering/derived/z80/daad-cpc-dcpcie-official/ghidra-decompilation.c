/* Ghidra-derived function ram:0000 RST0 */

/* WARNING: Control flow encountered bad instruction data */

void RST0(undefined1 *param_1,undefined1 param_2)

{
  undefined2 in_AF;
  
  *(char *)CONCAT11(param_2,*param_1) = (char)((ushort)in_AF >> 8);
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0008 RST1 */

/* WARNING: Control flow encountered bad instruction data */

void RST1(undefined1 *param_1,undefined1 param_2)

{
  undefined2 in_AF;
  
  *(char *)CONCAT11(param_2,*param_1) = (char)((ushort)in_AF >> 8);
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0010 RST2 */

/* WARNING: Control flow encountered bad instruction data */

void RST2(undefined1 *param_1)

{
  undefined2 in_AF;
  
  *param_1 = (char)((ushort)in_AF >> 8);
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
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

void RST6(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0038 RST7 */

/* WARNING: Control flow encountered bad instruction data */

void RST7(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



/* Ghidra-derived function ram:0066 NMI_ISR */

/* WARNING: Control flow encountered bad instruction data */

void NMI_ISR(void)

{
                    /* WARNING: Bad instruction - Truncating control flow here */
  halt_baddata();
}



