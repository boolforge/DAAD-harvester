; da65 V2.18 - Ubuntu 2.19-1
; Created:    2026-08-19 11:28:47
; Input file: preservation_corpus/extracted/depth2_b8c6fb53_EDIPLUS4
; Page:       1


        .setcpu "6502"

L0000           := $0000
L02BF           := $02BF
L02DE           := $02DE
L4803           := $4803
L4A1D           := $4A1D
L5103           := $5103
L7802           := $7802
LDB11           := $DB11
LFF84           := $FF84
LFF90           := $FF90
LFFB7           := $FFB7
LFFBA           := $FFBA
LFFBD           := $FFBD
LFFC0           := $FFC0
LFFC6           := $FFC6
LFFCF           := $FFCF
LFFD5           := $FFD5
LFFD8           := $FFD8
LFFE1           := $FFE1
LFFE4           := $FFE4
LFFE7           := $FFE7
        ora     ($08,x)
        ora     $0108
        brk
        .byte   $9E
        .byte   $32
        bmi     L0841
        .byte   $33
        .byte   $3A
        .byte   $8F
        brk
        brk
        brk
        jmp     L356B

        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
L0819:  .byte   $FF
        .byte   $FF
        rts

L081C:  brk
        brk
        .byte   $4C
L081F:  .byte   $3A
        php
        rts

        brk
        brk
        jmp     L083A

        rts

        brk
        brk
        jmp     L26F4

        jmp     L2249

        jmp     L23A6

        jmp     L263E

        jmp     L264C

        .byte   $4C
L083A:  .byte   $3D
L083B:  php
        rts

L083D:  ldx     #$03
        pla
        .byte   $8D
L0841:  inc     $6802
        .byte   $8D
L0845:  .byte   $EF
        .byte   $02
        stx     $02AD
        jsr     L3487
        jsr     LFFE7
        jsr     L3471
        lda     $02C0
        bne     L0860
        lda     #$08
        jsr     L26F4
        jsr     L283E
L0860:  jsr     L2247
        ldx     $02AD
        lda     #$49
        sta     $41
        lda     #$35
        sta     $42
        cpx     #$65
        beq     L08E5
        lda     #$4F
        sta     $41
        lda     #$35
        sta     $42
        cpx     #$64
        beq     L08E5
        txa
        pha
        lda     #$5A
        sta     $41
        lda     #$35
        sta     $42
        jsr     L1B67
        pla
        sta     $8B
        lda     #$00
        sta     $8C
        jsr     L1AEA
        ldx     $02AD
        cpx     #$64
        bcs     L08E8
        lda     #$66
        sta     $41
        lda     #$35
        sta     $42
        jsr     L1B67
        lda     $02E9
        sta     $8B
        jsr     L1AE6
        lda     #$3A
        jsr     L2249
        lda     $02EE
        sta     $FB
        lda     $02EF
        sta     $FC
        ldx     #$00
        lda     ($FB,x)
        sta     $8B
        jsr     L1AE6
        lda     #$2C
        jsr     L2249
        ldy     #$01
        lda     ($FB),y
        sta     $8B
        jsr     L1AE6
        lda     #$3E
        jsr     L2249
        lda     $02EA
        sta     $8B
        jsr     L1AE6
        jmp     L08E6

L08E5:  .byte   $20
L08E6:  .byte   $67
        .byte   $1B
L08E8:  jsr     L23A6
        ldy     #$00
        sty     $EF
L08EF:  lda     $EF
        beq     L08EF
L08F3:  sty     $EF
        jsr     L324E
        jsr     L3471
        lda     $02A7
        and     #$FB
        sta     $02A7
        lda     #$00
        sta     $02AD
        sta     $02C4
        sta     $02C5
        sta     $02C6
        lda     #$0D
        sta     L356B
        lda     #$78
        sta     $02C8
        lda     $02C0
        beq     L0923
        jmp     (L02BF)

L0923:  ldx     #$F7
        txs
        lda     $A3
        sta     $02B4
        jsr     L2930
        lda     #$B9
        sta     $8D
        lda     #$34
        sta     $8E
        ldx     #$08
L0938:  ldy     #$0F
L093A:  lda     L34A9,y
        sta     ($8D),y
        dey
        bpl     L093A
        clc
        lda     #$10
        adc     $8D
        sta     $8D
        lda     #$00
        adc     $8E
        sta     $8E
        dex
        bne     L0938
        lda     #$00
        jsr     L2719
        jsr     L283E
        lda     #$08
        sta     $FF11
        lda     #$00
        tay
L0962:  sta     L367E,y
        dey
        bne     L0962
        sta     $02A7
        lda     #$80
        sta     L369B
        jsr     L0979
        beq     L0978
        jmp     L08F3

L0978:  .byte   $4C
L0979:  .byte   $3B
        .byte   $34
        tsx
        .byte   $8E
L097D:  .byte   $E7
        .byte   $02
        lda     #$00
        sta     $02E9
        jsr     L29BE
        lda     #$00
        pha
        sta     $02EB
        .byte   $8D
L098E:  inx
        .byte   $02
        ldx     #$00
        lda     ($FB,x)
L0994:  bne     L09C7
        pla
        beq     L09AB
        pla
        sta     $8B
        pla
        sta     $FB
        pla
        sta     $FC
        pla
        sta     $FD
        pla
        sta     $FE
        jmp     L1084

L09AB:  lda     $02E8
        beq     L09C6
        pla
        sta     $02E9
        dec     $02E8
        pla
        sta     $FD
        pla
        sta     $FE
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L09FC

L09C6:  rts

L09C7:  jsr     L33AA
        tay
        cpy     #$FF
        beq     L09D4
        cpy     L369F
        bne     L09DF
L09D4:  lda     ($FB,x)
        cmp     #$FF
        beq     L09EB
        cmp     L36A0
        beq     L09EB
L09DF:  jsr     L33AA
        jsr     L33AA
        jsr     L33AA
L09E8:  jmp     L098E

L09EB:  jsr     L33AA
        ldx     #$00
        lda     ($FB,x)
        sta     $FD
        jsr     L33AA
        lda     ($FB,x)
        sta     $FE
        .byte   $20
L09FC:  tax
        .byte   $33
        ldx     #$00
        lda     ($FD,x)
        cmp     #$FF
        beq     L09E8
        lda     $FC
        pha
        lda     $FB
        pha
        lda     ($FD,x)
        sta     $02EA
        asl     a
        tay
        iny
        lda     L12C8,y
        pha
        dey
        lda     L12C8,y
        pha
        jsr     L33B1
        lda     ($FD,x)
        bit     $02EA
        bpl     L0A2B
        tay
        lda     L367E,y
L0A2B:  tay
        clc
        adc     #$7E
        sta     $8B
        lda     #$37
        adc     #$00
        sta     $8C
        tya
        clc
        adc     #$7E
        sta     $FB
        lda     #$36
        adc     #$00
        sta     $FC
        tya
        rts

        cmp     L36A4
        beq     L0AC4
        jmp     L0AAE

        cmp     L36A4
        bne     L0AC4
        jmp     L0AAE

        cmp     L36A4
        bcc     L0AC4
        jmp     L0AAE

        cmp     L36A4
        bcc     L0AB0
        beq     L0AB0
        jmp     L0AC2

        lda     ($8B,x)
        cmp     L36A4
        beq     L0AC4
        cmp     #$FD
        bcs     L0AC4
        jmp     L0AAE

        lda     ($8B,x)
        cmp     L36A4
        beq     L0AB0
        cmp     #$FD
        bcs     L0AB0
        jmp     L0AC2

        lda     ($8B,x)
        cmp     #$FD
        beq     L0AC4
        jmp     L0AAE

        lda     ($8B,x)
        cmp     #$FD
        beq     L0AB0
        jmp     L0AC2

        lda     ($8B,x)
        cmp     #$FE
        bne     L0AB0
        jmp     L0AC2

        lda     ($8B,x)
        cmp     #$FE
        beq     L0AB0
        jmp     L0AC2

        sta     $3F
        jsr     L1ABC
        cmp     $3F
L0AAE:  bcc     L0AC4
L0AB0:  pla
        sta     $FB
        pla
        sta     $FC
        jmp     L098E

        lda     ($FB,x)
        bne     L0AB0
        jmp     L0AC2

        lda     ($FB,x)
L0AC2:  beq     L0AB0
L0AC4:  .byte   $20
L0AC5:  lda     ($33),y
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L09FC

        jsr     L33B1
L0AD3:  lda     ($FD,x)
        cmp     ($FB,x)
        bne     L0AB0
        jmp     L0AC2

        jsr     L0F3A
        jmp     L0AD3

        jsr     L33B1
L0AE5:  lda     ($FD,x)
        cmp     ($FB,x)
        beq     L0AB0
        jmp     L0AC2

        jsr     L0F3A
        jmp     L0AE5

        jsr     L0F3A
        jmp     L0AFD

        jsr     L33B1
L0AFD:  lda     ($FD,x)
        cmp     ($FB,x)
        bcc     L0AC4
        jmp     L0AAE

        jsr     L0F3A
        jmp     L0B0F

        jsr     L33B1
L0B0F:  lda     ($FD,x)
        cmp     ($FB,x)
        bcc     L0AB0
        beq     L0AB0
        jmp     L0AC2

        .byte   $CD
L0B1B:  lda     ($36,x)
        beq     L0AC4
        jmp     L0AAE

        cmp     L36A2
        jmp     L0B1B

        cmp     L36A9
        jmp     L0B1B

        cmp     L36AA
        jmp     L0B1B

        cmp     L36AB
L0B37:  jmp     L0B1B

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$0C
        jsr     L1F96
        ldx     #$00
        lda     ($FB,x)
        tay
        pla
        sta     $FD
        pla
        sta     $FE
        tya
        pha
        lda     #$1E
        jsr     L29DA
        pla
        eor     #$FF
        cmp     ($FB,x)
        bne     L0B61
        jmp     L0E3F

L0B61:  jmp     L0AAE

        lda     #$00
        sta     $FE98
        sta     $EF
        lda     #$0D
        jsr     L1F96
        ldx     #$00
        lda     ($FB,x)
        pha
        lda     #$1F
        jsr     L29DA
        pla
        eor     #$FF
        ldx     $02E7
        txs
        ldx     #$00
        sec
        sbc     ($FB,x)
        beq     L0B92
        stx     L36A4
        ldx     $02E7
        txs
        jmp     L097D

L0B92:  ldx     $02E7
        txs
        .byte   $C9
L0B97:  brk
        rts

        pha
        lda     $02A7
        and     #$FB
        .byte   $8D
        .byte   $A7
L0BA1:  .byte   $02
        pla
        jsr     L1B59
        pla
        sta     $FB
        pla
        sta     $FC
        lda     #$FF
        sta     $02AC
        jmp     L0994

        lda     #$0F
        jmp     L0BA1

        lda     $FE
        pha
        lda     $FD
        pha
        jsr     L261F
        pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0E3F

        jsr     L33B1
        pha
        lda     ($FD,x)
        tay
        pla
        jsr     L0819
        jmp     L0E3C

        jsr     L33B1
        pha
        lda     ($FD,x)
        tay
        pla
        jsr     L081C
        jmp     L0E3C

        lda     $FE
        pha
        lda     $FD
        pha
        jsr     L2766
        pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0E3F

        .byte   $8E
L0BFA:  .byte   $7F
        rol     $BD,x
        ror     $C937,x
        .byte   $FF
        beq     L0C11
        cmp     #$FD
        bcc     L0C0D
        lda     L36A4
        sta     $377E,x
L0C0D:  inx
        jmp     L0BFA

L0C11:  jmp     L0E3F

L0C14:  pla
        sta     $FD
        pla
        sta     $FE
        lda     #$1A
        jmp     L0CF5

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FD
        sta     $FD
        lda     #$FE
        sta     $FE
        lda     L36A4
        jsr     L1556
        beq     L0C14
        pla
        sta     $FD
        pla
        sta     $FE
        jsr     L33BF
L0C3E:  jmp     L0C42

        .byte   $20
L0C42:  .byte   $C2
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$19
        cpy     #$FD
        bcs     L0CA7
        lda     #$1A
        cpy     L36A4
L0C52:  bne     L0CA7
        lda     L36B1
        jsr     L143E
        jsr     L13E7
        clc
        adc     $FC
        cmp     L36B2
        beq     L0C69
        lda     #$2B
L0C67:  bcs     L0CA7
L0C69:  lda     #$24
        sta     $FB
        lda     #$1B
L0C6F:  sta     $FC
        lda     $FC
        pha
        lda     $FB
        pha
        ldy     L367F
        cpy     L36A3
        bcs     L0C96
        lda     #$FE
        ldx     #$00
        sta     ($8B,x)
        inc     L367F
        pla
        sta     $FB
        pla
        sta     $FC
L0C8E:  lda     $FB
        jsr     L1B59
        jmp     L0E3C

L0C96:  pla
        sta     $FB
        pla
        sta     $FC
        ldx     $02EB
        beq     L0CA7
        ldx     $3883
        stx     $02EB
L0CA7:  jmp     L0B97

        jsr     L152F
        beq     L0CF7
        jsr     L33BF
        jmp     L0CB6

        .byte   $20
L0CB6:  .byte   $C2
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$18
        cpy     #$FD
        beq     L0CA7
        lda     #$31
        cpy     L36A4
        beq     L0CA7
        lda     #$1C
        cpy     #$FE
        bne     L0CA7
        dec     L367F
        lda     L36A4
        sta     ($8B,x)
        lda     #$27
L0CD8:  jmp     L0C8E

        jsr     L33BF
        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FE
        sta     $FE
        lda     #$FD
        jsr     L1551
        bne     L0CFE
        pla
        sta     $FD
        pla
        sta     $FE
L0CF5:  lda     #$17
L0CF7:  bcs     L0CFB
        lda     #$08
L0CFB:  jmp     L0B97

L0CFE:  pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0D08

        .byte   $20
L0D08:  .byte   $C2
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$32
        cpy     #$FE
        beq     L0CFB
        cpy     L36A4
        beq     L0CFB
        lda     #$17
        cpy     #$FD
        bne     L0CFB
        jsr     L14E9
        lda     #$18
        bcc     L0CFB
        lda     #$26
        sta     $FB
        lda     #$2A
        sta     $FC
        jmp     L0C6F

L0D30:  pla
        sta     $FD
        pla
        sta     $FE
        lda     #$1C
        jmp     L0CF5

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FD
        jsr     L154F
        beq     L0D30
        tay
        pla
        sta     $FD
        pla
        sta     $FE
        jsr     L33BF
        tya
        jmp     L0D57

        .byte   $20
L0D57:  .byte   $C2
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$31
        cpy     L36A4
        beq     L0CFB
        lda     #$1D
        cpy     #$FD
        beq     L0CFB
        lda     #$1C
        bcc     L0CFB
        jsr     L14E9
        bcc     L0CFB
        lda     #$FD
        sta     ($8B,x)
        dec     L367F
        lda     #$25
        jmp     L0C8E

        tax
L0D7F:  jsr     L223C
        dex
        bne     L0D7F
        jmp     L0E3C

        sta     L36A4
        jmp     L0E3C

        cmp     $3884
        bcs     L0DBC
        ldx     $388E
        stx     $8D
        ldx     $388F
        stx     $8E
        jmp     L0DCE

        pha
        lda     $02A7
        ora     #$40
        sta     $02A7
        pla
        cmp     $3885
        bcs     L0DBC
        ldx     $3890
        stx     $8D
        ldx     $3891
        stx     $8E
        jmp     L0DCE

L0DBC:  ldx     #$07
        jmp     L083D

        cmp     $3886
        bcs     L0DBC
        ldx     $3892
        stx     $8D
        ldx     $3893
L0DCE:  stx     $8E
        asl     a
        php
        clc
        adc     $8D
        sta     $8D
        lda     $8E
        adc     #$00
        plp
        adc     #$00
        sta     $8E
        ldy     #$00
        lda     ($8D),y
        sta     $41
        iny
        lda     ($8D),y
        sta     $42
        jsr     L1B67
L0DEE:  jmp     L0E3C

        jsr     L15C2
        lda     ($8B,x)
        tay
        lda     #$FC
L0DF9:  sta     ($8B,x)
        cpy     #$FE
        bne     L0E3E
        dec     L367F
        jmp     L0E3C

        jsr     L15C2
        lda     ($8B,x)
        tay
        lda     L36A4
        sta     ($8B,x)
L0E10:  jmp     L0DF9

        jsr     L33B1
        lda     ($FD,x)
        jsr     L15C2
        tay
        lda     ($8B,x)
        pha
        lda     $377E,y
        sta     ($8B,x)
        pla
        sta     $377E,y
L0E28:  jmp     L0E3C

        cmp     #$26
        beq     L0E36
        lda     #$FF
        sta     ($FB,x)
        jmp     L0E3C

L0E36:  ldx     #$09
        jmp     L083D

        txa
L0E3C:  sta     ($FB,x)
L0E3E:  .byte   $20
L0E3F:  lda     ($33),y
        pla
        sta     $FB
        pla
        sta     $FC
        lda     #$FF
        sta     $02AC
L0E4C:  jmp     L09FC

        jsr     L33B1
        sta     $8C
L0E54:  lda     ($FD,x)
        clc
        adc     ($FB,x)
        bcc     L0E88
        lda     #$FF
        jmp     L0E86

        jsr     L33B1
L0E63:  lda     ($FD,x)
        sta     $8C
        lda     ($FB,x)
        sec
        sbc     $8C
        bcs     L0E6F
        txa
L0E6F:  sta     ($FB,x)
        jmp     L0E3C

        sta     $8C
        inc     $FD
        lda     ($FD,x)
        tay
        lda     L367E,y
        jmp     L0E86

        jsr     L33B1
        sta     $8C
L0E86:  lda     ($FD,x)
L0E88:  sta     $8B
        lda     $8C
        cmp     #$26
        bne     L0E99
        lda     $3884
        cmp     $8B
        bcc     L0EA0
        beq     L0EA0
L0E99:  lda     $8B
        sta     ($FB,x)
        jmp     L0E3C

L0EA0:  ldx     #$01
L0EA2:  jmp     L083D

        jsr     L1BA0
L0EA8:  jmp     L0E3F

        ldy     #$01
        lda     ($FB),y
        sta     $8C
        jmp     L0EB4

L0EB4:  stx     $8C
        lda     ($FB,x)
        sta     $8B
        jsr     L1AEA
        jmp     L0E3C

        jsr     L33B1
        lda     ($FD,x)
        jsr     L14E1
        cmp     ($8B,x)
        bne     L0EDB
L0ECC:  jmp     L0AC2

        jsr     L33B1
        lda     ($FD,x)
        jsr     L14E1
        cmp     ($8B,x)
        bne     L0ECC
L0EDB:  jmp     L0AAE

        jsr     L15C2
        jsr     L33B1
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        lda     ($FD,x)
        jsr     L14E1
        pha
        lda     ($FB,x)
        jmp     L0F18

        jsr     L14E1
        pha
        lda     L36B1
        jmp     L0F15

        lda     ($FB,x)
        cmp     #$FF
        bne     L0F0E
        ldx     #$02
        jmp     L083D

        lda     ($8B,x)
L0F0E:  pha
        jsr     L33B1
        lda     ($FD,x)
        .byte   $20
L0F15:  .byte   $C2
        ora     $20,x
L0F18:  .byte   $17
        ora     $C9,x
        inc     $03D0,x
        dec     L367F
        pla
        cmp     #$FE
        bne     L0F29
        inc     L367F
L0F29:  sta     ($FB,x)
        jmp     L0E3C

        lda     $FB
        sta     $8B
        lda     $FC
        sta     $8C
        jsr     L0F42
        .byte   $4C
L0F3A:  stx     $0E
        lda     $FB
        sta     $8B
        lda     $FC
L0F42:  sta     $8C
        jsr     L33B1
        lda     ($8B,x)
        sta     $8B
        pha
        lda     ($FD,x)
        sta     $8C
        clc
        adc     #$7E
        sta     $FB
        lda     #$36
        adc     #$00
        sta     $FC
        pla
        rts

        jsr     L0F3A
        jmp     L0E54

        jsr     L0F3A
        jmp     L0E63

        lda     L36A4
        sta     $8C
        lda     $02A7
        ora     #$02
        sta     $02A7
        jsr     L168E
        jmp     L0E3F

        tay
        lda     $FE
        pha
        lda     $FD
        pha
        cpy     #$00
        bne     L0F8D
        jsr     L179C
        jmp     L0F8E

L0F8D:  .byte   $20
L0F8E:  dey
        .byte   $17
        pla
        sta     $FD
        pla
        sta     $FE
        bcs     L0FA3
        lda     $02A7
        ora     #$10
        sta     $02A7
        jmp     L0AAE

L0FA3:  jmp     L0AC2

        jsr     L14E1
        sta     $8C
        lda     $02A7
        and     #$FD
        sta     $02A7
        jsr     L168E
        jmp     L0E3C

        jsr     L33B1
        cmp     $3887
        bcs     L0FF5
        cmp     #$00
        beq     L0FF5
        pha
        jsr     L29BE
        pla
        inc     $02E8
        ldx     $02E8
        cpx     #$0A
        beq     L0FF2
        ldx     $02E9
        stx     $8C
        ldx     #$00
        stx     $8B
        stx     $02AC
        sta     $02E9
        lda     $FE
        pha
        lda     $FD
        pha
        lda     $8C
        pha
        lda     $8B
        pha
        jmp     L098E

L0FF2:  jmp     L083B

L0FF5:  ldx     #$06
        jmp     L083D

        lda     $02E9
        jsr     L29BE
        pla
        pla
        jmp     L098E

        sta     L36AE
        jsr     L33B1
        lda     ($FD,x)
        sta     $8B
        lda     #$F8
        bne     L1041
        jsr     L33B1
        jmp     L0E3C

        lda     $02A7
        and     #$FB
        sta     $02A7
        jmp     L0E3F

        sta     L36A3
        jsr     L33B1
        lda     ($FD,x)
        sta     L36B2
        jmp     L0E3C

        sta     L36A7
        jsr     L33B1
        lda     ($FD,x)
        asl     a
        asl     a
        asl     a
        sta     $8B
        lda     #$C7
L1041:  sta     $8C
        lda     L36AF
        eor     $8B
        and     $8C
        eor     $8B
        sta     L36AF
        jmp     L0E3C

        sta     L105F
        jsr     L33B1
        lda     ($FD,x)
        sta     L1060
        .byte   $20
        .byte   $B1
L105F:  .byte   $33
L1060:  jsr     L0000
L1063:  jmp     L0E3F

        ldx     #$05
L1068:  jmp     L083D

        jsr     L14E1
        sta     L36B0
        ldx     #$04
        lda     $02EB
        bne     L1068
        pla
        sta     $FB
        pla
        sta     $FC
        lda     $02A7
        and     #$EF
        .byte   $8D
L1084:  .byte   $A7
        .byte   $02
        lda     $FE
        pha
        lda     $FD
        pha
        lda     $FC
        pha
        lda     $FB
        pha
        lda     #$FF
        sta     $8B
        lda     #$00
        sta     $8C
        lda     $8C
        pha
        lda     $8B
        pha
        lda     $FC
        pha
        lda     $FB
        pha
        lda     $FE
        pha
        lda     $02EB
        sta     $8B
L10AE:  lda     L36B0
        jsr     L164E
        bcc     L10E2
        sta     L36A0
        cmp     L36AA
        php
        jsr     L33AA
        lda     ($FB,x)
        sta     L36A1
        plp
        bne     L10D3
        lda     L36AB
        cmp     #$FF
        beq     L10AE
        cmp     ($FB,x)
        beq     L10AE
L10D3:  lda     $8B
        sta     $02EB
        tya
        jsr     L15C2
        pla
        sta     $FE
        jmp     L0E3C

L10E2:  lda     #$00
        sta     $02EB
        ldx     #$09
L10E9:  pla
        dex
        bne     L10E9
L10ED:  jmp     L0994

        sta     $02B0
        jsr     L0F42
        lda     $FC
        pha
        lda     $FB
        pha
        jsr     L143B
        lda     $FC
        sta     $8B
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L0E88

        sta     $8C
        jsr     L13E7
        jmp     L0E86

        sta     $8C
        jsr     L1ABC
        jmp     L0E86

L111C:  jmp     L0CF5

        sta     $02FE
        jsr     L152F
        beq     L111C
        jmp     L1133

        jsr     L15C2
        jsr     L33B1
        lda     ($FD,x)
        .byte   $8D
L1133:  inc     $A102,x
        .byte   $8B
        tay
        lda     #$18
        cpy     #$FD
        beq     L115B
        lda     #$31
        cpy     L36A4
        beq     L115B
        lda     #$1C
        cpy     #$FE
        bne     L115B
        lda     $02FE
        sta     ($8B,x)
        dec     L367F
        ldy     #$2C
        jsr     L11DD
        jmp     L0C8E

L115B:  jmp     L0B97

        sta     $02FE
        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FE
        sta     $FE
        lda     #$FD
        sta     $FD
        lda     $02FE
        jsr     L1556
        bne     L118D
        lda     L36A4
        jsr     L1572
        bne     L118D
        pla
        sta     $FD
        pla
        sta     $FE
        lda     $02FE
        bcs     L11D7
        jmp     L0CF7

L118D:  pla
        sta     $FD
        pla
        sta     $FE
        lda     $02FE
        jmp     L119F

        jsr     L15C2
        jsr     L33B1
L119F:  lda     ($FD,x)
        sta     $FC
        lda     ($8B,x)
        tay
        lda     #$19
        cpy     #$FD
        bcs     L115B
        cpy     $FC
        bne     L11CC
        lda     $8C
        pha
        lda     $8B
        pha
        lda     $FC
        jsr     L1517
        tay
        pla
        sta     $8B
        pla
        sta     $8C
        cpy     #$FD
        bcc     L11C9
        jmp     L0C52

L11C9:  jmp     L0C67

L11CC:  cpy     L36A4
        php
        ldy     #$2D
        lda     $FC
        plp
        beq     L11D9
L11D7:  ldy     #$34
L11D9:  jsr     L11DD
        .byte   $4C
L11DD:  .byte   $97
        .byte   $0B
        pha
        tya
        jsr     L1B59
        lda     $02A9
        ora     #$10
        sta     $02A9
        pla
        jsr     L1A6A
        lda     #$33
        rts

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FD
        sta     $FE
        jsr     L154F
        pla
        sta     $FD
        pla
        sta     $FE
L1206:  jmp     L0E3F

        ldy     #$00
        lda     $3898
        sta     $FB
        lda     $3899
L1213:  sta     $FC
L1215:  lda     ($FB),y
        sta     $377E,y
        iny
        cmp     #$FE
        bcc     L1215
        bne     L1206
        inc     L367F
L1224:  jmp     L1213

        stx     $02AC
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L0994

        lda     ($FB,x)
        cmp     $3884
        bcs     L1260
        tay
        lda     $FE
        pha
        lda     $FD
        pha
        lda     $FC
        pha
        lda     $FB
        pha
        tya
        jsr     L174C
        tay
        pla
        sta     $FB
        pla
        sta     $FC
        pla
        sta     $FD
        pla
        sta     $FE
        tya
        bcc     L1260
        sta     ($FB,x)
        jmp     L0E3C

L1260:  jmp     L0AAE

        lda     $02AC
        bne     L1270
L1268:  jmp     L0AAE

        lda     $02AC
        bne     L1268
L1270:  jmp     L0AC5

        stx     $FC
        asl     a
        sta     $FB
        bcc     L127C
        dec     $FC
L127C:  asl     $FB
        rol     $FC
        pla
        sta     $8B
        pla
        sta     $8C
        clc
        lda     $8B
        adc     $FB
        sta     $FB
        lda     $8C
        adc     $FC
        sta     $FC
L1293:  jmp     L098E

        cmp     #$FF
        beq     L129D
        sta     L369F
L129D:  jsr     L33B1
        lda     ($FD,x)
        cmp     #$FF
        beq     L12A9
        sta     L36A0
L12A9:  jmp     L0E3C

        jsr     L15C2
        jmp     L0E3C

        lda     #$20
        jsr     L2249
        jmp     L0E3F

        jsr     L13C8
        bne     L12C7
L12BF:  jmp     L0AAE

        jsr     L13C8
        bne     L12BF
L12C7:  .byte   $4C
L12C8:  .byte   $C2
        asl     a
        .byte   $42
        asl     a
        lsr     a
        asl     a
        .byte   $52
        asl     a
        .byte   $5A
        asl     a
        .byte   $64
        asl     a
        .byte   $72
        asl     a
        .byte   $80
        asl     a
        .byte   $89
        asl     a
        .byte   $92
        asl     a
        .byte   $9B
        asl     a
        ldy     $0A
        ldx     $0A,y
        lda     $CD0A,x
        asl     a
        .byte   $F7
        asl     a
        ora     #$0B
        .byte   $17
        .byte   $0B
        .byte   $1F
        .byte   $0B
        dec     $0B,x
        .byte   $8B
        ora     L0B37
        adc     ($0B,x)
        .byte   $A3
        .byte   $0B
        lda     ($0B),y
        ldx     $0B,y
        ora     #$1E
        .byte   $97
        asl     L0EA8,x
        .byte   $D7
        .byte   $1B
        cpx     $0B
        inc     $0B,x
        .byte   $1C
        .byte   $0C
        .byte   $A7
        .byte   $0C
        sec
        ora     L0CD8
        .byte   $7B
        ora     L1293
        sta     $0D
        sta     $040D,x
        ora     L0C3E
        .byte   $B2
        .byte   $0C
        .byte   $53
        ora     L0DEE
        .byte   $02
        asl     L0E10
        .byte   $DB
        asl     L0E28
        sec
        asl     L0E4C
        eor     $7E0E,x
        asl     L0EA2
L1334:  lda     ($0E),y
        ldx     $BD0D,y
        asl     L12A9
        .byte   $AF
        .byte   $12
        .byte   $B7
        .byte   $12
        .byte   $BF
        .byte   $12
        ror     $0F
        iny
        .byte   $0B
        .byte   $9B
L1347:  ora     L1DBD,x
        nop
        .byte   $1C
        jsr     L4A1D
        ora     L1D78,x
        and     $0B
        .byte   $2B
        .byte   $0B
        and     ($0B),y
        .byte   $5A
        .byte   $0F
        rts

        .byte   $0F
        adc     $A30F,y
        .byte   $0F
        ldx     $0F,y
        cmp     $A70A,y
        ora     L1C8F
        .byte   $DF
        asl     a
        .byte   $EB
        asl     a
        bcs     L1389
        lda     #$1C
        .byte   $02
        bpl     L1334
        .byte   $1B
        pla
        bpl     L1387
        bpl     L1389
        bpl     L1347
        asl     L10ED
        .byte   $27
        ora     ($96),y
        ora     ($16),y
        bpl     L13A6
        bpl     L1390
L1387:  ora     ($11),y
L1389:  ora     ($2F),y
L138B:  bpl     L13B6
        .byte   $1C
        .byte   $43
        .byte   $1C
L1390:  .byte   $6B
        .byte   $1C
        beq     L13A5
        .byte   $4F
        bpl     L138B
        asl     L1224
        .byte   $1C
        ora     ($5B),y
        ora     ($30),y
        .byte   $12
        iny
        .byte   $1C
        .byte   $F7
        .byte   $0F
        .byte   $95
L13A5:  .byte   $1C
L13A6:  .byte   $8F
        .byte   $0B
        sta     ($1D,x)
        .byte   $03
        .byte   $0B
        sbc     ($0A),y
        rts

        .byte   $12
        pla
        .byte   $12
        bvs     L13C6
        dey
        .byte   $0B
L13B6:  lsr     L331C,x
        .byte   $0F
        .byte   $63
        bpl     L13C6
        .byte   $0F
        .byte   $63
L13BF:  bpl     L13BF
        asl     L1063
        .byte   $2B
        .byte   $0F
L13C6:  adc     ($0E),y
L13C8:  asl     $12
        tax
        lsr     a
        lsr     a
        lsr     a
        sta     $FB
        lda     #$3B
        sec
        sbc     $FB
        tay
        txa
        and     #$07
        tax
        lda     L13DF,x
        .byte   $39
        .byte   $7E
L13DF:  rol     $60,x
        ora     ($02,x)
        .byte   $04
        php
        bpl     L1407
L13E7:  rti

        .byte   $80
        lda     $FC
        pha
        lda     $FB
        pha
        lda     $8C
        pha
        lda     $8B
        pha
        lda     $FE
        pha
        lda     $FD
        pha
        lda     $3883
        sta     $FE
        lda     #$00
        sta     $FD
L1404:  pha
        lda     #$00
L1407:  sta     $FC
        ldy     $FD
        lda     $377E,y
        cmp     #$FD
        bcc     L1417
        sty     $FB
        jsr     L1440
L1417:  pla
        clc
        adc     $FC
        bcc     L1422
        lda     #$FF
        jmp     L1426

L1422:  inc     $FD
        dec     $FE
L1426:  bne     L1404
        tay
        pla
        sta     $FD
        pla
        sta     $FE
        pla
        sta     $8B
        pla
        sta     $8C
        pla
        sta     $FB
        pla
        sta     $FC
L143B:  tya
        rts

        .byte   $AD
L143E:  bcs     L1442
L1440:  sta     $FB
L1442:  lda     $8C
        pha
        lda     $8B
        pha
        lda     #$00
        sta     $8C
        lda     #$0A
        sta     $02B0
        lda     $FB
        sta     $8B
        jsr     L1469
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        pla
        sta     $8B
        pla
        sta     $8C
        ldx     #$00
        .byte   $A5
L1469:  .byte   $FB
        rts

        lda     $FC
        pha
        lda     $FB
        pha
        lda     $8C
        pha
        lda     $8B
        pha
        lda     $FE
        pha
        lda     $FD
        pha
        jsr     L1503
        and     #$7F
        clc
        adc     #$C0
        and     #$3F
        bcc     L14C1
        beq     L14C0
        dec     $02B0
        beq     L14BB
        ldx     $3883
        stx     $FE
        ldx     $8B
        stx     $FD
        ldx     #$00
        stx     $8B
        sta     $8C
        lda     #$7E
        sta     $FB
        lda     #$37
        sta     $FC
L14A7:  ldx     #$00
        lda     ($FB,x)
        cmp     $FD
        bne     L14B2
        jsr     L1469
L14B2:  jsr     L33AA
        inc     $8B
        dec     $FE
        bne     L14A7
L14BB:  inc     $02B0
        lda     $8C
L14C0:  sec
L14C1:  tax
        pla
        sta     $FD
        pla
        sta     $FE
        pla
        sta     $8B
        pla
        sta     $8C
        pla
        sta     $FB
        pla
        sta     $FC
        php
        txa
        clc
        adc     $8C
        sta     $8C
        bcc     L14E1
        lda     #$FF
        sta     $8C
L14E1:  plp
        rts

        cmp     #$FF
        bne     L14EA
        .byte   $AD
        .byte   $A4
L14E9:  .byte   $36
L14EA:  rts

        lda     $8C
        pha
        lda     $8B
        pha
        lda     L36B1
        sta     $8B
        jsr     L1503
        asl     a
        pla
        sta     $8B
        pla
        sta     $8C
        lda     #$28
        .byte   $85
L1503:  .byte   $FB
        rts

        lda     $8B
        clc
        adc     $389C
        sta     $FB
        lda     #$00
        sta     $8C
        adc     $389D
        sta     $FC
        .byte   $4C
L1517:  rol     a
        ora     $85,x
        .byte   $8B
        lda     #$00
L151D:  sta     $8C
        lda     #$7E
        clc
        adc     $8B
        sta     $FB
        lda     $8C
        adc     #$37
        sta     $FC
        ldx     #$00
        .byte   $A1
L152F:  .byte   $FB
        rts

        lda     $FE
        sta     $02B3
        lda     $FD
        sta     $02B2
        lda     #$FD
        sta     $FE
        jsr     L154F
        php
        lda     $02B2
        sta     $FD
        lda     $02B3
        sta     $FE
        lda     #$1C
L154F:  plp
        rts

L1551:  lda     #$FE
        ldy     L36A4
L1556:  sty     $FD
        ldy     L36A0
        iny
        sec
        beq     L1586
        ldy     $FE
        sta     $FE
        tya
        pha
        jsr     L159E
        bcs     L158C
        pla
        sta     $FE
        jsr     L159E
        bcs     L158D
L1572:  lda     $FD
        sta     $FE
        jsr     L159E
        bcs     L158D
        lda     #$FF
        sta     $FE
        jsr     L159E
        lda     #$00
        bcs     L158F
L1586:  php
        lda     #$FF
        jmp     L15C3

L158C:  pla
L158D:  lda     #$FF
L158F:  php
        tya
        clc
        adc     #$7E
        sta     $8B
        lda     #$00
        adc     #$37
        sta     $8C
        tya
        .byte   $4C
L159E:  .byte   $C3
        ora     $A9,x
        brk
        sta     $8B
L15A4:  jsr     L1650
        bcc     L15AF
        jsr     L15AE
        bne     L15A4
L15AE:  sec
L15AF:  rts

        cmp     L36A0
        bne     L15C3
        lda     L36A1
        cmp     #$FF
        beq     L15C3
        jsr     L33AA
        ldx     #$00
        .byte   $C1
L15C2:  .byte   $FB
L15C3:  rts

        php
        pha
        tax
        lda     $FC
        pha
        lda     $FB
        pha
        lda     $8C
        pha
        lda     $8B
        pha
        lda     #$00
        sta     L36B4
        sta     L36B5
        sta     L36B6
        sta     L36B7
        sta     L36B8
        sta     L36B9
        stx     $8B
        stx     L36B1
        cpx     #$FF
        beq     L1634
        cpx     $3883
        bcs     L1645
        stx     $8B
        jsr     L1503
        asl     a
        ror     L36B7
        asl     a
        ror     L36B6
        jsr     L151D
        sta     L36B4
        lda     $8B
        sta     $FB
        jsr     L1440
        lda     $FC
        sta     L36B5
        asl     $8B
        rol     $8C
        lda     $8B
        clc
        adc     $389E
        sta     $FB
        lda     $8C
        adc     $389F
        sta     $FC
        ldy     #$00
        lda     ($FB),y
        sta     L36B9
        iny
        lda     ($FB),y
        sta     L36B8
L1634:  pla
        sta     $8B
        pla
        sta     $8C
        pla
        sta     $FB
        pla
        sta     $FC
        ldx     #$00
        pla
        plp
        rts

L1645:  pla
        pla
        pla
        pla
        pla
        plp
        ldx     #$00
        .byte   $4C
L164E:  .byte   $3D
        php
L1650:  sta     $FE
        lda     $8B
        asl     a
        php
        clc
        adc     $389A
        sta     $FB
        lda     #$00
        sta     $8C
        tax
        adc     $389B
        plp
        adc     #$00
L1667:  sta     $FC
        ldy     $8B
        cpy     $3883
        beq     L168E
        inc     $8B
        lda     $FE
        cmp     #$FF
        beq     L167D
        cmp     $377E,y
        bne     L1685
L167D:  lda     ($FB,x)
        cmp     #$FF
        beq     L1685
        sec
        rts

L1685:  jsr     L33AA
        jsr     L33AA
        jmp     L1667

L168E:  clc
        rts

        lda     L36B3
        and     #$7F
        sta     L36B3
        lda     $02A9
        and     #$EF
        sta     $02A9
        ldy     #$00
        sty     $02B3
        .byte   $8C
L16A6:  .byte   $B2
        .byte   $02
        sty     $02B0
        lda     $377E,y
        cmp     #$FF
        beq     L16F8
        cmp     $8C
        bne     L16F1
        lda     $02B3
        sty     $02B3
        ldx     $02B2
        stx     $02B1
        ldx     #$00
        stx     $02B2
        bit     L36B3
        bmi     L16EE
        lda     L36B3
        ora     #$80
        sta     L36B3
        lda     #$02
        bit     $02A7
        beq     L16E8
        lda     #$01
        jsr     L1B59
        bit     L36B3
        bvs     L16E8
        jsr     L2247
L16E8:  inc     $02B2
        jmp     L16EF

L16EE:  .byte   $20
L16EF:  rol     a
        .byte   $17
L16F1:  ldy     $02B0
        iny
        jmp     L16A6

L16F8:  lda     $02B3
        ldx     $02B2
        stx     $02B1
        bit     L36B3
        bpl     L171F
        bvc     L172C
        ldx     $02B1
        bne     L1717
        pha
        lda     #$2F
        jsr     L1B59
        inc     $02B1
        pla
L1717:  jsr     L172A
        lda     #$30
        jmp     L1B59

L171F:  lda     #$02
        bit     $02A7
        bne     L172B
        lda     #$35
        .byte   $20
        .byte   $59
L172A:  .byte   $1B
L172B:  rts

L172C:  bit     L36B3
        bvs     L173F
        jsr     L29CD
        lda     $FB
        sta     $41
        lda     $FC
        sta     $42
        jmp     L1B5F

L173F:  pha
        lda     $02B1
        bne     L174A
        lda     #$2E
        jsr     L1B59
L174A:  pla
        .byte   $4C
L174C:  ror     a
        .byte   $1A
        asl     a
        php
        clc
        adc     $3894
        sta     $8D
        lda     $3895
        adc     #$00
        plp
        adc     #$00
        sta     $8E
        ldy     #$00
        lda     ($8D),y
        sta     $FB
        iny
        lda     ($8D),y
        sta     $FC
L176B:  ldx     #$00
        lda     ($FB,x)
        cmp     #$FF
        bne     L1775
        clc
        rts

L1775:  cmp     L369F
        bne     L1781
        jsr     L33AA
        lda     ($FB,x)
        sec
        rts

L1781:  jsr     L33AA
        jsr     L33AA
        jmp     L176B

        lda     $02E5
        sta     $FB
        ora     $02E6
        beq     L17ED
        lda     $02E6
        sta     $FC
        ldx     #$01
        .byte   $4C
L179C:  cpy     $A917
        .byte   $04
        bit     $02A7
        beq     L17B7
        lda     $02E3
        sta     $FB
        lda     $02E4
        sta     $FC
        ldx     #$00
        lda     ($FB,x)
        cmp     #$0D
        bne     L17D6
L17B7:  jsr     L1F6C
        bcc     L17ED
        lda     $FB
        sta     $02E3
        lda     $FC
        sta     $02E4
        ldx     #$00
        stx     $02E5
        stx     $02E6
        lda     #$FF
        sta     L369F
        sta     L36A2
L17D6:  stx     $02A8
        lda     #$FF
        sta     L36A0
        sta     L36A1
        sta     L36A9
        sta     L36AA
        sta     L36AB
        .byte   $4C
L17EB:  sed
        .byte   $17
L17ED:  lda     $02A7
        and     #$FB
        sta     $02A7
        sec
        rts

L17F7:  .byte   $20
L17F8:  tax
        .byte   $33
        jsr     L1A40
        cmp     #$22
        beq     L17ED
        jsr     L1A52
        bcs     L1822
        cmp     #$0D
        bne     L17F7
        lda     #$04
        bit     $02A7
        beq     L17ED
        lda     $02A7
        and     #$FB
        sta     $02A7
        .byte   $4C
L181A:  .byte   $9C
        .byte   $17
        pla
        sta     $FB
        pla
L1820:  sta     $FC
L1822:  jsr     L19D0
        beq     L182A
        .byte   $4C
L1828:  sbc     #$18
L182A:  jsr     L1A4E
        bcs     L1822
        cmp     #$22
        bne     L1865
        lda     #$01
        bit     $02A8
        bne     L1865
        lda     $02E5
        ora     $02E6
        beq     L1845
L1842:  jmp     L17EB

L1845:  jsr     L33AA
        lda     $FB
        sta     $02E5
        lda     $FC
        sta     $02E6
L1852:  lda     ($FB,x)
        cmp     #$0D
        beq     L1842
        jsr     L33AA
        cmp     #$22
        bne     L1852
        jsr     L1A40
        .byte   $4C
L1863:  plp
        clc
L1865:  lda     $02A7
        ora     #$04
        sta     $02A7
        lda     #$01
        bit     $02A8
        bne     L1881
        lda     $FB
        sta     $02E3
        lda     $FC
        sta     $02E4
        jmp     L1889

L1881:  lda     $FB
        sta     $02E5
        lda     $FC
        .byte   $8D
L1889:  inc     $02
        ldx     #$00
        lda     ($FB,x)
        cmp     #$0D
        bne     L189B
        lda     $02A7
        and     #$FB
        sta     $02A7
L189B:  lda     #$02
        bit     $02A8
        bne     L18B2
        lda     L36A0
        cmp     #$FF
        beq     L1842
        cmp     #$28
        bcs     L18B0
        sta     L369F
L18B0:  clc
        rts

L18B2:  lda     #$20
        bit     $02A8
        bne     L18BE
        lda     #$FF
        sta     L36A2
L18BE:  lda     L36AA
        sta     $8B
        lda     L36AB
        sta     $8C
        jsr     L18D3
        lda     L36A0
        sta     $8B
        lda     L36A1
L18D3:  sta     $8C
        lda     $8B
        cmp     #$FF
        beq     L18E9
        cmp     #$32
        bcc     L18E9
        lda     $8B
        sta     L36AC
        lda     $8C
        sta     L36AD
L18E9:  clc
        rts

        tay
        ldx     #$00
        lda     ($FD,x)
        cmp     #$05
        bne     L18F7
        jmp     L1863

L18F7:  cmp     #$00
        bne     L1910
        lda     #$02
        bit     $02A8
        bne     L190D
        sty     L369F
        lda     $02A8
        ora     #$02
        sta     $02A8
L190D:  jmp     L1820

L1910:  cmp     #$01
        bne     L1929
        lda     #$20
        bit     $02A8
        bne     L190D
        sty     L36A2
        lda     $02A8
        ora     #$20
        sta     $02A8
        jmp     L1820

L1929:  cmp     #$04
        bne     L193A
        lda     L36A9
        cmp     #$FF
        bne     L190D
        sty     L36A9
        jmp     L1820

L193A:  tax
        lda     #$08
        bit     $02A8
        bne     L190D
        lda     $FC
        pha
        lda     $FB
        pha
        lda     #$A0
        sta     $FB
        lda     #$36
        sta     $FC
        lda     #$04
        bit     $02A8
        beq     L195F
        lda     #$AA
        sta     $FB
        lda     #$36
        sta     $FC
L195F:  txa
        ldx     #$00
        cmp     #$06
        beq     L19BC
        cmp     #$02
        bne     L19A6
        lda     #$04
        bit     $02A8
        beq     L1996
        cpy     L36A0
        bne     L198E
        jsr     L33AA
        lda     ($FB,x)
        jsr     L33CC
        cmp     #$FF
        beq     L1999
        cmp     L36A1
        beq     L1999
        lda     L36A1
        cmp     #$FF
        beq     L1999
L198E:  lda     $02A8
        ora     #$08
        sta     $02A8
L1996:  tya
        sta     ($FB,x)
L1999:  lda     $02A8
        ora     #$04
        and     #$7F
        sta     $02A8
L19A3:  jmp     L181A

L19A6:  bit     $02A8
        bmi     L19A3
        jsr     L33AA
        tya
        sta     ($FB,x)
        lda     $02A8
        ora     #$80
        sta     $02A8
        jmp     L181A

L19BC:  lda     L36AC
        cmp     #$FF
        beq     L19A3
        tay
        jsr     L33AA
        lda     L36AD
        sta     ($FB,x)
        jsr     L33CC
        .byte   $4C
L19D0:  pla
        ora     $A2,y
        lda     #$DF
        ldy     #$04
L19D8:  sta     $02B8,y
        dey
        bpl     L19D8
        iny
L19DF:  jsr     L1A4E
        bcc     L19FB
        eor     #$FF
        sta     $02B8,y
        jsr     L33AA
        iny
        cpy     #$05
        bne     L19DF
        beq     L19F6
L19F3:  jsr     L33AA
L19F6:  jsr     L1A4E
        bcs     L19F3
L19FB:  jsr     L1A40
        lda     $3896
        sta     $FD
        lda     $3897
        sta     $FE
        lda     $02A7
        and     #$DF
        sta     $02A7
        ldy     #$00
L1A12:  lda     ($FD,x)
        bne     L1A17
        rts

L1A17:  cmp     $02B8,y
        beq     L1A24
        lda     $02A7
        ora     #$20
        sta     $02A7
L1A24:  jsr     L33B1
        iny
        cpy     #$05
        bne     L1A12
        lda     #$20
        bit     $02A7
        bne     L1A39
        lda     ($FD,x)
        jsr     L33B1
        rts

L1A39:  jsr     L33B1
        jsr     L33B1
        .byte   $4C
L1A40:  asl     $1A
        ldx     #$00
        lda     ($FB,x)
        cmp     #$20
        bne     L1A62
        jsr     L33AA
        .byte   $4C
L1A4E:  rti

        .byte   $1A
        ldx     #$00
L1A52:  lda     ($FB,x)
        jsr     L1A61
        bcc     L1A6A
        cmp     #$41
        bcc     L1A62
        cmp     #$5B
        bcc     L1A6A
L1A61:  clc
L1A62:  rts

        cmp     #$30
        bcc     L1A6A
        cmp     #$3A
        rts

L1A6A:  sec
        rts

        cmp     $3883
        bcs     L1ABD
        tay
        lda     $FC
        pha
        lda     $FB
        pha
        tya
        jsr     L29CD
L1A7C:  jsr     L1AA5
        beq     L1A7C
        tay
        lda     #$10
        bit     $02A9
        bne     L1A8F
        tya
        and     #$DF
        jmp     L1A97

L1A8F:  jsr     L1AA5
        bne     L1A8F
L1A94:  jsr     L1AA5
L1A97:  beq     L1A94
L1A99:  eor     #$FF
        jsr     L2249
        jsr     L1AA5
        cmp     #$D1
        bne     L1A99
L1AA5:  beq     L1AB7
        ldx     #$00
        lda     ($FB,x)
        cmp     #$F5
        beq     L1AB5
        jsr     L33AA
        cmp     #$DF
        rts

L1AB5:  pla
        pla
L1AB7:  pla
        sta     $FB
        pla
        .byte   $85
L1ABC:  .byte   $FC
L1ABD:  rts

        lda     $02B4
        clc
        adc     #$01
        sta     $02B0
        lda     #$65
        sta     $02B1
        lda     #$00
        sta     $02B4
        ldx     #$08
L1AD3:  lsr     $02B0
        bcc     L1ADC
        clc
        adc     $02B1
L1ADC:  ror     a
        ror     $02B4
        dex
        bne     L1AD3
        cmp     #$00
        .byte   $F0
L1AE6:  .byte   $D7
        rts

        lda     #$00
L1AEA:  sta     $8C
        lda     #$00
        sta     $02B2
        lda     #$10
        sta     $41
        lda     #$27
        sta     $42
        jsr     L1B1F
        lda     #$E8
        sta     $41
        lda     #$03
        sta     $42
        jsr     L1B1F
        lda     #$64
        sta     $41
        lda     #$00
        sta     $42
        jsr     L1B1F
        lda     #$0A
        sta     $41
        jsr     L1B1F
        lda     $8B
        clc
        adc     #$30
        .byte   $4C
L1B1F:  eor     #$22
        ldx     #$00
L1B23:  inx
        lda     $8B
        sec
        sbc     $41
        sta     $8B
        lda     $8C
        sbc     $42
        sta     $8C
        bcs     L1B23
        dex
        lda     $8B
        clc
        adc     $41
        sta     $8B
        lda     $8C
        adc     $42
        sta     $8C
        txa
        bne     L1B4A
        ldx     $02B2
        bne     L1B4A
        rts

L1B4A:  ldx     #$01
        stx     $02B2
        clc
        adc     #$30
        jmp     L2249

        jsr     L29DA
        .byte   $4C
L1B59:  .byte   $5F
        .byte   $1B
        jsr     L29DA
        .byte   $4C
L1B5F:  .byte   $67
        .byte   $1B
        lda     $02A7
        ora     #$40
        .byte   $8D
L1B67:  .byte   $A7
        .byte   $02
L1B69:  ldx     #$00
        lda     $02A9
        ora     #$20
        sta     $02A9
        lda     ($41,x)
        eor     #$FF
        cmp     #$0A
        beq     L1B9D
        cmp     $3882
        bne     L1B91
        lda     $02A9
        ora     #$10
        sta     $02A9
        lda     L36B1
        jsr     L1A6A
        jmp     L1B92

L1B91:  .byte   $20
L1B92:  eor     #$22
        inc     $41
        bne     L1B69
        inc     $42
        jmp     L1B67

L1B9D:  bit     $02A7
L1BA0:  bvc     L1BB2
        jsr     L2247
        jsr     L299F
        lda     $02A7
        and     #$BF
        sta     $02A7
        ldx     #$00
L1BB2:  rts

        and     #$07
        sta     $8B
        lda     $02D5
        and     #$F8
        ora     $8B
        sta     $02D5
        jmp     L0E3C

        cmp     $CBFD
        bcs     L1BD7
        sta     $02FF
        tay
        jsr     L2ACB
        lda     ($FB,x)
        bmi     L1BD7
        jmp     L0AC2

L1BD7:  jmp     L0AAE

        tax
        lda     $02AA
        and     #$7F
        sta     $02AA
        txa
        beq     L1BEE
        lda     $02AA
        ora     #$80
        sta     $02AA
L1BEE:  lda     $FE
        pha
        lda     $FD
        pha
        jsr     L23A6
        jsr     L299F
        lda     $02D5
        pha
        lda     #$00
        sta     $02D5
        lda     $02D3
        pha
        lda     $02D2
        pha
        ldy     $02FF
        jsr     L2A0B
        jsr     L299F
        pla
        sta     $02D2
        pla
        sta     $02D3
        jsr     L28FB
        pla
        sta     $02D5
        pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0E3C

        jsr     L23A6
        lda     $02D5
        and     #$5F
        sta     $02D5
        lda     $02D2
        sta     $02D6
        lda     $02D3
        sta     $02D7
        jmp     L0E3F

        jsr     L23A6
        lda     $02D5
        and     #$5F
        sta     $02D5
        lda     $02D6
        sta     $8B
        lda     $02D7
        sta     $8C
        jsr     L2693
        jmp     L0E3F

        pha
        jsr     L23A6
        lda     $02D3
        sta     $8C
        pla
        jmp     L1C7C

        pha
        jsr     L23A6
        pla
        clc
        adc     $02D0
        sta     $8C
        jsr     L33B1
L1C7C:  lda     ($FD,x)
        clc
        adc     $02D1
        sta     $8B
        jsr     L2693
        lda     $02D5
        and     #$5F
        sta     $02D5
L1C8F:  jmp     L0E3C

        jsr     L26F4
        jmp     L0E3C

        jsr     L23A6
        jsr     L33BF
        lda     $02CE
        lsr     a
        sta     $FC
        lda     #$14
        sec
        sbc     $FC
        jmp     L1CC3

        pha
        jsr     L23A6
        pla
        cmp     #$17
        bcc     L1CB7
        lda     #$00
L1CB7:  sta     $02D0
        jsr     L33B1
        lda     ($FD,x)
        cmp     #$28
        bcc     L1CC5
L1CC3:  lda     #$00
L1CC5:  sta     $02D1
        jmp     L1CDC

        pha
        jsr     L23A6
        pla
        sec
        sbc     #$01
        sta     $02CF
        jsr     L33B1
        lda     ($FD,x)
        .byte   $8D
L1CDC:  dec     L2002
        .byte   $CB
        rol     $20
        .byte   $EF
        plp
        lda     $02CF
        sta     $02CC
        jmp     L0E3C

        pha
        jsr     L33B1
        lda     ($FD,x)
        cmp     #$D5
        bcc     L1CF9
        lda     #$D5
L1CF9:  cmp     #$5A
        bcs     L1CFF
        lda     #$D6
L1CFF:  sec
        sbc     #$5A
        asl     a
        tay
        lda     $CC10,y
        sta     $FF0E
        lda     $CC11,y
        sta     $FF10
        pla
        tay
        lda     #$18
        sta     $FF11
L1D17:  jsr     L223C
        dey
        bne     L1D17
        stx     $FF11
        jmp     L0E3C

        jsr     L1F55
        pha
        and     #$F0
        sta     $8B
        pla
        and     #$0F
        sta     $8C
        lda     $02CA
        and     #$F0
        ora     $8C
        sta     $02CA
        sta     $02DA
        lda     $02D8
        and     #$0F
        ora     $8B
        sta     $02D8
        sta     $02A5
        jmp     L0E3C

        jsr     L1F55
        pha
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        sta     $8B
        pla
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        sta     $8C
        lda     $02CA
        and     #$0F
        ora     $8C
        sta     $02CA
        sta     $02DA
        lda     $02D8
        and     #$F0
        ora     $8B
        sta     $02D8
        sta     $02A5
L1D78:  jmp     L0E3C

        jsr     L1F55
        sta     $FF19
        jmp     L0E3C

        .byte   $20
L1D85:  .byte   $87
        .byte   $34
        jsr     LFFE4
        jsr     L3471
        beq     L1D9B
        sta     L36BA
        lda     $02CF
        jsr     L266D
        jmp     L0AC5

L1D9B:  jmp     L0AAE

        lda     #$FF
        sta     $02C1
        lda     #$00
        sta     $1D
        lda     #$DD
        sta     $1E
        lda     #$7E
        sta     $1B
        lda     #$36
        sta     $1C
        lda     #$00
        sta     $02B6
        lda     #$02
        sta     $02B7
L1DBD:  jmp     L1E04

        ldy     $02C1
        bne     L1DC8
        jmp     L0AAE

L1DC8:  jsr     L33B1
        sta     $02B6
        stx     $02B7
        inc     $02B6
        bne     L1DD9
        inc     $02B7
L1DD9:  lda     #$7E
        sta     $1D
        lda     #$36
        sta     $1E
        lda     #$00
        sta     $1B
        lda     #$DD
        sta     $1C
        jsr     L33D9
        lda     #$7E
        sta     $1D
        lda     #$37
        sta     $1E
        lda     #$00
        sta     $02B6
        lda     #$01
        sta     $02B7
        lda     #$00
        sta     $1B
        lda     #$DE
L1E04:  sta     $1C
        jsr     L33D9
        jmp     L0E3F

        tay
        lda     L02BF
        sta     $02AE
        lda     $02C0
        sta     $02AF
        lda     #$67
        sta     L02BF
        lda     #$1E
        sta     $02C0
        lda     $FE
        pha
        lda     $FD
        pha
        tya
        pha
        jsr     L3382
        pla
        jsr     L32EC
        lda     $02B0
        beq     L1E90
        jsr     L3487
        tax
        ldy     #$01
        jsr     LFFBA
        ldx     #$6B
        ldy     #$35
        lda     $02B1
        jsr     LFFBD
        lda     #$7E
        sta     $FB
        lda     #$36
        sta     $FC
        ldx     #$80
        ldy     #$38
        lda     #$FB
        jsr     LFFD8
        php
        jsr     L324E
        ldy     $02B0
        cpy     #$01
        bne     L1E81
        plp
L1E67:  bcs     L1E90
        jsr     L3471
        pla
        sta     $FD
        pla
        sta     $FE
        lda     $02AE
        sta     L02BF
        lda     $02AF
        sta     $02C0
        jmp     L0E3C

L1E81:  plp
        bcs     L1E90
        jsr     L3278
        ldx     #$64
        cmp     #$00
        bne     L1E97
        jmp     L1E67

L1E90:  ldx     #$65
        cmp     #$00
        beq     L1E97
        dex
L1E97:  jmp     L0845

        tay
        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$00
        sta     $387F
        sta     $387E
        tya
        jsr     L32EC
        jsr     L3487
        lda     $02B0
        beq     L1EE4
        ldy     #$00
        tax
        jsr     LFFBA
        ldx     #$6B
        ldy     #$35
        lda     $02B1
        jsr     LFFBD
        lda     #$00
        ldx     #$7E
        ldy     #$36
        jsr     LFFD5
        php
        jsr     L324E
        stx     $3F
        sty     $40
        ldy     $02B0
        cpy     #$01
        bne     L1EF3
        plp
        bcc     L1EE9
        cmp     #$00
        bne     L1F1F
L1EE4:  ldx     #$65
        jmp     L0845

L1EE9:  jsr     LFFB7
        cmp     #$00
        bne     L1F1F
        jmp     L1F22

L1EF3:  plp
        bcc     L1F03
        cmp     #$04
        beq     L1F03
        cmp     #$00
        bne     L1F1F
        ldx     #$65
        jmp     L0845

L1F03:  jsr     LFFB7
        pha
        lda     $40
        pha
        lda     $3F
        pha
        jsr     L3278
        cmp     #$00
        bne     L1F1F
        pla
        sta     $3F
        pla
        sta     $40
        pla
        cmp     #$40
        beq     L1F24
L1F1F:  ldx     #$64
        .byte   $4C
L1F22:  eor     $08
L1F24:  lda     #$80
        ldy     #$38
        cmp     $3F
        bne     L1F1F
        cpy     $40
        bne     L1F1F
        lda     $387E
        sta     $3F
        lda     $387F
        sta     $40
        jsr     L3382
        lda     $387E
        cmp     $3F
        bne     L1F1F
        lda     $387F
        cmp     $40
        bne     L1F1F
        jsr     L3471
        pla
        sta     $FD
        pla
        sta     $FE
        .byte   $4C
L1F55:  .byte   $3C
        asl     L0F29
        tay
        lda     $CBF9
        sta     $FB
        lda     $CBFA
        sta     $FC
        jsr     L33AA
        lda     ($FB),y
        tay
        .byte   $B9
        brk
L1F6C:  cpy     $AD60
        tay
        .byte   $02
        and     #$EF
        sta     $02A8
        lda     L36A8
        beq     L1F80
        cmp     $3886
        bcc     L1FAF
L1F80:  jsr     L1ABC
        ldy     #$02
        cmp     #$1E
        bcc     L1F94
        iny
        cmp     #$3C
        bcc     L1F94
        iny
        cmp     #$5A
        bcc     L1F94
        iny
L1F94:  tya
        .byte   $4C
L1F96:  lda     $481F
        lda     $02A7
        and     #$FB
        sta     $02A7
        lda     $02A8
        ora     #$10
        sta     $02A8
        lda     #$0C
        sta     $02C8
        pla
L1FAF:  pha
        lda     $02C9
        sta     $02C3
        lda     L36A7
        and     #$07
        beq     L1FC0
        jsr     L26F4
L1FC0:  pla
        jsr     L1B59
        jsr     L23A6
        lda     $02D5
        and     #$BF
        sta     $02D5
        lda     #$80
        sta     $02CC
        lda     #$21
        jsr     L1B59
        jsr     L21F4
        jsr     L260B
        lda     $02D2
        sta     $02C7
        lda     #$10
        bit     $02A8
        bne     L2003
        lda     L36AF
        asl     a
        bcc     L2003
        asl     a
        bcc     L2003
        asl     a
        bcc     L2003
        ldy     #$00
        jsr     L2192
        jsr     L21B9
        .byte   $4C
        clc
L2002:  .byte   $20
L2003:  lda     #$00
        sta     $02C6
        sta     $02C5
        lda     #$0D
        sta     L356B
        .byte   $4C
L2011:  clc
        jsr     $01A9
        bit     L36AF
L2018:  bne     L203D
        lda     #$10
        bit     $02A8
        bne     L203D
L2021:  lda     L36AE
        beq     L203D
        jsr     L264C
        bcs     L2040
        ldy     $02C5
        jsr     L2192
        jsr     L21D5
        lda     L36AF
        ora     #$C0
        clc
        jmp     L20C4

L203D:  jsr     L263E
L2040:  cmp     #$14
        bne     L2047
        jmp     L215C

L2047:  cmp     #$9D
        bne     L204E
        jmp     L2139

L204E:  cmp     #$1D
        bne     L2055
        jmp     L2149

L2055:  cmp     #$0D
        bne     L2064
        lda     $02C6
        beq     L2061
        .byte   $4C
        .byte   $AD
L2060:  .byte   $20
L2061:  jmp     L2011

L2064:  ldy     $02C6
        cpy     $02C8
        beq     L2061
        cmp     #$20
        bcc     L2061
        cmp     #$41
        bcc     L2088
        cmp     #$5B
        bcs     L207E
        clc
        adc     #$20
        jmp     L2086

L207E:  cmp     #$C1
        bcc     L2061
        cmp     #$DB
        bcs     L2061
L2086:  sbc     #$7F
L2088:  pha
        lda     $02C6
        tax
        tay
        iny
L208F:  lda     L356B,x
        sta     L356B,y
        dex
        dey
        cpy     $02C5
        bne     L208F
        pla
        sta     L356B,y
        inc     $02C5
        inc     $02C6
        jsr     L2192
        jsr     L21B9
        .byte   $4C
L20AD:  ora     ($20),y
        ldy     $02C5
        jsr     L2192
        jsr     L21D5
        jsr     L2247
        lda     #$78
        sta     $02C8
        lda     L36AF
        .byte   $29
L20C4:  .byte   $3F
        sec
        sta     L36AF
        php
        jsr     L2616
        lda     #$08
        bit     L36AF
        beq     L20D7
        jsr     L2766
L20D7:  lda     $02D5
        ora     #$40
        sta     $02D5
        lda     $02C3
        jsr     L26F4
        plp
        php
        bcc     L2131
        lda     #$10
        bit     L36AF
        beq     L20F5
        lda     #$21
        jsr     L1B59
L20F5:  lda     #$6B
        sta     $FB
        lda     #$35
L20FB:  sta     $FC
        .byte   $A2
L20FE:  brk
        lda     ($FB,x)
        cmp     #$0D
        beq     L2127
        pha
        lda     #$10
        bit     L36AF
        beq     L2112
        pla
        pha
        jsr     L2249
L2112:  pla
        cmp     #$61
        bcc     L2121
        cmp     #$7B
        bcs     L2121
        and     #$DF
        ldx     #$00
        sta     ($FB,x)
L2121:  jsr     L33AA
        jmp     L20FB

L2127:  lda     #$10
        bit     L36AF
        beq     L2131
        jsr     L2247
L2131:  lda     #$6B
        sta     $FB
        lda     #$35
        sta     $FC
L2139:  plp
        rts

        ldy     $02C5
        beq     L2148
        dec     $02C5
        lda     #$08
        jsr     L24BD
L2148:  .byte   $4C
L2149:  ora     ($20),y
        ldy     $02C5
        lda     L356B,y
        cmp     #$0D
        beq     L2148
        inc     $02C5
        jsr     L24BD
        .byte   $4C
L215C:  ora     ($20),y
        lda     $02C5
        beq     L2148
        tay
        dey
        tax
L2166:  lda     L356B,x
        sta     L356B,y
        inx
        iny
        cpy     $02C6
        bne     L2166
        lda     #$08
        jsr     L24BD
        dec     $02C6
        dec     $02C5
        ldy     $02C5
        jsr     L2192
        lda     #$20
        jsr     L24BD
        lda     #$08
        jsr     L24BD
        jsr     L21B9
        .byte   $4C
L2192:  ora     ($20),y
        tya
        pha
        jsr     L2616
        pla
        tay
        tya
        pha
        lda     L356B,y
        cmp     #$0D
        bne     L21B2
        lda     #$20
        jsr     L24BD
        lda     #$08
        jsr     L24BD
        pla
        jmp     L260B

L21B2:  jsr     L24BD
        pla
        tay
        iny
        .byte   $4C
L21B9:  sta     L2021,y
        asl     $26,x
        lda     $02C6
        sec
        sbc     $02C5
        beq     L21D4
        tay
L21C8:  tya
        pha
        lda     #$08
        jsr     L24BD
        pla
        tay
        dey
        bne     L21C8
L21D4:  .byte   $4C
L21D5:  .byte   $0B
        rol     $AD
        dec     $02
        clc
        adc     $02C7
        sec
        sbc     $02D1
        ldx     $02CF
L21E5:  sec
        sbc     $02CE
        bcc     L21F2
        dex
        bne     L21E5
        ldx     $02CF
        inx
L21F2:  txa
        .byte   $4C
L21F4:  adc     $AD26
        dec     $8502
        .byte   $8B
        lda     #$00
        sta     $8C
        sta     $FB
        sta     $FC
        ldx     $02CF
L2206:  clc
        lda     $8B
        adc     $FB
        sta     $FB
        lda     $8C
        adc     $FC
        sta     $FC
        dex
        bpl     L2206
        lda     $02D2
        clc
        adc     #$01
        sec
        sbc     $02D1
        sta     $8B
        sec
        lda     $FB
        sbc     $8B
        sta     $FB
        lda     $FC
        sbc     $8C
        sta     $FC
        lda     $FC
        bne     L223D
        lda     $FB
        cmp     $02C8
        bcs     L223D
        .byte   $8D
        iny
L223C:  .byte   $02
L223D:  rts

        lda     #$01
        sta     $02E2
        lda     $02E2
        .byte   $D0
L2247:  .byte   $FB
        rts

L2249:  lda     #$0D
        cmp     #$80
        bcc     L228E
        tay
        lda     #$04
        bit     $02A9
        beq     L228E
        lda     $FC
        pha
        lda     $FB
        pha
        lda     $3888
        sta     $FB
        lda     $3889
        sta     $FC
        tya
        sec
        sbc     #$7F
        tax
        ldy     #$00
L226E:  lda     ($FB),y
        php
        jsr     L33AA
        plp
        bpl     L226E
        dex
        bne     L226E
        ldy     #$00
        lda     ($FB),y
        php
        and     #$7F
        plp
        bmi     L2296
        jsr     L228C
        jsr     L33AA
        .byte   $4C
        sei
L228C:  .byte   $22
        tya
L228E:  tay
        lda     $FC
        pha
        lda     $FB
        pha
        tya
L2296:  tay
        lda     $8C
        pha
        lda     $8B
        pha
        lda     $FE
        pha
        lda     $FD
        pha
        tya
        cmp     #$0D
        beq     L2314
        cmp     #$10
        bcc     L22C3
        lda     #$01
        bit     $02D5
        beq     L22B7
        tya
        ora     #$80
        tay
L22B7:  tya
        bit     $02D5
        bvs     L22C6
        jsr     L236E
        jmp     L22FF

L22C3:  jmp     L2334

L22C6:  cmp     #$20
        beq     L22EF
        cmp     #$A0
        beq     L22EF
        pha
        lda     $02C4
        cmp     #$28
        bne     L22D9
        jsr     L23A6
L22D9:  lda     $02D5
        and     #$7F
        sta     $02D5
        pla
        ldy     $02C4
        sta     L35E3,y
        iny
        sty     $02C4
        jmp     L22FF

L22EF:  bit     $02D5
        bmi     L2301
        pha
        jsr     L23A6
        pla
        bit     $02D5
        bmi     L2301
        .byte   $20
L22FF:  .byte   $6E
        .byte   $23
L2301:  pla
        sta     $FD
        pla
        sta     $FE
        pla
        sta     $8B
        pla
        sta     $8C
        pla
        sta     $FB
        pla
        sta     $FC
        rts

L2314:  jsr     L23A6
        lda     #$20
        bit     $02D5
        php
        lda     $02D5
        and     #$DF
        sta     $02D5
        plp
        beq     L2330
        lda     #$0D
        jsr     L24BD
        jmp     L22FF

L2330:  jsr     L2410
        .byte   $4C
L2334:  .byte   $FF
        .byte   $22
        cmp     #$0F
        bne     L2345
        lda     $02D5
        and     #$FE
        sta     $02D5
        jmp     L22FF

L2345:  cmp     #$0E
        bne     L2354
        lda     $02D5
        ora     #$01
        sta     $02D5
        jmp     L22FF

L2354:  pha
        jsr     L23A6
        pla
        cmp     #$0B
        bne     L2363
        jsr     L2766
        jmp     L22FF

L2363:  cmp     #$0C
        bne     L236D
        ldx     $02CF
        jsr     L262E
L236D:  .byte   $4C
L236E:  .byte   $FF
        .byte   $22
        pha
        jsr     L24BD
        lda     $02D5
        and     #$DF
        sta     $02D5
        lda     $02D1
        clc
        adc     $02CE
        cmp     $02D2
        beq     L238A
        pla
        rts

L238A:  pla
        cmp     #$20
        bne     L239C
        bit     $02D5
        bvc     L239C
        lda     $02D5
        ora     #$80
        sta     $02D5
L239C:  jmp     L2415

        lda     $02D5
        ora     #$20
        .byte   $8D
        .byte   $D5
L23A6:  .byte   $02
        rts

        pha
        bit     $02D5
        bvc     L23B3
        lda     $02C4
        bne     L23B5
L23B3:  pla
        rts

L23B5:  lda     $02D1
        clc
        adc     $02CE
        sec
        sbc     $02D2
        cmp     $02C4
        beq     L23E5
        bcs     L23ED
        lda     $02D1
        clc
        adc     $02CE
        cmp     $02D2
        beq     L23ED
        lda     $FC
        pha
        lda     $FB
        pha
        jsr     L2410
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L23EB

L23E5:  lda     $02D5
        ora     #$80
        .byte   $8D
L23EB:  cmp     $02,x
L23ED:  ldy     #$00
L23EF:  tya
        pha
        lda     L35E3,y
        jsr     L236E
        pla
        tay
        iny
        cpy     $02C4
        bne     L23EF
        .byte   $4C
L2400:  ora     #$24
        pha
        lda     $02D5
        and     #$7F
        .byte   $8D
L2409:  cmp     $02,x
        lda     #$00
        sta     $02C4
L2410:  pla
        rts

        lda     #$0D
        .byte   $20
L2415:  lda     $CE24,x
        cpy     $F002
        .byte   $01
L241C:  rts

        lda     $02CF
        sta     $02CC
        lda     $02F0
        bne     L241C
        lda     #$02
        bit     $02D5
        bne     L241C
        jsr     L2670
        lda     $42
        pha
        lda     $41
        pha
        lda     #$20
        jsr     L29DA
        lda     $02DC
        pha
        and     #$3F
        sta     $02DC
        lda     $02DA
        pha
        lda     $02DB
        pha
        lda     $02A5
        pha
        lda     $02A6
        pha
        lda     $02D5
        pha
        lda     #$00
        sta     $02D5
        dec     $02F0
        .byte   $20
L2463:  .byte   $9F
        and     #$A0
        brk
        lda     ($41),y
        eor     #$FF
        cmp     #$0A
        beq     L247B
        jsr     L2249
        inc     $41
        bne     L2478
        inc     $42
L2478:  jmp     L2463

L247B:  inc     $02F0
        pla
        sta     $02D5
        pla
        sta     $02A6
        pla
        sta     $02A5
        pla
        sta     $02DB
        pla
        sta     $02DA
        pla
        sta     $02DC
        pla
        sta     $41
        pla
        sta     $42
        lda     #$02
        bit     L36AF
        jsr     L2637
        lda     $02D2
        cmp     $02D1
        bne     L24AD
        rts

L24AD:  lda     #$08
        jsr     L24BD
        lda     #$20
        jsr     L24BD
        lda     #$08
        jsr     L24BD
        .byte   $4C
L24BD:  ldx     #$24
        pha
        jsr     L24D7
        pla
        cmp     #$08
        bne     L24CD
        jsr     L24EE
        beq     L24D9
L24CD:  cmp     #$0D
        bne     L24D6
        jsr     L2528
        beq     L24D9
L24D6:  .byte   $20
L24D7:  .byte   $64
        .byte   $25
L24D9:  lda     $02CD
        beq     L2527
        lda     $02DC
        pha
        lda     #$80
        sta     $02DC
        lda     #$5F
        jsr     L2564
        pla
        .byte   $8D
L24EE:  .byte   $DC
        .byte   $02
        lda     $02D2
        cmp     $02D1
        beq     L250B
        dec     $02D2
        sec
        lda     $35
        sbc     #$08
        sta     $35
        lda     $36
        sbc     #$00
        sta     $36
        jmp     L2525

L250B:  ldx     $02D3
        cpx     $02D0
        beq     L2527
        dex
        stx     $02D3
        lda     $02D1
        clc
        adc     $02CE
        sec
        sbc     #$01
        sta     $02D2
        .byte   $20
L2525:  .byte   $FB
        plp
L2527:  .byte   $A9
L2528:  brk
        rts

        lda     $02D1
        clc
        adc     $02CE
        cmp     $02D2
        beq     L253E
        lda     #$20
        jsr     L2564
        jmp     L2528

L253E:  lda     $02D0
        clc
        adc     $02CF
        cmp     $02D3
        beq     L254F
        inc     $02D3
        bne     L255A
L254F:  lda     $02D3
        pha
        jsr     L2776
        pla
        sta     $02D3
L255A:  lda     $02D1
        sta     $02D2
        jsr     L28FB
        .byte   $A9
L2564:  brk
        rts

        ldx     #$00
        stx     $8E
        asl     a
        rol     $8E
        asl     a
        rol     $8E
        asl     a
        rol     $8E
        sta     $8D
        clc
        lda     $CBF7
        adc     $8D
        sta     $8D
        lda     $CBF8
        adc     $8E
        sta     $8E
        lda     $02D1
        clc
        adc     $02CE
        cmp     $02D2
        bne     L259F
        lda     $8E
        pha
        lda     $8D
        pha
        jsr     L2528
        pla
        sta     $8D
        pla
        sta     $8E
L259F:  jsr     L25B1
        inc     $02D2
        clc
        lda     #$08
        adc     $35
        sta     $35
        lda     #$00
        adc     $36
        .byte   $85
L25B1:  rol     $60,x
        ldx     #$00
        ldy     #$00
        bit     $02DC
        bpl     L25BD
        dex
L25BD:  bvc     L25C0
        dey
L25C0:  stx     $40
        sty     $3F
        ldy     #$07
L25C6:  lda     ($35),y
        and     $40
        eor     ($8D),y
        eor     $3F
        sta     ($35),y
        dey
        bpl     L25C6
        lda     $35
        sta     $8D
        lda     $36
        lsr     a
        ror     $8D
        lsr     a
        ror     $8D
        lsr     a
        ror     $8D
        and     #$03
        ora     #$BC
        sta     $8E
        and     #$FB
        sta     $40
        lda     $8D
        sta     $3F
        ldy     #$00
        lda     ($8D),y
        eor     $02DA
        and     $02DB
        eor     $02DA
        sta     ($8D),y
        lda     ($3F),y
        eor     $02A5
        and     $02A6
        eor     $02A5
        .byte   $91
L260B:  .byte   $3F
        rts

        lda     $02CD
        bne     L2620
        dec     $02CD
        .byte   $4C
L2616:  .byte   $DC
        bit     $20
        .byte   $D7
        bit     $A9
        brk
        .byte   $8D
        .byte   $CD
L261F:  .byte   $02
L2620:  rts

        jsr     L23A6
        lda     #$10
        jsr     L1B59
        jsr     L23A6
        .byte   $AE
        .byte   $CF
L262E:  .byte   $02
        inx
        txa
        jsr     L266D
        lda     #$04
        .byte   $2C
L2637:  .byte   $AF
        rol     $F0,x
        ora     $AD
        .byte   $AE
        .byte   $36
L263E:  bne     L264E
        jsr     L3487
        jsr     LFFE4
        jsr     L3471
        cmp     #$00
        .byte   $F0
L264C:  .byte   $F3
        rts

L264E:  lda     #$00
        sta     $02E0
        sta     $02E1
L2656:  jsr     L3487
        jsr     LFFE4
        jsr     L3471
        cmp     #$00
        bne     L266D
        lda     $02E1
        cmp     L36AE
        bcc     L2656
        clc
        rts

L266D:  sec
        rts

        .byte   $8D
L2670:  cpy     $A902
        lda     L1D85,y
        lda     #$34
        sta     $1E
        ldx     #$08
        ldy     #$05
        lda     ($1D),y
        ldy     #$02
        sta     ($1D),y
        clc
        lda     #$10
        adc     $1D
        sta     $1D
        lda     #$00
        adc     $1E
        sta     $1E
        dex
        .byte   $D0
L2693:  inx
        rts

        ldx     $8C
        ldy     $8B
        txa
        cmp     $02D0
        bcc     L26BE
        lda     $02D0
        clc
        adc     $02CF
        cmp     $8C
        bcc     L26BE
        tya
        cmp     $02D1
        bcc     L26BE
        lda     $02D1
        clc
        adc     $02CE
        sec
        sbc     #$01
        cmp     $8B
        bcs     L26C4
L26BE:  ldy     $02D1
        ldx     $02D0
L26C4:  sty     $02D2
        stx     $02D3
        .byte   $4C
L26CB:  .byte   $FB
        plp
        lda     $02D0
        clc
        adc     $02CF
        cmp     #$17
        bcc     L26E1
        lda     #$16
        sec
        sbc     $02D0
        sta     $02CF
L26E1:  lda     $02D1
        clc
        adc     $02CE
        cmp     #$29
        bcc     L26F5
        lda     #$28
        sec
        sbc     $02D1
        .byte   $8D
        .byte   $CE
L26F4:  .byte   $02
L26F5:  rts

        cmp     $02C9
        beq     L26F5
        pha
        jsr     L23A6
        lda     $02C9
        jsr     L273D
        lda     #$CA
        sta     $1B
        lda     #$02
        sta     $1C
        lda     #$10
        sta     $02B6
        lda     #$00
        sta     $02B7
        .byte   $20
        .byte   $D9
L2719:  .byte   $33
        pla
        pha
        sta     $02C9
        jsr     L273D
        lda     #$CA
        sta     $1D
        lda     #$02
        sta     $1E
        lda     #$10
        sta     $02B6
        lda     #$00
        sta     $02B7
        jsr     L33D9
        jsr     L28FB
        jsr     L299F
L273D:  pla
        rts

        pha
        lda     #$00
        sta     $1E
        pla
        asl     a
        rol     $1E
        asl     a
        rol     $1E
        asl     a
        rol     $1E
        asl     a
        rol     $1E
        clc
        adc     #$B9
        sta     $1D
        sta     $1B
        lda     $1E
        adc     #$34
        sta     $1E
        sta     $1C
        rts

        lda     #$40
        bit     L369B
L2766:  bne     L2777
        jsr     L2400
        jsr     L28EF
        lda     $02CF
        sta     $02CC
        .byte   $20
        .byte   $3E
L2776:  plp
L2777:  rts

        lda     $02CF
        sta     $FE
        lda     $02CE
        asl     a
        asl     a
        asl     a
        sta     $02B6
        lda     #$00
        adc     #$00
        sta     $02B7
        jsr     L28EF
        lda     $35
        sta     $1B
        lda     $36
        sta     $1C
        lda     $FE
        beq     L27C4
L279C:  lda     $35
        sta     $1D
        lda     $36
        sta     $1E
        clc
        lda     #$40
        adc     $35
        sta     $35
        lda     #$01
        adc     $36
        sta     $36
        lda     $35
        sta     $1B
        lda     $36
        sta     $1C
        pha
        jsr     L33D9
        pla
        sta     $1C
        dec     $FE
        bne     L279C
L27C4:  jsr     L28D1
        lda     $02CF
        sta     $FE
        lda     $02CE
        sta     $02B6
        lda     #$00
        sta     $02B7
        lda     $02D0
        jsr     L33FE
        clc
        adc     $02D1
        sta     $1D
        tya
        adc     #$BC
        sta     $1E
        lda     $1D
        sta     $1B
        lda     $1E
        sta     $1C
        lda     $FE
        beq     L2835
L27F4:  lda     #$28
        sta     $1B
        lda     #$00
        sta     $1C
        clc
        lda     $1D
        adc     $1B
        sta     $1B
        lda     $1E
        adc     $1C
        sta     $1C
        pha
        lda     $1E
        pha
        jsr     L33D9
        lda     $1C
        and     #$FB
        sta     $1C
        lda     $1E
        and     #$FB
        sta     $1E
        jsr     L33D9
        pla
        sta     $1E
        pla
        sta     $1C
        lda     #$28
        adc     $1D
        sta     $1D
        lda     #$00
        adc     $1E
        sta     $1E
        dec     $FE
        bne     L27F4
L2835:  ldy     $02CE
        dey
        lda     #$01
        sta     $FE
        .byte   $4C
L283E:  ldx     #$28
        ldx     $02CF
        inx
        stx     $FE
        lda     #$00
        sta     $02B7
        lda     $02CE
        asl     a
        rol     $02B7
        asl     a
        rol     $02B7
        asl     a
        rol     $02B7
        sta     $02B6
        jsr     L28EF
        lda     $35
        sta     $1B
        lda     $36
        sta     $1C
L2868:  pha
        jsr     L28D1
        pla
        sta     $1C
        clc
        lda     #$40
        adc     $1B
        sta     $1B
        lda     #$01
        adc     $1C
        sta     $1C
        dec     $FE
        bne     L2868
        lda     $02CE
        sta     $FD
        ldx     $02CF
        inx
        stx     $FE
        lda     $02D1
        sta     $FB
        lda     $02D0
        jsr     L33FE
        clc
        adc     $FB
        sta     $1B
        tya
        adc     #$BC
        sta     $1C
        dec     $FD
        ldy     $FD
        tya
        pha
        lda     $1B
        sta     $1D
        lda     $1C
        and     #$FB
        sta     $1E
        lda     $02CA
L28B3:  sta     ($1B),y
        dey
        bpl     L28B3
        pla
        tay
        lda     $02D8
L28BD:  sta     ($1D),y
        dey
        bpl     L28BD
        lda     #$28
        adc     $1B
        sta     $1B
        lda     #$00
        adc     $1C
        sta     $1C
        dec     $FE
        .byte   $D0
L28D1:  bne     L2933
        ldy     #$00
        tya
        ldx     $02B7
        beq     L28E5
L28DB:  sta     ($1B),y
        iny
        bne     L28DB
        inc     $1C
        dex
        bne     L28DB
L28E5:  ldx     $02B6
        beq     L28F0
        sta     ($1B),y
        iny
        dex
        .byte   $D0
L28EF:  .byte   $FA
L28F0:  rts

        lda     $02D0
        sta     $02D3
        lda     $02D1
        .byte   $8D
L28FB:  .byte   $D2
        .byte   $02
        lda     $02D3
        jsr     L33FE
        sty     $36
        asl     a
        rol     $36
        asl     a
        rol     $36
        asl     a
        rol     $36
        sta     $35
        lda     $02D2
        asl     a
        asl     a
        asl     a
        bcc     L291B
        inc     $36
        clc
L291B:  adc     $35
        sta     $35
        lda     #$00
        adc     $36
        sta     $36
        lda     #$00
        adc     $35
        sta     $35
        lda     #$E0
        adc     $36
        .byte   $85
L2930:  rol     $60,x
        .byte   $AD
L2933:  sbc     $85CB,y
        .byte   $3F
        lda     $CBFA
        sta     $40
        ldy     #$00
        lda     ($3F),y
        tax
        lda     $CC00,x
        sta     $FF19
        iny
        lda     ($3F),y
        tax
        lda     $CC00,x
        pha
        and     #$F0
        sta     $02A5
        pla
        and     #$0F
        sta     $02DA
        iny
        lda     ($3F),y
        tax
        lda     $CC00,x
        pha
        asl     a
        asl     a
        asl     a
        asl     a
        ora     $02DA
        sta     $02DA
        pla
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        ora     $02A5
        sta     $02A5
        lda     #$00
        sta     $02DB
        sta     $02A6
        lda     $02DB
        sta     $02CB
        lda     $02DA
        sta     $02CA
        lda     $02A6
        sta     $02D9
        lda     $02A5
        sta     $02D8
        lda     $02DC
        sta     $02D4
        rts

        .byte   $20
L299F:  ldx     $23
        lda     $02CB
        sta     $02DB
        lda     $02CA
        sta     $02DA
        lda     $02D9
        sta     $02A6
        lda     $02D8
        sta     $02A5
        lda     $02D4
        .byte   $8D
        .byte   $DC
L29BE:  .byte   $02
        rts

        ldy     $388A
        sty     $8D
        ldy     $388B
        sty     $8E
        jmp     L29F0

L29CD:  lda     $FB
        ldy     $388C
        sty     $8D
        ldy     $388D
        sty     $8E
        .byte   $4C
L29DA:  beq     L2A05
        ldy     $3892
        sty     $8D
        ldy     $3893
        sty     $8E
        jsr     L29F0
        lda     $FB
        sta     $41
        lda     $FC
        .byte   $85
L29F0:  .byte   $42
        rts

        asl     a
        php
        clc
        adc     $8D
        sta     $8D
        lda     #$00
        tay
        adc     $8E
        plp
        adc     #$00
        sta     $8E
        lda     ($8D),y
L2A05:  sta     $FB
        iny
        lda     ($8D),y
        .byte   $85
L2A0B:  .byte   $FC
        rts

        lda     L369B
        and     #$20
        bne     L2A52
        jsr     L2ACB
        lda     ($FB,x)
        bmi     L2A56
        jsr     L2A66
        lda     #$08
        bit     L369B
        beq     L2A31
        lda     $02DA
        and     #$0F
        tay
        lda     $CC00,y
        sta     $FF19
L2A31:  lda     $02AA
        bmi     L2A39
        jsr     L2A54
L2A39:  lda     #$10
        bit     L369B
        beq     L2A4C
        lda     #$00
        sta     $EF
L2A44:  lda     $EF
        beq     L2A44
        lda     #$00
        sta     $EF
L2A4C:  lda     $02C2
        sta     $FF19
L2A52:  .byte   $20
        .byte   $9F
L2A54:  and     #$60
L2A56:  jsr     L2E1D
        lda     #$00
        sta     $02F6
        sta     $02FB
        sta     $02F9
        .byte   $20
        .byte   $0B
L2A66:  .byte   $2B
        rts

        tya
        pha
        lda     $02CA
        pha
        lda     $02CB
        pha
        lda     $02D8
        pha
        lda     $02D9
        pha
        ldy     #$01
        lda     ($FB),y
        sta     $02CA
        lda     #$00
        sta     $02CB
        iny
        lda     ($FB),y
        sta     $02D0
        iny
        lda     ($FB),y
        sta     $02D1
        iny
        lda     ($FB),y
        sec
        sbc     #$01
        sta     $02CF
        iny
        lda     ($FB),y
        sta     $02CE
        jsr     L26CB
        jsr     L299F
        jsr     L2766
        lda     $FF19
        sta     $02C2
        pla
        sta     $02D9
        pla
        sta     $02D8
        pla
        sta     $02CB
        pla
        sta     $02CA
        lda     #$00
        sta     $22
        sta     $23
        sta     $24
        sta     $25
        pla
L2ACB:  tay
        rts

        ldx     #$00
        stx     $FC
        tya
        asl     a
        php
        pha
        rol     $FC
        asl     a
        rol     $FC
        sta     $FB
        pla
        clc
        adc     $FB
        sta     $FB
        bcc     L2AE6
        inc     $FC
L2AE6:  plp
        bcc     L2AEB
        inc     $FC
L2AEB:  clc
        lda     $CBF3
        adc     $FB
        sta     $FB
        lda     $CBF4
        adc     $FC
        .byte   $85
L2AF9:  .byte   $FC
        rts

        lda     #$03
L2AFD:  bne     L2B01
L2AFF:  lda     #$01
L2B01:  sta     $02F7
        clc
        adc     $19
        sta     $19
        bcc     L2B0D
L2B0B:  inc     $1A
L2B0D:  ldy     #$00
        lda     ($19),y
        and     #$07
        asl     a
        tax
        lda     L2B1D,x
        pha
        lda     L2B1C,x
L2B1C:  pha
L2B1D:  rts

        .byte   $2B
        .byte   $2B
        lsr     $C82B
        .byte   $2B
        adc     $E92B,y
        .byte   $2B
        bpl     L2B56
        sec
        bit     L2CDD
        lda     ($19),y
        asl     a
        bcs     L2B46
        sta     $FB
        lda     $02DA
        eor     $FB
        and     #$0F
        eor     $FB
        sta     $02DA
        lda     #$0F
        jmp     L2B66

L2B46:  lda     $02DB
        ora     #$F0
        sta     $02DB
        jmp     L2AFD

        lda     ($19),y
        bmi     L2B71
        lsr     a
L2B56:  lsr     a
        lsr     a
        sta     $FB
        lda     $02DA
        eor     $FB
        and     #$F0
        eor     $FB
        sta     $02DA
L2B66:  lda     #$F0
        and     $02DB
        sta     $02DB
        jmp     L2AFD

L2B71:  lda     $02DB
        ora     #$0F
        sta     $02DB
        jmp     L2AFD

        lda     $02FA
        cmp     #$0A
        bne     L2B90
        lda     #$00
        sta     $02F6
        sta     $02FB
        ldx     #$03
        jmp     L0845

L2B90:  cmp     #$00
        bne     L2B9E
        lda     $19
        sta     $02F8
        lda     $1A
        sta     $02F9
L2B9E:  inc     $02FA
        lda     $1A
        pha
        lda     $19
        pha
        lda     $02F6
        ora     $02FB
        pha
        lda     ($19),y
        lsr     a
        lsr     a
        lsr     a
        and     #$07
        sta     $02F6
        lda     $02FB
        eor     ($19),y
        and     #$C0
        sta     $02FB
        iny
        lda     ($19),y
        jsr     L2E1E
        jmp     L2B0B

        lda     $02FA
        beq     L2BEB
        pla
        pha
        and     #$07
        sta     $02F6
        pla
        and     #$C0
        sta     $02FB
        pla
        sta     $19
        pla
        sta     $1A
        dec     $02FA
        lda     #$02
        jmp     L2AFF

L2BEB:  rts

        lda     ($19),y
        sta     $02DC
        jsr     L2E42
        lda     $8B
        sta     $22
        lda     $8C
        sta     $23
        lda     $FB
        sta     $24
        lda     $FC
        sta     $25
        lda     $02DC
        and     #$C0
        cmp     #$C0
        beq     L2C10
        jsr     L314D
L2C10:  jmp     L2AF9

        lda     ($19),y
        and     #$C0
        cmp     #$C0
        beq     L2C35
        sta     $02DC
        jsr     L2DAF
        iny
        ldx     #$01
        bit     $02FC
        bpl     L2C2B
        ldx     #$FF
L2C2B:  bvc     L2C2F
        ldy     #$FF
L2C2F:  jsr     L308B
        jmp     L2AF9

L2C35:  jsr     L2D69
        jmp     L2AF9

        lda     $23
        pha
        lda     $22
        pha
        lda     $25
        pha
        lda     $24
        pha
        jsr     L2D69
        lda     ($19),y
        bmi     L2C6C
        lda     #$62
        sta     $FB
        sta     $8B
        lda     #$2C
        sta     $FC
        sta     $8C
        lda     #$00
        jsr     L2E66
        ldy     #$03
        jmp     L2C89

        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
L2C6C:  ldy     #$03
        lda     ($19),y
        ldy     #$00
        jsr     L2C99
        lda     $FB
        sta     $8B
        lda     $FC
        sta     $8C
        lda     ($19),y
        and     #$40
        beq     L2C85
        ldy     #$FF
L2C85:  tya
        jsr     L2E66
L2C89:  ldy     #$04
        pla
        sta     $24
        pla
        sta     $25
        pla
        sta     $22
        pla
        sta     $23
        tya
        .byte   $4C
L2C99:  .byte   $FF
        rol     a
        sty     $FC
        asl     a
        rol     $FC
        asl     a
        rol     $FC
        asl     a
        rol     $FC
        adc     $CBF7
        sta     $FB
        lda     $CBF8
        adc     $FC
        sta     $FC
        rts

L2CB3:  asl     a
        and     #$C0
        sta     $02DC
        iny
        lda     ($19),y
        sta     $02D3
        iny
        lda     ($19),y
        sta     $02D2
        iny
        lda     ($19),y
        pha
        jsr     L28FB
        ldy     #$00
        pla
        jsr     L2C99
        sta     $8E
        lda     $FB
        sta     $8D
        jsr     L25B1
        lda     #$04
L2CDD:  jmp     L2AFF

        lda     ($19),y
        bpl     L2CB3
        lda     #$00
        sta     $8C
        iny
        lda     ($19),y
        sta     $8B
        asl     $8B
        rol     $8C
        asl     $8B
        rol     $8C
        asl     $8B
        rol     $8C
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        asl     $8B
        rol     $8C
        asl     $8B
        rol     $8C
        clc
        lda     $8B
        adc     $FB
        sta     $FB
        lda     $8C
        adc     $FC
        sta     $FC
        iny
        lda     ($19),y
        clc
        adc     $FB
        sta     $FB
        lda     #$00
        adc     $FC
        sta     $FC
        clc
        lda     #$00
        adc     $FB
        sta     $FB
        lda     #$BC
        adc     $FC
        sta     $FC
        iny
        lda     ($19),y
        tax
        iny
L2D36:  lda     ($19),y
L2D38:  pha
        tay
        lda     ($FB),y
        eor     $02DA
        and     $02DB
        eor     $02DA
        sta     ($FB),y
        cpy     #$00
        beq     L2D4F
        dey
        jmp     L2D38

L2D4F:  cpx     #$00
        beq     L2D65
        dex
        clc
        lda     #$28
        adc     $FB
        sta     $FB
        lda     #$00
        adc     $FC
        sta     $FC
        pla
        jmp     L2D36

L2D65:  pla
        lda     #$05
        .byte   $4C
L2D69:  .byte   $FF
        rol     a
        jsr     L2DAF
        bit     $02FC
        bpl     L2D83
        sec
        lda     $22
        sbc     $8B
        sta     $22
        lda     $23
        sbc     $8C
        sta     $23
        jmp     L2D8E

L2D83:  clc
        lda     $8B
        adc     $22
        sta     $22
        lda     $8C
        adc     $23
L2D8E:  sta     $23
        bit     $02FC
        bvc     L2DA3
        sec
        lda     $24
        sbc     $FB
        sta     $24
        lda     $25
        sbc     $FC
        sta     $25
        rts

L2DA3:  clc
        lda     $FB
        adc     $24
        sta     $24
        lda     $FC
        adc     $25
        .byte   $85
L2DAF:  and     $60
        jsr     L2E42
        lda     $02F6
        beq     L2E05
        lda     #$00
        sta     $8D
        lda     #$00
        sta     $8E
        ldy     $02F6
L2DC4:  clc
        lda     $8B
        adc     $8D
        sta     $8D
        lda     $8C
        adc     $8E
        sta     $8E
        dey
        bne     L2DC4
        jsr     L2E10
        lda     $8D
        sta     $8B
        lda     $8E
        sta     $8C
        lda     #$00
        sta     $8D
        lda     #$00
        sta     $8E
        ldy     $02F6
L2DEA:  clc
        lda     $FB
        adc     $8D
        sta     $8D
        lda     $FC
        adc     $8E
        sta     $8E
        dey
        bne     L2DEA
        jsr     L2E10
        lda     $8D
        sta     $FB
        .byte   $A5
L2E02:  stx     $FC85
L2E05:  ldy     #$00
        lda     ($19),y
        asl     a
        asl     a
        eor     $02FB
        .byte   $8D
        .byte   $FC
L2E10:  .byte   $02
        rts

        lsr     $8E
        ror     $8D
        lsr     $8E
        ror     $8D
        lsr     $8E
        .byte   $66
L2E1D:  .byte   $8D
L2E1E:  rts

        tya
        asl     a
        php
        clc
        adc     $CBF1
        sta     $19
        lda     $CBF2
        adc     #$00
        plp
        adc     #$00
        sta     $1A
        tya
        pha
        ldy     #$00
        lda     ($19),y
        pha
        iny
        lda     ($19),y
        sta     $1A
        pla
        sta     $19
        pla
L2E42:  tay
        rts

        lda     #$00
        sta     $FC
        tay
        lda     ($19),y
        lsr     a
        lsr     a
        lsr     a
        and     #$01
        sta     $8C
        iny
        lda     ($19),y
        sta     $8B
        iny
        lda     ($19),y
        sta     $FB
        rts

        pha
        jsr     L3471
        pla
        jsr     L2E66
        .byte   $4C
L2E66:  .byte   $87
        .byte   $34
        tsx
        stx     $02FD
        sta     $8E
        ldy     #$00
        sty     $8D
L2E72:  lda     ($8B),y
        ora     ($FB),y
        eor     $8E
        sta     $D000,y
        iny
        cpy     #$08
        bne     L2E72
        lda     $22
        sta     $02F2
        lda     $23
        sta     $02F3
        lda     $24
        sta     $02F4
        lda     $25
        sta     $02F5
        ldx     $02F1
        inx
        ldy     #$00
        lda     #$08
        sta     $FB
        lda     #$D0
        sta     $FC
        lda     #$FF
L2EA4:  sta     ($FB),y
        inc     $FB
        bne     L2EAC
        inc     $FC
L2EAC:  sta     ($FB),y
        inc     $FB
        bne     L2EB4
        inc     $FC
L2EB4:  dex
        bne     L2EA4
        sta     ($FB),y
        inc     $FB
        bne     L2EBF
        inc     $FC
L2EBF:  lda     #$7F
        sta     ($FB),y
        sta     $D009
        jsr     L3135
        beq     L2ECE
        jmp     L3086

L2ECE:  lda     #$FF
        pha
        clc
        ror     $8E
        lda     $8D
        and     #$BF
        sta     $8D
        lda     $24
        asl     a
        php
        clc
        adc     #$08
        sta     $0D
        lda     #$D0
        adc     #$00
        plp
        adc     #$00
        sta     $0E
        lda     $24
        jsr     L319C
        lda     L3145,x
        eor     #$FF
        sta     $40
        tya
        pha
        clc
        adc     $FB
        sta     $8B
        lda     $FC
        adc     #$00
        sta     $8C
        bit     $8D
        bpl     L2F10
        dec     $24
        ldy     #$00
        jmp     L2F12

L2F10:  inc     $24
L2F12:  ldy     #$04
        lda     ($0D),y
        sta     $FD
        iny
        lda     ($0D),y
        sta     $FE
        lda     $24
        jsr     L319C
        tya
        clc
        adc     $FB
        sta     $3D
        lda     $FC
        adc     #$00
        sta     $3E
        pla
        tax
        lda     $D000,x
        sta     $3F
        ldy     #$00
L2F37:  lsr     $40
        bcc     L2F57
        ror     $40
        clc
        lda     #$08
        adc     $3D
        sta     $3D
        lda     #$00
        adc     $3E
        sta     $3E
        clc
        lda     #$08
        adc     $8B
        sta     $8B
        lda     #$00
        adc     $8C
        sta     $8C
L2F57:  inc     $22
        bne     L2F5D
        inc     $23
L2F5D:  lda     $22
        cmp     #$40
        lda     $23
        sbc     #$01
        beq     L2F6D
        lda     ($8B),y
        and     $40
        beq     L2F37
L2F6D:  sec
        lda     $22
        sbc     #$01
        sta     $22
        lda     $23
        sbc     #$00
        sta     $23
        ldy     #$02
        lda     $22
        sta     ($0D),y
        iny
        lda     $23
        sta     ($0D),y
        ldy     #$00
        jmp     L2FF8

L2F8A:  .byte   $4C
L2F8B:  jmp     $B130

        .byte   $8B
        and     $40
        bne     L2F8A
        lda     $3F
        and     $40
        ora     ($8B),y
        sta     ($8B),y
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        jsr     L3165
        bit     $8D
        bvs     L2FBE
        bit     $FE
        bmi     L2FC1
        lda     $FD
        cmp     $22
        lda     $FE
        sbc     $23
        bcc     L2FC1
        lda     $8D
        ora     #$40
        sta     $8D
L2FBE:  jmp     L2FE9

L2FC1:  lda     ($3D),y
        and     $40
        clc
        bne     L2FC9
        sec
L2FC9:  bit     $8E
        bmi     L2FE6
        bcc     L2FEB
        tsx
        cpx     #$12
        bcs     L2FD7
        jmp     L305C

L2FD7:  lda     $23
        pha
        lda     $22
        pha
        lda     $24
        pha
        sec
        ror     $8E
        jmp     L2FE9

L2FE6:  bcs     L2FEB
        clc
L2FE9:  ror     $8E
L2FEB:  sec
        lda     $22
        sbc     #$01
        sta     $22
        lda     $23
        sbc     #$00
        sta     $23
L2FF8:  bcc     L304E
        asl     $40
        bcs     L3001
L2FFE:  jmp     L2F8B

L3001:  rol     $40
        sec
        lda     $3D
        sbc     #$08
        sta     $3D
        lda     $3E
        sbc     #$00
        sta     $3E
        sec
        lda     $8B
        sbc     #$08
        sta     $8B
        lda     $8C
        sbc     #$00
        sta     $8C
        lda     ($8B),y
        bne     L2FFE
        bit     $8D
        bvs     L302D
        lda     ($3D),y
        bne     L2FFE
        bit     $8E
        bpl     L2FFE
L302D:  lda     $3F
        sta     ($8B),y
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        jsr     L3165
        sec
        lda     $22
        sbc     #$08
        sta     $22
        lda     $23
        sbc     #$00
        sta     $23
        bcc     L304E
        .byte   $4C
L304C:  ora     ($30,x)
L304E:  pla
        cmp     #$FF
        beq     L305E
        sta     $24
        pla
        sta     $22
        pla
        sta     $23
        .byte   $4C
L305C:  .byte   $CF
        .byte   $2E
L305E:  lda     $02F2
        sta     $22
        lda     $02F3
        sta     $23
        lda     $02F4
        sta     $24
        lda     $02F5
        sta     $25
        ldx     $02FD
        txs
        bit     $8D
        bmi     L3088
        dec     $24
        lda     $24
        cmp     #$FF
        beq     L3088
        sec
        ror     $8D
        .byte   $4C
L3086:  cpy     $2E
L3088:  ldx     $02FD
L308B:  txs
L308C:  rts

        stx     $8D
        sty     $8E
        lda     $8B
        cmp     $FB
        lda     $8C
        sbc     $FC
        bcs     L30AC
        lda     #$00
        sta     $3F
        sty     $40
        lda     $FB
        sta     $FD
        lda     $FC
        sta     $FE
        jmp     L30CA

L30AC:  lda     $8B
        ora     $8C
        ora     $FB
        ora     $FC
        beq     L308C
        lda     #$00
        sta     $40
        stx     $3F
        lda     $8B
        sta     $FD
        lda     $8C
        sta     $FE
        lda     $FB
        sta     $8B
        lda     $FC
L30CA:  sta     $8C
        lda     $FE
        lsr     a
        sta     $1C
        lda     $FD
        ror     a
        sta     $1B
        lda     #$00
        sec
        sbc     $FD
        sta     $1D
        lda     #$00
        sbc     $FE
        sta     $1E
L30E3:  jsr     L314D
        clc
        lda     $8B
        adc     $1B
        sta     $1B
        lda     $8C
        adc     $1C
        sta     $1C
        sec
        lda     $1B
        sbc     $FD
        tax
        lda     $1C
        sbc     $FE
        bcc     L310A
        sta     $1C
        stx     $1B
        ldy     $8E
        ldx     $8D
        jmp     L310C

L310A:  ldy     $40
L310C:  ldx     $3F
        txa
        beq     L311E
        bmi     L3114
        dex
L3114:  clc
        adc     $22
        sta     $22
        txa
        adc     $23
        sta     $23
L311E:  tya
        beq     L312E
        bmi     L3124
        dey
L3124:  clc
        adc     $24
        sta     $24
        tya
        adc     $25
        sta     $25
L312E:  inc     $1D
        bne     L30E3
        inc     $1E
        .byte   $D0
L3135:  lda     L2060
        dey
        and     ($90),y
        .byte   $03
        lda     #$FF
        rts

        lda     L3145,x
        eor     #$FF
        .byte   $31
L3145:  .byte   $FB
        rts

        .byte   $7F
        .byte   $BF
        .byte   $DF
        .byte   $EF
        .byte   $F7
        .byte   $FB
L314D:  sbc     L20FE,x
        dey
        and     ($B0),y
        .byte   $33
        lda     ($FB),y
        bit     $02DC
        bmi     L315E
        and     L3145,x
L315E:  bvs     L3165
        eor     L3145,x
        eor     #$FF
L3165:  sta     ($FB),y
        lda     $FC
        lsr     a
        ror     $FB
        lsr     a
        ror     $FB
        lsr     a
        ror     $FB
        and     #$03
        ora     #$BC
        sta     $FC
        ldy     #$00
        lda     ($FB),y
        eor     $02DA
        and     $02DB
        eor     $02DA
        sta     ($FB),y
        rts

L3188:  sec
        rts

        lda     $22
        cmp     #$40
        lda     $23
        sbc     #$01
        bcs     L3188
        lda     $25
        bne     L3188
        lda     $24
        cmp     #$C0
L319C:  bcs     L3188
        and     #$F8
        asl     a
        rol     $25
        asl     a
        rol     $25
        asl     a
        rol     $25
        tay
        adc     #$00
        sta     $FB
        lda     $25
        adc     #$E0
        sta     $FC
        tya
        asl     a
        rol     $25
        asl     a
        rol     $25
        adc     $FB
        sta     $FB
        lda     $25
        adc     $FC
        sta     $FC
        lda     $22
        and     #$F8
        adc     $FB
        sta     $FB
        lda     $23
        adc     $FC
        sta     $FC
        ldy     #$00
        sty     $25
        lda     $24
        and     #$07
        tay
        lda     $22
        and     #$07
        tax
        rts

        pha
        txa
        pha
        tya
        pha
        bit     $02DD
        bvs     L3217
        inc     $02E0
        lda     $02E0
        cmp     #$40
        bne     L31FE
        inc     $02E1
        lda     #$00
        sta     $02E0
L31FE:  lda     $02DD
        ora     #$40
        sta     $02DD
        lda     $02F1
        jsr     L323F
        jsr     L081F
        bit     $02DD
        bmi     L322A
        jmp     (L02DE)

L3217:  lda     $02DD
        and     #$BF
        sta     $02DD
        lda     #$00
        sta     $02E2
        lda     $FF09
        sta     $FF09
L322A:  lda     $FF13
        pha
        sta     $FF3E
        jsr     LDB11
        pla
        lsr     a
        bcs     L323B
        sta     $FF3F
L323B:  pla
        tay
        pla
        tax
L323F:  pla
        rti

        sta     $FF0B
        lda     #$02
        sta     $FF0A
        lda     $FF09
        .byte   $8D
        .byte   $09
L324E:  .byte   $FF
        rts

        php
        pha
        sei
        lda     #$E5
        sta     $0314
        lda     #$31
        sta     $0315
        lda     #$00
        sta     $02DD
        jsr     L323F
        pla
L3266:  plp
        rts

        php
        pha
        sei
        lda     L02DE
        sta     $0314
        lda     $02DF
        sta     $0315
        pla
L3278:  plp
        rts

        lda     #$02
        sta     $02B2
        jsr     LFFE7
        lda     #$00
        sta     $3E
        jsr     LFFBD
        lda     #$0F
        ldx     #$08
        tay
        jsr     LFFBA
        jsr     LFFC0
        bcs     L32DD
        jsr     L32E6
        bcc     L32DD
        ldx     #$0F
        jsr     LFFC6
L32A0:  bcs     L32DD
L32A2:  jsr     LFFCF
        bcs     L32DD
        pha
        jsr     L32E6
        pla
        bcc     L32DD
        pha
        sei
        sta     $FF3F
        jsr     L2249
        sta     $FF3E
        cli
        pla
        cmp     #$0D
        beq     L32E2
        ldx     $02B2
        dex
        bmi     L32A2
        stx     $02B2
        sec
        sbc     #$30
        sta     $3D
        lda     $3E
        asl     a
        sta     $3E
        asl     a
        asl     a
        adc     $3E
        adc     $3D
        sta     $3E
        jmp     L32A0

L32DD:  ldx     #$64
        jmp     L0845

L32E2:  jsr     LFFE7
        .byte   $A5
L32E6:  rol     L2060,x
        .byte   $B7
        .byte   $FF
        .byte   $C9
L32EC:  brk
        rts

L32EE:  cmp     #$00
        beq     L32FC
        tay
        cmp     #$01
        beq     L3321
        ldy     #$08
        jmp     L331F

L32FC:  lda     #$3E
        jsr     L1F96
        ldx     #$00
        lda     ($FB,x)
        pha
        lda     #$36
        jsr     L29DA
        pla
        eor     #$FF
        ldy     #$01
        cmp     ($FB,x)
        beq     L3321
        pha
        lda     #$37
        jsr     L29DA
        pla
        .byte   $A0
L331C:  php
        cmp     ($FB,x)
L331F:  bne     L32EE
L3321:  sty     $02B0
        lda     #$3C
        jsr     L1F96
        ldy     #$07
        ldx     #$01
        stx     $02B1
        dex
L3331:  lda     ($FB,x)
        sta     $02B2
        tya
        sta     ($FB,x)
        lda     $02B2
        cmp     #$0D
        beq     L3358
        cmp     #$41
        bcc     L3347
        clc
        adc     #$80
L3347:  tay
        jsr     L33AA
        inc     $02B1
        lda     $02B1
        cmp     #$11
        bne     L3331
        dec     $02B1
L3358:  lda     $02B0
        cmp     #$01
        bne     L337F
        lda     #$3D
        jsr     L1B59
L3364:  ldy     #$00
        jsr     LFFE1
        bne     L3371
        lda     #$00
        sta     $02B0
        rts

L3371:  lda     $01
        and     #$10
        bne     L3364
        ldx     #$00
L3379:  dex
        bne     L3379
        dey
        bne     L3371
L337F:  jsr     L3266
L3382:  sec
        rts

        lda     #$7E
        sta     $FB
        lda     #$36
        sta     $FC
        lda     #$FE
        sta     $FE
        lda     #$00
        sta     $FD
        tax
        sta     $387F
L3398:  clc
        adc     ($FB,x)
        bcc     L33A0
        inc     $387F
L33A0:  jsr     L33AA
        jsr     L33B1
        bne     L3398
        .byte   $8D
        .byte   $7E
L33AA:  sec
        rts

        inc     $FB
        bne     L33C0
        .byte   $E6
L33B1:  .byte   $FC
        rts

        inc     $FD
        bne     L33C0
        .byte   $E6
L33B8:  inc     $E660,x
        .byte   $8B
        bne     L33C0
        .byte   $E6
L33BF:  .byte   $8C
L33C0:  rts

        pha
        dec     $FD
        lda     $FD
        cmp     #$FF
        bne     L33CC
        dec     $FE
L33CC:  pla
        rts

        pha
        dec     $FB
        lda     $FB
        cmp     #$FF
        bne     L33D9
        dec     $FC
L33D9:  pla
        rts

        ldx     $02B7
        beq     L33F0
        ldy     #$00
L33E2:  lda     ($1B),y
        sta     ($1D),y
        iny
        bne     L33E2
        inc     $1C
        inc     $1E
        dex
        bne     L33E2
L33F0:  ldx     $02B6
        beq     L33FF
        ldy     #$00
        lda     ($1B),y
        sta     ($1D),y
        iny
        dex
        .byte   $D0
L33FE:  sed
L33FF:  rts

        asl     a
        tax
        lda     L3407,x
        .byte   $BC
        php
L3407:  .byte   $34
        rts

        brk
        brk
        plp
        brk
        bvc     L340F
L340F:  sei
        brk
        ldy     #$00
        iny
        brk
        beq     L3417
L3417:  clc
        ora     ($40,x)
        ora     ($68,x)
        ora     ($90,x)
        ora     ($B8,x)
        ora     ($E0,x)
        ora     ($08,x)
        .byte   $02
        bmi     L3429
        cli
        .byte   $02
L3429:  .byte   $80
        .byte   $02
        tay
        .byte   $02
        bne     L3431
        sed
        .byte   $02
L3431:  jsr     L4803
        .byte   $03
        bvs     L343A
        tya
        .byte   $03
        .byte   $C0
L343A:  .byte   $03
        inx
        .byte   $03
        sei
        lda     #$0B
        sta     $FF06
        sta     $FF3E
        lda     #$00
        sta     $FB
        lda     #$10
        sta     $FC
        ldy     #$34
        jsr     L3461
        lda     #$71
        sta     $FB
        lda     #$34
        sta     $FC
        ldy     #$FD
        jsr     L3461
        .byte   $6C
L3461:  .byte   $FC
        .byte   $FF
        lda     #$00
        tax
        sta     ($FB,x)
        inc     $FB
        bne     L346E
        inc     $FC
L346E:  cpy     $FC
        .byte   $D0
L3471:  sbc     ($60),y
        php
        sei
        pha
        lda     $02DD
        ora     #$80
        sta     $02DD
        sta     $FF3F
        lda     #$3B
        sta     $FF06
        pla
L3487:  plp
        rts

        php
        sei
        pha
        lda     #$CC
L348E:  cmp     $FF1D
        bne     L348E
L3493:  cmp     $FF1D
        beq     L3493
        sta     $FF3E
        lda     $02DD
        and     #$7F
        sta     $02DD
        lda     #$0B
        sta     $FF06
        pla
L34A9:  plp
        rts

        bpl     L34AD
L34AD:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L34BD
L34BD:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L34CD
L34CD:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L34DD
L34DD:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L34ED
L34ED:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L34FD
L34FD:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L350D
L350D:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L351D
L351D:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        bpl     L352D
L352D:  asl     L0000,x
        plp
        asl     L0000,x
        brk
        brk
L3534:  brk
        brk
        rti

        brk
        brk
        .byte   $07
        brk
        .byte   $12
        brk
        .byte   $03
        brk
        bpl     L3544
        brk
        brk
        brk
L3544:  brk
        brk
        rti

        brk
        brk
        .byte   $37
        brk
        lda     $BAAD,x
        ldx     $F5B4,y
        ldx     $D0,y
        bcs     L3534
        tsx
        sta     $908D
        sta     $F5DF
        clv
        .byte   $9E
        .byte   $92
        txs
        .byte   $DF
        tsx
        sta     $908D
        sta     $F5DF
        .byte   $DF
        stx     $91,y
L356B:  .byte   $DF
        sbc     $20,x
        txa
        .byte   $FF
        jsr     LFF84
        lda     #$00
        tay
L3576:  sta     $02A7,y
        iny
        cpy     #$59
        bne     L3576
        jsr     LFF90
        php
        sei
        lda     #$E0
        sta     $FFFE
        lda     #$31
        sta     $FFFF
        lda     $0315
        cmp     #$31
        beq     L359D
        sta     $02DF
        lda     $0314
        sta     L02DE
L359D:  ldy     #$00
        lda     #$00
        sta     $FB
        lda     #$B8
        sta     $FC
        tya
L35A8:  sta     ($FB),y
        jsr     L33AA
        ldx     $FC
        cpx     #$C0
        bne     L35A8
        lda     #$A2
        sta     $FB
        lda     #$38
        sta     $FC
        lda     #$19
        sta     $8B
        lda     #$08
        sta     $8C
        ldy     #$03
        ldx     #$00
L35C7:  lda     ($FB,x)
        sta     $FD
        jsr     L33AA
        lda     ($FB,x)
        sta     $FE
        ora     $FD
        beq     L35EE
        lda     #$4C
        sta     ($8B,x)
        jsr     L33B8
        lda     $FD
        sta     ($8B,x)
        .byte   $20
        clv
L35E3:  .byte   $33
        lda     $FE
        sta     ($8B,x)
        jsr     L33B8
        jmp     L35F9

L35EE:  clc
        lda     #$03
        adc     $8B
        sta     $8B
        lda     #$00
        adc     $8C
L35F9:  sta     $8C
        jsr     L33AA
        dey
        bne     L35C7
        plp
        lda     #$B8
        sta     $FF14
        lda     #$38
        sta     $FF12
        lda     $02A9
        and     #$FB
        sta     $02A9
        lda     $3888
        ora     $3889
        beq     L3624
        lda     $02A9
        ora     #$04
        sta     $02A9
L3624:  lda     #$D2
        sta     $02F1
        ldx     #$00
L362B:  lda     L3635,x
        sta     $CC00,x
        inx
        bne     L362B
        .byte   $4C
L3635:  .byte   $F3
        php
        brk
        adc     ($32),y
        .byte   $43
        .byte   $34
        eor     $16
        .byte   $67
        sec
        ora     #$42
        and     ($41,x)
        adc     $4E
        eor     ($07),y
        brk
        bit     L0000
        rti

        brk
        .byte   $5B
        brk
        ror     L0000,x
        bcc     L3653
L3653:  lda     #$00
        cmp     (L0000,x)
        cmp     $F000,y
        brk
        asl     $01
        .byte   $1C
        ora     ($31,x)
        ora     ($45,x)
        ora     ($59,x)
        ora     ($6D,x)
        ora     ($7F,x)
        ora     ($92,x)
        ora     ($A3,x)
        ora     ($B5,x)
        ora     ($C5,x)
        ora     ($D6,x)
        ora     ($E5,x)
        ora     ($F5,x)
        ora     ($04,x)
        .byte   $02
        .byte   $12
        .byte   $02
        jsr     L2E02
L367E:  .byte   $02
L367F:  .byte   $3B
        .byte   $02
        pha
        .byte   $02
        .byte   $54
        .byte   $02
        adc     ($02,x)
        jmp     (L7802)

        .byte   $02
        .byte   $83
        .byte   $02
        stx     $9802
        .byte   $02
        .byte   $A3
        .byte   $02
        lda     $B602
        .byte   $02
        cpy     #$02
        cmp     #$02
L369B:  .byte   $D2
        .byte   $02
        .byte   $DA
        .byte   $02
L369F:  .byte   $E3
L36A0:  .byte   $02
L36A1:  .byte   $EB
L36A2:  .byte   $02
L36A3:  .byte   $F3
L36A4:  .byte   $02
        .byte   $FA
        .byte   $02
L36A7:  .byte   $02
L36A8:  .byte   $03
L36A9:  .byte   $09
L36AA:  .byte   $03
L36AB:  .byte   $10
L36AC:  .byte   $03
L36AD:  .byte   $17
L36AE:  .byte   $03
L36AF:  .byte   $1E
L36B0:  .byte   $03
L36B1:  .byte   $24
L36B2:  .byte   $03
L36B3:  rol     a
L36B4:  .byte   $03
L36B5:  .byte   $30
L36B6:  .byte   $03
L36B7:  .byte   $36
L36B8:  .byte   $03
L36B9:  .byte   $3C
L36BA:  .byte   $03
        .byte   $42
        .byte   $03
        .byte   $47
        .byte   $03
        jmp     L5103

        .byte   $03
        lsr     $03,x
        .byte   $5B
        .byte   $03
        rts

        .byte   $03
        .byte   $64
        .byte   $03
        adc     #$03
        adc     $7103
        .byte   $03
        adc     $03,x
        adc     $7D03,y
        .byte   $03
        sta     ($03,x)
        sta     $03
        dey
        .byte   $03
        .byte   $8B
        .byte   $03
        .byte   $8F
        .byte   $03
        .byte   $92
        .byte   $03
        sta     $03,x
        tya
        .byte   $03
        .byte   $9B
        .byte   $03
        .byte   $9E
        .byte   $03
        lda     ($03,x)
        .byte   $A3
        .byte   $03
        ldx     $03
        lda     #$03
        .byte   $AB
        .byte   $03
        ldx     $B003
        .byte   $03
        .byte   $B2
        .byte   $03
        ldy     $03,x
        .byte   $B7
        .byte   $03
        lda     $BB03,y
        .byte   $03
        lda     $BF03,x
        .byte   $03
        cpy     #$03
        .byte   $C2
        .byte   $03
        cpy     $03
        dec     $03
        .byte   $C7
        .byte   $03
        cmp     #$03
        .byte   $CB
        .byte   $03
        cpy     $CE03
        .byte   $03
        .byte   $CF
        .byte   $03
        bne     L3720
        .byte   $D2
        .byte   $03
        .byte   $D3
L3720:  .byte   $03
        .byte   $D4
        .byte   $03
        dec     $03,x
        .byte   $D7
        .byte   $03
        cld
        .byte   $03
        cmp     $DA03,y
        .byte   $03
        .byte   $DB
        .byte   $03
        .byte   $DC
        .byte   $03
        cmp     $DE03,x
        .byte   $03
        .byte   $DF
        .byte   $03
        cpx     #$03
        sbc     ($03,x)
        .byte   $E2
        .byte   $03
        .byte   $E3
        .byte   $03
        .byte   $FF
        .byte   $03
