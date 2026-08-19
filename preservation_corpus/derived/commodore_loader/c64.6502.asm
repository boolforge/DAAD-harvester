; da65 V2.18 - Ubuntu 2.19-1
; Created:    2026-08-19 11:28:47
; Input file: preservation_corpus/extracted/depth2_cebfe1e3_EDI64
; Page:       1


        .setcpu "6502"

L0000           := $0000
L02BF           := $02BF
L02DE           := $02DE
L4111           := $4111
L4803           := $4803
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
        jmp     L34DC

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
        jmp     L26D1

        jmp     L2251

        jmp     L23AE

        jmp     L2627

        jmp     L262F

        .byte   $4C
L083A:  eor     ($08,x)
        sta     $D400,y
L083F:  rts

        rti

L0841:  ldx     #$03
        pla
        sta     $02EE
        pla
        .byte   $8D
L0849:  .byte   $EF
        .byte   $02
        stx     $02AD
        jsr     LFFE7
        lda     $02C0
        bne     L085E
        lda     #$08
        jsr     L26D1
        jsr     L2812
L085E:  jsr     L224F
        ldx     $02AD
        lda     #$BA
        sta     $41
        lda     #$34
        sta     $42
        cpx     #$65
        beq     L08E3
        lda     #$C0
        sta     $41
        lda     #$34
        sta     $42
        cpx     #$64
        beq     L08E3
        txa
        pha
        lda     #$CB
        sta     $41
        lda     #$34
        sta     $42
        jsr     L1B78
        pla
        sta     $8B
        lda     #$00
        sta     $8C
        jsr     L1AFB
        ldx     $02AD
        cpx     #$64
        bcs     L08E6
        lda     #$D7
        sta     $41
        lda     #$34
        sta     $42
        jsr     L1B78
        lda     $02E9
        sta     $8B
        jsr     L1AF7
        lda     #$3A
        jsr     L2251
        lda     $02EE
        sta     $FB
        lda     $02EF
        sta     $FC
        ldx     #$00
        lda     ($FB,x)
        sta     $8B
        jsr     L1AF7
        lda     #$2C
        jsr     L2251
        ldy     #$01
        lda     ($FB),y
        sta     $8B
        jsr     L1AF7
        lda     #$3E
        jsr     L2251
        lda     $02EA
        sta     $8B
        jsr     L1AF7
        jmp     L08E4

L08E3:  .byte   $20
L08E4:  sei
        .byte   $1B
L08E6:  jsr     L23AE
        ldy     #$00
        sty     $C6
L08ED:  lda     $C6
        beq     L08ED
L08F1:  sty     $C6
        jsr     L31C7
        lda     $02A7
        and     #$FB
        sta     $02A7
        lda     #$00
        sta     $02AD
        sta     $02C4
        sta     $02C5
        sta     $02C6
        lda     #$0D
        sta     L34DC
        lda     #$78
        sta     $02C8
        lda     $02C0
        beq     L091E
        jmp     (L02BF)

L091E:  ldx     #$F7
        txs
        lda     $A2
        sta     $02B4
        jsr     L28F4
        lda     #$2A
        sta     $8D
        lda     #$34
        sta     $8E
        ldx     #$08
L0933:  ldy     #$0F
L0935:  lda     L341A,y
        sta     ($8D),y
        dey
        bpl     L0935
        clc
        lda     #$10
        adc     $8D
        sta     $8D
        lda     #$00
        adc     $8E
        sta     $8E
        dex
        bne     L0933
        lda     #$00
        jsr     L26F6
        jsr     L2812
        lda     #$00
        sta     $8D
        lda     #$D4
        sta     $8E
        lda     #$00
        ldy     #$1C
L0961:  sta     ($8D),y
        dey
        bpl     L0961
        lda     #$0F
        sta     $D418
        lda     #$F0
        sta     $D406
        lda     #$00
        tay
L0973:  sta     $367E,y
        dey
        bne     L0973
        sta     $02A7
        lda     #$80
        sta     $369B
        jsr     L098A
        beq     L0989
        jmp     L08F1

L0989:  .byte   $4C
L098A:  cpy     $33
        tsx
        .byte   $8E
L098E:  .byte   $E7
        .byte   $02
        lda     #$00
        sta     $02E9
        jsr     L2944
        lda     #$00
        pha
        sta     $02EB
        .byte   $8D
L099F:  inx
        .byte   $02
        ldx     #$00
        lda     ($FB,x)
L09A5:  bne     L09D8
        pla
        beq     L09BC
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
        jmp     L1095

L09BC:  lda     $02E8
        beq     L09D7
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
        jmp     L0A0D

L09D7:  rts

L09D8:  jsr     L3333
        tay
        cpy     #$FF
        beq     L09E5
        cpy     $369F
        bne     L09F0
L09E5:  lda     ($FB,x)
        cmp     #$FF
        beq     L09FC
        cmp     $36A0
        beq     L09FC
L09F0:  jsr     L3333
        jsr     L3333
        jsr     L3333
L09F9:  jmp     L099F

L09FC:  jsr     L3333
        ldx     #$00
        lda     ($FB,x)
        sta     $FD
        jsr     L3333
        lda     ($FB,x)
        sta     $FE
        .byte   $20
L0A0D:  .byte   $33
        .byte   $33
        ldx     #$00
        lda     ($FD,x)
        cmp     #$FF
        beq     L09F9
        lda     $FC
        pha
        lda     $FB
        pha
        lda     ($FD,x)
        sta     $02EA
        asl     a
        tay
        iny
        lda     L12D9,y
        pha
        dey
        lda     L12D9,y
        pha
        jsr     L333A
        lda     ($FD,x)
        bit     $02EA
        bpl     L0A3C
        tay
        lda     $367E,y
L0A3C:  tay
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

        cmp     $36A4
        beq     L0AD5
        jmp     L0ABF

        cmp     $36A4
        bne     L0AD5
        jmp     L0ABF

        cmp     $36A4
        bcc     L0AD5
        jmp     L0ABF

        cmp     $36A4
        bcc     L0AC1
        beq     L0AC1
        jmp     L0AD3

        lda     ($8B,x)
        cmp     $36A4
        beq     L0AD5
        cmp     #$FD
        bcs     L0AD5
        jmp     L0ABF

        lda     ($8B,x)
        cmp     $36A4
        beq     L0AC1
        cmp     #$FD
        bcs     L0AC1
        jmp     L0AD3

        lda     ($8B,x)
        cmp     #$FD
        beq     L0AD5
        jmp     L0ABF

        lda     ($8B,x)
        cmp     #$FD
        beq     L0AC1
        jmp     L0AD3

        lda     ($8B,x)
        cmp     #$FE
        bne     L0AC1
        jmp     L0AD3

        lda     ($8B,x)
        cmp     #$FE
        beq     L0AC1
        jmp     L0AD3

        sta     $3F
        jsr     L1ACD
        cmp     $3F
L0ABF:  bcc     L0AD5
L0AC1:  pla
        sta     $FB
        pla
        sta     $FC
        jmp     L099F

        lda     ($FB,x)
        bne     L0AC1
        jmp     L0AD3

        lda     ($FB,x)
L0AD3:  beq     L0AC1
L0AD5:  .byte   $20
L0AD6:  .byte   $3A
        .byte   $33
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L0A0D

        jsr     L333A
L0AE4:  lda     ($FD,x)
        cmp     ($FB,x)
        bne     L0AC1
        jmp     L0AD3

        jsr     L0F4B
        jmp     L0AE4

        jsr     L333A
L0AF6:  lda     ($FD,x)
        cmp     ($FB,x)
        beq     L0AC1
        jmp     L0AD3

        jsr     L0F4B
        jmp     L0AF6

        jsr     L0F4B
        jmp     L0B0E

        jsr     L333A
L0B0E:  lda     ($FD,x)
        cmp     ($FB,x)
        bcc     L0AD5
        jmp     L0ABF

        jsr     L0F4B
        jmp     L0B20

        jsr     L333A
L0B20:  lda     ($FD,x)
        cmp     ($FB,x)
        bcc     L0AC1
        beq     L0AC1
        jmp     L0AD3

        .byte   $CD
L0B2C:  lda     ($36,x)
        beq     L0AD5
        jmp     L0ABF

        cmp     $36A2
L0B36:  jmp     L0B2C

        cmp     $36A9
        jmp     L0B2C

        cmp     $36AA
        jmp     L0B2C

        cmp     $36AB
L0B48:  jmp     L0B2C

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$0C
        jsr     L1F9E
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
        jsr     L2960
        pla
        eor     #$FF
        cmp     ($FB,x)
        bne     L0B72
        jmp     L0E50

L0B72:  jmp     L0ABF

        lda     #$00
        sta     $D418
        sta     $C6
        lda     #$0D
        jsr     L1F9E
        ldx     #$00
        lda     ($FB,x)
        pha
        lda     #$1F
        jsr     L2960
        pla
        eor     #$FF
        ldx     $02E7
        txs
        ldx     #$00
        sec
        sbc     ($FB,x)
        beq     L0BA3
        stx     $36A4
        ldx     $02E7
        txs
        jmp     L098E

L0BA3:  ldx     $02E7
        txs
        .byte   $C9
L0BA8:  brk
        rts

        pha
        lda     $02A7
        and     #$FB
        .byte   $8D
        .byte   $A7
L0BB2:  .byte   $02
        pla
        jsr     L1B6A
        pla
        sta     $FB
        pla
        sta     $FC
        lda     #$FF
        sta     $02AC
        jmp     L09A5

        lda     #$0F
        jmp     L0BB2

        lda     $FE
        pha
        lda     $FD
        pha
        jsr     L2608
        pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0E50

        jsr     L333A
        pha
        lda     ($FD,x)
        tay
        pla
        jsr     L0819
        jmp     L0E4D

        jsr     L333A
        pha
        lda     ($FD,x)
        tay
        pla
        jsr     L081C
        jmp     L0E4D

        lda     $FE
        pha
        lda     $FD
        pha
        jsr     L2743
        pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0E50

        .byte   $8E
L0C0B:  .byte   $7F
        rol     $BD,x
L0C0E:  ror     $C937,x
        .byte   $FF
        beq     L0C22
        cmp     #$FD
        bcc     L0C1E
        lda     $36A4
        sta     $377E,x
L0C1E:  inx
        jmp     L0C0B

L0C22:  jmp     L0E50

L0C25:  pla
        sta     $FD
        pla
        sta     $FE
        lda     #$1A
        jmp     L0D06

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FD
        sta     $FD
        lda     #$FE
        sta     $FE
        lda     $36A4
        jsr     L1567
        beq     L0C25
        pla
        sta     $FD
        pla
        sta     $FE
        jsr     L3348
L0C4F:  jmp     L0C53

        .byte   $20
L0C53:  .byte   $D3
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$19
        cpy     #$FD
        bcs     L0CB8
        lda     #$1A
        cpy     $36A4
L0C63:  bne     L0CB8
        lda     $36B1
        jsr     L144F
        jsr     L13F8
        clc
        adc     $FC
        cmp     $36B2
        beq     L0C7A
        lda     #$2B
L0C78:  bcs     L0CB8
L0C7A:  lda     #$24
        sta     $FB
        lda     #$1B
L0C80:  sta     $FC
        lda     $FC
        pha
        lda     $FB
        pha
        ldy     $367F
        cpy     $36A3
        bcs     L0CA7
        lda     #$FE
        ldx     #$00
        sta     ($8B,x)
        inc     $367F
        pla
        sta     $FB
        pla
        sta     $FC
L0C9F:  lda     $FB
        jsr     L1B6A
        jmp     L0E4D

L0CA7:  pla
        sta     $FB
        pla
        sta     $FC
        ldx     $02EB
        beq     L0CB8
        ldx     $3883
        stx     $02EB
L0CB8:  jmp     L0BA8

        jsr     L1540
        beq     L0D08
        jsr     L3348
        jmp     L0CC7

        .byte   $20
L0CC7:  .byte   $D3
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$18
        cpy     #$FD
        beq     L0CB8
        lda     #$31
        cpy     $36A4
        beq     L0CB8
        lda     #$1C
        cpy     #$FE
        bne     L0CB8
        dec     $367F
        lda     $36A4
        sta     ($8B,x)
        lda     #$27
        jmp     L0C9F

        jsr     L3348
        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FE
        sta     $FE
        lda     #$FD
        jsr     L1562
        bne     L0D0F
        pla
        sta     $FD
        pla
        sta     $FE
L0D06:  lda     #$17
L0D08:  bcs     L0D0C
        lda     #$08
L0D0C:  jmp     L0BA8

L0D0F:  pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0D19

        .byte   $20
L0D19:  .byte   $D3
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$32
        cpy     #$FE
        beq     L0D0C
        cpy     $36A4
        beq     L0D0C
        lda     #$17
        cpy     #$FD
        bne     L0D0C
        jsr     L14FA
        lda     #$18
        bcc     L0D0C
        lda     #$26
        sta     $FB
        lda     #$2A
        sta     $FC
        jmp     L0C80

L0D41:  pla
        sta     $FD
        pla
        sta     $FE
        lda     #$1C
        jmp     L0D06

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FD
        jsr     L1560
        beq     L0D41
        tay
        pla
        sta     $FD
        pla
        sta     $FE
        jsr     L3348
        tya
        jmp     L0D68

        .byte   $20
L0D68:  .byte   $D3
        ora     $A1,x
        .byte   $8B
        tay
        lda     #$31
        cpy     $36A4
        beq     L0D0C
        lda     #$1D
        cpy     #$FD
        beq     L0D0C
        lda     #$1C
        bcc     L0D0C
        jsr     L14FA
        bcc     L0D0C
        lda     #$FD
        sta     ($8B,x)
        dec     $367F
        lda     #$25
        jmp     L0C9F

        tax
L0D90:  jsr     L2244
        dex
        bne     L0D90
        jmp     L0E4D

        sta     $36A4
        jmp     L0E4D

        cmp     $3884
        bcs     L0DCD
        ldx     $388E
        stx     $8D
        ldx     $388F
        stx     $8E
        jmp     L0DDF

        pha
        lda     $02A7
        ora     #$40
        sta     $02A7
        pla
        cmp     $3885
        bcs     L0DCD
        ldx     $3890
        stx     $8D
        ldx     $3891
        stx     $8E
        jmp     L0DDF

L0DCD:  ldx     #$07
        jmp     L0841

        cmp     $3886
        bcs     L0DCD
        ldx     $3892
        stx     $8D
        ldx     $3893
L0DDF:  stx     $8E
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
        jsr     L1B78
L0DFF:  jmp     L0E4D

        jsr     L15D3
        lda     ($8B,x)
        tay
        lda     #$FC
L0E0A:  sta     ($8B,x)
        cpy     #$FE
        bne     L0E4F
        dec     $367F
        jmp     L0E4D

        jsr     L15D3
        lda     ($8B,x)
        tay
        lda     $36A4
        sta     ($8B,x)
L0E21:  jmp     L0E0A

        jsr     L333A
        lda     ($FD,x)
        jsr     L15D3
        tay
        lda     ($8B,x)
        pha
        lda     $377E,y
        sta     ($8B,x)
        pla
        sta     $377E,y
        jmp     L0E4D

        cmp     #$26
        beq     L0E47
        lda     #$FF
        sta     ($FB,x)
        jmp     L0E4D

L0E47:  ldx     #$09
L0E49:  jmp     L0841

        txa
L0E4D:  sta     ($FB,x)
L0E4F:  .byte   $20
L0E50:  .byte   $3A
        .byte   $33
        pla
        sta     $FB
        pla
        sta     $FC
        lda     #$FF
        sta     $02AC
        jmp     L0A0D

        jsr     L333A
        sta     $8C
L0E65:  lda     ($FD,x)
        clc
        adc     ($FB,x)
        bcc     L0E99
        lda     #$FF
        jmp     L0E97

        jsr     L333A
L0E74:  lda     ($FD,x)
        sta     $8C
        lda     ($FB,x)
        sec
        sbc     $8C
        bcs     L0E80
        txa
L0E80:  sta     ($FB,x)
        jmp     L0E4D

        sta     $8C
        inc     $FD
        lda     ($FD,x)
        tay
        lda     $367E,y
L0E8F:  jmp     L0E97

        jsr     L333A
        sta     $8C
L0E97:  lda     ($FD,x)
L0E99:  sta     $8B
        lda     $8C
        cmp     #$26
        bne     L0EAA
        lda     $3884
        cmp     $8B
        bcc     L0EB1
        beq     L0EB1
L0EAA:  lda     $8B
        sta     ($FB,x)
        jmp     L0E4D

L0EB1:  ldx     #$01
        jmp     L0841

        jsr     L1BB1
        jmp     L0E50

        ldy     #$01
        lda     ($FB),y
        sta     $8C
L0EC2:  jmp     L0EC5

L0EC5:  stx     $8C
        lda     ($FB,x)
        sta     $8B
        jsr     L1AFB
L0ECE:  jmp     L0E4D

        jsr     L333A
        lda     ($FD,x)
        jsr     L14F2
        cmp     ($8B,x)
        bne     L0EEC
L0EDD:  jmp     L0AD3

        jsr     L333A
        lda     ($FD,x)
        jsr     L14F2
        cmp     ($8B,x)
        bne     L0EDD
L0EEC:  jmp     L0ABF

        jsr     L15D3
        jsr     L333A
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        lda     ($FD,x)
        jsr     L14F2
        pha
        lda     ($FB,x)
        jmp     L0F29

        jsr     L14F2
        pha
        lda     $36B1
        jmp     L0F26

        lda     ($FB,x)
        cmp     #$FF
        bne     L0F1F
        ldx     #$02
        jmp     L0841

        lda     ($8B,x)
L0F1F:  pha
        jsr     L333A
        lda     ($FD,x)
        .byte   $20
L0F26:  .byte   $D3
        ora     $20,x
L0F29:  plp
        ora     $C9,x
        inc     $03D0,x
        dec     $367F
        pla
        cmp     #$FE
        bne     L0F3A
        inc     $367F
L0F3A:  sta     ($FB,x)
        jmp     L0E4D

        lda     $FB
        sta     $8B
        lda     $FC
        sta     $8C
        jsr     L0F53
        .byte   $4C
L0F4B:  .byte   $97
        asl     $FBA5
        sta     $8B
        lda     $FC
L0F53:  sta     $8C
        jsr     L333A
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

        jsr     L0F4B
        jmp     L0E65

        jsr     L0F4B
        jmp     L0E74

        lda     $36A4
        sta     $8C
        lda     $02A7
        ora     #$02
        sta     $02A7
        jsr     L169F
        jmp     L0E50

        tay
        lda     $FE
        pha
        lda     $FD
        pha
        cpy     #$00
        bne     L0F9E
        jsr     L17AD
        jmp     L0F9F

L0F9E:  .byte   $20
L0F9F:  sta     $6817,y
        sta     $FD
        pla
        sta     $FE
        bcs     L0FB4
        lda     $02A7
        ora     #$10
        sta     $02A7
        jmp     L0ABF

L0FB4:  jmp     L0AD3

        jsr     L14F2
        sta     $8C
        lda     $02A7
        and     #$FD
        sta     $02A7
        jsr     L169F
        jmp     L0E4D

        jsr     L333A
        cmp     $3887
        bcs     L1006
        cmp     #$00
        beq     L1006
        pha
        jsr     L2944
        pla
        inc     $02E8
        ldx     $02E8
        cpx     #$0A
        beq     L1003
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
        jmp     L099F

L1003:  jmp     L083F

L1006:  ldx     #$06
        jmp     L0841

        lda     $02E9
        jsr     L2944
        pla
        pla
        jmp     L099F

        sta     $36AE
        jsr     L333A
        lda     ($FD,x)
        sta     $8B
        lda     #$F8
        bne     L1052
        jsr     L333A
        jmp     L0E4D

        lda     $02A7
        and     #$FB
        sta     $02A7
        jmp     L0E50

        sta     $36A3
        jsr     L333A
        lda     ($FD,x)
        sta     $36B2
        jmp     L0E4D

        sta     $36A7
        jsr     L333A
        lda     ($FD,x)
        asl     a
        asl     a
        asl     a
        sta     $8B
        lda     #$C7
L1052:  sta     $8C
        lda     $36AF
        eor     $8B
        and     $8C
        eor     $8B
        sta     $36AF
        jmp     L0E4D

        sta     L1070
        jsr     L333A
        lda     ($FD,x)
        sta     L1071
        .byte   $20
        .byte   $3A
L1070:  .byte   $33
L1071:  jsr     L0000
        jmp     L0E50

        ldx     #$05
L1079:  jmp     L0841

        jsr     L14F2
        sta     $36B0
        ldx     #$04
        lda     $02EB
        bne     L1079
        pla
        sta     $FB
        pla
        sta     $FC
        lda     $02A7
        and     #$EF
        .byte   $8D
L1095:  .byte   $A7
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
L10BF:  lda     $36B0
        jsr     L165F
        bcc     L10F3
        sta     $36A0
        cmp     $36AA
        php
        jsr     L3333
        lda     ($FB,x)
        sta     $36A1
        plp
        bne     L10E4
        lda     $36AB
        cmp     #$FF
        beq     L10BF
        cmp     ($FB,x)
        beq     L10BF
L10E4:  lda     $8B
        sta     $02EB
        tya
        jsr     L15D3
        pla
        sta     $FE
        jmp     L0E4D

L10F3:  lda     #$00
        sta     $02EB
        ldx     #$09
L10FA:  pla
        dex
        bne     L10FA
L10FE:  jmp     L09A5

        sta     $02B0
        jsr     L0F53
        lda     $FC
        pha
        lda     $FB
        pha
        jsr     L144C
        lda     $FC
        sta     $8B
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L0E99

        sta     $8C
        jsr     L13F8
        jmp     L0E97

        sta     $8C
        jsr     L1ACD
        jmp     L0E97

L112D:  jmp     L0D06

        sta     $02FE
        jsr     L1540
        beq     L112D
        jmp     L1144

        jsr     L15D3
        jsr     L333A
        lda     ($FD,x)
        .byte   $8D
L1144:  inc     $A102,x
        .byte   $8B
        tay
        lda     #$18
        cpy     #$FD
        beq     L116C
        lda     #$31
        cpy     $36A4
        beq     L116C
        lda     #$1C
        cpy     #$FE
        bne     L116C
        lda     $02FE
        sta     ($8B,x)
        dec     $367F
        ldy     #$2C
        jsr     L11EE
        jmp     L0C9F

L116C:  jmp     L0BA8

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
        jsr     L1567
        bne     L119E
        lda     $36A4
        jsr     L1583
        bne     L119E
        pla
        sta     $FD
        pla
        sta     $FE
        lda     $02FE
        bcs     L11E8
        jmp     L0D08

L119E:  pla
        sta     $FD
        pla
        sta     $FE
        lda     $02FE
        jmp     L11B0

        jsr     L15D3
        jsr     L333A
L11B0:  lda     ($FD,x)
        sta     $FC
        lda     ($8B,x)
        tay
        lda     #$19
        cpy     #$FD
        bcs     L116C
        cpy     $FC
        bne     L11DD
        lda     $8C
        pha
        lda     $8B
        pha
        lda     $FC
        jsr     L1528
        tay
        pla
        sta     $8B
        pla
        sta     $8C
        cpy     #$FD
        bcc     L11DA
        jmp     L0C63

L11DA:  jmp     L0C78

L11DD:  cpy     $36A4
        php
        ldy     #$2D
        lda     $FC
        plp
        beq     L11EA
L11E8:  ldy     #$34
L11EA:  jsr     L11EE
        .byte   $4C
L11EE:  tay
        .byte   $0B
        pha
        tya
        jsr     L1B6A
        lda     $02A9
        ora     #$10
        sta     $02A9
        pla
        jsr     L1A7B
        lda     #$33
        rts

        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$FD
        sta     $FE
        jsr     L1560
        pla
        sta     $FD
        pla
        sta     $FE
L1217:  jmp     L0E50

        ldy     #$00
        lda     $3898
        sta     $FB
        lda     $3899
L1224:  sta     $FC
L1226:  lda     ($FB),y
        sta     $377E,y
        iny
        cmp     #$FE
        bcc     L1226
        bne     L1217
        inc     $367F
        jmp     L1224

        stx     $02AC
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L09A5

        lda     ($FB,x)
        cmp     $3884
        bcs     L1271
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
        jsr     L175D
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
        bcc     L1271
        sta     ($FB,x)
        jmp     L0E4D

L1271:  jmp     L0ABF

        lda     $02AC
        bne     L1281
L1279:  jmp     L0ABF

        lda     $02AC
        bne     L1279
L1281:  jmp     L0AD6

        stx     $FC
        asl     a
        sta     $FB
        bcc     L128D
        dec     $FC
L128D:  asl     $FB
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
        jmp     L099F

        cmp     #$FF
        beq     L12AE
        sta     $369F
L12AE:  jsr     L333A
        lda     ($FD,x)
        cmp     #$FF
        beq     L12BA
        sta     $36A0
L12BA:  jmp     L0E4D

        jsr     L15D3
        jmp     L0E4D

        lda     #$20
        jsr     L2251
        jmp     L0E50

        jsr     L13D9
        bne     L12D8
L12D0:  jmp     L0ABF

        jsr     L13D9
        bne     L12D0
L12D8:  .byte   $4C
L12D9:  .byte   $D3
        asl     a
        .byte   $53
        asl     a
        .byte   $5B
        asl     a
        .byte   $63
        asl     a
        .byte   $6B
        asl     a
        adc     $0A,x
        .byte   $83
        asl     a
        sta     ($0A),y
        txs
        asl     a
        .byte   $A3
        asl     a
        ldy     $B50A
        asl     a
        .byte   $C7
        asl     a
        dec     $DE0A
        asl     a
        php
        .byte   $0B
        .byte   $1A
        .byte   $0B
        plp
        .byte   $0B
        bmi     L130A
        .byte   $E7
        .byte   $0B
        .byte   $9C
        ora     L0B48
        .byte   $72
        .byte   $0B
        ldy     $0B,x
        .byte   $C2
L130A:  .byte   $0B
        .byte   $C7
        .byte   $0B
        and     ($1E,x)
        lda     #$1E
        lda     $E80E,y
        .byte   $1B
        sbc     $0B,x
        .byte   $07
        .byte   $0C
        and     $B80C
        .byte   $0C
        eor     #$0D
        sbc     #$0C
        sty     $A40D
        .byte   $12
        stx     $0D,y
        ldx     L150D
        ora     L0C4F
        .byte   $C3
        .byte   $0C
        .byte   $64
        ora     L0DFF
        .byte   $13
        asl     L0E21
        cpx     $390E
        asl     L0E49
        eor     $6E0E,x
        asl     L0E8F
        .byte   $B3
        asl     L0EC2
        .byte   $CF
        ora     L0ECE
        tsx
        .byte   $12
        cpy     #$12
        iny
        .byte   $12
        bne     L1365
        .byte   $77
        .byte   $0F
        .byte   $D9
L1356:  .byte   $0B
        tax
        ora     L1DCF,x
        .byte   $FB
L135C:  .byte   $1C
        ror     $1D
        ror     $8D1D
        ora     L0B36,x
L1365:  .byte   $3C
        .byte   $0B
        .byte   $42
        .byte   $0B
L1369:  .byte   $6B
        .byte   $0F
        adc     ($0F),y
        txa
        .byte   $0F
        ldy     $0F,x
        .byte   $C7
        .byte   $0F
        nop
        asl     a
        clv
        ora     L1CA0
        beq     L1385
        .byte   $FC
        asl     a
        cmp     ($1B,x)
        tsx
        .byte   $1C
        .byte   $13
        bpl     L1356
        .byte   $1B
L1385:  adc     L2110,y
        bpl     L13AB
        bpl     L1369
        asl     L10FE
        sec
        ora     ($A7),y
        ora     ($27),y
        bpl     L13C8
        bpl     L13B2
        ora     ($22),y
        ora     ($40),y
        bpl     L13D8
        .byte   $1C
        .byte   $54
        .byte   $1C
        .byte   $7C
        .byte   $1C
        ora     ($12,x)
        rts

        bpl     L13AD
        .byte   $0F
        and     $12,x
L13AB:  .byte   $2D
        .byte   $11
L13AD:  jmp     (L4111)

        .byte   $12
        .byte   $D9
L13B2:  .byte   $1C
        php
        bpl     L135C
        .byte   $1C
        ldy     #$0B
        stx     $1D,y
        .byte   $14
        .byte   $0B
        .byte   $02
        .byte   $0B
        adc     ($12),y
        adc     $8112,y
        .byte   $12
        sta     $6F0B,y
L13C8:  .byte   $1C
        .byte   $44
        .byte   $0F
        .byte   $74
        bpl     L13E8
        .byte   $0F
        .byte   $74
        bpl     L13E1
        .byte   $0F
        .byte   $74
        bpl     L1412
        .byte   $0F
        .byte   $82
L13D8:  .byte   $0E
L13D9:  .byte   $17
        .byte   $12
        tax
        lsr     a
        lsr     a
        lsr     a
        sta     $FB
L13E1:  lda     #$3B
        sec
        sbc     $FB
        tay
        txa
L13E8:  and     #$07
        tax
        lda     L13F0,x
        .byte   $39
        .byte   $7E
L13F0:  rol     $60,x
        ora     ($02,x)
        .byte   $04
        php
        bpl     L1418
L13F8:  rti

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
        .byte   $A9
L1412:  brk
        sta     $FD
L1415:  pha
        lda     #$00
L1418:  sta     $FC
        ldy     $FD
        lda     $377E,y
        cmp     #$FD
        bcc     L1428
        sty     $FB
        jsr     L1451
L1428:  pla
        clc
        adc     $FC
        bcc     L1433
        lda     #$FF
        jmp     L1437

L1433:  inc     $FD
        dec     $FE
L1437:  bne     L1415
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
L144C:  tya
        rts

        .byte   $AD
L144F:  bcs     L1453
L1451:  sta     $FB
L1453:  lda     $8C
        pha
        lda     $8B
        pha
        lda     #$00
        sta     $8C
        lda     #$0A
        sta     $02B0
        lda     $FB
        sta     $8B
        jsr     L147A
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
L147A:  .byte   $FB
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
        jsr     L1514
        and     #$7F
        clc
        adc     #$C0
        and     #$3F
        bcc     L14D2
        beq     L14D1
        dec     $02B0
        beq     L14CC
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
L14B8:  ldx     #$00
        lda     ($FB,x)
        cmp     $FD
        bne     L14C3
        jsr     L147A
L14C3:  jsr     L3333
        inc     $8B
        dec     $FE
        bne     L14B8
L14CC:  inc     $02B0
        lda     $8C
L14D1:  sec
L14D2:  tax
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
        bcc     L14F2
        lda     #$FF
        sta     $8C
L14F2:  plp
        rts

        cmp     #$FF
        bne     L14FB
        .byte   $AD
        .byte   $A4
L14FA:  .byte   $36
L14FB:  rts

        lda     $8C
        pha
        lda     $8B
        pha
        lda     $36B1
        sta     $8B
        jsr     L1514
        asl     a
        pla
        .byte   $85
L150D:  .byte   $8B
        pla
        sta     $8C
        lda     #$28
        .byte   $85
L1514:  .byte   $FB
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
L1528:  .byte   $3B
        ora     $85,x
        .byte   $8B
        lda     #$00
L152E:  sta     $8C
        lda     #$7E
        clc
        adc     $8B
        sta     $FB
        lda     $8C
        adc     #$37
        sta     $FC
        ldx     #$00
        .byte   $A1
L1540:  .byte   $FB
        rts

        lda     $FE
        sta     $02B3
        lda     $FD
        sta     $02B2
        lda     #$FD
        sta     $FE
        jsr     L1560
        php
        lda     $02B2
        sta     $FD
        lda     $02B3
        sta     $FE
        lda     #$1C
L1560:  plp
        rts

L1562:  lda     #$FE
        ldy     $36A4
L1567:  sty     $FD
        ldy     $36A0
        iny
        sec
        beq     L1597
        ldy     $FE
        sta     $FE
        tya
        pha
        jsr     L15AF
        bcs     L159D
        pla
        sta     $FE
        jsr     L15AF
        bcs     L159E
L1583:  lda     $FD
        sta     $FE
        jsr     L15AF
        bcs     L159E
        lda     #$FF
        sta     $FE
        jsr     L15AF
        lda     #$00
        bcs     L15A0
L1597:  php
        lda     #$FF
        jmp     L15D4

L159D:  pla
L159E:  lda     #$FF
L15A0:  php
        tya
        clc
        adc     #$7E
        sta     $8B
        lda     #$00
        adc     #$37
        sta     $8C
        tya
        .byte   $4C
L15AF:  .byte   $D4
        ora     $A9,x
        brk
        sta     $8B
L15B5:  jsr     L1661
        bcc     L15C0
        jsr     L15BF
        bne     L15B5
L15BF:  sec
L15C0:  rts

        cmp     $36A0
        bne     L15D4
        lda     $36A1
        cmp     #$FF
        beq     L15D4
        jsr     L3333
        ldx     #$00
        .byte   $C1
L15D3:  .byte   $FB
L15D4:  rts

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
        sta     $36B4
        sta     $36B5
        sta     $36B6
        sta     $36B7
        sta     $36B8
        sta     $36B9
        stx     $8B
        stx     $36B1
        cpx     #$FF
        beq     L1645
        cpx     $3883
        bcs     L1656
        stx     $8B
        jsr     L1514
        asl     a
        ror     $36B7
        asl     a
        ror     $36B6
        jsr     L152E
        sta     $36B4
        lda     $8B
        sta     $FB
        jsr     L1451
        lda     $FC
        sta     $36B5
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
        sta     $36B9
        iny
        lda     ($FB),y
        sta     $36B8
L1645:  pla
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

L1656:  pla
        pla
        pla
        pla
        pla
        plp
        ldx     #$00
        .byte   $4C
L165F:  eor     ($08,x)
L1661:  sta     $FE
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
L1678:  sta     $FC
        ldy     $8B
        cpy     $3883
        beq     L169F
        inc     $8B
        lda     $FE
        cmp     #$FF
        beq     L168E
        cmp     $377E,y
        bne     L1696
L168E:  lda     ($FB,x)
        cmp     #$FF
        beq     L1696
        sec
        rts

L1696:  jsr     L3333
        jsr     L3333
        jmp     L1678

L169F:  clc
        rts

        lda     $36B3
        and     #$7F
        sta     $36B3
        lda     $02A9
        and     #$EF
        sta     $02A9
        ldy     #$00
        sty     $02B3
        .byte   $8C
L16B7:  .byte   $B2
        .byte   $02
        sty     $02B0
        lda     $377E,y
        cmp     #$FF
        beq     L1709
        cmp     $8C
        bne     L1702
        lda     $02B3
        sty     $02B3
        ldx     $02B2
        stx     $02B1
        ldx     #$00
        stx     $02B2
        bit     $36B3
        bmi     L16FF
        lda     $36B3
        ora     #$80
        sta     $36B3
        lda     #$02
        bit     $02A7
        beq     L16F9
        lda     #$01
        jsr     L1B6A
        bit     $36B3
        bvs     L16F9
        jsr     L224F
L16F9:  inc     $02B2
        jmp     L1700

L16FF:  .byte   $20
L1700:  .byte   $3B
        .byte   $17
L1702:  ldy     $02B0
        iny
        jmp     L16B7

L1709:  lda     $02B3
        ldx     $02B2
        stx     $02B1
        bit     $36B3
        bpl     L1730
        bvc     L173D
        ldx     $02B1
        bne     L1728
        pha
        lda     #$2F
        jsr     L1B6A
        inc     $02B1
        pla
L1728:  jsr     L173B
        lda     #$30
        jmp     L1B6A

L1730:  lda     #$02
        bit     $02A7
        bne     L173C
        lda     #$35
        .byte   $20
        ror     a
L173B:  .byte   $1B
L173C:  rts

L173D:  bit     $36B3
        bvs     L1750
        jsr     L2953
        lda     $FB
        sta     $41
        lda     $FC
        sta     $42
        jmp     L1B70

L1750:  pha
        lda     $02B1
        bne     L175B
        lda     #$2E
        jsr     L1B6A
L175B:  pla
        .byte   $4C
L175D:  .byte   $7B
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
L177C:  ldx     #$00
        lda     ($FB,x)
        cmp     #$FF
        bne     L1786
        clc
        rts

L1786:  cmp     $369F
        bne     L1792
        jsr     L3333
        lda     ($FB,x)
        sec
        rts

L1792:  jsr     L3333
        jsr     L3333
        jmp     L177C

        lda     $02E5
        sta     $FB
        ora     $02E6
        beq     L17FE
        lda     $02E6
        sta     $FC
        ldx     #$01
        .byte   $4C
L17AD:  cmp     $A917,x
        .byte   $04
        bit     $02A7
        beq     L17C8
        lda     $02E3
        sta     $FB
        lda     $02E4
        sta     $FC
        ldx     #$00
        lda     ($FB,x)
        cmp     #$0D
        bne     L17E7
L17C8:  jsr     L1F74
        bcc     L17FE
        lda     $FB
        sta     $02E3
        lda     $FC
        sta     $02E4
        ldx     #$00
        stx     $02E5
        stx     $02E6
        lda     #$FF
        sta     $369F
        sta     $36A2
L17E7:  stx     $02A8
        lda     #$FF
        sta     $36A0
        sta     $36A1
        sta     $36A9
        sta     $36AA
        sta     $36AB
        .byte   $4C
L17FC:  ora     #$18
L17FE:  lda     $02A7
        and     #$FB
        sta     $02A7
        sec
        rts

L1808:  .byte   $20
L1809:  .byte   $33
        .byte   $33
        jsr     L1A51
        cmp     #$22
        beq     L17FE
        jsr     L1A63
        bcs     L1833
        cmp     #$0D
        bne     L1808
        lda     #$04
        bit     $02A7
        beq     L17FE
        lda     $02A7
        and     #$FB
        sta     $02A7
        .byte   $4C
L182B:  lda     $6817
        sta     $FB
        pla
L1831:  sta     $FC
L1833:  jsr     L19E1
        beq     L183B
        .byte   $4C
L1839:  .byte   $FA
        clc
L183B:  jsr     L1A5F
        bcs     L1833
        cmp     #$22
        bne     L1876
        lda     #$01
        bit     $02A8
        bne     L1876
        lda     $02E5
        ora     $02E6
        beq     L1856
L1853:  jmp     L17FC

L1856:  jsr     L3333
        lda     $FB
        sta     $02E5
        lda     $FC
        sta     $02E6
L1863:  lda     ($FB,x)
        cmp     #$0D
        beq     L1853
        jsr     L3333
        cmp     #$22
        bne     L1863
        jsr     L1A51
        .byte   $4C
L1874:  .byte   $39
        clc
L1876:  lda     $02A7
        ora     #$04
        sta     $02A7
        lda     #$01
        bit     $02A8
        bne     L1892
        lda     $FB
        sta     $02E3
        lda     $FC
        sta     $02E4
        jmp     L189A

L1892:  lda     $FB
        sta     $02E5
        lda     $FC
        .byte   $8D
L189A:  inc     $02
        ldx     #$00
        lda     ($FB,x)
        cmp     #$0D
        bne     L18AC
        lda     $02A7
        and     #$FB
        sta     $02A7
L18AC:  lda     #$02
        bit     $02A8
        bne     L18C3
        lda     $36A0
        cmp     #$FF
        beq     L1853
        cmp     #$28
        bcs     L18C1
        sta     $369F
L18C1:  clc
        rts

L18C3:  lda     #$20
        bit     $02A8
        bne     L18CF
        lda     #$FF
        sta     $36A2
L18CF:  lda     $36AA
        sta     $8B
        lda     $36AB
        sta     $8C
        jsr     L18E4
        lda     $36A0
        sta     $8B
        lda     $36A1
L18E4:  sta     $8C
        lda     $8B
        cmp     #$FF
        beq     L18FA
        cmp     #$32
        bcc     L18FA
        lda     $8B
        sta     $36AC
        lda     $8C
        sta     $36AD
L18FA:  clc
        rts

        tay
        ldx     #$00
        lda     ($FD,x)
        cmp     #$05
        bne     L1908
        jmp     L1874

L1908:  cmp     #$00
        bne     L1921
        lda     #$02
        bit     $02A8
        bne     L191E
        sty     $369F
        lda     $02A8
        ora     #$02
        sta     $02A8
L191E:  jmp     L1831

L1921:  cmp     #$01
        bne     L193A
        lda     #$20
        bit     $02A8
        bne     L191E
        sty     $36A2
        lda     $02A8
        ora     #$20
        sta     $02A8
        jmp     L1831

L193A:  cmp     #$04
        bne     L194B
        lda     $36A9
        cmp     #$FF
        bne     L191E
        sty     $36A9
        jmp     L1831

L194B:  tax
        lda     #$08
        bit     $02A8
        bne     L191E
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
        beq     L1970
        lda     #$AA
        sta     $FB
        lda     #$36
        sta     $FC
L1970:  txa
        ldx     #$00
        cmp     #$06
        beq     L19CD
        cmp     #$02
        bne     L19B7
        lda     #$04
        bit     $02A8
        beq     L19A7
        cpy     $36A0
        bne     L199F
        jsr     L3333
        lda     ($FB,x)
        jsr     L3355
        cmp     #$FF
        beq     L19AA
        cmp     $36A1
        beq     L19AA
        lda     $36A1
        cmp     #$FF
        beq     L19AA
L199F:  lda     $02A8
        ora     #$08
        sta     $02A8
L19A7:  tya
        sta     ($FB,x)
L19AA:  lda     $02A8
        ora     #$04
        and     #$7F
        sta     $02A8
L19B4:  jmp     L182B

L19B7:  bit     $02A8
        bmi     L19B4
        jsr     L3333
        tya
        sta     ($FB,x)
        lda     $02A8
        ora     #$80
        sta     $02A8
        jmp     L182B

L19CD:  lda     $36AC
        cmp     #$FF
        beq     L19B4
        tay
        jsr     L3333
        lda     $36AD
        sta     ($FB,x)
        jsr     L3355
        .byte   $4C
L19E1:  adc     $A219,y
        brk
        lda     #$DF
        ldy     #$04
L19E9:  sta     $02B8,y
        dey
        bpl     L19E9
        iny
L19F0:  jsr     L1A5F
        bcc     L1A0C
        eor     #$FF
        sta     $02B8,y
        jsr     L3333
        iny
        cpy     #$05
        bne     L19F0
        beq     L1A07
L1A04:  jsr     L3333
L1A07:  jsr     L1A5F
        bcs     L1A04
L1A0C:  jsr     L1A51
        lda     $3896
        sta     $FD
        lda     $3897
        sta     $FE
        lda     $02A7
        and     #$DF
        sta     $02A7
        ldy     #$00
L1A23:  lda     ($FD,x)
        bne     L1A28
        rts

L1A28:  cmp     $02B8,y
        beq     L1A35
        lda     $02A7
        ora     #$20
        sta     $02A7
L1A35:  jsr     L333A
        iny
        cpy     #$05
        bne     L1A23
        lda     #$20
        bit     $02A7
        bne     L1A4A
        lda     ($FD,x)
        jsr     L333A
        rts

L1A4A:  jsr     L333A
        jsr     L333A
        .byte   $4C
L1A51:  .byte   $17
        .byte   $1A
        ldx     #$00
        lda     ($FB,x)
        cmp     #$20
        bne     L1A73
        jsr     L3333
        .byte   $4C
L1A5F:  eor     ($1A),y
        ldx     #$00
L1A63:  lda     ($FB,x)
        jsr     L1A72
        bcc     L1A7B
        cmp     #$41
        bcc     L1A73
        cmp     #$5B
        bcc     L1A7B
L1A72:  clc
L1A73:  rts

        cmp     #$30
        bcc     L1A7B
        cmp     #$3A
        rts

L1A7B:  sec
        rts

        cmp     $3883
        bcs     L1ACE
        tay
        lda     $FC
        pha
        lda     $FB
        pha
        tya
        jsr     L2953
L1A8D:  jsr     L1AB6
        beq     L1A8D
        tay
        lda     #$10
        bit     $02A9
        bne     L1AA0
        tya
        and     #$DF
        jmp     L1AA8

L1AA0:  jsr     L1AB6
        bne     L1AA0
L1AA5:  jsr     L1AB6
L1AA8:  beq     L1AA5
L1AAA:  eor     #$FF
        jsr     L2251
        jsr     L1AB6
        cmp     #$D1
        bne     L1AAA
L1AB6:  beq     L1AC8
        ldx     #$00
        lda     ($FB,x)
        cmp     #$F5
        beq     L1AC6
        jsr     L3333
        cmp     #$DF
        rts

L1AC6:  pla
        pla
L1AC8:  pla
        sta     $FB
        pla
        .byte   $85
L1ACD:  .byte   $FC
L1ACE:  rts

        lda     $02B4
        clc
        adc     #$01
        sta     $02B0
        lda     #$65
        sta     $02B1
        lda     #$00
        sta     $02B4
        ldx     #$08
L1AE4:  lsr     $02B0
        bcc     L1AED
        clc
        adc     $02B1
L1AED:  ror     a
        ror     $02B4
        dex
        bne     L1AE4
        cmp     #$00
        .byte   $F0
L1AF7:  .byte   $D7
        rts

        lda     #$00
L1AFB:  sta     $8C
        lda     #$00
        sta     $02B2
        lda     #$10
        sta     $41
        lda     #$27
        sta     $42
        jsr     L1B30
        lda     #$E8
        sta     $41
        lda     #$03
        sta     $42
        jsr     L1B30
        lda     #$64
        sta     $41
        lda     #$00
        sta     $42
        jsr     L1B30
        lda     #$0A
        sta     $41
        jsr     L1B30
        lda     $8B
        clc
        adc     #$30
        .byte   $4C
L1B30:  eor     ($22),y
        ldx     #$00
L1B34:  inx
        lda     $8B
        sec
        sbc     $41
        sta     $8B
        lda     $8C
        sbc     $42
        sta     $8C
        bcs     L1B34
        dex
        lda     $8B
        clc
        adc     $41
        sta     $8B
        lda     $8C
        adc     $42
        sta     $8C
        txa
        bne     L1B5B
        ldx     $02B2
        bne     L1B5B
        rts

L1B5B:  ldx     #$01
        stx     $02B2
        clc
        adc     #$30
        jmp     L2251

        jsr     L2960
        .byte   $4C
L1B6A:  bvs     L1B87
        jsr     L2960
        .byte   $4C
L1B70:  sei
        .byte   $1B
        lda     $02A7
        ora     #$40
        .byte   $8D
L1B78:  .byte   $A7
        .byte   $02
L1B7A:  ldx     #$00
        lda     $02A9
        ora     #$20
        sta     $02A9
        lda     ($41,x)
        .byte   $49
L1B87:  .byte   $FF
        cmp     #$0A
        beq     L1BAE
        cmp     $3882
        bne     L1BA2
        lda     $02A9
        ora     #$10
        sta     $02A9
        lda     $36B1
        jsr     L1A7B
        jmp     L1BA3

L1BA2:  .byte   $20
L1BA3:  eor     ($22),y
        inc     $41
        bne     L1B7A
        inc     $42
        jmp     L1B78

L1BAE:  bit     $02A7
L1BB1:  bvc     L1BC3
        jsr     L224F
        jsr     L2931
        lda     $02A7
        and     #$BF
        sta     $02A7
        ldx     #$00
L1BC3:  rts

        and     #$07
        sta     $8B
        lda     $02D5
        and     #$F8
        ora     $8B
        sta     $02D5
        jmp     L0E4D

        cmp     $CBFD
        bcs     L1BE8
        sta     $02FF
        tay
        jsr     L2A43
        lda     ($FB,x)
        bmi     L1BE8
        jmp     L0AD3

L1BE8:  jmp     L0ABF

        tax
        lda     $02AA
        and     #$7F
        sta     $02AA
        txa
        beq     L1BFF
        lda     $02AA
        ora     #$80
        sta     $02AA
L1BFF:  lda     $FE
        pha
        lda     $FD
        pha
        jsr     L23AE
        jsr     L2931
        lda     $02D5
        pha
        lda     #$00
        sta     $02D5
        lda     $02D3
        pha
        lda     $02D2
        pha
        ldy     $02FF
        jsr     L2991
        jsr     L2931
        pla
        sta     $02D2
        pla
        sta     $02D3
        jsr     L28BF
        pla
        sta     $02D5
        pla
        sta     $FD
        pla
        sta     $FE
        jmp     L0E4D

        jsr     L23AE
        lda     $02D5
        and     #$5F
        sta     $02D5
        lda     $02D2
        sta     $02D6
        lda     $02D3
        sta     $02D7
        jmp     L0E50

        jsr     L23AE
        lda     $02D5
        and     #$5F
        sta     $02D5
        lda     $02D6
        sta     $8B
        lda     $02D7
        sta     $8C
        jsr     L2670
        jmp     L0E50

        pha
        jsr     L23AE
        lda     $02D3
        sta     $8C
        pla
        jmp     L1C8D

        pha
        jsr     L23AE
        pla
        clc
        adc     $02D0
        sta     $8C
        jsr     L333A
L1C8D:  lda     ($FD,x)
        clc
        adc     $02D1
        sta     $8B
        jsr     L2670
        lda     $02D5
        and     #$5F
        sta     $02D5
L1CA0:  jmp     L0E4D

        jsr     L26D1
        jmp     L0E4D

        jsr     L23AE
        jsr     L3348
        lda     $02CE
        lsr     a
        sta     $FC
        lda     #$14
        sec
        sbc     $FC
        jmp     L1CD4

        pha
        jsr     L23AE
        pla
        cmp     #$19
        bcc     L1CC8
        lda     #$00
L1CC8:  sta     $02D0
        jsr     L333A
        lda     ($FD,x)
        cmp     #$28
        bcc     L1CD6
L1CD4:  lda     #$00
L1CD6:  sta     $02D1
        jmp     L1CED

        pha
        jsr     L23AE
        pla
        sec
        sbc     #$01
        sta     $02CF
        jsr     L333A
        lda     ($FD,x)
        .byte   $8D
L1CED:  dec     L2002
        tay
        rol     $20
        .byte   $B3
        plp
        lda     $02CF
        sta     $02CC
        jmp     L0E4D

        pha
        jsr     L333A
        lda     ($FD,x)
        cmp     #$18
        bcs     L1D0A
        lda     #$18
L1D0A:  cmp     #$D6
        bcc     L1D10
        lda     #$D6
L1D10:  ldx     #$FF
L1D12:  inx
        sec
        sbc     #$18
        bcs     L1D12
        adc     #$18
        tay
        lda     L1D4F,y
        sta     $8D
        lda     #$01
        sta     $8E
        cpy     #$17
        bne     L1D31
        inc     $8E
        jmp     L1D2F

L1D2D:  asl     $8D
L1D2F:  rol     $8E
L1D31:  dex
        bne     L1D2D
        lda     $8D
        sta     $D400
        lda     $8E
        sta     $D401
        pla
        tay
        lda     #$21
        .byte   $8D
L1D43:  .byte   $04
        .byte   $D4
L1D45:  jsr     L2244
        dey
        bne     L1D45
        stx     $D404
        .byte   $4C
L1D4F:  eor     L0C0E
        .byte   $14
        .byte   $1C
        bit     $2D
        and     $3E,x
        .byte   $47
        eor     ($5B),y
        ror     $70
        .byte   $7B
        stx     $91
        sta     $B6A9,x
        .byte   $C3
        bne     L1D43
        .byte   $EB
        beq     L1D72
        jsr     L1F61
        ldx     #$F0
        jmp     L1D7A

        .byte   $20
L1D72:  adc     ($1F,x)
        asl     a
        asl     a
        asl     a
        asl     a
        and     #$F0
L1D7A:  ldx     #$0F
        stx     $8B
        sta     $8C
        lda     $02CA
        and     $8B
        ora     $8C
        sta     $02CA
        sta     $02DA
        jmp     L0E4D

        jsr     L1F61
        sta     $D020
        jmp     L0E4D

        jsr     LFFE4
        beq     L1DAA
        sta     $36BA
        lda     $02CF
        jsr     L264A
        jmp     L0AD6

L1DAA:  jmp     L0ABF

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
        jsr     L33F6
L1DCF:  jmp     L1E19

        ldy     $02C1
        bne     L1DDA
        jmp     L0ABF

L1DDA:  jsr     L333A
        sta     $02B6
        stx     $02B7
        inc     $02B6
        bne     L1DEB
        inc     $02B7
L1DEB:  lda     #$7E
        sta     $1D
        lda     #$36
        sta     $1E
        lda     #$00
        sta     $1B
        lda     #$DD
        sta     $1C
        jsr     L33F6
        jsr     L3362
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
L1E19:  sta     $1C
        jsr     L3362
        jsr     L3408
        jmp     L0E50

        tay
        lda     L02BF
        sta     $02AE
        lda     $02C0
        sta     $02AF
        lda     #$7C
        sta     L02BF
        lda     #$1E
        sta     $02C0
        lda     $FE
        pha
        lda     $FD
        pha
        tya
        pha
        jsr     L330B
        pla
        jsr     L3275
        lda     $02B0
        beq     L1EA2
        tax
        ldy     #$01
        jsr     LFFBA
        ldx     #$DC
        ldy     #$34
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
        jsr     L31C7
        ldy     $02B0
        cpy     #$01
        bne     L1E93
        plp
L1E7C:  bcs     L1EA2
        pla
        sta     $FD
        pla
        sta     $FE
        lda     $02AE
        sta     L02BF
        lda     $02AF
        sta     $02C0
        jmp     L0E4D

L1E93:  plp
        bcs     L1EA2
        jsr     L3209
        ldx     #$64
        cmp     #$00
        bne     L1EA9
        jmp     L1E7C

L1EA2:  ldx     #$65
        cmp     #$00
        beq     L1EA9
        dex
L1EA9:  jmp     L0849

        tay
        lda     $FE
        pha
        lda     $FD
        pha
        lda     #$00
        sta     $387F
        sta     $387E
        tya
        jsr     L3275
        lda     $02B0
        beq     L1EF3
        ldy     #$00
        tax
        jsr     LFFBA
        ldx     #$DC
        ldy     #$34
        lda     $02B1
        jsr     LFFBD
        lda     #$00
        ldx     #$7E
        ldy     #$36
        jsr     LFFD5
        php
        jsr     L31C7
        stx     $3F
        sty     $40
        ldy     $02B0
        cpy     #$01
        bne     L1F02
        plp
        bcc     L1EF8
        cmp     #$00
        bne     L1F2E
L1EF3:  ldx     #$65
        jmp     L0849

L1EF8:  jsr     LFFB7
        cmp     #$00
        bne     L1F2E
        jmp     L1F31

L1F02:  plp
        bcc     L1F12
        cmp     #$04
        beq     L1F12
        cmp     #$00
        bne     L1F2E
        ldx     #$65
        jmp     L0849

L1F12:  jsr     LFFB7
        pha
        lda     $40
        pha
        lda     $3F
        pha
        jsr     L3209
        cmp     #$00
        bne     L1F2E
        pla
        sta     $3F
        pla
        sta     $40
        pla
        cmp     #$40
        beq     L1F33
L1F2E:  ldx     #$64
        .byte   $4C
L1F31:  eor     #$08
L1F33:  lda     #$80
        ldy     #$38
        cmp     $3F
        bne     L1F2E
        cpy     $40
        bne     L1F2E
        lda     $387E
        sta     $3F
        lda     $387F
        sta     $40
        jsr     L330B
        lda     $387E
        cmp     $3F
        bne     L1F2E
        lda     $387F
        cmp     $40
        bne     L1F2E
        pla
        sta     $FD
        pla
        sta     $FE
        .byte   $4C
L1F61:  eor     L290E
        .byte   $0F
        tay
        lda     $CBF9
        sta     $FB
        lda     $CBFA
        sta     $FC
        jsr     L3333
        .byte   $B1
L1F74:  .byte   $FB
        rts

        lda     $02A8
        and     #$EF
        sta     $02A8
        lda     $36A8
        beq     L1F88
        cmp     $3886
        bcc     L1FB7
L1F88:  jsr     L1ACD
        ldy     #$02
        cmp     #$1E
        bcc     L1F9C
        iny
        cmp     #$3C
        bcc     L1F9C
        iny
        cmp     #$5A
        bcc     L1F9C
        iny
L1F9C:  tya
        .byte   $4C
L1F9E:  lda     $1F,x
        pha
        lda     $02A7
        and     #$FB
        sta     $02A7
        lda     $02A8
        ora     #$10
        sta     $02A8
        lda     #$0C
        sta     $02C8
        pla
L1FB7:  pha
        lda     $02C9
        sta     $02C3
        lda     $36A7
        and     #$07
        beq     L1FC8
        jsr     L26D1
L1FC8:  pla
        jsr     L1B6A
        jsr     L23AE
        lda     $02D5
        and     #$BF
        sta     $02D5
        lda     #$80
        sta     $02CC
        lda     #$21
        jsr     L1B6A
        jsr     L21FC
        jsr     L25F4
        lda     $02D2
        sta     $02C7
        lda     #$10
        bit     $02A8
        bne     L200B
        lda     $36AF
        asl     a
        bcc     L200B
        asl     a
        bcc     L200B
        asl     a
        bcc     L200B
        ldy     #$00
L2002:  jsr     L219A
        jsr     L21C1
        jmp     L2020

L200B:  lda     #$00
        sta     $02C6
        sta     $02C5
        lda     #$0D
        sta     L34DC
        .byte   $4C
L2019:  jsr     $A920
        ora     ($2C,x)
        .byte   $AF
        .byte   $36
L2020:  bne     L2045
        lda     #$10
        bit     $02A8
        bne     L2045
        lda     $36AE
        beq     L2045
        jsr     L262F
        bcs     L2048
        ldy     $02C5
        jsr     L219A
        jsr     L21DD
        lda     $36AF
        ora     #$C0
        clc
        jmp     L20CC

L2045:  jsr     L2627
L2048:  cmp     #$14
        bne     L204F
        jmp     L2164

L204F:  cmp     #$9D
        bne     L2056
        jmp     L2141

L2056:  cmp     #$1D
        bne     L205D
        jmp     L2151

L205D:  cmp     #$0D
        .byte   $D0
L2060:  .byte   $0B
        lda     $02C6
        beq     L2069
        jmp     L20B5

L2069:  jmp     L2019

L206C:  ldy     $02C6
        cpy     $02C8
        beq     L2069
        cmp     #$20
        bcc     L2069
        cmp     #$41
        bcc     L2090
        cmp     #$5B
        bcs     L2086
        clc
        adc     #$20
        jmp     L208E

L2086:  cmp     #$C1
        bcc     L2069
        cmp     #$DB
        bcs     L2069
L208E:  sbc     #$7F
L2090:  pha
        lda     $02C6
        tax
        tay
        iny
L2097:  lda     L34DC,x
        sta     L34DC,y
        dex
        dey
        cpy     $02C5
        bne     L2097
        pla
        sta     L34DC,y
        inc     $02C5
        inc     $02C6
        jsr     L219A
        jsr     L21C1
        .byte   $4C
L20B5:  ora     $AC20,y
        cmp     $02
        jsr     L219A
        jsr     L21DD
        jsr     L224F
        lda     #$78
        sta     $02C8
        lda     $36AF
        .byte   $29
L20CC:  .byte   $3F
        sec
        sta     $36AF
        php
        jsr     L25FF
        lda     #$08
        bit     $36AF
        beq     L20DF
        jsr     L2743
L20DF:  lda     $02D5
        ora     #$40
        sta     $02D5
        lda     $02C3
        jsr     L26D1
        plp
        php
        bcc     L2139
        lda     #$10
        bit     $36AF
        beq     L20FD
        lda     #$21
        jsr     L1B6A
L20FD:  .byte   $A9
L20FE:  .byte   $DC
        sta     $FB
        lda     #$34
L2103:  sta     $FC
        ldx     #$00
        lda     ($FB,x)
        cmp     #$0D
        beq     L212F
        pha
        lda     #$10
L2110:  bit     $36AF
        beq     L211A
        pla
        pha
        jsr     L2251
L211A:  pla
        cmp     #$61
        bcc     L2129
        cmp     #$7B
        bcs     L2129
        and     #$DF
        ldx     #$00
        sta     ($FB,x)
L2129:  jsr     L3333
        jmp     L2103

L212F:  lda     #$10
        bit     $36AF
        beq     L2139
        jsr     L224F
L2139:  lda     #$DC
        sta     $FB
        lda     #$34
        sta     $FC
L2141:  plp
        rts

        ldy     $02C5
        beq     L2150
        dec     $02C5
        lda     #$08
        jsr     L24B5
L2150:  .byte   $4C
L2151:  ora     $AC20,y
        cmp     $02
        lda     L34DC,y
        cmp     #$0D
        beq     L2150
        inc     $02C5
        jsr     L24B5
        .byte   $4C
L2164:  ora     $AD20,y
        cmp     $02
        beq     L2150
        tay
        dey
        tax
L216E:  lda     L34DC,x
        sta     L34DC,y
        inx
        iny
        cpy     $02C6
        bne     L216E
        lda     #$08
        jsr     L24B5
        dec     $02C6
        dec     $02C5
        ldy     $02C5
        jsr     L219A
        lda     #$20
        jsr     L24B5
        lda     #$08
        jsr     L24B5
        jsr     L21C1
        .byte   $4C
L219A:  ora     $9820,y
        pha
        jsr     L25FF
        pla
        tay
        tya
        pha
        lda     L34DC,y
        cmp     #$0D
        bne     L21BA
        lda     #$20
        jsr     L24B5
        lda     #$08
        jsr     L24B5
        pla
        jmp     L25F4

L21BA:  jsr     L24B5
        pla
        tay
        iny
        .byte   $4C
L21C1:  lda     ($21,x)
        jsr     L25FF
        lda     $02C6
        sec
        sbc     $02C5
        beq     L21DC
        tay
L21D0:  tya
        pha
        lda     #$08
        jsr     L24B5
        pla
        tay
        dey
        bne     L21D0
L21DC:  .byte   $4C
L21DD:  .byte   $F4
        and     $AD
        dec     $02
        clc
        adc     $02C7
        sec
        sbc     $02D1
        ldx     $02CF
L21ED:  sec
        sbc     $02CE
        bcc     L21FA
        dex
        bne     L21ED
        ldx     $02CF
        inx
L21FA:  txa
        .byte   $4C
L21FC:  lsr     a
        rol     $AD
        dec     $8502
        .byte   $8B
        lda     #$00
        sta     $8C
        sta     $FB
        sta     $FC
        ldx     $02CF
L220E:  clc
        lda     $8B
        adc     $FB
        sta     $FB
        lda     $8C
        adc     $FC
        sta     $FC
        dex
        bpl     L220E
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
        bne     L2245
        lda     $FB
        cmp     $02C8
        bcs     L2245
        .byte   $8D
        iny
L2244:  .byte   $02
L2245:  rts

        lda     #$01
        sta     $02E2
        lda     $02E2
        .byte   $D0
L224F:  .byte   $FB
        rts

L2251:  lda     #$0D
        cmp     #$80
        bcc     L2296
        tay
        lda     #$04
        bit     $02A9
        beq     L2296
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
L2276:  lda     ($FB),y
        php
        jsr     L3333
        plp
        bpl     L2276
        dex
        bne     L2276
        ldy     #$00
        lda     ($FB),y
        php
        and     #$7F
        plp
        bmi     L229E
        jsr     L2294
        jsr     L3333
        .byte   $4C
        .byte   $80
L2294:  .byte   $22
        tya
L2296:  tay
        lda     $FC
        pha
        lda     $FB
        pha
        tya
L229E:  tay
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
        beq     L231C
        cmp     #$10
        bcc     L22CB
        lda     #$01
        bit     $02D5
        beq     L22BF
        tya
        ora     #$80
        tay
L22BF:  tya
        bit     $02D5
        bvs     L22CE
        jsr     L2376
        jmp     L2307

L22CB:  jmp     L233C

L22CE:  cmp     #$20
        beq     L22F7
        cmp     #$A0
        beq     L22F7
        pha
        lda     $02C4
        cmp     #$28
        bne     L22E1
        jsr     L23AE
L22E1:  lda     $02D5
        and     #$7F
        sta     $02D5
        pla
        ldy     $02C4
        sta     L3554,y
        iny
        sty     $02C4
        jmp     L2307

L22F7:  bit     $02D5
        bmi     L2309
        pha
        jsr     L23AE
        pla
        bit     $02D5
        bmi     L2309
        .byte   $20
L2307:  ror     $23,x
L2309:  pla
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

L231C:  jsr     L23AE
        lda     #$20
        bit     $02D5
        php
        lda     $02D5
        and     #$DF
        sta     $02D5
        plp
        beq     L2338
        lda     #$0D
        jsr     L24B5
        jmp     L2307

L2338:  jsr     L2418
        .byte   $4C
L233C:  .byte   $07
        .byte   $23
        cmp     #$0F
        bne     L234D
        lda     $02D5
        and     #$FE
        sta     $02D5
        jmp     L2307

L234D:  cmp     #$0E
        bne     L235C
        lda     $02D5
        ora     #$01
        sta     $02D5
        jmp     L2307

L235C:  pha
        jsr     L23AE
        pla
        cmp     #$0B
        bne     L236B
        jsr     L2743
        jmp     L2307

L236B:  cmp     #$0C
        bne     L2375
        ldx     $02CF
        jsr     L2617
L2375:  .byte   $4C
L2376:  .byte   $07
        .byte   $23
        pha
        jsr     L24B5
        lda     $02D5
        and     #$DF
        sta     $02D5
        lda     $02D1
        clc
        adc     $02CE
        cmp     $02D2
        beq     L2392
        pla
        rts

L2392:  pla
        cmp     #$20
        bne     L23A4
        bit     $02D5
        bvc     L23A4
        lda     $02D5
        ora     #$80
        sta     $02D5
L23A4:  jmp     L241D

        lda     $02D5
        ora     #$20
        .byte   $8D
        .byte   $D5
L23AE:  .byte   $02
        rts

        pha
        bit     $02D5
        bvc     L23BB
        lda     $02C4
        bne     L23BD
L23BB:  pla
        rts

L23BD:  lda     $02D1
        clc
        adc     $02CE
        sec
        sbc     $02D2
        cmp     $02C4
        beq     L23ED
        bcs     L23F5
        lda     $02D1
        clc
        adc     $02CE
        cmp     $02D2
        beq     L23F5
        lda     $FC
        pha
        lda     $FB
        pha
        jsr     L2418
        pla
        sta     $FB
        pla
        sta     $FC
        jmp     L23F3

L23ED:  lda     $02D5
        ora     #$80
        .byte   $8D
L23F3:  cmp     $02,x
L23F5:  ldy     #$00
L23F7:  tya
        pha
        lda     L3554,y
        jsr     L2376
        pla
        tay
        iny
        cpy     $02C4
        bne     L23F7
        .byte   $4C
L2408:  ora     ($24),y
        pha
        lda     $02D5
        and     #$7F
        .byte   $8D
L2411:  cmp     $02,x
        lda     #$00
        sta     $02C4
L2418:  pla
        rts

        lda     #$0D
        .byte   $20
L241D:  lda     $24,x
        dec     $02CC
        beq     L2425
L2424:  rts

L2425:  lda     $02CF
        sta     $02CC
        lda     $02F0
        bne     L2424
        lda     #$02
        bit     $02D5
        bne     L2424
        jsr     L264D
        lda     $42
        pha
        lda     $41
        pha
        lda     #$20
        jsr     L2960
        lda     $02DC
        pha
        and     #$3F
        sta     $02DC
        lda     $02DA
        pha
        lda     $02DB
        pha
        lda     $02D5
        pha
        lda     #$00
        sta     $02D5
        dec     $02F0
        .byte   $20
L2463:  and     ($29),y
        ldy     #$00
        lda     ($41),y
        eor     #$FF
        cmp     #$0A
        beq     L247B
        jsr     L2251
        inc     $41
        bne     L2478
        inc     $42
L2478:  jmp     L2463

L247B:  inc     $02F0
        pla
        sta     $02D5
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
        bit     $36AF
        jsr     L2620
        lda     $02D2
        cmp     $02D1
        bne     L24A5
        rts

L24A5:  lda     #$08
        jsr     L24B5
        lda     #$20
        jsr     L24B5
        lda     #$08
        jsr     L24B5
        .byte   $4C
L24B5:  txs
        bit     $48
        jsr     L24CF
        pla
        cmp     #$08
        bne     L24C5
        jsr     L24E6
        beq     L24D1
L24C5:  cmp     #$0D
        bne     L24CE
        jsr     L2520
        beq     L24D1
L24CE:  .byte   $20
L24CF:  .byte   $5C
        .byte   $25
L24D1:  lda     $02CD
        beq     L251F
        lda     $02DC
        pha
        lda     #$80
        sta     $02DC
        lda     #$5F
        jsr     L255C
        pla
        .byte   $8D
L24E6:  .byte   $DC
        .byte   $02
        lda     $02D2
        cmp     $02D1
        beq     L2503
        dec     $02D2
        sec
        lda     $35
        sbc     #$08
        sta     $35
        lda     $36
        sbc     #$00
        sta     $36
        jmp     L251D

L2503:  ldx     $02D3
        cpx     $02D0
        beq     L251F
        dex
        stx     $02D3
        lda     $02D1
        clc
        adc     $02CE
        sec
        sbc     #$01
        sta     $02D2
        .byte   $20
L251D:  .byte   $BF
        plp
L251F:  .byte   $A9
L2520:  brk
        rts

        lda     $02D1
        clc
        adc     $02CE
        cmp     $02D2
        beq     L2536
        lda     #$20
        jsr     L255C
        jmp     L2520

L2536:  lda     $02D0
        clc
        adc     $02CF
        cmp     $02D3
        beq     L2547
        inc     $02D3
        bne     L2552
L2547:  lda     $02D3
        pha
        jsr     L2753
        pla
        sta     $02D3
L2552:  lda     $02D1
        sta     $02D2
        jsr     L28BF
        .byte   $A9
L255C:  brk
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
        bne     L2597
        lda     $8E
        pha
        lda     $8D
        pha
        jsr     L2520
        pla
        sta     $8D
        pla
        sta     $8E
L2597:  jsr     L33F6
        jsr     L25AF
        jsr     L3408
        inc     $02D2
        clc
        lda     #$08
        adc     $35
        sta     $35
        lda     #$00
        adc     $36
        .byte   $85
L25AF:  rol     $60,x
        ldx     #$00
        ldy     #$00
        bit     $02DC
        bpl     L25BB
        dex
L25BB:  bvc     L25BE
        dey
L25BE:  stx     $40
        sty     $3F
        ldy     #$07
L25C4:  lda     ($35),y
        and     $40
        eor     ($8D),y
        eor     $3F
        sta     ($35),y
        dey
        bpl     L25C4
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
        ora     #$CC
        sta     $8E
        ldy     #$00
        lda     ($8D),y
        eor     $02DA
        and     $02DB
        eor     $02DA
        .byte   $91
L25F4:  sta     $AD60
        cmp     $D002
        asl     $CDCE
        .byte   $02
        .byte   $4C
L25FF:  .byte   $D4
        bit     $20
        .byte   $CF
        bit     $A9
        brk
        .byte   $8D
        .byte   $CD
L2608:  .byte   $02
        rts

        jsr     L23AE
        lda     #$10
        jsr     L1B6A
        jsr     L23AE
        .byte   $AE
        .byte   $CF
L2617:  .byte   $02
        inx
        txa
        jsr     L264A
        lda     #$04
        .byte   $2C
L2620:  .byte   $AF
        rol     $F0,x
        ora     $AD
        .byte   $AE
        .byte   $36
L2627:  bne     L2631
        jsr     LFFE4
        cmp     #$00
        .byte   $F0
L262F:  .byte   $F9
        rts

L2631:  lda     #$00
        sta     $02E0
        sta     $02E1
L2639:  jsr     LFFE4
        cmp     #$00
        bne     L264A
        lda     $02E1
        cmp     $36AE
        bcc     L2639
        clc
        rts

L264A:  sec
        rts

        .byte   $8D
L264D:  cpy     $A902
        rol     a
        sta     $1D
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
L2670:  inx
        rts

        ldx     $8C
        ldy     $8B
        txa
        cmp     $02D0
        bcc     L269B
        lda     $02D0
        clc
        adc     $02CF
        cmp     $8C
        bcc     L269B
        tya
        cmp     $02D1
        bcc     L269B
        lda     $02D1
        clc
        adc     $02CE
        sec
        sbc     #$01
        cmp     $8B
        bcs     L26A1
L269B:  ldy     $02D1
        ldx     $02D0
L26A1:  sty     $02D2
        stx     $02D3
        .byte   $4C
L26A8:  .byte   $BF
        plp
        lda     $02D0
        clc
        adc     $02CF
        cmp     #$19
        bcc     L26BE
        lda     #$18
        sec
        sbc     $02D0
        sta     $02CF
L26BE:  lda     $02D1
        clc
        adc     $02CE
        cmp     #$29
        bcc     L26D2
        lda     #$28
        sec
        sbc     $02D1
        .byte   $8D
        .byte   $CE
L26D1:  .byte   $02
L26D2:  rts

        cmp     $02C9
        beq     L26D2
        pha
        jsr     L23AE
        lda     $02C9
        jsr     L271A
        lda     #$CA
        sta     $1B
        lda     #$02
        sta     $1C
        lda     #$0D
        sta     $02B6
        lda     #$00
        sta     $02B7
        .byte   $20
        .byte   $62
L26F6:  .byte   $33
        pla
        pha
        sta     $02C9
        jsr     L271A
        lda     #$CA
        sta     $1D
        lda     #$02
        sta     $1E
        lda     #$0D
        sta     $02B6
        lda     #$00
        sta     $02B7
        jsr     L3362
        jsr     L28BF
        jsr     L2931
L271A:  pla
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
        adc     #$2A
        sta     $1D
        sta     $1B
        lda     $1E
        adc     #$34
        sta     $1E
        sta     $1C
        rts

        lda     #$40
        bit     $369B
L2743:  bne     L2754
        jsr     L2408
        jsr     L28B3
        lda     $02CF
        sta     $02CC
        .byte   $20
        .byte   $12
L2753:  plp
L2754:  rts

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
        jsr     L28B3
        lda     $35
        sta     $1B
        lda     $36
        sta     $1C
        lda     $FE
        beq     L27A7
        jsr     L33F6
L277C:  lda     $35
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
        jsr     L3362
        pla
        sta     $1C
        dec     $FE
        bne     L277C
        jsr     L3408
L27A7:  jsr     L288F
        lda     $02CF
        sta     $FE
        lda     $02CE
        sta     $02B6
        lda     #$00
        sta     $02B7
        lda     $02D0
        jsr     L3387
        clc
        adc     $02D1
        sta     $1D
        tya
        adc     #$CC
        sta     $1E
        lda     $1D
        sta     $1B
        lda     $1E
        sta     $1C
        lda     $FE
        beq     L2809
L27D7:  lda     #$28
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
        jsr     L3362
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
        bne     L27D7
L2809:  ldy     $02CE
        dey
        lda     #$01
        sta     $FE
        .byte   $4C
L2812:  ror     $28,x
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
        jsr     L28B3
        lda     $35
        sta     $1B
        lda     $36
        sta     $1C
L283C:  pha
        jsr     L288F
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
        bne     L283C
        lda     $02CE
        sta     $FD
        ldx     $02CF
        inx
        stx     $FE
        lda     $02D1
        sta     $FB
        lda     $02D0
        jsr     L3387
        clc
        adc     $FB
        sta     $1B
        tya
        adc     #$CC
        sta     $1C
        dec     $FD
        ldy     $FD
L2878:  lda     $02CA
        sta     ($1B),y
        dey
        bpl     L2878
        lda     #$28
        adc     $1B
        sta     $1B
        lda     #$00
        adc     $1C
        sta     $1C
        dec     $FE
        .byte   $D0
L288F:  inc     $60
        jsr     L33F6
        ldy     #$00
        tya
        ldx     $02B7
        beq     L28A6
L289C:  sta     ($1B),y
        iny
        bne     L289C
        inc     $1C
        dex
        bne     L289C
L28A6:  ldx     $02B6
        beq     L28B1
L28AB:  sta     ($1B),y
        iny
        dex
        bne     L28AB
L28B1:  .byte   $20
        php
L28B3:  .byte   $34
        rts

        lda     $02D0
        sta     $02D3
        lda     $02D1
        .byte   $8D
L28BF:  .byte   $D2
        .byte   $02
        lda     $02D3
        jsr     L3387
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
        bcc     L28DF
        inc     $36
        clc
L28DF:  adc     $35
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
L28F4:  rol     $60,x
        lda     $CBF9
        sta     $3F
        lda     $CBFA
        sta     $40
        ldy     #$00
        lda     ($3F),y
        sta     $D020
        iny
        lda     ($3F),y
        sta     $8D
        iny
        .byte   $B1
L290E:  .byte   $3F
        asl     a
        asl     a
        asl     a
        asl     a
        ora     $8D
        sta     $02DA
        lda     #$00
        sta     $02DB
        lda     $02DB
        sta     $02CB
        lda     $02DA
        sta     $02CA
        lda     $02DC
        sta     $02D4
        rts

        .byte   $20
L2931:  ldx     $AD23
        .byte   $CB
        .byte   $02
        sta     $02DB
        lda     $02CA
        sta     $02DA
        lda     $02D4
        .byte   $8D
        .byte   $DC
L2944:  .byte   $02
        rts

        ldy     $388A
        sty     $8D
        ldy     $388B
        sty     $8E
        jmp     L2976

L2953:  lda     $FB
        ldy     $388C
        sty     $8D
        ldy     $388D
        sty     $8E
        .byte   $4C
L2960:  ror     $29,x
        ldy     $3892
        sty     $8D
        ldy     $3893
        sty     $8E
        jsr     L2976
        lda     $FB
        sta     $41
        lda     $FC
        .byte   $85
L2976:  .byte   $42
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
        sta     $FB
        iny
        lda     ($8D),y
        .byte   $85
L2991:  .byte   $FC
        rts

        lda     $369B
        and     #$20
        bne     L29D4
        jsr     L2A43
        lda     ($FB,x)
        bmi     L29D8
        jsr     L29EE
        lda     #$08
        bit     $369B
        beq     L29B3
        lda     $02DA
        and     #$0F
        sta     $D020
L29B3:  lda     $02AA
        bmi     L29BB
        jsr     L29D6
L29BB:  lda     #$10
        bit     $369B
        beq     L29CE
        lda     #$00
        sta     $C6
L29C6:  lda     $C6
        beq     L29C6
        lda     #$00
        sta     $C6
L29CE:  lda     $02C2
        sta     $D020
L29D4:  .byte   $20
        .byte   $31
L29D6:  and     #$60
L29D8:  jsr     L2D95
        lda     #$00
        sta     $02F6
        sta     $02FB
        sta     $02F9
        jsr     L33F6
        jsr     L2A83
        .byte   $20
        php
L29EE:  .byte   $34
        rts

        tya
        pha
        lda     $02CA
        pha
        lda     $02CB
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
        jsr     L26A8
        jsr     L2931
        jsr     L2743
        lda     $D020
        sta     $02C2
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
L2A43:  tay
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
        bcc     L2A5E
        inc     $FC
L2A5E:  plp
        bcc     L2A63
        inc     $FC
L2A63:  clc
        lda     $CBF3
        adc     $FB
        sta     $FB
        lda     $CBF4
        adc     $FC
        .byte   $85
L2A71:  .byte   $FC
        rts

        lda     #$03
L2A75:  bne     L2A79
L2A77:  lda     #$01
L2A79:  sta     $02F7
        clc
        adc     $19
        sta     $19
        bcc     L2A85
L2A83:  inc     $1A
L2A85:  ldy     #$00
        lda     ($19),y
        and     #$07
        asl     a
        tax
        lda     L2A95,x
        pha
        lda     L2A94,x
L2A94:  pha
L2A95:  rts

        .byte   $A3
        rol     a
        dec     $2A
        rti

        .byte   $2B
        sbc     ($2A),y
        adc     ($2B,x)
        dey
        .byte   $2B
        bcs     L2ACF
        eor     $2C,x
        lda     ($19),y
        asl     a
        bcs     L2ABE
        sta     $FB
        lda     $02DA
        eor     $FB
        and     #$0F
        eor     $FB
        sta     $02DA
        lda     #$0F
        jmp     L2ADE

L2ABE:  lda     $02DB
        ora     #$F0
        sta     $02DB
        jmp     L2A75

        lda     ($19),y
        bmi     L2AE9
        lsr     a
        lsr     a
L2ACF:  lsr     a
        sta     $FB
        lda     $02DA
        eor     $FB
        and     #$F0
        eor     $FB
        sta     $02DA
L2ADE:  lda     #$F0
        and     $02DB
        sta     $02DB
        jmp     L2A75

L2AE9:  lda     $02DB
        ora     #$0F
        sta     $02DB
        jmp     L2A75

        lda     $02FA
        cmp     #$0A
        bne     L2B08
        lda     #$00
        sta     $02F6
        sta     $02FB
        ldx     #$03
        jmp     L0849

L2B08:  cmp     #$00
        bne     L2B16
        lda     $19
        sta     $02F8
        lda     $1A
        sta     $02F9
L2B16:  inc     $02FA
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
        jsr     L2D96
        jmp     L2A83

        lda     $02FA
        beq     L2B63
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
        jmp     L2A77

L2B63:  rts

        lda     ($19),y
        sta     $02DC
        jsr     L2DBA
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
        beq     L2B88
        jsr     L30C5
L2B88:  jmp     L2A71

        lda     ($19),y
        and     #$C0
        cmp     #$C0
        beq     L2BAD
        sta     $02DC
        jsr     L2D27
        iny
        ldx     #$01
        bit     $02FC
        bpl     L2BA3
        ldx     #$FF
L2BA3:  bvc     L2BA7
        ldy     #$FF
L2BA7:  jsr     L3003
        jmp     L2A71

L2BAD:  jsr     L2CE1
        jmp     L2A71

        lda     $23
        pha
        lda     $22
        pha
        lda     $25
        pha
        lda     $24
        pha
        jsr     L2CE1
        lda     ($19),y
        bmi     L2BE4
        lda     #$DA
        sta     $FB
        sta     $8B
        lda     #$2B
        sta     $FC
        sta     $8C
        lda     #$00
        jsr     L2DDE
        ldy     #$03
        jmp     L2C01

        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
L2BE4:  ldy     #$03
        lda     ($19),y
        ldy     #$00
        jsr     L2C11
        lda     $FB
        sta     $8B
        lda     $FC
        sta     $8C
        lda     ($19),y
        and     #$40
        beq     L2BFD
        ldy     #$FF
L2BFD:  tya
        jsr     L2DDE
L2C01:  ldy     #$04
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
L2C11:  .byte   $77
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

L2C2B:  asl     a
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
        jsr     L28BF
        ldy     #$00
        pla
        jsr     L2C11
        sta     $8E
        lda     $FB
        sta     $8D
        jsr     L25AF
        lda     #$04
        jmp     L2A77

        lda     ($19),y
        bpl     L2C2B
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
        lda     #$CC
        adc     $FC
        sta     $FC
        iny
        lda     ($19),y
        tax
        iny
L2CAE:  lda     ($19),y
L2CB0:  pha
        tay
        lda     ($FB),y
        eor     $02DA
        and     $02DB
        eor     $02DA
        sta     ($FB),y
        cpy     #$00
        beq     L2CC7
        dey
        jmp     L2CB0

L2CC7:  cpx     #$00
        beq     L2CDD
        dex
        clc
        lda     #$28
        adc     $FB
        sta     $FB
        lda     #$00
        adc     $FC
        sta     $FC
        pla
        jmp     L2CAE

L2CDD:  pla
        lda     #$05
        .byte   $4C
L2CE1:  .byte   $77
        rol     a
        jsr     L2D27
        bit     $02FC
        bpl     L2CFB
        sec
        lda     $22
        sbc     $8B
        sta     $22
        lda     $23
        sbc     $8C
        sta     $23
        jmp     L2D06

L2CFB:  clc
        lda     $8B
        adc     $22
        sta     $22
        lda     $8C
        adc     $23
L2D06:  sta     $23
        bit     $02FC
        bvc     L2D1B
        sec
        lda     $24
        sbc     $FB
        sta     $24
        lda     $25
        sbc     $FC
        sta     $25
        rts

L2D1B:  clc
        lda     $FB
        adc     $24
        sta     $24
        lda     $FC
        adc     $25
        .byte   $85
L2D27:  and     $60
        jsr     L2DBA
        lda     $02F6
        beq     L2D7D
        lda     #$00
        sta     $8D
        lda     #$00
        sta     $8E
        ldy     $02F6
L2D3C:  clc
        lda     $8B
        adc     $8D
        sta     $8D
        lda     $8C
        adc     $8E
        sta     $8E
        dey
        bne     L2D3C
        jsr     L2D88
        lda     $8D
        sta     $8B
        lda     $8E
        sta     $8C
        lda     #$00
        sta     $8D
        lda     #$00
        sta     $8E
        ldy     $02F6
L2D62:  clc
        lda     $FB
        adc     $8D
        sta     $8D
        lda     $FC
        adc     $8E
        sta     $8E
        dey
        bne     L2D62
        jsr     L2D88
        lda     $8D
        sta     $FB
        lda     $8E
        sta     $FC
L2D7D:  ldy     #$00
        lda     ($19),y
        asl     a
        asl     a
        eor     $02FB
        .byte   $8D
        .byte   $FC
L2D88:  .byte   $02
        rts

        lsr     $8E
        ror     $8D
        lsr     $8E
        ror     $8D
        lsr     $8E
        .byte   $66
L2D95:  .byte   $8D
L2D96:  rts

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
L2DBA:  tay
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
        jsr     L33F6
        pla
        jsr     L2DDE
        .byte   $4C
L2DDE:  php
        .byte   $34
        tsx
        stx     $02FD
        sta     $8E
        ldy     #$00
        sty     $8D
L2DEA:  lda     ($8B),y
        ora     ($FB),y
        eor     $8E
        sta     $D000,y
        iny
        cpy     #$08
        bne     L2DEA
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
L2E1C:  sta     ($FB),y
        inc     $FB
        bne     L2E24
        inc     $FC
L2E24:  sta     ($FB),y
        inc     $FB
        bne     L2E2C
        inc     $FC
L2E2C:  dex
        bne     L2E1C
        sta     ($FB),y
        inc     $FB
        bne     L2E37
        inc     $FC
L2E37:  lda     #$7F
        sta     ($FB),y
        sta     $D009
        jsr     L30AD
        beq     L2E46
        jmp     L2FFE

L2E46:  lda     #$FF
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
        jsr     L3114
        lda     L30BD,x
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
        bpl     L2E88
        dec     $24
        ldy     #$00
        jmp     L2E8A

L2E88:  inc     $24
L2E8A:  ldy     #$04
        lda     ($0D),y
        sta     $FD
        iny
        lda     ($0D),y
        sta     $FE
        lda     $24
        jsr     L3114
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
L2EAF:  lsr     $40
        bcc     L2ECF
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
L2ECF:  inc     $22
        bne     L2ED5
        inc     $23
L2ED5:  lda     $22
        cmp     #$40
        lda     $23
        sbc     #$01
        beq     L2EE5
        lda     ($8B),y
        and     $40
        beq     L2EAF
L2EE5:  sec
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
        jmp     L2F70

L2F02:  .byte   $4C
L2F03:  cpy     $2F
        lda     ($8B),y
        and     $40
        bne     L2F02
        lda     $3F
        and     $40
        ora     ($8B),y
        sta     ($8B),y
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        jsr     L30DD
        bit     $8D
        bvs     L2F36
        bit     $FE
        bmi     L2F39
        lda     $FD
        cmp     $22
        lda     $FE
        sbc     $23
        bcc     L2F39
        lda     $8D
        ora     #$40
        sta     $8D
L2F36:  jmp     L2F61

L2F39:  lda     ($3D),y
        and     $40
        clc
        bne     L2F41
        sec
L2F41:  bit     $8E
        bmi     L2F5E
        bcc     L2F63
        tsx
        cpx     #$12
        bcs     L2F4F
        jmp     L2FD4

L2F4F:  lda     $23
        pha
        lda     $22
        pha
        lda     $24
        pha
        sec
        ror     $8E
        jmp     L2F61

L2F5E:  bcs     L2F63
        clc
L2F61:  ror     $8E
L2F63:  sec
        lda     $22
        sbc     #$01
        sta     $22
        lda     $23
        sbc     #$00
        sta     $23
L2F70:  bcc     L2FC6
        asl     $40
        bcs     L2F79
L2F76:  jmp     L2F03

L2F79:  rol     $40
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
        bne     L2F76
        bit     $8D
        bvs     L2FA5
        lda     ($3D),y
        bne     L2F76
        bit     $8E
        bpl     L2F76
L2FA5:  lda     $3F
        sta     ($8B),y
        lda     $8B
        sta     $FB
        lda     $8C
        sta     $FC
        jsr     L30DD
        sec
        lda     $22
        sbc     #$08
        sta     $22
        lda     $23
        sbc     #$00
        sta     $23
        bcc     L2FC6
        .byte   $4C
L2FC4:  .byte   $79
        .byte   $2F
L2FC6:  pla
        cmp     #$FF
        beq     L2FD6
        sta     $24
        pla
        sta     $22
        pla
        sta     $23
        .byte   $4C
L2FD4:  .byte   $47
        .byte   $2E
L2FD6:  lda     $02F2
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
        bmi     L3000
        dec     $24
        lda     $24
        cmp     #$FF
        beq     L3000
        sec
        ror     $8D
        .byte   $4C
L2FFE:  .byte   $3C
        .byte   $2E
L3000:  ldx     $02FD
L3003:  txs
L3004:  rts

        stx     $8D
        sty     $8E
        lda     $8B
        cmp     $FB
        lda     $8C
        sbc     $FC
        bcs     L3024
        lda     #$00
        sta     $3F
        sty     $40
        lda     $FB
        sta     $FD
        lda     $FC
        sta     $FE
        jmp     L3042

L3024:  lda     $8B
        ora     $8C
        ora     $FB
        ora     $FC
        beq     L3004
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
L3042:  sta     $8C
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
L305B:  jsr     L30C5
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
        bcc     L3082
        sta     $1C
        stx     $1B
        ldy     $8E
        ldx     $8D
        jmp     L3084

L3082:  ldy     $40
L3084:  ldx     $3F
        txa
        beq     L3096
        bmi     L308C
        dex
L308C:  clc
        adc     $22
        sta     $22
        txa
        adc     $23
        sta     $23
L3096:  tya
        beq     L30A6
        bmi     L309C
        dey
L309C:  clc
        adc     $24
        sta     $24
        tya
        adc     $25
        sta     $25
L30A6:  inc     $1D
        bne     L305B
        inc     $1E
        .byte   $D0
L30AD:  lda     L2060
        brk
        and     ($90),y
        .byte   $03
        lda     #$FF
        rts

        lda     L30BD,x
        eor     #$FF
        .byte   $31
L30BD:  .byte   $FB
        rts

        .byte   $7F
        .byte   $BF
        .byte   $DF
        .byte   $EF
        .byte   $F7
        .byte   $FB
L30C5:  sbc     L20FE,x
        brk
        and     ($B0),y
        .byte   $33
        lda     ($FB),y
        bit     $02DC
        bmi     L30D6
        and     L30BD,x
L30D6:  bvs     L30DD
        eor     L30BD,x
        eor     #$FF
L30DD:  sta     ($FB),y
        lda     $FC
        lsr     a
        ror     $FB
        lsr     a
        ror     $FB
        lsr     a
        ror     $FB
        and     #$03
        ora     #$CC
        sta     $FC
        ldy     #$00
        lda     ($FB),y
        eor     $02DA
        and     $02DB
        eor     $02DA
        sta     ($FB),y
        rts

L3100:  sec
        rts

        lda     $22
        cmp     #$40
        lda     $23
        sbc     #$01
        bcs     L3100
        lda     $25
        bne     L3100
        lda     $24
        cmp     #$C0
L3114:  bcs     L3100
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

        lda     $01
        pha
        ora     #$02
        sta     $01
        bit     $02DD
        bvs     L3197
        inc     $02E0
        lda     $02E0
        cmp     #$40
        bne     L3178
        inc     $02E1
        lda     #$00
        sta     $02E0
L3178:  lda     $02DD
        ora     #$40
        sta     $02DD
        lda     $02F1
        clc
        adc     #$31
        jsr     L31AE
        jsr     L081F
        bit     $02DD
        bmi     L31A7
        pla
        sta     $01
        jmp     (L02DE)

L3197:  lda     $02DD
        and     #$BF
        sta     $02DD
        lda     #$00
        sta     $02E2
        jsr     L31AE
L31A7:  pla
        sta     $01
        pla
        tay
        pla
        tax
L31AE:  pla
        rti

        sta     $D012
        lda     $D011
        and     #$7F
        sta     $D011
        lda     #$01
        sta     $D019
        lda     $D01A
        ora     #$01
        .byte   $8D
        .byte   $1A
L31C7:  bne     L3229
        php
        pha
        sei
        lda     $DC0E
        and     #$FE
        sta     $DC0E
        lda     #$58
        sta     $0314
        lda     #$31
        sta     $0315
        lda     #$00
        sta     $02DD
        jsr     L31AE
        pla
L31E7:  plp
        rts

        php
        pha
        sei
        lda     $D01A
        and     #$FE
        sta     $D01A
        lda     $DC0E
        ora     #$01
        sta     $DC0E
        lda     L02DE
        sta     $0314
        lda     $02DF
        sta     $0315
        pla
L3209:  plp
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
        bcs     L3266
        .byte   $20
        .byte   $6F
L3229:  .byte   $32
        bcc     L3266
        ldx     #$0F
        jsr     LFFC6
L3231:  bcs     L3266
L3233:  jsr     LFFCF
        bcs     L3266
        pha
        jsr     L326F
        pla
        bcc     L3266
        pha
        jsr     L2251
        pla
        cmp     #$0D
        beq     L326B
        ldx     $02B2
        dex
        bmi     L3233
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
        jmp     L3231

L3266:  ldx     #$64
        jmp     L0849

L326B:  jsr     LFFE7
        .byte   $A5
L326F:  rol     L2060,x
        .byte   $B7
        .byte   $FF
        .byte   $C9
L3275:  brk
        rts

L3277:  cmp     #$00
        beq     L3285
        tay
        cmp     #$01
        beq     L32AA
        ldy     #$08
        jmp     L32A8

L3285:  lda     #$3E
        jsr     L1F9E
        ldx     #$00
        lda     ($FB,x)
        pha
        lda     #$36
        jsr     L2960
        pla
        eor     #$FF
        ldy     #$01
        cmp     ($FB,x)
        beq     L32AA
        pha
        lda     #$37
        jsr     L2960
        pla
        ldy     #$08
        cmp     ($FB,x)
L32A8:  bne     L3277
L32AA:  sty     $02B0
        lda     #$3C
        jsr     L1F9E
        ldy     #$07
        ldx     #$01
        stx     $02B1
        dex
L32BA:  lda     ($FB,x)
        sta     $02B2
        tya
        sta     ($FB,x)
        lda     $02B2
        cmp     #$0D
        beq     L32E1
        cmp     #$41
        bcc     L32D0
        clc
        adc     #$80
L32D0:  tay
        jsr     L3333
        inc     $02B1
        lda     $02B1
        cmp     #$11
        bne     L32BA
        dec     $02B1
L32E1:  lda     $02B0
        cmp     #$01
        bne     L3308
        lda     #$3D
        jsr     L1B6A
L32ED:  ldy     #$00
        jsr     LFFE1
        bne     L32FA
        lda     #$00
        sta     $02B0
        rts

L32FA:  lda     $01
        and     #$10
        bne     L32ED
        ldx     #$00
L3302:  dex
        bne     L3302
        dey
        bne     L32FA
L3308:  jsr     L31E7
L330B:  sec
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
        .byte   $8D
        .byte   $7F
L3320:  sec
L3321:  clc
        adc     ($FB,x)
        bcc     L3329
        inc     $387F
L3329:  jsr     L3333
        jsr     L333A
        bne     L3321
        .byte   $8D
        .byte   $7E
L3333:  sec
        rts

        inc     $FB
        bne     L3349
        .byte   $E6
L333A:  .byte   $FC
        rts

        inc     $FD
        bne     L3349
        .byte   $E6
L3341:  inc     $E660,x
        .byte   $8B
        bne     L3349
        .byte   $E6
L3348:  .byte   $8C
L3349:  rts

        pha
        dec     $FD
        lda     $FD
        cmp     #$FF
        bne     L3355
        dec     $FE
L3355:  pla
        rts

        pha
        dec     $FB
        lda     $FB
        cmp     #$FF
        bne     L3362
        dec     $FC
L3362:  pla
        rts

        ldx     $02B7
        beq     L3379
        ldy     #$00
L336B:  lda     ($1B),y
        sta     ($1D),y
        iny
        bne     L336B
        inc     $1C
        inc     $1E
        dex
        bne     L336B
L3379:  ldx     $02B6
        beq     L3388
        ldy     #$00
        lda     ($1B),y
        sta     ($1D),y
        iny
        dex
        .byte   $D0
L3387:  sed
L3388:  rts

        asl     a
        tax
        lda     L3390,x
        .byte   $BC
        .byte   $91
L3390:  .byte   $33
        rts

        brk
        brk
        plp
        brk
        bvc     L3398
L3398:  sei
        brk
        ldy     #$00
        iny
        brk
        beq     L33A0
L33A0:  clc
        ora     ($40,x)
        ora     ($68,x)
        ora     ($90,x)
        ora     ($B8,x)
        ora     ($E0,x)
        ora     ($08,x)
        .byte   $02
        bmi     L33B2
        cli
        .byte   $02
L33B2:  .byte   $80
        .byte   $02
        tay
        .byte   $02
        bne     L33BA
        sed
        .byte   $02
L33BA:  jsr     L4803
        .byte   $03
        bvs     L33C3
        tya
        .byte   $03
        .byte   $C0
L33C3:  .byte   $03
        inx
        .byte   $03
        sei
        lda     #$07
        sta     $01
        lda     #$00
        sta     $FB
        lda     #$08
        sta     $FC
        ldy     #$33
        jsr     L33E6
        lda     #$F6
        sta     $FB
        lda     #$33
        sta     $FC
        ldy     #$CC
        jsr     L33E6
        .byte   $6C
L33E6:  .byte   $FC
        .byte   $FF
        lda     #$00
        tax
        sta     ($FB,x)
        inc     $FB
        bne     L33F3
        inc     $FC
L33F3:  cpy     $FC
        .byte   $D0
L33F6:  sbc     ($60),y
        php
        sei
        lda     $02DD
        ora     #$80
        sta     $02DD
        lda     $01
        and     #$FC
        sta     $01
L3408:  plp
        rts

        php
        sei
        lda     $01
        ora     #$02
        sta     $01
        lda     $02DD
        and     #$7F
        sta     $02DD
L341A:  plp
        rts

        bpl     L341E
L341E:  clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$10
        brk
        clc
        brk
        plp
        clc
        brk
        brk
        brk
L34A5:  brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$12
        brk
        .byte   $03
        brk
        bpl     L34B5
        brk
        brk
        brk
L34B5:  brk
        brk
        rti

        brk
        brk
        brk
        cpx     #$BD
        lda     $BEBA
        ldy     $F5,x
        ldx     $D0,y
        bcs     L34A5
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
L34DC:  .byte   $DF
        sbc     $20,x
        txa
        .byte   $FF
        jsr     LFF84
        lda     #$00
        tay
L34E7:  sta     $02A7,y
        iny
        cpy     #$59
        bne     L34E7
        jsr     LFF90
        lda     $01
        and     #$FE
        sta     $01
        lda     #$3E
        sta     $0318
        lda     #$08
        sta     $0319
        lda     #$3E
        sta     $FFFA
        lda     #$08
        sta     $FFFB
        php
        sei
        lda     $0315
        cmp     #$31
        beq     L351E
        sta     $02DF
        lda     $0314
        sta     L02DE
L351E:  ldy     #$FF
L3520:  lda     $FF00,y
        sta     $FF00,y
        dey
        bne     L3520
        lda     #$00
        sta     $FB
        lda     #$CC
        sta     $FC
L3531:  tya
        sta     ($FB),y
        jsr     L3333
        lda     $FC
        cmp     #$D0
        bne     L3531
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
L3551:  lda     ($FB,x)
        .byte   $85
L3554:  sbc     L3320,x
        .byte   $33
        lda     ($FB,x)
        sta     $FE
        ora     $FD
        beq     L3578
        lda     #$4C
        sta     ($8B,x)
        jsr     L3341
        lda     $FD
        sta     ($8B,x)
        jsr     L3341
        lda     $FE
        sta     ($8B,x)
        jsr     L3341
        jmp     L3583

L3578:  clc
        lda     #$03
        adc     $8B
        sta     $8B
        lda     #$00
        adc     $8C
L3583:  sta     $8C
        jsr     L3333
        dey
        bne     L3551
        plp
        lda     $DD02
        ora     #$03
        sta     $DD02
        lda     $DD00
        and     #$FC
        sta     $DD00
        lda     #$38
        sta     $D018
        lda     $D011
        ora     #$20
        sta     $D011
        lda     $02A9
        and     #$FB
        sta     $02A9
        lda     $3888
        ora     $3889
        beq     L35C1
        lda     $02A9
        ora     #$04
        sta     $02A9
L35C1:  lda     #$C0
        sta     $02F1
        jmp     L08F1

