; da65 V2.18 - Ubuntu 2.19-1
; Created:    2026-08-19 12:12:43
; Input file: preservation_corpus/extracted/depth1_a05bba25_JABATO P.1
; Page:       1


        .setcpu "6502"

L0060           := $0060
L00F9           := $00F9
L0116           := $0116
L01BA           := $01BA
L0200           := $0200
L0211           := $0211
L0216           := $0216
L0223           := $0223
L0225           := $0225
L0226           := $0226
L022F           := $022F
L0236           := $0236
L02A6           := $02A6
L0353           := $0353
L036E           := $036E
L04A4           := $04A4
L0502           := $0502
L0610           := $0610
L06E3           := $06E3
L8F03           := $8F03
L90EC           := $90EC
L910D           := $910D
L9158           := $9158
L920B           := $920B
L9219           := $9219
L928D           := $928D
L936F           := $936F
L9428           := $9428
L947C           := $947C
L97CF           := $97CF
L9919           := $9919
L9956           := $9956
L9C17           := $9C17
L9FE2           := $9FE2
LA0D6           := $A0D6
LA0D7           := $A0D7
LA0DC           := $A0DC
LA158           := $A158
LA258           := $A258
LA60A           := $A60A
LA7C7           := $A7C7
LA818           := $A818
LA829           := $A829
LA9ED           := $A9ED
LAB45           := $AB45
LAC00           := $AC00
LAC03           := $AC03
LACAF           := $ACAF
LB0B0           := $B0B0
LB2E1           := $B2E1
LB3D9           := $B3D9
LB4B0           := $B4B0
LBA96           := $BA96
LBB36           := $BB36
LBC2C           := $BC2C
LBC80           := $BC80
LBEE1           := $BEE1
LBF36           := $BF36
LBF49           := $BF49
LC1D9           := $C1D9
LC34C           := $C34C
LC529           := $C529
LC530           := $C530
LC6E1           := $C6E1
LC76A           := $C76A
LC8B3           := $C8B3
LC8F9           := $C8F9
LC9DC           := $C9DC
LCAD7           := $CAD7
LCC2C           := $CC2C
LCC54           := $CC54
LCC9C           := $CC9C
LCD2A           := $CD2A
LCE7B           := $CE7B
LCEB6           := $CEB6
LCF12           := $CF12
LCFAC           := $CFAC
LD0CB           := $D0CB
LD194           := $D194
LD237           := $D237
LD38A           := $D38A
LD3E8           := $D3E8
LD4B2           := $D4B2
LD4B8           := $D4B8
LD4BC           := $D4BC
LD4E3           := $D4E3
LD4ED           := $D4ED
LD67C           := $D67C
LD6CA           := $D6CA
LD870           := $D870
LD970           := $D970
LD974           := $D974
LDA7C           := $DA7C
LDCCE           := $DCCE
LDF5E           := $DF5E
LDFF8           := $DFF8
LE059           := $E059
LE0D1           := $E0D1
LE255           := $E255
LE361           := $E361
LE3B3           := $E3B3
LE596           := $E596
LE5A2           := $E5A2
LE5E7           := $E5E7
LE74A           := $E74A
LE852           := $E852
LE8F5           := $E8F5
LE935           := $E935
LEA3E           := $EA3E
LEA78           := $EA78
LEAF7           := $EAF7
LEB05           := $EB05
LF0CD           := $F0CD
LF0CE           := $F0CE
LF106           := $F106
LF32A           := $F32A
LF343           := $F343
LF485           := $F485
LF5E4           := $F5E4
LF85F           := $F85F
LF8E9           := $F8E9
LFD8B           := $FD8B
LFD97           := $FD97
LFE07           := $FE07
LFEB6           := $FEB6
LFFE4           := $FFE4
L0801:  ora     ($08,x)
        .byte   $0B
        php
        .byte   $EF
L0806:  brk
        .byte   $9E
        .byte   $32
        bmi     L0841
        and     ($00),y
        brk
        brk
L080F:  sei
        .byte   $EE
        .byte   $30
L0812:  bne     $07BD
        sec
        sta     $01
        ldx     #$34
L0819:  lda     L0842,x
        sta     $01FF,x
        dex
        bne     L0819
        ldx     #$CF
L0824:  lda     L0875,x
        sta     a:$F6,x
        dex
        bne     L0824
        ldy     #$85
L082F:  dex
L0830:  lda     L8C7A,x
L0833:  sta     $CF0A,x
        txa
        bne     L082F
        dec     L0833
        dec     L0830
        dey
        .byte   $D0
L0841:  .byte   $ED
L0842:  jmp     L0116

        pha
        lda     L4BD4
        rol     a
        sta     $F7
        inc     $0202
        bne     L0854
        inc     $0203
L0854:  pla
        rts

        inx
        txa
L0858:  asl     $F7
        .byte   $D0
L085B:  .byte   $03
        jsr     L0200
L085F:  bcc     L0873
        inx
        cpx     #$08
        bne     L0858
        beq     L0873
        ldx     #$07
        inx
        asl     $F7
        bne     L0872
        jsr     L0200
L0872:  rol     a
L0873:  dex
        .byte   $D0
L0875:  sbc     $18,x
        rts

        .byte   $80
        .byte   $03
        .byte   $8D
L087B:  ora     ($08,x)
        inc     $FA
        bne     L0883
        inc     $FB
L0883:  dex
        rts

L0885:  ldy     $F8
        ldx     #$02
        jsr     L022F
        sta     $F8
        tya
L088F:  ldx     #$06
        jsr     L022F
        jsr     L00F9
L0897:  ldy     #$00
        tya
        ldx     #$02
        jsr     L022F
        cmp     $F8
        bne     L088F
        jsr     L0211
        sta     $2D
L08A8:  lsr     a
        bne     L08EA
        jsr     L0225
        lsr     a
        bcc     L08F8
        jsr     L0225
        lsr     a
        bcc     L0885
        iny
        jsr     L0211
        sta     $2D
        cmp     #$80
        bcc     L08CC
L08C1:  .byte   $A2
L08C2:  ora     ($20,x)
        rol     $02
        sta     $2D
        jsr     L0211
        tay
L08CC:  jsr     L0211
        tax
        lda     $01A5,x
        cpx     #$20
        bcc     L08DD
        txa
        ldx     #$03
        jsr     L0226
L08DD:  ldx     $2D
        inx
L08E0:  jsr     L00F9
        .byte   $D0
L08E4:  .byte   $FB
        dey
        bne     L08E0
L08E8:  beq     L0897
L08EA:  jsr     L0211
        cmp     #$FF
        beq     L0914
        sbc     #$00
        ldx     #$00
        jsr     L022F
L08F8:  sta     $2E
        jsr     L0223
        adc     $FA
        ldx     $2D
        sta     $2D
        lda     $FB
        sbc     $2E
        sta     $2E
L0909:  inx
L090A:  lda     ($2D),y
        iny
        .byte   $20
L090E:  sbc     $D000,y
        sed
        beq     L08E8
L0914:  .byte   $A9
L0915:  .byte   $37
        sta     $01
        .byte   $CE
L0919:  bmi     $08EB
        .byte   $A5
L091C:  .byte   $FA
        sta     $2D
        lda     $FB
        sta     $2E
        cli
        jmp     L080F

L0927:  .byte   $FF
        brk
        ora     $02
L092B:  ora     ($03,x)
        asl     a
L092E:  .byte   $DF
        sta     $04D1
        asl     $09
        rti

        .byte   $93
        sbc     $08,x
        asl     L2010
        .byte   $7F
        tya
        tay
        .byte   $07
        bvc     L09A9
        .byte   $80
        dey
        .byte   $FC
        .byte   $0B
        .byte   $44
        ora     $0108
        brk
        .byte   $9E
        .byte   $32
        bmi     L0984
        .byte   $33
        .byte   $3A
        .byte   $8F
        .byte   $DC
        .byte   $89
L0953:  txs
L0954:  bne     L098A
        rts

        .byte   $DA
        eor     ($01),y
        ldy     $46,x
        sbc     #$B8
        ora     #$3F
        .byte   $3B
        cpy     #$A3
        .byte   $AB
        rti

L0965:  dey
        and     $EBFF,y
        bvs     L096B
L096B:  ldy     $02,x
        rol     a
        .byte   $42
        php
        ora     $EA,x
        lsr     L6C41
        bvc     L09B7
        .byte   $3A
        .byte   $47
        eor     L559D,x
        .byte   $22
        bmi     L0927
        and     $26,x
        bne     L092B
        .byte   $5A
L0984:  cpx     #$65
        .byte   $D7
        sta     ($35,x)
        pha
L098A:  .byte   $BF
        .byte   $A7
        .byte   $A3
        rol     $BC
        asl     $A2
        .byte   $92
        rol     a
        pha
        ldy     L88BC,x
        and     ($07,x)
        .byte   $DA
        and     ($62,x)
        nop
        rti

        .byte   $21
L099F:  .byte   $63
        php
        ora     ($C7,x)
        .byte   $D3
        .byte   $1B
        .byte   $42
        sec
        beq     L09C9
L09A9:  .byte   $7C
        bit     $A0
        brk
        sty     $D2
        and     $2E,x
        .byte   $37
        .byte   $87
        .byte   $E2
        adc     L4610,x
L09B7:  ora     $D356,y
        sta     ($14,x)
        sbc     $A7C6,x
        .byte   $DA
        adc     $A5C6
        .byte   $74
        ror     L7E22
        .byte   $E2
        .byte   $A7
L09C9:  inc     L7932
        asl     $C6
        .byte   $A3
        cmp     $4A,x
        .byte   $9E
        .byte   $23
        .byte   $72
        brk
        tya
        dey
        beq     L09DC
        .byte   $57
        adc     $F8
L09DC:  ora     $16,x
        lda     $A9E6,x
        pla
        .byte   $A3
        .byte   $6D
        .byte   $31
L09E5:  dec     L0060,x
        ldx     $A6
        asl     $16
        rol     $A4,x
        dec     $16,x
        .byte   $3A
        dey
        .byte   $22
        .byte   $80
        rol     $C4E5,x
        dec     $46,x
        rol     $20,x
        .byte   $43
        .byte   $5F
        .byte   $03
L09FD:  ora     $22,x
        .byte   $0C
        lda     ($BC),y
L0A02:  .byte   $74
        .byte   $80
        .byte   $32
        .byte   $C7
        .byte   $67
L0A07:  .byte   $3E
L0A08:  .byte   $92
        ldy     $39,x
        .byte   $93
        .byte   $DC
        .byte   $82
        adc     #$A5
        ror     $21
        .byte   $13
L0A13:  .byte   $AF
        eor     ($3B),y
        .byte   $53
        .byte   $E2
        .byte   $80
        adc     ($AD),y
        ror     $A5,x
        pla
        rol     L4B26,x
        eor     L34A2
        rol     L43AA,x
        .byte   $E3
        lsr     $35
        rol     a
        .byte   $7C
        .byte   $23
        eor     ($93,x)
L0A2F:  inc     L3502
        eor     $D566,y
        .byte   $3A
        .byte   $FF
        sta     L365C
        sta     $CF5D
        .byte   $80
        pha
L0A3F:  cmp     $3C,x
        .byte   $FB
L0A42:  asl     a
        sta     L3662
        .byte   $AD
        tya
L0A48:  sec
        sta     $D3
        .byte   $DD
L0A4C:  jmp     ($7DCA)

        inc     $FD58,x
        cpy     L1B97
        cpx     $64
        .byte   $FF
        pha
        .byte   $7B
        pla
        .byte   $03
        .byte   $77
        .byte   $17
        .byte   $9B
        and     #$30
        sty     L2B25
        cmp     L733D,y
        jmp     L910D

L0A6A:  .byte   $8F
        and     $F33E,y
        .byte   $4B
        .byte   $93
        cpx     #$D3
        .byte   $34
        cmp     $AF
        .byte   $34
        .byte   $FB
        lda     L6C4D
        .byte   $D5
L0A7B:  rol     a
        .byte   $27
        lda     #$26
        .byte   $4F
        sbc     $0581
        .byte   $62
        .byte   $7B
        bcc     L0AD9
        sta     $54,x
        .byte   $80
        ldx     $64,y
        beq     L0AA1
        lda     ($98),y
L0A90:  .byte   $AB
        adc     ($F8,x)
        .byte   $FB
        cmp     $8E32
        .byte   $23
        .byte   $7C
        inx
        .byte   $FB
        jmp     L6097

        .byte   $4F
        .byte   $5C
        .byte   $06
L0AA1:  lda     $55
        lda     L14F4,y
        bpl     L0AD8
        .byte   $DB
        ora     $F192,x
        lda     $B1,x
        .byte   $E7
        ora     $0520
        ora     L89FB,y
        .byte   $D4
        brk
        asl     $38,x
        .byte   $5E
        .byte   $83
L0ABB:  .byte   $AC
        .byte   $8E
L0ABD:  .byte   $3E
        .byte   $D0
L0ABF:  lda     L39B0,x
        bmi     L0B3C
        sbc     $49,x
        asl     a
        lda     #$02
        .byte   $EB
        .byte   $EF
        rol     $FA0C
        .byte   $8F
        .byte   $CF
        lda     $9A46,x
        eor     $F1,x
        .byte   $1F
        .byte   $79
        .byte   $A6
L0AD8:  .byte   $B5
L0AD9:  .byte   $7C
        .byte   $47
        dec     $B569,x
        .byte   $5F
        asl     $D6
        ora     $9943
        ldx     $F5
        adc     $DEC7,y
        adc     #$C4
        .byte   $7C
        .byte   $07
        .byte   $DA
        .byte   $32
        .byte   $83
        bne     L0ABD
        ora     $DE91,x
L0AF5:  rti

        pla
        .byte   $37
        and     $FA00
        .byte   $92
        .byte   $32
        cmp     $F3
        .byte   $63
        brk
        rol     a
        bcc     L0B72
        ora     L2C13,y
        .byte   $42
        adc     $5C,x
        txs
        adc     $07A0
        .byte   $DC
        .byte   $9C
        adc     $E148
        rol     $C6
        ldx     $6B
        .byte   $53
        .byte   $EB
        .byte   $43
        lda     ($85,x)
        .byte   $F2
        asl     $A941
        brk
        pla
        .byte   $D4
        sed
L0B24:  .byte   $52
        adc     ($A8,x)
        eor     L3D10
        ror     a
        .byte   $93
        cmp     L43B2
        ldy     $00
        .byte   $7A
        .byte   $22
        tya
        cpy     L0F77
        cld
        cpy     $BA
        .byte   $8E
        .byte   $E7
L0B3C:  .byte   $02
L0B3D:  .byte   $8D
        .byte   $E9
L0B3F:  jmp     $82AE

        sty     $C2,x
        .byte   $52
        .byte   $44
        .byte   $6F
        .byte   $5A
        .byte   $7A
        .byte   $74
        ora     ($51,x)
L0B4C:  brk
        bvc     L0B4C
        inx
        clc
        tax
        .byte   $A3
        cpy     #$4A
        .byte   $97
        .byte   $E2
        .byte   $3F
L0B58:  ror     $F7E3,x
        .byte   $F2
        .byte   $3F
        .byte   $7F
        .byte   $63
        .byte   $F7
        sbc     $33,y
        .byte   $52
        eor     $B1,x
        cmp     $E0
        bit     L46D1
        stx     $74
        .byte   $7B
        cmp     $D975,y
        .byte   $6F
L0B72:  ldx     $65
        ora     $30
        eor     $E9
        .byte   $9C
        tax
        bmi     L0BBB
        .byte   $FC
        ora     ($73,x)
        .byte   $22
        .byte   $5F
        rti

        rol     $B22F
        .byte   $63
L0B86:  .byte   $D4
        .byte   $47
        and     $42,x
        ora     ($C3),y
        plp
        inx
        .byte   $B2
        sbc     L5C4C,x
        asl     a
        .byte   $A3
        nop
        tax
        plp
        dec     $A3
        dec     $9F8F,x
        .byte   $EB
        .byte   $2F
        .byte   $0F
        .byte   $DA
        and     $38,x
        ldy     $4B
        sed
        sta     ($4B),y
        inc     $90,x
        asl     $BD91,x
        rti

        iny
        .byte   $FF
        .byte   $92
        .byte   $DB
        jsr     L3524
        rol     $50
        asl     a
        ora     $54
        .byte   $64
        .byte   $5C
L0BBB:  sbc     ($8B,x)
        and     #$22
L0BBF:  .byte   $21
L0BC0:  .byte   $AF
        .byte   $B2
        asl     $CEF4
        sbc     L4E2C,x
        and     ($00),y
        lsr     a
        .byte   $8B
        .byte   $92
        .byte   $E3
        ror     a
        .byte   $81
L0BD0:  sta     $34
        .byte   $97
        .byte   $32
        lda     $B21B
        eor     $46
        .byte   $4C
L0BDA:  and     $E9,x
        .byte   $F7
        .byte   $52
        jmp     (LA7C7)

        cpx     $C2
        dey
        .byte   $0B
        .byte   $34
        dec     L2193,x
        .byte   $44
        asl     $47,x
        dec     $83
        sta     ($97),y
        cpy     $83
        eor     ($A7),y
        .byte   $C2
        .byte   $77
        .byte   $82
        .byte   $62
        .byte   $64
        iny
        .byte   $32
        eor     $95
        clv
        .byte   $AC
        .byte   $49
L0C00:  lsr     $1DA4,x
        asl     $9E
        .byte   $42
        .byte   $74
        .byte   $63
        iny
        cmp     ($C3,x)
        sta     ($3D),y
        .byte   $FC
L0C0E:  asl     $E9DA
        .byte   $6B
        .byte   $DC
        adc     $BBCB,y
        .byte   $FB
        rti

        eor     $D3,x
        cmp     $980C,x
        .byte   $F7
        sta     $3F
L0C20:  jsr     L1ED9
L0C23:  cmp     $3F
        .byte   $90
L0C26:  .byte   $14
        .byte   $74
        .byte   $04
        .byte   $42
        stx     $4D,y
        .byte   $0F
        .byte   $36
L0C2E:  .byte   $B7
        .byte   $BE
        .byte   $FC
L0C31:  .byte   $3B
        clc
        .byte   $59
L0C34:  sei
        lsr     $04D7
        .byte   $DC
        .byte   $14
        .byte   $E4
L0C3B:  .byte   $D7
        .byte   $63
        bcc     L0BC0
        eor     L2982,y
        sta     $41,x
        ror     $DA9D,x
        bmi     L0C0E
L0C49:  .byte   $34
        .byte   $EE
        .byte   $BC
L0C4C:  rol     $EE,x
        bcc     $0C17
        .byte   $22
        bmi     L0C2E
        .byte   $D2
L0C54:  .byte   $9F
        .byte   $C2
        sty     $8E,x
        .byte   $0C
L0C59:  .byte   $D5
L0C5A:  .byte   $10
L0C5B:  adc     #$B1
        and     #$1D
        pha
        lsr     $C9,x
        .byte   $9C
        .byte   $D1
L0C64:  .byte   $F4
        .byte   $B3
        adc     ($F4,x)
        lda     $61,x
        .byte   $F4
        .byte   $B7
        .byte   $57
        .byte   $D2
        .byte   $63
        jsr     L8B84
        lda     $05C4,y
        .byte   $34
        .byte   $37
        tay
L0C78:  bcc     L0C00
        .byte   $97
        sbc     $9722,y
        sbc     $22,x
        ldy     $59
        sty     $00
        sty     $1D
        sty     $15,x
        .byte   $1E
L0C89:  .byte   $63
        bit     $C6
        .byte   $77
L0C8D:  .byte   $0F
        .byte   $67
        adc     ($53),y
        .byte   $42
        lsr     $F8BF
        .byte   $7B
        .byte   $03
        jmp     L1067

        .byte   $E2
        .byte   $CB
        .byte   $97
        bvs     L0D02
        lsr     a
        bcc     L0C5A
        cmp     $21,x
        ldx     $A99A
        tsx
L0CA8:  rol     $BBED,x
        cpx     #$9B
        tax
        .byte   $7A
        php
        lda     #$0E
        jsr     L8353
L0CB5:  bvs     L0CD6
        .byte   $44
        .byte   $64
        rti

        bit     $47
        sta     $A1,x
        .byte   $F4
        ldy     $93C7
        .byte   $44
        .byte   $8F
L0CC4:  .byte   $77
        eor     $A3
        .byte   $97
        .byte   $17
        iny
        .byte   $8E
L0CCB:  .byte   $A7
        .byte   $5F
        .byte   $FC
        .byte   $B2
        cmp     #$8C
        eor     ($55,x)
        and     ($E9,x)
        .byte   $8E
L0CD6:  cmp     ($9E,x)
        bvc     L0D3E
        .byte   $1A
        .byte   $53
        rol     $75
        ror     $52,x
        .byte   $62
L0CE1:  ldx     $FC,y
        asl     a
L0CE4:  rol     $B9,x
        lda     $8DF9,y
        .byte   $AF
        .byte   $02
        .byte   $A9
L0CEC:  .byte   $F2
        sta     L244F
        ror     $8D
L0CF2:  .byte   $4F
        .byte   $37
        eor     $038C
        .byte   $32
L0CF8:  .byte   $03
        .byte   $A3
        .byte   $3A
        .byte   $DB
L0CFC:  brk
        rol     a
L0CFE:  tax
        brk
        .byte   $12
        .byte   $0B
L0D02:  .byte   $AF
L0D03:  .byte   $FA
        .byte   $2D
        asl     a
L0D06:  .byte   $03
        lsr     a
        .byte   $DB
        bpl     L0D2D
        .byte   $0B
        .byte   $DF
        .byte   $FA
        .byte   $97
        bpl     L0CFE
        and     #$28
        sty     L0E28
        rol     a
        ror     L36C8,x
L0D1A:  .byte   $3F
        .byte   $C2
        .byte   $19
L0D1D:  sta     $C45A,y
L0D20:  cld
        cpy     #$01
        bne     L0D3D
        plp
        .byte   $B0
L0D27:  bit     $72
        .byte   $A3
        lda     $964A
L0D2D:  bit     L526B
        lda     $8B
        asl     $25
        .byte   $D3
        lda     ($03,x)
        .byte   $73
        sty     L80A8
        .byte   $72
        rti

L0D3D:  .byte   $34
L0D3E:  .byte   $02
        sta     $19,x
        cpx     $19
        rol     a
        rol     $58
        .byte   $F7
        beq     L0D4A
        dex
L0D4A:  .byte   $4C
        .byte   $1F
L0D4C:  php
        lda     $3B,x
        cpx     #$4C
        .byte   $BC
        .byte   $E2
L0D53:  eor     $C7A5,y
        .byte   $1C
        .byte   $47
        bne     L0D5A
L0D5A:  adc     $1B,x
        sbc     $47,x
        .byte   $80
        eor     ($17),y
        bvc     L0D7E
        bpl     L0DD0
        .byte   $57
        .byte   $C2
        lsr     $FE18,x
        ora     ($03),y
L0D6C:  dex
L0D6D:  jmp     LA258

        rti

        .byte   $27
        .byte   $8B
        .byte   $03
        ldy     $E2B3,x
        cpx     #$82
        .byte   $DF
        .byte   $57
        .byte   $F4
        .byte   $7A
        .byte   $17
L0D7E:  ldx     $4A
        sty     L3A36
        .byte   $83
        .byte   $72
L0D85:  eor     ($3C,x)
L0D87:  rol     a
        inc     $21
        ldx     $E6,y
        .byte   $89
        .byte   $D4
        php
        sbc     L483F,x
        lda     ($FA,x)
        stx     $B8A0
L0D97:  .byte   $62
        .byte   $3F
        .byte   $8F
        .byte   $D4
        asl     $8C
        sty     $0F,x
        brk
        eor     L3211,y
        ora     ($BF),y
        .byte   $52
        eor     ($C6,x)
        plp
        .byte   $8F
        .byte   $F4
        .byte   $3C
        sbc     ($10),y
        .byte   $34
        .byte   $3B
        .byte   $EB
        eor     ($F0,x)
        sec
        .byte   $AB
        eor     ($D0,x)
        sec
        php
        ora     ($0F,x)
        .byte   $32
        tsx
        rol     $C8,x
        sbc     ($C5),y
        asl     L435D
        .byte   $84
L0DC5:  .byte   $CB
        lda     #$16
        .byte   $8F
        bvs     L0D97
        txs
        adc     L170B
        .byte   $5A
L0DD0:  .byte   $9C
        adc     L50E3
        eor     $22,x
        eor     L6777,x
        .byte   $9E
        ldy     $01,x
        sed
        sbc     #$D6
        pha
        asl     L5454
        .byte   $89
        .byte   $F7
        rol     $9D62
        cpy     #$57
        .byte   $1A
        .byte   $02
L0DEC:  lda     L2671,x
        .byte   $1B
        .byte   $7C
        .byte   $34
        .byte   $A7
        .byte   $52
        bit     $A799
        bne     L0DD0
        .byte   $52
        .byte   $6F
        .byte   $9C
        .byte   $9D
        .byte   $E0
L0DFE:  tay
        .byte   $8E
L0E00:  .byte   $2F
        rol     $BD,x
        rol     $6637
        .byte   $27
        .byte   $43
L0E08:  .byte   $B2
        .byte   $7F
        .byte   $64
        ora     ($99,x)
        .byte   $9E
        sta     $F2D4,y
        inx
        .byte   $52
        adc     ($70,x)
        .byte   $73
        .byte   $1C
        .byte   $AE
L0E18:  .byte   $5B
        sta     $23,x
        lsr     a
        .byte   $4C
        .byte   $24
L0E1E:  .byte   $0F
        adc     $33,x
L0E21:  .byte   $FF
        .byte   $53
        tsx
        .byte   $A7
        sbc     L5B3B,y
L0E28:  .byte   $9C
        bmi     L0DEC
        .byte   $9F
        ora     L2DF7
        .byte   $F2
        .byte   $0F
        .byte   $D3
L0E32:  and     $66,x
        .byte   $3B
        .byte   $07
        bpl     L0E74
        .byte   $0C
        bne     L0E00
L0E3B:  .byte   $D4
        .byte   $54
        .byte   $8C
        inx
L0E3F:  .byte   $03
        inc     $C1,x
        .byte   $54
        .byte   $33
L0E44:  .byte   $73
        ora     #$8A
        .byte   $14
        nop
        dec     $10,x
        cmp     L14F4,y
        lda     $A704,y
        eor     $C6
L0E53:  ora     L337F,y
        cli
        sta     $01BC
        bit     $D2
        .byte   $57
L0E5D:  rts

        .byte   $73
        .byte   $52
        pha
        iny
        bvs     L0E9B
        .byte   $0B
        sed
        .byte   $E7
        ora     $F5
        .byte   $89
        ora     $98
L0E6C:  lda     L6B33
        ora     ($7C,x)
        tax
        ldx     #$00
L0E74:  sta     ($8B,x)
        inc     $9E
        .byte   $3C
        .byte   $DB
        .byte   $FC
        inc     $E8
        sbc     L4390
        .byte   $CB
        dex
        tsx
        .byte   $0C
        .byte   $E2
        .byte   $3B
        eor     L0060,x
        eor     #$8D
L0E8A:  sta     ($84,x)
        .byte   $1C
        .byte   $A3
        asl     L1509,x
        pha
        .byte   $F2
        .byte   $DB
        pha
        .byte   $8C
L0E96:  .byte   $44
        .byte   $8F
        .byte   $87
        .byte   $34
        txs
L0E9B:  jmp     L9158

        .byte   $47
        rol     a
        sta     ($CC),y
        .byte   $0F
        sbc     $9C0D
        cpx     $BC
        adc     ($85,x)
        and     L492A
        .byte   $D4
        sta     L1C84,y
        dec     $A3
        ldx     #$33
        ora     #$48
        sty     $40
        asl     $A033
        asl     L54E8,x
        .byte   $2F
        rts

        ora     $52
        bpl     L0E8A
        .byte   $63
        lda     #$EE
        ror     $E91E
        .byte   $5C
        .byte   $64
        .byte   $97
        ror     L0D1D,x
        cli
        adc     ($A6),y
        nop
        eor     ($E8),y
        ror     L4F90
L0EDA:  sty     $D424
        stx     $B5
        .byte   $49
L0EE0:  .byte   $33
        ora     #$25
        jmp     L45C2

        clc
        .byte   $73
        lda     $F8
        .byte   $E3
        dex
        .byte   $74
        bcc     L0EF1
        .byte   $8C
        .byte   $A6
L0EF1:  eor     $C243,x
        sei
        cpy     L322B
        .byte   $1B
        .byte   $DA
        .byte   $C7
        cmp     ($96,x)
        .byte   $62
        ldy     $77
        sta     $89
        .byte   $2C
L0F03:  cmp     $8E90
        .byte   $E2
        dec     $42
        .byte   $27
L0F0A:  .byte   $33
        sbc     ($83),y
        .byte   $85
L0F0E:  txa
        .byte   $92
        lsr     L6A17,x
        lda     $DF62,x
        .byte   $04
        .byte   $FB
        ldy     $B0
        rol     $F161,x
        .byte   $32
        bvs     L0F4F
        tsx
        ror     a
        .byte   $CE
        .byte   $FE
L0F24:  .byte   $E2
        tya
L0F26:  and     $03
        clv
        ldx     $D2
        jmp     (LC529)

        .byte   $80
        .byte   $6D
L0F30:  .byte   $74
L0F31:  .byte   $81
L0F32:  cpy     $34
        .byte   $6D
        .byte   $74
L0F36:  txa
        adc     L29C7,x
        .byte   $33
        cld
        rol     L1D88,x
        eor     #$82
        sbc     ($19,x)
        bcs     L0F0E
        .byte   $D3
        sbc     L245D
        .byte   $D7
        jmp     L1D9B

        .byte   $2C
        .byte   $DC
L0F4F:  .byte   $73
        sei
        .byte   $67
        .byte   $52
        .byte   $C7
        rol     $C81D,x
        .byte   $33
        .byte   $73
L0F59:  .byte   $0C
        .byte   $57
        tsx
        .byte   $36
L0F5D:  ror     $1324,x
        rol     $B1
        .byte   $FB
        .byte   $0F
        .byte   $CF
        .byte   $07
        .byte   $63
        .byte   $89
        txs
        ldy     L11C2
        .byte   $0F
        ora     $E39C,y
        ldx     $A3,y
        .byte   $3B
        .byte   $12
        rol     L8D4B
L0F77:  .byte   $F3
        lda     ($A3),y
        .byte   $9C
        rol     $B8,x
        .byte   $DA
        .byte   $D2
        eor     #$37
        .byte   $80
        and     $FC4F,x
        .byte   $0F
        .byte   $DB
        asl     L41B4,x
        bit     L4543
        .byte   $27
        .byte   $AB
        .byte   $72
        ror     a
        .byte   $F2
        cpy     #$93
        sty     L4298
        dec     $26
        bpl     L0F5D
        tya
        ror     L08E4,x
        .byte   $13
        lda     ($49),y
        sty     $2E,x
        lsr     $6C,x
        ror     $FD,x
        .byte   $9C
        .byte   $72
        dec     $58
        brk
        cmp     $38
        adc     ($3A,x)
        adc     $C5C2
        .byte   $D2
        dec     $25
        ror     $80
        eor     L216C
        dec     $2C
        .byte   $5C
        .byte   $80
        lsr     a
        eor     ($D2),y
        cmp     $B9
        eor     ($80),y
        lda     ($46),y
        eor     ($92,x)
        .byte   $DA
        ror     L2999,x
        .byte   $B7
        .byte   $0C
        .byte   $E3
        sty     $99D2
        ora     L651A,x
        dec     $30
        .byte   $62
        .byte   $F4
        .byte   $03
        .byte   $DB
L0FDE:  ldx     L8B47
L0FE1:  .byte   $C7
L0FE2:  cmp     $BA
        .byte   $E7
        eor     $06
        .byte   $3B
        .byte   $92
        sbc     $921C,y
        lda     L5C1C
        and     $9195,y
        tya
        eor     #$85
        .byte   $42
        and     $F27B,x
        lda     L13A6,x
        dey
        .byte   $F7
        adc     ($FA),y
        bne     L1009
        ldx     #$02
        .byte   $E2
        .byte   $8B
        .byte   $82
        .byte   $6F
        .byte   $61
L1009:  ldx     #$0D
        ror     $8C
        .byte   $73
L100E:  pha
        rti

        .byte   $7C
        .byte   $9E
        sbc     L7C1D
        .byte   $72
        cpy     #$F8
        .byte   $3D
        .byte   $D2
L101A:  sbc     ($0D),y
        .byte   $4B
        .byte   $AF
        dec     L2D63
        .byte   $50
L1022:  .byte   $47
        .byte   $83
        .byte   $AF
L1025:  .byte   $6F
L1026:  rol     $F2B2
        .byte   $77
L102A:  bmi     L1026
        and     L6EF9
        lda     $A1,x
        .byte   $83
        tsx
        lsr     $7C,x
        bpl     L1022
        nop
        bit     $9243
        .byte   $E3
        sec
        .byte   $BB
        .byte   $12
        rti

        .byte   $B9
L1041:  .byte   $12
        pha
        .byte   $07
        stx     $B8
        sec
        jsr     L0812
        .byte   $E2
        .byte   $B3
        .byte   $93
        .byte   $6F
        pha
        jsr     LC34C
        bcs     L1041
        lsr     L28EC
        .byte   $F3
        .byte   $32
        pla
        rol     $CC,x
        txs
        asl     L2F33
        inc     $C9,x
        dec     $9A,x
        ldx     $E9,y
        .byte   $AB
L1067:  lsr     $68,x
        .byte   $A4
L106A:  cpy     #$01
        rol     a
        cpy     $DD
        .byte   $47
        .byte   $A7
        .byte   $3A
        asl     $63,x
        .byte   $9E
        and     L7B3A,y
L1078:  .byte   $93
        sbc     #$86
        sty     $F8,x
        .byte   $63
        .byte   $3C
        adc     $8C,x
        sbc     ($E6),y
        .byte   $2F
        dec     $D8
        .byte   $BF
        .byte   $1C
        .byte   $63
        .byte   $44
        .byte   $80
        .byte   $5C
        cmp     ($C3),y
        tay
        cmp     $A6AE,x
        ldx     L5840
        lda     $E070,y
        dec     L8163,x
        sec
        iny
        .byte   $2F
        eor     L8318
        .byte   $72
        .byte   $15
L10A3:  cmp     #$18
        .byte   $65
L10A6:  .byte   $13
        eor     ($5D,x)
        adc     #$04
        .byte   $FA
        dec     $A2,x
        .byte   $FF
        inx
        sec
        sbc     #$4F
        .byte   $0F
        lda     $34
        sty     L5C54
        lda     #$70
        eor     #$9C
L10BD:  lda     L6140
        .byte   $63
        bcs     L10C8
        .byte   $F4
        .byte   $02
        adc     $94A3,y
L10C8:  tya
        sei
        bit     $0D
        .byte   $1A
        jmp     L52CE

        .byte   $BF
        .byte   $34
        .byte   $AB
        adc     ($00),y
        .byte   $D4
        lda     $8E
        sta     $D401
        .byte   $57
        eor     $45
        eor     #$0C
        pla
        rol     $B5
        and     L3957,y
        dex
        txa
        .byte   $3B
        and     L36F8,x
        .byte   $0C
        .byte   $14
L10EE:  .byte   $1C
        bit     $2D
        and     $3E,x
L10F3:  .byte   $47
        eor     ($5B),y
        ror     $70
        .byte   $7B
        stx     $91
        .byte   $9D
L10FC:  lda     #$B6
        .byte   $D2
        asl     $EF86,x
        .byte   $5F
        .byte   $80
        eor     #$05
        jsr     L1795
        .byte   $82
        .byte   $93
        and     ($C4,x)
        tya
        sed
        eor     L4FD9,x
        sta     $10
        .byte   $7C
        .byte   $34
        .byte   $5B
        .byte   $27
        .byte   $9E
        bvc     L112C
        bit     L2C58
        .byte   $64
        ror     a
        .byte   $7C
        dec     $ED
L1123:  ora     ($36,x)
L1125:  .byte   $1A
        .byte   $A7
        .byte   $0C
        adc     #$06
        .byte   $83
        .byte   $1E
L112C:  sbc     $21
        sbc     $15,x
        .byte   $BF
        .byte   $39
        .byte   $6C
L1133:  cpx     $E5
L1135:  .byte   $F4
        .byte   $9F
        .byte   $7F
        sty     L2DE0
        .byte   $63
        inc     $A6,x
L113E:  .byte   $07
        eor     L2062,y
        .byte   $1B
        .byte   $73
        .byte   $8B
        .byte   $6B
L1146:  brk
        .byte   $B6
L1148:  .byte   $CB
        adc     ($06,x)
        sbc     ($76),y
        adc     ($8E),y
        ldx     $43
        .byte   $17
        .byte   $12
        sty     $F5A7
        .byte   $D4
        .byte   $A3
        adc     ($79),y
        .byte   $F3
        adc     ($CE,x)
        bit     L720C
        rti

        cpx     $0B
        .byte   $53
        .byte   $1F
        ldy     #$A5
        eor     $DD1D
L116A:  brk
        eor     $C9,x
        .byte   $FB
        cpy     #$15
        cpx     #$37
        eor     $05D2,x
        ora     L4419
        brk
        .byte   $8F
        sty     $E0E2
        sbc     $4F
        .byte   $4B
        clc
        .byte   $9F
        lda     ($6A),y
L1184:  iny
        .byte   $E7
        asl     $F4
        cmp     ($50,x)
        txa
        jsr     L5F6E
        .byte   $5A
L118F:  .byte   $DC
        inc     $EB
        and     ($A3),y
        stx     $90D2
        ror     $9F6A,x
        lsr     a
        lda     #$4B
        beq     L11A9
        txs
        .byte   $1A
        lda     L462C
        lda     #$78
        cmp     L40CD,y
L11A9:  .byte   $8B
        lda     #$F8
        bne     L1204
L11AE:  jmp     (LC76A)

        adc     ($A9),y
        .byte   $85
L11B4:  .byte   $59
L11B5:  sbc     $E1
        .byte   $D7
        .byte   $9B
        adc     L3C0F,x
        adc     ($9A),y
        stx     $6C,y
        .byte   $53
        .byte   $0F
L11C2:  dec     $6A
L11C4:  .byte   $5F
        .byte   $5C
        .byte   $3F
        asl     L0C59
        sbc     $A784,y
        sbc     $85
        .byte   $CE
L11D0:  adc     ($BD),y
        .byte   $5A
        .byte   $2B
        sbc     L7179,y
        .byte   $97
        cmp     $8E
        lda     ($F8),y
        .byte   $3B
        .byte   $5F
        rol     $45,x
        .byte   $8B
        .byte   $25
L11E2:  sty     $C8CF
        cmp     $FE,x
        clv
        .byte   $34
        .byte   $9B
        .byte   $FB
        .byte   $97
        jsr     L440B
        bpl     L11B4
        .byte   $72
        bvs     L11AE
        .byte   $9F
        txa
        .byte   $7C
        .byte   $24
L11F8:  .byte   $20
L11F9:  cmp     $29,x
        adc     ($BD,x)
        .byte   $BB
        .byte   $5B
        .byte   $4F
L1200:  tax
        cmp     $F734,x
L1204:  lda     L4FD2
        dex
        .byte   $44
        .byte   $8F
        tax
L120B:  .byte   $02
L120C:  ora     #$80
        sta     $B24F
        .byte   $03
        .byte   $D2
        ldx     $37
        .byte   $D4
        eor     ($1A),y
        ora     $F861,x
        .byte   $1C
        .byte   $62
        jsr     L2363
        .byte   $D4
        rol     $4D,x
        .byte   $64
        bne     L1251
L1226:  iny
        cmp     ($28,x)
        cmp     $AC7C
        bvc     L120C
        sta     L2AD6
        inc     L5C37,x
        ldx     $73
        .byte   $9B
        tya
        .byte   $3A
        pha
        .byte   $3F
        asl     L52A2
        eor     ($4A),y
        .byte   $13
        dec     $EA,x
        .byte   $5C
        .byte   $9C
        sta     L0D03
        tsx
        ora     $73,x
        .byte   $D4
L124C:  sta     $1E,x
        tsx
        .byte   $34
L1250:  .byte   $6B
L1251:  cmp     $B9,x
        eor     $3B
        lda     L555F
        .byte   $6B
        .byte   $34
        .byte   $64
        sty     $D8D2
        .byte   $C3
        .byte   $1C
        jmp     (LB3D9)

        lda     $16
        .byte   $1E
L1266:  eor     ($AC),y
        sta     L1125,y
        .byte   $47
        asl     $8E13
        bcc     L1289
        .byte   $DC
        .byte   $F7
L1273:  rol     $DC48
        cpx     $F8
        .byte   $52
        adc     ($39,x)
        .byte   $02
        sta     $D0,x
        cmp     ($3B,x)
        .byte   $E3
        .byte   $73
        .byte   $1B
L1283:  plp
        inx
        sta     ($5B,x)
        sta     ($99,x)
L1289:  adc     ($88),y
        cmp     $30,x
L128D:  .byte   $1B
        eor     ($02),y
L1290:  lsr     $F5,x
        sta     ($68,x)
        sei
        and     $ABCD,y
        adc     $F7
        .byte   $7B
        and     $F3
        tay
        .byte   $A0
L129F:  .byte   $E3
        .byte   $7B
        lda     $3F,x
        inc     L7A76
        inc     $21
        and     L3176,y
        cpy     #$99
        eor     L2621
        ora     ($06,x)
        .byte   $F2
        .byte   $3C
        asl     $46,x
        lda     #$40
        cmp     L419C,y
        .byte   $02
        .byte   $1C
        .byte   $73
        cmp     #$8D
        .byte   $52
        .byte   $89
        lda     ($46),y
        .byte   $80
        eor     $966A,x
        cmp     $B299
        cmp     L71F6
        eor     #$DB
        jmp     L73A6

        .byte   $47
        tya
        ror     $04
        .byte   $5C
        dec     L1646
        .byte   $93
        dec     $88
        and     $4D
        ora     L1F5A,y
        sty     $BBE2
        .byte   $1B
        rts

        .byte   $04
        cpy     $B90C
        eor     $10,x
        sei
        .byte   $8B
        .byte   $A7
        .byte   $BB
        ldx     L6A65,y
        jmp     L10A3

L12F8:  rts

L12F9:  .byte   $02
        .byte   $74
        eor     $9449,x
        and     L6C7C
L1301:  .byte   $8F
        and     ($F0),y
        cmp     $B707
        .byte   $6F
        .byte   $DF
        ora     $F2DB
        .byte   $99
L130D:  cmp     $5E
        .byte   $5B
        ror     L731F,x
        lda     ($91,x)
        .byte   $87
        .byte   $1B
        .byte   $7E
L1318:  .byte   $12
        pla
        and     ($CE),y
        .byte   $87
        inx
        .byte   $0B
        php
        .byte   $02
        cmp     $99
        lda     ($C6,x)
        .byte   $6E
L1326:  ror     $A1
        .byte   $E7
L1329:  .byte   $B7
        dey
        .byte   $5F
        .byte   $D4
        adc     ($0C),y
        ora     L15D0,y
L1332:  .byte   $6F
        .byte   $0B
        .byte   $82
        sty     $F8
        ora     L1273
        .byte   $13
        rol     L49C1
        lsr     a
        jmp     L0F26

        adc     $0E,x
        .byte   $F2
        .byte   $DA
        .byte   $9F
        .byte   $73
        .byte   $5F
        .byte   $BF
        ora     $A7F0,x
        .byte   $B7
        .byte   $C4
L134F:  .byte   $FC
        bne     L136E
        .byte   $77
        rol     $9419,x
        .byte   $3A
        .byte   $87
        ora     L631F,x
        .byte   $13
        sta     L3C9D,y
        adc     ($92,x)
        ror     a
        jmp     (L8739)

        ldy     #$8A
        .byte   $02
        .byte   $D4
        cpx     $28
L136B:  beq     L136F
        .byte   $A0
L136E:  .byte   $34
L136F:  ror     a
        ora     ($21),y
        cmp     $91,x
        and     ($DE),y
        .byte   $3F
        ora     $3D,x
        cmp     $C6
        adc     $F0F5,x
        eor     ($C7,x)
        .byte   $C3
        eor     ($02,x)
        cld
        sbc     $49,x
        .byte   $9B
        .byte   $07
        .byte   $C3
        sta     ($56,x)
        .byte   $9F
        sta     $F7B3,y
        .byte   $87
        asl     L75E6,x
        rol     $FD84,x
        ror     $DF
        sta     L189A,y
        dec     $66,x
        stx     $39
        .byte   $BD
L13A0:  .byte   $B3
        .byte   $22
        .byte   $DB
        .byte   $DB
        .byte   $32
        .byte   $32
L13A6:  stx     $35
        sta     $063E,x
        .byte   $33
        rts

        .byte   $CE
L13AE:  bit     $5901
        cpy     #$9E
        cpy     #$3B
        .byte   $17
        .byte   $F7
        eor     ($BC,x)
        .byte   $73
        sty     $98,x
        .byte   $A7
        and     ($64),y
        lsr     $8D81,x
        inc     $65
        .byte   $F4
        inc     $8E
        jsr     L66F6
        .byte   $B6
L13CB:  eor     $3DA9,y
        and     $26,x
        .byte   $03
        asl     $47
        lsr     $01,x
        .byte   $3A
        stx     $6A,y
L13D8:  .byte   $62
        .byte   $67
        .byte   $4F
        ldy     L44D8,x
        iny
        rol     $A8
        adc     L54C2,y
        adc     $E4
        .byte   $1A
        tay
        adc     $BCF5,y
        tya
        bcc     L13F3
        adc     ($A7),y
        inc     L0060
        rti

L13F3:  .byte   $64
        bit     L2C84
        ldy     $2C
        cpy     $2C
        cpx     L592D
        and     ($6A,x)
        sbc     ($6C,x)
        ora     ($6D,x)
        and     ($6E,x)
        eor     ($6F,x)
        adc     ($71,x)
        lda     ($72,x)
        sta     ($74,x)
        sta     ($7A,x)
L1410:  dey
        .byte   $0B
        .byte   $D4
        .byte   $0B
        .byte   $E2
        .byte   $0B
        nop
        .byte   $0B
        .byte   $02
        .byte   $0C
L141A:  ora     $0C
        asl     L380C
        .byte   $0C
        sei
L1421:  .byte   $0C
        stx     $30,y
        .byte   $64
        cli
        .byte   $64
        inx
        rts

        sed
L142A:  ror     L83B4
        rti

        .byte   $83
        stx     $03
        txa
        .byte   $83
        sty     $03,x
        lda     $AC,x
L1437:  .byte   $1C
L1438:  dec     L0E1E
        .byte   $1F
        .byte   $54
        .byte   $1F
L143E:  pla
        .byte   $1F
        ror     $A81F,x
        bvc     L1438
        bmi     L143E
        jsr     L10EE
        sbc     #$41
        .byte   $07
        .byte   $8B
        php
        ora     $08,x
        .byte   $1C
        php
L1453:  .byte   $76
L1454:  dey
        plp
        php
        bmi     L1461
        .byte   $3A
        php
        eor     #$14
        .byte   $42
        .byte   $64
L145F:  .byte   $42
        .byte   $F4
L1461:  .byte   $43
        .byte   $0C
        .byte   $43
L1464:  tya
        .byte   $3F
        .byte   $3C
        eor     ($58,x)
        .byte   $A2
L146A:  .byte   $23
        .byte   $62
        .byte   $22
        .byte   $02
        .byte   $27
        ldx     #$2F
        .byte   $02
        and     ($62),y
        .byte   $32
        .byte   $22
        rol     $C2,x
        and     ($02,x)
        lsr     L4F62
        .byte   $62
        .byte   $53
        .byte   $42
        .byte   $5A
        bcs     L148E
        inc     $0B,x
        .byte   $FC
        .byte   $0B
        jmp     (L7211)

        stx     L2DC1
        .byte   $51
L148E:  .byte   $2E
        .byte   $81
L1490:  and     #$78
        ora     $EB
L1494:  .byte   $3C
        and     L5260,x
        cld
        .byte   $2F
        cli
        cli
        iny
        rol     $BC
        plp
        sty     $27
        .byte   $5C
        .byte   $27
L14A4:  pha
        plp
        ldy     #$26
        ldy     $AD27
        sbc     ($02,x)
        sta     ($56),y
        and     ($5D),y
L14B1:  .byte   $62
        asl     a
        tsx
        .byte   $89
        cpy     #$09
        ldx     #$8A
        ldx     $8A
        .byte   $C7
        ora     #$EB
        .byte   $FC
        .byte   $4C
        .byte   $64
L14C1:  bvc     $1493
        bvc     $145D
        cli
        beq     L1520
        clc
        lsr     $18
        eor     L5660,y
        .byte   $44
        lsr     $48,x
        eor     L3CF7,y
        .byte   $04
        sbc     $DF53,x
        bmi     L14C1
        cpy     $F2
        lda     L3883
        cpy     #$4E
        eor     ($CC),y
        inc     $E3,x
        .byte   $EF
        .byte   $4F
        sty     $9F,x
        ldy     L0CE1
        dec     L604E
        bcs     L1490
        .byte   $64
        .byte   $1E
        .byte   $C2
L14F4:  nop
        tay
        .byte   $A7
        bit     $F538
        .byte   $A7
        .byte   $0B
        ora     L7EC1
        .byte   $6F
L1500:  .byte   $DC
        .byte   $6F
        sbc     $CB0D
        .byte   $5C
        ror     $6C
        .byte   $C0
L1509:  .byte   $5B
        .byte   $33
        asl     L0C5B
L150E:  .byte   $1C
        inc     $85
        .byte   $9E
        .byte   $DE
        .byte   $55
L1514:  lda     $A5C6,x
L1517:  .byte   $4F
        adc     #$47
        ror     $8E,x
        rti

        rol     $EF31,x
L1520:  .byte   $87
        .byte   $47
        stx     $7D,y
        bpl     L152C
        .byte   $74
        bcs     L15A7
        .byte   $13
        sbc     ($05),y
L152C:  iny
        cmp     ($4B,x)
        sed
L1530:  .byte   $C3
        lsr     L0A90
        .byte   $4F
        cpx     $0E
        .byte   $3C
        ora     $9373
        .byte   $0F
        cpy     #$AD
        .byte   $9C
L153F:  ldx     #$A1
        .byte   $BF
        lda     #$A2
        sbc     ($BF,x)
        .byte   $5B
        .byte   $AB
        dec     $2B
        .byte   $5B
        bcs     L1530
        .byte   $74
        lda     L5E6F,y
        ldx     $40
        .byte   $80
        rol     $29,x
        sta     L1E89,y
        pla
        ldx     $1B,y
        .byte   $7B
        .byte   $3B
        tya
        .byte   $93
        sty     $AA38
        .byte   $7C
        rol     $70
        dey
        ldy     $42
        pha
        cli
        cmp     #$00
        .byte   $44
        rti

        .byte   $4F
        ldx     #$85
        bvs     L15E6
        .byte   $F4
        sta     ($F2,x)
        inx
        bmi     L15F3
        .byte   $43
        .byte   $73
L157C:  .byte   $83
        .byte   $37
        .byte   $0B
        sbc     L150E,y
        sbc     $9D
        .byte   $52
        eor     ($0B),y
        .byte   $C3
        .byte   $34
        cli
        .byte   $C3
        jmp     (LC6E1)

        .byte   $7B
        .byte   $F4
L1590:  ror     $DB,x
        .byte   $3A
        adc     ($CB),y
        sta     $01A6
        .byte   $87
        sec
        ora     ($48,x)
        .byte   $04
        lda     $70,x
        rol     $53,x
L15A1:  .byte   $4B
        .byte   $A3
        .byte   $DB
        rol     a
        .byte   $14
        .byte   $6D
L15A7:  txs
        .byte   $44
        ror     $D9C6,x
        ora     ($3A,x)
        .byte   $A7
        cmp     ($15,x)
        lda     #$EA
        .byte   $8F
        lda     $A9,x
        dec     $DE,x
        jmp     L2549

        .byte   $53
        .byte   $FC
        .byte   $E2
        .byte   $9B
        lsr     $29,x
        rti

L15C2:  .byte   $DB
        .byte   $21
L15C4:  .byte   $0B
        ora     #$E9
        .byte   $3F
        .byte   $9B
        .byte   $D4
        sec
        sta     ($5A,x)
        .byte   $83
        rol     $04,x
L15D0:  eor     $B7E4,x
        .byte   $C7
        cpy     #$DE
        .byte   $62
        adc     L897B,y
        bvs     L15A1
        .byte   $D7
        ldx     $D84C,y
        .byte   $04
        sty     $72
        .byte   $4B
        .byte   $3C
        .byte   $8C
L15E6:  ldy     $67,x
        bne     L1631
        .byte   $7B
        cpx     $75
        .byte   $0B
        .byte   $C4
L15EF:  sty     $64
        .byte   $C7
        .byte   $1D
L15F3:  .byte   $9C
        and     $96E2,x
        tay
        asl     $65
        jsr     L400C
        iny
        .byte   $33
        lda     ($EC,x)
        bvs     L15C4
        lsr     L5AE8
        ora     ($D2,x)
        .byte   $ED
L1609:  .byte   $51
L160A:  inc     $4166
        .byte   $FC
        .byte   $77
        .byte   $57
        dec     $0E,x
        rol     $84,x
        .byte   $24
L1615:  eor     $7C,x
        sbc     $27
        .byte   $33
        rol     a
        iny
        adc     $CB1A
        .byte   $9F
        ldy     $FAD9
        dec     L0D6D
        .byte   $17
        ora     $DA81,x
        ldy     #$8D
        .byte   $22
        lsr     L62CA
        .byte   $FC
L1631:  .byte   $C2
        bvc     L160A
        brk
        lda     $D3D1
        .byte   $1F
        sta     ($C4),y
        eor     ($A6,x)
L163D:  and     ($46),y
L163F:  lda     $62,x
        lda     $20,x
        .byte   $74
L1644:  .byte   $5F
        .byte   $51
L1646:  .byte   $9B
        .byte   $73
        .byte   $97
        eor     ($4A),y
        cmp     ($06),y
        .byte   $53
        .byte   $C7
        tay
        ldx     #$3D
        .byte   $6B
        lda     $E8BF,x
        dec     $AF,x
        stx     $8A
        .byte   $5B
        lsr     $BDA6,x
        .byte   $53
        jmp     (LC1D9)

L1662:  .byte   $43
        .byte   $4F
        ror     L5E34
        .byte   $A3
        .byte   $22
        .byte   $97
        cpy     #$7B
        txs
        .byte   $9B
        .byte   $BB
        lda     ($A8,x)
        .byte   $17
        .byte   $64
        clv
        .byte   $DF
        rti

        .byte   $22
        .byte   $C7
        .byte   $82
        .byte   $54
        asl     a
        .byte   $14
        adc     L2678
        sbc     L46C6,x
        clc
        and     $DA
        dec     $6C
        .byte   $52
L1688:  .byte   $FF
        .byte   $1B
        .byte   $9F
        .byte   $7C
        .byte   $CF
        sta     ($4E),y
        .byte   $9B
        dec     $EA59,x
        ldy     #$00
        sty     $02B3
        sty     L4FB2
        .byte   $DB
        brk
        rol     $D7
        cpx     $C9
        .byte   $52
        rol     $2C,x
        ror     $81
        .byte   $DB
        and     $83
L16A9:  ora     $C935,x
        .byte   $D3
        ora     $0462,x
        bcc     L16E3
        cmp     #$F0
        cli
        tya
        dec     $04
L16B8:  jmp     L335E

        .byte   $6F
        ora     #$F6
        sta     $9445,y
        cpx     #$5E
        ora     ($B5,x)
        jsr     LCC2C
        .byte   $D3
        .byte   $1C
        nop
        bvs     L16D0
        .byte   $67
        .byte   $8E
        .byte   $DF
L16D0:  lda     L1437,y
        sta     L340E,y
        .byte   $41
L16D7:  sty     $34
        dec     $D9D9
        asl     a
        cpy     L1A3E
        lda     $C1F6
L16E3:  .byte   $E3
        .byte   $7C
        rti

        adc     $40
        .byte   $92
        .byte   $BB
        .byte   $3D
        .byte   $B5
L16EC:  ldy     #$14
L16EE:  sta     ($52),y
        .byte   $5F
        dec     $6E
        .byte   $BB
        .byte   $B3
        cmp     $A3,x
        sta     $937A
        .byte   $04
        cpy     $F0F4
        lda     $D6,x
        .byte   $80
        and     $AF49
        ora     L1D0C,x
        .byte   $5A
        .byte   $07
        bpl     L1776
L170B:  .byte   $DC
        .byte   $A7
        sty     $ED,x
L170F:  .byte   $07
        txs
        .byte   $6B
        .byte   $42
        jmp     L1F7C

        pha
        .byte   $AD
L1718:  lda     ($EB),y
        sty     $BB
        lda     L53E6,x
        .byte   $16
L1720:  .byte   $C7
        .byte   $BB
        .byte   $3F
        .byte   $A5
L1724:  .byte   $3B
        .byte   $E2
L1726:  .byte   $A0
L1727:  sta     $FA,x
        sei
        tay
        .byte   $34
        inc     $DE,x
        .byte   $62
        asl     $FB2E
        .byte   $2C
        .byte   $90
L1734:  .byte   $12
        ora     #$E6
        lda     #$3D
        sta     $DCB7,x
        .byte   $6F
        sta     L3FE1,x
L1740:  brk
        dec     $EB
        adc     L8D59,y
        bpl     L1726
        .byte   $64
        .byte   $47
        lsr     $CD,x
        .byte   $6E
        .byte   $7D
L174E:  sbc     ($A4),y
        .byte   $02
        tya
        iny
        .byte   $37
        .byte   $52
        ora     #$D1
        bcs     L16EE
        ror     $D898
        sbc     $AD
        cpx     $02
        .byte   $74
        ldy     $D00D,x
L1764:  .byte   $1F
        jsr     L1FDA
        bcc     L179B
        .byte   $47
        dey
        .byte   $D4
        .byte   $E7
        .byte   $64
        ror     $E4
        jmp     (L4CFC)

        plp
        .byte   $E4
L1776:  cmp     #$67
        .byte   $22
        cpx     $A5
        sta     $9156
        ldy     $75,x
        .byte   $47
        lsr     L19AA,x
        nop
        .byte   $A3
        .byte   $9F
        .byte   $AB
        and     $B5FA,y
L178B:  .byte   $9F
        ldy     L40F0,x
        pha
        ora     $E3FB
        .byte   $E7
        .byte   $E5
L1795:  .byte   $14
        .byte   $52
        and     $92A4,x
        .byte   $26
L179B:  sei
        brk
        stx     $ACC7
        .byte   $07
        clc
        lda     L72ED
        sty     $DC,x
        ror     $DC,x
        .byte   $52
        adc     ($A0,x)
L17AC:  .byte   $DB
        tya
        bit     L5E41
        .byte   $3A
        .byte   $CF
        .byte   $04
        cpy     $E108
        ora     ($BA,x)
        .byte   $6B
        sbc     L76A6,y
        sta     ($95,x)
        pha
        ora     #$62
        bvc     L17AC
        .byte   $15
L17C5:  bcs     $1767
        .byte   $D2
        .byte   $92
        .byte   $72
        cmp     ($8D,x)
        lda     ($64),y
        .byte   $C3
        .byte   $A7
        .byte   $2B
        lsr     $DC89
        .byte   $D2
        .byte   $FF
L17D6:  .byte   $87
        .byte   $53
        ora     L6AAC,x
        adc     L36B1,y
        ldy     L60CD
        adc     $10,x
        .byte   $12
        ora     #$C5
        .byte   $67
        stx     $30,y
        .byte   $6F
        cpy     $90
        tya
        .byte   $42
L17EE:  .byte   $39
        .byte   $F1
L17F0:  .byte   $63
        .byte   $FA
L17F2:  .byte   $12
        .byte   $04
        .byte   $7B
        .byte   $3F
        .byte   $72
        .byte   $42
        adc     ($A4),y
        and     ($5A,x)
        lda     ($DA,x)
        .byte   $63
        .byte   $33
        ldy     L4B91
        brk
        rol     $C608,x
        clc
        rol     a
        pha
        .byte   $3A
        sbc     #$E6
        rts

        clv
        clc
        lda     $EF5A
        sei
        eor     $BE
        .byte   $F7
        sty     $6B
        .byte   $1C
        cmp     $BC7E
        .byte   $D4
        sei
        .byte   $F3
        lda     $8B
        sbc     ($DF),y
        bpl     L17F0
        rti

        .byte   $2B
L1828:  and     $E4B9,x
        .byte   $92
        lda     $8C
        sta     $E35D
        asl     $C7A3,x
        .byte   $89
        jsr     L9C17
        cpy     $F6B5
        .byte   $37
        .byte   $CE
L183D:  cpx     #$4A
        ldx     L0954,y
        adc     ($99),y
        .byte   $57
        .byte   $5B
L1846:  eor     ($DE),y
        .byte   $9C
        adc     $E7F7,y
        .byte   $1B
        ora     $BA,x
        ldy     $92AC
        sbc     $A002
        .byte   $14
L1856:  plp
        .byte   $D2
        stx     $D5
        sec
        .byte   $93
        .byte   $B2
        .byte   $F7
L185E:  eor     ($F0,x)
        .byte   $04
        cmp     #$4F
        bne     L1879
        .byte   $B2
        .byte   $F3
        jmp     L0BD0

L186A:  lda     $D6,x
        .byte   $54
        ora     L4030,y
        ror     $D6,x
        .byte   $EB
        adc     $71
        .byte   $14
        cpx     #$3A
        .byte   $02
L1879:  ldx     $4B,y
        dec     $CC52,x
        .byte   $52
        beq     L1828
        jsr     L9FE2
        ldx     L4C70
        .byte   $07
        lda     LE059
        .byte   $D7
        lsr     a
        .byte   $1B
        and     ($89),y
        .byte   $F2
        .byte   $C7
        .byte   $7B
        ldy     L3235
        .byte   $44
        lda     ($A6),y
        .byte   $59
L189A:  cpy     #$07
        cpx     #$4B
        cpy     #$CF
        .byte   $1A
        lda     $6A,x
        .byte   $B7
        .byte   $3A
        .byte   $12
        .byte   $1A
        tay
        lda     $EC5D
        .byte   $43
        .byte   $EB
        ora     ($03,x)
        sty     $C508
        .byte   $0F
        .byte   $0F
        bvc     L1904
        lda     L866C
        nop
        bvc     L18F6
        cmp     $F612
        .byte   $E3
        cpy     L285D
        .byte   $03
        lsr     $26
        .byte   $A3
        .byte   $5C
        sbc     ($0E,x)
L18CA:  dec     $9B,x
        .byte   $2F
        ora     $A6,x
        .byte   $73
L18D0:  sta     $A2
        ldx     $FC,y
        .byte   $2F
        cpx     #$3A
        ldy     $5A,x
        beq     L18D0
        php
        .byte   $F4
        .byte   $B4
L18DE:  .byte   $80
        .byte   $EB
        rol     $AB,x
        .byte   $DB
        .byte   $8F
        .byte   $8B
        eor     #$E8
        cmp     $BE
        lda     L8028
        rol     a
        .byte   $74
        .byte   $BF
        rti

        ora     #$33
        bvs     L18F9
L18F4:  bpl     L1917
L18F6:  sbc     $90,x
        iny
L18F9:  ora     #$20
        rol     $9FA4
        inc     $3C,x
        sta     L320A,y
        .byte   $30
L1904:  ora     ($74,x)
        .byte   $3B
        ldy     $DB00,x
        .byte   $6F
        eor     L7E7B,y
        ora     $FB0F,y
        .byte   $1B
        .byte   $0F
        .byte   $FB
        rti

        .byte   $99
        .byte   $04
L1917:  .byte   $EB
        .byte   $65
L1919:  stx     $9119
        and     #$76
        .byte   $6F
        ora     $B0,x
        .byte   $EB
        adc     L6FBE,x
        stx     $48,y
        lda     L1500,x
        bvc     L1998
        dec     $2F
        sta     $61
        .byte   $35
L1931:  .byte   $27
        sty     $EBA9
        cmp     #$FA
        .byte   $AB
        ldx     L4D6A,y
        sei
        .byte   $F3
        sty     $38
        .byte   $DF
        .byte   $A3
        lda     $8F82,x
        dex
        .byte   $3F
        .byte   $53
        .byte   $3B
        .byte   $C7
        jmp     (L825F)

        ora     L0A02
        .byte   $E3
        ldx     $2B
        tax
        .byte   $F2
        jsr     L8852
        ora     ($9C),y
        sta     ($59),y
        pha
        asl     $C7
        .byte   $4C
L195F:  ldy     $04
        .byte   $72
        .byte   $50
L1963:  adc     $20
        .byte   $0B
        .byte   $92
        .byte   $B7
        and     #$00
        .byte   $91
L196B:  stx     $0C
        .byte   $93
        ora     #$48
        ora     ($E4,x)
        sta     L5330,x
        and     ($34,x)
        dex
        .byte   $1B
        cpy     $9A
        ora     L40F0,x
        .byte   $F7
        and     #$20
        .byte   $C2
        asl     $FBF0,x
        tay
        lda     #$10
        bit     L62A9
        txa
        adc     ($1E,x)
        .byte   $54
L198F:  sta     L3D68,y
        and     ($93),y
        .byte   $54
        iny
        sta     $15
L1998:  ldy     #$5A
        .byte   $C7
        .byte   $23
        .byte   $1F
        tsx
        .byte   $03
        dex
        iny
        lda     #$65
        jsr     L1E9D
        lda     #$6C
        .byte   $20
        .byte   $1F
L19AA:  .byte   $23
        jmp     LE3B3

        iny
        .byte   $83
        lda     L4630
        sty     L48D3
        pla
L19B7:  jmp     LDCCE

        beq     L1A28
        .byte   $E3
        .byte   $89
L19BE:  .byte   $A3
        .byte   $03
        sei
        .byte   $E1
L19C2:  .byte   $E3
        .byte   $47
L19C4:  .byte   $51
L19C5:  .byte   $3A
        .byte   $3A
        .byte   $1E
        .byte   $9E
L19C9:  .byte   $02
        .byte   $16
L19CB:  .byte   $0C
L19CC:  inc     a:$BE,x
        cmp     $A4,x
        .byte   $9B
        .byte   $F5
L19D3:  iny
        ora     L1688,x
        cmp     ($2E,x)
        .byte   $DB
        rti

        and     ($86,x)
        bcc     L19FD
        jmp     (L2B8F)

        .byte   $A3
        jmp     (LCE7B)

        .byte   $3F
        .byte   $3C
        plp
        .byte   $82
        .byte   $13
        .byte   $B3
        dec     $40
        .byte   $10
L19EF:  adc     ($B7,x)
        .byte   $3C
        .byte   $1A
        .byte   $9B
        .byte   $B3
        .byte   $C7
        eor     ($5A),y
        asl     $F114,x
        .byte   $0D
        .byte   $6B
L19FD:  bcs     L1A57
        dec     $0560,x
        .byte   $77
        dec     $21
        .byte   $4F
        .byte   $3A
        and     ($3D),y
        .byte   $3C
        .byte   $1F
        .byte   $A7
L1A0C:  .byte   $83
        .byte   $F2
        lda     #$E8
        .byte   $A3
        .byte   $D4
        asl     $D5CB
        .byte   $92
        .byte   $8F
        bvc     L1A24
        .byte   $2F
        bvc     L19C4
L1A1C:  sbc     $A3,x
        inc     $9B
        sta     $69
        bmi     L19C5
L1A24:  dec     $21
        tsx
        .byte   $23
L1A28:  .byte   $D4
        .byte   $E3
        sta     $06,x
        lda     L79D7,x
        bvc     L19D3
        inc     L1E56
        ora     L7254,y
        .byte   $B2
L1A38:  cld
        sei
        .byte   $32
L1A3B:  cmp     ($E1),y
        .byte   $05
L1A3E:  brk
        .byte   $D4
        cmp     #$95
        bit     $CC
        clv
        .byte   $80
L1A46:  adc     L3FAF,y
        bit     L79CE
        .byte   $37
        and     $FE95,y
L1A50:  .byte   $BE
L1A51:  lda     ($07,x)
        sbc     L12F8,x
        .byte   $F2
L1A57:  .byte   $E3
        dec     L28AA,x
        bvc     L1ACD
        .byte   $93
        eor     ($21),y
        lsr     $D905,x
        .byte   $B2
        .byte   $82
        sec
        beq     L1A74
        cmp     #$40
        bne     L1A85
L1A6C:  stx     $C57A
        php
        .byte   $FB
        clv
        .byte   $72
        .byte   $69
L1A74:  adc     ($36,x)
        .byte   $A7
L1A77:  rol     $F4
        cmp     #$5D
        cmp     $F4
        .byte   $5A
        .byte   $F3
        jsr     L62E8
        .byte   $F3
        and     ($51,x)
L1A85:  adc     ($48),y
        ldx     #$A0
        and     ($4D,x)
        eor     $AF57,y
        cmp     $21
        .byte   $04
        .byte   $BF
        .byte   $FC
        .byte   $2B
        cli
        .byte   $39
L1A96:  bvs     $1A91
        ldy     $CC
        .byte   $FB
        .byte   $AD
        cli
L1A9D:  rol     $D3,x
        .byte   $80
        .byte   $2B
        .byte   $3C
        brk
        .byte   $12
        ora     $EC
        inc     $C9
        rti

        ora     $92
        and     L1720,x
        sta     ($92),y
        adc     L0C20,y
        .byte   $9F
        ror     a
        .byte   $DA
        bcc     L1AB9
        .byte   $D6
L1AB9:  .byte   $44
        .byte   $C2
        rts

        cmp     $C307,y
        iny
        .byte   $D1
L1AC1:  sta     $4DBD,y
        .byte   $54
        .byte   $77
        cmp     #$35
        tay
        .byte   $80
        rol     $88
        .byte   $E9
L1ACD:  cmp     #$02
        sty     $6E,x
        .byte   $1C
        adc     $AB,x
        .byte   $9B
        .byte   $14
        .byte   $83
        .byte   $D2
        .byte   $D3
        tsx
        .byte   $93
        .byte   $D7
        iny
        .byte   $93
        .byte   $6B
        ldy     #$34
        lsr     $D86A
        rol     $04,x
        bvc     L1AC1
        .byte   $4F
        eor     $FE
        .byte   $64
        adc     $D590,x
        .byte   $C7
        sty     $44,x
        eor     ($2F,x)
        .byte   $F2
        ror     $B8F5
        dec     $3F,x
        and     $9F
        adc     #$E8
        .byte   $BF
        .byte   $3A
        ldy     #$05
        pha
        php
        .byte   $E7
        inx
        ror     $7E,x
        sta     $D0
        brk
        .byte   $64
        ldx     $B76F
        sta     ($26),y
        .byte   $47
        bpl     L1B86
        pha
        adc     #$19
        rol     $B1,x
        .byte   $5C
L1B1A:  .byte   $FA
        ora     $1A
        beq     L1B20
        .byte   $2C
L1B20:  eor     $027D
        .byte   $37
        bit     $CAB1
        cmp     $2F,x
        .byte   $22
        pla
        lda     $C907,y
        and     $80,x
        lda     L6E62
        lda     $99,x
        lsr     $44,x
        cmp     $C0
        lsr     $C200
        .byte   $93
        .byte   $14
        .byte   $DA
        .byte   $93
        .byte   $3E
        .byte   $24
L1B42:  cmp     L8C22,y
        dec     $9190
        asl     $4C,x
        .byte   $EB
        .byte   $1F
        and     L39E4,x
        .byte   $23
        ldy     $FF7C
        .byte   $A7
        iny
        .byte   $6B
        .byte   $3A
        .byte   $1A
        .byte   $E3
        .byte   $37
        jsr     LD6CA
        and     ($4C,x)
        .byte   $87
        jsr     LCFAC
L1B63:  eor     L4146,x
        .byte   $E7
        .byte   $87
        ldx     $DF4A
L1B6B:  sta     ($5E,x)
        eor     #$D7
        sta     ($56,x)
        lsr     a
        .byte   $FF
        .byte   $80
        inc     L7F49
        .byte   $80
        inc     $4A
        .byte   $F7
        .byte   $80
        ror     $F54E,x
        .byte   $32
        .byte   $F2
        eor     ($27,x)
        ora     ($BA,x)
        .byte   $AB
L1B86:  cld
        .byte   $B2
        .byte   $2F
        ora     $CA32
        sta     ($C4),y
        .byte   $FD
        .byte   $1D
L1B90:  .byte   $4F
        cmp     ($14),y
        sbc     L4F12,x
        .byte   $D1
L1B97:  ldy     $FD,x
        .byte   $1A
        lsr     $61,x
        adc     $290F,y
        dey
        ldx     $62
        cld
        .byte   $03
        .byte   $0C
        .byte   $34
        bcc     L1C1D
        sbc     $A0
        ora     $CC0A,y
L1BAD:  sta     L0ABB,x
        stx     $F497
        .byte   $82
        .byte   $27
        ror     a
        tax
        .byte   $32
        .byte   $2F
        eor     ($2E,x)
        .byte   $64
        .byte   $3F
        .byte   $72
        ldx     #$33
        ora     ($87,x)
        .byte   $43
        cmp     $8FA0
        .byte   $5E
        .byte   $E0
L1BC8:  .byte   $F7
        inc     L630E
        .byte   $42
        .byte   $12
        .byte   $20
L1BCF:  .byte   $8D
        .byte   $92
L1BD1:  eor     #$1A
        sty     L4DFA
        sta     ($04,x)
        eor     $27,x
        .byte   $E7
        .byte   $14
        cpx     L1078
        eor     ($94,x)
        eor     $F74C
        .byte   $C7
        lda     L7725,x
        and     L253D,y
        lda     $F52F
        and     $AE
        clc
        ora     $25,x
        ora     ($40,x)
        .byte   $44
        ldy     $15
        adc     #$3F
        tay
        cpx     $05
        lda     ($2C),y
        adc     $53
        .byte   $A1
L1C02:  lsr     $4609
        stx     $F7,y
        .byte   $43
        cpx     #$5E
        sta     ($69),y
        dec     $D0
        sta     ($48),y
        .byte   $04
        cmp     ($92),y
        and     $29,x
L1C15:  brk
L1C16:  txs
L1C17:  asl     L4281
        rti

        .byte   $53
        .byte   $34
L1C1D:  adc     ($79,x)
        stx     $4A
        ora     ($59,x)
        rol     a
        .byte   $7B
        eor     $02
L1C27:  sta     $D3F4,x
        sta     ($FB,x)
L1C2C:  ror     L2917
        php
L1C30:  .byte   $5C
        .byte   $B4
L1C32:  .byte   $9B
        .byte   $C2
        adc     $DA
        .byte   $DC
        lda     ($4C,x)
        .byte   $0C
        .byte   $33
        sed
        .byte   $04
        .byte   $67
        .byte   $32
        .byte   $44
        .byte   $23
        .byte   $C4
L1C42:  ora     ($2B,x)
        .byte   $92
        .byte   $BD
L1C46:  dex
        and     ($31,x)
        .byte   $47
        inc     $C1
L1C4C:  .byte   $F3
        .byte   $97
        adc     L1B6B
        ldy     L11B5,x
        ora     $4E,x
        .byte   $43
        sta     L1919,x
        tya
        cpy     L380E
        pla
        .byte   $67
L1C60:  .byte   $27
        .byte   $B3
        clc
        ldx     $9544
        .byte   $24
L1C67:  .byte   $0C
        .byte   $77
        clv
        adc     $39,x
        .byte   $07
        jmp     L232B

L1C70:  .byte   $82
        ror     $8A,x
        sty     $F0F9
        lda     ($D6),y
        .byte   $80
L1C79:  .byte   $77
        cmp     $C0
        bne     L1C17
        ror     $D74D,x
        cmp     $A246
L1C84:  .byte   $13
        .byte   $13
        iny
        tay
        .byte   $DB
        ldy     $BE
L1C8B:  sec
        .byte   $ED
        .byte   $A2
L1C8E:  bvs     $1CC6
        sta     $2D3B
L1C93:  sed
        .byte   $93
        bne     L1C8B
        .byte   $A3
        jmp     (L5600)

        pla
L1C9C:  rol     $2C,x
        and     L1734,x
        sta     L4383,x
        .byte   $13
        cpy     $19
        asl     L099F,x
        lsr     $38
        .byte   $C3
        ror     L183D
        .byte   $7A
        jsr     L6E52
        .byte   $CF
        .byte   $63
        .byte   $E7
        sec
        asl     a
        rti

        .byte   $1F
        .byte   $2B
        .byte   $43
        cmp     L4E8F,x
        dey
        cpx     L25C0
        bpl     L1D1C
        .byte   $87
        sta     ($9E,x)
        rti

        brk
        plp
        .byte   $02
        cpy     $75
        .byte   $93
        sta     L2F8B,y
        cmp     $FC79,y
        .byte   $B2
        inc     L8607,x
        bvc     L1C70
        .byte   $3C
        ora     L595A,y
        .byte   $9E
        inc     $B0,x
        .byte   $93
        .byte   $64
        .byte   $E2
        .byte   $97
        .byte   $EF
        sta     $BC,x
        .byte   $F7
        .byte   $7F
        and     L1B63,y
        sbc     $A0
        bne     L1CFD
        .byte   $4F
        .byte   $0C
        .byte   $DC
        .byte   $80
        rol     $6C
        cmp     $3E,x
        .byte   $D4
        .byte   $C0
L1CFD:  .byte   $CF
        .byte   $17
        .byte   $0F
        bpl     L1D17
        ror     a
        ror     L7DE8,x
        .byte   $A7
        tay
        .byte   $6E
        .byte   $4C
L1D0A:  .byte   $04
L1D0B:  .byte   $81
L1D0C:  sbc     L3743,x
        .byte   $E7
        .byte   $52
        txa
        .byte   $06
L1D13:  .byte   $EE
        .byte   $B6
L1D15:  sbc     ($10),y
L1D17:  .byte   $DF
        .byte   $5F
        .byte   $44
        lsr     a
        .byte   $7D
L1D1C:  inc     L1C4C,x
        .byte   $74
        lda     #$FE
        lda     #$9C
        adc     $DBBE
L1D27:  dec     $A0C8,x
        .byte   $43
        cmp     L3D1D,x
        .byte   $1C
        .byte   $3C
        txa
        eor     $FE,x
        bvc     L1D95
        bit     $40
        cpy     $47
        cld
        .byte   $F4
        .byte   $9C
        .byte   $47
        and     ($EF),y
        .byte   $5F
        cmp     $1F,x
        rol     L5397,x
        .byte   $1C
        .byte   $91
L1D47:  lda     $499A
        bpl     $1CDC
        .byte   $17
        adc     $07
        cmp     $4A,x
        rti

        eor     #$80
        tya
        asl     a
        .byte   $89
        stx     $3D
L1D59:  sta     L0060,x
        .byte   $12
        rti

        dey
        pha
L1D5F:  sta     L46AA,y
        tya
        .byte   $14
L1D64:  eor     #$92
        .byte   $41
L1D67:  cpx     #$4B
        .byte   $93
        rol     a
L1D6B:  .byte   $0F
        .byte   $02
L1D6D:  clc
        stx     $02C4
        cmp     #$28
        bne     L1D78
        lda     $88,x
        .byte   $67
L1D78:  .byte   $FA
        sed
        .byte   $23
        and     $59
        ora     $99B2,x
L1D80:  pha
        and     $C8,x
L1D83:  sty     $64,x
        .byte   $7C
        cmp     ($A9),y
L1D88:  lsr     $49
        .byte   $80
        adc     $058F
        lda     $5E,x
        cpy     #$74
        .byte   $5F
        .byte   $DE
        .byte   $1E
L1D95:  sty     $2C,x
        .byte   $14
        bvs     L1D6D
        .byte   $56
L1D9B:  adc     ($C0),y
        ora     ($55),y
        inc     $FD
        .byte   $17
        sta     $1E
        ora     ($10,x)
        .byte   $43
        cli
        ora     $E417,x
        .byte   $1C
        cmp     $46,x
        cpx     $87
        inx
        ora     $D5
        .byte   $C7
        sbc     L1D47,x
        lsr     $D621,x
        asl     L2021,x
        rol     $5E,x
        rol     $14,x
        ora     L7A21,y
        brk
        .byte   $D4
        lda     #$55
        adc     ($06),y
        .byte   $47
        lda     $24,x
        sbc     ($07,x)
        ora     ($35),y
        .byte   $87
        bit     $5C
        .byte   $DB
        .byte   $54
        dex
        .byte   $B7
        lsr     $91
        .byte   $6F
L1DDB:  sec
        .byte   $0B
        .byte   $37
        lsr     a
        asl     a
        sbc     ($65,x)
        sta     ($A2,x)
        .byte   $9B
        dec     $A20D
        .byte   $29
L1DE9:  .byte   $42
        tay
        tya
        ora     $D7AA,x
        .byte   $AE
        .byte   $A3
L1DF1:  tay
        .byte   $1A
        .byte   $A3
        cmp     $81,x
        .byte   $22
        ldx     L5A60
        php
        .byte   $74
        plp
        cmp     $B4,x
        .byte   $C7
        sec
        sbc     L6C8C
        cld
        inc     L20F0
        .byte   $97
        sta     ($37,x)
        cmp     #$6A
        and     $EB,x
        cmp     ($13,x)
        txa
        inc     L16B8,x
        .byte   $EB
        .byte   $04
        .byte   $93
        .byte   $DA
        ldx     $0380,y
        stx     $31,y
        jsr     LA0D7
        tax
        sta     L6644
        eor     ($69),y
        cpx     #$99
        ldx     $9148,y
        ror     L536B
        .byte   $33
        clc
        sty     $51,x
        cld
L1E34:  .byte   $0B
        .byte   $67
L1E36:  ror     $45
        clv
        .byte   $0B
        ora     $9F
        .byte   $0D
        .byte   $34
L1E3E:  .byte   $8B
        .byte   $6F
        .byte   $83
        .byte   $5F
        .byte   $D2
        ldy     $40
        .byte   $44
        .byte   $3F
        inx
        ror     $D2,x
        .byte   $A1
L1E4B:  ora     $22
        .byte   $09
L1E4E:  .byte   $37
        rol     a
        eor     $D635
        inc     L0909
L1E56:  eor     #$05
        .byte   $27
        sbc     ($A9),y
        sbc     $5B,x
        ldy     $9E,x
        sbc     $BB,x
        jmp     (L3B7E)

        sbc     ($54),y
        .byte   $67
        rol     $7B
        and     $42,x
        iny
        rti

        .byte   $E7
        .byte   $4B
        cmp     ($8E,x)
        adc     $00,x
L1E73:  .byte   $04
        cmp     L1740
        .byte   $12
        .byte   $F7
        .byte   $27
        .byte   $23
        .byte   $8F
        ora     $64,x
L1E7E:  ror     L1FDB
        .byte   $89
        stx     L8AAA
        bmi     L1EA8
        .byte   $71
L1E88:  .byte   $06
L1E89:  .byte   $3F
        bvc     L1E34
        .byte   $9F
        .byte   $5F
        .byte   $36
L1E8F:  jsr     $AEEA
        .byte   $BB
        .byte   $B3
        .byte   $74
        .byte   $6B
L1E96:  .byte   $BF
        .byte   $7B
        .byte   $14
        .byte   $42
        .byte   $E3
        .byte   $8E
        .byte   $54
L1E9D:  dec     $52
        cli
        bit     $D192
        rol     a
        txs
        .byte   $32
        .byte   $42
        .byte   $19
L1EA8:  cpy     $CE
        cpy     $95
        txs
        ora     L630D
        .byte   $DF
        ldy     $9895
        .byte   $4B
        .byte   $27
        jmp     LD4BC

        eor     ($52),y
        .byte   $4B
        eor     $D5EC
        .byte   $02
        adc     $A954,x
        adc     $D68E,x
        .byte   $A9
L1EC7:  .byte   $9C
        .byte   $AD
L1EC9:  .byte   $3C
        .byte   $04
        .byte   $F3
        .byte   $93
        cpx     #$E2
        sty     $D7,x
        ldy     $22
        .byte   $14
        dec     $94,x
        .byte   $DB
        ldy     $02
L1ED9:  .byte   $14
        cmp     $9D49,y
        .byte   $04
        lda     $DA,x
        rts

L1EE1:  eor     $DB88,x
        cpx     #$29
        sta     $1D,x
        ldx     $EE
        .byte   $3C
        .byte   $37
        cmp     $49
        ldy     $DF
L1EF0:  bpl     L1F4C
        ora     L81A9,x
        sbc     $2C
        .byte   $02
        clc
        .byte   $7C
        .byte   $4B
        ora     $26,x
        bit     $B5
        ror     L1D83
        sta     $D8E9,y
        .byte   $99
        .byte   $FE
L1F07:  brk
        lda     $F6C9,x
        iny
        .byte   $1A
        .byte   $9F
        pla
        .byte   $DB
        inc     $924E
        dec     $AF17
        asl     $23
        .byte   $3B
        .byte   $13
        .byte   $47
        ora     $13
        .byte   $3A
        ror     $C6C2,x
        sty     $FB56
        sbc     $B7
L1F26:  .byte   $CF
        .byte   $7F
        .byte   $5B
        sbc     ($96),y
        .byte   $DF
        .byte   $74
        .byte   $63
L1F2E:  cmp     $4D
        ldy     #$1F
        .byte   $4B
L1F33:  .byte   $1C
        .byte   $AC
L1F35:  txa
        cli
        .byte   $D4
        stx     $F00E
        .byte   $02
        .byte   $37
        .byte   $3F
        .byte   $63
        .byte   $BB
        sbc     $80
        .byte   $7A
        rol     $E7
        stx     $77,y
L1F47:  eor     $C4DC,x
        .byte   $0E
        .byte   $05
L1F4C:  .byte   $B2
        txs
        .byte   $E2
        stx     $58
        .byte   $B2
        .byte   $9B
        .byte   $62
        .byte   $87
        ora     $B4,x
L1F57:  brk
        ora     $98
L1F5A:  rts

        jsr     LAC03
        lda     $00
        clc
L1F61:  dey
        .byte   $64
        php
        .byte   $43
        .byte   $FA
        brk
L1F67:  .byte   $7B
        .byte   $13
        .byte   $52
        .byte   $54
        ora     $18
        .byte   $D4
        .byte   $53
        sbc     L5813,y
        sta     ($0D,x)
        adc     L1EE1,y
        .byte   $5F
        sbc     ($2A,x)
        .byte   $53
        .byte   $34
L1F7C:  .byte   $6F
        .byte   $97
        sbc     #$48
        clc
        .byte   $4E
        .byte   $93
L1F83:  .byte   $1C
        .byte   $F4
        .byte   $47
        .byte   $52
        .byte   $6E
L1F88:  bne     L1F9B
        ror     L13D8
        .byte   $1F
        .byte   $52
        and     ($A8),y
        eor     $919A,y
        lda     ($D9,x)
        cmp     #$F6
        ldy     $C9
        .byte   $F2
L1F9B:  lsr     $4B,x
        ror     $45,x
        .byte   $64
        sbc     $71,x
        eor     $44
        .byte   $1C
        sbc     $D655
        adc     L8319,y
        inc     $EB,x
        and     ($9B,x)
L1FAF:  lda     #$D0
        php
        jsr     LFFE4
        .byte   $67
        brk
        .byte   $AF
        sta     $30,x
        and     ($A9),y
        cpy     #$84
        .byte   $1C
        jsr     L1E4E
        .byte   $1A
        ora     ($55,x)
        lda     #$ED
        txs
        .byte   $9C
        .byte   $32
        asl     L0C23,x
        .byte   $E2
L1FCE:  .byte   $8F
L1FCF:  eor     L4919
        .byte   $17
L1FD3:  ora     $9B,x
        ldy     #$05
        jsr     LEA3E
L1FDA:  .byte   $70
L1FDB:  .byte   $E2
        dec     $48
        asl     a
        jmp     L4532

        pha
        .byte   $07
        .byte   $3C
        adc     $4E
L1FE7:  bit     L805D
        .byte   $35
L1FEB:  .byte   $63
        .byte   $32
        cpx     $D19B
        dey
        jmp     L1EC9

        ldy     $C5
        and     ($94),y
        tsx
        adc     #$33
        dec     $22
        .byte   $13
        .byte   $52
        bmi     L2072
        .byte   $DA
        .byte   $9E
        eor     ($B9),y
        inc     $C6E3
        eor     #$4B
        ora     L0D85,x
        cpy     L6A1C
L2010:  adc     L83A9,y
        .byte   $37
        bit     $0B
        .byte   $C3
        .byte   $E9
L2018:  .byte   $C7
        .byte   $92
        sbc     $C83D
        .byte   $2F
L201E:  .byte   $89
        nop
        .byte   $72
L2021:  sta     L74E6,y
        .byte   $02
        sta     $1C
        .byte   $67
        .byte   $0F
        .byte   $3B
        ror     $D4
        .byte   $EB
        .byte   $74
        .byte   $EB
L202F:  .byte   $17
        .byte   $34
        .byte   $57
        .byte   $42
        .byte   $44
        .byte   $6F
        .byte   $B7
        clc
        .byte   $EF
        .byte   $1C
        .byte   $63
        .byte   $DF
        .byte   $47
L203C:  .byte   $1F
        .byte   $23
        .byte   $5F
        .byte   $7C
        sta     $8C
        ora     L1EF0,x
        .byte   $8F
        .byte   $34
        ora     $13
        .byte   $0F
L204A:  .byte   $7C
        .byte   $1F
        .byte   $A3
        ora     L3930
        lda     ($96,x)
        .byte   $34
        .byte   $A3
        cmp     $B926
        cmp     $B895
        .byte   $32
        .byte   $80
        cli
        .byte   $97
        sta     ($41,x)
        cpx     $1A
L2062:  stx     $24,y
        clv
        adc     $A92A,y
        beq     L20A3
        .byte   $AB
        .byte   $8F
        tax
L206D:  .byte   $73
        .byte   $F3
        .byte   $87
        .byte   $59
        .byte   $CD
L2072:  cld
        .byte   $54
        ldy     $D8,x
        .byte   $53
        dec     $F5
        bit     $5C
        .byte   $62
        .byte   $1B
        lsr     $44
        lda     #$7F
        .byte   $BC
        .byte   $0B
L2083:  lda     #$11
        pla
L2086:  sbc     ($1D),y
        .byte   $A3
        dec     $2A
        ldx     #$E6
L208D:  cpy     $46
        ora     ($AC,x)
        lsr     $B6
        .byte   $DC
L2094:  pha
        .byte   $A9
L2096:  ror     a
        rol     $E069,x
        and     #$D8
        ldy     $20
        jsr     L2933
        ldx     $AB,y
L20A3:  ldx     $57,y
        ldy     $F0
        jsr     L343C
        lda     ($E5),y
        .byte   $EB
        ora     $C396,x
        lsr     L32B3
        inc     $97
        cmp     ($9B,x)
        .byte   $C2
        dey
        dex
        ldy     $A3
        .byte   $80
        ldy     L1C42,x
        clc
        dec     L51B6
        ldx     L59BA,y
        .byte   $47
        sec
        lda     $9FCF
        rol     a
        lda     ($EE,x)
        and     #$F3
        adc     L3497,y
        .byte   $07
        adc     $B374,y
        sec
        .byte   $7B
        .byte   $89
        lda     L5627,x
        and     $34
        .byte   $42
        .byte   $3F
        bit     $F2
        .byte   $93
        .byte   $06
L20E6:  txa
        .byte   $5B
        asl     a
        and     ($BF,x)
        .byte   $9C
        ldx     $D8
        .byte   $3B
        .byte   $2E
L20F0:  .byte   $B7
        sei
        .byte   $3F
        .byte   $12
        ora     ($E6),y
        .byte   $39
L20F7:  .byte   $52
        .byte   $43
        ora     L5B4C
        .byte   $34
        .byte   $82
        cpy     $E3
        php
        .byte   $23
L2102:  stx     L1D0A
        ora     $A7DE
        .byte   $EB
        sta     $DD,x
        .byte   $6B
        .byte   $0C
        .byte   $5F
        ror     $CC8A
        dec     $DB80,x
        lsr     a
        sbc     #$B9
        .byte   $FB
        eor     #$FA
        .byte   $CF
        .byte   $3B
        sty     $DB88
        rol     L130D,x
        .byte   $0F
        and     a:$62
L2126:  .byte   $3A
        .byte   $62
        .byte   $73
        and     #$81
        .byte   $93
        lda     ($99,x)
        .byte   $8B
        ldx     L4F49
        brk
L2133:  ldy     $DF
        iny
        bne     L2133
        inc     $1C
        dex
        bne     L2133
        .byte   $AE
        pha
L213F:  .byte   $8F
        brk
        ror     $3C
        .byte   $53
L2144:  .byte   $D7
        sbc     #$93
        cmp     L0C4C
        .byte   $57
        ldy     L7D31,x
        .byte   $5B
        .byte   $A6
L2150:  cmp     $1C,x
L2152:  and     ($B0,x)
        eor     ($33),y
        .byte   $A7
        cpx     $AD29
        ror     L6493
        .byte   $34
        .byte   $80
        .byte   $1F
        and     ($B0),y
        .byte   $C3
        .byte   $C7
        ora     L7DCC,x
        and     $E9,x
        cpy     #$E3
        .byte   $1C
L216C:  eor     L87F3
        .byte   $9F
        .byte   $B7
        dec     $A41E
        asl     $50
        .byte   $D3
        inc     $7A,x
        .byte   $3E
L217A:  .byte   $32
        .byte   $13
        nop
        asl     $35,x
        .byte   $8F
L2180:  lda     $DD,x
        .byte   $82
        lda     L69C7
        .byte   $B2
        .byte   $77
        adc     L1329
        inc     $37,x
        and     L52B9
        sta     L2645
L2193:  .byte   $67
        .byte   $52
        .byte   $37
        eor     ($C5),y
        ora     ($AD,x)
        lsr     $B9D6
        .byte   $1C
        .byte   $7A
        .byte   $2D
        .byte   $EB
L21A1:  .byte   $53
        lda     $99,x
        dex
        .byte   $57
        ora     $64
        eor     ($C4),y
        bit     $6D
        .byte   $64
        .byte   $5E
L21AE:  adc     L26C7,x
        ora     $5215
        .byte   $EB
        inc     L33B2
        .byte   $AF
        clc
        .byte   $DF
        .byte   $2F
        .byte   $1A
        cmp     #$2E
        ldy     $F8E4,x
        .byte   $F3
        jsr     L3FCF
        .byte   $7E
        .byte   $0B
L21C8:  stx     $0F,y
L21CA:  lsr     $CCBD,x
        sta     L65A8,y
        stx     $E0F1
L21D3:  .byte   $CB
        sed
        sei
        .byte   $33
        adc     ($8E),y
        .byte   $AB
        tsx
        ldx     #$AA
        sbc     #$F5
        cli
        .byte   $DB
        ldx     L7C72,y
        adc     ($39,x)
        jsr     L2B0B
        lda     ($D3,x)
        cmp     $B681,y
        .byte   $54
        .byte   $72
        .byte   $77
        bpl     L224E
        ora     $33,x
        dey
        nop
        .byte   $74
        sed
        .byte   $04
L21FA:  bmi     L21CA
        .byte   $52
        asl     L19C2,x
        .byte   $04
        ror     a
        .byte   $77
        php
        and     $DC,x
        clc
        iny
        .byte   $1A
        .byte   $E3
        sbc     ($00,x)
        and     $F1,x
        .byte   $5B
        sty     $04
        .byte   $D7
        rol     $A9
        lsr     a
        tay
L2216:  and     #$D4
        .byte   $42
        bit     $C8A9
        .byte   $35
L221D:  .byte   $74
        tsx
        txa
        .byte   $DF
        pla
        nop
        .byte   $FB
        .byte   $8F
        .byte   $DF
        bcc     L2252
        .byte   $E7
        ora     $2C,x
        ldx     $CAB2
        eor     $22
        jsr     L3B2D
        sed
L2234:  .byte   $2F
        .byte   $C2
        .byte   $CF
        bmi     L21D3
        inc     L4898
        .byte   $20
        .byte   $8D
L223E:  jsr     $9481
L2241:  txa
        ora     ($00,x)
        cld
        sbc     L2180,x
        lsr     $E7C1
        bcc     L2294
        .byte   $AE
L224E:  sta     ($87,x)
        dec     $89,x
L2252:  .byte   $5F
        lsr     $7C
        sbc     $05,x
        sei
        sta     $D5F3,y
        .byte   $04
        .byte   $C1
L225D:  adc     $0447,y
        .byte   $7C
        pla
        .byte   $44
        ldy     $11,x
        ldy     $D0
        adc     ($93,x)
        asl     a
        rol     $28
        .byte   $52
        sec
        .byte   $52
        pha
        lsr     $71,x
        .byte   $7B
        ror     L3F47
        rol     $10
        and     #$49
        .byte   $04
        .byte   $DF
        .byte   $81
L227D:  eor     #$FA
        cmp     $B6CC
        sed
        sbc     $01C8,x
        .byte   $73
        ror     L3514,x
        inc     $31,x
        .byte   $5B
        .byte   $E7
        stx     $D7,y
        adc     $A66F,x
        .byte   $5B
L2294:  sei
        .byte   $D7
        .byte   $A3
        rts

        asl     L7D83,x
        lsr     $DE,x
L229D:  cpx     #$49
        .byte   $B2
        .byte   $33
        asl     a
        .byte   $32
        dec     $F0
        .byte   $D3
        .byte   $22
        clv
        cmp     #$48
L22AA:  sec
        eor     $55,x
        nop
        .byte   $B7
        lsr     a
        .byte   $D2
        .byte   $2F
        .byte   $57
L22B3:  .byte   $33
        sbc     ($81),y
        ldy     L38AE
        ldy     $B220
        cpx     $AC
        ldy     $B1
        rti

        lda     ($E0),y
        bcs     L2339
        .byte   $B7
        sec
        .byte   $42
        ldy     $F204
        .byte   $FB
        .byte   $93
        lda     L5717
        adc     $21
        .byte   $F1
L22D3:  sbc     $7658,y
L22D6:  asl     $2A99,x
        .byte   $62
        tsx
        .byte   $43
        bcs     L227D
L22DE:  asl     a
        .byte   $44
        .byte   $F4
        .byte   $C3
        .byte   $D2
        clv
        .byte   $DD
L22E5:  bmi     $2303
        lsr     a
        .byte   $8F
L22E9:  .byte   $FB
        adc     L0BBF
        and     L0ABF
        .byte   $64
        .byte   $42
        .byte   $CB
        .byte   $82
        lda     $FB50
        .byte   $4F
        .byte   $5F
        ldy     #$2C
        .byte   $90
L22FC:  lda     $DB00
        .byte   $73
        rol     L404C,x
        .byte   $6C
        .byte   $F7
L2305:  nop
        .byte   $B7
L2307:  rol     $D4
        .byte   $A3
L230A:  and     ($BF),y
        brk
        .byte   $54
        .byte   $A3
        jmp     LFD97

        .byte   $DF
        jmp     L2B7C

        .byte   $23
        .byte   $3C
        .byte   $12
        .byte   $2B
        .byte   $73
        sei
        .byte   $37
        .byte   $37
        .byte   $92
        .byte   $32
        .byte   $8F
        txa
        .byte   $5C
        lsr     L42E3,x
        .byte   $B7
        .byte   $3C
        sty     $71,x
        .byte   $53
L232B:  bvc     L2341
        .byte   $64
        cpx     $47
        eor     $F102,y
        .byte   $72
        .byte   $62
        eor     L3E56,x
        .byte   $03
L2339:  adc     L1609
        .byte   $1C
        .byte   $2D
        .byte   $16
L233F:  .byte   $1C
        .byte   $AD
L2341:  bpl     L2396
L2343:  .byte   $1F
        .byte   $A3
        eor     $D1D1,y
        rol     $94
        .byte   $91
L234B:  .byte   $3F
        .byte   $2B
        .byte   $53
        .byte   $02
        .byte   $6B
        .byte   $B2
        .byte   $DC
        bpl     L2395
        .byte   $17
        .byte   $33
        .byte   $C7
        php
        .byte   $44
        .byte   $CF
        rol     L1BD1
        rol     L23B9
        rol     L2BB9
L2363:  bit     L684A
        cpx     $E0
        .byte   $33
        adc     #$91
        ldx     $2A
        jmp     L6039

        .byte   $F9
L2371:  .byte   $C3
        iny
L2373:  adc     #$AD
        rol     $DCF2,x
        txa
        jsr     LCF12
        cpy     #$21
        .byte   $04
        .byte   $62
        .byte   $FF
        .byte   $52
        .byte   $80
L2383:  ora     $07,x
        sbc     L5906,y
        .byte   $83
        .byte   $1B
L238A:  .byte   $C4
L238B:  ora     $25,x
        ldy     $527D
L2390:  sta     ($A3),y
        and     ($12),y
        .byte   $7E
L2395:  .byte   $92
L2396:  .byte   $A7
        sbc     #$22
        .byte   $92
        clc
        inc     L1C60
        .byte   $7A
        ldx     $89
        .byte   $02
        ora     $F4C8,y
        .byte   $B2
        .byte   $17
        sbc     ($BD),y
        .byte   $9B
        iny
        and     #$8B
        tay
        bpl     L2363
        bit     $B1
        .byte   $7B
        .byte   $27
L23B4:  txs
        ror     $AD33
        .byte   $F6
L23B9:  cmp     #$63
        .byte   $BF
        .byte   $64
        .byte   $CB
        .byte   $12
        dex
        .byte   $C0
L23C1:  .byte   $D7
        .byte   $87
        ora     $53,x
        ora     $026B,x
        .byte   $62
        lda     #$23
        .byte   $47
        and     ($CE,x)
        .byte   $32
        .byte   $67
        sbc     #$1C
        .byte   $C7
        asl     a
        bpl     L2373
        .byte   $87
        lsr     $AD5F,x
        tsx
        .byte   $B7
        .byte   $AF
        .byte   $AF
        .byte   $0F
        .byte   $E2
        cpy     L0A48
        ldy     #$93
        .byte   $72
        ldy     #$9A
        adc     ($82,x)
        .byte   $AF
        lda     $BE2A
        .byte   $92
        and     #$AA
        sed
        ldy     $68
        ldx     #$8E
        pha
        .byte   $B1
L23F8:  cpy     $C650
        .byte   $B3
        adc     #$B5
        jsr     L5D8C
        .byte   $A7
        bmi     L238A
        .byte   $7B
        adc     $B1D6,y
        tsx
        sta     ($80),y
        cmp     ($64),y
L240D:  cmp     ($8E),y
        .byte   $DF
        stx     $DAFC
        ldx     L0FDE
        lsr     L6C72
        adc     #$38
        clv
        .byte   $89
L241D:  sty     $90D7
        .byte   $C3
        .byte   $1F
        .byte   $2D
L2423:  adc     $3AE6,y
        .byte   $72
        cmp     $35,x
        and     ($51,x)
        .byte   $63
        inc     $F1,x
        cmp     $DECF,y
        brk
        .byte   $07
        .byte   $80
        bit     $42
        .byte   $A3
L2437:  asl     L780B,x
L243A:  .byte   $23
        cpx     #$4B
        rol     a
        .byte   $34
        asl     a
        rol     L362C
        sty     $C7
        .byte   $62
        dec     $89,x
        .byte   $54
        .byte   $82
        .byte   $D0
L244B:  .byte   $EB
        eor     #$67
        .byte   $59
L244F:  jmp     (L7120)

        rol     a
        .byte   $52
        rol     $C75A
        .byte   $E2
        rol     L475A,x
        cpy     $CC
L245D:  .byte   $E2
        .byte   $DA
        lda     ($88,x)
        .byte   $AB
        .byte   $1B
L2463:  sta     $E348,y
        .byte   $C2
        sta     a:$E5
        inx
        dec     $E524,x
        ldy     L2564
        sbc     $A4
        .byte   $62
        rts

        stx     $B60F
        .byte   $52
        lsr     a
        cmp     $66
        .byte   $52
        .byte   $5A
        .byte   $3C
        lda     #$10
        and     #$7C
        .byte   $FC
        .byte   $13
        .byte   $22
        txa
        clv
        rol     $81
        .byte   $39
L248B:  ror     $67,x
        .byte   $9F
        .byte   $57
        .byte   $FD
        .byte   $F7
L2491:  .byte   $FA
        lsr     $77
        sta     ($B4,x)
        lsr     $A4
        .byte   $3C
        php
        .byte   $14
        .byte   $0B
        ldy     $4B
        .byte   $1A
        eor     #$3C
        asl     L8751,x
L24A4:  lsr     $D7
        cmp     $D786,y
        sbc     ($D1,x)
        lda     $F6,x
        lsr     $D7
        sbc     ($68,x)
        rti

        .byte   $DB
        eor     L1326
        .byte   $02
        ora     #$81
        .byte   $1A
        and     L349A,y
        .byte   $DB
        sbc     ($82),y
        rts

        ldx     L6F48,y
        .byte   $1C
        clv
        eor     ($2C),y
        dec     L00F9,x
        .byte   $65
L24CB:  lda     $43F2,y
        ora     L294C
        and     ($AD,x)
        ora     $24,x
        rol     $57,x
        sta     $CF36
        .byte   $D4
        .byte   $37
        cmp     ($03,x)
        .byte   $F9
        .byte   $50
L24E0:  inc     $B2
        .byte   $80
        tsx
        .byte   $92
        cmp     $FD7D
        .byte   $AB
        sta     ($23,x)
        sta     L68FF,y
L24EE:  cpx     $24
        jmp     L34BD

        tsx
        stx     $E8D3
        .byte   $13
        sei
        ora     ($C2,x)
        .byte   $46
L24FC:  cld
        cmp     $88
        sbc     L16A9,x
        .byte   $3A
        .byte   $64
        .byte   $03
        .byte   $43
        .byte   $23
        brk
        .byte   $23
        .byte   $43
        dex
        sty     $8A,x
        .byte   $37
        iny
        asl     a
        sty     $8E,x
        .byte   $37
L2513:  cmp     $C93E
        .byte   $23
        .byte   $7D
L2518:  .byte   $13
        cpx     $3796
        .byte   $D4
        asl     a
        .byte   $BB
        cpy     $0B
        lda     ($35,x)
        tax
        .byte   $42
        ora     L742F,y
        .byte   $1B
        .byte   $EF
L252A:  sta     $FB91
        inc     $FB
        bne     L2597
        .byte   $0F
        cmp     L32BE,x
        ldy     $3B,x
        eor     L6ABD,x
L253A:  eor     $7F,x
        .byte   $1E
L253D:  .byte   $D2
        .byte   $8D
        .byte   $09
L2540:  bne     $2562
        adc     $31,x
        .byte   $A7
        .byte   $7C
        .byte   $9C
        .byte   $63
        php
L2549:  .byte   $D4
        pha
        clc
        ror     $92
        .byte   $72
        .byte   $14
        sty     $DF,x
        bcs     L2582
        pha
        .byte   $C2
        .byte   $22
        txs
        .byte   $52
        cpx     L2E35
        .byte   $DC
        sta     ($83),y
        .byte   $93
        clv
        .byte   $83
        bvs     L252A
L2564:  inc     $14,x
        cmp     $41
        .byte   $3F
        beq     L2513
        brk
        .byte   $74
        cli
        rol     $F44A,x
        .byte   $47
        .byte   $3C
        rts

        .byte   $43
        asl     a
L2576:  rti

        .byte   $1F
        clc
        .byte   $92
        .byte   $23
        .byte   $53
        .byte   $14
        .byte   $8B
        sbc     $E4A3,y
        .byte   $12
L2582:  lsr     $B021
        .byte   $BF
        lda     L7D0C,y
        .byte   $FF
        sec
        .byte   $67
        cpy     $AE35
        .byte   $7A
        sbc     ($AE,x)
        .byte   $7C
        ldx     $AB8A
        .byte   $DC
L2597:  pha
        sta     $3F
        cmp     L6464
        ora     #$01
        dec     $64
        asl     $F1F2
        .byte   $3D
L25A5:  dec     $414E
        .byte   $73
        cpx     $EBE4
        .byte   $CE
        .byte   $2F
L25AE:  lda     $3B50,x
L25B1:  inx
        .byte   $FA
        cmp     $31,x
        ora     $0C,x
        .byte   $44
        bvs     L2601
        .byte   $92
        sta     ($04,x)
        sta     L3E20,x
L25C0:  brk
        bne     L25D9
        lsr     a
        sta     ($E1,x)
        sta     $48,x
        ora     L751E
        .byte   $80
L25CC:  .byte   $D4
        cpx     $22
        .byte   $47
        rol     $04
        .byte   $13
        .byte   $22
        sta     ($0D),y
L25D6:  iny
        .byte   $4F
        .byte   $34
L25D9:  .byte   $FB
        .byte   $62
        clc
        cpx     #$C1
        eor     #$91
        stx     $0D
        adc     L7B68
L25E5:  .byte   $D2
        .byte   $9F
        .byte   $A7
        bne     L2576
        .byte   $5C
        .byte   $8C
L25EC:  .byte   $5B
        tsx
        ldy     L4A41,x
        .byte   $62
        .byte   $8B
        nop
        bvs     L260A
        bit     $FE
        bmi     L260D
        lda     $FD
        cmp     $4C
        .byte   $2F
        .byte   $EE
        .byte   $52
L2601:  and     $9400,y
        .byte   $1C
        ora     #$52
        .byte   $02
        .byte   $0E
        .byte   $29
L260A:  bmi     L25B1
        .byte   $33
L260D:  .byte   $0F
        .byte   $53
        pha
        .byte   $63
        rti

        .byte   $04
        cpx     #$92
        sec
        cpy     #$65
        .byte   $1B
        rol     $04B8
        .byte   $AC
L261D:  brk
        cmp     $99,x
        sec
L2621:  adc     ($EB,x)
        .byte   $0C
        sty     $89
        .byte   $07
        .byte   $0C
        cmp     ($DC),y
        adc     L67E7
        .byte   $27
        .byte   $4F
        cmp     ($05),y
        jsr     L0CA8
        sta     ($C6,x)
        ldx     $92,y
        .byte   $CB
        cmp     #$94
        .byte   $80
        sta     $BD07,x
        and     ($0C,x)
        .byte   $0F
        .byte   $1F
        and     ($D0),y
L2645:  .byte   $7C
        .byte   $9E
        adc     ($6C),y
        .byte   $79
        .byte   $A4
L264B:  bit     $63
        .byte   $1E
L264E:  adc     ($88),y
        sbc     ($A1,x)
        tsx
        cpy     $28
        .byte   $42
        .byte   $4E
L2657:  pla
        ror     a
        lda     $00
        stx     $8A
        .byte   $33
        and     L4D0D,x
        .byte   $57
        sty     $3C
        ora     $E9,x
        ror     $AC
        .byte   $13
        asl     $8E
        adc     $023A,y
L266E:  .byte   $FB
        .byte   $83
        .byte   $9E
L2671:  cpx     #$F1
        bmi     L26B1
        ldx     L4EB7,y
L2678:  rti

        .byte   $49
L267A:  .byte   $EB
        .byte   $5B
        inc     $9F
L267E:  .byte   $64
        adc     $BE,x
        .byte   $89
        inc     $49,x
        .byte   $5B
L2685:  nop
        .byte   $9F
        .byte   $64
        lda     $DF,x
        ldy     #$53
        eor     #$56
        rts

        ora     L488C,x
        sty     L682C
        .byte   $83
        .byte   $22
        .byte   $F2
        .byte   $1C
        .byte   $82
        .byte   $17
        lda     $D4,x
L269D:  ldx     $08
        pla
        cld
        pha
        cpx     $A0
        cmp     $62
        .byte   $83
        .byte   $97
        .byte   $F2
        cpy     #$45
        stx     $A5,y
        .byte   $9F
        .byte   $11
L26AF:  .byte   $D9
        tya
L26B1:  .byte   $33
        .byte   $FD
        .byte   $66
L26B4:  adc     $3F,x
        sty     $98,x
        .byte   $14
        .byte   $62
        .byte   $9C
        ldy     #$B1
        .byte   $80
        .byte   $BF
        rts

        .byte   $BF
        .byte   $9E
        .byte   $1A
        cpy     $A972
        .byte   $02
L26C7:  clc
        sbc     L5F87,x
        dec     $1D,x
        .byte   $7F
        sta     $C6E6,x
        .byte   $97
        sbc     L5451,y
        .byte   $E2
        cmp     $D5FA
        lsr     L8702,x
        .byte   $1C
        .byte   $BF
        lda     $E3,x
        ora     $FDCB
        bit     $EE51
        .byte   $64
        .byte   $AB
        clv
        dec     L15EF,x
        cld
        dec     $FDF1
        .byte   $C4
L26F1:  sta     ($BC),y
        .byte   $E3
        tax
        lda     $1C
        dec     L0C49
        .byte   $54
        .byte   $1C
        stx     $1B
        .byte   $A4
L26FF:  stx     $C7A6
        cpx     $C3
        .byte   $1A
        .byte   $44
        asl     a
        .byte   $63
        sed
        lda     $0638
        tya
        brk
        sbc     $0C
        .byte   $37
        asl     L4D31
        .byte   $C3
        sty     $C3,x
        lsr     $0311,x
        ora     L0CC4
        .byte   $C3
        adc     ($05),y
        cpy     $A13B
        .byte   $63
        cpy     $A13D
        .byte   $5A
        tax
        .byte   $02
        .byte   $0C
        .byte   $83
        clc
        .byte   $0F
        sta     ($4F),y
        .byte   $FB
        ora     ($8B,x)
        .byte   $64
        .byte   $23
        .byte   $1F
        ldx     $07,y
        .byte   $FB
        sbc     $FFFE,x
        .byte   $7F
        .byte   $BF
        .byte   $DF
        .byte   $E2
        .byte   $3A
        bit     $EF09
        .byte   $22
        .byte   $27
        lsr     L78A1
        ora     ($9E,x)
        .byte   $E7
        .byte   $23
        .byte   $80
        rol     a
        .byte   $EF
        .byte   $5B
L2751:  .byte   $F2
        sec
        eor     $C4AF,x
        ldx     $6D
        and     L7EB9,x
        .byte   $B7
        .byte   $A7
        .byte   $CB
        adc     ($1A),y
        .byte   $F4
        dec     L3903
        ldx     $3B
        tsx
        ror     $1E,x
        sty     $A4,x
        tsx
        asl     $9C0C,x
        tya
L2770:  asl     $1D,x
        eor     $3F
        ora     ($44,x)
        cpy     $AE
        .byte   $5F
        lda     $0C,x
        bcs     L2786
        .byte   $72
        lsr     a
        ldx     $9E
        .byte   $04
        cpy     $98
        .byte   $72
        .byte   $EE
L2786:  adc     ($95),y
        .byte   $12
        lsr     $E6,x
        adc     ($31),y
        .byte   $53
        eor     $C8C3,x
        sta     L26AF
        .byte   $62
        jmp     (L3095)

        lsr     a
        eor     ($EA,x)
        clc
        sbc     #$07
        tax
        lsr     a
        .byte   $80
L27A1:  ora     $24,x
        .byte   $04
        sta     ($42,x)
        .byte   $80
        stx     $6E,y
        sta     ($29,x)
        cpy     #$BB
        .byte   $BB
        .byte   $80
        asl     a
        lda     $3F,x
        .byte   $52
        .byte   $63
        rti

        .byte   $23
        .byte   $BB
        sta     $BC
        .byte   $23
        tya
        sbc     ($DD),y
        .byte   $6F
        sta     $01
        rol     L7CEB,x
        eor     $A4E0,y
        and     ($20),y
        .byte   $57
        sta     L1B97,y
        asl     $02
        cmp     $A019
        cmp     $EEAD,y
        lda     L6F0A,y
        .byte   $F3
        .byte   $93
        lda     L717D
        ora     ($71,x)
        .byte   $CB
        .byte   $C7
        .byte   $53
        eor     $43
        eor     $53
        lsr     $68
        .byte   $09
L27E8:  adc     #$42
        ldy     $47,x
        eor     ($9C,x)
        .byte   $6F
        .byte   $D3
        sbc     L2F9C
        dec     $53
        cpy     L416B
L27F8:  .byte   $9D
L27F9:  inc     $93
        sbc     $AE9E
        cmp     $3C
        .byte   $56
L2801:  .byte   $87
        ror     $BB33
        .byte   $FA
        adc     $90D4,x
        lsr     $8A
        ora     ($D4,x)
        sta     L8A46,y
        sta     ($B1,x)
        .byte   $83
        tsx
        sbc     ($82,x)
        bvc     L27F9
        cpy     #$9B
        bit     L2770
        .byte   $DB
        .byte   $1B
        .byte   $0C
        ror     $27
        cmp     L4C6A,x
        and     ($AF),y
        .byte   $5B
        ldx     $C604,y
        .byte   $B3
        .byte   $1B
        cmp     $29,x
        sbc     ($64),y
        .byte   $DF
        stx     $9E,y
        iny
        .byte   $3C
        .byte   $7C
        .byte   $DF
L2838:  sty     L1FCE
        .byte   $44
        .byte   $11
L283D:  bvc     $280E
        sty     L41AA
        sta     ($FF,x)
        rts

        ror     L6840,x
        .byte   $67
        jsr     L4475
        asl     L8C41,x
L284F:  .byte   $9E
        stx     $64
        ora     $F6E9,y
        .byte   $5C
        ldy     $86
        .byte   $3B
        sty     $D1,x
        .byte   $20
        .byte   $4E
L285D:  .byte   $E7
        cmp     $66
        .byte   $1B
        cpx     #$47
        .byte   $5C
        tya
        lda     L1C46,y
        lda     ($C9),y
        .byte   $F4
        adc     ($D2),y
        rts

L286E:  .byte   $DA
        lsr     $9714,x
        .byte   $8B
        adc     $A754
        .byte   $D4
        .byte   $C2
        sbc     ($F2,x)
        .byte   $67
        lda     ($95),y
        .byte   $8F
L287E:  sty     L45EB
        bit     L3074
        cli
        sed
        dec     $91
        plp
        adc     $F870,x
        cpx     #$C6
        dec     $7E,x
        sec
        .byte   $34
        tya
        brk
        eor     $BBEF,y
        .byte   $0D
        .byte   $4F
L2899:  .byte   $13
        ror     $BC,x
        pla
        .byte   $02
        .byte   $13
        .byte   $CF
        .byte   $43
        ror     $C132
        brk
        .byte   $0F
        clc
        cld
        ldy     #$07
L28AA:  .byte   $67
        .byte   $97
        .byte   $F2
        .byte   $C5
L28AE:  plp
        .byte   $13
        eor     #$85
        sbc     L1F88,y
        tsx
        .byte   $D4
        .byte   $FA
        .byte   $62
        .byte   $34
L28BA:  adc     ($9E,x)
        and     L3190,y
        sta     $34
        cpy     #$22
        .byte   $E7
        eor     ($9F,x)
        .byte   $72
        adc     ($56),y
        .byte   $A7
        .byte   $EE
L28CB:  pha
        stx     $E686
        .byte   $73
        asl     $92C9,x
        .byte   $CF
        .byte   $3A
        pla
        .byte   $FD
        .byte   $49
L28D8:  .byte   $EB
        .byte   $3A
        .byte   $9C
        .byte   $B3
        adc     ($9C,x)
        .byte   $3F
        .byte   $FA
        brk
        ldx     L3E3E
        lda     $28
        ora     #$48
        stx     $87
        .byte   $72
        .byte   $45
L28EC:  sbc     $68
        ror     L68C4,x
        adc     L5610,y
        ora     L8129,y
        .byte   $DF
        .byte   $C7
L28F9:  .byte   $13
        lda     #$FE
        .byte   $73
        sbc     $AAE8
        .byte   $67
        .byte   $C7
        .byte   $57
        .byte   $6F
        cpy     $A8
        .byte   $03
        .byte   $EE
L2908:  .byte   $4F
        sty     $AA
        .byte   $6F
        sta     L4313,y
        cmp     ($9F,x)
        ora     L441D,x
        .byte   $04
        iny
        sei
L2917:  sty     $39
        .byte   $BF
        .byte   $03
        .byte   $E7
        .byte   $F4
        .byte   $9F
        .byte   $09
L291F:  .byte   $03
        sed
L2921:  .byte   $3E
        .byte   $62
L2923:  cmp     #$99
        sed
        dec     $04
        sty     $DA6F
        .byte   $5F
L292C:  .byte   $D2
        .byte   $FA
        rti

        sbc     ($BF),y
        txs
        php
L2933:  .byte   $F3
        .byte   $FB
        lda     $FB
        bmi     L292C
        .byte   $FC
        .byte   $0F
        .byte   $32
        .byte   $F3
        .byte   $22
        .byte   $14
        sta     $2C
        bne     L291F
        ldy     $47
        .byte   $72
        .byte   $34
        rol     L8779,x
        .byte   $39
        .byte   $87
L294C:  ldx     #$37
        dex
        ldy     $02C7,x
        lda     $E33A
        .byte   $C7
        sbc     ($82,x)
        .byte   $9C
        eor     $51
        eor     L7825
        sta     $9B5F
        .byte   $9C
        bvc     L2964
L2964:  ldy     #$00
        sbc     ($4E),y
        cmp     L00F9
        brk
        asl     $0300,x
        brk
        plp
L2970:  brk
        and     L3200
        bne     L2977
        clv
L2977:  ora     ($D7,x)
        brk
        php
        rti

        ora     ($80),y
        .byte   $12
        cpy     #$14
L2981:  brk
L2982:  ora     $40,x
        asl     $54,x
        .byte   $6B
        cpx     #$08
        .byte   $80
        ora     L0D20
        cpy     #$0E
        rts

        .byte   $0F
L2991:  cli
        brk
        .byte   $7A
        inx
        .byte   $03
        sei
        lda     #$07
L2999:  sta     $01
        .byte   $E1
L299C:  .byte   $3B
        bpl     L2921
        and     $CD62,y
        php
        rol     $CD
        rol     a
        ror     a
        .byte   $FC
        sed
        dec     $A8,x
        .byte   $34
        clc
        .byte   $47
        .byte   $9B
        .byte   $67
        sbc     ($21,x)
        cmp     L0954,x
        lda     $932B
        dec     $E265,x
        cpy     #$28
        .byte   $87
        txa
        cmp     L4019,y
        .byte   $52
        sed
        .byte   $D2
        .byte   $7C
        .byte   $FE
L29C7:  lsr     $19
L29C9:  eor     $1D
        cmp     ($ED),y
        .byte   $5A
        cmp     $5B
        rol     a
        .byte   $FF
        .byte   $47
        .byte   $44
        .byte   $77
        jsr     LE852
        .byte   $D3
        cpx     $E9
        rts

        .byte   $C7
        cpx     $929F
        lsr     a
        .byte   $43
        sbc     L7F8D,x
        inc     $26
        .byte   $B3
        .byte   $E3
        lsr     $00
        .byte   $D2
        txs
        .byte   $34
        .byte   $64
        ora     L6F8F
        .byte   $AF
        inc     $3D,x
        ldx     $D8FF,y
        .byte   $B3
        ora     $03,x
        cmp     #$32
        beq     L2A08
        sta     $02DF
        lda     $0314
        sta     L67DE
L2A08:  .byte   $1B
L2A09:  .byte   $7B
        bcc     L2A1B
        sbc     $FD94,y
        dey
        bne     L2A09
        bvs     L2A7D
        .byte   $66
L2A15:  rol     $66
        bit     $5B
        cpx     $B5
L2A1B:  lda     $FC
        cmp     #$D0
        bne     L2A15
        plp
        lda     $DD02
        ora     #$4D
        sty     $FB
        lda     $DD00
        pha
        plp
        .byte   $D4
        .byte   $FB
        lda     #$38
        lsr     a
        ldx     $D3
        bvs     L29C9
        asl     $53
        ror     L00F9,x
        stx     $3E,y
        .byte   $DB
L2A3E:  inc     L0060
        dey
        sec
        ora     L3889
        beq     L2A4F
        .byte   $63
        cpy     #$24
        ora     ($8F),y
        asl     a
        .byte   $9C
        php
L2A4F:  .byte   $DF
        asl     $63,x
        .byte   $FA
        .byte   $80
        .byte   $22
        .byte   $64
        sty     $DD,x
        and     #$FE
        sta     $BAF2,y
        .byte   $04
        brk
        asl     $00
        asl     a
        asl     $17
        dey
        ldy     $05
        cmp     #$C0
        inc     $E0FD,x
        bit     $00
        asl     $00
        jsr     LF106
        sei
        lsr     $DDD6,x
        .byte   $5F
        .byte   $5A
        .byte   $7A
        .byte   $DB
        pla
        cli
L2A7D:  .byte   $6F
        cmp     $C62D,x
        .byte   $42
        .byte   $37
        .byte   $7F
        dec     $E2,x
        .byte   $7A
        lsr     a
        adc     #$DB
        bne     L2A8F
        sbc     L51FE,x
L2A8F:  .byte   $FD
L2A90:  sed
        sbc     $1B9D,y
        .byte   $8F
        .byte   $67
        .byte   $87
        .byte   $F3
        cpx     #$6B
        and     $DF3F
        beq     L2A3E
        .byte   $DB
        .byte   $CF
        sta     L38D1,y
        sed
        .byte   $1B
        .byte   $1B
        .byte   $CF
        sbc     ($E0),y
        brk
        .byte   $12
L2AAC:  ora     $6F,x
        sty     $EB16
        cpy     $A2FC
        ora     $01
        .byte   $CE
L2AB7:  .byte   $67
        .byte   $57
        .byte   $0E
L2ABA:  lda     $A14F,x
        ldx     $487E
        .byte   $9E
        .byte   $2F
        .byte   $D2
        cpx     #$38
        .byte   $93
        .byte   $7F
        .byte   $4B
        .byte   $7F
        .byte   $7B
        .byte   $7F
        dec     $1C,x
L2ACD:  cmp     $EDF5
        sbc     $AD,x
        .byte   $80
        bmi     L2ADA
        .byte   $F7
L2AD6:  .byte   $2B
        .byte   $4E
        .byte   $B7
L2AD9:  .byte   $C7
L2ADA:  tsx
        sbc     $ADB6,y
        beq     L2AD9
        bcs     L2ACD
        dex
        .byte   $F3
        stx     L3F21
        .byte   $0F
        .byte   $9B
        asl     L6EBE
        .byte   $AB
        .byte   $6F
        asl     $E633
        .byte   $EF
        .byte   $73
        .byte   $82
        .byte   $17
        .byte   $1F
        .byte   $37
        lsr     $77,x
        cpy     #$20
        eor     L6DF3,y
        .byte   $4F
        lda     $8EF5
        rol     L2B6C,x
        tax
        stx     $E6F3
        .byte   $CF
        .byte   $35
L2B0B:  jmp     (LF343)

        .byte   $92
        dec     $F2
        .byte   $DA
        sbc     L3C6B,y
        .byte   $AC
L2B16:  adc     $FAB6
        cmp     $8F3F
        txs
        .byte   $BB
        ror     a
        sbc     $3E,x
        ldx     L2B6C,y
        .byte   $4C
L2B25:  .byte   $B3
        inc     $BE
        .byte   $FA
        .byte   $E2
        sed
        .byte   $9C
        .byte   $03
        .byte   $AF
        .byte   $9B
        asl     L6BBE
        .byte   $F3
        eor     L3A73,y
        .byte   $F2
        asl     $F9C6
        .byte   $43
        .byte   $8F
        txs
        .byte   $DF
        .byte   $0C
        .byte   $1C
        sbc     $BDB6,y
        ora     $EB
        inc     $C2
        .byte   $D4
        .byte   $87
        rol     $F86A,x
        .byte   $80
        and     $F0
        sbc     $E3B0,y
        inc     $A7
        asl     $75,x
        ldx     $9F3B,y
        .byte   $34
        cmp     $57,x
        .byte   $77
        cmp     $20
        .byte   $1C
        .byte   $22
        ror     $D6
        and     ($F4,x)
        .byte   $7B
        lda     $BEFE
        .byte   $71
L2B6A:  .byte   $82
        .byte   $C1
L2B6C:  bcc     L2B78
        .byte   $F7
        ldy     $DC76
        sbc     $CFBA,y
        nop
        .byte   $D3
        .byte   $B0
L2B78:  asl     L733E
        .byte   $93
L2B7C:  .byte   $AF
        txs
        cpy     L31E9
        .byte   $EB
        .byte   $E7
        .byte   $3C
        sta     $9273,y
        .byte   $AB
        .byte   $89
        .byte   $04
L2B8A:  .byte   $9F
        .byte   $0F
        .byte   $9B
        .byte   $0C
        .byte   $F9
L2B8F:  ldy     L56D7,x
        .byte   $64
        eor     L1764,x
L2B96:  .byte   $03
        eor     $BA,x
        .byte   $E7
        .byte   $3F
        beq     L2B96
        bcs     L2B8A
        .byte   $E7
        .byte   $27
        nop
        lsr     $F9B8
        cpy     $9B
        cpx     $10
        .byte   $0C
        sbc     L8AC5,y
        ldx     $9E,y
        .byte   $3C
        lda     ($7E),y
        lda     $C7
        .byte   $AF
        .byte   $9C
        .byte   $CF
        and     $EB,x
L2BB9:  .byte   $E7
        ora     L8046
        .byte   $3A
        sbc     $EBB0,y
        .byte   $E7
        .byte   $27
        lda     $BF,x
        cmp     $D5,x
        rol     L6178
        .byte   $E7
        .byte   $1F
        and     $C72F,y
        cmp     $9ED5
        .byte   $5C
        sbc     ($D7),y
        adc     $C1,x
        .byte   $30
L2BD8:  .byte   $FF
        asl     $B855,x
        .byte   $82
        .byte   $9B
        .byte   $9E
        lsr     $F6,x
        cmp     $95,x
        cmp     #$19
L2BE5:  .byte   $F3
        adc     L57C7
        ora     $D976,x
        and     L7354,x
        .byte   $C7
        .byte   $97
        php
        .byte   $6B
        lda     L61F3,y
        ldx     $C84C
        .byte   $E2
        asl     a
        .byte   $C3
        .byte   $83
        ldx     L6EBE
L2C00:  rol     $B3BA
        bcs     L2BE5
        .byte   $83
        .byte   $AF
        .byte   $9B
        .byte   $3C
        .byte   $C7
        .byte   $EB
        ror     $CE,x
        tax
        .byte   $CB
        txa
        .byte   $CB
        .byte   $0B
        .byte   $2C
L2C13:  cpx     $3A
        .byte   $E3
        ldx     L39CB
        .byte   $3C
        rol     $EB6B,x
        pha
        clv
        sbc     $B2B1,y
        ldx     $4B,y
        .byte   $E3
        .byte   $93
        sty     $A4
        asl     $AABC
        inc     L7887
        sbc     $8EC9,y
        dey
        rol     a
        ldy     $D5,x
        .byte   $67
        .byte   $74
        ldy     $56
        rol     $9C6F,x
        ldx     L1250,y
        lda     $DA8D
        .byte   $AB
        .byte   $36
L2C44:  ldy     $11
        adc     $F72C
        dex
        cpy     #$13
        inc     $B5
        ror     L0D06
        .byte   $7C
        ldx     $EB
        .byte   $87
        cmp     L5F63
L2C58:  .byte   $37
        jmp     L0E32

        lda     ($F2),y
        cmp     #$28
        jsr     LCAD7
        .byte   $67
        .byte   $A7
        .byte   $CB
        rts

        ora     $88,x
        asl     a
        .byte   $64
        .byte   $32
        .byte   $5C
        lsr     $A9,x
        ora     $9AAF
        tsx
        .byte   $DF
        bne     L2CBA
        sbc     L8B49,y
        cpy     #$36
        .byte   $3C
        .byte   $AB
        .byte   $37
L2C7E:  .byte   $DA
        .byte   $B3
        .byte   $4F
        .byte   $9B
        .byte   $CD
        .byte   $F1
L2C84:  .byte   $27
        .byte   $0F
        txs
        dec     $3E,x
        adc     L13AE
        and     ($8B,x)
        ldy     $12
        tsx
        .byte   $6B
        and     L511B,x
        rts

        lda     ($3C,x)
L2C98:  .byte   $AC
L2C99:  and     #$9C
        bit     $2B
        ror     a
        lda     $D5AE
        lda     $9D,x
        sei
        .byte   $DB
        sta     $D759,x
        adc     $BB,x
        .byte   $C3
        rol     $DAB2
        .byte   $DF
        and     #$45
L2CB1:  rti

        sec
        sbc     $8ECC,y
        .byte   $3E
L2CB7:  .byte   $73
        .byte   $1E
        .byte   $E6
L2CBA:  .byte   $DB
        .byte   $0F
        .byte   $32
        .byte   $0F
        eor     $B735,x
        sta     L7C7C
        cmp     L7C78,x
        .byte   $E2
        cmp     $C5,x
        bcs     L2D4A
        .byte   $72
        eor     L63DB,y
        .byte   $67
L2CD1:  .byte   $5F
        .byte   $3C
        .byte   $1A
        .byte   $80
        .byte   $83
        .byte   $63
        .byte   $AF
        .byte   $22
        .byte   $9E
        bpl     L2D4D
        .byte   $F3
        .byte   $9F
        ldy     $D9
        .byte   $D7
        dex
        .byte   $EB
        adc     $D7,x
        cmp     L67CE
        asl     $67,x
        .byte   $CF
        .byte   $2B
        sbc     $8E
        .byte   $BF
        sta     ($7A,x)
        .byte   $52
        ldx     $EB07,y
L2CF5:  dex
        .byte   $B6
L2CF7:  .byte   $C3
        .byte   $AF
        txs
        .byte   $9C
        sbc     $CF2F,x
        txs
        dec     L0F32
        .byte   $FA
        sbc     L64C2,y
        .byte   $0C
        cmp     ($AC,x)
        cpx     $84
        dex
        dec     L6DBE
        .byte   $7C
        ldx     L4B6C,y
L2D13:  tsx
        sbc     $BCAA,y
        .byte   $3C
        .byte   $E3
        inc     $BF
        ora     $DDBA,y
        .byte   $AF
        dex
        dec     L6B14
        .byte   $2B
        lda     ($20),y
        .byte   $EB
L2D27:  .byte   $8F
        rol     a
        ldy     $0347,x
        beq     L2D27
        lda     L5BC3
        tax
        ror     $050F,x
        .byte   $33
        .byte   $92
        .byte   $9E
        .byte   $FA
        .byte   $CB
        .byte   $D3
        inc     $DB
        .byte   $AF
        .byte   $9E
L2D3F:  .byte   $22
        adc     ($9B),y
        asl     $CA33
        .byte   $F4
        .byte   $EB
        .byte   $8F
        .byte   $9B
        .byte   $BB
L2D4A:  .byte   $AB
        .byte   $04
        .byte   $2E
L2D4D:  rol     L736C,x
        cli
        jmp     L8F03

        .byte   $9C
        and     $C5,x
        .byte   $FB
        sty     $C184
        .byte   $7C
        lda     $B8
L2D5E:  bcs     L2D13
        dex
        .byte   $42
        .byte   $5C
L2D63:  .byte   $F2
        lda     L20E6
L2D67:  asl     $7C
        rol     L3A6C,x
        sbc     $ABB6,y
        ldx     $F020,y
        sbc     $E3B0,y
        inc     $AB
        .byte   $1F
        rol     a:$CF
        lda     $97F3
        .byte   $3C
        .byte   $54
        .byte   $3A
        sbc     L61CC,y
        bne     L2D94
        ldx     L0D6C,y
        .byte   $33
        dex
        .byte   $EB
        .byte   $3A
        cpx     L73CE
        .byte   $E7
        rol     $B5AF
L2D94:  ldx     $9F93,y
        sec
        .byte   $C3
        .byte   $53
        dex
        .byte   $5F
        adc     $C0BB
        .byte   $44
        .byte   $03
        .byte   $22
        lda     L2AAC
        sed
        .byte   $F2
        .byte   $C7
        .byte   $DB
        .byte   $AB
        dec     L6C3E
        .byte   $6B
        rol     a
L2DAF:  ldy     L73CB
        .byte   $AF
        .byte   $97
        .byte   $63
        sta     ($02),y
        .byte   $DB
        .byte   $B3
        .byte   $DB
        .byte   $8D
L2DBB:  .byte   $DA
        dec     $8D35,x
        sec
        .byte   $F9
L2DC1:  sbc     $EC
        .byte   $E3
L2DC4:  inc     $97
        php
        and     a:$81
        lda     L7578
        .byte   $AB
        .byte   $73
        .byte   $E3
        .byte   $E7
        sty     $D9,x
        .byte   $37
        .byte   $8F
        .byte   $9C
        cmp     #$BE
        .byte   $5F
        .byte   $CF
        .byte   $9B
        .byte   $AB
        .byte   $9C
        cmp     $CF58,x
L2DE0:  .byte   $9C
        .byte   $92
        ldx     $AF,y
        .byte   $CB
        .byte   $3B
        .byte   $5B
        asl     $FF5F
        .byte   $2F
        txs
        cpy     $E0F9
        .byte   $DB
        ora     $8E,x
        sed
        sbc     $A5B1,y
        .byte   $BE
L2DF7:  and     ($00,x)
        .byte   $EB
        inc     $C3
        .byte   $8F
        .byte   $9C
        adc     $CF,x
L2E00:  .byte   $73
        .byte   $DC
        sbc     L1BCF,y
        rol     L7A0D
        .byte   $F9
L2E09:  bcs     $2DFB
        sbc     L83C8,y
        .byte   $7C
        dec     $B0,x
        inc     $69
        lsr     $B3
        dex
        .byte   $C3
        .byte   $99
        .byte   $84
L2E19:  .byte   $57
        .byte   $CF
        rol     a
        ldx     $0240
        bvc     L2E2F
        .byte   $BE
        .byte   $6C
L2E23:  .byte   $3A
        sbc     $B8BA,y
        bcs     L2E00
        beq     L2E59
        .byte   $7C
        .byte   $DC
        .byte   $64
        .byte   $06
L2E2F:  ora     #$59
        .byte   $74
        ror     a
        bit     $01
L2E35:  .byte   $97
        ldx     $38,y
        .byte   $3C
        cmp     ($9E),y
        eor     $97DB,y
        .byte   $5C
        adc     $E3,x
        asl     L6609
        .byte   $B7
        .byte   $5F
        rol     $7E,x
        .byte   $5F
        and     $BC,x
        .byte   $7C
        .byte   $F2
        cpx     #$DD
        bit     $67
        rol     $37
L2E53:  .byte   $E7
        .byte   $23
        .byte   $77
        .byte   $1F
        .byte   $3C
        .byte   $0C
L2E59:  .byte   $8B
        sbc     ($D7),y
        .byte   $57
        .byte   $93
        .byte   $DC
        .byte   $7C
        cpx     #$FE
        .byte   $6E
        .byte   $89
L2E64:  adc     $F3,x
        adc     ($D5,x)
        sta     $8D85,x
        cmp     $DA,x
L2E6D:  asl     $D86E,x
        .byte   $63
        lda     L2F6E
        cmp     $BA72,y
        cmp     $9D,x
        .byte   $67
        .byte   $97
L2E7B:  ror     $2E
        adc     $F558,y
        jsr     L0502
        .byte   $92
        lsr     $57,x
        lda     $B8,x
        .byte   $A3
        .byte   $9F
        and     L75CB,y
        .byte   $9E
        lsr     $1D,x
        adc     $82,x
        .byte   $67
        cmp     L56ED
        .byte   $DF
        lsr     $AC,x
        .byte   $E7
        .byte   $CF
        and     ($6F),y
        lsr     $5C,x
        ora     ($61,x)
        cld
        ora     ($C7,x)
        .byte   $5F
        pla
        sta     L79E6,y
        ror     $5B,x
        .byte   $67
        cmp     $BA7E
        sec
        .byte   $D4
        lsr     $02,x
        inc     $EB41
        .byte   $4E
        .byte   $73
L2EB8:  dex
        .byte   $FB
        stx     $BE4E
        jmp     (LA9ED)

        .byte   $4F
        sed
        .byte   $EB
        cpx     $85
        lsr     $E7E3,x
        ora     L5C2D,x
        tsx
        sbc     $B4C7,y
        ror     L6A3E
        sbc     L2EB8
        .byte   $AF
        sbc     $0B
        .byte   $AD
L2ED9:  .byte   $2B
        cmp     $AE6B
        .byte   $64
        .byte   $14
        .byte   $CF
        .byte   $3C
        lda     $F3AE
        .byte   $23
        .byte   $8F
        .byte   $2B
        .byte   $6F
L2EE8:  .byte   $2B
        .byte   $3B
        ror     $A758
        jmp     LC8F9

        .byte   $8B
        adc     $A973
        sed
        .byte   $7C
        cld
        adc     $F3,x
        .byte   $67
        txa
        and     #$DC
        .byte   $7C
        sbc     ($AF,x)
        and     ($8D),y
        .byte   $C7
        dec     L714B
        .byte   $F3
        sta     $B7,x
        ora     $43,x
        lda     LD67C,x
        cli
        adc     ($75,x)
        .byte   $7F
        .byte   $44
        inc     $DC
        .byte   $7C
        .byte   $F2
        .byte   $1B
        sta     ($67),y
        eor     L2657,x
        ror     $3D
        sbc     ($6B),y
        .byte   $9C
        txa
        .byte   $9C
        .byte   $7C
        .byte   $F2
        .byte   $CF
        .byte   $8B
        brk
        adc     $F3,x
        adc     ($9F,x)
        sec
        .byte   $DF
        cmp     #$32
        tya
        .byte   $05
L2F33:  .byte   $9F
        .byte   $3C
        .byte   $C7
        eor     ($20,x)
        .byte   $07
        .byte   $5F
        rol     $1D,x
        .byte   $7C
        cmp     $EB,x
        .byte   $9E
        cmp     $83
        stx     L32BE
        clc
        .byte   $7A
        sbc     $EBB0,y
        .byte   $CB
        sta     $D6E6,y
        .byte   $FB
        .byte   $7F
        .byte   $87
L2F51:  cmp     L5F67
        .byte   $3C
        .byte   $27
        txs
        .byte   $80
        adc     ($F3),y
        adc     $F3E1
        eor     L198F,y
        ora     $5B
        cpy     $DDB0
        .byte   $1B
        sed
        .byte   $7C
        cld
        adc     $F3,x
        .byte   $83
        .byte   $DA
        .byte   $DF
L2F6E:  .byte   $44
        .byte   $02
        .byte   $EB
        inc     $B3
        .byte   $AF
        .byte   $9E
        lsr     $35
        jsr     LCD2A
        .byte   $74
        .byte   $62
        cmp     L50D1
        ora     $66
        .byte   $EF
        ora     $9DB1
        ldy     L48D5,x
        cpy     #$07
        .byte   $1F
L2F8B:  sec
        .byte   $23
        .byte   $D7
        cmp     L759F
        eor     #$C7
        dec     $0417
        adc     $E5,x
        adc     L6576
        .byte   $E1
L2F9C:  .byte   $F3
        .byte   $5B
        sbc     ($E5,x)
        stx     L7E66
        .byte   $1F
        rol     $1E,x
        .byte   $1F
        and     $57,x
        adc     L5921,y
        cmp     L0CEC,x
        .byte   $E7
        .byte   $CF
        brk
        ldx     $DC,y
        lsr     $76,x
        and     $21,x
        inc     $0D
        .byte   $B7
        sty     $F5,x
        .byte   $87
        ora     $D9E7,y
        .byte   $F3
        eor     $7B,x
        tya
        jsr     L7CBD
        cpx     $F7
        .byte   $5F
        .byte   $37
        eor     $D7D5,y
        eor     L21AE,x
        ldy     $66,x
        lda     $55,x
        .byte   $6F
        .byte   $4F
        .byte   $7C
        ldx     $D9,y
        .byte   $F2
        .byte   $93
        .byte   $D7
        cmp     L61B5
        .byte   $C7
        .byte   $1F
        and     L54D5,y
        .byte   $83
        .byte   $9F
        and     $02CB,x
        .byte   $AF
        .byte   $1F
        sec
        .byte   $6B
        ror     $A1
        .byte   $C7
        cmp     L728F
        adc     $DB57,x
        pla
        .byte   $43
        .byte   $D7
        dec     $F159
        .byte   $F3
        adc     ($88,x)
        .byte   $7A
        .byte   $DF
        eor     ($EB,x)
        .byte   $E7
        .byte   $BB
        sty     $9BCF
        ldy     L3D19,x
        .byte   $02
        .byte   $E3
        .byte   $E7
        and     $F93A,y
        .byte   $B2
        ldx     L3FEB,y
        txs
        adc     $E6
L301A:  .byte   $1A
L301B:  sbc     $FC9E,y
        .byte   $0F
        .byte   $D7
        beq     L304F
        eor     L2CF7
        ora     #$18
        .byte   $07
        .byte   $5F
        and     $9C,x
        .byte   $7C
        sbc     $59,x
        .byte   $E1
L302F:  .byte   $F3
        stx     $3E,y
        .byte   $1F
        and     $DE0C,y
        ora     $D7
        cmp     L5ED7
        cli
        .byte   $6B
        .byte   $AE
        .byte   $87
L303F:  brk
        rol     L6FBE
        sty     $7C,x
        rol     $B86D,x
        .byte   $F2
        ldx     $CE,y
        rol     L3BB9,x
        .byte   $AB
L304F:  .byte   $23
        rti

        asl     a
        adc     $06DE,x
L3055:  rti

        .byte   $14
        cmp     $E57C,x
        plp
L305B:  asl     $BF
        .byte   $DB
        iny
        ora     L6819,y
        clc
L3063:  .byte   $7A
        .byte   $FB
        jsr     L7365
        .byte   $74
        sta     $73,x
        beq     L3063
        jmp     (LE361)

L3070:  cmp     #$B3
        .byte   $3F
        .byte   $1D
L3074:  sec
        .byte   $F4
        adc     $6E,x
        dec     L3C17
        sbc     $D164,y
        .byte   $2B
        sei
        adc     $F006,x
        .byte   $7A
        .byte   $32
        .byte   $77
        .byte   $B2
        .byte   $B7
        .byte   $7A
        php
        sta     ($8C,x)
        rol     $BB9C,x
        .byte   $C3
        adc     #$BE
        .byte   $80
        .byte   $8C
        .byte   $3F
L3095:  rol     $5F
        rol     $5F,x
        rol     $1E
        inc     $1A
        inc     $50
        .byte   $FC
L30A0:  cpx     $F361
        .byte   $64
        sbc     #$11
L30A6:  rts

        .byte   $74
L30A8:  adc     L5306,y
        .byte   $4F
        .byte   $23
        .byte   $2F
        .byte   $63
        .byte   $1F
        pha
        ror     a
        bmi     L30A6
        .byte   $06
L30B5:  bvc     L303F
        .byte   $AB
        .byte   $9C
L30B9:  adc     $C042,x
        eor     $D5
        .byte   $CF
        .byte   $34
        .byte   $0E
L30C1:  ldx     $FE4D,y
        adc     $CEF5
        .byte   $5C
        ldy     $AC3D
        adc     $9D0D,x
        stx     $AE9C
L30D1:  asl     $98A2,x
        inc     $EE6F
        adc     #$EE
L30D9:  .byte   $8B
        .byte   $27
        .byte   $4E
L30DC:  sty     $5F,x
        rol     $1E,x
L30E0:  .byte   $27
        .byte   $2E
L30E2:  stx     $1E,y
        rol     $1F,x
        pha
        .byte   $77
        .byte   $74
        sbc     $6D,x
        beq     L3154
        .byte   $F5
L30EE:  adc     $E4
        .byte   $3A
        txa
        .byte   $0F
        ror     $9F
L30F5:  .byte   $22
        inx
        iny
        sta     $B2A8
        sbc     $73
L30FD:  sbc     $74,x
        .byte   $EF
        adc     $ED,x
        adc     ($E7,x)
L3104:  .byte   $63
        sbc     ($74,x)
        .byte   $F2
        adc     #$F3
        bvs     L30F5
        bvs     L30FD
        .byte   $72
        sbc     ($65,x)
        .byte   $F4
        .byte   $6F
        sbc     $E96C
        adc     $E7,x
        eor     $EE,x
        adc     $F6
        adc     $A994
        .byte   $07
L3120:  .byte   $9B
        .byte   $A7
        .byte   $0C
        rol     a
L3124:  .byte   $3A
        sbc     L70AA,y
        bcc     L31A1
        rol     $70,x
        lda     $B4F4,y
        bvs     L30E2
        inc     $34,x
        .byte   $FA
        rol     $FA,x
        .byte   $BB
        .byte   $74
        bcc     L3104
        .byte   $89
        .byte   $FF
        sbc     $95CF,x
        .byte   $97
        inx
        .byte   $83
        lda     ($BF),y
L3144:  .byte   $89
        .byte   $8E
        .byte   $29
L3147:  clv
        tya
        .byte   $7A
        ldy     #$EC
        .byte   $83
        ldy     $5F,x
        clv
        .byte   $83
L3151:  .byte   $C2
        .byte   $0B
        .byte   $5B
L3154:  and     $BA5B,x
        cli
        .byte   $A3
L3159:  .byte   $B3
        sta     $95B3
        .byte   $9B
        .byte   $A5
L315F:  .byte   $A7
        sta     L1C16,x
        .byte   $BD
        .byte   $5A
L3165:  and     $BF4B,x
        cpx     $63
        and     ($BF,x)
        ora     $BF35,y
        .byte   $13
        .byte   $D3
        .byte   $BF
        .byte   $23
        .byte   $3D
L3174:  .byte   $37
L3175:  .byte   $3D
L3176:  .byte   $A3
        .byte   $EB
        sbc     $7D
        .byte   $1D
        .byte   $15
L317C:  cmp     ($BF),y
        .byte   $2F
        .byte   $3D
        .byte   $0D
L3181:  ldx     $8237,y
        .byte   $5A
        .byte   $37
        ror     L4C7A,x
        rol     L4834,x
        sbc     $F2,x
        .byte   $23
        .byte   $66
L3190:  ror     a
        bmi     L31CA
        rol     $A7
        .byte   $03
        nop
        .byte   $7A
        rol     $58,x
        .byte   $3C
        .byte   $E3
L319C:  .byte   $C3
        nop
        .byte   $7B
        .byte   $7E
        .byte   $56
L31A1:  rol     a
        rts

        rol     $E477,x
        .byte   $C3
        dec     L267A,x
        ror     a
        lsr     $2E
        plp
        .byte   $3B
        ldy     $7C,x
L31B1:  lda     $D748,x
L31B4:  .byte   $8F
        txa
        txs
        .byte   $9B
        .byte   $23
        .byte   $4C
L31BA:  cpx     $F5
        .byte   $0B
        brk
        iny
        sta     $9093
        asl     a
        .byte   $1A
        lda     $D760,y
        .byte   $34
        sbc     $8B
L31CA:  .byte   $32
        sbc     $2A,x
L31CD:  bit     $DB
        ldy     #$AD
        clc
        iny
        bcs     L31BA
        sbc     $ED,x
        tsx
        .byte   $0F
        .byte   $9E
        tay
L31DB:  .byte   $C2
        ora     $02E6,y
        ldx     a:$43
        .byte   $3C
        ror     a
        .byte   $67
        .byte   $83
        cpy     L46DA
L31E9:  .byte   $42
        bit     L6088
        bcc     L3174
        .byte   $0E
L31F0:  .byte   $9B
        sbc     #$B9
        ror     $C178
        dec     $A15E
        .byte   $C3
        .byte   $27
        .byte   $34
        .byte   $44
        .byte   $2F
        .byte   $AD
        .byte   $B9
L3200:  .byte   $1B
        .byte   $32
        cpx     #$BB
        rol     $F145
        stx     $98
L3209:  .byte   $53
L320A:  .byte   $7A
        dec     $7A
        sta     $CE,x
        .byte   $54
        .byte   $84
L3211:  sta     $A11F,y
        .byte   $B3
        .byte   $13
        .byte   $3C
        adc     $A235
        adc     ($30),y
        brk
        sbc     $99,x
        .byte   $97
        and     $00,x
        adc     $D3,x
        ora     $1C
        cli
        .byte   $3A
        .byte   $74
        .byte   $19
        .byte   $79
L322B:  .byte   $F7
        clc
        .byte   $9E
        .byte   $52
        .byte   $32
        asl     $27
        sei
        .byte   $6B
        .byte   $92
L3235:  ror     L6FC8,x
        ora     $BD,x
        .byte   $22
        adc     L658C
        .byte   $5A
        ora     L4472
        and     #$10
        bne     L328B
        pha
L3247:  eor     $D7FA,y
        .byte   $80
        ldy     $81
        ora     $FD3B
        cmp     ($92),y
        cmp     $6B
        eor     #$9B
        asl     a
        ora     $8A,x
        adc     $9F
        .byte   $3A
        adc     $43
        cli
        .byte   $0F
        ldy     #$AF
        ldx     L8518
        ora     L7AEB,x
        sbc     $9260,y
        .byte   $4B
        .byte   $87
        cmp     ($47),y
        .byte   $73
        .byte   $92
        .byte   $13
        .byte   $12
        .byte   $D3
        .byte   $72
        ora     $6E
        sbc     L8455,y
        .byte   $54
        lda     L61B2,y
        cmp     ($DC),y
        .byte   $0C
        .byte   $D2
        cmp     ($73),y
        dec     $9B
L3286:  adc     $66
        .byte   $03
        sty     $A9,x
L328B:  .byte   $A7
        .byte   $89
        adc     $1C
        cmp     ($B2),y
        .byte   $FC
L3292:  .byte   $7C
        .byte   $80
        .byte   $43
        .byte   $03
        ora     $01
        iny
        bit     $65
        sta     L1B1A
        .byte   $A7
        ror     $A1,x
        .byte   $A7
        sec
        .byte   $74
        sbc     #$91
L32A6:  sta     $1A,x
        asl     L4673,x
        .byte   $E2
        cpx     $99
        .byte   $14
        .byte   $32
L32B0:  .byte   $53
        cpy     #$6A
L32B3:  rts

        .byte   $23
        .byte   $22
        asl     L4764,x
        .byte   $5F
        stx     $E9
        .byte   $2F
        .byte   $B1
L32BE:  ora     ($61),y
        bne     L32C5
        .byte   $44
        .byte   $44
        .byte   $07
L32C5:  pla
        .byte   $77
        bpl     L3286
        .byte   $D4
        .byte   $1F
        .byte   $72
        .byte   $3B
        sbc     $71
        asl     $99
        cmp     $E2
        asl     $20,x
        .byte   $34
        .byte   $4B
        rts

        ror     $F1
L32DA:  txs
        lsr     $91,x
L32DD:  asl     a
        lsr     $D9,x
        dec     $35
        pla
        txs
        bvs     L32FC
        .byte   $4B
        asl     $F6,x
        .byte   $1A
        .byte   $92
        rol     $17
        inc     $9EB7,x
        .byte   $B7
        adc     ($FD,x)
        and     L3919
        jsr     L4362
        lsr     $CD
        .byte   $16
L32FC:  cmp     ($11,x)
        ora     L5FBF,y
        ora     $26,x
        .byte   $43
        .byte   $DC
        .byte   $54
        .byte   $89
L3307:  .byte   $62
        .byte   $64
        cpx     #$2D
        ora     L44AD,y
        bvs     L32DD
        .byte   $04
        .byte   $D4
        adc     #$16
        rol     $7B
        dec     $95,x
        .byte   $6F
        .byte   $22
        pha
        .byte   $C6
L331C:  ora     $9A,x
        ora     ($A7,x)
        .byte   $27
L3321:  bit     L234B
        .byte   $E4
L3325:  adc     #$66
L3327:  eor     ($94),y
        .byte   $81
L332A:  sty     $4C
L332C:  sty     $EC,x
        .byte   $69
L332F:  .byte   $1B
        eor     ($A3,x)
        dec     L870C
        .byte   $27
L3336:  sei
        .byte   $63
        eor     #$EF
        cpy     L4ECB
L333D:  .byte   $4B
        .byte   $92
        clc
        .byte   $62
        .byte   $FA
L3342:  .byte   $D7
        sta     $9644,y
        dey
        dec     $054B
        .byte   $80
L334B:  eor     $9168,x
        .byte   $AF
        .byte   $DB
        sei
        .byte   $57
        .byte   $AE
        sed
L3354:  .byte   $5A
        tya
        .byte   $57
        cpx     #$6F
        .byte   $EB
        dec     L5D68,x
        .byte   $EB
L335E:  .byte   $7A
        .byte   $CF
        jsr     LA0D6
        .byte   $DC
        .byte   $20
        .byte   $DC
L3366:  ldy     #$E0
        jsr     $A0E1
        .byte   $E2
        jsr     L20F7
        .byte   $FC
        ldy     #$8B
        and     ($08),y
        eor     ($08),y
        sta     ($08),y
        .byte   $CD
        .byte   $0B
L337A:  .byte   $3F
        dec     $50,x
        tya
        .byte   $90
L337F:  txs
        bvc     L331C
L3382:  bcc     L3321
        .byte   $50
L3385:  .byte   $9F
        bvc     L3327
        bne     L332A
        bcc     L332C
        bne     L332F
        bpl     L3336
        bvc     L333D
        .byte   $90
L3393:  ldx     $B5D0
        ldy     #$85
        .byte   $AF
        .byte   $14
        .byte   $20
L339B:  ldy     $31,x
        .byte   $A4
L339E:  and     ($C4),y
        and     ($E4),y
        .byte   $32
        sty     $32
        cpy     $32
        .byte   $D4
        .byte   $32
        cpx     $33
        .byte   $D4
        .byte   $34
        .byte   $F4
        rol     $24,x
        .byte   $37
L33B1:  .byte   $14
L33B2:  sec
        .byte   $74
        and     L3DD4,y
        lsr     a
        and     ($F3,x)
        lda     (L00F9,x)
        and     ($80,x)
        ldx     #$02
        .byte   $22
        .byte   $04
        .byte   $22
        ora     $A2
        .byte   $0C
        .byte   $22
        .byte   $14
        .byte   $22
        ora     $A2,x
        and     ($22,x)
        and     ($A2,x)
        .byte   $22
        ldx     #$23
        ldx     #$3D
        .byte   $22
        pha
        eor     ($12),y
        .byte   $89
        .byte   $12
        cmp     L1D13
        .byte   $13
        .byte   $71
L33DF:  bpl     $3373
        inc     $D624
        and     #$C9
        .byte   $2F
        .byte   $A3
        inc     $81
        pha
        .byte   $02
        sty     L8952
        .byte   $33
L33F0:  ora     ($B0),y
        stx     $0C,y
        .byte   $3C
        ldx     $CAC3
        ror     $2A
        pla
        .byte   $B7
        .byte   $F2
        lsr     L142A
        sta     ($8E),y
        lsr     a
        plp
        clv
        dex
        .byte   $97
        txa
        .byte   $92
        bit     $37
        .byte   $F2
        tsx
        brk
L340E:  lda     #$C0
        .byte   $16
L3411:  .byte   $9C
        brk
        .byte   $32
        .byte   $02
        .byte   $0B
        .byte   $9E
        .byte   $32
        sbc     ($0C,x)
        .byte   $3B
        .byte   $C3
        cpx     $2A
L341E:  adc     $A6
        and     $80
        asl     $34
        .byte   $AB
        .byte   $72
        dec     $E022,x
        tay
        sta     ($20),y
        inx
        cmp     ($9B),y
        stx     $0F,y
        .byte   $7C
        eor     $DFFD,x
        lsr     $CEEB,x
        lda     ($BB,x)
        .byte   $CF
        .byte   $45
L343C:  stx     $5E,y
        asl     $30,x
        .byte   $17
        ora     #$FA
        .byte   $61
L3444:  .byte   $9F
        and     ($25,x)
        bit     $44
        .byte   $D4
        bcs     L3481
        sbc     $48,x
        stx     $C4
        .byte   $54
        .byte   $66
L3452:  sbc     ($1B),y
        .byte   $17
        eor     ($A4),y
        rol     a
        asl     $F1
L345A:  .byte   $22
        bit     $B49C
        bit     L1DF1
        cmp     $BB
        sta     $89
        cmp     $BA
        .byte   $F3
        .byte   $72
        .byte   $1B
        ldy     $CF
        bit     $51
        adc     #$18
        .byte   $3C
        pha
        bpl     L34CC
        .byte   $43
        sty     $80
        ror     a
        .byte   $73
        dec     $CD
        stx     $DD,y
        .byte   $91
L347E:  cmp     #$5E
        .byte   $72
L3481:  .byte   $A3
        adc     $A5
        cpx     #$ED
        ora     $3C,x
        lsr     $51
        adc     #$B0
        .byte   $77
        stx     $D5,y
        .byte   $9B
        lda     ($C7),y
        .byte   $2B
        cli
        ror     L1A77
L3497:  .byte   $62
        eor     #$4D
L349A:  asl     $38
        .byte   $16
L349D:  .byte   $CE
L349E:  .byte   $05
L349F:  ora     ($28),y
L34A1:  cld
L34A2:  .byte   $6B
        stx     $B3,y
        cmp     $DB92,y
        stx     $71,y
        .byte   $CF
L34AB:  ora     $A4A7,y
        ora     ($16,x)
        sbc     ($9E,x)
        .byte   $07
        .byte   $44
        .byte   $F4
        cpx     L5EB1
        adc     ($D1,x)
        sei
        .byte   $43
L34BC:  .byte   $69
L34BD:  adc     L00F9
        .byte   $54
        .byte   $04
        .byte   $BF
        .byte   $52
        .byte   $33
        and     ($43,x)
        .byte   $23
        asl     a
        lsr     $D9
        cpx     $97
L34CC:  and     ($A3,x)
        jmp     (LE74A)

        and     L4A30
        sta     ($A6,x)
        adc     $6E,x
        .byte   $92
        eor     $13,x
        ora     ($01,x)
        lda     ($0C),y
        lsr     $99,x
        .byte   $45
L34E2:  cpy     $91
        .byte   $D2
        .byte   $13
        lda     ($E9,x)
        .byte   $1A
        jmp     L97CF

        cli
        stx     $45,y
        cmp     L8A91
        cmp     ($22),y
        .byte   $62
        ror     $C392
        .byte   $07
        jsr     L8547
        ror     L00F9,x
        lda     L6128,y
        .byte   $D2
L3502:  .byte   $1A
        adc     $C7
        sbc     L0C26,y
        .byte   $6F
        eor     ($66),y
        sbc     $8C,x
        sta     ($A2,x)
        sta     ($32),y
        jmp     (L571E)

L3514:  cmp     ($23,x)
        .byte   $3A
        .byte   $63
        .byte   $3A
        sty     $4A
        sta     $9203,y
        .byte   $42
        .byte   $9B
        rol     L4ECB,x
        .byte   $4B
L3524:  eor     L13CB
        ora     $44,x
        .byte   $0B
        .byte   $97
        .byte   $02
        .byte   $D3
        cmp     $B7
        eor     ($C8,x)
        eor     #$D8
        asl     $84,x
        cli
        .byte   $83
        sta     ($89,x)
        eor     L1FAF
        rol     $1E
        .byte   $B2
L353F:  txs
        eor     ($F2),y
        cmp     ($DD,x)
        and     $D127,y
        .byte   $23
        .byte   $AC
        .byte   $42
L354A:  .byte   $DC
        .byte   $64
        bvc     L35B7
        clc
        .byte   $CF
        sbc     L89D1
        pha
        brk
        bit     $BA
        .byte   $64
        .byte   $9F
        and     $8F
        adc     L1F26,x
        eor     $2C
        .byte   $92
        sbc     #$4E
        .byte   $92
        .byte   $E2
L3565:  clc
        .byte   $37
        cmp     #$14
L3569:  stx     $19
        .byte   $52
        adc     ($01,x)
        ora     L44A6,y
        beq     L3589
        sta     $99
        rts

        .byte   $BF
        sta     $F4,x
        cpx     L2150
        .byte   $CB
        asl     $CE09,x
        eor     L1E88,y
        .byte   $F2
        ldy     $98
        .byte   $B5
L3587:  eor     ($86),y
L3589:  .byte   $0F
        sta     $71
        .byte   $10
L358D:  .byte   $DB
        .byte   $14
        jmp     L9428

        adc     ($20),y
        eor     ($D8),y
        .byte   $52
        .byte   $42
        stx     $41
        eor     ($31),y
        .byte   $92
        .byte   $D3
        .byte   $04
        dec     $A1,x
        .byte   $89
        .byte   $6B
        .byte   $1A
        .byte   $62
        ora     L7E11,y
        .byte   $4B
        .byte   $FC
        .byte   $13
        .byte   $DA
        .byte   $66
L35AD:  .byte   $F4
        .byte   $92
        .byte   $6B
        and     ($A5),y
        lda     $D6E0,y
        .byte   $4C
        .byte   $77
L35B7:  sta     ($44),y
        asl     $C5
        and     ($15,x)
        lsr     L1D13
        and     ($10,x)
        .byte   $43
        .byte   $81
L35C4:  bvc     $35C7
        .byte   $CB
        bmi     L35DC
        and     L8631,x
        ora     $25,x
        cpy     #$40
        .byte   $4B
        lsr     $86
        lda     #$20
        ldy     L1931
        cpy     $64
        .byte   $C3
        .byte   $15
L35DC:  cmp     ($16),y
        rts

        .byte   $DC
        brk
        .byte   $33
        eor     $DF
        sbc     #$86
        cmp     ($2A,x)
        cmp     ($35,x)
        iny
        adc     $F4
        eor     #$D2
        .byte   $62
        .byte   $49
L35F1:  brk
        sta     L7354,y
        .byte   $53
        and     ($A6,x)
        rti

        adc     ($83,x)
        .byte   $64
        .byte   $D4
        .byte   $3C
        .byte   $F4
        bcc     L3652
        .byte   $CF
        ora     L1266,y
        and     ($C8,x)
        sty     $58
L3609:  ora     L5013,y
        sbc     $07
        sta     L1184,y
        ldy     #$B8
        ora     $C6B3,y
        ror     a
        .byte   $3C
        ldy     $91,x
        .byte   $34
        cmp     L5616,x
L361E:  asl     $89,x
        sta     L128D
        ora     ($1A),y
        bne     L35C4
        adc     ($30,x)
L3629:  .byte   $7A
        eor     ($C1),y
L362C:  asl     a
        .byte   $1D
        .byte   $06
L362F:  .byte   $67
        bit     L3159
        .byte   $6D
        clc
L3635:  asl     L2152
        iny
        .byte   $7A
        bvs     L36AA
        .byte   $1F
        .byte   $04
        sta     L261D
        .byte   $E3
        and     ($73,x)
        cpy     $1C
        ldy     #$4E
        .byte   $5A
        lsr     $5D
        .byte   $47
        ora     $74,x
        ora     #$C1
        inc     $49,x
L3652:  txs
        lsr     $47
        pha
        pha
        .byte   $4D
L3658:  adc     #$98
        cpy     #$78
L365C:  .byte   $6B
        .byte   $13
        .byte   $04
        .byte   $13
        .byte   $3D
        brk
L3662:  lda     L6126
L3665:  .byte   $E2
        lsr     $31
        rol     a
        cmp     #$71
        cmp     L6774
        .byte   $07
        ldy     $77
        stx     $80
        asl     $DC0D
        .byte   $97
        inx
        .byte   $87
        .byte   $42
        .byte   $13
        eor     #$06
        ora     ($2E,x)
        cli
        ldx     #$52
        eor     L5822
        .byte   $63
        .byte   $03
        .byte   $D2
        rts

        bvc     L361E
        .byte   $9C
        .byte   $92
        bvs     L3629
        .byte   $3F
        bcc     L3692
L3692:  .byte   $12
        lda     $EC02
        .byte   $DC
        .byte   $DA
        ora     $62
        sec
        .byte   $89
        .byte   $77
        .byte   $89
        eor     L608C,x
        rol     a
        bvs     L3635
        .byte   $74
        .byte   $D4
        sbc     #$31
        .byte   $12
        txa
L36AA:  .byte   $97
        sta     L5428
        .byte   $E3
        .byte   $7F
        .byte   $4B
L36B1:  jmp     L4588

        bcc     L36E4
        and     #$63
        brk
        .byte   $14
        .byte   $92
        sei
L36BC:  .byte   $A3
        .byte   $C0
L36BE:  cpx     $2F
        ora     $10,x
        cpx     #$99
        ora     $22
        .byte   $0B
L36C7:  .byte   $24
L36C8:  .byte   $82
        .byte   $FB
        stx     $40,y
L36CC:  .byte   $87
        iny
        .byte   $93
        adc     L3292,y
        ror     $E20E,x
L36D5:  ldx     $CC
        lda     $D480
        .byte   $B2
        ldy     $98,x
        .byte   $43
        rol     L0D27
        cpx     #$AA
        clc
L36E4:  .byte   $83
        .byte   $A3
        .byte   $34
        cpy     $29
        .byte   $83
        cli
        and     ($CC,x)
        cmp     $A0
        .byte   $77
        .byte   $33
        .byte   $C3
        bvc     L3721
        brk
        .byte   $4C
L36F6:  .byte   $DC
        .byte   $C9
L36F8:  bit     $74
        .byte   $B2
        txa
L36FC:  tya
        sta     $952D
        .byte   $23
        ldy     #$32
        rol     $7A
        .byte   $62
L3706:  .byte   $C3
        sec
        and     $B68B,x
        .byte   $C3
        ora     L2C98,y
        rol     $9B90
        rol     $2E
        cmp     #$85
        .byte   $02
        .byte   $D4
L3718:  cpy     #$CD
        jsr     LBC2C
        .byte   $B2
        ora     ($80,x)
L3720:  .byte   $C2
L3721:  tay
        dec     $C1
        .byte   $A3
        bit     $01
        jmp     L02A6

        tsx
        .byte   $03
        .byte   $5A
        plp
L372E:  .byte   $22
        .byte   $43
        .byte   $4E
L3731:  tay
        .byte   $3C
        dey
        pla
        rol     $10
        sty     $C305
        bvc     L3706
        ldy     L60B8,x
        .byte   $92
        .byte   $9E
        plp
        .byte   $6C
L3743:  cmp     L2DC4,x
        tax
        rol     L0A7B
        dec     $37
        .byte   $33
        txa
        lda     ($29),y
        bpl     L3731
        .byte   $03
        .byte   $E3
L3754:  .byte   $3A
        lda     $EC32,x
        .byte   $2F
        rol     a
        .byte   $32
        .byte   $E7
        bvs     L36F6
        tax
        .byte   $07
        .byte   $D2
        nop
        bpl     L3718
        .byte   $E2
        jmp     LBEE1

        .byte   $89
L3769:  adc     $D9A9,y
        .byte   $62
L376D:  .byte   $27
        asl     $AE58
L3771:  jsr     L90EC
        sei
        rol     $83,x
        sty     $B7
        .byte   $80
        cmp     ($B0),y
        bcs     L3790
        .byte   $2F
        tay
        .byte   $D4
        bvc     L378B
        and     #$C8
        cld
        ldx     #$41
        .byte   $C2
        .byte   $D7
        .byte   $89
L378B:  .byte   $13
        .byte   $89
        lsr     $18,x
        tay
L3790:  .byte   $B2
        .byte   $CB
        .byte   $59
        .byte   $90
L3794:  bcc     $37A3
        .byte   $72
        rts

        .byte   $62
        cpy     L8987
        .byte   $82
        .byte   $67
        .byte   $34
        ldy     $CB71,x
        .byte   $9E
        .byte   $52
        lsr     $50,x
        .byte   $F4
        and     L23B4
L37AA:  plp
        .byte   $9B
        eor     $AD2E,y
        .byte   $63
        rti

        .byte   $1C
        sta     $0A,x
        .byte   $3F
L37B5:  txs
        .byte   $74
        ora     L7789,y
        .byte   $82
        tay
        txs
        inx
        rol     $E190
        cmp     #$86
        .byte   $53
        .byte   $13
        pha
        .byte   $AB
        .byte   $A3
        eor     $F35D
        rol     $42
        inx
        .byte   $9C
        tsx
        cli
        ora     #$13
        ora     #$42
        .byte   $13
        .byte   $27
        dey
        sta     $B826,x
        .byte   $AF
        ldy     $A7
        pha
        bcc     L376D
        .byte   $9E
        sta     L230A,x
        .byte   $7B
        lsr     $32
        .byte   $D4
        bit     L2343
        cpx     #$31
        php
        .byte   $7A
        .byte   $2F
        rol     a
        .byte   $80
        inc     L7931
        brk
        .byte   $0C
        sta     L087B,y
        .byte   $82
        .byte   $23
        .byte   $CC
        .byte   $E3
L37FF:  inc     $5C,x
        cpy     $59
        and     ($4B),y
        .byte   $83
        cpy     #$E2
        pha
        .byte   $33
        .byte   $1F
        dey
L380C:  .byte   $EB
        .byte   $AB
L380E:  .byte   $9E
        txa
        asl     $02
        .byte   $F3
        ldy     L1F2E,x
        bit     $49
        rti

        .byte   $A7
        txa
        .byte   $9C
        .byte   $33
L381D:  .byte   $CB
        .byte   $54
        dec     L6355
        pha
        and     $968F,x
        .byte   $33
        bpl     L37B5
        eor     L3C23,x
        adc     #$66
        iny
        .byte   $97
        bcc     L385E
        .byte   $D2
        and     $14,x
        txa
        ldx     #$0B
        .byte   $F2
        lda     #$0B
        .byte   $3B
        ldy     $65
        ldx     $A6
L3840:  .byte   $0B
        sta     $40
        .byte   $9C
        .byte   $2F
        .byte   $26
L3846:  .byte   $C3
        .byte   $1A
        txs
        rol     L4164
        sty     $1D,x
        .byte   $4B
        .byte   $8B
        .byte   $B3
        .byte   $1C
        .byte   $97
L3853:  php
        cmp     L3393
        dec     L8254
        sei
        bcc     L3846
        .byte   $31
L385E:  .byte   $82
        .byte   $52
        cmp     $E3
        .byte   $3A
        .byte   $E9
L3864:  and     $26
        rol     $8E
        .byte   $89
        cmp     $CA37
        nop
        .byte   $44
        dec     $B7
        .byte   $0C
        .byte   $74
        .byte   $BF
        and     ($9F),y
        lda     $0213,y
        bvs     L38DF
        bmi     L38DA
        ldy     $FD03
        .byte   $33
        .byte   $5B
L3881:  .byte   $DA
        .byte   $26
L3883:  .byte   $B7
        cmp     #$AD
        .byte   $53
        .byte   $7B
        .byte   $DF
L3889:  sta     ($85),y
        .byte   $33
        bne     L380E
        and     ($0B,x)
        sty     $42
        sbc     ($70,x)
        .byte   $DA
        bcs     L3853
        .byte   $FF
L3898:  .byte   $3B
        .byte   $AB
        .byte   $0C
        .byte   $3A
        .byte   $62
        ldy     $89
        ora     ($E5,x)
L38A1:  dey
        lda     $2B,x
        cld
        .byte   $8B
        ldy     #$91
        .byte   $33
        .byte   $3B
        ldy     $CB,x
        cli
        .byte   $A2
L38AE:  rti

        nop
        .byte   $54
        bit     $9149
        eor     $0389,y
        eor     #$D2
        .byte   $F2
        .byte   $74
        txs
        rol     $8EB6
        .byte   $6B
        .byte   $53
        bit     L87E3
        .byte   $1C
        .byte   $2B
L38C6:  .byte   $52
        adc     $C668
        .byte   $93
        cmp     ($CC,x)
        tya
        .byte   $83
L38CF:  .byte   $90
L38D0:  .byte   $93
L38D1:  .byte   $89
        .byte   $2C
        .byte   $83
L38D4:  jsr     $64FE
        sta     $DD18
L38DA:  .byte   $D3
        adc     L4C74,x
        .byte   $F1
L38DF:  lsr     a
        .byte   $2B
        plp
        .byte   $3C
        .byte   $E3
        lsr     a
        lda     L0F31,y
        ldx     $C2
        cld
        .byte   $97
        .byte   $3C
        .byte   $93
        .byte   $12
        rol     $ED68
        .byte   $BE
L38F3:  sbc     $F828,y
        .byte   $D3
        .byte   $3C
        and     L49AE
        ora     L3C0E,x
        eor     $4B,x
        .byte   $D7
        php
        .byte   $35
L3903:  .byte   $CC
L3904:  .byte   $A3
        .byte   $42
        .byte   $93
        .byte   $7C
        lda     L8B2C,x
        bpl     L38F3
        .byte   $0B
        ora     #$0C
        and     $8B,x
        ldy     $C2,x
        lsr     $E2
        and     #$02
        .byte   $DC
L3919:  ldy     L8228,x
        .byte   $9C
        .byte   $BB
        .byte   $54
        bit     $40
        .byte   $0F
        sec
        .byte   $C3
        ora     $9185,y
        .byte   $33
L3928:  and     L1148,y
        rol     L0D20
        .byte   $4C
        .byte   $09
L3930:  .byte   $92
        eor     #$33
        cli
        .byte   $5A
        .byte   $2F
        plp
        .byte   $53
        bit     L5C32
        .byte   $52
        .byte   $5D
L393D:  ror     a
        .byte   $B0
L393F:  .byte   $D7
        sta     L120B,y
L3943:  sta     L4E01,y
        bvs     L38D4
        pha
        .byte   $C2
        .byte   $EB
        ldy     $8D,x
        .byte   $22
        eor     $FE,x
        .byte   $92
        sbc     $BD,x
        bit     $8D
        .byte   $2E
        .byte   $3A
L3957:  eor     L286E
        tya
        .byte   $AC
L395C:  .byte   $2F
        asl     a
        clv
        .byte   $72
        bne     L3904
        .byte   $67
        iny
        sta     ($74),y
        rol     $09,x
        .byte   $8F
        ldx     #$6F
        dec     L3840,x
        sty     L5DCA
        .byte   $FB
        iny
        ldx     L4EA0
        bit     $8E
        .byte   $97
L3979:  and     ($8D),y
        bcc     L395C
        ora     #$82
        cmp     $94B3,y
        dec     L0CF2
        bvs     L3928
        bit     $B3
        .byte   $8F
        rol     L8833
        .byte   $27
        .byte   $23
        dey
        and     ($C9),y
        .byte   $8F
        .byte   $D0
L3994:  tay
        sta     $0B,x
        .byte   $E2
        .byte   $13
        ror     $8B
        lda     $A323,x
        sei
        .byte   $D4
        sbc     ($BA,x)
        bit     L3247
        lda     ($2A,x)
        stx     $CA,y
        cli
        and     L19CB,x
        .byte   $89
        .byte   $D2
        .byte   $DA
L39B0:  plp
        .byte   $1F
        .byte   $22
        eor     ($E3,x)
        .byte   $74
        .byte   $DF
        .byte   $0C
L39B8:  sei
        ldx     $F288,y
        sbc     ($54,x)
        sta     $44,x
L39C0:  asl     $03,x
        stx     $5A
        .byte   $44
        ldx     $62,y
        ror     a
        .byte   $74
        sta     ($D2),y
L39CB:  clc
        .byte   $BB
        .byte   $7B
        and     ($37),y
        .byte   $C1
L39D1:  .byte   $DA
        .byte   $7A
        lsr     L0060
        .byte   $32
        .byte   $7A
        ldy     $4C
        ora     #$41
        bvc     L3979
        bit     L8003
        .byte   $92
        sei
        sta     ($14),y
L39E4:  lda     L2E19,y
        dec     $E4
        lsr     a
        .byte   $74
        and     L6C62,y
        .byte   $3C
        dex
        sbc     #$2E
        and     ($02),y
        .byte   $74
        tsx
        lsr     a
        and     ($CD),y
        .byte   $82
        bmi     L3A39
        cpy     #$84
        sbc     $74
        .byte   $4B
        .byte   $D4
        sty     $39,x
        .byte   $43
        .byte   $B3
        tay
        .byte   $BC
        .byte   $34
L3A09:  sbc     $A6
        dey
        adc     $ABEE
        inc     $2E
        ora     $0C
        inc     $D8,x
        .byte   $07
        .byte   $82
        .byte   $5C
        ora     $DFED,x
        rol     a
        .byte   $63
        ora     L4897,x
        sty     $0C
        .byte   $33
        eor     $03C5,y
        .byte   $89
        .byte   $E2
        .byte   $F2
        .byte   $EF
        and     #$C4
        .byte   $CD
L3A2D:  .byte   $53
        rol     $CACC
        adc     $26,x
L3A33:  .byte   $1C
        .byte   $02
        .byte   $54
L3A36:  .byte   $2C
L3A37:  sbc     $49
L3A39:  .byte   $AF
        .byte   $D3
        bpl     L3A09
        stx     $84,y
        and     ($0B),y
        .byte   $B2
        eor     #$20
        .byte   $EE
L3A45:  asl     $73
        asl     $92
        sec
L3A4A:  .byte   $23
        .byte   $7A
        ora     #$32
        .byte   $6C
L3A4F:  .byte   $8C
L3A50:  adc     ($62),y
        tya
        sta     $D830
L3A56:  .byte   $89
        rol     $F408
        .byte   $77
        .byte   $FB
        .byte   $6B
        .byte   $89
        .byte   $C2
        stx     $DD2C
        cpx     $8C
        cpy     #$DD
        .byte   $DF
        asl     $EA
        .byte   $D9
        tay
L3A6B:  .byte   $FE
L3A6C:  .byte   $80
        sbc     L1D0B
        cpx     #$F5
        .byte   $B1
L3A73:  .byte   $96
L3A74:  and     #$A8
        tsx
        stx     $35,y
        tya
        cmp     $E929,y
        ldx     #$A8
        .byte   $0C
        .byte   $F3
        sta     $95,x
        .byte   $0F
        .byte   $B2
        rol     $EF,x
        .byte   $0B
        .byte   $B2
        .byte   $E3
        sec
L3A8B:  cmp     ($D3,x)
        sec
        beq     L3A56
        ora     #$D8
        .byte   $B2
        .byte   $0C
        .byte   $89
        rol     $BC00
        .byte   $CF
        clc
        .byte   $13
        ora     $C228,x
        .byte   $0C
        sec
        cmp     L3CE9
        .byte   $80
        lsr     a
        sbc     $A93E,y
        and     $FEED
        inx
        .byte   $B2
        pla
        sty     $988F
        sed
        lda     #$20
        cmp     ($0F,x)
        .byte   $8B
        .byte   $22
        sbc     ($55),y
        bmi     L3A4F
        sta     L1B90,y
        lda     L19BE,y
        .byte   $44
        .byte   $07
        .byte   $9B
        cpy     $AF09
        .byte   $03
        lda     L00F9,x
        .byte   $C7
        sta     L83A1
        asl     $99
        ldx     L113E
        bit     $2F
        .byte   $74
        lsr     L17C5
        eor     L0FE1,x
        .byte   $3C
        .byte   $17
        .byte   $27
        rol     L24FC,x
        lda     #$D3
        lda     ($AD,x)
        asl     a
        .byte   $57
        cmp     #$B2
        lda     $F429,y
        cpy     #$78
        .byte   $17
        sty     $69,x
        .byte   $9C
        .byte   $5A
        lsr     $10
L3AF7:  cmp     ($5C),y
        .byte   $12
        and     $B8
        sty     $B0
        sbc     ($84),y
        .byte   $53
        .byte   $97
        .byte   $53
        .byte   $D3
        bvc     L3AF7
        .byte   $64
        .byte   $22
        tya
        .byte   $07
        .byte   $9B
        .byte   $C3
        cmp     ($61,x)
        and     #$30
        .byte   $80
        .byte   $13
        cpy     #$FE
        cli
        adc     ($76),y
        ora     $41
        cmp     $D1
        .byte   $3C
        .byte   $72
        .byte   $C2
        ora     #$22
        .byte   $64
        sta     ($7A),y
        sbc     ($98,x)
        cpy     L65A8
        ora     $E9C2,y
        .byte   $CF
        tya
L3B2D:  sbc     $94
        lda     ($D3),y
        ora     $D664,x
        cpy     $D9
L3B36:  .byte   $17
        dec     $38
        lda     ($13),y
        lsr     $D2,x
        rol     $F3
        .byte   $9E
        bvs     L3B46
        .byte   $97
        dey
        inx
        .byte   $76
L3B46:  .byte   $F3
        .byte   $93
        eor     L1726,y
        .byte   $44
        eor     $76
        .byte   $DB
        .byte   $97
        .byte   $5C
        dec     $5D
        txs
        ror     $10
        .byte   $D3
        .byte   $DC
        ldy     $6A
        cpx     #$6E
        .byte   $97
        .byte   $62
        rts

        inx
        ror     $E2
L3B62:  lsr     $18
        nop
        nop
        ora     $51,x
        rti

        ldy     $9162,x
        sty     $21
        txa
        lda     L1A6C,y
        adc     $8B
        cpy     $77
        .byte   $13
        ldx     $29
        .byte   $37
L3B7A:  dec     $5C,x
        .byte   $77
        clc
L3B7E:  sbc     L560E
        sbc     L349D,y
        bcc     L3B7A
        .byte   $1C
        lsr     $72
        stx     $39
        iny
        rol     a
        .byte   $EF
        ldx     #$66
        .byte   $8B
        lda     $D24D
        dex
        .byte   $62
        sbc     ($1D),y
        rol     L4B6C
        asl     a
        .byte   $4B
        cmp     ($3C,x)
        .byte   $B2
L3BA0:  asl     a
        .byte   $32
        .byte   $6B
        sty     $2F,x
        lsr     a
        sta     $A420,x
        ldy     L8C28,x
        sbc     $C0
        .byte   $13
        .byte   $27
        and     $8DE4,y
        lsr     a
        plp
        .byte   $D3
        .byte   $9F
        .byte   $33
L3BB8:  .byte   $7D
L3BB9:  .byte   $FF
        .byte   $52
        eor     $F552,y
        and     ($33),y
        .byte   $CB
        .byte   $54
        ldy     L6CA6,x
        .byte   $C2
        .byte   $14
        clv
        and     L7839,y
        sta     $B7,x
        cpy     $A86B
        .byte   $92
        .byte   $7C
        dec     L4CA5,x
        cpy     L2ED9
        .byte   $82
        ldx     $65,y
        .byte   $A7
        .byte   $7A
        .byte   $63
        eor     #$9E
        ldx     #$4A
        .byte   $22
        jmp     (LB0B0)

        .byte   $1C
        tay
        .byte   $13
        cli
        sty     $AC,x
        txa
        and     ($2D),y
        .byte   $82
        inx
        dec     $F1
        asl     a
        .byte   $9C
        bit     $90A5
        .byte   $27
        .byte   $32
        .byte   $63
        .byte   $3C
L3BFC:  .byte   $1A
        .byte   $37
        .byte   $FB
        ldy     $A3BA
        rti

        tya
        and     $C18A,y
        .byte   $31
L3C08:  sta     $1A,x
        .byte   $93
        .byte   $2B
        .byte   $F3
        .byte   $79
L3C0E:  .byte   $8E
L3C0F:  sty     $8D90
        and     ($C6),y
        cpx     $C6
        .byte   $25
L3C17:  .byte   $2C
L3C18:  cpy     $4B25
        tya
        .byte   $23
        asl     L2B8A,x
        brk
        .byte   $92
        asl     a
L3C23:  .byte   $EB
        .byte   $62
        adc     $EBB5,y
        adc     L3DAC
L3C2B:  .byte   $6F
L3C2C:  .byte   $83
L3C2D:  .byte   $72
        .byte   $37
        ldy     $3C
        .byte   $6B
        ora     ($DA,x)
        plp
        .byte   $34
        cpx     $3D
        .byte   $6C
        .byte   $89
L3C3A:  .byte   $3C
        .byte   $89
        and     L24EE
        bit     $61
        eor     #$0A
        adc     ($43,x)
        rol     L9428,x
        bit     $0137
        .byte   $12
        .byte   $44
        .byte   $92
        lsr     a
        cpx     $B6B2
        .byte   $37
        dec     $F0,x
        .byte   $B7
        .byte   $7C
        .byte   $33
        .byte   $43
        .byte   $54
        .byte   $9E
        .byte   $14
        .byte   $22
        and     ($4A),y
        .byte   $FF
        sbc     $AF,x
        asl     $80
        cpx     #$A5
        asl     L3EE2
        txa
        .byte   $F1
L3C6B:  .byte   $BB
L3C6C:  .byte   $07
        cmp     #$A9
        .byte   $C2
        sta     $8B,x
        cpx     #$2E
        bcc     L3C0E
        jsr     L7862
        .byte   $CB
        dex
L3C7B:  .byte   $E2
        .byte   $37
L3C7D:  tay
        sta     L8351,x
        .byte   $0B
        .byte   $14
        .byte   $C3
        .byte   $64
        .byte   $9C
        .byte   $33
        .byte   $EB
        .byte   $64
L3C89:  .byte   $03
        sty     $B2,x
        .byte   $F4
        dec     $D6,x
        .byte   $4B
        .byte   $83
        .byte   $32
        cmp     #$C3
        rol     L530D,x
        ror     $F6,x
        clc
        asl     a
        .byte   $39
        .byte   $8B
L3C9D:  .byte   $6F
        jmp     LD4E3

        asl     L6C4D
        dec     $0568,x
        .byte   $4C
L3CA8:  nop
        brk
        sta     $08,x
        lda     L3382,y
        cld
        ldy     L412E
        bpl     L3C7B
        .byte   $FC
        sta     $0466
        .byte   $B7
        sty     $95
        dex
        rti

L3CBE:  ldy     $88,x
        sty     $80
        .byte   $FE
L3CC3:  .byte   $2B
        ror     $342E
        sta     ($B8),y
        tsx
        .byte   $53
        .byte   $2F
        eor     $CC12,y
        .byte   $72
        .byte   $5C
        cpy     #$EF
        rol     $BC6A
        .byte   $EB
        cmp     #$AE
        beq     L3D37
        sta     ($37),y
        cmp     #$68
        .byte   $8B
        rti

        lda     #$2F
L3CE3:  .byte   $07
        .byte   $F3
        ora     $4C,x
        and     ($A4),y
L3CE9:  lsr     a
        .byte   $5F
        asl     $B3
        bvc     L3CC3
        and     L6A4D
        ldy     $CE36,x
        .byte   $1C
        .byte   $3E
L3CF7:  sty     L3771
        .byte   $0C
        .byte   $72
        sbc     ($07),y
L3CFE:  bcc     L3D2B
        cli
        sbc     ($A9,x)
        .byte   $80
        .byte   $47
        .byte   $37
        .byte   $BB
        inc     L58D3
        .byte   $2B
        ora     $8ED9
        adc     #$13
L3D10:  eor     ($9C,x)
        brk
        sty     $BA
        sty     L299C
        .byte   $3B
L3D19:  .byte   $7C
        lda     $07E4,y
L3D1D:  .byte   $12
        pha
        .byte   $E3
        ora     $7C,x
        sta     $9B31,y
L3D25:  inx
        .byte   $39
L3D27:  and     ($03,x)
        .byte   $D4
        .byte   $30
L3D2B:  .byte   $8B
        .byte   $93
        .byte   $D2
        .byte   $D2
        .byte   $93
        .byte   $3C
        .byte   $1C
        .byte   $80
        ldy     L54C7
        .byte   $73
L3D37:  .byte   $1C
        .byte   $F3
        adc     $C3
        cld
        bcs     L3D5A
        ldy     L658C,x
        ldx     $CE
        .byte   $3B
        tax
        .byte   $92
        .byte   $9E
        .byte   $22
        bcc     L3CE3
        lsr     $25
        ldx     #$B9
        stx     $0C,y
        .byte   $73
        clc
        bmi     L3D27
        rol     $4B
        .byte   $03
        .byte   $D4
        sta     ($88),y
L3D5A:  .byte   $82
        .byte   $52
        cpx     #$F8
        bmi     L3D60
L3D60:  pla
        ldy     L8BA8,x
        eor     $A2,x
        .byte   $CB
        .byte   $1A
L3D68:  .byte   $02
        cpy     $D1
        bcc     L3D25
        .byte   $CC
L3D6E:  nop
        sta     $012F
        and     $97D3
        adc     ($43,x)
        .byte   $5C
        .byte   $0C
        eor     L74E0
        .byte   $DF
        rts

        .byte   $83
        lsr     L8257,x
        sbc     ($BE),y
        rol     a
        inc     $E380
        cpy     #$24
        .byte   $BB
        .byte   $3B
        php
        .byte   $83
        ora     ($E0),y
        and     $26
        cpy     L7C6A
        .byte   $CF
        .byte   $0C
        .byte   $B3
        .byte   $A7
        .byte   $6B
        .byte   $F2
        ror     L6A6A
        sei
        .byte   $A7
        .byte   $13
        and     L8386,x
        iny
        .byte   $BB
        cpx     #$8C
        .byte   $3B
        sed
        .byte   $B3
        .byte   $41
L3DAC:  .byte   $D4
        .byte   $DF
        sta     ($20,x)
        ldy     L0BDA,x
        txs
        .byte   $93
        .byte   $52
        .byte   $44
        ldx     $A20D,y
        ldx     $8C
        .byte   $6B
        rol     $BC78,x
        .byte   $80
        .byte   $CB
        .byte   $73
        adc     L89FA
        ldy     $73
        .byte   $1C
        .byte   $1F
        .byte   $34
        .byte   $CB
        .byte   $B4
L3DCD:  cmp     #$02
        .byte   $4F
        .byte   $32
        inc     $6C
        .byte   $BB
L3DD4:  .byte   $54
        plp
        plp
        .byte   $37
        .byte   $42
        .byte   $62
        jmp     LD4B8

        rol     L8BC6
        .byte   $89
        .byte   $73
        .byte   $7A
L3DE3:  sta     $D633
        jsr     LFD8B
        .byte   $7B
        cmp     $FC6D
        cpx     L7C6C
        adc     $E3FB
L3DF3:  cli
        .byte   $23
        asl     $ED4B
        .byte   $1B
        bcs     L3DE3
        sbc     $AC,x
        and     $D4
        rol     $8E62
        .byte   $7C
        rts

        ldy     $CD,x
        .byte   $74
        .byte   $54
        .byte   $27
        asl     $50
        .byte   $FA
        .byte   $0F
        .byte   $23
        and     $0221,x
        .byte   $DC
        rol     a
        sta     L4F6D
L3E16:  jmp     LE5E7

        sta     ($30),y
        .byte   $1A
        .byte   $27
        plp
        .byte   $12
        .byte   $F2
L3E20:  .byte   $53
        .byte   $33
        .byte   $B9
L3E23:  eor     $1252,y
        .byte   $4B
        .byte   $C3
        .byte   $72
        ldy     $A31D
        .byte   $C3
        rol     $14
        and     $4D,x
        .byte   $74
        asl     $0D,x
        cpx     #$C1
        sta     $EC2E
        sty     L4874
        .byte   $2F
        .byte   $7C
L3E3E:  .byte   $32
        cpx     $30
        .byte   $CF
L3E42:  .byte   $47
        .byte   $62
        rti

        ldy     #$82
        .byte   $2F
        .byte   $8F
        jsr     L0B3D
        .byte   $B3
        .byte   $D3
        .byte   $7B
        ora     $990D
        .byte   $80
        lda     $8F
        .byte   $25
L3E56:  plp
        and     $E5,x
        .byte   $2F
        bit     $D4
        .byte   $27
        bvc     L3E42
        .byte   $12
        .byte   $1E
L3E61:  bcs     $3E1D
        ldx     $2A
        jsr     LFEB6
        lsr     a
        .byte   $47
        ldx     #$64
        .byte   $CF
        .byte   $22
        .byte   $0B
        .byte   $A3
        rol     a
        .byte   $F9
        .byte   $E9
L3E73:  .byte   $22
        sei
        .byte   $5F
        .byte   $0B
        dec     $CF28,x
        .byte   $82
        .byte   $F4
        ldx     $BA,y
        .byte   $80
        .byte   $C7
        sta     ($C8),y
        sec
        asl     a
L3E84:  .byte   $5C
        .byte   $34
        cpx     #$08
        .byte   $12
        sbc     L70D6
        lda     $B07B
        .byte   $5C
        bit     L3181
        ora     $E081,x
        .byte   $CF
        .byte   $9C
        dey
        ldy     $A144,x
L3E9C:  cmp     ($FC,x)
        .byte   $13
        bit     $CD
        sei
        sty     L264B
        .byte   $22
        dex
        .byte   $22
        .byte   $3A
        sei
        .byte   $3F
        sta     $F979
        jmp     LF0CE

        .byte   $5B
        and     L5D77,y
        .byte   $0F
        .byte   $A2
L3EB7:  adc     #$80
        .byte   $BB
        plp
        .byte   $0B
        .byte   $63
        .byte   $7C
        .byte   $8D
L3EBF:  .byte   $82
        iny
        dec     L4BB6,x
        and     ($8B,x)
        iny
        ldx     $34,y
        ldx     $12,y
        bit     $1F
        and     $4B
        and     ($C1,x)
        ldx     $C730
        and     L63EA,y
        .byte   $1C
        lsr     a
        ldx     $03
        tya
        and     $0D
        .byte   $F3
        .byte   $74
        .byte   $22
        .byte   $FC
L3EE2:  dec     $19
        jmp     L18F4

        .byte   $33
        .byte   $83
        .byte   $F2
        .byte   $F2
        dex
        php
        .byte   $62
        cmp     ($C0),y
        cmp     L4927
        ror     $F782
        .byte   $AB
L3EF7:  ora     $33
        ror     $E399
        .byte   $87
        .byte   $8F
        pla
        lda     L25D6,y
        sty     $02
        ldx     #$57
        .byte   $83
        .byte   $2B
        .byte   $22
        .byte   $64
        sei
L3F0B:  and     L0CE4,y
        bit     L6B8C
        plp
        txs
        inc     L2908,x
        .byte   $A3
        lda     ($66,x)
        pla
        inc     $B5
        and     ($C0),y
        ldy     $BD,x
        .byte   $B6
L3F21:  sty     $96F8
        .byte   $CB
        .byte   $C7
        bcc     L3EF7
        clc
        pla
        .byte   $C2
        cpx     #$C0
        sta     L2DBB,y
        ora     L6C2C,x
L3F33:  and     L33F0
        iny
        rts

        cmp     L2DAF,x
        .byte   $72
        and     $41,x
        .byte   $67
        sty     $F8DA
        .byte   $D2
        bvs     L3F8B
        and     #$56
L3F47:  jmp     (L10A6)

        .byte   $D7
        .byte   $37
        .byte   $CF
        cpx     $B9
        lda     L202F,x
        adc     #$92
        .byte   $67
        inc     $2C,x
        ldx     L0060
        .byte   $87
        sta     L092E
        .byte   $0C
        .byte   $5A
        .byte   $F3
        sec
        sty     $26
        .byte   $33
        .byte   $89
        .byte   $6B
        sty     L7F72
L3F69:  .byte   $37
        .byte   $14
        cpy     $A49F
        .byte   $4B
        .byte   $AB
        .byte   $53
        and     $032D,x
        iny
        txs
L3F76:  ror     $08,x
        .byte   $B2
        .byte   $E2
        .byte   $23
        .byte   $44
        sbc     $B6
        .byte   $23
        .byte   $1C
        lda     $D442,y
        .byte   $CF
        .byte   $3F
        .byte   $9D
L3F86:  .byte   $33
        .byte   $3A
        .byte   $92
        .byte   $24
L3F8A:  lsr     a
L3F8B:  .byte   $23
        ldy     L1283,x
        .byte   $42
        .byte   $A0
L3F91:  .byte   $FA
        .byte   $37
        .byte   $C3
        bit     L4D36
        bvs     L3FAD
        .byte   $37
        .byte   $E3
        pla
        .byte   $0C
L3F9D:  .byte   $F2
L3F9E:  bpl     L3FE2
        bvc     L3F69
        .byte   $3A
        .byte   $6B
        bne     L3FFC
        .byte   $09
L3FA7:  .byte   $32
        bmi     L3F33
        iny
        .byte   $9E
        .byte   $44
L3FAD:  .byte   $D7
        .byte   $71
L3FAF:  .byte   $02
        adc     ($C4,x)
L3FB2:  rol     a
        iny
        rol     L5631
        .byte   $4B
        tya
        .byte   $52
        dec     $63,x
L3FBC:  .byte   $A7
        .byte   $93
        bit     $8C
        .byte   $73
        .byte   $42
        eor     #$B2
        ror     $CBBC
        .byte   $52
        bcs     L3F91
        adc     $EB72
        .byte   $3A
        .byte   $44
L3FCF:  .byte   $D7
        .byte   $82
        ldy     L3EB7,x
        .byte   $44
L3FD5:  dey
        .byte   $C2
        clv
        jmp     L4477

        .byte   $37
        jsr     LD0CB
        .byte   $80
        .byte   $02
L3FE1:  .byte   $8C
L3FE2:  rol     a
        sbc     L674C,x
L3FE6:  .byte   $9C
        iny
        bit     $38
L3FEA:  .byte   $4B
L3FEB:  .byte   $22
        asl     a
        .byte   $DA
        bmi     L3F9D
        .byte   $33
        dec     $80,x
        .byte   $9B
        .byte   $F7
        sty     L1135
        rol     $C3A2
        .byte   $26
L3FFC:  .byte   $34
        ldy     $8C,x
        ldx     L5902,y
        sbc     #$82
        sbc     ($23),y
        rol     L0B24
        iny
L400A:  .byte   $6B
        .byte   $94
L400C:  cpx     #$DB
        .byte   $B3
        rol     $82
        dex
        .byte   $DB
        and     $C9A9,y
        eor     L43A7
L4019:  cpx     #$DB
        .byte   $7A
        sed
        .byte   $C7
        .byte   $84
L401F:  .byte   $E2
        .byte   $44
        .byte   $AD
L4022:  .byte   $C2
        .byte   $D0
L4024:  .byte   $D2
        .byte   $5C
        .byte   $72
        .byte   $4B
        cmp     #$68
        .byte   $C2
        .byte   $73
        .byte   $7B
        ora     L3DF3
L4030:  sbc     L358D,y
        inc     L8B27
        txa
        cmp     #$92
        .byte   $67
        .byte   $5C
        ldx     $DDBF,y
        .byte   $1F
        .byte   $2F
        .byte   $32
        bvc     L3FD5
        .byte   $F2
        .byte   $1B
        .byte   $33
        pha
        jmp     LDFF8

        .byte   $82
        .byte   $0E
L404C:  .byte   $72
        lsr     $9C28
L4050:  sbc     ($8D),y
        .byte   $D2
        ldy     #$6A
        asl     a
        .byte   $42
        inx
        .byte   $A7
        clv
        .byte   $B2
L405B:  .byte   $14
        .byte   $9B
        .byte   $AF
        asl     $83
        lda     L3587,x
        tay
        .byte   $02
        .byte   $74
        .byte   $63
        ldy     L090E
        .byte   $A3
        .byte   $BB
        sty     $E3
        eor     #$4B
        sbc     $D9
        and     ($2F),y
        ror     $CC
        rts

        lsr     $18
        .byte   $CF
        sta     (L0060,x)
        ldy     $CAF4,x
        asl     a
        .byte   $2D
L4081:  and     $8D
        nop
        sta     ($9A),y
        .byte   $37
        sbc     ($14,x)
L4089:  .byte   $33
        sbc     ($21,x)
        rol     L0A4C
        .byte   $DC
        sbc     #$25
        eor     $E333,y
        ldy     #$2F
        lda     $52
        bit     $A0AA
        and     $EA99,x
        .byte   $03
        .byte   $12
        sbc     $CB9C,y
        cmp     ($FC,x)
        and     ($CC,x)
        .byte   $EB
L40A9:  ror     $D368,x
        dec     $AF78,x
        ldx     #$3F
        eor     #$84
L40B3:  .byte   $02
        .byte   $E3
        dec     $CD78
        ora     #$2D
        .byte   $D4
        php
        .byte   $83
        rol     $C8AF,x
        .byte   $93
        .byte   $57
        inx
        sbc     ($C1,x)
        .byte   $DC
        ldx     $A3B7,y
        lsr     L091C,x
        .byte   $02
L40CD:  .byte   $C7
        ldx     #$E8
        .byte   $C4
L40D1:  cpy     $219C
        .byte   $D4
        .byte   $37
        .byte   $42
        .byte   $27
        .byte   $9C
        .byte   $8B
        .byte   $82
        .byte   $14
        sta     ($AC,x)
L40DE:  dec     $FC
        lda     $42
        .byte   $02
        pla
        bne     L4136
        rol     a
        and     $A7
        .byte   $62
        .byte   $80
        stx     $FA
        inc     L1F5A
L40F0:  jmp     L6CC5

        plp
        .byte   $9C
        .byte   $B9
L40F6:  lda     LC530,y
        .byte   $37
        .byte   $DA
        tax
        .byte   $7A
        .byte   $70
L40FE:  tax
        .byte   $F2
        .byte   $F2
        .byte   $80
        .byte   $2B
        .byte   $5C
        sbc     ($C9,x)
        cpy     $B495
        lda     L0B58,x
        sta     L3E23,x
L410F:  and     #$B3
        .byte   $87
        .byte   $A3
        .byte   $1C
        ldy     L4C0D,x
        adc     $036F,y
        asl     $2C
        .byte   $D3
        sty     L4BC7
        .byte   $E3
        asl     L7352
        cmp     $AEED,x
L4127:  and     ($E6),y
        .byte   $63
        .byte   $33
        bmi     L40F6
L412D:  .byte   $90
L412E:  .byte   $72
        lsr     $33,x
        stx     $D9
L4133:  rti

        tya
        .byte   $B7
L4136:  .byte   $5F
        brk
        .byte   $36
L4139:  nop
        .byte   $4B
        .byte   $E2
        .byte   $E3
        and     $E1,x
        lda     $93,x
        .byte   $33
        .byte   $5B
        ldy     $CC,x
        .byte   $BE
L4146:  jmp     L88FA

        .byte   $02
        .byte   $E2
        .byte   $DC
        lda     L38D0,y
        .byte   $37
        lda     $CC
        adc     L74D8,y
        cmp     L0D3E
        .byte   $B7
        ora     #$CA
        rol     $48,x
        cpy     #$54
        .byte   $3B
        .byte   $63
        .byte   $0C
        nop
        .byte   $E4
L4164:  lda     $CB09,x
L4167:  cpx     L31DB
        .byte   $E5
L416B:  .byte   $7C
        .byte   $9E
        rol     $82
        .byte   $89
        cmp     $62,x
        cpy     $CF
        adc     $22
        beq     L41D7
        and     ($E3),y
        .byte   $BF
        .byte   $92
        stx     $23,y
        cpy     $A209
        .byte   $4B
        lda     ($F2,x)
        .byte   $6E
L4185:  .byte   $64
        rol     $896C
        .byte   $82
        sbc     #$02
        inc     $A6
        .byte   $64
        lda     $C378,x
        sty     $CE,x
        lda     $C78B
        cpx     #$BC
        jmp     (L8C67)

L419C:  cpx     $9EDC
        txa
        adc     L5EA3,y
        .byte   $12
        .byte   $82
        eor     $C2E8,x
        rts

        .byte   $12
L41AA:  plp
        lda     L3769,y
        sbc     ($0C,x)
L41B0:  php
        .byte   $8B
        brk
        .byte   $D4
L41B4:  .byte   $D3
        rol     $B736
        cmp     ($AE,x)
        ror     a
        plp
        .byte   $22
        ldx     $EEC3
        .byte   $1C
        sta     ($00,x)
        .byte   $9B
        .byte   $8B
        plp
        bit     $94
        lsr     L624F
        bcs     L4167
        pha
        sta     ($9A),y
        .byte   $1C
        cpx     $63
        ldy     #$91
        .byte   $33
        .byte   $BB
L41D7:  and     ($33,x)
        .byte   $CF
        .byte   $22
        .byte   $72
        sta     ($85),y
        .byte   $F2
        .byte   $F4
        lsr     $45
        .byte   $1B
        cpx     $FE
        asl     L82A5
        ldy     #$E4
        .byte   $6B
        .byte   $8F
        eor     ($5F),y
        rol     $7C
        .byte   $BB
L41F1:  ldx     $B9
        .byte   $FB
        .byte   $97
        .byte   $C3
        ldy     #$5F
        .byte   $44
        lda     L129F,y
        jsr     LD870
        clc
        .byte   $F3
        stx     $98C3
        .byte   $E1
L4205:  ldy     $5B,x
        .byte   $2E
        rts

L4209:  .byte   $92
        ora     $A6
        .byte   $22
        adc     #$65
        .byte   $C1
L4210:  .byte   $AF
        .byte   $62
        cmp     L28AE,y
        sbc     ($BE,x)
        lsr     $0542,x
        sbc     ($AC,x)
        eor     L5C7A,y
L421F:  .byte   $A2
L4220:  tya
        .byte   $E2
        cmp     ($0C,x)
        .byte   $67
        .byte   $C7
        .byte   $64
        .byte   $63
        .byte   $AB
        and     L2E6D,y
        .byte   $89
        ldy     $91,x
        .byte   $32
        bcc     L4295
        lda     L58E1
        eor     ($AA,x)
        clc
        sbc     $37
        sta     L56EE,y
        adc     #$10
        .byte   $77
        sec
        .byte   $1A
        .byte   $63
        sta     L10F3,y
        .byte   $9E
        .byte   $53
        lda     #$AA
        bcs     L426A
        bit     $54
        .byte   $CB
        cmp     $17
L4251:  adc     ($86,x)
        sty     $B864
        stx     $FC
        sta     L8407,x
        dec     L206D,x
        .byte   $43
        adc     ($7B),y
L4261:  asl     $04,x
        adc     $A183,y
        .byte   $2F
        sed
        clc
        tya
L426A:  .byte   $F2
        .byte   $D4
        .byte   $9B
        .byte   $43
        ora     ($8B),y
        .byte   $D3
        clc
        .byte   $53
        sty     L6AF1
        .byte   $9C
        pha
        eor     L75CE
        .byte   $13
        .byte   $03
        sbc     $F3
        tax
        .byte   $1B
L4281:  cpx     #$FF
        .byte   $EB
        ror     $BD73
        and     $F3
        .byte   $65
L428A:  .byte   $12
        .byte   $F9
        .byte   $DE
L428D:  clc
        bmi     L4220
        .byte   $6B
        and     L5A20
        .byte   $30
L4295:  .byte   $5A
        .byte   $6F
        .byte   $16
L4298:  ror     L1B42
        sbc     ($3D,x)
        and     ($32,x)
        .byte   $63
        .byte   $12
        and     ($52),y
L42A3:  rol     $DC
        cpx     #$79
        cmp     $30,x
        .byte   $63
        ora     ($7D,x)
        lda     $E9
        ror     L085B
        eor     #$56
        .byte   $17
        dec     $7C
        and     L5E85,x
        sta     L36CC,y
        asl     $FF
        adc     #$9F
        .byte   $5B
        cpx     $C0
        bmi     L428A
        sta     L16EC,y
        .byte   $67
        dey
        bit     $0281
        bit     $28
        .byte   $17
        .byte   $57
        asl     $7A
        .byte   $FC
        .byte   $CF
        clc
        sbc     ($17,x)
        cli
        adc     ($EA),y
        lsr     $9A6F,x
        bcs     L4353
        txs
        .byte   $F3
L42E2:  .byte   $EC
L42E3:  .byte   $1B
        adc     $11
        .byte   $64
        eor     ($91),y
L42E9:  ldx     $F1C4
        .byte   $92
        ora     $E0
        php
        asl     $E0,x
        lda     L5B34,x
        txa
        eor     L58E0
        .byte   $43
        .byte   $17
        ldy     $69
        ldx     L85E6
        stx     L0D87
        .byte   $62
        .byte   $93
        .byte   $5B
        beq     L42E2
        .byte   $64
        .byte   $67
        .byte   $02
        beq     L42E9
        jmp     L2685

        .byte   $0B
        .byte   $8E
        .byte   $39
L4313:  ldx     #$F8
        .byte   $4B
        lda     L7A4D,x
        sta     ($C3,x)
        ldy     $D7
        jmp     L23B9

        ror     $C306,x
        eor     L0CFC,x
        ror     L40DE
        tsx
        ora     L7D0F,x
        cmp     L8713,x
        tsx
L4331:  stx     $58
        .byte   $2F
        asl     a
        adc     $EE33,y
        .byte   $F2
L4339:  .byte   $23
        tay
L433B:  txs
L433C:  .byte   $BB
        sbc     $26,x
        .byte   $85
L4340:  sty     $0F51
        .byte   $5B
        brk
        .byte   $C2
        bmi     L4339
        sta     L0E96,x
        .byte   $FB
        .byte   $D2
        adc     ($47),y
        .byte   $23
        ldy     $B7
L4352:  cli
L4353:  rol     $A549,x
        .byte   $E2
        .byte   $3B
        .byte   $4B
        sbc     ($2E),y
        .byte   $8B
        .byte   $F0
L435D:  .byte   $9C
        bit     $CC4B
        .byte   $2C
L4362:  sta     $A2,x
        rts

        ldx     L1301,y
        .byte   $5E
        .byte   $83
L436A:  .byte   $D3
        .byte   $8F
        ldx     $FC
        .byte   $DF
        lda     ($00,x)
        dec     $A48C
        sbc     ($4C,x)
        asl     $83
        .byte   $3C
        sbc     ($E4),y
        clc
        sec
        sty     L5C7A
        .byte   $62
        .byte   $CD
        .byte   $F2
L4383:  .byte   $A7
        .byte   $D3
        .byte   $2F
        tya
        pla
        ldy     L4A05,x
        .byte   $02
        .byte   $37
        sbc     L0FE2
L4390:  and     #$32
        .byte   $FA
        .byte   $14
        jmp     L8BF2

L4397:  plp
L4398:  clc
        and     $E7A1,y
        .byte   $89
        cpy     $D8
        clv
        rol     $042F,x
        .byte   $43
        eor     $C0B1,x
L43A7:  .byte   $34
        .byte   $BC
        .byte   $7A
L43AA:  .byte   $E3
        ora     L8B09
        .byte   $82
        cld
        .byte   $C2
        .byte   $F9
L43B2:  sta     $F88C
        ora     $7D,x
        .byte   $74
        eor     $DDFB
        .byte   $83
        .byte   $77
        .byte   $7F
        tya
        .byte   $9E
        .byte   $54
L43C1:  .byte   $E3
        .byte   $73
        sed
        ldy     $DB,x
        .byte   $D4
        sta     $016E,y
        .byte   $C3
        .byte   $5C
L43CC:  .byte   $6F
        iny
        .byte   $5F
        sta     L8D27,x
        sty     L36C7
        .byte   $D3
        ora     L6473,x
L43D9:  jmp     LD3E8

        ldx     $4C
        .byte   $BD
        .byte   $CB
L43E0:  .byte   $0C
        .byte   $7C
        asl     $F3C2,x
        cmp     L2991
        .byte   $2C
        .byte   $BD
L43EA:  bcc     $4438
        .byte   $F2
        .byte   $4F
        sty     L39D1
        and     $F90D,y
        .byte   $FA
        .byte   $82
        ldy     $B5
        .byte   $04
L43F9:  .byte   $93
        sty     $C7
        .byte   $9F
        .byte   $54
        lda     L24E0,y
        .byte   $0D
L4402:  php
        adc     $E8E0
        and     ($E5),y
        .byte   $3C
        .byte   $0E
        .byte   $E3
L440B:  .byte   $8F
        .byte   $B2
        lsr     $6C,x
        .byte   $CB
        iny
        bit     $64
        iny
        eor     $DE
        and     $EA,x
        .byte   $AC
L4419:  .byte   $93
        inx
        and     ($C7),y
L441D:  bmi     L43D9
        .byte   $37
        txa
        .byte   $93
L4422:  .byte   $03
        sec
        .byte   $92
        cpx     $F4
        sta     L09FD,y
L442A:  .byte   $32
        adc     ($EA,x)
        rol     $7A
        .byte   $3C
L4430:  .byte   $AF
        .byte   $63
        ror     $E970,x
        bvs     L448F
        and     ($30,x)
        .byte   $93
        .byte   $FA
        .byte   $FA
        jmp     L84B0

        .byte   $DF
        cpy     #$53
        rol     $CCD2
        adc     $B4,x
        ora     $CE19
        .byte   $89
        .byte   $E2
        .byte   $9B
        ldx     $0164
        beq     L447D
        ora     #$A8
        .byte   $B2
        dec     L5DF3,x
        .byte   $A7
        .byte   $34
        .byte   $4B
        .byte   $A7
        .byte   $F3
        .byte   $1F
        php
        sty     $B2
        .byte   $64
        ldx     L5D3F,y
        .byte   $D2
        .byte   $E2
        .byte   $1A
        clc
        .byte   $D7
        and     $93
        rol     L7258,x
        bpl     L44BC
        .byte   $A9
L4472:  cmp     $A359,y
L4475:  eor     ($B4),y
L4477:  plp
        .byte   $4B
        .byte   $8D
L447A:  brk
        .byte   $62
        .byte   $25
L447D:  bit     $0E
        iny
        .byte   $B3
        asl     $F3DF,x
        .byte   $8F
        .byte   $9E
        .byte   $64
        ldx     $D2
        .byte   $22
        .byte   $0B
        cpy     $30
        .byte   $13
        iny
L448F:  .byte   $7B
        sta     L3524,y
        .byte   $2F
        .byte   $37
        .byte   $83
        .byte   $5A
        adc     $DF,x
        and     ($A5),y
        cpx     #$82
        .byte   $9E
        and     L66E9,y
        cpx     #$9A
        inc     L7E21
L44A6:  sed
        sty     $38,x
        .byte   $C7
        .byte   $1A
        tay
        .byte   $D2
L44AD:  eor     ($FA,x)
        cmp     #$60
        .byte   $C3
        asl     L5963
        lsr     L339E
        dec     $BC90,x
        .byte   $87
L44BC:  sta     L27F8
        .byte   $42
        cpx     #$31
        sty     L2970
        bit     $47
        .byte   $9C
        nop
        sty     L3A8B
        cpx     #$78
        .byte   $89
        sei
        .byte   $C2
        .byte   $53
        .byte   $52
        lsr     L3E73
        bit     $2E
L44D8:  .byte   $A3
        asl     $80
        lsr     $95
        and     ($D6),y
        .byte   $C2
        .byte   $44
        dec     $17
        .byte   $A7
        .byte   $89
        cmp     $8C,x
        .byte   $DF
        cmp     ($4F,x)
        asl     L63BA
        asl     L305B,x
        .byte   $57
        .byte   $32
        inc     $9005
        cmp     ($08,x)
        .byte   $93
        asl     L732E,x
        .byte   $1B
        lsr     a
L44FD:  ora     $89
        .byte   $52
        .byte   $6C
        .byte   $80
L4502:  .byte   $BC
        .byte   $75
L4504:  pha
        inc     $09
        .byte   $F2
        sbc     $68,x
        and     $71
        .byte   $D3
        .byte   $37
        cpx     #$20
        rol     $78
        .byte   $E7
        eor     $C37B
        asl     a
        .byte   $03
        tya
        bcc     L4558
        rol     L43C1,x
        lsr     L50B8,x
        .byte   $63
        and     L221D
        cld
        .byte   $C7
        ldy     #$E4
        .byte   $C7
        rol     $E8,x
        ldx     $EF6D,y
        .byte   $5B
        .byte   $E2
        .byte   $4E
L4532:  rts

        sbc     ($9C,x)
        and     L337A
        cpy     $BC
        rol     L49E7,x
        .byte   $9C
        .byte   $C3
        .byte   $0C
        bvs     L45B3
        .byte   $01
L4543:  .byte   $22
        .byte   $F7
        .byte   $CF
        and     $FF7B,y
        .byte   $0C
        sbc     ($20),y
        and     ($E2),y
L454E:  sbc     L0CB5
        cpx     #$09
        .byte   $B2
        txa
        sbc     $90
        .byte   $85
L4558:  .byte   $DF
        lda     $990D,y
        dec     $FD7D
        .byte   $7A
        adc     #$69
        tay
        sed
        sbc     L1963,x
        .byte   $64
        .byte   $2F
        .byte   $5A
        sec
        pla
        ldx     #$D0
        .byte   $D3
        .byte   $3D
        .byte   $0C
L4571:  .byte   $CB
        cpx     #$34
        and     ($EB),y
        sta     $8B,x
        rol     a
L4579:  jsr     L2216
        .byte   $CB
        bne     L4579
        inx
        sta     $AB31,x
        php
        lsr     L802F
        .byte   $D0
L4588:  .byte   $9E
        .byte   $FA
        eor     #$C3
        asl     $BD
        .byte   $72
        sbc     $A8
L4591:  .byte   $CF
        ora     $D2CB,x
        bit     $65
        .byte   $42
        sty     $E0
        ldx     $0299
        ldx     #$E1
        .byte   $A7
        ldy     #$95
        ldx     $AC,y
        .byte   $92
        cli
        rol     L0C64
        sta     L25AE,x
        ldy     $E7
        eor     #$9E
        .byte   $F2
        and     ($09),y
L45B3:  .byte   $97
        eor     ($BC,x)
        cpy     $5C
        .byte   $97
        .byte   $DB
        cpx     #$13
        .byte   $32
        cpx     $5B
        sta     $19
        .byte   $B6
L45C2:  ora     #$30
        dec     $13
        asl     $3C
        .byte   $7C
        .byte   $72
        .byte   $64
        inc     L2E09
        .byte   $1F
        ldx     $BD
        .byte   $97
        cmp     ($F1,x)
        .byte   $22
        .byte   $6B
        cmp     ($4B),y
        .byte   $0C
        asl     L4591,x
        .byte   $E2
        ldy     $EC5C,x
        asl     $A0
        eor     #$98
        dec     $A0
        adc     #$DD
        .byte   $DF
        .byte   $5F
L45EA:  .byte   $5D
L45EB:  .byte   $87
        and     ($85,x)
        bne     L4630
        .byte   $1A
        sed
        .byte   $63
        asl     $FE
        .byte   $13
        ora     L244B,y
        .byte   $F1
L45FA:  sbc     $1985,y
        .byte   $23
        .byte   $FF
        lda     $CB99
        clv
        ora     #$8D
        sta     $EE9B
        rol     $71
        .byte   $F2
        bit     $03
        and     #$C7
        .byte   $DA
L4610:  .byte   $7C
        cli
        ror     $5E
        .byte   $79
L4615:  ora     $DA
        cpy     $89
        .byte   $34
        .byte   $43
        bit     $E856
        and     ($4B,x)
        ora     L4CCD,y
        cmp     ($59,x)
        sta     $F2
        .byte   $CB
        tya
        stx     $65
        .byte   $E1
L462C:  lsr     $1A
        ora     ($66),y
L4630:  .byte   $FB
        rol     $83
        eor     ($27),y
        .byte   $9C
        cpy     #$54
        ora     ($C9,x)
        .byte   $8F
        .byte   $34
        sed
        ora     ($4C,x)
        adc     $19,x
        sbc     ($0B),y
        jmp     LA818

        .byte   $53
        asl     $38
        brk
        .byte   $0D
        .byte   $E6
L464C:  stx     $87,y
        .byte   $2D
L464F:  ldy     $26,x
        ldy     L4CA3,x
        .byte   $FA
        .byte   $34
        cpy     $C274
L4659:  and     $F4
        .byte   $27
        and     $B2E9,x
        .byte   $FA
        sty     $8E,x
        rol     $8F60
        and     #$DC
        .byte   $D7
        ldx     $9370,y
        .byte   $80
        ldx     $9282,y
        sbc     $91,x
        .byte   $93
L4672:  .byte   $33
L4673:  sty     L7E63
        .byte   $F5
L4677:  .byte   $32
        .byte   $9B
        .byte   $2F
        ldy     $7A
        .byte   $27
        .byte   $4B
        .byte   $C3
        bit     L2491
        dec     $15
        sta     ($DC,x)
        and     $08,x
        cmp     ($85,x)
        bmi     L46A7
        ldy     $E207
        .byte   $53
        tya
        lda     #$23
        .byte   $3C
        .byte   $C3
        cmp     $C9FB
        .byte   $4B
        cpx     L28CB
        .byte   $54
        .byte   $9B
        .byte   $C3
        asl     L1F33
        ora     ($20,x)
        lda     $A8,x
        .byte   $29
L46A7:  txa
        .byte   $8F
        .byte   $2E
L46AA:  ldy     #$AF
        lda     $CC
        .byte   $FC
        .byte   $7F
        bvc     L4677
L46B2:  sec
        ror     a
        .byte   $1F
        ror     $D7D8,x
        ldx     $78,y
        tya
        .byte   $FB
        .byte   $07
        .byte   $33
        .byte   $5C
        .byte   $7D
        .byte   $8C
L46C1:  ror     $84
        clv
        ror     $9C,x
L46C6:  rol     a
        bmi     L4677
        .byte   $C2
        .byte   $F4
        .byte   $82
        and     L3354
        inx
        .byte   $A0
L46D1:  sta     ($3B),y
        .byte   $7A
        .byte   $27
        cpy     L66EC
        .byte   $64
        .byte   $3A
L46DA:  .byte   $03
        .byte   $F4
        ror     L8924
        ora     $E1
        .byte   $DC
        lsr     $F179,x
        sty     $6F
        .byte   $12
L46E8:  lsr     $A498
        bne     L46B2
        .byte   $1F
        .byte   $C2
        stx     $AA,y
        sta     $E8
        .byte   $63
        .byte   $1A
        .byte   $F7
        .byte   $44
        .byte   $12
        ora     #$17
        .byte   $4B
        adc     $ED
        .byte   $13
        .byte   $3A
        .byte   $6B
        .byte   $CF
        inc     $5F
        rts

        and     ($7C),y
        .byte   $BF
        .byte   $73
        dec     $4F
L470A:  .byte   $F3
        dec     $BD
        dec     L5386,x
        lda     ($E2,x)
        ror     $E0
        .byte   $07
        .byte   $DF
        and     #$85
        ora     ($36),y
        .byte   $7E
L471B:  .byte   $5C
        .byte   $9E
        .byte   $93
        .byte   $3A
        .byte   $D2
        eor     ($B6,x)
        .byte   $02
        .byte   $27
        .byte   $2F
        pha
        and     ($70),y
        .byte   $1A
        .byte   $6F
        sta     ($E9),y
        adc     $29
        .byte   $BF
        sty     $2D
        .byte   $1C
        .byte   $1F
        rol     $BC
        ora     $E225,y
L4738:  .byte   $DA
        adc     $D4
        .byte   $6B
L473C:  .byte   $CF
        bit     $4E
L473F:  .byte   $D7
        .byte   $44
        adc     ($17),y
        jsr     L6425
        .byte   $47
        .byte   $CB
        ora     ($E6),y
        .byte   $6B
        .byte   $DF
        asl     a
        .byte   $5C
        beq     L4762
        asl     a
        .byte   $1A
        sbc     #$63
L4754:  adc     L1727,x
        .byte   $2C
L4758:  lsr     a
        .byte   $35
L475A:  .byte   $72
        .byte   $1B
        adc     ($1B,x)
        .byte   $14
        ror     $A2
        .byte   $D9
L4762:  .byte   $4F
        .byte   $10
L4764:  and     $62
        .byte   $5F
        eor     L5464
        sta     ($BF),y
        rol     L6F61
        cmp     #$67
        sty     L86A9
        and     L4926,y
        .byte   $62
        and     #$AE
        .byte   $4B
        rti

        dec     $6C,x
        cpx     #$63
        .byte   $C3
        .byte   $FA
        lsr     $A6E2,x
        .byte   $7D
        sed
L4787:  ora     $EE
        clv
        .byte   $5F
        and     $69
        .byte   $9F
        pla
        lda     ($61),y
        and     ($B3,x)
        dec     $99
        .byte   $7C
        .byte   $80
        .byte   $41
L4798:  .byte   $34
        .byte   $5C
        pla
        .byte   $07
        and     ($AF,x)
        bpl     L4758
        sei
        .byte   $83
        lda     ($44),y
        stx     $FC
        .byte   $91
L47A7:  cmp     $B5
        .byte   $44
        .byte   $9E
        .byte   $44
        .byte   $7A
        bpl     L47B1
        .byte   $0F
        .byte   $17
L47B1:  asl     $77
L47B3:  nop
        .byte   $72
        .byte   $F2
        adc     $99,x
        .byte   $E3
        .byte   $07
L47BA:  bit     $43
        .byte   $39
        .byte   $79
L47BE:  clc
        .byte   $87
        adc     ($BD),y
        .byte   $0F
        .byte   $44
        sta     L8BF1,y
        .byte   $97
        lsr     $A1,x
        adc     #$1A
        .byte   $63
        iny
        .byte   $F0
L47CF:  eor     ($CC,x)
        cmp     ($4E),y
        .byte   $33
        .byte   $D2
L47D5:  .byte   $F2
        asl     $3B
        .byte   $0C
        clc
        eor     ($97),y
        ora     $B2,x
        ora     $BA
        asl     $78
        .byte   $97
        sta     L4AE2,y
        .byte   $62
        asl     a
        .byte   $12
        .byte   $93
        clc
        .byte   $F3
        tay
        .byte   $1B
        sbc     $4B,x
        eor     #$86
        ora     ($C2,x)
        .byte   $D3
        .byte   $17
        .byte   $7B
        asl     $FD
        .byte   $F3
        bmi     L47CF
        dec     $9E
        and     $E1
        inc     $6F,x
        cpx     #$7C
        .byte   $17
        .byte   $0C
        asl     $7B
        txa
        txs
        sbc     ($B9,x)
        jsr     L2150
        brk
        .byte   $A1
L4811:  .byte   $80
L4812:  .byte   $5F
        sec
        pha
        plp
        lsr     a
        .byte   $97
        ldx     $D9
        ror     $C9
        .byte   $9E
        sbc     ($C6),y
        sec
        asl     L6415,x
        .byte   $4B
        bcs     L4845
        .byte   $A7
        sta     L712C,y
        eor     ($90),y
        cmp     $14
        .byte   $53
        ora     ($BF),y
        .byte   $42
        .byte   $79
        .byte   $D3
L4834:  cpx     $1D
        txs
        adc     $F99A,y
        .byte   $19
L483B:  dec     $D7
        sbc     $E4
L483F:  .byte   $BC
L4840:  .byte   $67
        cpy     $40
        .byte   $4D
        .byte   $DF
L4845:  sta     $E9
        .byte   $AF
        txa
        inc     L2D5E,x
        rol     $14
        .byte   $97
        sta     $B124,x
        .byte   $A3
        .byte   $9C
        sty     L22FC
        adc     L8690,y
        .byte   $0B
        eor     #$B3
        rol     L53E8,x
        .byte   $BF
        dec     $ED
        .byte   $0B
        ror     L43E0,x
L4867:  .byte   $DF
        .byte   $30
L4869:  sbc     $112F,x
        .byte   $A3
        .byte   $7F
        rol     $D6
        .byte   $32
        cli
        .byte   $CC
        .byte   $F6
L4874:  .byte   $2F
        dex
        nop
        rol     $F760
        lda     L3A6B,x
        .byte   $4B
        .byte   $D7
        brk
        tsx
        .byte   $47
        .byte   $37
        beq     L488C
        cmp     #$23
        ora     #$09
        cmp     L53D0
L488C:  ora     $2D
        .byte   $F3
        eor     ($40),y
        .byte   $92
        .byte   $0C
        .byte   $9E
        .byte   $9F
        .byte   $F2
        .byte   $2E
L4897:  .byte   $82
L4898:  bvs     L4869
        .byte   $9F
        ror     $18,x
        .byte   $E3
        sbc     ($55),y
        jmp     L4579

        dec     $DD9A
        txs
        .byte   $92
L48A8:  and     ($E4),y
        and     $2F
        bvs     L490E
        sbc     $26,x
        .byte   $E2
        .byte   $89
        .byte   $7A
        adc     $CB
        sbc     L1C15
        cpx     $0D
        .byte   $D7
        ldy     $BE
        inc     $BD
        bvc     L4925
        .byte   $A7
        cmp     $C1
        .byte   $30
L48C5:  sei
        eor     L174E
        .byte   $DC
        asl     a
        .byte   $14
        stx     $38
        cpx     $07
        lda     $E38E,y
L48D3:  brk
        .byte   $F6
L48D5:  ora     $BAA4,x
        .byte   $17
        .byte   $D3
        adc     $E9
        rol     L8613,x
        .byte   $7B
        .byte   $8F
        .byte   $6F
        sty     $C9
        ldx     L16D7,y
        asl     $3C
        .byte   $72
        .byte   $73
        .byte   $52
        .byte   $D3
        .byte   $04
        .byte   $43
        sty     $A9
        ldx     L645C
        .byte   $F4
        .byte   $C3
        .byte   $02
        cmp     ($7D,x)
        .byte   $23
        cpy     $F6
        cpy     L1846
        .byte   $EF
        .byte   $73
        and     ($34),y
        .byte   $67
        cpy     #$EA
        .byte   $67
        .byte   $D4
        .byte   $F7
        and     $D531,x
        .byte   $22
        .byte   $6B
L490E:  sta     $B92D,y
        rol     $69
        .byte   $7C
        and     #$01
        and     L6FE6,y
L4919:  cld
        lsr     $C76B
        .byte   $5C
        ora     $BC26,y
        adc     $E6,x
        sec
        .byte   $DE
L4925:  .byte   $E9
L4926:  .byte   $95
L4927:  .byte   $82
        .byte   $5B
        .byte   $EC
L492A:  .byte   $5F
        eor     $69
        .byte   $CB
        .byte   $5F
        asl     $FC
        .byte   $9C
        inc     $7D
        .byte   $27
        stx     $B8
        .byte   $9F
        ora     $94,x
        .byte   $5A
L493B:  lsr     $6F,x
        .byte   $E1
L493E:  sta     L6D16
        sta     $64
        adc     $D69C,y
        tya
        .byte   $F3
        asl     L4E13
        .byte   $64
        rol     $EF9B,x
        inx
        .byte   $63
        .byte   $9E
        adc     #$78
        bne     L496E
        .byte   $F4
        lsr     $CE,x
        .byte   $97
        .byte   $D3
        rol     $5D,x
        .byte   $67
        stx     $E3,y
        ora     $F2,y
        inc     L319C
        .byte   $54
        ora     $B4
        cmp     $EB
        .byte   $C3
        .byte   $37
        .byte   $D2
L496E:  ora     #$06
        cmp     $D8C4,y
        adc     #$96
        adc     ($1B,x)
        .byte   $47
        .byte   $6F
        .byte   $92
        asl     a
        .byte   $0B
        sta     $C5
        adc     $D9,x
        lda     L1615,x
        .byte   $EB
        ora     L0CF8,y
        .byte   $F3
        and     $26
        adc     L1A46,y
        .byte   $F2
        .byte   $3A
        jmp     LAC00

        .byte   $DC
        sta     ($CF,x)
        .byte   $E2
        .byte   $D3
        .byte   $12
        .byte   $7A
        txs
        .byte   $F2
        lda     ($F3,x)
        .byte   $93
        .byte   $47
        stx     $06
        .byte   $04
        cmp     ($A4,x)
        tay
        .byte   $67
        ora     $48,x
        asl     $A0E4
        asl     $79
        .byte   $CB
L49AE:  cmp     $C297,y
        .byte   $7A
        .byte   $5C
        .byte   $82
        .byte   $87
        sbc     $B19D,x
        rol     $D5AE,x
        eor     $DFF5,x
        ldx     L43F9
L49C1:  cmp     ($5E,x)
        .byte   $4F
        .byte   $32
        lda     #$14
        lda     $F2
        eor     $9390
        .byte   $22
        .byte   $73
        .byte   $F3
        sta     $ED01,y
        cmp     ($66),y
        lda     L77BF,y
        tya
        ror     $1B,x
        beq     L4A0B
        txs
        sbc     $A9,x
        eor     #$91
        inc     L471B
        .byte   $2C
L49E5:  cpy     $18
L49E7:  .byte   $4F
L49E8:  asl     $D2,x
        .byte   $80
        ora     #$7E
        .byte   $1F
        eor     #$D0
        tax
        bvs     L49E8
        sei
        ora     $69
        ldx     L21C8
        .byte   $92
        lsr     L858E,x
        .byte   $F2
        sed
        .byte   $9C
        ror     $D130,x
        .byte   $1D
        .byte   $66
L4A05:  .byte   $34
L4A06:  ldx     $63,y
        ldy     L46E8,x
L4A0B:  .byte   $44
        iny
        lsr     $F81B
        .byte   $6B
        .byte   $32
        cpx     $F1
        .byte   $CB
        .byte   $9C
        and     $3A,x
        asl     a
        bit     $E9
        tya
        .byte   $67
        cmp     #$4D
        .byte   $5F
        .byte   $14
        .byte   $4F
        .byte   $87
        txs
        .byte   $1B
        .byte   $D7
        .byte   $80
        ror     $A502
        .byte   $7B
        cmp     $0146,x
        .byte   $CC
L4A2F:  .byte   $79
L4A30:  stx     L4659
        ror     $CC5F,x
        .byte   $D4
        cmp     ($4A,x)
        bit     $96
        .byte   $5C
        ldx     $BD
        asl     L1F67
L4A41:  eor     L7DC9
        .byte   $9B
        adc     $34
        .byte   $87
        ora     #$04
        cmp     $4E
        lsr     a
        .byte   $93
        eor     ($81),y
        ldx     #$15
        adc     $26,x
        adc     $C83C
        .byte   $22
        .byte   $17
        cld
        bpl     L4AC3
        .byte   $C7
        ora     $22,x
        .byte   $63
        .byte   $DA
        clv
        .byte   $63
        lda     $09
        .byte   $7B
        .byte   $B2
        .byte   $07
        sbc     #$C3
        and     ($73,x)
        lda     ($94,x)
        brk
        .byte   $A7
        rol     $F133
        rol     $BD
        eor     L1133
        lda     ($51),y
        .byte   $F2
        ora     $EB
        clv
        .byte   $5B
        lda     L3C2B
        sei
        .byte   $7C
        .byte   $CF
        .byte   $66
L4A86:  .byte   $3B
        .byte   $9E
        ora     L2CF5,y
        .byte   $17
        .byte   $87
        lda     ($6A),y
L4A8F:  bpl     L4AE2
        .byte   $1B
        tay
L4A93:  rol     $A6
        .byte   $D4
        cmp     ($50),y
        .byte   $44
        .byte   $73
        .byte   $97
        asl     L5295
        .byte   $27
        php
L4AA0:  ldx     $58,y
        inx
        eor     #$C1
        .byte   $0F
        .byte   $2D
L4AA7:  bit     $17
        asl     $BD
        .byte   $FC
        inc     $AA
        sbc     $E1
        .byte   $9F
        bvs     L4A93
        and     ($97,x)
        ora     L2C44,x
        tya
        .byte   $DF
        tay
        asl     $9B
        sed
        iny
        adc     $F5
        .byte   $F9
        .byte   $9D
L4AC3:  .byte   $FC
        .byte   $52
        sta     $F8
        .byte   $57
        lda     ($36,x)
L4ACA:  .byte   $5A
        ldx     L315F
        sbc     L82AF,y
        .byte   $D4
        .byte   $42
        ldy     $51
        txs
        .byte   $5F
        ror     L196B,x
        .byte   $B2
        .byte   $13
        lda     $C6
        adc     #$AF
L4AE0:  .byte   $9D
        .byte   $1E
L4AE2:  .byte   $1A
        cmp     ($A7),y
        .byte   $3F
        .byte   $1F
        sbc     ($9E),y
        eor     L6220
        cli
        sty     L7B5C
        iny
        stx     $8E,y
        lsr     L7692,x
        tya
        .byte   $87
        eor     $67
        pla
        sbc     L1C79,y
        sed
        rol     $E319
        inc     L4615,x
        sbc     $E6AB,x
        .byte   $7C
        .byte   $7C
        .byte   $53
        lsr     $7D
        pha
        ldy     #$82
        .byte   $67
        sta     $9EC1
        pla
        asl     $FE
L4B17:  .byte   $7C
        ldx     $89
        .byte   $7A
        .byte   $1F
        .byte   $97
        .byte   $02
        ror     $24
        sei
        lsr     $47
        txs
        inc     $71,x
L4B26:  asl     $2E,x
        .byte   $87
        adc     ($63,x)
        lda     #$9C
        .byte   $D4
        stx     $5F,y
        .byte   $83
        eor     #$32
        asl     a
        .byte   $57
        lda     $DCCB,y
        lda     L5E5A,x
        and     $A5
        .byte   $3C
        .byte   $12
        sta     $19,x
        cmp     L410F
L4B44:  .byte   $AF
        sty     $72
        .byte   $6F
        lda     ($78),y
        .byte   $7A
        .byte   $9B
        sbc     ($D6),y
        lsr     $1A
        sbc     ($D5),y
        iny
        sty     $AC
        eor     #$54
        rol     $FD
        .byte   $52
        inc     $B1
        bit     $5E
        .byte   $0B
        and     ($3E,x)
        .byte   $63
        .byte   $63
        asl     $33,x
        .byte   $53
        ora     $D2
        adc     #$B1
        ora     #$BF
L4B6C:  bit     $39
        ror     L6069
        sta     ($8F),y
        .byte   $83
        tax
        .byte   $44
        cpy     #$56
        .byte   $92
        cmp     $13
        .byte   $04
        beq     L4B44
        .byte   $7C
        .byte   $82
        lda     ($85),y
        cpx     L3943
        .byte   $1A
        .byte   $6B
        lda     ($49,x)
        adc     L5B42,y
        .byte   $07
        .byte   $04
        and     $B47B,y
L4B91:  .byte   $17
        .byte   $C7
L4B93:  .byte   $22
        .byte   $6F
        sbc     (L0060,x)
        .byte   $04
        .byte   $80
        .byte   $5A
        sty     $D8,x
L4B9C:  lsr     L65B3,x
        cmp     $A9
        ror     $2D,x
        .byte   $14
        .byte   $4F
L4BA5:  sta     ($82,x)
        .byte   $6F
        dec     $84,x
        asl     $04
        stx     $07
        .byte   $0F
        bcc     L4B93
        .byte   $5F
        .byte   $8B
        bpl     L4C14
        .byte   $54
L4BB6:  eor     #$AF
        lsr     $89
        txa
        and     #$34
        eor     L5909,x
        .byte   $12
        cpx     #$46
        .byte   $02
        php
        bpl     L4BE0
L4BC7:  .byte   $E2
        brk
        .byte   $4B
        and     L301B
        .byte   $5F
        .byte   $1C
        cmp     ($CD),y
        stx     $C16F
L4BD4:  .byte   $2B
        ldx     $59
        txs
        .byte   $5A
        dec     $45,x
        sbc     $8EB1,x
        .byte   $32
        .byte   $31
L4BE0:  eor     L1226,x
        stx     $A1,y
        .byte   $EB
        .byte   $14
        eor     L4672
        .byte   $1C
        .byte   $BB
        .byte   $04
        .byte   $F3
        .byte   $92
        asl     L19CC,x
        cmp     L7824,x
        .byte   $73
        ora     $48,x
        ror     a
        sbc     $99
        sbc     $17,x
        sty     $BF,x
        and     $16,x
        .byte   $54
        cmp     L74F1
        lda     ($12,x)
        eor     $C1,x
        .byte   $AF
        .byte   $53
        .byte   $74
        .byte   $49
L4C0D:  .byte   $BF
        adc     L81BC,x
L4C11:  .byte   $27
        cmp     #$7B
L4C14:  .byte   $97
        .byte   $03
        sbc     #$7C
        .byte   $83
        .byte   $A7
        lsr     $E6F5,x
        .byte   $7B
        .byte   $DF
        sta     ($42),y
        lsr     L339B
        sta     $F0
        .byte   $14
        sty     $C8,x
        .byte   $49
L4C2A:  sty     $6F
        .byte   $93
        sbc     ($52),y
        brk
        .byte   $97
        ldx     $BA6B,y
        iny
L4C35:  eor     $F71A,x
        .byte   $C3
        .byte   $1C
        rol     $9106,x
        .byte   $3D
        .byte   $B2
L4C3F:  lsr     $D1
        sbc     ($85),y
        clv
        ror     $3C
        eor     ($85),y
        ldy     $E141,x
        .byte   $17
        bit     $F470
        lsr     L3994
        .byte   $3B
        jsr     L5661
        .byte   $12
        rts

        lda     $0A,x
L4C5A:  .byte   $63
        sta     L4398,x
        eor     $CB
        .byte   $93
        inc     $B2
        .byte   $1C
        .byte   $3C
        .byte   $93
        .byte   $12
        .byte   $67
        .byte   $83
        .byte   $DE
L4C6A:  pla
        .byte   $63
        bcs     L4C2A
        .byte   $3C
        .byte   $B4
L4C70:  ldy     $81
        cmp     #$B4
L4C74:  .byte   $67
        sbc     ($EF,x)
        .byte   $1A
        .byte   $F5
L4C79:  clv
L4C7A:  txs
        .byte   $E7
        rol     a
        cpx     #$8B
        .byte   $0C
L4C80:  .byte   $8B
        plp
        .byte   $8B
        rts

        .byte   $8B
        cpy     #$8B
        nop
        txa
        and     ($D4,x)
        adc     ($17,x)
        .byte   $A3
        jsr     L2E23
L4C91:  .byte   $23
        rol     L4CA3,x
        .byte   $23
        cli
        .byte   $A3
        .byte   $64
        .byte   $A3
        bvs     L4C3F
L4C9C:  .byte   $0B
        eor     ($1D,x)
        and     ($1D,x)
        .byte   $F9
        .byte   $1E
L4CA3:  and     ($1E),y
L4CA5:  cmp     #$1F
        eor     $E148,x
        sbc     #$05
        and     #$09
        adc     #$0F
        sbc     #$15
        ora     #$02
        adc     #$2A
        ora     #$2B
        cmp     #$2F
        eor     #$34
        .byte   $89
        .byte   $3A
        .byte   $23
        eor     #$6B
        lsr     a
        .byte   $B7
        lsr     a
        nop
        lsr     a
        adc     #$4B
        lda     ($4B,x)
        .byte   $DF
        .byte   $4B
        .byte   $16
L4CCD:  txa
        .byte   $62
        tsx
        adc     $3A
        .byte   $64
        .byte   $1A
        ror     L13A6
        .byte   $7C
        .byte   $93
        pha
        .byte   $D3
        sty     $94D3
        .byte   $D3
        txs
        .byte   $93
        ldy     $24
        sta     $9D40,x
        rts

        .byte   $9D
        .byte   $86
L4CE9:  sta     $9CAA,x
        .byte   $B2
        .byte   $9F
        asl     a
        .byte   $9F
        bvc     L4C91
        .byte   $C2
        .byte   $9E
        rol     $CF5D
        .byte   $4B
        .byte   $12
        .byte   $83
        ldx     #$85
L4CFC:  .byte   $82
        stx     $B7
        .byte   $D4
        ora     ($94,x)
        .byte   $44
        .byte   $54
        eor     L5C94
L4D07:  .byte   $14
        .byte   $6B
        sty     $42,x
        .byte   $14
        txa
L4D0D:  .byte   $14
        .byte   $8F
        .byte   $14
        .byte   $97
        sty     $9C,x
        .byte   $14
        ldy     $B594
        tya
        ldy     $42
        .byte   $A7
        .byte   $9F
        inc     L734A
        tax
        .byte   $77
        txa
        .byte   $7A
        stx     $FB53
        .byte   $53
        .byte   $1C
        .byte   $54
        rol     $54
        sec
        .byte   $54
        .byte   $47
        .byte   $54
        .byte   $57
        .byte   $54
L4D31:  .byte   $6B
        .byte   $54
        .byte   $7F
        .byte   $54
        .byte   $90
L4D36:  .byte   $72
        ldy     $CA
        lda     $3A
        lda     $AA
        .byte   $A7
        ror     a
        lda     $32
        .byte   $AF
        .byte   $C2
        .byte   $AB
        .byte   $5A
        ldy     $AA,x
        lda     $32,x
        lda     $D2,x
        .byte   $B7
        .byte   $1A
        bcs     L4D07
        ora     $D2,x
        .byte   $15
L4D52:  cld
        eor     $DE,x
        eor     $DE,x
        sta     $F5,x
        tay
        ldx     $B066
        sty     $B0,x
        .byte   $B2
        bcs     L4D36
        lda     ($04),y
        lda     ($2C),y
        lda     ($AE),y
        .byte   $05
L4D69:  .byte   $81
L4D6A:  sbc     $96
        lda     $9D,x
        .byte   $63
        bit     $AD98
        .byte   $67
        .byte   $FC
        .byte   $42
        cmp     $52,x
        dec     $B8,x
        dec     $84,x
        dec     $CA,x
        dec     $D7,x
        dec     $E1,x
        asl     $EA,x
        .byte   $16
L4D84:  sbc     $E8,x
        .byte   $B7
        .byte   $3A
        lda     L85AE,y
        cpy     $E5
        cmp     $B5,x
        cmp     $DB55,y
        lda     $D0
        ora     $E1,x
        eor     $E8,x
        cmp     $EB,x
        lda     $ED
        .byte   $07
        .byte   $AF
        .byte   $42
        .byte   $AF
        ldy     #$30
        eor     #$30
        rts

        bcs     L4E17
        bmi     L4DB1
        sta     L6D85
        stx     $29
        .byte   $86
L4DAF:  sta     ($86,x)
L4DB1:  sta     $A986,y
        stx     $BD
        stx     $D5
        stx     $ED
        .byte   $87
        ora     $87
        .byte   $21
L4DBE:  .byte   $87
        and     L6187,y
        sty     $59
        bit     $AC4A
        eor     L51EC
        bit     L6C51
        eor     ($CC),y
        .byte   $52
        jmp     LCC54

        .byte   $54
        cpx     $8F5A
        .byte   $62
        .byte   $EB
        .byte   $62
        inc     L1662,x
        .byte   $63
        .byte   $37
        .byte   $63
        bvc     L4E45
        adc     ($63),y
        bcc     L4D69
        .byte   $1C
        .byte   $DB
        ora     L1FD3,x
        .byte   $5B
        clc
        sty     L1D59
        ora     $9922,y
        rol     $99
        .byte   $2B
        cmp     $D932,y
L4DF9:  .byte   $3F
L4DFA:  cmp     $EA05,y
        .byte   $CB
L4DFE:  brk
        .byte   $CD
        .byte   $02
L4E01:  cmp     $CC7E
        rol     L62CE
        dec     $CFA4
        .byte   $1C
        dec     $D022
        nop
        cmp     ($44),y
        bne     L4E55
L4E13:  .byte   $D3
        .byte   $52
        .byte   $D3
        .byte   $76
L4E17:  .byte   $D3
        ldy     #$D6
        .byte   $9E
        stx     $91
        .byte   $14
        and     $49,x
        and     $78,x
        .byte   $35
L4E23:  php
        cpx     L5A0A
        .byte   $DC
        .byte   $1A
        .byte   $DF
        .byte   $5A
        inx
L4E2C:  .byte   $DA
        .byte   $F3
        .byte   $5A
        .byte   $FF
        .byte   $5A
        sbc     $9B
L4E33:  .byte   $32
        .byte   $1B
        rol     $DB,x
        .byte   $3F
        .byte   $DB
        ora     $CA
        .byte   $DA
        jmp     L74DA

        .byte   $DB
        .byte   $3A
        .byte   $DB
        .byte   $3C
        .byte   $DB
        .byte   $3E
L4E45:  .byte   $DB
        bvc     L4E23
        .byte   $54
        .byte   $DB
        .byte   $AB
        inc     $D6,x
        dec     $EC,x
        rol     $E0
        inc     $F5,x
        stx     $FD,y
L4E55:  asl     $F0
        .byte   $97
        ora     $B7
        .byte   $03
        .byte   $E7
        asl     $47,x
        .byte   $17
        .byte   $27
        ora     $B848,y
        dex
        lda     L89C7
        cpy     $11
        iny
        eor     #$C8
        sbc     ($CA),y
        rti

        rol     L0E53
        cli
        lsr     L0E5D
        eor     $F1
L4E78:  adc     #$97
        jsr     LF485
        ldx     #$97
        .byte   $82
        jmp     (LD194)

        .byte   $9E
        asl     L4787,x
        eor     ($29,x)
        cmp     #$7E
        txs
        sbc     #$5D
        .byte   $46
L4E8F:  .byte   $FC
        adc     L7A25,x
        .byte   $19
        .byte   $F1
L4E95:  sed
        dec     $C8
        ora     $E8,x
        .byte   $72
        sbc     L8786,y
        .byte   $1F
        .byte   $97
L4EA0:  .byte   $F2
        .byte   $57
        lda     ($BF,x)
        stx     $06,y
        adc     $E6
        lsr     $A19E,x
        nop
        adc     ($D9),y
        sta     L6985,y
        .byte   $BF
        ror     a
        cpy     #$75
        .byte   $1A
        .byte   $C1
L4EB7:  lda     #$94
        lda     L1E8F,y
        adc     $CD7A,y
        ora     $935C,y
        .byte   $9C
        bmi     L4F1B
        .byte   $1A
        ror     $9C
        and     L66C2,x
L4ECB:  .byte   $B7
        .byte   $4B
        .byte   $2C
L4ECE:  .byte   $37
        .byte   $73
        .byte   $4C
L4ED1:  .byte   $B2
        sed
        .byte   $B7
        jmp     LC8B3

        .byte   $D3
        sty     $EB34
        .byte   $3B
        adc     $C3AA,y
        ldy     $CF,x
        .byte   $74
        .byte   $BD
        .byte   $11
L4EE4:  .byte   $EF
        .byte   $C1
L4EE6:  inc     $E8
        bit     L52B7
        .byte   $17
        .byte   $52
        .byte   $D7
        .byte   $53
        .byte   $97
        .byte   $54
        .byte   $67
        eor     $27,x
        eor     $F7,x
        .byte   $57
        .byte   $47
        cli
        .byte   $A7
        eor     L5A97,y
        .byte   $77
        .byte   $5B
        .byte   $47
        .byte   $5B
L4F01:  .byte   $F7
        eor     L3A45,x
        nop
        .byte   $3A
        .byte   $F3
        tsx
        sed
        tsx
        sbc     $F93A,y
        tsx
        .byte   $FA
        .byte   $3A
        .byte   $FA
L4F12:  tsx
L4F13:  .byte   $FB
        .byte   $3A
        .byte   $FB
        .byte   $C7
        .byte   $D7
        ldy     $97BD
L4F1B:  .byte   $5A
        .byte   $A5
L4F1D:  tya
        sta     $E39E,x
        .byte   $CB
        ora     ($1A),y
        and     $EB,x
        ror     $DB,x
        bit     $56
        sbc     $20
        .byte   $FA
        ldx     $CF,y
        lda     $96F3
L4F32:  sbc     $DD98,y
        .byte   $74
        .byte   $37
        dec     $CD2F
        .byte   $CF
        and     ($CA),y
        cmp     $2E
        .byte   $B7
        .byte   $4F
        .byte   $3C
        .byte   $02
        tay
        dec     $B6C6
        .byte   $CE
        .byte   $B2
L4F49:  cmp     $B4
        .byte   $A7
        .byte   $3B
        eor     $F1
        .byte   $9E
        inc     $75
L4F52:  .byte   $57
        .byte   $1A
        .byte   $EF
        rol     $EB
        .byte   $3A
        cld
        .byte   $92
        .byte   $9C
        sed
        .byte   $83
        lda     ($F4,x)
        dec     $A8,x
        .byte   $B6
L4F62:  sed
        stx     $B7,y
        .byte   $82
        adc     $CD
        lsr     a
        adc     ($B8,x)
        .byte   $3D
        .byte   $E2
L4F6D:  .byte   $FA
        .byte   $04
        ora     ($26),y
        .byte   $A7
        .byte   $EB
        .byte   $74
        bcs     L4FDB
        cpx     L26FF
        .byte   $17
        ora     $A151,x
        .byte   $6B
        ldx     L2EE8,y
        sbc     #$C6
        cpx     $49
        ora     #$83
        .byte   $E6
L4F88:  .byte   $23
        tax
        cmp     ($3C,x)
        ldy     $35,x
        .byte   $9B
        .byte   $6E
L4F90:  .byte   $8F
        jmp     (L7A9E)

        .byte   $9C
        jmp     (L67CE)

        ora     $AC6F
        ldx     $C3,y
        .byte   $22
        rol     $8D,x
        adc     $D3
        .byte   $73
        .byte   $3B
L4FA4:  cmp     ($B2),y
        .byte   $FA
        .byte   $9E
        .byte   $B7
        .byte   $EF
        dey
        cmp     #$B8
        tax
        beq     L4F32
        .byte   $1D
        .byte   $56
L4FB2:  .byte   $9B
        adc     $26,x
        sty     $C763
        ora     #$E7
        lda     $A9B6,y
L4FBD:  lda     $06
        sbc     $69,x
        .byte   $03
        asl     L653D,x
        lda     ($56,x)
L4FC7:  adc     $9A
        ldx     $DA
L4FCB:  and     $BF,x
        lsr     $F5C4,x
        cli
        tax
L4FD2:  lsr     a
        .byte   $DB
        and     ($0D,x)
        .byte   $89
        cpy     #$4C
L4FD9:  asl     a
        txs
L4FDB:  cmp     ($D7),y
L4FDD:  tax
        .byte   $3A
        asl     $22,x
        .byte   $3D
L4FE2:  ora     #$36
        eor     $AF
L4FE6:  .byte   $CB
        .byte   $27
        cpx     $4B
        lda     #$FB
        .byte   $64
L4FED:  .byte   $DB
        and     #$D5
        sbc     ($5B,x)
L4FF2:  .byte   $76
L4FF3:  lda     $7282,y
        .byte   $1C
L4FF7:  pla
        .byte   $44
        ora     L32DA,y
        and     $BF11
L4FFF:  .byte   $2D
        .byte   $E4
L5001:  txs
        .byte   $E7
L5003:  .byte   $9C
        cli
        .byte   $62
        .byte   $5B
        and     $9D
        sbc     $5B
        .byte   $0B
        .byte   $5F
        .byte   $27
        .byte   $1A
        ldx     #$45
        .byte   $5A
        .byte   $3C
L5013:  .byte   $32
        lsr     $D822,x
        bcc     L506E
        .byte   $1B
        sta     $B9,x
        .byte   $F3
        .byte   $6F
        tya
L501F:  bit     $1C
        .byte   $63
        .byte   $54
        ldx     $D8
        sta     L6397,x
        adc     L7C91,x
        lda     #$DE
        .byte   $27
        clc
        clv
        sbc     #$D6
        .byte   $FF
        .byte   $5B
        cmp     $D6B1,y
        sty     $87,x
        sbc     ($6E,x)
        .byte   $FC
        .byte   $9C
L503D:  .byte   $7F
        sta     $76,x
        sbc     $CF,x
        bpl     L4FCB
        .byte   $89
        .byte   $1F
        sbc     ($D8,x)
        adc     $52,x
        sbc     #$D3
        lda     ($E3),y
        .byte   $3B
        .byte   $04
        .byte   $F3
        inc     $6C
        dec     $E7AF
        sbc     $69
        .byte   $5B
        .byte   $7D
L505A:  .byte   $B2
        asl     $6F
        .byte   $B3
        sei
L505F:  adc     #$4C
        dec     $B9
        .byte   $36
L5064:  cpx     #$9D
        .byte   $E3
        .byte   $2B
        .byte   $F4
        .byte   $9B
        lda     L5C4B,x
        .byte   $5B
L506E:  .byte   $33
        .byte   $5B
        .byte   $1C
        .byte   $D3
        jsr     LF32A
        inc     $C53C,x
        ldx     $8E,y
        .byte   $6B
        tay
        .byte   $7B
        .byte   $0B
        asl     $5B,x
        .byte   $66
L5081:  beq     $5059
        ror     $5A,x
        eor     $B9,x
        .byte   $BF
L5088:  .byte   $9C
        adc     $1D,x
        .byte   $E3
        ora     ($1A),y
        .byte   $82
        .byte   $D2
        .byte   $23
        ora     L317C,y
        .byte   $DA
        .byte   $53
L5096:  .byte   $9E
        .byte   $A4
L5098:  .byte   $A7
        lda     ($98,x)
        .byte   $83
        .byte   $92
        cmp     $9F1C
        .byte   $F2
        tsx
        sei
        inc     $E9,x
        .byte   $62
        beq     L5088
        .byte   $C2
        adc     #$4F
        .byte   $43
        inc     $22,x
        .byte   $34
        bvs     L503D
        adc     $8F,x
        adc     $96
        .byte   $4F
        adc     $56,x
L50B8:  .byte   $0F
        lda     #$E6
        pha
        eor     $47,x
        sta     $B2C4,y
        sei
        rol     $59
        .byte   $F7
        cmp     $E5B7,y
        .byte   $8B
        ror     $F505,x
        ror     $E5,x
        .byte   $1A
        .byte   $DC
        .byte   $5D
L50D1:  .byte   $37
        .byte   $1B
        ldx     $B5A5
        cmp     #$23
        ldx     $C7,y
        lda     $A698,y
        tay
        lsr     $F5,x
        .byte   $63
        .byte   $39
        .byte   $69
L50E3:  rol     $05,x
        .byte   $C7
        .byte   $61
L50E7:  .byte   $47
        eor     $F681,y
        .byte   $47
        sec
        dec     $BC,x
        ldy     #$BB
        .byte   $6B
        .byte   $9B
        adc     $F1C6
        adc     #$65
        bcs     L514B
        .byte   $F7
        dec     $B9
        dec     $64
        ldy     $37
L5101:  .byte   $79
L5102:  lda     $FD,x
        .byte   $6F
        sbc     $41,x
        jsr     L26C7
        nop
        .byte   $D7
        asl     L170F,x
        .byte   $9B
        lsr     L0C89
        sbc     L81B7,x
        .byte   $0C
        sbc     L26F1
        .byte   $11
L511B:  sei
        sty     $EB
        sta     $CA,x
        rol     $A5F8
        and     ($38,x)
        .byte   $AB
        .byte   $1B
        sta     $EF2C,x
        adc     $ED8C
        .byte   $1B
        sei
        rol     L6397
        eor     $CFF3,x
        bcc     L5102
        .byte   $D5
L5138:  .byte   $97
        .byte   $6F
        stx     $79
        .byte   $67
        .byte   $12
        iny
        .byte   $27
        bvs     L5138
        .byte   $1C
        .byte   $EC
        .byte   $6E
L5145:  sbc     ($64),y
        ldy     $B0
        eor     #$B9
L514B:  rol     $2D,x
        lsr     a
        adc     $12
        and     L464F
        .byte   $B7
        .byte   $D2
        cpx     $E44D
        adc     ($95),y
        lsr     $62,x
        .byte   $F4
        .byte   $C7
        clv
        rol     $C4EF,x
        ldx     #$74
        .byte   $07
        clv
        .byte   $B7
        tya
        .byte   $64
        .byte   $52
        ldx     $35
        .byte   $CC
L516D:  .byte   $C2
L516E:  bvs     $5134
        tay
        cmp     L8C2E,x
        .byte   $37
        sta     ($1C,x)
        .byte   $DF
        .byte   $6B
        .byte   $7C
        .byte   $63
        .byte   $33
        sbc     ($B4),y
L517E:  .byte   $EB
        and     #$26
        and     ($8E),y
        asl     L8363,x
        cpy     $5A
        bit     L5E64
        plp
        .byte   $14
L518D:  ldx     $72,y
        cmp     $AF80
        ldx     $B7,y
        .byte   $9B
        eor     L31B1
        cmp     #$18
        rts

        ldx     $14
        eor     L4B9C
        and     $CB36,y
        txs
        .byte   $34
        sbc     ($1E,x)
        adc     $DF
        rol     L3DCD
        .byte   $27
        jsr     LBF49
        txs
        cmp     $E2BA
        .byte   $93
        .byte   $22
L51B6:  .byte   $A3
        .byte   $5B
        .byte   $B2
        cmp     $81
        .byte   $52
        .byte   $03
        .byte   $72
L51BE:  ldy     $93,x
        adc     ($E4,x)
        .byte   $B2
        ror     L3720,x
        ldx     $2C,y
L51C8:  .byte   $CB
        .byte   $27
        lsr     $AA45
        .byte   $B7
        ldy     $C9
        .byte   $34
        inc     $59,x
        .byte   $D7
        cpx     $C2
        .byte   $63
        ldx     $B7,y
        .byte   $EF
        ldx     $11
        .byte   $63
        beq     L51BE
        .byte   $3C
        ldy     L674C,x
        .byte   $6F
        asl     L19B7
        clc
        cpy     L6D10
        .byte   $E9
L51EC:  adc     #$2A
        eor     #$9E
        and     ($BE),y
        .byte   $77
        .byte   $5C
        sbc     ($27),y
        cmp     L12F9
        ldy     $BD
        .byte   $3B
        .byte   $34
        .byte   $F6
L51FE:  ora     $0A,x
        clc
        cpy     $F0
        cmp     $2C
        asl     a
        ldy     L6DDC,x
        .byte   $1F
        dec     $87
        .byte   $4B
        ora     $38,x
        .byte   $F7
        adc     L5E1E,x
        dec     $F6D6,x
        jmp     L2CB7

        .byte   $80
        cmp     $16
        .byte   $D3
        tya
        .byte   $D3
L521F:  sty     $ABD0
        .byte   $8F
L5223:  .byte   $D3
        sta     $67
        .byte   $32
        dec     $4B
        .byte   $DA
        .byte   $E7
        adc     ($72,x)
        .byte   $52
        .byte   $7B
        ldy     $06E7,x
        cmp     $CE,x
        .byte   $7B
        .byte   $E2
        .byte   $5A
        ldy     $71
        .byte   $44
        cmp     L3D6E,y
        rol     $25
        and     #$7B
        cpy     $F11F
        stx     $B7
        .byte   $B4
L5247:  ora     $DE29,y
        clc
        .byte   $E3
        bne     L521F
        .byte   $57
        .byte   $9B
        .byte   $EF
        rol     $97
        txa
        .byte   $9B
        cpx     L178B
        .byte   $C7
L5259:  sbc     $A6,x
        .byte   $F5
L525C:  stx     $5C,y
        ldx     $ED,y
L5260:  .byte   $D2
        eor     $9280,x
        ror     $9893,x
        .byte   $B3
        eor     $CC3D
L526B:  .byte   $14
        txa
        .byte   $3B
        .byte   $CF
        .byte   $72
        asl     $CF,x
        rol     $CD72,x
        .byte   $AB
        .byte   $33
        eor     $EB4A
        tax
        .byte   $44
        and     L0E3B
        .byte   $57
        sed
        ldx     L7B62,y
        inc     $D8,x
        .byte   $E7
        .byte   $DF
        sbc     L729B,y
        txs
        .byte   $92
        .byte   $CF
        .byte   $D7
        sta     L7C77,y
        .byte   $27
        eor     #$E5
L5295:  .byte   $E3
        rts

L5297:  inc     $1A
        .byte   $D2
        stx     $4E
        ora     ($A4),y
        .byte   $DB
        .byte   $63
        .byte   $E7
        .byte   $92
L52A2:  .byte   $32
        .byte   $BB
        stx     L09A9
        cpy     L74F3
        sbc     ($5B),y
L52AC:  .byte   $FC
        ror     $22
        .byte   $B2
        rol     a
        ror     $35
        lda     $98E3
        .byte   $23
L52B7:  .byte   $92
        .byte   $96
L52B9:  .byte   $72
        sta     L7B65
        .byte   $89
        rts

        .byte   $6F
        asl     $79,x
        .byte   $89
        .byte   $C2
        .byte   $A3
        plp
        inc     $99,x
        ldx     $E9,y
        .byte   $37
        and     $1C
        .byte   $B5
L52CE:  .byte   $3A
        ldx     $9958,y
        lsr     a
        ror     $76
        cli
        cpy     $09
        dec     $B9
        asl     $3E
        cpx     #$65
        .byte   $AB
        and     ($B5),y
        sbc     $98
        sbc     $72,x
        ora     ($6F,x)
        eor     $E38C,x
        .byte   $33
        lda     ($AF),y
        iny
        .byte   $89
        ora     $B890,y
        dec     $9A
        inx
        .byte   $3A
        lda     L77DC
        dec     L1E36
        .byte   $34
        .byte   $BB
        .byte   $B7
        ldx     $AE
        .byte   $BF
        .byte   $C7
        ldx     $24,y
        .byte   $46
L5306:  sta     L3055,x
        cmp     #$33
        .byte   $33
        .byte   $E7
L530D:  .byte   $6B
        .byte   $9E
        .byte   $B7
        cmp     L4BA5
        .byte   $1B
        sta     L6611,y
        and     L4C9C,y
L531A:  .byte   $04
        bcc     L52AC
        .byte   $C3
        adc     $E4,x
        dec     L38CF
        dec     L27A1
        .byte   $A3
        .byte   $D4
        bcc     L538F
        .byte   $5C
        .byte   $FB
        .byte   $89
        .byte   $13
        .byte   $9E
        rts

L5330:  .byte   $1B
        .byte   $34
        .byte   $D2
        .byte   $64
        bcc     L531A
        and     $DE8A,y
        lda     $AEF0
        cpy     L631A
        ora     ($9E,x)
        .byte   $23
        .byte   $1A
        sta     $95DB,y
        .byte   $82
        .byte   $27
        and     $CE,x
        eor     $9A,x
        eor     L2152,y
        .byte   $34
L5350:  cpx     L70F7
        cmp     L3C2D
        .byte   $C7
        sec
        cmp     $38,x
        .byte   $D3
        cmp     #$6A
        ror     L13D8,x
        cmp     #$1B
        iny
        rti

        sbc     $CA64,x
        .byte   $3C
        eor     $E3,x
        .byte   $3D
L536B:  clv
        .byte   $A3
        .byte   $32
        .byte   $D3
        cmp     ($EF,x)
        lsr     $04,x
        .byte   $CB
        adc     ($86),y
        adc     ($AB),y
        stx     $8DB1
        plp
        sec
        dec     $EB
        and     $35
        bmi     L5350
        ldx     L8084
L5386:  .byte   $FC
        ldx     #$75
        .byte   $CF
        stx     L3366
        dec     $0A
L538F:  lsr     $D1E2,x
        txs
        ldy     $73
        asl     $41,x
L5397:  adc     $B6,x
        .byte   $BE
        cli
L539B:  dex
L539C:  clc
        cmp     ($8D),y
        .byte   $7F
        .byte   $37
        and     L650C,y
        cmp     $22,x
        cmp     $BFB5,y
        rol     L1F61
        ldx     $99A0
        .byte   $C2
        rol     $B80E
        lda     $BAE4,x
        sta     L50E7,y
        dec     $E9,x
        dec     $62
        .byte   $3C
        sty     L8B6B
        adc     #$5E
        sbc     L8BBF
        .byte   $67
        ora     ($8D),y
        .byte   $54
        .byte   $90
L53CB:  .byte   $63
        .byte   $92
        bcc     L539C
        .byte   $0C
L53D0:  .byte   $5F
        sty     $CECF
        .byte   $77
        clv
L53D6:  adc     #$E4
        eor     $EA
        ldx     $79,y
        .byte   $F7
        .byte   $5B
        cpx     L19EF
        bcs     L539B
        inc     $8E8D,x
L53E6:  cmp     #$6D
L53E8:  .byte   $D2
        ror     a
        .byte   $2E
L53EB:  pha
        cpy     #$CC
        .byte   $63
        lsr     a
        cld
        cpy     $BD5E
        cmp     ($E3,x)
        .byte   $7A
        sty     $C9,x
        jmp     L2AB7

        .byte   $6B
        .byte   $72
        .byte   $44
        .byte   $7B
        .byte   $FE
L5401:  .byte   $1A
        cmp     #$4F
L5404:  .byte   $6B
        sta     $97,x
        .byte   $C7
        .byte   $7A
        lsr     L00F9
        stx     $2C,y
        .byte   $89
        ora     $7E,x
        .byte   $AC
L5411:  .byte   $9E
        .byte   $3F
        eor     $CC34,x
        .byte   $14
        .byte   $92
        and     $CE,x
        .byte   $42
        asl     $E556
        clc
        .byte   $F2
        ldx     $F5
        .byte   $64
        eor     $F8C6,y
        .byte   $9C
        .byte   $81
L5428:  iny
L5429:  tsx
        ldx     $DF,y
        clc
        .byte   $93
        .byte   $67
L542F:  .byte   $7A
        .byte   $F3
        bvc     L5411
        .byte   $FC
L5434:  .byte   $33
        .byte   $5A
        and     $BF,x
        .byte   $7C
        .byte   $72
        .byte   $B3
        .byte   $34
        inc     $5D,x
        .byte   $3A
        .byte   $3F
        cmp     #$EB
        .byte   $27
        and     ($8B,x)
        sta     ($CD,x)
        and     #$0C
        .byte   $F3
        .byte   $4F
        cli
        .byte   $85
L544D:  sty     L71CC
        .byte   $8D
L5451:  .byte   $B2
        .byte   $32
        .byte   $11
L5454:  adc     L855B,x
        .byte   $F3
        bvc     L5429
        .byte   $53
        .byte   $80
        .byte   $4B
        .byte   $FA
        .byte   $DF
        sta     L3165
        sbc     ($6C,x)
L5464:  sbc     L37AA,x
        sty     L8C99
        rol     $07
        rts

        .byte   $54
        inc     $00
        .byte   $63
        sec
        .byte   $8B
        lsr     a
        adc     $75,x
        .byte   $89
        .byte   $1B
        .byte   $62
        txs
        adc     #$F3
        eor     $C8,x
        ldx     #$DB
        lda     $A43D,y
        cmp     L5AD3,x
        .byte   $89
        .byte   $1F
        ora     ($27),y
        .byte   $1A
        .byte   $DB
        lda     L5966,x
        .byte   $D9
L5490:  .byte   $63
        .byte   $9B
        .byte   $CB
        .byte   $53
        dec     $FD,x
        .byte   $E3
        lsr     $37,x
        ldy     L349F
        txa
        .byte   $3A
        .byte   $DF
        eor     #$A4
        eor     $2D
        .byte   $DC
        lda     ($04),y
        sta     ($67),y
        and     L6393,x
        adc     $A18A
        .byte   $89
        .byte   $A7
        .byte   $9C
        .byte   $9B
        .byte   $E6
L54B3:  .byte   $2F
        .byte   $64
        brk
        .byte   $D2
        .byte   $87
        .byte   $37
        .byte   $2B
        sec
        nop
L54BC:  .byte   $B2
        .byte   $DB
        .byte   $8F
        .byte   $3C
        .byte   $ED
        .byte   $1B
L54C2:  cmp     #$91
        lda     $FEF6
L54C7:  dec     L6E67,x
L54CA:  inc     $DB,x
        adc     L1290
        .byte   $8F
        .byte   $73
        inc     L5BDF
        .byte   $A4
L54D5:  .byte   $9B
        .byte   $12
        .byte   $B2
        tsx
        sbc     #$60
        iny
        lda     L470A,x
        .byte   $2E
        .byte   $B3
L54E1:  rti

        and     L4EE4,x
        and     ($AA),y
        .byte   $27
L54E8:  ora     $2B
        sbc     $C4A4,y
        .byte   $A7
        cld
L54EF:  .byte   $C7
        adc     $D4
        .byte   $9F
        asl     L32A6
        lda     #$D5
        bit     L86F7
        and     #$6E
        bcc     L54E1
        .byte   $DB
        .byte   $87
        stx     L45EA
        lda     L345A,y
        .byte   $D2
        adc     $B9,x
        ldx     L65FA,y
        asl     $73,x
        .byte   $BB
        .byte   $AB
        dec     $FA,x
        php
        .byte   $73
        .byte   $93
        jmp     (L2E7B)

        eor     L4261
        .byte   $1B
        tax
L551E:  bcc     L54B3
        bvc     L557D
        .byte   $E2
        .byte   $44
        .byte   $D2
        .byte   $07
        .byte   $2F
        .byte   $DC
        dex
        .byte   $FC
        ldy     $E3,x
L552C:  .byte   $A7
        adc     ($0A),y
        dec     $AD83,x
        sbc     $15,x
        dec     $FB
        cmp     ($F8,x)
        ldx     $46
        sbc     $64,x
        .byte   $17
        .byte   $12
        cld
        eor     $B073,x
        .byte   $E3
        .byte   $3A
        .byte   $22
        .byte   $FB
        .byte   $53
        .byte   $7B
        and     ($2A),y
        .byte   $33
        .byte   $54
L554C:  .byte   $9B
        ror     $F66B,x
        cmp     $F6,x
        .byte   $13
        .byte   $17
        lsr     $AEC9
        ror     $1B,x
        .byte   $22
        sty     $65
        .byte   $AB
        .byte   $33
        .byte   $7A
L555F:  .byte   $43
        .byte   $3B
        .byte   $6F
        tya
        .byte   $F3
        asl     L0A3F,x
        bvs     L55C1
        .byte   $DF
        sec
        sbc     $1A
        cmp     L30EE
        .byte   $F3
        ora     L6E31
        .byte   $93
        .byte   $89
        adc     ($86),y
L5578:  and     ($53),y
        .byte   $8B
        cmp     #$73
L557D:  .byte   $4F
        .byte   $9C
        .byte   $C7
        .byte   $E2
        .byte   $E3
L5582:  .byte   $AB
        .byte   $5A
        .byte   $44
        txs
        lda     ($D6,x)
        lsr     $B14C,x
        .byte   $12
        plp
        adc     $05
        sty     $EA
        tax
        bit     L7138
        .byte   $DB
        .byte   $7B
        adc     $A90A,y
        .byte   $13
        .byte   $8B
        .byte   $09
L559D:  .byte   $3B
        asl     $30
        lsr     L2923
        and     #$EE
L55A5:  sei
        asl     a
        .byte   $1D
L55A8:  txa
        eor     $9D8A,x
        sta     $A09D
        cmp     $6EB4,x
        cpx     $E722
        adc     $07,x
        .byte   $77
        .byte   $37
        adc     L7C57,y
        .byte   $37
        .byte   $7F
        .byte   $C7
        adc     $C7,x
L55C1:  txa
        .byte   $17
        txa
        .byte   $27
        sta     $8F07
        .byte   $B7
        sta     ($78,x)
        .byte   $3C
        lda     $3C,x
L55CE:  cmp     ($BC),y
        .byte   $EB
        adc     $E4,x
        eor     $E8
        sbc     $E9
        lda     $E9
        .byte   $A9
L55DA:  sbc     #$AD
        sbc     #$B1
        nop
        sta     ($EA),y
        sta     $EB,x
        eor     $4F,x
        eor     ($CF,x)
        pla
        .byte   $2F
        adc     L6D6F
        .byte   $8F
        .byte   $72
        .byte   $AB
        .byte   $7B
        sbc     $FA7B,y
        .byte   $7B
        .byte   $FB
        .byte   $7B
        jsr     L947C
        .byte   $33
        inc     $2B
        cpx     #$63
        .byte   $EC
        .byte   $A1
L5600:  .byte   $5F
        .byte   $7A
        .byte   $1F
        .byte   $7A
        .byte   $5F
        .byte   $67
        ora     ($00,x)
        .byte   $9F
        cpx     #$20
        rts

        rti

        .byte   $A0
L560E:  adc     ($C0,x)
L5610:  sta     ($F1,x)
        inc     $0408
        .byte   $0D
L5616:  .byte   $1F
        rts

        ldy     #$40
L561A:  cpx     #$60
        cpx     #$94
        .byte   $7B
        .byte   $83
        .byte   $47
        bcc     L563F
        bvs     L55A8
        .byte   $C7
        clv
L5627:  rti

        bpl     L5672
        clc
        and     $97,x
        clv
        dey
        clc
        .byte   $50
L5631:  jsr     LF85F
        bpl     L55CE
        sec
        bcs     L5659
        .byte   $4F
        sed
        clc
        pha
        sec
        .byte   $64
L563F:  .byte   $5F
        sta     $81
        php
        cli
        .byte   $5C
        .byte   $D5
L5646:  adc     L201E
        and     ($D8),y
        and     $1E
        ldx     #$31
        beq     L5665
        .byte   $04
        and     #$1F
        .byte   $62
        rts

        .byte   $42
        lda     ($A6),y
L5659:  sec
        .byte   $03
        asl     $01C1,x
        .byte   $53
        iny
L5660:  .byte   $14
L5661:  .byte   $74
        .byte   $04
        .byte   $54
        .byte   $0C
L5665:  .byte   $54
        .byte   $12
        .byte   $3A
L5668:  sta     ($87,x)
        .byte   $BF
        cmp     ($07,x)
        .byte   $E2
        sed
        .byte   $7A
        rts

        .byte   $11
L5672:  plp
        and     ($14),y
        .byte   $74
        bpl     L5646
        brk
        cmp     #$C0
        pha
        eor     ($49,x)
        sta     ($C9,x)
        .byte   $A3
        sty     L2094
        stx     $38,y
        eor     #$41
        dex
        .byte   $23
        jsr     L1C9C
        ldy     $14
        ldx     $78
        .byte   $22
        .byte   $3F
        .byte   $22
        .byte   $BF
        .byte   $23
        .byte   $3F
        .byte   $23
        .byte   $BF
        and     $3F
        and     #$BF
        bit     L303F
        .byte   $BF
        and     $3F,x
        and     L3EBF,y
        .byte   $3F
        .byte   $4B
        ora     L21FA
        .byte   $FA
        and     $FA,x
        and     L45FA,y
        .byte   $FA
        eor     ($FA),y
        eor     L71FA,x
        .byte   $FA
        adc     $91FA,x
        .byte   $FA
        lda     $FA
        lda     $C5FA,y
        .byte   $FA
        cmp     #$FA
        cmp     $D1FA
        .byte   $FA
        cmp     $FA,x
        cmp     $FDFA,y
        .byte   $FB
        bvc     L571F
L56D0:  cld
        .byte   $AF
        cmp     $D90F,y
        .byte   $2F
        .byte   $D9
L56D7:  .byte   $CF
        .byte   $DA
        .byte   $2F
        .byte   $DA
        .byte   $4F
        .byte   $DA
        .byte   $6F
        .byte   $DB
        .byte   $8F
        .byte   $DC
        .byte   $2F
        .byte   $DC
        .byte   $CF
        cmp     $DDAF,x
        .byte   $CF
        cmp     $DEEF,x
        .byte   $0F
        .byte   $C6
L56ED:  .byte   $5F
L56EE:  sbc     ($FC),y
        .byte   $67
        inc     $FE6F,x
        adc     ($FE),y
        .byte   $77
        inc     $FE73,x
        .byte   $87
        .byte   $12
L56FC:  .byte   $DF
        nop
        .byte   $5F
        sbc     #$1F
        sbc     #$DF
        sbc     #$FF
        .byte   $EB
        .byte   $FF
        nop
        .byte   $9F
        nop
        .byte   $7F
        cpx     $EC13
        .byte   $9B
        tax
        plp
        bit     $B1
        sta     $21
        eor     ($61,x)
L5717:  rti

        rti

        .byte   $C0
L571A:  rts

        .byte   $92
        .byte   $77
        .byte   $35
L571E:  .byte   $BC
L571F:  cpy     $5D
        rol     $0702,x
        .byte   $FE
        .byte   $7E
L5726:  ldx     $44FB
        .byte   $C3
        .byte   $80
        .byte   $BF
        ora     #$48
        .byte   $7F
        php
        .byte   $97
        .byte   $AF
        .byte   $6F
        sed
        brk
        sbc     L34A1,y
        ora     ($29,x)
        bvc     L56FC
        .byte   $9F
        sed
        nop
        .byte   $4B
        bcc     L56D0
        sta     L2096,x
        sei
        .byte   $64
        bcs     L5761
        sta     $9828,y
        .byte   $9B
        .byte   $1F
        .byte   $04
        cmp     $C962,y
        sbc     $2E,x
        .byte   $02
        asl     $4A,x
        asl     $C7,x
        sty     $BB,x
        .byte   $87
        sty     $C0,x
        php
        .byte   $89
        plp
L5761:  .byte   $8B
        asl     L0D53,x
        .byte   $79
        .byte   $13
L5767:  eor     L5FBC,y
        sta     ($C4,x)
        eor     ($04,x)
        .byte   $C3
        ora     #$F2
        ror     $44,x
        .byte   $43
        inc     L0216,x
        asl     L0E08
        .byte   $0C
        asl     L6C10
        .byte   $14
        dec     $78
        brk
        plp
        .byte   $01
L5784:  bcs     L5789
        .byte   $1F
        brk
        .byte   $26
L5789:  cmp     ($2A,x)
        txa
        inc     $B2FF,x
        .byte   $E7
        .byte   $8F
        .byte   $13
        rts

        ldy     $AF,x
        cld
        .byte   $FA
        eor     $8E,x
        .byte   $F3
        .byte   $04
        .byte   $0F
        .byte   $F2
        php
        .byte   $F7
        brk
        .byte   $03
        dey
        rti

        .byte   $F3
        .byte   $32
        .byte   $23
        .byte   $B3
        .byte   $32
        iny
        .byte   $1B
        eor     $99,x
        asl     $E026,x
        .byte   $DF
        sty     $77,x
        .byte   $47
        clv
        and     #$B8
        adc     $97
        lda     $CC5D,x
        sty     $C4
        and     $C0
        .byte   $DF
        cmp     ($A4),y
        php
        jsr     L464C
        .byte   $2D
L57C7:  adc     $C8
        .byte   $5C
        clc
        asl     a
        asl     $0A,x
        stx     $1B,y
        asl     L7D75,x
        ldx     #$9D
L57D5:  .byte   $DA
        lsr     $9CA2,x
        cmp     ($EF),y
        adc     $57
        .byte   $54
        .byte   $FC
        sei
        .byte   $C7
        tay
        rti

        and     ($B8),y
        bit     $0269
        .byte   $FF
        .byte   $13
        .byte   $12
        lsr     $35
        asl     L17D6,x
        cpx     #$71
        .byte   $CF
        adc     $48
        cmp     #$1E
        sbc     ($C1),y
        bpl     L57FD
L57FB:  and     ($A6,x)
L57FD:  cpy     #$92
        inc     $CD33
        cmp     ($7E),y
        lda     $BC3C,y
        eor     #$90
        sed
        .byte   $F4
        .byte   $04
L580C:  .byte   $37
        php
        .byte   $F4
        .byte   $7B
        beq     L580C
L5812:  .byte   $EB
L5813:  cpy     $B8
        .byte   $23
        .byte   $5F
        .byte   $DC
        and     L5E78,y
        .byte   $1A
        sbc     ($E2),y
        cmp     #$E1
        bcs     L5828
L5822:  jmp     LF0CD

        adc     L7507,x
L5828:  .byte   $F4
        .byte   $3F
        .byte   $9F
        ldy     #$60
        .byte   $BF
        .byte   $77
        lsr     L185E,x
        .byte   $E7
        bcs     L5885
        .byte   $5A
        eor     #$34
        sei
        .byte   $B7
        .byte   $87
L583B:  cpy     #$40
        eor     #$70
        pha
L5840:  ora     ($33,x)
        lda     ($7A),y
        .byte   $4F
        .byte   $97
        .byte   $8B
L5847:  .byte   $27
        bpl     L583B
        asl     $69
        lda     #$E4
        .byte   $DA
        .byte   $E3
        .byte   $CF
        .byte   $04
        .byte   $54
        bpl     L57D5
        .byte   $F2
        cpx     #$F0
        .byte   $02
        inc     $D4,x
        .byte   $D2
        .byte   $C2
        .byte   $6B
        ror     L8CB1
        asl     L8BC8
        bmi     L57FB
        .byte   $0F
        stx     L3B7E
        .byte   $AB
        clv
        .byte   $DF
        .byte   $42
        .byte   $64
        eor     $E330
        .byte   $3C
        sec
        cpy     L3307
        and     ($14),y
        .byte   $5C
        .byte   $9B
        bvc     L5812
        ror     $13,x
        bmi     L58D2
        ror     a
        bvc     L5894
        .byte   $0E
L5885:  asl     $E6,x
        .byte   $56
L5888:  .byte   $0E
        .byte   $5E
L588A:  inc     $9B
        ldx     $4D
L588E:  .byte   $AB
        asl     $FF0C,x
        inc     $16,x
L5894:  ldy     $DC
        .byte   $D4
        .byte   $5C
        sta     ($20),y
        .byte   $C7
        tya
        sec
        .byte   $74
        .byte   $52
        brk
        php
        .byte   $17
        lda     ($46,x)
        sbc     ($31),y
        adc     L8516,x
        lda     ($D3),y
        .byte   $47
        sei
        .byte   $5A
        .byte   $14
        ror     $93,x
        rol     L4F52
        dec     $C0
        ora     L401F
        and     ($01,x)
        eor     $A0
        brk
        and     ($80,x)
        .byte   $02
        adc     $77,x
        sta     ($55,x)
        .byte   $DF
        adc     ($D2,x)
        brk
        .byte   $5A
        .byte   $02
        ora     ($61,x)
        dec     $02,x
        .byte   $2F
        .byte   $FE
        .byte   $AB
L58D2:  .byte   $FB
L58D3:  inc     L100E,x
        jmp     L1D67

        .byte   $44
        .byte   $54
        .byte   $43
        ldx     $80
        .byte   $02
        .byte   $C2
L58E0:  .byte   $E9
L58E1:  .byte   $7C
        .byte   $7C
        .byte   $27
        eor     L5D7C,y
        .byte   $DE
L58E8:  eor     ($42),y
        lsr     $16,x
        lsr     L4C9C,x
        .byte   $D3
        .byte   $4B
        and     #$1E
        .byte   $A6
L58F4:  ror     $61
        .byte   $64
        ora     ($E3),y
        ora     $9069,y
        .byte   $5F
        .byte   $0C
L58FE:  tay
        ldx     $61
        brk
L5902:  bvc     L58E8
        bne     L590A
L5906:  eor     L822A
L5909:  .byte   $B0
L590A:  and     $50
        rol     $6F
        sed
        sbc     #$8F
        asl     a
        lsr     L3A4A,x
        rti

L5916:  bit     $E3B8
        stx     $8A,y
        ora     $F0,x
        dec     $C2
        rts

        dex
L5921:  ldx     $0302,y
        .byte   $5A
        .byte   $03
        eor     $AC
        .byte   $3A
        .byte   $23
        lsr     $E5C3
L592D:  ldx     $EC
        sbc     ($55,x)
        ora     $F9B0
        adc     #$0D
        .byte   $B2
        sbc     ($26),y
        sta     $A5,x
        rol     a
        .byte   $EB
L593D:  lda     L238B,x
        pha
        txs
        plp
        rol     $2B,x
        .byte   $FF
        .byte   $0F
        .byte   $C7
        dec     $C1
        .byte   $F4
        .byte   $3C
        .byte   $0C
        .byte   $C7
        nop
        adc     L6012,y
        .byte   $D7
        sbc     $C5FF,y
        rol     $F8
        .byte   $9D
        .byte   $1F
L595A:  cpy     $DE
        ora     ($BE),y
        rts

        .byte   $CB
        eor     #$2C
        plp
L5963:  .byte   $5F
        .byte   $1F
        pha
L5966:  .byte   $9F
        ldy     $7C,x
        .byte   $7F
        .byte   $87
        sta     ($55),y
        .byte   $E3
        bvs     L5916
        inc     $09
        sbc     ($A4,x)
        .byte   $47
        lda     $E9
        sbc     $E9
        lda     ($64),y
        asl     $9A,x
        and     ($FE),y
        .byte   $3A
        clc
        .byte   $9E
        iny
        jmp     L1DDB

        eor     #$A9
        rts

        .byte   $74
        bit     $C5
        .byte   $FA
        rol     a
        .byte   $1A
        adc     #$82
        eor     L284F,x
        lsr     $5F,x
        ora     #$60
        .byte   $F4
        ror     $BD
        asl     $90
        .byte   $FF
        .byte   $97
        lda     L1453,x
        .byte   $34
        ldx     L8531,y
        pha
        inc     L1D6B,x
        brk
        stx     $5C,y
        .byte   $89
        rts

        .byte   $D4
        .byte   $32
        .byte   $1B
        cmp     ($F0),y
        .byte   $39
        .byte   $47
L59B6:  cpx     #$ED
        .byte   $22
        rti

L59BA:  sbc     ($33,x)
        sta     L421F
        sta     ($B8),y
        adc     $D047,y
        .byte   $62
        and     #$34
        .byte   $A7
        rol     a
        .byte   $F2
        .byte   $0B
        eor     $4D
        .byte   $3A
        rol     $3B
        ldx     $2E
        .byte   $9E
L59D3:  .byte   $8B
        .byte   $E2
        cld
        .byte   $02
        sty     $34,x
        sta     $E6E2,y
        sbc     #$86
        txs
        lda     $0740
L59E2:  .byte   $82
        .byte   $DB
        tax
        lda     L1200,y
        tax
        ldx     $D1B6,y
L59EC:  bit     $B726
        .byte   $DC
        rol     $F7B7
        .byte   $52
        .byte   $92
        .byte   $54
        sta     $C30E,y
        .byte   $64
        .byte   $42
        tay
        cpy     #$C4
        .byte   $2B
        php
        adc     ($4A,x)
        .byte   $D2
        .byte   $1A
        .byte   $E0
L5A05:  rol     $EADB
        clv
        rti

L5A0A:  sty     $B2D4
        eor     ($6B),y
L5A0F:  .byte   $6F
        tax
        .byte   $50
L5A12:  cpy     #$88
        .byte   $FA
        .byte   $0F
        bcs     L5A12
        asl     $FAB0
L5A1B:  ora     $A08F,x
L5A1E:  pla
        .byte   $FA
L5A20:  and     $8F
        ldy     #$7A
        .byte   $34
        .byte   $02
        .byte   $CF
        .byte   $2B
        .byte   $22
        cpy     #$01
        sty     $BC23
        asl     $00,x
        .byte   $80
        .byte   $02
        .byte   $4B
        .byte   $E3
        cpx     #$1A
        .byte   $8F
        .byte   $8B
        sei
        ror     a
        ldy     $F1,x
        php
        .byte   $A3
        sty     $24
        lsr     L4EE6
        sty     $EB73
        .byte   $0C
        sei
        sed
        and     $F8B0,x
        .byte   $03
        ldy     $B7,x
        asl     $E8B4
        .byte   $0F
        ldy     $E8,x
        ora     L5A0F,x
        .byte   $04
        rol     $7F
        .byte   $4B
        asl     L628F
        .byte   $1A
L5A60:  and     $A808
        ldy     $A222,x
        bne     L59EC
        lsr     L82C0
        tya
        .byte   $DA
        bvc     L5A12
        bvs     L5A05
        and     $9ABC
        .byte   $57
        sbc     $6E,x
        .byte   $93
        sta     $B8
        .byte   $93
        adc     ($56,x)
        lsr     L2126,x
        .byte   $93
        .byte   $17
L5A82:  ldy     #$13
        and     L120C,y
        stx     $DA89
        sta     $C0,x
        sta     ($A1,x)
L5A8E:  sta     $E286
        ora     ($A6,x)
        .byte   $0D
L5A94:  sty     $D4
        .byte   $BD
L5A97:  adc     $E7
L5A99:  .byte   $FF
        inc     $07
        beq     L5A1E
        and     L5247,x
        .byte   $83
        adc     ($FD,x)
        txa
        .byte   $57
        .byte   $1C
        .byte   $27
        inc     $5C,x
        sta     ($EC),y
        .byte   $5F
        ror     $DC
        plp
        .byte   $43
        and     $8C
        eor     #$1B
        .byte   $47
        lda     #$B5
        .byte   $B7
        lda     $982F
        and     $B5A7
        dey
        bvs     L5B2F
        adc     (L00F9,x)
        adc     #$DD
        .byte   $07
        .byte   $89
        .byte   $87
        .byte   $E7
        sta     $59,x
        .byte   $D7
        .byte   $32
        .byte   $04
        iny
        ora     $19,x
        .byte   $C7
L5AD3:  .byte   $7C
        ora     $D400,y
        adc     $1E
        .byte   $E7
        ldx     $1C,y
        cpy     #$31
        .byte   $6D
        .byte   $6D
L5AE0:  ldx     $07,y
        asl     $9CB6,x
        plp
        ldy     #$91
L5AE8:  .byte   $EB
        adc     #$BF
        clc
        sbc     ($89,x)
        adc     #$B0
        asl     L5789,x
        bcs     L5B35
        ora     L6ADC,y
L5AF8:  .byte   $D1
L5AF9:  .byte   $89
        .byte   $57
        cmp     ($ED,x)
        asl     $75,x
        .byte   $7C
        .byte   $1F
        .byte   $52
        .byte   $67
        .byte   $47
        cpy     $5C
        cld
        .byte   $73
        eor     $ED,x
        adc     ($76),y
        .byte   $02
        cli
        adc     $EC55
        .byte   $7B
        .byte   $47
L5B13:  ora     $1E,x
        .byte   $74
        .byte   $73
        .byte   $0B
        cmp     ($DE),y
        .byte   $1A
        eor     L4DFE,y
        .byte   $DF
        asl     $14,x
        .byte   $DF
        sei
        jsr     L7008
        php
        .byte   $7B
        .byte   $3F
        sed
        pha
        .byte   $1C
        ror     $9540,x
L5B2F:  .byte   $42
        stx     $64,y
        bmi     L5B74
L5B34:  .byte   $20
L5B35:  .byte   $5A
        adc     ($70,x)
        .byte   $27
        sbc     ($7A,x)
L5B3B:  eor     L7D30,y
        .byte   $83
        .byte   $FA
        adc     ($30,x)
L5B42:  beq     L5AF9
        adc     $68,x
        .byte   $42
        .byte   $43
        eor     L225D,x
        txs
L5B4C:  cmp     ($EF),y
        adc     $D2
        sta     $62
        bit     L8525
        cmp     ($EC),y
        jmp     L1A3B

        rol     $32,x
        .byte   $52
        sta     $42
        bcc     L5B96
        .byte   $92
        rti

L5B63:  rti

        and     #$BC
        eor     L2018,x
        .byte   $17
        .byte   $02
        .byte   $82
        .byte   $17
        ldx     $18
        eor     $98
        sta     ($70),y
        .byte   $1C
L5B74:  .byte   $72
        .byte   $89
        cmp     $3C
        adc     L5B8E,x
        bvs     L5BDA
        .byte   $DC
        adc     ($D0),y
        iny
        .byte   $1A
        adc     $CDFC
        .byte   $0F
        .byte   $03
        adc     $CA,x
        sbc     $9114,x
        .byte   $4C
        .byte   $3B
L5B8E:  eor     $80
        lda     L25A5
        .byte   $0F
        .byte   $34
        .byte   $86
L5B96:  sbc     ($E3),y
L5B98:  .byte   $5A
        lda     $57
        cmp     ($30),y
        sta     $D51E
        .byte   $9C
        jsr     LCEB6
        inc     $4F,x
        and     $6B,x
        .byte   $93
        .byte   $63
        .byte   $8B
        eor     L875F,y
        eor     $C461,y
        tya
        .byte   $5A
        ora     $2F
        .byte   $EB
        and     $A097
        .byte   $64
        .byte   $7B
        .byte   $64
        eor     $EC,x
        php
        asl     a
        eor     L7193
L5BC3:  .byte   $93
        .byte   $64
        dec     $95
        lda     $AA75,y
        inc     $AB,x
        and     L5EE5,y
        ora     $44
        .byte   $DC
        .byte   $14
        .byte   $7C
        .byte   $93
        rol     $D3
        asl     L5401
L5BDA:  ldx     $C521,y
        adc     ($C4,x)
L5BDF:  .byte   $DC
        sta     $C5,x
        txa
        rol     a
        sta     L269D
        .byte   $13
        .byte   $1F
        cmp     (L00F9),y
        and     $E6
        sec
        sta     $D8
        sed
        clv
        ror     $B2
        php
        .byte   $42
        ora     ($11),y
        eor     L6748
        inc     L0E6C,x
        asl     L0A42,x
        jmp     (LFE07)

        ror     $43,x
        bcc     L5C6B
        sta     ($25),y
        .byte   $9B
        bcc     L5C79
        php
        lda     $DCCC
        .byte   $DC
        lsr     $3F,x
        cpx     $CFB6
        .byte   $C3
        .byte   $4B
        .byte   $87
        .byte   $F3
        .byte   $45
L5C1C:  .byte   $CB
        inc     L353F,x
        .byte   $0F
        .byte   $1F
        .byte   $8B
        lda     L7EB4,y
        ror     a
        .byte   $C7
        .byte   $E2
        inc     $DD,x
        .byte   $1F
        .byte   $9C
L5C2D:  .byte   $74
        ror     $74,x
        cmp     ($E1),y
L5C32:  .byte   $DB
        .byte   $47
        .byte   $A7
        .byte   $8C
        .byte   $7E
L5C37:  .byte   $7F
        .byte   $FA
        cmp     (L00F9),y
        sed
        inc     L1123,x
        .byte   $B2
        rti

        .byte   $4F
        cpy     #$C6
        .byte   $3F
        .byte   $05
L5C46:  clc
        .byte   $FC
L5C48:  .byte   $1B
        .byte   $63
        .byte   $F0
L5C4B:  .byte   $8E
L5C4C:  brk
        rti

        .byte   $F4
        lda     $3F
        asl     L13CB
L5C54:  .byte   $F3
        .byte   $FC
        ldx     $9300,y
        .byte   $FC
        dex
        brk
        .byte   $3C
        .byte   $F4
        .byte   $FA
        brk
        cli
        sbc     $58
        and     $9EF8,y
        sta     $9E,x
        .byte   $87
        rol     a
        .byte   $79
L5C6B:  sed
        cpy     #$C1
        .byte   $9F
        .byte   $89
        cpx     $F8D9
        txs
        .byte   $E7
        .byte   $C7
        .byte   $83
        dec     $7E
L5C79:  .byte   $23
L5C7A:  rti

        cpy     #$0C
        ora     $E7C3,x
        cmp     ($DC,x)
        .byte   $6F
        .byte   $1F
        .byte   $92
        .byte   $1C
        ror     L4050,x
        .byte   $1C
        pla
        inc     L3E9C,x
        .byte   $3F
        .byte   $EB
        iny
        .byte   $FC
        .byte   $C3
        .byte   $0C
L5C94:  sty     $4C
L5C96:  .byte   $F2
        .byte   $3F
        rol     $03,x
        cmp     ($13),y
        sei
        .byte   $8F
        dec     L3FB2
        and     $F0C3,x
        .byte   $4F
        .byte   $5F
        ldy     $017E
        cpy     #$A7
        brk
        jmp     L8909

        bne     L5D15
        ora     #$E9
        bne     L5C48
        .byte   $1F
        .byte   $83
        bpl     L5CF8
        nop
        sbc     $1E
        .byte   $CF
        ora     $917F
        rti

        tya
        and     #$15
L5CC4:  .byte   $67
        inc     $BF
        dec     $F173
        eor     $0426
        .byte   $E7
        .byte   $5F
        .byte   $EB
        .byte   $1C
        .byte   $7A
        and     ($71),y
        sed
        cmp     $C7,x
        .byte   $E3
        inc     $7E,x
        and     ($C2,x)
        adc     ($F1),y
        and     #$02
        ror     $A7,x
        .byte   $2D
        .byte   $02
L5CE4:  .byte   $44
        sta     ($3F,x)
        .byte   $9F
        dey
        .byte   $34
        .byte   $7C
        ror     L405B,x
        .byte   $93
        .byte   $19
L5CF0:  adc     #$05
        .byte   $8F
        cpy     L3F76
        .byte   $34
        .byte   $A0
L5CF8:  eor     #$CC
L5CFA:  ldx     $18,y
        .byte   $FC
        dec     $F363,x
        .byte   $9E
        .byte   $04
        cli
        .byte   $F7
        lda     L153F
        ora     #$DD
        .byte   $1F
        .byte   $9F
        inc     L8192,x
        .byte   $17
        lsr     $8FF7
        cpy     $DF
        .byte   $F9
L5D15:  rts

        txa
        .byte   $A7
        .byte   $03
        cmp     ($0A,x)
        ldx     $86
        cmp     ($17,x)
        nop
        .byte   $FC
        lsr     $8F,x
        .byte   $C2
        and     #$41
        .byte   $0B
        .byte   $FF
        stx     $47,y
        sbc     ($91,x)
        sty     L1E7E
        lda     ($D1,x)
        beq     L5CC4
        .byte   $47
        .byte   $82
        adc     $1F,x
        txa
        .byte   $D4
        ror     L4A2F,x
        php
        rts

        .byte   $F5
L5D3F:  txs
        .byte   $3F
        .byte   $3F
        .byte   $DB
        pla
        .byte   $FC
        adc     $A3,x
        cmp     ($F6),y
        .byte   $8F
        .byte   $89
        .byte   $22
        and     (L00F9),y
        clc
        .byte   $C7
        cpx     $A2
        lsr     $CC1E,x
        .byte   $27
        .byte   $E7
        .byte   $FC
        .byte   $DC
        bpl     L5CFA
        .byte   $FC
        .byte   $F3
        .byte   $1F
        sty     $50,x
        .byte   $43
        rol     a
        jmp     L4FA4

        .byte   $CF
        .byte   $FA
        tay
L5D68:  and     ($AF,x)
        .byte   $FA
        .byte   $D4
        .byte   $FC
        .byte   $52
        adc     $93
        .byte   $1F
        stx     $AC,y
        .byte   $7A
        .byte   $5B
        lda     ($D9),y
L5D77:  .byte   $73
        .byte   $04
        adc     L77FF,y
L5D7C:  .byte   $04
        and     #$FF
        .byte   $7F
        .byte   $04
        ldy     $05
        and     ($E1,x)
        eor     ($09,x)
        .byte   $7F
        cpx     $31
L5D8A:  .byte   $F9
        .byte   $9C
L5D8C:  .byte   $C7
        stx     $AB
        .byte   $1F
        .byte   $9B
        ldy     L767E
        and     (L00F9),y
        inc     $C7
        .byte   $E7
        .byte   $C3
        ora     L501F,x
        eor     $6A
        .byte   $C2
        .byte   $D7
        inc     $7E
        and     ($82,x)
        eor     ($E7,x)
        cpy     #$64
        asl     L08C1,x
        and     ($DD),y
        .byte   $7F
        sta     $E1E7
        lda     #$26
        ror     L1421,x
        .byte   $67
        .byte   $E2
        ora     #$66
        ror     $9822,x
        .byte   $67
        .byte   $E2
        cmp     ($A6),y
        ror     L1C2C,x
        .byte   $67
        .byte   $E3
        eor     ($E6,x)
        .byte   $7E
L5DCA:  jsr     L7121
        sed
        sta     ($C7),y
        .byte   $E2
        .byte   $87
        .byte   $1A
        .byte   $8B
        .byte   $5C
        ror     $F12F,x
        sed
        .byte   $CF
        .byte   $C7
        .byte   $E3
        .byte   $8F
        .byte   $1F
        stx     L7EFC
        .byte   $3F
        sbc     (L00F9),y
        .byte   $0B
        .byte   $C7
        cpx     $6F
        .byte   $1F
        .byte   $92
        .byte   $FC
        ror     L714F,x
        sbc     $C749,y
        sbc     $54
L5DF3:  clc
        .byte   $3A
        sta     $76
        ror     L5A1B,x
        .byte   $67
        inc     $9F
        inc     $FC98
        .byte   $C0
L5E01:  .byte   $83
        ora     $FF
        dec     $83
        .byte   $02
        .byte   $FF
        cpy     $0383
        .byte   $FF
        .byte   $D2
        .byte   $83
        .byte   $04
        .byte   $FF
        cld
        .byte   $83
        php
        .byte   $FF
        dec     $B363,x
L5E17:  .byte   $92
        .byte   $0C
        .byte   $07
        .byte   $FF
        lda     #$8F
        .byte   $CF
L5E1E:  rol     $3F
        rol     $E098,x
        .byte   $02
        sty     $4F
        cpy     #$96
        .byte   $3F
        .byte   $04
        cli
        .byte   $FC
        ora     L4D84,y
        .byte   $42
        sec
        .byte   $44
        .byte   $D4
        .byte   $2B
L5E34:  sty     $4D
        .byte   $43
        rol     $3F,x
        asl     $FCD8
        lsr     $1C,x
        jsr     LBF36
L5E41:  .byte   $D2
        sed
        .byte   $FC
        eor     $84,x
        cpy     $D845
L5E49:  jmp     L65A8

        .byte   $E3
        sbc     ($BF),y
        .byte   $8F
        .byte   $C7
        stx     L203C
        sec
        .byte   $FC
        stx     L3E84
        rts

L5E5A:  sty     $84,x
        asl     $FDD7,x
        .byte   $0C
        jsr     L3CFE
        .byte   $67
L5E64:  .byte   $C2
        sbc     L1F57,x
L5E68:  stx     $7C,y
        .byte   $7E
L5E6B:  lsr     $E1E7,x
        .byte   $EE
L5E6F:  lda     ($68,x)
        .byte   $FC
L5E72:  bne     L5E17
        .byte   $93
        ror     $CE8F
L5E78:  cli
        .byte   $FC
        bvc     L5E68
        .byte   $8F
        .byte   $C3
        .byte   $9F
        php
        .byte   $FC
        rol     $F7,x
        .byte   $A3
        .byte   $F0
L5E85:  .byte   $02
        cli
        lda     L11F8,y
        .byte   $C7
        cpx     #$8F
        .byte   $1F
        .byte   $83
        .byte   $5C
        ror     $F112,x
        sed
        adc     ($C7,x)
        sbc     ($DF,x)
        .byte   $1F
        dey
        ldy     L267E,x
        sbc     ($F8),y
        .byte   $AB
        .byte   $C7
        .byte   $E2
        .byte   $EF
L5EA3:  .byte   $1F
        sty     L7EFC
        sec
        sbc     ($F8),y
        .byte   $F7
        .byte   $C7
        cpx     $67
        .byte   $1F
        .byte   $92
        .byte   $BC
L5EB1:  ror     $F14F,x
        sbc     $C747,y
        sbc     $4C
        and     #$09
        cmp     $6C
        and     #$29
        lda     L1FE7
        txs
        .byte   $44
        .byte   $4F
L5EC5:  .byte   $C3
        ldy     $FCD4,x
        .byte   $FF
        .byte   $D3
        .byte   $63
        .byte   $F3
        adc     $CE8F
        sty     $E4,x
        .byte   $3B
        .byte   $F3
L5ED4:  .byte   $63
        beq     L5F25
L5ED7:  clc
        sta     $0B
        clc
        .byte   $FC
        and     $86,x
        and     L37FF
        .byte   $63
        sbc     ($50),y
        .byte   $B4
L5EE5:  ror     $D125,x
        sed
        lda     $47
        .byte   $E2
        cpy     $A1
        dey
        .byte   $3F
L5EF0:  .byte   $D7
        plp
        .byte   $FC
        .byte   $64
L5EF4:  .byte   $8F
        .byte   $C3
        .byte   $57
        asl     a
        rol     L241D,x
        sty     L8458
        bcc     L5EC5
        .byte   $C7
        bvs     L5F4F
        ror     L3147,x
        sbc     L0C31,y
        .byte   $97
        .byte   $14
        .byte   $0C
        ror     $B156,x
        sbc     $C764,y
        sbc     $EC
        and     ($47),y
        inc     L3124,x
        .byte   $4F
        inc     L3144,x
        .byte   $D2
        sta     $33,x
        and     ($BF,x)
        .byte   $CF
        sbc     $18,x
L5F25:  .byte   $FC
        dec     L3F86,x
        .byte   $FF
        .byte   $E2
        stx     $32
        .byte   $FF
        inc     $86
        .byte   $52
        .byte   $17
        .byte   $FF
        .byte   $54
        .byte   $32
        dec     L3FE6
        .byte   $3C
        cld
        .byte   $FC
        .byte   $F7
        .byte   $86
L5F3D:  .byte   $5C
        .byte   $43
        rol     $F5C2
        ror     $19,x
        ldx     $9981,y
L5F47:  .byte   $BF
        .byte   $27
        ora     $BABF,y
        sta     L39C0,y
L5F4F:  ora     $B4C0,y
        sta     L30C1,y
        sta     L81C1,y
        lda     $8B
        .byte   $2B
        .byte   $02
        sta     $A09A,y
        rol     $9983
        .byte   $19
L5F63:  ldx     $A995
        .byte   $85
L5F67:  brk
        .byte   $A5
L5F69:  sta     ($B0),y
        ora     ($02,x)
L5F6D:  .byte   $92
L5F6E:  sta     ($89,x)
        nop
        .byte   $FC
        lda     L3070,x
        ldy     #$C1
        .byte   $73
        .byte   $FC
        bit     L38A1
        brk
        adc     $38,x
        asl     $CE
        .byte   $63
        stx     $D163
        bvc     L5F3D
L5F87:  .byte   $3A
        cpx     L433C
        .byte   $23
        dec     $53
        sta     ($F2),y
        .byte   $34
        .byte   $2B
        .byte   $63
        .byte   $27
L5F94:  eor     ($69,x)
        adc     #$AC
        ror     $1E,x
        .byte   $F4
        dex
        .byte   $BB
        and     $9D
        txa
L5FA0:  tay
        cld
        sbc     ($C8,x)
        pla
        txs
        .byte   $19
L5FA7:  .byte   $63
        .byte   $87
        and     $87
        cpy     #$80
        .byte   $72
        php
        pha
        .byte   $5A
        .byte   $12
        ror     L69E2
        .byte   $5C
        .byte   $7A
        .byte   $06
L5FB8:  .byte   $47
        ldy     #$18
        .byte   $7A
L5FBC:  php
        .byte   $32
        .byte   $69
L5FBF:  and     $A215,x
        inc     $55,x
        ldy     $E0,x
        sbc     $9847,y
        .byte   $CD
        .byte   $C1
L5FCB:  inc     $0C
        bpl     L5F69
        sbc     ($47),y
L5FD1:  clv
        rts

        rol     a
        .byte   $6B
        cmp     $D1C5
        lsr     L8139
        stx     L5EF4
        inc     $EAD5
        inc     $C24D
        ror     $EE
        .byte   $02
        .byte   $5E
        .byte   $DC
L5FE9:  bmi     $6025
        lsr     L60EE,x
        .byte   $DC
        .byte   $9B
        cpy     $5E
        cmp     L8563
        .byte   $1A
        jmp     (LACAF)

        bvs     L5FA0
        .byte   $A3
        .byte   $6B
        asl     a
        .byte   $8F
        bvs     L5FCB
        lda     $ACE9,x
        .byte   $D2
        tya
        .byte   $DA
        eor     L09E5
        .byte   $0C
        .byte   $07
        .byte   $0C
        rol     $F1
        lda     ($2C,x)
        .byte   $A4
L6012:  .byte   $9B
        dex
        rol     $C292,x
        .byte   $E3
        .byte   $DC
        tya
        and     ($C2),y
        stx     L1A0C
        and     $DDC2,x
        .byte   $93
        bvs     L6030
        cmp     $DCA3,x
        pha
        and     L3411
        .byte   $DA
        .byte   $C7
        .byte   $2C
        php
L6030:  sta     $03B4
        php
        .byte   $8F
        .byte   $42
        ror     $AA
        nop
L6039:  jmp     LD38A

        .byte   $DC
        php
        .byte   $04
        rol     $038E
        dex
        rol     L2801,x
        .byte   $FA
        .byte   $4B
        ora     $A3,x
        ror     L1C67
        .byte   $B2
L604E:  ldx     $0A,y
        cmp     $EC
        .byte   $1C
        .byte   $E3
        beq     L5FE9
        .byte   $8F
        .byte   $C3
        rol     L0E3F,x
        clv
        .byte   $FC
        rol     $F1E3,x
        .byte   $1F
        .byte   $8F
        cmp     $0E
        .byte   $3F
        ora     $F8,x
        .byte   $FC
        .byte   $5F
L6069:  .byte   $E3
        sbc     ($9F),y
        .byte   $8F
        .byte   $C7
        rol     L213F,x
        clv
L6072:  .byte   $FC
        .byte   $93
        .byte   $E3
        .byte   $F2
L6076:  .byte   $73
        .byte   $8F
        dex
        .byte   $BE
        .byte   $3F
L607B:  and     $FCB8
        .byte   $D4
        adc     $1F
        txs
        .byte   $74
        ror     L516E,x
        .byte   $F9
        .byte   $CB
L6088:  .byte   $47
        .byte   $E7
        .byte   $9D
        .byte   $1F
L608C:  .byte   $9F
        .byte   $34
        ror     L517E,x
        sed
        .byte   $0B
        bit     L81CD
        .byte   $DC
L6097:  ror     $F10A,x
        sed
        .byte   $43
        .byte   $C7
        sbc     ($57,x)
        .byte   $1F
        stx     $7C
        ror     $F11D,x
        sed
        .byte   $83
        ora     $07B9,y
L60AA:  and     L24CB,y
        and     L3565
        cpy     L67BD
        .byte   $5F
        .byte   $E7
        .byte   $02
        .byte   $0D
        .byte   $47
L60B8:  ora     ($AD,x)
        adc     #$8D
        eor     L186A
        tya
        ror     L1A1C
        asl     $D8,x
        .byte   $5C
        jsr     L571A
        dey
        .byte   $9C
        .byte   $E3
        .byte   $52
L60CD:  ora     ($C7),y
        sta     L30D1,y
        sta     ($A1,x)
        and     $E7,x
        .byte   $89
        .byte   $9E
        php
L60D9:  jsr     LDF5E
        .byte   $9C
        sty     $44
        .byte   $DA
        dec     L1318,x
        .byte   $EB
        cpy     #$1C
        clc
        .byte   $23
        .byte   $C7
        asl     $00,x
        .byte   $12
        .byte   $53
        .byte   $30
L60EE:  bvs     L613F
        .byte   $13
L60F1:  sei
        plp
        .byte   $A3
        sta     L2423,x
        .byte   $7B
        .byte   $D4
        dec     $8DF7,x
        .byte   $80
        .byte   $02
        bit     $E7FB
        ora     #$D1
        .byte   $32
        sbc     $FB6C,y
        .byte   $0B
        .byte   $2F
        .byte   $97
        cpx     $33
        .byte   $4B
        .byte   $E3
        cpy     $44
        ldx     $CF63,y
        .byte   $22
        cmp     ($FE),y
        adc     L2CB1
        .byte   $83
        .byte   $57
        sbc     #$60
        ldx     $0C
        .byte   $89
        adc     ($15,x)
        sta     $0E,x
        .byte   $04
        .byte   $DB
L6126:  sbc     $80
L6128:  sbc     $EE
        .byte   $14
        sty     $D4,x
        .byte   $32
        asl     $A2
        ora     ($44,x)
        lsr     L3209
        sbc     L217A,y
        bvs     L6172
        lda     L68B7,x
        ora     #$9D
L613F:  .byte   $1D
L6140:  eor     #$A6
        .byte   $04
        .byte   $CB
        dec     $5D,x
        sbc     ($68,x)
        sta     ($E0),y
        .byte   $03
        .byte   $57
        sta     ($AD,x)
        .byte   $8B
        inc     L100E
        .byte   $9B
        lda     $9363,y
        ora     ($92),y
        bvs     L6162
        ror     a
        .byte   $77
        cmp     L797D,y
        .byte   $23
        .byte   $82
        .byte   $C7
L6162:  .byte   $BF
        sbc     #$36
        adc     L1C8E,x
        ldy     #$91
        tsx
        sta     ($6F,x)
        .byte   $87
        ora     L13AE
        .byte   $01
L6172:  rti

        .byte   $54
        .byte   $E3
        cpy     $07
        .byte   $61
L6178:  cpy     $64
        stx     $02,y
        asl     $F597,x
        lsr     $B507
        .byte   $E7
        jmp     (L8416)

        .byte   $62
L6187:  .byte   $83
        .byte   $17
        tay
        and     ($24,x)
        cmp     $51
        inc     $3A
        .byte   $62
        lda     $1C,x
        .byte   $CB
        rti

        ldx     $6B
        .byte   $6F
        pha
        .byte   $EB
        .byte   $4B
        adc     #$AF
        .byte   $52
        ror     $52
        .byte   $DA
        .byte   $E3
        .byte   $32
        and     ($66),y
        .byte   $C3
        .byte   $1F
        .byte   $9D
        .byte   $EC
L61A9:  ror     $B17E,x
        sed
L61AD:  .byte   $1B
        .byte   $1A
        bcs     L6212
        .byte   $8F
L61B2:  cmp     ($E6,x)
        .byte   $3F
L61B5:  asl     a
        cli
        .byte   $FC
        rol     $63,x
        .byte   $F0
L61BB:  sbc     $C58F
        brk
        ora     ($F8),y
        txa
        .byte   $47
        .byte   $E2
        eor     ($1F),y
        txa
        bit     $7E
        .byte   $2B
        ora     ($F8),y
L61CC:  tsx
        .byte   $47
        .byte   $E3
        eor     ($1F,x)
        .byte   $8F
        .byte   $64
        ror     L1146,x
        sbc     L4738,y
        sbc     $39
        .byte   $1F
        stx     $64,y
        ror     $915D,x
        sbc     L4798,y
        inc     $C9
        .byte   $1F
        sta     L7E04,x
        .byte   $7A
        dec     $8D
        ora     $F70C,y
        .byte   $DB
        .byte   $17
        .byte   $30
L61F3:  .byte   $FF
        stx     L8438
        asl     L483B,x
        bcc     L6278
        .byte   $3A
        .byte   $5A
        sta     ($F7,x)
L6200:  bcs     L625B
        .byte   $17
L6203:  asl     $A938,x
        ldx     L83BF
        inx
        .byte   $13
        lda     L801D,x
        sta     ($3B,x)
        dec     $A3
L6212:  .byte   $07
        ora     #$8E
        .byte   $33
        inx
        cmp     $A735
        sta     $938C,x
        .byte   $44
        .byte   $89
        .byte   $9C
L6220:  .byte   $33
L6221:  bne     L61BB
        .byte   $4B
        .byte   $3F
L6225:  ora     ($32,x)
        dec     $8FA7,x
L622A:  ldy     #$F2
        ror     a
        ldx     $B33E
        .byte   $32
        .byte   $AF
        .byte   $8F
        ldy     #$70
        dec     $52
        .byte   $62
        inc     L3CBE
        .byte   $3E
        .byte   $80
L623D:  .byte   $89
        .byte   $9B
        ora     ($35),y
        .byte   $7A
        .byte   $B2
        .byte   $04
        beq     L6262
        .byte   $F0
L6247:  asl     a
        txs
        dec     L4E95,x
        .byte   $AF
        and     ($E5),y
L624F:  .byte   $47
        ror     $B8
L6252:  .byte   $69
L6253:  .byte   $63
        eor     ($9C,x)
        lda     ($14,x)
        .byte   $6B
        .byte   $CE
        .byte   $CC
L625B:  rol     $EA9C
        cpx     L8373
        .byte   $26
L6262:  .byte   $0C
        .byte   $A3
        sbc     $64
        rol     $8D,x
        rts

        txs
        and     $AC,x
        .byte   $73
        .byte   $97
        sta     L6B81
        sta     ($9E),y
        dec     $02
        eor     #$98
        .byte   $EC
L6278:  lda     L2383,x
        cmp     $C792,y
        .byte   $7C
        rol     $EB,x
        .byte   $A3
        ror     $C7,x
        and     $A290,y
        ror     $F49A
        ora     $EE26
        .byte   $8F
        .byte   $A0
L628F:  jsr     L30A0
        cld
        cpx     $8F5D
        sta     ($00,x)
        and     ($38),y
        sed
        ldy     $12
L629D:  bpl     L6247
        ldx     #$AE
        ldx     #$6E
L62A3:  .byte   $AB
        .byte   $0C
L62A5:  asl     L13CB,x
        .byte   $E6
L62A9:  .byte   $AF
        ldy     #$FB
        .byte   $0F
        tay
L62AE:  bmi     L629D
        .byte   $A3
        .byte   $80
        .byte   $34
        asl     L3B36
        jmp     (L7DF3)

        .byte   $0C
        rol     L0B86,x
        .byte   $2F
        .byte   $6B
        .byte   $A7
        pha
        bpl     L62AE
        asl     L4AA0
        sec
        .byte   $0F
        .byte   $6D
        .byte   $BD
L62CA:  ldx     L1A9D
        .byte   $62
L62CE:  iny
        rol     $AA,x
        .byte   $0B
        and     $E812,x
        tya
        ora     L59B6
        and     $A0
        .byte   $9C
        asl     $3F,x
        .byte   $63
        eor     #$88
        clc
        bpl     L633E
        .byte   $D7
        .byte   $7C
        .byte   $8B
        .byte   $31
L62E8:  lda     ($06,x)
        .byte   $8F
        bpl     L6355
        .byte   $FA
        .byte   $9B
        lda     $1F
        ora     ($64,x)
        cmp     L7474
        dec     $4C
        .byte   $AB
        bit     $B93E
        sbc     L0C78
        cmp     #$BA
        plp
        sbc     $0C
        .byte   $8F
L6305:  .byte   $AB
        and     L745B,y
        eor     $AB79
        .byte   $B1
L630D:  .byte   $D6
L630E:  ldx     L3C3A
        dec     L3C2C,x
        inx
L6315:  .byte   $F4
        .byte   $B3
        .byte   $0B
        bvc     L6348
L631A:  and     $A9B8,x
        bcc     L636F
L631F:  bpl     L6315
        bpl     L62A5
        .byte   $62
        .byte   $7A
        .byte   $44
        cmp     #$7B
        .byte   $F2
        .byte   $1B
        and     ($77,x)
        .byte   $5C
        sbc     ($1E,x)
        .byte   $1B
        lda     $E77B,x
        sta     ($31,x)
        .byte   $5F
        stx     $04F3
        .byte   $CB
        .byte   $44
        dex
        .byte   $BE
        .byte   $3B
L633E:  .byte   $4F
        sbc     #$49
        .byte   $C3
        nop
        lda     L6CCF,x
        .byte   $E2
        .byte   $6D
L6348:  .byte   $D7
        .byte   $3C
        sbc     #$D3
        bne     L62E8
        cmp     ($BC,x)
        sbc     $D9
L6352:  stx     $78
        .byte   $D7
L6355:  rol     L73E6
        sty     $66
        .byte   $33
        .byte   $63
        .byte   $54
        .byte   $B2
        rol     L11E2
        ror     $A9
        plp
        eor     $E7AE,x
        eor     $F836
        bpl     L638F
        sta     $043D,x
L636F:  .byte   $89
L6370:  .byte   $B3
        sta     L7B75,x
        ora     L6C6F,y
        ldx     #$6C
        .byte   $64
        .byte   $FA
        ora     L4E33
        eor     ($A4),y
        sbc     L3385,y
        .byte   $1F
        .byte   $62
        ldy     $E0,x
        tya
        and     $A38F
        bcc     L6370
        .byte   $6F
        .byte   $D2
L638F:  rts

        stx     $33,y
        .byte   $42
L6393:  .byte   $97
        asl     a
        inc     $8E,x
L6397:  .byte   $D7
        sbc     $C7D3,y
        .byte   $1F
        bcc     L63DA
        ror     $F143,x
        sbc     $9F1B,y
        txa
        .byte   $12
        .byte   $7C
        ror     L674E,x
        sbc     ($AD,x)
        .byte   $17
        asl     L1C15,x
        .byte   $7C
        .byte   $57
        adc     (L00F9),y
        adc     #$C7
        sbc     $D7
        .byte   $1F
        txs
L63BA:  stx     $8F
        .byte   $C3
        .byte   $7C
        tay
        .byte   $FC
        .byte   $53
        bne     L6352
        cmp     $2D
        pla
        .byte   $FC
        .byte   $43
        .byte   $DC
        .byte   $A3
        .byte   $F3
        .byte   $92
        .byte   $3F
        .byte   $0C
        .byte   $FA
        tay
        .byte   $FC
        .byte   $FC
        .byte   $8F
        cmp     $F0
        lda     #$67
        .byte   $E7
        cpx     #$8F
L63DA:  .byte   $1F
L63DB:  .byte   $83
        .byte   $1C
        ror     L6713,x
        .byte   $E2
        and     ($66),y
        ror     L1A38,x
        sbc     ($F8),y
        .byte   $7F
        .byte   $C7
L63EA:  .byte   $E2
        lsr     L287E
        .byte   $27
        sbc     ($F8),y
L63F1:  lda     ($C7),y
        .byte   $E2
        .byte   $F7
        .byte   $1F
        sty     L7E9C
        and     $71,x
        sed
        sbc     $C7
        .byte   $E3
        dec     $7E,x
        rol     L67C0
        .byte   $E3
        jmp     (L1F47)

        sta     ($DC),y
        ror     L674A,x
        .byte   $E3
        .byte   $7C
        .byte   $D7
        .byte   $1F
        .byte   $94
L6412:  ora     $6DF8,y
L6415:  eor     ($C7),y
        sbc     $97
        .byte   $1F
        .byte   $97
        .byte   $5C
        ror     L0A6A,x
        .byte   $8F
        .byte   $CC
L6421:  txa
        .byte   $3F
        .byte   $34
        tay
L6425:  .byte   $FC
        .byte   $DA
        .byte   $A3
        .byte   $F3
        txa
        .byte   $8F
        dec     L3F8A
        .byte   $3C
        .byte   $23
        beq     L6421
        .byte   $DA
        .byte   $8F
        .byte   $CF
        sed
        .byte   $FC
        sec
        .byte   $02
        sty     $87,x
        sbc     L5490,y
        ror     L881C,x
        eor     ($F8),y
        .byte   $33
        .byte   $1F
        .byte   $89
        cpy     $31
        sed
        txs
        .byte   $4F
        .byte   $1F
L644C:  sta     $B1C5
        sed
        .byte   $9E
        .byte   $67
        .byte   $47
        sbc     ($E4,x)
        ror     L201E,x
L6458:  cmp     ($F8),y
        lda     ($47,x)
L645C:  .byte   $E2
        sbc     $1F
        sty     $F811
        .byte   $80
        .byte   $CD
L6464:  .byte   $47
        .byte   $E3
        .byte   $74
        ror     $BD39,x
        .byte   $47
        .byte   $E2
        .byte   $0B
        sbc     $1E,x
        .byte   $92
        ora     #$0F
        .byte   $C6
L6473:  .byte   $89
        .byte   $42
        .byte   $3F
        .byte   $27
        .byte   $43
        sbc     ($C6),y
        sty     L163F
        tax
        pha
        .byte   $FC
        lda     ($0F),y
        .byte   $C7
        .byte   $2B
        .byte   $52
        sec
        rol     $FCC8
        .byte   $C3
        .byte   $0F
        cpy     $2C
        .byte   $72
        .byte   $3F
        rol     $48,x
        .byte   $FC
        .byte   $DE
L6493:  .byte   $0F
        cmp     $1E
        .byte   $22
        .byte   $3F
        .byte   $3A
        .byte   $83
        sbc     ($17),y
        clv
        .byte   $3F
        .byte   $1A
        sbc     $F103,x
        .byte   $93
        .byte   $F2
        rti

        rts

        bcs     L644C
        ror     $04,x
        sbc     ($F8),y
        ora     $E0C7,x
        .byte   $A7
        .byte   $1F
        .byte   $83
        .byte   $B2
        .byte   $3B
        .byte   $4F
        .byte   $3D
L64B6:  .byte   $4B
        .byte   $02
        .byte   $D2
        .byte   $FB
        .byte   $14
        .byte   $13
        eor     ($12,x)
        eor     #$81
        .byte   $F9
        .byte   $1E
L64C2:  .byte   $34
        sty     $C7,x
        .byte   $E3
        .byte   $2B
        ldy     #$79
        php
        eor     #$30
        .byte   $43
        asl     $EBAD,x
        rti

        jsr     LF8E9
        asl     a
        clv
        .byte   $92
        .byte   $92
        eor     $C730,y
        cpx     $F4
        bcc     L6526
        sbc     L7C2A,x
        .byte   $1B
        .byte   $54
        lda     ($E9),y
        .byte   $5A
        .byte   $9F
        .byte   $87
        inc     $92,x
        .byte   $44
        .byte   $1F
        .byte   $F7
        ora     #$F0
        lda     $5B
        dec     $3C
        bmi     L651A
        stx     $81,y
        jmp     (LD4ED)

        .byte   $14
        .byte   $02
        asl     $A9,x
        .byte   $C2
        sbc     $C3,x
        lsr     a
        sed
        ldx     L1D27
        ldy     $73,x
        sei
        cld
        .byte   $73
L650C:  brk
        dey
        cli
        .byte   $47
        .byte   $96
L6511:  .byte   $52
        ldx     L47A7,y
        .byte   $C2
        eor     $018E
        .byte   $64
L651A:  dec     $24
        .byte   $CB
        lda     $E8
        ldy     $BA,x
        sbc     $51
        cpx     L4397
L6526:  eor     $BC7B,x
        .byte   $DB
        ror     $EE58,x
        .byte   $7F
        .byte   $1C
        clc
        adc     $EE
        .byte   $34
        dec     L7C3D,x
        .byte   $47
        .byte   $51
L6538:  .byte   $E7
        adc     #$F9
        .byte   $27
        .byte   $57
L653D:  eor     $E5
        bmi     L6576
        .byte   $9E
        adc     ($FE,x)
        php
        .byte   $E7
        .byte   $C7
        .byte   $D2
        .byte   $DF
        .byte   $1F
        eor     L7B33,y
        .byte   $7F
        .byte   $83
        ldx     $E401
        dec     $07,x
        lda     ($F8),y
        .byte   $2F
        rol     $4B
        inc     $C732,x
        sbc     ($2A,x)
        ror     $D02B,x
        ldx     $4C,y
        .byte   $DF
        .byte   $5F
        inc     $3C
        .byte   $7A
        .byte   $1A
        .byte   $C9
L656A:  sbc     $19
        .byte   $CF
        .byte   $1F
        php
        .byte   $D2
        .byte   $64
        .byte   $7A
        .byte   $3F
        lsr     a
        .byte   $93
        .byte   $11
L6576:  .byte   $57
        .byte   $FA
        .byte   $74
        txs
        .byte   $0F
        .byte   $FA
        bcc     L65E8
L657E:  .byte   $0B
        sbc     L4C5A,x
        .byte   $AF
        .byte   $5F
        .byte   $EB
        .byte   $52
        .byte   $67
        ror     a
        .byte   $6B
        .byte   $D2
        ror     $0A
L658C:  jmp     (LE059)

        .byte   $92
        .byte   $DB
        dec     $03
        sty     $D19E
        rti

        sta     $A40F,y
        jmp     (L454E)

        .byte   $3F
        eor     $EA30
        .byte   $1F
        .byte   $DB
        .byte   $EB
        .byte   $5F
        .byte   $E1
L65A6:  pla
        .byte   $80
L65A8:  .byte   $22
        jsr     L4422
        cmp     #$19
        inc     $96
        .byte   $19
        .byte   $D3
L65B2:  .byte   $22
L65B3:  ror     L78B0
        ora     ($32,x)
        cpx     $EBB7
        adc     $ED93,x
        .byte   $E3
        .byte   $74
        cmp     $0F
        .byte   $64
        .byte   $C2
        ldx     L77F9
        .byte   $FA
        sbc     L4A2F,y
        inx
        .byte   $BF
        .byte   $92
        plp
        php
        bvs     L656A
        .byte   $23
        .byte   $3C
        .byte   $FC
        and     L124C,x
        stx     L51C8
        .byte   $8B
        cmp     ($C9),y
        sta     ($7C),y
        sty     $E17D
        and     $1B
        clv
        .byte   $23
        .byte   $26
L65E8:  cmp     L33DF
        .byte   $22
        .byte   $97
        dec     $12
        ldy     $CFBC
        bmi     L65A8
        bvs     L65B2
        clv
        eor     #$F4
        .byte   $06
L65FA:  .byte   $D2
        .byte   $13
        ora     #$59
        bit     L657E
        lda     ($D1,x)
        inc     L1F9B,x
        .byte   $1B
        .byte   $32
        .byte   $6C
L6609:  dec     $F3
        .byte   $04
        .byte   $DC
        cpy     L750D
        .byte   $30
L6611:  and     $E0,x
        .byte   $C7
        .byte   $E7
        .byte   $B2
        .byte   $72
        .byte   $7F
        sbc     $F831,x
        ora     $28,x
        lsr     a
        .byte   $8E
L661F:  .byte   $D2
        sty     $6A
L6622:  .byte   $CB
        .byte   $12
        .byte   $CF
        cmp     L8B7F
        lsr     a
        .byte   $63
        dey
        cpx     $C2A6
        rol     L0B3F,x
        .byte   $B3
        sbc     ($24),y
        .byte   $F3
        .byte   $8F
        sty     $0E
        .byte   $3F
        .byte   $12
        sbc     $0A
        adc     $7E,x
        .byte   $A3
        .byte   $47
        .byte   $E2
        cmp     L8B1F
L6644:  .byte   $F4
        sei
        and     ($D1),y
        sed
        .byte   $D7
        and     #$4A
        .byte   $42
        .byte   $F4
        .byte   $3A
        rts

        .byte   $E2
L6651:  ora     $49,x
        .byte   $90
L6654:  .byte   $FF
L6655:  sbc     #$38
        .byte   $03
        bvc     L661F
        plp
        .byte   $44
        .byte   $43
        lda     ($10,x)
        dec     LEA3E
        inx
        .byte   $03
        .byte   $1C
        ora     ($0C,x)
        asl     a
        .byte   $AF
        ora     #$A4
        .byte   $DC
        cli
        cpx     $B1FF
        .byte   $C7
        .byte   $22
        php
        .byte   $7F
        .byte   $E3
        .byte   $64
        .byte   $72
        .byte   $C7
        txa
        .byte   $1A
        txs
        txa
        .byte   $12
        .byte   $03
        asl     $A9,x
        ora     L857C,x
        bit     L349E
        eor     ($CE),y
        cmp     ($88),y
L668A:  .byte   $7F
        .byte   $CC
L668C:  ora     ($DA),y
        .byte   $A3
        .byte   $72
        ora     L2899
        cpx     #$26
        .byte   $32
        .byte   $9C
        jmp     (L2F51)

        lda     $E747,y
        ora     $1F,x
        sta     L7E54,x
        .byte   $7A
        eor     ($F8),y
        ora     #$2D
        eor     $9C81,x
        ror     $F108,x
        sed
        and     $E0C7
        .byte   $E7
        .byte   $1F
        sty     $7C
        ror     $CA14,x
        sbc     L7512
        .byte   $7F
        .byte   $72
        .byte   $F2
        sbc     ($A6,x)
        .byte   $A7
        .byte   $D9
L66C2:  .byte   $BB
        tax
        .byte   $13
        stx     $99
        lsr     a
        tya
        and     #$35
        cmp     ($B6),y
        sbc     L871F
        .byte   $EF
        .byte   $34
        .byte   $7C
        rol     $A7D1,x
        .byte   $63
        and     #$99
        sty     $3C,x
        bpl     L66DE
        .byte   $93
L66DE:  .byte   $53
        rol     a
        .byte   $9B
        .byte   $14
        ror     a
        lda     #$4E
        and     $AD
        .byte   $C7
        .byte   $0C
L66E9:  .byte   $F7
        .byte   $1F
        .byte   $95
L66EC:  ora     L8B6E,x
        rts

        sbc     #$31
        .byte   $EF
        .byte   $07
        .byte   $C7
        cld
L66F6:  eor     $A1C2,y
        .byte   $7F
        sec
        iny
        plp
        .byte   $67
        .byte   $7F
        pla
        .byte   $F7
        .byte   $1F
        and     #$B4
        .byte   $FE
L6705:  .byte   $7C
        dec     $49
        .byte   $B2
        ora     ($88,x)
        eor     ($48,x)
        .byte   $DC
        ldx     #$69
        .byte   $B2
        .byte   $3E
        .byte   $1E
L6713:  ora     L72D4,x
        ror     a
        .byte   $3F
        adc     $8D,x
        eor     L34E2
        inc     $7F,x
        bit     $EE
        rol     $AB78
        .byte   $D4
        eor     $1F
        txs
        .byte   $74
        ror     L516D,x
        sbc     L47D5,y
        .byte   $E7
        sta     $1F
        .byte   $9E
        ldy     $7E,x
        adc     L2751,x
        .byte   $5B
        tay
        .byte   $1A
        jmp     (L2E2F)

        .byte   $C3
        .byte   $32
        ror     $11
        .byte   $FE
        .byte   $DD
L6744:  lda     $34C1
        .byte   $B6
L6748:  .byte   $C3
        .byte   $49
L674A:  .byte   $6D
        .byte   $A1
L674C:  and     $D2,x
L674E:  cli
        ror     $E1,x
        .byte   $07
        .byte   $8F
        .byte   $54
        cpx     #$11
        .byte   $82
        eor     ($A1),y
        and     L67C2,x
L675C:  lsr     $E360,x
        .byte   $BB
        sta     $99
        adc     L67EE
        .byte   $1F
        .byte   $42
        .byte   $9E
        asl     $C029,x
        ora     ($6B,x)
        sta     L3A74,y
        brk
        plp
        tay
        .byte   $27
L6774:  .byte   $DB
        .byte   $94
L6776:  tay
L6777:  .byte   $17
        .byte   $C7
        cmp     ($4A),y
        lda     ($46,x)
        adc     L102A,x
        ror     L381D
L6783:  .byte   $A7
        .byte   $7A
        .byte   $E3
        .byte   $F2
        .byte   $07
        .byte   $8F
        iny
        ror     L233F,x
        .byte   $7A
        .byte   $B3
        .byte   $03
        .byte   $54
        sec
        lsr     L6305
        php
        .byte   $0C
        rol     $53
        .byte   $63
        asl     a
        bpl     L67C3
        dec     $DB,x
        clc
        rts

        adc     $CB32,y
        clc
        pla
        adc     #$32
        .byte   $A3
        asl     L22DE,x
L67AC:  adc     $A6
        bmi     L67AC
        inc     $55,x
        .byte   $63
        bpl     L6783
        adc     $B6,x
        .byte   $3C
        eor     L5726,y
        .byte   $63
        .byte   $12
L67BD:  .byte   $0B
        rol     $56
L67C0:  .byte   $63
        .byte   $13
L67C2:  .byte   $CD
L67C3:  cmp     $86,x
        and     ($50),y
        .byte   $92
        ror     $71
        sta     $B93F
        .byte   $3A
L67CE:  .byte   $53
        and     ($67),y
        dex
        cmp     $9B
        .byte   $C3
        .byte   $CB
        cmp     $92
        .byte   $67
        sta     ($24),y
        ror     $42
        .byte   $02
L67DE:  ldy     $B1
        .byte   $80
        cpx     L1590
        rol     $D1
        .byte   $7F
L67E7:  stx     $B1
        sbc     $47,x
        .byte   $FF
        .byte   $9B
        .byte   $90
L67EE:  eor     $B840
        .byte   $F3
        .byte   $63
        .byte   $4F
        .byte   $ED
        .byte   $8F
L67F6:  cpy     #$B9
        adc     $82,x
        .byte   $32
        .byte   $EB
        .byte   $43
        .byte   $B2
        jmp     (L55A5)

        adc     $25
        sty     $98FF
        dec     $85
        and     ($F6),y
        cmp     L2838,y
        .byte   $A3
        tya
        .byte   $C2
        .byte   $8E
        ror     a
L6812:  .byte   $B2
        .byte   $64
        .byte   $BF
        inc     $EDD5,x
        .byte   $0F
L6819:  sed
        ror     $4A
        rts

        tsx
        beq     L67F6
        clc
        .byte   $A7
        .byte   $7A
        sbc     ($58,x)
        .byte   $5C
        adc     L71A4
        sed
        .byte   $9D
        .byte   $C7
L682C:  .byte   $E2
        .byte   $9F
        .byte   $1A
        ror     $BB46,x
        .byte   $87
        asl     $C03C,x
        .byte   $47
        ldy     $B678,x
        .byte   $9B
        ldy     $04E1,x
        and     $84,x
L6840:  .byte   $04
        lda     L5B98,x
        .byte   $8F
        bcc     L6876
        .byte   $2F
        bcc     L6888
L684A:  ldx     L6253,y
        adc     $FE,x
        asl     L08C2,x
        ror     $C5
        .byte   $04
        stx     $C5C2
        ldy     L22D6
        pla
        .byte   $63
        bmi     L68CE
        cli
        .byte   $42
        sbc     ($9B),y
        .byte   $5B
        asl     $0643,x
        .byte   $62
        adc     L7A68
        cmp     $2B
        .byte   $E7
        .byte   $13
        bcc     L68CD
        ror     L6744,x
L6874:  .byte   $E2
        .byte   $AC
L6876:  lsr     $7E,x
        .byte   $2B
        pha
        .byte   $E7
        .byte   $E2
        ldy     L1EC7,x
        .byte   $13
        .byte   $F2
        inc     $BA
        .byte   $7F
        ldx     #$97
        ror     $BC
L6888:  .byte   $93
        sbc     ($49),y
        .byte   $37
        .byte   $12
L688D:  sbc     $3F
        .byte   $F7
        sty     L6076
        and     (L00F9),y
        sty     $E9D3
        .byte   $53
        sty     L4185
        .byte   $2B
        .byte   $27
        .byte   $E2
        .byte   $AB
        .byte   $BB
        cmp     $C271,x
        .byte   $0B
        and     ($99),y
        lda     ($39,x)
        sed
        .byte   $92
        .byte   $1B
        and     ($B0),y
        lsr     $63
        .byte   $93
        and     $B4
        txs
        plp
L68B5:  rts

        .byte   $74
L68B7:  .byte   $9B
        .byte   $5A
        .byte   $23
        ora     L17F2,x
        .byte   $13
        eor     $F8
        sbc     ($43),y
        .byte   $6C
        rol     a
L68C4:  .byte   $E3
        dey
        .byte   $DF
        stx     L752E
        adc     $61
        .byte   $C7
L68CD:  rti

L68CE:  bcs     L6933
        jmp     L264E

        .byte   $87
        .byte   $2F
        ror     $A5E0
        .byte   $9B
        sty     $73
        .byte   $1C
        bit     $BCE3
        .byte   $3B
        rol     $F4B8,x
        .byte   $26
L68E4:  dey
        cpy     L0C2E
        .byte   $73
        .byte   $A3
        inc     L302F
        ror     $EB
        pha
        and     $DCB4
        .byte   $3F
        .byte   $5F
        sty     $D1
        sta     $81
        sbc     L80EF,y
        .byte   $FB
        sty     $8E
L68FF:  and     #$D6
        sei
        .byte   $FC
        adc     ($E3),y
        .byte   $F2
        .byte   $1F
        .byte   $89
        inc     L6874,x
        .byte   $9D
L690C:  beq     $689A
        .byte   $0B
        rts

        .byte   $CB
        .byte   $82
        inc     $04,x
        cld
        .byte   $1C
        .byte   $57
        sbc     ($3C),y
        sed
        sta     L1E4B
        .byte   $DC
        .byte   $54
        sbc     ($B1),y
        adc     $C7
        inc     $A0
        pla
        .byte   $D4
        lda     ($CC),y
        .byte   $5C
        php
        tya
        .byte   $9B
        inc     L803E,x
        cmp     #$AC
        .byte   $76
L6933:  txs
        lda     $82
        .byte   $8F
        rti

        .byte   $72
        .byte   $62
        txa
        rol     $E0A2,x
        ldx     $8E
        .byte   $E0
L6941:  .byte   $BB
        ora     $C3,x
        lsr     $8C,x
        sbc     L3FEA,x
        .byte   $3A
        tay
        .byte   $FC
        beq     L68E4
        .byte   $C7
        dey
        .byte   $C2
        .byte   $04
        ldx     #$04
        ldy     $2E
        brk
        dec     $08,x
        lda     ($CE,x)
        ldy     #$6A
        eor     (L00F9,x)
        inc     $C711
        clv
        .byte   $02
        stx     $D1,y
        ldy     L7FA0
        ldx     $EC,y
        .byte   $42
        .byte   $67
        lda     $03,x
        and     $C892,x
        .byte   $F7
        asl     $93
        .byte   $3B
        asl     $EF38
        .byte   $F7
        inc     $4A
        and     $29
        sbc     L4502
        .byte   $E3
        lda     #$36
        .byte   $67
L6985:  ror     $07,x
        bpl     L690C
        sta     L8410,y
        rol     $76,x
        sbc     $EE
        .byte   $17
        sei
        inx
        adc     $E3
        ldy     #$36
        ora     L301A,x
        .byte   $22
        sec
        .byte   $82
        .byte   $47
        cli
        .byte   $72
        .byte   $5A
        sbc     L7492,x
        .byte   $93
        ror     L3794
        sta     $80,x
        sta     $AB,x
        sta     $04,x
        stx     $37,y
        stx     $46,y
        stx     $53,y
        stx     $5D,y
        stx     $63,y
        stx     $65,y
        stx     $67,y
        stx     $6C,y
        stx     $72,y
        stx     $90,y
        stx     $D7,y
        jmp     LB4B0

L69C7:  lda     $BAC4,y
        cpx     L7CBB
        .byte   $BB
        ldy     $BE,x
        .byte   $92
        adc     $C5
        rol     $0F
        ldx     $25
        inc     $31
        inc     $3F
        rol     $03
        ldx     $4B
        ldx     $4E
        .byte   $E6
L69E2:  eor     $A3,x
        .byte   $32
        .byte   $B7
        .byte   $32
        .byte   $D3
        .byte   $32
        ora     $52
        ora     #$1B
        bpl     L69F3
        cpy     #$D5
        .byte   $A7
        .byte   $CC
L69F3:  .byte   $DF
        .byte   $B3
        asl     $CFA2,x
        txs
        sta     $3F,x
        dec     $86
        inc     $EE27
L6A00:  cpx     $0668
        sbc     $48
        .byte   $44
        pla
        .byte   $72
        .byte   $7A
        .byte   $87
        .byte   $27
        tay
L6A0C:  .byte   $7A
        adc     $EE07,x
        cmp     ($00),y
L6A12:  .byte   $47
        ora     ($EE,x)
        .byte   $27
        .byte   $EE
L6A17:  .byte   $EC
L6A18:  bvs     $69E0
        ldx     $54
L6A1C:  bvs     L6A30
        adc     ($83),y
L6A20:  clv
        sbc     $DD29,x
        and     L2D67
        adc     $2D,x
L6A29:  .byte   $6F
        and     L887A
        and     L34AB,y
L6A30:  .byte   $04
        ora     $CD
        .byte   $5A
        cmp     ($45,x)
        inc     L35F1,x
        bcs     L6A61
        brk
        .byte   $2F
        .byte   $DD
L6A3E:  brk
        and     $36,x
        brk
        rti

        .byte   $47
        .byte   $0B
        pla
        bpl     L6A99
        inc     L2A90,x
        .byte   $42
        .byte   $3F
L6A4D:  eor     $63
        sbc     $6F,x
        sbc     L3B62,x
        .byte   $64
        cmp     ($44,x)
        .byte   $0B
        .byte   $7A
L6A59:  .byte   $1F
        .byte   $FB
        tsx
        .byte   $07
        brk
        .byte   $9C
        .byte   $19
        .byte   $5A
L6A61:  asl     L60AA,x
        .byte   $C3
L6A65:  .byte   $C2
        .byte   $CD
        sec
L6A68:  bmi     L6A0C
L6A6A:  bmi     L6A0C
        sbc     L8618,x
        .byte   $C3
        sty     $C4
        .byte   $A0
L6A73:  .byte   $1F
        lda     $0314,y
        bcs     L6A7B
        lda     ($C3),y
L6A7B:  .byte   $42
        eor     #$94
        .byte   $F7
        dey
        bpl     L6A73
        eor     $04,x
        .byte   $37
        .byte   $B3
        .byte   $7F
        .byte   $23
        .byte   $FF
        and     $79
        dex
        .byte   $47
L6A8D:  iny
        .byte   $3B
        cmp     #$43
        iny
        .byte   $CF
        cmp     $C75F
        .byte   $2B
        .byte   $C7
        .byte   $B7
L6A99:  cld
        .byte   $FB
        cpy     $BF
        dec     L243A
        .byte   $CB
        sbc     #$DB
L6AA3:  .byte   $EB
        .byte   $52
        ora     ($50,x)
        dey
        brk
        .byte   $13
        .byte   $20
        brk
L6AAC:  eor     #$FA
        .byte   $07
        sta     ($A1),y
        sbc     #$44
        adc     $0740,y
        ora     L0965
        .byte   $67
        eor     ($52),y
        .byte   $07
L6ABD:  .byte   $0B
        sta     $CD
        sta     $63
        .byte   $83
        eor     $52,x
        lda     $59
        .byte   $1C
        ora     L1D1C,x
        brk
        .byte   $F2
        .byte   $A7
        .byte   $0F
        bcc     L6A59
        ldy     L00F9
        eor     $8F9E
        asl     L8A49
        tax
        .byte   $4C
        .byte   $21
L6ADC:  .byte   $82
        .byte   $02
        .byte   $DF
        inc     $07
L6AE1:  ldy     #$9F
        .byte   $FF
        cpy     #$0F
        sbc     $C0,x
        brk
        .byte   $42
        ora     $77
        .byte   $F3
        .byte   $C2
        sed
        rol     a
        brk
L6AF1:  .byte   $DF
        dec     $F9E3,x
        .byte   $F4
        ora     $CF
        php
        lda     ($28,x)
        clc
        and     ($2E,x)
        .byte   $DA
        and     $07,x
        brk
        and     $04,x
        asl     $15
        .byte   $02
        .byte   $04
        ora     $DA,x
        txa
        .byte   $82
L6B0C:  brk
        adc     L6A8D
        .byte   $80
        .byte   $57
        .byte   $80
L6B13:  .byte   $04
L6B14:  .byte   $C3
        .byte   $F3
        cmp     ($D4),y
        rol     L4A06,x
        rts

        asl     $19
        .byte   $9E
        sbc     ($ED),y
        cpx     #$65
L6B23:  cpx     #$C0
        ldy     #$54
        .byte   $C2
        .byte   $0B
        bpl     L6B65
        lda     $7B,x
        brk
        asl     $D7
        eor     ($06,x)
        inx
L6B33:  cli
        asl     $D0
        eor     ($06),y
L6B38:  iny
        pla
        brk
        ora     L62A3,y
        bmi     L6B23
        .byte   $34
        ora     $04
        brk
        lsr     $CB
        .byte   $34
        iny
        .byte   $13
        sbc     L266E,x
        bcc     L6B13
        lsr     $A6
        ldy     #$0B
        and     ($87),y
        asl     $D480,x
        eor     $A2
        .byte   $E2
        .byte   $C7
        inx
        plp
        tya
        eor     L41B0,y
        .byte   $04
        ror     L4AA7,x
L6B65:  cld
        rts

        .byte   $82
        bvc     L6B7B
        bit     $D0
        ldx     $BA2A
        ora     ($57,x)
        bne     L6B75
        .byte   $BC
        .byte   $7D
L6B75:  .byte   $07
        txa
        stx     L8657
        .byte   $C9
L6B7B:  tay
        cmp     $C91D,x
        .byte   $82
        .byte   $A3
L6B81:  .byte   $34
        .byte   $67
        php
        asl     a
        .byte   $8B
        .byte   $C3
        pha
        adc     $E11E
        .byte   $C0
L6B8C:  stx     $91C9
        dex
        asl     $09,x
        txa
        sty     L2B6A
        .byte   $47
        dey
        .byte   $5C
        .byte   $7A
        .byte   $0B
        .byte   $C7
        lda     ($41,x)
        lda     L825B
        ldx     $0A,y
        lda     #$36
        sta     ($18),y
        ldx     L7101
        cpx     L141A
        .byte   $22
        .byte   $04
        asl     $0D
        nop
        jmp     L6B38

        rol     $81,x
        .byte   $80
        rti

        tax
        .byte   $F4
        .byte   $7B
        .byte   $04
        .byte   $35
L6BBE:  ora     $8F
        bcc     L6BF2
        .byte   $1B
        ora     $CB38
        lda     #$36
        lda     $FB08
        lsr     $82,x
        .byte   $92
        cpy     #$4E
        stx     L00F9
        eor     ($96,x)
        .byte   $1A
        tya
        .byte   $47
        .byte   $9C
        .byte   $A7
        cpy     $E2
        .byte   $9C
        .byte   $A3
        sty     $A0,x
        jmp     (L6655)

        .byte   $87
        adc     ($9F),y
        lsr     $20,x
        tya
        .byte   $FA
        ora     #$D5
        asl     $19,x
        .byte   $A3
        bne     L6C44
        .byte   $6E
        .byte   $8C
L6BF2:  lda     ($9D,x)
        eor     ($BA),y
        tsx
        jsr     L0060
        .byte   $DA
        eor     $060A,y
        cpy     $A2C2
        dex
        brk
        .byte   $62
        dec     $07
        ror     $C6,x
        clc
        adc     L822C
        eor     ($01),y
        .byte   $6C
        .byte   $F2
L6C10:  .byte   $53
        .byte   $9F
        .byte   $07
        ora     $11
        .byte   $76
L6C16:  dec     $F939
        sta     ($BC),y
        inc     $18F8
        .byte   $3F
        sta     $26,x
        .byte   $74
        .byte   $CF
        adc     ($10,x)
        .byte   $1A
        lda     $DF
        ror     $9B15
        .byte   $C4
L6C2C:  asl     a
        lsr     $01,x
        txa
        ora     ($18),y
        .byte   $07
        inc     $1F,x
        eor     $11
        .byte   $FA
        asl     $EB1F,x
        .byte   $1F
        lda     ($56),y
L6C3E:  eor     $CA,x
        .byte   $9C
L6C41:  brk
        .byte   $4B
        .byte   $15
L6C44:  bvc     L6C16
        asl     L1D0B
        .byte   $1C
        tax
        inc     $34
L6C4D:  .byte   $77
        .byte   $62
        lda     $95
L6C51:  .byte   $47
        cmp     ($00),y
L6C54:  tay
        .byte   $7D
        .byte   $12
L6C57:  .byte   $64
        .byte   $1A
        .byte   $B1
L6C5A:  adc     $A447
        .byte   $1B
        .byte   $80
        eor     #$19
        .byte   $6C
L6C62:  and     $B8
        .byte   $7A
        .byte   $3B
        sta     $01
        txa
        .byte   $82
        .byte   $80
        .byte   $FA
        .byte   $9B
        .byte   $8F
        .byte   $27
L6C6F:  and     ($C6,x)
        tax
L6C72:  .byte   $97
        cpy     #$53
        bcc     L6C5A
        stx     $30,y
        php
        inc     $1C
L6C7C:  .byte   $1C
        jsr     L1718
        eor     $58,x
        brk
        ora     L20F0,y
        .byte   $0C
L6C87:  .byte   $0F
        .byte   $AC
L6C89:  .byte   $54
        .byte   $D3
        .byte   $4C
L6C8C:  sed
        .byte   $1A
        .byte   $CF
        ora     #$6C
        .byte   $D4
        dec     $BC
        .byte   $97
L6C95:  .byte   $CF
        .byte   $C7
        sty     L36FC
        bmi     L6CAC
        cpy     #$D0
        sta     ($3E,x)
        .byte   $4F
        inc     $B599,x
        txa
        .byte   $F6
L6CA6:  lsr     L0F0A,x
        .byte   $8F
        .byte   $19
        .byte   $1A
L6CAC:  .byte   $4B
        sta     ($BE),y
        .byte   $4B
        bvc     L6CCA
        ldy     $09,x
        bpl     L6D24
        ror     $68,x
        ora     #$61
        .byte   $D7
        .byte   $DA
        .byte   $03
        bmi     L6CD8
        bcs     L6CE7
        .byte   $9F
        .byte   $D4
        .byte   $CD
        .byte   $06
L6CC5:  adc     L54CA
        dec     $EF,x
L6CCA:  rol     a
        ror     a
        .byte   $12
        bcc     L6C87
L6CCF:  adc     $A027,x
        bit     $E2
        lda     ($E2,x)
        bmi     L6CF4
L6CD8:  lsr     $6C,x
        .byte   $52
        sbc     $CD02
        dey
        .byte   $7A
        .byte   $07
        sbc     $34,x
        bpl     L6C95
        .byte   $74
        php
L6CE7:  stx     L1F83
        eor     $9A77,y
        .byte   $C3
        .byte   $12
        jsr     L4340
        .byte   $20
        .byte   $1C
L6CF4:  .byte   $67
        .byte   $E2
        .byte   $67
        .byte   $1F
        .byte   $0C
        .byte   $67
        adc     L11F9,y
        .byte   $C7
        ldy     $DF
        asl     L5C96,x
        ror     L136B,x
        .byte   $8F
L6D07:  .byte   $CD
L6D08:  jmp     (L4024)

        .byte   $03
        rti

        jsr     L146A
L6D10:  dey
        .byte   $E2
        cmp     #$2B
        ora     $08,x
L6D16:  .byte   $D2
        cmp     ($2B,x)
        eor     $34,x
        dex
        .byte   $C1
L6D1D:  plp
        asl     a
        .byte   $1B
        dec     L428D
        .byte   $83
L6D24:  .byte   $E3
        inc     $24,x
        ldx     $C9
        tay
        .byte   $64
        adc     L8405,x
L6D2E:  eor     $08
        ora     ($28),y
        sec
        and     ($AC),y
        .byte   $7C
        .byte   $92
        .byte   $83
        .byte   $02
        .byte   $47
        cld
        and     #$A8
        and     $8A,x
        .byte   $9D
L6D40:  and     $87,x
        clc
        .byte   $EB
        .byte   $87
        pla
        .byte   $DF
        ora     L688D
        .byte   $FA
        .byte   $02
        ora     ($A3,x)
        ldy     L1494
        .byte   $3A
        .byte   $37
        .byte   $23
        .byte   $D0
L6D55:  .byte   $04
        bit     $56
        bvc     L6D2E
L6D5A:  .byte   $13
        lda     #$C7
        .byte   $5C
L6D5E:  .byte   $6B
        lsr     $15
        rol     $1C
        .byte   $74
        .byte   $02
        eor     $E9,x
        clc
        inc     $A1
        lda     ($94),y
        clc
        .byte   $19
        tax
L6D6F:  sec
        .byte   $13
        ora     L77F4,x
        .byte   $02
        nop
        .byte   $80
        sta     ($8A,x)
L6D79:  .byte   $C7
        bpl     L6DA8
        .byte   $DA
        sbc     $35,x
        brk
        sta     L2390
        bvc     L6D1D
L6D85:  .byte   $C7
        .byte   $A3
        .byte   $12
        .byte   $3A
        ora     $43
        .byte   $83
        jsr     L1BC8
        .byte   $14
        asl     $2B,x
        brk
        .byte   $82
L6D94:  .byte   $89
        ror     $C4
        ror     $83
        bne     L6D94
        .byte   $1C
        ldy     $8D,x
        cpx     #$20
        .byte   $B3
        ror     $AF
        adc     L47B3,y
        .byte   $A5
L6DA7:  .byte   $B7
L6DA8:  lda     L775D,x
        .byte   $77
        lda     $5E
        inc     $DE,x
        jsr     L4E55
L6DB3:  txa
        stx     $D3
        cpx     #$3E
        .byte   $44
        clv
        bcc     L6D55
        plp
        .byte   $25
L6DBE:  .byte   $07
        eor     ($E2),y
        ora     L400A
        .byte   $73
        bvc     L6DFF
        .byte   $E2
        .byte   $A3
        stx     $19,y
        ora     $066B
        plp
        rti

        ora     ($D5,x)
        ora     $8E19
        cpy     L3151
        pla
        .byte   $FB
        sbc     $31
L6DDC:  sty     $48
        dec     $AB,x
        inc     $8F,x
        cpy     #$30
        eor     $CA50
        .byte   $53
        cpy     #$2F
        eor     ($01),y
        .byte   $13
        bvc     L6E0F
        .byte   $8F
        bvc     L6E32
        pla
L6DF3:  .byte   $27
        .byte   $12
        cmp     $03,x
        bpl     L6D79
        bmi     L6DB3
        .byte   $F7
        .byte   $0F
        cmp     $07,x
L6DFF:  asl     L0915
        .byte   $0F
        sbc     $0A
        .byte   $82
        cmp     L10BD,y
        rol     $1F,x
        ora     $C2,x
        and     ($44),y
L6E0F:  .byte   $0B
L6E10:  nop
        .byte   $12
        .byte   $03
        rti

        .byte   $7C
        .byte   $57
        asl     $C6
        iny
        and     L08A8,y
        .byte   $5C
        adc     ($06),y
        cpy     $80
        sty     $62,x
        asl     $F2
        dec     $FC
        asl     $85,x
        .byte   $C7
        clv
L6E2B:  lsr     $29,x
        cmp     $0F
        cpy     #$FA
L6E31:  .byte   $A5
L6E32:  eor     ($7C),y
        asl     $AA17
        ora     ($10),y
        jsr     L3881
        lda     ($17),y
        ora     L46D1,x
        sta     L554C,x
        .byte   $87
        .byte   $44
        bvs     L6EBE
        tay
        and     $1E
        sbc     ($71,x)
        clc
        .byte   $17
        adc     ($EE,x)
        .byte   $1B
L6E52:  ora     $A2C1,x
        .byte   $C2
        cmp     $02
        cmp     ($65,x)
        asl     $C0
        and     ($FA),y
        jsr     L6C54
        rti

L6E62:  bmi     L6ED0
        .byte   $54
        asl     a
        .byte   $6C
L6E67:  rol     $04
        jmp     (L0216)

        adc     $0536
        sty     $00
        .byte   $63
        stx     L8D3E
        .byte   $E3
        sbc     $14,x
        asl     $5E
        cpy     $00
L6E7C:  bvs     L6E94
        cmp     ($01,x)
        cmp     L5AF8,y
        ora     $01
        bit     $C761
        .byte   $E2
        php
        .byte   $27
        bmi     L6EB3
        inc     $C9DF,x
        eor     $83,y
        .byte   $A2
L6E94:  ldy     L6538,x
        rts

        tay
        ldy     #$68
        ldx     $F636
        .byte   $DA
        asl     $06
        inc     $68,x
        ora     $86
        .byte   $6E
L6EA6:  .byte   $5C
        .byte   $67
        .byte   $07
        cmp     #$10
        sta     L0EDA
L6EAE:  .byte   $02
        asl     a
        ora     ($C0),y
        .byte   $50
L6EB3:  .byte   $7F
        adc     $F6
        pla
        .byte   $67
        bne     L6F11
        rol     $FE
        .byte   $7E
        .byte   $F2
L6EBE:  and     $04,x
        .byte   $67
        dec     $7A,x
        .byte   $72
        .byte   $1B
        sta     $00
        txs
        .byte   $E7
        lsr     $E163
        clv
        rol     $0477,x
L6ED0:  .byte   $F2
        .byte   $0F
        sbc     L4C79
        rti

        cmp     ($89,x)
        .byte   $42
        .byte   $82
        ora     #$42
        .byte   $72
        sed
        .byte   $04
        .byte   $0B
        .byte   $AF
        .byte   $1C
        rol     $CF15
        .byte   $9E
        .byte   $2B
        ora     ($2C,x)
        .byte   $CF
        sec
        sbc     $ED
        lda     $CD06,y
        .byte   $3C
        .byte   $34
        cpy     L6E10
        sta     L7180,x
        .byte   $D7
L6EF9:  lda     ($DB),y
        .byte   $6B
        ldx     $01,y
        rol     a
        .byte   $52
        and     ($A8),y
        .byte   $07
        .byte   $8E
        .byte   $BE
L6F05:  .byte   $47
        bmi     L6F52
        .byte   $54
        .byte   $5E
L6F0A:  .byte   $32
        sta     ($27,x)
        .byte   $CF
        ora     $41
        .byte   $39
L6F11:  ora     $E332,y
        adc     L7D79
        .byte   $02
        .byte   $53
        sta     $A771,x
        .byte   $9F
        pha
        .byte   $22
        lda     $A0B2,x
        .byte   $3A
        .byte   $44
        ldx     $52
        asl     a
        .byte   $5F
        rol     $3D
        ora     L2540,y
        cmp     ($AF,x)
        plp
        inx
        dey
        plp
        rts

        .byte   $83
        .byte   $73
        .byte   $B2
        .byte   $C7
        inx
        rts

        .byte   $73
        sty     $98CD
        tsx
        dec     $1B,x
        and     $8F,x
        tax
        .byte   $72
        ldy     L32B0
L6F48:  .byte   $4C
L6F49:  .byte   $44
        asl     $0B,x
        eor     #$16
        jsr     L163D
        clc
L6F52:  asl     L2B16
        bmi     L6F6D
        rti

        clc
        asl     $28,x
        asl     L3E16,x
        dec     L74E0
L6F61:  .byte   $9F
        .byte   $9E
        .byte   $4F
        cpy     L2241
        ora     #$F2
        .byte   $EC
L6F6A:  .byte   $7F
        .byte   $99
        php
L6F6D:  .byte   $CB
        and     ($F2,x)
        .byte   $5C
L6F71:  .byte   $FA
        stx     $28
        sec
        .byte   $80
        stx     $10,y
        php
        .byte   $87
        .byte   $04
        bit     $C6
        .byte   $C3
        .byte   $0C
        .byte   $83
        eor     L253A,y
        .byte   $CF
        lda     L8C4A
        ora     ($46,x)
        inx
        ror     L48A8
        .byte   $BC
        .byte   $01
L6F8F:  php
        .byte   $62
        ldy     #$00
        clv
        dex
        .byte   $1C
        .byte   $04
        .byte   $44
        .byte   $0E
        clv
L6F9A:  bvs     $6FA3
        ora     $09,x
        .byte   $14
        stx     L28D8
        asl     L810C
        bcc     L6F49
        bvc     L6FF9
        pla
        .byte   $FA
        asl     $B0
        asl     a
        .byte   $0B
        txa
        brk
        .byte   $33
        cli
        rol     $D08F,x
        .byte   $73
        bvc     L6F71
        .byte   $34
        txs
        .byte   $1A
        sty     $81
L6FBE:  .byte   $1A
        stx     $00
        txs
        dec     $81
        .byte   $AD
L6FC5:  .byte   $34
        .byte   $22
        .byte   $10
L6FC8:  ora     $15,x
        .byte   $54
        .byte   $AF
        .byte   $34
        ldy     $71
        lda     L7103,x
        dex
        eor     $49
        .byte   $3C
        asl     a
        bit     $19
        asl     L6622,x
        ldy     $50
        sed
        bit     $11
        .byte   $EB
        .byte   $1F
        lda     ($6A),y
        .byte   $1E
L6FE6:  asl     a
        ora     ($1B),y
        .byte   $80
        eor     ($AC),y
        .byte   $02
        .byte   $13
        .byte   $5A
        cli
        .byte   $1A
        .byte   $13
        nop
        .byte   $22
        sec
        lsr     a
        jsr     L6A18
L6FF9:  .byte   $1A
        ora     $18,x
        and     ($14,x)
        ldx     L8755
        rts

        cmp     ($F4),y
        .byte   $04
        ora     L401F
L7008:  .byte   $9C
L7009:  lda     ($5E),y
        rol     a
        .byte   $1A
        .byte   $0F
        txa
        .byte   $3C
        .byte   $22
        .byte   $6B
        bpl     L6FC5
        .byte   $77
        .byte   $14
        brk
        rti

        .byte   $74
        bvc     L706D
        eor     $44,x
        .byte   $74
        adc     $84,x
        .byte   $D3
        ora     $00,x
        ldy     $06A8,x
        .byte   $04
        .byte   $A1
L7028:  ora     ($95,x)
        cmp     ($98,x)
        jmp     L0353

        .byte   $87
        .byte   $12
        .byte   $D2
        .byte   $D4
        brk
        .byte   $04
        .byte   $D3
        .byte   $0C
        .byte   $7A
        ldy     $7B,x
        cpy     $F4
        .byte   $4B
        .byte   $83
        .byte   $D2
        and     $FA,x
        .byte   $C7
        adc     $C42B,x
        .byte   $47
        .byte   $42
        clc
        .byte   $54
        adc     $C706,x
        plp
        bvs     L7028
        tay
        and     $08,x
        bvs     L709E
        bpl     L7057
        txa
L7057:  rol     L0F31,x
        sta     ($58),y
        asl     $15
        nop
        .byte   $04
        .byte   $44
        ror     a
        asl     L6A12
        .byte   $03
        rti

        sed
        dec     $A8
        sbc     ($24,x)
        .byte   $5F
L706D:  eor     ($D6),y
        .byte   $1B
        .byte   $1F
        .byte   $54
        .byte   $14
        eor     ($14,x)
        .byte   $6F
        .byte   $D2
        rol     $D262
        .byte   $13
        brk
        .byte   $52
        .byte   $7F
        brk
        dec     $B0
        lda     $21,x
        .byte   $7C
        .byte   $5F
        .byte   $52
        and     ($D2,x)
        adc     L5081,x
        .byte   $DB
        .byte   $CB
        .byte   $0C
        cmp     ($DC),y
        ora     L18CA,x
        .byte   $17
        eor     $7D
        .byte   $1A
        .byte   $12
        dec     $18,x
        clc
        .byte   $80
        stx     $07,y
L709E:  .byte   $1B
        .byte   $CF
        .byte   $CE
        inx
L70A2:  cld
        cpy     $66
        .byte   $02
        clc
        brk
        .byte   $23
        .byte   $92
L70AA:  bit     $0602
        cli
        ldy     #$23
        .byte   $3F
        asl     $33
        .byte   $E3
        sta     $F5AF,y
        .byte   $83
L70B8:  sta     ($5D),y
        .byte   $B3
L70BB:  .byte   $DC
        inx
        .byte   $7B
        cpy     #$97
        .byte   $1E
        .byte   $20
L70C2:  ldy     #$D9
        .byte   $FB
        ldx     $38,y
        sbc     ($15),y
        .byte   $F2
        .byte   $EB
        .byte   $EB
        .byte   $D3
        cpx     $D3
        inc     $01
        tsx
        cmp     $FAF6
        .byte   $F6
L70D6:  inc     $BCE2
        sty     $33,x
        tax
        .byte   $93
        bvc     L70BB
        .byte   $52
        .byte   $02
        sbc     ($3C,x)
        .byte   $03
        .byte   $8F
        ldx     $C1BA
        .byte   $FB
        .byte   $93
        ldx     L7A3C
        sbc     $E1
        .byte   $33
        jmp     (LE8F5)

        .byte   $12
        .byte   $03
        .byte   $D7
        clv
L70F7:  .byte   $17
        .byte   $87
        stx     $F66F
        and     $01
        .byte   $77
        .byte   $7F
        .byte   $62
L7101:  lda     ($59,x)
L7103:  plp
        bpl     L710A
        asl     a
        .byte   $0F
        .byte   $E7
        .byte   $82
L710A:  sta     $9BCF,y
        .byte   $7F
        .byte   $9F
        cmp     ($A6,x)
        .byte   $C7
        brk
        asl     $CD
        .byte   $1C
        .byte   $DA
        inx
        brk
        lda     ($06),y
        ror     $A0E7,x
        .byte   $B3
        brk
L7120:  .byte   $05
L7121:  ldx     $7B,y
        sbc     ($78,x)
        brk
        .byte   $87
        .byte   $1F
        sta     $11
        dec     $D0,x
L712C:  .byte   $43
        .byte   $1C
        .byte   $13
        .byte   $E7
        inc     $A5
        eor     $C3,x
        .byte   $C2
        .byte   $6B
        tay
        .byte   $F0
L7138:  .byte   $7F
        eor     L6F9A,x
        rol     $6E
        sta     ($1E,x)
        ldx     #$07
        and     $A9,x
        .byte   $80
        .byte   $83
        sed
        .byte   $A3
        .byte   $80
L7149:  .byte   $54
        .byte   $E1
L714B:  .byte   $C3
        ora     $20,x
        sei
L714F:  lda     #$82
        adc     ($F0),y
        .byte   $23
        pha
        dex
        .byte   $C7
        lsr     L2305
        lda     ($E0),y
        clc
        asl     L5E01
        .byte   $10
L7161:  .byte   $E7
        .byte   $02
        .byte   $E2
        lda     ($F4),y
        .byte   $73
        txa
        lsr     a
        ora     $1D
        adc     ($70,x)
        .byte   $D7
        .byte   $8B
        bit     L4C80
        sed
        cpy     L0EE0
        ror     $D19F
L7179:  beq     L718B
        .byte   $80
        plp
L717D:  .byte   $0C
        pla
        .byte   $30
L7180:  .byte   $7C
        rol     a
        .byte   $0C
        ror     a
        cld
        jmp     (L0236)

        tya
        .byte   $04
        .byte   $63
L718B:  .byte   $3F
L718C:  asl     $02
        jsr     L8A21
        .byte   $0B
        .byte   $B3
L7193:  cpx     #$83
        .byte   $8F
        eor     ($AE,x)
        .byte   $3F
        .byte   $04
        sec
        .byte   $FC
        rol     $F1E3
        .byte   $83
        .byte   $3B
        ora     $F2B6
L71A4:  .byte   $1B
        .byte   $14
        .byte   $62
        rts

        .byte   $80
        .byte   $6D
        .byte   $B4
L71AB:  .byte   $CF
        .byte   $0B
        jmp     (LDA7C)

        tay
        dec     $6F,x
        .byte   $1B
        sec
        .byte   $19
L71B6:  .byte   $8B
        bit     $1A
        ror     a
        dec     $53,x
        .byte   $07
        stx     $38,y
        .byte   $2B
        .byte   $80
        .byte   $0F
        .byte   $E2
        ror     $C2
        ldy     #$08
        .byte   $74
        pha
        .byte   $F2
        lda     ($04,x)
L71CC:  lsr     a
        .byte   $1C
        php
L71CF:  lsr     $95
        bne     L71E6
L71D3:  cpy     #$9C
        .byte   $D4
        sei
        bmi     L71EF
        lda     $07B0,y
        .byte   $04
        dec     $0C
        lda     L00F9
        .byte   $A3
        .byte   $F4
        .byte   $13
        .byte   $1E
        clc
L71E6:  .byte   $2B
        .byte   $63
        rts

        .byte   $F3
        bmi     L71EE
        dec     $6D
L71EE:  .byte   $82
L71EF:  .byte   $6B
        .byte   $4B
        .byte   $63
        jsr     LBA96
        .byte   $9E
L71F6:  php
        .byte   $04
        .byte   $DA
        .byte   $A1
L71FA:  asl     a
        sty     $6E,x
        clv
        .byte   $F7
        .byte   $04
        .byte   $DF
        ldy     $56
        lda     $0469
        inc     $8D
        ror     a
        .byte   $52
        bvs     L71B6
L720C:  .byte   $47
        bne     L71CF
        .byte   $4F
        .byte   $7A
L7211:  eor     $C1E0,x
        cli
        sbc     $A40C,x
        sty     L0F03
        ora     $07,x
        php
        ora     $01,x
        .byte   $07
        .byte   $0C
        ldx     $69
        plp
        ldy     $D08A
        cpy     #$F8
        .byte   $F7
        .byte   $8F
        tay
        inx
        .byte   $0B
        ldx     $29
        ldx     #$68
        plp
        .byte   $54
        bit     L5404
        clc
        .byte   $44
        .byte   $D4
        .byte   $14
        .byte   $34
        bmi     L7289
        sty     $EFAA
        bit     $30
L7244:  ror     $8D
        rts

        inx
        dex
        asl     $80
        .byte   $5A
        adc     #$B0
        asl     L442A,x
        .byte   $62
        ldy     $0E
L7254:  and     L0D1A,x
        .byte   $41
L7258:  .byte   $82
        .byte   $83
        ora     $14
        eor     L0060
        inc     $15
        .byte   $63
        .byte   $F4
        .byte   $3A
        txs
        .byte   $87
        .byte   $03
        .byte   $AB
        bne     L727B
        .byte   $9B
        adc     $88,x
        sbc     $D998
        ora     ($A6,x)
        .byte   $2F
        sta     ($A9,x)
        ldx     $F0
        eor     ($B0),y
        .byte   $7A
        .byte   $E1
L727A:  sei
L727B:  jmp     LBB36

        .byte   $87
        .byte   $3A
        .byte   $4F
        ora     $07
        bpl     L727A
        jmp     LAB45

        .byte   $36
L7289:  .byte   $04
        .byte   $A3
        inc     $6E,x
        txa
        .byte   $89
L728F:  brk
        cmp     ($62,x)
        .byte   $02
        .byte   $C2
        .byte   $53
        rts

        .byte   $0C
L7297:  lsr     L11C4
        .byte   $21
L729B:  lda     $04,x
        adc     $CA4D,y
        ora     a:$44
        and     L2144,y
        eor     $02
        .byte   $3B
        cpx     $8E
        ldx     $F0
        and     ($80),y
        .byte   $4B
        asl     $3E
        sbc     $0288
        jsr     L593D
        sbc     ($DF),y
        adc     ($D0,x)
        cli
        clc
        ror     L801B,x
        .byte   $C2
        asl     $1A
        cpx     #$41
        .byte   $3F
        bit     $18
        .byte   $FC
        .byte   $57
        rti

        lsr     $7E
        jsr     L6705
        cpx     #$C0
        .byte   $5C
L72D4:  php
        bcs     L7297
        brk
        ldx     $65,y
        .byte   $8B
        .byte   $34
        .byte   $67
        cpx     L7E86
        .byte   $DC
        .byte   $67
        inc     L39B8
        cmp     $EC
        cpx     #$E7
        cmp     $FD
        stx     $08,y
L72ED:  brk
        stx     L5096
        .byte   $E3
        .byte   $F2
        .byte   $83
        .byte   $8F
        cmp     L4754
        cpx     #$CE
        ldx     $0540
        .byte   $8B
        .byte   $FB
        dex
        ldy     L6225,x
        inc     $FA,x
        tay
L7306:  ora     #$58
        .byte   $BB
        ldy     #$C4
        .byte   $02
        .byte   $42
        .byte   $D2
        tay
        lda     L4840,y
        .byte   $43
        ror     a
        .byte   $04
        eor     $6F
        lda     ($26,x)
        .byte   $9B
        .byte   $7F
L731B:  ora     $03,x
        ora     #$05
L731F:  .byte   $12
        ora     #$15
        php
        .byte   $22
        .byte   $80
        ldy     #$E8
        inx
        asl     a
        .byte   $8F
        rti

        nop
        .byte   $E7
        .byte   $74
L732E:  asl     a
        tya
        jmp     LA60A

        .byte   $5C
        .byte   $63
L7335:  clv
        bit     L1454
        jsr     L9956
        .byte   $EC
L733D:  .byte   $A6
L733E:  .byte   $13
        cmp     ($40,x)
        lda     ($0E),y
        rti

        .byte   $2B
        lda     $29,x
        tsx
        .byte   $C7
        .byte   $D0
L734A:  adc     $33
        sta     L6D5E,x
        .byte   $54
        sbc     $3F,x
L7352:  brk
        .byte   $C7
L7354:  sbc     L1C27
        .byte   $DA
        cpy     $53
        eor     $0605,x
        ldx     #$B0
        bvs     L7335
        .byte   $34
        rol     $2F,x
        .byte   $85
L7365:  sta     ($45,x)
        cpy     $B1
        .byte   $12
        .byte   $D7
        .byte   $4D
L736C:  .byte   $62
        ldy     $D4,x
        bit     $9F52
        .byte   $22
        ror     a
        tya
        dec     $C4,x
        rol     a
        bit     L6EA6
        ror     $B4
        cld
        .byte   $0C
        adc     $82,x
        .byte   $04
        eor     ($23),y
        ora     $21,x
        lda     $87,x
        cmp     ($74,x)
        ror     L38C6,x
        jmp     (L936F)

        ora     L8C47
        adc     $85,x
        .byte   $47
        dey
        rts

        lsr     $23
        .byte   $31
L739B:  cpy     $56
        .byte   $43
        sbc     $9C,x
        .byte   $E7
        .byte   $44
        asl     $22,x
        .byte   $13
        .byte   $59
L73A6:  tay
        .byte   $80
        ror     $F321
        eor     ($A8,x)
        sec
        dec     $22,x
        cmp     ($A4),y
        dec     $85,x
        bcs     L73E0
        ror     L118F
        cmp     L54BC,y
        clv
        dec     L4133,x
        .byte   $63
        bvs     L73EF
        sty     $A0,x
        .byte   $C7
        .byte   $13
        .byte   $DA
        asl     a
        .byte   $2B
        .byte   $73
L73CB:  .byte   $02
        .byte   $2C
        .byte   $44
L73CE:  .byte   $1A
        adc     #$F6
L73D1:  rol     a
        adc     ($5A,x)
        rol     $61,x
        .byte   $54
        .byte   $22
        .byte   $8F
        .byte   $1A
        adc     ($7A,x)
        dey
        bvc     L7409
        tsx
L73E0:  brk
        .byte   $C6
L73E2:  eor     $2942
        tsx
L73E6:  brk
        .byte   $C3
        bvc     L73E2
        .byte   $E2
        .byte   $89
        lsr     a
        rti

        .byte   $E1
L73EF:  bvc     L73D1
        adc     ($50),y
        beq     L7441
        .byte   $4F
        ora     $6A,x
        asl     a
        and     ($3D),y
        cmp     L8622,y
        .byte   $37
        .byte   $03
        and     ($DA,x)
        .byte   $89
        ldy     #$11
        .byte   $7C
        .byte   $4F
        .byte   $04
        nop
L7409:  .byte   $D4
        sbc     ($68,x)
        .byte   $DF
        bpl     L7425
        and     $14
        .byte   $A7
        cmp     #$B2
        asl     $CC
        .byte   $0F
        .byte   $3C
        .byte   $89
        tay
        rol     L0A08
        ldy     $D7
        and     $2B
        .byte   $0C
        cpy     $E3
        .byte   $27
L7425:  and     $02
        asl     $A8
        bpl     L7451
        .byte   $3B
        sty     $22
        pla
L742F:  lsr     a
        sta     L08DD,y
        .byte   $87
        brk
        .byte   $1C
        lsr     $F1C2
        eor     ($28),y
        sta     $0E
        ldy     #$64
        .byte   $0E
        .byte   $97
L7441:  .byte   $7B
        .byte   $13
        ldy     $98CA
        .byte   $F4
        ldx     #$83
        bmi     L7467
        .byte   $5A
        .byte   $04
        cpy     #$A9
        adc     ($E0,x)
L7451:  dey
        asl     $3D
        and     ($02,x)
        .byte   $3C
        ldx     #$6A
        .byte   $2B
        .byte   $07
L745B:  bcc     L74BE
        .byte   $62
        asl     $0340,x
        .byte   $AB
        .byte   $1A
L7463:  plp
        .byte   $B2
        php
        txs
L7467:  .byte   $80
        .byte   $80
        ror     $0D
        .byte   $93
        lsr     $7F,x
        .byte   $42
        cmp     $35
        sta     L841E,y
L7474:  .byte   $F4
        .byte   $12
        inc     $0B
        cpy     #$FC
        dec     L668A,x
        ror     $922C
        and     #$B0
        lsr     a
        .byte   $2F
        sta     ($08,x)
        ora     #$EB
        .byte   $80
        inc     $FDA4,x
        .byte   $53
        and     ($08),y
        sbc     ($83),y
        .byte   $DF
L7492:  sbc     ($9A),y
        .byte   $E2
L7495:  sec
        cli
        brk
        .byte   $DB
        php
        rts

        .byte   $9B
        jsr     LD970
        cpy     #$00
        txs
L74A2:  .byte   $5B
        php
        ldy     #$C5
        ora     #$94
        cmp     ($01),y
        beq     L74AD
        .byte   $83
L74AD:  .byte   $E2
        .byte   $FA
        sbc     $D6
        .byte   $5A
        rol     L8170,x
        .byte   $C3
        ora     ($80,x)
        cpy     #$4B
        .byte   $04
        .byte   $73
        .byte   $57
        .byte   $F7
L74BE:  brk
        .byte   $1C
        ror     L4024,x
        .byte   $43
        .byte   $52
        .byte   $02
        cpy     #$0B
        lsr     a
        php
        .byte   $8B
        .byte   $54
        rts

        cli
        sta     ($EF,x)
        and     $3F
        and     ($96,x)
        lda     L0F59
        .byte   $41
L74D8:  bcc     L7463
L74DA:  sta     ($92,x)
        ora     #$6C
        .byte   $74
        .byte   $7A
L74E0:  ora     ($D5),y
        .byte   $72
        .byte   $AF
        .byte   $5C
        .byte   $91
L74E6:  ror     a
L74E7:  adc     ($66),y
        .byte   $5B
        stx     L31F0
        .byte   $80
        brk
        .byte   $73
        .byte   $80
L74F1:  .byte   $63
        .byte   $80
L74F3:  .byte   $3A
        lsr     a
        .byte   $03
        ora     ($5A,x)
        adc     #$36
        rol     L68B5,x
        .byte   $F7
        lda     ($CB),y
        sty     $BED6
        .byte   $3C
        .byte   $3A
        .byte   $F2
        .byte   $50
L7507:  sbc     $9B,x
        bvc     L74A2
        .byte   $47
        .byte   $74
L750D:  .byte   $D4
        .byte   $42
        stx     L5AE0
L7512:  and     L0E21,x
        .byte   $DF
        .byte   $42
        bne     L7562
        pla
        .byte   $B7
        sta     ($88,x)
        .byte   $02
L751E:  .byte   $57
        .byte   $37
        cmp     ($E7,x)
        dec     $98B8,x
        .byte   $7B
        dex
        .byte   $7C
        brk
        jsr     L5B13
        nop
        .byte   $DD
L752E:  .byte   $DA
        .byte   $F7
        .byte   $73
L7531:  .byte   $F7
        dec     $B906,x
        sbc     $9B,x
        .byte   $12
        pha
        .byte   $42
        clv
        eor     ($9E,x)
        .byte   $80
        sta     $027D,x
        .byte   $F3
        .byte   $04
        eor     $C5D1,y
        .byte   $C7
        bvs     L757C
        .byte   $C7
        .byte   $D7
        .byte   $53
        cmp     $B5F5,y
        sbc     #$57
        .byte   $9B
        .byte   $A3
        dec     $F2A9
        .byte   $E3
        lsr     L7944,x
L755A:  .byte   $B2
        .byte   $B2
        bvc     L75CE
        rol     L17EE
        .byte   $8E
L7562:  rti

        bpl     L74E7
        .byte   $5C
L7566:  .byte   $F7
        and     $E5,x
        .byte   $42
        .byte   $E7
        sec
        .byte   $80
        rts

        ldx     L60F1,y
        sbc     $03FF
        sbc     $87
        ora     $EE
L7578:  .byte   $72
        .byte   $FB
        .byte   $1B
        .byte   $81
L757C:  .byte   $27
        .byte   $8B
        .byte   $72
        .byte   $CB
        .byte   $89
        .byte   $4E
L7582:  inx
        .byte   $27
        .byte   $34
        inc     $E7,x
        brk
        .byte   $DC
L7589:  jmp     (LD4B2)

        bit     $D140
        .byte   $9F
        ldy     #$86
        cpy     $45
        .byte   $62
        .byte   $CC
        .byte   $05
L7597:  .byte   $42
        .byte   $D3
        .byte   $07
        asl     $C2
        bit     $C982
L759F:  cpx     $CBB6
        .byte   $1C
        txs
        .byte   $F2
        ora     L23F8,y
        lda     $52
        ora     $37
        .byte   $33
        .byte   $17
        .byte   $62
        sta     ($A1,x)
        .byte   $FC
        ldx     #$65
        .byte   $E2
        bmi     L7597
        ldx     #$29
        bmi     L7582
        cld
        .byte   $13
        .byte   $5F
        .byte   $6B
        adc     #$AF
        bcs     L760F
        eor     #$E5
        .byte   $64
        .byte   $6B
        .byte   $12
        .byte   $89
        .byte   $20
L75CA:  .byte   $64
L75CB:  .byte   $12
        .byte   $39
        .byte   $20
L75CE:  .byte   $54
        .byte   $27
        .byte   $80
        .byte   $7C
        .byte   $93
        ora     ($E4),y
        .byte   $FB
        php
        .byte   $E3
        bne     L761E
        .byte   $DB
        and     $49
        .byte   $82
        .byte   $80
        cmp     a:$88
        eor     #$B0
        .byte   $DC
        .byte   $E4
L75E6:  sty     $10,x
        .byte   $1C
        .byte   $97
        .byte   $1A
        cmp     $82
L75ED:  clv
        .byte   $5B
        cpx     $AA
        .byte   $02
        cmp     $C408
        .byte   $CF
        .byte   $1C
        inc     $BDB9
        .byte   $5C
        sty     $C6
        .byte   $3C
        .byte   $6B
        .byte   $13
        cpy     L4C35
        eor     L2C00
        and     $4A
        .byte   $32
        cmp     $A8,x
        eor     $17
        .byte   $AC
        clv
L760F:  ldx     #$6B
        ldy     #$63
        .byte   $7A
        ldx     #$20
        sbc     $71
        .byte   $F7
        lsr     L816F
        rts

        .byte   $FA
L761E:  ldy     #$D4
        dex
        sbc     ($26,x)
        bit     L5668
        eor     #$D0
        adc     $00,x
        .byte   $3C
        .byte   $A3
        dec     $44
        .byte   $A3
        bvs     L75ED
        jsr     L1D15
        .byte   $07
        ldy     L6AA3,x
        .byte   $62
        .byte   $AB
        inx
        .byte   $14
        sty     $AD7E
        ldy     $A0
        .byte   $63
        stx     $63
        sty     $95,x
        sbc     ($F2),y
        lsr     $39,x
        lsr     $A5
        .byte   $A7
        sty     $7D,x
        nop
        txa
        .byte   $9E
        .byte   $53
        lda     $8D
        and     $83,x
        jmp     L0A13

        .byte   $83
        .byte   $D3
        lsr     L5ED4
        .byte   $03
        .byte   $1A
        cmp     $C78A
        clv
        ldy     $A7
        .byte   $33
        .byte   $3A
        pha
        lsr     a
        .byte   $CB
        sei
        .byte   $DC
        sta     $C0
        rol     a
        clc
        .byte   $EB
        .byte   $23
        .byte   $63
        .byte   $E2
        ora     ($C1),y
        .byte   $62
        brk
        rol     a
        .byte   $8F
        .byte   $AF
        .byte   $50
L767E:  rol     a
        sbc     ($EE),y
        stx     $4A
        .byte   $44
        plp
        stx     $0A
        .byte   $A3
        ror     $3E
        sta     ($C0,x)
        cpx     $AA3E
        dex
        cmp     $28,x
L7692:  ldx     $73
        cpy     #$68
        ldx     $AFB0,y
        .byte   $04
        tax
        stx     L5098
        .byte   $B7
        cmp     #$66
        .byte   $92
        asl     $91
        dex
        tsx
L76A6:  asl     $AC,x
        ora     $A4,x
        lsr     $AD06
        stx     $AF0F
        asl     $CD
        .byte   $5A
        eor     ($E0,x)
        bpl     L76BF
        .byte   $FA
        .byte   $03
        .byte   $A3
        .byte   $8B
        lsr     $8C,x
        sei
        .byte   $A3
L76BF:  sta     ($70,x)
        rol     a
        .byte   $A7
        eor     $C3
        and     #$A3
        asl     $B850,x
        .byte   $23
L76CB:  .byte   $89
        pha
        sta     ($09),y
        bcs     L76CB
L76D1:  .byte   $0B
        .byte   $8F
        tay
        inx
        ldx     #$6A
        sta     $E9FF,x
        .byte   $27
        .byte   $63
        inc     $1C,x
        .byte   $C7
        adc     ($54,x)
L76E1:  .byte   $1B
        .byte   $54
        .byte   $42
        asl     $C0,x
        .byte   $63
        bne     L76D1
        brk
        .byte   $54
        rol     $37
        ora     ($C8,x)
        and     #$C1
        .byte   $EF
        sty     $20,x
        .byte   $42
        and     $80,x
        tay
        .byte   $D6
L76F9:  ldy     $70
        sbc     $04
        .byte   $8F
        rti

        dey
        .byte   $F4
        dey
        and     L5454
        tay
        rti

        .byte   $83
        ldy     #$DA
        jmp     L6A00

        beq     L7766
        ldx     $44
        sta     ($E3,x)
        nop
        lda     ($6A,x)
        .byte   $BF
        .byte   $62
        .byte   $FA
        ror     a
        ora     L5847
        and     $ED33,x
        eor     $C3AC,x
        .byte   $8D
        .byte   $7A
L7725:  bcs     L76F9
        stx     $04,y
        .byte   $D2
        cmp     L6203,y
        sty     $D387
        lda     L5145,y
        .byte   $74
        lda     ($76,x)
        cli
        .byte   $34
        lda     $E0A1
        eor     $EC,x
        lda     $59
        sta     L5101,x
        .byte   $89
        eor     L4571,x
        adc     L101A,x
        tya
        .byte   $44
        asl     a
        jmp     LEB05

        lsr     $E1A3,x
        ror     L21A1,x
        sty     $A0
        sta     ($5E,x)
        ldy     #$F4
        cpx     $0A
L775D:  .byte   $13
        .byte   $EB
        ora     $DA95,y
        iny
        .byte   $80
        .byte   $0D
        .byte   $24
L7766:  jmp     L036E

        .byte   $47
        ldy     #$3E
        lda     #$40
        .byte   $5C
        adc     $53
        jsr     LD974
        bmi     L77B2
        ror     $D115
        .byte   $CB
        ora     $D5
        .byte   $7A
        .byte   $72
        tya
        .byte   $14
        .byte   $53
        .byte   $2E
L7782:  ldx     $A3
        eor     ($A0),y
        ora     #$1B
        .byte   $85
L7789:  sty     $EDF5
        sta     $0E
        asl     $C5B5,x
        bpl     L77CC
        tax
        sei
        brk
        .byte   $33
        .byte   $80
        rts

        .byte   $32
        lda     $E679
        .byte   $62
        lda     ($1B),y
        bvc     L7782
        jmp     L0610

        jmp     L3754

        .byte   $63
        .byte   $0C
        ldy     #$61
        adc     ($4A),y
        ora     $5D,x
        .byte   $0D
        .byte   $C1
L77B2:  sta     $62
        ora     $C025,x
        .byte   $1C
        dec     $B8,x
        .byte   $D0
L77BB:  rol     a
        and     $07,x
        .byte   $A3
L77BF:  asl     $BDBA
        lda     ($B0),y
        .byte   $DB
        ora     $7A,x
        clv
        .byte   $32
        ldx     $C8
        .byte   $80
L77CC:  jmp     (L283D)

        .byte   $FA
        .byte   $03
        bcs     L77BB
        sty     $EE48
        ldx     $63
        sbc     ($41),y
        adc     #$A5
L77DC:  sei
        .byte   $9F
        .byte   $A3
        ldy     $0310
        sty     $08,x
        rol     $2B
L77E6:  plp
        .byte   $F4
        php
        ldx     $8B
        .byte   $63
        inx
        rol     a
        clv
        ror     a
        ldx     #$EC
        asl     $8E,x
L77F4:  .byte   $80
        .byte   $80
        rol     a
        .byte   $6C
        .byte   $64
L77F9:  stx     $BD,y
        .byte   $E3
        .byte   $C3
        .byte   $AB
        .byte   $09
L77FF:  .byte   $C3
        .byte   $80
        plp
        lda     L1517
        .byte   $27
        .byte   $AF
        asl     $F3,x
        cli
        .byte   $FA
L780B:  cmp     $20,x
        ldx     #$C0
        .byte   $5C
        php
        .byte   $0C
        .byte   $80
        asl     a
        tax
        ror     $FA,x
        .byte   $74
L7818:  ror     a
        and     $96,x
        asl     $9063,x
        .byte   $1B
        .byte   $82
        lda     $D5E7,x
        .byte   $C6
L7824:  .byte   $7D
L7825:  .byte   $33
        .byte   $80
        asl     $0F
        .byte   $67
        .byte   $73
        stx     L447A
        inc     $69
        .byte   $37
        .byte   $5A
        .byte   $DC
        ror     $F7
        bit     $EB
        .byte   $BD
        .byte   $E1
L7839:  ldy     #$6D
        .byte   $D7
        dec     L1A96,x
        .byte   $FB
        .byte   $FF
        .byte   $6B
        cpx     L5CE4
        .byte   $0C
        adc     $02,x
        cmp     $E0
        cmp     L33B1,y
        sta     ($16,x)
        .byte   $7C
        asl     $E9,x
        .byte   $54
        .byte   $FC
        ora     #$96
        .byte   $4F
        cpy     #$A9
        .byte   $74
        .byte   $FC
        .byte   $0B
        tya
        .byte   $4F
        cpy     #$C9
        sty     $4E,x
L7862:  php
        ldy     #$4F
        cpy     #$9A
        .byte   $14
        .byte   $FC
        asl     a
        ldx     #$4F
        cpy     #$CA
L786E:  .byte   $3C
        eor     $2E
        .byte   $9F
        .byte   $A7
        bvs     L78BA
        .byte   $5A
L7876:  ror     $D604,x
        .byte   $27
        cpx     #$55
        ror     a
        ror     $D705,x
        .byte   $27
        cpx     #$65
        .byte   $7A
        ror     $D806,x
L7887:  .byte   $43
        .byte   $83
        sta     $AD
        .byte   $13
        .byte   $54
        .byte   $22
        sbc     ($3F,x)
        .byte   $02
        ror     $F053
        rol     a
        sbc     #$3F
        .byte   $02
        inc     $F0D3
        .byte   $32
        sbc     ($3F),y
        .byte   $03
        .byte   $6F
        .byte   $53
L78A1:  .byte   $04
        .byte   $23
        ora     ($3F),y
        .byte   $02
        adc     ($53),y
        beq     L78D5
        ora     $023F,y
        sbc     ($D3),y
        .byte   $F0
L78B0:  .byte   $33
        and     ($AB,x)
        rti

        ldy     #$DC
        sty     $C9,x
        php
        .byte   $CE
L78BA:  .byte   $4F
        cpy     #$9C
        .byte   $F4
        .byte   $FC
        asl     a
        bne     L7911
        cpy     #$BD
        .byte   $14
        .byte   $FC
        .byte   $0C
        .byte   $D2
        .byte   $4F
        cpy     #$DD
        .byte   $32
        sty     $AB,x
        .byte   $1F
        inx
        .byte   $4F
        cmp     ($EE,x)
        .byte   $74
        .byte   $FC
L78D5:  ora     L4FE6,x
        cmp     ($CE,x)
        .byte   $54
        .byte   $FC
        .byte   $1B
        cpx     $4F
        cmp     ($AE,x)
        .byte   $34
        bcs     L78FE
        sbc     #$4F
        cmp     ($BE,x)
        ldy     $FC
        .byte   $1C
        .byte   $EB
        .byte   $4F
        cmp     ($DE,x)
        cpy     $FC
        asl     L4FED,x
        cmp     ($FE,x)
        cpx     $B3
        .byte   $1A
        .byte   $EF
        .byte   $4F
        cmp     ($BF,x)
        .byte   $04
L78FE:  .byte   $FC
        .byte   $1C
        sbc     ($4F),y
        cmp     ($DF,x)
        bit     $FC
        asl     L4FF3,x
        cmp     ($FF,x)
        .byte   $44
        .byte   $B3
        .byte   $1B
        sbc     $4F,x
        .byte   $C1
L7911:  .byte   $CF
        .byte   $64
        .byte   $FC
        ora     L4FF7,x
        cmp     ($EF,x)
        sty     $39
        .byte   $1C
        sbc     $C14F,y
        .byte   $DF
        ldy     $30
        .byte   $1A
        dec     $C14F,x
        lda     $FCF4,x
        .byte   $1C
        cpx     #$4F
        cmp     ($DE,x)
        .byte   $14
        .byte   $FC
L7930:  .byte   $1E
L7931:  .byte   $E2
L7932:  rti

        cmp     ($BD,x)
        ldy     $FC,x
        ora     L4FDD,x
        cmp     ($CD,x)
        cpy     #$10
        lsr     a
        .byte   $13
        .byte   $80
        .byte   $33
        .byte   $07
        .byte   $9F
L7944:  and     L5003,y
        eor     #$70
        .byte   $83
        .byte   $52
        inc     $E9,x
        adc     ($9D,x)
        .byte   $53
        ora     #$48
        ora     $ECDB,y
        .byte   $9F
        cmp     $B7,x
        .byte   $FC
        sta     ($90),y
        lda     ($BD),y
        .byte   $62
        .byte   $0F
        cmp     L551E,y
        asl     $2B,x
        .byte   $1F
        .byte   $42
        lda     ($CB),y
        pha
        ora     ($CA),y
        sec
        .byte   $22
        .byte   $0B
        .byte   $4B
        iny
        bit     L4B17
        sbc     ($CB,x)
        lsr     L14B1
        cpy     $9090
        .byte   $4E
        tay
L797D:  dey
        eor     $20
        ldx     L35AD,y
        stx     $00
        .byte   $52
        .byte   $4B
        .byte   $4B
        .byte   $62
        brk
        .byte   $34
        lsr     a
        .byte   $27
        .byte   $47
        ldy     #$BC
        .byte   $7A
        ora     ($EA,x)
        .byte   $89
        bcc     L79DD
        clv
        cmp     $2F
        ror     L71AB
        sbc     L6B33
        lsr     $0110,x
        .byte   $E2
        .byte   $B5
L79A4:  cmp     $E8
        pla
        cmp     $2C
        sta     $29,x
        sta     $39,x
        .byte   $33
        txs
        sty     $8B
        .byte   $F2
        .byte   $C2
        sbc     L157C
        .byte   $73
        .byte   $5C
        eor     ($1A),y
        .byte   $67
        ldy     #$16
        .byte   $9C
        adc     L44FD,y
        .byte   $62
        .byte   $14
        .byte   $1C
        .byte   $17
        sta     $CC,x
        jmp     L36D5

        .byte   $87
        .byte   $F3
        lda     ($51),y
L79CE:  php
        .byte   $FA
        .byte   $9B
        lda     $5F,x
        .byte   $44
        inx
        .byte   $62
        .byte   $A3
L79D7:  ora     ($64),y
        jmp     (L6B0C)

        .byte   $1F
L79DD:  rti

        txa
        tay
        .byte   $82
        ldx     #$51
        inx
        rts

        .byte   $79
L79E6:  .byte   $13
        .byte   $A7
        .byte   $13
        ldx     $95,y
        .byte   $74
        ror     L473C,x
        cmp     ($C5,x)
        .byte   $8F
        .byte   $02
        eor     $9E
        .byte   $80
        ora     $A5
        .byte   $82
        ora     ($2C,x)
        bne     L7A1C
        ora     ($2C,x)
        bcc     L7A32
        ora     ($C7,x)
        lsr     L61AD
        inc     $BD,x
        .byte   $1C
        plp
        bit     $A62C
L7A0D:  .byte   $34
        .byte   $E3
        nop
        ldx     $A337,y
        bvs     L7A7F
        .byte   $77
        .byte   $DF
        .byte   $17
        lda     $E537
        .byte   $39
L7A1C:  ora     $AC
        .byte   $FF
        .byte   $AE
        .byte   $AD
L7A21:  rol     a
        .byte   $FA
        .byte   $8F
        .byte   $43
L7A25:  .byte   $7A
        sed
        bit     $FA2A
L7A2A:  .byte   $AB
        .byte   $D3
        .byte   $D4
        jsr     L89A6
        rol     a
        .byte   $61
L7A32:  .byte   $02
        dey
        .byte   $63
        pla
        rol     L0F36,x
        .byte   $8F
        cmp     ($40),y
L7A3C:  plp
        bcs     L7A6C
        sbc     $67,x
        .byte   $1A
        stx     $34,y
        .byte   $03
        .byte   $44
        .byte   $04
        and     ($83),y
        .byte   $04
        brk
        and     ($C3),y
L7A4D:  rti

        .byte   $32
L7A4F:  lda     ($F8),y
        .byte   $32
        ldx     #$C0
        .byte   $32
        .byte   $52
        clc
        .byte   $36
L7A58:  stx     $0C,y
        and     ($B4,x)
L7A5C:  asl     a
        .byte   $20
        .byte   $E1
L7A5F:  .byte   $B2
        asl     $21
        ora     L4127,y
        .byte   $82
        .byte   $1B
        .byte   $D3
L7A68:  .byte   $FC
        .byte   $47
        ora     $4F,x
L7A6C:  .byte   $80
        beq     L7A4F
        .byte   $22
        rts

        cpx     #$5E
        ldx     $09
        inx
L7A76:  .byte   $9E
        sbc     ($A0,x)
        .byte   $A0
L7A7A:  tya
        ldy     $06
        bmi     L7A5F
L7A7F:  inx
        rts

        .byte   $02
        .byte   $04
        .byte   $9E
        .byte   $1A
        ldy     #$15
        stx     $A6A3
        rol     a
        ldy     L8D08
        .byte   $5F
        .byte   $80
        and     $0D
        lsr     L5A94
        .byte   $BB
        .byte   $43
        lsr     $A2
        .byte   $80
        rts

        .byte   $8B
        ora     $E2
L7A9E:  .byte   $A7
        bpl     L7A2A
        .byte   $5C
        adc     ($84),y
        .byte   $02
        rol     $8A,x
        txa
        sta     ($D1),y
        inc     L4209
        sed
        bit     $A6
        php
        cmp     L3A6C
        sbc     ($88,x)
        rti

        ora     ($C0),y
        bit     $54
        ldx     L80AE
        .byte   $42
        .byte   $D3
        eor     ($52),y
        rol     a
        sty     $ACA3
        rol     a
        txs
        adc     L4504,y
        bmi     L7B02
        bpl     L7A7A
        .byte   $C7
        ora     $6C,x
        .byte   $12
        ldy     $D72E,x
        asl     L48C5
        bit     L4430
        .byte   $6B
        .byte   $C2
        .byte   $33
        .byte   $D4
        .byte   $74
        dec     L4A8F
        .byte   $43
        lsr     L3A50
        .byte   $6F
        ldx     $AD,y
L7AEB:  sbc     L8051,x
        lsr     a
        ldy     $C1,x
        cpy     $E8
        .byte   $E2
        sbc     $23
        .byte   $AB
        nop
        ora     $02,x
        inx
        .byte   $FA
        .byte   $04
        and     ($42),y
        .byte   $80
        txa
        .byte   $B1
L7B02:  sbc     $65,x
        cpx     #$22
        ror     a
        .byte   $22
        .byte   $07
        ldx     $E153
        sta     ($65),y
        .byte   $80
        eor     ($62),y
        cpx     #$A9
        adc     $80
        ldx     $8F76
        .byte   $E7
        lsr     $C4,x
        ora     ($28,x)
        ldx     L4210,y
        .byte   $04
        .byte   $7B
        .byte   $DB
        .byte   $EB
L7B24:  txs
        .byte   $FA
        cpx     $79
        inc     $B08E
        .byte   $A3
        .byte   $BB
        .byte   $D4
        cpx     $6D
        inc     $82
        .byte   $B9
L7B33:  .byte   $02
        ldy     $CA76,x
        .byte   $EF
        ora     ($4F,x)
L7B3A:  adc     $FBBD,x
        .byte   $9C
        asl     L81BE,x
        .byte   $FA
        sbc     $CF
        .byte   $A3
        jmp     (L06E3)

        .byte   $C7
        cmp     ($6C,x)
        .byte   $F4
        rol     $03,x
        .byte   $CF
        bne     L7B61
        and     ($6D,x)
        .byte   $B3
        stx     $38,y
        ora     $9C8D
        .byte   $72
        .byte   $0E
        .byte   $1A
L7B5C:  .byte   $9B
        adc     ($02),y
        and     ($A8,x)
L7B61:  .byte   $51
L7B62:  adc     ($01),y
        .byte   $54
L7B65:  txa
        .byte   $3D
        .byte   $C7
L7B68:  and     ($63),y
        .byte   $D2
        stx     $FA
        .byte   $13
        .byte   $A3
        bne     L7BD3
        and     $E802,x
        .byte   $30
L7B75:  cmp     $1E,x
        brk
        lda     $52
        sbc     $18,x
        ldx     #$40
        .byte   $23
        stx     $50,y
        .byte   $03
        sta     ($CA),y
        eor     ($4B,x)
        ldy     L436A
        ora     L3502,x
L7B8C:  beq     L7BEC
        ror     a
        .byte   $C7
        cpx     $0352
        .byte   $53
        sty     $F1
        bcs     L7BD0
        asl     $A8,x
        cmp     $ACB9,y
        sbc     ($69),y
        lsr     L80C9,x
        cpy     #$49
        sta     ($80,x)
        adc     L6941,y
        lsr     $2A,x
        sbc     ($9C),y
        lda     $6E,x
        .byte   $03
        ora     ($7A,x)
        sta     ($57),y
        ldx     L3FBC
        lsr     $9A
        bvc     L7B8C
        lda     L2086
        .byte   $AD
        .byte   $34
L7BC0:  .byte   $54
        bit     $17
        lsr     $CE
        lda     #$18
        adc     $3A
        .byte   $03
        .byte   $D3
        .byte   $2B
        sta     ($83,x)
        cpx     $86
L7BD0:  .byte   $AE
L7BD1:  cmp     ($40),y
L7BD3:  adc     $5C
        .byte   $6B
        .byte   $82
        .byte   $2B
        bne     L7BC0
        lsr     L6F6A
        .byte   $47
        lda     ($3E,x)
        plp
        eor     ($3D,x)
        .byte   $5F
        rti

        inc     $1F,x
        eor     ($37,x)
        sta     $E8,x
        .byte   $09
L7BEC:  plp
        ror     a
        .byte   $34
        ora     #$2A
        lsr     a:$2C,x
L7BF4:  lda     ($67),y
        .byte   $C3
        sta     ($19,x)
        pla
        .byte   $FA
        .byte   $13
        and     $0E,x
        .byte   $8F
L7BFF:  clc
        sbc     $AC05,x
        ldx     L2518,y
        .byte   $9B
        .byte   $C3
        .byte   $4B
        .byte   $1A
        .byte   $6B
        eor     $063E,x
        cpy     #$E0
        adc     #$A8
        sta     $65,x
        and     ($AD),y
        .byte   $02
        .byte   $C2
        sty     $0E,x
        asl     $82
        .byte   $10
L7C1D:  rol     $52
        .byte   $1A
        eor     ($B2),y
        php
        lda     ($1E,x)
        cpx     $34
        .byte   $7B
        sta     ($C0),y
L7C2A:  and     ($1C,x)
        .byte   $74
        .byte   $0B
        .byte   $72
        .byte   $8F
        .byte   $0B
        .byte   $54
        .byte   $74
        .byte   $02
        .byte   $07
        tax
        .byte   $32
        .byte   $13
        ora     #$20
        stx     $C0
        .byte   $A0
L7C3D:  bmi     L7BD1
        and     L4D52,x
        cpy     #$44
        .byte   $0F
        eor     L25E5
        .byte   $82
        cmp     ($ED,x)
        .byte   $5B
        .byte   $82
        sty     $94
        .byte   $1A
        .byte   $62
        .byte   $C7
        inx
        lda     L341E
        .byte   $91
L7C57:  brk
        cpy     #$1C
        lda     ($51),y
        rti

        rol     L7EAC,x
        cmp     $BE,x
        asl     $03
        lsr     $0E
        tax
        dey
        .byte   $2D
        .byte   $C5
L7C6A:  .byte   $83
        .byte   $1D
L7C6C:  cmp     L0060,x
        .byte   $82
        bcc     L7C8B
        .byte   $C7
L7C72:  ora     L7F99
        cli
        tax
L7C77:  .byte   $0E
L7C78:  ora     ($2F,x)
        adc     #$3E
L7C7C:  adc     $A957,y
        sec
        .byte   $FC
        ldx     $CF,y
        .byte   $CF
        .byte   $32
        ldy     $99,x
        .byte   $63
        .byte   $3F
        lsr     $C0,x
L7C8B:  adc     #$AC
        .byte   $C2
        jsr     LA829
L7C91:  sed
        .byte   $FC
        sty     $CF,x
        cpy     #$2F
        .byte   $3A
        rol     $F5
        .byte   $E2
        ldy     L8504
        .byte   $EF
        .byte   $83
        sty     $94
        .byte   $9C
        .byte   $4F
        .byte   $0B
        ora     ($8D,x)
        sei
        .byte   $F7
        .byte   $0C
        cmp     #$BE
        adc     $DB,x
        ora     #$03
        sbc     ($BE),y
        .byte   $2F
        .byte   $1C
        .byte   $7F
        adc     L4FC7,y
        .byte   $97
        bmi     L7CDE
L7CBB:  .byte   $8F
        .byte   $4C
L7CBD:  .byte   $62
        dec     L5FD1
        .byte   $1C
        adc     $FB
        .byte   $C2
        cpy     $33
        and     ($82,x)
        ora     ($3B,x)
        brk
        .byte   $C2
        and     $046D,y
        .byte   $3C
        adc     $C4DA,y
        sta     $43
        sta     ($B0,x)
        sed
        .byte   $27
        sta     $B877,x
        .byte   $D0
L7CDE:  ora     $0F,x
        ora     ($EF),y
        and     $DCC0,x
        sbc     L0806,x
        cmp     $2A,x
        txa
L7CEB:  ora     ($A8),y
        sbc     $79
        cpy     $D9
        beq     L7D30
        txs
        .byte   $8B
        .byte   $02
        cli
        dec     $68
        and     L6EAE
        sty     $36
        lda     L47BA,y
        bne     L7D70
        rol     $13,x
        eor     L81AB,x
        cmp     $E868
        .byte   $A6
L7D0C:  .byte   $7C
        .byte   $2B
        .byte   $66
L7D0F:  sta     ($E1,x)
        .byte   $F2
        stx     $9B51
        .byte   $1C
        and     L8421,x
        .byte   $62
        sta     L1410,y
        ldx     $49
        pla
        inc     L0AF5
        stx     $A0E0
        lsr     a
        .byte   $EB
        tya
        rol     L588E
        sta     ($8F),y
        .byte   $1A
        .byte   $BB
L7D30:  .byte   $81
L7D31:  sbc     ($A8,x)
        rol     $B5
        .byte   $57
        .byte   $54
        .byte   $7C
        txs
        .byte   $2B
        rol     a
        cmp     L5A82,y
        ror     a
        ror     $E834
        cmp     ($04,x)
        .byte   $02
        .byte   $B3
        .byte   $C3
        tsx
        .byte   $C2
        ldx     L412D,y
        inx
        cpy     $04
        .byte   $A3
        .byte   $43
        dec     $B8,x
        adc     $A209,y
        .byte   $9B
        stx     $9C,y
        adc     ($04),y
        eor     ($F5,x)
        .byte   $4B
L7D5E:  sta     $A8
        dec     $81,x
        .byte   $7A
        .byte   $CF
        nop
        bvs     L7DA3
        sbc     $27
        .byte   $0B
        ldx     $C847
        clc
        tay
        .byte   $A0
L7D70:  .byte   $04
        rti

        .byte   $5F
        and     $13,x
L7D75:  .byte   $A3
        cmp     ($64),y
        .byte   $56
L7D79:  .byte   $0C
        adc     $63,x
        .byte   $1C
        .byte   $D4
        ror     L8A3E
        brk
        .byte   $6B
L7D83:  .byte   $9F
        lda     $F5,x
        lsr     a
        and     #$B9
        .byte   $42
        .byte   $E3
        cli
        .byte   $22
        sty     $5A,x
        .byte   $3A
        .byte   $04
        .byte   $23
        sbc     #$34
        ror     $B9
        inc     L6DA7,x
        txs
        .byte   $73
        asl     $04,x
        asl     $AE
        sta     $8B,x
        lsr     $2B
L7DA3:  cpx     $B8
        ora     ($0B),y
        ldy     $2D
        ora     $10,x
        .byte   $8F
L7DAC:  tay
        .byte   $9F
        txa
        and     ($1A),y
        .byte   $34
L7DB2:  .byte   $23
        nop
        sta     ($30,x)
        iny
        .byte   $2F
        lda     ($E4),y
        .byte   $4F
        brk
        .byte   $0B
        sbc     $77,x
        and     L1F35
        lda     #$84
        lsr     $50,x
        ora     $08,x
        .byte   $50
L7DC9:  lsr     a
        ora     #$A0
L7DCC:  sta     $5E
        brk
        jsr     LE255
        .byte   $5D
        .byte   $44
L7DD4:  .byte   $A7
        .byte   $AB
        .byte   $80
        ora     ($AD,x)
        adc     L53D6,y
        .byte   $C7
        .byte   $0F
        eor     L815D
        .byte   $D4
        sed
        ora     #$62
        eor     L5582,y
L7DE8:  sta     $73,x
        .byte   $7A
        asl     a
        .byte   $DC
        cmp     L8301,x
        cmp     ($11),y
        .byte   $03
L7DF3:  sta     ($35),y
        eor     $C4,x
        adc     $6A
        cmp     ($8F),y
        .byte   $5E
L7DFC:  .byte   $7B
        rts

        sec
        lda     ($11,x)
        .byte   $03
        rol     $31,x
L7E04:  rts

        .byte   $D2
        .byte   $CF
        .byte   $80
        bit     $94
        .byte   $0C
        .byte   $27
        lsr     $3F,x
        eor     L5B63
L7E11:  lsr     $90,x
        lsr     L36BE,x
        beq     L7DB2
        .byte   $F2
        ldy     $A7
        .byte   $2F
        jsr     L4F88
        .byte   $A7
        .byte   $84
L7E21:  .byte   $84
L7E22:  php
        sty     $14
        bmi     L7E65
        .byte   $AF
        eor     ($00,x)
        dey
        lda     #$0F
        sta     ($91,x)
        sei
        lda     #$9A
        sta     $D7
        .byte   $C7
        adc     $16,x
        ldx     #$11
        .byte   $E9
L7E3A:  jmp     $47CC

        cli
        bpl     L7DD4
        .byte   $33
        .byte   $87
        .byte   $82
        lsr     a
        bvc     L7E48
        ldy     #$A0
L7E48:  eor     ($42,x)
        bvc     L7DFC
        bmi     L7E9E
        ldy     #$19
        tay
        stx     $A8,y
        .byte   $7C
L7E54:  bvc     L7E5C
        sty     L800A
        stx     $42
        rts

L7E5C:  rol     $28,x
        ora     $3B
        .byte   $DF
        .byte   $C7
        plp
L7E63:  clc
        .byte   $9D
L7E65:  .byte   $29
L7E66:  bvs     L7E8C
L7E68:  .byte   $AB
        sbc     #$8B
        php
        .byte   $AF
        ora     #$12
        .byte   $AF
        .byte   $87
        sty     $0E,x
        sec
        .byte   $80
        sty     $26
        lda     ($F1,x)
        asl     a
        .byte   $19
L7E7B:  nop
        .byte   $14
        .byte   $27
        .byte   $1B
        sta     ($A0,x)
        tya
        sbc     ($C5),y
        ora     ($B1),y
L7E86:  .byte   $E2
        .byte   $23
        tax
        .byte   $12
        ora     $01,x
L7E8C:  .byte   $54
        eor     $85
        .byte   $82
        bvs     L7E68
        sbc     #$44
        dey
        .byte   $47
        and     L7876
        .byte   $0F
        .byte   $39
        .byte   $79
L7E9C:  pha
        .byte   $42
L7E9E:  jsr     L3BA0
        sta     $58,x
        asl     $19
        .byte   $C2
        lda     ($6C,x)
        .byte   $0C
        .byte   $13
        .byte   $FD
        .byte   $1E
L7EAC:  and     ($C4),y
        .byte   $B9
L7EAF:  eor     #$83
        adc     #$C4
        .byte   $9C
L7EB4:  .byte   $13
        cmp     $0A
        .byte   $93
        .byte   $3A
L7EB9:  sta     L7930,x
        adc     $08
        rol     $E52A,x
L7EC1:  .byte   $0C
        .byte   $22
        .byte   $42
        cli
        ldy     $82,x
        .byte   $F3
        adc     $AE,x
        .byte   $9C
        lda     #$B8
        ror     a
        .byte   $1C
        .byte   $02
        brk
        cpx     L4ACA
        cpx     $BA56
        cpx     $04
        ldy     $EC
        lda     $48
        ldy     $DD
        .byte   $AF
        .byte   $23
        .byte   $5A
        bvc     L7EEE
        .byte   $57
        .byte   $4B
        and     L4139,x
        and     #$4D
        .byte   $80
L7EEC:  rol     $B1
L7EEE:  .byte   $6B
        cmp     ($19),y
        eor     $DB,x
        sbc     $FF79
        .byte   $FA
        .byte   $93
        .byte   $47
        cli
        tya
        .byte   $07
L7EFC:  plp
L7EFD:  sty     L5223
        bit     $05CB
        .byte   $33
        .byte   $9B
        rol     $A804,x
        .byte   $CF
        lda     ($0E,x)
        .byte   $44
L7F0C:  .byte   $D4
        dec     $03B7
        lda     ($7B),y
        .byte   $8F
        pha
        eor     $6E,x
        .byte   $3B
        .byte   $BB
        lda     ($A2),y
        .byte   $0C
        .byte   $F4
        .byte   $D4
        ror     a
        .byte   $CD
L7F1F:  .byte   $5C
        .byte   $52
        sta     $AD59,x
        cld
        .byte   $5C
        ora     $0735,x
        ldx     L28BA
        .byte   $F4
        ldy     $7A
        ldy     $59
        cmp     $03
        lda     ($C9),y
        .byte   $80
        pha
        .byte   $62
        stx     L54EF
        .byte   $82
        ror     a
        .byte   $62
L7F3E:  cpx     L60D9
        .byte   $20
L7F42:  cmp     $3030,y
        cmp     $3D02,y
        .byte   $CC
L7F49:  .byte   $23
        dec     $C52B,x
        ldx     #$2C
        cld
        clc
        .byte   $82
        lsr     $A2C0,x
        beq     L7F59
        .byte   $C2
        .byte   $65
L7F59:  .byte   $D2
        cmp     $9F3D,y
        .byte   $22
        .byte   $E2
        .byte   $22
        cmp     $05
        .byte   $02
        dec     $A4
        ldx     #$C8
        ora     $54
        iny
        ora     ($B9,x)
        cpx     #$E1
        .byte   $9B
        sty     $04A0
L7F72:  .byte   $CB
        ror     $04
        .byte   $CB
        .byte   $47
        cpy     $C6
        cpx     $04
        cmp     $84
        .byte   $64
        dex
        asl     $A4
        cpy     $BE07
        .byte   $3A
        lsr     $08,x
        .byte   $9B
        adc     L6C89
        .byte   $1F
        .byte   $80
L7F8D:  stx     $66,y
        brk
        .byte   $80
        stx     $51
        cpy     L623D
        bcs     L7FFD
        .byte   $A9
L7F99:  .byte   $80
        .byte   $04
        ora     $C0B4
        .byte   $0E
        .byte   $7E
L7FA0:  clc
        .byte   $14
        rti

        .byte   $1B
        clc
        bcc     L7F42
        ror     a
        jsr     L01BA
        lsr     a
        .byte   $2B
        .byte   $9D
        .byte   $FA
L7FAF:  sbc     ($C6),y
        cmp     $8F,x
        .byte   $DA
        .byte   $64
        ror     L841E,x
        adc     ($34,x)
        .byte   $42
        ora     #$A3
        .byte   $DC
        ror     a
        tsx
        .byte   $D4
        sbc     $49
        .byte   $32
        lda     ($72,x)
        .byte   $8F
        nop
        .byte   $FA
        sbc     L6A29
        .byte   $44
        stx     $EB
        cpy     #$D0
        php
        asl     $B2,x
        nop
        tsx
        .byte   $BF
        .byte   $04
        lda     ($DF),y
        .byte   $62
        .byte   $3A
        .byte   $EB
        adc     ($46,x)
        sbc     #$82
        iny
        .byte   $DF
        .byte   $8F
        .byte   $73
        sei
        bit     $8F37
        .byte   $42
        inx
        bit     $AB33
        .byte   $AF
        .byte   $54
        sei
        ldx     $CB37,y
        sbc     ($40),y
        and     #$BE
        rti

        sbc     L6651,x
        pla
L7FFD:  .byte   $FA
        .byte   $3B
        stx     $C2
        asl     $FB
L8003:  .byte   $8F
L8004:  ldx     L1DE9
        ldx     $C836,y
L800A:  sta     ($4B,x)
        .byte   $E2
        rti

        jmp     LD67C

        ldy     L43CC,x
        cmp     $66
        .byte   $D9
L8017:  and     $2C3A
        .byte   $04
L801B:  .byte   $D3
        .byte   $C1
L801D:  .byte   $63
        ora     L3120
        .byte   $3F
        .byte   $37
        tsx
        ldy     L4331,x
        .byte   $A1
L8028:  .byte   $A4
L8029:  pha
        plp
        asl     $9E,x
        .byte   $99
        tsx
L802F:  .byte   $59
L8030:  beq     $7FCC
        .byte   $44
        cld
        sbc     $B304,x
        .byte   $63
        .byte   $42
        adc     ($F8,x)
        .byte   $04
        .byte   $D4
        .byte   $3A
L803E:  .byte   $33
        eor     ($EB,x)
        .byte   $9B
        cpy     #$51
L8044:  .byte   $80
L8045:  .byte   $C2
L8046:  bvc     L8029
        .byte   $3A
        txs
        adc     #$5D
        .byte   $6B
        inc     $6C
        .byte   $8E
        .byte   $51
L8051:  bmi     L80B5
        eor     (L0060),y
        .byte   $FA
        lsr     $9A,x
        .byte   $F4
        asl     a
        php
        .byte   $8F
        .byte   $D0
L805D:  nop
L805E:  ror     a
L805F:  ldx     $B8
        adc     ($C4,x)
L8063:  .byte   $92
        txa
        .byte   $92
        sta     $5B
        sbc     ($E5,x)
        .byte   $67
        .byte   $80
        bmi     L80A7
L806E:  lda     $02BF,y
        .byte   $13
        cpy     $B6
        .byte   $47
        .byte   $90
L8076:  ldy     #$24
        dey
        ora     $B0C4
        .byte   $4F
        bvs     L8090
        sty     $BE
        asl     $C4,x
        .byte   $93
L8084:  ora     $71,x
        .byte   $9B
        cpy     #$1C
        pha
        .byte   $73
        ldy     $67
        .byte   $4C
        .byte   $DA
L808F:  .byte   $55
L8090:  pla
        .byte   $EB
        .byte   $12
        sta     L3743,y
        cpy     $B5
        .byte   $89
        lsr     $AA
        .byte   $0B
        cpy     $0517
        .byte   $82
        bvs     L808F
        lda     $C8,x
        bcs     L80E2
        .byte   $E5
L80A7:  .byte   $8E
L80A8:  lsr     $A1CA
        eor     $A65A,x
L80AE:  .byte   $8B
        .byte   $1A
        .byte   $93
        brk
        .byte   $62
        .byte   $34
        .byte   $2B
L80B5:  .byte   $42
        adc     L285D,y
        eor     #$A8
        pla
        eor     #$A8
        lda     L6777
        bpl     L8063
        cli
        .byte   $92
        sed
        cmp     #$AC
        .byte   $31
L80C9:  sbc     #$7B
        .byte   $9B
        .byte   $B3
        .byte   $02
        cmp     $E609
        stx     L5CF0
        .byte   $13
        .byte   $03
        dec     $24,x
        .byte   $A3
        .byte   $47
        .byte   $2B
        dec     $6C
        .byte   $82
        ora     ($8A,x)
        .byte   $02
        .byte   $2B
L80E2:  .byte   $E7
L80E3:  clv
        dey
        rol     $B6
        .byte   $4F
        dex
        cpy     $79
        lsr     a
        lda     L0C8D
L80EF:  jsr     L862D
        asl     a
        .byte   $B3
        beq     L8076
        .byte   $B7
        .byte   $9E
        eor     ($91,x)
        .byte   $5B
        .byte   $63
        stx     L7244
        sty     L10FC
        ldx     $A0,y
        brk
        .byte   $82
        ldx     $A0
        clc
        .byte   $CF
        iny
        .byte   $0C
L810C:  .byte   $FC
        php
        rol     $79,x
        sec
        asl     $00
        ora     ($36,x)
        .byte   $0C
        ora     ($04,x)
        .byte   $D4
        .byte   $52
        ora     $23
        bcc     L8145
        .byte   $22
        php
        .byte   $23
        ldy     L8044
        .byte   $57
        ror     $C1E6,x
        .byte   $55
L8129:  .byte   $FB
        .byte   $37
        .byte   $82
        .byte   $B3
        eor     ($59,x)
        cmp     #$58
        and     $9403,x
        sbc     $43
        .byte   $12
        .byte   $F4
        .byte   $F4
L8139:  sta     ($C1,x)
        bit     $32
        cli
        .byte   $F4
        inc     $CD,x
        dey
        sbc     L4A86,x
L8145:  .byte   $D7
        clv
        .byte   $F7
        .byte   $03
        ldy     $E3
        .byte   $04
        and     $9B
        ora     $EA,x
        .byte   $2F
        ora     $E370,x
        .byte   $5F
        .byte   $3B
        .byte   $80
        and     L433B
        cmp     L5A8E
L815D:  jmp     L30E0

        tax
        tsx
        .byte   $C0
L8163:  sbc     #$E9
        sbc     L7EAF
        cli
        .byte   $BF
        .byte   $07
        lda     $A0
        .byte   $AF
        .byte   $7C
L816F:  sei
L8170:  .byte   $FA
        .byte   $B3
        sbc     ($FA,x)
L8174:  ldx     $71
        pla
        sbc     $E5
        stx     L7A58
        ora     $05E5
        .byte   $A3
        dey
        rol     $C7,x
        eor     $40,x
        cpy     $FD58
        ldx     $02EB
        .byte   $80
        sbc     $E966,x
        .byte   $5C
        .byte   $BD
        .byte   $02
L8192:  .byte   $44
        bit     $E9DC
        cld
        ror     $8F88
        bvc     L81BC
        sei
        sta     ($03),y
        cmp     $10
        ora     L1025
        and     #$AC
        sbc     #$9B
        .byte   $1A
L81A9:  ldy     $DC,x
L81AB:  dey
        adc     ($7F,x)
        lda     #$00
        adc     L805E,x
        and     $30,x
        nop
        .byte   $84
L81B7:  brk
        dec     $02,x
        .byte   $80
        .byte   $D6
L81BC:  cpy     #$53
L81BE:  jmp     L2371

L81C1:  eor     ($94,x)
        .byte   $4D
L81C4:  .byte   $53
        ldx     $85,y
        .byte   $8F
        bmi     L8247
        .byte   $2F
        .byte   $0E
        .byte   $AC
L81CD:  ora     L6C57
        bmi     L81EF
        lsr     $9D
        ora     ($15,x)
        .byte   $C2
        cmp     L755A,x
        .byte   $DC
        lsr     L30A8,x
        ora     $C88D
        cmp     $28,x
        and     $D04A
        .byte   $03
        jmp     L518D

        .byte   $6B
        pha
        ldy     #$0E
        .byte   $0C
L81EF:  jsr     L4C11
        lda     ($01),y
        sta     ($82),y
        lsr     a
        .byte   $74
        ror     $AF,x
        bcs     L81C4
        .byte   $FB
        cmp     $B3,x
        sbc     ($1C,x)
        sty     L6458
        php
        sbc     $A2,x
        asl     $C3,x
        .byte   $D3
        .byte   $54
        asl     a
        ldy     $82,x
        .byte   $E3
        .byte   $E7
        bvs     L8212
L8212:  lda     #$1A
        txa
        .byte   $F2
        adc     #$B2
        and     $9143
        sta     $79
        ldy     $87
        cli
        .byte   $73
        .byte   $02
        .byte   $5A
        .byte   $F3
        .byte   $9F
        eor     L501F,x
L8228:  .byte   $1D
        .byte   $46
L822A:  lda     $5E
L822C:  stx     $9F,y
        rti

        lsr     $1F,x
        eor     ($D5,x)
        sbc     $01
        eor     ($AD),y
        eor     $9F16,x
        eor     ($AD),y
        lsr     L731B,x
L823F:  ror     $E8
        .byte   $FA
        .byte   $04
        bcs     L823F
        txa
        .byte   $0C
L8247:  cli
        eor     ($89),y
        .byte   $72
        and     ($50,x)
        .byte   $7B
        dec     $9D
        txs
        .byte   $DB
        .byte   $54
        .byte   $D9
L8254:  lsr     $FA83
L8257:  txa
        .byte   $57
        .byte   $BF
        .byte   $85
L825B:  .byte   $CB
        cmp     ($39),y
        .byte   $6D
L825F:  sbc     $39,x
        .byte   $63
        .byte   $5A
        ldy     L40FE,x
        eor     ($3D,x)
        pha
        pla
        .byte   $42
        bmi     L8212
        cmp     ($8D),y
        ora     ($0A,x)
        ror     $9448
        .byte   $24
L8275:  .byte   $42
        .byte   $AF
        eor     ($D3,x)
        asl     a
        and     (L00F9),y
        lsr     $88
        bit     $AC60
        asl     $DA86
        bpl     L82B1
        cmp     ($6A,x)
        .byte   $37
L8289:  sbc     $68,x
        sta     $AF
        .byte   $07
        .byte   $5A
        .byte   $7A
L8290:  .byte   $63
        .byte   $82
        ora     $87
        lsr     $05
        .byte   $82
        .byte   $04
        ora     #$84
        brk
        cpx     $D4F7
        .byte   $A7
L829F:  .byte   $87
        .byte   $4B
        .byte   $DC
        .byte   $E2
        .byte   $3E
        .byte   $0E
L82A5:  ora     ($19,x)
        cmp     $C9,x
        eor     ($85),y
        lda     #$EF
        tax
        .byte   $A7
L82AF:  .byte   $3E
        .byte   $F0
L82B1:  jmp     L8A82

        rts

        .byte   $5C
        .byte   $54
        cpy     #$00
        bmi     L82C1
        .byte   $12
        sta     $02
        .byte   $63
        dey
L82C0:  .byte   $3E
L82C1:  .byte   $3C
        lsr     $79
        .byte   $47
        sta     $23
        inx
        .byte   $80
        sty     $E2,x
        .byte   $0C
        .byte   $A3
        .byte   $F4
        .byte   $14
        ldy     #$62
        bmi     L825F
        eor     ($0A,x)
        .byte   $5A
        .byte   $A3
        sta     $28,x
L82D9:  .byte   $54
        stx     $9D,y
        rol     $E251
        lsr     a
        .byte   $8B
        .byte   $34
        ror     a
        .byte   $7B
        .byte   $C7
        .byte   $89
        .byte   $47
        .byte   $C2
        adc     $5B,x
        sbc     #$D4
        eor     ($1E),y
        sta     $A3C3,y
        ldx     #$C7
        .byte   $6F
        .byte   $34
        .byte   $72
        .byte   $62
        brk
        .byte   $82
        rts

        clv
        sty     L3C08
        stx     $36,y
        pha
L8301:  cpy     #$67
        sbc     ($46,x)
        ror     L1C02,x
        rti

        .byte   $13
        rti

        .byte   $14
        .byte   $53
        and     $E787,y
        lda     #$82
        sty     $6E
L8314:  lda     ($4D,x)
        bpl     L82D9
L8318:  .byte   $36
L8319:  .byte   $EB
        cmp     #$1E
        tsx
        sty     $DD
        .byte   $37
        .byte   $8F
        adc     ($3D),y
        cli
        sty     L14A4
        asl     $02
        .byte   $A7
        lda     $08
        .byte   $72
        .byte   $9C
        .byte   $A7
        .byte   $89
        .byte   $80
        rti

        sbc     L0953,y
        ror     a
        inc     $DCA3
        sec
        .byte   $52
        .byte   $C3
        tsx
        jmp     (L8453)

        .byte   $8F
        ldy     L13A0
        cpx     $F47A
        cmp     ($EC,x)
L8349:  .byte   $74
        .byte   $62
        .byte   $8F
        ldx     #$8B
        .byte   $0F
        lsr     a
        .byte   $F4
L8351:  .byte   $47
        .byte   $AB
L8353:  inx
        cmp     $FE,x
        .byte   $14
        lda     $00
        asl     L5E6B
        .byte   $34
        .byte   $82
        asl     $A6,x
        bcc     L839F
        .byte   $C9
L8363:  inx
        and     ($61,x)
        inx
        and     ($7A,x)
        asl     $B59A,x
        .byte   $E7
        ldy     $71,x
        txa
        sta     ($47,x)
        .byte   $59
L8373:  cmp     ($AA,x)
        .byte   $FC
        adc     L473F,x
        .byte   $74
        .byte   $74
        eor     $58,x
        jsr     L6511
        cmp     $5D
        sbc     L5888
        .byte   $7D
L8386:  eor     $52,x
        ora     ($54),y
        .byte   $5C
        lsr     a
        .byte   $57
        tay
        jsr     L873D
        .byte   $D4
        .byte   $7E
        .byte   $F2
L8394:  .byte   $97
        .byte   $83
        cmp     $D1,x
        eor     $78,x
        eor     $84
        cli
        eor     $5E
L839F:  inc     $5A,x
L83A1:  adc     ($F7,x)
        .byte   $57
        .byte   $5C
        .byte   $7B
        .byte   $DB
        .byte   $6B
        .byte   $5D
L83A9:  cmp     $A97C,x
        .byte   $34
        sei
        sta     $C7D8,y
        bcs     L83D8
        .byte   $7C
L83B4:  rol     L5001,x
        .byte   $FF
        lsr     L805F,x
        asl     $56,x
        .byte   $B7
        .byte   $C3
L83BF:  .byte   $7B
        .byte   $C2
        sei
        and     $C617,x
        ldx     $D7,y
        .byte   $C2
L83C8:  ldy     $C4,x
        jmp     (LEA78)

        .byte   $DA
        lsr     $02,x
        .byte   $F2
        sta     ($DB,x)
        rol     $D5,x
        sbc     $79,x
        .byte   $5E
L83D8:  .byte   $9E
        ldy     #$75
        .byte   $7B
        bne     L83E0
        .byte   $2B
        .byte   $57
L83E0:  bne     L8427
        .byte   $B7
        bne     L840C
        plp
        dey
        ora     $F815
        ldx     $0A,y
        .byte   $57
        .byte   $27
        bne     L842E
        tay
        .byte   $63
        sei
        ora     $A8A6,y
        ldy     #$05
        cpx     #$7D
        .byte   $F2
        clv
        bpl     L8455
        .byte   $DC
        .byte   $2F
        asl     $36,x
        .byte   $37
        .byte   $89
        tax
L8405:  .byte   $02
        sec
L8407:  .byte   $13
        adc     $ED
        .byte   $2C
        rts

L840C:  lda     $08
        clc
        .byte   $61
L8410:  dec     L393F
        inc     $C4
        .byte   $86
L8416:  .byte   $EF
        .byte   $AB
        rti

        .byte   $E3
        .byte   $9B
        asl     $E34B
L841E:  sbc     ($8F),y
        .byte   $3F
L8421:  and     $C1A8,y
        dec     $CF62,x
L8427:  ldy     $D0,x
        .byte   $3F
        .byte   $C7
        sec
        .byte   $2E
        .byte   $ED
L842E:  cli
        .byte   $77
        lda     $FED3,x
        sbc     $5F
        .byte   $1C
        ldy     $C1
L8438:  ora     ($BD,x)
        tya
        eor     (L00F9,x)
        .byte   $47
        ora     ($2B,x)
        .byte   $FB
        lsr     L4F01,x
        asl     a
        .byte   $34
        nop
        .byte   $9F
        ldy     $C3E6
        .byte   $AB
        asl     L6A20
L844F:  lsr     L6AE1,x
        .byte   $9F
L8453:  .byte   $5E
        .byte   $A5
L8455:  and     L53CB
L8458:  .byte   $7A
        .byte   $77
        lda     L4FE2
        bvs     L8405
        .byte   $4F
        jsr     L43C1
        inc     $EB,x
        sbc     ($C4,x)
        stx     $F5
        bit     $05
        and     $26,x
        lsr     L64B6
        lda     ($3E,x)
        lda     L5C46,x
        pha
        adc     $AA
        eor     ($80),y
        .byte   $B3
        .byte   $67
        sbc     L3665
        .byte   $62
        sta     $E2
        stx     $B905
        sbc     ($1A),y
        ror     a
        stx     $23,y
        .byte   $53
        .byte   $1B
        and     $EC
        .byte   $C3
        bne     L84A9
        rts

        clv
        adc     ($A8,x)
        .byte   $F3
        ora     L3D6E,x
        bcs     L841E
        cpy     $03C1
        .byte   $2F
        cpx     #$60
        .byte   $27
        .byte   $3A
        adc     $97,x
        and     ($D6),y
        dec     $20
L84A9:  .byte   $8B
        .byte   $0C
        txs
        .byte   $A3
        eor     $A1AB
L84B0:  .byte   $83
        .byte   $E3
        dec     $A3
        .byte   $80
        lsr     $C05A
        .byte   $9C
        .byte   $03
        lsr     $A4
        .byte   $2E
        .byte   $9E
L84BE:  txs
        ldx     #$8C
        dex
        rts

        .byte   $4F
        lda     #$2A
        .byte   $54
        bit     $43
        stx     $C1ED
        jsr     LE596
        cpy     #$A3
        .byte   $49
L84D2:  .byte   $DC
        .byte   $9F
        ldx     $AF7B
        .byte   $82
        ror     L229D
        .byte   $C3
        .byte   $1A
        jmp     (LCC9C)

        .byte   $C2
        .byte   $02
        bcc     L8525
        .byte   $47
        .byte   $C2
        .byte   $9C
        and     $C101,x
        .byte   $2F
        asl     L46C1
        .byte   $02
        cmp     L3A37,x
        .byte   $D4
        ldx     #$0A
        .byte   $54
        bit     $E1
        lsr     $CA15,x
        bmi     L84BE
        .byte   $5A
        clc
        sta     L8290,x
        .byte   $5E
        .byte   $A9
L8504:  ora     $DB9E,y
        .byte   $77
        .byte   $3D
        .byte   $D3
L850A:  adc     ($42),y
        cpy     #$9C
        and     $81,x
        sbc     $A159,x
        lsr     $BB
        .byte   $81
L8516:  sbc     ($44),y
L8518:  sty     $9A
        .byte   $FA
        asl     $906F
        .byte   $23
        .byte   $14
        .byte   $3C
        ora     #$D2
        asl     $88,x
L8525:  and     ($95),y
        lda     $BD
        cmp     $C1
        .byte   $1B
        beq     L850A
        sta     $9635,x
L8531:  nop
        cpy     #$3E
        plp
        .byte   $1B
        .byte   $5F
        rti

        ldy     $F2EF
        dec     L2C7E
        cpx     $DF0A
        .byte   $4F
        .byte   $F2
        adc     $82,x
        .byte   $37
        .byte   $9B
L8547:  .byte   $0F
        tay
        bpl     L8556
        .byte   $8F
        .byte   $3A
        .byte   $7B
        and     L30B5,y
        tya
        .byte   $B7
        .byte   $3A
        .byte   $73
        .byte   $63
L8556:  bvc     L85BF
        .byte   $3C
        .byte   $C2
        .byte   $93
L855B:  .byte   $D2
        sty     $A9,x
L855E:  ldy     L1BAD,x
        .byte   $9C
        .byte   $E0
L8563:  cpy     #$43
        rti

        eor     ($51),y
        .byte   $47
        clc
        jmp     L7009

        .byte   $FA
        .byte   $0B
        brk
        .byte   $72
        .byte   $8B
        sbc     $67,x
        lsr     $82
        .byte   $C7
        .byte   $4F
        eor     L3452
        .byte   $F4
L857C:  .byte   $14
        .byte   $74
        dey
        .byte   $6F
        .byte   $63
        sbc     ($37,x)
        .byte   $4F
        rti

        .byte   $42
        adc     ($31),y
        eor     ($96),y
        .byte   $DF
        asl     $F8
        .byte   $24
L858E:  dec     $5C
        .byte   $CF
        bit     $A3
        .byte   $32
        .byte   $1A
        .byte   $67
        .byte   $80
        adc     ($20,x)
        txs
        .byte   $B2
        sbc     $0A,x
        .byte   $07
        rts

        .byte   $07
        sty     $5D,x
        bne     L85E4
        bpl     L855E
        sta     L2C99
        sbc     $30,x
        .byte   $74
        .byte   $CD
        .byte   $4C
L85AE:  sbc     ($16),y
        sei
        ora     $C4
        dec     L31CD
        rti

        .byte   $83
        .byte   $92
        jsr     L9919
        stx     $D46B
L85BF:  and     $B09D
        .byte   $9C
        sei
        .byte   $73
        sty     $DC
        rts

        lda     ($3E),y
        .byte   $82
        dec     L410F,x
        .byte   $04
        cmp     L6F05,x
        jsr     L5916
        ldy     #$76
        .byte   $A7
        .byte   $9B
        sty     $0151
        .byte   $17
        asl     L87E0
        asl     $96E0
        .byte   $14
L85E4:  .byte   $D6
L85E5:  .byte   $C0
L85E6:  ora     ($CA,x)
        .byte   $7A
        php
        iny
        .byte   $27
        cpx     #$94
        txa
        ror     $C909,x
        .byte   $27
        cpx     #$A4
        .byte   $9B
        bmi     L85E5
        plp
        asl     L2102
        .byte   $34
        .byte   $9F
        .byte   $82
        .byte   $33
        adc     #$F8
        and     $38
        .byte   $9F
        .byte   $82
        .byte   $73
L8607:  lda     #$F8
        and     #$3C
        .byte   $9F
        .byte   $82
        .byte   $B3
        cpx     #$E0
L8610:  .byte   $42
        .byte   $14
        .byte   $89
L8613:  sed
        .byte   $23
        lsr     a
        .byte   $9F
        .byte   $82
L8618:  .byte   $54
        cmp     #$F8
        .byte   $27
        lsr     L829F
        sta     $09,x
        sed
L8622:  .byte   $2B
        .byte   $52
        .byte   $9F
        .byte   $82
        cmp     $48,x
        cpx     L6221
        .byte   $9F
        .byte   $82
L862D:  rol     $49,x
        sed
        .byte   $25
L8631:  ror     $9F
        .byte   $82
        ror     $89,x
        sed
        and     #$6A
        .byte   $9F
        .byte   $82
        ldx     $C9,y
        sed
        and     L806E
        .byte   $42
        .byte   $17
        cmp     #$F8
        .byte   $23
        ror     L829F,x
        cli
        ora     #$F8
        .byte   $27
        .byte   $82
        .byte   $9F
        .byte   $82
        tya
        eor     #$F8
        .byte   $2B
        stx     $0E
        asl     a
L8657:  .byte   $23
        sty     $9F,x
        .byte   $82
        eor     $F869,y
        .byte   $27
        tya
        .byte   $9F
        .byte   $82
        sta     $E0A0,y
        .byte   $C2
        .byte   $5A
        .byte   $89
        sed
        .byte   $87
        .byte   $EC
        .byte   $E4
L866C:  .byte   $9E
        pha
        sta     ($AB,x)
        bvc     L86A6
        .byte   $EB
        .byte   $4F
        dec     $D1
        .byte   $34
        .byte   $83
        .byte   $6F
        lda     #$D9
        .byte   $93
        cpx     #$30
        ora     $C99E,y
        .byte   $34
        sbc     $A04F,x
        dec     $FA,x
        .byte   $FB
        cmp     ($50,x)
        cpx     L5411
        .byte   $6B
        lda     $F8,x
L8690:  rol     $C1,x
        .byte   $34
        dec     $3C,x
        adc     $26
        .byte   $53
        .byte   $D4
        .byte   $14
        bpl     L8706
        .byte   $17
        .byte   $03
        sbc     ($C1,x)
        ldy     #$89
        php
        sta     $F8,x
        .byte   $72
L86A6:  adc     ($A1),y
        dey
L86A9:  .byte   $62
        ldx     L116A
        .byte   $5F
        .byte   $32
        sty     $56
        and     #$D7
        cmp     L0DFE
        .byte   $4F
        .byte   $0B
        cmp     $3D,x
        .byte   $8B
        eor     ($20,x)
        sty     $C6
        and     ($8F),y
        .byte   $47
        lda     L493B,x
        .byte   $22
        eor     $D4
        ror     $D3,x
        .byte   $82
        sty     $7E
        .byte   $D3
        .byte   $A7
        pla
        and     ($9A,x)
        bcs     L86FC
        .byte   $80
        ror     $28
        cli
        and     $6F,x
        bpl     L8741
        ora     $B500,x
        .byte   $E2
        .byte   $64
        sbc     $21
        iny
        and     #$C9
        lda     $FFC0,y
        .byte   $CF
        .byte   $9C
        bpl     L86F9
        nop
        .byte   $3C
        nop
        cpx     $EB
        .byte   $44
        .byte   $EB
        ldy     $EE
        .byte   $DC
L86F7:  .byte   $EB
        .byte   $AC
L86F9:  beq     L8690
        .byte   $A7
L86FC:  .byte   $FB
        tay
        rol     $68,x
        .byte   $42
        plp
L8702:  sty     $9B,x
        eor     $53
L8706:  lsr     $A4
        txs
        jmp     L43EA

L870C:  tsx
        .byte   $53
        .byte   $5A
        .byte   $63
        txa
        .byte   $6C
        tax
L8713:  adc     ($DA,x)
        sta     $65,x
        .byte   $D4
        .byte   $BB
        cmp     $5C,x
        lsr     $17,x
        lsr     $9F,x
L871F:  lsr     $A8,x
        dec     $AA,x
        lsr     $CF,x
        dec     $DC,x
        .byte   $D7
        .byte   $22
        cld
        .byte   $07
        cld
        .byte   $AF
        cli
        .byte   $EB
        .byte   $E2
        cpy     $AA
        cpy     $CCAE
L8735:  tsx
        cmp     $DD26
L8739:  .byte   $32
        cmp     $DD3E,x
L873D:  .byte   $42
        dec     $DCF6,x
L8741:  tsx
        cpx     $C6
        inc     $0A
        nop
        .byte   $02
        inc     $EDFA
L874B:  asl     $F0
        tax
        sbc     $FA92,y
L8751:  .byte   $03
        pha
        .byte   $1A
        cld
L8755:  .byte   $1A
        sed
        asl     a
        ror     $FCC1
        cmp     ($FF,x)
        cmp     ($59,x)
L875F:  brk
        bit     $C18B
        cmp     $10
        .byte   $0C
        .byte   $DC
        ldy     #$63
        .byte   $A7
        bne     L876F
        .byte   $1F
        eor     ($C4,x)
L876F:  asl     L505F
        .byte   $0F
        .byte   $27
        .byte   $A3
        sbc     L3C7D
        .byte   $D7
L8779:  .byte   $0F
        cmp     #$74
        rol     $C325,x
        cmp     #$AC
        .byte   $F3
        and     $3B,x
        .byte   $7D
        .byte   $3D
L8786:  .byte   $DC
        .byte   $4F
        ldy     $EC,x
        sbc     $FBE8
        php
        .byte   $CF
        tay
        php
        sed
        bne     L87E3
        stx     $67
        rol     $C7D2,x
        .byte   $FA
        .byte   $FF
        cpy     #$21
        .byte   $02
        ldy     $0C,x
        brk
        .byte   $1C
        rol     $98,x
        eor     ($BC),y
        .byte   $79
L87A7:  .byte   $3A
        sed
        rti

        .byte   $DB
        cld
        sbc     ($B9,x)
        asl     a
        .byte   $14
        plp
        .byte   $14
        asl     a
        .byte   $37
        .byte   $27
        .byte   $1F
        eor     $C7ED,y
        bvc     L87BE
        lsr     $DE
        .byte   $66
L87BE:  sty     L204A
        bvs     L874B
        .byte   $D7
        cpy     $03
        .byte   $C7
        .byte   $1F
        brk
        .byte   $0C
        ora     $E1A2,y
        .byte   $D7
        dec     $77
        cpy     $78
        .byte   $7C
        .byte   $44
        adc     $F1,x
        txs
        .byte   $80
        asl     $1A,x
        iny
        .byte   $CF
        ror     L223E,x
        .byte   $35
L87E0:  sta     ($51),y
        .byte   $31
L87E3:  .byte   $9F
        .byte   $1C
        adc     ($40),y
        .byte   $67
        lsr     L7161
        .byte   $F3
        sbc     ($F0,x)
        brk
        lda     ($E5,x)
        lda     ($D7),y
L87F3:  .byte   $CF
        .byte   $53
L87F5:  .byte   $1B
        .byte   $DC
        inc     $82,x
        .byte   $DB
        .byte   $D3
        ldy     L0DC5,x
        .byte   $3C
        .byte   $27
        .byte   $B3
        .byte   $1F
        .byte   $89
        cmp     L41F1,x
        beq     L8859
        beq     L87A7
        ora     L0919,y
        .byte   $3C
        ldy     L7F0C
        sbc     ($44,x)
        sta     ($82,x)
        .byte   $62
        eor     ($A3,x)
        .byte   $A7
        ora     $04E2
L881C:  .byte   $6F
        asl     L8030,x
        .byte   $04
        .byte   $0F
        .byte   $0B
        .byte   $FC
        .byte   $EB
        .byte   $DB
        dec     $ABE1
        .byte   $87
        php
        .byte   $FB
        tax
        ldx     L8832,y
        .byte   $27
        .byte   $A9
L8832:  .byte   $1B
L8833:  sbc     $7B,x
        .byte   $3C
        .byte   $4F
        sty     $30
        .byte   $80
        cmp     L34BC,y
        cli
        .byte   $43
        jmp     (LC530)

        .byte   $64
        tax
        .byte   $22
        .byte   $92
        asl     $AA22,x
        ldy     L0A07
        .byte   $14
        .byte   $42
        .byte   $1C
        .byte   $23
        .byte   $A7
        .byte   $E2
L8852:  .byte   $AF
        .byte   $83
        brk
        txa
        txa
        .byte   $0C
        .byte   $14
L8859:  bit     $A1
        beq     L87F5
        brk
        php
        ora     $E001,y
        .byte   $D7
        .byte   $83
        .byte   $07
        asl     L240D,x
        .byte   $7C
        and     ($7E),y
        .byte   $97
        dec     L6D40
        sei
        .byte   $31
L8871:  inc     $AF,x
        stx     L3BB8
        and     $FDBA
        .byte   $F2
L887A:  sed
        sbc     ($BF,x)
        .byte   $89
        .byte   $82
        asl     L3C18
        jsr     L7E3A
        cmp     $7E
        .byte   $32
        bpl     L88C4
        bne     L889C
        inx
        .byte   $43
        .byte   $8F
        .byte   $7A
L8890:  .byte   $8B
        dey
        .byte   $0F
        .byte   $0C
        ora     L6E7C
        .byte   $7B
        brk
        sec
        .byte   $A3
        .byte   $EB
L889C:  .byte   $F7
        lda     #$8E
        cpy     $BCFE
        .byte   $22
        .byte   $3A
        beq     L8890
        .byte   $03
        ldx     $8F
        .byte   $2F
        dey
        .byte   $0F
        asl     $8E09
        sec
        .byte   $22
        and     L1C32,x
        php
L88B5:  .byte   $3C
        bcc     L88EF
        .byte   $8F
        .byte   $0F
        .byte   $5D
        .byte   $12
L88BC:  .byte   $14
        .byte   $1A
        brk
        ldy     #$90
        asl     $E781
L88C4:  dec     $19,x
        ora     ($1B),y
        ora     $05,x
        .byte   $5B
L88CB:  .byte   $87
        .byte   $C1
L88CD:  .byte   $63
        eor     #$5A
        ora     $54
        ora     L1A50,y
        cli
        .byte   $07
        sed
        .byte   $73
        ldy     L7818,x
        pha
        clc
        bvs     L88E3
        eor     L1F57,y
L88E3:  .byte   $03
        .byte   $CF
        bcc     L8919
        ora     L0C34
        rol     L0C54,x
        .byte   $BC
        .byte   $06
L88EF:  .byte   $F3
        stx     $1D,y
        .byte   $07
        txs
        sta     ($85,x)
        .byte   $42
        sta     ($86,x)
        .byte   $C7
L88FA:  cmp     ($89,x)
        bvc     L8910
        .byte   $02
        sec
        bmi     L88CB
        ora     ($C1),y
        bpl     L890A
        .byte   $07
        .byte   $83
        .byte   $70
L8909:  cli
L890A:  clc
        .byte   $8B
        .byte   $04
        .byte   $93
        .byte   $0E
        .byte   $15
L8910:  ora     $6C
        .byte   $1C
        .byte   $63
        tax
        .byte   $42
        .byte   $07
        .byte   $80
        .byte   $DD
L8919:  ldx     L2307,y
        rti

        .byte   $34
        .byte   $92
        bne     L8927
        sta     ($2E,x)
        .byte   $0E
L8924:  eor     $80
        .byte   $A0
L8927:  and     L7A5C
        .byte   $0C
        bit     L2ABA
        beq     L88B5
        .byte   $77
        txa
        ldy     $18,x
        .byte   $27
        .byte   $3B
        eor     $C82C
        .byte   $E7
        asl     a
        ldy     $2A,x
        plp
        lda     ($5C),y
        .byte   $6B
        .byte   $5C
        brk
        plp
        sta     L8394,y
        ora     $41
        ora     $9F,x
        cpx     #$13
        .byte   $CF
        .byte   $63
        ora     #$C9
        .byte   $A1
L8952:  .byte   $3B
        .byte   $E7
        .byte   $9C
        stx     $5A,y
        asl     $18,x
L8959:  ora     ($41),y
        adc     $E1
        eor     #$FD
        adc     ($01,x)
        asl     $01,x
        sty     $78,x
        jsr     L505A
        .byte   $52
        .byte   $7F
        sed
        .byte   $52
        plp
        bvs     L89C9
        rts

        .byte   $5B
        tax
        .byte   $14
        .byte   $0B
        rti

        lda     L145F
        cli
        dec     $A9,x
L897B:  cld
        .byte   $9F
        inc     $1D,x
        .byte   $10
L8980:  .byte   $B3
        asl     L4F13
        txa
        .byte   $4F
        sed
L8987:  bmi     L89A1
        ldy     $04
        .byte   $8F
        cmp     ($80),y
        ora     #$EB
        .byte   $C7
        .byte   $0C
        .byte   $54
        .byte   $AB
        adc     ($FA),y
        cmp     ($5C,x)
        .byte   $54
        .byte   $CF
        .byte   $9C
        ror     L5297,x
        .byte   $AF
        .byte   $97
        .byte   $F6
L89A1:  .byte   $B3
        .byte   $0C
        .byte   $FC
        .byte   $BF
        tax
L89A6:  .byte   $B3
        cmp     $57,x
        .byte   $AF
        dec     $A94C
        ora     $04
        sty     $42
        .byte   $2F
        rol     $CC,x
        .byte   $0B
        .byte   $DA
        cpx     #$43
        .byte   $72
        .byte   $6B
        .byte   $FF
        ror     $6F,x
        ror     $F2FC,x
        .byte   $F2
        inc     L26F1
        eor     ($00,x)
        .byte   $B6
L89C7:  iny
        .byte   $10
L89C9:  .byte   $27
        dey
        .byte   $FC
        .byte   $44
        .byte   $23
        .byte   $10
L89CF:  .byte   $89
        .byte   $D7
L89D1:  .byte   $E2
        bit     $40
        .byte   $89
        .byte   $17
        .byte   $5F
        txs
        .byte   $43
        .byte   $3C
        .byte   $72
        inc     $9F5B,x
        .byte   $FB
        asl     $1F
        cpx     #$9C
        asl     a
        rts

        bmi     L89FF
        .byte   $0C
        asl     $03
        .byte   $07
        .byte   $FF
        .byte   $FC
        beq     L89CF
        .byte   $C0
L89F0:  .byte   $DA
        ldy     #$20
        .byte   $9F
        .byte   $27
        .byte   $07
        ora     ($06,x)
        brk
        .byte   $14
L89FA:  .byte   $14
L89FB:  .byte   $F2
        lda     #$D2
        .byte   $AC
L89FF:  dec     $DCBE,x
        .byte   $DF
        lsr     $9C,x
        php
        php
        asl     $7F
        ora     ($80,x)
        .byte   $EE
        .byte   $36
L8A0D:  .byte   $F2
        .byte   $CF
        .byte   $AF
        .byte   $A3
        .byte   $EF
        ora     L7D5E
        sbc     L7BFF,x
        .byte   $74
        .byte   $CB
        eor     L3FA7,y
        tya
        php
        and     $B4,x
L8A21:  .byte   $4B
        .byte   $D7
L8A23:  sbc     ($28),y
        .byte   $02
        eor     $A2,x
        .byte   $5F
        .byte   $1F
        bne     L8A46
        .byte   $7F
        .byte   $3F
        .byte   $9F
        .byte   $53
        .byte   $3B
        rol     $F087,x
        txs
        .byte   $CF
        .byte   $EF
        .byte   $FF
        .byte   $DF
        .byte   $CF
        .byte   $AF
        sta     ($98),y
        .byte   $41
L8A3E:  ldx     #$4D
        txa
        ora     $2F
        .byte   $9F
        .byte   $04
        .byte   $1D
L8A46:  lda     #$2C
        .byte   $DC
L8A49:  sta     $84
        ldx     L88CD
        dey
        asl     $78
        and     $16,x
        .byte   $83
        txa
        bcs     L8A23
        .byte   $A7
        ora     $B0E0,y
        beq     L8A0D
        bvs     L89F0
L8A5F:  .byte   $73
        .byte   $D7
        inc     L4FFF,x
        .byte   $BF
        lsr     L4DAF
        .byte   $8F
        cmp     L4089
        eor     ($F4,x)
        sbc     ($02),y
        .byte   $A7
        tay
        .byte   $4E
        .byte   $2E
L8A74:  rol     $26
        .byte   $13
        .byte   $4F
        .byte   $0C
        .byte   $6F
        .byte   $D4
        .byte   $5A
        .byte   $FF
        ror     L7EFD,x
        .byte   $FD
        .byte   $BF
L8A82:  .byte   $07
        .byte   $1F
        .byte   $0F
        ror     L0E44
        sed
        bit     $E4
        .byte   $FC
        .byte   $FF
        stx     $0B,y
        .byte   $67
        .byte   $27
L8A91:  pla
        brk
        .byte   $5C
        .byte   $3C
        bit     $1A
        txs
        dey
        asl     a
        asl     L7FAF
        .byte   $C3
        cmp     $BFB5
        ldx     L79A4,y
        .byte   $77
        .byte   $7F
        .byte   $83
        .byte   $82
        .byte   $3C
        .byte   $9F
L8AAA:  cmp     ($57,x)
        .byte   $F3
        .byte   $BB
        .byte   $F3
        .byte   $AB
        .byte   $F3
        .byte   $AF
        sty     $76,x
        .byte   $07
        .byte   $92
        and     $A3E0,x
        bcc     L8AC7
        .byte   $07
        bcs     L8AFC
        .byte   $3C
        .byte   $6B
        ora     #$C7
        .byte   $FF
        sed
        .byte   $1F
L8AC5:  tya
        .byte   $03
L8AC7:  .byte   $43
        eor     #$43
        adc     ($9B),y
        bit     $2A
        jsr     LE0D1
        and     L22E5,y
        .byte   $73
        cpx     $25
        ror     L7F3E,x
        dec     L3C6C,x
        .byte   $36
L8ADE:  .byte   $3A
        sec
        sec
        .byte   $3F
        .byte   $DC
        .byte   $42
        .byte   $7C
        cli
        jsr     LA158
        .byte   $03
        lda     $F37A,x
        bmi     L8AF6
        ror     $40,x
        bmi     L8ADE
        lda     #$FD
        .byte   $F9
L8AF6:  adc     #$EA
        sbc     $FFE9,y
        .byte   $7A
L8AFC:  eor     #$58
        eor     $69
        .byte   $AB
        .byte   $93
        .byte   $8B
        .byte   $E3
        .byte   $D4
        brk
        ora     L65A6
L8B09:  lda     $80,x
        ldy     L3444,x
        .byte   $64
        ora     $64
        eor     $41
        bvs     L8B15
L8B15:  cpy     $EB
        .byte   $0B
        .byte   $17
        .byte   $27
        .byte   $97
        eor     #$E5
        cpx     $93
L8B1F:  .byte   $3F
        stx     L1D5F
        .byte   $89
        sbc     $B549,x
L8B27:  iny
        .byte   $CF
        ldy     $C0,x
        .byte   $26
L8B2C:  dec     $42,x
        .byte   $D2
        .byte   $1A
        sbc     L195F,x
        .byte   $1F
L8B34:  .byte   $AF
        .byte   $FC
        sbc     L4081,x
        and     ($CF,x)
        .byte   $22
        bvc     L8B8B
        ora     L7E7B,x
        .byte   $74
        .byte   $BB
        .byte   $E3
        .byte   $FF
        .byte   $DF
L8B46:  .byte   $FC
L8B47:  .byte   $3D
        .byte   $DC
L8B49:  .byte   $77
        inc     L7DFC,x
        .byte   $FC
        .byte   $C2
        .byte   $34
        .byte   $03
        nop
        .byte   $44
        .byte   $0F
        asl     $83
        sed
        .byte   $92
        rol     $033E,x
        .byte   $D3
        .byte   $80
        ror     a
        brk
        cmp     (L0060),y
        jsr     L8045
        asl     a
        .byte   $89
        .byte   $EF
        .byte   $FF
L8B68:  .byte   $F4
        .byte   $E4
L8B6A:  .byte   $DA
L8B6B:  inc     $FFFE,x
L8B6E:  .byte   $E3
        .byte   $EF
        .byte   $C7
        .byte   $87
        beq     L8B68
        .byte   $80
        rti

        ldy     #$C0
        cpx     #$E8
        sed
        .byte   $FC
        .byte   $33
        .byte   $74
        .byte   $86
L8B7F:  .byte   $82
        .byte   $89
        ora     ($03,x)
        .byte   $94
L8B84:  sec
        sei
        adc     $FCFB,y
        .byte   $5B
        .byte   $79
L8B8B:  .byte   $FA
        sbc     $FAFB,y
        adc     L7BF4,y
        .byte   $7E
        .byte   $D1
L8B94:  .byte   $AB
        and     #$76
        bcc     L8B6A
        sbc     ($DD,x)
        sbc     L739B,y
        rti

        ora     $A712,y
        sty     $B0CB
        asl     $9F0F
L8BA8:  cpy     #$5C
        adc     L1D80
        asl     L4DF9
        ldy     L8004
        lda     L1E3E,x
        .byte   $CF
        .byte   $03
        .byte   $F7
        cpy     L5EF0
        .byte   $9C
        .byte   $2B
        .byte   $AC
L8BBF:  .byte   $F7
        lsr     $FAB3
        sbc     L58F4,x
L8BC6:  .byte   $FE
        .byte   $4F
L8BC8:  .byte   $FF
        .byte   $DF
        .byte   $CF
        .byte   $9F
        sty     L7531
        adc     $DB
        ldy     $5A,x
        .byte   $24
L8BD4:  cli
        sei
        jmp     L6D07

        and     L347E,y
        inc     $08,x
        .byte   $1F
        dey
        asl     $9E
        .byte   $77
        .byte   $E3
        beq     L8BC6
        beq     L8C48
        .byte   $7F
        rol     $98B8,x
        tya
        ora     $9858,y
        ror     a
L8BF1:  iny
L8BF2:  bvc     L8B94
        rti

        ora     ($0F,x)
        tya
        .byte   $CF
        .byte   $C7
        sta     $ABB3
        .byte   $0F
        ora     #$A7
        brk
        .byte   $27
        .byte   $DF
        beq     L8C22
        .byte   $2B
        bmi     L8BD4
        bcs     L8C1A
        ldy     #$11
        .byte   $23
        .byte   $13
        and     $3D
        asl     $4F,x
        .byte   $F4
        .byte   $81
L8C14:  .byte   $82
        asl     $28,x
        asl     $08,x
        .byte   $07
L8C1A:  ora     ($40,x)
        brk
        .byte   $43
        lsr     $40
        .byte   $99
        .byte   $B4
L8C22:  .byte   $0B
        jmp     L9219

        sta     $08
L8C28:  ora     L80E3
        bpl     L8C34
        .byte   $83
L8C2E:  asl     $01
        .byte   $04
        .byte   $44
        .byte   $ED
        .byte   $BE
L8C34:  .byte   $D3
        bit     L2CD1
        .byte   $D3
        .byte   $FF
        ror     $F72F,x
        .byte   $7C
        ldy     #$9F
        .byte   $3F
L8C41:  .byte   $4B
        bit     $1B
        sta     $D1
        .byte   $A7
L8C47:  tya
L8C48:  ora     ($28),y
L8C4A:  .byte   $5C
        rol     L5E72
        rol     L8A5F
        rol     L7495,x
        eor     ($C0,x)
        .byte   $27
        .byte   $F3
        .byte   $FA
        sta     L3E61
        ldy     L5578,x
        bcc     L8C14
        cmp     L47B3
        .byte   $5C
        .byte   $9B
        .byte   $7C
L8C67:  sbc     L8314,y
        .byte   $C3
        .byte   $5F
        .byte   $B7
        .byte   $DF
        .byte   $A7
        .byte   $DB
        .byte   $E7
        .byte   $F7
        inc     $FE7F,x
        .byte   $03
        .byte   $C3
        .byte   $FC
        .byte   $4D
        .byte   $B7
L8C7A:  txs
        .byte   $5C
        .byte   $FF
        sbc     ($E3,x)
        .byte   $9F
        .byte   $74
        ldy     $E7,x
        inc     L15C2
        tsx
        eor     L6EBE,x
        .byte   $03
        txa
        .byte   $9F
        sty     $D6D9
        brk
        cpy     $43
        sbc     ($82),y
        and     L552C
        .byte   $07
L8C99:  .byte   $3B
        .byte   $0B
        .byte   $54
        .byte   $8B
        .byte   $44
        .byte   $83
        .byte   $27
        rol     $06
        .byte   $04
        clv
        clc
        jsr     LD237
        .byte   $73
        ora     #$DC
        .byte   $E7
        rol     $0C
        bpl     L8CC2
        .byte   $14
L8CB1:  asl     $18,x
        .byte   $1A
        .byte   $1C
        .byte   $1F
        jsr     LE5A2
        and     $FCA7,y
        ora     $3C,x
        sbc     ($6D,x)
        sbc     ($EE,x)
L8CC2:  .byte   $27
        inc     $5A,x
        .byte   $C3
        lda     $A3,x
        .byte   $FF
        .byte   $FF
        cmp     ($00),y
        .byte   $47
        sed
        .byte   $D2
        ora     $D208
        ora     L1F07,x
        .byte   $CC
        .byte   $06
L8CD7:  beq     $8D10
        .byte   $FA
        cmp     #$4A
        brk
L8CDD:  .byte   $04
        .byte   $F4
        sta     ($FB),y
        iny
        cpy     #$00
        bne     L8CDD
        inx
        cpx     #$20
        beq     L8CF0
        inc     $FC
        .byte   $52
        rts

        .byte   $96
L8CF0:  .byte   $6B
        .byte   $BF
        inc     $02
        dec     $CC1F,x
        php
        .byte   $0C
        pla
        .byte   $14
        .byte   $87
        sty     $A5
        asl     a
        .byte   $7C
        .byte   $D4
        cpx     L8B46
        .byte   $27
        cld
        .byte   $0D
        .byte   $10
L8D08:  eor     $07
        sbc     $D705,y
        .byte   $FA
        bit     $51
        .byte   $0B
        bne     L8D7A
        and     $07FF,y
        .byte   $B3
        sbc     $ED8E,x
        .byte   $5F
        .byte   $F7
        .byte   $9B
        sty     $69,x
        .byte   $F4
        lda     L5F47,y
        .byte   $3B
        .byte   $94
L8D25:  asl     a
        dey
L8D27:  sta     ($F4,x)
        lda     $9E48,y
        ldx     L1856
        txa
        .byte   $7B
        cmp     ($8B),y
        eor     ($E6,x)
        cmp     L7B24,x
        bmi     L8CD7
        .byte   $04
        .byte   $14
        sbc     ($52),y
L8D3E:  .byte   $6F
        asl     a
        .byte   $9B
        .byte   $5F
        cpx     $AC82
        sty     $04
        cmp     $A1CE,y
        .byte   $01
L8D4B:  .byte   $02
        sty     L00F9,x
        php
        .byte   $2F
        sed
        cmp     $98,x
        asl     L8610,x
        .byte   $5C
        sta     $9F
L8D59:  tay
        rol     a
        ora     #$28
        adc     #$48
        and     #$46
        and     #$46
        .byte   $5F
L8D64:  pla
        .byte   $B3
        cmp     $DC
        clc
        ora     $4D,x
        .byte   $04
        jmp     (L1720)

        dex
        rti

        brk
        .byte   $7F
        .byte   $FF
        sbc     L0F30,x
        .byte   $FB
        rti

        .byte   $07
L8D7A:  .byte   $7F
        .byte   $FF
