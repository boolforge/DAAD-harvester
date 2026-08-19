; da65 V2.18 - Ubuntu 2.19-1
; Created:    2026-08-19 11:28:47
; Input file: preservation_corpus/extracted/depth1_20a1cd01_JABATO P.2
; Page:       1


        .setcpu "6502"

L003E           := $003E
L0056           := $0056
L0060           := $0060
L0081           := $0081
L00F9           := $00F9
L010A           := $010A
L0116           := $0116
L0180           := $0180
L0200           := $0200
L0211           := $0211
L0223           := $0223
L0225           := $0225
L0226           := $0226
L022F           := $022F
L0256           := $0256
L0278           := $0278
L02BC           := $02BC
L0304           := $0304
L0311           := $0311
L04A4           := $04A4
L0620           := $0620
L0760           := $0760
L077B           := $077B
L079B           := $079B
L8F39           := $8F39
L8F6B           := $8F6B
L9062           := $9062
L90DD           := $90DD
L910D           := $910D
L920B           := $920B
L9240           := $9240
L928D           := $928D
L92AD           := $92AD
L92C2           := $92C2
L942C           := $942C
L946A           := $946A
L94D4           := $94D4
L95C4           := $95C4
L95FB           := $95FB
L96C7           := $96C7
L974F           := $974F
L9828           := $9828
L9849           := $9849
L985A           := $985A
L98EE           := $98EE
L98F4           := $98F4
L990C           := $990C
L9930           := $9930
L9982           := $9982
L9A30           := $9A30
L9A8A           := $9A8A
L9A8D           := $9A8D
L9B09           := $9B09
L9BA0           := $9BA0
L9C17           := $9C17
L9C98           := $9C98
L9FBF           := $9FBF
L9FE2           := $9FE2
LA0D7           := $A0D7
LA158           := $A158
LA2D9           := $A2D9
LA7C7           := $A7C7
LA8A7           := $A8A7
LAAB1           := $AAB1
LABB1           := $ABB1
LAC03           := $AC03
LAC75           := $AC75
LAEEA           := $AEEA
LB03E           := $B03E
LB06E           := $B06E
LB43C           := $B43C
LB8A5           := $B8A5
LB9E9           := $B9E9
LBA72           := $BA72
LBAAB           := $BAAB
LBDD4           := $BDD4
LBE4E           := $BE4E
LC000           := $C000
LC081           := $C081
LC154           := $C154
LC17A           := $C17A
LC1D9           := $C1D9
LC23D           := $C23D
LC2BE           := $C2BE
LC341           := $C341
LC6D9           := $C6D9
LC767           := $C767
LC81E           := $C81E
LC8A9           := $C8A9
LC8DF           := $C8DF
LCA30           := $CA30
LCA35           := $CA35
LCB00           := $CB00
LCC2C           := $CC2C
LCD05           := $CD05
LCE7B           := $CE7B
LCEF2           := $CEF2
LD1F1           := $D1F1
LD2D5           := $D2D5
LD4BC           := $D4BC
LD57B           := $D57B
LD6FF           := $D6FF
LD7A2           := $D7A2
LDABA           := $DABA
LDB28           := $DB28
LDB94           := $DB94
LDC86           := $DC86
LDCCE           := $DCCE
LDE50           := $DE50
LE071           := $E071
LE0D1           := $E0D1
LE15A           := $E15A
LE2CC           := $E2CC
LE31C           := $E31C
LE38A           := $E38A
LE3B3           := $E3B3
LE3BF           := $E3BF
LE4BA           := $E4BA
LE61C           := $E61C
LE66D           := $E66D
LE6B3           := $E6B3
LE74E           := $E74E
LE8D3           := $E8D3
LE935           := $E935
LE9B6           := $E9B6
LEB3B           := $EB3B
LEB72           := $EB72
LEB99           := $EB99
LEBAE           := $EBAE
LF00D           := $F00D
LF0A9           := $F0A9
LF0FB           := $F0FB
LF12E           := $F12E
LF140           := $F140
LF1E3           := $F1E3
LF25F           := $F25F
LF2CA           := $F2CA
LF47C           := $F47C
LF818           := $F818
LF97A           := $F97A
LFA82           := $FA82
LFCF5           := $FCF5
LFFE4           := $FFE4
L0801:  ora     ($08,x)
        .byte   $0B
L0804:  php
        .byte   $EF
L0806:  brk
        .byte   $9E
        .byte   $32
        bmi     L0841
        and     ($00),y
L080D:  brk
        brk
L080F:  sei
        inc     $D030
        lda     #$38
        sta     $01
        ldx     #$34
L0819:  lda     L0842,x
        sta     $01FF,x
        dex
        bne     L0819
L0822:  ldx     #$CF
L0824:  lda     L0875,x
        sta     a:$F6,x
        dex
        bne     L0824
        ldy     #$86
L082F:  dex
L0830:  lda     L8E24,x
L0833:  .byte   $9D
        asl     a
L0835:  .byte   $CF
        txa
        bne     L082F
L0839:  dec     L0833
        .byte   $CE
        .byte   $30
L083E:  php
        dey
        .byte   $D0
L0841:  .byte   $ED
L0842:  jmp     L0116

        pha
        lda     L4A2A
        rol     a
        sta     $F7
        inc     $0202
        .byte   $D0
L0850:  .byte   $03
        inc     $0203
L0854:  pla
        rts

        inx
        txa
L0858:  asl     $F7
        bne     L085F
        jsr     L0200
L085F:  bcc     L0873
        inx
        cpx     #$08
        bne     L0858
        beq     L0873
        ldx     #$07
L086A:  inx
L086B:  asl     $F7
        bne     L0872
        jsr     L0200
L0872:  rol     a
L0873:  dex
        .byte   $D0
L0875:  sbc     $18,x
        rts

        .byte   $80
        .byte   $03
L087A:  sta     L0801
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
L0894:  jsr     L00F9
L0897:  ldy     #$00
        tya
        ldx     #$02
        jsr     L022F
        cmp     $F8
        bne     L088F
        jsr     L0211
        sta     $2D
        lsr     a
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
        ldx     #$01
        jsr     L0226
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
L08E0:  .byte   $20
L08E1:  sbc     $D000,y
L08E4:  .byte   $FB
        dey
        .byte   $D0
L08E7:  sed
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
        inx
L090A:  .byte   $B1
L090B:  and     $20C8
L090E:  sbc     $D000,y
        sed
        beq     L08E8
L0914:  lda     #$37
        sta     $01
        dec     $D030
        lda     $FA
        sta     $2D
        lda     $FB
        sta     $2E
        cli
        jmp     L080F

L0927:  .byte   $FF
        brk
        ora     $D1
L092B:  php
        .byte   $02
        ora     ($10,x)
        .byte   $04
        asl     a
        .byte   $93
        .byte   $DF
        .byte   $03
        ora     #$0D
        sta     L7F40
        tay
        jsr     L8880
L093D:  sbc     $06,x
        ora     $33,x
        .byte   $44
        txa
        bcc     L08E1
        .byte   $AD
L0946:  ora     $0108
        brk
        .byte   $9E
        .byte   $32
L094C:  bmi     L0984
        .byte   $33
        .byte   $3A
        .byte   $8F
        .byte   $DC
        .byte   $89
L0953:  txs
L0954:  bne     L098A
L0956:  rts

        .byte   $DA
        eor     ($01),y
        ldy     $46,x
        sbc     #$B8
        ora     #$3F
        .byte   $3B
        cpy     #$A3
        .byte   $AB
        rti

        dey
        and     $EBFF,y
        bvs     L096B
L096B:  .byte   $B4
L096C:  .byte   $02
        rol     a
        .byte   $42
        php
        ora     $EA,x
        lsr     L6C41
        bvc     L09B7
        .byte   $3A
        .byte   $47
L0979:  eor     L559D,x
        .byte   $22
        .byte   $30
L097E:  tay
        and     $26,x
        bne     L092B
        .byte   $5A
L0984:  cpx     #$65
L0986:  .byte   $D7
        sta     ($35,x)
        pha
L098A:  .byte   $BF
        .byte   $A7
L098C:  .byte   $A3
L098D:  rol     $BC
        asl     $A2
L0991:  .byte   $92
        rol     a
        pha
        ldy     L88BC,x
        and     ($07,x)
L0999:  .byte   $DA
        and     ($62,x)
        nop
        rti

        .byte   $21
L099F:  .byte   $63
        php
        ora     ($C7,x)
        .byte   $D3
        .byte   $1B
L09A5:  .byte   $42
        sec
        beq     L09C9
        .byte   $7C
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
        adc     $D631
        rts

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
        ora     $22,x
L09FF:  .byte   $0C
L0A00:  .byte   $B1
L0A01:  .byte   $BC
L0A02:  .byte   $74
        .byte   $80
        .byte   $32
        .byte   $C7
        .byte   $67
        rol     $B492,x
        and     $DC93,y
        .byte   $82
        adc     #$A5
        ror     $21
        .byte   $13
        .byte   $AF
        eor     ($3B),y
        .byte   $53
        .byte   $E2
        .byte   $80
        adc     ($AD),y
        ror     $A5,x
        pla
        rol     L4B26,x
        .byte   $4D
L0A22:  ldx     #$34
        rol     L43AA,x
        .byte   $E3
        lsr     $35
        rol     a
        .byte   $7C
        .byte   $23
        eor     ($93,x)
        inc     L3502
        .byte   $59
        .byte   $66
L0A34:  cmp     $3A,x
        .byte   $FF
        sta     L365C
        sta     $CF5D
        .byte   $80
        pha
L0A3F:  cmp     $3C,x
        .byte   $FB
        asl     a
        sta     L3662
L0A46:  .byte   $AD
        tya
L0A48:  sec
        sta     $D3
        cmp     $CA6C,x
        adc     L58FE,x
        sbc     $97CC,x
        .byte   $1B
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

        .byte   $8F
        and     $F33E,y
        .byte   $4B
        .byte   $93
        cpx     #$D3
        .byte   $34
        cmp     $AF
        .byte   $34
        .byte   $FB
        lda     L6C4D
        cmp     $2A,x
        .byte   $27
        lda     #$26
        .byte   $4F
L0A80:  sbc     $0581
        .byte   $62
        .byte   $7B
        bcc     L0AD9
        sta     $54,x
L0A89:  .byte   $80
        ldx     $64,y
        beq     L0AA1
        lda     ($98),y
        .byte   $AB
        adc     ($F8,x)
        .byte   $FB
        cmp     L8E32
        .byte   $23
        .byte   $7C
        inx
        .byte   $FB
        .byte   $4C
L0A9C:  .byte   $97
        rts

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
L0ABD:  rol     $BDD0,x
L0AC0:  bcs     $0AFB
        bmi     L0B3C
        sbc     $49,x
        asl     a
        lda     #$02
        .byte   $EB
L0ACA:  .byte   $EF
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
L0AE4:  ldx     $F5
        adc     $DEC7,y
        .byte   $69
L0AEA:  cpy     $7C
        .byte   $07
        .byte   $DA
        .byte   $32
        .byte   $83
        bne     L0ABD
        ora     $DE91,x
        rti

        pla
        .byte   $37
        .byte   $2D
        brk
L0AFA:  .byte   $FA
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
L0B13:  rol     $C6
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
        .byte   $52
        .byte   $61
L0B26:  tay
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
        sta     L4CE9
        ldx     $9482
        .byte   $C2
L0B44:  .byte   $52
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
        .byte   $86
L0B6C:  .byte   $74
        .byte   $7B
        cmp     $D975,y
        .byte   $6F
L0B72:  ldx     $65
        ora     $30
        eor     $E9
        .byte   $9C
        tax
L0B7A:  bmi     L0BBB
        .byte   $FC
L0B7D:  .byte   $01
L0B7E:  .byte   $73
        .byte   $22
        .byte   $5F
        rti

        rol     $B22F
        .byte   $63
        .byte   $D4
        .byte   $47
        and     $42,x
L0B8A:  ora     ($C3),y
        plp
        inx
        .byte   $B2
        sbc     L5C4C,x
        asl     a
        .byte   $A3
        nop
        tax
        plp
L0B97:  dec     $A3
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
        .byte   $1E
L0BAA:  sta     ($BD),y
        rti

        iny
        .byte   $FF
        .byte   $92
L0BB0:  .byte   $DB
        jsr     L3524
        rol     $50
        asl     a
        ora     $54
        .byte   $64
        .byte   $5C
L0BBB:  sbc     ($8B,x)
        and     #$22
        .byte   $21
L0BC0:  .byte   $AF
        .byte   $B2
        asl     $CEF4
        sbc     L4E2C,x
        and     ($00),y
        lsr     a
        .byte   $8B
        .byte   $92
L0BCD:  .byte   $E3
        ror     a
        .byte   $81
L0BD0:  sta     $34
        .byte   $97
        .byte   $32
        lda     $B21B
        eor     $46
        jmp     LE935

        .byte   $F7
        .byte   $52
L0BDE:  jmp     (LA7C7)

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
        ldy     L5E49
        ldy     $1D
L0C03:  asl     $9E
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
        .byte   $79
        .byte   $CB
L0C15:  .byte   $BB
        .byte   $FB
        rti

        eor     $D3,x
        cmp     $980C,x
        .byte   $F7
        sta     $3F
L0C20:  jsr     L1ED9
L0C23:  .byte   $C5
L0C24:  .byte   $3F
        bcc     L0C3B
        .byte   $74
        .byte   $04
        .byte   $42
        .byte   $96
L0C2B:  eor     $360F
L0C2E:  .byte   $B7
        .byte   $BE
L0C30:  .byte   $FC
        .byte   $3B
        clc
        eor     L4E78,y
        .byte   $D7
        .byte   $04
        .byte   $DC
        .byte   $14
        .byte   $E4
L0C3B:  .byte   $D7
        .byte   $63
        bcc     L0BC0
L0C3F:  .byte   $59
        .byte   $82
L0C41:  and     #$95
L0C43:  eor     ($7E,x)
        sta     $30DA,x
L0C48:  .byte   $C5
L0C49:  .byte   $34
        inc     L36BC
        inc     $C790
        .byte   $22
        bmi     L0C2E
        .byte   $D2
        .byte   $9F
        .byte   $C2
        sty     $8E,x
        .byte   $0C
        cmp     $10,x
        adc     #$B1
        and     #$1D
        pha
        lsr     $C9,x
        .byte   $9C
        .byte   $D1
L0C64:  .byte   $F4
        .byte   $B3
        adc     ($F4,x)
        lda     $61,x
L0C6A:  .byte   $F4
        .byte   $B7
        .byte   $57
        .byte   $D2
        .byte   $63
        jsr     L8B84
        lda     $05C4,y
        .byte   $34
        bne     L0C48
        pha
        .byte   $43
L0C7A:  .byte   $4B
        .byte   $FC
L0C7C:  sta     ($4B),y
        .byte   $FA
        sta     ($52),y
        bit     a:$C2
L0C84:  .byte   $42
        asl     L0ACA
        .byte   $8F
        .byte   $31
L0C8A:  .byte   $92
L0C8B:  .byte   $63
        .byte   $3B
        .byte   $87
        .byte   $B3
        clv
        lda     #$A1
        .byte   $27
        .byte   $5F
        .byte   $FC
        and     $A681,x
        .byte   $33
        dey
        adc     ($65),y
        .byte   $CB
        clv
L0C9E:  and     ($A5),y
        pha
        .byte   $5C
        ror     a
        bcc     L0C7C
        eor     $DD54
L0CA8:  .byte   $1F
        ror     $DD,x
L0CAB:  beq     L0CFA
        cmp     $3D,x
        .byte   $04
        .byte   $54
        .byte   $87
        bpl     L0CDD
        cmp     ($B8,x)
        .byte   $0F
        ldx     #$32
L0CB9:  jsr     L2312
        dex
        bne     L0CB9
        lsr     $63,x
        .byte   $C9
L0CC2:  ldx     #$47
L0CC4:  .byte   $BB
        ldx     #$D1
        .byte   $CB
        .byte   $8B
L0CC9:  cpx     $47
        .byte   $53
        .byte   $AF
        inc     L6459,x
        dec     $20
        tax
        bcc     L0CC9
        .byte   $C7
        rts

        .byte   $CF
        plp
        .byte   $32
        ora     $9329
L0CDD:  .byte   $3A
L0CDE:  .byte   $BB
        and     #$31
        .byte   $5B
        ror     L1B05,x
        .byte   $5C
        .byte   $DC
        .byte   $FC
        dec     $D7
        sta     ($54,x)
        sbc     $A746,y
        .byte   $92
        .byte   $33
        .byte   $46
L0CF2:  .byte   $A7
        .byte   $9B
        ldx     $C6
        ora     ($99,x)
        ora     ($D1,x)
L0CFA:  sta     L806D,x
        ora     $55,x
        brk
        ora     #$05
        .byte   $D7
        sbc     L8516,x
        ora     ($A5,x)
        adc     L1188
        ora     $EF
        sbc     L884B,x
        ror     $94,x
        sty     $46,x
        .byte   $14
        .byte   $07
        ora     $3F,x
        .byte   $64
        .byte   $1B
        .byte   $1F
        sbc     ($0C,x)
        cpy     L62AD
        .byte   $6C
        rts

L0D22:  brk
        inx
        .byte   $0C
        .byte   $14
        cli
        .byte   $12
        and     $D651,y
        lda     $4B
        asl     $35,x
        lda     #$52
        cmp     $83
        .byte   $12
        .byte   $E9
L0D35:  bne     $0CB8
        lda     $54C6,y
        rti

        and     L1A20,y
        .byte   $01
L0D3F:  lsr     a
        sty     L0CF2
        sta     $13,x
        bit     $F87B
        brk
        sbc     $26
        .byte   $0F
        sty     $5A
        .byte   $9D
        .byte   $F0
L0D50:  rol     $5E
        adc     ($2C),y
        .byte   $D2
        .byte   $E3
        stx     $E823
        brk
        .byte   $3A
        sta     $A3FA
        cpy     #$28
        .byte   $8B
        tay
        ora     L3588
        .byte   $AB
L0D66:  sbc     ($2F,x)
        .byte   $0C
        .byte   $7F
        php
        sta     ($E5,x)
        rol     $2C
        eor     ($20),y
        .byte   $13
        cmp     L0081
        .byte   $DE
        .byte   $59
L0D76:  sbc     ($70),y
        eor     ($6F,x)
        .byte   $AB
L0D7B:  .byte   $FA
        and     $D30B,x
        and     $46
        .byte   $1B
        ora     $B941,x
L0D85:  jsr     L159E
        .byte   $73
        bpl     L0D66
        .byte   $73
        .byte   $44
        nop
        .byte   $04
        .byte   $7E
        .byte   $9F
L0D91:  ldy     $50
        sbc     $5047,x
        .byte   $5C
        and     ($1F),y
        .byte   $C7
        nop
        .byte   $03
        lsr     $4A
        .byte   $07
        .byte   $80
        bit     $9988
        php
        .byte   $DF
        lda     #$20
        .byte   $E3
        .byte   $14
        .byte   $47
        .byte   $FA
        asl     L8878,x
        .byte   $1A
        ora     $A0F5,x
        sed
L0DB3:  .byte   $1C
        eor     $A0,x
        inx
        .byte   $1C
        .byte   $04
L0DB9:  brk
L0DBA:  .byte   $87
        sta     L1B5D,y
        .byte   $64
L0DBF:  sei
        .byte   $E2
        .byte   $87
        rol     $C2A1
        adc     $D4
        .byte   $8B
        .byte   $47
        clv
        .byte   $66
L0DCB:  .byte   $4D
        .byte   $36
L0DCD:  sta     $8B
        lda     L364E
        sbc     ($A8),y
L0DD4:  rol     a
        sta     ($2E),y
        .byte   $BB
        .byte   $B3
L0DD9:  .byte   $CF
        .byte   $5A
        brk
        .byte   $FC
        .byte   $74
        .byte   $EB
L0DDF:  bit     $07
        rol     a
        rol     a
        .byte   $44
        .byte   $FB
        .byte   $97
        and     ($4E),y
        cpx     #$2B
        sta     L5E01
        clv
        .byte   $93
        ora     L1ABE
L0DF2:  .byte   $53
L0DF3:  lda     #$16
L0DF5:  jmp     LE8D3

        .byte   $6B
        lda     #$37
        dec     $F04E
        .byte   $54
        .byte   $47
        .byte   $17
        .byte   $9B
        lsr     L1B97,x
        .byte   $B3
        .byte   $13
        .byte   $A1
L0E08:  cmp     $B23F,y
        brk
L0E0C:  cpy     L4CCF
        nop
        adc     L2974,y
        bmi     L0DCD
        and     L578E,y
L0E18:  and     $91CA
        lda     $26
        .byte   $12
        .byte   $07
        tsx
        .byte   $99
L0E21:  .byte   $FF
        lda     #$DD
        .byte   $53
        .byte   $FC
        sta     $CEAD,x
        clc
        rts

        .byte   $CF
        stx     $FB
L0E2E:  stx     L00F9,y
        .byte   $07
        sbc     #$9A
        .byte   $B3
        ora     L8883,x
        asl     L6806,x
        .byte   $62
        nop
        rol     a
        lsr     $74
L0E3F:  ora     ($FB,x)
        rts

        tax
        ora     L84B9,y
        cmp     $0A
        adc     $6B,x
        php
        jmp     (L0AFA)

        .byte   $5C
        .byte   $82
        .byte   $53
        ldx     #$E3
        .byte   $0C
        .byte   $BF
        sta     L46AC,y
        dec     $9200,x
        adc     #$2B
        bcs     L0E98
        lda     #$24
        .byte   $64
        sec
        .byte   $1B
        sta     $FC
        .byte   $73
        .byte   $82
        .byte   $FA
        cpy     $82
        .byte   $CC
L0E6C:  lsr     $99,x
        lda     $80,x
        ldx     L5155,y
        brk
        rti

        cmp     $F3
        .byte   $4F
        asl     $FE6D,x
        .byte   $73
        .byte   $74
        ror     $C8,x
        and     ($E5,x)
        sbc     $5D
        asl     $71
        ora     $B0AA,x
        bit     $C6
        cpy     #$C2
        asl     $8F51
        .byte   $04
        txa
        ldy     $79
        adc     L46A4
        .byte   $22
        .byte   $47
L0E98:  .byte   $C3
        txs
        eor     L2C26
        pha
        .byte   $A3
        sta     $48,x
        .byte   $E6
L0EA2:  .byte   $07
        inc     $86,x
        dec     L5E72
        bmi     L0E6C
        stx     $95,y
        bit     $EA
        jmp     L0EC2

        .byte   $63
        eor     ($D1),y
        ora     $A484,y
        .byte   $42
        jsr     L1907
        bne     L0ECC
        .byte   $74
        rol     a
        .byte   $17
        bcs     L0EC4
L0EC2:  lda     #$08
L0EC4:  .byte   $62
        lda     ($D4),y
        .byte   $F7
        .byte   $37
        .byte   $0F
        .byte   $74
        .byte   $AE
L0ECC:  .byte   $32
        .byte   $4B
        .byte   $BF
L0ECF:  asl     $AC86
        sec
        .byte   $D3
        adc     $28,x
        .byte   $F4
        .byte   $37
        pha
        .byte   $27
        dec     $12
        ror     a
        .byte   $43
        .byte   $5A
        ldy     $99
        sty     $92
        ldx     $61
        .byte   $22
        sty     $D239
        .byte   $FC
        adc     ($E5),y
        .byte   $3A
        pha
        ora     ($46,x)
        .byte   $53
        rol     $E1A1
        .byte   $3C
        ror     $15
        sta     $ED0D,y
        .byte   $63
        cpx     #$CB
        and     ($52),y
        .byte   $3B
        .byte   $C2
        cpy     $96
        ror     $C8
        .byte   $47
        adc     ($63),y
        and     ($13,x)
        sta     $C1F8,y
        .byte   $C2
        cmp     $49
        .byte   $2F
        .byte   $0B
        lda     $5E,x
        .byte   $B1
L0F15:  .byte   $6F
        .byte   $82
        adc     L58D2,x
        .byte   $1F
        bmi     L0F15
        sta     L1738,y
        cmp     L6735,x
        .byte   $7F
        adc     ($4C),y
        .byte   $12
        sta     ($DC,x)
        .byte   $53
        adc     #$36
        .byte   $14
        .byte   $E2
        cpy     #$36
        tsx
        rti

        .byte   $E2
        .byte   $1A
        rol     $BA,x
        eor     L003E
        .byte   $E3
        sty     $99,x
        cpx     L441F
        asl     $C1A4
        bvs     L0ECF
        cld
        .byte   $64
        sbc     #$F6
        ldx     L6B92
        ldx     $4D
        .byte   $8E
        .byte   $96
L0F4E:  ror     $BC39
        .byte   $33
        lda     #$63
        .byte   $9F
        asl     L19E4
        lda     L2B86,y
        cmp     L3F1B,x
        .byte   $12
        ora     #$93
        cli
        sbc     $E787,x
        .byte   $83
        lda     ($C4),y
        cmp     L6156
L0F6B:  php
        .byte   $87
        sty     L71CE
        .byte   $DB
        .byte   $51
L0F72:  sta     $1789,x
        and     $C6
L0F77:  sbc     $D1D8,y
        dec     L5C1B
        adc     L2469
        .byte   $9B
        cpy     #$1E
        .byte   $A7
        inc     $ED07,x
        .byte   $8F
        .byte   $5A
        .byte   $20
        .byte   $96
L0F8B:  .byte   $21
L0F8C:  ldx     #$93
        cmp     $B9,x
        and     $79,x
        rts

        eor     #$C6
        jmp     L6321

        .byte   $13
        php
        adc     ($4C,x)
        .byte   $3F
        .byte   $72
        .byte   $04
        .byte   $09
L0FA0:  cld
        ldy     $CA
        .byte   $17
        .byte   $2B
        rol     $3B,x
        ror     L39CE,x
        .byte   $63
        bit     L6200
L0FAE:  .byte   $9C
        bmi     L0F4E
        rol     $E1,x
        .byte   $62
        sbc     #$63
        .byte   $12
        .byte   $B3
        rti

        rol     $B6
        bpl     L0FA0
        asl     $2E,x
        rti

        and     $28
        sbc     #$62
        .byte   $DC
        tay
        cpy     #$58
        .byte   $A3
        jsr     L6DC9
        .byte   $3F
        .byte   $4C
L0FCE:  .byte   $94
L0FCF:  .byte   $DB
        stx     $71
        dec     $69
        jmp     L8D8E

        .byte   $32
        .byte   $E3
        clc
        .byte   $31
L0FDB:  .byte   $7A
        ora     ($ED,x)
L0FDE:  .byte   $D7
        .byte   $23
        cmp     $E3
        .byte   $E2
        cmp     $A273,x
        .byte   $83
        ora     L7CC9,x
        stx     L5649
        stx     L1C2E
        dex
        iny
        .byte   $CC
L0FF3:  bit     $C2
        lda     ($1E,x)
        lda     L5EF9,x
        .byte   $D3
        ora     #$C4
        .byte   $7B
        clv
        .byte   $FD
        pla
L1001:  .byte   $03
        cmp     ($01),y
        adc     ($45),y
        cmp     ($37,x)
        bcs     L0FDB
        asl     $B3
        lsr     $39
        ldy     $20
        rol     L764F,x
        stx     L39BE
        rts

        .byte   $7C
        asl     L78E9,x
        stx     $A5
        .byte   $D7
L101E:  .byte   $E7
        .byte   $31
L1020:  stx     $A8,y
        .byte   $23
        cmp     ($D7,x)
        .byte   $B7
        .byte   $97
        eor     L3B79,y
        tya
        adc     $FC16,x
        .byte   $B7
        .byte   $5A
        bne     L0FF3
        cmp     L3E2B,x
        php
        adc     $F5,x
        asl     $21,x
        cmp     #$71
        .byte   $9C
        eor     L2089,x
        .byte   $5C
        .byte   $89
        bit     $03
        .byte   $C3
        .byte   $5C
        .byte   $1C
        bpl     L1052
        .byte   $04
        adc     ($59),y
        cmp     #$B7
        ldy     $10
L1050:  rol     $61
L1052:  cld
        ror     $A7,x
        ror     $14,x
        adc     L3499,y
        .byte   $1B
        ror     $4D
        .byte   $07
        ora     $FB97,y
        .byte   $64
        .byte   $EB
        eor     L745B
        cmp     $AB,x
        .byte   $34
        .byte   $52
        rts

        brk
        sta     $62,x
        ror     $D3A3
        .byte   $9D
L1072:  .byte   $0B
        .byte   $31
L1074:  .byte   $CF
        .byte   $1C
        .byte   $9D
        .byte   $3D
L1078:  cmp     #$F4
        .byte   $C3
        lsr     a
        .byte   $7C
        and     ($9E),y
        .byte   $3A
        dec     $78
        .byte   $F3
        .byte   $17
        .byte   $E3
        jmp     (L8E5F)

        and     ($A2),y
        rti

        rol     $E168
        .byte   $D4
        ror     L53D7
        .byte   $57
        jsr     L5C2C
        clv
        bvs     L1108
        and     ($C0),y
L109B:  .byte   $9C
        .byte   $64
        .byte   $17
        ldx     $8C
        eor     ($B9,x)
        asl     a
        cpx     $8C
        .byte   $32
        .byte   $89
        ldy     #$AE
        ldy     $82,x
        adc     L516B,x
        .byte   $7F
        .byte   $F4
        .byte   $1C
        .byte   $74
        .byte   $A7
        .byte   $87
        .byte   $D2
        txs
        lsr     $2A
        rol     $B854
        bit     $CE
        lsr     $A0,x
        bmi     L1072
        cld
        .byte   $02
        .byte   $FA
        ora     ($3C,x)
        cmp     ($CA),y
        jmp     L123C

        asl     $8D
L10CD:  rol     $67
        and     #$5F
        txs
        eor     $BC,x
        brk
        .byte   $1A
        sty     $B1,x
        cmp     ($A0),y
        .byte   $3A
        txa
        inx
        tay
        .byte   $A9
L10DF:  and     ($8D,x)
        .byte   $04
        dec     $A7,x
        rol     a
        .byte   $E7
        and     L4751,y
        .byte   $67
        .byte   $BF
        asl     $C1
        .byte   $82
        .byte   $83
        sty     $85
        ldx     $A7
L10F3:  iny
        nop
        .byte   $2B
        jmp     (L0FCE)

        bvs     L10CD
        .byte   $33
        lda     $36,x
        .byte   $DA
        .byte   $43
        bne     L10DF
        .byte   $EB
        beq     L110E
        .byte   $20
L1106:  ldy     $12
L1108:  ldx     #$F0
        .byte   $52
        .byte   $64
        sec
        .byte   $93
L110E:  .byte   $1F
        .byte   $0B
        ldy     L7C8A,x
        plp
        .byte   $83
L1115:  sbc     ($A2,x)
        cmp     $F23C,y
        .byte   $80
        .byte   $89
        .byte   $62
        cmp     ($63,x)
        .byte   $23
        .byte   $53
        inc     $37
        pla
L1124:  ora     #$B0
L1126:  cmp     $38,x
        .byte   $63
        pha
        .byte   $34
        clc
        .byte   $F7
        and     #$0F
        tay
        lda     $CBF9
        .byte   $67
        .byte   $27
        .byte   $2F
        ldy     $FB
        .byte   $FC
        .byte   $67
        .byte   $01
L113B:  .byte   $6B
        .byte   $1F
        lda     $30,x
        .byte   $3A
L1140:  .byte   $CB
        ora     ($00),y
        .byte   $DB
        .byte   $9C
        .byte   $5B
        cli
        ora     $B6
        .byte   $5B
        php
        .byte   $37
L114C:  .byte   $8B
        .byte   $B3
        sty     L3275
        clc
        clv
        sty     $65,x
        .byte   $3F
        ldx     L1BA5
        .byte   $8B
        .byte   $CF
L115B:  .byte   $9B
        asl     L6071
        .byte   $63
        .byte   $92
        .byte   $07
        jsr     L985A
        sbc     L2A05,x
        pla
        inc     $02E8
        ldx     $DE4F
        brk
        .byte   $AF
        ora     ($BA,x)
        inc     L2890
        pla
L1177:  dex
        jsr     L7C04
        .byte   $67
        .byte   $17
        .byte   $07
        rol     a
        .byte   $7A
        cli
        cpy     $FD
        .byte   $8B
        lsr     $47,x
        sec
        .byte   $37
L1188:  ldx     $0A
        sty     $51
        .byte   $03
        .byte   $72
        .byte   $FA
L118F:  dec     $E7,x
        .byte   $37
        eor     L1C8D,y
        ror     $94,x
        .byte   $83
        .byte   $F3
        .byte   $54
L119A:  .byte   $FA
        eor     $4A,x
        .byte   $5F
        .byte   $80
        .byte   $54
        bne     L1177
        adc     #$62
        and     $4B,x
        dec     $CE
        ror     a
        .byte   $04
        eor     $C64F,x
        .byte   $82
        .byte   $B3
        .byte   $63
        .byte   $56
L11B1:  .byte   $3B
        sta     L2A4C
L11B5:  .byte   $CF
        .byte   $2F
        asl     $DBBC
        inx
        adc     L8CE3,y
        .byte   $D4
        .byte   $B3
        .byte   $62
        tya
        .byte   $7E
L11C3:  .byte   $33
        .byte   $52
        .byte   $FA
        sbc     ($F8,x)
        .byte   $72
L11C9:  iny
        .byte   $67
        cpy     L3F25
        .byte   $2C
        .byte   $2E
L11D0:  .byte   $73
        sta     $D1EA
L11D4:  .byte   $5F
        .byte   $CB
        .byte   $CB
        sty     L2CBE
        adc     $8F,x
        cmp     ($DA,x)
        .byte   $F9
        .byte   $B2
L11E0:  bit     $2C59
        ror     $7E
        lsr     $AF
L11E7:  sbc     $C1,x
        ldy     $DF
        .byte   $DC
        .byte   $B9
L11ED:  brk
        .byte   $5A
        jsr     L1B86
        .byte   $93
        sta     $D4
        .byte   $FC
        .byte   $53
        sbc     ($21,x)
        asl     $A9
        .byte   $4B
        ora     $DAED
        .byte   $DA
        adc     $E956,x
        .byte   $A7
        .byte   $BD
L1205:  ror     $7E92
        .byte   $52
        bit     $7D
L120B:  .byte   $50
L120C:  bpl     $125A
        .byte   $04
        ror     a
        adc     L1E90,x
        sta     $31,x
        ldx     L88A2,y
        bne     L1205
        .byte   $0F
        cpy     #$E3
        ora     ($03),y
        ora     $A11E,y
        .byte   $B2
        .byte   $6B
        rol     L0081
        lsr     L0946,x
        lsr     $6B
        sbc     $62
        stx     $F4
        ror     L57B1
        sbc     ($BA),y
        sbc     $33
        .byte   $9C
        .byte   $DC
        cmp     ($D2,x)
        eor     ($F8,x)
L123C:  adc     $12,x
        .byte   $92
        txa
        bvc     L11E0
        .byte   $B7
        .byte   $52
        cpx     $E4
        pla
        clc
        adc     $ABD0
        .byte   $9E
        ldy     $A8
        sbc     $D1,x
        .byte   $A3
        lsr     $CAAD,x
L1254:  and     #$DD
        ror     a
        .byte   $FA
        .byte   $AB
        eor     L24A3,y
        ror     $96
L125E:  dec     $18
        .byte   $E3
        ror     $CD
        sta     $B028,x
        .byte   $F2
        .byte   $8D
        .byte   $64
L1269:  cmp     #$28
        txa
        sec
        bvs     L120B
        .byte   $74
        .byte   $80
        dec     $E7
        lda     L4672,y
        .byte   $E7
        .byte   $27
        .byte   $C2
        .byte   $93
        ora     #$C8
        .byte   $14
        ldx     L0986
        .byte   $DF
        .byte   $1B
        tya
        cmp     L4447,y
        asl     a
        .byte   $DC
        .byte   $0C
        .byte   $CB
        .byte   $8C
L128B:  lsr     $A9
        .byte   $80
        .byte   $DA
        dey
L1290:  .byte   $12
        .byte   $B7
        ldy     L430B
        cmp     ($CE,x)
        adc     L2F5B
        .byte   $BB
        cmp     $9D2F,y
        eor     $07
        .byte   $1B
L12A1:  cmp     $FFA9,x
L12A4:  .byte   $73
        .byte   $B3
        .byte   $D7
        and     ($09),y
        .byte   $CB
        lda     ($8E),y
        .byte   $04
L12AD:  dex
        adc     #$09
        bmi     L12BA
        .byte   $37
        sta     ($E0),y
        .byte   $B2
        and     $4A,x
        asl     $CC
L12BA:  .byte   $E2
        php
        bpl     L12A1
        .byte   $9E
        jmp     L946A

        eor     L348A
        .byte   $02
        .byte   $EB
        .byte   $54
        ldx     $6C,y
        cmp     L6F96
        .byte   $B3
        txa
        lsr     L65DA
        .byte   $33
L12D3:  txs
        .byte   $3C
L12D5:  .byte   $C3
        bmi     L12FA
        inc     $72
        bmi     L1290
        .byte   $9E
        .byte   $34
        eor     ($2A,x)
L12E0:  pla
L12E1:  dex
        bne     L12E0
        .byte   $67
        ora     $D8,x
        .byte   $DB
        brk
        rol     L0060
        adc     $CA
        tay
        .byte   $83
        cpy     $5D
        and     $F3DD,x
        .byte   $2B
        .byte   $52
        adc     $18
L12F8:  .byte   $83
        brk
L12FA:  .byte   $13
L12FB:  ldx     #$EA
        jmp     L6BA1

        .byte   $E3
        .byte   $64
        .byte   $79
        .byte   $8F
L1304:  stx     $68
        .byte   $3D
        .byte   $BB
L1308:  ror     L6EF8,x
        .byte   $DF
        sty     $CE,x
L130E:  rol     a
        .byte   $F2
        .byte   $DB
        beq     L130E
        sta     L8C0C,x
        sec
        .byte   $DB
        beq     L12AD
        eor     ($8E,x)
        .byte   $74
        .byte   $3F
        rti

        cli
        rti

        asl     $2C,x
        cmp     L330E
L1326:  .byte   $73
L1327:  and     $0F,x
        and     L42BC,x
        inc     L88A3,x
        rts

        dec     $AB80
        sei
        .byte   $5C
        .byte   $14
        .byte   $27
        cpy     #$6B
        tya
        bcc     L12D5
        ror     $0A,x
        lsr     a
        .byte   $52
        adc     ($30,x)
        .byte   $7B
        tay
L1344:  .byte   $77
        stx     $D4,y
        .byte   $FB
        txs
        sbc     $EFF8,x
L134C:  sta     $3D
        ldx     $E627,y
        .byte   $80
        .byte   $E3
        lda     $CCF0,y
        lda     ($D4,x)
        sec
        inx
        .byte   $FB
        clc
        .byte   $9C
        .byte   $CC
        .byte   $E9
L135F:  .byte   $E3
        .byte   $0C
        .byte   $93
L1362:  .byte   $53
        adc     ($CC,x)
        and     L5004,x
        asl     $A7,x
        and     ($47,x)
        .byte   $80
        ora     $01,x
        .byte   $A3
        bvc     L12FB
        .byte   $0E
L1373:  ldy     L8E89
        sbc     ($F8),y
        .byte   $A9
L1379:  inc     $332E
        .byte   $EF
        .byte   $AF
        .byte   $82
        asl     L1A3E
        php
        asl     $C7,x
        tax
        jmp     L3ED8

        .byte   $1C
        asl     a
        ldy     $FC,x
        cmp     $BC9F
        sec
        .byte   $F7
        .byte   $33
        lda     #$F4
        .byte   $27
        .byte   $EB
        rol     $FC,x
        cpy     $C6D0
        .byte   $B3
        .byte   $34
        and     ($CD),y
        sbc     L1699
        dec     $91D9,x
        sty     $31,x
        ldy     $F0E9
        and     ($9B),y
L13AD:  asl     $71
        rts

        asl     a
        dec     $F604
        ora     ($D8,x)
L13B6:  .byte   $BF
        tsx
        ora     $9CE3
        ldy     $C5
        and     L228B,y
        .byte   $F4
        .byte   $0C
        .byte   $6F
        .byte   $33
        .byte   $2F
        .byte   $A7
        .byte   $34
        adc     ($07),y
        .byte   $B3
        and     $B2,x
        cmp     $E949
        lda     #$30
        clc
L13D2:  .byte   $32
        .byte   $3A
        bcs     L13DF
L13D6:  .byte   $D4
        .byte   $B3
L13D8:  .byte   $53
        .byte   $13
        .byte   $3A
        adc     $C2E6,x
        .byte   $26
L13DF:  eor     ($35,x)
        .byte   $43
        dec     $A312
        .byte   $2F
        jsr     L43D5
        .byte   $CF
        lda     $C4E4
        .byte   $80
        .byte   $2B
        sta     L333F
        .byte   $02
        .byte   $03
        and     ($64,x)
        and     ($65,x)
        and     ($66,x)
        and     ($67,x)
        adc     ($6A,x)
        cmp     #$0B
        .byte   $57
        .byte   $0B
L1402:  rts

        .byte   $0B
        adc     #$0B
        .byte   $72
        .byte   $0B
        .byte   $7B
        .byte   $0B
        sta     $940B
        .byte   $0B
        ldy     $0B
        .byte   $D4
        rti

        lsr     L5FA0,x
        bpl     L1476
        bvc     L1471
        bpl     L147B
        plp
        rts

        .byte   $70
L141E:  adc     ($C0,x)
        .byte   $63
        cpy     #$64
        lda     ($83),y
        .byte   $22
        .byte   $C3
L1427:  .byte   $27
        .byte   $43
        .byte   $07
        .byte   $C3
L142B:  adc     $A4,x
        .byte   $1A
        .byte   $04
        .byte   $1C
        bmi     L144E
        .byte   $54
        .byte   $1C
        ldy     #$1D
L1436:  .byte   $AD
L1437:  rts

        inc     $70
L143A:  beq     $14AC
        .byte   $FA
        ldy     #$FB
        rti

L1440:  .byte   $FB
        beq     L1440
        .byte   $42
        .byte   $87
        .byte   $99
        .byte   $87
L1447:  lda     $7007,y
        .byte   $87
        lsr     a
        php
        .byte   $3C
L144E:  cli
        rti

        tay
        rti

        cpx     #$43
        ldy     $41,x
        rti

        eor     ($80,x)
        eor     ($D0,x)
        .byte   $42
        pha
        ldx     #$13
        .byte   $22
        .byte   $17
        ldx     #$18
        .byte   $62
        .byte   $1C
L1465:  cmp     (L00F9,x)
        .byte   $E2
        asl     a
        cmp     $11
        .byte   $1B
        ora     ($10),y
        ora     ($3D),y
L1470:  .byte   $11
L1471:  sei
        ora     ($8B),y
        ora     ($91),y
L1476:  ora     ($B6),y
        ora     ($08),y
        .byte   $12
L147B:  .byte   $73
        .byte   $12
        .byte   $7B
        .byte   $12
        txs
L1480:  .byte   $12
        cmp     $80,x
        .byte   $5F
        bcs     L14E5
        cpx     #$5B
        rts

        .byte   $8B
        sty     $76,x
        ora     #$6A
L148E:  .byte   $89
        .byte   $74
        ora     #$4B
        .byte   $C0
L1493:  .byte   $2F
        eor     $EBE1,y
        .byte   $02
        stx     $C1,y
        .byte   $7A
        .byte   $C2
        dec     $41
        and     $E1,x
        .byte   $44
        and     ($3A,x)
        sbc     ($3A,x)
        .byte   $41
L14A6:  eor     $01
        and     $61,x
        .byte   $3D
L14AB:  .byte   $6F
        php
        .byte   $14
        txa
        lda     ($8A),y
        .byte   $EB
        bpl     L1509
        .byte   $D4
        lsr     L4D00
        .byte   $14
        eor     $34,x
        lsr     $38,x
        .byte   $4F
        .byte   $5F
        .byte   $E2
        .byte   $63
        .byte   $22
        stx     $82
        sty     $C2
        .byte   $C7
        .byte   $82
L14C8:  cpy     #$C2
L14CA:  bmi     L148E
        .byte   $CB
        .byte   $02
        .byte   $B2
        .byte   $22
        .byte   $B2
        .byte   $42
        .byte   $CF
        lda     L27E0,y
        nop
        .byte   $9E
        sbc     L3E87,y
        .byte   $27
        sta     $6C,x
        ora     $02C6,y
        .byte   $72
        stx     $B767
L14E5:  .byte   $1F
        .byte   $7A
        .byte   $7C
        ldy     $FD
        .byte   $67
        php
        ror     $72
        .byte   $73
        ora     $84
        .byte   $FB
        .byte   $20
        .byte   $F6
L14F4:  .byte   $17
        eor     $45,x
        and     $C761,y
        lda     L5838
        ror     $F30B
L1500:  .byte   $7E
        .byte   $E3
L1502:  .byte   $7F
        pla
        ror     $E35A
        .byte   $33
        .byte   $66
L1509:  .byte   $02
        cmp     L7298,y
        cld
        rts

        .byte   $E7
        .byte   $34
        bit     $F2F6
        lda     L35EE
        rol     a
        .byte   $7B
L1519:  lsr     a
        .byte   $3B
        ldy     $72,x
        ora     ($F1,x)
        .byte   $8F
        .byte   $7C
        .byte   $3A
        .byte   $3C
        .byte   $B3
        inx
L1525:  .byte   $80
        .byte   $33
        lda     $83
        beq     L14CA
        dey
        rol     L0A46
        .byte   $5F
        dec     $1A
L1532:  .byte   $74
        .byte   $80
        .byte   $52
        .byte   $7F
        jsr     LE071
        .byte   $6B
        .byte   $9C
        tya
        ror     L6C05,x
L153F:  sbc     $15
        ora     L4DFD
L1544:  .byte   $17
        ora     $DDFA
        .byte   $5E
        .byte   $31
L154A:  .byte   $5A
        cmp     L1B87,x
        lda     $CB
        .byte   $7A
        sbc     $32,x
        .byte   $04
        ora     ($B1,x)
        jmp     L48CC

        .byte   $F3
        eor     $B0
        .byte   $DB
        cmp     $C4DC,y
        .byte   $9C
        adc     ($C5,x)
        .byte   $53
L1564:  sbc     ($33,x)
        sty     $45
        .byte   $22
        .byte   $12
        .byte   $42
        dec     $48
        .byte   $02
        .byte   $22
        .byte   $02
        adc     L2B14,x
        .byte   $83
        .byte   $97
        ldy     $0F
        .byte   $97
        eor     ($83,x)
        dex
        .byte   $1B
        .byte   $9C
        ora     L5FB8,y
        iny
        bvs     L1532
        bit     $92EA
        dey
        lsr     $A219,x
        dec     $1B
        .byte   $67
        asl     $DF33
        .byte   $A3
        ldx     $D9,y
        .byte   $D3
        .byte   $8E
L1595:  .byte   $5C
        adc     L0C30
        and     L0AC0,y
        rti

        .byte   $25
L159E:  .byte   $AB
        sta     ($B2,x)
        txs
        eor     $D91E,x
L15A5:  bvc     L154A
        jmp     (L23D2)

        inc     $36,x
        iny
        ora     #$D5
        rol     $AD08,x
        .byte   $4F
        .byte   $54
        .byte   $7D
L15B5:  lda     $B64E
        .byte   $F2
        .byte   $62
        eor     #$2A
        .byte   $9F
        .byte   $E7
        .byte   $14
        .byte   $DA
        lda     ($4A),y
        asl     $D9
        php
        cli
        .byte   $4F
        eor     #$FC
        dec     $C4A1,x
        asl     a
        .byte   $D4
        ora     L22B0,y
        .byte   $EF
        and     $BE
        rol     $F306,x
        .byte   $13
        .byte   $CB
        .byte   $DC
        .byte   $4B
        stx     $2E
        lda     L66F2,x
        cpy     #$24
        .byte   $23
        .byte   $92
        eor     L65E4,y
        .byte   $A3
        rol     L3B82,x
        .byte   $DF
        .byte   $23
        tay
        .byte   $5E
L15EF:  bit     $23
        rol     $38
        cpx     $EFE1
        .byte   $14
        lda     $40,x
        .byte   $33
        and     #$00
        .byte   $62
        asl     $41
        sta     L630F,x
L1602:  .byte   $86
L1603:  asl     a
        .byte   $77
        .byte   $42
        bne     L1616
        .byte   $97
        ror     a
        .byte   $8F
        .byte   $73
L160C:  .byte   $32
        .byte   $0F
        .byte   $E3
        tsx
        ldx     L71B0,y
        ldy     $21,x
        .byte   $22
L1616:  .byte   $AB
        .byte   $E7
        and     #$39
        .byte   $99
L161B:  lsr     $43,x
        pla
        dec     $5C,x
        sbc     $CF66,x
        dec     $73,x
        pla
        pla
        clv
        cpx     $D50E
        .byte   $04
        adc     #$12
        ror     $53,x
        .byte   $17
        inc     $12
        stx     $B0
        ora     $6E
        stx     $FC98
        stx     L0D22
        and     ($8A),y
        and     $AB,x
        ora     $A9,x
        .byte   $03
L1644:  ldx     #$FA
        sty     $9CDB
        tsx
        txa
        lsr     $88,x
        .byte   $32
        pla
        .byte   $AB
        .byte   $FC
        .byte   $A2
L1652:  and     $BD6B,x
        .byte   $BF
        inx
        dec     $AF,x
        stx     $8A
        .byte   $5B
        lsr     $BDA6,x
        .byte   $53
        jmp     (LC1D9)

        .byte   $43
        .byte   $4F
        ror     L5E34
        .byte   $A3
        .byte   $22
        .byte   $97
        .byte   $C0
L166C:  .byte   $7B
        txs
        .byte   $9B
        .byte   $BB
        lda     ($A8,x)
L1672:  .byte   $17
        .byte   $64
L1674:  clv
        .byte   $DF
        rti

        .byte   $22
        .byte   $C7
        .byte   $82
        .byte   $54
L167B:  asl     a
        .byte   $14
        adc     L2678
        sbc     L46C6,x
        clc
        and     $DA
        dec     $6C
L1688:  .byte   $52
        .byte   $FF
L168A:  .byte   $1B
        .byte   $9F
        .byte   $7C
        .byte   $CF
        sta     ($4E),y
        .byte   $9B
        dec     $EA59,x
        ldy     #$00
        .byte   $8C
L1697:  .byte   $B3
        .byte   $02
L1699:  sty     L4FB2
        .byte   $DB
        brk
        rol     $D7
        cpx     $C9
        .byte   $52
        rol     $2C,x
        ror     L0081
        .byte   $DB
        .byte   $25
L16A9:  .byte   $83
        ora     $C935,x
        .byte   $D3
        ora     $0462,x
        bcc     L16E4
        cmp     #$F0
        cli
        tya
        .byte   $C6
L16B8:  .byte   $04
        jmp     L335E

        .byte   $6F
        ora     #$F6
        .byte   $99
        .byte   $45
L16C1:  sty     $E0,x
        lsr     $B501,x
        jsr     LCC2C
        .byte   $D3
        .byte   $1C
        nop
        bvs     L16D1
        .byte   $67
        .byte   $8E
        .byte   $DF
L16D1:  lda     L1437,y
        sta     L340E,y
        .byte   $41
L16D8:  sty     $34
        dec     $D9D9
        asl     a
        cpy     L1A3E
        lda     $C1F6
L16E4:  .byte   $E3
        .byte   $7C
        rti

        adc     $40
        .byte   $92
        .byte   $BB
        .byte   $3D
        .byte   $B5
L16ED:  ldy     #$14
L16EF:  sta     ($52),y
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
        bpl     L1777
        .byte   $DC
        .byte   $A7
        sty     $ED,x
        .byte   $07
        txs
        .byte   $6B
        .byte   $42
        jmp     L1F7C

        pha
L1718:  lda     $EBB1
        sty     $BB
        lda     L53E6,x
L1720:  asl     $C7,x
        .byte   $BB
        .byte   $3F
        lda     $3B
        .byte   $E2
L1727:  ldy     #$95
        .byte   $FA
        sei
        tay
        .byte   $34
        inc     $DE,x
        .byte   $62
        asl     $FB2E
        .byte   $2C
L1734:  .byte   $90
L1735:  .byte   $12
        ora     #$E6
L1738:  lda     #$3D
        sta     $DCB7,x
        .byte   $6F
        .byte   $9D
L173F:  .byte   $E1
L1740:  .byte   $3F
        brk
        dec     $EB
        adc     L8D59,y
        bpl     L1727
        .byte   $64
        .byte   $47
        lsr     $CD,x
        ror     $F17D
        ldy     $02
        tya
        iny
        .byte   $37
        .byte   $52
        ora     #$D1
        bcs     L16EF
        ror     $D898
        sbc     $AD
        cpx     $02
        .byte   $74
        ldy     $D00D,x
        .byte   $1F
        jsr     L1FDA
        bcc     L179C
        .byte   $47
        dey
        .byte   $D4
        .byte   $E7
        .byte   $64
        ror     $E4
        jmp     (L4CFC)

        plp
        .byte   $E4
L1777:  cmp     #$67
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
        .byte   $9F
        ldy     L40F0,x
        pha
        ora     $E3FB
        .byte   $E7
        sbc     $14
        .byte   $52
L1798:  and     $92A4,x
        .byte   $26
L179C:  sei
        brk
        stx     $ACC7
L17A1:  .byte   $07
        clc
        lda     L72ED
        sty     $DC,x
        ror     $DC,x
        .byte   $52
        adc     ($A0,x)
L17AD:  .byte   $DB
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
        bvc     L17AD
        ora     $B0,x
        ldy     #$D2
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
        .byte   $87
        .byte   $53
        ora     L6AAC,x
        adc     L36B1,y
        .byte   $AC
L17E0:  .byte   $CD
L17E1:  rts

        adc     $10,x
        .byte   $12
        ora     #$C5
        .byte   $67
        stx     $30,y
        .byte   $6F
        cpy     $90
        tya
        .byte   $42
        .byte   $39
        .byte   $F1
L17F1:  .byte   $63
        .byte   $FA
        .byte   $12
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
L1801:  .byte   $AC
        .byte   $91
L1803:  .byte   $4B
        brk
        rol     $C608,x
L1808:  clc
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
        .byte   $CD
        .byte   $7E
L181D:  ldy     $78D4,x
        .byte   $F3
        lda     $8B
        sbc     ($DF),y
        bpl     L17F1
        rti

        .byte   $2B
L1829:  .byte   $3D
L182A:  lda     $92E4,y
        lda     $8C
        sta     $E35D
        asl     $C7A3,x
        .byte   $89
        jsr     L9C17
        cpy     $F6B5
        .byte   $37
L183D:  dec     L4AE0
        ldx     L0954,y
L1843:  adc     ($99),y
        .byte   $57
L1846:  .byte   $5B
        .byte   $51
L1848:  dec     $799C,x
        .byte   $F7
        .byte   $E7
        .byte   $1B
        ora     $BA,x
        ldy     $92AC
        sbc     $A002
        .byte   $14
        plp
        .byte   $D2
        stx     $D5
        sec
        .byte   $93
        .byte   $B2
        .byte   $F7
        eor     ($F0,x)
        .byte   $04
        cmp     #$4F
        bne     L187A
        .byte   $B2
        .byte   $F3
        jmp     L0BD0

        lda     $D6,x
        .byte   $54
        ora     L4030,y
        ror     $D6,x
        .byte   $EB
        adc     $71
        .byte   $14
        cpx     #$3A
        .byte   $02
L187A:  ldx     $4B,y
        dec     $CC52,x
        .byte   $52
        beq     L1829
        jsr     L9FE2
        ldx     L4C70
        .byte   $07
L1889:  .byte   $AD
L188A:  eor     $D7E0,y
        lsr     a
        .byte   $1B
        and     ($89),y
        .byte   $F2
        .byte   $C7
        .byte   $7B
        ldy     L3235
        .byte   $44
        lda     ($A6),y
        eor     $07C0,y
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
        bvc     L1905
        lda     L866C
        nop
        bvc     L18F7
        cmp     $F612
        .byte   $E3
        cpy     L285D
        .byte   $03
        lsr     $26
        .byte   $A3
        .byte   $5C
        sbc     ($0E,x)
        dec     $9B,x
        .byte   $2F
        ora     $A6,x
        .byte   $73
L18D1:  sta     $A2
        ldx     $FC,y
        .byte   $2F
        cpx     #$3A
        ldy     $5A,x
        beq     L18D1
        php
        .byte   $F4
        ldy     $80,x
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
        bvs     L18FA
        bpl     L1918
L18F7:  sbc     $90,x
        iny
L18FA:  ora     #$20
        rol     $9FA4
        .byte   $F6
L1900:  .byte   $3C
        sta     L320A,y
        .byte   $30
L1905:  ora     ($74,x)
L1907:  .byte   $3B
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
L1918:  .byte   $EB
L1919:  adc     $8E
        ora     L2991,y
        ror     $6F,x
        ora     $B0,x
        .byte   $EB
        adc     L6FBE,x
        stx     $48,y
        lda     L1500,x
        bvc     L1999
        .byte   $C6
L192E:  .byte   $2F
        sta     $61
        and     $27,x
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
L1950:  .byte   $E3
        ldx     $2B
        tax
        .byte   $F2
        jsr     L8852
        ora     ($9C),y
        sta     ($59),y
        pha
        asl     $C7
        jmp     L04A4

        .byte   $72
        bvc     L19CA
        jsr     L920B
        .byte   $B7
        and     #$00
        sta     ($86),y
        .byte   $0C
L196E:  .byte   $93
        ora     #$48
        ora     ($E4,x)
        sta     L5330,x
        .byte   $21
L1977:  .byte   $34
        dex
        .byte   $1B
        cpy     $9A
        ora     L40F0,x
        .byte   $F7
        and     #$20
        .byte   $C2
        .byte   $1E
L1984:  beq     $1981
        tay
        lda     #$10
        bit     L62A9
        txa
        adc     ($1E,x)
        .byte   $54
        sta     L3D68,y
        and     ($93),y
        .byte   $54
        iny
        sta     $15
L1999:  ldy     #$5A
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
L19AA:  .byte   $1F
        .byte   $23
        jmp     LE3B3

        iny
        .byte   $83
        lda     L4630
        sty     L48D3
        pla
        .byte   $4C
        .byte   $CE
L19BA:  .byte   $DC
        beq     L1A29
        .byte   $E3
        .byte   $89
        .byte   $A3
        .byte   $03
        sei
        sbc     ($E3,x)
        .byte   $47
L19C5:  .byte   $51
L19C6:  .byte   $3A
        .byte   $3A
        .byte   $1E
        .byte   $9E
L19CA:  .byte   $02
        asl     $0C,x
        inc     a:$BE,x
        cmp     $A4,x
        .byte   $9B
        .byte   $F5
L19D4:  iny
        ora     L1688,x
        cmp     ($2E,x)
        .byte   $DB
        rti

        and     ($86,x)
        bcc     L19FE
        jmp     (L2B8F)

L19E3:  .byte   $A3
L19E4:  .byte   $6C
        .byte   $7B
L19E6:  dec     $3C3F
        plp
        .byte   $82
        .byte   $13
        .byte   $B3
        dec     $40
        bpl     L1A52
        .byte   $B7
        .byte   $3C
        .byte   $1A
        .byte   $9B
        .byte   $B3
        .byte   $C7
        eor     ($5A),y
        asl     $F114,x
        .byte   $0D
        .byte   $6B
L19FE:  bcs     L1A58
        dec     $0560,x
        .byte   $77
L1A04:  dec     $21
        .byte   $4F
        .byte   $3A
        .byte   $31
L1A09:  and     $1F3C,x
        .byte   $A7
        .byte   $83
        .byte   $F2
        lda     #$E8
        .byte   $A3
        .byte   $D4
        asl     $D5CB
        .byte   $92
        .byte   $8F
        bvc     L1A25
        .byte   $2F
        bvc     L19C5
        .byte   $F5
L1A1E:  .byte   $A3
        .byte   $E6
L1A20:  .byte   $9B
        sta     $69
        bmi     L19C6
L1A25:  dec     $21
        tsx
        .byte   $23
L1A29:  .byte   $D4
        .byte   $E3
        sta     $06,x
        lda     L79D7,x
        bvc     L19D4
        inc     L1E56
        ora     L7254,y
        .byte   $B2
        cld
        sei
        .byte   $32
        cmp     ($E1),y
L1A3E:  ora     $00
        .byte   $D4
L1A41:  cmp     #$95
        .byte   $24
L1A44:  cpy     $80B8
        adc     L3FAF,y
        bit     L79CE
        .byte   $37
L1A4E:  and     $FE95,y
        .byte   $BE
L1A52:  lda     ($07,x)
        sbc     L12F8,x
        .byte   $F2
L1A58:  .byte   $E3
        dec     L28AA,x
        bvc     L1ACE
        .byte   $93
        eor     ($21),y
L1A61:  lsr     $D905,x
        .byte   $B2
        .byte   $82
        sec
        beq     L1A75
        cmp     #$40
        bne     L1A86
        stx     $C57A
        php
        .byte   $FB
        clv
        .byte   $72
        .byte   $69
L1A75:  adc     ($36,x)
        .byte   $A7
        rol     $F4
        cmp     #$5D
        cmp     $F4
        .byte   $5A
        .byte   $F3
        jsr     L62E8
        .byte   $F3
L1A84:  and     ($51,x)
L1A86:  adc     ($48),y
        ldx     #$A0
        and     ($4D,x)
        eor     $AF57,y
        cmp     $21
        .byte   $04
        .byte   $BF
        .byte   $FC
        .byte   $2B
        cli
        and     $F970,y
        ldy     $CC
        .byte   $FB
        lda     L3658
        .byte   $D3
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
        bcc     L1ABA
        .byte   $D6
L1ABA:  .byte   $44
        .byte   $C2
        rts

        .byte   $D9
L1ABE:  .byte   $07
        .byte   $C3
        iny
        .byte   $D1
L1AC2:  sta     $4DBD,y
        .byte   $54
        .byte   $77
        cmp     #$35
        tay
        .byte   $80
        rol     $88
        .byte   $E9
L1ACE:  cmp     #$02
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
L1ADC:  .byte   $D7
        iny
L1ADE:  .byte   $93
        .byte   $6B
        ldy     #$34
        lsr     $D86A
        rol     $04,x
        bvc     L1AC2
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
L1B05:  .byte   $E7
        inx
        ror     $7E,x
        sta     $D0
        brk
        .byte   $64
        ldx     $B76F
        sta     ($26),y
        .byte   $47
        bpl     L1B87
        pha
        adc     #$19
        rol     $B1,x
        .byte   $5C
        .byte   $FA
        ora     $1A
        beq     L1B21
        .byte   $2C
L1B21:  eor     $027D
        .byte   $37
        bit     $CAB1
        cmp     $2F,x
        .byte   $22
        pla
        lda     $C907,y
        and     $80,x
        .byte   $AD
L1B32:  .byte   $62
        ror     $99B5
        lsr     $44,x
        cmp     $C0
        .byte   $4E
L1B3B:  brk
        .byte   $C2
        .byte   $93
        .byte   $14
        .byte   $DA
        .byte   $93
        rol     $D924,x
        .byte   $22
        sty     $90CE
        sta     ($16),y
        jmp     L1FEB

        .byte   $3D
        .byte   $E4
L1B4F:  and     $AC23,y
        .byte   $7C
        .byte   $FF
        .byte   $A7
        iny
        .byte   $6B
        .byte   $3A
        .byte   $1A
        .byte   $E3
        .byte   $37
        .byte   $20
        dex
L1B5D:  dec     $21,x
        jmp     L2087

L1B62:  .byte   $AC
L1B63:  .byte   $CF
        eor     $4146,x
        .byte   $E7
        .byte   $87
        .byte   $AE
        lsr     a
L1B6B:  .byte   $DF
        sta     ($5E,x)
        eor     #$D7
        sta     (L0056,x)
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
L1B86:  .byte   $AB
L1B87:  cld
        .byte   $B2
        .byte   $2F
        ora     $CA32
        sta     ($C4),y
        sbc     L4F1D,x
        cmp     ($14),y
        sbc     L4F12,x
L1B97:  cmp     ($B4),y
        sbc     L561A,x
        adc     ($79,x)
        .byte   $0F
        and     #$88
        .byte   $A6
L1BA2:  .byte   $62
        cld
        .byte   $03
L1BA5:  .byte   $0C
        .byte   $34
        bcc     L1C1E
        sbc     $A0
        ora     $CC0A,y
        sta     L0ABB,x
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
        lsr     $F7E0,x
        inc     L630E
        .byte   $42
        .byte   $12
        jsr     L928D
        eor     #$1A
        sty     L4DFA
        sta     ($04,x)
        eor     $27,x
        .byte   $E7
        .byte   $14
        cpx     L1078
        eor     ($94,x)
        eor     $F74C
        .byte   $C7
        .byte   $BD
L1BE7:  and     $77
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
        lda     ($4E,x)
        ora     #$46
        stx     $F7,y
        .byte   $43
        cpx     #$5E
        sta     ($69),y
        dec     $D0
        sta     ($48),y
        .byte   $04
        cmp     ($92),y
        and     $29,x
        brk
        txs
L1C18:  asl     L4281
        rti

        .byte   $53
        .byte   $34
L1C1E:  adc     ($79,x)
        stx     $4A
        ora     ($59,x)
        rol     a
        .byte   $7B
L1C26:  eor     $02
        sta     $D3F4,x
        .byte   $81
L1C2C:  .byte   $FB
        .byte   $6E
L1C2E:  .byte   $17
        and     #$08
        .byte   $5C
        ldy     $9B,x
        .byte   $C2
        adc     $DA
        .byte   $DC
        lda     ($4C,x)
        .byte   $0C
L1C3B:  .byte   $33
        sed
        .byte   $04
        .byte   $67
        .byte   $32
        .byte   $44
        .byte   $23
        cpy     $01
        .byte   $2B
        .byte   $92
L1C46:  lda     L21CA,x
        and     ($47),y
        .byte   $E6
L1C4C:  cmp     ($F3,x)
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
        .byte   $27
        .byte   $B3
        clc
        ldx     $9544
L1C67:  bit     $0C
        .byte   $77
        clv
        adc     $39,x
        .byte   $07
        jmp     L232B

L1C71:  .byte   $82
        ror     $8A,x
        sty     $F0F9
        lda     ($D6),y
        .byte   $80
        .byte   $77
        cmp     $C0
        bne     L1C18
        ror     $D74D,x
        cmp     $A246
        .byte   $13
        .byte   $13
        iny
        tay
        .byte   $DB
        ldy     $BE
L1C8C:  sec
L1C8D:  sbc     L70A2
        rol     $8D,x
        .byte   $3B
L1C93:  and     $93F8
        bne     L1C8C
        .byte   $A3
        jmp     (L5600)

        pla
        rol     $2C,x
        and     L1734,x
        sta     L4383,x
        .byte   $13
L1CA6:  cpy     $19
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
L1CBE:  cmp     L4E8F,x
        dey
        .byte   $EC
        .byte   $C0
L1CC4:  and     $10
        lsr     $87,x
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
        bvc     L1C71
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
        bne     L1CFE
        .byte   $4F
        .byte   $0C
        .byte   $DC
L1CF7:  .byte   $80
        rol     $6C
        cmp     L003E,x
        .byte   $D4
        .byte   $C0
L1CFE:  .byte   $CF
        .byte   $17
L1D00:  .byte   $0F
        bpl     L1D18
        ror     a
        .byte   $7E
        inx
L1D06:  adc     LA8A7,x
        ror     $044C
L1D0C:  sta     ($FD,x)
        .byte   $43
        .byte   $37
        .byte   $E7
        .byte   $52
        txa
        asl     $EE
        ldx     $F1,y
        .byte   $10
L1D18:  .byte   $DF
        .byte   $5F
        .byte   $44
L1D1B:  lsr     a
        .byte   $7D
L1D1D:  inc     L1C4C,x
        .byte   $74
        lda     #$FE
        lda     #$9C
        adc     $DBBE
        dec     $A0C8,x
        .byte   $43
        cmp     L3D1D,x
        .byte   $1C
        .byte   $3C
        txa
        eor     $FE,x
        bvc     L1D96
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
L1D46:  .byte   $1C
L1D47:  sta     ($AD),y
        txs
        eor     #$10
        bcc     L1D65
        adc     $07
        cmp     $4A,x
        rti

        eor     #$80
        tya
        asl     a
        .byte   $89
        stx     $3D
        sta     L0060,x
        .byte   $12
        rti

        dey
        pha
        .byte   $99
        tax
L1D62:  lsr     $98
        .byte   $14
L1D65:  eor     #$92
        eor     ($E0,x)
        .byte   $4B
        .byte   $93
        rol     a
        .byte   $0F
        .byte   $02
L1D6E:  clc
        stx     $02C4
        cmp     #$28
        bne     L1D79
        lda     $88,x
        .byte   $67
L1D79:  .byte   $FA
        sed
        .byte   $23
        and     $59
        ora     $99B2,x
        pha
        .byte   $35
L1D83:  iny
        sty     $64,x
        .byte   $7C
        cmp     ($A9),y
        lsr     $49
        .byte   $80
        adc     $058F
        lda     $5E,x
        cpy     #$74
        .byte   $5F
        .byte   $DE
        .byte   $1E
L1D96:  sty     $2C,x
        .byte   $14
        bvs     L1D6E
        lsr     $71,x
        cpy     #$11
        eor     $E6,x
        .byte   $FD
        .byte   $17
L1DA3:  sta     $1E
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
        .byte   $71
L1DCA:  asl     $47
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
        sec
        .byte   $0B
        .byte   $37
        lsr     a
        asl     a
        sbc     ($65,x)
        sta     ($A2,x)
        .byte   $9B
        dec     $A20D
L1DE9:  and     #$42
        tay
        tya
        ora     $D7AA,x
        ldx     $A8A3
        .byte   $1A
        .byte   $A3
        cmp     L0081,x
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
        .byte   $8D
        .byte   $44
L1E25:  ror     $51
        adc     #$E0
        .byte   $99
L1E2A:  ldx     $9148,y
        ror     L536B
        .byte   $33
        clc
        .byte   $94
L1E33:  eor     ($D8),y
L1E35:  .byte   $0B
        .byte   $67
        ror     $45
        clv
        .byte   $0B
        ora     $9F
        ora     L8B34
        .byte   $6F
        .byte   $83
        .byte   $5F
        .byte   $D2
        .byte   $A4
L1E45:  rti

        .byte   $44
        .byte   $3F
        inx
        ror     $D2,x
        lda     ($05,x)
        .byte   $22
L1E4E:  ora     #$37
        rol     a
        eor     $D635
        .byte   $EE
        .byte   $09
L1E56:  ora     #$49
        ora     $27
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
        .byte   $75
L1E73:  brk
        .byte   $04
        cmp     L1740
        .byte   $12
        .byte   $F7
        .byte   $27
        .byte   $23
        .byte   $8F
        ora     $64,x
        ror     L1FDB
        .byte   $89
        stx     L8AAA
        bmi     L1EA9
        adc     ($06),y
        .byte   $3F
        bvc     L1E35
        .byte   $9F
        .byte   $5F
L1E8F:  .byte   $36
L1E90:  jsr     LAEEA
        .byte   $BB
        .byte   $B3
        .byte   $74
        .byte   $6B
        .byte   $BF
        .byte   $7B
        .byte   $14
        .byte   $42
        .byte   $E3
        .byte   $8E
L1E9D:  .byte   $54
        dec     $52
        cli
        bit     $D192
        rol     a
        txs
        .byte   $32
        .byte   $42
        .byte   $19
L1EA9:  cpy     $CE
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
L1EC1:  adc     $A954,x
        adc     $D68E,x
        lda     #$9C
L1EC9:  lda     $043C
        .byte   $F3
        .byte   $93
        .byte   $E0
L1ECF:  .byte   $E2
        sty     $D7,x
        ldy     $22
        .byte   $14
        dec     $94,x
        .byte   $DB
        .byte   $A4
L1ED9:  .byte   $02
        .byte   $14
L1EDB:  cmp     $9D49,y
        .byte   $04
        lda     $DA,x
L1EE1:  rts

        eor     $DB88,x
        cpx     #$29
        sta     $1D,x
        ldx     $EE
        .byte   $3C
        .byte   $37
        cmp     $49
        .byte   $A4
L1EF0:  .byte   $DF
        bpl     L1F4D
        ora     L81A9,x
        sbc     $2C
        .byte   $02
        clc
        .byte   $7C
L1EFB:  .byte   $4B
        ora     $26,x
        bit     $B5
        .byte   $6E
L1F01:  .byte   $83
        ora     $E999,x
        cld
        sta     $FE,y
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
        .byte   $CF
        .byte   $7F
        .byte   $5B
        sbc     ($96),y
        .byte   $DF
        .byte   $74
        .byte   $63
        cmp     $4D
        ldy     #$1F
        .byte   $4B
        .byte   $1C
L1F35:  ldy     L588A
        .byte   $D4
        stx     $F00E
        .byte   $02
        .byte   $37
        .byte   $3F
L1F3F:  .byte   $63
        .byte   $BB
        sbc     $80
        .byte   $7A
        rol     $E7
        stx     $77,y
        eor     $C4DC,x
        .byte   $0E
        .byte   $05
L1F4D:  .byte   $B2
        txs
        .byte   $E2
        stx     $58
        .byte   $B2
        .byte   $9B
        .byte   $62
        .byte   $87
        ora     $B4,x
        brk
        ora     $98
L1F5B:  rts

        jsr     LAC03
        lda     $00
        clc
        dey
        .byte   $64
        php
        .byte   $43
        .byte   $FA
        brk
        .byte   $7B
L1F69:  .byte   $13
        .byte   $52
L1F6B:  .byte   $54
        ora     $18
        .byte   $D4
        .byte   $53
        sbc     L5813,y
        sta     ($0D,x)
        adc     L1EE1,y
        .byte   $5F
        sbc     ($2A,x)
        .byte   $53
L1F7C:  .byte   $34
        .byte   $6F
        .byte   $97
        sbc     #$48
        clc
        lsr     L1C93
        .byte   $F4
        .byte   $47
L1F87:  .byte   $52
        ror     L11D0
        ror     L13D8
        .byte   $1F
        .byte   $52
        and     ($A8),y
        eor     $919A,y
        lda     ($D9,x)
        cmp     #$F6
        .byte   $A4
L1F9A:  cmp     #$F2
        lsr     $4B,x
        ror     $45,x
        .byte   $64
        .byte   $F5
L1FA2:  adc     ($45),y
        .byte   $44
        .byte   $1C
        sbc     $D655
        adc     L8319,y
        inc     $EB,x
        and     ($9B,x)
        lda     #$D0
        php
        jsr     LFFE4
        .byte   $67
        brk
        .byte   $AF
        sta     $30,x
        and     ($A9),y
        cpy     #$84
L1FBF:  .byte   $1C
        jsr     L1E4E
        .byte   $1A
        ora     ($55,x)
        lda     #$ED
        txs
        .byte   $9C
        .byte   $32
        asl     L0C23,x
L1FCE:  .byte   $E2
        .byte   $8F
        eor     L4919
        .byte   $17
        ora     $9B,x
        ldy     #$05
        .byte   $20
        .byte   $3E
L1FDA:  nop
L1FDB:  bvs     L1FBF
        dec     $48
        asl     a
        jmp     L4532

        pha
        .byte   $07
        .byte   $3C
        adc     $4E
        bit     L805D
L1FEB:  and     $63,x
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
        bmi     L2073
        .byte   $DA
        .byte   $9E
        eor     ($B9),y
        inc     $C6E3
        eor     #$4B
        ora     L0D85,x
        cpy     L6A1C
        adc     L83A9,y
        .byte   $37
        bit     $0B
        .byte   $C3
        sbc     #$C7
        .byte   $92
        sbc     $C83D
        .byte   $2F
        .byte   $89
        nop
L2021:  .byte   $72
        sta     L74E6,y
        .byte   $02
        sta     $1C
        .byte   $67
        .byte   $0F
        .byte   $3B
        ror     $D4
        .byte   $EB
        .byte   $74
        .byte   $EB
        .byte   $17
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
        .byte   $1F
        .byte   $23
        .byte   $5F
        .byte   $7C
        sta     $8C
        .byte   $1D
        .byte   $F0
L2045:  asl     $348F,x
L2048:  ora     $13
        .byte   $0F
        .byte   $7C
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
        stx     $24,y
        clv
        adc     $A92A,y
        beq     L20A4
        .byte   $AB
        .byte   $8F
        tax
        .byte   $73
        .byte   $F3
        .byte   $87
        .byte   $59
        .byte   $CE
L2073:  lsr     $15,x
        and     L1436
        sbc     ($BD),y
        eor     #$17
        clc
        stx     $D1
L207F:  sta     ($2A),y
        .byte   $5F
        .byte   $EF
        .byte   $02
        nop
L2085:  .byte   $44
        .byte   $5A
L2087:  .byte   $3C
        .byte   $47
L2089:  pla
        sbc     ($8A),y
        tay
        lda     L11B1,y
        .byte   $80
        .byte   $6B
        ora     ($AD),y
        .byte   $B7
        .byte   $12
        rol     a
        .byte   $5A
        .byte   $8F
        txs
        sei
        asl     a
        ror     $29,x
L209E:  php
        php
        .byte   $0C
        dex
        .byte   $6D
        tax
L20A4:  sbc     $E995
        .byte   $3C
        php
        .byte   $0F
        ora     L792C
        .byte   $7A
        .byte   $C7
        adc     $B0
        .byte   $D3
        ldy     $B9CC
        lda     $F0
        ror     $F0
        ldx     #$32
        lda     #$28
        .byte   $E0
L20BE:  .byte   $2F
L20BF:  bpl     L2048
L20C1:  asl     $33
        .byte   $AD
L20C4:  sty     $6F,x
        ldx     L5196
        dec     L732B
        .byte   $E7
        dex
        tay
        .byte   $7B
L20D0:  txa
        .byte   $7C
        dec     $CD65,x
        ora     ($DE,x)
        .byte   $5D
L20D8:  bit     $1ECE
        .byte   $E2
        .byte   $6F
        eor     #$D5
        .byte   $89
        eor     L8F10
        cmp     #$3C
        ldy     $C1
        ldx     #$96
        .byte   $C2
        dey
        .byte   $6F
        .byte   $E7
        and     #$B6
        .byte   $0E
L20F0:  .byte   $CB
        lda     L0FDE
        .byte   $C4
L20F5:  sty     $79
        stx     $9054
        .byte   $C3
        .byte   $53
        asl     $CD,x
        jsr     L38B1
        .byte   $C2
        php
        .byte   $E3
L2104:  .byte   $82
        .byte   $87
        .byte   $43
        .byte   $77
        lda     #$FA
        sbc     $77
        .byte   $5A
        .byte   $C3
        .byte   $17
        .byte   $DB
        ldx     #$B3
        .byte   $37
L2113:  ldy     #$36
        .byte   $D2
        tsx
        ror     $D27E
        ror     $CEB3,x
        .byte   $E3
        .byte   $22
        rol     $CF,x
        .byte   $83
        .byte   $44
        .byte   $C3
        .byte   $CB
L2125:  cli
        .byte   $80
L2127:  asl     L9C98
        dex
        rts

        .byte   $64
        inx
        ror     $62
        .byte   $EB
        .byte   $92
        .byte   $53
        cpy     #$29
        .byte   $37
        .byte   $F2
        .byte   $34
        rol     L87F9,x
        .byte   $32
        ldy     $3D,x
L213E:  .byte   $AB
        .byte   $92
        .byte   $23
        cpy     #$19
        .byte   $8F
        .byte   $14
        sbc     $FA,x
        .byte   $64
        .byte   $F3
        .byte   $53
        .byte   $03
        ora     $EF,x
        .byte   $0C
        .byte   $5F
        lsr     $E9,x
        lda     $47,x
        php
        jmp     (L4C14)

        sbc     #$FB
        asl     a
        .byte   $6B
        .byte   $5B
L215C:  ldy     $D9
        ora     $0720
        cpy     L306C
        sbc     ($C7),y
        .byte   $73
        .byte   $1F
        eor     L707A
        sec
        .byte   $C7
        .byte   $13
        .byte   $7C
        .byte   $E1
L2170:  .byte   $E7
        sbc     L87F3
        lda     #$01
        sty     $34,x
        sbc     $8F9E,x
        sty     $FA84
        sta     $8D
        .byte   $63
        sbc     $9077
        rol     a
        dec     $A60D,x
        cmp     #$DD
        ldy     $A4,x
        .byte   $4F
        cld
        .byte   $DC
        ldx     $E5,y
        lsr     a
        .byte   $35
L2193:  .byte   $14
L2194:  .byte   $99
        .byte   $9D
L2196:  pha
        cmp     L1447,x
        asl     $B5
        .byte   $3B
        .byte   $5A
        cpx     $71
        inx
        .byte   $B7
        lda     $D64E
        .byte   $67
L21A6:  and     #$5C
        ora     $91,x
        .byte   $47
        bpl     L213E
        lda     $91,x
        adc     L1CF7,y
        tya
        .byte   $34
        eor     $4B,x
        .byte   $AF
        tsx
        iny
        dec     L63BC
        .byte   $7C
        ldy     L246B,x
        tsx
        .byte   $F3
        .byte   $93
        .byte   $E3
        cpy     L3C83
L21C7:  sbc     L2EF8,x
L21CA:  cli
        and     $F77A,x
        .byte   $32
        ror     $A1
        stx     $3B,y
        .byte   $C7
        .byte   $83
        .byte   $2F
        sbc     ($E0,x)
        cmp     L3AC6
        ldx     L8AEA
        .byte   $AB
        .byte   $A7
        cmp     $63,x
        ror     $C9F9
        sbc     ($84),y
        cpx     $80
        bit     L87AE
        .byte   $4F
        ror     $06
        cmp     $C951,y
        .byte   $DC
        eor     ($6C,x)
        .byte   $54
        dec     $A923
        .byte   $D3
        cpx     #$10
        .byte   $C3
        and     L7B48,y
        php
        .byte   $64
        .byte   $11
L2203:  lda     #$DC
        .byte   $20
L2206:  .byte   $D7
        bvs     $226C
        jsr     L8F6B
        sty     $00
        .byte   $D7
        cmp     $6E
        bpl     L2226
        .byte   $5C
        txs
        lda     $2A
        ldy     #$A7
        eor     ($08),y
        .byte   $B2
        .byte   $A7
        jsr     LD2D5
L2220:  nop
        .byte   $2B
        adc     $ABA3,x
        .byte   $EE
L2226:  .byte   $3F
        .byte   $7E
L2228:  rti

        .byte   $AB
        .byte   $9C
        .byte   $54
        .byte   $B2
        tsx
        .byte   $CB
        and     #$14
        dey
        .byte   $80
        .byte   $B4
L2234:  .byte   $EF
        cpx     #$BF
        .byte   $0B
        .byte   $3C
        .byte   $C2
        .byte   $6B
        tsx
        adc     ($20,x)
        .byte   $82
L223F:  .byte   $34
        .byte   $82
        .byte   $06
L2242:  .byte   $52
        plp
        .byte   $04
        .byte   $03
        .byte   $63
        inc     $00,x
        sta     $3B
L224B:  .byte   $07
        .byte   $9E
        eor     ($1E,x)
        tsx
        asl     $1F
        .byte   $5A
        and     $7D
        ora     $D4F3,y
        ora     $E2,x
        .byte   $67
        .byte   $CF
        .byte   $54
        .byte   $13
        ora     $E5
        .byte   $1C
        ora     ($F1),y
        lda     ($12,x)
        bne     L22AD
        .byte   $93
        eor     ($86,x)
        jmp     L9828

        lda     ($48,x)
        sbc     ($49,x)
        and     ($59,x)
        cmp     $ED
        lda     $FC1C,y
        tya
        rti

        .byte   $A5
L227B:  bit     $13
        ror     L2705,x
        .byte   $EB
        .byte   $37
        .byte   $32
L2283:  .byte   $DB
        .byte   $E3
        .byte   $F7
        jsr     LCD05
        sed
        .byte   $50
L228B:  .byte   $D7
        cld
        cmp     $6F
        .byte   $9E
        .byte   $5B
        eor     $BEF5,x
        sta     $E36D,y
        .byte   $5E
        .byte   $8D
L2299:  .byte   $80
        .byte   $7A
        .byte   $0D
L229C:  sbc     $5B,x
        .byte   $7B
        sta     ($26,x)
        iny
        cpy     $CB28
        .byte   $1B
        .byte   $C3
        jmp     LE38A

        .byte   $25
L22AB:  .byte   $20
        .byte   $E1
L22AD:  eor     $57,x
        tax
L22B0:  cmp     L482B,x
        lda     $CF5C,x
        dec     $06
        .byte   $B2
        clv
        .byte   $E2
        bcs     L223F
        .byte   $CB
        .byte   $92
        .byte   $B2
        .byte   $92
        cmp     $02
        .byte   $C7
        .byte   $82
        cmp     ($D2,x)
        .byte   $DC
        sbc     ($0A,x)
        bcs     L22DF
        .byte   $CB
        inc     $B44E
        eor     $945D,x
        .byte   $87
        .byte   $C7
        sbc     $61
        cld
        .byte   $7A
        .byte   $64
        lda     #$8A
        sbc     #$0E
        .byte   $C2
L22DF:  .byte   $7C
        and     #$13
L22E2:  .byte   $D3
L22E3:  .byte   $0F
        lsr     a
        .byte   $E3
        .byte   $74
        .byte   $C0
L22E8:  adc     ($2A),y
        .byte   $3F
        sbc     $FCB6
        bit     $FCB6
        and     #$91
        .byte   $0B
L22F4:  rol     $B50A
        .byte   $43
        sbc     L7E3D
        .byte   $80
        .byte   $B2
        .byte   $42
        ldy     $03,x
        .byte   $6D
L2301:  cpy     $31F9
        ora     ($B3,x)
        .byte   $DF
        tax
        .byte   $DC
        .byte   $9B
        .byte   $52
L230B:  .byte   $8C
L230C:  dec     $FC
        ora     ($52,x)
        .byte   $8D
        .byte   $32
L2312:  .byte   $5F
        .byte   $F7
        adc     $F031,x
        ldy     $F08C
        pha
        .byte   $AD
        .byte   $CD
L231D:  cpx     #$DC
        dec     $CA48,x
        .byte   $3E
        .byte   $29
L2324:  .byte   $71
L2325:  .byte   $7B
        sta     $DC0A
        .byte   $F2
        .byte   $51
L232B:  cmp     $4D
        rti

        eor     ($93),y
        sta     ($1D),y
        .byte   $64
        .byte   $0B
        cmp     $C9
        .byte   $89
        adc     $58,x
        sed
        ora     L24B4
        cli
        bvs     L22F4
        cli
        .byte   $72
        ldy     $41,x
        jmp     L8D7E

        .byte   $67
        .byte   $47
        .byte   $44
        txs
        .byte   $52
        .byte   $44
L234D:  .byte   $FC
        lda     L094C
        ldx     L70CB
        eor     ($04,x)
        .byte   $5C
        .byte   $CF
        .byte   $1C
        and     ($13,x)
        .byte   $3C
        .byte   $BB
        .byte   $44
        jmp     (LE4BA)

        sty     LE4BA
        ldy     L29B1
        .byte   $A3
        .byte   $93
        .byte   $80
        cmp     L46A6
        tya
        lda     #$30
        sbc     $83
        .byte   $E7
        .byte   $0F
        and     ($A6,x)
        ldy     $FB,x
        .byte   $CB
        .byte   $72
        plp
        .byte   $80
        .byte   $4B
        .byte   $3F
        brk
        sty     $11
        .byte   $8B
        .byte   $FD
L2383:  lsr     a
        brk
        .byte   $54
        .byte   $1F
        .byte   $E4
L2388:  .byte   $19
        .byte   $66
L238A:  .byte   $0C
        .byte   $6F
L238C:  bpl     L23E2
        stx     $B1,y
        sbc     $4A,x
        lsr     $8C
        cpy     $49
        .byte   $FA
        lsr     a
        .byte   $9F
        ldy     $8A
        pha
        .byte   $63
        lda     L7180,y
        nop
        txs
        bit     $08
        .byte   $67
        .byte   $23
        .byte   $D2
L23A7:  iny
        .byte   $5F
        dec     $F6
        .byte   $6F
        jsr     L2EA6
        ldy     #$42
        cpy     $C592
        cpx     L699E
        clv
        dec     $DBB7
        and     $8E
        sbc     L2C93,x
        .byte   $4B
        .byte   $2B
        .byte   $03
        lsr     L551C,x
        jmp     LAC75

        ora     #$8A
        ldy     $8D
L23CD:  .byte   $1C
        .byte   $87
        sec
        cmp     #$9F
L23D2:  ldy     $73
        .byte   $1C
        plp
        .byte   $42
        ror     $1D,x
        adc     $B67E,y
        nop
        dec     $BCBE,x
        .byte   $3F
        .byte   $8B
L23E2:  and     ($20),y
        rol     a
        .byte   $82
        eor     L82CA
        adc     #$86
        asl     a
        ldx     $AAB4,y
        .byte   $FA
        pha
        ldx     $AB
        .byte   $E2
        sta     ($A2),y
        txa
        and     $C722,y
        and     ($43),y
        .byte   $1A
        cmp     $D4A6
        .byte   $82
        and     ($76),y
        .byte   $9C
L2404:  .byte   $C2
        ora     $E7ED,y
        .byte   $5A
        .byte   $C6
L240A:  nop
L240B:  lsr     $03
        eor     $93
        lsr     $3B
        ror     $F33B,x
        ror     a
        .byte   $BB
        sei
        and     $C939,x
        lda     ($A4),y
        .byte   $E2
        .byte   $E2
        .byte   $26
L241F:  .byte   $33
        .byte   $5E
        .byte   $43
L2422:  .byte   $0C
        .byte   $7C
        lda     $E7,x
        tya
        sbc     #$CB
        .byte   $54
        .byte   $D4
        sta     $45
        .byte   $8F
        .byte   $DB
        .byte   $C7
        .byte   $67
        .byte   $3F
        sei
        brk
        asl     $9100,x
        asl     a
        sty     L2D78
        cpx     #$8F
        sta     ($2C,x)
        tay
        bne     L246A
        clv
        bcs     L241F
        .byte   $13
        ora     L5A8B,x
        and     $52
        .byte   $0B
        .byte   $43
        lda     $9D25
        adc     $B0
L2452:  sta     ($C4,x)
L2454:  lda     #$48
        lda     L1F6B,y
        dey
        sbc     L1F69,y
        .byte   $13
        .byte   $33
        .byte   $8B
        ror     a
        stx     $22
L2463:  ldy     L656E
        .byte   $23
        .byte   $8F
        asl     a
L2469:  .byte   $37
L246A:  .byte   $94
L246B:  .byte   $03
        .byte   $A3
        sei
        .byte   $93
        stx     $B1,y
        bcc     L240A
        stx     $91,y
        .byte   $89
        .byte   $82
        sec
        .byte   $3E
L2479:  .byte   $D9
L247A:  eor     #$2B
        ora     $99,x
        eor     #$68
        .byte   $F2
        ldy     $40
        lda     $F3
        beq     L24D3
        txa
        rol     a
        cpx     #$9A
L248B:  .byte   $04
        sbc     $D9
        .byte   $9E
        adc     $F75F,x
        .byte   $DF
        sbc     #$19
        dec     $D106,x
        .byte   $1A
        bcc     L248B
        jsr     L2E50
        sta     ($2C),y
        adc     #$24
        .byte   $F0
L24A3:  .byte   $79
L24A4:  lsr     $1D
        .byte   $1B
        .byte   $5F
        ror     $1B
        .byte   $5F
        .byte   $87
        lsr     $D7
        cmp     L5F1B,y
L24B1:  sta     $A1
        .byte   $03
L24B4:  .byte   $72
        eor     L1326
L24B8:  .byte   $02
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
        .byte   $D6
L24CB:  sbc     $B965,y
        .byte   $F2
        .byte   $43
L24D0:  ora     L294C
L24D3:  and     ($AD,x)
        ora     $24,x
        rol     $57,x
        sta     $CF36
        .byte   $D4
        .byte   $37
L24DE:  cmp     ($03,x)
        sbc     $E650,y
        .byte   $B2
        .byte   $80
        tsx
        .byte   $92
        cmp     $FD7D
        .byte   $AB
        sta     ($23,x)
        sta     L68FF,y
        cpx     $24
        jmp     L34BD

        tsx
        stx     LE8D3
        .byte   $13
        sei
        ora     ($C2,x)
        lsr     $D8
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
L2515:  cmp     $C93E
        .byte   $23
L2519:  adc     $EC13,x
        stx     $37,y
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
L252C:  sta     $FB91
        inc     $FB
        bne     L2599
        .byte   $0F
        cmp     L32BE,x
        ldy     $3B,x
        eor     L6ABD,x
        .byte   $55
L253D:  .byte   $7F
        asl     L8DD2,x
        ora     #$D0
        jsr     L3175
        .byte   $A7
        .byte   $7C
        .byte   $9C
        .byte   $63
        php
        .byte   $D4
        pha
        clc
        ror     $92
        .byte   $72
        .byte   $14
        sty     $DF,x
        bcs     L2584
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
        bvs     L252C
        inc     $14,x
        cmp     $41
        .byte   $3F
        beq     L2515
L256D:  brk
        .byte   $74
        cli
        rol     $F44A,x
L2573:  .byte   $47
        .byte   $3C
        rts

        .byte   $43
        asl     a
L2578:  rti

        .byte   $1F
        clc
        .byte   $92
        .byte   $23
        .byte   $53
        .byte   $14
        .byte   $8B
        .byte   $F9
        .byte   $A3
L2582:  cpx     $12
L2584:  .byte   $4E
        .byte   $21
L2586:  bcs     $2547
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
L2599:  pha
        sta     $3F
        cmp     L6464
        ora     #$01
        dec     $64
        asl     $F1F2
        and     L4ECE,x
L25A9:  eor     ($73,x)
        cpx     $EBE4
        dec     $BD2F
        bvc     L25EE
L25B3:  inx
        .byte   $FA
        cmp     $31,x
        ora     $0C,x
        .byte   $44
        bvs     L2603
        .byte   $92
        sta     ($04,x)
        .byte   $9D
L25C0:  jsr     L003E
        bne     L25DB
        lsr     a
        sta     ($E1,x)
L25C8:  sta     $48,x
        ora     L751E
        .byte   $80
        .byte   $D4
        cpx     $22
        .byte   $47
        rol     $04
        .byte   $13
        .byte   $22
        sta     ($0D),y
        iny
        .byte   $4F
        .byte   $34
L25DB:  .byte   $FB
        .byte   $62
        clc
        cpx     #$C1
        eor     #$91
        stx     $0D
        adc     L7B68
        .byte   $D2
        .byte   $9F
        .byte   $A7
        bne     L2578
        .byte   $5C
        .byte   $8C
L25EE:  .byte   $5B
        tsx
        ldy     L4A41,x
        .byte   $62
        .byte   $8B
        nop
        bvs     L260C
L25F8:  bit     $FE
        bmi     L260F
        lda     $FD
        cmp     $4C
        .byte   $2F
        .byte   $EE
        .byte   $52
L2603:  and     $9400,y
        .byte   $1C
        ora     #$52
        .byte   $02
        .byte   $0E
        .byte   $29
L260C:  .byte   $30
L260D:  lda     $33
L260F:  .byte   $0F
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
        ldy     $D500
        sta     L6138,y
        .byte   $EB
L2625:  .byte   $0C
L2626:  sty     $89
        .byte   $07
        .byte   $0C
        cmp     ($DC),y
        adc     L67E7
        .byte   $27
        .byte   $4F
L2631:  cmp     ($05),y
        jsr     L0CA8
        sta     ($C6,x)
        .byte   $B6
L2639:  .byte   $92
        .byte   $CB
        cmp     #$94
        .byte   $80
L263E:  sta     $BD07,x
        and     ($0C,x)
        .byte   $0F
        .byte   $1F
        and     ($D0),y
        .byte   $7C
L2648:  .byte   $9E
        adc     ($6C),y
        adc     L24A4,y
        .byte   $63
        asl     L8871,x
        sbc     ($A1,x)
        tsx
        cpy     $28
        .byte   $42
        lsr     L6A68
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
        .byte   $FB
        .byte   $83
        .byte   $9E
        cpx     #$F1
        bmi     L26B3
        .byte   $BE
L2678:  .byte   $B7
        lsr     L4940
        .byte   $EB
        .byte   $5B
        inc     $9F
        .byte   $64
        adc     $BE,x
        .byte   $89
        inc     $49,x
        .byte   $5B
        nop
        .byte   $9F
        .byte   $64
        lda     $DF,x
        ldy     #$53
        eor     #$56
        rts

        ora     L488C,x
        sty     L682C
        .byte   $83
L2698:  .byte   $22
        .byte   $F2
        .byte   $1C
        .byte   $82
        .byte   $17
        lda     $D4,x
        ldx     $08
        pla
        cld
        pha
        cpx     $A0
L26A6:  cmp     $62
        .byte   $83
        .byte   $97
        .byte   $F2
        cpy     #$45
        stx     $A5,y
L26AF:  .byte   $9F
        ora     ($D9),y
        tya
L26B3:  .byte   $33
        sbc     L7566,x
        .byte   $3F
        sty     $98,x
        .byte   $14
        .byte   $62
        .byte   $9C
L26BD:  ldy     #$B1
        .byte   $80
        .byte   $BF
L26C1:  rts

        .byte   $BF
        .byte   $9E
        .byte   $1A
        cpy     $A972
        .byte   $02
        clc
        sbc     L5F87,x
        dec     $1D,x
L26CF:  .byte   $7F
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
        .byte   $CE
L26F0:  sbc     ($FD),y
        cpy     $91
        ldy     $AAE3,x
        lda     $1C
        dec     L0C49
        .byte   $54
        .byte   $1C
        stx     $1B
        ldy     $8E
        ldx     $C7
        .byte   $E4
L2705:  .byte   $C3
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
        lsr     L0311,x
        ora     L0CC4
        .byte   $C3
        adc     ($05),y
L2722:  cpy     $A13B
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
        .byte   $F2
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
L276E:  .byte   $1E
        .byte   $0C
L2770:  .byte   $9C
        tya
        asl     $1D,x
L2774:  eor     $3F
        ora     ($44,x)
        cpy     $AE
        .byte   $5F
        lda     $0C,x
        .byte   $B0
L277E:  ora     #$72
        lsr     a
        ldx     $9E
        .byte   $04
        cpy     $98
        .byte   $72
        .byte   $EE
L2788:  adc     ($95),y
L278A:  .byte   $12
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
L279E:  sbc     #$07
        tax
        lsr     a
        .byte   $80
        ora     $24,x
        .byte   $04
        sta     ($42,x)
        .byte   $80
        stx     $6E,y
        sta     ($29,x)
L27AD:  cpy     #$BB
        .byte   $BB
        .byte   $80
        asl     a
        lda     $3F,x
        .byte   $52
L27B5:  .byte   $63
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
L27E0:  .byte   $CB
        .byte   $C7
        .byte   $53
        eor     $43
        eor     $53
        lsr     $68
        ora     #$69
        .byte   $42
        ldy     $47,x
L27EE:  eor     ($9C,x)
        .byte   $6F
        .byte   $D3
        sbc     L2F9C
        dec     $53
        cpy     L416B
        .byte   $9D
L27FB:  inc     $93
        sbc     $AE9E
        cmp     $3C
        lsr     $87,x
        ror     $BB33
        .byte   $FA
        adc     $90D4,x
        .byte   $46
L280C:  txa
        ora     ($D4,x)
        sta     L8A46,y
        sta     ($B1,x)
        .byte   $83
        tsx
        sbc     ($82,x)
        bvc     L27FB
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
        sty     L1FCE
L283D:  .byte   $44
        ora     ($50),y
        .byte   $CF
        sty     L41AA
        sta     ($FF,x)
        rts

        ror     L6840,x
        .byte   $67
        jsr     L4475
        asl     L8C41,x
        .byte   $9E
        stx     $64
        ora     $F6E9,y
        .byte   $5C
        ldy     $86
L285A:  .byte   $3B
        sty     $D1,x
L285D:  jsr     LE74E
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

        .byte   $DA
        .byte   $5E
L2872:  .byte   $14
        .byte   $97
        .byte   $8B
        .byte   $72
        eor     $29,x
        sbc     $30,x
        clv
        .byte   $7C
L287C:  sta     L65EC,y
L287F:  .byte   $63
        .byte   $E3
        .byte   $3A
        cmp     ($4B),y
        ora     L160C,x
        .byte   $3E
        .byte   $31
L2889:  ldy     $4A
L288B:  .byte   $1F
        .byte   $5C
        rol     L3138,x
L2890:  lda     $9F,x
        stx     L260D
        brk
        asl     $7B,x
        inc     L53C3
        cpy     $DD
        .byte   $AF
        .byte   $1A
        brk
        sty     $F3
        bne     L287F
        sty     L40B0
        .byte   $03
        dec     $36
L28AA:  plp
        ora     ($D9,x)
        sbc     $FC
        lda     ($4A),y
L28B1:  .byte   $04
        .byte   $D2
        adc     ($7E,x)
        .byte   $62
        .byte   $07
        inc     L3EB5
        tya
        sta     L6718
        stx     L0C64
        adc     ($4D,x)
        bmi     L28CD
        .byte   $B9
L28C6:  bne     $292F
        .byte   $DC
        .byte   $9C
        eor     $A9,x
        .byte   $FB
L28CD:  .byte   $92
        .byte   $23
        lda     ($B9,x)
        .byte   $9C
        .byte   $C7
        .byte   $B2
        .byte   $64
        .byte   $B3
        dec     L3F9A
        .byte   $52
        .byte   $7A
        dec     L2CA7
        cld
L28DF:  .byte   $67
        .byte   $0F
        inc     L2B80,x
        .byte   $8F
        .byte   $8F
        lda     #$4A
        .byte   $02
        .byte   $52
        and     ($A1,x)
        .byte   $DC
        sta     ($79),y
        .byte   $5A
        .byte   $1F
        lda     ($1A),y
        asl     L1544,x
        stx     $4A
        rts

        .byte   $77
        sbc     ($C4),y
        nop
        .byte   $7F
        .byte   $9C
        .byte   $FB
        .byte   $7A
        rol     a
L2902:  sta     $D5F1,y
        .byte   $DB
        sbc     ($2A),y
        brk
        .byte   $FB
        .byte   $93
        sbc     ($2A,x)
        .byte   $9B
        inc     $44
        bne     L2902
        .byte   $67
        .byte   $C7
        .byte   $47
        .byte   $51
L2916:  ora     ($32,x)
        asl     L0E21,x
        .byte   $6F
        cpy     #$F9
        sbc     $C227,x
        rti

        inc     $980F,x
        .byte   $B2
        ror     $7E
        and     (L0081),y
        .byte   $23
        .byte   $1B
        inc     $97,x
        .byte   $F4
        ldx     L3C90,y
        .byte   $6F
        inc     $82
        .byte   $3C
        inc     L7EE9,x
        cpy     $FF3C
        .byte   $03
        cpy     $C8BC
L2940:  sta     $21
        .byte   $4B
        .byte   $34
        .byte   $37
        and     #$11
        .byte   $DC
        sta     $9E0F
L294B:  .byte   $61
L294C:  dec     $E861
        sta     $AFF2
        and     ($C0),y
        .byte   $AB
L2955:  lsr     $F1B8
        sed
        rts

        .byte   $A7
        ora     ($54),y
L295D:  .byte   $53
L295E:  eor     #$5E
        .byte   $23
        .byte   $57
        inc     $E7
        .byte   $14
        brk
        plp
        brk
        .byte   $3C
        .byte   $53
        lda     ($7E),y
L296C:  rti

        .byte   $07
        .byte   $80
        brk
        cpy     #$0A
        brk
        .byte   $0B
L2974:  rti

        .byte   $0C
        ldy     $00,x
        ror     L7500
        cpy     #$02
        bpl     L2983
        rts

        .byte   $04
        .byte   $B0
L2982:  .byte   $05
L2983:  brk
        ora     $50
        ora     $95
        .byte   $1A
        sed
        .byte   $02
        jsr     L4803
        .byte   $03
        bvs     L2994
L2991:  tya
        .byte   $03
        .byte   $D6
L2994:  brk
        asl     a:$BA,x
        dec     L412A,x
        sbc     ($40,x)
        sei
        lsr     L20C4
        stx     $B358
        .byte   $42
        ora     #$B3
        lsr     a
        txs
        .byte   $BF
        rol     $AA35,x
        .byte   $0D
        .byte   $06
L29AF:  ora     ($E6),y
L29B1:  cmp     L48F8,y
        .byte   $77
        eor     $02,x
        .byte   $6B
        lsr     a
        cpx     $F7
        .byte   $99
L29BC:  sei
        bcs     $29C9
        and     ($E2,x)
        ldx     $46,y
        bvc     L29D9
        ldx     $9F34,y
        .byte   $3F
        sta     ($86),y
L29CB:  eor     ($47),y
        .byte   $74
        .byte   $7B
        lsr     $B1,x
        lsr     $CA,x
L29D3:  .byte   $BF
        cmp     ($D1),y
        ora     L14C8,x
L29D9:  tsx
        .byte   $34
        sbc     L583A,y
        and     ($FB),y
        .byte   $27
        cpx     $92
        .byte   $90
L29E4:  .byte   $FF
        .byte   $63
        .byte   $5F
        sbc     $AC89,y
        sed
        cmp     ($80),y
        .byte   $34
        ldx     $8D
        ora     L6303,y
        .byte   $DB
        .byte   $EB
        .byte   $FD
        .byte   $8F
L29F7:  .byte   $6F
L29F8:  .byte   $BF
        inc     $2C,x
        cmp     $40
        .byte   $F2
        jmp     L02BC

        .byte   $63
        .byte   $77
        cpy     #$AB
L2A05:  eor     $00
        .byte   $E3
        .byte   $77
        sta     $DEC6,y
        cpx     $03
        inc     L3F65,x
        .byte   $62
        .byte   $34
        and     L1ADC,x
        eor     $9989,y
        .byte   $89
        asl     L00F9,x
        and     L7F69
        .byte   $32
        .byte   $74
        .byte   $34
        and     L2B0A,x
        rti

L2A26:  .byte   $B7
        .byte   $42
        .byte   $53
        adc     (L003E,x)
        .byte   $EB
        rti

        .byte   $37
        .byte   $52
        asl     a
        and     L003E,x
L2A32:  nop
        lsr     $A912
        ldy     $DC,x
        bit     L0081
        sty     $DD,x
        .byte   $BE
L2A3D:  .byte   $65
L2A3E:  .byte   $8F
        ldx     L00F9,y
L2A41:  tya
        .byte   $22
        asl     L6203
        lsr     $023C
        clc
        beq     L2A55
L2A4C:  .byte   $04
        .byte   $63
        .byte   $C2
        .byte   $A7
L2A50:  .byte   $02
        .byte   $37
        cmp     $98
        .byte   $FE
L2A55:  .byte   $A0
L2A56:  php
        sta     L3725,y
        lsr     a
        .byte   $7F
        ldx     $7C
        ldx     a:L0081
        ora     ($80,x)
        .byte   $02
        sta     ($85,x)
        .byte   $E2
        and     #$01
        .byte   $72
        bvs     L2AAB
        .byte   $BF
        sei
L2A6E:  ora     #$00
        ora     ($80,x)
        php
        ora     ($BC,x)
        lsr     $B517,x
        .byte   $B7
        .byte   $57
        dec     $9E,x
        ldx     $DA,y
        asl     $1B,x
        .byte   $F7
        .byte   $4B
        sei
        bit     $23
        .byte   $77
        sbc     L276E,x
        .byte   $A4
L2A8A:  ldx     $9D
        lda     $3F00,x
        .byte   $DF
        sbc     $1F
        .byte   $DF
        .byte   $8F
        sta     $B8D1,y
        inc     $78,x
        .byte   $7F
        rol     $B206,x
        .byte   $D3
        sbc     L09FF,x
        sbc     $F9BC,x
        sta     L8F13,x
        sta     ($B1,x)
        .byte   $BC
        .byte   $FF
L2AAB:  asl     $0100,x
        and     (L0056,x)
        sed
        .byte   $89
        dec     $B9
        .byte   $0F
        dex
        lda     #$10
        and     $26
        clc
        sta     L5F19,x
        .byte   $63
        .byte   $5C
        lsr     L7591
        .byte   $D2
        sbc     L7140,x
        clc
        inc     $FEB2,x
        inc     $FF,x
        ldx     L8B89
        .byte   $EB
        .byte   $DB
        .byte   $EB
        .byte   $5B
        brk
        rts

        .byte   $0B
        inc     $9D56
        .byte   $6F
        .byte   $8F
        .byte   $75
L2ADD:  .byte   $F3
        adc     $E15B
        .byte   $F3
L2AE2:  .byte   $61
L2AE3:  .byte   $D7
        sta     $E7,x
        .byte   $1C
L2AE7:  .byte   $42
        ror     L361F,x
        ora     $D87C,x
        eor     $9E57,y
        .byte   $67
        cmp     $E7DE
        lsr     $C0
        bit     $BAF9
        .byte   $B3
        ldx     $E301,y
        inc     $C2
        tsx
        lda     #$97
        rol     L2A6E,x
        .byte   $AF
        ldy     L003E,x
L2B09:  .byte   $F6
L2B0A:  .byte   $1F
        rol     $77,x
        adc     ($AA,x)
        dec     $47,x
        cmp     $ADD5
L2B14:  .byte   $F3
        eor     ($1F,x)
        rol     $7D,x
        .byte   $1B
        .byte   $E2
        .byte   $F4
        brk
        .byte   $E3
        inc     $DB
        .byte   $AF
        .byte   $9B
        .byte   $1B
        .byte   $CB
        .byte   $6B
L2B25:  inc     $AC
        .byte   $EB
        lda     ($B6),y
        .byte   $CF
        .byte   $04
        inc     L6D3E,x
        .byte   $32
        sbc     #$A7
        .byte   $8F
        txs
        .byte   $BB
        ror     a
        sbc     L003E,x
        ldx     L2B6C,y
        jmp     LE6B3

L2B3E:  .byte   $BF
        rol     L892F
        cpy     #$3A
        sbc     $E3B0,y
        .byte   $E7
        .byte   $6F
        ror     $0774,x
        sbc     $F3,x
        adc     L0B7A
        .byte   $D7
        cmp     $A985
        asl     $D57C
        beq     L2B3E
        .byte   $4B
        sbc     ($F3,x)
        adc     ($C7,x)
        cmp     L5635
        .byte   $47
        sty     $80,x
        .byte   $62
        dec     L5F56,x
        and     ($78,x)
        .byte   $7C
L2B6C:  cld
        adc     $F3,x
        bcc     L2BE6
        clv
        eor     L46D1,x
        .byte   $B7
        .byte   $FA
        sbc     $CCAD,y
        inc     $40,x
        rol     L713E
        .byte   $61
L2B80:  .byte   $F7
        rol     $B36E,x
        .byte   $FA
        .byte   $B4
L2B86:  inx
        .byte   $03
        .byte   $8F
        .byte   $9C
        cpx     $EB
        inc     $B3
        .byte   $3A
L2B8F:  jmp     LF97A

        .byte   $CF
        rol     L6C3E
        .byte   $33
        .byte   $5F
        .byte   $4B
        beq     L2BE4
        .byte   $BB
        .byte   $61
L2B9D:  lsr     $84,x
        iny
        .byte   $6B
        .byte   $7B
        eor     $75,x
        .byte   $63
        .byte   $7C
        ldy     $97
        .byte   $0F
        .byte   $9B
        .byte   $04
        .byte   $F9
L2BAC:  .byte   $64
        inc     $E7AD,x
        .byte   $3F
        bvs     L2BAC
        bcs     L2C20
        inc     $EF
        tax
        ldy     $E9
        .byte   $AF
        .byte   $9B
        .byte   $E7
        .byte   $2F
        sty     $DC,x
        dey
        .byte   $63
        sbc     $0E
        cld
        .byte   $7B
        .byte   $6B
        inc     $C1
L2BC9:  .byte   $AF
L2BCA:  txs
        .byte   $D4
        and     $1A,x
        bvs     L2BC9
        bcs     L2C42
        sbc     $B54E,y
        .byte   $7C
        adc     ($BB),y
        .byte   $9B
        .byte   $D7
        bmi     L2BF8
        .byte   $7C
        .byte   $D4
        .byte   $E7
        .byte   $82
        .byte   $07
        ora     L3975,x
L2BE4:  .byte   $13
        .byte   $D7
L2BE6:  cmp     L792E
        .byte   $07
        sbc     $F3,x
        .byte   $9E
        .byte   $5C
        .byte   $7C
        cmp     L1470,x
        .byte   $3F
        .byte   $9F
        and     L3333,x
        .byte   $66
L2BF8:  lda     $BE,x
        .byte   $67
        lsr     $21,x
        sbc     ($F3),y
        .byte   $6D
        .byte   $59
L2C01:  .byte   $5C
        sta     ($9F),y
        rol     $DC,x
        adc     ($F1),y
L2C08:  cmp     #$6D
        .byte   $93
        cmp     $47,x
        and     L81E5,y
        clv
        asl     $E5
L2C13:  .byte   $9F
        rol     $1A,x
        cpx     $CC
        stx     L711B
        asl     $EDC2
        .byte   $FF
        .byte   $8F
L2C20:  .byte   $9B
        .byte   $8B
        ldx     $B8AE
        .byte   $F9
L2C26:  nop
        .byte   $B2
        .byte   $C2
        .byte   $D7
L2C2A:  tax
        .byte   $CE
        .byte   $C4
L2C2D:  txa
        .byte   $D2
        rol     L6C3E
        .byte   $6C
L2C33:  .byte   $AD
        .byte   $92
L2C35:  sed
        cmp     L60E1,x
        .byte   $77
L2C3A:  .byte   $AF
        bit     $E318
        inc     $B6
        .byte   $DB
L2C41:  .byte   $02
L2C42:  .byte   $DB
        .byte   $73
        .byte   $AF
        .byte   $81
L2C46:  txs
        ldx     $AA3C,y
        ldy     $B3FA
        .byte   $BB
        .byte   $D3
        and     L168A,x
        txs
        brk
        and     ($15,x)
        .byte   $92
        eor     $B195,y
        .byte   $F3
        .byte   $5A
        .byte   $B7
        .byte   $43
        asl     $BE
        jmp     (L98EE)

        sbc     L48BA,y
        asl     a
L2C67:  cmp     ($D6),y
        rol     L536D,x
        jsr     LC341
        inc     $C9
L2C71:  .byte   $CB
L2C72:  inc     $B5
        .byte   $C3
        inc     $C1
        .byte   $C3
        lda     L6C19
L2C7B:  rti

        .byte   $52
        sbc     #$8A
        .byte   $DA
        .byte   $DF
        bne     L2CC7
        sbc     L4CAD,y
        bne     L2CBE
        .byte   $3C
        .byte   $AB
        .byte   $37
        .byte   $DA
        .byte   $B3
        ldx     $B8,y
        eor     L30D6
L2C92:  .byte   $50
L2C93:  sbc     ($3A),y
        bvc     L2C35
        inc     $CAC1
        lsr     $B5C2,x
L2C9D:  ora     L188A,y
        sbc     L70A6,y
        .byte   $97
        .byte   $47
        .byte   $44
        .byte   $F1
L2CA7:  .byte   $4F
        .byte   $2B
        lda     $DE
        .byte   $89
        bcc     L2C46
        stx     $E9,y
        lsr     a
        rol     a
L2CB2:  brk
        .byte   $C7
        dex
        .byte   $64
L2CB6:  and     ($F3),y
        ror     $C2
        sed
        php
        .byte   $32
        .byte   $53
L2CBE:  lsr     $E927,x
        .byte   $32
        adc     $D632,y
        .byte   $DD
        .byte   $35
L2CC7:  .byte   $F3
        lsr     $97,x
        .byte   $1F
        cpy     #$AD
        pha
        .byte   $DF
        .byte   $03
        lda     $E5,x
        .byte   $5B
        rts

        .byte   $C7
        cmp     L2463
        .byte   $5A
        lda     $06F3,x
L2CDC:  .byte   $B2
        ldx     $EEFA,y
        .byte   $1F
        .byte   $AF
        .byte   $9C
        .byte   $AB
        .byte   $E2
        .byte   $B2
        .byte   $B3
        ora     ($6A,x)
        cpx     #$78
        .byte   $F2
        cpy     #$5E
        lda     #$69
        sed
        .byte   $9E
        .byte   $14
        dec     L7CBA
        and     $F9F4,x
        ldx     $CF,y
        .byte   $9B
        .byte   $9B
        jmp     (LB06E)

L2D00:  .byte   $42
        .byte   $02
        .byte   $CF
        .byte   $9B
        .byte   $1C
        cpx     $13
        .byte   $CF
        bit     $AB44
        .byte   $B7
        sta     $02
        clv
        .byte   $D7
        .byte   $4F
        asl     a
        .byte   $31
L2D13:  eor     $75F3,y
        sbc     $98F3
        asl     $F319
        adc     L6D67
        lsr     $9F7F,x
        rol     $16,x
        adc     L4A48,y
        ora     ($71,x)
        .byte   $5B
        cpy     L0C6A
        sed
        .byte   $7C
        cld
        sei
        .byte   $7C
        .byte   $E3
        bit     L1718
        .byte   $1F
        sec
        rol     $C7E9,x
        cmp     L44B6
        bpl     L2D40
L2D40:  adc     $F3,x
        adc     ($9F,x)
        sec
        adc     ($7B,x)
        .byte   $9F
L2D48:  asl     a
        brk
        .byte   $5C
        .byte   $7C
        cmp     L3CF2,y
        adc     $F3,x
        rts

        adc     #$9E
        .byte   $57
        eor     L66D7,y
        .byte   $73
        .byte   $9F
        and     L7D67,y
        lda     $9CF4
        sbc     $BAAA,y
        lda     #$E5
        tya
        ldx     $DD,y
        inx
        .byte   $22
        ora     ($8D,x)
        dec     $D6,x
        ora     $7C,x
        adc     L5E59,y
        cmp     L715E,x
        .byte   $F3
        .byte   $81
L2D78:  adc     L7110,y
        .byte   $9D
        sei
L2D7D:  .byte   $EB
        .byte   $4F
        adc     $09,x
        .byte   $C7
        sta     $65,x
L2D84:  eor     $99,x
L2D86:  .byte   $6F
        asl     $DD58,x
        cmp     #$29
L2D8C:  adc     L20D0
        .byte   $BF
        .byte   $1E
L2D91:  eor     $38,x
        .byte   $BB
        dec     $45
        .byte   $6F
        clc
        rol     $9C
        .byte   $7C
        .byte   $F2
        .byte   $1C
L2D9D:  sbc     ($F3),y
L2D9F:  .byte   $4B
L2DA0:  eor     L6C55,x
        php
        ora     $6B
        .byte   $C2
        cmp     L665B
L2DAA:  .byte   $7C
L2DAB:  .byte   $F9
L2DAC:  and     ($DA,x)
        cld
        .byte   $72
        bmi     L2DAB
        .byte   $7C
        dec     $67,x
        cmp     $D7A5
        .byte   $02
        asl     L7CBC
        cld
        .byte   $57
L2DBE:  dec     $3A,x
        adc     ($F3),y
        .byte   $5F
        sta     L604E
        .byte   $5C
        stx     $94
        .byte   $B7
        cpy     $20
        ora     $D87C,x
        adc     ($F3),y
        sty     $EEF9
        adc     L369F
        .byte   $DC
L2DD8:  cmp     $C0
        .byte   $87
        .byte   $1F
        sec
        .byte   $3F
        lda     $ECF7
        cmp     L3BCE,x
        rol     L3A08
        sbc     $EBB0,y
        inc     $EA
        .byte   $E2
        .byte   $FB
L2DEE:  bit     $2C
        .byte   $FA
        cmp     $3C,x
        beq     L2DEE
        bcs     L2DBE
        jmp     LE61C

        .byte   $72
L2DFB:  asl     $B8
        sbc     $CCAC,y
        sed
        .byte   $0C
        .byte   $CF
        bcs     L2DAC
L2E05:  ldx     $B4,y
        .byte   $89
        .byte   $CF
        txs
        .byte   $AE
L2E0B:  .byte   $42
        .byte   $32
        bvc     L2E1D
        ldx     L3A6C,y
        sbc     L8BCC,y
        ora     $027F
        cmp     L1674,y
        bit     $01
L2E1D:  adc     $DC
        bit     $43
        ora     ($71,x)
        .byte   $F3
        .byte   $57
L2E25:  lsr     $DD,x
        .byte   $C7
        cmp     L645E
        ror     $EF
        .byte   $5F
        and     $BE,x
        .byte   $1F
        rol     $1D,x
        .byte   $79
        .byte   $72
L2E35:  sbc     $DD,x
        bit     $67
        .byte   $27
        .byte   $23
        eor     $F1,x
        iny
        .byte   $07
        .byte   $5F
        rol     $1D,x
        .byte   $7C
        sbc     ($91),y
        ora     $C7,x
        .byte   $5F
        .byte   $27
        sei
        .byte   $BF
        asl     L6B5C,x
        adc     ($F3),y
L2E50:  adc     L54CC
        adc     ($3D,x)
        .byte   $97
        asl     a
        and     $BC,x
        .byte   $52
        .byte   $E7
        cmp     L5387
        dec     $19,x
L2E60:  .byte   $EF
        .byte   $7C
        adc     $9D,x
        ror     $19,x
        sta     ($76),y
        .byte   $87
        .byte   $C7
        dec     $D875
        .byte   $B3
        sbc     ($F3),y
        eor     L5A57,y
        .byte   $87
        .byte   $C7
        and     $4E
        .byte   $67
        sbc     ($67),y
        dex
        .byte   $EB
        .byte   $57
        dec     $EE
        .byte   $7C
        .byte   $E7
        .byte   $52
        .byte   $1F
        lsr     $D559,x
        sbc     ($D7,x)
        .byte   $53
        cpy     $BD
        .byte   $8F
        .byte   $4B
        brk
L2E8E:  jsr     L3856
        .byte   $51
L2E92:  sty     $20C8
        .byte   $1D
L2E96:  .byte   $7C
        dec     $F8,x
        .byte   $7C
        cld
        adc     $E5,x
        sty     $B7,x
        lda     $A4,x
        .byte   $1C
        .byte   $7C
        inc     $15
        .byte   $D6
L2EA6:  ror     L75D8
        ldy     $9F09
        and     L39B1,x
        .byte   $F3
        dex
        sbc     ($5B,x)
        .byte   $74
        ror     $DC05,x
        txa
        .byte   $F3
        ora     $C87D
        ldx     $FAB7
L2EBF:  sbc     L08E4,y
        adc     $AEE3,y
        dec     $97DA
        .byte   $8E
        .byte   $4C
L2ECA:  .byte   $6F
        cmp     $D2
        ldy     $BAEB,x
        ldx     L57C9
        lsr     $B93C,x
        sta     ($33),y
        .byte   $3C
        sbc     $E2B6,y
        .byte   $97
        stx     $E6BC
L2EE0:  cmp     ($55),y
        .byte   $93
        lda     ($1E),y
        rti

        ror     a
        .byte   $57
        cmp     $E585
        .byte   $B7
        .byte   $3A
        sta     $CD87,y
        sta     ($5F,x)
        bit     $AC
        .byte   $02
        .byte   $7F
        brk
        .byte   $63
L2EF8:  sbc     $2A
        .byte   $DA
        sbc     $64,y
        inc     $04
        .byte   $63
        sbc     $2E
L2F03:  cli
        sbc     $BB48,y
L2F07:  txa
        lda     ($D4,x)
        .byte   $EB
        lda     L4466
        bne     L2ECA
        lda     L73A2,x
        ror     L003E
        eor     L522A,y
L2F18:  eor     ($38,x)
        .byte   $3A
        .byte   $5A
        dec     $62,x
        eor     #$D3
        sbc     $0D
        asl     a
        brk
        clc
        sbc     L654D,y
        ror     a
        adc     ($C9),y
        cpy     L64C5
        .byte   $4F
        .byte   $1F
        and     L2DAA,y
        sbc     ($F3,x)
        adc     ($9F,x)
        .byte   $3C
        .byte   $42
        ror     $B2
        rts

        asl     $7C,x
        .byte   $F3
        .byte   $13
        .byte   $64
        .byte   $80
        ora     $D87C,x
        adc     $F3,x
        .byte   $57
        ldx     L167B
        asl     $F33A
        .byte   $7B
        .byte   $AF
        .byte   $9C
        .byte   $BB
        cpy     L2C01
        .byte   $EB
        tsx
        sbc     ($04,x)
        .byte   $D7
        .byte   $AF
L2F5B:  .byte   $9B
        .byte   $6F
        .byte   $0F
        txs
        cpy     $C771
        tsx
        .byte   $DB
        .byte   $0B
        rol     L36E3
        .byte   $B7
        .byte   $B7
        cmp     L0A48
        .byte   $B3
        eor     $CF18,x
        .byte   $74
        .byte   $54
        ora     ($59,x)
L2F75:  .byte   $BB
        .byte   $D3
        .byte   $6D
        .byte   $67
L2F79:  .byte   $6F
        .byte   $34
        .byte   $F4
        bmi     L2F7F
        .byte   $D7
L2F7F:  cmp     L876F
        cmp     L8787
        sta     $9E,x
        .byte   $17
        .byte   $04
        adc     $F3,x
L2F8B:  .byte   $6D
L2F8C:  .byte   $76
L2F8D:  adc     $E1
        .byte   $F3
        .byte   $5B
        sbc     ($E5,x)
        sta     L7EA6
        .byte   $1F
        rol     $1D,x
        .byte   $7C
        cpx     #$5D
L2F9C:  .byte   $6B
        .byte   $7F
L2F9E:  clc
        and     $B9,x
        sta     $C701,x
        cmp     L1A4E
        .byte   $0C
        .byte   $E7
        .byte   $5F
        ora     ($96,x)
        .byte   $DC
        .byte   $52
        .byte   $F3
        ora     #$F7
        .byte   $C7
        ora     L6DF3,y
L2FB5:  .byte   $C7
        .byte   $C7
        .byte   $5F
        rol     L1652,x
        .byte   $1C
        cmp     L66AB
        .byte   $6B
        cli
        .byte   $71
L2FC2:  .byte   $74
        and     ($9E,x)
        eor     $57,x
        lda     L0B58,y
        .byte   $D7
        dec     $F575
        .byte   $F3
        adc     $9D,x
        .byte   $5D
L2FD2:  adc     $D6,x
        .byte   $F4
        .byte   $DB
        .byte   $57
        .byte   $AE
L2FD8:  ror     $9B19
        .byte   $B3
        .byte   $E7
        and     $F3
        sbc     $27
        .byte   $AF
        .byte   $9B
        ror     a
        .byte   $C3
        stx     L733E
        .byte   $8E
        .byte   $A9
L2FEA:  .byte   $07
        rol     $B772,x
        lda     $AB4C,y
        sbc     L21A6
        .byte   $EB
        .byte   $E7
        bmi     L3070
        sbc     $EDEE,y
        bcc     L2FB5
        sbc     L4EE4,y
L3000:  and     $DCCD,x
        .byte   $12
        ldx     L77EB,y
        rol     $BC6E,x
        rol     $F371,x
        tya
        and     $E6
        eor     $6E,x
        .byte   $6D
        .byte   $9C
L3014:  .byte   $7A
        .byte   $F9
L3016:  cpy     #$8D
        .byte   $7F
        .byte   $02
        cmp     $D5,x
        adc     L554F,y
        adc     $DD
        .byte   $D3
        .byte   $D7
        .byte   $1F
        rol     $57,x
        .byte   $B7
        bne     L3047
        .byte   $1F
        .byte   $36
L302B:  clc
        .byte   $A3
        .byte   $53
        cpy     L5FDB
        .byte   $1F
        adc     ($F3),y
        cpy     L3E5B
        ora     ($67,x)
        .byte   $CF
L303A:  rol     a
        sta     ($1F,x)
        asl     $AA5C,x
        inc     L351F,x
        inc     $D9,x
        sta     ($53),y
L3047:  .byte   $D3
        .byte   $DF
        asl     L5C57,x
        cmp     $93,x
        .byte   $0F
        lsr     $F358,x
        sbc     ($E5,x)
        sty     L7C7C
        beq     L3070
        .byte   $D7
        .byte   $CF
        adc     $48,x
        pla
        ora     ($4F,x)
        .byte   $BB
        bne     L302B
        .byte   $02
        .byte   $9B
        .byte   $AF
        .byte   $9C
        .byte   $89
        ldx     $B0
        sbc     ($C0),y
L306C:  .byte   $D4
        .byte   $03
        .byte   $47
        .byte   $E2
L3070:  jsr     L6564
        jmp     (L46A0)

        adc     #$0F
        ldx     L3DF2
        tay
        .byte   $04
        rti

        cld
        .byte   $C2
        .byte   $1F
        sty     $77
        .byte   $87
        .byte   $E3
        .byte   $9F
        .byte   $A3
        .byte   $2B
        .byte   $73
        .byte   $A7
        bcc     L3014
L308C:  .byte   $1C
        .byte   $C3
        lda     ($85),y
L3090:  dec     L3C80
        tay
        .byte   $1D
L3095:  .byte   $03
        cmp     L3EBC,x
        tya
        eor     $C33B,y
        adc     L3CBC,x
        .byte   $3B
        sta     $997C,y
        .byte   $7C
        cld
        .byte   $7C
        tya
        .byte   $7B
        dey
        nop
        .byte   $0F
        .byte   $AE
L30AD:  cmp     ($16,x)
        .byte   $07
        and     $CD73,x
        .byte   $03
        bvs     L3133
        adc     $BA88,y
        lda     L378C,y
        lda     L4504,y
        .byte   $5C
        cmp     $D3D8,y
        .byte   $DC
        sbc     #$EA
        .byte   $17
        cpx     L2D9D
        sbc     $CD,x
        .byte   $3C
        stx     $A13E
        .byte   $5A
        .byte   $CB
        iny
        sbc     #$CA
        .byte   $45
L30D6:  .byte   $FF
        .byte   $13
        .byte   $7F
        .byte   $73
        sei
        .byte   $63
        .byte   $7A
        and     ($F4),y
L30DF:  ldy     L00F9,x
L30E1:  and     ($F4),y
        bmi     L30DF
        lda     LBA72,y
        .byte   $F7
        bmi     L30E1
        tsx
        .byte   $74
        lda     ($86),y
        .byte   $F7
        .byte   $2B
        .byte   $0F
        .byte   $53
        .byte   $97
        pha
        .byte   $44
        lda     $B47A,y
L30F9:  bvs     L30AD
        .byte   $F3
        lda     L8AFA,y
        .byte   $63
        lda     $D4C3,y
L3103:  lsr     $28,x
        .byte   $BB
        .byte   $4B
L3107:  ldx     #$17
        sta     $87
L310B:  sta     L8DA7,x
        .byte   $97
        cmp     ($BF,x)
        lda     ($97),y
        sbc     #$8E
        .byte   $39
L3116:  .byte   $3B
        .byte   $1C
        .byte   $3A
        eor     $9D7D,y
        .byte   $3B
        cmp     $63,x
        .byte   $22
        .byte   $3B
        bit     $74
        .byte   $DB
        cpy     $CB
        cpy     $9B
        nop
        .byte   $D2
        .byte   $1C
        cmp     ($E9,x)
        .byte   $5C
        cpx     $07
L3130:  lda     $F48F,x
L3133:  .byte   $42
        and     ($A2,x)
        adc     ($E6,x)
L3138:  adc     ($F6,x)
        .byte   $67
        sbc     #$05
        .byte   $67
        brk
        bcc     L3130
        adc     #$F3
        .byte   $72
        .byte   $F2
        adc     L6DF5
        beq     L31BC
L314A:  .byte   $97
L314B:  .byte   $43
        cpx     L7715
        .byte   $FB
        .byte   $3C
        .byte   $17
        sbc     L4390,y
        .byte   $44
        ldx     $54
        lda     L7B51,y
        txs
        ror     $BB98,x
        php
        .byte   $3B
        eor     $C879,x
        sec
        cmp     $3A,x
        eor     ($7C),y
L3169:  cmp     $9A7A,y
        adc     $E11C,x
        .byte   $53
        sta     $D197,y
        .byte   $53
        .byte   $D5
L3175:  .byte   $87
        sbc     #$93
        nop
        lsr     L1B32
        sbc     ($93),y
        .byte   $5B
        sbc     ($29),y
        .byte   $FB
        .byte   $23
        and     L3D37,x
        .byte   $A3
        sbc     $EB
        sbc     $7D
        ora     $D115,x
        .byte   $BF
        .byte   $2F
        and     $BE0D,x
        .byte   $B7
        .byte   $9E
        .byte   $5A
        .byte   $37
        ror     L4D7A,x
L319A:  rol     L5834,x
        sbc     $F2,x
        .byte   $63
        .byte   $62
        ror     a
        and     ($36),y
        inc     $A7
        .byte   $13
        nop
L31A8:  .byte   $7A
        rol     $59,x
        .byte   $3C
        .byte   $E3
        .byte   $D3
        nop
        .byte   $7B
        .byte   $7E
L31B1:  lsr     $2A,x
        adc     (L003E,x)
        .byte   $77
        cpx     $D3
        .byte   $DE
        .byte   $79
L31BA:  .byte   $2F
        .byte   $E4
L31BC:  .byte   $62
        .byte   $E2
        .byte   $A3
        .byte   $5A
        .byte   $BF
        .byte   $63
        lsr     L2A3E,x
        ror     a
        adc     L378D
        .byte   $93
        cmp     $2C,x
        .byte   $13
        .byte   $22
L31CE:  rol     $4E,x
        eor     ($8E,x)
        .byte   $1A
        lda     $D664,y
L31D6:  .byte   $74
        cpx     $8B
        .byte   $72
        sbc     $74,x
        .byte   $87
        .byte   $B3
        .byte   $93
        txs
        .byte   $89
        .byte   $9E
        sty     L3E6B
        .byte   $32
        and     L3D39
        .byte   $7B
        ror     $E793
        tax
        and     ($86),y
        eor     #$84
        lda     #$90
L31F4:  cpy     #$4F
        .byte   $1A
        stx     $39,y
        ora     $E4A3,x
        .byte   $22
        cld
        sty     $48
        inx
        .byte   $54
        .byte   $E9
L3203:  ldx     $479B,y
        cli
        cmp     $CC
L3209:  .byte   $7A
L320A:  .byte   $A7
        asl     a
        rts

        .byte   $B1
L320E:  .byte   $77
        .byte   $EB
        .byte   $6E
        .byte   $C6
L3212:  cpy     $2DBA
        .byte   $CB
        lda     ($7C),y
        sbc     ($A6,x)
        sty     $BE,x
        lda     ($9E),y
        lda     $B573
        .byte   $1F
        rol     $C7
        .byte   $EB
        cmp     $F334
        and     #$20
        .byte   $DB
        .byte   $A3
        sbc     $C503,x
        .byte   $C7
        jmp     L5193

        pla
        .byte   $BB
L3235:  .byte   $D0
L3236:  .byte   $D7
        .byte   $5B
        asl     $CE5D,x
        .byte   $27
        .byte   $34
        sty     L8983
        dec     $99
L3242:  cpy     L329E
        .byte   $1B
        dec     $921B
        rol     L8ED7
        .byte   $54
        pha
        cmp     ($24,x)
        .byte   $C2
        .byte   $3B
        .byte   $0B
        .byte   $AC
        .byte   $5D
L3255:  dec     $31
        sta     ($5E),y
        .byte   $80
        .byte   $D2
        .byte   $0B
        tya
L325D:  .byte   $DF
        inc     $968C
L3261:  .byte   $6B
        lsr     $4D,x
        cld
        ora     L0DCB,x
        .byte   $C3
        rol     $75,x
        .byte   $E2
        .byte   $07
        ror     a
        .byte   $5A
        lda     ($1A),y
        eor     ($0B),y
        .byte   $5D
        .byte   $2E
L3275:  txs
        rol     $D6
        sbc     $F2,x
        cmp     ($43,x)
        .byte   $47
L327D:  .byte   $22
        adc     L09C9,y
        .byte   $89
        adc     #$B7
        .byte   $2D
L3285:  .byte   $DA
        ldy     $80,x
        .byte   $97
L3289:  .byte   $7A
        .byte   $B2
        cmp     $913B,x
        .byte   $72
        .byte   $5A
        rol     $D379
        adc     $C4AC
        adc     #$95
        ror     $F1,x
        jmp     (L9A8D)

        .byte   $76
L329E:  eor     $8F,x
        bcc     L32E9
        .byte   $D4
        lsr     $A0,x
        .byte   $7A
        .byte   $44
        .byte   $F7
        .byte   $0C
        pha
        .byte   $D4
        .byte   $DC
        .byte   $7B
        ldy     $9D,x
        lda     $A393,y
        eor     L888C
        .byte   $D4
        .byte   $F3
        txs
        .byte   $77
        ora     ($24),y
        cld
        .byte   $9E
        .byte   $92
L32BE:  .byte   $9E
        .byte   $42
        .byte   $A7
        brk
        eor     $E619,y
        sty     $6F
        .byte   $D3
        adc     $97,x
        adc     $88,x
        sty     $E8
        rti

        inc     $21,x
        .byte   $5C
        .byte   $3B
        cli
        .byte   $5A
        nop
        .byte   $4F
        lda     L3714,y
        .byte   $F2
        .byte   $4F
        .byte   $44
        .byte   $D2
        sei
        ldy     $C152,x
        ora     $D9
L32E4:  adc     $9D
        bit     $5C
        .byte   $AB
L32E9:  .byte   $1A
        .byte   $83
        .byte   $6B
        adc     #$F1
        cmp     $17
        and     $C776
        inc     $DC,x
        .byte   $A7
        eor     ($E9),y
        .byte   $C2
        cmp     $BAD5,y
        ldy     $BBF5,x
        .byte   $4F
        sbc     #$68
        cmp     #$C9
        .byte   $07
        ora     ($AA),y
        rol     $69,x
        lda     $65,x
        .byte   $87
        .byte   $CD
        .byte   $FA
L330E:  sed
        .byte   $A9
L3310:  rol     $1A,x
        .byte   $E2
        ldy     $5B
        .byte   $0B
        .byte   $A7
        ora     ($29),y
        cmp     L6341
        stx     $69
        .byte   $22
        .byte   $E3
        cli
        cmp     #$73
        cmp     $AB95,x
        ora     L4416,y
        .byte   $74
        ldx     $D0,y
        eor     L3939
        ror     $AB
        .byte   $DD
        .byte   $2C
L3333:  .byte   $DA
        .byte   $22
        .byte   $73
        .byte   $74
        .byte   $64
        .byte   $A7
        .byte   $63
        cli
        .byte   $DA
        eor     L741E
L333F:  eor     $79,x
        .byte   $3B
        .byte   $D3
        .byte   $1A
        .byte   $4F
        ror     L5A66,x
        .byte   $72
        eor     L5790,x
L334C:  .byte   $17
        dec     $BD,x
        dex
        and     $B8
        inx
        .byte   $9C
        stx     $4B,y
        ora     #$E5
        cpy     $BF26
        .byte   $6D
L335C:  .byte   $E3
        .byte   $5E
L335E:  .byte   $BB
        .byte   $E9
L3360:  ror     a
        sbc     ($5F,x)
        sta     ($BF,x)
        .byte   $AF
        adc     L77A1,y
        ldy     L2A8A
        sta     ($CC,x)
        eor     ($D7,x)
        eor     ($D8,x)
L3372:  eor     ($DF,x)
        .byte   $41
L3375:  .byte   $E2
        eor     ($E3,x)
        eor     ($0D,x)
        .byte   $42
        clc
        .byte   $42
L337D:  .byte   $2C
        .byte   $42
L337F:  .byte   $34
        .byte   $42
        .byte   $45
L3382:  .byte   $42
        .byte   $54
        .byte   $42
        .byte   $63
L3386:  .byte   $42
        .byte   $7A
        .byte   $42
L3389:  bcc     L33A5
L338B:  .byte   $14
        .byte   $52
        .byte   $14
L338E:  .byte   $5A
        .byte   $14
        .byte   $B2
L3391:  .byte   $14
        .byte   $F2
L3393:  ora     $02,x
        ora     $1A,x
        .byte   $15
L3398:  .byte   $22
        .byte   $15
L339A:  rol     a
        ora     $DA,x
        asl     $C2,x
        .byte   $17
        .byte   $32
L33A1:  .byte   $17
        .byte   $E2
        bpl     L335C
L33A5:  bcc     L3375
        bvc     L337D
        bpl     L337F
        bcc     L3382
        bpl     L3386
        bcc     L3389
        bcc     L338B
        bne     L338E
        .byte   $10
L33B6:  .byte   $DC
        bne     L339A
        bvc     L33A1
        .byte   $10
L33BC:  sbc     #$D0
        .byte   $EF
        bcc     L33B6
        tax
        stx     $1A
        dey
        rti

        dey
        lsr     $88,x
        .byte   $74
        dey
        .byte   $7A
        dey
        .byte   $82
        .byte   $89
        .byte   $9F
        nop
        pha
L33D2:  sta     L8D48
        tay
        bcc     L3360
        sta     ($68),y
        sta     ($A8),y
        sta     ($E8),y
        txs
        .byte   $82
        .byte   $44
L33E1:  .byte   $DC
        .byte   $44
        nop
        .byte   $44
        .byte   $FB
        .byte   $44
        .byte   $0F
        eor     $24
        eor     $F2
        sta     ($D0),y
        and     $10
        .byte   $D4
        ora     #$72
        dec     $40
        .byte   $64
        .byte   $27
        cmp     $C5
L33F9:  ora     ($80,x)
        adc     L7346,x
        .byte   $92
        .byte   $42
        .byte   $02
        .byte   $D4
        .byte   $89
        dey
L3404:  .byte   $DC
        .byte   $62
        adc     $49
        brk
        cpy     $B0
        .byte   $1B
        tya
        .byte   $A9
L340E:  inc     $22
        ora     #$2A
        .byte   $6E
L3413:  tya
        .byte   $7A
        sta     ($A8,x)
        .byte   $6F
        ora     L40CE
        .byte   $3A
        rol     $A2C3
        ror     $2A
        pla
        .byte   $B7
        asl     $4E,x
        rol     a
L3426:  .byte   $14
        bcc     L33E1
L3429:  sec
        dey
        cmp     L120C,x
        lsr     $D0,x
        bcs     L3455
        stx     $CC
        .byte   $97
        .byte   $7C
        sta     ($CE),y
        bvs     L33D2
        .byte   $53
        asl     a
        rti

        lda     #$26
        ror     a
        .byte   $89
        .byte   $8E
L3442:  .byte   $52
        rol     $49,x
        .byte   $32
        ldx     $3A
L3448:  eor     #$5E
L344A:  .byte   $02
        ldx     $26,y
        rol     a
        jmp     L2698

        ora     L1B62
        .byte   $89
L3455:  .byte   $9B
        bvc     L34CC
        .byte   $9B
        asl     $ED
        .byte   $32
        .byte   $B5
L345D:  eor     ($96,x)
        pla
        .byte   $8B
        sta     $D732,x
        eor     L69B9,y
        cmp     #$AC
L3469:  eor     $D0FD,x
        cmp     L238C,x
        .byte   $CE
L3470:  .byte   $32
        cli
        and     ($8C,x)
        eor     ($C9,x)
        jsr     L98F4
        txa
        sty     L2631
        iny
        .byte   $BB
        asl     a
        sed
        bcc     L3470
        .byte   $07
        .byte   $4B
        sbc     #$32
        .byte   $50
L3488:  ldy     #$BA
L348A:  sta     $9EE8
        cmp     $DE0A,x
        .byte   $EB
        .byte   $20
L3492:  cmp     $9990,x
        rol     a
        ldy     $B0A7
L3499:  .byte   $F6
L349A:  .byte   $03
        ora     $E9B9,y
        .byte   $22
        tax
        .byte   $B7
        .byte   $82
L34A2:  .byte   $D0
L34A3:  lda     $302A,y
        .byte   $1A
        ora     #$0D
        .byte   $D3
        and     $98
        bcc     L3492
        .byte   $8F
        stx     $0D,y
        tay
        .byte   $C2
        .byte   $CF
        .byte   $0B
        jsr     L077B
        sbc     #$E3
        .byte   $04
        sbc     #$28
L34BD:  tay
        .byte   $62
        .byte   $52
        .byte   $80
L34C1:  .byte   $0F
        tya
        .byte   $23
        sty     $A3,x
        .byte   $B3
        clc
        and     $8C,x
        .byte   $20
        .byte   $44
L34CC:  rol     a
        cmp     $A6AF
        sta     ($FE,x)
        ldy     $E730
        pha
        sbc     $0E,x
        ror     L6392,x
        sec
        .byte   $CC
L34DD:  .byte   $C7
        sta     $B20C,x
        lsr     a
        sta     $0259,y
        asl     a
        .byte   $8B
        .byte   $37
        eor     ($8C,x)
L34EA:  .byte   $93
        .byte   $E2
        bmi     L34A3
        bpl     L3488
        .byte   $B7
        bit     $AB8F
        .byte   $25
L34F5:  ldy     $96,x
        sta     $9D0B,x
        .byte   $FA
        cmp     L62A9,y
        .byte   $34
        pha
        .byte   $DA
        tsx
L3502:  tya
        stx     $8F,y
        .byte   $8B
        and     #$C6
        .byte   $BC
        .byte   $E5
L350A:  sta     $62
        sbc     ($AF,x)
        ror     L2872,x
        .byte   $82
        .byte   $B9
        .byte   $02
L3514:  sbc     ($CC,x)
        .byte   $3B
        cmp     #$89
        .byte   $43
        .byte   $33
        .byte   $DA
        .byte   $42
        ror     L0056,x
L351F:  pla
        .byte   $34
        lsr     a
        adc     ($33),y
L3524:  .byte   $14
        stx     $E738
        .byte   $8F
        bit     $8F
        .byte   $9E
        .byte   $93
        sec
        rol     L3000
        bcc     L358B
        bcc     L34DD
        jsr     L238A
        and     $18
        bcc     L3567
        ror     $80
        sbc     #$23
L3540:  .byte   $0B
        .byte   $26
L3542:  .byte   $03
        .byte   $D4
        asl     a
        and     L8D4B,y
        rti

        .byte   $D4
        .byte   $97
        stx     $8C,y
        jsr     L8DE0
        adc     L1BA2,y
        ora     #$10
        ldy     $CC,x
        asl     a
        .byte   $43
        bvs     L3514
        tax
        .byte   $32
        .byte   $3E
        .byte   $CD
L355F:  .byte   $23
        .byte   $D4
        .byte   $07
        .byte   $64
        pha
        .byte   $73
        .byte   $23
        lsr     a
L3567:  .byte   $7A
        rol     L3730
        lda     ($83,x)
        .byte   $83
        tya
        cmp     L35BF
        .byte   $83
        .byte   $02
        tay
        ora     ($20,x)
        .byte   $87
        .byte   $52
        .byte   $C5
L357A:  plp
        tay
        .byte   $D2
        .byte   $3F
        .byte   $67
        .byte   $8B
        asl     $EA77
        ldy     $4E
        asl     $0393
L3588:  bcc     L3514
        .byte   $8D
L358B:  .byte   $89
        .byte   $9E
        and     L8D70
        stx     $26,y
        .byte   $92
        ora     #$72
L3595:  tax
        .byte   $42
        php
        dec     $62
        .byte   $8B
        sta     $05B0,y
        rol     $CE7D
        eor     ($AC),y
        bit     $C9
        php
        dey
        bcs     L35D7
        sta     $4C
L35AB:  pha
        .byte   $C3
        .byte   $04
        sbc     #$D0
        ldy     $89
        and     ($4A,x)
        .byte   $1C
        .byte   $2F
        .byte   $02
        ldx     $54
        bit     L2E0B
        ldy     L664D
L35BF:  lsr     $78
        txs
        .byte   $42
        cmp     ($37),y
        clv
        .byte   $13
        eor     $22
        sec
        .byte   $82
        .byte   $5A
        cli
        cpy     #$B8
        .byte   $BB
L35D0:  lsr     $B00E,x
        sta     L3090,x
        .byte   $CE
L35D7:  .byte   $07
        tay
        iny
        lda     #$30
        nop
        .byte   $20
L35DE:  .byte   $C4
L35DF:  sta     $28,x
        bit     $48
        lda     ($0E),y
        bvc     L358B
        .byte   $07
        .byte   $22
        .byte   $AB
        .byte   $F7
        dec     $0343
L35EE:  .byte   $64
        ldx     #$37
        .byte   $0B
        ora     #$83
        cpy     $36
        and     $B9
        cpx     $49
        .byte   $8B
        lda     $99F8
        adc     #$09
L3600:  rol     $ADA0,x
        bcc     L362E
        clc
L3606:  ror     $F361
L3609:  ldx     L386E
        .byte   $13
        and     $33,x
        rts

L3610:  ror     $4D,x
        jmp     LDC86

        ror     $B0
        eor     $995C,y
        dec     $4C
        .byte   $34
        .byte   $54
        .byte   $C0
L361F:  .byte   $47
        bcc     L364A
        ora     $C533,y
        bit     $16
        .byte   $82
        .byte   $13
        and     $01,x
        cpx     $1F
        .byte   $DC
L362E:  .byte   $E5
L362F:  cpx     #$F8
        ror     a
        lda     $07,x
L3634:  eor     #$35
        lsr     $53,x
        .byte   $69
L3639:  ora     $6673,y
        bmi     $3628
        .byte   $1B
        .byte   $3C
        lda     ($62,x)
        .byte   $47
        eor     ($61,x)
        lda     ($23,x)
        sei
        .byte   $3C
        .byte   $10
L364A:  ror     $E018
        .byte   $24
L364E:  .byte   $53
        jmp     LAAB1

        lsr     $1E,x
        adc     $C5
        .byte   $D9
        .byte   $1B
L3658:  rts

L3659:  .byte   $9E
        .byte   $5A
        .byte   $CC
L365C:  .byte   $63
        sta     ($54,x)
        sta     $A527,y
L3662:  .byte   $54
        .byte   $89
        .byte   $8B
        ldx     L4259
        .byte   $5C
        .byte   $17
        .byte   $03
        sta     ($74,x)
        ror     $49
        bmi     L36D4
        .byte   $3E
L3672:  .byte   $F3
        lda     ($69,x)
        .byte   $3C
        .byte   $5B
        dex
        eor     #$66
        bpl     L3600
        ldy     $E0C4
        sty     L0056
        ora     ($0D,x)
        .byte   $80
        .byte   $63
        .byte   $3C
        ror     $CD
        .byte   $CB
        eor     #$12
        .byte   $FF
        clc
        cpy     #$CE
        .byte   $89
        sta     $93CA
        lsr     $A6,x
        .byte   $77
        rol     a
        ora     ($84),y
        ldy     L1465,x
        .byte   $4F
        .byte   $19
        .byte   $90
L369F:  .byte   $B3
        and     ($CF,x)
        and     $34
        .byte   $5C
        lsr     $92
        .byte   $4F
        .byte   $12
        dey
        .byte   $97
        lsr     a
        .byte   $DB
        inc     L44B6,x
L36B0:  txs
L36B1:  bcs     L3659
        .byte   $DB
        ora     $97
        sbc     $88
        brk
        lda     L0A22
L36BC:  sta     ($85),y
        ldy     $BAA0
        .byte   $1B
        .byte   $53
        ldy     $96
        ldy     $84
        .byte   $D3
        sta     $49
L36CA:  .byte   $CB
        iny
        lsr     a
        bcc     L36B0
        eor     L5A14,y
        eor     ($D0),y
L36D4:  pha
        sbc     L5314
        sta     ($63),y
        and     #$48
        ldx     $A1
        eor     ($31,x)
        .byte   $3C
        .byte   $0D
        .byte   $F2
L36E3:  lsr     $05
        adc     ($98,x)
        .byte   $0B
        rti

        ldy     $A512
        ldx     L3606
        sei
        jmp     LC81E

        ora     ($DF),y
        .byte   $19
L36F6:  .byte   $34
L36F7:  rol     $0A,x
        rts

        sty     L8734
        sty     L0E2E
        cmp     #$33
        .byte   $83
        .byte   $80
        and     $A6,x
        .byte   $CC
L3707:  .byte   $67
        bit     $7BC6
        txa
        ora     L6133,y
        .byte   $E2
        dex
        ror     L2B9D
L3714:  cld
L3715:  ldy     $16,x
        .byte   $62
        rol     a
        sei
        .byte   $92
        .byte   $1E
L371C:  .byte   $44
        .byte   $AB
        .byte   $C3
        bvc     L3715
        .byte   $B3
        .byte   $3A
        .byte   $34
        dey
L3725:  beq     L371C
        .byte   $37
        ora     $82
        rol     L2A32,x
        bvs     L3738
        .byte   $0B
L3730:  lsr     $CB,x
        ror     $DC01,x
        bcc     L36F7
        .byte   $9B
L3738:  sty     $0F
        cmp     L8819,y
        .byte   $D2
        .byte   $E7
        bvs     L36CA
        ora     #$B2
        asl     $4B,x
        dex
        cld
        .byte   $73
        .byte   $04
        adc     #$93
        .byte   $12
        eor     ($86),y
        eor     $E346
        dec     $FC
        jmp     (LC154)

        .byte   $72
        and     #$58
        .byte   $5C
        .byte   $5C
        cmp     $17
        .byte   $5A
        .byte   $04
        ora     $16,x
        .byte   $7C
        .byte   $97
        dey
        eor     ($21),y
        adc     $D1
        .byte   $C2
        .byte   $F7
        .byte   $1B
        .byte   $D7
        eor     ($C9),y
        .byte   $87
        ldx     $59
        .byte   $D2
        .byte   $5C
        lda     $84
        cmp     L8106,y
        adc     L5838
        asl     a
        rti

        cmp     ($29),y
        .byte   $DC
        cpy     $F1
        sei
        eor     ($12),y
        .byte   $C6
L3786:  .byte   $13
        eor     ($C0,x)
        sbc     ($A6,x)
L378B:  .byte   $46
L378C:  .byte   $70
L378D:  rol     $47
        .byte   $97
        .byte   $34
        cmp     $06
        sta     L69CE,y
        .byte   $73
        cmp     $3A
        lsr     $E62D,x
        .byte   $0E
        .byte   $06
L379E:  sbc     $0614,y
        clc
        .byte   $5B
        .byte   $92
        sbc     $9973,x
        sbc     ($91,x)
        .byte   $17
        bne     L380A
        .byte   $32
        brk
        pha
        .byte   $4B
        .byte   $CF
        bmi     L3816
        .byte   $5F
        rti

        cpy     $F955
        sty     L17A1
        adc     ($65,x)
        .byte   $C2
        lda     ($45,x)
        sbc     $73,x
        cmp     ($8A,x)
        eor     #$BD
L37C6:  clc
        eor     #$FA
        .byte   $47
        .byte   $5C
L37CB:  cpx     L24B1
        adc     $B08A,y
        eor     $E0
L37D3:  asl     $C2
        tya
        .byte   $DF
        beq     L3820
L37D9:  dec     $97
        bcc     L37C6
        sei
        sty     $97,x
        rol     $25,x
L37E2:  dec     $74,x
        dey
        .byte   $6B
        .byte   $17
        .byte   $33
        cpx     $05
        .byte   $92
        jmp     (L3016)

L37EE:  .byte   $03
        bmi     L382A
        .byte   $97
        ora     ($73),y
        ora     ($24,x)
        .byte   $5B
        rol     $08
        and     ($A5,x)
        .byte   $34
        cli
        php
        .byte   $37
        .byte   $80
        tsx
        .byte   $89
        rol     a
        clv
        and     $83,x
        ldy     #$AC
        .byte   $C3
        .byte   $A3
L380A:  .byte   $02
        bit     $BC
        .byte   $25
L380E:  dex
        and     ($09),y
        ldx     #$1F
        .byte   $C3
        .byte   $80
        .byte   $AD
L3816:  .byte   $C2
        ror     $DC
        .byte   $32
        .byte   $E7
        txa
        rol     $AD32
        .byte   $01
L3820:  dey
        bne     L37E2
        sbc     $0A,x
        .byte   $62
        .byte   $5A
        .byte   $F2
        sbc     $AF
L382A:  tsx
        .byte   $FA
        .byte   $1B
        tya
        .byte   $BB
        .byte   $E3
        .byte   $1C
        cmp     $AC
        .byte   $F4
        inx
        inc     $37
        .byte   $B7
        .byte   $77
        cpx     $9FCD
        .byte   $37
        iny
        .byte   $F7
        ora     #$03
        .byte   $1B
        .byte   $9C
        and     L2FD2
L3846:  .byte   $17
        .byte   $B3
        .byte   $19
        .byte   $8E
L384A:  rol     $E333
        .byte   $C2
        bcs     L37D9
        .byte   $C2
        rti

        eor     ($CC,x)
        .byte   $16
L3855:  .byte   $7D
L3856:  .byte   $17
        asl     $BCC4
        .byte   $B2
        .byte   $05
L385C:  lda     ($65,x)
        .byte   $64
        .byte   $93
        .byte   $1F
L3861:  .byte   $52
L3862:  dec     $6E
        lda     #$79
        inc     $7A,x
        sbc     $CD5D,y
        .byte   $17
        .byte   $6E
        .byte   $A6
L386E:  bmi     L3846
        asl     $24,x
        .byte   $67
        cpy     L6E10
        .byte   $0F
        sta     $B8
        lsr     $B0
        dec     $D10D,x
        .byte   $47
        asl     a
        .byte   $C7
        .byte   $3C
        eor     ($09,x)
        and     ($AC),y
        .byte   $5C
        .byte   $F7
        ora     $C16C,x
        rts

        cmp     ($15,x)
        .byte   $93
        sty     $8B
        ora     ($AF,x)
        clc
        eor     $98E0,x
        .byte   $5F
L3898:  dec     $13
        sta     $B0
        .byte   $0F
        sty     $ED,x
        adc     $14
        .byte   $52
        and     $A55D,y
        bcs     L390C
        cmp     $59,x
L38A9:  clv
        cld
        ror     $90E4
        .byte   $33
        .byte   $3C
        .byte   $53
L38B1:  cmp     ($5B),y
        ora     $3A
        .byte   $82
        .byte   $7C
        ldy     L6984
        sei
        adc     $D6
        pha
        asl     $4F,x
L38C0:  sta     $89
        stx     $F8,y
        inc     L090B
        .byte   $89
        tay
        .byte   $C3
        .byte   $13
        ldy     a:$E1
        cpy     L4347
        rol     $38,x
        bmi     L3862
        sta     $9F8D,y
        .byte   $4B
        stx     $72,y
        .byte   $83
        php
        .byte   $3B
        bit     L2E60
        .byte   $34
        ldy     $02
L38E4:  sty     $CC
        stx     $25
        cmp     ($24),y
        .byte   $0B
        sta     $A52C
        rol     $6A
        .byte   $C2
        .byte   $7A
        .byte   $34
        sty     $28
        sta     $9C00,y
        bit     $9E2F
        .byte   $35
L38FC:  lda     ($B0,x)
        adc     $A032,y
        ora     ($52,x)
L3903:  sbc     #$8C
        cpy     L0CC2
        .byte   $33
        bvc     L390B
L390B:  cld
L390C:  sed
        lda     $B401,x
        cmp     L7716
        pha
        .byte   $E2
        .byte   $F2
        .byte   $B7
        and     ($D2),y
        ldy     $BDBB
        .byte   $32
        .byte   $C2
        rol     $34
        lsr     a
        .byte   $23
        rol     $DA
        sta     ($3A,x)
        bmi     L38E4
        .byte   $5C
        .byte   $AB
        .byte   $CB
        and     $91CD
        .byte   $A3
        dex
L3930:  .byte   $F3
        jsr     LB03E
        .byte   $9B
        adc     L2D86,x
        rti

L3939:  asl     $03
L393B:  .byte   $17
        cpy     $C7
        .byte   $1F
        .byte   $E9
L3940:  .byte   $32
        dec     $00,x
        .byte   $97
        rol     $B6,x
        .byte   $02
        brk
        rts

        .byte   $92
        .byte   $32
        lsr     L878A,x
        stx     $93,y
        stx     $2C,y
        .byte   $E9
L3953:  ora     #$02
        nop
        cpx     $CE
        .byte   $FC
        .byte   $27
        sta     $AA61
        sei
        .byte   $C6
L395F:  .byte   $CB
        inc     $49
        lda     $82
        dec     $E2,x
L3966:  dec     $E1A0
        bit     L2FEA
        .byte   $2F
L396D:  .byte   $23
        ora     $E4,x
        dec     $7C,x
        cmp     L4063
L3975:  lda     $99A7,y
L3978:  php
        .byte   $82
        ror     a
        cld
        and     ($89,x)
        eor     L9849
        .byte   $E3
        .byte   $1C
        .byte   $67
        .byte   $03
        .byte   $37
        tay
        .byte   $9B
        cpx     $D12C
        and     ($AA),y
        .byte   $20
L398E:  nop
        asl     a
        beq     L398E
        .byte   $2F
        .byte   $5F
        .byte   $F2
        .byte   $AB
        .byte   $22
        cmp     $C9F1
        rol     L67BD
        ldy     $CC
        beq     L39B0
        and     #$2E
L39A3:  .byte   $5C
        .byte   $91
L39A5:  plp
        rol     a
        lsr     $C758
        .byte   $B3
        sec
        tya
        sty     L89DB
L39B0:  .byte   $E0
L39B1:  tax
        asl     L2113
        .byte   $C2
        lda     ($4B,x)
        .byte   $14
L39B9:  .byte   $81
L39BA:  bmi     $3982
        .byte   $9E
L39BD:  .byte   $CC
L39BE:  .byte   $F3
        eor     L7420
        tsx
        .byte   $5F
        .byte   $AB
        .byte   $24
L39C6:  stx     $D420
        sty     $58,x
L39CB:  .byte   $3A
        .byte   $CB
        .byte   $9E
L39CE:  .byte   $E2
        lda     L628C,y
L39D2:  ldx     #$30
        bcc     L39BA
        .byte   $3C
        jmp     L8333

        dec     L7A66,x
        plp
        dec     $4E,x
        .byte   $0B
        stx     L0F72
L39E4:  lda     $C9
        ldx     #$92
        .byte   $E7
        sei
        clv
        .byte   $F7
        .byte   $33
        .byte   $6B
        ror     $41
        plp
        stx     $C2,y
        .byte   $FA
        bvs     L39B9
        .byte   $3C
        .byte   $12
        asl     a
        sbc     L4B32
        dec     $9229,x
        .byte   $64
        .byte   $3C
        adc     $A1
        pha
        lsr     $A80D,x
        clv
L3A08:  .byte   $D3
        .byte   $1A
L3A0A:  cpy     $929A
        .byte   $8F
        plp
        .byte   $FC
        .byte   $C7
        eor     #$BE
        tay
        lda     L4C62,y
        .byte   $72
        lda     #$8B
        dec     $E2EC
        .byte   $37
        .byte   $37
        ora     ($2F,x)
L3A21:  .byte   $62
L3A22:  eor     #$C6
        .byte   $0C
        tsx
        .byte   $8F
        .byte   $26
L3A28:  .byte   $C2
        cpx     $03
        .byte   $34
        ldy     $A8
        bvc     L3A28
        .byte   $9E
        .byte   $89
        inx
        .byte   $22
        inc     $6E
        asl     $2F,x
        tay
        .byte   $BB
        sbc     $C12E,y
        and     ($4B,x)
        .byte   $07
        stx     $A15A
        php
        .byte   $E3
        .byte   $1C
        .byte   $AF
        rol     $CC
        eor     $79
        .byte   $62
        rol     a
        cpx     $49
        lda     L3953,x
L3A52:  cpy     #$06
        .byte   $F2
        cmp     ($C8,x)
        .byte   $52
        bit     $29
L3A5A:  .byte   $63
        and     $BA
        eor     ($E2,x)
        .byte   $7A
        jmp     (LF0A9)

L3A63:  .byte   $B3
        asl     $C9
        rol     L52A9,x
        ldy     $A7CA,x
L3A6C:  and     ($C6),y
        dey
        ldy     $88,x
        bcc     L3AE2
        ldy     $3C
        ora     ($34,x)
        .byte   $93
        .byte   $9C
        dec     $1A
        .byte   $0C
        .byte   $74
        .byte   $F2
        .byte   $1B
        .byte   $1B
        ldx     $71
        .byte   $DC
        .byte   $63
        ldx     $39
        .byte   $0F
        .byte   $D3
        sta     $D4
        sta     ($AC),y
        .byte   $2B
        ora     $B1D4,y
        adc     $E0
        .byte   $7B
        .byte   $17
        .byte   $7F
        eor     $83
        .byte   $12
        .byte   $72
        eor     $64
        .byte   $13
        and     L2104,x
        .byte   $06
L3AA0:  .byte   $80
        .byte   $62
        lsr     L5294
        cli
        bne     L3ABA
        .byte   $D3
        cpy     $9A
        sty     $65
        .byte   $43
        .byte   $13
        and     $44
        dec     $04F8
        .byte   $44
        bcc     L3A52
        asl     a
        .byte   $62
        .byte   $E1
L3ABA:  .byte   $92
        .byte   $34
L3ABC:  ora     $79
        bmi     L3ABC
        ora     L10F3,y
        .byte   $B3
L3AC4:  adc     $6E
L3AC6:  .byte   $07
        .byte   $A4
L3AC8:  bcc     $3B48
        bvs     L3A52
        sbc     ($68,x)
        and     $DC69,y
        eor     ($31),y
        rol     a
L3AD4:  .byte   $57
        cmp     ($AB,x)
        .byte   $72
        .byte   $43
        .byte   $64
        and     ($42),y
        and     $E7
        brk
        .byte   $43
L3AE0:  .byte   $D9
        dey
L3AE2:  and     #$33
        .byte   $D3
        asl     $46,x
        sta     ($30,x)
        .byte   $17
        asl     a
        lsr     a
        jmp     L3610

        cpx     $C4
        ora     ($C3,x)
        asl     $DE,x
        lda     $B3,x
        eor     ($FD),y
        ora     ($A0,x)
        .byte   $5E
L3AFC:  .byte   $33
        .byte   $92
        cmp     $64
        .byte   $07
        eor     L2C72,y
        .byte   $42
        cmp     L2CDC,x
        lda     ($02),y
        ora     ($F6,x)
        .byte   $1F
        lda     ($AD,x)
        .byte   $34
        .byte   $54
        cmp     ($26,x)
        iny
        ora     $96C2,y
        .byte   $14
L3B18:  .byte   $42
        cmp     $9872
        .byte   $EB
        .byte   $6C
        .byte   $5A
L3B1F:  sbc     ($0A,x)
        .byte   $67
        .byte   $42
        bit     $98
        .byte   $9B
        ora     $E3
        .byte   $9E
        .byte   $0F
        .byte   $F2
        .byte   $F3
L3B2C:  lsr     $0F
        lda     $B5
        adc     $C9
L3B32:  cmp     ($BE),y
        and     ($C1,x)
        cpx     #$63
        sei
        sta     $EF
        adc     ($19),y
        sec
        .byte   $67
        .byte   $9C
        eor     #$92
        bvs     L3B8F
        .byte   $7A
        .byte   $EF
        .byte   $DF
        pha
        bcc     L3B18
        .byte   $42
        sbc     ($2E),y
L3B4D:  clc
        .byte   $72
        .byte   $1A
        .byte   $D4
        adc     #$6B
        sta     ($5E),y
        .byte   $53
        jsr     L4E00
        .byte   $5A
        .byte   $52
        ror     $B9
        .byte   $B2
        .byte   $17
        .byte   $3A
        .byte   $77
        stx     $36
        bvc     L3BB1
        .byte   $4F
        .byte   $1A
        cmp     L5E90,x
        .byte   $1B
        .byte   $EF
        .byte   $8B
        clc
        .byte   $63
        adc     $04E5,x
        .byte   $83
        sbc     #$07
        rts

        ror     $6B
        .byte   $3C
L3B79:  ldy     $CE
        .byte   $89
        .byte   $9C
        tsx
L3B7E:  .byte   $13
        .byte   $B2
        clc
        .byte   $64
L3B82:  .byte   $9C
        tsx
        cmp     L0DDF
        .byte   $CF
        ldy     #$1B
        txa
        beq     L3B97
        .byte   $D9
        .byte   $52
L3B8F:  .byte   $CF
        rol     a
        bcc     L3B1F
        ora     #$C3
        .byte   $8C
        .byte   $D4
L3B97:  asl     $69
        bmi     L3BF7
        .byte   $02
        .byte   $B3
        .byte   $1A
        bit     L2D8C
        beq     L3BB2
        .byte   $72
        txs
        .byte   $CB
        asl     a
        stx     $F73A
        .byte   $37
        sty     $03,x
        .byte   $9F
        .byte   $37
        .byte   $FB
        .byte   $A0
L3BB1:  .byte   $E0
L3BB2:  .byte   $07
        bpl     L3C15
        and     $D0,x
        pla
        tsx
        .byte   $1F
        and     $44
        .byte   $93
        .byte   $37
        ldx     #$29
        .byte   $33
        adc     $CE73,x
        .byte   $1C
        .byte   $CF
L3BC6:  jmp     L84E7

        .byte   $DF
        .byte   $83
L3BCB:  .byte   $3C
        asl     a
        .byte   $82
L3BCE:  cpy     $CF
        adc     $52
        and     ($6D,x)
        rol     $A3
        cmp     #$DE
        .byte   $3C
        stx     $4E
        .byte   $DB
        .byte   $73
        clc
        .byte   $8B
        .byte   $9B
        .byte   $E7
        rol     L4932
        .byte   $97
        bne     L3BCB
        .byte   $37
        ldx     $03FC
        .byte   $1C
L3BEC:  adc     L6EC2,y
        bvs     L3BF2
        .byte   $CB
L3BF2:  .byte   $1A
        .byte   $4B
        cpy     #$3C
L3BF6:  .byte   $16
L3BF7:  pha
        inc     $95
        .byte   $20
        .byte   $16
L3BFC:  .byte   $B2
        cli
        .byte   $9B
        eor     #$98
        .byte   $04
        .byte   $D3
        ora     L4B30,x
        .byte   $DA
        sei
        .byte   $D7
        sta     $07
        ldy     $C7
        .byte   $4B
        eor     L7803,y
        ora     $8F,x
        .byte   $0F
        .byte   $43
L3C15:  .byte   $53
        brk
        rol     $80,x
        ldy     $C7
L3C1B:  .byte   $5C
        sta     L37D3
        .byte   $54
        lda     L837C,x
        jmp     L079B

        and     $44,x
        .byte   $4B
        .byte   $D4
        .byte   $0C
        .byte   $9C
        .byte   $B7
        .byte   $CC
L3C2E:  inc     $49,x
        sty     L2F9E
        .byte   $4B
        .byte   $72
L3C35:  tsx
        bit     $21
        .byte   $43
        cpx     $ECC4
        .byte   $2F
        .byte   $3B
        .byte   $82
        iny
        .byte   $DA
        .byte   $B2
        cmp     ($20,x)
        .byte   $13
        .byte   $03
        rti

        .byte   $DC
        .byte   $2F
        brk
        cpx     #$F5
        rol     $43
        .byte   $42
        .byte   $74
        .byte   $C2
        beq     L3BEC
        .byte   $04
        inc     $0E
        .byte   $33
        .byte   $A7
        stx     L44BB
        cpy     $CC
        txa
        bit     $079F
        jsr     L9A8A
        .byte   $2F
        and     ($E1),y
        lda     L3786,y
        eor     ($21),y
L3C6C:  .byte   $D4
        .byte   $9C
        cmp     ($AF,x)
        .byte   $1B
        clv
        .byte   $62
        sty     $21
        .byte   $17
        eor     ($A5),y
        jmp     L691E

        lda     L425C,y
        lda     ($2F,x)
L3C80:  .byte   $31
L3C81:  sei
        .byte   $3C
L3C83:  lsr     $BC85
        sbc     ($6E,x)
        dec     $BE99,x
        .byte   $92
        and     ($84),y
        .byte   $9B
        .byte   $17
L3C90:  sta     ($B1),y
        bvc     L3C35
        asl     a
        eor     $FC,x
        bvc     L3CF3
L3C99:  ora     $6C
        tya
        .byte   $2B
        cmp     L8E98,x
        ora     ($E0),y
        beq     L3D05
        .byte   $DE
        .byte   $5C
L3CA6:  sec
        brk
        lda     ($19,x)
        .byte   $04
        .byte   $93
        cpy     #$42
L3CAE:  .byte   $5C
        .byte   $82
        .byte   $80
        sta     L379E,y
        asl     $06
        .byte   $04
        .byte   $23
        sty     $01
        .byte   $32
        .byte   $4C
L3CBC:  .byte   $1B
        .byte   $72
        cpy     $C8
        cmp     $B072,y
        lsr     $A404,x
        clv
        .byte   $07
        .byte   $03
        cmp     L247A,y
        .byte   $4B
        .byte   $13
        ora     $01
        .byte   $63
        and     $12,x
        eor     L8530,x
        ldy     #$5C
        cpy     $CF98
        and     ($9E,x)
        .byte   $BF
        eor     $E1
        .byte   $7A
        ora     $D0C4,x
        sed
        eor     L1519,y
        .byte   $80
        .byte   $7C
        and     ($29),y
        .byte   $DC
        cpy     #$1C
        sta     ($22),y
        .byte   $6C
L3CF2:  .byte   $61
L3CF3:  .byte   $32
        .byte   $47
        sec
        .byte   $6B
        cmp     L5815
        jmp     L92C2

        bit     $87
        cpy     $84
        adc     L8E78,y
        .byte   $D9
L3D05:  .byte   $12
        .byte   $A3
        .byte   $93
        .byte   $7C
        ora     $D8
        sta     ($A8),y
        .byte   $B2
        .byte   $6B
        .byte   $46
L3D10:  asl     $6D
        sta     $E0
        ror     L4D45,x
        .byte   $97
        .byte   $1B
        ror     $3D
        .byte   $5C
        .byte   $96
L3D1D:  .byte   $1B
        cpx     $F3
        eor     L5C5F,y
        dec     $DB,x
        lsr     L7A5F,x
        .byte   $DF
        .byte   $13
        sty     L4837
        .byte   $5F
        lsr     $4F,x
        eor     #$11
        .byte   $BF
        jsr     L654E
L3D36:  .byte   $21
L3D37:  sei
        .byte   $4C
L3D39:  asl     $5C
        .byte   $04
        .byte   $DC
        .byte   $2F
        .byte   $54
        .byte   $9C
        .byte   $D4
L3D41:  plp
        pla
        eor     $10
        .byte   $1C
        .byte   $1B
        sta     ($61),y
        cpx     #$1C
        .byte   $7B
        .byte   $F7
        adc     ($04,x)
        eor     #$49
        .byte   $EB
        sei
        .byte   $1F
        and     $3A
        asl     $AC
        .byte   $69
L3D59:  .byte   $2F
        .byte   $FC
        rts

        sbc     ($D3),y
        dec     $BC,x
        .byte   $0C
        .byte   $43
        .byte   $82
        sty     $3B,x
        dey
L3D66:  .byte   $FA
        .byte   $2B
L3D68:  dec     $EE
        cli
        sta     ($22,x)
        inc     $F4,x
        .byte   $2F
        .byte   $8B
        dec     $40
        .byte   $9C
        adc     ($00,x)
        cpy     $CACB
        .byte   $E2
        .byte   $37
        tay
        .byte   $80
        bcs     L3D41
        cmp     $32
        dex
        lda     L31BA
        .byte   $E7
        .byte   $47
        lda     ($27),y
        .byte   $96
L3D8A:  .byte   $22
        .byte   $64
        lda     L6479,x
        jmp     L84EC

        ldy     $06,x
        ror     a
        pha
        .byte   $D7
        .byte   $2F
        .byte   $23
L3D99:  asl     $F33A,x
        ora     L4B44,x
        cmp     $D730
        .byte   $13
        .byte   $F2
L3DA4:  eor     $C238,x
        .byte   $47
        beq     L3D8A
        and     $064C
        bpl     L3D36
        rol     $C91A
        adc     $E6,x
        stx     L125E
        .byte   $D3
        adc     L35D0,y
        sbc     ($43,x)
        and     $E5,x
        ldx     L278A
        .byte   $83
        rti

        lda     #$83
        .byte   $92
        tya
        .byte   $DB
        .byte   $7C
        sta     L314A,y
        cpx     #$16
        rol     $DB
        jmp     LEB72

        .byte   $9B
        sta     $99
        rol     $31
        adc     $A6
        eor     ($08,x)
        dec     $EE
        cmp     #$BF
        sta     $EF02,y
        bne     L3DF3
        .byte   $C3
        pla
        stx     $CA40
        php
        .byte   $E3
        .byte   $9F
        ror     a
        bpl     L3DA4
        .byte   $01
L3DF2:  .byte   $63
L3DF3:  ror     L395F,x
        .byte   $03
        .byte   $7E
L3DF8:  bvc     $3DCC
        cli
        .byte   $5A
        .byte   $B2
        inx
        ldy     L26BD
        .byte   $E3
        ora     $C1F4
        .byte   $2F
        ora     L1803,y
        eor     L5E2C
        .byte   $23
        tay
        .byte   $2F
        inc     $E3
        jmp     LFCF5

        ldx     $91,y
        .byte   $9C
        .byte   $9E
        ora     L53B8
        clc
        .byte   $83
        bcc     L3E50
        .byte   $DA
        sty     $C5
        bit     $F22C
        .byte   $2F
        .byte   $02
        .byte   $A2
L3E28:  .byte   $93
        cpx     $0E
L3E2B:  .byte   $13
        beq     L3E3B
        .byte   $43
        sty     $CE,x
        sta     L39CB
        eor     #$47
        and     #$8C
        adc     ($BA,x)
        .byte   $70
L3E3B:  .byte   $34
        cpy     L1379
        .byte   $4B
        txs
        eor     $E782,y
        inc     $EC,x
        .byte   $CF
        .byte   $80
        pha
        .byte   $B9
        .byte   $07
L3E4B:  .byte   $2F
        .byte   $34
        .byte   $E3
        .byte   $1C
        .byte   $97
L3E50:  ora     #$9F
        .byte   $80
        jmp     L8327

        php
        sta     L0991,x
        .byte   $93
L3E5B:  lsr     $F162,x
        .byte   $77
        .byte   $07
        .byte   $C2
        ror     $90,x
        bcc     L3DF8
        .byte   $27
        .byte   $7C
        stx     L1373
        .byte   $24
L3E6B:  asl     $B003,x
        dec     $52,x
L3E70:  lda     $EF,x
        and     $B7,x
        .byte   $F3
        lda     ($B1),y
        sbc     ($B7),y
        .byte   $EF
L3E7A:  sta     $A461
        and     $B4AF
        ror     L3AC8
        and     $4B
        and     ($E0),y
L3E87:  ldx     $37,y
        sbc     ($DE,x)
        and     ($9D),y
        bvs     L3ED8
L3E8F:  .byte   $33
        .byte   $11
L3E91:  ldx     $A1
        dey
        .byte   $A3
        asl     L5283
        pha
        stx     $994E
        bmi     L3E91
        sta     L582E
        .byte   $82
        sty     $E5
        .byte   $97
        .byte   $52
        .byte   $EB
        cpx     L29AF
        cld
        lda     ($B9,x)
        sta     L5AF2,y
        cmp     #$C5
        clc
        sbc     (L00F9),y
L3EB5:  .byte   $F9
L3EB6:  eor     $86,x
        .byte   $99
        .byte   $27
L3EBA:  and     ($30,x)
L3EBC:  .byte   $D2
        ora     $C2C1,y
        .byte   $67
        cpy     #$E5
        .byte   $3A
        lsr     L115B
        stx     $32
        ldy     $04
L3ECB:  .byte   $B2
        adc     ($F3),y
        eor     $7A
        .byte   $04
        sbc     ($78),y
        .byte   $5C
        .byte   $C3
        ora     L2AE7,y
L3ED8:  lsr     L4094,x
        lsr     $A140,x
        .byte   $74
        .byte   $02
        .byte   $6F
        ora     $D421
        .byte   $44
        sbc     L6B7C,y
        beq     L3E8F
L3EEA:  eor     ($99,x)
        .byte   $D3
        .byte   $64
        .byte   $6F
        eor     ($78,x)
        .byte   $8F
        dec     $18
        tsx
        lda     ($86),y
        .byte   $7C
        adc     $BBE5,x
        ldx     $40
        .byte   $D3
        eor     $C0
        lda     ($8B),y
        nop
        .byte   $1C
        cmp     ($E0),y
        stx     $5E,y
        nop
        .byte   $17
        lsr     $7C
        .byte   $1F
        .byte   $05
L3F0E:  .byte   $1A
        bne     L3F29
        .byte   $F2
        .byte   $17
        .byte   $53
        .byte   $1A
        .byte   $F1
L3F16:  .byte   $3B
        pha
        .byte   $12
        .byte   $89
        .byte   $1C
L3F1B:  .byte   $7C
        lsr     $27,x
L3F1E:  .byte   $1F
        php
        .byte   $54
        adc     ($96,x)
        ora     ($7A,x)
L3F25:  lda     L1846
L3F28:  .byte   $F0
L3F29:  .byte   $97
        sta     $9282
        eor     #$41
        ora     #$0A
        .byte   $FA
        .byte   $B7
        .byte   $F3
        sty     $B1F8
        .byte   $89
        adc     L8A6C,x
        cmp     L462F,y
        .byte   $12
L3F3F:  .byte   $67
        .byte   $80
        rol     $4E,x
        .byte   $5C
L3F44:  adc     ($26),y
L3F46:  .byte   $67
        .byte   $8B
        sbc     $4B
        bit     $8E
        and     L3A63
        sbc     $C760
        ora     ($FE,x)
        .byte   $82
        beq     L3F44
        .byte   $0B
        .byte   $23
        .byte   $5C
        cpy     $23
        lsr     $C816
        plp
        ldy     $88
        ora     L6C31,x
L3F65:  rol     L38C0
        .byte   $CF
        .byte   $5A
        bcs     L3F0E
        sta     $86
        txa
        .byte   $9B
        rol     L8988
L3F73:  ldx     L5302
        iny
        cmp     #$A2
        .byte   $BF
        brk
L3F7B:  dex
        .byte   $14
        .byte   $BC
L3F7E:  pla
        sbc     ($4C,x)
        sei
        .byte   $02
L3F83:  .byte   $80
        .byte   $7E
        .byte   $2C
L3F86:  .byte   $3B
        .byte   $42
        .byte   $04
        lda     $0294,x
        .byte   $F2
        .byte   $73
        tay
        sta     (L0060,x)
        .byte   $97
        .byte   $33
        .byte   $CF
        clv
        .byte   $CF
        rol     L7332
        .byte   $FB
L3F9A:  php
L3F9B:  .byte   $92
        sbc     ($A0),y
        bit     $B19B
        ora     $F2
        sbc     $88,x
        asl     L2FC2
        eor     #$C9
        jsr     L22AB
        .byte   $DB
        cld
L3FAF:  .byte   $52
        .byte   $F3
        .byte   $A7
        .byte   $23
        cpx     $B7
        cpx     #$B9
        asl     $0F,x
        .byte   $62
        tya
        php
        sbc     L1427,y
        plp
        cld
        beq     L3F73
        cmp     $AD35,x
        asl     $BA92,x
        lsr     a
        .byte   $AF
        .byte   $9C
        .byte   $2F
        sta     (L0060,x)
        .byte   $23
        ora     ($D8,x)
        ldx     L2085,y
        inx
        .byte   $93
        .byte   $37
        .byte   $DE
        .byte   $04
L3FDA:  cmp     $40
        bit     $31
        and     ($D4),y
        php
L3FE1:  ldy     L8B0C,x
        .byte   $C7
        bmi     L3F7E
L3FE7:  bpl     L3F7B
        rts

        jsr     LE2CC
        cpx     #$34
        .byte   $0B
        .byte   $2D
        .byte   $8B
L3FF2:  .byte   $12
        .byte   $77
        eor     #$82
        .byte   $53
        asl     $E4,x
        .byte   $BC
L3FFA:  cmp     $8D0B
        .byte   $80
        cpy     $33DD
        cld
        ldy     L35DE
        .byte   $67
        sty     $D2DE
        tax
        .byte   $CB
        .byte   $D4
        pla
        .byte   $13
        .byte   $E2
        .byte   $8B
L4010:  .byte   $03
        txa
        cpy     L6C2A
        stx     L6892
        .byte   $7A
        .byte   $54
        bcc     L4083
        ror     $EC,x
        .byte   $BE
L401F:  sta     $2209
        .byte   $E2
        php
L4024:  tya
        .byte   $44
        rol     $5E
        .byte   $0C
        .byte   $74
L402A:  ora     $9A31
        cmp     $D312,y
L4030:  .byte   $83
        lsr     $C018,x
        bpl     L406B
        sbc     #$09
        and     #$88
        tya
        .byte   $FF
        .byte   $0C
        .byte   $7A
        .byte   $C2
        rol     $CC
        eor     $EFE2,y
        tya
        .byte   $3A
        iny
        ldx     $E133
        cmp     L31B1,y
        .byte   $E2
        sty     L8306
L4051:  .byte   $3C
        clc
        .byte   $83
        cpy     #$E1
        .byte   $D6
L4057:  bit     $21
        tsx
        rol     $CD
        sei
        .byte   $3C
        .byte   $89
        .byte   $0B
L4060:  pha
        .byte   $DA
        brk
L4063:  ldy     #$C2
        .byte   $D3
        .byte   $37
        .byte   $E2
        .byte   $7F
L4069:  .byte   $37
        brk
L406B:  cpy     #$06
        rol     $74,x
        txa
        rol     a
        .byte   $A3
L4072:  clc
        sta     L6021,y
        lda     L4100,x
        cpy     L21C7
L407C:  ora     #$C2
        cli
        pha
L4080:  .byte   $D3
        cli
        .byte   $17
L4083:  .byte   $37
        .byte   $E1
L4085:  .byte   $3B
        rol     a
L4087:  .byte   $3B
        dex
        ldy     $94D7,x
L408C:  jmp     (L53C7)

        .byte   $72
        .byte   $53
        pla
        .byte   $C2
        .byte   $96
L4094:  bit     $61
        eor     $994B
        .byte   $33
        .byte   $3B
        lda     ($31,x)
        sbc     #$0C
        .byte   $3B
        sed
        .byte   $17
        ora     L2BF8
        eor     #$16
        cmp     #$0B
        .byte   $4B
        dex
        clc
        cpy     $38
        .byte   $0B
        .byte   $02
L40B0:  bit     $4C
        .byte   $75
L40B3:  ldx     $278F
        .byte   $93
        tay
        .byte   $82
        sta     L72FB
        .byte   $5B
        adc     $E962,y
        inc     L2D48
        .byte   $64
        .byte   $4B
        .byte   $D2
        pha
L40C7:  tya
        lda     L3391,y
        .byte   $8B
        .byte   $B2
        .byte   $C9
L40CE:  .byte   $52
        sbc     $0468
        eor     $906D
        ldy     L8BBB,x
        .byte   $04
        .byte   $83
        inc     $4A,x
        .byte   $74
        ldy     L62F5,x
        jmp     LCEF2

        .byte   $33
        .byte   $E7
        sta     $07,x
        .byte   $FB
        .byte   $D2
        beq     L415E
        bit     L3707
        inx
        .byte   $84
L40F0:  and     $AB,x
        .byte   $73
        ldy     $59
        .byte   $2F
        .byte   $64
        .byte   $03
        .byte   $1C
        and     ($8B,x)
        asl     $0A
        .byte   $0F
        sta     ($2E),y
L4100:  bcc     L414E
        sbc     ($F6),y
        .byte   $8C
L4105:  .byte   $33
        inc     $47
        .byte   $0B
        .byte   $12
        asl     a
        inc     $0C
        sed
        and     $24
        eor     $A845
        .byte   $B2
        inc     $C2,x
        .byte   $AF
        .byte   $2F
        .byte   $93
        tay
        ldx     L2955,y
        .byte   $C3
        .byte   $39
L411F:  stx     $2E,y
        .byte   $F3
        cpy     $9973
        asl     a
        .byte   $F3
        .byte   $1C
        cld
        .byte   $27
L412A:  .byte   $8D
L412B:  .byte   $72
        rol     $27,x
        dey
        .byte   $5C
        lda     L8C68,x
        .byte   $62
        .byte   $1A
        jmp     (L40B3)

        and     ($6C),y
        .byte   $CC
        inx
L413C:  cpx     $3B
        rol     $4B
        cpx     #$20
        .byte   $1B
        asl     $A2
        ora     #$0E
        .byte   $9C
        lda     $E5
        dec     $4D
        .byte   $EC
        .byte   $46
L414E:  sta     $B4,x
        .byte   $72
        eor     ($16,x)
        .byte   $3B
        .byte   $93
        asl     L3966
        .byte   $F7
        .byte   $97
        dex
        iny
        .byte   $73
        .byte   $B0
L415E:  sbc     $4B
        .byte   $CB
        .byte   $17
        bcs     L41CD
        sta     $51,x
        .byte   $03
        .byte   $32
        asl     $EB
        .byte   $71
L416B:  .byte   $7A
        ora     ($68,x)
L416E:  sta     $D7BC,x
        .byte   $92
        .byte   $27
        .byte   $1F
        ror     $F4
        lda     ($79),y
        .byte   $37
        .byte   $97
        adc     L3D66,y
        asl     L8651,x
        .byte   $32
        eor     L5D34
        .byte   $B2
        .byte   $87
        cmp     ($BE,x)
        .byte   $1B
        lda     $EE25,x
        bcs     L41F1
        .byte   $0B
        and     ($86),y
        .byte   $FA
        beq     L412B
        tya
        .byte   $17
        .byte   $54
L4197:  jmp     (LF47C)

        cmp     $054C,y
        pha
        dec     $18
L41A0:  lda     L26A6
        .byte   $F4
        adc     ($40,x)
        bit     $D8
        and     ($67,x)
L41AA:  sbc     $D4A4,y
        cpy     #$77
        sta     L2582,y
        sbc     ($B1),y
        ora     ($38,x)
        inc     $0D
        and     L4CBD,x
        sei
        .byte   $97
        .byte   $A3
L41BE:  eor     $A779
        .byte   $83
        cld
        lda     $C94F,x
        ora     $89,x
        .byte   $AC
        .byte   $12
L41CA:  .byte   $EF
        .byte   $7E
        .byte   $30
L41CD:  .byte   $C7
        sty     $FF,x
        .byte   $D4
        .byte   $B9
L41D2:  cld
        .byte   $2F
        .byte   $5C
        bpl     L4197
        and     $A2,x
        bmi     L41A0
        .byte   $8F
        .byte   $2F
        .byte   $9B
        .byte   $D4
        cmp     $53,x
        .byte   $23
        tya
        ldx     $EF12,y
        .byte   $53
        asl     $B2
        .byte   $62
        .byte   $5A
        .byte   $34
        .byte   $C7
        bvc     L41D2
        .byte   $87
        .byte   $A2
L41F1:  sty     $2A,x
        ldx     $8B
        .byte   $1F
        eor     ($FE,x)
        bit     $99
        .byte   $37
        plp
        .byte   $77
        dec     $78,x
        .byte   $89
        inx
        sta     L1362,y
        jmp     LBA72

        .byte   $0F
        .byte   $83
        adc     L8B6C,x
        .byte   $C2
        .byte   $80
        .byte   $C7
        .byte   $64
        .byte   $52
        .byte   $DC
        .byte   $D3
        and     $FF,x
L4215:  .byte   $97
        ldy     #$2A
        rol     L768C
        lda     #$35
        cpx     $55
        .byte   $37
        bne     L4292
        sta     L31CE,y
        .byte   $DC
        cpy     L10DF
        .byte   $23
        rol     L7219,x
        bvs     L4298
        and     L30F9
        .byte   $CF
        .byte   $32
        adc     ($93),y
        rol     $1C
        sta     $C311
        .byte   $D2
        plp
        sta     L8CFC,x
        sed
        .byte   $17
        .byte   $03
        .byte   $63
        .byte   $D4
        .byte   $B3
        cpx     L7CCF
        .byte   $72
        .byte   $5F
        .byte   $A3
        .byte   $87
        .byte   $93
        inx
        .byte   $3B
        .byte   $0C
        sbc     ($B5),y
        .byte   $0F
        .byte   $19
        .byte   $22
L4256:  bit     $64
        .byte   $4B
L4259:  .byte   $2E
L425A:  .byte   $CE
        .byte   $9E
L425C:  .byte   $32
        php
        cpy     #$93
        bit     $26
        .byte   $8F
        jsr     LBDD4
        .byte   $9F
        pha
        .byte   $E3
        sta     $E88D,y
        .byte   $37
        .byte   $C7
        .byte   $80
        .byte   $DF
        sta     $CE0C,y
        .byte   $12
        ora     $CC99
        .byte   $74
        jsr     L990C
        .byte   $93
        lsr     $E332,x
        .byte   $3D
        .byte   $6E
L4281:  nop
        .byte   $49
L4283:  pha
        ldx     $8D
        .byte   $F2
        .byte   $07
        lda     L869A
        rol     L4CA2
        sed
        .byte   $D3
        .byte   $0C
        .byte   $FA
L4292:  .byte   $1A
        dec     L545D
        .byte   $6C
        .byte   $4C
L4298:  jmp     L8C70

        .byte   $22
        bcc     L4256
        sta     $CE,x
        .byte   $C9
L42A1:  .byte   $37
        adc     L788C
        stx     $8B,y
        .byte   $DC
        .byte   $0C
        .byte   $DF
        jmp     (L9BA0)

        .byte   $2B
        inx
L42AF:  txa
        .byte   $2B
        ora     $A960,y
        and     $AE8C
        and     ($5B),y
        ora     $F1F1
L42BC:  sbc     #$0A
        .byte   $C2
        lda     ($E5),y
        inc     $A3
        iny
L42C4:  .byte   $3B
        and     $82,x
        .byte   $F3
        clc
        pla
        sta     L34EA
        ror     a
        jsr     L3C2E
        .byte   $DF
        sta     $CF60
        lda     $2F
        .byte   $74
        ldy     L4D6F,x
        rol     $8A,x
        .byte   $DB
        .byte   $37
        .byte   $EB
        lda     L722B,y
        ldx     L2C2A
        .byte   $DF
        php
        .byte   $F2
        sbc     #$84
        ldx     $F4,y
        .byte   $DF
        .byte   $AF
        .byte   $5A
        .byte   $72
        rti

        .byte   $B7
        jmp     (L639C)

        .byte   $03
        asl     $F0
        sta     L8C5F,y
        .byte   $34
        cmp     $0B
        .byte   $C2
        cmp     #$60
        ora     $2C
        ora     $9A34,y
        tsx
L4308:  sty     L0999
L430B:  sta     $F882,y
        asl     $F50D,x
        adc     $EE31,x
        adc     $EDF5
        .byte   $AF
        and     ($8B),y
        .byte   $FE
L431B:  .byte   $92
        inc     $57,x
        ora     ($82,x)
L4320:  tsx
        .byte   $C3
        .byte   $F7
        .byte   $A3
        .byte   $03
        .byte   $7F
        ldx     $AC,y
        .byte   $CF
        .byte   $AF
        bcs     L42C4
        .byte   $83
        .byte   $2F
        ldy     #$BC
        lda     L0DBF,x
        tax
        eor     #$78
        .byte   $E2
        sbc     $A4
        txa
        rts

        and     $ED,x
        pha
        cmp     ($DF),y
        .byte   $B6
L4341:  sta     ($31),y
        cmp     ($3A),y
        bmi     L431B
L4347:  rts

        .byte   $31
L4349:  sta     $E379,x
        ror     $73BD,x
L434F:  asl     $3885,x
        .byte   $93
        .byte   $5A
        .byte   $9B
        txs
L4356:  .byte   $37
        .byte   $C6
L4358:  cpy     $D7
        eor     $62,x
        rts

        .byte   $34
        .byte   $B2
        inc     $98DC,x
        .byte   $34
        .byte   $22
        iny
        .byte   $C7
        ora     $E8A2,y
        .byte   $C4
L436A:  and     ($65,x)
        ror     $8C
        sed
        .byte   $EF
        cmp     #$EE
        .byte   $3E
        .byte   $33
L4374:  .byte   $E7
        tax
        sty     $A338
        .byte   $CB
        .byte   $53
        .byte   $4B
        lda     ($32,x)
        .byte   $5B
        .byte   $73
        ora     $D360,y
L4383:  and     L0C8B,y
        .byte   $77
        inc     $0A
        pla
        .byte   $F3
        lsr     L2383,x
        bpl     L43F3
L4390:  ldx     #$78
        cmp     $C794,y
        ldx     #$2C
        tay
        brk
        sty     L37EE
        cpx     $48
        .byte   $02
        .byte   $12
        .byte   $CB
        cpy     #$F7
        bit     L3169
        .byte   $AE
        .byte   $D2
L43A8:  lsr     a
        clv
L43AA:  tay
        .byte   $D2
        .byte   $92
        .byte   $77
        .byte   $80
        .byte   $26
L43B0:  beq     $436C
L43B2:  sbc     ($22,x)
        .byte   $3C
        and     $63,x
        .byte   $4B
        .byte   $87
        .byte   $B2
        ror     $E18C
        inc     $9747
        bit     $DD10
        cmp     ($38),y
        .byte   $7B
        ldy     L2889
L43C9:  .byte   $0B
        bcc     L434F
        rol     $92D0,x
        .byte   $3A
        .byte   $8B
        .byte   $82
L43D2:  .byte   $DA
        cpy     #$B7
L43D5:  and     ($EB),y
        sta     $B0F5,x
        .byte   $0C
        .byte   $F3
        .byte   $0F
        ora     L67D2,y
        .byte   $D2
        .byte   $F4
        clv
        .byte   $43
        and     ($89),y
        .byte   $12
L43E7:  rol     L086B,x
        cmp     ($0F),y
        .byte   $AB
        .byte   $33
        rol     L725E,x
        .byte   $FA
        .byte   $79
L43F3:  ora     #$C3
        bit     L8D35
L43F8:  .byte   $F7
        .byte   $33
L43FA:  and     $D4,x
        bit     $21
        .byte   $4B
        lda     ($18,x)
        .byte   $62
        .byte   $D2
        .byte   $72
        .byte   $EB
        .byte   $32
        sei
        .byte   $C7
        .byte   $6E
        .byte   $2E
L440A:  .byte   $73
        .byte   $1B
        eor     $34,x
        dec     $F00E,x
        eor     L8D2F,y
        .byte   $9C
        .byte   $E5
L4416:  bne     L43A8
        .byte   $C7
        sei
        .byte   $53
        asl     $B35B,x
        .byte   $1A
L441F:  sbc     ($00),y
        .byte   $02
        nop
        .byte   $9C
        ldy     $A713
        adc     #$F9
        inx
        .byte   $F2
        cpx     $DF7C
        .byte   $2F
        .byte   $A3
        eor     L8A23,x
        sei
        .byte   $2F
        ora     $38
        .byte   $D3
        .byte   $B7
        stx     $28,y
        .byte   $E3
        lda     ($38),y
        .byte   $D2
        .byte   $67
        plp
        .byte   $CF
        txs
        .byte   $64
        .byte   $9E
        txa
        .byte   $C9
L4447:  .byte   $A3
        eor     L350A,y
        .byte   $87
        .byte   $52
        ldy     $A6
        sty     $A22C
        sta     ($34,x)
        .byte   $3A
        .byte   $0C
        sbc     L83E8
        sed
        ldx     #$70
        .byte   $EB
        inc     $EB35
        .byte   $C2
        .byte   $33
        .byte   $DC
        cld
        txs
        .byte   $02
L4466:  plp
        ror     a
        sei
L4469:  bne     L44CE
        .byte   $7B
        .byte   $D4
        lda     $C8,x
        sta     $5C,x
        .byte   $A7
        .byte   $22
        stx     $43,y
L4475:  pla
        .byte   $C7
        cpy     #$77
L4479:  .byte   $37
        tya
        .byte   $23
        .byte   $5B
        .byte   $D7
        asl     $C2
        dec     $52,x
        .byte   $73
        sta     L632E
        eor     #$09
L4488:  .byte   $02
        .byte   $44
        .byte   $A7
        .byte   $72
        .byte   $DC
        .byte   $12
        .byte   $F7
        stx     $33,y
        .byte   $EB
        sbc     ($31,x)
        clc
        .byte   $0B
        lda     ($20),y
L4498:  .byte   $F2
        .byte   $37
        cmp     $66,x
        .byte   $44
        .byte   $D7
        lda     L3CAE,y
        .byte   $C7
        .byte   $9B
        .byte   $34
        stx     $0A,y
        .byte   $34
        .byte   $D7
        .byte   $0C
        .byte   $F3
        and     ($F3,x)
        sec
        lda     L2F8C
        ldy     L1402
        sta     ($5F,x)
        .byte   $2F
L44B6:  .byte   $2B
        lda     #$19
        .byte   $B2
        .byte   $3A
L44BB:  ror     a
        cpx     $09
        ldy     $90,x
        .byte   $BB
        and     ($E8),y
        .byte   $34
        sty     L0835
        .byte   $E3
        .byte   $0B
        dec     $10
        ldx     L535C,y
L44CE:  .byte   $3A
        .byte   $82
        sbc     $D1,x
        .byte   $37
        beq     L44F3
        cmp     #$0E
        adc     $C389,y
        .byte   $F4
        .byte   $DD
L44DC:  .byte   $FB
        and     $3511
        cmp     $08
        clv
L44E3:  sta     L362F,x
        .byte   $32
        sed
        rol     $F60C
        sta     L8BBE,x
        and     #$2C
        .byte   $D7
        .byte   $A3
        .byte   $F4
L44F3:  .byte   $C7
        eor     $20
        tax
        asl     $F9E0
        and     $C4,x
        tsx
        jmp     L9C98

        .byte   $2F
        ldy     $AC
        .byte   $BE
L4504:  ora     $B5C2,y
        cmp     $B7FB
        .byte   $8B
        ldy     $69,x
        dey
        .byte   $D3
        .byte   $8F
        sta     ($10,x)
        tsx
L4513:  ora     $2D
        .byte   $2F
        .byte   $22
        ldy     #$2B
        .byte   $42
        .byte   $6B
        ldy     #$D7
        .byte   $04
        .byte   $32
        .byte   $8B
        .byte   $8B
        ldy     $B3,x
        ora     L8C43,y
        and     L0DB9,y
        eor     L69E2,x
        .byte   $AF
        tsx
        .byte   $DC
        dec     L42AF
L4532:  .byte   $5C
        cpy     L2ADD
        cpx     $D7
        .byte   $44
        .byte   $8D
        .byte   $33
L453B:  cli
        .byte   $59
L453D:  dec     $A9F5,x
        .byte   $33
        .byte   $EC
L4542:  .byte   $7B
        bit     $90A0
        .byte   $27
        .byte   $74
L4548:  adc     #$B8
        .byte   $A3
        eor     $AEA6,x
        .byte   $A3
        .byte   $0C
        .byte   $12
        .byte   $3A
        .byte   $0C
        .byte   $F2
        .byte   $B0
L4555:  .byte   $23
        plp
        .byte   $C7
        sta     ($D8,x)
        .byte   $8B
        pla
        .byte   $D2
        sed
        .byte   $C2
L455F:  .byte   $67
        php
        .byte   $D4
        ora     $C3
        .byte   $8F
        .byte   $B2
        dey
        .byte   $9C
        brk
        .byte   $80
        bpl     L4577
        .byte   $42
        sty     $A0,x
        .byte   $63
        asl     LE31C,x
        ror     L32E4,x
        .byte   $E2
L4577:  ldy     #$CF
L4579:  bpl     L453D
        .byte   $E6
L457C:  dey
        dec     L4BA6
        dec     $DFD0,x
        .byte   $9B
        bvc     L4555
        .byte   $80
        bvc     L45C1
        stx     $ED1A
        sec
        bvc     L455F
        txs
        .byte   $0C
        rts

        lda     $23,x
        bcc     L4542
        .byte   $33
        .byte   $14
        rts

        ldx     L43B0,y
        .byte   $87
        eor     $A3,x
        sei
        sbc     $B633,x
        .byte   $32
        sec
        .byte   $01
L45A6:  sty     $BE
        lda     $B412
        sta     $E8FA
        dex
        .byte   $73
        and     $10
        .byte   $27
        .byte   $5B
        cmp     #$33
        and     $C110
        ora     L1602
        cmp     ($14,x)
        .byte   $9B
        sta     ($02),y
L45C1:  .byte   $83
        clc
        sta     L4024,x
        .byte   $27
        ror     $A410
        .byte   $0F
        bmi     L45D5
        .byte   $33
        .byte   $EB
        cmp     #$33
        cmp     L0060
        .byte   $E7
        .byte   $BC
L45D5:  .byte   $53
        .byte   $1C
        ldy     #$0D
        ror     a
        .byte   $12
        cpx     #$BC
        .byte   $52
        rol     a
        cpy     L1269
        clc
        .byte   $83
        cld
        .byte   $92
        .byte   $FC
        pha
        beq     L460B
        .byte   $34
        .byte   $3F
        .byte   $B2
        rol     L344A
        ldy     L82E6
        ldy     #$CA
        .byte   $D4
L45F6:  sbc     $D8
        .byte   $FC
        .byte   $9E
        sbc     L3E70,x
        jsr     L182A
        lda     ($B8),y
        .byte   $1F
        cmp     $B67A
        .byte   $43
        .byte   $1C
L4608:  tax
        .byte   $92
        .byte   $FC
L460B:  .byte   $1F
        .byte   $E2
        sbc     L4C34,y
L4610:  .byte   $F4
        .byte   $64
        rol     $70
        .byte   $E3
        rol     $B4
        cmp     L3AFC
        .byte   $92
        .byte   $F2
        inc     $09
        .byte   $F3
        .byte   $7F
        .byte   $07
        stx     $40,y
        cpx     $AD
        .byte   $1C
        cmp     ($CE,x)
        .byte   $34
        .byte   $13
        .byte   $7B
        ldy     #$3C
        .byte   $63
        .byte   $70
L462F:  .byte   $C5
L4630:  bne     L460B
        .byte   $C7
        stx     $4C
        .byte   $89
        .byte   $9C
        .byte   $1F
        cmp     L0A9C
        inc     $BC
        eor     ($C5),y
        dec     $AF41,x
        clc
        rti

        .byte   $0E
L4645:  ora     $69A4,x
        adc     ($C4),y
        adc     $E0,x
        asl     $6E
        bvc     $4669
        adc     $1B
        sbc     $EF,x
        adc     #$9B
        jmp     LEB99

        ldx     $1D,y
        lda     ($79,x)
        sec
        .byte   $67
        dec     $CE,x
        .byte   $0B
        eor     $E0
        lsr     $4D,x
        .byte   $1F
L4667:  .byte   $83
        and     $CAC7,y
        .byte   $82
        .byte   $63
        .byte   $80
        eor     ($72,x)
        txs
        .byte   $5E
L4672:  .byte   $27
        inc     $31
        .byte   $77
        .byte   $34
        rts

        eor     #$20
        lsr     $056F,x
        .byte   $92
        cmp     $C1D4,x
        tax
        .byte   $12
        bmi     L4645
        lsr     $3D
        .byte   $7B
        .byte   $34
        cmp     L457C
        eor     #$23
        ora     L6733,x
        rti

        .byte   $62
        .byte   $5C
        .byte   $77
        .byte   $DA
        eor     $9724
        sta     $9F19
        .byte   $0B
        .byte   $CC
L469E:  .byte   $D4
        .byte   $A9
L46A0:  pla
        ora     $9FF1
L46A4:  .byte   $4B
        .byte   $C9
L46A6:  adc     $AF,x
        rol     $6E
L46AA:  lda     $99
L46AC:  .byte   $F4
        and     $11,x
        pha
        .byte   $37
        .byte   $33
        lsr     $09
        clv
        ldx     #$18
        .byte   $8B
        ldy     $29,x
        .byte   $32
        .byte   $07
        .byte   $4B
        stx     L5E13
        tya
        bmi     L4667
        and     $54
L46C5:  .byte   $9E
L46C6:  sta     L2F8D,y
        .byte   $7C
        .byte   $72
        tay
        sty     L60FC
        .byte   $F2
        .byte   $E0
L46D1:  ldy     $C6,x
        .byte   $1C
        .byte   $43
        .byte   $DA
        plp
        cmp     L8CF4
        .byte   $33
        bvc     L4726
        .byte   $1B
        .byte   $4B
        bcs     L46A4
        .byte   $5B
L46E2:  ora     L2D91
        .byte   $5F
        .byte   $3A
        .byte   $FC
        and     L7DD3
        lda     L5C0E,x
        .byte   $33
        .byte   $CB
        sbc     ($FB),y
        lsr     a
        brk
        .byte   $8B
        txa
        and     $DB,x
        .byte   $F7
        jmp     LF1E3

        .byte   $BB
        .byte   $03
        rol     $C2,x
        ror     $4C,x
L4702:  .byte   $C7
L4703:  cpy     #$2F
        .byte   $37
        cld
        inc     L4072
L470A:  .byte   $CF
        .byte   $BF
        jsr     L0FCF
        .byte   $F3
        .byte   $87
        sty     $CC
L4713:  ldy     $94,x
        .byte   $13
        .byte   $22
L4717:  .byte   $83
L4718:  .byte   $34
        .byte   $CF
        bcc     L476C
        lda     $D2C8
        sbc     $77,x
        sec
        .byte   $7A
        cpy     $01
        .byte   $74
L4726:  ldx     L5387,y
        .byte   $3F
        .byte   $02
        bcc     L4744
        jmp     LDE50

        sta     $DE32,y
        .byte   $72
        cpx     L6886
        .byte   $D7
        cli
        .byte   $42
        cpx     #$02
        bmi     L4703
        sbc     $9DE9,y
        stx     $93,y
        .byte   $37
L4744:  inc     $1A
        .byte   $37
        cpx     L3116
        .byte   $DB
        ldx     $C760,y
        .byte   $5B
        .byte   $13
        .byte   $1F
L4751:  ora     #$E4
        .byte   $14
        .byte   $7A
        .byte   $89
        .byte   $82
L4757:  .byte   $63
        .byte   $87
        ldy     $AC,x
        .byte   $BB
        dec     L319A,x
        beq     L4717
        ora     L7371
        sty     $032F
        .byte   $22
        .byte   $C2
        .byte   $43
L476A:  .byte   $5C
        .byte   $B4
L476C:  .byte   $02
        .byte   $04
        ldy     L0BAA,x
        .byte   $0B
        lsr     a
        sbc     $2F
        eor     ($83,x)
        plp
        .byte   $80
        .byte   $9E
        bit     $AA
        brk
        bne     L4702
        .byte   $33
        .byte   $32
        .byte   $8B
        sbc     $DF
        and     ($C0),y
        cli
        .byte   $3F
        .byte   $8B
        cpx     $902A
        .byte   $33
        .byte   $D7
        ldy     $C7
        .byte   $9C
L4791:  .byte   $F2
        .byte   $44
L4793:  .byte   $9B
        .byte   $FA
        rol     $A5A1
        .byte   $A3
        .byte   $62
        jmp     LD1F1

L479D:  asl     $89
        .byte   $12
        .byte   $33
        .byte   $4B
        .byte   $DC
        .byte   $EF
        tsx
        inc     $28,x
        tsx
        ora     L3A21,y
        .byte   $7B
L47AC:  sei
        ldx     $A907,y
        .byte   $A3
        ror     L09A5,x
        .byte   $33
        .byte   $07
        ldx     #$EF
        .byte   $5C
L47B9:  inc     L35AB
        cmp     $88,x
        ldy     L8A11,x
        asl     $8A,x
L47C3:  nop
        sec
        lsr     L22AB
        .byte   $FB
        asl     $C60B
        bpl     L47E5
        cpy     L607B
        ora     #$26
        .byte   $3B
        .byte   $4B
        cpx     $C0D6
        .byte   $33
L47D9:  pla
        .byte   $43
        jmp     (L6215)

        cmp     #$D1
        cpy     #$CC
        dex
        asl     a
        .byte   $D2
L47E5:  ror     $29,x
        .byte   $33
        .byte   $C3
        .byte   $7A
        beq     L47C3
        jmp     (L8683)

        .byte   $47
        .byte   $A7
        ora     #$9C
        .byte   $E2
        inc     $D0
        bmi     L481E
        sta     L08E7
        sbc     #$EB
        .byte   $22
        sec
        .byte   $D7
        ldy     #$93
        .byte   $32
L4803:  cli
        and     $C4EA,y
        .byte   $CF
        .byte   $9F
        inc     $E168
        .byte   $EE
        .byte   $F5
L480E:  ora     $5EB3
        bit     $82
        sed
        .byte   $92
        eor     ($44,x)
        stx     $54,y
        dec     $C31E
        .byte   $5C
        .byte   $D7
L481E:  .byte   $AF
        cli
        .byte   $3C
        ora     $9CF6
        plp
        brk
        .byte   $87
        bcc     L4881
        .byte   $31
L482A:  .byte   $96
L482B:  .byte   $32
        inc     $AE,x
        asl     L1DA3
        .byte   $93
        ora     $8F74
        .byte   $2F
        .byte   $67
L4837:  .byte   $C2
        lda     $F68D,x
        adc     $C831,y
        .byte   $6C
L483F:  .byte   $C7
        stx     $F0,y
        .byte   $E7
        beq     L48A9
        and     ($8D,x)
        .byte   $53
        bne     L480E
        sta     $2B,x
        .byte   $74
        .byte   $E3
        inc     $73
        rol     L26C1
        .byte   $4B
        inx
        cmp     $2A,x
        brk
        ora     $CA,x
        lda     L230C,y
        .byte   $1A
        dex
        .byte   $DF
        plp
        dec     $24,x
        sty     $48
        .byte   $D3
        ror     $B077,x
        cmp     ($31),y
        sec
        .byte   $CB
        sbc     #$EA
        ora     ($29,x)
        lda     #$D3
        sec
        .byte   $77
        .byte   $92
        nop
        tya
        .byte   $2F
        lda     $DE8C
        inc     $F4CD
        cld
        .byte   $31
L4881:  .byte   $80
        .byte   $C2
        .byte   $57
        tya
        ldx     $F762,y
        sta     $2D
        .byte   $9B
        .byte   $35
L488C:  sbc     ($1C),y
        cpy     #$DC
        .byte   $C7
        lda     ($A2,x)
        bit     $D6BC
L4896:  .byte   $0E
L4897:  cli
        .byte   $43
        .byte   $D3
        .byte   $37
        cpx     #$40
        .byte   $27
        .byte   $82
        sty     $98,x
        sty     $96
        sta     $28
        .byte   $44
        tax
        php
        .byte   $C3
L48A9:  rol     $ABB0,x
        sbc     #$E8
        tay
        lda     #$89
        .byte   $73
        .byte   $1C
        sta     ($49),y
        cpx     $DF
        rol     $3B
        .byte   $77
L48BA:  eor     L0A01
        ldy     $DE33,x
        brk
        .byte   $BB
        and     ($93),y
        .byte   $2D
        .byte   $3F
L48C6:  .byte   $8F
        .byte   $2F
        .byte   $04
        jsr     L3107
L48CC:  bne     L492A
        cpy     #$D8
        cmp     L2648,x
L48D3:  sty     $24,x
        lda     $8B
        lsr     a
        stx     L6F39
        .byte   $DF
        cmp     L5C26,x
        jmp     LE3BF

        .byte   $F7
        .byte   $74
        lsr     L20BF
        pha
        .byte   $C7
        .byte   $C2
        dec     $D3,x
        and     $DF,x
        rts

        lda     ($8C),y
        rol     $21
        jmp     LF0FB

        .byte   $CB
        .byte   $DE
L48F8:  inx
        txa
        sec
        .byte   $B3
        .byte   $8E
L48FD:  .byte   $44
        .byte   $0B
L48FF:  ldy     L46E2,x
        .byte   $B2
        .byte   $F9
        .byte   $9D
L4905:  eor     #$9C
        .byte   $82
        .byte   $B7
        .byte   $64
        .byte   $8B
        .byte   $A7
        .byte   $92
        .byte   $E7
        dec     $9660,x
        bit     L35DF
        .byte   $82
        rol     a
        ror     $CA
        .byte   $C3
L4919:  jsr     L974F
        ldy     #$BB
        .byte   $BF
        inc     $F237
        tsx
        .byte   $63
        and     $80
        ldx     $D278,y
        .byte   $50
L492A:  ldx     L3D59,y
        .byte   $EF
        .byte   $5B
        .byte   $83
        .byte   $3B
        .byte   $4F
L4932:  and     ($1A),y
        pla
        asl     $E23E
        .byte   $53
        ror     L4308,x
        .byte   $1F
        .byte   $14
        pla
        .byte   $E3
L4940:  ror     $C9,x
        .byte   $C3
        php
        tya
        jmp     (L192E)

        ldy     $26
        .byte   $0C
        .byte   $7C
        adc     $03B9
        ror     L5208,x
        sbc     #$60
        .byte   $DF
        ora     ($42,x)
        .byte   $FC
        and     $49,x
        .byte   $13
        brk
        .byte   $82
        bcc     L4905
        eor     ($7C,x)
        and     L114C,y
        .byte   $3A
        .byte   $02
        cpy     $AD
        lda     $B7F3,x
        cmp     #$A9
        .byte   $37
        .byte   $E4
L496F:  and     ($93),y
        .byte   $37
        sbc     $F4
        rol     $B8,x
        .byte   $32
        rol     L1E2A,x
        .byte   $34
        .byte   $CF
        .byte   $74
        .byte   $73
        adc     L0A80,x
        .byte   $F7
L4982:  .byte   $9C
        txa
        sta     $22
        .byte   $CF
        ror     $BEB0,x
        and     $79,x
        .byte   $52
        cmp     ($E3,x)
        .byte   $1A
        .byte   $1F
        .byte   $37
        .byte   $E2
        .byte   $63
        bit     L2228
        sed
        and     L4BE6,x
        ldx     #$83
L499D:  .byte   $33
        .byte   $02
        bvs     L496F
        and     #$4E
        .byte   $1B
        .byte   $BB
        .byte   $2F
        brk
        bne     L49B3
        asl     L3212
        .byte   $63
        ora     #$91
        sta     L12D3,y
        txa
L49B3:  jmp     L5B9D

        cmp     L7476
        rol     $79,x
        asl     L6279
        .byte   $5C
        .byte   $42
        sty     $A465
        .byte   $4B
        lda     ($A3),y
        .byte   $A7
        .byte   $13
        .byte   $B3
        .byte   $1C
        clc
        .byte   $83
        .byte   $42
        plp
        rol     $62
        cmp     $CB8E
        .byte   $AC
L49D4:  .byte   $E3
        .byte   $9F
        sta     $5C
        .byte   $CF
L49D9:  dex
        ldy     $0D
        .byte   $C2
        plp
        .byte   $6B
        iny
        .byte   $C7
        rol     $06
        .byte   $82
        plp
        sta     $48,x
        .byte   $97
        sty     $AF,x
        .byte   $63
        .byte   $3C
        adc     $8B,x
        jmp     (L7A4C)

        tay
        .byte   $4B
        sbc     #$82
        .byte   $39
L49F6:  sed
        asl     L53CB,x
        iny
        cpy     $D305
        clc
        .byte   $32
        .byte   $0B
        .byte   $D2
        beq     L4A31
        bmi     L4A71
        bcc     L4A3A
        .byte   $82
        lda     $F909,y
        asl     $CA92,x
        .byte   $83
        lsr     L3310,x
        rol     L8346,x
        ror     $F20D,x
        inc     $DC
        cmp     $EB28,y
        inc     $06
L4A20:  rol     L0C15
        .byte   $F3
        .byte   $DF
        and     $F6
        .byte   $22
        .byte   $7C
        dey
L4A2A:  .byte   $52
        .byte   $D4
        .byte   $5A
        sbc     L19E3,y
        .byte   $95
L4A31:  bit     L2E92
        .byte   $1A
        lda     ($4E,x)
        ora     $E652,x
L4A3A:  .byte   $CC
        .byte   $6C
L4A3C:  .byte   $E7
        .byte   $74
        .byte   $DF
        .byte   $99
        plp
L4A41:  ldy     L63D7,x
        .byte   $7A
        eor     ($2E,x)
        .byte   $2C
L4A48:  .byte   $E3
        beq     L4A69
        jmp     L3FFA

        ora     $03FC
        .byte   $B3
        ror     L396D,x
        .byte   $E3
        .byte   $97
        sty     $50
        .byte   $C7
        rol     L8382,x
        .byte   $E3
        asl     a
        adc     #$2D
        inc     $F137
        sta     L1A09,y
        tsx
        .byte   $A1
L4A69:  sbc     $A4
        .byte   $8B
        .byte   $C4
L4A6D:  stx     $3C2A
        .byte   $B9
L4A71:  .byte   $34
        .byte   $2B
        .byte   $47
        .byte   $A6
L4A75:  bmi     $4A28
        .byte   $9E
        asl     $40,x
        sty     $CC20
        ldx     $2D,y
        .byte   $DA
        .byte   $31
L4A81:  .byte   $C2
L4A82:  bit     $BC
        .byte   $72
        .byte   $8B
        sbc     $38
        and     ($AF),y
        cmp     ($BD,x)
        cpy     #$5A
        lsr     $E629,x
        ora     L2EE0,x
        lsr     $05CC,x
        .byte   $E2
        beq     L4AB7
        dec     L5E47,x
        eor     $BE66,y
        ora     $BC89,y
        .byte   $B7
        stx     $1A,y
        bpl     L4A3C
        .byte   $5C
        sbc     #$97
        adc     L5EC5
        .byte   $9B
        .byte   $F3
        .byte   $9B
        .byte   $CF
        ora     $0719,x
        plp
        .byte   $2C
L4AB7:  .byte   $62
        .byte   $5A
        .byte   $1B
        .byte   $5C
        .byte   $17
        tax
        adc     L81AF,y
        .byte   $02
        .byte   $72
        sbc     $7D,x
        .byte   $9C
        .byte   $3A
        sta     $CE
        .byte   $1B
        sbc     $7E
        asl     a
        lsr     $FC
        rol     $05
        .byte   $E7
        .byte   $1A
L4AD2:  .byte   $67
        .byte   $CB
        bpl     L4B2F
        ror     $B667
        asl     $8E
        sbc     L59A4,y
        .byte   $17
        .byte   $80
L4AE0:  bcc     L4B41
        .byte   $91
L4AE3:  .byte   $F4
        .byte   $54
        cmp     ($AF,x)
        and     $98,x
        .byte   $3B
        sta     (L0056),y
        .byte   $47
        sta     ($78,x)
        sta     L1977,y
        .byte   $F3
        .byte   $FF
        .byte   $02
        sty     $E9
        .byte   $7B
        sec
        .byte   $1B
        sbc     $BD07
        lda     L1CBE,x
        cmp     $86,x
        .byte   $3C
        .byte   $7A
        .byte   $1D
        .byte   $26
L4B06:  ora     ($A0),y
        dec     $6E
        .byte   $44
        asl     $39,x
        cmp     #$CB
        ora     ($26),y
        eor     $9CB6,x
        adc     $9C1D,y
        rol     L696D,x
        .byte   $8F
        ora     $D9
        stx     $9381
        cmp     ($74,x)
        .byte   $4F
        lsr     a
        cli
        .byte   $7C
L4B26:  pha
        iny
        .byte   $1C
        .byte   $39
L4B2A:  ora     $B903,y
        .byte   $9E
        .byte   $46
L4B2F:  .byte   $45
L4B30:  .byte   $F4
        .byte   $E2
L4B32:  tya
        adc     $D105,y
        and     $9E,x
        php
        ora     ($25),y
        cpy     #$CC
        .byte   $79
        .byte   $6D
L4B3F:  lda     ($9E,x)
L4B41:  .byte   $FC
        and     $04
L4B44:  sty     $DC
L4B46:  cmp     ($71,x)
        tay
        .byte   $6B
        .byte   $8B
        .byte   $04
        cpx     #$01
        .byte   $87
        adc     ($71),y
        .byte   $3A
        .byte   $63
        .byte   $E3
        cpy     $17
        .byte   $63
        sbc     ($DA,x)
        .byte   $0C
        asl     $A1
        adc     $C308,y
        .byte   $73
        .byte   $33
        rol     $A467
        .byte   $4B
        .byte   $E3
        adc     $F135
        lda     $E4,x
        .byte   $63
        .byte   $0C
        .byte   $FC
        .byte   $7B
        .byte   $63
        .byte   $5C
        plp
        cmp     L5F73
        bit     L25C8
        sbc     $35,x
        ldy     $C3
        sec
        .byte   $37
        .byte   $9E
        and     ($C4),y
        plp
        .byte   $95
L4B83:  tay
        .byte   $DF
        .byte   $C3
        .byte   $AF
        and     $E5,x
        ora     ($0A),y
        .byte   $03
        .byte   $04
        sta     L0979,y
        .byte   $C9
L4B91:  rti

        cpx     L2E25
        .byte   $9C
        and     $24,x
        .byte   $8B
        dex
        bne     L4B83
        ldy     $AB,x
        .byte   $A3
        pla
        .byte   $63
        cli
        bit     $9431
        .byte   $02
L4BA6:  eor     $A0
        .byte   $67
        rol     a
        inc     $64,x
        .byte   $07
        rol     $0B
        .byte   $0F
        ora     $C35D
        adc     L0B26,x
        .byte   $9F
        bmi     L4B46
        plp
        beq     L4BF9
L4BBC:  sta     $A273
        ldy     L098C
        eor     #$69
        .byte   $42
        .byte   $63
        dec     L17E1
        lda     #$14
        cli
        pha
        cpy     $28
        cmp     #$68
        cmp     $D3C8
        iny
        .byte   $D7
        pha
        .byte   $DA
        iny
        lsr     $57
        .byte   $47
        sei
        .byte   $47
        .byte   $9F
        .byte   $47
        .byte   $BF
        .byte   $47
L4BE2:  ora     $48
        .byte   $1F
        pha
L4BE6:  and     $48,x
        .byte   $57
        pha
        sta     $AB48,x
        pha
        .byte   $B3
        pha
        .byte   $BB
        pha
        dec     $7A,x
        lsr     $BB
        .byte   $92
        .byte   $0F
        .byte   $12
L4BF9:  .byte   $67
        .byte   $52
        adc     L75D2
        ldy     $92,x
        asl     $94
        .byte   $22
        sty     $6A,x
        sty     $D4,x
L4C07:  sta     $06,x
        .byte   $95
L4C0A:  .byte   $62
        sta     $AF,x
        .byte   $54
        ldy     $74
        .byte   $B7
        .byte   $14
        clv
        .byte   $44
L4C14:  .byte   $BB
        .byte   $04
        lda     $A54B,x
        .byte   $FA
        .byte   $A5
L4C1B:  sty     $3726
        ldx     L0060
        rol     $18
        ldx     $C8
        lda     ($36),y
        sbc     L4D37
        and     $69,x
        and     L39BD,y
        sbc     $3A,x
        and     $3A,x
        sta     ($3A,x)
L4C34:  lda     L113B,x
        .byte   $3B
        sbc     $39,x
        sta     $3C
        .byte   $44
        ror     a
L4C3E:  .byte   $0C
        dex
        .byte   $0F
        rol     a
        .byte   $14
        dex
        .byte   $1A
        dex
        ora     #$2A
        and     L3A0A,y
        dex
        and     L2BCA,x
        asl     a
        .byte   $4B
        rol     a
        bvc     L4C3E
        .byte   $57
        txa
        .byte   $5A
        ror     a
        .byte   $5C
        txa
        .byte   $42
        .byte   $DA
        .byte   $53
        bit     L8053
        .byte   $53
        .byte   $9D
L4C62:  .byte   $53
        .byte   $D7
        txs
        tya
        .byte   $C2
        lda     ($7A,x)
        .byte   $A3
L4C6A:  .byte   $02
        lda     $22
        ldx     $B1
        .byte   $55
L4C70:  bpl     L4C07
        .byte   $63
        sta     $6B,x
        ora     $6F,x
        eor     $75,x
        clc
        .byte   $AB
        clv
        .byte   $AB
        cpx     #$AA
        php
        ldy     $AC26
        .byte   $3C
        ldy     $AC58
        .byte   $74
        ldy     $AD88
        rol     a
        adc     $6C,x
        sta     $6F
        cmp     $61
        sbc     $73,x
        eor     $74
        lda     $79,x
        .byte   $04
        .byte   $2B
        bne     L4CC7
        .byte   $DF
        .byte   $AB
        sbc     ($2B),y
        .byte   $FD
        .byte   $2B
L4CA2:  dey
        adc     (L0060),y
        .byte   $3F
        .byte   $E3
        dec     $32,x
        stx     $39,y
        lsr     $3D,x
L4CAD:  stx     $05,y
        .byte   $82
        .byte   $B2
        rol     a
        .byte   $B2
        ror     $CAB2,x
        .byte   $B3
L4CB7:  rol     $B3,x
        .byte   $AF
        eor     $97
        .byte   $15
L4CBD:  tay
        ora     $A1,x
        cmp     $B2
        cmp     $B8
        sbc     $BB
        .byte   $C5
L4CC7:  .byte   $B3
        .byte   $D5
L4CC9:  iny
        ora     $CD,x
        eor     $AE,x
        .byte   $24
L4CCF:  ldx     $AEB4
        beq     L4D02
        .byte   $82
        .byte   $2F
        ora     $AF,x
        rol     a
        .byte   $2F
        pha
        ora     L697B
        .byte   $7B
        adc     $AD79,x
        ror     L7E09,x
        sta     $F57E
        .byte   $7C
L4CE9:  rti

        jmp     L2C08

        .byte   $0F
        .byte   $0C
        .byte   $14
        bit     $CC1F
        asl     L334C
        .byte   $0C
        .byte   $37
        .byte   $6C
        .byte   $3A
L4CFA:  .byte   $2C
        .byte   $3A
L4CFC:  cpx     L6C3B
        .byte   $3C
L4D00:  .byte   $04
L4D01:  .byte   $FA
L4D02:  .byte   $57
        cmp     $FA84,x
        .byte   $44
        .byte   $5F
        bit     $EC3F
        .byte   $22
        .byte   $39
L4D0D:  .byte   $62
        lda     #$62
        bpl     L4D4D
        ora     L1D1B,x
        .byte   $EB
        ora     L1EFB,x
        .byte   $13
        asl     L1E33,x
        .byte   $D3
        .byte   $1F
        .byte   $63
        .byte   $1A
        .byte   $23
        .byte   $23
        .byte   $03
L4D24:  .byte   $23
        .byte   $A3
        bit     $CB
        and     $8B
        rol     $6B
        jsr     L9982
        .byte   $44
        cli
L4D31:  .byte   $CB
        .byte   $34
        .byte   $CB
        bvc     L4D01
        .byte   $7A
L4D37:  .byte   $CB
        inc     $CA
        iny
        cpy     $CE9E
        ldx     L26CF,y
        .byte   $CF
        .byte   $5A
        .byte   $CF
        .byte   $92
L4D45:  .byte   $CF
        dec     $CE,x
        and     ($E6,x)
        .byte   $87
        dec     $8C,x
L4D4D:  ldx     $84,y
        ror     $99
        rol     $9A,x
        inc     $9C
        ldx     $91,y
        asl     L27B5
        lda     $43,x
        and     $54,x
        lda     $74,x
        lda     $2E,x
        and     $C0,x
        and     $D1,x
        lda     $E1,x
        lda     $F4,x
L4D6A:  lda     $88,x
        and     ($B0),y
        .byte   $46
L4D6F:  sta     $ED89
        sty     L8EED
        sta     $AD93
        tya
        .byte   $4D
L4D7A:  tya
        sta     $AD9C
        sta     $B28D
        and     L4DBA
        ldx     #$0F
        ror     L6E5E
        bvs     L4DF9
        .byte   $80
        ror     L6EC3
        .byte   $F7
        ror     $AB16
        adc     L7A3B,y
        .byte   $C3
        .byte   $7C
        .byte   $F3
L4D99:  .byte   $7A
        .byte   $AB
        sta     $63
        sta     ($E3,x)
        .byte   $8B
        .byte   $13
        .byte   $8F
        .byte   $9F
        .byte   $8B
        .byte   $53
        .byte   $DF
        rol     a
        sty     $BF
        ror     $A708,x
        jsr     L9FBF
        sta     $2D,x
        .byte   $F4
        .byte   $74
        .byte   $73
        .byte   $5B
        .byte   $9C
        ldx     $B3
        .byte   $DE
        .byte   $5D
L4DBA:  lsr     $ADF6,x
        .byte   $C7
        .byte   $9F
        ror     L5703,x
        rol     $9E28,x
        txa
        ldy     $4A
        inc     $2F
        cmp     #$90
        .byte   $27
        asl     a
        .byte   $73
        .byte   $4F
        eor     #$19
        .byte   $43
        .byte   $0F
        .byte   $89
        .byte   $22
        adc     ($90,x)
        .byte   $C7
        ora     L62E2,x
        .byte   $74
        .byte   $BF
        and     $AEF8,y
        .byte   $B3
        .byte   $9F
        .byte   $B7
        ldy     $C6D7
        cmp     $AA
        and     $DF7C,y
        .byte   $A3
        eor     #$A0
        ldx     $30
        bcc     L4E2C
        inc     $53,x
        .byte   $2B
L4DF6:  .byte   $9C
        .byte   $D7
        .byte   $12
L4DF9:  .byte   $F2
L4DFA:  .byte   $E7
        .byte   $64
        .byte   $DF
L4DFD:  .byte   $3F
        .byte   $63
        .byte   $8F
L4E00:  .byte   $1C
        cli
        .byte   $D3
        eor     $D3
        asl     L803D,x
        sbc     ($37,x)
        .byte   $F2
        bvc     L4D99
        rol     L2203
        .byte   $44
        .byte   $32
        cpx     $0D
        .byte   $63
        inx
        ldx     L78E3
        sta     $8F37,y
        .byte   $92
        and     ($15),y
        .byte   $5C
        .byte   $DB
        .byte   $5C
        .byte   $E0
L4E23:  .byte   $DC
        .byte   $E3
        .byte   $DC
        cpx     $1C
        .byte   $E7
        .byte   $5C
        nop
        .byte   $5C
L4E2C:  cpx     $F15C
        .byte   $9C
        sbc     $1C,x
        inc     $DC,x
        .byte   $FA
        .byte   $5C
        .byte   $FC
        .byte   $DC
        cmp     $84
        inx
        jmp     L76E8

        inx
L4E3F:  txs
        sbc     #$BE
        rol     $C67B,x
        inc     $DC
        .byte   $CB
        pla
        sta     L528D,y
        .byte   $8B
        .byte   $6F
        .byte   $72
        adc     L7C9A,y
        .byte   $62
        sta     ($90),y
        .byte   $9C
        eor     L6272,y
        .byte   $43
        .byte   $72
        ror     $93
        .byte   $74
        .byte   $4B
        lsr     L7F51,x
        lsr     $99CE,x
        ror     $A3
        .byte   $AB
        .byte   $79
L4E69:  inc     $69
        .byte   $87
        php
        ldx     $E7,y
        .byte   $D2
        sbc     L4CB7,y
        sbc     #$8B
        eor     #$9E
        .byte   $D1
L4E78:  rol     a
        .byte   $8B
L4E7A:  .byte   $43
        .byte   $14
        .byte   $9B
        .byte   $53
        .byte   $B3
        .byte   $34
        pla
        .byte   $80
        eor     L8609,y
        cmp     $79
        rol     L00F9
        .byte   $C7
        and     L68F7,x
        ldx     $59
L4E8F:  ror     $F8,x
        sta     $96,x
        sbc     $D907,y
        .byte   $14
        ora     #$04
        beq     L4E7A
        lsr     $98
        adc     #$76
        adc     ($0B),y
        rol     $84
        cmp     #$15
        .byte   $89
        .byte   $A7
        .byte   $A7
        lsr     L3469
L4EAB:  .byte   $89
        .byte   $27
L4EAD:  .byte   $45
L4EAE:  .byte   $34
        lda     #$B6
        dec     $31
        adc     L3255,x
        cpy     $B8
        eor     L35AB
        .byte   $6B
        adc     L31D6,x
        pha
        eor     L27AD,x
        .byte   $12
        lda     $92
        .byte   $5C
        ora     $72,x
        nop
        sed
L4ECB:  adc     #$4D
        .byte   $A4
L4ECE:  and     #$BC
        cmp     L4DF6
        dex
        and     ($A5),y
        ror     $79
        .byte   $F7
        ldx     $96
        adc     L850F,x
        .byte   $2C
        .byte   $E3
L4EE0:  cpy     $1D81
        .byte   $A9
L4EE4:  sbc     ($53),y
        jmp     (LEB3B)

        asl     a
        dec     L3B4D
        inc     $2D,x
        .byte   $44
        ror     a
        lsr     $06,x
        .byte   $F3
        sta     ($3C),y
        .byte   $92
        rol     $9B
        .byte   $77
        adc     $CB73
        .byte   $1D
L4EFE:  brk
        .byte   $04
        .byte   $DB
        asl     $E1,x
        ldx     L0E0C,y
        .byte   $F2
        ror     L51E8
        jmp     (LFA82)

        .byte   $B3
        .byte   $74
        .byte   $B2
        .byte   $C2
        .byte   $F7
L4F12:  ror     $A278
        .byte   $19
L4F16:  asl     $611A,x
        .byte   $5B
        .byte   $03
        and     $D4,x
L4F1D:  lda     #$98
        cmp     $DD9F,y
        ora     ($35),y
        beq     L4F85
        .byte   $22
        inc     $F7E0
        and     $3C
        .byte   $9F
        .byte   $0B
        jsr     LD6FF
        sbc     $F4D5,y
        .byte   $4B
        .byte   $64
        .byte   $2B
        .byte   $BB
        .byte   $CB
        .byte   $5C
        bcs     L4EFE
        stx     $0E,y
        .byte   $BB
        eor     #$29
        .byte   $1C
        .byte   $EB
        sta     $DF,x
        .byte   $5B
        .byte   $EC
        .byte   $D9
L4F48:  ldx     $88,y
        .byte   $1A
        sbc     $961E
        .byte   $9E
        .byte   $63
        stx     L00F9
        stx     $1E,y
        .byte   $F7
        sec
        .byte   $D4
        .byte   $02
L4F58:  adc     $A6E1,x
        .byte   $D1
L4F5C:  and     $BAE0,y
        .byte   $AB
        and     $2C
        .byte   $1A
        dec     $96,x
        .byte   $3F
L4F66:  sta     $9197,x
        eor     $E9F1,x
        .byte   $3B
        .byte   $9E
        .byte   $B7
        cpx     $63
        sbc     L5293
        stx     $39,y
        cld
        bcs     L4F48
        .byte   $3C
        .byte   $1F
        .byte   $C7
        beq     L4F16
        inx
        bcs     L4F58
        .byte   $27
        jsr     LDB28
L4F85:  jsr     LF2CA
        .byte   $DA
L4F89:  bne     L4F58
        .byte   $22
        .byte   $C3
        bit     L85D7
        .byte   $3C
        sed
        asl     $A9F2,x
        sec
        .byte   $EB
        .byte   $1F
        .byte   $80
        .byte   $B3
        .byte   $4B
        cpx     L678C
        .byte   $5C
        .byte   $F0
L4FA0:  eor     ($2D),y
        .byte   $72
        adc     ($F8,x)
        .byte   $93
        .byte   $DC
        lsr     $19,x
        cpy     $E3
        .byte   $3B
        .byte   $93
        ldy     $BE,x
        lda     $95A4,y
L4FB2:  .byte   $9C
        eor     L45A6,y
        dec     $B1,x
        eor     ($AE,x)
        .byte   $42
        ora     $BDC3,y
        sta     L1DCA,y
        ldx     $26
        ldy     $96
        .byte   $5D
L4FC6:  ora     $7597,y
        ldx     $1FDD,y
        ldx     $4584
        cmp     ($39),y
        .byte   $A7
        ldy     $B9
        .byte   $22
        .byte   $79
L4FD6:  ldx     $3C
        dey
        .byte   $AF
        bvs     L4F66
        .byte   $2B
        sta     L6672
L4FE0:  .byte   $4B
L4FE1:  and     $9198,x
        .byte   $6C
        .byte   $4F
L4FE6:  .byte   $72
L4FE7:  .byte   $4B
        lsr     $D06C,x
        sed
L4FEC:  pla
        .byte   $74
        lda     ($B9,x)
        .byte   $4E
        .byte   $75
L4FF2:  eor     #$36
        .byte   $83
        lda     L507B,x
        lda     L231D,y
        .byte   $57
        tya
        ldy     $5D
        .byte   $A2
L5000:  eor     $669A,x
        .byte   $12
L5004:  sta     L11E7,x
        .byte   $27
        .byte   $97
        .byte   $73
        .byte   $52
        .byte   $64
        ora     ($DD),y
        tya
        and     $B1,x
        rts

        sta     L0D7B,x
        cmp     ($DA),y
        .byte   $74
        .byte   $3F
        .byte   $32
        jsr     L1735
L501D:  .byte   $D5
L501E:  .byte   $89
        ror     L5896
        cmp     $36
        lda     $8E,x
        bcc     L4FEC
        tya
L5029:  bvs     L4FC6
        sta     L4A20
        sta     $49,x
        dex
L5031:  .byte   $7B
        sta     L4896,y
        asl     $14,x
        eor     ($C3),y
        rol     L4A6D,x
        ror     $EE69
        .byte   $5C
        sta     ($4D),y
        cmp     L5B78,y
        tya
        sta     ($16),y
        ldx     $8C
        adc     $59,x
        bit     L37CB
        ora     $36,x
        sbc     $14
L5053:  dex
        cmp     $8A
        sbc     L0DF2
        bpl     L5029
        cli
        bmi     L4FE0
        cmp     $DB12
        bit     $D9E8
        and     $D224
        sbc     L8136
        jsr     LC2BE
        inx
        and     L1B3B,y
        .byte   $80
        ror     L3C99
        sbc     L5A0C
        cpx     #$26
        .byte   $DE
L507B:  sbc     $D19B
        sta     $B853
        dex
        ror     $D926,x
        bmi     L501E
        .byte   $CB
        ldx     #$87
        sty     $AE,x
        .byte   $0F
        .byte   $93
        ora     ($4D),y
        .byte   $AB
        .byte   $33
        .byte   $CF
        .byte   $F2
        ldy     L34F5,x
        ldx     $9BF0,y
        ora     $C89C,y
        stx     L6E11
        eor     ($F2),y
        ora     #$F2
        .byte   $73
        clc
        .byte   $8B
        .byte   $AF
        bvc     L5031
        eor     $B630,y
        dec     $E242,x
        ror     $BE,x
        asl     $F264,x
        ldy     #$C5
        .byte   $6B
        .byte   $5B
        sbc     $4C,x
        clv
        .byte   $7C
        stx     $D2
        .byte   $14
        .byte   $F2
        .byte   $D3
        .byte   $C7
        .byte   $4B
        .byte   $AF
        .byte   $27
        lsr     a
        .byte   $8B
        .byte   $E3
        .byte   $74
        lsr     $E605,x
        lda     $5C
        .byte   $6B
        lda     L4793,y
        .byte   $03
        clv
        .byte   $82
        cld
        .byte   $E3
        .byte   $64
        .byte   $D3
        ora     $12,x
        sbc     $26
        cmp     $9B0B,y
        sed
        cpy     $82
        .byte   $9B
        .byte   $C3
        .byte   $3A
        .byte   $5F
        and     ($36),y
        cpx     $C5
        .byte   $22
        lda     $F73C,y
        dec     $1B,x
L50F2:  asl     L7584,x
        .byte   $FB
        bvs     L512D
        .byte   $82
        stx     $BD3D
        bcs     L5141
        .byte   $CF
        sta     ($F1),y
        .byte   $BC
L5102:  cpx     $E2
        ldx     #$E5
        .byte   $13
        .byte   $D1
L5108:  sec
        sta     ($24),y
        .byte   $0F
        .byte   $13
        adc     $CDD2
        .byte   $E2
L5111:  .byte   $EF
        pla
        cpy     L7AAE
        sty     $57,x
        .byte   $32
        and     ($39),y
L511B:  cmp     #$05
        .byte   $3F
        .byte   $33
        .byte   $7C
        eor     $C90A,x
        asl     $B802
        cmp     ($92),y
        ror     a
        .byte   $9B
        lsr     $CF,x
        .byte   $0C
L512D:  .byte   $D7
        ldy     $E335
        adc     #$BA
        adc     ($A8),y
        cpy     L00F9
        sbc     ($B9,x)
        .byte   $1C
        adc     #$AF
        lda     L8E80
        lsr     $FC,x
L5141:  .byte   $62
        .byte   $8F
        eor     $6D
        asl     $71
        .byte   $89
        txa
        .byte   $32
        beq     L5111
        lda     ($6A),y
        .byte   $75
L514F:  .byte   $E7
        .byte   $1A
        .byte   $17
        ora     ($EE,x)
        .byte   $5F
L5155:  ldx     $D9
        ldx     $A7,y
        jmp     (LD7A2)

        jmp     L436A

        .byte   $14
        .byte   $67
        asl     $52,x
        .byte   $DC
        cmp     $DB
        .byte   $DC
        .byte   $7B
        .byte   $73
        .byte   $89
        .byte   $C4
L516B:  sty     $EC
        .byte   $B3
L516E:  .byte   $62
        .byte   $AB
        .byte   $FF
        jmp     (L5ED3)

        lsr     $90AB
        ldx     #$4E
        rol     $76,x
        .byte   $FA
        .byte   $CE
L517D:  .byte   $34
        lda     $6B,x
        .byte   $7D
L5181:  asl     $71
        .byte   $AF
        ldy     $9BCD,x
        lsr     $DAE5,x
        .byte   $83
        sty     $95,x
        .byte   $5A
        .byte   $33
        ora     ($6F),y
        .byte   $1A
        .byte   $E5
L5193:  .byte   $5B
        rol     $DC
L5196:  .byte   $4F
L5197:  cmp     $24,x
        sbc     $D1,x
        bit     $0C
        cmp     L24CB,x
        cpx     $DA
        ldx     $E0,y
        nop
        .byte   $DA
        cpx     #$E5
        dec     $B6
        asl     $AAAE
        .byte   $47
        .byte   $B2
        .byte   $3A
        lsr     $4D
        rol     $05,x
        bmi     L5197
        lda     ($A7,x)
        plp
        cpy     $9E
        .byte   $4F
        .byte   $72
        asl     L295E,x
        eor     $AF
        .byte   $6B
        sta     L24DE,y
        .byte   $E3
        sty     L408C
        .byte   $7A
        .byte   $C2
        inc     $D7
        cmp     $29,x
        clv
        lda     #$36
        iny
        ldy     L4A75,x
        sbc     ($84),y
        sed
        .byte   $C2
        .byte   $87
        .byte   $04
        .byte   $F7
        .byte   $1C
        bit     L698B
        adc     L756E,x
        cmp     #$E3
        .byte   $57
L51E8:  and     $C76F,x
        ldx     $35,y
        bit     $B9
        .byte   $3B
        .byte   $12
        cmp     $F1
        ldx     #$F7
        clc
        ldy     $B3
        jsr     L95FB
        clc
        .byte   $DB
        clc
        ldy     $94E9,x
        .byte   $7C
        eor     L325D,y
        cmp     #$B8
        .byte   $B4
L5208:  .byte   $97
        ldx     L39A5,y
        ror     $14
        .byte   $F3
        .byte   $44
        .byte   $92
        .byte   $73
        .byte   $BB
        .byte   $92
        inc     $DAB7
        .byte   $63
        eor     $B9,x
        .byte   $7A
        cmp     L0DB3,y
        cmp     $C01D,x
        sbc     $F7
        tya
        .byte   $1F
        inc     $27
        ldx     $33
        .byte   $0D
L522A:  lda     L6D6D,x
        .byte   $7F
        ora     $DBEE
        ldx     $DA
L5233:  .byte   $D4
        cmp     ($7B),y
        sty     $89
        and     ($B9,x)
        .byte   $2F
        .byte   $0C
        lda     L5F05,y
        .byte   $83
        and     $9AA1
        and     $DB
        .byte   $C3
        rti

        ror     $19
L5249:  .byte   $A3
        .byte   $34
        .byte   $1C
        bvs     L5249
        .byte   $C3
        sbc     ($6E,x)
        adc     $C56B
        .byte   $E7
        .byte   $53
        cpy     $E5
        rol     $CB12
        inc     $DC
        .byte   $97
        brk
        .byte   $67
        .byte   $9F
        .byte   $53
        .byte   $E2
        lsr     a
        .byte   $03
        .byte   $A7
        .byte   $93
        sbc     $CE,x
L5269:  .byte   $CB
        asl     $E5DA,x
        .byte   $DC
        .byte   $24
L526F:  .byte   $F2
        .byte   $03
        lda     L4FD6,x
        .byte   $4B
        .byte   $F2
        sta     ($DB),y
        .byte   $CF
        sei
        bcc     L5269
        asl     $B05C
        inc     $ADF2
        .byte   $52
L5283:  bit     $9A2C
        .byte   $D3
        .byte   $7A
        .byte   $3C
        tsx
        .byte   $1F
        .byte   $8F
        .byte   $8B
L528D:  .byte   $CB
        .byte   $AB
        cpx     $6E
        .byte   $4D
        .byte   $21
L5293:  .byte   $7C
L5294:  sta     L59CD
        .byte   $B3
        .byte   $23
        .byte   $97
        .byte   $FB
        .byte   $12
        .byte   $89
L529D:  asl     $86
        .byte   $E7
        .byte   $C3
        dec     $FC,x
        .byte   $5C
        adc     L7261,y
        adc     #$0C
L52A9:  cpy     #$9C
        bne     L531E
        .byte   $F2
        cld
        sbc     $94,x
        ldy     #$44
        lda     $A7C9,y
        .byte   $CE
        .byte   $74
L52B8:  .byte   $43
        .byte   $37
        cmp     $43
        lsr     L6B73
        adc     L215C,x
        .byte   $37
        cpx     $D9
        .byte   $97
        .byte   $52
        .byte   $8D
L52C8:  adc     ($74,x)
        sta     $4A,x
        .byte   $8B
        adc     ($72),y
        sbc     ($DB,x)
        .byte   $3A
        eor     $9F26,y
        adc     $BEF1,y
        cpy     L56E2
        adc     $ED30,y
        .byte   $54
        .byte   $D4
        .byte   $32
        ldx     $6F,y
        sta     ($ED,x)
        .byte   $74
        lda     ($BB,x)
        tya
        .byte   $AB
        lsr     $BB
        cpy     $CD
        .byte   $2F
        .byte   $3A
        .byte   $82
        cpy     $A849
        ldx     $CBCB,y
        and     ($B5,x)
        .byte   $4B
        and     $B13A,y
        pha
        tax
        sty     $B649
L5302:  ora     L6674,x
        cld
        tax
        sbc     $DA24,y
        eor     ($2C,x)
        .byte   $BF
        .byte   $3C
        .byte   $FF
        bit     $94
        and     L5DA0,x
L5314:  .byte   $FB
        .byte   $37
        .byte   $7A
        .byte   $F4
        inc     L25A9
        .byte   $92
        .byte   $43
        .byte   $D3
L531E:  cli
        .byte   $0B
        .byte   $7F
        asl     $A3,x
        rts

        .byte   $62
        rts

        .byte   $E2
        .byte   $34
        .byte   $83
        .byte   $EF
        .byte   $8F
L532B:  bvs     L5363
        .byte   $1F
        .byte   $AF
        clv
L5330:  .byte   $67
        ldy     L227B
        .byte   $2B
        .byte   $73
L5336:  .byte   $44
        .byte   $E3
        .byte   $54
        ror     a
        .byte   $B7
        .byte   $35
L533C:  .byte   $44
        .byte   $23
        .byte   $22
        .byte   $64
        .byte   $DC
        .byte   $FB
        .byte   $12
        cpx     #$91
        sta     $E729
        .byte   $DF
        lda     ($97),y
        sbc     ($A1,x)
        sta     L623C,y
        .byte   $7F
        and     #$97
        .byte   $F3
        .byte   $6B
        .byte   $FB
        .byte   $47
        adc     $05,x
        sta     L7E77,y
L535C:  and     $18,x
        tsx
        .byte   $57
        .byte   $89
        .byte   $02
        .byte   $0C
L5363:  dec     $32,x
        .byte   $DA
        and     $01
        ora     ($01),y
        .byte   $45
L536B:  sbc     #$36
L536D:  lsr     a
        adc     #$24
        cmp     #$73
        .byte   $B2
        .byte   $B3
        clc
        sta     $FF62,x
        dec     $FA,x
        .byte   $F4
        jmp     LABB1

        tya
        .byte   $9B
        jmp     (L89E6)

        inc     $44
        bvs     L533C
L5387:  .byte   $EB
        ror     $E9
        .byte   $32
        .byte   $DB
        .byte   $3C
        ldy     $ED
        clc
        .byte   $23
        lsr     $C286,x
        .byte   $54
        asl     $FD,x
L5397:  .byte   $F2
        .byte   $62
        .byte   $3A
        and     #$3B
        .byte   $7C
        bmi     L53BC
        inc     $5A
        .byte   $63
        ora     L11C9,x
        rol     $DB
        sta     $E2
        stx     $DB
        lda     L29F7
        .byte   $37
        eor     #$36
        clc
        cmp     $26,x
        inc     $3F
        .byte   $39
        .byte   $FD
L53B8:  nop
L53B9:  dec     $F379,x
L53BC:  .byte   $89
        .byte   $B7
        cld
        ldx     $51
        asl     $9D
L53C3:  .byte   $6F
        .byte   $DC
        sbc     $F1
L53C7:  sbc     ($D5),y
        adc     ($AC,x)
L53CB:  .byte   $83
        .byte   $DC
        .byte   $E2
        sta     ($0B,x)
        jmp     L8AE3

        .byte   $C2
        ldx     $74,y
        .byte   $1F
L53D7:  tax
        .byte   $0C
        ldx     $BB
        .byte   $82
        lsr     $B8
        eor     L45F6
        sei
        adc     #$61
        dec     $B7,x
L53E6:  .byte   $C2
        rol     $57
        ldx     $26
        txs
        .byte   $23
        and     $D0,x
        lsr     $6B,x
        .byte   $C2
        .byte   $E3
        sty     L3AD4
        cpx     $F6
        lda     L5A5C,y
        .byte   $D7
        .byte   $9B
        .byte   $A7
        bpl     L53B9
        stx     $47,y
        beq     L543A
        sbc     L701F,y
        .byte   $89
        sta     $29,x
L540A:  cmp     #$23
        and     ($9C),y
        .byte   $80
        .byte   $9B
        bvc     L542C
        .byte   $32
        .byte   $22
        rol     L3540,x
        dec     $BB35
        dec     $06
        .byte   $B3
        .byte   $93
        .byte   $43
        inc     $F2,x
        .byte   $04
        cmp     L7A20,y
        .byte   $07
        .byte   $AF
        .byte   $43
        .byte   $14
        .byte   $9B
        clv
        .byte   $6D
L542C:  clv
        .byte   $6F
        cpy     L3236
        rol     $CFCE,x
        .byte   $0B
        .byte   $A3
        .byte   $17
        eor     L229C,y
L543A:  .byte   $D4
        .byte   $B2
L543C:  .byte   $77
        and     L5748,y
        tya
        eor     L1BE7,x
        .byte   $13
        .byte   $D4
        .byte   $93
        .byte   $D7
        sed
        sta     $B0
        .byte   $5C
        .byte   $E6
L544D:  and     #$9E
        .byte   $D7
        .byte   $A4
L5451:  stx     $DB
        cmp     $A6DA
        .byte   $DA
        .byte   $FC
        .byte   $E7
        .byte   $5A
        and     L41BE,x
L545D:  .byte   $F2
        and     $02
        pla
        .byte   $E7
        sta     $91,x
        .byte   $DA
        eor     #$DE
        and     $BF
        .byte   $3A
        ora     L72A6,y
        .byte   $7C
        cmp     L8AA1
        eor     #$C6
        .byte   $5F
        sta     $DB91,x
L5477:  txs
        .byte   $CE
L5479:  .byte   $22
        .byte   $9C
        .byte   $A7
        .byte   $1B
        .byte   $E7
        ora     $D8F9,y
        sta     $D7C1
        php
        cmp     $DC
        .byte   $7B
        lsr     L1327,x
        rol     $F3
        .byte   $D6
L548E:  bit     $1B
        lda     L723E,y
        sbc     #$6B
        txs
        ora     L708A,y
        eor     $C1,x
        sta     $CD6F,x
        and     ($48),y
        sta     $A1EB,x
        .byte   $C9
L54A4:  .byte   $9B
        bmi     L5479
        sta     $B2E7
        .byte   $2F
        cmp     $E0
        lda     #$69
        lsr     $E6
        bvs     L5477
        and     ($9B,x)
        lda     $F7A9,y
        .byte   $07
        .byte   $BB
        sbc     #$38
        .byte   $BF
        .byte   $22
        sta     $D96F
        sta     $B6
        ldx     L24B8,y
        .byte   $37
        .byte   $92
        ldx     $91F8,y
        .byte   $DC
L54CC:  .byte   $F4
L54CD:  .byte   $2F
        rol     $3A,x
        cmp     #$4D
        and     $C9B8
        .byte   $14
        sec
        .byte   $4B
        and     $AD70
        cmp     L1CC4,x
        .byte   $63
        ldy     $B65B,x
        lsr     $E0A2
        .byte   $87
        cmp     $77
        rol     $8FD5
        .byte   $1C
        .byte   $CF
        lda     #$93
        .byte   $0B
        .byte   $7B
        .byte   $89
        .byte   $2B
        .byte   $14
        ror     $6B
        .byte   $5B
        .byte   $BB
        clv
        .byte   $72
        and     $BEB9
        .byte   $73
        ora     L637E,x
        .byte   $E7
        clv
        .byte   $3C
        .byte   $7C
        cmp     ($D5),y
        .byte   $3A
        adc     L207F,y
        ora     $3D
L550D:  eor     L7FB6
        .byte   $EB
        ror     L796D,x
        .byte   $92
        .byte   $2F
        eor     $0C,x
        .byte   $F7
        iny
        .byte   $B7
        .byte   $16
L551C:  .byte   $2B
L551D:  sbc     $E39A
        .byte   $6B
        .byte   $42
        .byte   $D4
        sbc     L093D,y
        .byte   $DA
        lsr     $5A
        .byte   $52
        sbc     $C79E,x
        cmp     #$6C
        .byte   $A3
        cpx     $F1
        .byte   $9E
        .byte   $E2
        rol     a
        adc     $98EF,y
        .byte   $DB
        sbc     L109B
        lsr     $B772,x
        bvc     L54CD
        .byte   $97
        rol     $3F,x
        .byte   $8B
        .byte   $3A
        .byte   $AF
        ror     a
        dec     $FC,x
        dec     L19BA
        ror     $DB
L554F:  .byte   $91
L5550:  .byte   $E7
        bvs     L5550
        inc     L65C5
L5556:  dec     $C9
        sta     $2F
        sta     $99F8
        adc     $78
        .byte   $C2
        sei
        .byte   $B7
        .byte   $2B
        .byte   $43
        adc     #$76
        inc     L1564,x
        ldx     $61,y
        cmp     $9A
        and     $AAC0
        and     $47,x
        ora     L2519
        .byte   $97
        .byte   $DC
        .byte   $67
        .byte   $A3
        .byte   $D2
        .byte   $E2
        .byte   $DC
        .byte   $F4
        rol     $D7F2,x
        rol     $E9,x
        clc
        .byte   $D2
        .byte   $EF
        .byte   $2F
        and     $CF1F
        clc
        .byte   $0F
        .byte   $44
        .byte   $89
        cmp     $7F
        .byte   $C2
        .byte   $3A
        .byte   $42
        tsx
        .byte   $43
        .byte   $3A
        .byte   $43
        tsx
        .byte   $44
        .byte   $3A
        .byte   $44
        tsx
        eor     $3A
L559D:  eor     $86
        .byte   $FB
        ldy     $6B
        ldy     $73
        ldx     $83
        ldy     #$85
        sta     $9D50,x
        .byte   $5F
        ora     L5D6C,x
        .byte   $74
        eor     L1A44,x
        cpx     $ED92
        rol     $FEED,x
        cpx     L2722
        .byte   $77
        .byte   $F7
        .byte   $7A
        .byte   $C7
        adc     L7F37,x
        .byte   $A7
        adc     ($6C),y
        .byte   $3C
        .byte   $1F
        ldy     $BC31,x
        rti

        ldy     $BC58,x
        .byte   $6B
        sta     $E0
        adc     ($E5,x)
        .byte   $79
L55D5:  inc     $19
        inc     L00F9
        cpx     $09
        inx
        cmp     $B1E9,x
        nop
        sta     $EB
        .byte   $5A
        .byte   $2F
        rti

        .byte   $4F
        ror     $8F
        jmp     (L758F)

        .byte   $EF
        .byte   $7A
        cpx     L227B
        .byte   $7C
        eor     L837C,y
        .byte   $7C
        ldy     $7C,x
        cmp     $4B,x
        sbc     ($D3,x)
L55FB:  .byte   $EB
        .byte   $0B
        .byte   $EB
        .byte   $13
        .byte   $EB
L5600:  .byte   $1B
        .byte   $EB
        .byte   $23
        cpx     L80F8
        .byte   $83
        brk
        .byte   $C2
        .byte   $FF
        cmp     ($02,x)
        .byte   $BF
        cpy     #$42
        .byte   $80
        .byte   $83
        .byte   $63
        cpx     L0830
        .byte   $82
        rol     a:$C8,x
        .byte   $C3
L561A:  .byte   $E3
        clv
        sec
        .byte   $0C
        .byte   $42
        rol     $C1C3,x
        cpy     $7F
        .byte   $C2
        .byte   $04
        brk
        cmp     $40
        sty     $A3
        tay
        .byte   $44
        .byte   $0C
        lsr     $E33E
        cld
        bvc     L5646
        .byte   $8F
L5635:  pha
        inc     $04,x
        ora     ($02),y
        .byte   $A3
        cpy     $64
L563D:  php
        sei
        .byte   $0C
        sei
L5641:  .byte   $12
        sty     L70D1
        .byte   $21
L5646:  ldy     #$31
        .byte   $B0
L5649:  eor     ($E8,x)
        .byte   $F7
        .byte   $1C
        bcs     L563D
        .byte   $1B
        .byte   $8F
        adc     ($A0),y
        and     ($6A,x)
        and     $AAC7,x
        sbc     $19
        .byte   $B2
        .byte   $F7
        asl     $94A3,x
        rts

        bpl     L56C0
        and     L40C7,x
        stx     $2C
        .byte   $BB
        dey
        rti

        .byte   $87
        brk
        iny
        ror     a
        .byte   $F7
        .byte   $1F
        .byte   $02
        .byte   $1F
        .byte   $03
        .byte   $1F
        .byte   $04
        .byte   $1F
        .byte   $AB
        bvs     L55FB
        dex
        ldy     L0A34,x
        .byte   $1F
        cmp     $A2
        pla
        ror     $8D,x
        .byte   $32
        rol     a
        and     $E3,x
        .byte   $F4
        dey
        .byte   $1C
        bcc     L5698
        tay
        bpl     L5641
        .byte   $1C
        pha
        cpy     #$C9
        eor     ($09,x)
        .byte   $63
        txs
        .byte   $3C
L5698:  .byte   $89
        ora     ($89,x)
        .byte   $BF
        cmp     ($49,x)
        eor     ($8A,x)
        brk
        .byte   $CC
L56A2:  eor     ($0C,x)
        .byte   $63
        ldy     $C2
        and     $F128,x
        .byte   $8F
        bvs     L56DF
        bcs     L56F1
        sec
        .byte   $E2
        rol     a
        .byte   $8F
        .byte   $82
        bmi     L56D8
        cld
        dex
        bit     L2E05
        .byte   $8F
L56BC:  .byte   $62
        beq     L5722
        brk
L56C0:  cli
        .byte   $F4
        .byte   $04
        rol     L3203
        sta     $E0F2
        .byte   $72
L56CA:  sei
        .byte   $EF
        rol     $04
        rol     $06
        and     #$8E
        .byte   $32
        beq     L5748
        sec
        iny
        .byte   $32
L56D8:  asl     $34
        stx     L39A3
        dec     $AB,x
L56DF:  inc     $EEB3
L56E2:  .byte   $BB
        inc     $EEC3
L56E6:  .byte   $CB
        inc     $EED3
        .byte   $DB
        inc     $EEE3
        .byte   $EB
        .byte   $EE
        .byte   $F3
L56F1:  inc     $EFFB
        .byte   $23
        .byte   $EF
        .byte   $3B
        .byte   $EF
        .byte   $63
        .byte   $EF
        .byte   $8B
        .byte   $EF
        .byte   $B3
        .byte   $EF
        .byte   $DB
        inx
        .byte   $03
        beq     L573E
L5703:  beq     L5768
        beq     L56A2
        beq     L56BC
        beq     L56E6
        sbc     ($23),y
        sbc     ($6B),y
        sbc     ($B3),y
        sbc     ($FB),y
        .byte   $F2
        .byte   $43
        .byte   $F2
        .byte   $8B
        .byte   $F2
        .byte   $D3
        .byte   $F3
        .byte   $1B
        .byte   $F3
        .byte   $63
        .byte   $F3
        .byte   $AB
        .byte   $F3
        .byte   $E3
        .byte   $F4
L5722:  .byte   $80
        .byte   $DF
        lda     ($9F,x)
        .byte   $A3
        .byte   $DF
        lda     $9F
        .byte   $A7
        .byte   $5F
        lda     #$9F
L572E:  tax
        .byte   $5F
        .byte   $AB
        .byte   $1F
        .byte   $AB
        .byte   $DF
        lda     $AD1F
        .byte   $DF
        .byte   $AF
        .byte   $1F
        bcs     L579B
        .byte   $B2
        .byte   $1F
L573E:  .byte   $B3
        .byte   $5F
        ldy     $9F,x
        ldx     $5F,y
        .byte   $B7
        .byte   $9F
        clv
        .byte   $DF
L5748:  lda     $B99F,y
        .byte   $DF
        tsx
        .byte   $1F
        sta     ($C8,x)
L5750:  .byte   $3F
        txa
        .byte   $87
        ora     ($C7),y
        .byte   $FB
        .byte   $2F
        .byte   $FB
        .byte   $4F
        .byte   $FA
        .byte   $1F
        .byte   $FB
        cpy     #$E1
        .byte   $23
        sbc     $FDE7,x
        .byte   $DF
        sbc     $FDEF,x
        .byte   $B7
        .byte   $FD
L5768:  .byte   $3F
        inc     $FC1F,x
        ror     $A2C8
        .byte   $44
        stx     $14
        .byte   $5A
        txa
        and     #$14
        ora     L803E
        cmp     ($E0,x)
        sta     $3F
        .byte   $3F
        .byte   $BF
        .byte   $BF
        .byte   $3F
        .byte   $7F
        .byte   $3F
        .byte   $02
        .byte   $57
        .byte   $9F
        .byte   $BF
        .byte   $04
        .byte   $93
        .byte   $F7
        .byte   $FC
        .byte   $77
        .byte   $FC
        .byte   $50
L578E:  .byte   $6C
        .byte   $57
L5790:  .byte   $FC
        .byte   $4F
        .byte   $FC
        .byte   $2F
        sbc     $B058
        lda     #$62
        .byte   $9D
        .byte   $7C
L579B:  cpy     $97
        nop
        inc     $C3,x
        dec     L0C3B,x
        iny
        .byte   $47
        lsr     L29CB
        bmi     L572E
        .byte   $80
        .byte   $44
        cpy     #$45
        .byte   $0C
        iny
        .byte   $A2
L57B1:  bcs     L57DF
        .byte   $04
        .byte   $1C
        bpl     L57D3
        .byte   $3C
        cld
        plp
        .byte   $5B
        .byte   $FC
        bmi     L57BE
L57BE:  .byte   $14
        brk
        cld
        .byte   $02
        .byte   $8F
        .byte   $80
        .byte   $13
L57C5:  rts

        sty     $AF,x
        .byte   $EF
L57C9:  .byte   $FA
        tsx
        .byte   $63
        cpy     L2DD8
        .byte   $2B
        inc     L003E,x
        .byte   $8F
L57D3:  sta     $C683
        .byte   $23
        bpl     L583F
        .byte   $3F
        .byte   $53
        iny
        .byte   $93
        asl     $BF
L57DF:  .byte   $CF
        inc     $D93F,x
        inx
        lda     ($13,x)
L57E6:  clv
        .byte   $33
        sty     L6819
        tay
        .byte   $14
        .byte   $2F
        .byte   $8F
        ldy     $4F
        .byte   $DA
        rol     $C523,x
        .byte   $3C
        .byte   $34
        dey
        .byte   $F4
        lda     $BD3C,x
        and     $57,x
        sed
        and     L6234
        .byte   $1C
        .byte   $43
        .byte   $13
        cmp     $A209,y
        .byte   $5C
        cmp     ($35,x)
        bit     $FC0F
        .byte   $5A
        sty     L54A4
        .byte   $20
L5813:  cpy     $42
L5815:  adc     ($E1,x)
        ror     a
        rol     L0914,x
        bcc     L57E6
        sty     $6A
        .byte   $F7
        eor     L4B30
        .byte   $0C
        asl     $A9,x
        .byte   $92
        rol     $9E,x
        .byte   $03
        pha
        ror     a
        .byte   $F7
        .byte   $2F
L582E:  .byte   $80
        .byte   $64
        bcs     L58AA
L5832:  .byte   $ED
L5833:  .byte   $4B
L5834:  asl     $A3
        beq     L584A
L5838:  .byte   $3F
        .byte   $21
L583A:  pha
        rol     L0953
        .byte   $61
L583F:  ldy     $7C,x
        bpl     L5868
        cmp     ($8C),y
        stx     $41,y
        .byte   $47
        sbc     ($0D,x)
L584A:  .byte   $1F
        sty     $74
        .byte   $7E
L584E:  .byte   $13
        .byte   $47
        cpx     #$01
        lda     ($34,x)
        .byte   $AC
L5855:  .byte   $A3
        inx
        php
        iny
        .byte   $9B
        stx     $A28F
        rts

        .byte   $32
        tax
        tay
        .byte   $83
        asl     $C80B,x
        pla
        eor     ($A1),y
L5868:  cli
        brk
        rol     $E0AB
        php
        ldx     $AB45,y
        bpl     L5873
L5873:  .byte   $52
        ldy     $0220
        .byte   $0B
        .byte   $2B
        brk
        .byte   $02
        rol     a
        ldx     L0A00
        nop
        ldx     $02,y
        bit     L2F03
        clv
        ldy     L2193
        .byte   $90
L588A:  and     L2D00
        .byte   $12
        .byte   $A7
        bcs     L5855
        plp
        inc     $A9,x
        .byte   $DC
        brk
L5896:  rol     $AF,x
        ldx     #$61
        lsr     a
        .byte   $22
        cmp     $E8
        nop
        .byte   $07
        rol     $C8
        .byte   $8F
L58A3:  ldy     #$30
        .byte   $E2
        jmp     (L3EBA)

        .byte   $85
L58AA:  .byte   $89
        .byte   $43
        rts

        .byte   $9C
        txs
        lsr     L5D7C,x
        stx     $E7
        .byte   $A7
        eor     $92C1,x
        cpx     #$64
        .byte   $64
        ldx     #$1E
        sta     L1984,x
        sbc     #$E1
        cmp     $0630,y
        pha
        lsr     a
        .byte   $42
        .byte   $27
        .byte   $C7
        cpy     #$11
        pha
        ora     L7B76,y
        .byte   $7A
        .byte   $71
L58D2:  asl     L0081,x
        txs
        sed
        adc     ($4C),y
        sbc     ($B1),y
        .byte   $9C
        ora     $E2
        adc     L757B,x
        cpy     #$5F
        sbc     $C0
        .byte   $1C
        .byte   $42
        bpl     L5934
        and     ($9F),y
        .byte   $27
        .byte   $64
        cli
        .byte   $62
        asl     $8F43,x
        .byte   $C5
L58F2:  .byte   $3A
L58F3:  .byte   $FF
        beq     L58F3
        ora     L3A22
        asl     $EB,x
        cld
        brk
        .byte   $5F
L58FE:  sta     $72
        .byte   $63
L5901:  .byte   $53
        .byte   $34
        and     ($D4),y
        lda     ($DE),y
        txa
        .byte   $72
        .byte   $93
        tax
        .byte   $80
        .byte   $02
        asl     L083E,x
        sec
        sed
        bpl     L591F
        rol     L1C26,x
        .byte   $E3
        ldy     #$40
        sty     $44,x
        lda     $BC00,x
L591F:  .byte   $03
        ldx     $C6E0
        .byte   $0F
        .byte   $8B
        bne     L5956
        lda     ($F7),y
        .byte   $3C
        .byte   $7C
        ldy     L88C9,x
L592E:  clv
        .byte   $D7
        .byte   $23
        sbc     $CFE2
L5934:  ldy     #$C7
        .byte   $22
        .byte   $52
L5938:  .byte   $4F
        asl     L47AC
        .byte   $7B
        .byte   $EB
        tay
        sta     L2C41,y
        .byte   $3B
        .byte   $AF
        sta     $1E,x
        .byte   $3C
        cpy     L393B
        eor     ($02),y
        cmp     $DD4B,x
        eor     #$A2
        dec     $38
        sbc     ($25),y
        .byte   $27
L5956:  beq     L592E
        .byte   $32
        .byte   $0B
L595A:  .byte   $7C
        beq     L58F2
        .byte   $33
        .byte   $0B
        .byte   $7B
        rol     $D6
        .byte   $EF
        .byte   $1F
        .byte   $02
        sec
        .byte   $02
        adc     ($9C,x)
        pla
        .byte   $1C
        .byte   $73
        adc     ($59,x)
        ora     L5B87,y
        cpy     $E4
        ldx     $1D
        .byte   $7C
        .byte   $72
        bvc     L59CF
        lda     $8F
        .byte   $E7
        cmp     #$68
        .byte   $63
        lda     ($34,x)
        pha
        cmp     ($29,x)
        adc     ($83),y
        .byte   $A7
        ora     $DE85,x
        lsr     $BD65,x
        adc     L3BF6,y
L5990:  ldx     $C3
        .byte   $93
        .byte   $44
        adc     $DA
        ldx     L7FAF
        nop
        .byte   $6B
        .byte   $32
        .byte   $9B
L599D:  bit     $C4
        ora     $EF
        sta     $BB,x
        .byte   $C2
L59A4:  ldx     $1F,y
        dey
        ldx     L7DF5
        .byte   $42
        jmp     (L0B7D)

        .byte   $D2
        adc     $93A5,x
        cmp     ($AD),y
        sbc     L48FF,x
        ror     L4498
        cli
        .byte   $CF
        .byte   $1C
        ror     $61
        brk
        eor     ($00,x)
        .byte   $04
        .byte   $D2
        tay
        rol     L0200
        eor     $02,x
        ror     $FF
        .byte   $2B
L59CD:  .byte   $02
        .byte   $8E
L59CF:  dey
        .byte   $EF
        stx     $BA0A
        brk
        bit     $9AB8
L59D8:  brk
        .byte   $AB
        .byte   $3B
        .byte   $42
        ora     ($0A,x)
        .byte   $C1
L59DF:  .byte   $0B
        .byte   $CF
        .byte   $49
L59E2:  .byte   $89
        rol     a
        .byte   $F4
        .byte   $64
        .byte   $0F
        .byte   $33
        .byte   $FF
        sta     $B9,x
        .byte   $9F
        .byte   $F2
        adc     #$21
        .byte   $1B
        and     ($31,x)
        bit     L0CAB
L59F5:  nop
        sbc     $DAA5
        .byte   $AB
        .byte   $52
        .byte   $2F
        jmp     (L5A3E)

        pla
L5A00:  cmp     L7726
        bcs     L599D
        jsr     L78B1
        inc     $F5
        .byte   $04
        .byte   $9B
L5A0C:  ora     $DC,x
        .byte   $2E
        dex
L5A10:  adc     #$81
        bmi     $5A45
L5A14:  rol     $10,x
        lda     $83,x
        adc     #$CF
        sbc     L67B8,y
        sed
        .byte   $5B
        eor     $B536,y
        asl     L6621,x
        sbc     ($5F,x)
        sty     $D6
        and     #$29
        ldy     $62,x
        cpy     $AB1F
        sei
L5A31:  bit     $ADF6
        dex
        .byte   $47
        sei
        sty     $20
        .byte   $4B
        .byte   $1C
        .byte   $2F
        .byte   $3E
        .byte   $AB
L5A3E:  bcs     L59D8
        inc     $B993
        ora     $05,x
        .byte   $34
        bcs     L59E2
        eor     L44DC,x
        lda     $76,x
L5A4D:  bcs     L59F5
        .byte   $87
        adc     $E9,x
        sed
        lda     ($A7),y
        .byte   $D2
        .byte   $A0
L5A57:  adc     ($98),y
        .byte   $0C
        .byte   $41
L5A5B:  .byte   $9D
L5A5C:  ror     L003E,x
        sbc     ($11),y
L5A60:  tay
        dex
        .byte   $BB
        .byte   $23
        ldy     $0A,x
L5A66:  .byte   $8F
        .byte   $5C
        tax
        .byte   $17
        .byte   $0F
        nop
        .byte   $93
        lda     $0409
        brk
        rol     $01
        ldx     $B4
        .byte   $80
        .byte   $42
        .byte   $02
        .byte   $8B
        rti

        brk
        .byte   $43
        and     #$22
L5A7E:  plp
        .byte   $EF
        .byte   $02
        .byte   $AB
        ldx     $A4C3,y
        brk
        ldy     $04,x
        .byte   $02
        .byte   $C3
        .byte   $AC
L5A8B:  .byte   $04
        lsr     L39C6,x
        .byte   $4B
        cmp     ($49),y
        stx     L8E2B
        bmi     L5A5B
        bcc     L5A4D
        .byte   $C2
        .byte   $F4
        .byte   $C3
        .byte   $44
        .byte   $D2
        .byte   $32
        .byte   $63
        dex
        rol     $83,x
        lsr     a
        .byte   $C3
        eor     #$B1
        .byte   $0C
        cmp     ($C2,x)
        ldy     $9339
        .byte   $02
        .byte   $CF
        .byte   $12
        cmp     #$68
        .byte   $9E
        eor     L294B
        .byte   $8F
        ldx     $40
        .byte   $D3
        .byte   $6F
        inc     $6A
L5ABD:  pha
        .byte   $42
        adc     ($B1,x)
        ror     a
        and     $2C
        dec     L0AE4,x
        .byte   $1F
        eor     $6C
        .byte   $E3
        lsr     $83
        adc     ($5B),y
        sec
        cmp     $26,x
        .byte   $C7
        lda     L003E,x
        jmp     LC6D9

        .byte   $13
        eor     ($12,x)
        .byte   $C2
        ror     $AE53
        and     L80C9,x
        .byte   $EB
        .byte   $87
        .byte   $D4
        cld
        cmp     $5B
        stx     $C320
        .byte   $02
        plp
        .byte   $E2
        .byte   $3B
        .byte   $67
        .byte   $5B
        .byte   $AB
L5AF2:  tsx
        ldy     #$68
        stx     $B087
        ldx     $C8,y
        inx
        eor     $B2
        inx
        jmp     (LBAAB)

        ldx     L378B
        dey
        and     L39D2
        sty     $2C
L5B0A:  lda     L2C9D,y
        .byte   $BB
        rol     a
        cpx     $86
        lsr     a
        .byte   $63
        ldx     $AA14
        pla
        .byte   $93
        .byte   $CB
        and     $7B
        .byte   $83
        .byte   $4B
        asl     L4897,x
        .byte   $DA
        eor     $E9BE
        cpx     $DC
        adc     $041A
        php
        asl     $42
        asl     $42
        lda     ($DE),y
        lsr     a
        ror     a
        .byte   $CB
        .byte   $22
        .byte   $64
        .byte   $DA
        cpx     #$EA
        .byte   $22
        .byte   $93
        rts

        .byte   $0B
        .byte   $3B
        .byte   $AB
        inc     L2D9F
        dey
        ldy     #$04
        sbc     ($6A,x)
        .byte   $E2
        beq     L5B0A
        rol     $6B
        .byte   $F3
        sta     $8FFB,y
        and     L0B97,y
        adc     ($0C,x)
        ora     $2F
        adc     ($26,x)
        lsr     L224B,x
        cpx     #$27
        .byte   $D3
L5B5E:  .byte   $E3
        .byte   $E3
        .byte   $79
        brk
L5B62:  asl     a
L5B63:  .byte   $82
        bmi     L5BBA
        .byte   $1B
        ora     ($CC,x)
        cmp     ($89,x)
        .byte   $A3
        .byte   $0B
        sta     ($8A,x)
        .byte   $B3
        ldy     $0327,x
        .byte   $E3
        tsx
        sbc     #$0B
        .byte   $86
L5B78:  .byte   $2F
        stx     $26
        .byte   $8F
        .byte   $EB
        cld
        .byte   $DC
        .byte   $3F
L5B80:  .byte   $57
        sta     L0081
        sbc     ($BE),y
        .byte   $1F
        .byte   $1B
L5B87:  inc     $87,x
        .byte   $72
        .byte   $BB
        ldx     #$38
        lsr     L3AC4,x
        ldx     $BE
        ora     #$99
        .byte   $EB
        .byte   $80
        bpl     L5B5E
        .byte   $7F
        inc     $A2,x
        pla
        .byte   $59
L5B9D:  rol     $07,x
        .byte   $0F
L5BA0:  and     ($05,x)
        rol     $03,x
        ldx     L287C
        .byte   $FA
        .byte   $3B
        and     ($C8,x)
        and     ($C8),y
        sty     $96,x
        ror     $B041
        .byte   $22
        .byte   $E2
        cli
        ldy     L5BE2,x
        .byte   $CF
        .byte   $F9
L5BBA:  lda     $C741,x
        sbc     $23
        inc     $E1BF,x
L5BC2:  and     #$B8
        .byte   $FC
        lda     $D97F
L5BC8:  adc     L869F
        .byte   $97
        eor     $DDF8,y
        tay
        .byte   $17
        sbc     ($1F),y
        .byte   $FC
        tsx
        .byte   $3F
        and     $68,x
        .byte   $FC
        cmp     $F3A3,x
        .byte   $92
        .byte   $8F
        dec     $F1A7
        .byte   $94
L5BE2:  .byte   $CF
        php
        .byte   $FC
        .byte   $FF
        inc     $7F,x
        .byte   $1A
L5BE9:  .byte   $FF
        sbc     $C48F,y
        .byte   $CF
        nop
        .byte   $3F
        brk
        .byte   $64
        .byte   $80
        .byte   $9E
        .byte   $80
L5BF5:  bvs     L5C00
        cld
        .byte   $0B
        brk
        and     #$FE
        asl     $E0C7
        .byte   $7C
L5C00:  brk
        nop
        bcc     L5BC8
        ldy     #$04
        .byte   $BF
        dec     $18
        .byte   $F4
        asl     $F063,x
        .byte   $B5
L5C0E:  .byte   $8F
        .byte   $C3
        lsr     $3F
        asl     $EC58
        .byte   $3B
        .byte   $80
        .byte   $2B
        .byte   $FF
        .byte   $3D
        .byte   $63
L5C1B:  sbc     ($58),y
        .byte   $BC
L5C1E:  ror     $7127,x
        sed
        lda     $B101
        .byte   $6B
L5C26:  .byte   $34
        bpl     L5BC2
        .byte   $73
        sbc     ($05),y
L5C2C:  .byte   $A7
        .byte   $3F
        clc
        .byte   $5B
        .byte   $73
        sbc     ($A9),y
        .byte   $C7
        .byte   $8F
        .byte   $C7
        .byte   $9C
        .byte   $FC
        ror     $CF7F
        .byte   $C7
        clc
        .byte   $3C
        .byte   $FC
        .byte   $7A
        .byte   $87
        .byte   $CF
        .byte   $C7
        cld
        ldy     L72FC,x
        .byte   $8F
        .byte   $CF
        .byte   $C7
        .byte   $39
        .byte   $5C
L5C4C:  .byte   $FC
        .byte   $3A
        .byte   $9B
        .byte   $CF
        cmp     $D13F
        lda     (L00F9),y
        bvc     L5C1E
L5C57:  sbc     $6B
L5C59:  .byte   $1F
        stx     $6C,y
        ror     $B15D,x
L5C5F:  sbc     $C782,y
        inc     $4B
        .byte   $1F
        sta     L7EEC,y
        ror     a
        lda     (L00F9),y
        tsx
        .byte   $C7
        .byte   $E7
        .byte   $1B
        .byte   $1F
        sta     L7ECC,x
        .byte   $7B
        and     (L00F9),y
        sbc     L6500,y
        inc     $0201,x
        bcs     L5C90
        .byte   $04
L5C7F:  cmp     ($54),y
        cmp     ($54,x)
        ror     L5108,x
        sed
        and     L8C1F
        .byte   $E3
        .byte   $54
        ror     L5111,x
        sed
L5C90:  eor     $1F,x
        sta     $D405
        ror     L511B,x
        sed
        adc     $E247,x
        .byte   $44
        ror     L263E,x
        eor     ($F8),y
        lda     #$47
        .byte   $E2
        sbc     $1F,x
        sta     $F911
        inc     L47D9,x
        .byte   $E3
        sta     L8E17,x
        .byte   $F2
        eor     ($0F,x)
        .byte   $FF
        .byte   $53
        cpx     L8708
        .byte   $FC
        .byte   $04
        php
        .byte   $BF
        .byte   $FC
        .byte   $3C
        php
        .byte   $0F
        .byte   $FC
        .byte   $54
        php
        .byte   $1F
        .byte   $FC
        cpy     $08
        .byte   $27
        sbc     L0804,x
        .byte   $3A
        .byte   $34
        .byte   $27
        .byte   $E2
        .byte   $8B
        bit     $F808
        tsx
        .byte   $23
        .byte   $F3
        clc
        .byte   $8F
        cmp     $FC30
        ror     $D9,x
        .byte   $0F
        .byte   $C7
        eor     L3FF2
        .byte   $3A
        .byte   $43
        sbc     ($D7),y
        ldy     $CF8E,x
        .byte   $62
        .byte   $3F
        .byte   $3F
        php
        .byte   $FC
        .byte   $12
        .byte   $5C
        .byte   $12
        ror     $C109,x
        .byte   $03
        .byte   $7F
        sta     $04C1
        .byte   $7F
        sta     ($B1),y
        sed
        .byte   $5A
        .byte   $C7
        sbc     ($AC,x)
        bpl     L5D33
        .byte   $F9
        .byte   $EB
L5D06:  .byte   $1F
        txa
        cpy     $E3
        sbc     ($47),y
        .byte   $8F
        cmp     $E8
        and     ($63,x)
        dec     $8C,x
        .byte   $FC
        .byte   $D7
        .byte   $FB
        .byte   $5C
        .byte   $12
        .byte   $1B
        .byte   $C3
        .byte   $74
        ora     ($F3),y
        .byte   $DB
        cpy     $11
        .byte   $0B
        .byte   $DB
L5D22:  cpx     $11
        .byte   $FB
        .byte   $DC
        asl     $7E
        .byte   $1C
        .byte   $43
        eor     ($0A,x)
        lda     L67C6,x
        cmp     ($EC,x)
        stx     $7E,y
L5D33:  .byte   $69
L5D34:  inc     L0956,x
        ora     L1326,x
        beq     L5D06
        adc     $3F,x
        .byte   $0F
        jmp     (LF818)

        lda     $63,x
        .byte   $C2
        sbc     L0E3F
        bmi     L5D22
        sed
        .byte   $CF
        .byte   $63
        .byte   $F3
        txa
        php
        rts

        .byte   $F7
        .byte   $9D
        .byte   $3F
L5D54:  .byte   $3F
        .byte   $FB
        tya
        .byte   $FC
        inc     $82,x
        bpl     L5D99
        .byte   $FA
        .byte   $4F
        .byte   $CF
        .byte   $FF
        cld
        jsr     L61F5
        brk
        eor     ($87,x)
        .byte   $BF
        ora     $67
        .byte   $E3
        cli
L5D6C:  dec     L3B7E
        .byte   $8F
        .byte   $E7
        .byte   $E2
        eor     ($46,x)
        ror     L181D,x
        .byte   $E7
        sbc     ($E9,x)
        .byte   $AE
        .byte   $7E
L5D7C:  adc     #$FC
        .byte   $E2
        .byte   $0C
        .byte   $7B
        .byte   $FC
        inc     $E70C
        sbc     L7C58,x
        ror     $C127,x
        tya
L5D8C:  .byte   $6B
        sbc     $8F5B,x
        cmp     $EE
        .byte   $3F
        .byte   $1A
        clv
        .byte   $FC
        .byte   $72
        .byte   $E3
        .byte   $F1
L5D99:  .byte   $EF
        .byte   $8F
        iny
        .byte   $FC
        .byte   $FC
        .byte   $3F
        txs
L5DA0:  .byte   $CF
        cpy     $39
        inc     L283D
        ldy     #$C9
        sty     L38A9
        .byte   $FC
        tax
        .byte   $E3
        .byte   $F2
L5DAF:  dec     $0C,x
        .byte   $9C
        dex
        .byte   $EF
        .byte   $8F
        cmp     $B120
        sbc     $0695,y
        adc     $FF,x
        .byte   $9C
        .byte   $C7
        inc     $C2
        ror     $EF29,x
        .byte   $9E
        .byte   $0C
        .byte   $E3
        .byte   $FF
        cmp     #$8F
        .byte   $CF
L5DCB:  iny
        .byte   $32
        .byte   $1F
        .byte   $F0
L5DCF:  plp
        .byte   $44
        .byte   $FC
        asl     L2D84
        .byte   $FF
        bpl     L5E3B
        beq     L5E4F
        .byte   $8F
        .byte   $C2
        sei
L5DDD:  .byte   $42
        .byte   $0F
        .byte   $F2
        clv
        .byte   $42
        and     $64
        .byte   $17
        .byte   $E7
        inc     $BF
        .byte   $CF
        sei
        .byte   $FC
        lsr     $E3
        sbc     ($33),y
        .byte   $8F
        cmp     $EE
        .byte   $3F
        ora     $FC38,y
        ror     $E3,x
        sbc     ($F3),y
        .byte   $8F
        cmp     #$08
        .byte   $42
        sty     L8414
L5E01:  and     #$D7
        .byte   $FC
        cpx     $21
        rol     a
        ora     L7E06
        and     ($53,x)
        sbc     (L00F9),y
        .byte   $6B
        .byte   $9F
        txs
        .byte   $7F
        .byte   $BE
L5E13:  .byte   $63
        .byte   $F3
        and     $8F,x
        cmp     L3F46
        rol     $93,x
        .byte   $F2
        .byte   $23
        .byte   $7A
        bpl     L5E62
        lsr     $B05C
        .byte   $83
        bne     L5E44
        bcc     L5DAF
        .byte   $DF
        .byte   $FE
        .byte   $09
L5E2C:  sbc     $F801,y
        .byte   $9F
        .byte   $87
        rti

        bcc     L5DDD
L5E34:  sed
        plp
        .byte   $9F
        txa
        .byte   $82
        .byte   $1C
        .byte   $94
L5E3B:  rol     a
        .byte   $07
        sbc     L1F35,y
        .byte   $86
L5E41:  .byte   $F4
L5E42:  .byte   $7E
        .byte   $1E
L5E44:  cmp     ($F8),y
        .byte   $8F
L5E47:  .byte   $20
        .byte   $54
L5E49:  .byte   $1F
        sbc     $58,x
        .byte   $54
        .byte   $20
        .byte   $94
L5E4F:  sta     $FF
        .byte   $17
        .byte   $FB
        asl     $7E
        rol     $32,x
        .byte   $42
        .byte   $EC
L5E59:  .byte   $6B
        .byte   $E3
        sbc     ($C3),y
        .byte   $8F
        .byte   $C7
        lsr     L1F3F
L5E62:  sec
        .byte   $FC
        .byte   $82
        sta     $DD
        .byte   $89
        .byte   $62
        dex
        cpy     #$A4
        ldy     #$3C
        .byte   $DC
        .byte   $0F
        and     $DA,x
L5E72:  .byte   $5F
        .byte   $AF
        .byte   $A3
        ora     $C0
        .byte   $B2
        .byte   $82
        sbc     $CF,x
        .byte   $1A
        lsr     $D64D,x
        .byte   $82
        pla
        .byte   $CF
        sta     L2774
        .byte   $A7
        brk
        ldx     $9B
        ora     $A7
        ora     $02A7,y
        .byte   $F3
        .byte   $30
L5E90:  and     ($69,x)
        .byte   $3C
        .byte   $D7
        .byte   $3A
        ror     a
        .byte   $07
        lda     $F36C
        .byte   $5B
        .byte   $87
        ldx     $BD1E,y
        .byte   $D7
        .byte   $37
        sta     L7867
        .byte   $E3
        .byte   $53
        .byte   $9E
        .byte   $89
        lda     ($FE,x)
L5EAA:  asl     $99E1,x
        .byte   $EF
        cpy     $900E
        .byte   $97
        cpy     L2573
        inc     $0B
        and     #$A8
        .byte   $89
        lda     #$FE
        .byte   $33
        tya
        .byte   $1C
        .byte   $0B
        sta     $CB,x
        lda     ($8C,x)
        .byte   $39
L5EC5:  .byte   $9F
        cpy     L67E9
        and     ($58),y
        .byte   $7B
        dey
        rol     $7A
        ldx     $C979,y
        .byte   $52
L5ED3:  .byte   $17
        sei
        sbc     L1798,y
        cpy     $E1F8
        ror     $9B,x
        lda     #$D8
        sbc     L698E,y
        .byte   $59
L5EE3:  .byte   $7F
        lda     $85
        .byte   $D7
        sty     $CC,x
        .byte   $32
        .byte   $27
        brk
        asl     $A5C3
        and     $FA,x
        cmp     $4C,x
        .byte   $EF
        ora     ($05,x)
        ora     $D1
        cld
L5EF9:  adc     $C047,y
        and     $1F
        eor     #$62
        .byte   $B3
        sty     L4469
        .byte   $4C
L5F05:  bne     L5EAA
        .byte   $F3
        .byte   $52
        .byte   $8F
        cmp     L3FDA
        .byte   $39
L5F0E:  tay
        .byte   $FC
L5F10:  sbc     $96,x
        lsr     $E3
        .byte   $8F
        cpy     #$A8
        .byte   $9D
        .byte   $83
L5F19:  .byte   $1C
        .byte   $7E
L5F1B:  bpl     L5F0E
        sed
        eor     $C7,x
        sbc     ($7F,x)
        .byte   $1F
        .byte   $87
        .byte   $1C
        ror     $F124,x
        sed
        lda     $C7
        .byte   $E2
        .byte   $CF
        .byte   $1F
        sty     L7E1C
        .byte   $33
        sbc     ($F8),y
        cmp     $E4C7,y
        .byte   $07
        .byte   $1F
        sta     ($1C),y
        ror     L4447,x
        inc     L1140
        bne     L5F10
        eor     $9ED3,x
        ora     L7937,x
        sed
        eor     L47B9
        cmp     #$36
        cmp     $E57F,y
        and     $3C,x
        asl     a
        rts

L5F56:  iny
        stx     $11,y
        .byte   $53
        bmi     L5FAC
        adc     L6D83,x
        ror     $99
        sty     $2F,x
        stx     $C7
        inx
        sbc     #$31
        lda     $045E,x
        adc     ($74,x)
        asl     $13
        lsr     $CA
        .byte   $D9
        .byte   $7A
L5F73:  cmp     L4080
        jmp     (L1304)

        and     ($98),y
        .byte   $02
        .byte   $D3
        .byte   $5B
        .byte   $32
        ldy     L6130
        .byte   $FF
        .byte   $03
        bit     $31
L5F86:  .byte   $06
L5F87:  ora     ($8E,x)
        .byte   $82
        bcc     L5F9F
        .byte   $1B
L5F8D:  .byte   $0F
        .byte   $82
        sec
        cpx     #$01
        .byte   $27
        .byte   $0C
        asl     $26
        adc     L8F0D,y
        .byte   $22
        .byte   $67
        tax
        sbc     ($94),y
        .byte   $31
L5F9F:  tsx
L5FA0:  .byte   $3C
        txa
        cpx     L086A
        cmp     $C6
        plp
        .byte   $1C
        eor     ($09,x)
        .byte   $9F
L5FAC:  .byte   $4B
        .byte   $DC
        adc     #$37
        .byte   $AB
        .byte   $C3
        .byte   $C2
        dec     $96
        jmp     L11C3

L5FB8:  and     $EC3D
        rol     $CB,x
        .byte   $D2
        ldy     L134C
        bvs     L5F86
L5FC3:  .byte   $32
        adc     $F7E2
        tsx
        inx
        jmp     LB43C

        .byte   $3C
        rti

        .byte   $9B
        stx     $8F
        rts

        pla
        eor     $E2,x
        .byte   $A3
        cpx     $10
        sec
        .byte   $AC
        sec
L5FDB:  ldx     L8C48,y
        .byte   $7B
L5FDF:  stx     $42
        .byte   $13
        eor     $F2B1
        asl     $10,x
        sbc     ($80,x)
        .byte   $02
        pla
        ror     $B6
        .byte   $57
        ora     $036C,x
        adc     $F9B1,y
        .byte   $F4
        .byte   $C7
        cpx     #$14
        .byte   $52
        cmp     ($36,x)
        .byte   $3F
L5FFC:  php
        cld
        .byte   $FC
        bmi     L6064
        sbc     ($40),y
        .byte   $44
        .byte   $7E
L6005:  bit     $11
        sed
        ldy     #$47
        .byte   $E3
        ora     ($1F),y
        stx     L7E04
        eor     ($11,x)
        sbc     L4718,y
        cpx     $A9
        .byte   $1F
        .byte   $93
        cpx     $7E
        eor     $91,x
        sbc     L476A,y
L6020:  .byte   $E5
L6021:  sbc     ($1F,x)
        tya
        ldy     $7E
        ror     $11
        sbc     L14AB,y
        .byte   $34
        .byte   $64
        sec
        .byte   $74
        bne     L6045
        jsr     L6338
        rol     a
        pla
        sta     ($AB),y
        and     ($30),y
        sta     L845E,x
        cmp     L7D14
L6040:  ora     ($26,x)
        ldx     $53,y
        .byte   $A6
L6045:  .byte   $14
        .byte   $7C
        ldy     L3C81
        .byte   $07
        .byte   $3C
        .byte   $02
        .byte   $A6
L604E:  .byte   $B7
        lda     $01
        .byte   $0B
        cli
        sei
        .byte   $13
        pla
        cmp     ($C7),y
        ora     ($AC,x)
        lsr     $B8,x
        .byte   $64
        tya
        ora     ($5D),y
        sed
        rts

        .byte   $DA
        .byte   $E0
L6064:  .byte   $54
        .byte   $1A
L6066:  eor     $AA2A
        rol     L8983,x
L606C:  ldy     $A8,x
        .byte   $FA
        .byte   $0C
        .byte   $A7
L6071:  clc
        rol     $9A,x
        ldx     $B409,y
        cpx     $CF6C
        .byte   $82
L607B:  .byte   $D7
        rol     $AA
        rol     $0101,x
        .byte   $89
        lda     $28,x
        .byte   $FA
        sta     ($90,x)
        rti

        .byte   $FA
L6089:  bcs     L60C0
        pla
L608C:  inc     $0A
        rol     $46
        bcs     L608C
        .byte   $97
        .byte   $4F
        .byte   $7A
        .byte   $7C
        .byte   $13
L6097:  .byte   $73
        sty     $D8,x
        php
        pla
        .byte   $5A
        .byte   $17
        sei
L609F:  .byte   $CB
        .byte   $73
        sta     ($E4,x)
        .byte   $6F
        rol     $52,x
        .byte   $89
        dec     $E573,x
        .byte   $FF
L60AB:  .byte   $27
        .byte   $BF
        .byte   $1F
L60AE:  .byte   $3C
        cpx     #$2F
        .byte   $1A
        .byte   $B2
        .byte   $13
        cpx     #$AD
        ldy     $D5
        and     $04
        lda     $DC,x
        sta     L662D,x
        tsx
L60C0:  .byte   $E2
        bcc     L6089
        .byte   $4B
        .byte   $6F
        .byte   $89
        rol     $CB,x
        .byte   $A7
        bvc     L606C
        rol     $D3,x
L60CD:  asl     L6EC6,x
        sei
        sta     ($93,x)
        .byte   $0C
        .byte   $8B
        .byte   $3B
        .byte   $E7
        rol     $9F
        .byte   $5A
        inc     L13B6
        sty     $E4E1
        .byte   $3A
L60E1:  sbc     ($F4,x)
        rol     $D9E9,x
        .byte   $7C
        .byte   $E7
        sta     $63
        .byte   $8B
        stx     $18
        asl     a
        eor     L2C92
        sbc     $9EED
        dec     L2D13,x
        .byte   $7A
        .byte   $27
        bcs     L60AE
        .byte   $AE
L60FC:  adc     $A661
        .byte   $69
L6100:  rti

        .byte   $34
        .byte   $9F
        bmi     L60AB
        jmp     (L8661)

        .byte   $1C
        .byte   $13
        ora     $B1
        .byte   $F4
        .byte   $72
        .byte   $1C
        adc     L4CFA
        .byte   $12
        cpy     $40
        .byte   $52
        cpx     #$D6
        and     $BA61
        ror     L0C2B,x
        .byte   $FF
        .byte   $8F
        cpy     $BC
        .byte   $FC
        .byte   $33
        eor     ($E3),y
        sbc     ($5B),y
        .byte   $8F
        dec     $6C
        .byte   $FC
        sec
        ror     $C4CF
L6130:  .byte   $87
        .byte   $4C
        .byte   $FC
L6133:  txa
        .byte   $7C
        .byte   $E3
        .byte   $F2
        .byte   $17
L6138:  .byte   $3F
        .byte   $0C
        ldx     #$F3
        sbc     ($EE),y
        .byte   $47
        .byte   $3F
        .byte   $1B
        adc     $F3
        sbc     ($DE),y
        .byte   $77
        .byte   $8F
        dex
        .byte   $5C
        .byte   $FC
        .byte   $73
        .byte   $AB
        .byte   $E3
        .byte   $F2
        .byte   $C7
        .byte   $3F
        .byte   $1A
        ror     $F173
        .byte   $E2
        .byte   $FF
L6156:  .byte   $3F
        .byte   $13
        sbc     $05,x
        .byte   $1F
        sty     $B138
        sed
        sbc     ($97,x)
        .byte   $1F
        .byte   $92
        stx     $D1
        .byte   $8F
L6166:  .byte   $C7
        lda     $FC78
        eor     ($DD,x)
        .byte   $A3
        .byte   $F3
        stx     $3F,y
        .byte   $0E
        tsx
L6172:  .byte   $E3
        sbc     ($0B),y
        .byte   $D2
        .byte   $8F
        .byte   $CF
        .byte   $DA
        .byte   $3F
        .byte   $03
        sbc     $99
        .byte   $9F
        .byte   $82
        sta     $D4F8,y
        and     ($C7),y
        sbc     ($17,x)
        .byte   $1F
        sta     $59
        sed
        .byte   $DC
        eor     L8D9F,x
        stx     $99
        sbc     L7102,y
        .byte   $C7
        .byte   $E2
        asl     $7E
        eor     ($23,x)
        .byte   $67
        .byte   $E3
        .byte   $22
        ror     $7E
        .byte   $1B
        rol     a
        .byte   $67
        .byte   $E3
        .byte   $5A
        dec     $7E,x
        .byte   $3F
        bcs     L620F
        sbc     ($D3,x)
L61AA:  .byte   $47
        .byte   $1F
        sta     $F9B9
        brk
        .byte   $EF
        .byte   $C7
        cpx     $1E
        ror     L453B,x
        dec     $6C
        sta     ($E3),y
        .byte   $F2
        .byte   $63
        .byte   $8F
        .byte   $C9
L61BF:  dec     $283F,x
        sed
        .byte   $FC
        ldy     $DA8C
        brk
        sta     $F6
        .byte   $4F
        ldy     $F7
        bcc     L623E
        .byte   $5F
        stx     $64
        eor     #$1A
        .byte   $FF
        .byte   $EF
        and     #$52
        .byte   $12
        lda     $FA7F,x
        .byte   $BB
        .byte   $7D
        .byte   $BB
L61DF:  lda     #$A0
        sta     $96F2,y
        and     $CFE1
        .byte   $9C
        .byte   $1C
        cpx     $F2
        .byte   $97
        cmp     L11D4,y
        cpy     L141E
        ror     L6322
L61F5:  ror     $47,x
        .byte   $E7
        .byte   $E3
        .byte   $0C
        sty     L8269
        .byte   $1C
        .byte   $AC
        .byte   $6E
L6200:  bvs     L6250
        .byte   $67
L6203:  .byte   $E6
L6204:  eor     ($71),y
        sbc     $C755,y
        eor     $76
        ror     $D824,x
        .byte   $C6
L620F:  sbc     $A5
        ldy     L4E69
        .byte   $AF
L6215:  beq     L61BF
        beq     L61DF
        stx     $6E,y
        bne     L624A
        .byte   $0B
        .byte   $92
        sta     ($03),y
        .byte   $3F
        .byte   $02
        sbc     ($C2,x)
        .byte   $80
        .byte   $4B
        sbc     (L00F9,x)
        .byte   $77
        .byte   $0B
        .byte   $77
        .byte   $1A
        .byte   $FB
        sta     L71DC
        sed
L6232:  .byte   $07
        .byte   $1D
L6234:  dec     $F8,x
        php
        .byte   $6F
        eor     $B779
        .byte   $E6
L623C:  .byte   $DD
        .byte   $A4
L623E:  .byte   $FC
        .byte   $39
L6240:  .byte   $5F
        .byte   $13
        bmi     L62BF
        sbc     $79
        .byte   $D7
L6247:  .byte   $97
        .byte   $AE
        .byte   $57
L624A:  cpy     #$A4
        dec     $24
        .byte   $CB
        .byte   $A6
L6250:  rts

        ldy     #$DE
        lda     ($73,x)
        .byte   $27
        .byte   $8B
        rti

        jmp     LF00D

        .byte   $7C
        .byte   $93
        .byte   $57
        adc     L657E,y
        cmp     L5FDF,y
        .byte   $9E
        .byte   $EF
        inc     $65
        lda     ($86),y
        bmi     L6204
        .byte   $02
        .byte   $F7
        rol     $9E,x
        .byte   $EF
        .byte   $46
L6272:  adc     L8976,y
        ror     $E0
        stx     $0D
L6279:  .byte   $39
L627A:  ror     $84,x
        tya
L627D:  sta     $C2
        stx     $42
        .byte   $17
        .byte   $C2
        .byte   $93
        lsr     $C7F8
        .byte   $DC
        .byte   $E7
        bmi     L62C3
        .byte   $1D
L628C:  .byte   $DB
        .byte   $43
        .byte   $7A
        and     $F5E9
        stx     $AC3E
        .byte   $BF
        lsr     L2586,x
        inx
        lsr     L59DF,x
        cpy     $5E
        cmp     ($C7,x)
        .byte   $AF
        lsr     L87E1,x
        .byte   $DC
        .byte   $4B
        .byte   $93
        .byte   $91
L62A9:  .byte   $B2
        rol     $94
        .byte   $13
L62AD:  ora     $71,x
        sta     $D6
        .byte   $72
        and     #$FF
        stx     $C264
        ldx     $0458,y
        .byte   $C7
L62BB:  .byte   $DC
        ror     L7852,x
L62BF:  and     #$F3
        .byte   $2F
        .byte   $46
L62C3:  .byte   $9E
        lda     L0060
        cpx     $76
        .byte   $C2
        lsr     L0A3F
        .byte   $A3
        .byte   $87
        ldy     #$0B
        .byte   $A3
        bcs     L62DF
        .byte   $CB
        .byte   $8F
        cpy     $0C
        .byte   $FC
        .byte   $80
        lsr     $E3
        sbc     ($57),y
        .byte   $3F
        .byte   $10
L62DF:  .byte   $97
        .byte   $63
        .byte   $83
L62E2:  bne     L627D
        .byte   $33
        .byte   $F3
        .byte   $5F
        .byte   $ED
L62E8:  adc     ($C6),y
        .byte   $1A
        .byte   $FF
        .byte   $6F
        stx     L801F
        .byte   $73
        .byte   $8E
        .byte   $10
L62F3:  .byte   $80
        .byte   $77
L62F5:  .byte   $E3
        sbc     ($EF),y
        .byte   $8F
        iny
        sed
        .byte   $E2
        cli
        .byte   $89
        .byte   $9C
        sed
        .byte   $72
        ldx     #$E3
L6303:  .byte   $F2
        .byte   $C3
        bmi     L633B
        .byte   $FF
        .byte   $72
        .byte   $9E
        .byte   $1F
        .byte   $F7
        .byte   $EC
L630D:  .byte   $7E
L630E:  .byte   $62
L630F:  .byte   $C7
        and     #$07
        .byte   $FF
        rol     $38
        .byte   $8F
        .byte   $FF
        lsr     $38
        .byte   $AB
        .byte   $FF
        lsr     L2639,x
        .byte   $B7
        cli
        .byte   $FC
L6321:  .byte   $E2
L6322:  stx     $FF07
        inc     $63
        .byte   $F3
        cmp     L4F89,x
        ldy     $FC,x
        .byte   $3F
L632E:  ora     ($8F,x)
        .byte   $2B
        .byte   $FF
        ora     $8F
        .byte   $FF
        .byte   $52
        pha
        .byte   $4C
L6338:  adc     $F84F,y
L633B:  jmp     (LC17A)

        .byte   $16
L633F:  .byte   $3F
L6340:  .byte   $06
L6341:  .byte   $A3
        dec     $8E,x
        .byte   $7A
        dec     $EBBA,x
        ror     $D3A8,x
        .byte   $04
        .byte   $9B
        .byte   $43
        bcs     L62F3
        rol     a
        cmp     #$FA
        lda     $C392,x
        bit     L2EBF
        adc     L6B69,x
        dec     $9E,x
        .byte   $3C
        rti

        .byte   $89
        .byte   $B2
        ldx     $DC93
        ldx     $C4
        .byte   $F7
        ldy     $B140
        .byte   $D4
        inc     $AAB0
        and     L0BDE,y
        cld
        lda     L1B4F
        .byte   $BB
        beq     L633F
        .byte   $BB
        .byte   $1F
        .byte   $FF
        .byte   $AE
L637D:  .byte   $93
L637E:  tay
        .byte   $F3
        cmp     ($0C,x)
        .byte   $42
        lda     $D0
        sty     $8F,x
        sbc     L4087,x
        .byte   $80
        .byte   $5B
        ora     ($7D,x)
        .byte   $1B
        dec     $09
        .byte   $46
L6392:  php
        .byte   $F4
        .byte   $4F
        sty     $45,x
        bcc     L6416
        .byte   $1F
        lsr     $E1
L639C:  .byte   $7F
        sta     ($CA),y
        .byte   $5C
        asl     $12,x
        iny
        .byte   $4D
        .byte   $9D
L63A5:  .byte   $47
        eor     L873D,y
        eor     $B839,y
        eor     $5D
        adc     ($15,x)
        adc     $DA,x
        .byte   $89
        .byte   $F2
        .byte   $FC
        .byte   $EF
        .byte   $43
        ldy     L2AE3
        cmp     $42
L63BC:  jsr     LBE4E
        .byte   $4B
        .byte   $D2
        .byte   $BB
        .byte   $14
        .byte   $43
        iny
        sta     ($72,x)
        iny
        cpx     L1889
        lda     $991C,x
        .byte   $17
        .byte   $8F
        .byte   $22
        asl     L88BC,x
        adc     $BD3C,x
L63D7:  cmp     $80
        ldy     $70,x
        ldy     L49D4,x
        .byte   $F3
        sbc     ($14,x)
        rol     $90
        sbc     $14,x
        .byte   $6B
        .byte   $E3
        inc     $5A,x
        sbc     (L00F9),y
        adc     $E6C7,y
        bcc     L6403
        .byte   $F0
L63F1:  .byte   $FF
        ora     $CC8F,y
        iny
        sbc     ($0F),y
        sbc     L4B06,x
        ora     $F348,x
        .byte   $0F
        sbc     L3F86,x
        .byte   $3A
L6403:  .byte   $23
        cmp     ($FF,x)
        .byte   $FB
        .byte   $D9
        rol     a
L6409:  rti

        bit     $10
        plp
        .byte   $22
        eor     ($3D,x)
        ora     $24
        ora     #$7F
        .byte   $C6
L6415:  .byte   $24
L6416:  .byte   $07
        .byte   $BF
        .byte   $C7
        bit     $07
        .byte   $FF
        iny
        bit     $0D
        .byte   $BF
        cmp     #$24
        ora     $85,x
        .byte   $AF
        .byte   $F2
        stx     L0D3F
        sei
        .byte   $FC
        rol     $CA90,x
        ldy     $0E
        .byte   $3F
        .byte   $12
        ldy     $06
        asl     L2454,x
        .byte   $03
        dec     $B355,x
        sbc     ($E1,x)
        .byte   $97
        rol     L1A1E,x
        cpx     $10
        .byte   $74
        ror     L20F5,x
        .byte   $22
        .byte   $34
        clv
        rti

        .byte   $FC
        .byte   $FF
        dey
        bcc     L6454
        tya
        sbc     $9201,y
L6454:  ldy     $7E
        eor     ($C8),y
        .byte   $13
L6459:  .byte   $13
        .byte   $32
        ora     ($49,x)
        ror     a
L645E:  .byte   $47
        lda     $C9
        .byte   $1F
        tya
        .byte   $24
L6464:  ror     $C864,x
        asl     $24,x
        bcc     L6409
        stx     $67
        .byte   $12
        .byte   $22
        sty     L4283
        .byte   $64
        bmi     L6415
        .byte   $13
        .byte   $44
        .byte   $D3
        .byte   $04
L6479:  .byte   $DC
        cli
        plp
        .byte   $B3
        tay
        .byte   $E5
L647F:  .byte   $F4
        dey
        .byte   $03
        .byte   $04
        asl     L1848
        .byte   $8F
        ldy     #$1F
        sed
        sbc     $8F31,y
        bcc     L64B9
        rol     $A352,x
        cpx     $0E
L6494:  .byte   $34
        sta     ($CE),y
        cmp     ($88),y
        .byte   $7F
        cpy     $DA11
        bcc     L647F
        .byte   $04
L64A0:  and     $B892
        ldx     $32,y
        .byte   $9C
        .byte   $33
        .byte   $4B
        .byte   $47
        .byte   $63
        .byte   $57
        .byte   $1F
        sta     L7EDC
        and     $F971,y
        .byte   $03
        .byte   $C7
        cpx     $37
        .byte   $1F
        .byte   $92
        .byte   $5C
L64B9:  ror     $F14C,x
        sbc     $C741,y
        sbc     $34
        stx     L24D0
        .byte   $1D
L64C5:  and     $B8,x
        cmp     $9C,x
        sta     $C1F8,y
        .byte   $9F
        .byte   $97
        clv
        sbc     $A099
        cmp     $A0
        ora     $21
        sta     L2DA0,x
        .byte   $A3
        ldx     $D0A4
        dec     L256D,x
        .byte   $D7
        ldx     $ED6C
        ror     $E5
        .byte   $D2
        ldx     $D533
        sbc     ($33),y
        ora     L2325
        sty     L7AE3
        sty     $AA0E
        .byte   $3F
        ora     ($25,x)
        lda     $B0
        lsr     $4B
L64FC:  pla
        jmp     LB8A5

L6500:  rol     $E3
        .byte   $DC
        cmp     $04
        .byte   $04
        and     $CB04,y
        .byte   $9B
        .byte   $62
        .byte   $2B
        .byte   $4B
        .byte   $1F
        .byte   $F3
        .byte   $BB
        sty     $D2
        inc     $076E,x
        ora     #$13
        .byte   $7B
        .byte   $BB
        .byte   $63
        .byte   $E3
        .byte   $34
        rol     L4069,x
        .byte   $BF
        .byte   $9C
        jmp     (L3940)

        clv
        adc     $0E
        sec
        sbc     #$F9
        ror     $4F,x
        .byte   $BB
        .byte   $54
        and     L4FE6,x
        lda     $16,x
        .byte   $9F
        .byte   $BB
        adc     $BEED,x
        inc     L7826
        lda     ($37),y
        asl     L2B09
        asl     $F1E4
        rol     L4ECB
        lsr     $B154
        .byte   $DF
        bpl     L64FC
        .byte   $D3
L654D:  .byte   $C7
L654E:  sta     ($D6,x)
        .byte   $43
        rol     $42,x
        sty     $3C,x
        eor     $BB5E,y
        .byte   $33
        .byte   $4B
        lda     LE66D,y
        .byte   $62
        ora     ($F8),y
        .byte   $F7
        cmp     #$D2
        ror     a
L6564:  .byte   $6F
        asl     a
        bit     $01DD
        and     $CF,x
        .byte   $5F
        .byte   $17
        .byte   $BF
L656E:  .byte   $C3
        and     ($27),y
        bvs     L65D2
        .byte   $C2
        .byte   $39
        .byte   $E7
L6576:  .byte   $1F
        dey
        .byte   $9C
        ror     $F129,x
        sed
        .byte   $CB
L657E:  .byte   $C7
        .byte   $E3
        .byte   $67
        .byte   $1F
        stx     L7E1C
        .byte   $3B
        sbc     (L00F9),y
        .byte   $03
L6589:  .byte   $C7
        cpx     $AF
        .byte   $1F
        sta     $3C,x
        ror     $F157,x
        .byte   $F9
L6593:  adc     ($C7),y
        inc     $B0
        sed
        .byte   $FC
        dec     $57,x
        .byte   $03
        sta     L28C6,x
        adc     #$B0
        eor     $9961
        .byte   $33
        php
L65A6:  .byte   $FF
        pla
        asl     L4EE0,x
        .byte   $4F
        adc     ($0C,x)
        .byte   $9E
        bne     L65B5
        .byte   $83
        dec     $BC
        .byte   $26
L65B5:  .byte   $3C
        .byte   $62
        php
        and     $BA27,y
        .byte   $73
        sbc     $92,x
        .byte   $D2
        .byte   $9C
        .byte   $80
        .byte   $3C
        rol     $A5
        .byte   $E3
L65C5:  dex
        .byte   $AF
        .byte   $8F
        cmp     L0B6C
        adc     $E4,x
        and     ($C7,x)
        bcs     L6589
        .byte   $B6
L65D2:  .byte   $E0
L65D3:  .byte   $BB
L65D4:  sty     L4E23
        .byte   $3F
        .byte   $0E
        .byte   $B3
L65DA:  sbc     ($24),y
        .byte   $FA
        jmp     L5FC3

        inx
        .byte   $52
        ror     $9A
L65E4:  .byte   $FF
        lsr     $93
        cpy     $AEE4
        .byte   $3F
        .byte   $14
L65EC:  .byte   $33
        .byte   $B2
        ora     L8E53
        eor     $8E
        .byte   $3F
        .byte   $17
        clv
        .byte   $9E
        lsr     L1801
        ora     L2626,x
        .byte   $1B
        ora     $DC,x
        pha
        adc     $E2,x
        asl     $B83B
        .byte   $9F
        .byte   $93
        dec     L70E6,x
        inc     $8D,x
        adc     ($E2),y
        ora     $D2AB,y
        cpx     #$FF
        cld
        dey
        and     $40,x
        eor     L3209,x
        .byte   $33
        eor     L532B,x
        asl     a
        .byte   $01
L6621:  lsr     L5102
        .byte   $02
        .byte   $52
        .byte   $17
        brk
        .byte   $6B
        plp
        bvc     L65D3
L662C:  .byte   $3A
L662D:  and     $20
        sed
        .byte   $F7
        php
        .byte   $8F
        .byte   $73
        ora     $33
        ora     $44
        lda     ($36),y
        brk
        jsr     LF25F
        .byte   $FF
        .byte   $B3
        rol     $66,x
        .byte   $12
        .byte   $50
L6644:  lda     ($39,x)
        cpy     $BE
L6648:  sec
        sta     $BE,x
        .byte   $E3
        .byte   $F3
L664D:  eor     L551D,x
        .byte   $1A
        inc     $A1
        .byte   $34
        inc     $49,x
        asl     $77
        .byte   $9B
L6659:  .byte   $5A
        .byte   $A0
L665B:  .byte   $37
        .byte   $54
        .byte   $3B
        sec
        cpx     $07
        sty     $E2,x
        bvc     L667E
        bvc     L6648
        sec
        ora     $8C,x
        jsr     L9930
        eor     L308C
        .byte   $3C
        .byte   $99
L6672:  adc     $8F
L6674:  ror     $CAE4
        sty     $C161
        cpy     $CB
        .byte   $4C
        .byte   $61
L667E:  sbc     $AAEC,y
        .byte   $C7
        .byte   $B7
        .byte   $02
        adc     $B6
        and     ($1C),y
        inc     $57,x
L668A:  .byte   $63
        .byte   $12
        .byte   $0B
        rol     L0056
        .byte   $63
        .byte   $13
        cmp     L86D5
        and     ($50),y
        .byte   $92
        ror     $71
        sta     $C65F
        and     $49,x
        .byte   $43
        .byte   $72
        sty     $98,x
        .byte   $AB
        eor     $C1
        stx     $49
        .byte   $9E
        .byte   $44
        ldy     $A9
L66AB:  eor     #$92
        dec     $03
        .byte   $B2
        rti

        .byte   $53
        .byte   $64
        cmp     $FE
        .byte   $1A
        .byte   $C7
        cmp     $1F,x
        inc     L416E,x
        and     $02,x
        sbc     ($54,x)
        .byte   $74
        adc     $D1B9
        sed
        .byte   $F3
        lsr     $B9
        cmp     L5336,y
        lsr     $52,x
        cli
        .byte   $CF
        sbc     L6A8C,y
        .byte   $07
        bcc     L6659
        ldx     $4E,y
L66D7:  bit     $98
        .byte   $C7
        .byte   $34
        .byte   $A3
        .byte   $1C
        cmp     $CF66
        .byte   $FF
        lda     $83,x
        .byte   $42
        txa
        lda     L8A29,y
        .byte   $EB
        cmp     ($96,x)
        .byte   $62
        sta     L8AEB,x
        ror     $36
        .byte   $EB
L66F2:  clc
        .byte   $FC
        .byte   $B2
        .byte   $63
        .byte   $F2
        dec     L7B51,x
        sta     $EA
        .byte   $84
L66FD:  eor     $09,x
        ldy     $8A36
        lda     $A9,x
        lsr     $19,x
L6706:  sta     L13AD,x
L6709:  lsr     L6836
        .byte   $E3
        ora     ($13,x)
        lda     ($0F),y
        sta     ($6C),y
        .byte   $43
        .byte   $E3
        sty     $9B,x
        .byte   $3A
L6718:  ora     ($B5,x)
        asl     L8E89
        .byte   $AB
        .byte   $14
        .byte   $BC
        plp
L6721:  lda     $A3F6,y
        .byte   $F3
        .byte   $F2
        .byte   $3F
        .byte   $0F
        cpy     #$25
        .byte   $AB
        .byte   $AF
        .byte   $F4
        bcc     L6778
        .byte   $53
        ora     L847F
L6733:  lsr     a
        .byte   $EC
L6735:  .byte   $0C
        sta     $E2,x
        lda     L2C2D
        .byte   $3B
        bcs     L66FD
        .byte   $8F
        bvc     L6752
        .byte   $4F
        .byte   $0B
        .byte   $D2
        .byte   $3C
        .byte   $DF
        .byte   $F7
        tay
        .byte   $5F
        rol     $FE28,x
        sed
        ldy     $82
        .byte   $D2
        .byte   $4B
        .byte   $D2
L6752:  .byte   $53
        .byte   $57
        cmp     #$8F
        sei
        inc     $6C,x
        rol     $73
        .byte   $E3
        .byte   $89
        .byte   $D3
        .byte   $CF
        dey
        .byte   $D7
        .byte   $E7
        .byte   $E2
        sbc     $ADCC,x
        cmp     ($CF,x)
        ora     $07,x
        .byte   $FC
        ror     L6721,x
        sbc     ($FA,x)
        .byte   $3C
        lda     #$5E
        .byte   $AF
        .byte   $D2
        .byte   $E3
        sbc     ($B9,x)
L6778:  lsr     $52,x
        lda     $3F
        .byte   $EB
        .byte   $F4
        ror     $C432,x
        .byte   $42
        .byte   $1B
        .byte   $4C
L6784:  lda     $63
        and     L8EB6
        .byte   $07
        txs
        .byte   $A3
L678C:  iny
        lda     $DFF1
        .byte   $3C
        .byte   $89
        eor     $B2,x
        .byte   $67
        and     ($82,x)
        .byte   $52
        and     ($38),y
        .byte   $80
        .byte   $44
        .byte   $8B
        .byte   $77
        .byte   $0B
        ror     a
        .byte   $3B
        .byte   $8F
        txa
        jsr     L2299
        .byte   $8F
        cpy     $A2
        .byte   $F7
        tya
        .byte   $FA
        .byte   $44
        inc     $26
        .byte   $C3
        ldy     $1E,x
        lsr     $ADB5
        lda     L1115,y
L67B8:  .byte   $5F
        adc     ($2A,x)
        .byte   $23
        .byte   $4F
L67BD:  .byte   $FB
        and     #$50
        .byte   $B7
        ldx     $23,y
        .byte   $D2
        .byte   $FC
        .byte   $8F
L67C6:  sty     L2422
        sbc     ($88),y
        .byte   $93
        dex
        .byte   $0F
        .byte   $07
        .byte   $2D
L67D0:  rts

        .byte   $FC
L67D2:  .byte   $73
        .byte   $DA
        .byte   $23
L67D5:  .byte   $A3
        .byte   $80
        .byte   $80
        rol     L1D62,x
        .byte   $FA
        dey
        .byte   $F4
        inc     $FC21
        eor     L296C,y
        ldy     #$02
        .byte   $DE
L67E7:  .byte   $74
        .byte   $74
L67E9:  txs
        dex
        and     L43E7
        .byte   $89
        ldy     L7BDC
        sty     $9B,x
        stx     $67
        .byte   $BB
        eor     #$67
        .byte   $37
        ora     $9B,x
        .byte   $FB
        .byte   $82
        lda     L866D,y
        .byte   $3C
        ror     L711D,x
        sed
L6806:  .byte   $87
        .byte   $C7
        .byte   $E2
        .byte   $74
        .byte   $B7
        php
        .byte   $65
L680D:  ror     $6148,x
        ldx     $FF3A
        .byte   $37
        ora     $E1D7
        and     L00F9,x
L6819:  rts

        pla
        .byte   $B7
        asl     $D9F8,x
        .byte   $7F
        dec     $65
        .byte   $7F
        .byte   $C7
        .byte   $83
        sbc     $77
        .byte   $92
        .byte   $AF
        ldx     $D5
        .byte   $81
L682C:  .byte   $7B
        .byte   $97
        stx     $B6,y
        cmp     L8A26,y
        .byte   $CF
        .byte   $AE
        .byte   $BC
L6836:  rol     $AFAF,x
        .byte   $03
        asl     $7E,x
        .byte   $27
        .byte   $5B
        adc     $8A
L6840:  .byte   $F5
L6841:  .byte   $FE
L6842:  .byte   $DF
        .byte   $C7
        .byte   $E3
        .byte   $DF
        asl     L5990,x
        sed
        .byte   $7F
        .byte   $0B
        .byte   $C7
        ldy     $4C
        lda     ($86),y
        .byte   $BF
        .byte   $E3
        .byte   $73
        cmp     ($26),y
        lsr     $5B
        .byte   $0F
        adc     $78
        .byte   $FC
        lda     $E3
        .byte   $F2
        .byte   $AF
L6860:  .byte   $3C
        ora     L732C,x
        sbc     ($DA),y
        .byte   $DF
        sta     $D98B
        adc     L16D8
        inc     $5E
        adc     L7ECC,y
        bcc     L680D
        lda     L0C8A,y
        asl     L4BE2
        tya
        php
        .byte   $73
        tya
        tax
        .byte   $70
L6880:  brk
L6881:  .byte   $7B
        tya
        clv
        .byte   $EE
        .byte   $A5
L6886:  .byte   $1C
        sbc     ($E1,x)
        cpy     L7568
        bvc     L6860
        .byte   $0F
        cpy     #$4E
        .byte   $DC
L6892:  cmp     L5D8C,x
        txs
        .byte   $B3
        eor     L6593,x
        asl     a
        .byte   $47
        sta     ($1C),y
        .byte   $83
        eor     $F49F
        .byte   $C2
        .byte   $DC
        lda     ($BB),y
        sty     L4FE1
        clc
        dec     $9700
        cld
        ora     $E0C7,x
        .byte   $EF
        .byte   $1F
        sty     $9C
L68B5:  ror     $CB1B,x
        beq     L68D6
        .byte   $5A
        .byte   $02
        eor     L27EE,x
        .byte   $83
        .byte   $FA
        .byte   $F3
        ror     $FCFC
        .byte   $DB
        dec     $DB7C,x
        sbc     #$B0
        sed
        .byte   $6B
        bpl     L68FC
        .byte   $F0
L68D0:  .byte   $AF
        eor     L1F87,x
        .byte   $5F
        .byte   $27
L68D6:  .byte   $87
        .byte   $67
        .byte   $6F
        ldy     #$0D
        .byte   $27
        ldy     #$7A
        .byte   $CF
        .byte   $13
        cpy     $E032
        tsx
        .byte   $FF
        .byte   $63
        .byte   $97
        dex
        stx     $7E
        .byte   $3F
        .byte   $1C
        sed
        beq     L696E
        .byte   $E3
        .byte   $E2
        .byte   $0B
        rol     $E10F,x
        .byte   $B3
        .byte   $F1
L68F7:  rol     $2A
        .byte   $5F
        ora     ($E3,x)
L68FC:  lda     $F2
        .byte   $DE
L68FF:  .byte   $4B
        .byte   $8F
        dex
        ora     #$7C
        .byte   $0B
        ldy     $E3
        .byte   $F2
        .byte   $AB
        sta     $E9CA
        adc     L52C8,x
        asl     a
        .byte   $0C
        php
        clc
        ora     ($CF),y
        .byte   $2F
        sta     ($7B),y
        eor     $A135,y
        and     $89,x
        .byte   $33
L691E:  lda     ($98),y
        bmi     L694B
        bvs     L694D
        .byte   $1F
        adc     ($D7,x)
        cmp     $9DD1
        ldy     $99
        .byte   $DB
        .byte   $D7
        stx     $E779
        cmp     ($06,x)
        .byte   $E3
        .byte   $5D
        .byte   $FC
L6936:  .byte   $5F
        sty     $CC
        jmp     (LE31C)

        beq     L68D0
        .byte   $63
        adc     #$DC
        stx     L8C73
        bvc     L6985
        .byte   $1F
        .byte   $44
        bit     $D6
        .byte   $BE
L694B:  .byte   $1E
        .byte   $96
L694D:  .byte   $DC
        rol     $EC5B
        .byte   $83
        sec
        .byte   $E3
        .byte   $74
        .byte   $F3
        .byte   $8F
        cpy     $2E
        .byte   $3F
        .byte   $12
        sec
        .byte   $FC
        lsr     L44E3
        .byte   $04
        .byte   $9C
        .byte   $04
        ldy     #$04
        .byte   $A7
        .byte   $37
        sbc     $CC77,x
        .byte   $0C
        ora     $EF
L696D:  .byte   $7B
L696E:  inc     L3E7A,x
        dec     $9DC9
        .byte   $DA
        sta     L3BC6,x
        .byte   $0E
        clv
L697A:  .byte   $D7
L697B:  .byte   $6F
        .byte   $E3
        sbc     ($DB),y
        sta     L0839
        .byte   $59
        clc
L6984:  .byte   $9D
L6985:  and     L57C5
        dec     $64
        .byte   $C6
L698B:  .byte   $87
        .byte   $47
        .byte   $0E
L698E:  .byte   $C7
        inc     $48
        .byte   $5A
        pha
        txa
        eor     #$14
        cmp     #$6A
        cmp     #$12
        eor     #$AB
        txa
        .byte   $4E
L699E:  ror     $4E
        stx     $A64E
        lsr     L4EAE
        ldx     $4E,y
L69A8:  dex
        .byte   $4F
        lsr     L6232,x
        .byte   $32
        .byte   $8B
        .byte   $32
        .byte   $8F
L69B1:  .byte   $D2
        .byte   $93
        .byte   $92
        txs
        eor     ($94,x)
        .byte   $D3
        .byte   $94
L69B9:  cmp     $94,x
        .byte   $D7
        sty     $EA,x
        sty     $10,x
        sta     $33,x
        sta     $51,x
        cpx     $AF
        sty     L8CAA
        .byte   $B6
L69CA:  .byte   $04
        .byte   $B7
        .byte   $F4
        .byte   $B2
L69CE:  .byte   $1C
        lda     $B88C,x
        sta     L14A6,y
        .byte   $A3
        and     ($0D),y
        and     ($1A),y
        .byte   $1F
        .byte   $BB
        .byte   $44
        ora     ($1C,x)
        .byte   $07
        clv
        .byte   $9F
L69E2:  .byte   $BB
        lda     ($C3),y
        .byte   $1A
L69E6:  sta     $C051,y
        .byte   $5B
        sta     $20,x
        inc     L483F
        .byte   $77
L69F0:  .byte   $4B
        eor     L5DCB,y
        .byte   $4B
        .byte   $5B
        .byte   $CB
        lsr     L0EA2,x
        ror     a
        cmp     $0101
        .byte   $73
        lsr     $B0,x
        .byte   $51
L6A02:  .byte   $7F
        .byte   $BC
L6A04:  eor     L096C
        .byte   $80
        .byte   $0B
        .byte   $F7
        rti

        ora     L804D
        bpl     L6A21
        .byte   $C2
L6A11:  .byte   $DA
        .byte   $04
        .byte   $14
        .byte   $7F
        ldy     $0A
        bcc     L69A8
        cmp     ($58),y
        .byte   $FD
L6A1C:  .byte   $5B
        .byte   $FF
L6A1E:  cli
        .byte   $8E
        .byte   $D9
L6A21:  .byte   $30
L6A22:  eor     ($02),y
        dec     $FE87,x
        inc     LC081
        .byte   $27
        .byte   $06
L6A2C:  lsr     $87,x
        tax
        tya
L6A30:  bmi     L6A22
        .byte   $B3
        lsr     L280C
        sty     L3F28
        lsr     $21
        bcs     L6A1E
        and     ($28),y
        .byte   $07
        inc     a:$45
        cpx     $AC00
        bvs     L6A2C
        bvs     L6A30
        .byte   $53
        dec     L4320,x
        cmp     $54
        asl     $3D
        jmp     LC8DF

        .byte   $FF
        cmp     #$5E
        .byte   $72
        sta     ($F2),y
        asl     L50F2
        .byte   $F2
        .byte   $33
L6A60:  .byte   $F3
        .byte   $57
        sbc     ($CA),y
        sbc     ($ED),y
        inc     L003E,x
L6A68:  sbc     ($2F),y
        .byte   $F3
        stx     L3289
        .byte   $FA
        ror     $FA,x
        .byte   $D4
        .byte   $80
        .byte   $54
L6A74:  jmp     L0081

        jmp     L0180

        .byte   $27
        inx
        asl     L8746,x
        lda     $11
        sbc     $00
        .byte   $1C
        and     $94,x
        and     $9D
        eor     $48
        .byte   $1C
        .byte   $2E
L6A8C:  .byte   $17
        rol     $15,x
L6A8F:  stx     L550D
        lsr     a
        sta     $64,x
        .byte   $70
L6A96:  .byte   $74
        bvs     L6B0D
        .byte   $03
        dex
        .byte   $9C
        rol     L2242,x
        .byte   $93
        sbc     $36
        .byte   $7A
        .byte   $3C
        and     L2A26,y
        lda     #$30
        stx     $08
        .byte   $0B
L6AAC:  .byte   $7F
        tax
        .byte   $42
        .byte   $23
        rts

        .byte   $80
        tax
        eor     ($23,x)
        .byte   $62
        brk
        sty     $40,x
        cmp     L00F9,x
        .byte   $9B
        .byte   $F6
L6ABD:  .byte   $12
        .byte   $22
        bit     $A9F9
L6AC2:  .byte   $7F
        sta     L6E14
        cpx     $7E
        inc     L16C1
        sbc     $1C
        eor     ($D1,x)
        nop
        ora     $A11E,x
        .byte   $FB
L6AD4:  .byte   $97
        sbc     ($C0),y
        ora     ($50,x)
        asl     $7D
        eor     ($80),y
        brk
        bvc     L6A60
        beq     L6B34
        brk
        asl     $FD58
        ora     $00
        pha
        and     $1E
        bpl     L6AC2
        .byte   $8F
        bne     L6B42
        pla
        sbc     ($45),y
        bpl     L6B2A
        ora     ($00),y
        .byte   $A3
        .byte   $7F
        sty     $61,x
        ldx     $9B3E,y
        sbc     ($46),y
L6B00:  ora     $CD,x
        .byte   $63
        .byte   $5B
        .byte   $14
        ldy     $40
        sty     $40,x
        .byte   $20
        php
L6B0B:  bpl     L6A8F
L6B0D:  .byte   $3B
        .byte   $7F
        inx
        cpx     $6F
        and     $FF,x
        .byte   $A3
        and     ($BC),y
        php
        .byte   $14
        plp
        .byte   $1C
        .byte   $14
        .byte   $1C
        .byte   $0C
        asl     $6D,x
        .byte   $02
        sta     ($84,x)
        .byte   $82
        sty     $83
        .byte   $52
        .byte   $92
        .byte   $02
        .byte   $82
L6B2A:  .byte   $47
        bvs     L6B3D
        .byte   $77
        tay
        cmp     ($50),y
        lda     #$BD
        .byte   $1B
L6B34:  ora     ($00,x)
        lda     #$11
        rts

        bcc     L6B7A
        .byte   $37
        .byte   $5D
L6B3D:  bvc     L6BA0
        and     $C741,y
L6B42:  cld
        brk
        .byte   $5C
        adc     L0081
        .byte   $1A
        sta     ($D1,x)
        .byte   $CF
        .byte   $4F
        pla
        tay
        asl     $A8
        bit     $7B
        .byte   $82
        eor     ($72),y
        .byte   $02
        .byte   $6B
        .byte   $1F
        .byte   $5C
        ldy     #$60
        .byte   $82
L6B5C:  ldy     #$20
        asl     $B1
        .byte   $FB
        .byte   $AB
        ora     L7214,x
        .byte   $E2
L6B66:  .byte   $80
        ora     ($D5,x)
L6B69:  dec     $36,x
        bmi     L6B97
        adc     $9946,y
        rti

        tay
        .byte   $84
L6B73:  adc     $C704,x
        txa
        inx
        sty     $51,x
L6B7A:  .byte   $0C
        .byte   $44
L6B7C:  cpx     #$54
        eor     #$85
        cmp     $A8
        lda     L77AC,y
        .byte   $44
        cmp     #$C8
        lda     #$DD
        .byte   $53
        .byte   $22
L6B8C:  lda     $F1
        .byte   $89
        .byte   $12
        .byte   $1A
        .byte   $A1
L6B92:  .byte   $14
        eor     $C70B,y
        plp
L6B97:  and     $D0A8,y
        ora     ($2C,x)
        cmp     $8F35,y
        .byte   $1A
L6BA0:  .byte   $31
L6BA1:  sbc     $A241,x
        iny
        cpx     #$46
        .byte   $37
        .byte   $22
        .byte   $D4
        ror     L2A3D,x
        .byte   $DF
        php
        sbc     $07,x
        .byte   $AB
        rol     $CB,x
        bne     L6B8C
        .byte   $AF
        ldy     #$71
        cli
        inc     $A3C5
L6BBD:  .byte   $D2
        .byte   $AF
        lda     ($1A,x)
        .byte   $3A
        .byte   $E2
        sed
L6BC4:  .byte   $22
        stx     L3EEA
        sta     $DB61
        .byte   $D4
        bne     L6C12
        dec     $2E,x
        sbc     $68,x
        txs
        stx     L517D
        beq     L6C52
        and     (L00F9),y
        eor     $E3D1
        inx
        php
        .byte   $54
        .byte   $3C
L6BE1:  .byte   $14
        .byte   $54
        .byte   $82
        sec
        dey
        plp
        lda     $06,x
        .byte   $AB
        .byte   $DC
        ror     a
        .byte   $8F
        sei
        .byte   $EE
        .byte   $8F
L6BF0:  .byte   $AF
        eor     ($5B),y
        .byte   $0F
        adc     ($5A),y
        lsr     a
        ldy     #$C3
        .byte   $52
        tsx
        .byte   $1B
        .byte   $43
        .byte   $23
        jsr     L2916
        tax
        .byte   $76
L6C03:  .byte   $8F
        .byte   $70
L6C05:  .byte   $3A
        .byte   $9B
        .byte   $43
        .byte   $E3
        bvs     L6C19
        .byte   $8F
        rti

        rol     a
        .byte   $3B
        lda     #$29
        .byte   $F5
L6C12:  .byte   $6B
        and     $41
        and     ($CC,x)
        .byte   $1A
        .byte   $8E
L6C19:  and     $B858
        ldx     #$52
        .byte   $1F
        ora     ($05,x)
        .byte   $42
        .byte   $E3
        adc     ($40),y
        beq     L6BBD
        .byte   $72
        .byte   $82
        .byte   $06
L6C2A:  lsr     L0056,x
        ora     ($84,x)
        .byte   $FA
        sty     $86
L6C31:  .byte   $92
        .byte   $82
        bvc     L6C03
        plp
        lsr     a
        asl     L1603
        rti

L6C3B:  clv
        ldy     $E3
L6C3E:  .byte   $44
        lda     ($42,x)
L6C41:  .byte   $02
        .byte   $A1
L6C43:  .byte   $80
        tya
        ldy     #$41
        ora     ($D0),y
        .byte   $07
        .byte   $1A
        cmp     ($B3,x)
L6C4D:  bvc     L6BF0
        bvc     L6BE1
        .byte   $B2
L6C52:  bvc     L6C84
        .byte   $CE
L6C55:  eor     ($C8),y
L6C57:  ldx     $05
        .byte   $0B
        and     $05,x
        clc
        .byte   $89
        rti

        ora     ($58),y
        cmp     L0D35
        ora     $35,x
        .byte   $03
        ora     ($8A,x)
        .byte   $C2
        and     L31A8,y
        plp
        .byte   $0C
        .byte   $D4
        .byte   $1C
        .byte   $52
        jsr     L4982
        .byte   $42
        .byte   $22
        bvc     L6CDA
        rol     a
        stx     $78
        adc     ($9A,x)
        .byte   $80
        ora     $C7
        cmp     $23,x
        rti

L6C84:  stx     $A8
        sec
        sty     $7D
L6C89:  .byte   $07
        nop
        .byte   $84
L6C8C:  .byte   $D4
        and     L5B62,y
        eor     $F5,x
        adc     $E8
        .byte   $2B
        .byte   $0B
        ora     $1D,x
        ora     #$C7
        lda     L1E45,y
        beq     L6C43
        ora     $52,x
        .byte   $67
        plp
        cli
        and     $48
        ora     ($35,x)
        .byte   $7A
        cli
        pla
        .byte   $42
        pha
        eor     L0081
        ldy     $5C
        dec     $37,x
        .byte   $54
        and     ($57,x)
        cmp     $1E,x
        .byte   $80
        lsr     $A0
L6CBB:  bne     L6C57
        .byte   $02
        .byte   $15
L6CBF:  ora     $FDF0
        .byte   $1F
        .byte   $34
        .byte   $03
        eor     L6340
        .byte   $DC
        .byte   $44
L6CCA:  .byte   $D4
        asl     $8F
        tay
        .byte   $F4
        brk
        asl     $A3
        .byte   $B2
        stx     $E2,y
        .byte   $92
        .byte   $80
        .byte   $D4
        plp
        .byte   $4B
L6CDA:  .byte   $54
        asl     $30,x
        .byte   $80
        .byte   $43
        tay
        .byte   $34
        sbc     $08,x
        ldy     #$AC
        stx     L003E,y
        dey
        cpx     L3A5A
        .byte   $32
        tay
        .byte   $CB
        .byte   $A3
        jmp     L8F12

        .byte   $1E
L6CF3:  bvc     $6CE6
        plp
        .byte   $AF
        bcs     L6C89
        lda     $BF
        .byte   $AB
        nop
        .byte   $AF
        lsr     a
        eor     L501D,x
        ror     a
        sec
        ldx     #$04
        lsr     $03
        sta     ($20,x)
        sty     $40
        ror     $32
        lda     #$63
        cpy     #$C1
        adc     #$72
        .byte   $01
L6D15:  sty     $E8
        .byte   $DC
        sbc     $07
        txa
        bcs     L6D65
        .byte   $D3
        .byte   $03
        ldy     $28
        asl     $02
        ora     $09,x
        stx     $C970
        tay
        .byte   $90
L6D2A:  bcc     $6CD4
        bvs     L6D62
        and     $04
        .byte   $C7
        sec
        .byte   $6C
L6D33:  rts

        .byte   $07
        .byte   $92
        sta     ($52,x)
        .byte   $52
        .byte   $C3
        cld
        .byte   $1C
        adc     ($50),y
L6D3E:  cpx     $17
        php
        bcc     L6D78
        lsr     a
        eor     #$1C
        eor     ($AC),y
        .byte   $0F
        .byte   $42
        sbc     L740F,x
        tya
        brk
        sty     $BD,x
        cpy     $A0
        rts

        sty     $A1
        .byte   $74
        ror     L43D2,x
        .byte   $8B
        .byte   $C7
L6D5C:  ldy     $2E
        .byte   $42
        .byte   $9F
        lda     #$B4
L6D62:  adc     $01
        .byte   $45
L6D65:  bpl     L6D7F
L6D67:  bvs     L6D15
        .byte   $0C
        .byte   $62
        dey
        .byte   $07
L6D6D:  .byte   $D2
        .byte   $43
        txs
        dec     $96
        tay
        cmp     #$4D
        stx     $27,y
        .byte   $2C
L6D78:  dec     $28,x
        and     ($2C,x)
L6D7C:  php
        bit     $14
L6D7F:  .byte   $22
        jsr     L6842
L6D83:  .byte   $A3
        .byte   $8F
        clc
        bcs     L6DBD
        .byte   $AB
        ldy     $D627
        sta     ($76),y
        .byte   $80
        plp
        .byte   $E2
        cmp     $00
        sty     $F840
        .byte   $E2
        .byte   $9B
        .byte   $74
        ldy     $D1,x
        .byte   $CB
        .byte   $5A
        cmp     #$14
        cmp     ($16,x)
        ora     ($C0),y
        beq     L6DED
        eor     $E112
        inc     $C6B5,x
        ldy     #$7C
        adc     ($12),y
        lsr     $E5
        .byte   $03
        bne     L6D7C
        ora     ($58),y
        ror     $4A
        .byte   $0F
        asl     $53,x
        .byte   $6B
        .byte   $54
L6DBD:  .byte   $5A
        .byte   $8B
        cli
        .byte   $F3
        ora     ($03,x)
        sta     L8898
        .byte   $8F
        .byte   $AE
        .byte   $52
L6DC9:  php
        asl     $08
        sty     $E5A8
        .byte   $93
        bcs     L6DE2
        .byte   $44
        brk
        bcs     L6E26
        cld
        bcs     L6E31
        .byte   $02
        ror     L0B8A,x
        ora     #$90
        jsr     LF140
L6DE2:  tax
        .byte   $DA
        asl     $43,x
        beq     L6E0B
        .byte   $04
        ldy     L4030
        .byte   $70
L6DED:  asl     $A4
        eor     ($1C,x)
        .byte   $3E
        .byte   $80
L6DF3:  .byte   $5E
        .byte   $AF
L6DF5:  lda     $BD
        .byte   $0D
        .byte   $C2
L6DF9:  .byte   $FA
L6DFA:  .byte   $DB
        ror     $FA,x
        .byte   $02
        bvs     L6DFA
        asl     L7235
        adc     ($70,x)
        inx
        .byte   $74
L6E07:  .byte   $FA
        eor     L6166
L6E0B:  and     $8F,x
        .byte   $47
        .byte   $A3
        inx
L6E10:  .byte   $11
L6E11:  .byte   $C3
        sbc     #$28
L6E14:  and     ($41),y
        cmp     $C84A,y
L6E19:  sta     $41
        .byte   $DF
        .byte   $1A
        adc     $6A,x
        sbc     $E552
        .byte   $3A
        .byte   $0F
        nop
        plp
L6E26:  .byte   $1A
        dec     $B0
        .byte   $2B
L6E2A:  .byte   $5C
        .byte   $4F
        .byte   $57
        .byte   $D2
        cmp     $B7,x
        .byte   $39
L6E31:  adc     $B082
        asl     L2C42
        .byte   $C2
        and     ($AB),y
        jmp     (L81D0)

        tax
        .byte   $14
        .byte   $92
        sty     $88
        and     $E8,x
        .byte   $3A
        rts

        dec     $3F
        plp
        cmp     ($03),y
        sty     L811A
        bcs     L6E2A
        .byte   $C2
        .byte   $03
L6E52:  asl     $C5EC,x
        inc     $AB
        bpl     L6E07
        bmi     L6E83
        lsr     a
        .byte   $0E
        .byte   $10
L6E5E:  bit     L303A
L6E61:  .byte   $2C
L6E62:  bpl     L6E84
        jmp     L0620

        .byte   $04
        asl     $70
        .byte   $22
        sty     L12E1
        lda     #$F8
        .byte   $13
        bit     L819F
        .byte   $52
        sbc     #$F8
        .byte   $17
        bmi     L6E19
        sta     ($93,x)
        jsr     LB9E9
        rti

        .byte   $9F
        sta     ($34,x)
L6E83:  .byte   $29
L6E84:  sed
        ora     $44,x
        .byte   $9F
        sta     ($94,x)
        sei
        txa
        eor     L4E3F,x
        cpx     #$8A
        ldy     $FC,x
        ora     #$AC
        .byte   $4F
L6E96:  cpy     #$AA
        .byte   $D4
        .byte   $FC
        .byte   $0B
        ldx     $C04F
        dex
        .byte   $F4
        .byte   $FC
        ora     L87B0
        .byte   $07
        .byte   $0B
        .byte   $5A
        rol     $A8
        eor     $C2
        ror     $DC04,x
        .byte   $A7
        cpx     #$55
        .byte   $D2
        ror     $DD05,x
        .byte   $A7
        cpx     #$65
        .byte   $E2
        ror     $DE06,x
        ldx     $08
        lsr     $22
        .byte   $7E
        .byte   $04
L6EC2:  .byte   $A0
L6EC3:  .byte   $1A
        .byte   $DC
        .byte   $B1
L6EC6:  .byte   $93
        beq     L6EF8
        ora     $033F,x
        .byte   $32
        .byte   $1A
        ldy     $0A,x
        ora     L4CC9
        bcc     L6E61
        cpx     $FC
        ora     #$CF
        .byte   $4F
        cpy     #$AD
        .byte   $04
        .byte   $FC
        .byte   $0B
        cmp     ($4F),y
        cpy     #$CD
        bit     $FC
        ora     L29D3
        lsr     a
        lda     ($FE),y
        sty     $FC
        asl     L4FE7,x
        cmp     ($DE,x)
        .byte   $64
        .byte   $FC
        .byte   $1C
        sbc     $4F
        .byte   $C1
L6EF8:  ldx     $FC44,y
        .byte   $1A
        .byte   $E3
        .byte   $4B
        ora     ($AE,x)
        sty     $FC,x
        .byte   $1B
        nop
        .byte   $4F
        cmp     ($CE,x)
        ldy     $FC,x
        .byte   $1D
L6F0A:  cpx     $C14F
        inc     $FCD4
        .byte   $1F
        inc     L314B
        ldx     $FCF4
        .byte   $1B
        beq     L6F69
        cmp     ($CF,x)
        .byte   $14
        .byte   $FC
        ora     L4FF2,x
        cmp     ($EF,x)
        .byte   $34
        .byte   $FC
        .byte   $1F
        .byte   $F4
        .byte   $4B
        and     ($BF),y
        .byte   $54
        .byte   $FC
        .byte   $1C
        inc     $4F,x
        cmp     ($DF,x)
        .byte   $74
        .byte   $FC
        asl     L43F8,x
        sta     ($CF),y
        .byte   $94
L6F39:  .byte   $FC
        ora     L43FA,x
        ora     ($AD,x)
        cpx     $FC
        .byte   $1B
        .byte   $DF
        .byte   $4F
        cmp     ($CE,x)
        .byte   $04
        .byte   $FC
L6F48:  ora     L4FE1,x
        .byte   $C1
L6F4C:  inc     L0C24
        .byte   $1B
        .byte   $DB
        .byte   $4F
        cmp     ($DD,x)
        .byte   $D4
        .byte   $FC
        .byte   $1C
        .byte   $DC
        ora     ($04,x)
        lda     ($38,x)
        ror     $8E
        sta     $CD5A,y
        .byte   $43
        brk
        .byte   $1B
        pha
        .byte   $C3
        .byte   $02
L6F67:  cmp     #$40
L6F69:  sta     L8161,y
        eor     #$40
        dec     $A0,x
        .byte   $80
        lda     L40CE
        clc
        .byte   $23
        and     $63
        .byte   $3A
        ldy     #$33
        rol     $A92D
        ldy     #$C0
        sbc     #$D6
        .byte   $DC
        .byte   $3A
        .byte   $12
        lda     $AB
        .byte   $1F
        .byte   $5A
        ldx     #$40
        .byte   $02
L6F8C:  tay
        .byte   $E2
        ror     a
L6F8F:  txa
        lsr     $A2
        cmp     #$D0
L6F94:  .byte   $04
        .byte   $0B
L6F96:  nop
        php
L6F98:  .byte   $0C
        .byte   $9B
        .byte   $89
        bne     L6FBF
        .byte   $9E
        .byte   $E2
        and     ($E0,x)
        lda     $0C
        lda     L20C1
        ldy     $00
        .byte   $5C
        ldx     #$21
        rts

        lda     ($C0,x)
        dec     $C7AC,x
        pla
        bmi     L7012
        plp
        plp
        .byte   $F2
        .byte   $53
        and     $89,x
        nop
        bit     $CD1C
L6FBE:  .byte   $13
L6FBF:  lda     $1A
        ror     $B305
        and     #$4C
        .byte   $C2
        .byte   $E2
        .byte   $53
        and     ($88),y
        clc
        bpl     L7038
        asl     $0C
        ror     a
        asl     $02,x
        ror     a
        .byte   $04
        .byte   $92
        sta     ($A9,x)
        cpy     $C6
        iny
        .byte   $CB
        bmi     L6F98
        .byte   $9B
        cpx     #$0D
L6FE1:  .byte   $A3
L6FE2:  tsx
        ldy     L8BA2
        adc     ($E5),y
        .byte   $0C
        ror     $31
        .byte   $92
        jsr     L234D
        .byte   $83
        .byte   $13
        lda     L3398
        pha
        lda     (L0056),y
        ror     L2404
        .byte   $07
        sty     $39,x
        lda     L697A,y
        .byte   $9C
        jsr     L9B09
        lda     $61,x
        cmp     L813E
        .byte   $5B
        sta     $F0,x
        rol     $DE
        .byte   $3F
        bvc     L7071
        .byte   $26
L7012:  .byte   $12
        .byte   $61
L7014:  sty     $09
        rts

        and     ($80,x)
        ora     #$A0
        .byte   $13
        ora     #$33
        .byte   $82
L701F:  cld
        jsr     L3609
        .byte   $0C
        asl     a:$D5
        .byte   $0C
        ror     $B6
        .byte   $53
        sty     L1900
        txs
        adc     L4341,y
        bvc     L7014
        .byte   $EF
        bvc     L7057
        .byte   $B1
L7038:  .byte   $54
        .byte   $7A
        ora     $07,x
        rts

        .byte   $44
        ora     L7495
        tya
        ora     #$28
        brk
        php
        ora     #$93
        sed
        tya
        bvs     L6FE1
        .byte   $87
        adc     $4B
        txa
        .byte   $A3
        cmp     ($5E),y
        .byte   $AF
L7054:  .byte   $EB
        .byte   $5D
        .byte   $8D
L7057:  ldy     $53
        .byte   $62
        ldy     $7B,x
        txs
        .byte   $87
        .byte   $87
        .byte   $F2
        .byte   $80
        sta     $CD02
        .byte   $C3
        sty     $40,x
        .byte   $1A
        .byte   $8F
        .byte   $AF
        cli
        sbc     $E08E,x
        .byte   $0B
        .byte   $3A
        .byte   $BD
L7071:  cmp     $07
        .byte   $23
        ldx     $E9EE
        .byte   $AE
L7078:  bne     $703A
L707A:  cmp     L7550
        bvs     L70D7
        .byte   $D6
L7080:  cmp     $8E,x
        .byte   $53
        bvc     $70FD
        bne     L70A9
        .byte   $22
        .byte   $8E
        .byte   $21
L708A:  lda     ($51),y
        plp
        sbc     $A6
        lda     #$46
        ldy     #$04
        .byte   $FC
        dec     $2B
        .byte   $03
        adc     ($D5,x)
        .byte   $72
        txs
        jmp     (LEBAE)

        .byte   $2B
        lda     #$90
        .byte   $AE
L70A2:  bvc     L7054
        tay
        .byte   $F1
L70A6:  ora     #$D5
        .byte   $2C
L70A9:  php
        ora     $30,x
        stx     L2AE2
        .byte   $3B
        .byte   $83
        and     ($44),y
        and     #$BA
L70B5:  iny
        txs
        asl     $20,x
        ora     $16,x
        .byte   $B7
        .byte   $B2
        cpx     #$68
        .byte   $E2
        brk
        ora     ($02),y
        and     $08,x
        ora     $D08F
        tax
        bit     $20
L70CB:  dec     $A0,x
        .byte   $CB
        .byte   $1C
        .byte   $25
L70D0:  .byte   $E1
L70D1:  bpl     L70E9
        and     L2301,y
        .byte   $C2
L70D7:  ror     $B5E0
        ora     #$D3
        bit     L6AD4
        .byte   $83
        .byte   $1A
        sta     ($57,x)
        sec
        cmp     ($BF),y
L70E6:  adc     ($F4,x)
        .byte   $09
L70E9:  jmp     L82FC

        .byte   $53
        sta     $4C
        adc     L4057,x
        lda     ($BF),y
        ora     ($C0,x)
        rti

        .byte   $F4
        adc     $AC51,x
        ror     a
        ora     L401F
        .byte   $D4
        .byte   $D3
        .byte   $4D
L7102:  .byte   $23
        plp
        .byte   $AC
        .byte   $6C
L7106:  .byte   $D3
        and     L7080
        ora     #$17
        .byte   $74
        adc     L7C45,x
L7110:  .byte   $5F
        eor     $DD
        asl     $C0F4,x
        inx
        .byte   $14
        .byte   $62
        .byte   $02
        .byte   $51
L711B:  .byte   $EE
        .byte   $09
L711D:  adc     ($53,x)
        .byte   $57
        rol     $A4A8
L7123:  adc     $060A,x
        .byte   $D7
        .byte   $67
        .byte   $33
        ror     a
        rol     a
        ror     a
L712C:  sta     $C2AD,x
        .byte   $0F
        .byte   $83
L7131:  cpy     #$1A
        ror     $1C
        .byte   $32
        ldy     L161B
        .byte   $92
        stx     $DA,y
        .byte   $12
        .byte   $01
L713E:  .byte   $A3
        rti

L7140:  .byte   $57
        .byte   $D4
        asl     a
        txs
        .byte   $8B
        .byte   $14
        sbc     $06
        asl     $0315
        lda     #$92
        php
        lsr     a
L714F:  .byte   $22
        .byte   $3A
        .byte   $99
L7152:  .byte   $03
        ldx     $9B
        .byte   $44
        .byte   $EB
        ldx     $0151
        sta     ($5A,x)
        .byte   $64
        .byte   $C2
L715E:  .byte   $BB
        .byte   $57
        asl     a
        lda     ($FF,x)
        .byte   $D4
        .byte   $E2
        stx     $92,y
        .byte   $33
        plp
        .byte   $AF
        .byte   $07
        .byte   $87
        rts

        pla
        sbc     ($0D),y
        asl     L4FA0
        .byte   $54
        .byte   $1C
        jmp     (L7296)

        sta     ($04,x)
        ror     a
        .byte   $8F
        .byte   $1B
L717D:  .byte   $D7
        .byte   $7A
        brk
L7180:  brk
        .byte   $FC
        lda     ($20,x)
        ldy     $D0,x
        .byte   $AF
        tay
        plp
        ldy     $6C,x
        .byte   $D2
        adc     #$D0
        adc     #$49
        nop
        .byte   $1B
        nop
        rol     a
        bit     $0B
        .byte   $37
        .byte   $62
        bvc     L7152
        ldx     $09
        .byte   $89
        tay
        sbc     L288B,x
        .byte   $27
        .byte   $0B
        ldy     $1B
        .byte   $0C
        sbc     $0E
        .byte   $17
        sta     ($99,x)
        ldy     L627A
        bcc     L7131
L71B0:  txa
        cmp     $D0CD,y
        .byte   $3C
        ora     L7E53,x
        .byte   $B3
        stx     $6C,y
        .byte   $F2
        bne     L7203
        .byte   $03
        sta     ($A0),y
        .byte   $03
        ora     $B8B4
        .byte   $54
        .byte   $03
        .byte   $C2
        jmp     L526F

        .byte   $5F
        .byte   $C7
        cli
L71CE:  and     $26,x
        .byte   $45
L71D1:  .byte   $32
        ora     L295D,y
        .byte   $47
        rol     $29
        eor     #$BD
        .byte   $2F
        pha
L71DC:  and     #$C5
        asl     $E335,x
        adc     L5D54
        and     ($D5),y
        .byte   $47
        bne     L7266
        .byte   $87
        lda     $29
        cmp     $6C
        sbc     L411F
L71F1:  ldx     #$B5
        adc     $D809,x
        .byte   $7A
        php
        cli
        .byte   $7A
        php
        cli
        .byte   $7A
        .byte   $07
        nop
        .byte   $C7
        sbc     L5A10
L7203:  ldy     $78,x
        cld
        adc     $E158,x
        .byte   $64
        .byte   $27
        .byte   $61
L720C:  inx
        .byte   $1B
        .byte   $57
        rti

        eor     $46
        .byte   $F4
        .byte   $B9
L7214:  .byte   $14
        dec     $9D,x
        and     ($21),y
L7219:  rti

        cpx     $BD
        sta     ($40,x)
        rts

        and     L4085
        .byte   $B3
        beq     L71D1
        .byte   $02
        .byte   $02
        tya
        ldy     $8F43
L722B:  .byte   $C2
        .byte   $0C
        .byte   $FC
        bit     $E330
        sbc     ($03,x)
        .byte   $3F
        .byte   $0B
L7235:  eor     L0060,x
        and     $6A,x
        and     $48,x
        .byte   $0C
        .byte   $0B
        .byte   $0B
L723E:  sbc     ($FA),y
        .byte   $07
        .byte   $02
        .byte   $34
        .byte   $C7
        bne     L7276
        .byte   $27
        plp
        sbc     L7AFC,y
        rti

        bpl     L7263
        .byte   $13
L724F:  .byte   $D4
        .byte   $43
        rti

        plp
        .byte   $7C
L7254:  ora     ($89),y
        asl     a
        .byte   $41
L7258:  cpy     #$46
        plp
        rts

        sta     ($28),y
L725E:  jsr     LA8A7
L7261:  bcc     L7258
L7263:  bmi     L72B2
        nop
L7266:  sec
        ora     #$58
        .byte   $22
        asl     a
        ora     $CA
        .byte   $0F
        and     $07,x
        .byte   $80
        .byte   $80
        rts

        bcc     L72CE
        .byte   $B9
L7276:  .byte   $53
        .byte   $74
        lsr     $C2
        ora     ($06,x)
        bne     L72CA
        jmp     (L3426)

        bit     L3404
        .byte   $6C
L7285:  rti

        rts

        jmp     L5750

        ora     L8444,y
        .byte   $B3
        ror     $16,x
        .byte   $04
        ora     ($97,x)
        lda     ($22),y
        .byte   $2C
L7296:  brk
        .byte   $10
L7298:  clc
        php
        bit     $8B
        sei
L729D:  asl     L1C2C,x
        .byte   $C3
        .byte   $E2
        bne     L730C
        sed
        .byte   $21
L72A6:  .byte   $02
        cli
        clc
        jsr     L3285
        ora     ($44,x)
        asl     $05
        .byte   $0F
        .byte   $A5
L72B2:  nop
        .byte   $D7
        and     ($2E,x)
        sty     $18,x
        sta     $0C,x
        rti

        .byte   $12
        .byte   $57
        and     ($BA),y
        .byte   $7A
        clc
        bit     L6A96
        eor     ($5C,x)
        adc     L4757,y
        .byte   $21
L72CA:  lda     $E3,x
        .byte   $47
        .byte   $1E
L72CE:  sbc     ($66,x)
        ldx     #$15
        .byte   $7B
        .byte   $FA
        cld
        adc     $86,x
        .byte   $04
        bcs     L732F
        .byte   $BF
        .byte   $63
        .byte   $43
        clc
        .byte   $B3
        bvs     L7285
        .byte   $07
        .byte   $04
        and     ($2A),y
        ldx     $EB2F
        stx     L88F0
        lda     $3A
L72ED:  ora     $13,x
        sta     $BA60
        bne     L7364
        .byte   $44
        .byte   $02
        tax
        .byte   $F2
        ora     L89B1,x
L72FB:  clv
L72FC:  .byte   $F4
        .byte   $42
        .byte   $B2
        .byte   $F4
        ldy     $9D
        stx     $B0,y
        .byte   $02
        .byte   $04
        cli
        .byte   $23
        cpy     #$7E
        ror     $7B
L730C:  .byte   $C3
        inc     L7123,x
        lda     $AC
        .byte   $52
        lda     ($28),y
        .byte   $62
        sty     $4E
        rts

        bpl     L729D
        brk
        ror     $1C
        .byte   $14
        bvc     L7341
        .byte   $1A
        clc
        jsr     L1FA2
        .byte   $3B
        dey
        and     ($C1,x)
        rol     a
L732B:  .byte   $0B
L732C:  .byte   $C5
L732D:  .byte   $7B
L732E:  .byte   $8F
L732F:  ldx     L1C67
L7332:  .byte   $07
        dec     $E5
        adc     $FD05,y
        cpx     L17E0
        .byte   $8F
        .byte   $AC
L733D:  .byte   $29
L733E:  cmp     ($A0,x)
        .byte   $0F
L7341:  bcs     L73BE
        asl     a
        eor     $C0
L7346:  cmp     ($FC,x)
        asl     $41
        .byte   $0B
        .byte   $83
        .byte   $3B
        stx     $42
        .byte   $0F
        bpl     L732D
        .byte   $83
        rol     $DF5F,x
        .byte   $1C
        rti

        .byte   $F3
        .byte   $D3
        ldx     L89EE
        iny
        sbc     ($E4),y
        php
        .byte   $A3
        sta     ($23),y
L7364:  .byte   $54
        lda     ($E3,x)
        sbc     $36,x
        cld
        .byte   $C3
        lsr     $28
        brk
        sta     $AE4D,x
L7371:  rti

        .byte   $82
        ldx     #$35
        .byte   $0C
        .byte   $53
        .byte   $3F
        .byte   $75
L7379:  ldx     $9122,y
        dey
        and     #$47
        lda     $A87F,y
        sta     $78,x
        and     L4A82
        sta     L543C,y
        .byte   $1A
        .byte   $C2
        .byte   $D4
        .byte   $1A
        cpy     #$7B
        and     $C31E
        cpy     $2E
        .byte   $C3
        cpy     $2F
        .byte   $D4
        clc
        .byte   $1E
L739B:  ldy     $A84B,x
        .byte   $0C
        ora     $87,x
        .byte   $F9
L73A2:  dex
        brk
        .byte   $23
        .byte   $AB
        .byte   $1F
        ldy     $B1,x
        .byte   $64
        .byte   $B3
        .byte   $5C
        bvc     L741F
        sei
        inc     L82B0
        lda     $A407
        .byte   $89
        .byte   $37
        tay
        stx     $E81F
        bit     $E4A9
L73BE:  rts

        rol     $AC
        bvs     L739B
        .byte   $E7
        .byte   $97
        .byte   $34
        rti

        cpy     $00
        .byte   $04
L73CA:  .byte   $B2
        cpy     #$8C
        .byte   $04
        .byte   $B3
        ora     ($14,x)
        asl     $047C
        rti

        .byte   $C3
        .byte   $34
        php
        adc     ($F8),y
        adc     ($01,x)
        ldy     $52
        .byte   $43
        .byte   $07
        .byte   $33
        .byte   $76
L73E2:  cld
        cpy     #$AE
        .byte   $02
        cmp     $A76C,y
        sbc     ($02,x)
        ror     L230B,x
        adc     ($B0),y
        .byte   $C2
        bcc     L7440
        .byte   $83
        stx     L8A0D
        .byte   $13
        .byte   $DC
        ldy     $D864
        pla
        jmp     (L20D8)

        sta     (L003E,x)
        sta     $F01E
        ora     ($B0),y
        .byte   $6F
        .byte   $14
        cpy     #$85
        .byte   $D2
        .byte   $FC
        .byte   $AC
        .byte   $A1
L740F:  bmi     L73E2
        adc     ($3F),y
        asl     a
        asl     $20
        .byte   $52
        .byte   $DC
        ldx     #$04
        cpx     $10
L741C:  sed
        .byte   $F1
L741E:  .byte   $BD
L741F:  .byte   $62
L7420:  .byte   $DB
        ora     $84
        .byte   $89
        .byte   $5C
        eor     ($06,x)
        rol     L4A81,x
        .byte   $13
        clv
        jsr     L1440
L742F:  adc     ($30,x)
        ora     L3595
        .byte   $57
        lda     $97
        rti

        cmp     $5D
        brk
        .byte   $9E
        dex
        .byte   $54
        .byte   $74
        .byte   $72
L7440:  cld
        .byte   $87
        asl     $5D,x
        .byte   $DC
        lda     $1D,x
        .byte   $04
        asl     $09
        ora     $E351,y
        txa
L744E:  and     ($6D,x)
        bne     L7493
        .byte   $57
        lda     $B60E,x
        .byte   $CF
        lsr     a
        bpl     L744E
        .byte   $6C
L745B:  ora     #$DE
        .byte   $DF
        bit     L6D33
L7461:  .byte   $7A
        .byte   $9E
        ldx     #$64
        sec
        .byte   $07
        php
        eor     ($12,x)
        cmp     ($19),y
        .byte   $F3
        asl     L1808
        .byte   $12
        asl     L0C30,x
        cpy     #$4C
L7476:  .byte   $0C
        bmi     L74C9
        php
        bne     L741C
        ora     #$A9
        adc     $0A
        cmp     ($3A,x)
        sbc     ($93),y
        .byte   $02
        lda     ($C5),y
        sty     $E70E
        dec     $06
        .byte   $9B
        .byte   $17
        .byte   $8F
        cmp     L70B5,y
        .byte   $E2
L7493:  sta     ($57),y
L7495:  lda     $CD
        .byte   $A7
        eor     L55D5
        .byte   $9B
        adc     L6DF5
        cmp     L7945,x
        plp
        .byte   $65
L74A4:  .byte   $8B
        sei
        .byte   $1A
        ora     $4C
        .byte   $EB
        .byte   $57
        .byte   $97
L74AC:  .byte   $44
        .byte   $DA
        .byte   $AB
        ldy     L3F1E
        ror     $EB
        .byte   $47
        .byte   $89
        and     L4EAB
        .byte   $03
        .byte   $57
        ldy     #$48
        ora     $E05E
        lsr     $1E,x
        jsr     L36F6
        asl     $05,x
        .byte   $4D
        .byte   $25
L74C9:  eor     $A8
        .byte   $54
        lsr     a
        .byte   $41
L74CE:  .byte   $80
        plp
        and     $A011,x
        .byte   $E2
        .byte   $02
        lda     ($21,x)
        eor     ($F4),y
        and     #$13
        sta     ($C8),y
        .byte   $0C
        .byte   $17
        lsr     $D458,x
        .byte   $D7
        inx
        .byte   $54
        .byte   $6D
L74E6:  .byte   $83
        ora     ($72,x)
        .byte   $92
        and     $0A
        dey
        .byte   $9B
        .byte   $C7
        inx
        and     ($28,x)
        adc     #$C7
        tay
        ora     L74A4,y
        .byte   $C7
        rti

        eor     L5938,x
        sta     ($92,x)
        .byte   $87
L7500:  sta     $966A,y
        .byte   $1F
        .byte   $12
        .byte   $C2
        ora     ($28),y
        sta     ($ED,x)
        .byte   $7A
L750B:  rol     L5181
        sty     $0D,x
        ora     #$C0
        eor     $51,x
        .byte   $52
        .byte   $F2
        ora     ($50,x)
        ldx     #$11
        dex
        .byte   $14
        eor     #$17
L751E:  ora     ($FA,x)
        .byte   $B3
        .byte   $5A
        beq     L74CE
        ldy     #$78
        .byte   $0C
        .byte   $1F
        sty     $1C,x
        lsr     a
        sec
        lda     #$D7
        jmp     L942C

        rol     L8029
        .byte   $62
        .byte   $3A
        .byte   $0F
        and     L8D41,x
        lda     #$A4
        .byte   $3A
        pla
        .byte   $2B
L753F:  .byte   $14
        .byte   $14
        .byte   $9F
        .byte   $D4
        tay
        .byte   $82
        .byte   $B2
        stx     $9D
        .byte   $FF
        .byte   $16
L754A:  .byte   $6C
        .byte   $C9
L754C:  sbc     $26
        beq     $7580
L7550:  bcc     L75A0
        dec     L00F9,x
        eor     ($84,x)
        .byte   $FA
        .byte   $A7
        .byte   $52
        .byte   $42
        .byte   $2B
        .byte   $F2
        stx     $80,y
        .byte   $CB
        cli
        cpy     #$1A
        .byte   $02
        sta     L6240,y
L7566:  brk
        .byte   $5A
L7568:  bit     $D800
        .byte   $C0
L756C:  .byte   $02
        .byte   $1A
L756E:  .byte   $AB
        and     L8589,x
L7572:  .byte   $87
        eor     ($9C,x)
        .byte   $47
        eor     #$87
        .byte   $C7
        ora     ($9E,x)
L757B:  .byte   $87
        .byte   $3A
        .byte   $C2
        eor     #$F5
        .byte   $9E
        asl     $F1,x
        .byte   $51
L7584:  .byte   $FC
        adc     $AFDB,y
        ldx     $E275
        .byte   $3C
        inc     $02
        .byte   $12
L758F:  ror     a
        .byte   $0C
L7591:  .byte   $13
        dec     L384A,x
        .byte   $C9
L7596:  cmp     $F0D3
        bcs     $75A3
        inc     $9E53,x
        .byte   $3C
        txs
L75A0:  dec     $0139,x
        stx     $61
        .byte   $BF
        .byte   $37
        and     ($C2),y
        .byte   $4F
        bmi     L75BE
        .byte   $1B
        cmp     $E22D,x
        ror     $78
        txa
        .byte   $F2
        .byte   $30
L75B5:  cpx     #$B6
        eor     $02,x
        sta     $62
        beq     L7605
        sei
L75BE:  .byte   $22
        asl     $75
        .byte   $83
        .byte   $02
        .byte   $74
        .byte   $1A
        bpl     L75DC
        cmp     L67D5
        clv
        ror     L4791,x
        .byte   $C7
        cmp     $C141
L75D2:  .byte   $13
        .byte   $F4
        eor     ($9D),y
        and     $53
L75D8:  bvc     L75EB
        .byte   $BD
        .byte   $32
L75DC:  .byte   $C3
        .byte   $C2
        sbc     $4A,x
        sta     $C11C,y
        lda     $41,x
        sta     $0682,y
        adc     L2940
L75EB:  .byte   $B2
        sta     L413C,x
        and     ($92,x)
        eor     ($26),y
        .byte   $12
        jsr     L6A11
        .byte   $0F
        txa
        .byte   $9B
        and     L79D6
        clc
        .byte   $73
        .byte   $7A
        .byte   $7C
        ora     ($33,x)
        lda     $FB,x
L7605:  bmi     L7681
        .byte   $8B
        adc     ($29,x)
        bne     L7676
        lsr     L1ADE,x
        eor     L818C
        sec
        lda     #$F6
        rol     a
        clc
        asl     L8195,x
        .byte   $80
        sta     ($E1),y
        sty     $E091
        lda     ($E1,x)
        ora     #$E2
        sta     $F2A8,x
        asl     a
        bpl     L75B5
        eor     $BCA8,y
        .byte   $22
        .byte   $14
        dec     L61AA,x
        sta     ($A0,x)
        .byte   $9B
        ldy     $86
        lda     ($41,x)
        .byte   $9C
        .byte   $B2
        .byte   $27
        lda     #$54
        dec     $DABE,x
        ldx     #$23
        cmp     $E0E1
        asl     $9C
        ldy     $A77E
        .byte   $73
        .byte   $33
        .byte   $1B
        nop
L764F:  plp
        .byte   $1C
        .byte   $CB
        .byte   $3C
        ora     #$0A
        cli
L7656:  .byte   $C2
        pha
        .byte   $24
L7659:  sta     ($93,x)
        rol     L295E
        bvc     L7689
        plp
        .byte   $52
        ora     $8C,x
        .byte   $33
        .byte   $74
        jsr     L754C
        nop
        .byte   $AB
        .byte   $0C
        .byte   $07
        sta     ($D0),y
        bmi     L76ED
        pha
        .byte   $D4
        .byte   $80
        rti

        .byte   $11
L7676:  .byte   $3F
        .byte   $3B
        sta     $C6
        cmp     ($14,x)
        .byte   $83
        .byte   $72
        .byte   $23
        and     ($39),y
L7681:  .byte   $B3
        inc     $C4
        beq     L76D7
        stx     $0460
L7689:  .byte   $A3
        .byte   $4C
        .byte   $A9
L768C:  .byte   $FA
        .byte   $9F
        eor     #$DC
        asl     $0E,x
        asl     a
        .byte   $14
        bpl     L76E0
        cmp     L11ED
        .byte   $33
        cmp     ($02,x)
        .byte   $34
        .byte   $82
        adc     #$D0
        bit     $40
        sta     L1CA6
        .byte   $B0
L76A6:  cmp     ($8D,x)
        jsr     L010A
        .byte   $E2
        sty     $E026
        sec
        .byte   $C2
        adc     $8B,x
        lda     ($40,x)
        .byte   $C7
        .byte   $AB
        rol     L3C1B
        .byte   $17
        .byte   $64
        .byte   $0C
        cpx     #$5A
        and     ($2C,x)
        .byte   $AF
        brk
        inx
        ora     #$69
        .byte   $80
        sty     L38FC
        .byte   $0F
        .byte   $80
        ldx     $18,y
        .byte   $0B
        .byte   $CF
        sty     $CFAB
        .byte   $C3
        ldy     $B6FC
L76D7:  cli
L76D8:  ora     $B681
        pha
        brk
        .byte   $CF
        .byte   $C2
        .byte   $8C
L76E0:  .byte   $FC
        ldx     $4E
        jsr     LC081
        adc     ($1E),y
L76E8:  .byte   $BF
        adc     $040F,y
        .byte   $7C
L76ED:  .byte   $43
        iny
        .byte   $7C
        and     ($DA,x)
        sei
L76F3:  .byte   $7B
        ror     a
        lsr     $9C,x
        .byte   $BF
        .byte   $47
        eor     #$F5
        adc     #$98
        sbc     ($31),y
        bvs     L7752
        lda     ($C0),y
        .byte   $52
        rti

        sbc     ($58),y
        and     #$35
        asl     $A5
        .byte   $17
        asl     $A7
        .byte   $6F
        .byte   $73
        bvc     L76F3
        jsr     L4051
L7715:  .byte   $DA
L7716:  adc     $42
        .byte   $13
        .byte   $04
        sta     $45
        .byte   $02
        .byte   $63
        .byte   $72
        sta     L42A1,x
        sta     $69
        .byte   $05
L7725:  .byte   $04
L7726:  .byte   $42
        lda     $41,x
        tay
        .byte   $7F
        ora     $F081,y
        bcs     L7780
        plp
        .byte   $DF
        .byte   $1C
        .byte   $A7
        brk
        .byte   $3A
        adc     L166C
        .byte   $C7
        .byte   $5A
        bvc     L76D8
        .byte   $1C
        cli
        .byte   $43
        tay
        .byte   $FA
        lda     $DE
        cmp     $14
        .byte   $0B
        ldx     $32
        adc     #$A2
        .byte   $92
        bvc     L77B8
        inc     $EE,x
        txa
        pla
L7752:  sbc     L1E8F,x
        bvc     L77D1
        eor     ($A0,x)
        txs
        adc     $BCFE
        sta     ($03,x)
        and     #$B4
        beq     L77DB
        ora     $A40C
        .byte   $7A
        sbc     $7D
        .byte   $13
        stx     L3AE0
        beq     L77C3
        ldx     a:$1E
        .byte   $EB
        ldx     #$EA
        adc     ($91),y
L7777:  php
        lda     ($E1),y
        .byte   $5B
        .byte   $A7
        .byte   $67
        iny
        .byte   $FE
        .byte   $A3
L7780:  dec     $AD
        brk
        pla
        .byte   $D3
L7785:  sta     $98
        .byte   $A3
        asl     a
        and     $04,x
        ldx     $AE
        ldx     $A2
        rol     $14
        sta     ($F4),y
        .byte   $D7
        .byte   $0F
        tax
L7796:  clc
        lda     $9478
        asl     a
        .byte   $53
        bcs     L7796
        eor     $68,x
        .byte   $30
L77A1:  clc
        and     $7C,x
        .byte   $14
        .byte   $13
L77A6:  .byte   $5A
        sbc     ($01),y
        .byte   $8B
        clv
        .byte   $FA
L77AC:  tax
        lsr     L8A82,x
        .byte   $33
        adc     $44,x
        .byte   $63
        dec     $A6
        .byte   $1A
        .byte   $5E
L77B8:  lsr     a
        .byte   $5C
        rts

        clv
        sbc     $AA8F,x
        lsr     $90,x
        tay
        .byte   $55
L77C3:  ora     L7EA5
        .byte   $8F
        .byte   $DA
        .byte   $53
        txs
        .byte   $57
        jsr     L7988
L77CE:  ldx     #$EC
        .byte   $26
L77D1:  .byte   $8B
        clv
        .byte   $1F
        .byte   $8F
        .byte   $1A
        txs
        lda     ($D2,x)
        .byte   $3B
        .byte   $82
L77DB:  adc     $69,x
        bcs     L7777
        bne     L77F6
        lda     ($14,x)
        .byte   $12
        txa
        rts

        tsx
        lsr     $F0DA,x
        .byte   $71
L77EB:  ldx     $19
        rol     $E3
        tax
        and     #$1B
        sta     ($11,x)
        clv
        .byte   $04
L77F6:  ora     ($5E),y
        cmp     $D5
        sbc     $8B
        jmp     L8403

        .byte   $47
        cpx     L836F
L7803:  eor     L22E3,y
        ora     L56CA
        eor     ($1E,x)
        bcc     L77A6
        .byte   $5B
        .byte   $6F
        .byte   $57
        sta     L4D24
        cli
        .byte   $34
        sbc     ($66),y
        ora     ($C7,x)
        .byte   $5C
        .byte   $03
        nop
        sty     $8D
        .byte   $57
        .byte   $7B
L7820:  .byte   $93
        .byte   $6B
        .byte   $14
        brk
        ror     $C7
L7826:  .byte   $83
        sty     $940B
        clc
        .byte   $42
        rol     L74AC,x
        .byte   $4B
        txa
L7831:  asl     a
        .byte   $0D
        .byte   $C1
L7834:  asl     $AB17,x
        .byte   $D2
        bne     L783E
        .byte   $13
        .byte   $14
        .byte   $32
        .byte   $0D
L783E:  nop
        .byte   $97
        .byte   $03
        sbc     $3A
        .byte   $A3
        txa
        .byte   $3C
        adc     ($AA,x)
        rol     $CF2B
        .byte   $9F
        .byte   $D4
        asl     L4215
        .byte   $6B
        .byte   $57
L7852:  adc     $C447,y
        .byte   $2B
        .byte   $92
        cpx     #$A0
        .byte   $7A
        ora     $79,x
        adc     #$2B
        eor     ($00,x)
        adc     $C144,y
        jmp     (L3261)

        .byte   $9C
L7867:  sta     ($E2),y
        rol     $CB99
        lda     ($9E,x)
        ora     $A8
        sty     $E5,x
        asl     $17,x
        .byte   $AF
        .byte   $43
        txs
        and     L62C3,x
        tya
        rol     $BE
        .byte   $12
        cmp     #$AC
        lsr     $B0
        .byte   $33
        cmp     L3542
        .byte   $47
        .byte   $C2
        .byte   $AB
        and     ($A3,x)
        ror     a
L788C:  sta     ($D3),y
        lsr     $22,x
        cmp     ($42,x)
        .byte   $63
        ora     ($C0),y
        sed
        .byte   $54
        .byte   $74
        tay
        sty     $50,x
        bcs     L7831
        .byte   $0C
        ror     $20,x
        .byte   $83
L78A1:  .byte   $E3
        .byte   $F4
        .byte   $42
        .byte   $A3
        bne     L790A
        sta     ($51),y
        .byte   $42
        .byte   $E2
        bvc     L78EF
        plp
        dey
        .byte   $22
        .byte   $D5
L78B1:  .byte   $03
        ldx     $BE
        cpx     #$72
        and     L45C1,x
        stx     L0081
        .byte   $44
        cmp     $01
        pha
        .byte   $03
L78C0:  pla
        ora     ($D5,x)
        .byte   $0F
        dey
        .byte   $80
        .byte   $DA
        .byte   $74
        ora     $07,x
        .byte   $04
        .byte   $93
        sbc     #$A3
        .byte   $74
        .byte   $F4
        asl     $04,x
        cmp     $94D2,y
        sbc     #$DC
        .byte   $04
        lsr     a
        .byte   $1A
        asl     $97,x
        sbc     L0C84
        .byte   $42
        .byte   $A3
        .byte   $82
        .byte   $50
L78E3:  ora     #$B3
        .byte   $53
        rts

        .byte   $4C
        .byte   $B0
L78E9:  cpx     L3EB6
        lda     $A1
        .byte   $E6
L78EF:  ldy     #$EB
        eor     ($B0),y
        ldx     L1050,y
        inc     $F4,x
        .byte   $F4
        lsr     $B6
        .byte   $37
        and     L1843,x
        bvs     L7942
        .byte   $02
        bcs     L795B
        ora     ($04),y
        .byte   $1B
        .byte   $54
        ora     ($96),y
L790A:  sta     $BD,x
        jmp     L2A41

        ora     #$53
        ora     $37
        .byte   $03
        .byte   $92
        eor     $98
        .byte   $3A
        ldy     $29,x
        ror     L8279
        rti

        sbc     ($52),y
        sta     L8D93
        lda     L65D4,y
        bmi     L792A
        lsr     a
        .byte   $2F
L792A:  asl     $5E
L792C:  .byte   $D1
L792D:  .byte   $24
L792E:  .byte   $8B
        php
        ror     a
        iny
L7932:  ora     $89
        ldx     $CE
        .byte   $31
L7937:  bvc     L792D
        ldy     #$12
        bpl     L798B
        sty     $64
        ldx     $54,y
        .byte   $74
L7942:  and     $55,x
        .byte   $3B
L7945:  ora     ($11,x)
        lsr     L0E08,x
        ror     a
        .byte   $14
        ora     ($19,x)
        eor     $62,x
        .byte   $52
        .byte   $1C
        .byte   $43
        .byte   $FC
        jmp     (L0304)

        .byte   $43
        .byte   $5C
        dec     $9E,x
L795B:  brk
L795C:  dex
        .byte   $54
        jsr     LCA30
        tya
        .byte   $43
        sta     $A7
        and     $B078
        .byte   $52
        .byte   $2B
        .byte   $03
        .byte   $D2
        .byte   $84
L796D:  bne     L795C
        .byte   $14
        .byte   $D3
        lsr     $AA50,x
        adc     #$46
        ror     $D7,x
        .byte   $C9
L7979:  sbc     $62
        .byte   $5A
        .byte   $7A
        sta     $C40D
        sta     L143A
        .byte   $43
        .byte   $80
        clc
        and     $69,x
L7988:  cpy     $FA5B
L798B:  dec     $6D,x
        cli
        sbc     ($7D),y
        .byte   $57
        sta     L6F8C
        lsr     a
        sbc     #$02
        and     L1DE9,x
        brk
        nop
        .byte   $04
        sty     $1D
        .byte   $5A
        adc     L73CA
        stx     $F811
        plp
        .byte   $54
        pla
        .byte   $03
        sta     $6A
        sta     $0C
        .byte   $D3
        .byte   $1A
        .byte   $74
        ldx     $91,y
        sbc     $15,x
        sta     ($23,x)
        lda     ($70),y
        ora     L6CCA,y
        .byte   $33
        .byte   $4B
        .byte   $3F
        .byte   $AB
        lsr     $9C
        ora     $B56A,x
        sta     L4751
        lsr     L56F1
        .byte   $3C
        .byte   $27
L79CD:  rti

L79CE:  rol     $CBB4,x
        bit     $D6D7
        .byte   $9B
        .byte   $97
L79D6:  asl     a
L79D7:  .byte   $02
        txs
        .byte   $C2
        bmi     L79CD
        lda     $68
        ora     $CE3A,x
        sty     $C6
        .byte   $80
        sta     L0C7A
        .byte   $FA
        sty     $02
        .byte   $D2
        dec     $9872
        .byte   $93
        .byte   $53
        iny
        .byte   $1B
        .byte   $4B
        .byte   $FF
        eor     #$55
        dex
        .byte   $34
        ora     L4447
        asl     $E844
        sta     $28
        .byte   $DC
        sei
        pla
        .byte   $B3
        .byte   $53
        lsr     L82C1,x
        .byte   $E7
        bit     $A1
        .byte   $C2
        .byte   $24
L7A0D:  ldx     #$82
        rts

        .byte   $9F
        .byte   $AB
        ldx     #$A2
        and     ($8D),y
        and     $BE15
        .byte   $5B
        rti

        bvc     L7A0D
        eor     (L0060,x)
        .byte   $05
L7A20:  .byte   $01
L7A21:  .byte   $62
        sty     L48FD
        bmi     L7A5D
        .byte   $80
        .byte   $CF
        lda     ($80,x)
        adc     ($62),y
        brk
        sta     ($61,x)
        .byte   $0C
        sbc     L090E,x
        asl     $1E,x
        plp
        dec     $9B51
        .byte   $65
L7A3B:  .byte   $82
        asl     $8F71
        clc
        .byte   $CF
        .byte   $C7
        dec     $CC71,x
        dey
        .byte   $CF
        lsr     a
        ror     L0081
        .byte   $3C
        .byte   $FC
L7A4C:  adc     $09,x
        .byte   $80
        sbc     ($98),y
        eor     ($9F,x)
        .byte   $4F
        .byte   $DF
        .byte   $5C
        .byte   $07
        brk
        dex
        lda     $6B,x
        plp
        .byte   $A2
L7A5D:  .byte   $03
        cli
L7A5F:  adc     #$35
        lda     ($C8,x)
        rol     L003E,x
        .byte   $A1
L7A66:  lsr     $3F
        ror     a
        .byte   $F4
        and     $0B
        ora     $35
        .byte   $8F
        .byte   $DA
        .byte   $F7
        sec
        .byte   $14
        sta     ($22,x)
        tax
        .byte   $62
        .byte   $04
        .byte   $13
        .byte   $54
        ldx     L823E,y
        .byte   $A3
        inx
        .byte   $92
        tya
        .byte   $6F
        .byte   $82
        adc     $08,x
        .byte   $E2
        ora     ($05),y
        .byte   $04
        eor     ($5E,x)
        ora     $28,x
        .byte   $03
        ora     $88
        .byte   $1A
        .byte   $77
        .byte   $57
        sbc     $10,x
        ldx     $90
        .byte   $69
L7A98:  .byte   $AB
L7A99:  pla
        ora     $4B,x
L7A9C:  .byte   $04
        and     $20,x
        .byte   $07
        .byte   $AB
        eor     ($8A,x)
        .byte   $34
        dey
        bvc     L7AD0
        .byte   $89
        iny
        asl     L1502,x
        .byte   $14
        .byte   $8F
L7AAE:  tax
        .byte   $52
        sta     ($0A),y
        pla
        ror     a
        .byte   $3F
        .byte   $63
        bvs     L7B0E
        sta     ($E1,x)
        plp
        .byte   $F7
        .byte   $82
        lda     ($51),y
        and     #$AD
        .byte   $2B
        cli
        cpy     L087A
        sta     ($D5,x)
        cpy     $1C
        php
        adc     L8024
        .byte   $03
        .byte   $65
L7AD0:  .byte   $2B
        sta     ($9B,x)
        .byte   $1C
        brk
        .byte   $9B
        ora     $00
        .byte   $D3
        .byte   $04
        .byte   $33
        .byte   $A3
        .byte   $7F
        cpy     #$42
        ror     $076B,x
        .byte   $27
L7AE3:  .byte   $E7
        .byte   $80
        jmp     (LCB00)

        ora     #$E1
        .byte   $03
        sbc     ($00,x)
        txa
        inc     $14,x
        .byte   $03
        cmp     L637D
        asl     a
        ora     $87,x
        .byte   $73
        and     $CCA4
        .byte   $01
L7AFC:  .byte   $04
        iny
        ora     ($06,x)
        cmp     $D147,y
        .byte   $6F
        .byte   $E2
        ror     L7785,x
L7B08:  .byte   $52
        .byte   $62
        .byte   $BB
        .byte   $4F
L7B0C:  .byte   $7C
        .byte   $E3
L7B0E:  .byte   $D2
        cpx     #$F6
        .byte   $E2
        rti

        .byte   $2F
        asl     $0E
        ora     #$AE
        bvs     L7B2C
        bvc     L7B08
        .byte   $BF
        lsr     $08
        .byte   $E3
        iny
        eor     $23,x
        .byte   $0C
        sty     $84
        lda     #$86
        .byte   $32
        lsr     a
        .byte   $1A
        .byte   $A3
L7B2C:  .byte   $89
        .byte   $23
        asl     $08
        bpl     L7B78
        asl     L7572
        .byte   $04
        .byte   $D7
        sbc     L2F18,y
        .byte   $32
        pha
        ora     $E7,x
        lda     $10
        .byte   $57
        .byte   $9E
        .byte   $6F
        asl     L8B3C,x
        eor     ($5D,x)
L7B48:  inc     $DF
        dec     L0D50
        .byte   $C3
        .byte   $1F
        .byte   $0E
        tya
L7B51:  dec     $D0
        .byte   $27
        asl     $CF,x
        .byte   $04
        eor     L118F,y
        tya
        .byte   $E7
        .byte   $B2
        cmp     $00
        bpl     L7B61
L7B61:  .byte   $DB
        .byte   $67
        lsr     L64A0,x
        sei
        .byte   $9D
L7B68:  sta     $BC
        sbc     #$BA
        brk
        eor     ($1D,x)
        .byte   $0C
        .byte   $32
        eor     ($1B,x)
        .byte   $0C
        ror     $25
L7B76:  .byte   $1A
        php
L7B78:  beq     L7BDB
        cpy     $F7A6
        sta     L753F,x
        eor     $9F
        ldy     #$9D
        dec     $7F,x
        sei
        and     #$ED
        bcs     L7B0C
        jmp     (LE9B6)

        pha
        .byte   $67
        .byte   $CF
        .byte   $02
        clc
        .byte   $0C
        dec     $0439,x
        cmp     $48,x
        cmp     ($9C,x)
        adc     L1F9A,x
        ora     #$9C
        .byte   $E2
        sbc     L1A84
        dey
        sty     $92
        txa
        .byte   $82
        .byte   $1A
        cmp     ($5D,x)
        .byte   $1F
        .byte   $44
        .byte   $A3
L7BAF:  ldy     $26,x
        .byte   $C7
        ldy     #$74
        .byte   $64
        .byte   $0B
        .byte   $C7
        dey
        cpy     $5E
        bpl     L7C03
        cmp     $22,x
        bmi     L7C24
        sei
        sty     $D3
        sty     L9828
        lda     $F979
        .byte   $83
        .byte   $53
        .byte   $A7
        dey
        .byte   $22
        .byte   $8B
        bit     $21
        cpy     $91
        jsr     L7834
        cpy     #$74
        ldy     $A11A
L7BDB:  .byte   $30
L7BDC:  asl     $6F
        jmp     L1074

        ora     ($82,x)
        sta     $83
        .byte   $52
        .byte   $44
        .byte   $02
        ror     $30
        .byte   $54
        inx
        eor     ($63,x)
        iny
        ror     a
        bmi     L7BFB
        pha
        lda     $E1EA,x
        .byte   $47
        clv
        .byte   $1F
        .byte   $AC
        .byte   $94
L7BFB:  .byte   $42
        sta     L355F,y
        adc     L1A41
        .byte   $F4
L7C03:  .byte   $E6
L7C04:  .byte   $07
        adc     ($67,x)
        lsr     $9C,x
        ora     ($99,x)
        .byte   $1B
        .byte   $96
L7C0D:  eor     ($98,x)
        ora     ($61,x)
        .byte   $81
L7C12:  asl     $71
        ror     a
        rol     $57,x
        rti

        .byte   $1E
L7C19:  ora     #$67
        .byte   $99
        .byte   $B5
L7C1D:  brk
        eor     $B5
        rol     $9C7C
        .byte   $EB
L7C24:  bpl     L7BAF
        tsx
        .byte   $1C
        bmi     L7C3A
        .byte   $04
        .byte   $7F
        eor     L4B83,y
        bcc     L7C12
        sei
        .byte   $63
        .byte   $9F
        .byte   $03
        asl     a
        beq     L7C19
        .byte   $43
        rti

L7C3A:  ora     ($3A,x)
L7C3C:  cpy     $90
        .byte   $E3
        .byte   $E3
        .byte   $3C
        .byte   $03
        lda     $AB,x
        .byte   $0E
L7C45:  .byte   $0B
        dec     $BC08,x
        beq     L7C0D
        .byte   $63
        .byte   $0F
        .byte   $CB
        .byte   $89
        .byte   $FB
        .byte   $03
        sec
        asl     L6B7C,x
        adc     L0C9E,x
L7C58:  .byte   $02
        .byte   $DB
        cli
        .byte   $02
        bpl     L7C84
        cmp     $04,x
        .byte   $12
        cpy     $20
        bvs     L7C87
        .byte   $C2
        .byte   $04
        asl     $DC,x
        .byte   $8F
        .byte   $72
        .byte   $C2
        ora     L6DF9,y
        and     ($DE,x)
        .byte   $62
        .byte   $44
        ora     $B0F8,y
        .byte   $13
        ora     $6C
        rti

        eor     ($19),y
L7C7C:  adc     L6100
        .byte   $9F
        txa
        asl     a
        ora     ($DA),y
L7C84:  sbc     $8C,x
        .byte   $C9
L7C87:  jsr     LC000
L7C8A:  bne     L7C84
        .byte   $63
        brk
        rol     $E252
        .byte   $4F
        .byte   $0F
        .byte   $DF
        .byte   $7C
        .byte   $D3
        lda     $2B,x
        cli
        tax
L7C9A:  rol     $9F2B,x
        pha
        .byte   $B7
        asl     $EC94,x
        ora     $FA1E
        lda     ($61,x)
        sta     $F0,x
        ldx     $9A4D,y
        adc     ($AA,x)
        ora     ($23,x)
        txa
        .byte   $CF
        ldx     #$56
        ora     $CE6B,x
        asl     a
        .byte   $6D
        cli
L7CBA:  .byte   $EF
        dey
L7CBC:  .byte   $13
        .byte   $5F
        and     ($E8,x)
        .byte   $54
        .byte   $6F
        .byte   $C3
        and     $75
        .byte   $FF
        ora     ($51,x)
        .byte   $B9
L7CC9:  pha
        cpy     $09
        .byte   $57
        ora     $9F,x
L7CCF:  .byte   $33
        jmp     (L0256)

        .byte   $8B
        lsr     L0081
        eor     $1B,x
        sta     ($55,x)
        .byte   $E7
        .byte   $FC
        ora     $47,x
        cli
        .byte   $D7
        tay
        bvc     L7C87
        adc     L470A,x
        cmp     $2F,x
        pha
        .byte   $57
        .byte   $AB
L7CEB:  tya
        adc     ($2C),y
        eor     $5A,x
        cmp     L7EB4
        eor     $E4F0,y
        .byte   $D7
        tax
        sbc     $32,x
        .byte   $9B
        ora     $B1,x
        lda     ($57,x)
        adc     L0056,x
        rti

        rti

        .byte   $FC
        ldy     #$81
        rol     $3A,x
        ldy     $83
        .byte   $FA
        cld
L7D0C:  cpy     L327D
L7D0F:  .byte   $9B
        adc     $EF
        .byte   $EB
        .byte   $5F
L7D14:  .byte   $1F
        lda     L8379,x
        .byte   $FA
        .byte   $C7
        sbc     $0B
        cmp     $D9,x
        cmp     $4C,x
        .byte   $F4
        sbc     ($DD),y
        dec     $B0
        lda     $049F,x
        bmi     L7D3E
        lsr     L0056,x
        cpx     $F35A
        and     #$D4
        .byte   $7A
        .byte   $0B
        eor     #$5F
        .byte   $57
L7D36:  ldy     $7F
        .byte   $57
        clv
        and     $987A,x
        .byte   $81
L7D3E:  .byte   $D4
        .byte   $AB
        .byte   $1F
        lsr     L68B5,x
        eor     $F5,x
        .byte   $77
        .byte   $7A
        ora     ($01,x)
        dec     $9C,x
        .byte   $57
        .byte   $8F
        cmp     L3B32
        .byte   $03
        dex
        eor     #$90
        .byte   $1B
        eor     L4488
        txs
        .byte   $DA
        and     $72
        rol     L87BC
        .byte   $44
        cmp     $39,x
        .byte   $8B
        .byte   $D7
        .byte   $CE
        .byte   $64
L7D67:  .byte   $52
        .byte   $12
        asl     a
        .byte   $02
        .byte   $13
        lsr     L357A
        .byte   $EF
        .byte   $67
        eor     ($E8,x)
        sec
        lsr     $A8
        adc     $F67B
        .byte   $57
        .byte   $D3
        .byte   $23
        .byte   $57
        cmp     $E5,x
        .byte   $7A
        .byte   $62
        .byte   $82
        brk
        .byte   $C7
L7D84:  ldy     #$65
        .byte   $87
        ldy     #$64
        .byte   $12
        .byte   $CD
L7D8B:  adc     #$80
        bvc     L7D0F
        rol     a
        .byte   $F4
        .byte   $02
        sta     $1D
        eor     ($E0),y
        .byte   $63
        .byte   $53
        rti

        .byte   $0C
        bvc     L7D84
        .byte   $43
        rol     $00
        cmp     $14,x
        clc
        and     $A4
        iny
        .byte   $8F
        .byte   $DA
        adc     ($75),y
        sbc     $95,x
        sec
        and     L712C,y
        .byte   $52
        adc     ($6A,x)
        sta     ($88),y
        bvc     L7D8B
        .byte   $AB
        eor     #$F7
        adc     ($F5,x)
        .byte   $47
        .byte   $A7
        and     #$90
        adc     L5556,x
        .byte   $9C
        ora     ($F4),y
        .byte   $3A
        ora     ($70,x)
        .byte   $53
        ror     a
        sta     $D8,x
        .byte   $7A
        .byte   $02
        cld
        .byte   $7A
        .byte   $12
        .byte   $DC
        .byte   $9E
L7DD3:  sty     $F7
        .byte   $17
        .byte   $A7
        .byte   $AB
        .byte   $72
        sty     $7C
        jsr     L9062
        bvc     L7E00
        ror     $2A,x
        .byte   $6F
        .byte   $47
        eor     ($F5,x)
        .byte   $8F
        lsr     a
L7DE8:  adc     $ADB1,y
        adc     L8610,x
        .byte   $7A
        lda     ($FA),y
        .byte   $6B
        rol     $71,x
        .byte   $4C
L7DF5:  and     #$C7
        ldy     $1E,x
        asl     $04,x
        ora     #$6C
        rol     L0FAE,x
L7E00:  .byte   $4F
        cli
        .byte   $DC
        .byte   $A3
L7E04:  txa
        .byte   $37
L7E06:  and     ($C2,x)
        .byte   $C3
L7E09:  nop
        .byte   $AF
        lsr     a
        .byte   $3F
        .byte   $44
        rol     a
        .byte   $EB
        cmp     $A6
        lsr     $C2
        and     #$9C
        inc     $C1
        eor     ($88),y
        .byte   $97
        rti

L7E1C:  eor     #$AF
        .byte   $82
L7E1F:  inc     $A0,x
        .byte   $11
L7E22:  .byte   $0F
        bvc     L7E1F
        lsr     L3E4B,x
        stx     $D0,y
        sbc     ($51,x)
        tya
        .byte   $F7
        ora     $A88F,x
        .byte   $EB
        sty     $CEAA
        dex
        adc     L23A7,y
        lsr     L77CE
        .byte   $02
L7E3D:  lda     ($51),y
        .byte   $E2
        adc     #$22
        ldx     $CAB0
        .byte   $57
        tsx
        jmp     LDABA

        plp
        cmp     $04A3,y
        ror     $B08E
        beq     L7EA1
L7E53:  .byte   $1A
        .byte   $02
        .byte   $83
        cpx     L285A
        .byte   $8B
        .byte   $1C
        stx     L4AE3
        lda     L46C5,x
        ldx     #$21
        asl     $C7
        .byte   $74
        jsr     L1EDB
        .byte   $67
        cli
        .byte   $DF
        cmp     $06
        sta     L3ECB
        txs
        dex
        sta     L3103
        .byte   $44
L7E77:  cpy     #$EB
        stx     $AA,y
L7E7B:  .byte   $FA
        .byte   $6F
        .byte   $82
        adc     $ED66,y
        ora     $BDD6,x
        eor     #$B8
L7E86:  lda     ($01,x)
        adc     $74,x
        lsr     $79,x
        eor     $E362
        .byte   $14
        bit     $9D1A
        dex
        lda     $6A,x
        .byte   $A3
        .byte   $0B
        sbc     $58,x
        ror     $A3
        .byte   $07
        .byte   $D4
        .byte   $62
        tax
        .byte   $9E
L7EA1:  eor     L8243,y
        .byte   $02
L7EA5:  .byte   $9B
L7EA6:  .byte   $D3
        sta     $CD38,x
        .byte   $8F
        .byte   $04
        plp
        dey
        .byte   $22
        cpx     #$D9
        tay
        bmi     L7ECB
L7EB4:  tay
        .byte   $74
        .byte   $DC
        lsr     a
        .byte   $4E
L7EB9:  .byte   $63
        .byte   $AC
L7EBB:  txa
        rol     L2194,x
        asl     $0337
        eor     ($28,x)
        and     ($E5),y
        php
        .byte   $13
        .byte   $8D
        .byte   $F1
L7ECA:  .byte   $71
L7ECB:  .byte   $69
L7ECC:  .byte   $64
        clc
        .byte   $0B
        bpl     L7EDD
        .byte   $0B
        .byte   $1F
        .byte   $92
        .byte   $8B
        and     $0D,x
        .byte   $8B
        .byte   $3A
        .byte   $67
        .byte   $BB
        cld
L7EDC:  .byte   $E0
L7EDD:  ldy     $16,x
L7EDF:  ror     L0DD4,x
        .byte   $0B
L7EE3:  ror     a
        bit     L5BA0
        sec
        rts

L7EE9:  ora     ($30),y
        .byte   $A4
L7EEC:  .byte   $14
        .byte   $80
        .byte   $1B
        sty     $C8,x
        stx     $C05A
        rts

        bpl     L7F09
L7EF7:  cpy     $BC
        ror     $F129,x
        sed
        sbc     $E5C7,x
        .byte   $47
        .byte   $1F
        tya
        .byte   $E3
        .byte   $03
        .byte   $0C
        brk
        .byte   $07
        .byte   $03
L7F09:  and     $9ECE
        .byte   $12
        dec     L7E1C
        pha
        adc     (L00F9),y
        adc     ($D7),y
        rts

        cpy     $14
        ldy     $C0,x
        lsr     $7E,x
        .byte   $3C
        .byte   $82
        .byte   $67
        sbc     $40
        asl     L5A7E,x
        php
        .byte   $67
        sbc     $E0
        .byte   $C6
L7F29:  .byte   $72
        eor     L6784,x
        .byte   $E3
        .byte   $8F
        .byte   $33
        nop
        bne     L7F40
        .byte   $9F
        sty     L7C3C
L7F37:  bit     L6706
        .byte   $E2
        stx     $76
        .byte   $43
L7F3E:  sta     $03
L7F40:  sta     ($8C,x)
        nop
        .byte   $54
        ldy     $22,x
        .byte   $97
        ror     $50,x
L7F49:  .byte   $D4
        lsr     $F2,x
        stx     $83,y
        bmi     L7F29
        .byte   $76
L7F51:  bcs     L7EF7
        lsr     a
        .byte   $1C
        .byte   $04
        jmp     L101E

        rti

        cmp     #$EC
        .byte   $3F
        rti

        .byte   $43
        .byte   $07
        .byte   $D2
        sta     $EC41
        .byte   $6B
        ldy     #$42
        .byte   $9D
        .byte   $4B
L7F69:  jmp     (LC23D)

        .byte   $C0
L7F6D:  pla
        sbc     L1525,x
        .byte   $03
        and     $18,x
        .byte   $03
        and     $10
        stx     a:$E1
        .byte   $1F
        bvc     L7F6D
        .byte   $3A
        sbc     $12,x
        sta     L529D
        txs
        ror     $DF,x
        ora     $D5
        .byte   $1C
        .byte   $04
        ora     $0B
        .byte   $03
        cmp     $1E,x
        .byte   $8F
        ldy     #$E8
        .byte   $F4
        .byte   $17
        txs
        sta     $D7
        cpy     $89
        .byte   $1A
        adc     ($AC),y
        .byte   $47
        ora     $D5A1,y
        inc     $5C
        ror     a
        eor     ($1F,x)
        eor     ($9B),y
        nop
        sec
        ora     ($46),y
        ror     $D429
        .byte   $6C
L7FAF:  dey
        .byte   $57
        .byte   $87
        .byte   $1C
        adc     $EA03,x
L7FB6:  stx     $D2
        .byte   $97
        .byte   $83
        .byte   $02
        rts

        .byte   $B3
        dec     $68
        bpl     L7F69
        dey
        bmi     L7FEC
        cpy     #$2D
        sec
        .byte   $7A
        cmp     ($C5),y
        .byte   $0F
        and     $40
        .byte   $07
        .byte   $39
L7FCF:  .byte   $83
        lda     $BB76
        .byte   $27
        .byte   $53
        bvs     L7FCF
        lda     $A646
        lda     ($F0,x)
        sbc     ($1C,x)
        lda     $35,x
        .byte   $47
        dec     $2D,x
L7FE3:  cli
        jsr     L9240
        dec     $63
        nop
        pla
        .byte   $33
L7FEC:  ror     L4B2A
        lda     L8463,x
        brk
        sty     L240B
        bpl     L8063
        ora     ($E9),y
        jsr     L0056
        .byte   $03
        .byte   $59
        .byte   $80
L8000:  sbc     #$01
        sta     $4BFA,y
        rts

        ora     ($E3,x)
        ror     $05
        .byte   $5C
        lda     $F85E,y
        .byte   $23
        .byte   $1B
L8010:  .byte   $C3
        brk
        rol     $40,x
        .byte   $D3
        ora     ($36),y
        cpy     #$C3
        bit     $C067
        rol     $B9
        .byte   $52
L801F:  .byte   $73
        .byte   $F4
        .byte   $5C
        .byte   $AC
        .byte   $E7
L8024:  lsr     $9DA9,x
        nop
L8028:  .byte   $12
L8029:  adc     L8830
        adc     L7820
        adc     L8000
        jmp     (L69F0)

        .byte   $9F
        .byte   $44
        ora     L31F4,y
        .byte   $9F
        ldy     #$86
L803D:  .byte   $CD
L803E:  .byte   $80
        asl     $CC
        brk
        ora     $A8F0,x
        .byte   $1B
        plp
        .byte   $80
        .byte   $4B
        .byte   $73
        .byte   $62
        .byte   $22
        .byte   $C6
L804D:  ora     ($1A,x)
        adc     $30
        ora     ($6F,x)
L8053:  .byte   $93
L8054:  sei
        eor     L0BB0,x
        .byte   $D4
        adc     $AC48
        .byte   $DC
L805D:  jsr     L425A
        .byte   $62
        .byte   $DF
        php
L8063:  .byte   $C3
        sta     ($06,x)
        ora     ($0B,x)
        .byte   $E2
L8069:  .byte   $80
        asl     a
        .byte   $43
        .byte   $82
L806D:  stx     $80
        .byte   $8B
        .byte   $33
        .byte   $1C
        beq     L8054
        cpx     L0C7C
        and     $15
        brk
        .byte   $02
        .byte   $7B
        .byte   $07
        .byte   $80
        sta     ($03,x)
        brk
        sta     $83
        ora     #$02
        ror     a
        sty     $0414
        .byte   $0C
        sta     ($87,x)
        .byte   $03
L808D:  .byte   $0C
        .byte   $04
        .byte   $13
        and     L6494
        .byte   $2F
        adc     #$84
        ora     L84D9,y
        .byte   $13
        adc     a:$51
        adc     ($FC,x)
        lda     L2625
        ldx     #$55
        beq     L80FF
        .byte   $D2
        .byte   $D4
        txs
        dey
        .byte   $D3
        sty     $6C
        adc     $0104,x
        cld
        adc     $D700,x
        .byte   $B2
        .byte   $BB
        ldy     #$7C
        .byte   $7A
        .byte   $02
        .byte   $57
        adc     #$34
        stx     $A614
        .byte   $E2
        sty     $9D,x
        cmp     ($F5),y
        .byte   $1A
        rts

        .byte   $89
        .byte   $0C
L80C9:  .byte   $D2
        lsr     $A0,x
        .byte   $07
        .byte   $80
        stx     $92,y
        adc     $CA
        cpy     #$09
        .byte   $80
        stx     $B3
        .byte   $02
        .byte   $4F
        .byte   $CB
        bcs     L80F0
        .byte   $FC
        stx     $03
        .byte   $80
        .byte   $6F
        .byte   $1D
        rti

L80E3:  bcs     $8105
        pha
        eor     $32
        .byte   $82
        stx     $37
        sta     L2283
        rts

        tay
L80F0:  cli
        .byte   $27
        tax
        .byte   $92
        asl     $89
        .byte   $59
        .byte   $CD
L80F8:  bit     $9C71
        cmp     $BD81
        .byte   $43
L80FF:  eor     ($D9,x)
        .byte   $DC
        .byte   $BB
        sty     $38,x
        .byte   $34
L8106:  .byte   $14
        ora     $DD90,x
        .byte   $9E
        nop
        bit     $5A
        rol     a
        ora     ($05,x)
        ora     #$03
        sbc     $29,x
        .byte   $17
        .byte   $83
        .byte   $0F
        stx     $AF,y
L811A:  adc     L0F8C
        sta     ($B6,x)
        eor     $A4
        .byte   $FC
        bpl     L8132
        sta     ($63,x)
        lda     LC2BE
        .byte   $64
        cmp     $35,x
        ora     $02
        stx     $4F,y
        .byte   $74
        .byte   $E4
L8132:  php
        lsr     L5F8D
L8136:  cpy     #$06
        ror     a
        .byte   $0E
        .byte   $D9
L813B:  ora     $6920
L813E:  sta     ($82,x)
        jsr     L9849
        bit     $E0
        clc
        .byte   $04
        .byte   $22
        .byte   $14
        and     $5B,x
        adc     #$52
        .byte   $03
        .byte   $AB
        .byte   $FC
        asl     $4C
        .byte   $9C
        cmp     #$E0
        .byte   $AB
        sed
        sta     $0E
        rol     $43,x
        .byte   $0C
        .byte   $04
        .byte   $57
        bmi     L8164
        .byte   $95
L8161:  .byte   $42
        rti

        .byte   $A9
L8164:  .byte   $9C
        php
        sei
        ora     ($02),y
        .byte   $7C
        php
        .byte   $C7
        lda     ($49,x)
        tya
        .byte   $74
        lsr     a
        .byte   $02
        .byte   $03
L8173:  .byte   $02
        ora     L0C03
        bpl     L8173
        tay
        ora     $CB04
        .byte   $1C
        .byte   $07
        clc
        .byte   $83
        .byte   $7B
        ldx     $15,y
        .byte   $9F
        ldx     $C3,y
        eor     ($24,x)
        ora     $C5,x
        rti

L818C:  php
        ora     ($47,x)
        sbc     L0822,y
        ora     ($2D,x)
        sed
L8195:  .byte   $F4
        .byte   $27
        and     $2F
        .byte   $E3
        bne     L813B
        .byte   $5A
        .byte   $B9
        .byte   $FB
L819F:  cpy     L6BC4
        .byte   $17
        .byte   $3A
        and     L7A99,y
        pla
        .byte   $80
L81A9:  asl     L5E42
        .byte   $3F
        .byte   $0C
        .byte   $33
L81AF:  .byte   $F2
        sta     L3F83,y
        ora     #$9C
        brk
        ora     ($90,x)
        brk
        and     #$9C
        .byte   $0C
        jsr     LCA35
        ldx     $CF71
        eor     $6C
        rol     $78,x
        rti

        .byte   $43
        pha
        .byte   $67
        cpx     #$B1
        .byte   $C0
L81CD:  cpy     $B1
        .byte   $C2
L81D0:  .byte   $04
        .byte   $74
        .byte   $B3
        rti

        cpy     $5C
        ldx     $59,y
        .byte   $67
        sbc     ($82,x)
        .byte   $DC
        .byte   $04
        sec
        rol     $39,x
        .byte   $82
        .byte   $EB
        .byte   $54
        ldy     #$C5
L81E5:  .byte   $87
        .byte   $C3
        .byte   $DF
        .byte   $D7
        ora     L7EDF
        .byte   $1C
        .byte   $80
        cpx     #$3E
        sei
        .byte   $3C
        .byte   $83
        ldy     #$F0
        .byte   $3B
        ldy     L2206
        .byte   $0C
        .byte   $FC
        cli
        clc
        .byte   $CF
        cmp     $03
        pla
        brk
        .byte   $67
        .byte   $82
        dey
        .byte   $67
        sty     $8C
        sbc     $74,x
        .byte   $54
        .byte   $CF
        eor     $03,x
        .byte   $0C
        sbc     $0648,x
        eor     #$50
        stx     $46
        eor     $80,x
        ldx     $84,y
        cmp     L668A
        sty     $C8D8
        ror     L173F
        .byte   $73
L8224:  rts

        sta     $C080,y
        sta     L1A61,y
        sta     L4349,y
        .byte   $3C
        sta     $F3,x
        beq     L81CD
        brk
        ldx     #$9A
        .byte   $13
        .byte   $32
        lda     #$A0
        .byte   $14
        .byte   $B3
        plp
        .byte   $E1
L823E:  rti

        .byte   $9B
        .byte   $3F
        adc     #$82
L8243:  .byte   $33
        rol     $18,x
        ora     ($3B,x)
        .byte   $8F
        dec     a:$2D
        ora     ($20),y
        and     $89,x
        bit     $69
        .byte   $0C
        jsr     L0311
        cmp     $02FC,y
        .byte   $3F
        .byte   $0F
        .byte   $DF
        and     L7D36,x
L825F:  sta     $DEE7
        .byte   $37
        asl     L6A02,x
        .byte   $42
        .byte   $80
        .byte   $D4
L8269:  adc     ($54),y
        beq     L827C
        cli
        sbc     L2125,x
        asl     $E5
        ora     $D5B1,y
        dec     $15,x
        .byte   $F9
L8279:  .byte   $43
        and     #$E2
L827C:  .byte   $74
        .byte   $03
        .byte   $04
        cld
        ror     a:$15
        asl     $15,x
        .byte   $47
        .byte   $8E
        plp
L8288:  .byte   $FD
        .byte   $AF
L828A:  .byte   $04
        .byte   $03
        sed
        inx
        .byte   $47
        .byte   $17
        and     $B1
        .byte   $A7
        .byte   $13
        .byte   $53
        brk
        ora     #$63
        stx     $0A
        brk
        .byte   $83
        adc     $E4,x
        .byte   $1A
        .byte   $43
        cpy     L0B13
        bpl     L82A5
L82A5:  .byte   $72
        ldx     L1493,y
        php
        .byte   $4B
        bpl     L8311
        .byte   $5C
        .byte   $B0
L82AF:  .byte   $10
L82B0:  rol     $7E
        .byte   $03
        ora     ($62,x)
        rti

        .byte   $AF
        ora     #$04
        .byte   $E0
L82BA:  sbc     $FDF0,y
        stx     $C066
L82C0:  .byte   $83
L82C1:  asl     $DC
        sbc     $9F,x
        .byte   $04
        stx     $6A
        .byte   $14
        .byte   $20
L82CA:  and     ($26),y
        bvc     L82AF
        .byte   $43
        rts

        adc     ($15,x)
        .byte   $5F
        cld
        and     L8DFE,x
        ora     ($9D,x)
        .byte   $9B
        .byte   $14
        jsr     L3413
        php
        eor     ($AC,x)
        adc     L22E8
        .byte   $93
        .byte   $2D
L82E6:  sta     ($93,x)
        rol     a
        .byte   $82
        .byte   $93
        rol     $84
        .byte   $1B
        rol     $01
        .byte   $1B
        and     L4608
        rts

        brk
        bmi     L8288
        adc     ($30),y
        cpx     #$E1
L82FC:  .byte   $34
        and     $47
        eor     $A927,y
        .byte   $B9
L8303:  sta     $20CC,y
L8306:  .byte   $0C
        ora     $85
        .byte   $72
        sta     ($AC),y
        eor     $E8
        tya
        php
L8310:  .byte   $25
L8311:  .byte   $C7
        .byte   $92
L8313:  pla
        rts

        eor     $16,x
        cpy     #$86
L8319:  .byte   $C3
        .byte   $52
        .byte   $83
        .byte   $8F
        lda     $C751,y
        lda     $39,x
        .byte   $53
        brk
        .byte   $2F
        .byte   $82
        .byte   $A9
L8327:  .byte   $C2
        cli
        clc
        sta     ($AA,x)
        ora     $03
        ora     #$FA
        lda     ($FA),y
        .byte   $6B
L8333:  .byte   $37
        ora     ($5B,x)
        .byte   $1C
        .byte   $EE
L8338:  .byte   $6B
        lda     (L0060,x)
        .byte   $7A
        .byte   $E2
        bmi     L8313
        asl     $F4E0,x
        stx     L0F8B
        .byte   $AB
L8346:  .byte   $9B
        .byte   $D3
        lsr     $BE,x
        .byte   $34
        ldy     #$0A
        .byte   $B3
        .byte   $63
        nop
        bmi     L83C0
        .byte   $6F
        rti

        .byte   $FB
        .byte   $0F
        pha
        cmp     ($0A,x)
        brk
        cmp     $19
        ora     ($AE,x)
        cpx     $84
        jmp     (L2234)

        txs
        .byte   $AF
        eor     ($0B,x)
        .byte   $3B
        .byte   $A7
        php
        ora     $8F
        ror     L1F5B,x
L836F:  .byte   $03
        .byte   $C3
        dec     $38,x
        sta     $E343
        bne     L8338
        .byte   $80
L8379:  lsr     $3D,x
        .byte   $FD
L837C:  jmp     (LF12E)

        jmp     (LD57B)

L8382:  .byte   $A3
        ldx     L62BB
        sbc     $18
        ora     ($15),y
        .byte   $A3
        dec     a:$8D,x
        ora     ($7A,x)
        .byte   $3B
        lda     ($48),y
        .byte   $82
        ora     $A246
        .byte   $74
        cpx     #$36
        sta     $C1F4,x
        .byte   $43
        cmp     ($FD,x)
        pla
        .byte   $37
        ora     $B104
        cmp     ($04),y
        .byte   $2F
        .byte   $96
L83A9:  .byte   $3F
        adc     #$C0
        .byte   $AB
        sty     $A8,x
        rol     L48C6
        .byte   $80
        sbc     #$D0
        .byte   $A7
        sty     $D0,x
        rol     $C3
        bne     L83CC
        .byte   $54
        cli
        bpl     L83C8
L83C0:  ora     ($CD),y
        ldx     L8310,y
        .byte   $2B
        sbc     #$3B
L83C8:  .byte   $04
        .byte   $07
        .byte   $AF
        .byte   $1A
L83CC:  .byte   $5A
        .byte   $72
        .byte   $BB
        lda     ($DB),y
        sty     L1254
        lda     $E8ED,x
        .byte   $FA
        txs
        dec     $AC
        adc     $CD44
        .byte   $8F
        ora     L0850
        .byte   $34
        ror     $F7D8,x
        txs
        .byte   $D7
L83E8:  cpy     $66
        .byte   $03
        .byte   $63
        lda     L720C,y
        dec     $55
        adc     L119A,x
        sbc     ($46,x)
        lda     $F40A,x
        sbc     ($EB),y
        eor     ($FB),y
        clc
        sty     $F2,x
        adc     ($05,x)
        .byte   $7A
L8403:  .byte   $87
        stx     $43
        cmp     L2D7D,x
        .byte   $DA
        lda     ($89),y
        eor     $65,x
        and     L865D,y
        ora     #$CD
        .byte   $6B
L8414:  .byte   $DB
        asl     a
        .byte   $34
        cpy     #$63
        lsr     $B8CF
        .byte   $44
        .byte   $17
        stx     $35,y
        ldx     #$14
        asl     $BD,x
        bcc     L8467
        nop
        clv
        sta     L8B30
        .byte   $1C
        ldy     $C2,x
        ora     #$66
        .byte   $DC
        .byte   $72
        .byte   $C7
        pla
        ora     $33,x
        .byte   $BF
        .byte   $1B
        sta     ($51,x)
        lda     L6936,x
        cpx     #$7F
        sta     $88
        cmp     $AA8A,y
L8444:  .byte   $FB
        sec
        .byte   $82
        eor     #$81
        adc     ($87,x)
        asl     $1E,x
        eor     $FB62
        dec     $19,x
        .byte   $EB
        .byte   $CF
        .byte   $E2
        ora     L4479,x
        eor     #$4D
        pha
        ora     $C0AB,y
L845E:  ldy     $69
        lsr     $B9,x
        rti

L8463:  .byte   $12
        ldx     $EF
        .byte   $21
L8467:  .byte   $1A
        .byte   $9B
        dec     L870D
        brk
        dex
        .byte   $7C
        .byte   $07
        dey
        cpy     $1B
        .byte   $8B
        lsr     a
        .byte   $70
L8476:  cmp     $07
        asl     $D5,x
        .byte   $82
        nop
        jmp     L514F

L847F:  pha
        adc     ($14,x)
        lda     ($C1),y
        .byte   $64
        nop
        rol     L2388,x
        inx
        .byte   $7A
        ldy     L3D99,x
        eor     ($06),y
        .byte   $A3
        .byte   $5C
        .byte   $0B
        dec     $9F,x
        brk
        .byte   $5C
        eor     L584E,x
        cmp     ($23,x)
        ora     ($50),y
        cpy     #$02
        ora     ($5C),y
        sbc     L9B09
        .byte   $62
        .byte   $32
        ora     L25F8,y
        .byte   $23
        .byte   $9F
        .byte   $82
        .byte   $72
        eor     L29F8,y
        .byte   $27
        dec     $5C
        ldy     #$38
        php
        sty     $D6
L84B9:  ror     $CD08,x
        .byte   $E7
        cpx     #$94
        inc     $7E
        ora     #$CE
        .byte   $E7
        cpx     #$A4
        inc     $7E,x
        asl     a
        .byte   $CF
        .byte   $83
        sta     ($08,x)
        .byte   $52
        .byte   $67
        cpx     #$8D
        rol     L097E
        .byte   $53
        .byte   $67
        cpx     #$9D
        .byte   $3E
L84D9:  ror     L540A,x
        .byte   $67
        cpx     #$AD
        lsr     L0B7E
        eor     $03,x
        sta     ($88,x)
        cli
L84E7:  .byte   $E7
        cpx     #$8D
        stx     $7E,y
L84EC:  ora     #$59
        .byte   $E7
        cpx     #$9D
        ldx     $7E
        asl     a
        .byte   $5A
        .byte   $E7
        cpx     #$AD
        ldx     $7E,y
        .byte   $0B
        .byte   $5B
        .byte   $83
        .byte   $82
        php
        .byte   $5F
        .byte   $67
        cpx     #$8D
        inc     L097E,x
        ror     a
        .byte   $02
        .byte   $3F
        .byte   $04
        beq     L856F
        beq     L8561
        asl     a
L850F:  .byte   $3F
        ora     $70
        sbc     #$ED
        lda     #$CA
L8516:  .byte   $8F
L8517:  cmp     ($2C,x)
        clv
        .byte   $FC
        .byte   $13
        cpy     $C18F
        jmp     L70D0

        adc     ($2D,x)
        pha
        .byte   $FC
        .byte   $13
        cmp     $82,x
        .byte   $13
        ldy     $FD
        cli
        sbc     L1E25,x
L8530:  .byte   $8F
        tay
        sbc     L4105,x
        .byte   $53
        .byte   $02
        lda     ($E2),y
        .byte   $87
        .byte   $9B
        bvs     L8546
        ora     ($A0,x)
        bcs     L854F
        ora     #$48
        sbc     $18,x
        .byte   $55
L8546:  inc     $F7,x
        sty     $51
        sbc     $48,x
        .byte   $8F
        pha
        .byte   $E9
L854F:  .byte   $63
        cmp     $45
L8552:  .byte   $12
        .byte   $33
        stx     $91,y
        .byte   $72
        ldy     L4060,x
        .byte   $E3
        dec     $05
        .byte   $82
        rti

        .byte   $6B
        .byte   $DF
L8561:  .byte   $1C
L8562:  .byte   $44
        rol     a
L8564:  ldx     L6066,y
        ror     a
L8568:  lda     L6841,y
        cpy     $0A
        .byte   $07
        .byte   $8B
L856F:  dey
        lda     $AA,x
        cpx     #$0A
        .byte   $37
        .byte   $E2
        txs
        bpl     L8562
        ora     L6005,x
        rol     $B1
        asl     $3A
        .byte   $EB
        .byte   $E2
        lda     ($13),y
        .byte   $A3
        bne     L8595
        .byte   $BE
        .byte   $B6
L8589:  lda     ($A8,x)
        sbc     ($0A),y
        .byte   $03
        tax
        .byte   $82
        ldx     L3AA0,y
        .byte   $B3
        .byte   $6B
L8595:  inc     $2A
        ldy     $A465
        .byte   $0B
        .byte   $0C
        .byte   $8F
        pha
        .byte   $DC
        .byte   $02
        .byte   $07
        sta     L6B00
        asl     $BA,x
        .byte   $87
        beq     L8564
        asl     $D2,x
        sta     L440A
        tay
        sbc     $AF
        adc     ($30,x)
        rol     a
        .byte   $37
        plp
        stx     $E7B1
        lda     $B1,x
        inc     $52
        sta     L5B63
        .byte   $1C
        dec     L5BE9
        .byte   $2B
        .byte   $6B
        .byte   $83
        cpy     #$AC
        bit     $A882
        .byte   $E2
        ora     $A2
        .byte   $22
        adc     $A756
        .byte   $42
        .byte   $47
        and     #$CA
L85D7:  ora     $F04F,x
        .byte   $B7
        .byte   $5F
        .byte   $63
        ldy     $5F
        .byte   $12
        .byte   $C3
        and     $9A7C,x
        .byte   $81
L85E5:  sty     $6B,x
        ora     ($EA,x)
        sta     $C705
        rti

        ora     $B771,x
        eor     #$10
        .byte   $0F
        eor     ($70,x)
        eor     $41
        .byte   $54
        sbc     ($91,x)
        .byte   $1A
        .byte   $D4
        cmp     L2CB6,y
        php
        cli
        inc     $E9,x
        .byte   $52
        .byte   $87
        sty     $50
L8607:  .byte   $6F
        .byte   $41
L8609:  .byte   $8F
        bit     $D76A
        cmp     ($73,x)
        .byte   $0D
L8610:  inc     $B5
        eor     ($84),y
        .byte   $1A
        cmp     $E86B
        cpx     #$A0
        stx     $87,y
        ror     a
        lsr     L4C0A
        jsr     L9A30
        .byte   $97
        .byte   $82
        ora     ($B1,x)
        lsr     $41
L8629:  .byte   $2B
        sbc     ($E0,x)
        ora     $18
        stx     $9CB0
        .byte   $5A
        clc
        .byte   $43
        .byte   $02
        lda     $E846,y
        .byte   $DF
        ora     $AB
        .byte   $12
        .byte   $34
        lda     $E46B,y
        .byte   $A7
        .byte   $B3
        .byte   $EF
L8643:  .byte   $D3
        .byte   $02
        .byte   $87
        .byte   $C3
        clc
        ldy     #$B0
        asl     $8E,x
        .byte   $5A
        .byte   $FB
        jmp     LC8A9

L8651:  .byte   $7C
        php
        .byte   $1B
        .byte   $94
L8655:  bit     $4E
        .byte   $92
        .byte   $87
        sty     $8C,x
        .byte   $AE
        txa
L865D:  .byte   $3F
        eor     ($CA),y
        sed
L8661:  .byte   $F7
        and     $54,x
        .byte   $0B
        lda     ($B6,x)
        .byte   $2B
        cpx     #$EA
        .byte   $BE
        .byte   $B5
L866C:  rti

L866D:  bcc     L8629
        .byte   $33
L8670:  adc     L6247,x
        asl     a
        rol     L69B1,x
        sec
        sbc     #$44
        .byte   $83
        sty     $AB
        .byte   $12
        .byte   $80
        rti

        lda     #$D1
        .byte   $52
L8683:  sta     ($12),y
        .byte   $23
        sta     $AB
L8688:  sta     L8568
        stx     L76E8
        .byte   $1E
L868F:  .byte   $17
        lda     ($93,x)
        .byte   $54
        brk
        rol     a
L8695:  dey
        dey
        .byte   $A3
        .byte   $87
        dex
L869A:  sed
        cmp     $A2
        .byte   $2E
        .byte   $2B
L869F:  .byte   $EB
        inc     $D6
        .byte   $A7
        ora     L78C0
        bne     L86AF
        .byte   $89
        bne     L8695
        asl     $01,x
        .byte   $63
        rol     a
L86AF:  lda     $F156,x
        adc     #$D6
        cpx     L0E18
        .byte   $5C
        .byte   $C7
        asl     $30
        .byte   $14
        .byte   $CB
        php
        bcs     L86F9
        beq     L8643
        .byte   $9F
        sta     ($A3,x)
        bvs     L86DD
        .byte   $C2
        .byte   $5C
        .byte   $D4
        adc     ($1F,x)
        .byte   $37
        rts

        .byte   $17
        cmp     a:$EA
        tya
        lsr     $EB
L86D5:  sty     $1C,x
        cpy     #$54
        php
        rol     $18,x
        brk
L86DD:  rol     $06,x
        cli
        .byte   $1C
        tax
        .byte   $02
        cli
        jsr     L3F9B
        .byte   $02
        pha
        .byte   $F3
        tya
        clc
        .byte   $42
        .byte   $07
        tsx
        iny
        and     #$F3
        ldx     $E3,y
        lsr     L2F75,x
        cpx     #$98
L86F9:  .byte   $23
        ldx     L0D76,y
        .byte   $BB
        txa
        sty     $DBF7
L8702:  .byte   $B3
        cpy     $66
        .byte   $7A
        rts

        plp
L8708:  cli
        .byte   $47
        .byte   $7A
        cpy     #$02
L870D:  .byte   $E7
        rti

        rol     $71,x
        .byte   $77
        ldx     $DF,y
        .byte   $8F
        jmp     (L8688)

        plp
        .byte   $73
        ldx     L4010
        lsr     $E06C,x
        cmp     ($00),y
        stx     $78
        sbc     ($78,x)
        .byte   $77
        .byte   $22
        stx     L897E
        .byte   $77
        .byte   $DA
        .byte   $62
        asl     a
        .byte   $1C
        .byte   $27
        .byte   $DF
        .byte   $77
        .byte   $07
L8734:  .byte   $33
        ror     $C809
        eor     $CA,x
        .byte   $7B
        stx     $BD,y
L873D:  sed
        dec     $EFD9,x
        .byte   $97
        ora     L7656,x
        .byte   $E5
L8746:  ora     ($75,x)
        .byte   $F4
        .byte   $07
        .byte   $C7
        .byte   $77
        .byte   $1B
        sta     L1D06,y
        .byte   $DF
        adc     L6B66
        .byte   $77
        cld
        .byte   $3B
        tya
        .byte   $E3
        sbc     L13D6,y
        .byte   $AB
        bvc     L8771
        .byte   $83
        bvc     L8772
        tya
        cmp     $A421
        and     ($F5,x)
        .byte   $A7
        .byte   $3B
        sbc     ($91,x)
        .byte   $1A
        .byte   $AE
        .byte   $2B
L876F:  cpx     $18
L8771:  .byte   $07
L8772:  .byte   $04
        rts

        .byte   $3C
        .byte   $87
        pha
        .byte   $8B
        asl     $0E,x
        txs
        dey
        dec     $98
        cpx     L8960
        ror     a
        sta     ($12,x)
        .byte   $12
        stx     $88
L8787:  .byte   $92
        stx     $43
L878A:  .byte   $80
        .byte   $74
L878C:  .byte   $63
        sta     ($B0),y
        .byte   $54
        .byte   $7B
        .byte   $5F
        eor     #$10
        ldy     $3B,x
        clc
        .byte   $53
        bit     $A29E
        sty     $53,x
        .byte   $52
        lsr     L4513
        .byte   $7C
        eor     $A452,y
        sta     ($04,x)
        .byte   $52
        .byte   $63
        .byte   $57
        .byte   $D3
        .byte   $BB
        .byte   $1E
        sed
L87AE:  ldy     $5E,x
L87B0:  asl     $0F
        cld
        stx     $00
        cmp     ($95),y
        .byte   $04
        rti

        .byte   $F4
        .byte   $C7
        .byte   $05
L87BC:  .byte   $3A
        .byte   $2F
        asl     a
        .byte   $57
        .byte   $5F
        ldy     #$C0
        txs
        ldy     #$A4
        and     ($DD),y
        .byte   $1C
        ldx     #$15
        adc     ($6A),y
        .byte   $87
        ora     $D7
        .byte   $DB
        .byte   $74
        asl     $31
        .byte   $5F
        bit     $E4
        .byte   $3C
        .byte   $D7
        ldx     #$F1
        ldy     #$C4
        adc     ($52),y
        rol     a
        php
L87E1:  cmp     ($D4,x)
        adc     $4D
        lda     #$CB
        ora     #$82
        sty     $1E,x
        .byte   $E2
        lda     ($14,x)
        .byte   $53
        iny
        .byte   $43
        dex
        .byte   $2C
L87F3:  .byte   $7F
        .byte   $14
        ora     (L0060,x)
        .byte   $89
        .byte   $2C
L87F9:  .byte   $22
        ldx     #$81
        bvc     L878C
        .byte   $17
        .byte   $0C
        and     ($BA,x)
        ldx     #$C1
        .byte   $22
        lda     ($11,x)
        .byte   $BF
        .byte   $02
        adc     $F3,x
        stx     $02
        sta     $C0
        lda     $3C,x
        ror     $C6,x
        eor     ($05),y
        clc
        .byte   $F4
        .byte   $A3
        .byte   $F1
L8819:  lda     L4F5C,x
        .byte   $04
        .byte   $04
        .byte   $E2
        sta     $D3
        asl     $A1
        .byte   $14
        .byte   $F2
        cli
        .byte   $92
        cld
L8828:  .byte   $B3
        .byte   $5A
        ldy     #$60
        .byte   $D4
        .byte   $C2
        .byte   $CE
        plp
L8830:  tya
        and     $20
        cmp     $A331,x
L8836:  .byte   $AB
        eor     L52B8,x
        eor     $CCD7,y
        .byte   $83
        .byte   $4F
        sta     L16ED
        lsr     $3C,x
        .byte   $95
L8845:  .byte   $B2
        .byte   $EF
        .byte   $43
        .byte   $CF
        bpl     L8869
L884B:  ldy     $33,x
        .byte   $3F
        .byte   $23
        clv
        plp
        .byte   $EF
L8852:  sec
        bvc     L889E
        ldy     $7C,x
        inc     $F3
        nop
        .byte   $5C
        cmp     L33F9
        .byte   $FC
        .byte   $52
        asl     a
        .byte   $04
        .byte   $8F
        and     L1ECF,x
        .byte   $C7
        .byte   $93
        .byte   $D1
L8869:  eor     (L0060),y
        lda     L8552,x
        ora     $D7,x
        .byte   $E3
L8871:  .byte   $DB
        .byte   $87
        .byte   $03
        cmp     $88
        sbc     ($A8),y
L8878:  adc     $8F,x
        stx     L5C7F
        .byte   $5C
        eor     ($0D,x)
L8880:  .byte   $0C
        bvs     L8828
L8883:  dex
        .byte   $34
        ora     $5F,x
        sta     ($AC),y
        .byte   $0B
        .byte   $47
        .byte   $10
L888C:  bcc     L8836
        adc     $8F8D
        .byte   $47
        bne     L8845
        .byte   $0C
        ror     L0894,x
L8898:  sta     ($3B,x)
        iny
        ror     a
        tsx
        ror     a
L889E:  .byte   $FA
        .byte   $6B
        stx     $71,y
L88A2:  .byte   $DA
L88A3:  adc     $D2,x
        adc     L7ECA,y
        .byte   $32
        .byte   $82
        dec     $85,x
        .byte   $32
        .byte   $8B
        rol     $92
        ldx     L1697
        sta     $9E42,y
        .byte   $12
        .byte   $9C
        jmp     L1595

        .byte   $F5
L88BC:  ora     L15B5,x
        adc     $55,x
        cmp     L0056,x
        and     $45,x
        eor     $E5,x
L88C7:  lda     $E6,x
L88C9:  ora     $E6,x
        adc     $E6,x
        cmp     $E0,x
        dec     $01,x
        rol     $01,x
        stx     $01,y
        inc     $02,x
        lsr     $02,x
        ldx     $03,y
        asl     $03,x
        ror     $03,x
        dec     $19,x
        stx     $15,y
        dec     $3F,x
        stx     $3F,y
        inc     $20,x
        lsr     $41,x
        inc     $C2,x
        lsr     $C2,x
        .byte   $B6
L88F0:  .byte   $D3
        stx     $DD,y
        asl     $DD,x
        ror     $D0,x
        inc     $F1,x
        lsr     $F4,x
        .byte   $37
        .byte   $04
        .byte   $57
        bit     $B7
        rol     $F7,x
        .byte   $27
        .byte   $97
        lsr     a
        .byte   $FF
        tsx
        tya
        tsx
        .byte   $89
        .byte   $BB
        .byte   $B2
        ldy     $BD49,x
        eor     L5ABD,y
        lda     $BFB7,x
        .byte   $A7
L8916:  .byte   $D2
        .byte   $0F
        rol     $C80A,x
        ora     ($00,x)
        brk
        rti

        .byte   $C2
        .byte   $87
        .byte   $DA
        .byte   $FA
        brk
        .byte   $63
        inx
        and     $BAF3,y
        php
        .byte   $1F
        .byte   $0B
        nop
        brk
        .byte   $59
L892F:  .byte   $C3
        eor     ($AF,x)
L8932:  .byte   $A7
        adc     $F9C7
        .byte   $47
        .byte   $D3
        sed
        .byte   $72
        .byte   $F3
        .byte   $EF
        .byte   $97
        .byte   $8B
        .byte   $47
        .byte   $AB
        .byte   $EB
        sbc     $E07F,x
        bpl     L88C7
        .byte   $5A
        asl     $00
        asl     L4C1B
        rti

        dec     $9D3C,x
        .byte   $7C
        jsr     LE66D
        bvs     L8932
        sta     $0A
        .byte   $14
        asl     a
        ora     $1B
        .byte   $93
        .byte   $8F
        .byte   $AC
        .byte   $F6
L8960:  .byte   $E3
        tay
        ora     ($A2,x)
        .byte   $62
        adc     ($A3,x)
        asl     $88
        .byte   $1C
        .byte   $22
        and     $F1,x
        brk
        sbc     ($C7),y
        cpy     #$03
        asl     $68
        clv
        .byte   $75
L8976:  sbc     ($9D),y
        sbc     ($1E),y
        .byte   $1F
        ora     ($1D),y
        .byte   $7C
L897E:  ror     $A0
        ora     $86
        .byte   $B2
L8983:  .byte   $33
        .byte   $DF
        .byte   $8F
        dey
        .byte   $8D
L8988:  .byte   $64
        .byte   $54
        jmp     LC767

        .byte   $1C
        bvc     L89A9
        .byte   $D3
        tya
        .byte   $5C
        .byte   $7C
        sed
        .byte   $7C
        brk
L8997:  plp
        adc     L756C,y
        .byte   $F3
        .byte   $D4
        dec     $F7
        and     $94A0,x
        .byte   $14
        .byte   $37
        tya
        .byte   $A1
L89A6:  .byte   $A7
        sty     $F6
L89A9:  .byte   $63
        sbc     ($3B),y
L89AC:  ldx     L3E28,y
        asl     a
        .byte   $3E
L89B1:  .byte   $13
        .byte   $A3
        .byte   $23
        and     ($27,x)
        sta     L0081,x
        .byte   $8F
        .byte   $FC
        plp
        bcc     L89ED
        jmp     L3448

        .byte   $74
        sbc     ($BC,x)
        rti

        sta     L80E3
        rti

        .byte   $02
        .byte   $07
        sta     $FE
        adc     $ED,x
        .byte   $E3
        bvs     L89A6
        .byte   $C3
        sty     $7D
        cmp     $5F,x
        .byte   $19
        .byte   $44
L89D8:  .byte   $13
        .byte   $D4
        .byte   $8D
L89DB:  .byte   $FA
        lda     L279E,x
        .byte   $C2
        clc
        rti

        jmp     (LA2D9)

        .byte   $C2
L89E6:  .byte   $1B
        adc     ($86,x)
        .byte   $2B
        and     $51
        .byte   $14
L89ED:  .byte   $90
L89EE:  sbc     ($15),y
        eor     L0060,x
        sec
        bvc     L8997
        bpl     L89D8
        ora     L153F,x
        .byte   $7C
L89FB:  clc
        .byte   $04
        .byte   $54
        bvc     L8A60
        lda     ($25,x)
        .byte   $0F
        sty     $C0
        brk
        rti

        iny
        .byte   $0F
        asl     $BC
        clc
        sec
L8A0D:  beq     L8A78
        .byte   $23
        .byte   $E1
L8A11:  .byte   $8B
        .byte   $F4
        ldx     $0372,y
        .byte   $6B
        cmp     ($8F,x)
        lda     $7C,x
        adc     $C1,x
        cmp     $D76D,y
        .byte   $EF
        .byte   $97
        .byte   $C7
L8A23:  ora     L4CFC
L8A26:  bpl     L8A98
        .byte   $C1
L8A29:  sbc     ($01,x)
        .byte   $D3
        inc     $2B,x
        sbc     ($90),y
        sta     ($D6,x)
        .byte   $80
        .byte   $87
        .byte   $42
        .byte   $1C
        .byte   $7B
        .byte   $D4
        .byte   $5C
        rti

        sei
        rts

L8A3C:  .byte   $6B
        .byte   $E3
        .byte   $73
        cpy     $C501
        .byte   $1F
        .byte   $5F
        .byte   $BD
        .byte   $4C
L8A46:  ror     $67,x
        sbc     $E1,x
        ora     ($D7),y
        .byte   $87
        bvc     L8A6C
        .byte   $34
        adc     L407C,y
        sei
        bvs     L8AA2
        adc     ($C1),y
        ora     ($E9),y
        bcc     L8A3C
        eor     ($E4,x)
        sta     ($BC,x)
L8A60:  .byte   $67
        ldx     L0A89
        ora     L5000
        pha
        .byte   $07
        rti

        .byte   $F3
        .byte   $E5
L8A6C:  .byte   $0C
        dey
        .byte   $8D
        txa
L8A70:  .byte   $82
        lda     $E0C3
        lda     ($A4),y
        .byte   $AD
        .byte   $02
L8A78:  tax
        .byte   $0C
        tay
        ora     $032C
        .byte   $FC
        and     L0CDE,y
L8A82:  .byte   $3C
        bit     $0C
        sec
        ora     ($AC,x)
L8A88:  .byte   $AB
        .byte   $8F
        sta     ($E7,x)
        iny
        ora     $9A06,y
        asl     $1F
        rol     a
        asl     $5E
        .byte   $03
        sei
        .byte   $CB
L8A98:  asl     $CD83
        rti

        .byte   $C2
        lda     ($40,x)
        .byte   $C3
        .byte   $63
L8AA1:  .byte   $E0
L8AA2:  cpy     $A8
        ora     #$01
        .byte   $5C
        cli
        .byte   $64
        .byte   $9C
L8AAA:  eor     ($01),y
        rti

        .byte   $7C
        .byte   $37
        eor     $84
        sbc     ($C2),y
        .byte   $92
        adc     ($C2,x)
        eor     $15,x
        jmp     (L714F)

        sed
        cmp     ($21,x)
        .byte   $03
        .byte   $C2
        .byte   $6F
L8AC1:  .byte   $0F
        cpy     $E4
L8AC4:  pla
        stx     $9A
        .byte   $5A
        php
        bne     L8A70
        cmp     ($C8,x)
        sta     $80,x
        ora     $AB
        .byte   $8F
        eor     ($85,x)
        .byte   $97
        eor     $5E
        bpl     L8A88
        .byte   $0C
        .byte   $14
        pla
        bmi     L8B2C
        sei
        ror     $96
        .byte   $64
        .byte   $73
L8AE3:  sta     $5A
        ora     $14,x
        cli
        .byte   $AE
        .byte   $35
L8AEA:  .byte   $AE
L8AEB:  brk
        .byte   $14
        jmp     L41CA

        .byte   $82
        ldy     #$8A
        .byte   $CF
        beq     L8AFF
        .byte   $E7
        .byte   $C2
        adc     ($39,x)
L8AFA:  .byte   $34
        .byte   $27
        .byte   $7C
        .byte   $73
        .byte   $92
L8AFF:  .byte   $CB
        .byte   $42
        .byte   $C3
        .byte   $02
        plp
        bit     L29BC
        .byte   $3F
        ldy     L2220
        .byte   $C0
L8B0C:  .byte   $32
        .byte   $8F
        .byte   $04
        .byte   $0B
        lsr     a
        asl     a
        .byte   $4F
        .byte   $FF
        asl     a
        eor     $0E
        .byte   $0B
        jmp     L750B

        .byte   $42
        sta     ($68,x)
        ora     $AB,x
        .byte   $E2
        .byte   $8B
        .byte   $1A
        cmp     $3B,x
        .byte   $13
        inc     $A2C3,x
        asl     $61,x
        .byte   $C2
L8B2C:  adc     #$F1
        eor     #$FF
L8B30:  asl     $03
        .byte   $14
        .byte   $80
L8B34:  sta     ($FA),y
        bmi     L8B39
        .byte   $3D
L8B39:  bvs     L8AC1
        rol     a
L8B3C:  eor     $B8,x
        sbc     $AE60,x
        rol     a
        .byte   $67
        .byte   $CE
L8B44:  .byte   $3F
        .byte   $4B
        lda     #$57
        .byte   $CB
        .byte   $FB
        eor     L7E86,y
        .byte   $5F
        cmp     $59,x
        nop
        .byte   $AB
        .byte   $D7
        .byte   $E7
        rol     $54
        .byte   $82
        .byte   $82
        .byte   $42
        and     ($17,x)
        .byte   $9B
        ror     $05
        sbc     L2170
        lda     $FF35,y
        .byte   $BB
        .byte   $37
        .byte   $BF
        lsr     L7979,x
        .byte   $77
        sei
L8B6C:  .byte   $93
        jsr     L5B80
        jmp     (L1308)

        cpy     $7E
        .byte   $22
        ora     ($88),y
        .byte   $44
        .byte   $EB
        sbc     ($12),y
        jsr     L8B44
        .byte   $AF
        cmp     $9E21
        .byte   $39
L8B84:  .byte   $7F
        and     $FDC7
        .byte   $83
L8B89:  .byte   $0F
        beq     L8BDA
        ora     $30
        clc
        .byte   $0C
        asl     $03
        ora     ($83,x)
        .byte   $FF
        inc     L7078,x
        rts

        adc     L1050
        .byte   $4F
        .byte   $93
        .byte   $83
        .byte   $80
        .byte   $83
        brk
L8BA2:  asl     a
        asl     a
        adc     $E954,y
        lsr     $6F,x
        .byte   $5F
        ror     $AB6F
        lsr     $0404
        .byte   $03
L8BB1:  .byte   $3F
        .byte   $80
        cpy     #$77
        .byte   $1B
        sei
        .byte   $A7
        .byte   $D7
        cmp     ($F7),y
L8BBB:  stx     $AF
        .byte   $3E
L8BBE:  inc     $BDFF,x
        tsx
        adc     $AC
        .byte   $D3
        .byte   $9F
        cpy     L1A04
        .byte   $DA
        and     $EB
L8BCC:  sed
        sty     $01,x
        rol     a
        cmp     ($2F),y
        .byte   $8F
        inx
        ora     $9F7F
        .byte   $CF
        .byte   $B3
        .byte   $CB
L8BDA:  .byte   $B7
        .byte   $CB
        .byte   $89
        cpx     $F7D3
        .byte   $FF
        .byte   $EF
        .byte   $E7
        .byte   $D7
        iny
        cpy     $D120
        rol     $C5
        .byte   $02
        .byte   $97
        .byte   $CF
        .byte   $82
        asl     $96D4
        ror     $C242
        .byte   $57
        ror     $C4
        .byte   $44
        .byte   $03
        rol     $FA60,x
        bne     L8C6F
        lsr     $19,x
        .byte   $80
        bpl     L8BB1
        asl     $1E,x
        asl     $0E,x
        .byte   $12
        rol     $FF7A
        .byte   $DF
L8C0C:  sbc     #$F7
        sbc     #$D5
        sbc     #$B1
        sbc     L28B1,y
        php
        rol     L209E,x
        .byte   $54
        sbc     $09,x
        cmp     $C4
        .byte   $C4
L8C1F:  sbc     #$EE
        ror     $01,x
        .byte   $FA
        .byte   $8B
        .byte   $5F
        .byte   $EF
        .byte   $DF
        .byte   $AF
        .byte   $DF
        .byte   $B7
        cpx     #$E3
        sbc     ($ED,x)
        iny
        sta     ($DF,x)
        .byte   $04
        .byte   $9C
        .byte   $9F
        .byte   $9F
        .byte   $F2
        cmp     ($6C,x)
        cpx     $ED
        brk
        .byte   $0B
        .byte   $87
        sty     $83
        .byte   $53
L8C41:  eor     ($01),y
L8C43:  eor     ($D5,x)
        .byte   $EF
        sed
        .byte   $79
L8C48:  ldx     $B7,y
        .byte   $F7
        .byte   $D4
        .byte   $8F
        rol     $F0EF
        bvs     L8C99
        .byte   $93
        sed
        rol     a
        inc     L7E77,x
        adc     $7E,x
        adc     $F2,x
        stx     $F2C0
L8C5F:  .byte   $47
        ldy     L7214,x
        ora     ($80,x)
        inc     $07,x
        .byte   $C7
L8C68:  sta     L3861
        .byte   $FF
        .byte   $FF
        .byte   $03
        .byte   $F3
L8C6F:  .byte   $04
L8C70:  cmp     L43C9,x
L8C73:  adc     ($9B),y
        bit     $2A
        jsr     LE0D1
        and     L22E2,y
        .byte   $73
        cpx     $25
        ror     L7F3E,x
        dec     L3C6C,x
L8C86:  .byte   $36
L8C87:  .byte   $3A
        sec
        sec
        .byte   $3F
        .byte   $DC
        .byte   $42
        .byte   $7C
        cli
        jsr     LA158
        .byte   $03
        lda     L7379,x
        bmi     L8C9F
        .byte   $76
L8C99:  rti

        bmi     L8C87
        lda     #$FD
        .byte   $F9
L8C9F:  adc     #$EA
        sbc     $FFE9,y
        .byte   $7A
        eor     #$58
        eor     $69
        .byte   $AB
L8CAA:  .byte   $93
        .byte   $8B
        .byte   $E3
        .byte   $D4
        brk
        ora     L65A6
        tsx
        cpx     #$2F
        ora     ($0D),y
        ora     L5901,y
        ora     ($50),y
        .byte   $5C
        brk
        and     ($3A),y
        .byte   $C2
        cmp     $C9
        sbc     $D2
        adc     L2479,y
        .byte   $CF
        .byte   $E3
        .byte   $97
        .byte   $C7
        .byte   $62
        .byte   $7F
        .byte   $52
        adc     L3372
        .byte   $EF
        cpx     $89
        lda     $90,x
        ldy     $86,x
        .byte   $BF
        .byte   $57
        dec     $47
        .byte   $EB
        .byte   $FF
        .byte   $3F
        rts

        bvc     L8CEB
L8CE3:  .byte   $73
        iny
        sty     $13,x
        .byte   $47
        lsr     $9DDF,x
L8CEB:  rol     $FFF8
        .byte   $F7
        .byte   $FF
        .byte   $0F
        .byte   $77
        .byte   $1D
        .byte   $FF
L8CF4:  .byte   $BF
        .byte   $1F
        .byte   $7F
        bmi     L8C86
        brk
        .byte   $FA
        .byte   $91
L8CFC:  .byte   $03
        cmp     ($A0,x)
        inc     L8F24,x
        .byte   $8F
        .byte   $80
        .byte   $F4
        cpx     #$1A
        .byte   $80
        .byte   $34
        cli
        php
        ora     (L0060),y
        .byte   $02
        ldx     #$7B
        .byte   $FF
        sbc     L3639,x
        .byte   $BF
        .byte   $BF
        .byte   $BF
        sed
        .byte   $FB
        sbc     ($E1),y
        .byte   $FC
        and     L1020,x
        plp
        bmi     L8D5A
        .byte   $3A
        rol     L0C3F,x
        cmp     $A021,x
        ldx     #$40
        rti

        sbc     $0E
        .byte   $1E
L8D2F:  asl     $FF7E,x
        asl     $DE,x
        .byte   $7E
L8D35:  ldx     $FE7E,y
        .byte   $9E
        adc     $DF1E,x
        ldy     $6A,x
        dex
        .byte   $5D
        .byte   $A4
L8D41:  .byte   $34
        sei
        .byte   $77
        ror     $DC66,x
        .byte   $D0
L8D48:  asl     $44
        .byte   $A9
L8D4B:  .byte   $E3
        .byte   $32
        cpx     L8303
        .byte   $E7
        beq     L8D6A
        .byte   $1B
L8D54:  rts

        .byte   $07
        .byte   $43
        .byte   $BE
        .byte   $23
L8D59:  .byte   $6B
L8D5A:  ora     ($20,x)
        .byte   $2F
        .byte   $4F
        .byte   $87
L8D5F:  .byte   $B3
        cpy     #$FD
        .byte   $F3
        .byte   $3C
        .byte   $17
        .byte   $A7
        asl     a
        .byte   $EB
        .byte   $3D
        .byte   $D3
L8D6A:  ldy     $BFFE
        adc     L3F16,x
L8D70:  .byte   $93
        .byte   $FF
        .byte   $F7
        .byte   $F3
        .byte   $E7
        .byte   $E3
        .byte   $0C
        eor     L7659,x
        sbc     L8916
        .byte   $16
L8D7E:  asl     $0113,x
        .byte   $DB
        lsr     L8D5F
        and     $0782,x
        .byte   $E2
        ora     ($A7,x)
        sta     $FCF8,x
L8D8E:  sec
        .byte   $3C
        clc
        .byte   $1F
        .byte   $CF
L8D93:  ldx     L2626
        asl     L0056
        .byte   $26
L8D99:  .byte   $1A
        .byte   $B2
        .byte   $14
        plp
        bpl     L8D9F
L8D9F:  .byte   $43
        inc     $33
        sbc     ($E3),y
        adc     $C3EA
L8DA7:  .byte   $C2
        adc     #$C0
        ora     #$F7
        .byte   $FC
        .byte   $07
        lsr     a
        cpy     L2C33
        .byte   $04
        plp
        .byte   $04
        pha
        cpy     $C9
        .byte   $4F
        eor     $93
        sbc     L6020,x
        sta     $8A
L8DC0:  ora     $82
        ora     ($C0,x)
        bvc     L8DC6
L8DC6:  bpl     L8D99
        bcc     L8DF0
        adc     $D302
        asl     $64
        lda     ($42,x)
        .byte   $03
L8DD2:  bvs     L8D54
        bpl     L8DDD
        .byte   $83
        ora     ($23,x)
        rts

        .byte   $67
        cpy     #$43
L8DDD:  .byte   $34
        .byte   $CB
        .byte   $34
L8DE0:  .byte   $4B
        .byte   $34
        .byte   $FF
        .byte   $DF
        .byte   $8B
        sbc     L28DF,x
        .byte   $27
        .byte   $CF
        .byte   $D2
        .byte   $C9
L8DEC:  asl     $E1
        .byte   $74
        .byte   $69
L8DF0:  inc     $04
        lsr     a
        .byte   $17
        .byte   $0B
        .byte   $9C
        .byte   $97
        .byte   $8B
        .byte   $97
        .byte   $E2
        .byte   $8F
        lda     $5D
        .byte   $10
L8DFE:  bvs     L8E09
        .byte   $FC
        inc     L58A3,x
        .byte   $4F
        .byte   $AF
        asl     L6415,x
L8E09:  bit     L6CF3
        cmp     ($D7),y
        rol     $DF
        rol     L2045,x
        beq     L8DEC
        .byte   $ED
        .byte   $F7
L8E17:  sbc     #$F6
        sbc     $FFFD,y
        .byte   $9F
        .byte   $FF
        .byte   $80
        .byte   $F0
L8E20:  .byte   $FF
        .byte   $13
        .byte   $6D
        .byte   $E6
L8E24:  .byte   $97
        .byte   $3F
        sed
        sei
        .byte   $E7
        .byte   $DD
        .byte   $2D
L8E2B:  and     $B0FB,y
        sta     $6E
        .byte   $97
        .byte   $6F
L8E32:  .byte   $9B
        .byte   $80
        .byte   $E2
        .byte   $A7
        .byte   $E3
        rol     $75,x
        .byte   $80
        and     ($10),y
        .byte   $FC
        rts

        .byte   $8B
        .byte   $4B
        ora     $41,x
        dec     $D5C2
        .byte   $22
        cmp     ($20),y
        cmp     #$C9
        sta     (L0081,x)
        rol     L0806
        ora     $9CF4
        .byte   $C2
L8E53:  bvs     L8E7D
        .byte   $1F
        rol     $906C,x
        pha
        bvc     L8EB4
        rts

        pla
        .byte   $70
L8E5F:  adc     $C30C,x
        ldy     $99D6,x
        beq     L8EBB
        .byte   $CF
        sta     $B7
        .byte   $87
        clv
        .byte   $9F
        cmp     L0F6B,y
        stx     $8F,y
        .byte   $FF
        .byte   $FF
        jmp     L1F01

        .byte   $E3
L8E78:  pha
        .byte   $34
        .byte   $23
        pha
        .byte   $74
L8E7D:  .byte   $1C
        .byte   $7F
        .byte   $30
L8E80:  .byte   $1B
        cpy     #$DF
        .byte   $EB
        and     $28
        brk
        .byte   $13
        .byte   $D2
L8E89:  .byte   $47
        .byte   $EF
        .byte   $23
        brk
        .byte   $03
        .byte   $43
        .byte   $DF
        .byte   $A3
        .byte   $80
        .byte   $83
        cpy     #$17
        .byte   $9B
        sbc     ($49),y
L8E98:  .byte   $82
        eor     $FFAE,y
        tya
        .byte   $0B
        sei
        .byte   $7F
        bmi     L8EC2
        and     ($A0),y
        .byte   $52
        asl     $9412,x
        and     #$F3
        .byte   $53
        lda     ($1A),y
        bit     L609F
        .byte   $34
        eor     ($14,x)
        .byte   $1F
L8EB4:  cpx     $17
L8EB6:  .byte   $5F
        inx
        sta     ($44),y
        .byte   $2F
L8EBB:  eor     ($9C,x)
        .byte   $E7
        .byte   $FC
        asl     $F6CF,x
L8EC2:  .byte   $3B
        lda     $7F,x
        dec     L516E,x
        .byte   $A7
        .byte   $D2
        sbc     $1D
        .byte   $7C
        inc     L2A50
        .byte   $22
        .byte   $07
        .byte   $D2
        sbc     $22
        .byte   $7A
        .byte   $B9
L8ED7:  cli
        .byte   $62
        and     #$EF
        lsr     $2D
        .byte   $07
        .byte   $9B
        .byte   $74
        sta     ($EC),y
        .byte   $C2
        .byte   $74
        bpl     L8F39
        cmp     $49
        ldy     L6D2A,x
        .byte   $7F
        .byte   $B2
L8EED:  asl     a
        .byte   $B2
        bpl     L8F04
        .byte   $67
        .byte   $3A
        sty     $04
        asl     a
        .byte   $53
        cpx     $20
        .byte   $BF
        .byte   $E3
        lsr     L0060,x
        sei
        .byte   $42
        ora     L1672,y
        .byte   $7E
        .byte   $A0
L8F04:  tay
        bit     $A1
        lda     $20
        lda     $18
        lda     $19
L8F0D:  adc     $CFA2,x
L8F10:  .byte   $17
        .byte   $70
L8F12:  rts

L8F13:  eor     $34,x
        ora     ($B0),y
        .byte   $80
        .byte   $5F
        and     #$00
        ora     ($FF,x)
        .byte   $FF
        sbc     $40,x
        .byte   $3F
        sbc     L1D00
L8F24:  .byte   $FF
        .byte   $FC
