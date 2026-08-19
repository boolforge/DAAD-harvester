; z80dasm 1.1.6
; command line: z80dasm -a -g 0x6000 preservation_corpus/extracted/depth2_05ac0a89_CODE.bin

	org	06000h

	jp 07f1ch		;6000
	adc a,01fh		;6003
	rst 38h			;6005
	rst 38h			;6006
	rst 38h			;6007
	rst 38h			;6008
	rst 38h			;6009
	ret			;600a
	nop			;600b
	nop			;600c
	ret			;600d
	jp p,0c979h		;600e
	nop			;6011
	nop			;6012
	jp 079f7h		;6013
	jp 06e26h		;6016
	jp 07432h		;6019
	jp 074efh		;601c
	jp 07637h		;601f
	jp 073d5h		;6022
	jp 073e1h		;6025
	jp 06032h		;6028
	nop			;602b
	rlca			;602c
	nop			;602d
	nop			;602e
	ld bc,00000h		;602f
	set 0,(ix-001h)		;6032
	pop hl			;6036
	dec hl			;6037
	dec hl			;6038
	dec hl			;6039
	dec hl			;603a
	ld (07e5bh),hl		;603b
	ld l,d			;603e
	jp 00055h		;603f
	call 07913h		;6042
	ld ix,07f1ch		;6045
	res 6,(ix-001h)		;6049
	call 016b0h		;604d
	ld a,(07e21h)		;6050
	or a			;6053
	jr nz,$+10		;6054
	ld a,008h		;6056
	call 07432h		;6058
	call 07817h		;605b
	call 0608bh		;605e
	call 07637h		;6061
	res 5,(iy+001h)		;6064
	call 073d5h		;6068
	ld (iy+000h),0ffh		;606b
	res 2,(ix-001h)		;606f
	call 07676h		;6073
	ld hl,0811ch		;6076
	ld (hl),00dh		;6079
	ld (07e18h),hl		;607b
	ld (ix-007h),078h		;607e
	ld hl,(07e20h)		;6082
	ld a,h			;6085
	or a			;6086
	jp z,060deh		;6087
	jp (hl)			;608a
	call 074edh		;608b
	ld a,(05c3ah)		;608e
	ld hl,060d2h		;6091
	bit 0,(ix-001h)		;6094
	jr nz,$+20		;6098
	inc a			;609a
	ld hl,060c1h		;609b
	cp 00dh		;609e
	jr z,$+30		;60a0
	ld hl,060c7h		;60a2
	cp 01bh		;60a5
	jr z,$+23		;60a7
	ld hl,060cbh		;60a9
	ld e,a			;60ac
	push de			;60ad
	call 06df1h		;60ae
	pop de			;60b1
	call 06da0h		;60b2
	bit 0,(ix-001h)		;60b5
	res 0,(ix-001h)		;60b9
	ret			;60bd
	jp 06df1h		;60be
	cp l			;60c1
	xor l			;60c2
	cp d			;60c3
	cp (hl)			;60c4
	or h			;60c5
	push af			;60c6
	or (hl)			;60c7
	ret nc			;60c8
	or b			;60c9
	rst 18h			;60ca
	cp d			;60cb
	adc a,l			;60cc
	adc a,l			;60cd
	sub b			;60ce
	adc a,l			;60cf
	rst 18h			;60d0
	push af			;60d1
	cp b			;60d2
	sbc a,(hl)			;60d3
	sub d			;60d4
	sbc a,d			;60d5
	rst 18h			;60d6
	cp d			;60d7
	adc a,l			;60d8
	adc a,l			;60d9
	sub b			;60da
	adc a,l			;60db
	rst 18h			;60dc
	push af			;60dd
	ld sp,(05c3dh)		;60de
	ld hl,06042h		;60e2
	ex (sp),hl			;60e5
	ld a,(0602bh)		;60e6
	call 0229bh		;60e9
	ld hl,0602ch		;60ec
	call 07900h		;60ef
	call 01cadh		;60f2
	call 00d6bh		;60f5
	ld de,07e72h		;60f8
	ld a,008h		;60fb
	ld hl,07e62h		;60fd
	ld bc,00010h		;6100
	ldir		;6103
	dec a			;6105
	jr nz,$-9		;6106
	ld (07f02h),a		;6108
	ld de,07f03h		;610b
	ld hl,07e62h		;610e
	ld bc,00010h		;6111
	ldir		;6114
	ld hl,07f1ch		;6116
	push hl			;6119
	pop ix		;611a
	xor a			;611c
	ld b,a			;611d
	ld (hl),a			;611e
	inc hl			;611f
	djnz $-2		;6120
	set 7,(ix+01dh)		;6122
	call 0612dh		;6126
	jp nz,0606fh		;6129
	rst 0			;612c
	ld (07e57h),sp		;612d
	xor a			;6131
	ld (07e5ah),a		;6132
	call 06d5eh		;6135
	xor a			;6138
	push af			;6139
	ld (07e5dh),a		;613a
	ld (07e59h),a		;613d
	xor a			;6140
	cp (hl)			;6141
	jr nz,$+26		;6142
	pop de			;6144
	ld a,d			;6145
	or a			;6146
	jr z,$+7		;6147
	pop hl			;6149
	pop bc			;614a
	jp 065e8h		;614b
	ld hl,07e59h		;614e
	cp (hl)			;6151
	ret z			;6152
	ld a,e			;6153
	ld (07e5ah),a		;6154
	dec (hl)			;6157
	pop bc			;6158
	pop hl			;6159
	jr $+34		;615a
	ld a,(hl)			;615c
	inc hl			;615d
	cp 0ffh		;615e
	jr z,$+7		;6160
	cp (ix+021h)		;6162
	jr nz,$+12		;6165
	ld a,(hl)			;6167
	cp 0ffh		;6168
	jr z,$+13		;616a
	cp (ix+022h)		;616c
	jr z,$+8		;616f
	inc hl			;6171
	inc hl			;6172
	inc hl			;6173
	jp 06140h		;6174
	inc hl			;6177
	ld c,(hl)			;6178
	inc hl			;6179
	ld b,(hl)			;617a
	inc hl			;617b
	ld a,(bc)			;617c
	cp 0ffh		;617d
	jr z,$-63		;617f
	ld (07f17h),a		;6181
	push hl			;6184
	ld d,000h		;6185
	sla a		;6187
	ld e,a			;6189
	inc bc			;618a
	ld a,(bc)			;618b
	ld hl,0678ch		;618c
	add hl,de			;618f
	ld e,(hl)			;6190
	inc hl			;6191
	ld d,(hl)			;6192
	push de			;6193
	ld d,000h		;6194
	ld e,a			;6196
	bit 7,(ix-005h)		;6197
	jr z,$+8		;619b
	ld hl,07f1ch		;619d
	add hl,de			;61a0
	ld a,(hl)			;61a1
	ld e,a			;61a2
	ld hl,0801ch		;61a3
	add hl,de			;61a6
	push hl			;61a7
	ld hl,07f1ch		;61a8
	add hl,de			;61ab
	pop de			;61ac
	ret			;61ad
	cp (ix+026h)		;61ae
	jr z,$+99		;61b1
	jr $+14		;61b3
	cp (ix+026h)		;61b5
	jr nz,$+92		;61b8
	jr $+7		;61ba
	cp (ix+026h)		;61bc
	jr c,$+85		;61bf
	pop hl			;61c1
	jp 06140h		;61c2
	cp (ix+026h)		;61c5
	jr c,$-7		;61c8
	jr z,$-9		;61ca
	jr $+72		;61cc
	ld a,(de)			;61ce
	cp (ix+026h)		;61cf
	jr z,$+66		;61d2
	cp 0fdh		;61d4
	jr nc,$+62		;61d6
	jr $-23		;61d8
	ld a,(de)			;61da
	cp (ix+026h)		;61db
	jr z,$-29		;61de
	cp 0fdh		;61e0
	jr nc,$-33		;61e2
	jr $+48		;61e4
	ld a,(de)			;61e6
	cp 0fdh		;61e7
	jr z,$+43		;61e9
	jr $-42		;61eb
	ld a,(de)			;61ed
	cp 0fdh		;61ee
	jr nz,$+36		;61f0
	jr $-49		;61f2
	ld a,(de)			;61f4
	cp 0feh		;61f5
	jr nz,$-54		;61f7
	jr $+27		;61f9
	ld a,(de)			;61fb
	cp 0feh		;61fc
	jr z,$-61		;61fe
	jr $+20		;6200
	call 06d7dh		;6202
	cp h			;6205
	jr nc,$+14		;6206
	jr $-71		;6208
	ld a,(hl)			;620a
	or a			;620b
	jr nz,$-75		;620c
	jr $+6		;620e
	ld a,(hl)			;6210
	or a			;6211
	jr z,$-81		;6212
	inc bc			;6214
	pop hl			;6215
	jp 0617ch		;6216
	inc bc			;6219
	ld a,(bc)			;621a
	cp (hl)			;621b
	jr nz,$-91		;621c
	jr $-10		;621e
	call 0650dh		;6220
	jr $-8		;6223
	inc bc			;6225
	ld a,(bc)			;6226
	cp (hl)			;6227
	jr z,$-103		;6228
	jr $-22		;622a
	call 0650dh		;622c
	jr $-8		;622f
	call 0650dh		;6231
	jr $+4		;6234
	inc bc			;6236
	ld a,(bc)			;6237
	cp (hl)			;6238
	jr c,$-37		;6239
	jr $-122		;623b
	call 0650dh		;623d
	jr $+4		;6240
	inc bc			;6242
	ld a,(bc)			;6243
	cp (hl)			;6244
	jp c,061c1h		;6245
	jp z,061c1h		;6248
	jp 06214h		;624b
	cp (ix+023h)		;624e
	jr z,$-61		;6251
	jp 061c1h		;6253
	cp (ix+024h)		;6256
	jr $-8		;6259
	cp (ix+02bh)		;625b
	jr $-13		;625e
	cp (ix+02ch)		;6260
	jr $-18		;6263
	cp (ix+02dh)		;6265
	jr $-23		;6268
	ld l,00ch		;626a
	push bc			;626c
	call 070feh		;626d
	pop bc			;6270
	ld a,(hl)			;6271
	ld l,01eh		;6272
	call 06d6eh		;6274
	cpl			;6277
	cp (hl)			;6278
	jp nz,061c1h		;6279
	jp 06457h		;627c
	ld l,00dh		;627f
	call 070feh		;6281
	ld a,(hl)			;6284
	ld l,01fh		;6285
	call 06d6eh		;6287
	cpl			;628a
	sub (hl)			;628b
	jr z,$+13		;628c
	xor a			;628e
	ld (07f42h),a		;628f
	ld sp,(07e57h)		;6292
	jp 06131h		;6296
	ld sp,(07e57h)		;6299
	or a			;629d
	ret			;629e
	res 2,(ix-001h)		;629f
	call 06de8h		;62a3
	pop hl			;62a6
	set 4,(ix-001h)		;62a7
	jp 06144h		;62ab
	ld l,00fh		;62ae
	jr $-13		;62b0
	push bc			;62b2
	call 073b7h		;62b3
	pop bc			;62b6
	jp 06457h		;62b7
	inc bc			;62ba
	call 0600ah		;62bb
	jp 06456h		;62be
	inc bc			;62c1
	call 0600dh		;62c2
	jp 06456h		;62c5
	push bc			;62c8
	call 0746dh		;62c9
	pop bc			;62cc
	jp 06457h		;62cd
	ld (ix+001h),000h		;62d0
	ld hl,0801ch		;62d4
	ld a,(hl)			;62d7
	cp 0ffh		;62d8
	jp z,06457h		;62da
	cp 0fdh		;62dd
	jr c,$+6		;62df
	ld a,(07f42h)		;62e1
	ld (hl),a			;62e4
	inc hl			;62e5
	jr $-15		;62e6
	push bc			;62e8
	ld a,(07f42h)		;62e9
	ld bc,0fefdh		;62ec
	call 06956h		;62ef
	pop bc			;62f2
	ld l,01ah		;62f3
	jp z,06384h		;62f5
	dec bc			;62f8
	call 069a3h		;62f9
	ld a,(de)			;62fc
	ld l,019h		;62fd
	cp 0fdh		;62ff
	jr nc,$+74		;6301
	inc l			;6303
	cp (ix+026h)		;6304
	jr nz,$+129		;6307
	ld a,(07f4fh)		;6309
	call 068cfh		;630c
	call 068a9h		;630f
	ld l,02bh		;6312
	add a,h			;6314
	jr c,$+115		;6315
	ld hl,07f50h		;6317
	cp (hl)			;631a
	jr z,$+6		;631b
	ld l,02bh		;631d
	jr nc,$+105		;631f
	ld l,024h		;6321
	ld h,01bh		;6323
	push hl			;6325
	ld a,(07f1dh)		;6326
	ld hl,07f41h		;6329
	cp (hl)			;632c
	jr nc,$+15		;632d
	ex de,hl			;632f
	ld (hl),0feh		;6330
	inc (ix+001h)		;6332
	pop hl			;6335
	call 06de8h		;6336
	jp 06456h		;6339
	pop hl			;633c
	ld l,h			;633d
	ld a,(07e5dh)		;633e
	or a			;6341
	jp z,0629fh		;6342
	ld a,(08403h)		;6345
	ld (07e5dh),a		;6348
	jp 0629fh		;634b
	call 06947h		;634e
	jr z,$+51		;6351
	dec bc			;6353
	call 069a3h		;6354
	ld a,(de)			;6357
	cp 0fdh		;6358
	ld l,018h		;635a
	jr z,$-17		;635c
	ld l,031h		;635e
	cp (ix+026h)		;6360
	jr z,$-24		;6363
	ld l,01ch		;6365
	cp 0feh		;6367
	jr nz,$-30		;6369
	ld a,(07f42h)		;636b
	ld (de),a			;636e
	dec (ix+001h)		;636f
	ld l,027h		;6372
	jr $-62		;6374
	push bc			;6376
	ld a,0fdh		;6377
	ld b,0feh		;6379
	call 06953h		;637b
	pop bc			;637e
	dec bc			;637f
	jr nz,$+14		;6380
	ld l,017h		;6382
	jr c,$+4		;6384
	ld l,008h		;6386
	jp 0629fh		;6388
	call 069a3h		;638b
	ld a,(de)			;638e
	ld l,032h		;638f
	cp 0feh		;6391
	jr z,$-11		;6393
	cp (ix+026h)		;6395
	jr z,$-16		;6398
	ld l,017h		;639a
	cp 0fdh		;639c
	jr nz,$-22		;639e
	call 0692ah		;63a0
	inc l			;63a3
	jr nc,$-28		;63a4
	ld l,026h		;63a6
	ld h,02ah		;63a8
	jp 06325h		;63aa
	push bc			;63ad
	ld b,0fdh		;63ae
	call 06951h		;63b0
	pop bc			;63b3
	ld l,01ch		;63b4
	jr z,$-50		;63b6
	dec bc			;63b8
	call 069a3h		;63b9
	ld a,(de)			;63bc
	ld l,031h		;63bd
	cp (ix+026h)		;63bf
	jr z,$-58		;63c2
	ld l,01dh		;63c4
	cp 0fdh		;63c6
	jr z,$-64		;63c8
	dec l			;63ca
	jr c,$-67		;63cb
	call 0692ah		;63cd
	jr nc,$-72		;63d0
	ex de,hl			;63d2
	ld (hl),0fdh		;63d3
	dec (ix+001h)		;63d5
	ld l,025h		;63d8
	jp 06336h		;63da
	ld e,a			;63dd
	ld d,000h		;63de
	push bc			;63e0
	call 073deh		;63e1
	pop bc			;63e4
	jr $+113		;63e5
	ld (07f42h),a		;63e7
	jr $+108		;63ea
	ld de,(0840eh)		;63ec
	ld hl,08404h		;63f0
	jr $+22		;63f3
	set 6,(ix-001h)		;63f5
	ld de,(08410h)		;63f9
	ld hl,08405h		;63fd
	jr $+9		;6400
	ld de,(08412h)		;6402
	ld hl,08406h		;6406
	cp (hl)			;6409
	jr nc,$+17		;640a
	ex de,hl			;640c
	ld d,000h		;640d
	ld e,a			;640f
	add hl,de			;6410
	add hl,de			;6411
	ld e,(hl)			;6412
	inc hl			;6413
	ld d,(hl)			;6414
	ex de,hl			;6415
	call 06df1h		;6416
	jr $+61		;6419
	ld d,007h		;641b
	jp 06032h		;641d
	call 069a3h		;6420
	ex de,hl			;6423
	ld a,(hl)			;6424
	cp 0feh		;6425
	ld (hl),0fch		;6427
	jr nz,$+45		;6429
	dec (ix+001h)		;642b
	jr $+40		;642e
	call 069a3h		;6430
	ld a,(de)			;6433
	cp 0feh		;6434
	ld a,(07f42h)		;6436
	ld (de),a			;6439
	jr $-17		;643a
	inc bc			;643c
	ld a,(bc)			;643d
	call 069a3h		;643e
	ld l,a			;6441
	ld h,000h		;6442
	ld a,(de)			;6444
	push de			;6445
	ld de,0801ch		;6446
	add hl,de			;6449
	ld d,(hl)			;644a
	ld (hl),a			;644b
	pop hl			;644c
	ld (hl),d			;644d
	jr $+8		;644e
	ld (hl),0ffh		;6450
	jr $+4		;6452
	ld (hl),000h		;6454
	inc bc			;6456
	pop hl			;6457
	set 4,(ix-001h)		;6458
	jp 0617ch		;645c
	inc bc			;645f
	ld d,a			;6460
	ld a,(bc)			;6461
	add a,(hl)			;6462
	jr nc,$+36		;6463
	ld a,0ffh		;6465
	jr $+32		;6467
	inc bc			;6469
	ld a,(bc)			;646a
	ld d,a			;646b
	ld a,(hl)			;646c
	sub d			;646d
	jr nc,$+3		;646e
	xor a			;6470
	ld (hl),a			;6471
	jr $-28		;6472
	inc bc			;6474
	push af			;6475
	ld a,(bc)			;6476
	push hl			;6477
	ld e,a			;6478
	ld d,000h		;6479
	ld hl,07f1ch		;647b
	add hl,de			;647e
	ld e,(hl)			;647f
	pop hl			;6480
	pop af			;6481
	jr $+7		;6482
	inc bc			;6484
	ld d,a			;6485
	ld a,(bc)			;6486
	ld e,a			;6487
	ld a,d			;6488
	cp 026h		;6489
	jr nz,$+14		;648b
	ld a,(08404h)		;648d
	cp e			;6490
	ld d,001h		;6491
	jp c,06032h		;6493
	jp z,06032h		;6496
	ld (hl),e			;6499
	jr $-68		;649a
	call 074edh		;649c
	jr $-72		;649f
	ld e,(hl)			;64a1
	inc hl			;64a2
	ld d,(hl)			;64a3
	call 06da2h		;64a4
	jr $-81		;64a7
	ld e,(hl)			;64a9
	call 06da0h		;64aa
	jr $-87		;64ad
	inc bc			;64af
	ex de,hl			;64b0
	ld a,(bc)			;64b1
	call 06923h		;64b2
	cp (hl)			;64b5
	jp nz,061c1h		;64b6
	jp 06214h		;64b9
	inc bc			;64bc
	ex de,hl			;64bd
	ld a,(bc)			;64be
	call 06923h		;64bf
	cp (hl)			;64c2
	jp nz,06214h		;64c3
	jp 061c1h		;64c6
	call 069a3h		;64c9
	inc bc			;64cc
	ex de,hl			;64cd
	ld a,(bc)			;64ce
	call 06923h		;64cf
	push af			;64d2
	ld a,(hl)			;64d3
	jr $+31		;64d4
	call 06923h		;64d6
	push af			;64d9
	ld a,(07f4fh)		;64da
	jr $+19		;64dd
	ld a,(hl)			;64df
	cp 0ffh		;64e0
	jr nz,$+8		;64e2
	ld d,002h		;64e4
	jp 06032h		;64e6
	ld a,(de)			;64e9
	push af			;64ea
	inc bc			;64eb
	ld a,(bc)			;64ec
	call 069a3h		;64ed
	call 0693eh		;64f0
	cp 0feh		;64f3
	jr nz,$+5		;64f5
	dec (ix+001h)		;64f7
	pop af			;64fa
	cp 0feh		;64fb
	jr nz,$+5		;64fd
	inc (ix+001h)		;64ff
	ld (hl),a			;6502
	jp 06456h		;6503
	ex de,hl			;6506
	call 0650eh		;6507
	jp 06487h		;650a
	ex de,hl			;650d
	inc bc			;650e
	ld a,(bc)			;650f
	push bc			;6510
	ld c,a			;6511
	ld b,000h		;6512
	ld hl,07f1ch		;6514
	add hl,bc			;6517
	ld a,(de)			;6518
	ld e,a			;6519
	ld d,c			;651a
	pop bc			;651b
	ret			;651c
	call 0650dh		;651d
	jp 06462h		;6520
	call 0650dh		;6523
	jp 0646bh		;6526
	ld d,(ix+026h)		;6529
	set 1,(ix-001h)		;652c
	call 06a20h		;6530
	jp 06457h		;6533
	push bc			;6536
	or a			;6537
	jr nz,$+7		;6538
	call 06ad4h		;653a
	jr $+5		;653d
	call 06ac8h		;653f
	pop bc			;6542
	jp c,06214h		;6543
	set 4,(ix-001h)		;6546
	jp 061c1h		;654a
	call 06923h		;654d
	ld d,a			;6550
	res 1,(ix-001h)		;6551
	call 06a20h		;6555
	jp 06456h		;6558
	inc bc			;655b
	ld hl,08407h		;655c
	cp (hl)			;655f
	jr nc,$+40		;6560
	or a			;6562
	jr z,$+37		;6563
	call 06d5eh		;6565
	push af			;6568
	ld a,(07e59h)		;6569
	inc a			;656c
	ld (07e59h),a		;656d
	cp 00ah		;6570
	jp z,0658dh		;6572
	pop af			;6575
	push bc			;6576
	ld de,(07e5ah)		;6577
	ld d,000h		;657b
	push de			;657d
	ld (07e5ah),a		;657e
	res 4,(ix-001h)		;6581
	jp 06140h		;6585
	ld d,006h		;6588
	jp 06032h		;658a
	pop af			;658d
	ld d,003h		;658e
	jp 06032h		;6590
	pop hl			;6593
	ld a,(07e5ah)		;6594
	call 06d5eh		;6597
	jp 06140h		;659a
	ld (07f4ch),a		;659d
	inc bc			;65a0
	ld a,(bc)			;65a1
	ld e,a			;65a2
	ld d,0f8h		;65a3
	jr $+28		;65a5
	inc bc			;65a7
	jp 06456h		;65a8
	ld (07f41h),a		;65ab
	inc bc			;65ae
	ld a,(bc)			;65af
	ld (07f50h),a		;65b0
	jp 06456h		;65b3
	ld (07f45h),a		;65b6
	inc bc			;65b9
	ld a,(bc)			;65ba
	rlca			;65bb
	rlca			;65bc
	rlca			;65bd
	ld e,a			;65be
	ld d,0c7h		;65bf
	ld a,(07f4dh)		;65c1
	xor e			;65c4
	and d			;65c5
	xor e			;65c6
	ld (07f4dh),a		;65c7
	jp 06456h		;65ca
	res 2,(ix-001h)		;65cd
	jp 06457h		;65d1
	call 06923h		;65d4
	ld (07f4eh),a		;65d7
	ld a,(07e5dh)		;65da
	or a			;65dd
	ld d,004h		;65de
	jp nz,06032h		;65e0
	pop hl			;65e3
	res 4,(ix-001h)		;65e4
	push bc			;65e8
	push hl			;65e9
	ld de,0ff00h		;65ea
	push de			;65ed
	push hl			;65ee
	push bc			;65ef
	ld a,(07e5dh)		;65f0
	ld e,a			;65f3
	ld a,(07f4eh)		;65f4
	call 069f8h		;65f7
	jr nc,$+41		;65fa
	ld (07f3eh),a		;65fc
	cp (ix+02ch)		;65ff
	inc hl			;6602
	ld a,(hl)			;6603
	ld (07f3fh),a		;6604
	jr nz,$+15		;6607
	ld a,(07f49h)		;6609
	cp 0ffh		;660c
	jr z,$+5		;660e
	cp (hl)			;6610
	jr nz,$+5		;6611
	pop hl			;6613
	jr $-32		;6614
	ld a,e			;6616
	ld (07e5dh),a		;6617
	dec a			;661a
	call 069a3h		;661b
	pop de			;661e
	pop bc			;661f
	jp 06456h		;6620
	xor a			;6623
	ld (07e5dh),a		;6624
	pop bc			;6627
	pop hl			;6628
	pop hl			;6629
	pop hl			;662a
	pop hl			;662b
	jp 06144h		;662c
	push af			;662f
	call 0650eh		;6630
	pop af			;6633
	push hl			;6634
	call 068cfh		;6635
	ld a,h			;6638
	pop hl			;6639
	jp 06487h		;663a
	ld d,a			;663d
	call 068a9h		;663e
	jp 06487h		;6641
	push hl			;6644
	call 06d7dh		;6645
	ld d,a			;6648
	ld a,h			;6649
	pop hl			;664a
	jp 06487h		;664b
	ld (07e50h),a		;664e
	call 06947h		;6651
	jp z,06384h		;6654
	jr $+10		;6657
	call 069a3h		;6659
	inc bc			;665c
	ld a,(bc)			;665d
	ld (07e50h),a		;665e
	ld a,(de)			;6661
	cp 0fdh		;6662
	ld l,018h		;6664
	jp z,0629fh		;6666
	ld l,031h		;6669
	cp (ix+026h)		;666b
	jp z,0629fh		;666e
	cp 0feh		;6671
	ld l,01ch		;6673
	jp nz,0629fh		;6675
	ld a,(07e50h)		;6678
	ld (de),a			;667b
	dec (ix+001h)		;667c
	ld l,02ch		;667f
	call 066d9h		;6681
	jp 06336h		;6684
	ld (07e50h),a		;6687
	push bc			;668a
	ld bc,0fefdh		;668b
	call 06956h		;668e
	jr nz,$+9		;6691
	ld a,(07f42h)		;6693
	ld b,a			;6696
	call 06953h		;6697
	pop bc			;669a
	jr nz,$+10		;669b
	ld a,(07e50h)		;669d
	jr c,$+49		;66a0
	jp 06386h		;66a2
	ld a,(07e50h)		;66a5
	jr $+7		;66a8
	call 069a3h		;66aa
	inc bc			;66ad
	ld a,(bc)			;66ae
	ld h,a			;66af
	ld a,(de)			;66b0
	ld l,019h		;66b1
	cp 0fdh		;66b3
	jp nc,0629fh		;66b5
	cp h			;66b8
	jr nz,$+16		;66b9
	ld a,h			;66bb
	push de			;66bc
	call 0693eh		;66bd
	pop de			;66c0
	cp 0fdh		;66c1
	jp nc,06321h		;66c3
	jp 06309h		;66c6
	ld l,02dh		;66c9
	cp (ix+026h)		;66cb
	ld a,h			;66ce
	jr z,$+4		;66cf
	ld l,034h		;66d1
	call 066d9h		;66d3
	jp 0629fh		;66d6
	push af			;66d9
	call 06de8h		;66da
	pop af			;66dd
	set 4,(ix-003h)		;66de
	set 5,(ix-003h)		;66e2
	call 06cfdh		;66e6
	ld l,033h		;66e9
	ret			;66eb
	push bc			;66ec
	ld b,0fdh		;66ed
	call 06951h		;66ef
	pop bc			;66f2
	jp 06457h		;66f3
	push bc			;66f6
	ld hl,(08418h)		;66f7
	ld de,0801ch		;66fa
	ld a,(hl)			;66fd
	ldi		;66fe
	cp 0feh		;6700
	jr c,$-5		;6702
	jr nz,$-18		;6704
	inc (ix+001h)		;6706
	jr $-12		;6709
	res 4,(ix-001h)		;670b
	pop hl			;670f
	jp 06144h		;6710
	push bc			;6713
	ld a,(hl)			;6714
	push hl			;6715
	ld hl,08404h		;6716
	cp (hl)			;6719
	call c,06aaeh		;671a
	pop hl			;671d
	pop bc			;671e
	jp nc,061c1h		;671f
	ld (hl),a			;6722
	jp 06456h		;6723
	bit 4,(ix-001h)		;6726
	jp nz,06215h		;672a
	jp 061c1h		;672d
	bit 4,(ix-001h)		;6730
	jp nz,061c1h		;6734
	jp 06215h		;6737
	ld h,000h		;673a
	ld l,a			;673c
	sla l		;673d
	jr nc,$+3		;673f
	dec h			;6741
	add hl,hl			;6742
	pop de			;6743
	add hl,de			;6744
	jp 06140h		;6745
	cp 0ffh		;6748
	jr z,$+5		;674a
	ld (07f3dh),a		;674c
	inc bc			;674f
	ld a,(bc)			;6750
	cp 0ffh		;6751
	jr z,$+5		;6753
	ld (07f3eh),a		;6755
	jp 06456h		;6758
	call 069a3h		;675b
	jp 06456h		;675e
	ld a,020h		;6761
	call 074efh		;6763
	jp 06457h		;6766
	call 0688ch		;6769
	jp nz,06214h		;676c
	jp 061c1h		;676f
	call 0688ch		;6772
	jp nz,061c1h		;6775
	jp 06214h		;6778
	ld l,a			;677b
	inc bc			;677c
	ld a,(bc)			;677d
	inc bc			;677e
	ld h,a			;677f
	call 06786h		;6780
	jp 06457h		;6783
	jp (hl)			;6786
	ld d,005h		;6787
	jp 06032h		;6789
	xor (hl)			;678c
	ld h,c			;678d
	or l			;678e
	ld h,c			;678f
	cp h			;6790
	ld h,c			;6791
	push bc			;6792
	ld h,c			;6793
	adc a,061h		;6794
	jp c,0e661h		;6796
	ld h,c			;6799
	out (c),h		;679a
	call p,0fb61h		;679c
	ld h,c			;679f
	ld (bc),a			;67a0
	ld h,d			;67a1
	ld a,(bc)			;67a2
	ld h,d			;67a3
	djnz $+100		;67a4
	add hl,de			;67a6
	ld h,d			;67a7
	ld (hl),062h		;67a8
	ld b,d			;67aa
	ld h,d			;67ab
	ld c,(hl)			;67ac
	ld h,d			;67ad
	ld d,(hl)			;67ae
	ld h,d			;67af
	pop bc			;67b0
	ld h,d			;67b1
	call pe,06a63h		;67b2
	ld h,d			;67b5
	ld a,a			;67b6
	ld h,d			;67b7
	and (hl)			;67b8
	ld h,d			;67b9
	xor (hl)			;67ba
	ld h,d			;67bb
	or d			;67bc
	ld h,d			;67bd
	rst 30h			;67be
	ld l,a			;67bf
	ld (hl),070h		;67c0
	and c			;67c2
	ld h,h			;67c3
	ld e,h			;67c4
	ld l,(hl)			;67c5
	ret z			;67c6
	ld h,d			;67c7
	ret nc			;67c8
	ld h,d			;67c9
	ret pe			;67ca
	ld h,d			;67cb
	ld c,(hl)			;67cc
	ld h,e			;67cd
	xor l			;67ce
	ld h,e			;67cf
	halt			;67d0
	ld h,e			;67d1
	defb 0ddh,063h	;ld ixh,e		;67d2
	ld c,b			;67d4
	ld h,a			;67d5
	rst 20h			;67d6
	ld h,e			;67d7
	push af			;67d8
	ld h,e			;67d9
	adc a,e			;67da
	ld h,e			;67db
	ld sp,hl			;67dc
	ld h,d			;67dd
	ld d,h			;67de
	ld h,e			;67df
	cp c			;67e0
	ld h,e			;67e1
	jr nz,$+102		;67e2
	jr nc,$+102		;67e4
	inc a			;67e6
	ld h,h			;67e7
	ret			;67e8
	ld h,h			;67e9
	ld d,b			;67ea
	ld h,h			;67eb
	ld d,h			;67ec
	ld h,h			;67ed
	ld e,a			;67ee
	ld h,h			;67ef
	ld l,c			;67f0
	ld h,h			;67f1
	add a,h			;67f2
	ld h,h			;67f3
	sbc a,h			;67f4
	ld h,h			;67f5
	xor c			;67f6
	ld h,h			;67f7
	ld (bc),a			;67f8
	ld h,h			;67f9
	xor a			;67fa
	ld h,h			;67fb
	ld e,e			;67fc
	ld h,a			;67fd
	ld h,c			;67fe
	ld h,a			;67ff
	ld l,c			;6800
	ld h,a			;6801
	ld (hl),d			;6802
	ld h,a			;6803
	add hl,hl			;6804
	ld h,l			;6805
	cp d			;6806
	ld h,d			;6807
	and d			;6808
	ld l,a			;6809
	or e			;680a
	ld l,a			;680b
	inc (hl)			;680c
	ld l,a			;680d
	ld e,l			;680e
	ld l,a			;680f
	ld l,c			;6810
	ld l,a			;6811
	add a,c			;6812
	ld l,a			;6813
	ld e,e			;6814
	ld h,d			;6815
	ld h,b			;6816
	ld h,d			;6817
	ld h,l			;6818
	ld h,d			;6819
	dec e			;681a
	ld h,l			;681b
	inc hl			;681c
	ld h,l			;681d
	ld (hl),065h		;681e
	ld c,l			;6820
	ld h,l			;6821
	ld e,e			;6822
	ld h,l			;6823
	jr nz,$+100		;6824
	ld sp,hl			;6826
	ld h,e			;6827
	push hl			;6828
	ld l,(hl)			;6829
	dec h			;682a
	ld h,d			;682b
	inc l			;682c
	ld h,d			;682d
	jr c,$+112		;682e
	ld l,(iy-063h)		;6830
	ld h,l			;6833
	ld b,a			;6834
	ld l,(hl)			;6835
	call nc,0a765h		;6836
	ld h,l			;6839
	and a			;683a
	ld h,l			;683b
	cp h			;683c
	ld h,h			;683d
	cpl			;683e
	ld h,(hl)			;683f
	ld e,c			;6840
	ld h,(hl)			;6841
	xor d			;6842
	ld h,(hl)			;6843
	call 0ab65h		;6844
	ld h,l			;6847
	dec a			;6848
	ld h,(hl)			;6849
	ld b,h			;684a
	ld h,(hl)			;684b
	or (hl)			;684c
	ld h,l			;684d
	adc a,d			;684e
	ld l,(hl)			;684f
	sbc a,(hl)			;6850
	ld l,(hl)			;6851
	jp nz,0ec6eh		;6852
	ld h,(hl)			;6855
	ld a,e			;6856
	ld h,a			;6857
	sub 064h		;6858
	dec bc			;685a
	ld h,a			;685b
	ld c,(hl)			;685c
	ld h,(hl)			;685d
	add a,a			;685e
	ld h,(hl)			;685f
	inc de			;6860
	ld h,a			;6861
	add hl,de			;6862
	ld l,a			;6863
	sub e			;6864
	ld h,l			;6865
	defb 0edh;next byte illegal after ed		;6866
	ld l,(hl)			;6867
	sbc a,c			;6868
	ld h,d			;6869
	adc a,h			;686a
	ld l,a			;686b
	dec a			;686c
	ld h,d			;686d
	ld sp,02662h		;686e
	ld h,a			;6871
	jr nc,$+105		;6872
	ld a,(09267h)		;6874
	ld h,d			;6877
	or l			;6878
	ld l,(hl)			;6879
	rlca			;687a
	ld h,l			;687b
	add a,a			;687c
	ld h,a			;687d
	jp (hl)			;687e
	ld h,h			;687f
	add a,a			;6880
	ld h,a			;6881
	rst 18h			;6882
	ld h,h			;6883
	add a,a			;6884
	ld h,a			;6885
	ld b,065h		;6886
	ld (hl),h			;6888
	ld h,h			;6889
	or 066h		;688a
	ld h,a			;688c
	rrca			;688d
	rrca			;688e
	rrca			;688f
	and 01fh		;6890
	ld l,a			;6892
	ld a,03bh		;6893
	sub l			;6895
	ld (068a6h),a		;6896
	ld a,h			;6899
	rlca			;689a
	rlca			;689b
	rlca			;689c
	and 038h		;689d
	or 046h		;689f
	ld (068a7h),a		;68a1
	defb 0ddh,0cbh,000h,000h	;rlc (ix+000h) & ld b,(ix+000h)		;68a4
	ret			;68a8
	xor a			;68a9
	push hl			;68aa
	push de			;68ab
	push bc			;68ac
	ld bc,(08402h)		;68ad
	ld c,a			;68b1
	ld de,0801ch		;68b2
	push af			;68b5
	ld a,(de)			;68b6
	cp 0fdh		;68b7
	ld l,c			;68b9
	ld h,000h		;68ba
	call nc,068d0h		;68bc
	pop af			;68bf
	add a,h			;68c0
	jr nc,$+6		;68c1
	ld a,0ffh		;68c3
	jr $+6		;68c5
	inc c			;68c7
	inc de			;68c8
	djnz $-20		;68c9
	pop bc			;68cb
	pop de			;68cc
	pop hl			;68cd
	ret			;68ce
	ld l,a			;68cf
	ex de,hl			;68d0
	xor a			;68d1
	ld d,a			;68d2
	ld (07e5eh),a		;68d3
	call 068dch		;68d6
	ex de,hl			;68d9
	ld a,l			;68da
	ret			;68db
	push hl			;68dc
	push de			;68dd
	push bc			;68de
	call 06936h		;68df
	and 07fh		;68e2
	add a,0c0h		;68e4
	res 6,a		;68e6
	res 7,a		;68e8
	jr nc,$+45		;68ea
	and 03fh		;68ec
	jr z,$+40		;68ee
	ld c,a			;68f0
	ld a,(07e5eh)		;68f1
	inc a			;68f4
	ld (07e5eh),a		;68f5
	cp 00ah		;68f8
	jr z,$+23		;68fa
	ld a,c			;68fc
	ld bc,(08402h)		;68fd
	ld c,e			;6901
	ld e,000h		;6902
	ld d,a			;6904
	ld hl,0801ch		;6905
	ld a,(hl)			;6908
	cp c			;6909
	call z,068dch		;690a
	inc hl			;690d
	inc e			;690e
	djnz $-7		;690f
	ld hl,07e5eh		;6911
	dec (hl)			;6914
	ld a,d			;6915
	scf			;6916
	pop bc			;6917
	pop de			;6918
	pop hl			;6919
	push af			;691a
	add a,d			;691b
	ld d,a			;691c
	jr nc,$+4		;691d
	ld d,0ffh		;691f
	pop af			;6921
	ret			;6922
	cp 0ffh		;6923
	ret nz			;6925
	ld a,(07f42h)		;6926
	ret			;6929
	push de			;692a
	ld e,(ix+033h)		;692b
	call 06936h		;692e
	pop de			;6931
	ld l,028h		;6932
	rlca			;6934
	ret			;6935
	ld d,000h		;6936
	ld hl,(0841ch)		;6938
	add hl,de			;693b
	ld a,(hl)			;693c
	ret			;693d
	ld e,a			;693e
	ld d,000h		;693f
	ld hl,0801ch		;6941
	add hl,de			;6944
	ld a,(hl)			;6945
	ret			;6946
	push bc			;6947
	ld b,0fdh		;6948
	call 06951h		;694a
	pop bc			;694d
	ld l,01ch		;694e
	ret			;6950
	ld a,0feh		;6951
	ld c,(ix+026h)		;6953
	ld (07f4fh),a		;6956
	ld a,(07f3eh)		;6959
	inc a			;695c
	scf			;695d
	jr z,$+30		;695e
	push bc			;6960
	ld b,(ix+033h)		;6961
	call 06988h		;6964
	jr c,$+25		;6967
	pop bc			;6969
	call 06988h		;696a
	jr c,$+20		;696d
	ld b,c			;696f
	call 06988h		;6970
	jr c,$+14		;6973
	ld b,0ffh		;6975
	call 06988h		;6977
	jr c,$+8		;697a
	ld a,0ffh		;697c
	jr $+37		;697e
	pop bc			;6980
	or a			;6981
	dec hl			;6982
	ex de,hl			;6983
	dec hl			;6984
	ld a,l			;6985
	jr $+29		;6986
	ld e,000h		;6988
	call 069f9h		;698a
	ret nc			;698d
	call 06996h		;698e
	pop hl			;6991
	jr nz,$-8		;6992
	scf			;6994
	ret			;6995
	cp (ix+022h)		;6996
	ret nz			;6999
	ld a,(07f3fh)		;699a
	cp 0ffh		;699d
	ret z			;699f
	inc hl			;69a0
	cp (hl)			;69a1
	ret			;69a2
	push af			;69a3
	push hl			;69a4
	push de			;69a5
	ld hl,00000h		;69a6
	ld (07f52h),hl		;69a9
	ld (07f54h),hl		;69ac
	ld (07f56h),hl		;69af
	ld e,a			;69b2
	ld (07f4fh),a		;69b3
	cp 0ffh		;69b6
	jr z,$+51		;69b8
	ld hl,08403h		;69ba
	cp (hl)			;69bd
	jr nc,$+49		;69be
	call 06936h		;69c0
	rla			;69c3
	rr (ix+039h)		;69c4
	rla			;69c8
	rr (ix+038h)		;69c9
	call 06941h		;69cd
	ld (07f52h),a		;69d0
	ex de,hl			;69d3
	call 068d0h		;69d4
	ld (ix+037h),h		;69d7
	ld h,000h		;69da
	ex de,hl			;69dc
	ld hl,(0841eh)		;69dd
	add hl,de			;69e0
	add hl,de			;69e1
	ld a,(hl)			;69e2
	ld (07f57h),a		;69e3
	inc hl			;69e6
	ld a,(hl)			;69e7
	ld (07f56h),a		;69e8
	pop de			;69eb
	pop hl			;69ec
	pop af			;69ed
	ret			;69ee
	pop de			;69ef
	pop hl			;69f0
	pop af			;69f1
	pop af			;69f2
	ld d,000h		;69f3
	jp 06032h		;69f5
	ld b,a			;69f8
	ld hl,0801ch		;69f9
	ld d,000h		;69fc
	add hl,de			;69fe
	ld a,(08403h)		;69ff
	cp e			;6a02
	ret z			;6a03
	ld a,b			;6a04
	inc de			;6a05
	cp 0ffh		;6a06
	jr z,$+3		;6a08
	cp (hl)			;6a0a
	inc hl			;6a0b
	jr nz,$-13		;6a0c
	ex (sp),hl			;6a0e
	push hl			;6a0f
	push de			;6a10
	dec e			;6a11
	ld hl,(0841ah)		;6a12
	add hl,de			;6a15
	add hl,de			;6a16
	ld a,(hl)			;6a17
	cp 0ffh		;6a18
	pop de			;6a1a
	ret c			;6a1b
	pop hl			;6a1c
	ex (sp),hl			;6a1d
	jr $-31		;6a1e
	push bc			;6a20
	ld bc,00000h		;6a21
	push bc			;6a24
	res 7,(ix+035h)		;6a25
	res 4,(ix-003h)		;6a29
	set 5,(ix-003h)		;6a2d
	ld hl,0801ch		;6a31
	add hl,bc			;6a34
	ld a,(hl)			;6a35
	cp 0ffh		;6a36
	jr z,$+76		;6a38
	cp d			;6a3a
	jr nz,$+45		;6a3b
	ld h,c			;6a3d
	ld l,000h		;6a3e
	ex (sp),hl			;6a40
	push hl			;6a41
	pop af			;6a42
	bit 7,(ix+035h)		;6a43
	jr nz,$+30		;6a47
	set 7,(ix+035h)		;6a49
	bit 1,(ix-001h)		;6a4d
	jr z,$+14		;6a51
	ld l,001h		;6a53
	call 06de8h		;6a55
	bit 6,(ix+035h)		;6a58
	call z,074edh		;6a5c
	ex (sp),hl			;6a5f
	ld l,001h		;6a60
	ex (sp),hl			;6a62
	jr $+5		;6a63
	call 06a6bh		;6a65
	inc bc			;6a68
	jr $-56		;6a69
	bit 6,(ix+035h)		;6a6b
	jr nz,$+9		;6a6f
	ld l,a			;6a71
	call 06d67h		;6a72
	jp 06dedh		;6a75
	jr c,$+9		;6a78
	push af			;6a7a
	ld l,02eh		;6a7b
	call 06de8h		;6a7d
	pop af			;6a80
	jp 06cfdh		;6a81
	pop af			;6a84
	pop bc			;6a85
	bit 7,(ix+035h)		;6a86
	jr z,$+26		;6a8a
	bit 6,(ix+035h)		;6a8c
	jr z,$-37		;6a90
	jr c,$+10		;6a92
	push af			;6a94
	ld l,02fh		;6a95
	call 06de8h		;6a97
	pop af			;6a9a
	scf			;6a9b
	call 06a6bh		;6a9c
	ld l,030h		;6a9f
	jp 06de8h		;6aa1
	bit 1,(ix-001h)		;6aa4
	ret nz			;6aa8
	ld l,035h		;6aa9
	jp 06de8h		;6aab
	ld hl,(08414h)		;6aae
	ld c,a			;6ab1
	ld b,000h		;6ab2
	add hl,bc			;6ab4
	add hl,bc			;6ab5
	ld e,(hl)			;6ab6
	inc hl			;6ab7
	ld d,(hl)			;6ab8
	ex de,hl			;6ab9
	ld a,(hl)			;6aba
	cp 0ffh		;6abb
	ret z			;6abd
	cp (ix+021h)		;6abe
	inc hl			;6ac1
	ld a,(hl)			;6ac2
	scf			;6ac3
	ret z			;6ac4
	inc hl			;6ac5
	jr $-12		;6ac6
	ld hl,(07e55h)		;6ac8
	ld a,l			;6acb
	or h			;6acc
	jr z,$+101		;6acd
	ld d,001h		;6acf
	xor a			;6ad1
	jr $+32		;6ad2
	bit 2,(ix-001h)		;6ad4
	jr z,$+8		;6ad8
	ld hl,(07e53h)		;6ada
	ld a,(hl)			;6add
	cp 00dh		;6ade
	push af			;6ae0
	scf			;6ae1
	call z,070d4h		;6ae2
	jr nc,$+41		;6ae5
	ld (07e53h),hl		;6ae7
	pop af			;6aea
	ld de,00000h		;6aeb
	ld (07e55h),de		;6aee
	ld (ix-002h),d		;6af2
	ld de,0ffffh		;6af5
	ld a,e			;6af8
	jr nz,$+8		;6af9
	ld (07f3dh),a		;6afb
	ld (07f40h),a		;6afe
	ld (07f3eh),de		;6b01
	ld (07f47h),de		;6b05
	ld (07f49h),a		;6b09
	jr $+10		;6b0c
	pop af			;6b0e
	set 7,(ix+031h)		;6b0f
	jr $+31		;6b13
	inc hl			;6b15
	call 06cdbh		;6b16
	cp 022h		;6b19
	jr z,$+23		;6b1b
	call 06ce3h		;6b1d
	jr c,$+25		;6b20
	cp 00dh		;6b22
	jr nz,$-15		;6b24
	bit 2,(ix-001h)		;6b26
	jr z,$+8		;6b2a
	res 2,(ix-001h)		;6b2c
	jr $-92		;6b30
	res 2,(ix-001h)		;6b32
	scf			;6b36
	ret			;6b37
	pop hl			;6b38
	call 06c88h		;6b39
	or a			;6b3c
	jp nz,06bbfh		;6b3d
	call 06ce2h		;6b40
	jr c,$-10		;6b43
	cp 022h		;6b45
	jr nz,$+35		;6b47
	bit 0,(ix-002h)		;6b49
	jr nz,$+29		;6b4d
	ld de,(07e55h)		;6b4f
	ld a,d			;6b53
	or e			;6b54
	jr nz,$-35		;6b55
	inc hl			;6b57
	ld (07e55h),hl		;6b58
	ld a,(hl)			;6b5b
	cp 00dh		;6b5c
	jr z,$-44		;6b5e
	inc hl			;6b60
	cp 022h		;6b61
	jr nz,$-8		;6b63
	call 06cdbh		;6b65
	jr $-40		;6b68
	set 2,(ix-001h)		;6b6a
	bit 0,(ix-002h)		;6b6e
	jr nz,$+7		;6b72
	ld (07e53h),hl		;6b74
	jr $+5		;6b77
	ld (07e55h),hl		;6b79
	ld a,(hl)			;6b7c
	cp 00dh		;6b7d
	jr nz,$+6		;6b7f
	res 2,(ix-001h)		;6b81
	bit 1,(ix-002h)		;6b85
	jr nz,$+17		;6b89
	ld a,(07f3eh)		;6b8b
	cp 0ffh		;6b8e
	jr z,$-94		;6b90
	cp 028h		;6b92
	ret nc			;6b94
	ld (07f3dh),a		;6b95
	or a			;6b98
	ret			;6b99
	bit 5,(ix-002h)		;6b9a
	jr nz,$+7		;6b9e
	ld a,0ffh		;6ba0
	ld (07f40h),a		;6ba2
	ld de,(07f48h)		;6ba5
	call 06bb0h		;6ba9
	ld de,(07f3eh)		;6bac
	ld a,e			;6bb0
	cp 0ffh		;6bb1
	jr z,$+10		;6bb3
	cp 032h		;6bb5
	jr c,$+6		;6bb7
	ld (07f4ah),de		;6bb9
	xor a			;6bbd
	ret			;6bbe
	ld e,a			;6bbf
	ld a,(bc)			;6bc0
	cp 005h		;6bc1
	jr z,$-89		;6bc3
	or a			;6bc5
	jr nz,$+48		;6bc6
	bit 1,(ix-002h)		;6bc8
	jp nz,06b39h		;6bcc
	ld (ix+021h),e		;6bcf
	set 1,(ix-002h)		;6bd2
	push hl			;6bd6
	ld hl,(07e60h)		;6bd7
	dec hl			;6bda
	ld a,(hl)			;6bdb
	cp 053h		;6bdc
	jr nz,$+4		;6bde
	dec hl			;6be0
	ld a,(hl)			;6be1
	cp 041h		;6be2
	jr z,$+6		;6be4
	cp 04fh		;6be6
	jr nz,$+8		;6be8
	dec hl			;6bea
	ld a,(hl)			;6beb
	cp 04ch		;6bec
	ld a,006h		;6bee
	pop hl			;6bf0
	jr z,$+44		;6bf1
	jp 06b39h		;6bf3
	cp 001h		;6bf6
	jr nz,$+19		;6bf8
	bit 5,(ix-002h)		;6bfa
	jp nz,06b39h		;6bfe
	ld (ix+024h),e		;6c01
	set 5,(ix-002h)		;6c04
	jp 06b39h		;6c08
	cp 004h		;6c0b
	jr nz,$+16		;6c0d
	ld a,(07f47h)		;6c0f
	cp 0ffh		;6c12
	jp nz,06b39h		;6c14
	ld (ix+02bh),e		;6c17
	jp 06b39h		;6c1a
	push hl			;6c1d
	ld hl,07f1ah		;6c1e
	bit 2,(hl)		;6c21
	jr nz,$+35		;6c23
	cp 003h		;6c25
	jr z,$+28		;6c27
	cp 002h		;6c29
	jr z,$+18		;6c2b
	ld a,(07f4ah)		;6c2d
	cp 0ffh		;6c30
	jr z,$+17		;6c32
	ld e,a			;6c34
	ld a,(07f4bh)		;6c35
	ld (07f3fh),a		;6c38
	set 6,(hl)		;6c3b
	ld a,e			;6c3d
	ld (07f3eh),a		;6c3e
	set 2,(hl)		;6c41
	jp 06b38h		;6c43
	bit 6,(hl)		;6c46
	jr nz,$+13		;6c48
	set 6,(hl)		;6c4a
	cp 003h		;6c4c
	jr nz,$+7		;6c4e
	ld (ix+023h),e		;6c50
	jr $-16		;6c53
	bit 3,(hl)		;6c55
	jr nz,$+34		;6c57
	cp 003h		;6c59
	jr z,$-24		;6c5b
	cp 002h		;6c5d
	jr z,$+18		;6c5f
	ld a,(07f4ah)		;6c61
	cp 0ffh		;6c64
	jr z,$-35		;6c66
	ld e,a			;6c68
	ld a,(07f4bh)		;6c69
	ld (07f49h),a		;6c6c
	set 7,(hl)		;6c6f
	ld a,e			;6c71
	ld (07f48h),a		;6c72
	set 3,(hl)		;6c75
	jr $-52		;6c77
	bit 7,(hl)		;6c79
	jr nz,$-56		;6c7b
	set 7,(hl)		;6c7d
	cp 003h		;6c7f
	jr nz,$-62		;6c81
	ld (ix+02dh),e		;6c83
	jr $-67		;6c86
	ld a,0dfh		;6c88
	ld de,07e20h		;6c8a
	ld b,005h		;6c8d
	dec de			;6c8f
	ld (de),a			;6c90
	djnz $-2		;6c91
	ld b,005h		;6c93
	call 06ce2h		;6c95
	jr nc,$+15		;6c98
	cpl			;6c9a
	ld (de),a			;6c9b
	inc de			;6c9c
	inc hl			;6c9d
	djnz $-9		;6c9e
	call 06ce2h		;6ca0
	inc hl			;6ca3
	jr c,$-4		;6ca4
	dec hl			;6ca6
	ld (07e60h),hl		;6ca7
	call 06cdbh		;6caa
	ld bc,(08416h)		;6cad
	push hl			;6cb1
	ld hl,07e1bh		;6cb2
	res 5,(ix-001h)		;6cb5
	ld d,005h		;6cb9
	ld a,(bc)			;6cbb
	or a			;6cbc
	jr nz,$+4		;6cbd
	pop hl			;6cbf
	ret			;6cc0
	cp (hl)			;6cc1
	jr z,$+6		;6cc2
	set 5,(ix-001h)		;6cc4
	inc bc			;6cc8
	inc hl			;6cc9
	dec d			;6cca
	jr nz,$-16		;6ccb
	bit 5,(ix-001h)		;6ccd
	jr nz,$+6		;6cd1
	ld a,(bc)			;6cd3
	inc bc			;6cd4
	pop hl			;6cd5
	ret			;6cd6
	inc bc			;6cd7
	inc bc			;6cd8
	jr $-39		;6cd9
	ld a,(hl)			;6cdb
	cp 020h		;6cdc
	ret nz			;6cde
	inc hl			;6cdf
	jr $-5		;6ce0
	ld a,(hl)			;6ce2
	call 06cf6h		;6ce3
	ccf			;6ce6
	ret c			;6ce7
	cp 015h		;6ce8
	ccf			;6cea
	ret nc			;6ceb
	cp 020h		;6cec
	ret c			;6cee
	cp 041h		;6cef
	ccf			;6cf1
	ret nc			;6cf2
	cp 05bh		;6cf3
	ret			;6cf5
	cp 030h		;6cf6
	ret c			;6cf8
	cp 03ah		;6cf9
	ccf			;6cfb
	ret			;6cfc
	push hl			;6cfd
	ld hl,08403h		;6cfe
	cp (hl)			;6d01
	jr nc,$+90		;6d02
	call 06d66h		;6d04
	call 06d4eh		;6d07
	jr z,$-3		;6d0a
	bit 4,(ix-003h)		;6d0c
	jr nz,$+6		;6d10
	and 0dfh		;6d12
	jr $+49		;6d14
	cp 0aah		;6d16
	jr z,$+6		;6d18
	cp 08ah		;6d1a
	jr nz,$+41		;6d1c
	call 06d4eh		;6d1e
	call 06d4eh		;6d21
	jr nz,$+26		;6d24
	push af			;6d26
	ld a,065h		;6d27
	call 06d33h		;6d29
	ld a,06ch		;6d2c
	call 074efh		;6d2e
	jr $+19		;6d31
	bit 5,(ix-003h)		;6d33
	jr nz,$+4		;6d37
	and 0dfh		;6d39
	jp 074efh		;6d3b
	push af			;6d3e
	ld a,06ch		;6d3f
	call 06d33h		;6d41
	pop af			;6d44
	cpl			;6d45
	call 074efh		;6d46
	call 06d4eh		;6d49
	jr $-7		;6d4c
	ld a,(hl)			;6d4e
	cp 0f5h		;6d4f
	jr z,$+10		;6d51
	cp 0d1h		;6d53
	jr z,$+6		;6d55
	inc hl			;6d57
	cp 0dfh		;6d58
	ret			;6d5a
	pop hl			;6d5b
	pop hl			;6d5c
	ret			;6d5d
	ld l,a			;6d5e
	push de			;6d5f
	ld de,(0840ah)		;6d60
	jr $+15		;6d64
	ld l,a			;6d66
	push de			;6d67
	ld de,(0840ch)		;6d68
	jr $+7		;6d6c
	push de			;6d6e
	ld de,(08412h)		;6d6f
	ld h,000h		;6d73
	add hl,hl			;6d75
	add hl,de			;6d76
	ld e,(hl)			;6d77
	inc hl			;6d78
	ld d,(hl)			;6d79
	ex de,hl			;6d7a
	pop de			;6d7b
	ret			;6d7c
	push af			;6d7d
	push bc			;6d7e
	ld bc,00865h		;6d7f
	ld hl,00000h		;6d82
	ld de,(05c76h)		;6d85
	inc e			;6d89
	ld d,h			;6d8a
	srl c		;6d8b
	jr nc,$+3		;6d8d
	add hl,de			;6d8f
	sla e		;6d90
	rl d		;6d92
	djnz $-9		;6d94
	ld (05c76h),hl		;6d96
	ld a,h			;6d99
	or a			;6d9a
	jr z,$-28		;6d9b
	pop bc			;6d9d
	pop af			;6d9e
	ret			;6d9f
	ld d,000h		;6da0
	push hl			;6da2
	push de			;6da3
	res 1,(ix-003h)		;6da4
	ex de,hl			;6da8
	ld de,02710h		;6da9
	call 06dcah		;6dac
	ld de,003e8h		;6daf
	call 06dcah		;6db2
	ld de,00064h		;6db5
	call 06dcah		;6db8
	ld de,0000ah		;6dbb
	call 06dcah		;6dbe
	ld a,l			;6dc1
	add a,030h		;6dc2
	call 074efh		;6dc4
	pop de			;6dc7
	pop hl			;6dc8
	ret			;6dc9
	xor a			;6dca
	inc a			;6dcb
	or a			;6dcc
	sbc hl,de		;6dcd
	jr nc,$-4		;6dcf
	add hl,de			;6dd1
	dec a			;6dd2
	jr nz,$+7		;6dd3
	bit 1,(ix-003h)		;6dd5
	ret z			;6dd9
	set 1,(ix-003h)		;6dda
	add a,030h		;6dde
	jp 074efh		;6de0
	call 06d6eh		;6de3
	jr $+7		;6de6
	call 06d6eh		;6de8
	jr $+6		;6deb
	set 6,(ix-001h)		;6ded
	ld a,(hl)			;6df1
	cpl			;6df2
	cp 00ah		;6df3
	jr z,$+37		;6df5
	set 5,(ix-003h)		;6df7
	cp (ix-006h)		;6dfb
	jr z,$+10		;6dfe
	cp 040h		;6e00
	jr nz,$+18		;6e02
	res 5,(ix-003h)		;6e04
	set 4,(ix-003h)		;6e08
	ld a,(07f4fh)		;6e0c
	call 06cfdh		;6e0f
	jr $+5		;6e12
	call 074efh		;6e14
	inc hl			;6e17
	jr $-39		;6e18
	bit 6,(ix-001h)		;6e1a
	ret z			;6e1e
	res 6,(ix-001h)		;6e1f
	jp 074edh		;6e23
	ex (sp),hl			;6e26
	ld (06e35h),de		;6e27
	ld e,(hl)			;6e2b
	inc hl			;6e2c
	ld d,(hl)			;6e2d
	inc hl			;6e2e
	ex de,hl			;6e2f
	add hl,de			;6e30
	ex de,hl			;6e31
	ex (sp),hl			;6e32
	push de			;6e33
	ld de,00000h		;6e34
	ret			;6e37
	and 007h		;6e38
	ld e,a			;6e3a
	ld a,(07f12h)		;6e3b
	and 0f8h		;6e3e
	or e			;6e40
	ld (07f12h),a		;6e41
	jp 06456h		;6e44
	ld hl,0fffdh		;6e47
	cp (hl)			;6e4a
	jr nc,$+14		;6e4b
	ld (07e4fh),a		;6e4d
	ld e,a			;6e50
	call 079d4h		;6e51
	bit 7,(hl)		;6e54
	jp nz,06214h		;6e56
	jp 061c1h		;6e59
	res 7,(ix-004h)		;6e5c
	or a			;6e60
	jr z,$+6		;6e61
	set 7,(ix-004h)		;6e63
	push bc			;6e67
	call 07637h		;6e68
	ld hl,(05c88h)		;6e6b
	push hl			;6e6e
	ld a,(07f12h)		;6e6f
	push af			;6e72
	res 6,(ix-00ah)		;6e73
	ld a,(07e4fh)		;6e77
	ld e,a			;6e7a
	call 07918h		;6e7b
	pop af			;6e7e
	ld (07f12h),a		;6e7f
	pop bc			;6e82
	call 00dd9h		;6e83
	pop bc			;6e86
	jp 06456h		;6e87
	push bc			;6e8a
	call 07637h		;6e8b
	res 5,(ix-00ah)		;6e8e
	res 7,(ix-00ah)		;6e92
	ld hl,(07f10h)		;6e96
	ld (07f05h),hl		;6e99
	jr $+21		;6e9c
	push bc			;6e9e
	call 07637h		;6e9f
	res 5,(ix-00ah)		;6ea2
	res 7,(ix-00ah)		;6ea6
	ld de,(07f05h)		;6eaa
	call 07496h		;6eae
	pop bc			;6eb1
	jp 06457h		;6eb2
	push bc			;6eb5
	push af			;6eb6
	call 07637h		;6eb7
	ld a,(07f11h)		;6eba
	ld d,a			;6ebd
	pop af			;6ebe
	ld e,a			;6ebf
	jr $+17		;6ec0
	ld d,a			;6ec2
	inc bc			;6ec3
	ld a,(bc)			;6ec4
	ld e,a			;6ec5
	push bc			;6ec6
	push de			;6ec7
	call 07637h		;6ec8
	pop de			;6ecb
	ld a,(07f0eh)		;6ecc
	add a,d			;6ecf
	ld d,a			;6ed0
	ld a,(07f0fh)		;6ed1
	add a,e			;6ed4
	ld e,a			;6ed5
	call 07496h		;6ed6
	res 5,(ix-00ah)		;6ed9
	res 7,(ix-00ah)		;6edd
	pop bc			;6ee1
	jp 06456h		;6ee2
	push bc			;6ee5
	call 07432h		;6ee6
	pop bc			;6ee9
	jp 06456h		;6eea
	dec bc			;6eed
	push bc			;6eee
	call 07637h		;6eef
	ld a,(07f0ch)		;6ef2
	srl a		;6ef5
	ld h,a			;6ef7
	ld a,015h		;6ef8
	sub h			;6efa
	jr $+25		;6efb
	push af			;6efd
	push bc			;6efe
	call 07637h		;6eff
	pop bc			;6f02
	pop af			;6f03
	cp 018h		;6f04
	jr c,$+3		;6f06
	xor a			;6f08
	ld (07f0eh),a		;6f09
	inc bc			;6f0c
	push bc			;6f0d
	ld a,(bc)			;6f0e
	cp 02ah		;6f0f
	jr c,$+3		;6f11
	xor a			;6f13
	ld (07f0fh),a		;6f14
	jr $+19		;6f17
	push af			;6f19
	push bc			;6f1a
	call 07637h		;6f1b
	pop bc			;6f1e
	pop af			;6f1f
	dec a			;6f20
	ld (07f0dh),a		;6f21
	inc bc			;6f24
	push bc			;6f25
	ld a,(bc)			;6f26
	ld (07f0ch),a		;6f27
	call 074c9h		;6f2a
	call 0747dh		;6f2d
	pop bc			;6f30
	jp 06456h		;6f31
	inc bc			;6f34
	push bc			;6f35
	push af			;6f36
	ld a,(bc)			;6f37
	call 02d28h		;6f38
	ld a,064h		;6f3b
	call 02d28h		;6f3d
	rst 28h			;6f40
	dec b			;6f41
	jr c,$+64		;6f42
	inc a			;6f44
	call 02d28h		;6f45
	pop af			;6f48
	call 02d28h		;6f49
	rst 28h			;6f4c
	and d			;6f4d
	inc b			;6f4e
	ld bc,03803h		;6f4f
	push ix		;6f52
	call 003f8h		;6f54
	pop ix		;6f57
	pop bc			;6f59
	jp 06456h		;6f5a
	call 070c4h		;6f5d
	rlca			;6f60
	rlca			;6f61
	rlca			;6f62
	and 078h		;6f63
	ld e,087h		;6f65
	jr $+11		;6f67
	call 070c4h		;6f69
	add a,078h		;6f6c
	and 087h		;6f6e
	ld e,078h		;6f70
	ld d,a			;6f72
	ld a,(07f07h)		;6f73
	and e			;6f76
	or d			;6f77
	ld (07f07h),a		;6f78
	ld (05c8fh),a		;6f7b
	jp 06456h		;6f7e
	call 070c4h		;6f81
	and 007h		;6f84
	call 0229bh		;6f86
	jp 06456h		;6f89
	bit 5,(iy+001h)		;6f8c
	jp z,061c1h		;6f90
	call 073d5h		;6f93
	ld (07f58h),a		;6f96
	ld a,(07f0dh)		;6f99
	call 07415h		;6f9c
	jp 06215h		;6f9f
	set 0,(ix-003h)		;6fa2
	push bc			;6fa6
	call 06fe6h		;6fa7
	ex de,hl			;6faa
	ld hl,07f1ch		;6fab
	ld bc,00200h		;6fae
	jr $+40		;6fb1
	bit 0,(ix-003h)		;6fb3
	jr nz,$+9		;6fb7
	res 2,(ix-001h)		;6fb9
	jp 061c1h		;6fbd
	inc bc			;6fc0
	push bc			;6fc1
	push af			;6fc2
	call 06fe6h		;6fc3
	pop af			;6fc6
	ld de,07f1ch		;6fc7
	ld c,a			;6fca
	ld b,000h		;6fcb
	inc bc			;6fcd
	push hl			;6fce
	ldir		;6fcf
	pop hl			;6fd1
	inc h			;6fd2
	ld de,0801ch		;6fd3
	ld bc,00100h		;6fd6
	ldir		;6fd9
	bit 7,(ix-001h)		;6fdb
	call nz,079dfh		;6fdf
	pop bc			;6fe2
	jp 06457h		;6fe3
	ld hl,08200h		;6fe6
	bit 7,(ix-001h)		;6fe9
	ret z			;6fed
	ld a,001h		;6fee
	call 079e0h		;6ff0
	ld hl,0c000h		;6ff3
	ret			;6ff6
	push bc			;6ff7
	ld hl,07025h		;6ff8
	ld (07e20h),hl		;6ffb
	push ix		;6ffe
	ld hl,(05c3dh)		;7000
	push hl			;7003
	ld hl,06042h		;7004
	push hl			;7007
	ld (05c3dh),sp		;7008
	xor a			;700c
	call 07056h		;700d
	ld l,03dh		;7010
	call 06de8h		;7012
	call 073d5h		;7015
	call 0707fh		;7018
	push hl			;701b
	ld hl,07024h		;701c
	ex (sp),hl			;701f
	push hl			;7020
	jp 00984h		;7021
	pop hl			;7024
	pop hl			;7025
	ld (05c3dh),hl		;7026
	pop ix		;7029
	call 070afh		;702b
	xor a			;702e
	ld (07e21h),a		;702f
	pop bc			;7032
	jp 06456h		;7033
	push bc			;7036
	ld a,001h		;7037
	call 07056h		;7039
	call 07092h		;703c
	push ix		;703f
	push de			;7041
	call 0707fh		;7042
	call 00761h		;7045
	pop de			;7048
	pop ix		;7049
	call 070a5h		;704b
	res 2,(ix-001h)		;704e
	pop bc			;7052
	jp 06456h		;7053
	ld (iy+03ah),a		;7056
	ld l,03ch		;7059
	call 070feh		;705b
	ld de,070b5h		;705e
	ld bc,0000ah		;7061
	ld a,(hl)			;7064
	cp 00dh		;7065
	jr z,$+12		;7067
	cp 020h		;7069
	jr z,$+8		;706b
	ldi		;706d
	jp pe,07064h		;706f
	ret			;7072
	ex de,hl			;7073
	ld (hl),020h		;7074
	inc hl			;7076
	dec c			;7077
	jr nz,$-4		;7078
	res 6,(ix-00ah)		;707a
	ret			;707e
	ld bc,00022h		;707f
	rst 30h			;7082
	push de			;7083
	pop ix		;7084
	ld hl,070b4h		;7086
	ld bc,00011h		;7089
	ldir		;708c
	ld hl,07f1ch		;708e
	ret			;7091
	set 6,(ix-004h)		;7092
	call 07913h		;7096
	ld hl,(05c51h)		;7099
	ld bc,074efh		;709c
	ld e,(hl)			;709f
	ld (hl),c			;70a0
	inc hl			;70a1
	ld d,(hl)			;70a2
	ld (hl),b			;70a3
	ret			;70a4
	ld hl,(05c51h)		;70a5
	ld (hl),e			;70a8
	inc hl			;70a9
	ld (hl),d			;70aa
	res 6,(ix-004h)		;70ab
	set 6,(ix-00ah)		;70af
	ret			;70b3
	inc bc			;70b4
	ld d,h			;70b5
	ld b,a			;70b6
	ld b,h			;70b7
	ld b,c			;70b8
	ld b,c			;70b9
	ld b,h			;70ba
	ld d,(hl)			;70bb
	ld (0302eh),a		;70bc
	nop			;70bf
	ld (bc),a			;70c0
	inc e			;70c1
	ld a,a			;70c2
	nop			;70c3
	push af			;70c4
	and 007h		;70c5
	ld e,a			;70c7
	ld d,000h		;70c8
	ld hl,(0fff9h)		;70ca
	inc hl			;70cd
	add hl,de			;70ce
	pop af			;70cf
	and 008h		;70d0
	or (hl)			;70d2
	ret			;70d3
	res 4,(ix-002h)		;70d4
	ld a,(07f46h)		;70d8
	or a			;70db
	jr z,$+11		;70dc
	ld l,a			;70de
	ld a,(08406h)		;70df
	cp l			;70e2
	jr z,$+4		;70e3
	jr nc,$+37		;70e5
	call 06d7dh		;70e7
	ld a,h			;70ea
	ld l,002h		;70eb
	cp 01eh		;70ed
	jr c,$+27		;70ef
	inc l			;70f1
	cp 03ch		;70f2
	jr c,$+22		;70f4
	inc l			;70f6
	cp 05ah		;70f7
	jr c,$+17		;70f9
	inc l			;70fb
	jr $+14		;70fc
	res 2,(ix-001h)		;70fe
	set 4,(ix-002h)		;7102
	ld (ix-007h),00ch		;7106
	push hl			;710a
	ld a,(07f02h)		;710b
	ld (07e52h),a		;710e
	ld a,(07f45h)		;7111
	and 007h		;7114
	call nz,07432h		;7116
	pop hl			;7119
	call 06de8h		;711a
	call 07637h		;711d
	res 6,(ix-00ah)		;7120
	ld (iy+007h),000h		;7124
	set 3,(iy+001h)		;7128
	res 3,(iy+030h)		;712c
	res 3,(ix-003h)		;7130
	ld a,080h		;7134
	ld (07f0ah),a		;7136
	ld l,021h		;7139
	call 06de8h		;713b
	call 0738fh		;713e
	call 077ach		;7141
	ld a,(07f10h)		;7144
	ld (07e51h),a		;7147
	bit 4,(ix-002h)		;714a
	jr nz,$+25		;714e
	ld a,(07f4dh)		;7150
	rlca			;7153
	jr nc,$+19		;7154
	rlca			;7156
	jr nc,$+16		;7157
	rlca			;7159
	jr nc,$+13		;715a
	ld hl,0811ch		;715c
	call 0734bh		;715f
	call 0735ah		;7162
	jr $+23		;7165
	xor a			;7167
	ld (07e1ah),a		;7168
	ld hl,0811ch		;716b
	ld a,00dh		;716e
	ld (hl),a			;7170
	ld (07e18h),hl		;7171
	jr $+8		;7174
	bit 0,(ix+031h)		;7176
	jr nz,$+36		;717a
	bit 4,(ix-002h)		;717c
	jr nz,$+30		;7180
	ld a,(07f4ch)		;7182
	or a			;7185
	jr z,$+24		;7186
	call 073e1h		;7188
	jr c,$+22		;718b
	ld hl,(07e18h)		;718d
	call 0734bh		;7190
	call 07370h		;7193
	ld a,(07f4dh)		;7196
	or 0c0h		;7199
	jp 07282h		;719b
	call 073d5h		;719e
	push af			;71a1
	push hl			;71a2
	ld de,00003h		;71a3
	ld hl,000c8h		;71a6
	push ix		;71a9
	call 003b5h		;71ab
	pop ix		;71ae
	pop hl			;71b0
	pop af			;71b1
	cp 00ch		;71b2
	jp z,0730ch		;71b4
	cp 008h		;71b7
	jp z,072e2h		;71b9
	cp 009h		;71bc
	jp z,072fbh		;71be
	cp 00eh		;71c1
	jr nz,$+9		;71c3
	set 3,(ix-003h)		;71c5
	jp 07176h		;71c9
	cp 00dh		;71cc
	jr nz,$+37		;71ce
	ld a,(07e1ah)		;71d0
	or a			;71d3
	jp nz,07270h		;71d4
	jp 07176h		;71d7
	dec d			;71da
	nop			;71db
	nop			;71dc
	dec de			;71dd
	ld d,000h		;71de
	nop			;71e0
	nop			;71e1
	rla			;71e2
	nop			;71e3
	nop			;71e4
	nop			;71e5
	inc e			;71e6
	dec de			;71e7
	jr $+2		;71e8
	nop			;71ea
	nop			;71eb
	ld a,(de)			;71ec
	nop			;71ed
	add hl,de			;71ee
	ld e,000h		;71ef
	nop			;71f1
	ld de,0cbddh		;71f2
	ld e,(iy-023h)		;71f5
	set 7,l		;71f8
	sbc a,(hl)			;71fa
	jr z,$+41		;71fb
	cp 021h		;71fd
	ld e,011h		;71ff
	jr z,$+36		;7201
	inc e			;7203
	cp 03fh		;7204
	jr z,$+31		;7206
	and 0dfh		;7208
	cp 041h		;720a
	jp c,07176h		;720c
	cp 05ah		;720f
	jp nc,07176h		;7211
	sub 041h		;7214
	ld e,a			;7216
	ld d,000h		;7217
	push hl			;7219
	ld hl,071dah		;721a
	add hl,de			;721d
	ld a,(hl)			;721e
	pop hl			;721f
	or a			;7220
	jp z,07176h		;7221
	ld e,a			;7224
	ld a,(07e1ah)		;7225
	cp (ix-007h)		;7228
	jp z,07176h		;722b
	ld a,e			;722e
	cp 011h		;722f
	jp c,07176h		;7231
	cp 05bh		;7234
	jr c,$+12		;7236
	cp 061h		;7238
	jp c,07176h		;723a
	cp 07bh		;723d
	jp nc,07176h		;723f
	ld hl,(07e18h)		;7242
	push hl			;7245
	ld a,00dh		;7246
	ld b,0ffh		;7248
	cpir		;724a
	pop bc			;724c
	ld a,e			;724d
	push hl			;724e
	pop de			;724f
	or a			;7250
	sbc hl,bc		;7251
	push hl			;7253
	pop bc			;7254
	push de			;7255
	pop hl			;7256
	dec hl			;7257
	lddr		;7258
	ld hl,07e1ah		;725a
	inc (hl)			;725d
	ld hl,(07e18h)		;725e
	ld (hl),a			;7261
	inc hl			;7262
	ld (07e18h),hl		;7263
	dec hl			;7266
	call 0734bh		;7267
	call 0735ah		;726a
	jp 07176h		;726d
	ld hl,(07e18h)		;7270
	call 0734bh		;7273
	call 07370h		;7276
	call 074edh		;7279
	ld a,(07f4dh)		;727c
	and 03fh		;727f
	scf			;7281
	ld (07f4dh),a		;7282
	push af			;7285
	call 077bch		;7286
	bit 3,(ix+031h)		;7289
	call nz,0746dh		;728d
	set 6,(ix-00ah)		;7290
	ld a,(07e52h)		;7294
	call 07432h		;7297
	pop af			;729a
	push af			;729b
	jr nc,$+61		;729c
	bit 4,(ix+031h)		;729e
	ld l,021h		;72a2
	call nz,06de8h		;72a4
	ld hl,0811ch		;72a7
	ld a,(hl)			;72aa
	cp 00dh		;72ab
	jr z,$+37		;72ad
	push af			;72af
	bit 4,(ix+031h)		;72b0
	call nz,074efh		;72b4
	pop af			;72b7
	cp 01ah		;72b8
	jr c,$+10		;72ba
	cp 020h		;72bc
	jr nc,$+6		;72be
	or 001h		;72c0
	jr $+12		;72c2
	cp 061h		;72c4
	jr c,$+9		;72c6
	cp 07bh		;72c8
	jr nc,$+5		;72ca
	and 0dfh		;72cc
	ld (hl),a			;72ce
	inc hl			;72cf
	jr $-38		;72d0
	bit 4,(ix+031h)		;72d2
	call nz,074edh		;72d6
	pop af			;72d9
	ld (ix-007h),078h		;72da
	ld hl,0811ch		;72de
	ret			;72e1
	ld de,(07e18h)		;72e2
	ld hl,0811ch		;72e6
	or a			;72e9
	sbc hl,de		;72ea
	jr z,$+12		;72ec
	dec de			;72ee
	ld (07e18h),de		;72ef
	ld a,008h		;72f3
	call 07685h		;72f5
	jp 07176h		;72f8
	ld hl,(07e18h)		;72fb
	ld a,(hl)			;72fe
	cp 00dh		;72ff
	jr z,$-9		;7301
	inc hl			;7303
	ld (07e18h),hl		;7304
	call 07685h		;7307
	jr $-18		;730a
	ld de,(07e18h)		;730c
	ld hl,0811ch		;7310
	or a			;7313
	sbc hl,de		;7314
	jr z,$-30		;7316
	push de			;7318
	pop hl			;7319
	ld a,00dh		;731a
	ld b,0ffh		;731c
	cpir		;731e
	or a			;7320
	sbc hl,de		;7321
	push hl			;7323
	pop bc			;7324
	push de			;7325
	pop hl			;7326
	dec de			;7327
	ldir		;7328
	ld a,008h		;732a
	call 07685h		;732c
	ld hl,07e1ah		;732f
	dec (hl)			;7332
	ld hl,(07e18h)		;7333
	dec hl			;7336
	ld (07e18h),hl		;7337
	call 0734bh		;733a
	push hl			;733d
	ld a,020h		;733e
	call 07685h		;7340
	pop hl			;7343
	inc hl			;7344
	call 0735ah		;7345
	jp 07176h		;7348
	call 077bch		;734b
	ld a,(hl)			;734e
	cp 00dh		;734f
	jp z,077ach		;7351
	call 07685h		;7354
	inc hl			;7357
	jr $-10		;7358
	ld de,(07e18h)		;735a
	xor a			;735e
	sbc hl,de		;735f
	ret z			;7361
	call 077bch		;7362
	ld b,l			;7365
	ld a,008h		;7366
	call 07685h		;7368
	djnz $-5		;736b
	jp 077ach		;736d
	ld de,0811ch		;7370
	or a			;7373
	sbc hl,de		;7374
	ld a,(07e51h)		;7376
	add a,l			;7379
	sub (ix-00dh)		;737a
	ld l,(ix-00fh)		;737d
	sub (ix-010h)		;7380
	jr c,$+8		;7383
	dec l			;7385
	jr nz,$-6		;7386
	ld l,(ix-00fh)		;7388
	ld a,l			;738b
	jp 07415h		;738c
	ld de,(07f0ch)		;738f
	ld d,000h		;7393
	ld h,d			;7395
	ld l,d			;7396
	ld bc,(07f0ch)		;7397
	inc b			;739b
	add hl,de			;739c
	djnz $-1		;739d
	ld a,(07f0fh)		;739f
	inc a			;73a2
	sub (ix-00dh)		;73a3
	ld e,a			;73a6
	or a			;73a7
	sbc hl,de		;73a8
	ld e,(ix-007h)		;73aa
	push hl			;73ad
	or a			;73ae
	sbc hl,de		;73af
	pop hl			;73b1
	ret nc			;73b2
	ld (ix-007h),l		;73b3
	ret			;73b6
	call 07637h		;73b7
	ld l,010h		;73ba
	call 06de8h		;73bc
	call 07637h		;73bf
	ld a,(07f0dh)		;73c2
	inc a			;73c5
	call 07415h		;73c6
	bit 2,(ix+031h)		;73c9
	jr z,$+8		;73cd
	ld a,(07f4ch)		;73cf
	or a			;73d2
	jr nz,$+14		;73d3
	push de			;73d5
	bit 5,(iy+001h)		;73d6
	jr z,$-4		;73da
	jr $+48		;73dc
	push de			;73de
	jr $+16		;73df
	push de			;73e1
	ld d,(ix+030h)		;73e2
	ld e,000h		;73e5
	srl d		;73e7
	rr e		;73e9
	srl d		;73eb
	rr e		;73ed
	xor a			;73ef
	ld (05c78h),a		;73f0
	ld (05c79h),a		;73f3
	ld (05c7ah),a		;73f6
	scf			;73f9
	bit 5,(iy+001h)		;73fa
	jr nz,$+14		;73fe
	push hl			;7400
	ld hl,(05c78h)		;7401
	and a			;7404
	sbc hl,de		;7405
	pop hl			;7407
	jr c,$-14		;7408
	jr $+9		;740a
	ld a,(05c08h)		;740c
	res 5,(iy+001h)		;740f
	pop de			;7413
	ret			;7414
	ld (07f0ah),a		;7415
	push ix		;7418
	push bc			;741a
	ld ix,07e72h		;741b
	ld de,00010h		;741f
	ld b,008h		;7422
	ld a,(ix+00ah)		;7424
	ld (ix+007h),a		;7427
	add ix,de		;742a
	djnz $-8		;742c
	pop bc			;742e
	pop ix		;742f
	ret			;7431
	cp (ix-01ah)		;7432
	ret z			;7435
	push af			;7436
	call 07637h		;7437
	ld a,(07f02h)		;743a
	call 07461h		;743d
	ex de,hl			;7440
	ld hl,07f03h		;7441
	ld bc,00010h		;7444
	ldir		;7447
	pop af			;7449
	push af			;744a
	ld (07f02h),a		;744b
	call 07461h		;744e
	ld de,07f03h		;7451
	ld bc,00010h		;7454
	ldir		;7457
	ld a,(07f07h)		;7459
	ld (05c8fh),a		;745c
	pop af			;745f
	ret			;7460
	ld hl,07e72h		;7461
	rlca			;7464
	rlca			;7465
	rlca			;7466
	rlca			;7467
	ld e,a			;7468
	ld d,000h		;7469
	add hl,de			;746b
	ret			;746c
	push bc			;746d
	push hl			;746e
	push de			;746f
	call 07676h		;7470
	call 0747dh		;7473
	call 07817h		;7476
	pop de			;7479
	pop hl			;747a
	pop bc			;747b
	ret			;747c
	ld a,(07f0eh)		;747d
	ld (07f11h),a		;7480
	call 00e9eh		;7483
	ld (07f08h),hl		;7486
	ld a,(07f0fh)		;7489
	ld (07f10h),a		;748c
	ld a,(07f0dh)		;748f
	ld (07f0ah),a		;7492
	ret			;7495
	ld a,d			;7496
	cp (ix-00eh)		;7497
	jr c,$+27		;749a
	ld a,(07f0eh)		;749c
	add a,(ix-00fh)		;749f
	cp d			;74a2
	jr c,$+18		;74a3
	ld a,e			;74a5
	cp (ix-00dh)		;74a6
	jr c,$+12		;74a9
	ld a,(07f0fh)		;74ab
	add a,(ix-010h)		;74ae
	dec a			;74b1
	cp e			;74b2
	jr nc,$+8		;74b3
	ld e,(ix-00dh)		;74b5
	ld d,(ix-00eh)		;74b8
	ld (ix-00ch),e		;74bb
	ld a,d			;74be
	ld (07f11h),a		;74bf
	call 00e9eh		;74c2
	ld (07f08h),hl		;74c5
	ret			;74c8
	ld a,(07f0eh)		;74c9
	add a,(ix-00fh)		;74cc
	cp 018h		;74cf
	jr c,$+10		;74d1
	ld a,017h		;74d3
	sub (ix-00eh)		;74d5
	ld (07f0dh),a		;74d8
	ld a,(07f0fh)		;74db
	add a,(ix-010h)		;74de
	cp 02bh		;74e1
	ret c			;74e3
	ld a,02ah		;74e4
	sub (ix-00dh)		;74e6
	ld (07f0ch),a		;74e9
	ret			;74ec
	ld a,00dh		;74ed
	push ix		;74ef
	ld ix,07f1ch		;74f1
	cp 080h		;74f5
	jr c,$+37		;74f7
	bit 2,(ix-003h)		;74f9
	jr z,$+31		;74fd
	push hl			;74ff
	ld hl,(08408h)		;7500
	sub 07fh		;7503
	bit 7,(hl)		;7505
	inc hl			;7507
	jr z,$-3		;7508
	dec a			;750a
	jr nz,$-6		;750b
	ld a,(hl)			;750d
	add a,080h		;750e
	jr c,$+13		;7510
	add a,080h		;7512
	call 0751ah		;7514
	inc hl			;7517
	jr $-11		;7518
	push ix		;751a
	push hl			;751c
	push de			;751d
	push bc			;751e
	cp 00dh		;751f
	jr z,$+76		;7521
	cp 010h		;7523
	jr c,$+92		;7525
	bit 0,(ix-00ah)		;7527
	jr z,$+4		;752b
	or 080h		;752d
	bit 6,(ix-00ah)		;752f
	jr z,$+53		;7533
	cp 020h		;7535
	jr z,$+34		;7537
	cp 0a0h		;7539
	jr z,$+30		;753b
	push af			;753d
	ld a,(07e24h)		;753e
	cp 028h		;7541
	call z,07637h		;7543
	pop af			;7546
	res 5,(ix-00ah)		;7547
	ld hl,(07e4dh)		;754b
	ld (hl),a			;754e
	inc hl			;754f
	ld (07e4dh),hl		;7550
	ld hl,07e24h		;7553
	inc (hl)			;7556
	jr $+36		;7557
	bit 5,(ix-00ah)		;7559
	jr nz,$+30		;755d
	push af			;755f
	call 07637h		;7560
	pop af			;7563
	bit 5,(ix-00ah)		;7564
	call z,0760fh		;7568
	jr $+16		;756b
	call 07637h		;756d
	bit 7,(ix-00ah)		;7570
	res 7,(ix-00ah)		;7574
	call z,075afh		;7578
	pop bc			;757b
	pop de			;757c
	pop hl			;757d
	pop ix		;757e
	ret			;7580
	cp 00fh		;7581
	jr nz,$+8		;7583
	res 0,(ix-00ah)		;7585
	jr $-14		;7589
	cp 00eh		;758b
	jr nz,$+8		;758d
	set 0,(ix-00ah)		;758f
	jr $-24		;7593
	push af			;7595
	call 07637h		;7596
	pop af			;7599
	cp 00bh		;759a
	jr nz,$+7		;759c
	call 0746dh		;759e
	jr $-38		;75a1
	cp 00ch		;75a3
	jr nz,$-42		;75a5
	ld a,(07f0dh)		;75a7
	call 073c6h		;75aa
	jr $-50		;75ad
	ld a,00dh		;75af
	call 07685h		;75b1
	ld hl,07f0ah		;75b4
	dec (hl)			;75b7
	ret nz			;75b8
	ld a,(07f0dh)		;75b9
	ld (hl),a			;75bc
	bit 1,(ix-00ah)		;75bd
	ret nz			;75c1
	call 07415h		;75c2
	ld l,020h		;75c5
	call 06d6eh		;75c7
	ld a,(07f12h)		;75ca
	push af			;75cd
	ld a,002h		;75ce
	ld (07f12h),a		;75d0
	ld a,(hl)			;75d3
	cpl			;75d4
	cp 00ah		;75d5
	jr z,$+8		;75d7
	inc hl			;75d9
	call 074efh		;75da
	jr $-10		;75dd
	pop af			;75df
	ld (07f12h),a		;75e0
	bit 1,(ix+031h)		;75e3
	jr z,$+13		;75e7
	ld a,(07f4ch)		;75e9
	or a			;75ec
	jr z,$+7		;75ed
	call 073e1h		;75ef
	jr $+5		;75f2
	call 073d5h		;75f4
	ld a,(07f10h)		;75f7
	cp (ix-00dh)		;75fa
	ret z			;75fd
	ld a,008h		;75fe
	call 07685h		;7600
	ld a,020h		;7603
	call 07685h		;7605
	ld a,008h		;7608
	call 07685h		;760a
	jr $-22		;760d
	ld e,a			;760f
	push de			;7610
	call 07685h		;7611
	pop de			;7614
	res 7,(ix-00ah)		;7615
	ld a,(07f10h)		;7619
	cp (ix-00dh)		;761c
	ret nz			;761f
	ld a,e			;7620
	cp 020h		;7621
	jr nz,$+12		;7623
	bit 6,(ix-00ah)		;7625
	jr z,$+6		;7629
	set 5,(ix-00ah)		;762b
	call 075b4h		;762f
	set 7,(ix-00ah)		;7632
	ret			;7636
	bit 6,(ix-00ah)		;7637
	ret z			;763b
	ld a,(07e24h)		;763c
	or a			;763f
	ret z			;7640
	ld a,(07f0fh)		;7641
	add a,(ix-010h)		;7644
	ld hl,07f10h		;7647
	sub (hl)			;764a
	ld hl,07e24h		;764b
	cp (hl)			;764e
	jr z,$+15		;764f
	jr nc,$+17		;7651
	ld a,(07f10h)		;7653
	cp (ix-00dh)		;7656
	call nz,075afh		;7659
	jr $+6		;765c
	set 5,(ix-00ah)		;765e
	ld bc,(07e23h)		;7662
	ld hl,07e25h		;7666
	ld a,(hl)			;7669
	push hl			;766a
	push bc			;766b
	call 0760fh		;766c
	pop bc			;766f
	pop hl			;7670
	inc hl			;7671
	djnz $-9		;7672
	jr $+6		;7674
	res 5,(ix-00ah)		;7676
	ld hl,07e25h		;767a
	ld (07e4dh),hl		;767d
	xor a			;7680
	ld (07e24h),a		;7681
	ret			;7684
	push hl			;7685
	push de			;7686
	push bc			;7687
	push af			;7688
	call 076a2h		;7689
	pop af			;768c
	cp 008h		;768d
	call z,076b4h		;768f
	cp 00dh		;7692
	call z,076dfh		;7694
	or a			;7697
	call nz,07710h		;7698
	call 076a2h		;769b
	pop bc			;769e
	pop de			;769f
	pop hl			;76a0
	ret			;76a1
	bit 3,(ix-00ah)		;76a2
	ret z			;76a6
	set 4,(ix-00ah)		;76a7
	ld a,05fh		;76ab
	call 07710h		;76ad
	res 4,(ix-00ah)		;76b0
	ld hl,07f10h		;76b4
	ld a,(07f0fh)		;76b7
	cp (hl)			;76ba
	jr z,$+5		;76bb
	dec (hl)			;76bd
	jr $+31		;76be
	ld hl,07f0eh		;76c0
	ld a,(07f11h)		;76c3
	cp (hl)			;76c6
	jr z,$+22		;76c7
	dec a			;76c9
	ld (07f11h),a		;76ca
	call 00e9eh		;76cd
	ld (07f08h),hl		;76d0
	ld a,(07f0fh)		;76d3
	add a,(ix-010h)		;76d6
	dec a			;76d9
	ld (07f10h),a		;76da
	xor a			;76dd
	ret			;76de
	ld a,(07f0fh)		;76df
	add a,(ix-010h)		;76e2
	cp (ix-00ch)		;76e5
	jr z,$+9		;76e8
	ld a,020h		;76ea
	call 07710h		;76ec
	jr $-16		;76ef
	ld hl,07f11h		;76f1
	ld a,(07f0eh)		;76f4
	add a,(ix-00fh)		;76f7
	cp (hl)			;76fa
	jr z,$+10		;76fb
	inc (hl)			;76fd
	ld a,(hl)			;76fe
	call 00e9eh		;76ff
	ld (07f08h),hl		;7702
	call z,077c6h		;7705
	ld a,(07f0fh)		;7708
	ld (07f10h),a		;770b
	xor a			;770e
	ret			;770f
	push af			;7710
	ld a,(07f0fh)		;7711
	add a,(ix-010h)		;7714
	cp (ix-00ch)		;7717
	jp nz,07720h		;771a
	call 076dfh		;771d
	ld a,(07f10h)		;7720
	ld hl,(07f08h)		;7723
	call 078f5h		;7726
	and 003h		;7729
	bit 1,a		;772b
	jr z,$+3		;772d
	inc hl			;772f
	ex (sp),hl			;7730
	push hl			;7731
	rlca			;7732
	ld e,a			;7733
	ld bc,0ffffh		;7734
	bit 4,(ix-00ah)		;7737
	jr nz,$+9		;773b
	ld hl,077a4h		;773d
	add hl,de			;7740
	ld c,(hl)			;7741
	inc hl			;7742
	ld b,(hl)			;7743
	rlc e		;7744
	rlc e		;7746
	ld hl,07784h		;7748
	add hl,de			;774b
	ld (07762h),hl		;774c
	ld de,(0fff7h)		;774f
	pop af			;7753
	ld l,a			;7754
	ld h,000h		;7755
	add hl,hl			;7757
	add hl,hl			;7758
	add hl,hl			;7759
	add hl,de			;775a
	pop de			;775b
	push de			;775c
	ld a,008h		;775d
	ex af,af'			;775f
	push hl			;7760
	call 07784h		;7761
	ld a,(de)			;7764
	and b			;7765
	xor h			;7766
	ld (de),a			;7767
	inc de			;7768
	ld a,(de)			;7769
	and c			;776a
	xor l			;776b
	ld (de),a			;776c
	dec de			;776d
	pop hl			;776e
	inc d			;776f
	inc hl			;7770
	ex af,af'			;7771
	dec a			;7772
	jr nz,$-20		;7773
	pop hl			;7775
	push hl			;7776
	call 00bdbh		;7777
	pop hl			;777a
	inc hl			;777b
	call 00bdbh		;777c
	ld hl,07f10h		;777f
	inc (hl)			;7782
	ret			;7783
	ld h,(hl)			;7784
	ld l,000h		;7785
	ret			;7787
	nop			;7788
	nop			;7789
	nop			;778a
	nop			;778b
	ld l,(hl)			;778c
	ld h,000h		;778d
	add hl,hl			;778f
	add hl,hl			;7790
	ret			;7791
	nop			;7792
	nop			;7793
	ld l,(hl)			;7794
	ld h,000h		;7795
	add hl,hl			;7797
	add hl,hl			;7798
	add hl,hl			;7799
	add hl,hl			;779a
	ret			;779b
	ld l,(hl)			;779c
	ld h,000h		;779d
	srl l		;779f
	srl l		;77a1
	ret			;77a3
	rst 38h			;77a4
	inc bc			;77a5
	rrca			;77a6
	call m,0f03fh		;77a7
	ret nz			;77aa
	rst 38h			;77ab
	push hl			;77ac
	bit 3,(ix-00ah)		;77ad
	jr nz,$+19		;77b1
	set 3,(ix-00ah)		;77b3
	call 076a7h		;77b7
	jr $+10		;77ba
	push hl			;77bc
	call 076a2h		;77bd
	res 3,(ix-00ah)		;77c0
	pop hl			;77c4
	ret			;77c5
	call 078aah		;77c6
	ld a,(07f0dh)		;77c9
	ld c,(ix-00eh)		;77cc
	or a			;77cf
	jr z,$+52		;77d0
	ld b,a			;77d2
	push bc			;77d3
	ld a,c			;77d4
	call 078e5h		;77d5
	push hl			;77d8
	push hl			;77d9
	ld a,c			;77da
	inc a			;77db
	call 078e5h		;77dc
	pop de			;77df
	push hl			;77e0
	call 07872h		;77e1
	pop hl			;77e4
	ld a,h			;77e5
	rrca			;77e6
	rrca			;77e7
	rrca			;77e8
	and 003h		;77e9
	or 058h		;77eb
	ld h,a			;77ed
	pop de			;77ee
	ld a,d			;77ef
	rrca			;77f0
	rrca			;77f1
	rrca			;77f2
	and 003h		;77f3
	or 058h		;77f5
	ld d,a			;77f7
	ld bc,(07f0bh)		;77f8
	ld b,000h		;77fc
	ldir		;77fe
	pop bc			;7800
	inc c			;7801
	djnz $-47		;7802
	push bc			;7804
	ld b,001h		;7805
	call 07853h		;7807
	pop bc			;780a
	ld l,c			;780b
	ld a,(07f0fh)		;780c
	ld bc,(07f0bh)		;780f
	ld b,001h		;7813
	jr $+26		;7815
	ld b,(ix-00fh)		;7817
	inc b			;781a
	ld c,(ix-00eh)		;781b
	call 07853h		;781e
	ld bc,(07f0bh)		;7821
	ld b,(ix-00fh)		;7825
	inc b			;7828
	ld a,(07f0fh)		;7829
	ld l,(ix-00eh)		;782c
	ld h,000h		;782f
	add hl,hl			;7831
	add hl,hl			;7832
	add hl,hl			;7833
	add hl,hl			;7834
	add hl,hl			;7835
	ld de,05800h		;7836
	add hl,de			;7839
	call 078ebh		;783a
	push bc			;783d
	push hl			;783e
	ld d,h			;783f
	ld e,l			;7840
	inc de			;7841
	ld b,000h		;7842
	ld a,(05c8fh)		;7844
	ld (hl),a			;7847
	ldir		;7848
	pop hl			;784a
	pop bc			;784b
	ld de,00020h		;784c
	add hl,de			;784f
	djnz $-19		;7850
	ret			;7852
	call 078aah		;7853
	dec a			;7856
	ld (07f0bh),a		;7857
	set 0,(ix-004h)		;785a
	push bc			;785e
	ld a,c			;785f
	call 078e5h		;7860
	ld e,l			;7863
	ld d,h			;7864
	inc de			;7865
	call 07872h		;7866
	pop bc			;7869
	inc c			;786a
	djnz $-13		;786b
	res 0,(ix-004h)		;786d
	ret			;7871
	ld bc,(07f0bh)		;7872
	ld b,008h		;7876
	push bc			;7878
	push hl			;7879
	push de			;787a
	ld a,(07f18h)		;787b
	rrca			;787e
	jp nc,0788ah		;787f
	ld (hl),000h		;7882
	ld b,a			;7884
	ld a,c			;7885
	or a			;7886
	ld a,b			;7887
	jr z,$+6		;7888
	ld b,000h		;788a
	ldir		;788c
	rrca			;788e
	jp nc,07898h		;788f
	pop hl			;7892
	pop hl			;7893
	inc h			;7894
	jp 078a6h		;7895
	rrca			;7898
	jp nc,078a2h		;7899
	pop de			;789c
	pop bc			;789d
	inc d			;789e
	jp 078a6h		;789f
	pop de			;78a2
	pop hl			;78a3
	inc d			;78a4
	inc h			;78a5
	pop bc			;78a6
	djnz $-47		;78a7
	ret			;78a9
	push bc			;78aa
	push hl			;78ab
	ld a,(07f0ch)		;78ac
	ld b,a			;78af
	srl a		;78b0
	srl a		;78b2
	ld c,a			;78b4
	add a,a			;78b5
	add a,c			;78b6
	ld c,a			;78b7
	ld a,(07f0fh)		;78b8
	and 003h		;78bb
	sla a		;78bd
	sla a		;78bf
	ld e,a			;78c1
	ld a,b			;78c2
	and 003h		;78c3
	add a,e			;78c5
	ld e,a			;78c6
	ld d,000h		;78c7
	ld hl,078d5h		;78c9
	add hl,de			;78cc
	ld a,(hl)			;78cd
	add a,c			;78ce
	ld (07f0bh),a		;78cf
	pop hl			;78d2
	pop bc			;78d3
	ret			;78d4
	nop			;78d5
	ld bc,00302h		;78d6
	ld bc,00302h		;78d9
	inc bc			;78dc
	ld bc,00202h		;78dd
	inc bc			;78e0
	ld bc,00201h		;78e1
	inc bc			;78e4
	call 00e9eh		;78e5
	ld a,(07f0fh)		;78e8
	call 078f5h		;78eb
	and 003h		;78ee
	ret z			;78f0
	dec a			;78f1
	ld e,a			;78f2
	add hl,de			;78f3
	ret			;78f4
	ld e,a			;78f5
	srl e		;78f6
	srl e		;78f8
	ld d,000h		;78fa
	add hl,de			;78fc
	add hl,de			;78fd
	add hl,de			;78fe
	ret			;78ff
	push hl			;7900
	call 07913h		;7901
	pop hl			;7904
	ld bc,00610h		;7905
	ld a,c			;7908
	rst 10h			;7909
	ld a,(hl)			;790a
	inc hl			;790b
	rst 10h			;790c
	inc c			;790d
	djnz $-6		;790e
	ret			;7910
	halt			;7911
	ret			;7912
	ld a,002h		;7913
	jp 01601h		;7915
	bit 5,(ix+01dh)		;7918
	ret nz			;791c
	call 079d4h		;791d
	bit 7,(hl)		;7920
	jp z,079b0h		;7922
	call 0796ch		;7925
	bit 3,(ix+01dh)		;7928
	jr z,$+18		;792c
	and 038h		;792e
	bit 5,a		;7930
	jr nz,$+4		;7932
	or 007h		;7934
	ld (05c48h),a		;7936
	rrca			;7939
	rrca			;793a
	rrca			;793b
	out (0feh),a		;793c
	call 0746dh		;793e
	bit 7,(ix-004h)		;7941
	call z,079b0h		;7945
	bit 4,(ix+01dh)		;7948
	jr z,$+12		;794c
	res 5,(iy+001h)		;794e
	bit 5,(iy+001h)		;7952
	jr z,$-4		;7956
	ld hl,(07e16h)		;7958
	ld (05c8dh),hl		;795b
	ld a,(07e15h)		;795e
	ld (05c48h),a		;7961
	and 038h		;7964
	rrca			;7966
	rrca			;7967
	rrca			;7968
	out (0feh),a		;7969
	ret			;796b
	ld a,(05c91h)		;796c
	and 00fh		;796f
	ld (05c91h),a		;7971
	ld a,(05c48h)		;7974
	ld (07e15h),a		;7977
	call 079d4h		;797a
	ld a,(hl)			;797d
	push af			;797e
	inc hl			;797f
	ld a,(hl)			;7980
	ld (07f0eh),a		;7981
	inc hl			;7984
	ld a,(hl)			;7985
	ld (07f0fh),a		;7986
	inc hl			;7989
	ld a,(hl)			;798a
	dec a			;798b
	ld (07f0dh),a		;798c
	inc hl			;798f
	ld a,(hl)			;7990
	ld (07f0ch),a		;7991
	push de			;7994
	call 074c9h		;7995
	pop de			;7998
	pop af			;7999
	and 03fh		;799a
	ld hl,(05c8dh)		;799c
	ld (07e16h),hl		;799f
	ld l,a			;79a2
	ld h,000h		;79a3
	ld (05c8dh),hl		;79a5
	ld (05c8fh),hl		;79a8
	ld l,h			;79ab
	ld (05c7dh),hl		;79ac
	ret			;79af
	push ix		;79b0
	ld d,000h		;79b2
	ld hl,(0fff1h)		;79b4
	ex de,hl			;79b7
	add hl,hl			;79b8
	add hl,de			;79b9
	ld e,(hl)			;79ba
	inc hl			;79bb
	ld d,(hl)			;79bc
	push de			;79bd
	pop ix		;79be
	ld a,000h		;79c0
	ld (07e0ch),a		;79c2
	ld (07e0dh),a		;79c5
	ld (05c44h),a		;79c8
	call 07913h		;79cb
	call 07a23h		;79ce
	pop ix		;79d1
	ret			;79d3
	ld hl,00000h		;79d4
	ld d,000h		;79d7
	add hl,de			;79d9
	add hl,de			;79da
	add hl,de			;79db
	add hl,de			;79dc
	add hl,de			;79dd
	ret			;79de
	xor a			;79df
	ld c,a			;79e0
	di			;79e1
	ld a,(05b5ch)		;79e2
	and 0f8h		;79e5
	or c			;79e7
	ld bc,07ffdh		;79e8
	ld (05b5ch),a		;79eb
	out (c),a		;79ee
	ei			;79f0
	ret			;79f1
	ld e,a			;79f2
	ld a,(bc)			;79f3
	cp 00eh		;79f4
	ret nc			;79f6
	push bc			;79f7
	ld bc,0fffdh		;79f8
	out (c),a		;79fb
	ld a,e			;79fd
	ld bc,0bffdh		;79fe
	out (c),a		;7a01
	pop bc			;7a03
	ret			;7a04
	push af			;7a05
	push hl			;7a06
	ld hl,(06011h)		;7a07
	scf			;7a0a
	call 06010h		;7a0b
	jp c,0003ah		;7a0e
	pop hl			;7a11
	pop af			;7a12
	ei			;7a13
	ret			;7a14
	ld a,(07e5fh)		;7a15
	ld i,a		;7a18
	im 2		;7a1a
	ret			;7a1c
	ld e,003h		;7a1d
	ld d,000h		;7a1f
	add ix,de		;7a21
	ld a,(ix+000h)		;7a23
	and 007h		;7a26
	sla a		;7a28
	ld hl,07a3ah		;7a2a
	ld e,a			;7a2d
	ld d,000h		;7a2e
	add hl,de			;7a30
	ld (07e0ah),ix		;7a31
	ld a,(hl)			;7a35
	inc hl			;7a36
	ld h,(hl)			;7a37
	ld l,a			;7a38
	jp (hl)			;7a39
	ld c,d			;7a3a
	ld a,d			;7a3b
	ld h,b			;7a3c
	ld a,d			;7a3d
	ret nz			;7a3e
	ld a,d			;7a3f
	ld b,a			;7a40
	ld a,e			;7a41
	sbc a,e			;7a42
	ld a,e			;7a43
	push bc			;7a44
	ld a,e			;7a45
	defb 0ddh,07bh,0eah	;illegal sequence		;7a46
	ld a,e			;7a49
	ld a,(ix+000h)		;7a4a
	call 07aabh		;7a4d
	ld b,(ix+002h)		;7a50
	ld c,(ix+001h)		;7a53
	call 022e5h		;7a56
	xor a			;7a59
	call 07ab5h		;7a5a
	jp 07a1dh		;7a5d
	ld a,(ix+000h)		;7a60
	and 018h		;7a63
	cp 018h		;7a65
	jr nz,$+15		;7a67
	call 07c31h		;7a69
	call 07c06h		;7a6c
	ld (05c7dh),bc		;7a6f
	jp 07a9fh		;7a73
	call 07aabh		;7a76
	call 07c31h		;7a79
	ld b,d			;7a7c
	ld c,e			;7a7d
	ld e,001h		;7a7e
	bit 6,(iy+008h)		;7a80
	jr z,$+4		;7a84
	ld e,0ffh		;7a86
	ld d,001h		;7a88
	bit 7,(iy+008h)		;7a8a
	jr z,$+4		;7a8e
	ld d,0ffh		;7a90
	exx			;7a92
	push hl			;7a93
	exx			;7a94
	call 024bah		;7a95
	exx			;7a98
	pop hl			;7a99
	exx			;7a9a
	xor a			;7a9b
	call 07ab5h		;7a9c
	bit 5,(ix+000h)		;7a9f
	jp z,07a1dh		;7aa3
	ld e,002h		;7aa6
	jp 07a1fh		;7aa8
	rrca			;7aab
	rrca			;7aac
	rrca			;7aad
	and 003h		;7aae
	or a			;7ab0
	add a,002h		;7ab1
	and 005h		;7ab3
	ld e,a			;7ab5
	ld a,(05c91h)		;7ab6
	and 0fah		;7ab9
	or e			;7abb
	ld (05c91h),a		;7abc
	ret			;7abf
	ld a,(ix+000h)		;7ac0
	cp 012h		;7ac3
	jp z,07b0ah		;7ac5
	call 07c50h		;7ac8
	call 07c06h		;7acb
	bit 5,(ix+000h)		;7ace
	jr nz,$+24		;7ad2
	xor a			;7ad4
	ld hl,07ae2h		;7ad5
	ld e,l			;7ad8
	ld d,h			;7ad9
	call 07c8bh		;7ada
	ld e,003h		;7add
	jp 07a1fh		;7adf
	rst 38h			;7ae2
	rst 38h			;7ae3
	rst 38h			;7ae4
	rst 38h			;7ae5
	rst 38h			;7ae6
	rst 38h			;7ae7
	rst 38h			;7ae8
	rst 38h			;7ae9
	ld a,(ix+003h)		;7aea
	ld l,a			;7aed
	ld h,000h		;7aee
	add hl,hl			;7af0
	add hl,hl			;7af1
	add hl,hl			;7af2
	ld de,(0fff7h)		;7af3
	add hl,de			;7af7
	ld e,l			;7af8
	ld d,h			;7af9
	xor a			;7afa
	bit 4,(ix+000h)		;7afb
	jr z,$+3		;7aff
	dec a			;7b01
	call 07c8bh		;7b02
	ld e,004h		;7b05
	jp 07a1fh		;7b07
	ld h,000h		;7b0a
	ld l,(ix+004h)		;7b0c
	ld d,h			;7b0f
	ld e,(ix+003h)		;7b10
	add hl,hl			;7b13
	add hl,hl			;7b14
	add hl,hl			;7b15
	add hl,hl			;7b16
	add hl,hl			;7b17
	add hl,de			;7b18
	ld de,05800h		;7b19
	add hl,de			;7b1c
	ld c,(ix+001h)		;7b1d
	ld b,(ix+002h)		;7b20
	push bc			;7b23
	push hl			;7b24
	ld de,(05c8fh)		;7b25
	ld a,(hl)			;7b29
	xor e			;7b2a
	and d			;7b2b
	xor e			;7b2c
	ld (hl),a			;7b2d
	xor a			;7b2e
	cp b			;7b2f
	jr z,$+7		;7b30
	inc hl			;7b32
	dec b			;7b33
	jp 07b25h		;7b34
	pop hl			;7b37
	pop bc			;7b38
	cp c			;7b39
	ld de,00005h		;7b3a
	jp z,07a1fh		;7b3d
	ld e,020h		;7b40
	add hl,de			;7b42
	dec c			;7b43
	jp 07b23h		;7b44
	ld a,(05c44h)		;7b47
	cp 00ah		;7b4a
	jr nz,$+18		;7b4c
	ld a,000h		;7b4e
	ld (05c44h),a		;7b50
	ld (07e0ch),a		;7b53
	ld (07e0dh),a		;7b56
	ld l,01eh		;7b59
	jp 00055h		;7b5b
	or a			;7b5e
	jr nz,$+6		;7b5f
	ld (07e08h),ix		;7b61
	inc (iy+00ah)		;7b65
	push ix		;7b68
	ld bc,(07e0ch)		;7b6a
	ld a,c			;7b6e
	or b			;7b6f
	push af			;7b70
	ld a,(ix+000h)		;7b71
	rrca			;7b74
	rrca			;7b75
	rrca			;7b76
	and 007h		;7b77
	ld (07e0ch),a		;7b79
	ld a,(07e0dh)		;7b7c
	xor (ix+000h)		;7b7f
	and 0c0h		;7b82
	ld (07e0dh),a		;7b84
	ld h,000h		;7b87
	ld l,(ix+001h)		;7b89
	add hl,hl			;7b8c
	ld de,(0fff1h)		;7b8d
	add hl,de			;7b91
	ld e,(hl)			;7b92
	inc hl			;7b93
	ld d,(hl)			;7b94
	push de			;7b95
	pop ix		;7b96
	jp 07a23h		;7b98
	ld a,(ix+000h)		;7b9b
	call 07aabh		;7b9e
	ld a,016h		;7ba1
	rst 10h			;7ba3
	ld a,(ix+003h)		;7ba4
	rst 10h			;7ba7
	ld a,(ix+002h)		;7ba8
	rst 10h			;7bab
	ld a,(ix+001h)		;7bac
	ld l,a			;7baf
	ld h,000h		;7bb0
	add hl,hl			;7bb2
	add hl,hl			;7bb3
	add hl,hl			;7bb4
	ld de,(0fff7h)		;7bb5
	add hl,de			;7bb9
	ld (05c7bh),hl		;7bba
	ld a,090h		;7bbd
	rst 10h			;7bbf
	ld e,004h		;7bc0
	jp 07a1fh		;7bc2
	ld d,(ix+000h)		;7bc5
	ld a,011h		;7bc8
	bit 7,d		;7bca
	jr z,$+4		;7bcc
	ld a,013h		;7bce
	rst 10h			;7bd0
	ld a,d			;7bd1
	rrca			;7bd2
	rrca			;7bd3
	rrca			;7bd4
	and 00fh		;7bd5
	rst 10h			;7bd7
	ld e,001h		;7bd8
	jp 07a1fh		;7bda
	ld d,(ix+000h)		;7bdd
	ld a,010h		;7be0
	bit 7,d		;7be2
	jr z,$-20		;7be4
	ld a,012h		;7be6
	jr $-24		;7be8
	ld a,(iy+00ah)		;7bea
	or a			;7bed
	ret z			;7bee
	pop bc			;7bef
	ld a,b			;7bf0
	and 007h		;7bf1
	ld (07e0ch),a		;7bf3
	ld a,b			;7bf6
	and 0c0h		;7bf7
	ld (07e0dh),a		;7bf9
	pop ix		;7bfc
	dec (iy+00ah)		;7bfe
	ld e,002h		;7c01
	jp 07a1fh		;7c03
	ld bc,(05c7dh)		;7c06
	ld a,c			;7c0a
	bit 6,(iy+008h)		;7c0b
	jr z,$+6		;7c0f
	sub e			;7c11
	jp 07c16h		;7c12
	add a,e			;7c15
	ld c,a			;7c16
	ld a,b			;7c17
	bit 7,(iy+008h)		;7c18
	jr z,$+10		;7c1c
	sub d			;7c1e
	jr nc,$+16		;7c1f
	sub 050h		;7c21
	jp 07c2fh		;7c23
	add a,d			;7c26
	jr c,$+6		;7c27
	cp 0b0h		;7c29
	jr c,$+4		;7c2b
	sub 0b0h		;7c2d
	ld b,a			;7c2f
	ret			;7c30
	bit 5,(ix+000h)		;7c31
	jr z,$+27		;7c35
	ld a,(ix+001h)		;7c37
	ld d,a			;7c3a
	rrca			;7c3b
	rrca			;7c3c
	rrca			;7c3d
	rrca			;7c3e
	and 00fh		;7c3f
	ld e,a			;7c41
	ld a,d			;7c42
	and 00fh		;7c43
	ld d,a			;7c45
	ld a,(07e0ch)		;7c46
	or a			;7c49
	jp z,07c6dh		;7c4a
	jp 07c60h		;7c4d
	ld e,(ix+001h)		;7c50
	ld d,(ix+002h)		;7c53
	ld a,(07e0ch)		;7c56
	or a			;7c59
	jp z,07c6dh		;7c5a
	jp 07c60h		;7c5d
	ld c,d			;7c60
	ld d,000h		;7c61
	call 07c77h		;7c63
	ld e,c			;7c66
	ld c,l			;7c67
	call 07c77h		;7c68
	ld e,c			;7c6b
	ld d,l			;7c6c
	ld a,(07e0dh)		;7c6d
	xor (ix+000h)		;7c70
	ld (iy+008h),a		;7c73
	ret			;7c76
	ld hl,00000h		;7c77
	ld b,a			;7c7a
	add hl,de			;7c7b
	djnz $-1		;7c7c
	srl h		;7c7e
	rr l		;7c80
	srl h		;7c82
	rr l		;7c84
	srl h		;7c86
	rr l		;7c88
	ret			;7c8a
	di			;7c8b
	push iy		;7c8c
	push ix		;7c8e
	exx			;7c90
	push hl			;7c91
	ld (07e10h),sp		;7c92
	ld de,(05c65h)		;7c96
	ld hl,0fef8h		;7c9a
	add hl,sp			;7c9d
	sbc hl,de		;7c9e
	exx			;7ca0
	jr nc,$+10		;7ca1
	call 07dcfh		;7ca3
	ld l,003h		;7ca6
	jp 00055h		;7ca8
	ld (07e0eh),bc		;7cab
	ld c,a			;7caf
	ld ix,0fff8h		;7cb0
	add ix,sp		;7cb4
	ld b,008h		;7cb6
	ld a,(de)			;7cb8
	or (hl)			;7cb9
	xor c			;7cba
	inc hl			;7cbb
	inc de			;7cbc
	push af			;7cbd
	inc sp			;7cbe
	djnz $-7		;7cbf
	ld hl,0ffffh		;7cc1
	push hl			;7cc4
	ld de,00000h		;7cc5
	ld b,058h		;7cc8
	push de			;7cca
	djnz $-1		;7ccb
	push hl			;7ccd
	ld bc,(07e0eh)		;7cce
	ld hl,00002h		;7cd2
	add hl,sp			;7cd5
	ld (07e12h),hl		;7cd6
	ld d,000h		;7cd9
	call 07df3h		;7cdb
	ld a,(hl)			;7cde
	and e			;7cdf
	jp nz,07dcfh		;7ce0
	ld a,01eh		;7ce3
	ex af,af'			;7ce5
	ld hl,0ffffh		;7ce6
	push hl			;7ce9
	ld a,d			;7cea
	and 0fch		;7ceb
	ld d,a			;7ced
	call 07df3h		;7cee
	ld a,b			;7cf1
	bit 7,d		;7cf2
	jr z,$+6		;7cf4
	inc b			;7cf6
	jp 07cfbh		;7cf7
	dec b			;7cfa
	push bc			;7cfb
	exx			;7cfc
	ld l,a			;7cfd
	ld h,000h		;7cfe
	ld de,(07e12h)		;7d00
	add hl,de			;7d04
	push hl			;7d05
	pop iy		;7d06
	and 007h		;7d08
	ld (07d0fh),a		;7d0a
	ld d,(ix+000h)		;7d0d
	pop bc			;7d10
	ld a,b			;7d11
	cp 0b0h		;7d12
	call c,07df3h		;7d14
	exx			;7d17
	bit 7,d		;7d18
	exx			;7d1a
	jr z,$+8		;7d1b
	ld c,(iy+001h)		;7d1d
	jp 07d26h		;7d20
	ld c,(iy-001h)		;7d23
	exx			;7d26
	srl e		;7d27
	jr nc,$+8		;7d29
	ld e,080h		;7d2b
	inc hl			;7d2d
	exx			;7d2e
	inc hl			;7d2f
	exx			;7d30
	inc c			;7d31
	jr z,$+6		;7d32
	ld a,(hl)			;7d34
	and e			;7d35
	jr z,$-15		;7d36
	dec c			;7d38
	ld (iy+000h),c		;7d39
	jp 07d85h		;7d3c
	ld a,(hl)			;7d3f
	and e			;7d40
	jr nz,$+116		;7d41
	exx			;7d43
	ld a,d			;7d44
	exx			;7d45
	and e			;7d46
	or (hl)			;7d47
	ld (hl),a			;7d48
	call 07ddch		;7d49
	ld a,c			;7d4c
	or a			;7d4d
	jr z,$+103		;7d4e
	bit 1,d		;7d50
	jr nz,$+50		;7d52
	exx			;7d54
	ld e,a			;7d55
	ld a,c			;7d56
	or a			;7d57
	jp z,07d67h		;7d58
	cp e			;7d5b
	jp c,07d67h		;7d5c
	exx			;7d5f
	ld a,d			;7d60
	or 003h		;7d61
	ld d,a			;7d63
	jp 07d84h		;7d64
	ld a,(hl)			;7d67
	exx			;7d68
	and e			;7d69
	jr nz,$+3		;7d6a
	scf			;7d6c
	bit 0,d		;7d6d
	jp nz,07d7fh		;7d6f
	jr nc,$+18		;7d72
	ex af,af'			;7d74
	dec a			;7d75
	jr z,$+72		;7d76
	ex af,af'			;7d78
	push bc			;7d79
	set 0,d		;7d7a
	jp 07d84h		;7d7c
	jp c,07d84h		;7d7f
	res 0,d		;7d82
	dec c			;7d84
	sla e		;7d85
	jp nc,07d3fh		;7d87
	ld e,001h		;7d8a
	dec hl			;7d8c
	ld a,(hl)			;7d8d
	exx			;7d8e
	dec hl			;7d8f
	or a			;7d90
	jr nz,$+32		;7d91
	exx			;7d93
	bit 1,d		;7d94
	exx			;7d96
	jr nz,$+11		;7d97
	cp (hl)			;7d99
	jr nz,$+23		;7d9a
	exx			;7d9c
	bit 0,d		;7d9d
	exx			;7d9f
	jr z,$+17		;7da0
	ld a,d			;7da2
	exx			;7da3
	ld (hl),a			;7da4
	call 07ddch		;7da5
	ld a,c			;7da8
	sub 008h		;7da9
	ld c,a			;7dab
	jr c,$+9		;7dac
	jp 07d8ch		;7dae
	exx			;7db1
	jp 07d3fh		;7db2
	ex af,af'			;7db5
	inc a			;7db6
	ex af,af'			;7db7
	pop bc			;7db8
	ld a,b			;7db9
	inc a			;7dba
	jp nz,07ceah		;7dbb
	ld bc,(07e0eh)		;7dbe
	bit 7,d		;7dc2
	jr nz,$+11		;7dc4
	set 7,d		;7dc6
	inc b			;7dc8
	ld a,b			;7dc9
	cp 0b0h		;7dca
	jp c,07cdbh		;7dcc
	ld sp,(07e10h)		;7dcf
	exx			;7dd3
	pop hl			;7dd4
	exx			;7dd5
	pop ix		;7dd6
	pop iy		;7dd8
	ei			;7dda
	ret			;7ddb
	push hl			;7ddc
	push de			;7ddd
	ld a,h			;7dde
	rrca			;7ddf
	rrca			;7de0
	rrca			;7de1
	and 003h		;7de2
	or 058h		;7de4
	ld h,a			;7de6
	ld de,(05c8fh)		;7de7
	ld a,(hl)			;7deb
	xor e			;7dec
	and d			;7ded
	xor e			;7dee
	ld (hl),a			;7def
	pop de			;7df0
	pop hl			;7df1
	ret			;7df2
	push bc			;7df3
	call 022aah		;7df4
	ld bc,07e00h		;7df7
	add a,c			;7dfa
	ld c,a			;7dfb
	ld a,(bc)			;7dfc
	ld e,a			;7dfd
	pop bc			;7dfe
	ret			;7dff
	add a,b			;7e00
	ld b,b			;7e01
	jr nz,$+18		;7e02
	ex af,af'			;7e04
	inc b			;7e05
	ld (bc),a			;7e06
	ld bc,00000h		;7e07
	nop			;7e0a
	nop			;7e0b
	nop			;7e0c
	nop			;7e0d
	nop			;7e0e
	nop			;7e0f
	nop			;7e10
	nop			;7e11
	nop			;7e12
	nop			;7e13
	nop			;7e14
	nop			;7e15
	nop			;7e16
	nop			;7e17
	inc e			;7e18
	add a,c			;7e19
	nop			;7e1a
	rst 38h			;7e1b
	rst 38h			;7e1c
	rst 38h			;7e1d
	rst 38h			;7e1e
	rst 38h			;7e1f
	nop			;7e20
	nop			;7e21
	nop			;7e22
	nop			;7e23
	nop			;7e24
	rst 38h			;7e25
	rst 38h			;7e26
	rst 38h			;7e27
	rst 38h			;7e28
	rst 38h			;7e29
	rst 38h			;7e2a
	rst 38h			;7e2b
	rst 38h			;7e2c
	rst 38h			;7e2d
	rst 38h			;7e2e
	rst 38h			;7e2f
	rst 38h			;7e30
	rst 38h			;7e31
	rst 38h			;7e32
	rst 38h			;7e33
	rst 38h			;7e34
	rst 38h			;7e35
	rst 38h			;7e36
	rst 38h			;7e37
	rst 38h			;7e38
	rst 38h			;7e39
	rst 38h			;7e3a
	rst 38h			;7e3b
	rst 38h			;7e3c
	rst 38h			;7e3d
	rst 38h			;7e3e
	rst 38h			;7e3f
	rst 38h			;7e40
	rst 38h			;7e41
	rst 38h			;7e42
	rst 38h			;7e43
	rst 38h			;7e44
	rst 38h			;7e45
	rst 38h			;7e46
	rst 38h			;7e47
	rst 38h			;7e48
	rst 38h			;7e49
	rst 38h			;7e4a
	rst 38h			;7e4b
	rst 38h			;7e4c
	dec h			;7e4d
	ld a,(hl)			;7e4e
	nop			;7e4f
	nop			;7e50
	nop			;7e51
	nop			;7e52
	nop			;7e53
	nop			;7e54
	nop			;7e55
	nop			;7e56
	nop			;7e57
	nop			;7e58
	nop			;7e59
	nop			;7e5a
	nop			;7e5b
	nop			;7e5c
	nop			;7e5d
	nop			;7e5e
	add hl,sp			;7e5f
	nop			;7e60
	nop			;7e61
	nop			;7e62
	nop			;7e63
	nop			;7e64
	nop			;7e65
	rlca			;7e66
	nop			;7e67
	ld b,b			;7e68
	rla			;7e69
	jr nz,$+44		;7e6a
	rla			;7e6c
	nop			;7e6d
	nop			;7e6e
	nop			;7e6f
	nop			;7e70
	ld b,b			;7e71
	nop			;7e72
	nop			;7e73
	nop			;7e74
	nop			;7e75
	rlca			;7e76
	nop			;7e77
	ld b,b			;7e78
	rla			;7e79
	jr nz,$+44		;7e7a
	rla			;7e7c
	nop			;7e7d
	nop			;7e7e
	nop			;7e7f
	nop			;7e80
	ld b,b			;7e81
	nop			;7e82
	nop			;7e83
	nop			;7e84
	nop			;7e85
	rlca			;7e86
	nop			;7e87
	ld b,b			;7e88
	rla			;7e89
	jr nz,$+44		;7e8a
	rla			;7e8c
	nop			;7e8d
	nop			;7e8e
	nop			;7e8f
	nop			;7e90
	ld b,b			;7e91
	nop			;7e92
	nop			;7e93
	nop			;7e94
	nop			;7e95
	rlca			;7e96
	nop			;7e97
	ld b,b			;7e98
	rla			;7e99
	jr nz,$+44		;7e9a
	rla			;7e9c
	nop			;7e9d
	nop			;7e9e
	nop			;7e9f
	nop			;7ea0
	ld b,b			;7ea1
	nop			;7ea2
	nop			;7ea3
	nop			;7ea4
	nop			;7ea5
	rlca			;7ea6
	nop			;7ea7
	ld b,b			;7ea8
	rla			;7ea9
	jr nz,$+44		;7eaa
	rla			;7eac
	nop			;7ead
	nop			;7eae
	nop			;7eaf
	nop			;7eb0
	ld b,b			;7eb1
	nop			;7eb2
	nop			;7eb3
	nop			;7eb4
	nop			;7eb5
	rlca			;7eb6
	nop			;7eb7
	ld b,b			;7eb8
	rla			;7eb9
	jr nz,$+44		;7eba
	rla			;7ebc
	nop			;7ebd
	nop			;7ebe
	nop			;7ebf
	nop			;7ec0
	ld b,b			;7ec1
	nop			;7ec2
	nop			;7ec3
	nop			;7ec4
	nop			;7ec5
	rlca			;7ec6
	nop			;7ec7
	ld b,b			;7ec8
	rla			;7ec9
	jr nz,$+44		;7eca
	rla			;7ecc
	nop			;7ecd
	nop			;7ece
	nop			;7ecf
	nop			;7ed0
	ld b,b			;7ed1
	nop			;7ed2
	nop			;7ed3
	nop			;7ed4
	nop			;7ed5
	rlca			;7ed6
	nop			;7ed7
	ld b,b			;7ed8
	rla			;7ed9
	jr nz,$+44		;7eda
	rla			;7edc
	nop			;7edd
	nop			;7ede
	nop			;7edf
	nop			;7ee0
	ld b,b			;7ee1
	nop			;7ee2
	nop			;7ee3
	nop			;7ee4
	nop			;7ee5
	rlca			;7ee6
	nop			;7ee7
	ld b,b			;7ee8
	rla			;7ee9
	jr nz,$+44		;7eea
	rla			;7eec
	nop			;7eed
	nop			;7eee
	nop			;7eef
	nop			;7ef0
	ld b,b			;7ef1
	nop			;7ef2
	nop			;7ef3
	nop			;7ef4
	nop			;7ef5
	sub a			;7ef6
	nop			;7ef7
	ld b,b			;7ef8
	inc bc			;7ef9
	dec c			;7efa
	djnz $+5		;7efb
	nop			;7efd
	nop			;7efe
	nop			;7eff
	nop			;7f00
	ld b,b			;7f01
	nop			;7f02
	rst 38h			;7f03
	rst 38h			;7f04
	nop			;7f05
	nop			;7f06
	rlca			;7f07
	nop			;7f08
	ld b,b			;7f09
	rla			;7f0a
	jr nz,$+44		;7f0b
	rla			;7f0d
	nop			;7f0e
	nop			;7f0f
	nop			;7f10
	nop			;7f11
	ld b,b			;7f12
	nop			;7f13
	nop			;7f14
	ld a,b			;7f15
	nop			;7f16
	nop			;7f17
	nop			;7f18
	nop			;7f19
	nop			;7f1a
	nop			;7f1b
	ld (iy+03ah),001h		;7f1c
	call 016b0h		;7f20
	ld de,(05c53h)		;7f23
	ld hl,(05c59h)		;7f27
	dec hl			;7f2a
	call 019e5h		;7f2b
	di			;7f2e
	ld hl,(0fff3h)		;7f2f
	ld (079d5h),hl		;7f32
	ld a,(0004bh)		;7f35
	cp 0bfh		;7f38
	jr z,$+42		;7f3a
	ld a,080h		;7f3c
	ld (07f1bh),a		;7f3e
	ld a,0c3h		;7f41
	ld (0600dh),a		;7f43
	ld b,000h		;7f46
	ld hl,08300h		;7f48
	ld a,082h		;7f4b
	ld (hl),a			;7f4d
	inc hl			;7f4e
	djnz $-2		;7f4f
	ld (hl),a			;7f51
	ld a,083h		;7f52
	ld (07e5fh),a		;7f54
	ld a,0c3h		;7f57
	ld (08282h),a		;7f59
	ld hl,07a05h		;7f5c
	ld (08283h),hl		;7f5f
	jr $+18		;7f62
	ld a,018h		;7f64
	ld (0ffffh),a		;7f66
	ld a,0c3h		;7f69
	ld (0fff4h),a		;7f6b
	ld hl,07a05h		;7f6e
	ld (0fff5h),hl		;7f71
	ld hl,08422h		;7f74
	ld de,0600ah		;7f77
	ld a,003h		;7f7a
	ex af,af'			;7f7c
	ld c,(hl)			;7f7d
	inc hl			;7f7e
	ld b,(hl)			;7f7f
	inc hl			;7f80
	ld a,b			;7f81
	or c			;7f82
	jr z,$+14		;7f83
	ex de,hl			;7f85
	ld a,0c3h		;7f86
	ld (hl),a			;7f88
	inc hl			;7f89
	ld (hl),c			;7f8a
	inc hl			;7f8b
	ld (hl),b			;7f8c
	inc hl			;7f8d
	ex de,hl			;7f8e
	jr $+5		;7f8f
	inc de			;7f91
	inc de			;7f92
	inc de			;7f93
	ex af,af'			;7f94
	dec a			;7f95
	jr nz,$-26		;7f96
	ld (iy-030h),005h		;7f98
	ld a,(08402h)		;7f9c
	ld (07f16h),a		;7f9f
	ld hl,(0fff9h)		;7fa2
	ld a,(hl)			;7fa5
	ld (0602bh),a		;7fa6
	inc hl			;7fa9
	ld a,(hl)			;7faa
	ld (0602dh),a		;7fab
	inc hl			;7fae
	ld a,(hl)			;7faf
	ld (0602ch),a		;7fb0
	ld ix,07f1ch		;7fb3
	call 07a15h		;7fb7
	ei			;7fba
	res 2,(ix-003h)		;7fbb
	ld hl,(08408h)		;7fbf
	ld a,l			;7fc2
	or h			;7fc3
	jp z,0606fh		;7fc4
	set 2,(ix-003h)		;7fc7
	jp 0606fh		;7fcb
	nop			;7fce
	nop			;7fcf
	nop			;7fd0
	nop			;7fd1
	nop			;7fd2
	nop			;7fd3
	nop			;7fd4
	nop			;7fd5
	nop			;7fd6
	nop			;7fd7
	nop			;7fd8
	nop			;7fd9
	nop			;7fda
	nop			;7fdb
	nop			;7fdc
	nop			;7fdd
	nop			;7fde
	nop			;7fdf
	nop			;7fe0
	nop			;7fe1
	nop			;7fe2
	nop			;7fe3
	nop			;7fe4
	nop			;7fe5
	nop			;7fe6
	nop			;7fe7
	nop			;7fe8
	nop			;7fe9
	nop			;7fea
	nop			;7feb
	nop			;7fec
	nop			;7fed
	nop			;7fee
	nop			;7fef
	nop			;7ff0
	nop			;7ff1
	nop			;7ff2
	nop			;7ff3
	nop			;7ff4
	nop			;7ff5
	nop			;7ff6
	nop			;7ff7
	nop			;7ff8
	nop			;7ff9
	nop			;7ffa
	nop			;7ffb
	nop			;7ffc
	nop			;7ffd
	nop			;7ffe
	nop			;7fff
	nop			;8000
	nop			;8001
	nop			;8002
	nop			;8003
	nop			;8004
	nop			;8005
	nop			;8006
	nop			;8007
	nop			;8008
	nop			;8009
	nop			;800a
	nop			;800b
	nop			;800c
	nop			;800d
	nop			;800e
	nop			;800f
	nop			;8010
	nop			;8011
	nop			;8012
	nop			;8013
	nop			;8014
	nop			;8015
	nop			;8016
	nop			;8017
	nop			;8018
	nop			;8019
	nop			;801a
	nop			;801b
	nop			;801c
	nop			;801d
	nop			;801e
	nop			;801f
	nop			;8020
	nop			;8021
	nop			;8022
	nop			;8023
	nop			;8024
	nop			;8025
	nop			;8026
	nop			;8027
	nop			;8028
	nop			;8029
	nop			;802a
	nop			;802b
	nop			;802c
	nop			;802d
	nop			;802e
	nop			;802f
	nop			;8030
	nop			;8031
	nop			;8032
	nop			;8033
	nop			;8034
	nop			;8035
	nop			;8036
	nop			;8037
	nop			;8038
	nop			;8039
	nop			;803a
	nop			;803b
	nop			;803c
	nop			;803d
	nop			;803e
	nop			;803f
	nop			;8040
	nop			;8041
	nop			;8042
	nop			;8043
	nop			;8044
	nop			;8045
	nop			;8046
	nop			;8047
	nop			;8048
	nop			;8049
	nop			;804a
	nop			;804b
	nop			;804c
	nop			;804d
	nop			;804e
	nop			;804f
	nop			;8050
	nop			;8051
	nop			;8052
	nop			;8053
	nop			;8054
	nop			;8055
	nop			;8056
	nop			;8057
	nop			;8058
	nop			;8059
	nop			;805a
	nop			;805b
	nop			;805c
	nop			;805d
	nop			;805e
	nop			;805f
	nop			;8060
	nop			;8061
	nop			;8062
	nop			;8063
	nop			;8064
	nop			;8065
	nop			;8066
	nop			;8067
	nop			;8068
	nop			;8069
	nop			;806a
	nop			;806b
	nop			;806c
	nop			;806d
	nop			;806e
	nop			;806f
	nop			;8070
	nop			;8071
	nop			;8072
	nop			;8073
	nop			;8074
	nop			;8075
	nop			;8076
	nop			;8077
	nop			;8078
	nop			;8079
	nop			;807a
	nop			;807b
	nop			;807c
	nop			;807d
	nop			;807e
	nop			;807f
	nop			;8080
	nop			;8081
	nop			;8082
	nop			;8083
	nop			;8084
	nop			;8085
	nop			;8086
	nop			;8087
	nop			;8088
	nop			;8089
	nop			;808a
	nop			;808b
	nop			;808c
	nop			;808d
	nop			;808e
	nop			;808f
	nop			;8090
	nop			;8091
	nop			;8092
	nop			;8093
	nop			;8094
	nop			;8095
	nop			;8096
	nop			;8097
	nop			;8098
	nop			;8099
	nop			;809a
	nop			;809b
	nop			;809c
	nop			;809d
	nop			;809e
	nop			;809f
	nop			;80a0
	nop			;80a1
	nop			;80a2
	nop			;80a3
	nop			;80a4
	nop			;80a5
	nop			;80a6
	nop			;80a7
	nop			;80a8
	nop			;80a9
	nop			;80aa
	nop			;80ab
	nop			;80ac
	nop			;80ad
	nop			;80ae
	nop			;80af
	nop			;80b0
	nop			;80b1
	nop			;80b2
	nop			;80b3
	nop			;80b4
	nop			;80b5
	nop			;80b6
	nop			;80b7
	nop			;80b8
	nop			;80b9
	nop			;80ba
	nop			;80bb
	nop			;80bc
	nop			;80bd
	nop			;80be
	nop			;80bf
	nop			;80c0
	nop			;80c1
	nop			;80c2
	nop			;80c3
	nop			;80c4
	nop			;80c5
	nop			;80c6
	nop			;80c7
	nop			;80c8
	nop			;80c9
	nop			;80ca
	nop			;80cb
	nop			;80cc
	nop			;80cd
	nop			;80ce
	nop			;80cf
	nop			;80d0
	nop			;80d1
	nop			;80d2
	nop			;80d3
	nop			;80d4
	nop			;80d5
	nop			;80d6
	nop			;80d7
	nop			;80d8
	nop			;80d9
	nop			;80da
	nop			;80db
	nop			;80dc
	nop			;80dd
	nop			;80de
	nop			;80df
	nop			;80e0
	nop			;80e1
	nop			;80e2
	nop			;80e3
	nop			;80e4
	nop			;80e5
	nop			;80e6
	nop			;80e7
	nop			;80e8
	nop			;80e9
	nop			;80ea
	nop			;80eb
	nop			;80ec
	nop			;80ed
	nop			;80ee
	nop			;80ef
	nop			;80f0
	nop			;80f1
	nop			;80f2
	nop			;80f3
	nop			;80f4
	nop			;80f5
	nop			;80f6
	nop			;80f7
	nop			;80f8
	nop			;80f9
	nop			;80fa
	nop			;80fb
	nop			;80fc
	nop			;80fd
	nop			;80fe
	nop			;80ff
	nop			;8100
	nop			;8101
	nop			;8102
	nop			;8103
	nop			;8104
	nop			;8105
	nop			;8106
	nop			;8107
	nop			;8108
	nop			;8109
	nop			;810a
	nop			;810b
	nop			;810c
	nop			;810d
	nop			;810e
	nop			;810f
	nop			;8110
	nop			;8111
	nop			;8112
	nop			;8113
	nop			;8114
	nop			;8115
	nop			;8116
	nop			;8117
	nop			;8118
	nop			;8119
	nop			;811a
	nop			;811b
	nop			;811c
	nop			;811d
	nop			;811e
	nop			;811f
	nop			;8120
	nop			;8121
	nop			;8122
	nop			;8123
	nop			;8124
	nop			;8125
	nop			;8126
	nop			;8127
	nop			;8128
	nop			;8129
	nop			;812a
	nop			;812b
	nop			;812c
	nop			;812d
	nop			;812e
	nop			;812f
	nop			;8130
	nop			;8131
	nop			;8132
	nop			;8133
	nop			;8134
	nop			;8135
	nop			;8136
	nop			;8137
	nop			;8138
	nop			;8139
	nop			;813a
	nop			;813b
	nop			;813c
	nop			;813d
	nop			;813e
	nop			;813f
	nop			;8140
	nop			;8141
	nop			;8142
	nop			;8143
	nop			;8144
	nop			;8145
	nop			;8146
	nop			;8147
	nop			;8148
	nop			;8149
	nop			;814a
	nop			;814b
	nop			;814c
	nop			;814d
	nop			;814e
	nop			;814f
	nop			;8150
	nop			;8151
	nop			;8152
	nop			;8153
	nop			;8154
	nop			;8155
	nop			;8156
	nop			;8157
	nop			;8158
	nop			;8159
	nop			;815a
	nop			;815b
	nop			;815c
	nop			;815d
	nop			;815e
	nop			;815f
	nop			;8160
	nop			;8161
	nop			;8162
	nop			;8163
	nop			;8164
	nop			;8165
	nop			;8166
	nop			;8167
	nop			;8168
	nop			;8169
	nop			;816a
	nop			;816b
	nop			;816c
	nop			;816d
	nop			;816e
	nop			;816f
	nop			;8170
	nop			;8171
	nop			;8172
	nop			;8173
	nop			;8174
	nop			;8175
	nop			;8176
	nop			;8177
	nop			;8178
	nop			;8179
	nop			;817a
	nop			;817b
	nop			;817c
	nop			;817d
	nop			;817e
	nop			;817f
	nop			;8180
	nop			;8181
	nop			;8182
	nop			;8183
	nop			;8184
	nop			;8185
	nop			;8186
	nop			;8187
	nop			;8188
	nop			;8189
	nop			;818a
	nop			;818b
	nop			;818c
	nop			;818d
	nop			;818e
	nop			;818f
	nop			;8190
	nop			;8191
	nop			;8192
	nop			;8193
	nop			;8194
	nop			;8195
	nop			;8196
	nop			;8197
	nop			;8198
	nop			;8199
	nop			;819a
	nop			;819b
	nop			;819c
	nop			;819d
	nop			;819e
	nop			;819f
	nop			;81a0
	nop			;81a1
	nop			;81a2
	nop			;81a3
	nop			;81a4
	nop			;81a5
	nop			;81a6
	nop			;81a7
	nop			;81a8
	nop			;81a9
	nop			;81aa
	nop			;81ab
	nop			;81ac
	nop			;81ad
	nop			;81ae
	nop			;81af
	nop			;81b0
	nop			;81b1
	nop			;81b2
	nop			;81b3
	nop			;81b4
	nop			;81b5
	nop			;81b6
	nop			;81b7
	nop			;81b8
	nop			;81b9
	nop			;81ba
	nop			;81bb
	nop			;81bc
	nop			;81bd
	nop			;81be
	nop			;81bf
	nop			;81c0
	nop			;81c1
	nop			;81c2
	nop			;81c3
	nop			;81c4
	nop			;81c5
	nop			;81c6
	nop			;81c7
	nop			;81c8
	nop			;81c9
	nop			;81ca
	nop			;81cb
	nop			;81cc
	nop			;81cd
	nop			;81ce
	nop			;81cf
	nop			;81d0
	nop			;81d1
	nop			;81d2
	nop			;81d3
	nop			;81d4
	nop			;81d5
	nop			;81d6
	nop			;81d7
	nop			;81d8
	nop			;81d9
	nop			;81da
	nop			;81db
	nop			;81dc
	nop			;81dd
	nop			;81de
	nop			;81df
	nop			;81e0
	nop			;81e1
	nop			;81e2
	nop			;81e3
	nop			;81e4
	nop			;81e5
	nop			;81e6
	nop			;81e7
	nop			;81e8
	nop			;81e9
	nop			;81ea
	nop			;81eb
	nop			;81ec
	nop			;81ed
	nop			;81ee
	nop			;81ef
	nop			;81f0
	nop			;81f1
	nop			;81f2
	nop			;81f3
	nop			;81f4
	nop			;81f5
	nop			;81f6
	nop			;81f7
	nop			;81f8
	nop			;81f9
	nop			;81fa
	nop			;81fb
	nop			;81fc
	nop			;81fd
	nop			;81fe
	nop			;81ff
	nop			;8200
	nop			;8201
	nop			;8202
	nop			;8203
	nop			;8204
	nop			;8205
	nop			;8206
	nop			;8207
	nop			;8208
	nop			;8209
	nop			;820a
	nop			;820b
	nop			;820c
	nop			;820d
	nop			;820e
	nop			;820f
	nop			;8210
	nop			;8211
	nop			;8212
	nop			;8213
	nop			;8214
	nop			;8215
	nop			;8216
	nop			;8217
	nop			;8218
	nop			;8219
	nop			;821a
	nop			;821b
	nop			;821c
	nop			;821d
	nop			;821e
	nop			;821f
	nop			;8220
	nop			;8221
	nop			;8222
	nop			;8223
	nop			;8224
	nop			;8225
	nop			;8226
	nop			;8227
	nop			;8228
	nop			;8229
	nop			;822a
	nop			;822b
	nop			;822c
	nop			;822d
	nop			;822e
	nop			;822f
	nop			;8230
	nop			;8231
	nop			;8232
	nop			;8233
	nop			;8234
	nop			;8235
	nop			;8236
	nop			;8237
	nop			;8238
	nop			;8239
	nop			;823a
	nop			;823b
	nop			;823c
	nop			;823d
	nop			;823e
	nop			;823f
	nop			;8240
	nop			;8241
	nop			;8242
	nop			;8243
	nop			;8244
	nop			;8245
	nop			;8246
	nop			;8247
	nop			;8248
	nop			;8249
	nop			;824a
	nop			;824b
	nop			;824c
	nop			;824d
	nop			;824e
	nop			;824f
	nop			;8250
	nop			;8251
	nop			;8252
	nop			;8253
	nop			;8254
	nop			;8255
	nop			;8256
	nop			;8257
	nop			;8258
	nop			;8259
	nop			;825a
	nop			;825b
	nop			;825c
	nop			;825d
	nop			;825e
	nop			;825f
	nop			;8260
	nop			;8261
	nop			;8262
	nop			;8263
	nop			;8264
	nop			;8265
	nop			;8266
	nop			;8267
	nop			;8268
	nop			;8269
	nop			;826a
	nop			;826b
	nop			;826c
	nop			;826d
	nop			;826e
	nop			;826f
	nop			;8270
	nop			;8271
	nop			;8272
	nop			;8273
	nop			;8274
	nop			;8275
	nop			;8276
	nop			;8277
	nop			;8278
	nop			;8279
	nop			;827a
	nop			;827b
	nop			;827c
	nop			;827d
	nop			;827e
	nop			;827f
	nop			;8280
	nop			;8281
	nop			;8282
	nop			;8283
	nop			;8284
	nop			;8285
	nop			;8286
	nop			;8287
	nop			;8288
	nop			;8289
	nop			;828a
	nop			;828b
	nop			;828c
	nop			;828d
	nop			;828e
	nop			;828f
	nop			;8290
	nop			;8291
	nop			;8292
	nop			;8293
	nop			;8294
	nop			;8295
	nop			;8296
	nop			;8297
	nop			;8298
	nop			;8299
	nop			;829a
	nop			;829b
	nop			;829c
	nop			;829d
	nop			;829e
	nop			;829f
	nop			;82a0
	nop			;82a1
	nop			;82a2
	nop			;82a3
	nop			;82a4
	nop			;82a5
	nop			;82a6
	nop			;82a7
	nop			;82a8
	nop			;82a9
	nop			;82aa
	nop			;82ab
	nop			;82ac
	nop			;82ad
	nop			;82ae
	nop			;82af
	nop			;82b0
	nop			;82b1
	nop			;82b2
	nop			;82b3
	nop			;82b4
	nop			;82b5
	nop			;82b6
	nop			;82b7
	nop			;82b8
	nop			;82b9
	nop			;82ba
	nop			;82bb
	nop			;82bc
	nop			;82bd
	nop			;82be
	nop			;82bf
	nop			;82c0
	nop			;82c1
	nop			;82c2
	nop			;82c3
	nop			;82c4
	nop			;82c5
	nop			;82c6
	nop			;82c7
	nop			;82c8
	nop			;82c9
	nop			;82ca
	nop			;82cb
	nop			;82cc
	nop			;82cd
	nop			;82ce
	nop			;82cf
	nop			;82d0
	nop			;82d1
	nop			;82d2
	nop			;82d3
	nop			;82d4
	nop			;82d5
	nop			;82d6
	nop			;82d7
	nop			;82d8
	nop			;82d9
	nop			;82da
	nop			;82db
	nop			;82dc
	nop			;82dd
	nop			;82de
	nop			;82df
	nop			;82e0
	nop			;82e1
	nop			;82e2
	nop			;82e3
	nop			;82e4
	nop			;82e5
	nop			;82e6
	nop			;82e7
	nop			;82e8
	nop			;82e9
	nop			;82ea
	nop			;82eb
	nop			;82ec
	nop			;82ed
	nop			;82ee
	nop			;82ef
	nop			;82f0
	nop			;82f1
	nop			;82f2
	nop			;82f3
	nop			;82f4
	nop			;82f5
	nop			;82f6
	nop			;82f7
	nop			;82f8
	nop			;82f9
	nop			;82fa
	nop			;82fb
	nop			;82fc
	nop			;82fd
	nop			;82fe
	nop			;82ff
	nop			;8300
	nop			;8301
	nop			;8302
	nop			;8303
	nop			;8304
	nop			;8305
	nop			;8306
	nop			;8307
	nop			;8308
	nop			;8309
	nop			;830a
	nop			;830b
	nop			;830c
	nop			;830d
	nop			;830e
	nop			;830f
	nop			;8310
	nop			;8311
	nop			;8312
	nop			;8313
	nop			;8314
	nop			;8315
	nop			;8316
	nop			;8317
	nop			;8318
	nop			;8319
	nop			;831a
	nop			;831b
	nop			;831c
	nop			;831d
	nop			;831e
	nop			;831f
	nop			;8320
	nop			;8321
	nop			;8322
	nop			;8323
	nop			;8324
	nop			;8325
	nop			;8326
	nop			;8327
	nop			;8328
	nop			;8329
	nop			;832a
	nop			;832b
	nop			;832c
	nop			;832d
	nop			;832e
	nop			;832f
	nop			;8330
	nop			;8331
	nop			;8332
	nop			;8333
	nop			;8334
	nop			;8335
	nop			;8336
	nop			;8337
	nop			;8338
	nop			;8339
	nop			;833a
	nop			;833b
	nop			;833c
	nop			;833d
	nop			;833e
	nop			;833f
	nop			;8340
	nop			;8341
	nop			;8342
	nop			;8343
	nop			;8344
	nop			;8345
	nop			;8346
	nop			;8347
	nop			;8348
	nop			;8349
	nop			;834a
	nop			;834b
	nop			;834c
	nop			;834d
	nop			;834e
	nop			;834f
	nop			;8350
	nop			;8351
	nop			;8352
	nop			;8353
	nop			;8354
	nop			;8355
	nop			;8356
	nop			;8357
	nop			;8358
	nop			;8359
	nop			;835a
	nop			;835b
	nop			;835c
	nop			;835d
	nop			;835e
	nop			;835f
	nop			;8360
	nop			;8361
	nop			;8362
	nop			;8363
	nop			;8364
	nop			;8365
	nop			;8366
	nop			;8367
	nop			;8368
	nop			;8369
	nop			;836a
	nop			;836b
	nop			;836c
	nop			;836d
	nop			;836e
	nop			;836f
	nop			;8370
	nop			;8371
	nop			;8372
	nop			;8373
	nop			;8374
	nop			;8375
	nop			;8376
	nop			;8377
	nop			;8378
	nop			;8379
	nop			;837a
	nop			;837b
	nop			;837c
	nop			;837d
	nop			;837e
	nop			;837f
	nop			;8380
	nop			;8381
	nop			;8382
	nop			;8383
	nop			;8384
	nop			;8385
	nop			;8386
	nop			;8387
	nop			;8388
	nop			;8389
	nop			;838a
	nop			;838b
	nop			;838c
	nop			;838d
	nop			;838e
	nop			;838f
	nop			;8390
	nop			;8391
	nop			;8392
	nop			;8393
	nop			;8394
	nop			;8395
	nop			;8396
	nop			;8397
	nop			;8398
	nop			;8399
	nop			;839a
	nop			;839b
	nop			;839c
	nop			;839d
	nop			;839e
	nop			;839f
	nop			;83a0
	nop			;83a1
	nop			;83a2
	nop			;83a3
	nop			;83a4
	nop			;83a5
	nop			;83a6
	nop			;83a7
	nop			;83a8
	nop			;83a9
	nop			;83aa
	nop			;83ab
	nop			;83ac
	nop			;83ad
	nop			;83ae
	nop			;83af
	nop			;83b0
	nop			;83b1
	nop			;83b2
	nop			;83b3
	nop			;83b4
	nop			;83b5
	nop			;83b6
	nop			;83b7
	nop			;83b8
	nop			;83b9
	nop			;83ba
	nop			;83bb
	nop			;83bc
	nop			;83bd
	nop			;83be
	nop			;83bf
	nop			;83c0
	nop			;83c1
	nop			;83c2
	nop			;83c3
	nop			;83c4
	nop			;83c5
	nop			;83c6
	nop			;83c7
	nop			;83c8
	nop			;83c9
	nop			;83ca
	nop			;83cb
	nop			;83cc
	nop			;83cd
	nop			;83ce
	nop			;83cf
	nop			;83d0
	nop			;83d1
	nop			;83d2
	nop			;83d3
	nop			;83d4
	nop			;83d5
	nop			;83d6
	nop			;83d7
	nop			;83d8
	nop			;83d9
	nop			;83da
	nop			;83db
	nop			;83dc
	nop			;83dd
	nop			;83de
	nop			;83df
	nop			;83e0
	nop			;83e1
	nop			;83e2
	nop			;83e3
	nop			;83e4
	nop			;83e5
	nop			;83e6
	nop			;83e7
	nop			;83e8
	nop			;83e9
	nop			;83ea
	nop			;83eb
	nop			;83ec
	nop			;83ed
	nop			;83ee
	nop			;83ef
	nop			;83f0
	nop			;83f1
	nop			;83f2
	nop			;83f3
	nop			;83f4
	nop			;83f5
	nop			;83f6
	nop			;83f7
	nop			;83f8
	nop			;83f9
	nop			;83fa
	nop			;83fb
	nop			;83fc
	nop			;83fd
	nop			;83fe
	nop			;83ff
	ld (bc),a			;8400
	ld de,0255fh		;8401
	ld c,e			;8404
	push af			;8405
	sub h			;8406
	dec e			;8407
	dec bc			;8408
	adc a,l			;8409
	ccf			;840a
	ex de,hl			;840b
	adc a,b			;840c
	ret nz			;840d
	cp e			;840e
	call z,0bc66h		;840f
	rst 28h			;8412
	sub h			;8413
	call nc,03cceh		;8414
	add a,h			;8417
	inc hl			;8418
	ret nc			;8419
	ld l,d			;841a
	rst 8			;841b
	or h			;841c
	rst 8			;841d
	exx			;841e
	rst 8			;841f
	ld a,c			;8420
	ex de,hl			;8421
	nop			;8422
	nop			;8423
	nop			;8424
	nop			;8425
	nop			;8426
	nop			;8427
	nop			;8428
	nop			;8429
	nop			;842a
	nop			;842b
	nop			;842c
	nop			;842d
	nop			;842e
	nop			;842f
	nop			;8430
	nop			;8431
	nop			;8432
	nop			;8433
	nop			;8434
	nop			;8435
	nop			;8436
	nop			;8437
	nop			;8438
	nop			;8439
	nop			;843a
	nop			;843b
	cp (hl)			;843c
	cp l			;843d
	rst 18h			;843e
	rst 18h			;843f
	rst 18h			;8440
	ld a,(bc)			;8441
	ld (bc),a			;8442
	cp (hl)			;8443
	cp l			;8444
	cp (hl)			;8445
	or l			;8446
	or b			;8447
	ld a,(bc)			;8448
	ld (bc),a			;8449
	cp (hl)			;844a
	cp l			;844b
	xor l			;844c
	cp d			;844d
	rst 18h			;844e
	ld e,d			;844f
	nop			;8450
	cp (hl)			;8451
	cp l			;8452
	xor l			;8453
	cp d			;8454
	or e			;8455
	ld e,d			;8456
	nop			;8457
	cp (hl)			;8458
	cp l			;8459
	xor l			;845a
	or (hl)			;845b
	xor l			;845c
	ld e,d			;845d
	nop			;845e
	cp (hl)			;845f
	cp l			;8460
	xor l			;8461
	or b			;8462
	rst 18h			;8463
	ld e,d			;8464
	nop			;8465
	cp (hl)			;8466
	cp b			;8467
	cp (hl)			;8468
	xor l			;8469
	xor l			;846a
	ld c,e			;846b
	nop			;846c
	cp (hl)			;846d
	cp b			;846e
	xor d			;846f
	cp (hl)			;8470
	rst 18h			;8471
	ld l,d			;8472
	ld (bc),a			;8473
	cp (hl)			;8474
	cp b			;8475
	xor d			;8476
	or l			;8477
	cp d			;8478
	ld l,l			;8479
	ld (bc),a			;847a
	cp (hl)			;847b
	or e			;847c
	cp c			;847d
	or b			;847e
	or d			;847f
	ld a,002h		;8480
	cp (hl)			;8482
	or c			;8483
	cp (hl)			;8484
	or e			;8485
	cp d			;8486
	ld b,c			;8487
	ld (bc),a			;8488
	cp (hl)			;8489
	or c			;848a
	or (hl)			;848b
	or e			;848c
	or e			;848d
	dec (hl)			;848e
	ld (bc),a			;848f
	cp (hl)			;8490
	xor l			;8491
	rst 18h			;8492
	rst 18h			;8493
	rst 18h			;8494
	add hl,bc			;8495
	ld (bc),a			;8496
	cp (hl)			;8497
	xor l			;8498
	cp l			;8499
	or b			;849a
	or e			;849b
	ld a,a			;849c
	ld (bc),a			;849d
	cp (hl)			;849e
	xor l			;849f
	cp b			;84a0
	or b			;84a1
	or e			;84a2
	ld (hl),c			;84a3
	ld (bc),a			;84a4
	cp (hl)			;84a5
	xor l			;84a6
	xor l			;84a7
	or (hl)			;84a8
	cp l			;84a9
	add hl,bc			;84aa
	ld (bc),a			;84ab
	cp (hl)			;84ac
	xor l			;84ad
	xor l			;84ae
	or b			;84af
	or l			;84b0
	ld c,l			;84b1
	nop			;84b2
	cp l			;84b3
	cp (hl)			;84b4
	or l			;84b5
	cp (hl)			;84b6
	rst 18h			;84b7
	ld a,(bc)			;84b8
	ld (bc),a			;84b9
	cp l			;84ba
	cp (hl)			;84bb
	or l			;84bc
	cp (hl)			;84bd
	xor l			;84be
	ld a,(bc)			;84bf
	ld (bc),a			;84c0
	cp l			;84c1
	cp (hl)			;84c2
	xor h			;84c3
	xor e			;84c4
	or b			;84c5
	ld a,(0bd02h)		;84c6
	cp d			;84c9
	cp l			;84ca
	cp d			;84cb
	rst 18h			;84cc
	ld b,l			;84cd
	nop			;84ce
	cp l			;84cf
	cp d			;84d0
	cp l			;84d1
	cp d			;84d2
	or e			;84d3
	ld b,l			;84d4
	nop			;84d5
	cp l			;84d6
	cp d			;84d7
	cp l			;84d8
	cp d			;84d9
	xor l			;84da
	ld b,l			;84db
	nop			;84dc
	cp l			;84dd
	cp d			;84de
	cp l			;84df
	cp d			;84e0
	xor e			;84e1
	ld b,l			;84e2
	nop			;84e3
	cp l			;84e4
	cp d			;84e5
	cp l			;84e6
	or b			;84e7
	rst 18h			;84e8
	ld b,l			;84e9
	nop			;84ea
	cp l			;84eb
	or b			;84ec
	or e			;84ed
	or (hl)			;84ee
	xor e			;84ef
	ld c,b			;84f0
	ld (bc),a			;84f1
	cp l			;84f2
	or b			;84f3
	or e			;84f4
	or b			;84f5
	or c			;84f6
	djnz $+4		;84f7
	cp l			;84f9
	or b			;84fa
	xor e			;84fb
	cp d			;84fc
	or e			;84fd
	ld d,b			;84fe
	ld (bc),a			;84ff
	cp l			;8500
	xor d			;8501
	or (hl)			;8502
	xor e			;8503
	xor l			;8504
	ld a,l			;8505
	ld (bc),a			;8506
	cp l			;8507
	xor d			;8508
	or e			;8509
	xor d			;850a
	cp h			;850b
	inc d			;850c
	ld (bc),a			;850d
	cp h			;850e
	cp (hl)			;850f
	cp h			;8510
	or a			;8511
	or (hl)			;8512
	dec sp			;8513
	ld (bc),a			;8514
	cp h			;8515
	cp (hl)			;8516
	cp h			;8517
	xor e			;8518
	xor d			;8519
	halt			;851a
	ld (bc),a			;851b
	cp h			;851c
	cp (hl)			;851d
	or e			;851e
	cp (hl)			;851f
	xor c			;8520
	add hl,sp			;8521
	ld (bc),a			;8522
	cp h			;8523
	cp (hl)			;8524
	or c			;8525
	cp (hl)			;8526
	or e			;8527
	ld l,c			;8528
	ld (bc),a			;8529
	cp h			;852a
	cp (hl)			;852b
	xor l			;852c
	cp d			;852d
	xor e			;852e
	ld c,d			;852f
	ld (bc),a			;8530
	cp h			;8531
	cp (hl)			;8532
	xor l			;8533
	cp b			;8534
	cp (hl)			;8535
	ld d,(hl)			;8536
	nop			;8537
	cp h			;8538
	cp (hl)			;8539
	xor l			;853a
	cp b			;853b
	or b			;853c
	ld d,(hl)			;853d
	nop			;853e
	cp h			;853f
	cp (hl)			;8540
	xor h			;8541
	cp h			;8542
	cp (hl)			;8543
	add a,d			;8544
	ld (bc),a			;8545
	cp h			;8546
	cp (hl)			;8547
	and l			;8548
	or b			;8549
	rst 18h			;854a
	inc sp			;854b
	ld (bc),a			;854c
	cp h			;854d
	cp d			;854e
	or e			;854f
	cp e			;8550
	or (hl)			;8551
	ld c,(hl)			;8552
	ld (bc),a			;8553
	cp h			;8554
	cp d			;8555
	xor l			;8556
	cp (hl)			;8557
	rst 18h			;8558
	ld c,b			;8559
	ld (bc),a			;855a
	cp h			;855b
	cp d			;855c
	xor l			;855d
	xor l			;855e
	cp (hl)			;855f
	ld e,e			;8560
	nop			;8561
	cp h			;8562
	cp d			;8563
	xor h			;8564
	xor e			;8565
	cp (hl)			;8566
	inc (hl)			;8567
	ld (bc),a			;8568
	cp h			;8569
	cp d			;856a
	xor h			;856b
	xor e			;856c
	or b			;856d
	inc (hl)			;856e
	ld (bc),a			;856f
	cp h			;8570
	or a			;8571
	or (hl)			;8572
	or e			;8573
	cp (hl)			;8574
	ld b,b			;8575
	ld (bc),a			;8576
	cp h			;8577
	or (hl)			;8578
	cp d			;8579
	xor l			;857a
	xor l			;857b
	ld e,e			;857c
	nop			;857d
	cp h			;857e
	or e			;857f
	cp (hl)			;8580
	xor c			;8581
	cp (hl)			;8582
	ld b,b			;8583
	nop			;8584
	cp h			;8585
	or e			;8586
	cp (hl)			;8587
	xor c			;8588
	or b			;8589
	ld b,b			;858a
	nop			;858b
	cp h			;858c
	or b			;858d
	cp b			;858e
	cp d			;858f
	rst 18h			;8590
	ld c,e			;8591
	nop			;8592
	cp h			;8593
	or b			;8594
	cp b			;8595
	cp d			;8596
	or e			;8597
	ld c,e			;8598
	nop			;8599
	cp h			;859a
	or b			;859b
	cp b			;859c
	cp d			;859d
	xor l			;859e
	ld c,e			;859f
	nop			;85a0
	cp h			;85a1
	or b			;85a2
	or l			;85a3
	or b			;85a4
	rst 18h			;85a5
	ld c,e			;85a6
	nop			;85a7
	cp h			;85a8
	or b			;85a9
	or d			;85aa
	cp d			;85ab
	rst 18h			;85ac
	ld b,(hl)			;85ad
	nop			;85ae
	cp h			;85af
	or b			;85b0
	or d			;85b1
	cp d			;85b2
	or e			;85b3
	ld b,(hl)			;85b4
	nop			;85b5
	cp h			;85b6
	or b			;85b7
	or d			;85b8
	cp d			;85b9
	xor l			;85ba
	ld b,(hl)			;85bb
	nop			;85bc
	cp h			;85bd
	or b			;85be
	or d			;85bf
	cp d			;85c0
	xor e			;85c1
	ld b,(hl)			;85c2
	nop			;85c3
	cp h			;85c4
	or b			;85c5
	or d			;85c6
	or b			;85c7
	rst 18h			;85c8
	ld b,(hl)			;85c9
	nop			;85ca
	cp h			;85cb
	or b			;85cc
	or c			;85cd
	cp e			;85ce
	xor d			;85cf
	ld l,c			;85d0
	ld (bc),a			;85d1
	cp h			;85d2
	or b			;85d3
	or c			;85d4
	or b			;85d5
	rst 18h			;85d6
	add a,c			;85d7
	ld (bc),a			;85d8
	cp h			;85d9
	or b			;85da
	xor a			;85db
	cp (hl)			;85dc
	or e			;85dd
	ld h,(hl)			;85de
	ld (bc),a			;85df
	cp h			;85e0
	xor d			;85e1
	call po,0dfbeh		;85e2
	ld (hl),d			;85e5
	ld (bc),a			;85e6
	cp h			;85e7
	xor d			;85e8
	cp l			;85e9
	xor l			;85ea
	cp d			;85eb
	add hl,sp			;85ec
	nop			;85ed
	cp h			;85ee
	xor d			;85ef
	cp l			;85f0
	xor l			;85f1
	or (hl)			;85f2
	add hl,sp			;85f3
	nop			;85f4
	cp h			;85f5
	xor d			;85f6
	cp l			;85f7
	xor l			;85f8
	or b			;85f9
	add hl,sp			;85fa
	nop			;85fb
	cp h			;85fc
	xor d			;85fd
	or c			;85fe
	cp (hl)			;85ff
	rst 18h			;8600
	ld (hl),d			;8601
	ld (bc),a			;8602
	cp e			;8603
	cp (hl)			;8604
	rst 18h			;8605
	rst 18h			;8606
	rst 18h			;8607
	ld b,d			;8608
	nop			;8609
	cp e			;860a
	cp (hl)			;860b
	or e			;860c
	cp d			;860d
	rst 18h			;860e
	ld b,d			;860f
	nop			;8610
	cp e			;8611
	cp (hl)			;8612
	xor l			;8613
	rst 18h			;8614
	rst 18h			;8615
	ld b,d			;8616
	nop			;8617
	cp e			;8618
	cp (hl)			;8619
	xor l			;861a
	xor h			;861b
	cp d			;861c
	ld b,d			;861d
	nop			;861e
	cp e			;861f
	cp (hl)			;8620
	xor h			;8621
	cp d			;8622
	or e			;8623
	ld b,d			;8624
	nop			;8625
	cp e			;8626
	cp (hl)			;8627
	xor e			;8628
	or (hl)			;8629
	or e			;862a
	ld b,(hl)			;862b
	ld (bc),a			;862c
	cp e			;862d
	cp d			;862e
	rst 18h			;862f
	rst 18h			;8630
	rst 18h			;8631
	inc b			;8632
	inc b			;8633
	cp e			;8634
	cp d			;8635
	cp h			;8636
	or (hl)			;8637
	xor l			;8638
	ld e,c			;8639
	nop			;863a
	cp e			;863b
	cp d			;863c
	cp c			;863d
	cp d			;863e
	or c			;863f
	ld b,c			;8640
	nop			;8641
	cp e			;8642
	cp d			;8643
	cp c			;8644
	or (hl)			;8645
	cp d			;8646
	ld b,c			;8647
	nop			;8648
	cp e			;8649
	cp d			;864a
	or l			;864b
	cp (hl)			;864c
	rst 18h			;864d
	ld c,h			;864e
	nop			;864f
	cp e			;8650
	cp d			;8651
	or l			;8652
	cp (hl)			;8653
	or e			;8654
	ld c,h			;8655
	nop			;8656
	cp e			;8657
	cp d			;8658
	or l			;8659
	cp (hl)			;865a
	xor l			;865b
	ld c,h			;865c
	nop			;865d
	cp e			;865e
	cp d			;865f
	or l			;8660
	or b			;8661
	rst 18h			;8662
	ld c,h			;8663
	nop			;8664
	cp e			;8665
	cp d			;8666
	or e			;8667
	rst 18h			;8668
	rst 18h			;8669
	inc b			;866a
	inc b			;866b
	cp e			;866c
	cp d			;866d
	or c			;866e
	xor e			;866f
	xor l			;8670
	ld (bc),a			;8671
	inc b			;8672
	cp e			;8673
	cp d			;8674
	xor h			;8675
	cp h			;8676
	xor l			;8677
	ld hl,(0bb00h)		;8678
	cp d			;867b
	xor h			;867c
	cp h			;867d
	xor d			;867e
	ld a,(0bb00h)		;867f
	cp d			;8682
	xor h			;8683
	xor e			;8684
	cp (hl)			;8685
	ld a,(0bb00h)		;8686
	or (hl)			;8689
	rst 18h			;868a
	rst 18h			;868b
	rst 18h			;868c
	ld e,c			;868d
	nop			;868e
	cp e			;868f
	or (hl)			;8690
	cp l			;8691
	xor d			;8692
	or l			;8693
	ld l,000h		;8694
	cp e			;8696
	or (hl)			;8697
	cp h			;8698
	cp d			;8699
	xor h			;869a
	ld e,c			;869b
	nop			;869c
	cp e			;869d
	or (hl)			;869e
	cp h			;869f
	or (hl)			;86a0
	cp d			;86a1
	ld e,c			;86a2
	nop			;86a3
	cp e			;86a4
	or (hl)			;86a5
	cp b			;86a6
	or b			;86a7
	rst 18h			;86a8
	ld e,c			;86a9
	nop			;86aa
	cp e			;86ab
	or (hl)			;86ac
	or l			;86ad
	cp d			;86ae
	rst 18h			;86af
	ld e,c			;86b0
	nop			;86b1
	cp e			;86b2
	or (hl)			;86b3
	or e			;86b4
	cp d			;86b5
	rst 18h			;86b6
	ld e,c			;86b7
	nop			;86b8
	cp e			;86b9
	or b			;86ba
	and (hl)			;86bb
	rst 18h			;86bc
	rst 18h			;86bd
	ld b,d			;86be
	nop			;86bf
	cp d			;86c0
	rst 18h			;86c1
	rst 18h			;86c2
	rst 18h			;86c3
	rst 18h			;86c4
	inc bc			;86c5
	ld (bc),a			;86c6
	cp d			;86c7
	cp h			;86c8
	or a			;86c9
	cp (hl)			;86ca
	rst 18h			;86cb
	jr c,$+2		;86cc
	cp d			;86ce
	cp h			;86cf
	or a			;86d0
	cp (hl)			;86d1
	or e			;86d2
	jr c,$+2		;86d3
	cp d			;86d5
	cp h			;86d6
	or a			;86d7
	cp (hl)			;86d8
	xor l			;86d9
	jr c,$+2		;86da
	cp d			;86dc
	cp h			;86dd
	or a			;86de
	or b			;86df
	rst 18h			;86e0
	jr c,$+2		;86e1
	cp d			;86e3
	or d			;86e4
	xor a			;86e5
	xor d			;86e6
	or l			;86e7
	ld d,c			;86e8
	nop			;86e9
	cp d			;86ea
	or c			;86eb
	rst 18h			;86ec
	rst 18h			;86ed
	rst 18h			;86ee
	ld (bc),a			;86ef
	inc b			;86f0
	cp d			;86f1
	or c			;86f2
	xor e			;86f3
	xor l			;86f4
	cp (hl)			;86f5
	dec bc			;86f6
	ld (bc),a			;86f7
	cp d			;86f8
	or c			;86f9
	xor e			;86fa
	xor l			;86fb
	or b			;86fc
	dec bc			;86fd
	ld (bc),a			;86fe
	cp d			;86ff
	xor h			;8700
	cp c			;8701
	cp d			;8702
	xor l			;8703
	ld (hl),002h		;8704
	cp d			;8706
	xor h			;8707
	xor a			;8708
	cp (hl)			;8709
	cp e			;870a
	ld b,a			;870b
	ld (bc),a			;870c
	cp d			;870d
	xor h			;870e
	xor a			;870f
	cp d			;8710
	or l			;8711
	ld b,e			;8712
	ld (bc),a			;8713
	cp d			;8714
	xor h			;8715
	xor a			;8716
	cp d			;8717
	xor l			;8718
	jr z,$+2		;8719
	cp d			;871b
	xor h			;871c
	xor a			;871d
	or (hl)			;871e
	or c			;871f
	ld b,l			;8720
	ld (bc),a			;8721
	cp d			;8722
	xor h			;8723
	xor (hl)			;8724
	xor d			;8725
	cp d			;8726
	rrca			;8727
	ld (bc),a			;8728
	cp d			;8729
	xor h			;872a
	xor e			;872b
	cp (hl)			;872c
	or c			;872d
	ld c,(hl)			;872e
	ld (bc),a			;872f
	cp d			;8730
	xor h			;8731
	xor e			;8732
	cp d			;8733
	rst 18h			;8734
	inc bc			;8735
	ld (bc),a			;8736
	cp d			;8737
	and a			;8738
	rst 18h			;8739
	rst 18h			;873a
	rst 18h			;873b
	inc l			;873c
	nop			;873d
	cp d			;873e
	and a			;873f
	cp (hl)			;8740
	or d			;8741
	or (hl)			;8742
	inc l			;8743
	nop			;8744
	cp c			;8745
	rst 18h			;8746
	rst 18h			;8747
	rst 18h			;8748
	rst 18h			;8749
	dec hl			;874a
	nop			;874b
	cp c			;874c
	or (hl)			;874d
	or e			;874e
	xor e			;874f
	xor l			;8750
	ld c,a			;8751
	ld (bc),a			;8752
	cp c			;8753
	or (hl)			;8754
	or c			;8755
	rst 18h			;8756
	rst 18h			;8757
	dec hl			;8758
	nop			;8759
	cp c			;875a
	xor l			;875b
	cp (hl)			;875c
	xor h			;875d
	cp h			;875e
	ld c,a			;875f
	ld (bc),a			;8760
	cp c			;8761
	xor l			;8762
	xor d			;8763
	xor e			;8764
	cp (hl)			;8765
	ld c,e			;8766
	ld (bc),a			;8767
	cp c			;8768
	xor l			;8769
	xor d			;876a
	xor e			;876b
	or b			;876c
	ld c,e			;876d
	ld (bc),a			;876e
	cp b			;876f
	rst 18h			;8770
	rst 18h			;8771
	rst 18h			;8772
	rst 18h			;8773
	ld l,000h		;8774
	cp b			;8776
	cp (hl)			;8777
	xor h			;8778
	rst 18h			;8779
	rst 18h			;877a
	ld l,(hl)			;877b
	ld (bc),a			;877c
	cp b			;877d
	or (hl)			;877e
	cp b			;877f
	cp (hl)			;8780
	or c			;8781
	ld de,0b802h		;8782
	or (hl)			;8785
	xor l			;8786
	cp (hl)			;8787
	rst 18h			;8788
	ld d,d			;8789
	nop			;878a
	cp b			;878b
	or (hl)			;878c
	xor l			;878d
	cp (hl)			;878e
	or e			;878f
	ld d,d			;8790
	nop			;8791
	cp b			;8792
	or (hl)			;8793
	xor l			;8794
	cp (hl)			;8795
	xor l			;8796
	ld d,d			;8797
	nop			;8798
	cp b			;8799
	or (hl)			;879a
	xor l			;879b
	or b			;879c
	rst 18h			;879d
	ld d,d			;879e
	nop			;879f
	cp b			;87a0
	or b			;87a1
	or e			;87a2
	xor a			;87a3
	cp d			;87a4
	inc a			;87a5
	nop			;87a6
	cp b			;87a7
	xor l			;87a8
	cp (hl)			;87a9
	cp l			;87aa
	cp (hl)			;87ab
	ld d,l			;87ac
	nop			;87ad
	cp b			;87ae
	xor l			;87af
	cp (hl)			;87b0
	cp l			;87b1
	or b			;87b2
	ld d,l			;87b3
	nop			;87b4
	cp b			;87b5
	xor l			;87b6
	cp (hl)			;87b7
	cp c			;87b8
	or (hl)			;87b9
	ld l,000h		;87ba
	or a			;87bc
	cp (hl)			;87bd
	cp l			;87be
	or e			;87bf
	cp (hl)			;87c0
	ld e,c			;87c1
	nop			;87c2
	or a			;87c3
	cp (hl)			;87c4
	cp h			;87c5
	cp d			;87c6
	xor l			;87c7
	ld d,a			;87c8
	nop			;87c9
	or a			;87ca
	cp (hl)			;87cb
	cp b			;87cc
	or b			;87cd
	rst 18h			;87ce
	ld d,a			;87cf
	nop			;87d0
	or a			;87d1
	cp (hl)			;87d2
	and l			;87d3
	rst 18h			;87d4
	rst 18h			;87d5
	ld d,a			;87d6
	nop			;87d7
	or a			;87d8
	or (hl)			;87d9
	cp d			;87da
	or e			;87db
	or b			;87dc
	ld (hl),h			;87dd
	ld (bc),a			;87de
	or a			;87df
	or b			;87e0
	or c			;87e1
	cp b			;87e2
	or b			;87e3
	scf			;87e4
	ld (bc),a			;87e5
	or a			;87e6
	xor d			;87e7
	or (hl)			;87e8
	xor e			;87e9
	and l			;87ea
	inc d			;87eb
	ld (bc),a			;87ec
	or a			;87ed
	xor d			;87ee
	or d			;87ef
	or b			;87f0
	rst 18h			;87f1
	ld h,l			;87f2
	ld (bc),a			;87f3
	or (hl)			;87f4
	rst 18h			;87f5
	rst 18h			;87f6
	rst 18h			;87f7
	rst 18h			;87f8
	add hl,hl			;87f9
	nop			;87fa
	or (hl)			;87fb
	or c			;87fc
	xor e			;87fd
	cp d			;87fe
	or e			;87ff
	xor (hl)			;8800
	ld (bc),a			;8801
	or (hl)			;8802
	or c			;8803
	xor c			;8804
	cp d			;8805
	or c			;8806
	add hl,hl			;8807
	nop			;8808
	or l			;8809
	cp (hl)			;880a
	xor l			;880b
	xor l			;880c
	cp (hl)			;880d
	ld c,c			;880e
	ld (bc),a			;880f
	or h			;8810
	cp (hl)			;8811
	xor a			;8812
	xor a			;8813
	or b			;8814
	ld a,a			;8815
	ld (bc),a			;8816
	or h			;8817
	xor d			;8818
	or (hl)			;8819
	or e			;881a
	or e			;881b
	inc de			;881c
	ld (bc),a			;881d
	or e			;881e
	cp (hl)			;881f
	cp b			;8820
	or b			;8821
	rst 18h			;8822
	ld (hl),l			;8823
	ld (bc),a			;8824
	or e			;8825
	cp (hl)			;8826
	cp b			;8827
	xor d			;8828
	or c			;8829
	ld (hl),l			;882a
	ld (bc),a			;882b
	or e			;882c
	cp (hl)			;882d
	or c			;882e
	and l			;882f
	cp (hl)			;8830
	ld c,l			;8831
	nop			;8832
	or e			;8833
	cp (hl)			;8834
	or c			;8835
	and l			;8836
	or b			;8837
	ld c,l			;8838
	nop			;8839
	or e			;883a
	cp d			;883b
	cp d			;883c
	rst 18h			;883d
	rst 18h			;883e
	inc l			;883f
	nop			;8840
	or e			;8841
	cp d			;8842
	cp d			;8843
	or e			;8844
	cp (hl)			;8845
	inc l			;8846
	nop			;8847
	or e			;8848
	cp d			;8849
	cp d			;884a
	or e			;884b
	or b			;884c
	inc l			;884d
	nop			;884e
	or e			;884f
	cp d			;8850
	cp d			;8851
	xor l			;8852
	rst 18h			;8853
	inc l			;8854
	nop			;8855
	or e			;8856
	cp d			;8857
	cp d			;8858
	xor l			;8859
	or e			;885a
	inc l			;885b
	nop			;885c
	or e			;885d
	cp d			;885e
	or b			;885f
	rst 18h			;8860
	rst 18h			;8861
	inc l			;8862
	nop			;8863
	or e			;8864
	cp d			;8865
	xor c			;8866
	cp (hl)			;8867
	or c			;8868
	ld d,c			;8869
	nop			;886a
	or e			;886b
	or (hl)			;886c
	cp l			;886d
	xor l			;886e
	or b			;886f
	ld b,d			;8870
	ld (bc),a			;8871
	or e			;8872
	or (hl)			;8873
	xor (hl)			;8874
	xor d			;8875
	or (hl)			;8876
	ld d,b			;8877
	ld (bc),a			;8878
	or e			;8879
	or e			;887a
	cp (hl)			;887b
	xor c			;887c
	cp d			;887d
	ld c,l			;887e
	ld (bc),a			;887f
	or e			;8880
	or e			;8881
	cp d			;8882
	or c			;8883
	cp (hl)			;8884
	scf			;8885
	nop			;8886
	or e			;8887
	or e			;8888
	cp d			;8889
	or c			;888a
	or b			;888b
	scf			;888c
	nop			;888d
	or e			;888e
	or b			;888f
	cp (hl)			;8890
	cp e			;8891
	rst 18h			;8892
	ld d,(hl)			;8893
	nop			;8894
	or e			;8895
	or b			;8896
	xor h			;8897
	cp (hl)			;8898
	rst 18h			;8899
	ld (hl),b			;889a
	ld (bc),a			;889b
	or e			;889c
	xor l			;889d
	rst 18h			;889e
	rst 18h			;889f
	rst 18h			;88a0
	inc (hl)			;88a1
	nop			;88a2
	or e			;88a3
	xor d			;88a4
	cp h			;88a5
	or a			;88a6
	cp (hl)			;88a7
	ld b,c			;88a8
	nop			;88a9
	or e			;88aa
	xor d			;88ab
	cp h			;88ac
	or a			;88ad
	or b			;88ae
	ld b,c			;88af
	nop			;88b0
	or d			;88b1
	rst 18h			;88b2
	rst 18h			;88b3
	rst 18h			;88b4
	rst 18h			;88b5
	ld hl,(0b200h)		;88b6
	cp (hl)			;88b9
	or c			;88ba
	or b			;88bb
	rst 18h			;88bc
	ld a,h			;88bd
	ld (bc),a			;88be
	or d			;88bf
	cp (hl)			;88c0
	xor h			;88c1
	cp h			;88c2
	cp (hl)			;88c3
	ld c,d			;88c4
	ld (bc),a			;88c5
	or d			;88c6
	cp (hl)			;88c7
	xor e			;88c8
	cp (hl)			;88c9
	rst 18h			;88ca
	ld b,c			;88cb
	nop			;88cc
	or d			;88cd
	cp (hl)			;88ce
	xor e			;88cf
	cp (hl)			;88d0
	or e			;88d1
	ld b,c			;88d2
	nop			;88d3
	or d			;88d4
	cp (hl)			;88d5
	xor e			;88d6
	cp (hl)			;88d7
	xor l			;88d8
	ld b,c			;88d9
	nop			;88da
	or d			;88db
	cp (hl)			;88dc
	xor e			;88dd
	or b			;88de
	rst 18h			;88df
	ld b,c			;88e0
	nop			;88e1
	or d			;88e2
	cp (hl)			;88e3
	and l			;88e4
	or b			;88e5
	rst 18h			;88e6
	inc a			;88e7
	ld (bc),a			;88e8
	or d			;88e9
	cp d			;88ea
	xor e			;88eb
	cp d			;88ec
	rst 18h			;88ed
	ld c,c			;88ee
	nop			;88ef
	or d			;88f0
	cp d			;88f1
	xor e			;88f2
	cp d			;88f3
	or e			;88f4
	ld c,c			;88f5
	nop			;88f6
	or d			;88f7
	cp d			;88f8
	xor e			;88f9
	cp d			;88fa
	xor l			;88fb
	ld c,c			;88fc
	nop			;88fd
	or d			;88fe
	cp d			;88ff
	xor e			;8900
	or b			;8901
	rst 18h			;8902
	ld c,c			;8903
	nop			;8904
	or d			;8905
	or (hl)			;8906
	cp d			;8907
	or e			;8908
	rst 18h			;8909
	ld c,c			;890a
	ld (bc),a			;890b
	or d			;890c
	or (hl)			;890d
	xor l			;890e
	cp (hl)			;890f
	rst 18h			;8910
	ld hl,(0b200h)		;8911
	or (hl)			;8914
	xor l			;8915
	cp (hl)			;8916
	xor l			;8917
	ld hl,(0b200h)		;8918
	or (hl)			;891b
	xor l			;891c
	or b			;891d
	rst 18h			;891e
	ld hl,(0b200h)		;891f
	or b			;8922
	xor c			;8923
	cp d			;8924
	xor l			;8925
	ld d,c			;8926
	nop			;8927
	or d			;8928
	xor d			;8929
	cp d			;892a
	xor l			;892b
	xor e			;892c
	add a,b			;892d
	ld (bc),a			;892e
	or d			;892f
	xor d			;8930
	cp d			;8931
	xor c			;8932
	cp d			;8933
	ld d,c			;8934
	nop			;8935
	or d			;8936
	xor d			;8937
	cp d			;8938
	xor c			;8939
	or b			;893a
	ld d,c			;893b
	nop			;893c
	or d			;893d
	xor d			;893e
	xor l			;893f
	or b			;8940
	rst 18h			;8941
	ld (hl),h			;8942
	ld (bc),a			;8943
	or c			;8944
	rst 18h			;8945
	rst 18h			;8946
	rst 18h			;8947
	rst 18h			;8948
	ld bc,0b102h		;8949
	cp (hl)			;894c
	cp e			;894d
	cp (hl)			;894e
	rst 18h			;894f
	ld b,e			;8950
	nop			;8951
	or c			;8952
	cp (hl)			;8953
	cp e			;8954
	cp (hl)			;8955
	xor l			;8956
	ld b,e			;8957
	nop			;8958
	or c			;8959
	cp (hl)			;895a
	cp e			;895b
	or b			;895c
	rst 18h			;895d
	ld b,e			;895e
	nop			;895f
	or c			;8960
	cp d			;8961
	rst 18h			;8962
	rst 18h			;8963
	rst 18h			;8964
	dec b			;8965
	ld (bc),a			;8966
	or c			;8967
	or (hl)			;8968
	cp h			;8969
	or a			;896a
	or b			;896b
	ld c,(hl)			;896c
	ld (bc),a			;896d
	or c			;896e
	or b			;896f
	rst 18h			;8970
	rst 18h			;8971
	rst 18h			;8972
	ld b,002h		;8973
	or c			;8975
	or b			;8976
	xor l			;8977
	cp d			;8978
	xor h			;8979
	dec b			;897a
	ld (bc),a			;897b
	or c			;897c
	or b			;897d
	xor l			;897e
	or b			;897f
	cp d			;8980
	ld b,002h		;8981
	or c			;8983
	or b			;8984
	xor l			;8985
	xor e			;8986
	cp d			;8987
	ld bc,0b002h		;8988
	rst 18h			;898b
	rst 18h			;898c
	rst 18h			;898d
	rst 18h			;898e
	inc b			;898f
	ld (bc),a			;8990
	or b			;8991
	cp (hl)			;8992
	xor h			;8993
	or (hl)			;8994
	xor h			;8995
	ld a,c			;8996
	ld (bc),a			;8997
	or b			;8998
	cp h			;8999
	xor d			;899a
	or e			;899b
	xor e			;899c
	add hl,sp			;899d
	nop			;899e
	or b			;899f
	cp d			;89a0
	xor h			;89a1
	xor e			;89a2
	cp d			;89a3
	inc b			;89a4
	ld (bc),a			;89a5
	or b			;89a6
	cp c			;89a7
	cp c			;89a8
	rst 18h			;89a9
	rst 18h			;89aa
	ld (0b003h),a		;89ab
	or (hl)			;89ae
	cp e			;89af
	or b			;89b0
	xor h			;89b1
	ld a,d			;89b2
	ld (bc),a			;89b3
	or b			;89b4
	xor l			;89b5
	cp d			;89b6
	or l			;89b7
	cp (hl)			;89b8
	ld a,d			;89b9
	ld (bc),a			;89ba
	xor a			;89bb
	rst 18h			;89bc
	rst 18h			;89bd
	rst 18h			;89be
	rst 18h			;89bf
	ei			;89c0
	ld (bc),a			;89c1
	xor a			;89c2
	cp (hl)			;89c3
	or e			;89c4
	or d			;89c5
	cp d			;89c6
	ld (hl),a			;89c7
	ld (bc),a			;89c8
	xor a			;89c9
	cp (hl)			;89ca
	xor a			;89cb
	cp (hl)			;89cc
	xor h			;89cd
	sbc a,h			;89ce
	ld (bc),a			;89cf
	xor a			;89d0
	cp (hl)			;89d1
	xor l			;89d2
	cp d			;89d3
	cp e			;89d4
	ld (hl),h			;89d5
	ld (bc),a			;89d6
	xor a			;89d7
	cp (hl)			;89d8
	xor h			;89d9
	cp (hl)			;89da
	rst 18h			;89db
	dec sp			;89dc
	nop			;89dd
	xor a			;89de
	cp (hl)			;89df
	xor h			;89e0
	cp (hl)			;89e1
	or e			;89e2
	dec sp			;89e3
	nop			;89e4
	xor a			;89e5
	cp (hl)			;89e6
	xor h			;89e7
	cp (hl)			;89e8
	xor l			;89e9
	dec sp			;89ea
	nop			;89eb
	xor a			;89ec
	cp (hl)			;89ed
	xor h			;89ee
	or (hl)			;89ef
	or e			;89f0
	ld l,b			;89f1
	ld (bc),a			;89f2
	xor a			;89f3
	cp (hl)			;89f4
	xor h			;89f5
	or b			;89f6
	rst 18h			;89f7
	dec sp			;89f8
	nop			;89f9
	xor a			;89fa
	cp (hl)			;89fb
	xor h			;89fc
	xor e			;89fd
	cp (hl)			;89fe
	ld h,(hl)			;89ff
	ld (bc),a			;8a00
	xor a			;8a01
	or (hl)			;8a02
	cp d			;8a03
	cp e			;8a04
	xor l			;8a05
	ld a,e			;8a06
	ld (bc),a			;8a07
	xor a			;8a08
	or (hl)			;8a09
	or c			;8a0a
	cp h			;8a0b
	or a			;8a0c
	ld b,l			;8a0d
	ld (bc),a			;8a0e
	xor a			;8a0f
	or (hl)			;8a10
	xor h			;8a11
	cp (hl)			;8a12
	rst 18h			;8a13
	inc a			;8a14
	nop			;8a15
	xor a			;8a16
	or (hl)			;8a17
	xor h			;8a18
	cp (hl)			;8a19
	or e			;8a1a
	inc a			;8a1b
	nop			;8a1c
	xor a			;8a1d
	or (hl)			;8a1e
	xor h			;8a1f
	cp (hl)			;8a20
	xor l			;8a21
	inc a			;8a22
	nop			;8a23
	xor a			;8a24
	or (hl)			;8a25
	xor h			;8a26
	or b			;8a27
	rst 18h			;8a28
	inc a			;8a29
	nop			;8a2a
	xor a			;8a2b
	or b			;8a2c
	or c			;8a2d
	rst 18h			;8a2e
	rst 18h			;8a2f
	ld b,a			;8a30
	nop			;8a31
	xor a			;8a32
	or b			;8a33
	or c			;8a34
	cp d			;8a35
	xor l			;8a36
	ld b,a			;8a37
	nop			;8a38
	xor a			;8a39
	or b			;8a3a
	or c			;8a3b
	cp b			;8a3c
	or b			;8a3d
	ld b,a			;8a3e
	nop			;8a3f
	xor a			;8a40
	or b			;8a41
	or c			;8a42
	or e			;8a43
	cp (hl)			;8a44
	ld b,a			;8a45
	nop			;8a46
	xor a			;8a47
	or b			;8a48
	or c			;8a49
	or e			;8a4a
	or b			;8a4b
	ld b,a			;8a4c
	nop			;8a4d
	xor a			;8a4e
	or b			;8a4f
	or c			;8a50
	xor e			;8a51
	cp d			;8a52
	ld b,a			;8a53
	nop			;8a54
	xor a			;8a55
	or b			;8a56
	xor a			;8a57
	or b			;8a58
	or e			;8a59
	ccf			;8a5a
	ld (bc),a			;8a5b
	xor a			;8a5c
	or b			;8a5d
	xor l			;8a5e
	rst 18h			;8a5f
	rst 18h			;8a60
	inc bc			;8a61
	inc b			;8a62
	xor a			;8a63
	or b			;8a64
	xor l			;8a65
	xor l			;8a66
	cp (hl)			;8a67
	dec sp			;8a68
	ld (bc),a			;8a69
	xor a			;8a6a
	xor l			;8a6b
	cp d			;8a6c
	cp b			;8a6d
	xor d			;8a6e
	ld e,c			;8a6f
	nop			;8a70
	xor a			;8a71
	xor d			;8a72
	call po,0bbbeh		;8a73
	ld b,l			;8a76
	ld (bc),a			;8a77
	xor a			;8a78
	xor d			;8a79
	cp (hl)			;8a7a
	rst 18h			;8a7b
	rst 18h			;8a7c
	ld b,l			;8a7d
	ld (bc),a			;8a7e
	xor a			;8a7f
	xor d			;8a80
	cp (hl)			;8a81
	xor h			;8a82
	rst 18h			;8a83
	ld b,l			;8a84
	ld (bc),a			;8a85
	xor a			;8a86
	xor d			;8a87
	cp d			;8a88
	xor l			;8a89
	xor e			;8a8a
	ld l,a			;8a8b
	ld (bc),a			;8a8c
	xor a			;8a8d
	xor d			;8a8e
	or c			;8a8f
	cp (hl)			;8a90
	cp e			;8a91
	ld b,l			;8a92
	ld (bc),a			;8a93
	xor (hl)			;8a94
	xor d			;8a95
	or (hl)			;8a96
	xor e			;8a97
	cp (hl)			;8a98
	ld c,b			;8a99
	nop			;8a9a
	xor (hl)			;8a9b
	xor d			;8a9c
	or (hl)			;8a9d
	xor e			;8a9e
	or b			;8a9f
	ld c,b			;8aa0
	nop			;8aa1
	xor l			;8aa2
	rst 18h			;8aa3
	rst 18h			;8aa4
	rst 18h			;8aa5
	rst 18h			;8aa6
	ld hl,(0ad00h)		;8aa7
	cp (hl)			;8aaa
	cp h			;8aab
	or (hl)			;8aac
	or d			;8aad
	ld b,(hl)			;8aae
	ld (bc),a			;8aaf
	xor l			;8ab0
	cp (hl)			;8ab1
	or d			;8ab2
	rst 18h			;8ab3
	rst 18h			;8ab4
	or b			;8ab5
	ld (bc),a			;8ab6
	xor l			;8ab7
	cp (hl)			;8ab8
	or d			;8ab9
	xor a			;8aba
	cp (hl)			;8abb
	ld a,(hl)			;8abc
	ld (bc),a			;8abd
	xor l			;8abe
	cp (hl)			;8abf
	or c			;8ac0
	xor d			;8ac1
	xor l			;8ac2
	ld h,a			;8ac3
	ld (bc),a			;8ac4
	xor l			;8ac5
	or (hl)			;8ac6
	cp h			;8ac7
	or b			;8ac8
	rst 18h			;8ac9
	ld e,h			;8aca
	nop			;8acb
	xor l			;8acc
	or e			;8acd
	rst 18h			;8ace
	rst 18h			;8acf
	rst 18h			;8ad0
	inc (hl)			;8ad1
	nop			;8ad2
	xor l			;8ad3
	or b			;8ad4
	cp h			;8ad5
	cp (hl)			;8ad6
	rst 18h			;8ad7
	ld a,e			;8ad8
	ld (bc),a			;8ad9
	xor l			;8ada
	or b			;8adb
	cp h			;8adc
	cp (hl)			;8add
	xor h			;8ade
	ld a,e			;8adf
	ld (bc),a			;8ae0
	xor l			;8ae1
	or b			;8ae2
	or d			;8ae3
	xor a			;8ae4
	cp d			;8ae5
	ld d,e			;8ae6
	nop			;8ae7
	xor l			;8ae8
	or b			;8ae9
	or d			;8aea
	xor a			;8aeb
	or b			;8aec
	ld d,e			;8aed
	nop			;8aee
	xor l			;8aef
	or b			;8af0
	xor h			;8af1
	cp (hl)			;8af2
	rst 18h			;8af3
	ld b,h			;8af4
	ld (bc),a			;8af5
	xor l			;8af6
	or b			;8af7
	xor h			;8af8
	cp (hl)			;8af9
	xor h			;8afa
	ld b,h			;8afb
	ld (bc),a			;8afc
	xor l			;8afd
	xor h			;8afe
	rst 18h			;8aff
	rst 18h			;8b00
	rst 18h			;8b01
	inc sp			;8b02
	nop			;8b03
	xor h			;8b04
	rst 18h			;8b05
	rst 18h			;8b06
	rst 18h			;8b07
	rst 18h			;8b08
	ld (bc),a			;8b09
	ld (bc),a			;8b0a
	xor h			;8b0b
	cp (hl)			;8b0c
	cp h			;8b0d
	cp (hl)			;8b0e
	rst 18h			;8b0f
	ld c,d			;8b10
	nop			;8b11
	xor h			;8b12
	cp (hl)			;8b13
	cp h			;8b14
	cp (hl)			;8b15
	or e			;8b16
	ld c,d			;8b17
	nop			;8b18
	xor h			;8b19
	cp (hl)			;8b1a
	cp h			;8b1b
	cp (hl)			;8b1c
	xor l			;8b1d
	ld c,d			;8b1e
	nop			;8b1f
	xor h			;8b20
	cp (hl)			;8b21
	cp h			;8b22
	cp d			;8b23
	xor l			;8b24
	ld h,h			;8b25
	ld (bc),a			;8b26
	xor h			;8b27
	cp (hl)			;8b28
	cp h			;8b29
	or b			;8b2a
	rst 18h			;8b2b
	ld c,d			;8b2c
	nop			;8b2d
	xor h			;8b2e
	cp (hl)			;8b2f
	cp h			;8b30
	xor d			;8b31
	cp e			;8b32
	ld d,c			;8b33
	nop			;8b34
	xor h			;8b35
	cp (hl)			;8b36
	or e			;8b37
	rst 18h			;8b38
	rst 18h			;8b39
	inc c			;8b3a
	ld (bc),a			;8b3b
	xor h			;8b3c
	cp (hl)			;8b3d
	or e			;8b3e
	cp b			;8b3f
	or b			;8b40
	inc c			;8b41
	ld (bc),a			;8b42
	xor h			;8b43
	cp (hl)			;8b44
	or e			;8b45
	or (hl)			;8b46
	cp e			;8b47
	ld (0ac00h),a		;8b48
	cp (hl)			;8b4b
	or e			;8b4c
	or (hl)			;8b4d
	xor l			;8b4e
	inc c			;8b4f
	ld (bc),a			;8b50
	xor h			;8b51
	cp (hl)			;8b52
	or e			;8b53
	xor e			;8b54
	cp (hl)			;8b55
	dec c			;8b56
	ld (bc),a			;8b57
	xor h			;8b58
	cp (hl)			;8b59
	or e			;8b5a
	xor e			;8b5b
	or b			;8b5c
	dec c			;8b5d
	ld (bc),a			;8b5e
	xor h			;8b5f
	cp (hl)			;8b60
	xor c			;8b61
	cp d			;8b62
	rst 18h			;8b63
	ld d,l			;8b64
	nop			;8b65
	xor h			;8b66
	cp d			;8b67
	call po,0adb0h		;8b68
	ld b,d			;8b6b
	ld (bc),a			;8b6c
	xor h			;8b6d
	cp d			;8b6e
	rst 18h			;8b6f
	rst 18h			;8b70
	rst 18h			;8b71
	rlca			;8b72
	ld (bc),a			;8b73
	xor h			;8b74
	cp d			;8b75
	cp b			;8b76
	xor d			;8b77
	or (hl)			;8b78
	ccf			;8b79
	nop			;8b7a
	xor h			;8b7b
	cp d			;8b7c
	or c			;8b7d
	or b			;8b7e
	xor l			;8b7f
	ld b,d			;8b80
	ld (bc),a			;8b81
	xor h			;8b82
	or (hl)			;8b83
	rst 18h			;8b84
	rst 18h			;8b85
	rst 18h			;8b86
	jr nc,$+4		;8b87
	xor h			;8b89
	or (hl)			;8b8a
	cp b			;8b8b
	or b			;8b8c
	rst 18h			;8b8d
	ccf			;8b8e
	nop			;8b8f
	xor h			;8b90
	or (hl)			;8b91
	cp b			;8b92
	xor d			;8b93
	cp d			;8b94
	ccf			;8b95
	nop			;8b96
	xor h			;8b97
	or (hl)			;8b98
	xor a			;8b99
	cp (hl)			;8b9a
	cp h			;8b9b
	ld de,0ac02h		;8b9c
	or b			;8b9f
	rst 18h			;8ba0
	rst 18h			;8ba1
	rst 18h			;8ba2
	ex af,af'			;8ba3
	ld (bc),a			;8ba4
	xor h			;8ba5
	or b			;8ba6
	cp l			;8ba7
	xor l			;8ba8
	cp d			;8ba9
	ld (bc),a			;8baa
	inc b			;8bab
	xor h			;8bac
	or b			;8bad
	or e			;8bae
	rst 18h			;8baf
	rst 18h			;8bb0
	ld (hl),e			;8bb1
	ld (bc),a			;8bb2
	xor h			;8bb3
	or b			;8bb4
	or e			;8bb5
	xor e			;8bb6
	cp (hl)			;8bb7
	ld c,h			;8bb8
	nop			;8bb9
	xor h			;8bba
	or b			;8bbb
	or d			;8bbc
	cp l			;8bbd
	xor l			;8bbe
	djnz $+4		;8bbf
	xor h			;8bc1
	or b			;8bc2
	xor a			;8bc3
	or b			;8bc4
	xor l			;8bc5
	ld (0ac02h),a		;8bc6
	xor l			;8bc9
	rst 18h			;8bca
	rst 18h			;8bcb
	rst 18h			;8bcc
	inc sp			;8bcd
	nop			;8bce
	xor h			;8bcf
	xor d			;8bd0
	cp l			;8bd1
	cp d			;8bd2
	rst 18h			;8bd3
	add hl,bc			;8bd4
	ld (bc),a			;8bd5
	xor h			;8bd6
	xor d			;8bd7
	cp l			;8bd8
	or (hl)			;8bd9
	xor l			;8bda
	add hl,bc			;8bdb
	ld (bc),a			;8bdc
	xor h			;8bdd
	xor d			;8bde
	cp l			;8bdf
	or b			;8be0
	rst 18h			;8be1
	add hl,bc			;8be2
	ld (bc),a			;8be3
	xor h			;8be4
	xor d			;8be5
	cp d			;8be6
	or e			;8be7
	or b			;8be8
	ld l,h			;8be9
	ld (bc),a			;8bea
	xor h			;8beb
	xor d			;8bec
	cp d			;8bed
	or e			;8bee
	xor e			;8bef
	ld c,h			;8bf0
	nop			;8bf1
	xor h			;8bf2
	xor d			;8bf3
	xor l			;8bf4
	rst 18h			;8bf5
	rst 18h			;8bf6
	ld (bc),a			;8bf7
	ld (bc),a			;8bf8
	xor h			;8bf9
	xor d			;8bfa
	xor l			;8bfb
	cp d			;8bfc
	xor h			;8bfd
	rlca			;8bfe
	ld (bc),a			;8bff
	xor h			;8c00
	xor d			;8c01
	xor l			;8c02
	or b			;8c03
	cp d			;8c04
	ex af,af'			;8c05
	ld (bc),a			;8c06
	xor e			;8c07
	rst 18h			;8c08
	rst 18h			;8c09
	rst 18h			;8c0a
	rst 18h			;8c0b
	cpl			;8c0c
	nop			;8c0d
	xor e			;8c0e
	cp (hl)			;8c0f
	xor a			;8c10
	cp (hl)			;8c11
	rst 18h			;8c12
	add hl,sp			;8c13
	nop			;8c14
	xor e			;8c15
	cp (hl)			;8c16
	xor a			;8c17
	cp (hl)			;8c18
	or e			;8c19
	add hl,sp			;8c1a
	nop			;8c1b
	xor e			;8c1c
	cp (hl)			;8c1d
	xor a			;8c1e
	cp (hl)			;8c1f
	xor l			;8c20
	add hl,sp			;8c21
	nop			;8c22
	xor e			;8c23
	cp (hl)			;8c24
	xor a			;8c25
	or b			;8c26
	rst 18h			;8c27
	add hl,sp			;8c28
	nop			;8c29
	xor e			;8c2a
	cp (hl)			;8c2b
	xor a			;8c2c
	or b			;8c2d
	or c			;8c2e
	ld c,b			;8c2f
	ld (bc),a			;8c30
	xor e			;8c31
	cp d			;8c32
	or c			;8c33
	rst 18h			;8c34
	rst 18h			;8c35
	dec a			;8c36
	nop			;8c37
	xor e			;8c38
	cp d			;8c39
	and a			;8c3a
	xor e			;8c3b
	or b			;8c3c
	cpl			;8c3d
	nop			;8c3e
	xor e			;8c3f
	cp d			;8c40
	and l			;8c41
	cp h			;8c42
	cp (hl)			;8c43
	djnz $+4		;8c44
	xor e			;8c46
	or (hl)			;8c47
	xor l			;8c48
	cp (hl)			;8c49
	rst 18h			;8c4a
	ld c,l			;8c4b
	nop			;8c4c
	xor e			;8c4d
	or (hl)			;8c4e
	xor l			;8c4f
	cp (hl)			;8c50
	or e			;8c51
	ld c,l			;8c52
	nop			;8c53
	xor e			;8c54
	or (hl)			;8c55
	xor l			;8c56
	cp (hl)			;8c57
	xor l			;8c58
	ld c,l			;8c59
	nop			;8c5a
	xor e			;8c5b
	or (hl)			;8c5c
	xor l			;8c5d
	or b			;8c5e
	rst 18h			;8c5f
	ld c,l			;8c60
	nop			;8c61
	xor e			;8c62
	or b			;8c63
	cp h			;8c64
	cp (hl)			;8c65
	rst 18h			;8c66
	dec a			;8c67
	nop			;8c68
	xor e			;8c69
	or b			;8c6a
	cp h			;8c6b
	cp (hl)			;8c6c
	or e			;8c6d
	dec a			;8c6e
	nop			;8c6f
	xor e			;8c70
	or b			;8c71
	cp h			;8c72
	cp (hl)			;8c73
	xor l			;8c74
	dec a			;8c75
	nop			;8c76
	xor e			;8c77
	or b			;8c78
	cp h			;8c79
	or b			;8c7a
	rst 18h			;8c7b
	dec a			;8c7c
	nop			;8c7d
	xor e			;8c7e
	or b			;8c7f
	cp e			;8c80
	or b			;8c81
	rst 18h			;8c82
	ld sp,0ab02h		;8c83
	or b			;8c86
	or d			;8c87
	cp (hl)			;8c88
	rst 18h			;8c89
	dec a			;8c8a
	nop			;8c8b
	xor e			;8c8c
	xor l			;8c8d
	or b			;8c8e
	or c			;8c8f
	cp h			;8c90
	jr c,$+4		;8c91
	xor d			;8c93
	or c			;8c94
	xor e			;8c95
	cp (hl)			;8c96
	rst 18h			;8c97
	ld b,h			;8c98
	nop			;8c99
	xor d			;8c9a
	or c			;8c9b
	xor e			;8c9c
	cp (hl)			;8c9d
	or e			;8c9e
	ld b,h			;8c9f
	nop			;8ca0
	xor d			;8ca1
	or c			;8ca2
	xor e			;8ca3
	cp (hl)			;8ca4
	xor l			;8ca5
	ld b,h			;8ca6
	nop			;8ca7
	xor d			;8ca8
	or c			;8ca9
	xor e			;8caa
	or b			;8cab
	rst 18h			;8cac
	ld b,h			;8cad
	nop			;8cae
	xor d			;8caf
	xor l			;8cb0
	or c			;8cb1
	cp (hl)			;8cb2
	rst 18h			;8cb3
	ld c,h			;8cb4
	ld (bc),a			;8cb5
	xor c			;8cb6
	rst 18h			;8cb7
	rst 18h			;8cb8
	rst 18h			;8cb9
	rst 18h			;8cba
	jp m,0a900h		;8cbb
	cp (hl)			;8cbe
	cp h			;8cbf
	or (hl)			;8cc0
	cp (hl)			;8cc1
	ld (hl),000h		;8cc2
	xor c			;8cc4
	cp (hl)			;8cc5
	cp h			;8cc6
	or (hl)			;8cc7
	or b			;8cc8
	ld (hl),000h		;8cc9
	xor c			;8ccb
	cp (hl)			;8ccc
	xor h			;8ccd
	or (hl)			;8cce
	or l			;8ccf
	dec a			;8cd0
	ld (bc),a			;8cd1
	xor c			;8cd2
	cp d			;8cd3
	xor l			;8cd4
	xor e			;8cd5
	cp d			;8cd6
	jr c,$+2		;8cd7
	xor c			;8cd9
	cp d			;8cda
	xor e			;8cdb
	cp (hl)			;8cdc
	rst 18h			;8cdd
	ld l,e			;8cde
	ld (bc),a			;8cdf
	xor c			;8ce0
	or (hl)			;8ce1
	cp d			;8ce2
	xor l			;8ce3
	xor e			;8ce4
	jr c,$+2		;8ce5
	xor b			;8ce7
	or b			;8ce8
	or a			;8ce9
	or b			;8cea
	rst 18h			;8ceb
	jr nc,$+2		;8cec
	and a			;8cee
	rst 18h			;8cef
	rst 18h			;8cf0
	rst 18h			;8cf1
	rst 18h			;8cf2
	ld (0a700h),a		;8cf3
	or (hl)			;8cf6
	xor d			;8cf7
	xor e			;8cf8
	cp d			;8cf9
	ld (de),a			;8cfa
	ld (bc),a			;8cfb
	and (hl)			;8cfc
	rst 18h			;8cfd
	rst 18h			;8cfe
	rst 18h			;8cff
	rst 18h			;8d00
	ld (bc),a			;8d01
	dec b			;8d02
	and (hl)			;8d03
	xor d			;8d04
	or d			;8d05
	rst 18h			;8d06
	rst 18h			;8d07
	rrca			;8d08
	ld (bc),a			;8d09
	nop			;8d0a
	rst 38h			;8d0b
	ld hl,(02a2ah)		;8d0c
	ld hl,(020aah)		;8d0f
	ld (hl),c			;8d12
	ld (hl),l			;8d13
	ld h,l			;8d14
	and b			;8d15
	jr nz,$+114		;8d16
	ld l,a			;8d18
	ld (hl),d			;8d19
	and b			;8d1a
	jr nz,$+119		;8d1b
	ld l,(hl)			;8d1d
	ld h,c			;8d1e
	and b			;8d1f
	jr nz,$+102		;8d20
	ld h,l			;8d22
	jr nz,$-18		;8d23
	jr nz,$+102		;8d25
	ld h,l			;8d27
	ld l,h			;8d28
	and b			;8d29
	jr nz,$+34		;8d2a
	jr nz,$+34		;8d2c
	and b			;8d2e
	jr nz,$+101		;8d2f
	ld l,a			;8d31
	ld l,(hl)			;8d32
	and b			;8d33
	ld h,l			;8d34
	ld h,h			;8d35
	ld h,l			;8d36
	ld (hl),e			;8d37
	and b			;8d38
	jr nz,$+114		;8d39
	ld h,c			;8d3b
	ld (hl),e			;8d3c
	pop hl			;8d3d
	ld c,a			;8d3e
	ld h,l			;8d3f
	ld (hl),e			;8d40
	ld (hl),h			;8d41
	push hl			;8d42
	ld h,c			;8d43
	ld h,e			;8d44
	ld l,c			;8d45
	ld h,c			;8d46
	and b			;8d47
	ld (hl),h			;8d48
	ld l,c			;8d49
	ld h,l			;8d4a
	ld l,(hl)			;8d4b
	push hl			;8d4c
	jr nz,$+103		;8d4d
	ld (hl),e			;8d4f
	ld (hl),h			;8d50
	sub l			;8d51
	ld l,a			;8d52
	jr nz,$+102		;8d53
	ld h,l			;8d55
	and b			;8d56
	dec a			;8d57
	dec a			;8d58
	dec a			;8d59
	dec a			;8d5a
	cp l			;8d5b
	ld h,c			;8d5c
	jr nz,$+110		;8d5d
	ld h,c			;8d5f
	and b			;8d60
	ld (hl),e			;8d61
	jr nz,$+102		;8d62
	ld h,l			;8d64
	and b			;8d65
	jr nz,$+117		;8d66
	ld h,l			;8d68
	and b			;8d69
	jr nz,$+119		;8d6a
	ld l,(hl)			;8d6c
	and b			;8d6d
	jr nz,$+99		;8d6e
	ld l,h			;8d70
	and b			;8d71
	jr nz,$+103		;8d72
	ld l,(hl)			;8d74
	and b			;8d75
	jr nz,$+110		;8d76
	ld h,c			;8d78
	and b			;8d79
	jr nz,$+114		;8d7a
	ld h,c			;8d7c
	jp p,06520h		;8d7d
	ld l,h			;8d80
	and b			;8d81
	jr nz,$+103		;8d82
	ld (hl),e			;8d84
	call p,06420h		;8d85
	ld h,l			;8d88
	and b			;8d89
	ld h,l			;8d8a
	ld l,(hl)			;8d8b
	ld (hl),h			;8d8c
	push hl			;8d8d
	jr nz,$+118		;8d8e
	ld h,l			;8d90
	and b			;8d91
	ld (hl),l			;8d92
	ld h,l			;8d93
	ld (hl),d			;8d94
	call p,07361h		;8d95
	and b			;8d98
	ld h,c			;8d99
	ld h,h			;8d9a
	rst 28h			;8d9b
	jr nz,$+123		;8d9c
	and b			;8d9e
	ld l,a			;8d9f
	ld (hl),e			;8da0
	and b			;8da1
	ld b,l			;8da2
	ld (hl),e			;8da3
	call p,07365h		;8da4
	and b			;8da7
	ld h,c			;8da8
	ld h,h			;8da9
	pop hl			;8daa
	ld h,c			;8dab
	jr nz,$-27		;8dac
	ld l,(hl)			;8dae
	ld h,h			;8daf
	rst 28h			;8db0
	ld h,h			;8db1
	ld h,l			;8db2
	di			;8db3
	ld b,l			;8db4
	ld l,h			;8db5
	and b			;8db6
	ld h,l			;8db7
	ld l,h			;8db8
	and b			;8db9
	ld l,(hl)			;8dba
	ld (hl),h			;8dbb
	push hl			;8dbc
	jr nz,$+106		;8dbd
	pop hl			;8dbf
	ld h,c			;8dc0
	and b			;8dc1
	ld l,a			;8dc2
	and b			;8dc3
	ld h,l			;8dc4
	jp p,0a065h		;8dc5
	ld h,l			;8dc8
	di			;8dc9
	ld h,l			;8dca
	xor 061h		;8dcb
	call pe,0f361h		;8dcd
	ld h,c			;8dd0
	jp p,0ee61h		;8dd1
	ld l,a			;8dd4
	jp p,0ee6fh		;8dd5
	ld (hl),h			;8dd8
	jp p,0f36fh		;8dd9
	inc l			;8ddc
	and b			;8ddd
	ld h,l			;8dde
	call pe,0e963h		;8ddf
	ld (hl),l			;8de2
	jp p,0e469h		;8de3
	ld (hl),h			;8de6
	pop hl			;8de7
	ld l,0a0h		;8de8
	ld l,c			;8dea
	xor 063h		;8deb
	pop hl			;8ded
	ld (hl),d			;8dee
	push hl			;8def
	ld l,a			;8df0
	xor (hl)			;8df1
	ld (hl),e			;8df2
	push af			;8df3
	ld l,a			;8df4
	call pe,0e564h		;8df5
	ld h,h			;8df8
	jp (hl)			;8df9
	ld h,c			;8dfa
	xor (hl)			;8dfb
	ld (hl),h			;8dfc
	push hl			;8dfd
	ld (hl),l			;8dfe
	xor 071h		;8dff
	push af			;8e01
	ld h,c			;8e02
	rst 20h			;8e03
	ld (hl),d			;8e04
	jp (hl)			;8e05
	ld (hl),h			;8e06
	rst 28h			;8e07
	ld l,l			;8e08
	ret p			;8e09
	ld (hl),h			;8e0a
	jp (hl)			;8e0b
	ld h,e			;8e0c
	push af			;8e0d
	ld h,d			;8e0e
	pop hl			;8e0f
	ld h,d			;8e10
	jp p,0ae2eh		;8e11
	ld (hl),e			;8e14
	and b			;8e15
	ld l,h			;8e16
	call pe,0ef63h		;8e17
	ld (hl),b			;8e1a
	push af			;8e1b
	ld h,c			;8e1c
	ex (sp),hl			;8e1d
	ld (hl),l			;8e1e
	defb 0edh;next byte illegal after ed		;8e1f
	jr $-16		;8e20
	ld l,l			;8e22
	pop hl			;8e23
	ld h,e			;8e24
	ret pe			;8e25
	ld l,h			;8e26
	rst 28h			;8e27
	ld h,d			;8e28
	jp (hl)			;8e29
	ld l,l			;8e2a
	jp (hl)			;8e2b
	ld (hl),e			;8e2c
	jp (hl)			;8e2d
	ld a,c			;8e2e
	and b			;8e2f
	ld (hl),d			;8e30
	pop hl			;8e31
	ld h,c			;8e32
	or 065h		;8e33
	call po,0ef72h		;8e35
	ld (hl),h			;8e38
	push af			;8e39
	ld l,h			;8e3a
	jp (hl)			;8e3b
	jr nz,$-8		;8e3c
	ld (hl),e			;8e3e
	rst 28h			;8e3f
	ld h,l			;8e40
	ex (sp),hl			;8e41
	ld (hl),b			;8e42
	rst 28h			;8e43
	ld l,h			;8e44
	pop hl			;8e45
	ld (hl),b			;8e46
	push hl			;8e47
	dec d			;8e48
	defb 0edh;next byte illegal after ed		;8e49
	ld l,h			;8e4a
	and b			;8e4b
	ld l,a			;8e4c
	defb 0edh;next byte illegal after ed		;8e4d
	ld h,l			;8e4e
	xor (hl)			;8e4f
	ld l,(hl)			;8e50
	and b			;8e51
	ld (hl),e			;8e52
	call p,0f567h		;8e53
	ld l,c			;8e56
	ex (sp),hl			;8e57
	ld h,l			;8e58
	ret m			;8e59
	dec d			;8e5a
	di			;8e5b
	ld l,c			;8e5c
	jp p,0e16ah		;8e5d
	ld h,a			;8e60
	jp p,0f465h		;8e61
	jr nz,$-18		;8e64
	ld h,c			;8e66
	indr		;8e67
	adc a,h			;8e69
	adc a,e			;8e6a
	jp pe,0df8ch		;8e6b
	sbc a,(hl)			;8e6e
	rst 18h			;8e6f
	sub b			;8e70
	adc a,h			;8e71
	sbc a,h			;8e72
	adc a,d			;8e73
	adc a,l			;8e74
	sbc a,(hl)			;8e75
	adc a,h			;8e76
	pop de			;8e77
	rst 18h			;8e78
	or c			;8e79
	sub b			;8e7a
	rst 18h			;8e7b
	adc a,c			;8e7c
	sbc a,d			;8e7d
	adc a,h			;8e7e
	rst 18h			;8e7f
	sub c			;8e80
	sbc a,(hl)			;8e81
	sbc a,e			;8e82
	sbc a,(hl)			;8e83
	pop de			;8e84
	push af			;8e85
	xor e			;8e86
	sbc a,(hl)			;8e87
	sub d			;8e88
	sbc a,l			;8e89
	sub (hl)			;8e8a
	jp (hl)			;8e8b
	sub c			;8e8c
	rst 18h			;8e8d
	adc a,a			;8e8e
	adc a,d			;8e8f
	sbc a,d			;8e90
	sbc a,e			;8e91
	sbc a,d			;8e92
	adc a,h			;8e93
	rst 18h			;8e94
	adc a,c			;8e95
	sbc a,d			;8e96
	adc a,l			;8e97
	rst 18h			;8e98
	push af			;8e99
	push af			;8e9a
	sub (hl)			;8e9b
	adc a,l			;8e9c
	rst 18h			;8e9d
	sbc a,(hl)			;8e9e
	sub e			;8e9f
	rst 18h			;8ea0
	push af			;8ea1
	adc a,e			;8ea2
	sbc a,d			;8ea3
	rst 18h			;8ea4
	sbc a,e			;8ea5
	sub (hl)			;8ea6
	sbc a,h			;8ea7
	sbc a,d			;8ea8
	push bc			;8ea9
	rst 18h			;8eaa
	defb 0ddh,0f5h,0b0h	;illegal sequence		;8eab
	adc a,h			;8eae
	sbc a,h			;8eaf
	adc a,d			;8eb0
	adc a,l			;8eb1
	sub b			;8eb2
	pop de			;8eb3
	push af			;8eb4
	or c			;8eb5
	sub b			;8eb6
	rst 18h			;8eb7
	sbc a,d			;8eb8
	adc a,h			;8eb9
	rst 18h			;8eba
	sub c			;8ebb
	sbc a,d			;8ebc
	sbc a,h			;8ebd
	sbc a,d			;8ebe
	adc a,h			;8ebf
	sbc a,(hl)			;8ec0
	adc a,l			;8ec1
	sub (hl)			;8ec2
	sub b			;8ec3
	rst 18h			;8ec4
	sbc a,d			;8ec5
	sub c			;8ec6
	rst 18h			;8ec7
	sbc a,d			;8ec8
	adc a,h			;8ec9
	adc a,e			;8eca
	sbc a,(hl)			;8ecb
	rst 18h			;8ecc
	sbc a,(hl)			;8ecd
	adc a,c			;8ece
	sbc a,d			;8ecf
	sub c			;8ed0
	adc a,e			;8ed1
	adc a,d			;8ed2
	adc a,l			;8ed3
	sbc a,(hl)			;8ed4
	pop de			;8ed5
	jp p,0b1f5h		;8ed6
	sub b			;8ed9
	rst 18h			;8eda
	adc a,a			;8edb
	adc a,d			;8edc
	sbc a,d			;8edd
	sbc a,e			;8ede
	sbc a,d			;8edf
	adc a,h			;8ee0
	rst 18h			;8ee1
	push af			;8ee2
	or c			;8ee3
	sub b			;8ee4
	rst 18h			;8ee5
	adc a,a			;8ee6
	adc a,d			;8ee7
	sbc a,d			;8ee8
	sbc a,e			;8ee9
	sbc a,d			;8eea
	adc a,h			;8eeb
	rst 18h			;8eec
	sub a			;8eed
	sbc a,(hl)			;8eee
	sbc a,h			;8eef
	sbc a,d			;8ef0
	adc a,l			;8ef1
	sub e			;8ef2
	sub b			;8ef3
	pop de			;8ef4
	jp p,0abf5h		;8ef5
	sub (hl)			;8ef8
	sbc a,d			;8ef9
	sub c			;8efa
	sbc a,d			;8efb
	adc a,h			;8efc
	rst 18h			;8efd
	push af			;8efe
	or c			;8eff
	sub b			;8f00
	rst 18h			;8f01
	adc a,e			;8f02
	sub (hl)			;8f03
	sbc a,d			;8f04
	sub c			;8f05
	sbc a,d			;8f06
	adc a,h			;8f07
	rst 18h			;8f08
	sub c			;8f09
	sbc a,(hl)			;8f0a
	sbc a,e			;8f0b
	sbc a,(hl)			;8f0c
	pop de			;8f0d
	jp p,0abf5h		;8f0e
	sub (hl)			;8f11
	sbc a,d			;8f12
	sub c			;8f13
	sbc a,d			;8f14
	adc a,h			;8f15
	rst 18h			;8f16
	adc a,a			;8f17
	adc a,d			;8f18
	sbc a,d			;8f19
	adc a,h			;8f1a
	adc a,e			;8f1b
	sub b			;8f1c
	rst 18h			;8f1d
	push af			;8f1e
	ret nz			;8f1f
	rst 18h			;8f20
	rst 10h			;8f21
	xor h			;8f22
	sub (hl)			;8f23
	ret nc			;8f24
	or c			;8f25
	sub b			;8f26
	sub 0f5h		;8f27
	jp p,0b3edh		;8f29
	sub b			;8f2c
	rst 18h			;8f2d
	sub (hl)			;8f2e
	sub c			;8f2f
	adc a,e			;8f30
	sbc a,d			;8f31
	sub c			;8f32
	adc a,e			;8f33
	sbc a,(hl)			;8f34
	adc a,h			;8f35
	rst 18h			;8f36
	sub b			;8f37
	adc a,e			;8f38
	adc a,l			;8f39
	sbc a,(hl)			;8f3a
	rst 18h			;8f3b
	adc a,c			;8f3c
	sbc a,d			;8f3d
	add a,l			;8f3e
	ret nz			;8f3f
	rst 18h			;8f40
	rst 10h			;8f41
	xor h			;8f42
	sub (hl)			;8f43
	ret nc			;8f44
	or c			;8f45
	sub b			;8f46
	sub 0f5h		;8f47
	push af			;8f49
	xor c			;8f4a
	sbc a,(hl)			;8f4b
	sub e			;8f4c
	sbc a,d			;8f4d
	pop de			;8f4e
	jp p,0f5f5h		;8f4f
	xor e			;8f52
	adc a,d			;8f53
	adc a,l			;8f54
	sub c			;8f55
	sub b			;8f56
	push bc			;8f57
	rst 18h			;8f58
	push af			;8f59
	indr		;8f5a
	adc a,h			;8f5c
	adc a,e			;8f5d
	jp pe,0df8ch		;8f5e
	adc a,h			;8f61
	sbc a,d			;8f62
	sbc a,b			;8f63
	adc a,d			;8f64
	adc a,l			;8f65
	sub b			;8f66
	push af			;8f67
	push af			;8f68
	push af			;8f69
	or d			;8f6a
	adc a,d			;8f6b
	sbc a,d			;8f6c
	adc a,l			;8f6d
	sbc a,d			;8f6e
	adc a,h			;8f6f
	rst 18h			;8f70
	sbc a,d			;8f71
	sub c			;8f72
	adc a,c			;8f73
	sbc a,d			;8f74
	sub c			;8f75
	sbc a,d			;8f76
	sub c			;8f77
	sbc a,(hl)			;8f78
	sbc a,e			;8f79
	sub b			;8f7a
	pop de			;8f7b
	jp p,0f5f5h		;8f7c
	or c			;8f7f
	sub b			;8f80
	rst 18h			;8f81
	sub e			;8f82
	sub b			;8f83
	rst 18h			;8f84
	sub e			;8f85
	sub e			;8f86
	sbc a,d			;8f87
	adc a,c			;8f88
	sbc a,(hl)			;8f89
	adc a,h			;8f8a
	rst 18h			;8f8b
	adc a,a			;8f8c
	adc a,d			;8f8d
	sbc a,d			;8f8e
	adc a,h			;8f8f
	adc a,e			;8f90
	sub b			;8f91
	pop de			;8f92
	jp p,0b1f5h		;8f93
	sub b			;8f96
	rst 18h			;8f97
	adc a,a			;8f98
	adc a,d			;8f99
	sbc a,d			;8f9a
	sbc a,e			;8f9b
	sbc a,d			;8f9c
	adc a,h			;8f9d
	pop de			;8f9e
	rst 18h			;8f9f
	or e			;8fa0
	sub e			;8fa1
	sbc a,d			;8fa2
	adc a,c			;8fa3
	sbc a,(hl)			;8fa4
	adc a,h			;8fa5
	rst 18h			;8fa6
	and b			;8fa7
	pop de			;8fa8
	jp p,0a6f5h		;8fa9
	sbc a,(hl)			;8fac
	rst 18h			;8fad
	adc a,e			;8fae
	sub (hl)			;8faf
	sbc a,d			;8fb0
	sub c			;8fb1
	sbc a,d			;8fb2
	adc a,h			;8fb3
	rst 18h			;8fb4
	and b			;8fb5
	pop de			;8fb6
	jp p,0eef5h		;8fb7
	or c			;8fba
	sub b			;8fbb
	rst 18h			;8fbc
	sbc a,d			;8fbd
	adc a,h			;8fbe
	adc a,e			;8fbf
	jp pe,09edfh		;8fc0
	rst 18h			;8fc3
	adc a,e			;8fc4
	adc a,d			;8fc5
	rst 18h			;8fc6
	sbc a,(hl)			;8fc7
	sub e			;8fc8
	sbc a,h			;8fc9
	sbc a,(hl)			;8fca
	sub c			;8fcb
	sbc a,h			;8fcc
	sbc a,d			;8fcd
	sbc a,0f2h		;8fce
	push af			;8fd0
	or e			;8fd1
	sub e			;8fd2
	sbc a,d			;8fd3
	adc a,c			;8fd4
	sbc a,(hl)			;8fd5
	adc a,h			;8fd6
	rst 18h			;8fd7
	adc a,e			;8fd8
	sbc a,(hl)			;8fd9
	sub c			;8fda
	adc a,e			;8fdb
	sbc a,(hl)			;8fdc
	adc a,h			;8fdd
	rst 18h			;8fde
	sbc a,h			;8fdf
	sub b			;8fe0
	adc a,h			;8fe1
	sbc a,(hl)			;8fe2
	adc a,h			;8fe3
	rst 18h			;8fe4
	adc a,(hl)			;8fe5
	adc a,d			;8fe6
	sbc a,d			;8fe7
	rst 18h			;8fe8
	and b			;8fe9
	rst 18h			;8fea
	adc a,h			;8feb
	sbc a,d			;8fec
	rst 18h			;8fed
	adc a,e			;8fee
	sbc a,d			;8fef
	rst 18h			;8ff0
	sbc a,d			;8ff1
	adc a,h			;8ff2
	sbc a,h			;8ff3
	sbc a,(hl)			;8ff4
	adc a,a			;8ff5
	sbc a,(hl)			;8ff6
	rst 18h			;8ff7
	sbc a,e			;8ff8
	sbc a,d			;8ff9
	rst 18h			;8ffa
	sub e			;8ffb
	sbc a,(hl)			;8ffc
	adc a,h			;8ffd
	rst 18h			;8ffe
	sub d			;8fff
	sbc a,(hl)			;9000
	sub c			;9001
	sub b			;9002
	adc a,h			;9003
	pop de			;9004
	jp p,0aff5h		;9005
	sbc a,d			;9008
	adc a,l			;9009
	sub b			;900a
	pop de			;900b
	pop de			;900c
	pop de			;900d
	rst 18h			;900e
	xor 08ch		;900f
	sub (hl)			;9011
	rst 18h			;9012
	sub c			;9013
	sub b			;9014
	rst 18h			;9015
	sub e			;9016
	sub b			;9017
	rst 18h			;9018
	adc a,e			;9019
	sub (hl)			;901a
	sbc a,d			;901b
	sub c			;901c
	sbc a,d			;901d
	adc a,h			;901e
	sbc a,0f2h		;901f
	push af			;9021
	and (hl)			;9022
	sbc a,(hl)			;9023
	rst 18h			;9024
	sub e			;9025
	sub e			;9026
	sbc a,d			;9027
	adc a,c			;9028
	sbc a,(hl)			;9029
	adc a,h			;902a
	rst 18h			;902b
	and b			;902c
	pop de			;902d
	jp p,0acf5h		;902e
	push af			;9031
	or c			;9032
	push af			;9033
	sub d			;9034
	jp pe,0d18ch		;9035
	pop de			;9038
	pop de			;9039
	push af			;903a
	jp p,0dfc1h		;903b
	push af			;903e
	push af			;903f
	cp d			;9040
	sub e			;9041
	rst 18h			;9042
	adc a,e			;9043
	sub (hl)			;9044
	sbc a,d			;9045
	sub d			;9046
	adc a,a			;9047
	sub b			;9048
	rst 18h			;9049
	adc a,a			;904a
	sbc a,(hl)			;904b
	adc a,h			;904c
	sbc a,(hl)			;904d
	pop de			;904e
	pop de			;904f
	pop de			;9050
	jp p,0bcf5h		;9051
	sub b			;9054
	sbc a,b			;9055
	sbc a,d			;9056
	adc a,h			;9057
	rst 18h			;9058
	and b			;9059
	pop de			;905a
	jp p,0abf5h		;905b
	sbc a,d			;905e
	rst 18h			;905f
	adc a,a			;9060
	sub b			;9061
	sub c			;9062
	sbc a,d			;9063
	adc a,h			;9064
	rst 18h			;9065
	and b			;9066
	pop de			;9067
	jp p,0abf5h		;9068
	sbc a,d			;906b
	rst 18h			;906c
	adc a,(hl)			;906d
	adc a,d			;906e
	sub (hl)			;906f
	adc a,e			;9070
	sbc a,(hl)			;9071
	adc a,h			;9072
	rst 18h			;9073
	and b			;9074
	pop de			;9075
	jp p,0bbf5h		;9076
	sbc a,d			;9079
	sub l			;907a
	sbc a,(hl)			;907b
	adc a,h			;907c
	rst 18h			;907d
	and b			;907e
	pop de			;907f
	jp p,0b1f5h		;9080
	sub b			;9083
	rst 18h			;9084
	adc a,a			;9085
	adc a,d			;9086
	sbc a,d			;9087
	sbc a,e			;9088
	sbc a,d			;9089
	adc a,h			;908a
	rst 18h			;908b
	adc a,a			;908c
	sub b			;908d
	sub c			;908e
	sbc a,d			;908f
	adc a,l			;9090
	adc a,e			;9091
	sbc a,d			;9092
	rst 18h			;9093
	and b			;9094
	pop de			;9095
	jp p,0b1f5h		;9096
	sub b			;9099
	rst 18h			;909a
	adc a,a			;909b
	adc a,d			;909c
	sbc a,d			;909d
	sbc a,e			;909e
	sbc a,d			;909f
	adc a,h			;90a0
	rst 18h			;90a1
	adc a,(hl)			;90a2
	adc a,d			;90a3
	sub (hl)			;90a4
	adc a,e			;90a5
	sbc a,(hl)			;90a6
	adc a,l			;90a7
	adc a,e			;90a8
	sbc a,d			;90a9
	rst 18h			;90aa
	and b			;90ab
	pop de			;90ac
	jp p,0b1f5h		;90ad
	sub b			;90b0
	rst 18h			;90b1
	adc a,a			;90b2
	adc a,d			;90b3
	sbc a,d			;90b4
	sbc a,e			;90b5
	sbc a,d			;90b6
	adc a,h			;90b7
	rst 18h			;90b8
	adc a,(hl)			;90b9
	adc a,d			;90ba
	sub (hl)			;90bb
	adc a,e			;90bc
	sbc a,(hl)			;90bd
	adc a,l			;90be
	adc a,e			;90bf
	sbc a,d			;90c0
	rst 18h			;90c1
	and b			;90c2
	out (0dfh),a		;90c3
	adc a,a			;90c5
	sub b			;90c6
	adc a,l			;90c7
	adc a,(hl)			;90c8
	adc a,d			;90c9
	sbc a,d			;90ca
	rst 18h			;90cb
	adc a,e			;90cc
	sub (hl)			;90cd
	sbc a,d			;90ce
	sub c			;90cf
	sbc a,d			;90d0
	adc a,h			;90d1
	rst 18h			;90d2
	sub e			;90d3
	sbc a,(hl)			;90d4
	adc a,h			;90d5
	rst 18h			;90d6
	sub d			;90d7
	sbc a,(hl)			;90d8
	sub c			;90d9
	sub b			;90da
	adc a,h			;90db
	rst 18h			;90dc
	sub e			;90dd
	sub e			;90de
	sbc a,d			;90df
	sub c			;90e0
	sbc a,(hl)			;90e1
	adc a,h			;90e2
	pop de			;90e3
	jp p,0bff5h		;90e4
	rst 18h			;90e7
	adc a,a			;90e8
	sbc a,d			;90e9
	adc a,h			;90ea
	sbc a,(hl)			;90eb
	rst 18h			;90ec
	sbc a,e			;90ed
	sbc a,d			;90ee
	sub d			;90ef
	sbc a,(hl)			;90f0
	adc a,h			;90f1
	sub (hl)			;90f2
	sbc a,(hl)			;90f3
	sbc a,e			;90f4
	sub b			;90f5
	rst 18h			;90f6
	add a,(hl)			;90f7
	rst 18h			;90f8
	adc a,h			;90f9
	sbc a,d			;90fa
	rst 18h			;90fb
	adc a,e			;90fc
	sbc a,d			;90fd
	rst 18h			;90fe
	sbc a,h			;90ff
	sbc a,(hl)			;9100
	sbc a,d			;9101
	pop de			;9102
	jp p,0aff5h		;9103
	sub b			;9106
	sub c			;9107
	sbc a,d			;9108
	adc a,h			;9109
	rst 18h			;910a
	and b			;910b
	rst 18h			;910c
	sbc a,d			;910d
	sub c			;910e
	rst 18h			;910f
	push af			;9110
	cp a			;9111
	rst 18h			;9112
	sub c			;9113
	sub b			;9114
	rst 18h			;9115
	sbc a,d			;9116
	adc a,h			;9117
	adc a,e			;9118
	jp pe,09adfh		;9119
	sub c			;911c
	rst 18h			;911d
	push af			;911e
	out (0dfh),a		;911f
	push af			;9121
	rst 18h			;9122
	add a,(hl)			;9123
	rst 18h			;9124
	push af			;9125
	pop de			;9126
	rst 18h			;9127
	push af			;9128
	or c			;9129
	sub b			;912a
	rst 18h			;912b
	adc a,e			;912c
	sub (hl)			;912d
	sbc a,d			;912e
	sub c			;912f
	sbc a,d			;9130
	adc a,h			;9131
	rst 18h			;9132
	and b			;9133
	pop de			;9134
	jp p,0eef5h		;9135
	or c			;9138
	sub b			;9139
	rst 18h			;913a
	adc a,h			;913b
	sbc a,d			;913c
	sbc a,(hl)			;913d
	adc a,h			;913e
	rst 18h			;913f
	sbc a,l			;9140
	adc a,l			;9141
	adc a,d			;9142
	adc a,e			;9143
	sub b			;9144
	sbc a,0f2h		;9145
	push af			;9147
	pop de			;9148
	jp p,0b1f5h		;9149
	sub b			;914c
	rst 18h			;914d
	sub a			;914e
	sbc a,(hl)			;914f
	add a,(hl)			;9150
	rst 18h			;9151
	sub c			;9152
	sbc a,(hl)			;9153
	sbc a,e			;9154
	sbc a,(hl)			;9155
	rst 18h			;9156
	sbc a,e			;9157
	sbc a,d			;9158
	rst 18h			;9159
	sbc a,d			;915a
	adc a,h			;915b
	sub b			;915c
	rst 18h			;915d
	sbc a,d			;915e
	sub c			;915f
	rst 18h			;9160
	push af			;9161
	sbc a,(hl)			;9162
	sub (hl)			;9163
	adc a,l			;9164
	sbc a,d			;9165
	pop de			;9166
	jp p,0bcf5h		;9167
	push af			;916a
	cp e			;916b
	push af			;916c
	push af			;916d
	cp d			;916e
	adc a,l			;916f
	adc a,l			;9170
	sub b			;9171
	adc a,l			;9172
	pop de			;9173
	jp p,0f5f5h		;9174
	or c			;9177
	sub b			;9178
	sub d			;9179
	sbc a,l			;917a
	adc a,l			;917b
	sbc a,d			;917c
	rst 18h			;917d
	sbc a,d			;917e
	adc a,l			;917f
	adc a,l			;9180
	rst 20h			;9181
	sub c			;9182
	sbc a,d			;9183
	sub b			;9184
	pop de			;9185
	jp p,0b1f5h		;9186
	sub b			;9189
	sub d			;918a
	sbc a,l			;918b
	adc a,l			;918c
	sbc a,d			;918d
	rst 18h			;918e
	sbc a,e			;918f
	sbc a,d			;9190
	sub e			;9191
	rst 18h			;9192
	sbc a,c			;9193
	sub (hl)			;9194
	sbc a,h			;9195
	sub a			;9196
	sbc a,d			;9197
	adc a,l			;9198
	sub b			;9199
	push bc			;919a
	push af			;919b
	xor a			;919c
	adc a,l			;919d
	sbc a,d			;919e
	adc a,a			;919f
	sbc a,(hl)			;91a0
	adc a,l			;91a1
	sbc a,(hl)			;91a2
	rst 18h			;91a3
	sub e			;91a4
	sbc a,(hl)			;91a5
	rst 18h			;91a6
	sbc a,h			;91a7
	sub (hl)			;91a8
	sub c			;91a9
	adc a,e			;91aa
	sbc a,(hl)			;91ab
	pop de			;91ac
	pop de			;91ad
	pop de			;91ae
	jp p,0edf5h		;91af
	cp h			;91b2
	sub (hl)			;91b3
	sub c			;91b4
	adc a,e			;91b5
	sbc a,(hl)			;91b6
	rst 18h			;91b7
	sub b			;91b8
	rst 18h			;91b9
	cp e			;91ba
	sub (hl)			;91bb
	adc a,h			;91bc
	sbc a,h			;91bd
	sub b			;91be
	ret nz			;91bf
	rst 18h			;91c0
	rst 10h			;91c1
	cp h			;91c2
	ret nc			;91c3
	cp e			;91c4
	sub 0f5h		;91c5
	sub c			;91c7
	push af			;91c8
	rst 18h			;91c9
	and b			;91ca
	pop de			;91cb
	push af			;91cc
	pop de			;91cd
	push af			;91ce
	cp d			;91cf
	adc a,h			;91d0
	adc a,e			;91d1
	jp pe,0df8ch		;91d2
	sub a			;91d5
	sbc a,(hl)			;91d6
	sbc a,l			;91d7
	sub e			;91d8
	sbc a,(hl)			;91d9
	sub c			;91da
	sbc a,e			;91db
	sub b			;91dc
	rst 18h			;91dd
	adc a,h			;91de
	sub b			;91df
	sub e			;91e0
	sub b			;91e1
	pop de			;91e2
	jp p,08cf5h		;91e3
	push af			;91e6
	defb 0ddh,0d1h,0f5h	;illegal sequence		;91e7
	defb 0ddh,0d1h,0f2h	;illegal sequence		;91ea
	push af			;91ed
	xor a			;91ee
	sbc a,d			;91ef
	adc a,l			;91f0
	sub b			;91f1
	pop de			;91f2
	pop de			;91f3
	pop de			;91f4
	rst 18h			;91f5
	adc a,h			;91f6
	sub (hl)			;91f7
	rst 18h			;91f8
	sub c			;91f9
	sub b			;91fa
	rst 18h			;91fb
	sbc a,d			;91fc
	adc a,h			;91fd
	adc a,e			;91fe
	jp pe,0f2d1h		;91ff
	push af			;9202
	push af			;9203
	push af			;9204
	push af			;9205
	push af			;9206
	cp d			;9207
	adc a,h			;9208
	adc a,e			;9209
	jp pe,089dfh		;920a
	sbc a,(hl)			;920d
	sbc a,h			;920e
	ret pe			;920f
	push af			;9210
	and (hl)			;9211
	sbc a,(hl)			;9212
	rst 18h			;9213
	sub e			;9214
	sub b			;9215
	rst 18h			;9216
	sbc a,d			;9217
	adc a,h			;9218
	adc a,e			;9219
	sbc a,(hl)			;921a
	sbc a,l			;921b
	sbc a,(hl)			;921c
	pop de			;921d
	jp p,0b1f5h		;921e
	sbc a,(hl)			;9221
	sbc a,e			;9222
	sbc a,(hl)			;9223
	rst 18h			;9224
	adc a,(hl)			;9225
	adc a,d			;9226
	sbc a,d			;9227
	rst 18h			;9228
	sbc a,e			;9229
	sbc a,d			;922a
	adc a,h			;922b
	adc a,e			;922c
	sbc a,(hl)			;922d
	sbc a,h			;922e
	sbc a,(hl)			;922f
	adc a,l			;9230
	pop de			;9231
	jp p,0b8f5h		;9232
	sbc a,d			;9235
	adc a,e			;9236
	adc a,d			;9237
	adc a,a			;9238
	adc a,a			;9239
	sbc a,(hl)			;923a
	sbc a,0f5h		;923b
	cp e			;923d
	sbc a,d			;923e
	sub c			;923f
	adc a,e			;9240
	adc a,l			;9241
	sub b			;9242
	rst 18h			;9243
	sub a			;9244
	sbc a,(hl)			;9245
	add a,(hl)			;9246
	rst 18h			;9247
	push af			;9248
	cp (hl)			;9249
	sub a			;924a
	sub b			;924b
	adc a,l			;924c
	sbc a,(hl)			;924d
	rst 18h			;924e
	sub e			;924f
	sbc a,(hl)			;9250
	adc a,h			;9251
	rst 18h			;9252
	adc a,h			;9253
	sbc a,(hl)			;9254
	sub e			;9255
	sub (hl)			;9256
	sbc a,e			;9257
	sbc a,(hl)			;9258
	adc a,h			;9259
	rst 18h			;925a
	adc a,h			;925b
	sbc a,d			;925c
	rst 18h			;925d
	sbc a,e			;925e
	sbc a,(hl)			;925f
	adc a,l			;9260
	jp pe,0df91h		;9261
	push af			;9264
	sbc a,h			;9265
	sub b			;9266
	sub c			;9267
	rst 18h			;9268
	sub e			;9269
	sbc a,(hl)			;926a
	rst 18h			;926b
	sbc a,e			;926c
	sbc a,d			;926d
	adc a,h			;926e
	sbc a,h			;926f
	adc a,l			;9270
	sub (hl)			;9271
	adc a,a			;9272
	sbc a,h			;9273
	sub (hl)			;9274
	rst 20h			;9275
	sub c			;9276
	pop de			;9277
	jp p,08cf5h		;9278
	rst 20h			;927b
	sub e			;927c
	sub b			;927d
	rst 18h			;927e
	sbc a,h			;927f
	sub b			;9280
	sub c			;9281
	rst 18h			;9282
	ret c			;9283
	and a			;9284
	ret c			;9285
	pop de			;9286
	jp p,0edf5h		;9287
	cp h			;928a
	sub b			;928b
	sub c			;928c
	rst 18h			;928d
	adc a,(hl)			;928e
	adc a,d			;928f
	jp (hl)			;9290
	ret nz			;9291
	jp p,0edf5h		;9292
	cp d			;9295
	sub c			;9296
	rst 18h			;9297
	adc a,(hl)			;9298
	adc a,d			;9299
	jp (hl)			;929a
	rst 18h			;929b
	sbc a,e			;929c
	sub (hl)			;929d
	adc a,l			;929e
	sbc a,d			;929f
	sbc a,h			;92a0
	sbc a,h			;92a1
	sub (hl)			;92a2
	rst 20h			;92a3
	sub c			;92a4
	ret nz			;92a5
	jp p,0a6f5h		;92a6
	adc a,d			;92a9
	sub d			;92aa
	rst 18h			;92ab
	push af			;92ac
	xor e			;92ad
	sbc a,d			;92ae
	add a,l			;92af
	sbc a,h			;92b0
	sbc a,(hl)			;92b1
	rst 18h			;92b2
	push af			;92b3
	xor h			;92b4
	sub (hl)			;92b5
	adc a,a			;92b6
	sbc a,(hl)			;92b7
	sbc a,h			;92b8
	rst 18h			;92b9
	push af			;92ba
	and a			;92bb
	sub (hl)			;92bc
	adc a,d			;92bd
	adc a,e			;92be
	sbc a,d			;92bf
	sbc a,h			;92c0
	adc a,d			;92c1
	adc a,e			;92c2
	sub e			;92c3
	sub (hl)			;92c4
	rst 18h			;92c5
	push af			;92c6
	or h			;92c7
	adc a,d			;92c8
	sub (hl)			;92c9
	sub e			;92ca
	sub e			;92cb
	rst 18h			;92cc
	push af			;92cd
	or a			;92ce
	adc a,d			;92cf
	sub (hl)			;92d0
	adc a,e			;92d1
	add a,l			;92d2
	sub (hl)			;92d3
	sub e			;92d4
	sub b			;92d5
	adc a,a			;92d6
	sub b			;92d7
	sbc a,h			;92d8
	sub a			;92d9
	adc a,e			;92da
	sub e			;92db
	sub (hl)			;92dc
	rst 18h			;92dd
	push af			;92de
	sub e			;92df
	sub e			;92e0
	sbc a,d			;92e1
	sbc a,b			;92e2
	sbc a,(hl)			;92e3
	pop de			;92e4
	jp p,09af5h		;92e5
	adc a,h			;92e8
	adc a,e			;92e9
	jp pe,09edfh		;92ea
	adc a,(hl)			;92ed
	adc a,d			;92ee
	ret pe			;92ef
	pop de			;92f0
	rst 18h			;92f1
	push af			;92f2
	cp (hl)			;92f3
	sbc a,l			;92f4
	adc a,l			;92f5
	sbc a,d			;92f6
	adc a,h			;92f7
	rst 18h			;92f8
	and b			;92f9
	pop de			;92fa
	push af			;92fb
	or c			;92fc
	sub b			;92fd
	rst 18h			;92fe
	adc a,a			;92ff
	adc a,d			;9300
	sbc a,d			;9301
	sbc a,e			;9302
	sbc a,d			;9303
	adc a,h			;9304
	rst 18h			;9305
	sub d			;9306
	sbc a,d			;9307
	adc a,e			;9308
	sbc a,d			;9309
	adc a,l			;930a
	rst 18h			;930b
	and b			;930c
	rst 18h			;930d
	sbc a,d			;930e
	sub c			;930f
	push af			;9310
	cp h			;9311
	sub (hl)			;9312
	sbc a,d			;9313
	adc a,l			;9314
	adc a,l			;9315
	sbc a,(hl)			;9316
	adc a,h			;9317
	rst 18h			;9318
	and b			;9319
	pop de			;931a
	jp p,0b1f5h		;931b
	sub b			;931e
	rst 18h			;931f
	adc a,a			;9320
	adc a,d			;9321
	sbc a,d			;9322
	sbc a,e			;9323
	sbc a,d			;9324
	adc a,h			;9325
	rst 18h			;9326
	sub d			;9327
	sub b			;9328
	adc a,c			;9329
	sbc a,d			;932a
	adc a,l			;932b
	rst 18h			;932c
	and b			;932d
	pop de			;932e
	jp p,0eef5h		;932f
	and (hl)			;9332
	sbc a,(hl)			;9333
	rst 18h			;9334
	sub a			;9335
	sbc a,(hl)			;9336
	adc a,h			;9337
	rst 18h			;9338
	sub a			;9339
	sbc a,d			;933a
	sbc a,h			;933b
	sub a			;933c
	sub b			;933d
	rst 18h			;933e
	sbc a,d			;933f
	adc a,h			;9340
	sub b			;9341
	sbc a,0f2h		;9342
	push af			;9344
	cp d			;9345
	adc a,h			;9346
	adc a,e			;9347
	jp pe,09cdfh		;9348
	sbc a,d			;934b
	adc a,l			;934c
	adc a,l			;934d
	sbc a,(hl)			;934e
	sbc a,e			;934f
	push af			;9350
	and (hl)			;9351
	sbc a,(hl)			;9352
	rst 18h			;9353
	sub a			;9354
	sbc a,(hl)			;9355
	adc a,h			;9356
	rst 18h			;9357
	sbc a,h			;9358
	sub b			;9359
	sbc a,b			;935a
	sub (hl)			;935b
	sbc a,e			;935c
	sub b			;935d
	pop de			;935e
	jp p,0a0f5h		;935f
	pop de			;9362
	push af			;9363
	and b			;9364
	pop de			;9365
	jp p,09ef5h		;9366
	push af			;9369
	sub b			;936a
	push af			;936b
	push af			;936c
	push af			;936d
	or c			;936e
	sub b			;936f
	rst 18h			;9370
	adc a,a			;9371
	sbc a,(hl)			;9372
	adc a,h			;9373
	sbc a,(hl)			;9374
	rst 18h			;9375
	sub c			;9376
	sbc a,(hl)			;9377
	sbc a,e			;9378
	sbc a,(hl)			;9379
	rst 18h			;937a
	sbc a,d			;937b
	adc a,h			;937c
	adc a,a			;937d
	sbc a,d			;937e
	sbc a,h			;937f
	sub (hl)			;9380
	sbc a,(hl)			;9381
	sub e			;9382
	pop de			;9383
	jp p,0bff5h		;9384
	rst 18h			;9387
	sub c			;9388
	sub b			;9389
	rst 18h			;938a
	adc a,e			;938b
	sub (hl)			;938c
	sbc a,d			;938d
	sub c			;938e
	sbc a,d			;938f
	rst 18h			;9390
	sub c			;9391
	sbc a,(hl)			;9392
	sbc a,e			;9393
	sbc a,(hl)			;9394
	rst 18h			;9395
	sub (hl)			;9396
	sub c			;9397
	adc a,e			;9398
	sbc a,d			;9399
	adc a,l			;939a
	sbc a,d			;939b
	adc a,h			;939c
	sbc a,(hl)			;939d
	sub c			;939e
	adc a,e			;939f
	sbc a,d			;93a0
	push af			;93a1
	push af			;93a2
	push af			;93a3
	cp a			;93a4
	rst 18h			;93a5
	sub c			;93a6
	sub b			;93a7
	rst 18h			;93a8
	sbc a,h			;93a9
	sbc a,(hl)			;93aa
	sbc a,l			;93ab
	sbc a,d			;93ac
	rst 18h			;93ad
	sbc a,d			;93ae
	sub c			;93af
	rst 18h			;93b0
	push af			;93b1
	push af			;93b2
	push af			;93b3
	xor e			;93b4
	sbc a,d			;93b5
	rst 18h			;93b6
	sbc a,e			;93b7
	sub (hl)			;93b8
	sbc a,h			;93b9
	sbc a,d			;93ba
	push bc			;93bb
	rst 18h			;93bc
	defb 0ddh,0f5h,0bah	;illegal sequence		;93bd
	adc a,h			;93c0
	adc a,e			;93c1
	jp pe,09edfh		;93c2
	sbc a,l			;93c5
	sub (hl)			;93c6
	sbc a,d			;93c7
	adc a,l			;93c8
	adc a,e			;93c9
	push af			;93ca
	xor e			;93cb
	sbc a,d			;93cc
	rst 18h			;93cd
	add a,l			;93ce
	sbc a,(hl)			;93cf
	sub d			;93d0
	adc a,a			;93d1
	sbc a,(hl)			;93d2
	adc a,h			;93d3
	rst 18h			;93d4
	and b			;93d5
	pop de			;93d6
	jp p,0f5f5h		;93d7
	or c			;93da
	sub b			;93db
	rst 18h			;93dc
	sub a			;93dd
	sbc a,(hl)			;93de
	add a,(hl)			;93df
	rst 18h			;93e0
	sub c			;93e1
	sub (hl)			;93e2
	sub c			;93e3
	sbc a,b			;93e4
	adc a,d			;93e5
	sub c			;93e6
	sbc a,(hl)			;93e7
	rst 18h			;93e8
	adc a,h			;93e9
	sbc a,(hl)			;93ea
	sub e			;93eb
	sub (hl)			;93ec
	sbc a,e			;93ed
	sbc a,(hl)			;93ee
	push af			;93ef
	or e			;93f0
	sbc a,(hl)			;93f1
	adc a,h			;93f2
	rst 18h			;93f3
	adc a,h			;93f4
	sbc a,(hl)			;93f5
	sub e			;93f6
	sub (hl)			;93f7
	sbc a,e			;93f8
	sbc a,(hl)			;93f9
	adc a,h			;93fa
	rst 18h			;93fb
	adc a,a			;93fc
	sub b			;93fd
	adc a,h			;93fe
	sub (hl)			;93ff
	sbc a,l			;9400
	sub e			;9401
	sbc a,d			;9402
	adc a,h			;9403
	rst 18h			;9404
	adc a,h			;9405
	sub b			;9406
	sub c			;9407
	rst 18h			;9408
	push af			;9409
	pop de			;940a
	jp p,0d3f5h		;940b
	rst 18h			;940e
	push af			;940f
	rst 18h			;9410
	add a,(hl)			;9411
	rst 18h			;9412
	push af			;9413
	or e			;9414
	sbc a,(hl)			;9415
	rst 18h			;9416
	and 091h		;9417
	sub (hl)			;9419
	sbc a,h			;941a
	sbc a,(hl)			;941b
	rst 18h			;941c
	adc a,h			;941d
	sbc a,(hl)			;941e
	sub e			;941f
	sub (hl)			;9420
	sbc a,e			;9421
	sbc a,(hl)			;9422
	rst 18h			;9423
	sbc a,d			;9424
	adc a,h			;9425
	rst 18h			;9426
	push af			;9427
	or c			;9428
	sub b			;9429
	adc a,l			;942a
	adc a,e			;942b
	sbc a,d			;942c
	push af			;942d
	xor h			;942e
	adc a,d			;942f
	adc a,l			;9430
	push af			;9431
	cp d			;9432
	adc a,h			;9433
	adc a,e			;9434
	sbc a,d			;9435
	push af			;9436
	or b			;9437
	sbc a,d			;9438
	adc a,h			;9439
	adc a,e			;943a
	sbc a,d			;943b
	push af			;943c
	or c			;943d
	sub b			;943e
	adc a,l			;943f
	sbc a,d			;9440
	adc a,h			;9441
	adc a,e			;9442
	sbc a,d			;9443
	push af			;9444
	or c			;9445
	sub b			;9446
	adc a,l			;9447
	sub b			;9448
	sbc a,d			;9449
	adc a,h			;944a
	adc a,e			;944b
	sbc a,d			;944c
	push af			;944d
	xor h			;944e
	adc a,d			;944f
	adc a,l			;9450
	sbc a,d			;9451
	adc a,h			;9452
	adc a,e			;9453
	sbc a,d			;9454
	push af			;9455
	xor h			;9456
	adc a,d			;9457
	adc a,l			;9458
	sub b			;9459
	sbc a,d			;945a
	adc a,h			;945b
	adc a,e			;945c
	sbc a,d			;945d
	push af			;945e
	adc a,h			;945f
	adc a,d			;9460
	sbc a,l			;9461
	sub (hl)			;9462
	adc a,l			;9463
	push af			;9464
	sbc a,l			;9465
	sbc a,(hl)			;9466
	sub l			;9467
	sbc a,(hl)			;9468
	adc a,l			;9469
	push af			;946a
	sbc a,d			;946b
	sub c			;946c
	adc a,e			;946d
	adc a,l			;946e
	sbc a,(hl)			;946f
	adc a,l			;9470
	push af			;9471
	adc a,h			;9472
	sbc a,(hl)			;9473
	sub e			;9474
	sub (hl)			;9475
	adc a,l			;9476
	push af			;9477
	xor a			;9478
	sub (hl)			;9479
	adc a,l			;947a
	jp pe,09692h		;947b
	sbc a,e			;947e
	sbc a,d			;947f
	pop de			;9480
	rst 18h			;9481
	push af			;9482
	xor a			;9483
	adc a,l			;9484
	sub (hl)			;9485
	sub d			;9486
	sbc a,d			;9487
	adc a,l			;9488
	push af			;9489
	xor h			;948a
	sbc a,d			;948b
	sbc a,b			;948c
	adc a,d			;948d
	sub c			;948e
	sbc a,e			;948f
	sub b			;9490
	push af			;9491
	xor e			;9492
	sbc a,d			;9493
	adc a,l			;9494
	sbc a,h			;9495
	sbc a,d			;9496
	adc a,l			;9497
	push af			;9498
	cp h			;9499
	adc a,d			;949a
	sbc a,(hl)			;949b
	adc a,l			;949c
	adc a,e			;949d
	sub b			;949e
	push af			;949f
	xor (hl)			;94a0
	adc a,d			;94a1
	sub (hl)			;94a2
	sub c			;94a3
	adc a,e			;94a4
	sub b			;94a5
	push af			;94a6
	and a			;94a7
	sub (hl)			;94a8
	sbc a,l			;94a9
	sbc a,(hl)			;94aa
	sub e			;94ab
	sbc a,l			;94ac
	jp pe,0bbf5h		;94ad
	sbc a,d			;94b0
	adc a,h			;94b1
	sub (hl)			;94b2
	sbc a,d			;94b3
	adc a,l			;94b4
	adc a,e			;94b5
	sub b			;94b6
	push af			;94b7
	and l			;94b8
	sub b			;94b9
	sub c			;94ba
	sbc a,(hl)			;94bb
	rst 18h			;94bc
	jp pe,0968dh		;94bd
	sbc a,e			;94c0
	sbc a,(hl)			;94c1
	push af			;94c2
	or b			;94c3
	sbc a,(hl)			;94c4
	adc a,h			;94c5
	sub (hl)			;94c6
	adc a,h			;94c7
	push af			;94c8
	and l			;94c9
	sub b			;94ca
	sub c			;94cb
	sbc a,(hl)			;94cc
	rst 18h			;94cd
	adc a,c			;94ce
	sub b			;94cf
	sub e			;94d0
	sbc a,h			;94d1
	jp pe,09691h		;94d2
	sbc a,h			;94d5
	sbc a,(hl)			;94d6
	push af			;94d7
	and l			;94d8
	sub b			;94d9
	sub c			;94da
	sbc a,(hl)			;94db
	rst 18h			;94dc
	sub d			;94dd
	sub b			;94de
	sub c			;94df
	adc a,e			;94e0
	sbc a,(hl)			;94e1
	push hl			;94e2
	sub b			;94e3
	adc a,h			;94e4
	sbc a,(hl)			;94e5
	push af			;94e6
	xor a			;94e7
	sbc a,(hl)			;94e8
	adc a,l			;94e9
	sbc a,(hl)			;94ea
	ret pe			;94eb
	adc a,h			;94ec
	sub b			;94ed
	push af			;94ee
	ld l,b			;94ef
	adc a,(hl)			;94f0
	add a,(hl)			;94f1
	adc a,(hl)			;94f2
	sbc a,d			;94f3
	adc a,(hl)			;94f4
	sbc a,e			;94f5
	adc a,(hl)			;94f6
	and d			;94f7
	adc a,(hl)			;94f8
	xor l			;94f9
	adc a,(hl)			;94fa
	or l			;94fb
	adc a,(hl)			;94fc
	ret c			;94fd
	adc a,(hl)			;94fe
	ex (sp),hl			;94ff
	adc a,(hl)			;9500
	rst 30h			;9501
	adc a,(hl)			;9502
	rst 38h			;9503
	adc a,(hl)			;9504
	djnz $-111		;9505
	rra			;9507
	adc a,a			;9508
	add hl,hl			;9509
	adc a,a			;950a
	ld c,c			;950b
	adc a,a			;950c
	ld c,d			;950d
	adc a,a			;950e
	ld d,c			;950f
	adc a,a			;9510
	ld d,d			;9511
	adc a,a			;9512
	ld e,d			;9513
	adc a,a			;9514
	ld l,b			;9515
	adc a,a			;9516
	ld l,c			;9517
	adc a,a			;9518
	ld l,d			;9519
	adc a,a			;951a
	ld a,(hl)			;951b
	adc a,a			;951c
	ld a,a			;951d
	adc a,a			;951e
	sub l			;951f
	adc a,a			;9520
	xor e			;9521
	adc a,a			;9522
	cp c			;9523
	adc a,a			;9524
	pop de			;9525
	adc a,a			;9526
	rlca			;9527
	sub b			;9528
	ld (03090h),hl		;9529
	sub b			;952c
	ld (03490h),a		;952d
	sub b			;9530
	dec sp			;9531
	sub b			;9532
	ccf			;9533
	sub b			;9534
	ld b,b			;9535
	sub b			;9536
	ld d,e			;9537
	sub b			;9538
	ld e,l			;9539
	sub b			;953a
	ld l,d			;953b
	sub b			;953c
	ld a,b			;953d
	sub b			;953e
	add a,d			;953f
	sub b			;9540
	sbc a,b			;9541
	sub b			;9542
	xor a			;9543
	sub b			;9544
	and 090h		;9545
	dec b			;9547
	sub c			;9548
	ld de,01f91h		;9549
	sub c			;954c
	ld (02691h),hl		;954d
	sub c			;9550
	add hl,hl			;9551
	sub c			;9552
	scf			;9553
	sub c			;9554
	ld c,b			;9555
	sub c			;9556
	ld c,e			;9557
	sub c			;9558
	ld h,d			;9559
	sub c			;955a
	ld l,c			;955b
	sub c			;955c
	ld l,e			;955d
	sub c			;955e
	ld l,l			;955f
	sub c			;9560
	ld l,(hl)			;9561
	sub c			;9562
	halt			;9563
	sub c			;9564
	ld (hl),a			;9565
	sub c			;9566
	adc a,b			;9567
	sub c			;9568
	sbc a,h			;9569
	sub c			;956a
	or c			;956b
	sub c			;956c
	rst 0			;956d
	sub c			;956e
	ret			;956f
	sub c			;9570
	call 0cf91h		;9571
	sub c			;9574
	push hl			;9575
	sub c			;9576
	rst 20h			;9577
	sub c			;9578
	jp pe,0ee91h		;9579
	sub c			;957c
	inc bc			;957d
	sub d			;957e
	inc b			;957f
	sub d			;9580
	dec b			;9581
	sub d			;9582
	ld b,092h		;9583
	rlca			;9585
	sub d			;9586
	ld de,02092h		;9587
	sub d			;958a
	inc (hl)			;958b
	sub d			;958c
	dec a			;958d
	sub d			;958e
	ld c,c			;958f
	sub d			;9590
	ld h,l			;9591
	sub d			;9592
	ld a,d			;9593
	sub d			;9594
	adc a,c			;9595
	sub d			;9596
	sub h			;9597
	sub d			;9598
	xor b			;9599
	sub d			;959a
	xor l			;959b
	sub d			;959c
	or h			;959d
	sub d			;959e
	cp e			;959f
	sub d			;95a0
	rst 0			;95a1
	sub d			;95a2
	adc a,092h		;95a3
	rst 18h			;95a5
	sub d			;95a6
	rst 20h			;95a7
	sub d			;95a8
	di			;95a9
	sub d			;95aa
	call m,01192h		;95ab
	sub e			;95ae
	dec e			;95af
	sub e			;95b0
	ld sp,04593h		;95b1
	sub e			;95b4
	ld d,c			;95b5
	sub e			;95b6
	ld h,c			;95b7
	sub e			;95b8
	ld h,h			;95b9
	sub e			;95ba
	ld l,b			;95bb
	sub e			;95bc
	ld l,d			;95bd
	sub e			;95be
	ld l,h			;95bf
	sub e			;95c0
	ld l,l			;95c1
	sub e			;95c2
	ld l,(hl)			;95c3
	sub e			;95c4
	add a,(hl)			;95c5
	sub e			;95c6
	and d			;95c7
	sub e			;95c8
	and e			;95c9
	sub e			;95ca
	and h			;95cb
	sub e			;95cc
	or d			;95cd
	sub e			;95ce
	or e			;95cf
	sub e			;95d0
	or h			;95d1
	sub e			;95d2
	cp a			;95d3
	sub e			;95d4
	res 2,e		;95d5
	exx			;95d7
	sub e			;95d8
	jp c,0f093h		;95d9
	sub e			;95dc
	ld a,(bc)			;95dd
	sub h			;95de
	dec c			;95df
	sub h			;95e0
	djnz $-106		;95e1
	inc d			;95e3
	sub h			;95e4
	jr z,$-106		;95e5
	ld l,094h		;95e7
	ld (03794h),a		;95e9
	sub h			;95ec
	dec a			;95ed
	sub h			;95ee
	ld b,l			;95ef
	sub h			;95f0
	ld c,(hl)			;95f1
	sub h			;95f2
	ld d,(hl)			;95f3
	sub h			;95f4
	ld e,a			;95f5
	sub h			;95f6
	ld h,l			;95f7
	sub h			;95f8
	ld l,e			;95f9
	sub h			;95fa
	ld (hl),d			;95fb
	sub h			;95fc
	ld a,b			;95fd
	sub h			;95fe
	add a,e			;95ff
	sub h			;9600
	adc a,d			;9601
	sub h			;9602
	sub d			;9603
	sub h			;9604
	sbc a,c			;9605
	sub h			;9606
	and b			;9607
	sub h			;9608
	and a			;9609
	sub h			;960a
	xor a			;960b
	sub h			;960c
	cp b			;960d
	sub h			;960e
	jp 0c994h		;960f
	sub h			;9612
	ret c			;9613
	sub h			;9614
	rst 20h			;9615
	sub h			;9616
	or c			;9617
	sub b			;9618
	rst 18h			;9619
	sub a			;961a
	sbc a,(hl)			;961b
	add a,(hl)			;961c
	rst 18h			;961d
	sub e			;961e
	adc a,d			;961f
	add a,l			;9620
	out (0dfh),a		;9621
	sub c			;9623
	sub b			;9624
	rst 18h			;9625
	adc a,c			;9626
	sbc a,d			;9627
	adc a,h			;9628
	pop de			;9629
	push af			;962a
	cp (hl)			;962b
	sbc a,e			;962c
	sub a			;962d
	sbc a,d			;962e
	adc a,l			;962f
	sub (hl)			;9630
	sbc a,e			;9631
	sub b			;9632
	rst 18h			;9633
	sbc a,(hl)			;9634
	rst 18h			;9635
	sub e			;9636
	sbc a,(hl)			;9637
	rst 18h			;9638
	adc a,a			;9639
	sbc a,(hl)			;963a
	adc a,l			;963b
	sbc a,d			;963c
	sbc a,e			;963d
	out (0dfh),a		;963e
	sbc a,d			;9640
	adc a,h			;9641
	adc a,e			;9642
	jp pe,08cdfh		;9643
	sub b			;9646
	sbc a,l			;9647
	adc a,l			;9648
	sbc a,d			;9649
	rst 18h			;964a
	adc a,d			;964b
	sub c			;964c
	sbc a,(hl)			;964d
	rst 18h			;964e
	adc a,d			;964f
	adc a,l			;9650
	sub c			;9651
	sbc a,(hl)			;9652
	pop de			;9653
	rst 18h			;9654
	xor e			;9655
	sub (hl)			;9656
	sbc a,d			;9657
	sub c			;9658
	sbc a,d			;9659
	rst 18h			;965a
	sbc a,c			;965b
	sub b			;965c
	adc a,l			;965d
	sub d			;965e
	sbc a,(hl)			;965f
	rst 18h			;9660
	sbc a,e			;9661
	sbc a,d			;9662
	rst 18h			;9663
	sbc a,(hl)			;9664
	sub c			;9665
	sub (hl)			;9666
	sub e			;9667
	sub e			;9668
	sub b			;9669
	push af			;966a
	cp e			;966b
	sbc a,d			;966c
	rst 18h			;966d
	sbc a,h			;966e
	sbc a,d			;966f
	adc a,l			;9670
	jp pe,09692h		;9671
	sbc a,h			;9674
	sbc a,(hl)			;9675
	push af			;9676
	xor d			;9677
	adc a,h			;9678
	sbc a,(hl)			;9679
	sbc a,e			;967a
	sub b			;967b
	rst 18h			;967c
	adc a,a			;967d
	sbc a,(hl)			;967e
	adc a,l			;967f
	sbc a,(hl)			;9680
	rst 18h			;9681
	sub b			;9682
	sbc a,c			;9683
	adc a,l			;9684
	sbc a,d			;9685
	sub c			;9686
	sbc a,e			;9687
	sbc a,(hl)			;9688
	adc a,l			;9689
	push af			;968a
	xor e			;968b
	sbc a,(hl)			;968c
	sub e			;968d
	sub e			;968e
	sbc a,(hl)			;968f
	sbc a,e			;9690
	sub b			;9691
	rst 18h			;9692
	sbc a,d			;9693
	sub c			;9694
	rst 18h			;9695
	sub e			;9696
	sbc a,(hl)			;9697
	rst 18h			;9698
	adc a,a			;9699
	sbc a,(hl)			;969a
	adc a,l			;969b
	sbc a,d			;969c
	sbc a,e			;969d
	out (0dfh),a		;969e
	adc a,e			;96a0
	sub (hl)			;96a1
	sbc a,d			;96a2
	sub c			;96a3
	sbc a,d			;96a4
	rst 18h			;96a5
	sbc a,h			;96a6
	adc a,d			;96a7
	sbc a,(hl)			;96a8
	adc a,e			;96a9
	adc a,l			;96aa
	sub b			;96ab
	rst 18h			;96ac
	sbc a,h			;96ad
	sbc a,d			;96ae
	sub e			;96af
	sbc a,e			;96b0
	sub (hl)			;96b1
	sub e			;96b2
	sub e			;96b3
	sbc a,(hl)			;96b4
	adc a,h			;96b5
	push af			;96b6
	rst 18h			;96b7
	sub c			;96b8
	sub (hl)			;96b9
	adc a,c			;96ba
	sbc a,d			;96bb
	sub e			;96bc
	push af			;96bd
	rst 18h			;96be
	xor 0bah		;96bf
	xor h			;96c1
	xor e			;96c2
	cp (hl)			;96c3
	rst 18h			;96c4
	xor c			;96c5
	cp (hl)			;96c6
	cp h			;96c7
	or (hl)			;96c8
	cp (hl)			;96c9
	sbc a,0f5h		;96ca
	push af			;96cc
	push af			;96cd
	cp b			;96ce
	adc a,l			;96cf
	sbc a,(hl)			;96d0
	sub c			;96d1
	sbc a,e			;96d2
	sbc a,d			;96d3
	rst 18h			;96d4
	add a,(hl)			;96d5
	rst 18h			;96d6
	adc a,a			;96d7
	sbc a,d			;96d8
	adc a,h			;96d9
	sbc a,(hl)			;96da
	sbc a,e			;96db
	sbc a,(hl)			;96dc
	push af			;96dd
	xor e			;96de
	sub (hl)			;96df
	sbc a,d			;96e0
	sub c			;96e1
	sbc a,d			;96e2
	rst 18h			;96e3
	adc a,d			;96e4
	sub c			;96e5
	rst 18h			;96e6
	sbc a,(hl)			;96e7
	adc a,h			;96e8
	sbc a,(hl)			;96e9
	rst 18h			;96ea
	add a,(hl)			;96eb
	rst 18h			;96ec
	sbc a,h			;96ed
	sub b			;96ee
	sub c			;96ef
	adc a,e			;96f0
	sub (hl)			;96f1
	sbc a,d			;96f2
	sub c			;96f3
	sbc a,d			;96f4
	rst 18h			;96f5
	adc a,a			;96f6
	sbc a,(hl)			;96f7
	adc a,h			;96f8
	adc a,e			;96f9
	sbc a,(hl)			;96fa
	rst 18h			;96fb
	sbc a,e			;96fc
	sbc a,d			;96fd
	rst 18h			;96fe
	cp h			;96ff
	sub b			;9700
	adc a,a			;9701
	sbc a,(hl)			;9702
	sub e			;9703
	push af			;9704
	cp e			;9705
	sbc a,d			;9706
	rst 18h			;9707
	sub b			;9708
	adc a,l			;9709
	sub b			;970a
	rst 18h			;970b
	add a,(hl)			;970c
	rst 18h			;970d
	sbc a,b			;970e
	sbc a,d			;970f
	sub d			;9710
	sbc a,(hl)			;9711
	adc a,h			;9712
	push af			;9713
	cp e			;9714
	sbc a,d			;9715
	rst 18h			;9716
	sbc a,h			;9717
	adc a,l			;9718
	sub (hl)			;9719
	adc a,h			;971a
	adc a,e			;971b
	sbc a,(hl)			;971c
	sub e			;971d
	rst 18h			;971e
	add a,(hl)			;971f
	rst 18h			;9720
	sub e			;9721
	sub e			;9722
	sbc a,d			;9723
	sub c			;9724
	sbc a,(hl)			;9725
	rst 18h			;9726
	sbc a,e			;9727
	sbc a,d			;9728
	rst 18h			;9729
	sub a			;972a
	adc a,d			;972b
	sub d			;972c
	sub b			;972d
	rst 18h			;972e
	sub e			;972f
	adc a,d			;9730
	sub d			;9731
	sub (hl)			;9732
	sub c			;9733
	sub b			;9734
	adc a,h			;9735
	sub b			;9736
	push af			;9737
	cp e			;9738
	sbc a,d			;9739
	rst 18h			;973a
	sbc a,h			;973b
	adc a,l			;973c
	sub (hl)			;973d
	adc a,h			;973e
	adc a,e			;973f
	sbc a,(hl)			;9740
	sub e			;9741
	out (0dfh),a		;9742
	sbc a,h			;9744
	sub b			;9745
	sub c			;9746
	rst 18h			;9747
	adc a,d			;9748
	sub c			;9749
	sbc a,(hl)			;974a
	rst 18h			;974b
	adc a,l			;974c
	sbc a,(hl)			;974d
	sub c			;974e
	adc a,d			;974f
	adc a,l			;9750
	sbc a,(hl)			;9751
	push af			;9752
	cp (hl)			;9753
	sub e			;9754
	adc a,d			;9755
	sbc a,h			;9756
	sub (hl)			;9757
	sub c			;9758
	rst 20h			;9759
	sbc a,b			;975a
	sbc a,d			;975b
	sub c			;975c
	sub b			;975d
	push af			;975e
	xor a			;975f
	sbc a,d			;9760
	adc a,h			;9761
	sbc a,(hl)			;9762
	sbc a,e			;9763
	sub b			;9764
	push af			;9765
	push af			;9766
	cp e			;9767
	sbc a,d			;9768
	rst 18h			;9769
	jp (hl)			;976a
	sbc a,l			;976b
	sbc a,(hl)			;976c
	sub c			;976d
	sub b			;976e
	push af			;976f
	cp e			;9770
	adc a,d			;9771
	adc a,l			;9772
	ret pe			;9773
	adc a,h			;9774
	sub (hl)			;9775
	sub d			;9776
	sbc a,(hl)			;9777
	push af			;9778
	cp e			;9779
	sbc a,d			;977a
	rst 18h			;977b
	sub b			;977c
	sbc a,l			;977d
	adc a,h			;977e
	sub (hl)			;977f
	sbc a,e			;9780
	sub (hl)			;9781
	sbc a,(hl)			;9782
	sub c			;9783
	sbc a,(hl)			;9784
	push af			;9785
	cp e			;9786
	sbc a,d			;9787
	sub e			;9788
	rst 18h			;9789
	adc a,e			;978a
	sbc a,(hl)			;978b
	sub d			;978c
	sbc a,(hl)			;978d
	push hl			;978e
	sub b			;978f
	rst 18h			;9790
	sbc a,e			;9791
	sbc a,d			;9792
	rst 18h			;9793
	adc a,d			;9794
	sub c			;9795
	rst 18h			;9796
	sbc a,h			;9797
	sub b			;9798
	sbc a,h			;9799
	sub b			;979a
	out (0dfh),a		;979b
	sub d			;979d
	adc a,d			;979e
	add a,(hl)			;979f
	rst 18h			;97a0
	sbc a,(hl)			;97a1
	sbc a,b			;97a2
	adc a,l			;97a3
	sub (hl)			;97a4
	sbc a,d			;97a5
	adc a,e			;97a6
	sbc a,(hl)			;97a7
	sbc a,e			;97a8
	sbc a,(hl)			;97a9
	rst 18h			;97aa
	adc a,a			;97ab
	sub b			;97ac
	adc a,l			;97ad
	rst 18h			;97ae
	sbc a,e			;97af
	sbc a,d			;97b0
	sbc a,l			;97b1
	sbc a,(hl)			;97b2
	sub l			;97b3
	sub b			;97b4
	push af			;97b5
	xor d			;97b6
	adc a,h			;97b7
	sbc a,(hl)			;97b8
	sbc a,e			;97b9
	sbc a,(hl)			;97ba
	rst 18h			;97bb
	adc a,a			;97bc
	sub b			;97bd
	adc a,l			;97be
	rst 18h			;97bf
	sub e			;97c0
	sub b			;97c1
	adc a,h			;97c2
	rst 18h			;97c3
	adc a,l			;97c4
	sbc a,d			;97c5
	add a,(hl)			;97c6
	sbc a,d			;97c7
	adc a,h			;97c8
	rst 18h			;97c9
	adc a,a			;97ca
	sbc a,(hl)			;97cb
	adc a,l			;97cc
	sbc a,(hl)			;97cd
	rst 18h			;97ce
	sbc a,(hl)			;97cf
	adc a,a			;97d0
	sub b			;97d1
	add a,(hl)			;97d2
	sbc a,(hl)			;97d3
	adc a,l			;97d4
	rst 18h			;97d5
	sub e			;97d6
	sbc a,(hl)			;97d7
	rst 18h			;97d8
	sbc a,c			;97d9
	adc a,l			;97da
	sbc a,d			;97db
	sub c			;97dc
	adc a,e			;97dd
	sbc a,d			;97de
	rst 18h			;97df
	sbc a,(hl)			;97e0
	sub e			;97e1
	rst 18h			;97e2
	adc a,l			;97e3
	sbc a,d			;97e4
	add a,l			;97e5
	sbc a,(hl)			;97e6
	adc a,l			;97e7
	push af			;97e8
	cp h			;97e9
	sub b			;97ea
	sub c			;97eb
	adc a,e			;97ec
	sub (hl)			;97ed
	sbc a,d			;97ee
	sub c			;97ef
	sbc a,d			;97f0
	rst 18h			;97f1
	sub e			;97f2
	sbc a,(hl)			;97f3
	adc a,h			;97f4
	rst 18h			;97f5
	sub e			;97f6
	sbc a,d			;97f7
	add a,(hl)			;97f8
	sbc a,d			;97f9
	sub c			;97fa
	sbc a,e			;97fb
	sbc a,(hl)			;97fc
	adc a,h			;97fd
	rst 18h			;97fe
	sbc a,e			;97ff
	sbc a,d			;9800
	sub e			;9801
	rst 18h			;9802
	xor (hl)			;9803
	adc a,d			;9804
	sub (hl)			;9805
	sbc a,h			;9806
	sub a			;9807
	jp (hl)			;9808
	push af			;9809
	or e			;980a
	sub (hl)			;980b
	sbc a,l			;980c
	adc a,l			;980d
	sub b			;980e
	rst 18h			;980f
	sbc a,e			;9810
	sbc a,d			;9811
	rst 18h			;9812
	sub e			;9813
	sbc a,(hl)			;9814
	adc a,h			;9815
	rst 18h			;9816
	adc a,a			;9817
	adc a,l			;9818
	sub b			;9819
	sbc a,c			;981a
	sbc a,d			;981b
	sbc a,h			;981c
	ret pe			;981d
	sbc a,(hl)			;981e
	adc a,h			;981f
	rst 18h			;9820
	sbc a,e			;9821
	sbc a,d			;9822
	sub e			;9823
	rst 18h			;9824
	and (hl)			;9825
	adc a,d			;9826
	sbc a,h			;9827
	sbc a,(hl)			;9828
	adc a,e			;9829
	jp pe,0f591h		;982a
	xor e			;982d
	adc a,l			;982e
	sbc a,(hl)			;982f
	adc a,e			;9830
	sbc a,(hl)			;9831
	rst 18h			;9832
	adc a,h			;9833
	sub b			;9834
	sbc a,l			;9835
	adc a,l			;9836
	sbc a,d			;9837
	rst 18h			;9838
	sub e			;9839
	sbc a,(hl)			;983a
	rst 18h			;983b
	sub a			;983c
	sub (hl)			;983d
	adc a,h			;983e
	adc a,e			;983f
	sub b			;9840
	adc a,l			;9841
	sub (hl)			;9842
	sbc a,(hl)			;9843
	rst 18h			;9844
	add a,(hl)			;9845
	rst 18h			;9846
	sub d			;9847
	sub (hl)			;9848
	adc a,e			;9849
	sub b			;984a
	sub e			;984b
	sub b			;984c
	sbc a,b			;984d
	ret pe			;984e
	sbc a,(hl)			;984f
	rst 18h			;9850
	sbc a,e			;9851
	sbc a,d			;9852
	rst 18h			;9853
	sub e			;9854
	sub b			;9855
	adc a,h			;9856
	rst 18h			;9857
	adc a,h			;9858
	sbc a,d			;9859
	push hl			;985a
	sub b			;985b
	adc a,l			;985c
	sbc a,d			;985d
	adc a,h			;985e
	rst 18h			;985f
	sbc a,e			;9860
	sbc a,d			;9861
	rst 18h			;9862
	cp h			;9863
	sbc a,(hl)			;9864
	sub h			;9865
	sbc a,h			;9866
	sub a			;9867
	sub (hl)			;9868
	adc a,(hl)			;9869
	adc a,d			;986a
	sbc a,d			;986b
	sub e			;986c
	push af			;986d
	or c			;986e
	sbc a,(hl)			;986f
	adc a,l			;9870
	adc a,l			;9871
	sbc a,(hl)			;9872
	rst 18h			;9873
	sub e			;9874
	sbc a,(hl)			;9875
	rst 18h			;9876
	sub d			;9877
	sub (hl)			;9878
	adc a,e			;9879
	sub b			;987a
	sub e			;987b
	sub b			;987c
	sbc a,b			;987d
	ret pe			;987e
	sbc a,(hl)			;987f
	rst 18h			;9880
	sbc a,e			;9881
	sbc a,d			;9882
	rst 18h			;9883
	xor e			;9884
	sub b			;9885
	adc a,e			;9886
	sub b			;9887
	sub c			;9888
	sub (hl)			;9889
	sbc a,h			;988a
	sbc a,(hl)			;988b
	adc a,a			;988c
	jp pe,0f591h		;988d
	xor e			;9890
	sub b			;9891
	sub c			;9892
	adc a,e			;9893
	sbc a,(hl)			;9894
	sub d			;9895
	sbc a,d			;9896
	sub c			;9897
	adc a,e			;9898
	sbc a,d			;9899
	out (0dfh),a		;989a
	sub e			;989c
	sub b			;989d
	rst 18h			;989e
	sub d			;989f
	sub (hl)			;98a0
	adc a,l			;98a1
	sbc a,(hl)			;98a2
	adc a,h			;98a3
	rst 18h			;98a4
	add a,(hl)			;98a5
	rst 18h			;98a6
	sbc a,(hl)			;98a7
	sub e			;98a8
	rst 18h			;98a9
	sub (hl)			;98aa
	sub c			;98ab
	adc a,h			;98ac
	adc a,e			;98ad
	sbc a,(hl)			;98ae
	sub c			;98af
	adc a,e			;98b0
	sbc a,d			;98b1
	rst 18h			;98b2
	adc a,e			;98b3
	adc a,d			;98b4
	rst 18h			;98b5
	adc a,c			;98b6
	sub b			;98b7
	sub e			;98b8
	adc a,d			;98b9
	sub c			;98ba
	adc a,e			;98bb
	sbc a,(hl)			;98bc
	sbc a,e			;98bd
	rst 18h			;98be
	adc a,h			;98bf
	sbc a,d			;98c0
	rst 18h			;98c1
	sbc a,(hl)			;98c2
	sub c			;98c3
	adc a,d			;98c4
	sub e			;98c5
	sbc a,(hl)			;98c6
	pop de			;98c7
	rst 18h			;98c8
	xor c			;98c9
	sbc a,(hl)			;98ca
	sbc a,b			;98cb
	sbc a,(hl)			;98cc
	adc a,l			;98cd
	jp pe,0df8ch		;98ce
	adc a,a			;98d1
	sub b			;98d2
	adc a,l			;98d3
	rst 18h			;98d4
	adc a,h			;98d5
	sub (hl)			;98d6
	sbc a,d			;98d7
	sub d			;98d8
	adc a,a			;98d9
	adc a,l			;98da
	sbc a,d			;98db
	rst 18h			;98dc
	sbc a,d			;98dd
	sub c			;98de
	rst 18h			;98df
	and a			;98e0
	sub (hl)			;98e1
	sbc a,l			;98e2
	sbc a,(hl)			;98e3
	sub e			;98e4
	sbc a,l			;98e5
	jp pe,0d1d1h		;98e6
	push af			;98e9
	push af			;98ea
	push af			;98eb
	push af			;98ec
	cp e			;98ed
	sbc a,d			;98ee
	rst 18h			;98ef
	sbc a,l			;98f0
	adc a,l			;98f1
	sub b			;98f2
	sub c			;98f3
	sbc a,h			;98f4
	sbc a,d			;98f5
	out (0dfh),a		;98f6
	adc a,a			;98f8
	sbc a,(hl)			;98f9
	adc a,l			;98fa
	sbc a,(hl)			;98fb
	rst 18h			;98fc
	adc a,e			;98fd
	sbc a,(hl)			;98fe
	sub e			;98ff
	sub e			;9900
	sbc a,(hl)			;9901
	rst 18h			;9902
	sbc a,b			;9903
	sub (hl)			;9904
	sbc a,b			;9905
	sbc a,(hl)			;9906
	sub c			;9907
	adc a,e			;9908
	sbc a,d			;9909
	push af			;990a
	push af			;990b
	push af			;990c
	xor a			;990d
	sbc a,d			;990e
	adc a,(hl)			;990f
	adc a,d			;9910
	sbc a,d			;9911
	push hl			;9912
	sub b			;9913
	rst 18h			;9914
	sbc a,c			;9915
	adc a,l			;9916
	sbc a,(hl)			;9917
	adc a,h			;9918
	sbc a,h			;9919
	sub b			;991a
	rst 18h			;991b
	sbc a,e			;991c
	sbc a,d			;991d
	rst 18h			;991e
	sbc a,d			;991f
	adc a,h			;9920
	adc a,e			;9921
	adc a,l			;9922
	sbc a,d			;9923
	sbc a,h			;9924
	sub a			;9925
	sbc a,(hl)			;9926
	rst 18h			;9927
	sbc a,l			;9928
	sub b			;9929
	sbc a,h			;992a
	sbc a,(hl)			;992b
	push af			;992c
	or e			;992d
	sbc a,(hl)			;992e
	rst 18h			;992f
	sbc a,l			;9930
	sub b			;9931
	adc a,e			;9932
	sbc a,d			;9933
	sub e			;9934
	sub e			;9935
	sbc a,(hl)			;9936
	rst 18h			;9937
	sbc a,h			;9938
	sub b			;9939
	sub c			;993a
	adc a,e			;993b
	sub (hl)			;993c
	sbc a,d			;993d
	sub c			;993e
	sbc a,d			;993f
	rst 18h			;9940
	adc a,d			;9941
	sub c			;9942
	rst 18h			;9943
	sbc a,d			;9944
	add a,a			;9945
	adc a,e			;9946
	adc a,l			;9947
	sbc a,(hl)			;9948
	push hl			;9949
	sub b			;994a
	rst 18h			;994b
	sub e			;994c
	ret pe			;994d
	adc a,(hl)			;994e
	adc a,d			;994f
	sub (hl)			;9950
	sbc a,e			;9951
	sub b			;9952
	push af			;9953
	cp h			;9954
	sub b			;9955
	sub c			;9956
	rst 18h			;9957
	sub d			;9958
	sub (hl)			;9959
	sbc a,d			;995a
	sub e			;995b
	push af			;995c
	or d			;995d
	jp pe,09c8ch		;995e
	sbc a,(hl)			;9961
	adc a,l			;9962
	sbc a,(hl)			;9963
	rst 18h			;9964
	sbc a,e			;9965
	sbc a,d			;9966
	sub e			;9967
	rst 18h			;9968
	sbc a,e			;9969
	sub (hl)			;996a
	sub b			;996b
	adc a,h			;996c
	rst 18h			;996d
	sbc a,e			;996e
	sbc a,d			;996f
	rst 18h			;9970
	sub e			;9971
	sub b			;9972
	adc a,h			;9973
	rst 18h			;9974
	adc a,c			;9975
	sub b			;9976
	sub e			;9977
	sbc a,h			;9978
	sbc a,(hl)			;9979
	sub c			;997a
	sbc a,d			;997b
	adc a,h			;997c
	push af			;997d
	cp d			;997e
	add a,a			;997f
	adc a,e			;9980
	adc a,l			;9981
	sbc a,(hl)			;9982
	push hl			;9983
	sub b			;9984
	rst 18h			;9985
	sbc a,c			;9986
	adc a,l			;9987
	adc a,d			;9988
	adc a,e			;9989
	sub b			;998a
	rst 18h			;998b
	sbc a,h			;998c
	sub b			;998d
	sub d			;998e
	adc a,a			;998f
	sbc a,d			;9990
	sub c			;9991
	sbc a,e			;9992
	sub (hl)			;9993
	sub b			;9994
	rst 18h			;9995
	sbc a,e			;9996
	sbc a,d			;9997
	rst 18h			;9998
	adc a,e			;9999
	sub b			;999a
	sbc a,e			;999b
	sbc a,(hl)			;999c
	rst 18h			;999d
	sbc a,c			;999e
	adc a,l			;999f
	adc a,d			;99a0
	adc a,e			;99a1
	sbc a,(hl)			;99a2
	push af			;99a3
	or e			;99a4
	sbc a,(hl)			;99a5
	sbc a,b			;99a6
	adc a,d			;99a7
	sub c			;99a8
	sbc a,(hl)			;99a9
	rst 18h			;99aa
	adc a,h			;99ab
	adc a,d			;99ac
	sbc a,l			;99ad
	adc a,e			;99ae
	sbc a,d			;99af
	adc a,l			;99b0
	adc a,l			;99b1
	jp pe,09a91h		;99b2
	sbc a,(hl)			;99b5
	pop de			;99b6
	push af			;99b7
	cp d			;99b8
	sub c			;99b9
	rst 18h			;99ba
	adc a,h			;99bb
	adc a,d			;99bc
	rst 18h			;99bd
	sub (hl)			;99be
	sub c			;99bf
	adc a,e			;99c0
	sbc a,d			;99c1
	adc a,l			;99c2
	sub (hl)			;99c3
	sub b			;99c4
	adc a,l			;99c5
	rst 18h			;99c6
	adc a,h			;99c7
	sbc a,d			;99c8
	rst 18h			;99c9
	adc a,(hl)			;99ca
	adc a,d			;99cb
	sbc a,d			;99cc
	sub d			;99cd
	sbc a,(hl)			;99ce
	rst 18h			;99cf
	sbc a,(hl)			;99d0
	sub e			;99d1
	sbc a,b			;99d2
	sub b			;99d3
	rst 18h			;99d4
	adc a,(hl)			;99d5
	adc a,d			;99d6
	sbc a,d			;99d7
	rst 18h			;99d8
	adc a,a			;99d9
	adc a,l			;99da
	sub b			;99db
	sbc a,e			;99dc
	adc a,d			;99dd
	sbc a,h			;99de
	sbc a,d			;99df
	rst 18h			;99e0
	sub a			;99e1
	adc a,d			;99e2
	sub d			;99e3
	sub b			;99e4
	rst 18h			;99e5
	sub e			;99e6
	adc a,d			;99e7
	sub d			;99e8
	sub (hl)			;99e9
	sub c			;99ea
	sub b			;99eb
	adc a,h			;99ec
	sub b			;99ed
	pop de			;99ee
	push af			;99ef
	xor l			;99f0
	adc a,d			;99f1
	sub (hl)			;99f2
	sub c			;99f3
	sub b			;99f4
	adc a,h			;99f5
	sbc a,(hl)			;99f6
	pop de			;99f7
	push af			;99f8
	or d			;99f9
	adc a,d			;99fa
	add a,(hl)			;99fb
	rst 18h			;99fc
	sub e			;99fd
	adc a,d			;99fe
	sub d			;99ff
	sub (hl)			;9a00
	sub c			;9a01
	sub b			;9a02
	adc a,h			;9a03
	sub b			;9a04
	pop de			;9a05
	push af			;9a06
	xor a			;9a07
	sbc a,(hl)			;9a08
	adc a,h			;9a09
	adc a,e			;9a0a
	sbc a,(hl)			;9a0b
	rst 18h			;9a0c
	sbc a,e			;9a0d
	sbc a,d			;9a0e
	rst 18h			;9a0f
	sbc a,h			;9a10
	sub b			;9a11
	adc a,a			;9a12
	sbc a,(hl)			;9a13
	sub e			;9a14
	pop de			;9a15
	rst 18h			;9a16
	cp d			;9a17
	adc a,h			;9a18
	adc a,e			;9a19
	jp pe,0f5dfh		;9a1a
	sbc a,l			;9a1d
	sub e			;9a1e
	sbc a,(hl)			;9a1f
	sub c			;9a20
	sbc a,e			;9a21
	sbc a,(hl)			;9a22
	push af			;9a23
	sbc a,(hl)			;9a24
	sbc a,l			;9a25
	sub e			;9a26
	sbc a,(hl)			;9a27
	sub c			;9a28
	sbc a,e			;9a29
	jp pe,09b91h		;9a2a
	sub b			;9a2d
	adc a,h			;9a2e
	sbc a,d			;9a2f
	push af			;9a30
	sbc a,d			;9a31
	sub c			;9a32
	sbc a,e			;9a33
	adc a,d			;9a34
	adc a,l			;9a35
	sbc a,d			;9a36
	sbc a,h			;9a37
	sub (hl)			;9a38
	jp (hl)			;9a39
	sub c			;9a3a
	sbc a,e			;9a3b
	sub b			;9a3c
	adc a,h			;9a3d
	sbc a,d			;9a3e
	push af			;9a3f
	sbc a,e			;9a40
	adc a,d			;9a41
	adc a,l			;9a42
	sbc a,(hl)			;9a43
	push af			;9a44
	or e			;9a45
	sbc a,(hl)			;9a46
	rst 18h			;9a47
	adc a,a			;9a48
	sub (hl)			;9a49
	sbc a,d			;9a4a
	sbc a,e			;9a4b
	adc a,l			;9a4c
	sbc a,(hl)			;9a4d
	adc a,h			;9a4e
	rst 18h			;9a4f
	sub a			;9a50
	adc a,d			;9a51
	sub d			;9a52
	sbc a,d			;9a53
	sbc a,(hl)			;9a54
	sub c			;9a55
	pop de			;9a56
	rst 18h			;9a57
	cp (hl)			;9a58
	sub e			;9a59
	rst 18h			;9a5a
	sbc a,(hl)			;9a5b
	sbc a,h			;9a5c
	sbc a,d			;9a5d
	adc a,l			;9a5e
	sbc a,h			;9a5f
	sbc a,(hl)			;9a60
	adc a,l			;9a61
	adc a,e			;9a62
	sbc a,d			;9a63
	out (0dfh),a		;9a64
	adc a,e			;9a66
	adc a,d			;9a67
	adc a,h			;9a68
	rst 18h			;9a69
	adc a,a			;9a6a
	sub (hl)			;9a6b
	sbc a,d			;9a6c
	adc a,h			;9a6d
	rst 18h			;9a6e
	sbc a,(hl)			;9a6f
	adc a,l			;9a70
	sbc a,e			;9a71
	sbc a,d			;9a72
	sub c			;9a73
	out (0dfh),a		;9a74
	add a,(hl)			;9a76
	rst 18h			;9a77
	sbc a,(hl)			;9a78
	sub e			;9a79
	rst 18h			;9a7a
	adc a,e			;9a7b
	sub b			;9a7c
	sbc a,h			;9a7d
	sbc a,(hl)			;9a7e
	adc a,l			;9a7f
	sub e			;9a80
	sbc a,(hl)			;9a81
	adc a,h			;9a82
	out (0dfh),a		;9a83
	adc a,e			;9a85
	adc a,d			;9a86
	adc a,h			;9a87
	rst 18h			;9a88
	sbc a,e			;9a89
	sbc a,d			;9a8a
	sbc a,e			;9a8b
	sub b			;9a8c
	adc a,h			;9a8d
	rst 18h			;9a8e
	adc a,h			;9a8f
	sbc a,d			;9a90
	rst 18h			;9a91
	sbc a,h			;9a92
	sub b			;9a93
	sub c			;9a94
	adc a,c			;9a95
	sub (hl)			;9a96
	sbc a,d			;9a97
	adc a,l			;9a98
	adc a,e			;9a99
	sbc a,d			;9a9a
	sub c			;9a9b
	rst 18h			;9a9c
	sbc a,d			;9a9d
	sub c			;9a9e
	rst 18h			;9a9f
	adc a,e			;9aa0
	sub (hl)			;9aa1
	add a,l			;9aa2
	sub b			;9aa3
	sub c			;9aa4
	sbc a,d			;9aa5
	adc a,h			;9aa6
	pop de			;9aa7
	rst 18h			;9aa8
	or e			;9aa9
	sbc a,(hl)			;9aaa
	rst 18h			;9aab
	sbc a,h			;9aac
	sub b			;9aad
	adc a,h			;9aae
	sbc a,(hl)			;9aaf
	rst 18h			;9ab0
	sbc a,d			;9ab1
	adc a,h			;9ab2
	adc a,e			;9ab3
	jp pe,08edfh		;9ab4
	adc a,d			;9ab7
	sbc a,d			;9ab8
	rst 18h			;9ab9
	sbc a,(hl)			;9aba
	adc a,l			;9abb
	sbc a,e			;9abc
	sbc a,d			;9abd
	out (0dfh),a		;9abe
	defb 0edh;next byte illegal after ed		;9ac0
	sub c			;9ac1
	sub b			;9ac2
	ret nz			;9ac3
	push af			;9ac4
	xor a			;9ac5
	sbc a,(hl)			;9ac6
	adc a,l			;9ac7
	adc a,e			;9ac8
	sbc a,d			;9ac9
	rst 18h			;9aca
	sbc a,e			;9acb
	sbc a,d			;9acc
	rst 18h			;9acd
	adc a,d			;9ace
	sub c			;9acf
	rst 18h			;9ad0
	sbc a,(hl)			;9ad1
	sub c			;9ad2
	adc a,e			;9ad3
	sub (hl)			;9ad4
	sbc a,b			;9ad5
	adc a,d			;9ad6
	sub b			;9ad7
	rst 18h			;9ad8
	sbc a,(hl)			;9ad9
	sbc a,h			;9ada
	adc a,d			;9adb
	sbc a,d			;9adc
	sbc a,e			;9add
	adc a,d			;9ade
	sbc a,h			;9adf
	adc a,e			;9ae0
	sub b			;9ae1
	pop de			;9ae2
	rst 18h			;9ae3
	or a			;9ae4
	sbc a,(hl)			;9ae5
	add a,(hl)			;9ae6
	rst 18h			;9ae7
	adc a,d			;9ae8
	sub c			;9ae9
	rst 18h			;9aea
	sbc a,(hl)			;9aeb
	sbc a,b			;9aec
	adc a,d			;9aed
	sub l			;9aee
	sbc a,d			;9aef
	adc a,l			;9af0
	sub b			;9af1
	rst 18h			;9af2
	sbc a,e			;9af3
	sbc a,d			;9af4
	sub e			;9af5
	rst 18h			;9af6
	adc a,e			;9af7
	sbc a,(hl)			;9af8
	sub d			;9af9
	sbc a,(hl)			;9afa
	push hl			;9afb
	sub b			;9afc
	rst 18h			;9afd
	sbc a,e			;9afe
	sbc a,d			;9aff
	rst 18h			;9b00
	adc a,d			;9b01
	sub c			;9b02
	rst 18h			;9b03
	sbc a,h			;9b04
	sub b			;9b05
	sbc a,h			;9b06
	sub b			;9b07
	rst 18h			;9b08
	adc a,a			;9b09
	sub b			;9b0a
	adc a,l			;9b0b
	rst 18h			;9b0c
	sbc a,d			;9b0d
	sub e			;9b0e
	rst 18h			;9b0f
	adc a,(hl)			;9b10
	adc a,d			;9b11
	sbc a,d			;9b12
	rst 18h			;9b13
	sbc a,d			;9b14
	adc a,h			;9b15
	sbc a,h			;9b16
	sbc a,(hl)			;9b17
	adc a,a			;9b18
	sbc a,(hl)			;9b19
	rst 18h			;9b1a
	sbc a,d			;9b1b
	sub e			;9b1c
	rst 18h			;9b1d
	sbc a,(hl)			;9b1e
	sbc a,b			;9b1f
	adc a,d			;9b20
	sbc a,(hl)			;9b21
	pop de			;9b22
	push af			;9b23
	cp d			;9b24
	sub e			;9b25
	rst 18h			;9b26
	sbc a,(hl)			;9b27
	sbc a,b			;9b28
	adc a,d			;9b29
	sub l			;9b2a
	sbc a,d			;9b2b
	adc a,l			;9b2c
	sub b			;9b2d
	rst 18h			;9b2e
	sbc a,d			;9b2f
	adc a,h			;9b30
	adc a,e			;9b31
	jp pe,08bdfh		;9b32
	sbc a,(hl)			;9b35
	adc a,a			;9b36
	sbc a,(hl)			;9b37
	sbc a,e			;9b38
	sub b			;9b39
	rst 18h			;9b3a
	sbc a,h			;9b3b
	sub b			;9b3c
	sub c			;9b3d
	rst 18h			;9b3e
	sub e			;9b3f
	sbc a,(hl)			;9b40
	rst 18h			;9b41
	adc a,c			;9b42
	sbc a,(hl)			;9b43
	adc a,h			;9b44
	sub (hl)			;9b45
	sub l			;9b46
	sbc a,(hl)			;9b47
	pop de			;9b48
	push af			;9b49
	cp d			;9b4a
	sub e			;9b4b
	rst 18h			;9b4c
	sbc a,(hl)			;9b4d
	sbc a,b			;9b4e
	adc a,d			;9b4f
	sbc a,(hl)			;9b50
	rst 18h			;9b51
	adc a,h			;9b52
	sbc a,d			;9b53
	rst 18h			;9b54
	sbc a,c			;9b55
	sub (hl)			;9b56
	sub e			;9b57
	adc a,e			;9b58
	adc a,l			;9b59
	sbc a,(hl)			;9b5a
	rst 18h			;9b5b
	sub a			;9b5c
	sbc a,(hl)			;9b5d
	sbc a,h			;9b5e
	sub (hl)			;9b5f
	sbc a,(hl)			;9b60
	rst 18h			;9b61
	sub a			;9b62
	sbc a,(hl)			;9b63
	sbc a,l			;9b64
	sub (hl)			;9b65
	adc a,e			;9b66
	sbc a,(hl)			;9b67
	sbc a,h			;9b68
	sub (hl)			;9b69
	sub b			;9b6a
	sub c			;9b6b
	sbc a,d			;9b6c
	adc a,h			;9b6d
	rst 18h			;9b6e
	sub (hl)			;9b6f
	sub c			;9b70
	sbc a,c			;9b71
	sbc a,d			;9b72
	adc a,l			;9b73
	sub (hl)			;9b74
	sub b			;9b75
	adc a,l			;9b76
	sbc a,d			;9b77
	adc a,h			;9b78
	pop de			;9b79
	push af			;9b7a
	cp (hl)			;9b7b
	sbc a,h			;9b7c
	sub (hl)			;9b7d
	sbc a,e			;9b7e
	sub b			;9b7f
	rst 18h			;9b80
	sbc a,h			;9b81
	sub (hl)			;9b82
	sbc a,(hl)			;9b83
	sub c			;9b84
	sub a			;9b85
	ret pe			;9b86
	sbc a,e			;9b87
	adc a,l			;9b88
	sub (hl)			;9b89
	sbc a,h			;9b8a
	sub b			;9b8b
	pop de			;9b8c
	rst 18h			;9b8d
	xor h			;9b8e
	sub (hl)			;9b8f
	sbc a,d			;9b90
	sub c			;9b91
	adc a,e			;9b92
	sbc a,d			;9b93
	adc a,h			;9b94
	rst 18h			;9b95
	adc a,h			;9b96
	adc a,d			;9b97
	adc a,h			;9b98
	rst 18h			;9b99
	sbc a,d			;9b9a
	sbc a,c			;9b9b
	sbc a,d			;9b9c
	sbc a,h			;9b9d
	adc a,e			;9b9e
	sub b			;9b9f
	adc a,h			;9ba0
	pop de			;9ba1
	push af			;9ba2
	or e			;9ba3
	sbc a,(hl)			;9ba4
	rst 18h			;9ba5
	adc a,l			;9ba6
	sbc a,d			;9ba7
	sbc a,(hl)			;9ba8
	sbc a,h			;9ba9
	sbc a,h			;9baa
	sub (hl)			;9bab
	rst 20h			;9bac
	sub c			;9bad
	rst 18h			;9bae
	sbc a,e			;9baf
	sbc a,d			;9bb0
	sub e			;9bb1
	rst 18h			;9bb2
	sbc a,(hl)			;9bb3
	sbc a,b			;9bb4
	adc a,d			;9bb5
	sbc a,(hl)			;9bb6
	rst 18h			;9bb7
	sbc a,h			;9bb8
	sub b			;9bb9
	sub c			;9bba
	rst 18h			;9bbb
	sub e			;9bbc
	sbc a,(hl)			;9bbd
	rst 18h			;9bbe
	adc a,c			;9bbf
	sbc a,d			;9bc0
	adc a,e			;9bc1
	sbc a,(hl)			;9bc2
	rst 18h			;9bc3
	adc a,a			;9bc4
	adc a,l			;9bc5
	sub b			;9bc6
	sbc a,e			;9bc7
	adc a,d			;9bc8
	sbc a,h			;9bc9
	sbc a,d			;9bca
	rst 18h			;9bcb
	sbc a,d			;9bcc
	sub e			;9bcd
	rst 18h			;9bce
	sbc a,b			;9bcf
	sbc a,(hl)			;9bd0
	adc a,h			;9bd1
	pop de			;9bd2
	push af			;9bd3
	cp h			;9bd4
	sub (hl)			;9bd5
	sbc a,(hl)			;9bd6
	sub c			;9bd7
	adc a,d			;9bd8
	adc a,l			;9bd9
	sub b			;9bda
	rst 18h			;9bdb
	adc a,a			;9bdc
	sub b			;9bdd
	adc a,e			;9bde
	jp pe,0968ch		;9bdf
	sbc a,h			;9be2
	sub b			;9be3
	pop de			;9be4
	push af			;9be5
	or e			;9be6
	sub b			;9be7
	rst 18h			;9be8
	sbc a,h			;9be9
	adc a,l			;9bea
	adc a,d			;9beb
	add a,l			;9bec
	sbc a,(hl)			;9bed
	rst 18h			;9bee
	adc a,d			;9bef
	sub c			;9bf0
	sbc a,(hl)			;9bf1
	rst 18h			;9bf2
	adc a,c			;9bf3
	sbc a,d			;9bf4
	adc a,e			;9bf5
	sbc a,(hl)			;9bf6
	pop de			;9bf7
	push af			;9bf8
	cp h			;9bf9
	sbc a,(hl)			;9bfa
	sub b			;9bfb
	sbc a,l			;9bfc
	sbc a,(hl)			;9bfd
	out (0dfh),a		;9bfe
	sub e			;9c00
	sbc a,(hl)			;9c01
	rst 18h			;9c02
	sub d			;9c03
	jp pe,0df8ch		;9c04
	sbc a,e			;9c07
	adc a,d			;9c08
	adc a,l			;9c09
	sbc a,(hl)			;9c0a
	rst 18h			;9c0b
	sub d			;9c0c
	sbc a,(hl)			;9c0d
	sbc a,e			;9c0e
	sbc a,d			;9c0f
	adc a,l			;9c10
	sbc a,(hl)			;9c11
	pop de			;9c12
	rst 18h			;9c13
	or e			;9c14
	sub b			;9c15
	adc a,h			;9c16
	rst 18h			;9c17
	adc a,h			;9c18
	sub (hl)			;9c19
	sbc a,b			;9c1a
	sub e			;9c1b
	sub b			;9c1c
	adc a,h			;9c1d
	rst 18h			;9c1e
	sub e			;9c1f
	sbc a,(hl)			;9c20
	rst 18h			;9c21
	sub a			;9c22
	sbc a,(hl)			;9c23
	sub c			;9c24
	rst 18h			;9c25
	sbc a,h			;9c26
	adc a,d			;9c27
	sbc a,(hl)			;9c28
	adc a,h			;9c29
	sub (hl)			;9c2a
	adc a,a			;9c2b
	sbc a,d			;9c2c
	adc a,e			;9c2d
	adc a,l			;9c2e
	sub (hl)			;9c2f
	sbc a,c			;9c30
	sub (hl)			;9c31
	sbc a,h			;9c32
	sbc a,(hl)			;9c33
	sbc a,e			;9c34
	sub b			;9c35
	pop de			;9c36
	rst 18h			;9c37
	cp d			;9c38
	adc a,h			;9c39
	adc a,e			;9c3a
	jp pe,09edfh		;9c3b
	sub e			;9c3e
	sbc a,b			;9c3f
	sub b			;9c40
	rst 18h			;9c41
	sbc a,e			;9c42
	sbc a,d			;9c43
	adc a,h			;9c44
	adc a,a			;9c45
	sbc a,d			;9c46
	sbc a,b			;9c47
	sbc a,(hl)			;9c48
	sbc a,e			;9c49
	sbc a,(hl)			;9c4a
	rst 18h			;9c4b
	sbc a,e			;9c4c
	sbc a,d			;9c4d
	sub e			;9c4e
	rst 18h			;9c4f
	adc a,h			;9c50
	adc a,d			;9c51
	sbc a,d			;9c52
	sub e			;9c53
	sub b			;9c54
	rst 18h			;9c55
	add a,(hl)			;9c56
	rst 18h			;9c57
	adc a,e			;9c58
	sub (hl)			;9c59
	sbc a,d			;9c5a
	sub c			;9c5b
	sbc a,d			;9c5c
	rst 18h			;9c5d
	adc a,d			;9c5e
	sub c			;9c5f
	sbc a,(hl)			;9c60
	rst 18h			;9c61
	adc a,l			;9c62
	sbc a,(hl)			;9c63
	sub c			;9c64
	adc a,d			;9c65
	adc a,l			;9c66
	sbc a,(hl)			;9c67
	pop de			;9c68
	rst 18h			;9c69
	rst 18h			;9c6a
	push af			;9c6b
	xor h			;9c6c
	sub b			;9c6d
	sbc a,l			;9c6e
	adc a,l			;9c6f
	sbc a,d			;9c70
	adc a,h			;9c71
	sbc a,(hl)			;9c72
	sub e			;9c73
	sbc a,d			;9c74
	rst 18h			;9c75
	add a,(hl)			;9c76
	rst 18h			;9c77
	sbc a,d			;9c78
	adc a,h			;9c79
	rst 18h			;9c7a
	sub d			;9c7b
	rst 20h			;9c7c
	adc a,c			;9c7d
	sub (hl)			;9c7e
	sub e			;9c7f
	pop de			;9c80
	push af			;9c81
	or a			;9c82
	sbc a,(hl)			;9c83
	add a,(hl)			;9c84
	rst 18h			;9c85
	sbc a,e			;9c86
	sub b			;9c87
	adc a,h			;9c88
	out (0dfh),a		;9c89
	adc a,d			;9c8b
	sub c			;9c8c
	sbc a,(hl)			;9c8d
	rst 18h			;9c8e
	sbc a,(hl)			;9c8f
	rst 18h			;9c90
	sbc a,h			;9c91
	sbc a,(hl)			;9c92
	sbc a,e			;9c93
	sbc a,(hl)			;9c94
	rst 18h			;9c95
	sub e			;9c96
	sbc a,(hl)			;9c97
	sbc a,e			;9c98
	sub b			;9c99
	rst 18h			;9c9a
	sbc a,e			;9c9b
	sbc a,d			;9c9c
	rst 18h			;9c9d
	sub e			;9c9e
	sbc a,(hl)			;9c9f
	rst 18h			;9ca0
	sub e			;9ca1
	sub b			;9ca2
	adc a,h			;9ca3
	sbc a,(hl)			;9ca4
	pop de			;9ca5
	push af			;9ca6
	cp d			;9ca7
	sub c			;9ca8
	sub b			;9ca9
	adc a,l			;9caa
	sub d			;9cab
	sbc a,d			;9cac
	rst 18h			;9cad
	sbc a,d			;9cae
	adc a,h			;9caf
	sbc a,c			;9cb0
	sbc a,d			;9cb1
	adc a,l			;9cb2
	sbc a,(hl)			;9cb3
	rst 18h			;9cb4
	adc a,(hl)			;9cb5
	adc a,d			;9cb6
	sbc a,d			;9cb7
	rst 18h			;9cb8
	adc a,l			;9cb9
	sbc a,d			;9cba
	adc a,a			;9cbb
	adc a,l			;9cbc
	sbc a,d			;9cbd
	adc a,h			;9cbe
	sbc a,d			;9cbf
	sub c			;9cc0
	adc a,e			;9cc1
	sbc a,(hl)			;9cc2
	rst 18h			;9cc3
	sbc a,(hl)			;9cc4
	sub e			;9cc5
	rst 18h			;9cc6
	adc a,h			;9cc7
	sub b			;9cc8
	sub e			;9cc9
	pop de			;9cca
	push af			;9ccb
	rst 18h			;9ccc
	or e			;9ccd
	sbc a,(hl)			;9cce
	adc a,h			;9ccf
	rst 18h			;9cd0
	adc a,a			;9cd1
	sbc a,(hl)			;9cd2
	adc a,l			;9cd3
	sbc a,d			;9cd4
	sbc a,e			;9cd5
	sbc a,d			;9cd6
	adc a,h			;9cd7
	rst 18h			;9cd8
	sbc a,e			;9cd9
	sbc a,d			;9cda
	rst 18h			;9cdb
	sub e			;9cdc
	sbc a,(hl)			;9cdd
	rst 18h			;9cde
	sub a			;9cdf
	sbc a,(hl)			;9ce0
	sbc a,l			;9ce1
	sub (hl)			;9ce2
	adc a,e			;9ce3
	sbc a,(hl)			;9ce4
	sbc a,h			;9ce5
	sub (hl)			;9ce6
	rst 20h			;9ce7
	sub c			;9ce8
	rst 18h			;9ce9
	sub e			;9cea
	sub b			;9ceb
	rst 18h			;9cec
	adc a,l			;9ced
	sbc a,d			;9cee
	adc a,e			;9cef
	sub (hl)			;9cf0
	sbc a,d			;9cf1
	sub c			;9cf2
	sbc a,d			;9cf3
	sub c			;9cf4
	rst 18h			;9cf5
	sub d			;9cf6
	sbc a,d			;9cf7
	sub c			;9cf8
	sub b			;9cf9
	adc a,h			;9cfa
	rst 18h			;9cfb
	adc a,a			;9cfc
	sub b			;9cfd
	adc a,l			;9cfe
	rst 18h			;9cff
	sbc a,d			;9d00
	sub e			;9d01
	rst 18h			;9d02
	or b			;9d03
	sbc a,d			;9d04
	adc a,h			;9d05
	adc a,e			;9d06
	sbc a,d			;9d07
	out (0dfh),a		;9d08
	sbc a,e			;9d0a
	sub b			;9d0b
	sub c			;9d0c
	sbc a,e			;9d0d
	sbc a,d			;9d0e
	rst 18h			;9d0f
	sub a			;9d10
	sbc a,(hl)			;9d11
	add a,(hl)			;9d12
	rst 18h			;9d13
	adc a,d			;9d14
	sub c			;9d15
	sbc a,(hl)			;9d16
	rst 18h			;9d17
	sbc a,h			;9d18
	adc a,d			;9d19
	push hl			;9d1a
	sbc a,(hl)			;9d1b
	pop de			;9d1c
	push af			;9d1d
	cp d			;9d1e
	adc a,h			;9d1f
	adc a,e			;9d20
	sbc a,d			;9d21
	rst 18h			;9d22
	sub d			;9d23
	adc a,d			;9d24
	adc a,l			;9d25
	sub b			;9d26
	rst 18h			;9d27
	sbc a,d			;9d28
	adc a,h			;9d29
	adc a,e			;9d2a
	jp pe,09cdfh		;9d2b
	adc a,d			;9d2e
	sbc a,l			;9d2f
	sub (hl)			;9d30
	sbc a,d			;9d31
	adc a,l			;9d32
	adc a,e			;9d33
	sub b			;9d34
	rst 18h			;9d35
	sbc a,e			;9d36
	sbc a,d			;9d37
	rst 18h			;9d38
	sbc a,(hl)			;9d39
	sbc a,e			;9d3a
	adc a,c			;9d3b
	sbc a,d			;9d3c
	adc a,l			;9d3d
	adc a,e			;9d3e
	sbc a,d			;9d3f
	sub c			;9d40
	sbc a,h			;9d41
	sub (hl)			;9d42
	sbc a,(hl)			;9d43
	adc a,h			;9d44
	rst 18h			;9d45
	adc a,h			;9d46
	sub b			;9d47
	sbc a,l			;9d48
	adc a,l			;9d49
	sbc a,d			;9d4a
	rst 18h			;9d4b
	sub e			;9d4c
	sub b			;9d4d
	rst 18h			;9d4e
	adc a,(hl)			;9d4f
	adc a,d			;9d50
	sbc a,d			;9d51
	rst 18h			;9d52
	sbc a,h			;9d53
	sub (hl)			;9d54
	sbc a,d			;9d55
	adc a,l			;9d56
	adc a,l			;9d57
	sbc a,(hl)			;9d58
	pop de			;9d59
	pop de			;9d5a
	pop de			;9d5b
	rst 18h			;9d5c
	and a			;9d5d
	sub (hl)			;9d5e
	sbc a,l			;9d5f
	sbc a,(hl)			;9d60
	sub e			;9d61
	sbc a,l			;9d62
	jp pe,0dfd3h		;9d63
	sbc a,d			;9d66
	sub e			;9d67
	rst 18h			;9d68
	sub (hl)			;9d69
	sub c			;9d6a
	sbc a,c			;9d6b
	sub (hl)			;9d6c
	sbc a,d			;9d6d
	adc a,l			;9d6e
	sub c			;9d6f
	sub b			;9d70
	rst 18h			;9d71
	sub d			;9d72
	sbc a,(hl)			;9d73
	add a,(hl)			;9d74
	sbc a,(hl)			;9d75
	pop de			;9d76
	push af			;9d77
	cp d			;9d78
	sub e			;9d79
	rst 18h			;9d7a
	sub d			;9d7b
	adc a,d			;9d7c
	adc a,l			;9d7d
	sub b			;9d7e
	rst 18h			;9d7f
	sbc a,d			;9d80
	adc a,h			;9d81
	adc a,e			;9d82
	jp pe,08ddfh		;9d83
	sub b			;9d86
	adc a,e			;9d87
	sub b			;9d88
	pop de			;9d89
	rst 18h			;9d8a
	xor a			;9d8b
	adc a,d			;9d8c
	sbc a,d			;9d8d
	sbc a,e			;9d8e
	sbc a,d			;9d8f
	adc a,h			;9d90
	rst 18h			;9d91
	adc a,c			;9d92
	sbc a,d			;9d93
	adc a,l			;9d94
	rst 18h			;9d95
	adc a,d			;9d96
	sub c			;9d97
	rst 18h			;9d98
	adc a,l			;9d99
	sbc a,d			;9d9a
	adc a,e			;9d9b
	sbc a,(hl)			;9d9c
	add a,l			;9d9d
	sub b			;9d9e
	rst 18h			;9d9f
	sbc a,e			;9da0
	sbc a,d			;9da1
	rst 18h			;9da2
	sub e			;9da3
	sbc a,(hl)			;9da4
	rst 18h			;9da5
	or c			;9da6
	cp (hl)			;9da7
	cp e			;9da8
	cp (hl)			;9da9
	pop de			;9daa
	push af			;9dab
	and (hl)			;9dac
	adc a,d			;9dad
	sub d			;9dae
	rst 18h			;9daf
	or h			;9db0
	sbc a,h			;9db1
	sub (hl)			;9db2
	sub d			;9db3
	sub (hl)			;9db4
	sub e			;9db5
	out (0dfh),a		;9db6
	sub l			;9db8
	sbc a,d			;9db9
	sbc a,c			;9dba
	sbc a,d			;9dbb
	rst 18h			;9dbc
	sbc a,e			;9dbd
	sbc a,d			;9dbe
	rst 18h			;9dbf
	sub e			;9dc0
	sub b			;9dc1
	adc a,h			;9dc2
	rst 18h			;9dc3
	cp l			;9dc4
	sub b			;9dc5
	sub e			;9dc6
	sub b			;9dc7
	sub c			;9dc8
	adc a,e			;9dc9
	sub (hl)			;9dca
	sub h			;9dcb
	and 09ah		;9dcc
	adc a,h			;9dce
	rst 18h			;9dcf
	add a,(hl)			;9dd0
	rst 18h			;9dd1
	sbc a,e			;9dd2
	sub (hl)			;9dd3
	sub b			;9dd4
	adc a,h			;9dd5
	rst 18h			;9dd6
	sbc a,e			;9dd7
	sbc a,d			;9dd8
	rst 18h			;9dd9
	sub e			;9dda
	sbc a,(hl)			;9ddb
	rst 18h			;9ddc
	sub d			;9ddd
	adc a,d			;9dde
	sbc a,d			;9ddf
	adc a,l			;9de0
	adc a,e			;9de1
	sbc a,d			;9de2
	out (0dfh),a		;9de3
	sbc a,d			;9de5
	adc a,h			;9de6
	rst 18h			;9de7
	adc a,d			;9de8
	sub c			;9de9
	rst 18h			;9dea
	adc a,l			;9deb
	sbc a,d			;9dec
	adc a,a			;9ded
	adc a,d			;9dee
	sbc a,b			;9def
	sub c			;9df0
	sbc a,(hl)			;9df1
	sub c			;9df2
	adc a,e			;9df3
	sbc a,d			;9df4
	rst 18h			;9df5
	sbc a,d			;9df6
	adc a,h			;9df7
	adc a,(hl)			;9df8
	adc a,d			;9df9
	sbc a,d			;9dfa
	sub e			;9dfb
	sbc a,d			;9dfc
	adc a,e			;9dfd
	sub b			;9dfe
	pop de			;9dff
	rst 18h			;9e00
	cp (hl)			;9e01
	rst 18h			;9e02
	adc a,h			;9e03
	adc a,d			;9e04
	rst 18h			;9e05
	sbc a,(hl)			;9e06
	sub e			;9e07
	adc a,l			;9e08
	sbc a,d			;9e09
	sbc a,e			;9e0a
	sbc a,d			;9e0b
	sbc a,e			;9e0c
	sub b			;9e0d
	adc a,l			;9e0e
	rst 18h			;9e0f
	adc a,e			;9e10
	sub b			;9e11
	sbc a,e			;9e12
	sub b			;9e13
	rst 18h			;9e14
	adc a,(hl)			;9e15
	adc a,d			;9e16
	sbc a,d			;9e17
	sbc a,e			;9e18
	sbc a,(hl)			;9e19
	rst 18h			;9e1a
	adc a,e			;9e1b
	adc a,l			;9e1c
	sub (hl)			;9e1d
	adc a,h			;9e1e
	adc a,e			;9e1f
	sbc a,d			;9e20
	sub d			;9e21
	sbc a,d			;9e22
	sub c			;9e23
	adc a,e			;9e24
	sbc a,d			;9e25
	rst 18h			;9e26
	sub a			;9e27
	sbc a,d			;9e28
	sub e			;9e29
	sbc a,(hl)			;9e2a
	sbc a,e			;9e2b
	sub b			;9e2c
	pop de			;9e2d
	rst 18h			;9e2e
	push af			;9e2f
	cp d			;9e30
	adc a,h			;9e31
	rst 18h			;9e32
	sbc a,d			;9e33
	sub e			;9e34
	rst 18h			;9e35
	sbc a,e			;9e36
	sub (hl)			;9e37
	sub b			;9e38
	adc a,h			;9e39
	rst 18h			;9e3a
	sbc a,e			;9e3b
	sbc a,d			;9e3c
	rst 18h			;9e3d
	sub e			;9e3e
	sbc a,(hl)			;9e3f
	adc a,h			;9e40
	rst 18h			;9e41
	adc a,e			;9e42
	sub (hl)			;9e43
	sub c			;9e44
	sub (hl)			;9e45
	sbc a,d			;9e46
	sbc a,l			;9e47
	sub e			;9e48
	sbc a,(hl)			;9e49
	adc a,h			;9e4a
	rst 18h			;9e4b
	add a,(hl)			;9e4c
	rst 18h			;9e4d
	adc a,a			;9e4e
	sub b			;9e4f
	adc a,l			;9e50
	rst 18h			;9e51
	sub e			;9e52
	sub b			;9e53
	rst 18h			;9e54
	adc a,e			;9e55
	sbc a,(hl)			;9e56
	sub c			;9e57
	adc a,e			;9e58
	sub b			;9e59
	rst 18h			;9e5a
	sbc a,e			;9e5b
	sbc a,d			;9e5c
	rst 18h			;9e5d
	and a			;9e5e
	sub (hl)			;9e5f
	sbc a,l			;9e60
	sbc a,(hl)			;9e61
	sub e			;9e62
	sbc a,l			;9e63
	jp pe,0dfd1h		;9e64
	xor e			;9e67
	sbc a,(hl)			;9e68
	sub d			;9e69
	sbc a,l			;9e6a
	sub (hl)			;9e6b
	jp (hl)			;9e6c
	sub c			;9e6d
	rst 18h			;9e6e
	sbc a,h			;9e6f
	sub b			;9e70
	sub c			;9e71
	sub b			;9e72
	sbc a,h			;9e73
	sub (hl)			;9e74
	sbc a,e			;9e75
	sub b			;9e76
	rst 18h			;9e77
	sbc a,h			;9e78
	sub b			;9e79
	sub d			;9e7a
	sub b			;9e7b
	rst 18h			;9e7c
	cp d			;9e7d
	adc a,h			;9e7e
	adc a,a			;9e7f
	sbc a,d			;9e80
	sub l			;9e81
	sub b			;9e82
	rst 18h			;9e83
	or b			;9e84
	adc a,h			;9e85
	sbc a,h			;9e86
	adc a,d			;9e87
	adc a,l			;9e88
	sub b			;9e89
	out (0dfh),a		;9e8a
	adc a,a			;9e8c
	sub b			;9e8d
	adc a,l			;9e8e
	rst 18h			;9e8f
	adc a,h			;9e90
	adc a,d			;9e91
	rst 18h			;9e92
	sbc a,d			;9e93
	adc a,h			;9e94
	sbc a,h			;9e95
	adc a,d			;9e96
	sbc a,e			;9e97
	sub b			;9e98
	pop de			;9e99
	rst 18h			;9e9a
	push af			;9e9b
	cp d			;9e9c
	adc a,h			;9e9d
	sbc a,d			;9e9e
	rst 18h			;9e9f
	cp d			;9ea0
	adc a,h			;9ea1
	adc a,a			;9ea2
	sbc a,d			;9ea3
	sub l			;9ea4
	sub b			;9ea5
	rst 18h			;9ea6
	sub a			;9ea7
	sbc a,(hl)			;9ea8
	rst 18h			;9ea9
	sbc a,(hl)			;9eaa
	sub c			;9eab
	adc a,d			;9eac
	sub e			;9ead
	sbc a,(hl)			;9eae
	sbc a,e			;9eaf
	sub b			;9eb0
	rst 18h			;9eb1
	adc a,h			;9eb2
	adc a,d			;9eb3
	rst 18h			;9eb4
	adc a,c			;9eb5
	sub b			;9eb6
	sub e			;9eb7
	adc a,d			;9eb8
	sub c			;9eb9
	adc a,e			;9eba
	sbc a,(hl)			;9ebb
	sbc a,e			;9ebc
	pop de			;9ebd
	push af			;9ebe
	cp l			;9ebf
	sbc a,(hl)			;9ec0
	sub l			;9ec1
	sbc a,(hl)			;9ec2
	rst 18h			;9ec3
	adc a,a			;9ec4
	sub b			;9ec5
	adc a,l			;9ec6
	rst 18h			;9ec7
	sub e			;9ec8
	sbc a,(hl)			;9ec9
	rst 18h			;9eca
	adc a,a			;9ecb
	sbc a,(hl)			;9ecc
	adc a,l			;9ecd
	sbc a,d			;9ece
	sbc a,e			;9ecf
	rst 18h			;9ed0
	sbc a,d			;9ed1
	sub c			;9ed2
	rst 18h			;9ed3
	sbc a,c			;9ed4
	sub (hl)			;9ed5
	sub c			;9ed6
	sbc a,(hl)			;9ed7
	rst 18h			;9ed8
	sbc a,h			;9ed9
	sbc a,(hl)			;9eda
	adc a,a			;9edb
	sbc a,(hl)			;9edc
	pop de			;9edd
	push af			;9ede
	cp d			;9edf
	sub e			;9ee0
	rst 18h			;9ee1
	sbc a,(hl)			;9ee2
	sbc a,b			;9ee3
	adc a,d			;9ee4
	sbc a,(hl)			;9ee5
	rst 18h			;9ee6
	adc a,h			;9ee7
	sbc a,d			;9ee8
	rst 18h			;9ee9
	sub a			;9eea
	sbc a,(hl)			;9eeb
	rst 18h			;9eec
	sub a			;9eed
	sbc a,d			;9eee
	sub e			;9eef
	sbc a,(hl)			;9ef0
	sbc a,e			;9ef1
	sub b			;9ef2
	out (0dfh),a		;9ef3
	sbc a,c			;9ef5
	sub b			;9ef6
	adc a,l			;9ef7
	sub d			;9ef8
	sbc a,(hl)			;9ef9
	sub c			;9efa
	sbc a,e			;9efb
	sub b			;9efc
	rst 18h			;9efd
	adc a,d			;9efe
	sub c			;9eff
	rst 18h			;9f00
	sbc a,d			;9f01
	adc a,h			;9f02
	adc a,a			;9f03
	sbc a,d			;9f04
	sub l			;9f05
	sub b			;9f06
	rst 18h			;9f07
	sbc a,e			;9f08
	sbc a,d			;9f09
	rst 18h			;9f0a
	sub a			;9f0b
	sub (hl)			;9f0c
	sbc a,d			;9f0d
	sub e			;9f0e
	sub b			;9f0f
	pop de			;9f10
	push af			;9f11
	cp c			;9f12
	sub b			;9f13
	adc a,l			;9f14
	sub d			;9f15
	sbc a,(hl)			;9f16
	sbc a,e			;9f17
	sbc a,(hl)			;9f18
	rst 18h			;9f19
	adc a,a			;9f1a
	sub b			;9f1b
	adc a,l			;9f1c
	rst 18h			;9f1d
	sub e			;9f1e
	sbc a,(hl)			;9f1f
	adc a,h			;9f20
	rst 18h			;9f21
	sbc a,(hl)			;9f22
	sbc a,b			;9f23
	adc a,d			;9f24
	sbc a,(hl)			;9f25
	adc a,h			;9f26
	rst 18h			;9f27
	sbc a,e			;9f28
	sbc a,d			;9f29
	adc a,h			;9f2a
	sbc a,l			;9f2b
	sub b			;9f2c
	adc a,l			;9f2d
	sbc a,e			;9f2e
	sbc a,(hl)			;9f2f
	sbc a,e			;9f30
	sbc a,(hl)			;9f31
	adc a,h			;9f32
	rst 18h			;9f33
	sbc a,e			;9f34
	sbc a,d			;9f35
	sub e			;9f36
	rst 18h			;9f37
	sub e			;9f38
	sbc a,(hl)			;9f39
	sbc a,b			;9f3a
	sub b			;9f3b
	rst 18h			;9f3c
	adc a,h			;9f3d
	adc a,d			;9f3e
	adc a,a			;9f3f
	sbc a,d			;9f40
	adc a,l			;9f41
	sub (hl)			;9f42
	sub b			;9f43
	adc a,l			;9f44
	pop de			;9f45
	push af			;9f46
	cp d			;9f47
	adc a,l			;9f48
	sub (hl)			;9f49
	add a,l			;9f4a
	sbc a,(hl)			;9f4b
	sbc a,e			;9f4c
	sub b			;9f4d
	adc a,h			;9f4e
	rst 18h			;9f4f
	sbc a,e			;9f50
	sbc a,d			;9f51
	rst 18h			;9f52
	adc a,a			;9f53
	and 09eh		;9f54
	adc a,h			;9f56
	pop de			;9f57
	push af			;9f58
	cp h			;9f59
	sbc a,(hl)			;9f5a
	adc a,l			;9f5b
	sbc a,b			;9f5c
	sbc a,(hl)			;9f5d
	sbc a,e			;9f5e
	sbc a,(hl)			;9f5f
	adc a,h			;9f60
	rst 18h			;9f61
	sbc a,e			;9f62
	sbc a,d			;9f63
	rst 18h			;9f64
	sbc a,e			;9f65
	jp pe,0968bh		;9f66
	sub e			;9f69
	sbc a,d			;9f6a
	adc a,h			;9f6b
	pop de			;9f6c
	push af			;9f6d
	cp b			;9f6e
	sub (hl)			;9f6f
	sbc a,b			;9f70
	sbc a,(hl)			;9f71
	sub c			;9f72
	adc a,e			;9f73
	sbc a,d			;9f74
	adc a,h			;9f75
	sbc a,h			;9f76
	sub b			;9f77
	pop de			;9f78
	push af			;9f79
	xor h			;9f7a
	sbc a,d			;9f7b
	push hl			;9f7c
	sub b			;9f7d
	adc a,l			;9f7e
	rst 18h			;9f7f
	sbc a,e			;9f80
	sbc a,d			;9f81
	sub e			;9f82
	rst 18h			;9f83
	sbc a,c			;9f84
	adc a,d			;9f85
	sbc a,d			;9f86
	sbc a,b			;9f87
	sub b			;9f88
	rst 18h			;9f89
	add a,(hl)			;9f8a
	rst 18h			;9f8b
	sbc a,e			;9f8c
	sub (hl)			;9f8d
	sub b			;9f8e
	adc a,h			;9f8f
	rst 18h			;9f90
	sbc a,e			;9f91
	sbc a,d			;9f92
	rst 18h			;9f93
	sub e			;9f94
	sub b			;9f95
	adc a,h			;9f96
	rst 18h			;9f97
	adc a,c			;9f98
	sub b			;9f99
	sub e			;9f9a
	sbc a,h			;9f9b
	sbc a,(hl)			;9f9c
	sub c			;9f9d
	sbc a,d			;9f9e
	adc a,h			;9f9f
	pop de			;9fa0
	rst 18h			;9fa1
	or e			;9fa2
	or e			;9fa3
	sbc a,d			;9fa4
	adc a,c			;9fa5
	sbc a,(hl)			;9fa6
	rst 18h			;9fa7
	adc a,d			;9fa8
	sub c			;9fa9
	sbc a,(hl)			;9faa
	rst 18h			;9fab
	sub d			;9fac
	jp pe,09c8ch		;9fad
	sbc a,(hl)			;9fb0
	adc a,l			;9fb1
	sbc a,(hl)			;9fb2
	pop de			;9fb3
	push af			;9fb4
	xor l			;9fb5
	sbc a,(hl)			;9fb6
	adc a,a			;9fb7
	sbc a,(hl)			;9fb8
	sbc a,h			;9fb9
	sbc a,d			;9fba
	adc a,h			;9fbb
	rst 18h			;9fbc
	sbc a,d			;9fbd
	sub c			;9fbe
	sub e			;9fbf
	adc a,d			;9fc0
	adc a,e			;9fc1
	sbc a,(hl)			;9fc2
	sbc a,e			;9fc3
	sbc a,(hl)			;9fc4
	adc a,h			;9fc5
	rst 18h			;9fc6
	adc a,(hl)			;9fc7
	adc a,d			;9fc8
	sbc a,d			;9fc9
	rst 18h			;9fca
	adc a,c			;9fcb
	adc a,d			;9fcc
	sbc a,d			;9fcd
	sub e			;9fce
	sbc a,(hl)			;9fcf
	sub c			;9fd0
	rst 18h			;9fd1
	adc a,h			;9fd2
	sub b			;9fd3
	sbc a,l			;9fd4
	adc a,l			;9fd5
	sbc a,d			;9fd6
	rst 18h			;9fd7
	adc a,e			;9fd8
	ret pe			;9fd9
	pop de			;9fda
	push af			;9fdb
	or d			;9fdc
	sub b			;9fdd
	sub e			;9fde
	sbc a,d			;9fdf
	adc a,h			;9fe0
	adc a,e			;9fe1
	sub b			;9fe2
	rst 18h			;9fe3
	add a,(hl)			;9fe4
	rst 18h			;9fe5
	sbc a,h			;9fe6
	sbc a,(hl)			;9fe7
	sbc a,b			;9fe8
	rst 20h			;9fe9
	sub c			;9fea
	pop de			;9feb
	push af			;9fec
	cp h			;9fed
	sub b			;9fee
	adc a,l			;9fef
	adc a,e			;9ff0
	sbc a,(hl)			;9ff1
	sbc a,e			;9ff2
	sub b			;9ff3
	rst 18h			;9ff4
	adc a,l			;9ff5
	sub b			;9ff6
	sbc a,h			;9ff7
	sub b			;9ff8
	adc a,h			;9ff9
	sub b			;9ffa
	rst 18h			;9ffb
	sub (hl)			;9ffc
	sub c			;9ffd
	sbc a,d			;9ffe
	adc a,h			;9fff
	sbc a,h			;a000
	sbc a,(hl)			;a001
	sub e			;a002
	sbc a,(hl)			;a003
	sbc a,l			;a004
	sub e			;a005
	sbc a,d			;a006
	pop de			;a007
	push af			;a008
	cp d			;a009
	sub e			;a00a
	rst 18h			;a00b
	sbc a,e			;a00c
	sub (hl)			;a00d
	sub b			;a00e
	adc a,h			;a00f
	rst 18h			;a010
	sbc a,b			;a011
	adc a,d			;a012
	sbc a,d			;a013
	adc a,l			;a014
	adc a,l			;a015
	sbc a,d			;a016
	adc a,l			;a017
	sub b			;a018
	out (0dfh),a		;a019
	sub a			;a01b
	sub (hl)			;a01c
	sub l			;a01d
	sub b			;a01e
	rst 18h			;a01f
	sbc a,e			;a020
	sbc a,d			;a021
	rst 18h			;a022
	cp h			;a023
	sub b			;a024
	sbc a,(hl)			;a025
	adc a,e			;a026
	sub e			;a027
	sub (hl)			;a028
	sbc a,h			;a029
	adc a,d			;a02a
	sbc a,d			;a02b
	out (0dfh),a		;a02c
	adc a,(hl)			;a02e
	adc a,d			;a02f
	sbc a,d			;a030
	rst 18h			;a031
	sbc a,e			;a032
	sbc a,d			;a033
	adc a,h			;a034
	adc a,e			;a035
	adc a,l			;a036
	sub b			;a037
	sub c			;a038
	rst 20h			;a039
	rst 18h			;a03a
	sbc a,(hl)			;a03b
	rst 18h			;a03c
	or h			;a03d
	adc a,d			;a03e
	sub h			;a03f
	adc a,d			;a040
	sub e			;a041
	sub h			;a042
	jp pe,0d191h		;a043
	pop de			;a046
	pop de			;a047
	push af			;a048
	cp e			;a049
	sbc a,d			;a04a
	adc a,h			;a04b
	sbc a,h			;a04c
	sub (hl)			;a04d
	sbc a,d			;a04e
	sub c			;a04f
	sbc a,e			;a050
	sbc a,d			;a051
	rst 18h			;a052
	sub a			;a053
	sbc a,(hl)			;a054
	adc a,h			;a055
	adc a,e			;a056
	sbc a,(hl)			;a057
	rst 18h			;a058
	sub e			;a059
	sbc a,(hl)			;a05a
	rst 18h			;a05b
	adc a,a			;a05c
	adc a,d			;a05d
	sbc a,d			;a05e
	adc a,l			;a05f
	adc a,e			;a060
	sbc a,(hl)			;a061
	rst 18h			;a062
	sbc a,e			;a063
	sbc a,d			;a064
	sub e			;a065
	rst 18h			;a066
	adc a,a			;a067
	sbc a,(hl)			;a068
	sub e			;a069
	sbc a,(hl)			;a06a
	sbc a,h			;a06b
	sub (hl)			;a06c
	sub b			;a06d
	jp nc,08d8fh		;a06e
	sub (hl)			;a071
	adc a,h			;a072
	sub (hl)			;a073
	rst 20h			;a074
	sub c			;a075
	pop de			;a076
	rst 18h			;a077
	push af			;a078
	cp (hl)			;a079
	adc a,l			;a07a
	sbc a,l			;a07b
	sub b			;a07c
	sub e			;a07d
	rst 18h			;a07e
	sbc a,h			;a07f
	sbc a,d			;a080
	sub c			;a081
	adc a,e			;a082
	adc a,l			;a083
	sbc a,(hl)			;a084
	sub e			;a085
	rst 18h			;a086
	sbc a,e			;a087
	sbc a,d			;a088
	sub e			;a089
	rst 18h			;a08a
	adc a,a			;a08b
	sbc a,(hl)			;a08c
	adc a,l			;a08d
	sbc a,(hl)			;a08e
	sub (hl)			;a08f
	adc a,h			;a090
	sub b			;a091
	out (0dfh),a		;a092
	sbc a,h			;a094
	sbc a,(hl)			;a095
	adc a,l			;a096
	sbc a,b			;a097
	sbc a,(hl)			;a098
	sbc a,e			;a099
	sub b			;a09a
	rst 18h			;a09b
	sbc a,e			;a09c
	sbc a,d			;a09d
	rst 18h			;a09e
	sbc a,c			;a09f
	adc a,l			;a0a0
	adc a,d			;a0a1
	adc a,e			;a0a2
	sub b			;a0a3
	adc a,h			;a0a4
	rst 18h			;a0a5
	sbc a,e			;a0a6
	sbc a,d			;a0a7
	rst 18h			;a0a8
	sub e			;a0a9
	sbc a,(hl)			;a0aa
	rst 18h			;a0ab
	adc a,c			;a0ac
	sub (hl)			;a0ad
	sbc a,e			;a0ae
	sbc a,(hl)			;a0af
	pop de			;a0b0
	push af			;a0b1
	cp (hl)			;a0b2
	sub e			;a0b3
	sub d			;a0b4
	sbc a,(hl)			;a0b5
	adc a,h			;a0b6
	rst 18h			;a0b7
	sbc a,e			;a0b8
	sbc a,d			;a0b9
	rst 18h			;a0ba
	sbc a,(hl)			;a0bb
	adc a,(hl)			;a0bc
	adc a,d			;a0bd
	sbc a,d			;a0be
	sub e			;a0bf
	sub e			;a0c0
	sub b			;a0c1
	adc a,h			;a0c2
	rst 18h			;a0c3
	adc a,(hl)			;a0c4
	adc a,d			;a0c5
	sbc a,d			;a0c6
	rst 18h			;a0c7
	sub c			;a0c8
	sub b			;a0c9
	rst 18h			;a0ca
	sub d			;a0cb
	sbc a,d			;a0cc
	adc a,l			;a0cd
	sbc a,d			;a0ce
	sbc a,h			;a0cf
	sbc a,d			;a0d0
	sub c			;a0d1
	rst 18h			;a0d2
	sub c			;a0d3
	sub (hl)			;a0d4
	rst 18h			;a0d5
	adc a,d			;a0d6
	sub c			;a0d7
	rst 18h			;a0d8
	sub (hl)			;a0d9
	sub c			;a0da
	sbc a,c			;a0db
	sub (hl)			;a0dc
	sbc a,d			;a0dd
	adc a,l			;a0de
	sub c			;a0df
	sub b			;a0e0
	pop de			;a0e1
	push af			;a0e2
	xor d			;a0e3
	sub c			;a0e4
	sbc a,(hl)			;a0e5
	rst 18h			;a0e6
	adc a,e			;a0e7
	sub (hl)			;a0e8
	sbc a,d			;a0e9
	sub c			;a0ea
	sbc a,d			;a0eb
	rst 18h			;a0ec
	sbc a,b			;a0ed
	adc a,l			;a0ee
	sbc a,(hl)			;a0ef
	sbc a,l			;a0f0
	sbc a,(hl)			;a0f1
	sbc a,e			;a0f2
	sub b			;a0f3
	rst 18h			;a0f4
	adc a,d			;a0f5
	sub c			;a0f6
	rst 18h			;a0f7
	sbc a,h			;a0f8
	sub b			;a0f9
	sub c			;a0fa
	sub b			;a0fb
	pop de			;a0fc
	push af			;a0fd
	cp h			;a0fe
	sub b			;a0ff
	sub d			;a100
	sub b			;a101
	rst 18h			;a102
	sub e			;a103
	sub b			;a104
	adc a,h			;a105
	rst 18h			;a106
	sbc a,h			;a107
	sub b			;a108
	sub c			;a109
	sub b			;a10a
	adc a,h			;a10b
	rst 18h			;a10c
	sbc a,e			;a10d
	sbc a,d			;a10e
	rst 18h			;a10f
	cp h			;a110
	sub a			;a111
	sub (hl)			;a112
	sbc a,h			;a113
	sub a			;a114
	jp (hl)			;a115
	sub c			;a116
	rst 18h			;a117
	or (hl)			;a118
	adc a,e			;a119
	add a,l			;a11a
	jp pe,0f5d1h		;a11b
	xor l			;a11e
	sbc a,d			;a11f
	sbc a,h			;a120
	sub (hl)			;a121
	sbc a,(hl)			;a122
	rst 18h			;a123
	add a,(hl)			;a124
	rst 18h			;a125
	sbc a,h			;a126
	sbc a,d			;a127
	adc a,l			;a128
	adc a,l			;a129
	sbc a,(hl)			;a12a
	sbc a,e			;a12b
	ret pe			;a12c
	adc a,h			;a12d
	sub (hl)			;a12e
	sub d			;a12f
	sbc a,(hl)			;a130
	pop de			;a131
	push af			;a132
	or e			;a133
	sbc a,(hl)			;a134
	rst 18h			;a135
	adc a,a			;a136
	adc a,d			;a137
	sbc a,d			;a138
	adc a,l			;a139
	adc a,e			;a13a
	sbc a,(hl)			;a13b
	rst 18h			;a13c
	sbc a,d			;a13d
	adc a,h			;a13e
	adc a,e			;a13f
	jp pe,09bdfh		;a140
	sbc a,d			;a143
	adc a,h			;a144
	adc a,e			;a145
	adc a,l			;a146
	sub b			;a147
	add a,l			;a148
	sbc a,(hl)			;a149
	sbc a,e			;a14a
	sbc a,(hl)			;a14b
	pop de			;a14c
	push af			;a14d
	xor c			;a14e
	sbc a,d			;a14f
	adc a,h			;a150
	rst 18h			;a151
	sbc a,d			;a152
	sub e			;a153
	rst 18h			;a154
	adc a,a			;a155
	sbc a,(hl)			;a156
	adc a,h			;a157
	sbc a,(hl)			;a158
	sbc a,e			;a159
	sub b			;a15a
	out (0dfh),a		;a15b
	sbc a,d			;a15d
	sub e			;a15e
	rst 18h			;a15f
	sub (hl)			;a160
	sub c			;a161
	adc a,e			;a162
	sbc a,d			;a163
	adc a,l			;a164
	sub (hl)			;a165
	sub b			;a166
	adc a,l			;a167
	rst 18h			;a168
	sbc a,e			;a169
	sbc a,d			;a16a
	rst 18h			;a16b
	sub e			;a16c
	sbc a,(hl)			;a16d
	rst 18h			;a16e
	adc a,a			;a16f
	sub (hl)			;a170
	adc a,l			;a171
	jp pe,09692h		;a172
	sbc a,e			;a175
	sbc a,d			;a176
	rst 18h			;a177
	sub (hl)			;a178
	sub e			;a179
	adc a,d			;a17a
	sub d			;a17b
	sub (hl)			;a17c
	sub c			;a17d
	sbc a,(hl)			;a17e
	sbc a,e			;a17f
	sub b			;a180
	pop de			;a181
	di			;a182
	call p,0a6f5h		;a183
	sbc a,(hl)			;a186
	rst 18h			;a187
	sub c			;a188
	sub b			;a189
	rst 18h			;a18a
	adc a,c			;a18b
	sbc a,d			;a18c
	adc a,h			;a18d
	rst 18h			;a18e
	sbc a,l			;a18f
	sub (hl)			;a190
	sbc a,d			;a191
	sub c			;a192
	out (0dfh),a		;a193
	sbc a,d			;a195
	sub e			;a196
	rst 18h			;a197
	sbc a,(hl)			;a198
	sub c			;a199
	sub (hl)			;a19a
	sub e			;a19b
	sub e			;a19c
	sub b			;a19d
	rst 18h			;a19e
	adc a,h			;a19f
	sbc a,d			;a1a0
	rst 18h			;a1a1
	sbc a,e			;a1a2
	sbc a,d			;a1a3
	sbc a,l			;a1a4
	sub (hl)			;a1a5
	sub e			;a1a6
	sub (hl)			;a1a7
	adc a,e			;a1a8
	sbc a,(hl)			;a1a9
	pop de			;a1aa
	push af			;a1ab
	di			;a1ac
	call p,09eb3h		;a1ad
	rst 18h			;a1b0
	sbc a,d			;a1b1
	sub c			;a1b2
	sbc a,d			;a1b3
	adc a,l			;a1b4
	sbc a,b			;a1b5
	sub (hl)			;a1b6
	sbc a,(hl)			;a1b7
	rst 18h			;a1b8
	sbc a,e			;a1b9
	sbc a,d			;a1ba
	sub e			;a1bb
	rst 18h			;a1bc
	sbc a,(hl)			;a1bd
	sub c			;a1be
	sub (hl)			;a1bf
	sub e			;a1c0
	sub e			;a1c1
	sub b			;a1c2
	rst 18h			;a1c3
	adc a,h			;a1c4
	sbc a,d			;a1c5
	rst 18h			;a1c6
	sbc a,(hl)			;a1c7
	sbc a,b			;a1c8
	sub b			;a1c9
	adc a,e			;a1ca
	sbc a,(hl)			;a1cb
	rst 18h			;a1cc
	add a,(hl)			;a1cd
	rst 18h			;a1ce
	adc a,c			;a1cf
	adc a,d			;a1d0
	sbc a,d			;a1d1
	sub e			;a1d2
	adc a,c			;a1d3
	sbc a,d			;a1d4
	adc a,h			;a1d5
	rst 18h			;a1d6
	sbc a,(hl)			;a1d7
	rst 18h			;a1d8
	adc a,e			;a1d9
	adc a,d			;a1da
	rst 18h			;a1db
	adc a,e			;a1dc
	sub (hl)			;a1dd
	sbc a,d			;a1de
	sub d			;a1df
	adc a,a			;a1e0
	sub b			;a1e1
	pop de			;a1e2
	di			;a1e3
	call p,0b3f5h		;a1e4
	sbc a,(hl)			;a1e7
	rst 18h			;a1e8
	sbc a,c			;a1e9
	adc a,d			;a1ea
	sbc a,d			;a1eb
	adc a,l			;a1ec
	add a,l			;a1ed
	sbc a,(hl)			;a1ee
	rst 18h			;a1ef
	sbc a,e			;a1f0
	sbc a,d			;a1f1
	sub e			;a1f2
	rst 18h			;a1f3
	adc a,e			;a1f4
	sub (hl)			;a1f5
	sbc a,d			;a1f6
	sub d			;a1f7
	adc a,a			;a1f8
	sub b			;a1f9
	rst 18h			;a1fa
	adc a,e			;a1fb
	sbc a,d			;a1fc
	rst 18h			;a1fd
	sub (hl)			;a1fe
	sub d			;a1ff
	adc a,a			;a200
	sub (hl)			;a201
	sbc a,e			;a202
	sbc a,d			;a203
	rst 18h			;a204
	adc a,(hl)			;a205
	adc a,d			;a206
	sub (hl)			;a207
	adc a,e			;a208
	sbc a,(hl)			;a209
	adc a,l			;a20a
	adc a,e			;a20b
	sbc a,d			;a20c
	rst 18h			;a20d
	and b			;a20e
	pop de			;a20f
	push af			;a210
	cp d			;a211
	adc a,h			;a212
	adc a,e			;a213
	jp pe,08cdfh		;a214
	sub (hl)			;a217
	sub c			;a218
	rst 18h			;a219
	sbc a,d			;a21a
	sub c			;a21b
	sbc a,d			;a21c
	adc a,l			;a21d
	sbc a,b			;a21e
	ret pe			;a21f
	sbc a,(hl)			;a220
	pop de			;a221
	push af			;a222
	cp h			;a223
	sbc a,(hl)			;a224
	sbc a,d			;a225
	adc a,h			;a226
	rst 18h			;a227
	add a,(hl)			;a228
	rst 18h			;a229
	adc a,e			;a22a
	sbc a,d			;a22b
	rst 18h			;a22c
	sbc a,e			;a22d
	sbc a,d			;a22e
	adc a,h			;a22f
	sub c			;a230
	adc a,d			;a231
	sbc a,h			;a232
	sbc a,(hl)			;a233
	adc a,h			;a234
	pop de			;a235
	push af			;a236
	cp d			;a237
	adc a,h			;a238
	adc a,e			;a239
	jp pe,08c96h		;a23a
	rst 18h			;a23d
	sbc a,d			;a23e
	sub c			;a23f
	rst 18h			;a240
	sub d			;a241
	adc a,d			;a242
	sub c			;a243
	sbc a,e			;a244
	sub b			;a245
	adc a,h			;a246
	rst 18h			;a247
	adc a,a			;a248
	sbc a,(hl)			;a249
	adc a,l			;a24a
	sbc a,(hl)			;a24b
	sub e			;a24c
	sbc a,d			;a24d
	sub e			;a24e
	sub b			;a24f
	adc a,h			;a250
	out (0dfh),a		;a251
	sub c			;a253
	sub b			;a254
	rst 18h			;a255
	sbc a,d			;a256
	adc a,h			;a257
	rst 18h			;a258
	adc a,a			;a259
	sub b			;a25a
	adc a,h			;a25b
	sub (hl)			;a25c
	sbc a,l			;a25d
	sub e			;a25e
	sbc a,d			;a25f
	rst 18h			;a260
	sub e			;a261
	sbc a,(hl)			;a262
	rst 18h			;a263
	sbc a,h			;a264
	sub b			;a265
	sub d			;a266
	adc a,d			;a267
	sub c			;a268
	sub (hl)			;a269
	sbc a,h			;a26a
	sbc a,(hl)			;a26b
	sbc a,h			;a26c
	sub (hl)			;a26d
	rst 20h			;a26e
	sub c			;a26f
	pop de			;a270
	push af			;a271
	cp e			;a272
	sbc a,d			;a273
	rst 18h			;a274
	sub e			;a275
	sbc a,(hl)			;a276
	rst 18h			;a277
	adc a,d			;a278
	adc a,l			;a279
	sub c			;a27a
	sbc a,(hl)			;a27b
	rst 18h			;a27c
	adc a,h			;a27d
	sbc a,(hl)			;a27e
	sub e			;a27f
	sbc a,d			;a280
	rst 18h			;a281
	sub a			;a282
	adc a,d			;a283
	sub d			;a284
	sub b			;a285
	rst 18h			;a286
	sub e			;a287
	adc a,d			;a288
	sub d			;a289
	sub (hl)			;a28a
	sub c			;a28b
	sub b			;a28c
	adc a,h			;a28d
	sub b			;a28e
	push af			;a28f
	pop de			;a290
	rst 18h			;a291
	xor d			;a292
	sub c			;a293
	sub b			;a294
	adc a,h			;a295
	rst 18h			;a296
	adc a,h			;a297
	sbc a,(hl)			;a298
	sbc a,h			;a299
	sbc a,d			;a29a
	adc a,l			;a29b
	sbc a,e			;a29c
	sub b			;a29d
	adc a,e			;a29e
	sbc a,d			;a29f
	adc a,h			;a2a0
	rst 18h			;a2a1
	sbc a,d			;a2a2
	adc a,h			;a2a3
	adc a,e			;a2a4
	jp pe,0df91h		;a2a5
	sub b			;a2a8
	sbc a,h			;a2a9
	adc a,d			;a2aa
	adc a,a			;a2ab
	sbc a,(hl)			;a2ac
	sbc a,e			;a2ad
	sub b			;a2ae
	adc a,h			;a2af
	rst 18h			;a2b0
	sbc a,h			;a2b1
	sub b			;a2b2
	sub c			;a2b3
	rst 18h			;a2b4
	adc a,h			;a2b5
	adc a,d			;a2b6
	adc a,h			;a2b7
	rst 18h			;a2b8
	adc a,l			;a2b9
	sub (hl)			;a2ba
	adc a,e			;a2bb
	sub b			;a2bc
	adc a,h			;a2bd
	pop de			;a2be
	rst 18h			;a2bf
	push af			;a2c0
	or e			;a2c1
	sub b			;a2c2
	adc a,h			;a2c3
	rst 18h			;a2c4
	adc a,h			;a2c5
	sbc a,(hl)			;a2c6
	sbc a,h			;a2c7
	sbc a,d			;a2c8
	adc a,l			;a2c9
	sbc a,e			;a2ca
	sub b			;a2cb
	adc a,e			;a2cc
	sbc a,d			;a2cd
	adc a,h			;a2ce
	rst 18h			;a2cf
	adc a,c			;a2d0
	sbc a,d			;a2d1
	sub c			;a2d2
	rst 18h			;a2d3
	sbc a,d			;a2d4
	sub e			;a2d5
	rst 18h			;a2d6
	sbc a,h			;a2d7
	sbc a,(hl)			;a2d8
	add a,l			;a2d9
	sub b			;a2da
	rst 18h			;a2db
	sub d			;a2dc
	sub b			;a2dd
	adc a,c			;a2de
	sbc a,d			;a2df
	adc a,l			;a2e0
	adc a,h			;a2e1
	sbc a,d			;a2e2
	rst 18h			;a2e3
	adc a,h			;a2e4
	sub b			;a2e5
	sub e			;a2e6
	sub b			;a2e7
	out (0dfh),a		;a2e8
	sub a			;a2ea
	sbc a,(hl)			;a2eb
	sbc a,h			;a2ec
	sbc a,d			;a2ed
	sub c			;a2ee
	rst 18h			;a2ef
	adc a,d			;a2f0
	sub c			;a2f1
	sbc a,(hl)			;a2f2
	rst 18h			;a2f3
	adc a,e			;a2f4
	sub b			;a2f5
	adc a,l			;a2f6
	adc a,a			;a2f7
	sbc a,d			;a2f8
	rst 18h			;a2f9
	adc a,l			;a2fa
	sbc a,d			;a2fb
	adc a,c			;a2fc
	sbc a,d			;a2fd
	adc a,l			;a2fe
	sbc a,d			;a2ff
	sub c			;a300
	sbc a,h			;a301
	sub (hl)			;a302
	sbc a,(hl)			;a303
	rst 18h			;a304
	add a,(hl)			;a305
	rst 18h			;a306
	sub a			;a307
	adc a,d			;a308
	add a,(hl)			;a309
	sbc a,d			;a30a
	sub c			;a30b
	rst 18h			;a30c
	sbc a,(hl)			;a30d
	rst 18h			;a30e
	sbc a,d			;a30f
	adc a,h			;a310
	sbc a,h			;a311
	sbc a,(hl)			;a312
	adc a,a			;a313
	sbc a,d			;a314
	pop de			;a315
	push af			;a316
	rst 18h			;a317
	adc a,h			;a318
	sub b			;a319
	sbc a,l			;a31a
	adc a,l			;a31b
	sbc a,d			;a31c
	rst 18h			;a31d
	sbc a,d			;a31e
	sub e			;a31f
	rst 18h			;a320
	adc a,(hl)			;a321
	adc a,d			;a322
	sbc a,d			;a323
	rst 18h			;a324
	sub a			;a325
	sbc a,(hl)			;a326
	add a,(hl)			;a327
	rst 18h			;a328
	push af			;a329
	cp d			;a32a
	sub e			;a32b
	rst 18h			;a32c
	adc a,h			;a32d
	sub b			;a32e
	adc a,a			;a32f
	sub b			;a330
	adc a,l			;a331
	adc a,e			;a332
	sbc a,d			;a333
	rst 18h			;a334
	sbc a,d			;a335
	adc a,h			;a336
	rst 18h			;a337
	sbc a,e			;a338
	sbc a,d			;a339
	sub d			;a33a
	sbc a,(hl)			;a33b
	adc a,h			;a33c
	sub (hl)			;a33d
	sbc a,(hl)			;a33e
	sbc a,e			;a33f
	sub b			;a340
	rst 18h			;a341
	sbc a,b			;a342
	adc a,l			;a343
	sbc a,(hl)			;a344
	sub c			;a345
	sbc a,e			;a346
	sbc a,d			;a347
	pop de			;a348
	push af			;a349
	xor h			;a34a
	sub b			;a34b
	sbc a,l			;a34c
	adc a,l			;a34d
	sbc a,d			;a34e
	rst 18h			;a34f
	and b			;a350
	rst 18h			;a351
	sub a			;a352
	sbc a,(hl)			;a353
	add a,(hl)			;a354
	rst 18h			;a355
	push af			;a356
	cp d			;a357
	sub e			;a358
	rst 18h			;a359
	sub a			;a35a
	adc a,d			;a35b
	sub d			;a35c
	sub b			;a35d
	rst 18h			;a35e
	sbc a,d			;a35f
	sub c			;a360
	adc a,e			;a361
	adc a,l			;a362
	sbc a,(hl)			;a363
	rst 18h			;a364
	sbc a,d			;a365
	sub c			;a366
	rst 18h			;a367
	sub e			;a368
	sbc a,(hl)			;a369
	rst 18h			;a36a
	sbc a,d			;a36b
	adc a,h			;a36c
	sbc a,c			;a36d
	sbc a,d			;a36e
	adc a,l			;a36f
	sbc a,(hl)			;a370
	rst 18h			;a371
	sub e			;a372
	sub e			;a373
	sbc a,d			;a374
	sub c			;a375
	jp pe,09b91h		;a376
	sub b			;a379
	sub e			;a37a
	sbc a,(hl)			;a37b
	pop de			;a37c
	push af			;a37d
	cp d			;a37e
	sub e			;a37f
	rst 18h			;a380
	sub a			;a381
	adc a,d			;a382
	sub d			;a383
	sub b			;a384
	rst 18h			;a385
	sbc a,d			;a386
	adc a,h			;a387
	sbc a,h			;a388
	sbc a,(hl)			;a389
	adc a,a			;a38a
	sbc a,(hl)			;a38b
	rst 18h			;a38c
	adc a,a			;a38d
	sub b			;a38e
	adc a,l			;a38f
	rst 18h			;a390
	sub e			;a391
	sbc a,(hl)			;a392
	rst 18h			;a393
	adc a,l			;a394
	sbc a,(hl)			;a395
	sub c			;a396
	adc a,d			;a397
	adc a,l			;a398
	sbc a,(hl)			;a399
	pop de			;a39a
	push af			;a39b
	cp d			;a39c
	sub e			;a39d
	rst 18h			;a39e
	sub a			;a39f
	adc a,d			;a3a0
	sub d			;a3a1
	sub b			;a3a2
	rst 18h			;a3a3
	adc a,h			;a3a4
	sbc a,d			;a3a5
	rst 18h			;a3a6
	sbc a,(hl)			;a3a7
	sbc a,h			;a3a8
	sbc a,(hl)			;a3a9
	sbc a,l			;a3aa
	rst 20h			;a3ab
	pop de			;a3ac
	push af			;a3ad
	cp d			;a3ae
	sub e			;a3af
	rst 18h			;a3b0
	adc a,e			;a3b1
	sbc a,(hl)			;a3b2
	adc a,a			;a3b3
	rst 20h			;a3b4
	sub c			;a3b5
	rst 18h			;a3b6
	adc a,h			;a3b7
	sbc a,d			;a3b8
	rst 18h			;a3b9
	sbc a,(hl)			;a3ba
	sbc a,l			;a3bb
	sub e			;a3bc
	sbc a,(hl)			;a3bd
	sub c			;a3be
	sbc a,e			;a3bf
	sbc a,(hl)			;a3c0
	rst 18h			;a3c1
	sbc a,h			;a3c2
	sub b			;a3c3
	sub c			;a3c4
	rst 18h			;a3c5
	sbc a,d			;a3c6
	sub e			;a3c7
	rst 18h			;a3c8
	sbc a,h			;a3c9
	sbc a,(hl)			;a3ca
	sub e			;a3cb
	sub b			;a3cc
	adc a,l			;a3cd
	rst 18h			;a3ce
	add a,(hl)			;a3cf
	rst 18h			;a3d0
	adc a,h			;a3d1
	sbc a,d			;a3d2
	rst 18h			;a3d3
	sbc a,h			;a3d4
	sbc a,(hl)			;a3d5
	sbc a,d			;a3d6
	pop de			;a3d7
	push af			;a3d8
	xor e			;a3d9
	sbc a,(hl)			;a3da
	adc a,a			;a3db
	sbc a,(hl)			;a3dc
	adc a,h			;a3dd
	rst 18h			;a3de
	sub e			;a3df
	sbc a,(hl)			;a3e0
	rst 18h			;a3e1
	adc a,l			;a3e2
	sbc a,(hl)			;a3e3
	sub c			;a3e4
	adc a,d			;a3e5
	adc a,l			;a3e6
	sbc a,(hl)			;a3e7
	rst 18h			;a3e8
	sbc a,h			;a3e9
	sub b			;a3ea
	sub c			;a3eb
	rst 18h			;a3ec
	adc a,a			;a3ed
	sbc a,(hl)			;a3ee
	adc a,h			;a3ef
	adc a,e			;a3f0
	sbc a,(hl)			;a3f1
	pop de			;a3f2
	rst 18h			;a3f3
	xor a			;a3f4
	adc a,l			;a3f5
	sub b			;a3f6
	sub c			;a3f7
	adc a,e			;a3f8
	sub b			;a3f9
	rst 18h			;a3fa
	adc a,h			;a3fb
	sbc a,d			;a3fc
	rst 18h			;a3fd
	sbc a,d			;a3fe
	sub c			;a3ff
	sbc a,e			;a400
	adc a,d			;a401
	adc a,l			;a402
	sbc a,d			;a403
	sbc a,h			;a404
	sbc a,d			;a405
	pop de			;a406
	push af			;a407
	cp d			;a408
	sbc a,h			;a409
	sub a			;a40a
	sbc a,(hl)			;a40b
	adc a,h			;a40c
	rst 18h			;a40d
	and b			;a40e
	rst 18h			;a40f
	sbc a,(hl)			;a410
	sub e			;a411
	rst 18h			;a412
	sbc a,c			;a413
	adc a,d			;a414
	sbc a,d			;a415
	sbc a,b			;a416
	sub b			;a417
	out (0dfh),a		;a418
	sbc a,e			;a41a
	sub b			;a41b
	sub c			;a41c
	sbc a,e			;a41d
	sbc a,d			;a41e
	rst 18h			;a41f
	adc a,h			;a420
	sbc a,d			;a421
	rst 18h			;a422
	sbc a,h			;a423
	sbc a,(hl)			;a424
	adc a,l			;a425
	sbc a,l			;a426
	sub b			;a427
	sub c			;a428
	sub (hl)			;a429
	add a,l			;a42a
	sbc a,(hl)			;a42b
	pop de			;a42c
	push af			;a42d
	or c			;a42e
	sub b			;a42f
	rst 18h			;a430
	adc a,h			;a431
	sbc a,d			;a432
	sbc a,(hl)			;a433
	adc a,h			;a434
	rst 18h			;a435
	sbc a,b			;a436
	adc a,d			;a437
	sbc a,(hl)			;a438
	adc a,l			;a439
	adc a,l			;a43a
	sub b			;a43b
	pop de			;a43c
	push af			;a43d
	or e			;a43e
	sbc a,(hl)			;a43f
	rst 18h			;a440
	adc a,a			;a441
	sbc a,(hl)			;a442
	adc a,h			;a443
	adc a,e			;a444
	sbc a,(hl)			;a445
	rst 18h			;a446
	sbc a,d			;a447
	adc a,h			;a448
	adc a,e			;a449
	jp pe,092dfh		;a44a
	adc a,d			;a44d
	add a,(hl)			;a44e
	rst 18h			;a44f
	sbc a,e			;a450
	adc a,d			;a451
	adc a,l			;a452
	sbc a,(hl)			;a453
	pop de			;a454
	push af			;a455
	xor e			;a456
	adc a,d			;a457
	adc a,h			;a458
	rst 18h			;a459
	adc a,a			;a45a
	sub (hl)			;a45b
	sbc a,d			;a45c
	adc a,h			;a45d
	rst 18h			;a45e
	adc a,h			;a45f
	sbc a,d			;a460
	rst 18h			;a461
	sbc a,c			;a462
	adc a,l			;a463
	ret pe			;a464
	sbc a,d			;a465
	sub c			;a466
	pop de			;a467
	pop de			;a468
	pop de			;a469
	di			;a46a
	call p,09aadh		;a46b
	adc a,e			;a46e
	adc a,l			;a46f
	sub b			;a470
	sbc a,h			;a471
	sbc a,d			;a472
	sbc a,e			;a473
	sbc a,d			;a474
	adc a,h			;a475
	rst 18h			;a476
	sbc a,(hl)			;a477
	rst 18h			;a478
	adc a,h			;a479
	sbc a,(hl)			;a47a
	sub e			;a47b
	adc a,e			;a47c
	sub b			;a47d
	adc a,h			;a47e
	pop de			;a47f
	push af			;a480
	cp (hl)			;a481
	sub e			;a482
	rst 18h			;a483
	sbc a,h			;a484
	sub b			;a485
	sub d			;a486
	sbc a,d			;a487
	adc a,l			;a488
	rst 18h			;a489
	and b			;a48a
	rst 18h			;a48b
	adc a,(hl)			;a48c
	adc a,d			;a48d
	sbc a,d			;a48e
	sbc a,e			;a48f
	sbc a,(hl)			;a490
	adc a,h			;a491
	rst 18h			;a492
	sub (hl)			;a493
	sub c			;a494
	adc a,h			;a495
	sbc a,d			;a496
	sub c			;a497
	adc a,h			;a498
	sub (hl)			;a499
	sbc a,l			;a49a
	sub e			;a49b
	sbc a,d			;a49c
	pop de			;a49d
	push af			;a49e
	xor a			;a49f
	sbc a,(hl)			;a4a0
	adc a,h			;a4a1
	sbc a,(hl)			;a4a2
	adc a,h			;a4a3
	rst 18h			;a4a4
	adc a,h			;a4a5
	sub b			;a4a6
	sbc a,l			;a4a7
	adc a,l			;a4a8
	sbc a,d			;a4a9
	rst 18h			;a4aa
	sub e			;a4ab
	sbc a,(hl)			;a4ac
	adc a,h			;a4ad
	rst 18h			;a4ae
	sub a			;a4af
	sub (hl)			;a4b0
	adc a,l			;a4b1
	adc a,c			;a4b2
	sub (hl)			;a4b3
	sbc a,d			;a4b4
	sub c			;a4b5
	adc a,e			;a4b6
	sbc a,d			;a4b7
	adc a,h			;a4b8
	rst 18h			;a4b9
	sub e			;a4ba
	sub b			;a4bb
	adc a,h			;a4bc
	sbc a,(hl)			;a4bd
	adc a,h			;a4be
	rst 18h			;a4bf
	adc a,h			;a4c0
	sub (hl)			;a4c1
	sub c			;a4c2
	rst 18h			;a4c3
	sbc a,d			;a4c4
	sub c			;a4c5
	adc a,e			;a4c6
	sbc a,d			;a4c7
	adc a,l			;a4c8
	sbc a,(hl)			;a4c9
	adc a,l			;a4ca
	adc a,e			;a4cb
	sbc a,d			;a4cc
	pop de			;a4cd
	jp p,0aff5h		;a4ce
	sub b			;a4d1
	sbc a,h			;a4d2
	sub b			;a4d3
	rst 18h			;a4d4
	sbc a,(hl)			;a4d5
	rst 18h			;a4d6
	adc a,a			;a4d7
	sub b			;a4d8
	sbc a,h			;a4d9
	sub b			;a4da
	rst 18h			;a4db
	adc a,l			;a4dc
	sbc a,d			;a4dd
	sbc a,h			;a4de
	sub b			;a4df
	sbc a,l			;a4e0
	adc a,l			;a4e1
	sbc a,(hl)			;a4e2
	adc a,h			;a4e3
	rst 18h			;a4e4
	sub e			;a4e5
	sbc a,(hl)			;a4e6
	rst 18h			;a4e7
	adc a,h			;a4e8
	sbc a,d			;a4e9
	sub c			;a4ea
	adc a,h			;a4eb
	sub (hl)			;a4ec
	sbc a,l			;a4ed
	sub (hl)			;a4ee
	sub e			;a4ef
	sub (hl)			;a4f0
	sbc a,e			;a4f1
	sbc a,(hl)			;a4f2
	sbc a,e			;a4f3
	pop de			;a4f4
	push af			;a4f5
	cp e			;a4f6
	sbc a,d			;a4f7
	sub e			;a4f8
	rst 18h			;a4f9
	sub d			;a4fa
	sub b			;a4fb
	sub l			;a4fc
	sbc a,(hl)			;a4fd
	sbc a,e			;a4fe
	sub b			;a4ff
	rst 18h			;a500
	adc a,h			;a501
	adc a,d			;a502
	sbc a,d			;a503
	sub e			;a504
	sub b			;a505
	rst 18h			;a506
	adc a,h			;a507
	adc a,d			;a508
	adc a,l			;a509
	sbc a,b			;a50a
	sbc a,d			;a50b
	rst 18h			;a50c
	sbc a,b			;a50d
	sbc a,(hl)			;a50e
	adc a,h			;a50f
	rst 18h			;a510
	adc a,(hl)			;a511
	adc a,d			;a512
	sbc a,d			;a513
	rst 18h			;a514
	sbc a,c			;a515
	sub e			;a516
	sub b			;a517
	adc a,e			;a518
	sbc a,(hl)			;a519
	rst 18h			;a51a
	sbc a,(hl)			;a51b
	sub e			;a51c
	rst 18h			;a51d
	sub b			;a51e
	sbc a,d			;a51f
	adc a,h			;a520
	adc a,e			;a521
	sbc a,d			;a522
	push af			;a523
	and (hl)			;a524
	sbc a,(hl)			;a525
	rst 18h			;a526
	sub c			;a527
	sub b			;a528
	rst 18h			;a529
	sub a			;a52a
	sbc a,(hl)			;a52b
	add a,(hl)			;a52c
	rst 18h			;a52d
	sub d			;a52e
	jp pe,0df8ch		;a52f
	sbc a,b			;a532
	sbc a,(hl)			;a533
	adc a,h			;a534
	pop de			;a535
	push af			;a536
	xor h			;a537
	sub (hl)			;a538
	sbc a,b			;a539
	adc a,d			;a53a
	sbc a,d			;a53b
	adc a,h			;a53c
	rst 18h			;a53d
	sbc a,d			;a53e
	sub e			;a53f
	rst 18h			;a540
	adc a,l			;a541
	sbc a,(hl)			;a542
	adc a,h			;a543
	adc a,e			;a544
	adc a,l			;a545
	sub b			;a546
	rst 18h			;a547
	sbc a,e			;a548
	sbc a,d			;a549
	sub e			;a54a
	rst 18h			;a54b
	sbc a,b			;a54c
	sbc a,(hl)			;a54d
	adc a,h			;a54e
	pop de			;a54f
	di			;a550
	call p,090b3h		;a551
	rst 18h			;a554
	adc a,l			;a555
	sbc a,d			;a556
	adc a,h			;a557
	adc a,a			;a558
	sub (hl)			;a559
	adc a,l			;a55a
	sbc a,(hl)			;a55b
	adc a,h			;a55c
	rst 18h			;a55d
	add a,(hl)			;a55e
	pop de			;a55f
	pop de			;a560
	pop de			;a561
	di			;a562
	call p,0b2eeh		;a563
	adc a,d			;a566
	sbc a,d			;a567
	adc a,l			;a568
	sbc a,d			;a569
	adc a,h			;a56a
	rst 18h			;a56b
	sbc a,d			;a56c
	sub c			;a56d
	adc a,e			;a56e
	adc a,l			;a56f
	sbc a,d			;a570
	rst 18h			;a571
	sbc a,d			;a572
	adc a,h			;a573
	adc a,a			;a574
	sbc a,(hl)			;a575
	adc a,h			;a576
	sub d			;a577
	sub b			;a578
	adc a,h			;a579
	sbc a,0f5h		;a57a
	or e			;a57c
	sbc a,(hl)			;a57d
	rst 18h			;a57e
	adc a,c			;a57f
	sbc a,(hl)			;a580
	adc a,h			;a581
	sub (hl)			;a582
	sub l			;a583
	sbc a,(hl)			;a584
	rst 18h			;a585
	adc a,e			;a586
	sbc a,(hl)			;a587
	adc a,a			;a588
	sbc a,(hl)			;a589
	rst 18h			;a58a
	sbc a,d			;a58b
	sub e			;a58c
	rst 18h			;a58d
	sbc a,(hl)			;a58e
	sbc a,b			;a58f
	adc a,d			;a590
	sub l			;a591
	sbc a,d			;a592
	adc a,l			;a593
	sub b			;a594
	out (0dfh),a		;a595
	sbc a,e			;a597
	sbc a,d			;a598
	adc a,e			;a599
	sbc a,d			;a59a
	sub c			;a59b
	sub (hl)			;a59c
	sbc a,d			;a59d
	sub c			;a59e
	sbc a,e			;a59f
	sub b			;a5a0
	rst 18h			;a5a1
	sbc a,d			;a5a2
	sub e			;a5a3
	rst 18h			;a5a4
	sbc a,(hl)			;a5a5
	sbc a,b			;a5a6
	adc a,d			;a5a7
	sbc a,(hl)			;a5a8
	pop de			;a5a9
	push af			;a5aa
	cp d			;a5ab
	sub e			;a5ac
	rst 18h			;a5ad
	sbc a,(hl)			;a5ae
	sbc a,b			;a5af
	adc a,d			;a5b0
	sbc a,(hl)			;a5b1
	rst 18h			;a5b2
	sbc a,c			;a5b3
	sub e			;a5b4
	adc a,d			;a5b5
	add a,(hl)			;a5b6
	sbc a,d			;a5b7
	rst 18h			;a5b8
	sbc a,e			;a5b9
	sbc a,d			;a5ba
	rst 18h			;a5bb
	sub c			;a5bc
	adc a,d			;a5bd
	sbc a,d			;a5be
	adc a,c			;a5bf
	sub b			;a5c0
	pop de			;a5c1
	push af			;a5c2
	or a			;a5c3
	sbc a,(hl)			;a5c4
	adc a,h			;a5c5
	rst 18h			;a5c6
	sbc a,(hl)			;a5c7
	sbc a,h			;a5c8
	adc a,e			;a5c9
	sub (hl)			;a5ca
	adc a,c			;a5cb
	sbc a,(hl)			;a5cc
	sbc a,e			;a5cd
	sub b			;a5ce
	rst 18h			;a5cf
	adc a,d			;a5d0
	sub c			;a5d1
	sbc a,(hl)			;a5d2
	rst 18h			;a5d3
	adc a,e			;a5d4
	adc a,l			;a5d5
	sbc a,(hl)			;a5d6
	sub d			;a5d7
	adc a,a			;a5d8
	sbc a,(hl)			;a5d9
	pop de			;a5da
	pop de			;a5db
	pop de			;a5dc
	di			;a5dd
	call p,0b3eeh		;a5de
	sbc a,(hl)			;a5e1
	adc a,h			;a5e2
	rst 18h			;a5e3
	adc a,a			;a5e4
	sbc a,(hl)			;a5e5
	adc a,l			;a5e6
	sbc a,d			;a5e7
	sbc a,e			;a5e8
	sbc a,d			;a5e9
	adc a,h			;a5ea
	rst 18h			;a5eb
	adc a,h			;a5ec
	sbc a,d			;a5ed
	rst 18h			;a5ee
	sbc a,(hl)			;a5ef
	adc a,a			;a5f0
	adc a,l			;a5f1
	sub b			;a5f2
	add a,a			;a5f3
	sub (hl)			;a5f4
	sub d			;a5f5
	sbc a,(hl)			;a5f6
	sub c			;a5f7
	sbc a,0f5h		;a5f8
	cp (hl)			;a5fa
	sub e			;a5fb
	rst 18h			;a5fc
	sbc a,d			;a5fd
	sub c			;a5fe
	adc a,e			;a5ff
	adc a,l			;a600
	sbc a,d			;a601
	adc a,e			;a602
	sbc a,d			;a603
	sub c			;a604
	sbc a,d			;a605
	adc a,l			;a606
	adc a,e			;a607
	sbc a,d			;a608
	out (0dfh),a		;a609
	sub e			;a60b
	sub b			;a60c
	adc a,h			;a60d
	rst 18h			;a60e
	sub d			;a60f
	adc a,d			;a610
	adc a,l			;a611
	sub b			;a612
	adc a,h			;a613
	rst 18h			;a614
	adc a,h			;a615
	sbc a,d			;a616
	rst 18h			;a617
	sbc a,h			;a618
	sub (hl)			;a619
	sbc a,d			;a61a
	adc a,l			;a61b
	adc a,l			;a61c
	sbc a,(hl)			;a61d
	sub c			;a61e
	rst 18h			;a61f
	add a,(hl)			;a620
	rst 18h			;a621
	adc a,e			;a622
	sbc a,d			;a623
	rst 18h			;a624
	sub e			;a625
	sbc a,(hl)			;a626
	sub d			;a627
	sub (hl)			;a628
	sub c			;a629
	sbc a,(hl)			;a62a
	sub c			;a62b
	pop de			;a62c
	pop de			;a62d
	pop de			;a62e
	push af			;a62f
	xor 0b5h		;a630
	adc a,d			;a632
	adc a,h			;a633
	adc a,e			;a634
	sub b			;a635
	rst 18h			;a636
	sbc a,(hl)			;a637
	rst 18h			;a638
	adc a,e			;a639
	sub (hl)			;a63a
	sbc a,d			;a63b
	sub d			;a63c
	adc a,a			;a63d
	sub b			;a63e
	sbc a,0dfh		;a63f
	or e			;a641
	sbc a,(hl)			;a642
	adc a,h			;a643
	rst 18h			;a644
	adc a,a			;a645
	sbc a,(hl)			;a646
	adc a,l			;a647
	sbc a,d			;a648
	sbc a,e			;a649
	sbc a,d			;a64a
	adc a,h			;a64b
	rst 18h			;a64c
	sbc a,h			;a64d
	sbc a,(hl)			;a64e
	adc a,h			;a64f
	sub (hl)			;a650
	rst 18h			;a651
	adc a,e			;a652
	sbc a,d			;a653
	rst 18h			;a654
	sbc a,(hl)			;a655
	adc a,a			;a656
	sub e			;a657
	sbc a,(hl)			;a658
	adc a,h			;a659
	adc a,e			;a65a
	sbc a,(hl)			;a65b
	sub c			;a65c
	pop de			;a65d
	pop de			;a65e
	pop de			;a65f
	push af			;a660
	or b			;a661
	add a,(hl)			;a662
	sbc a,d			;a663
	adc a,h			;a664
	rst 18h			;a665
	sub d			;a666
	sbc a,d			;a667
	sbc a,h			;a668
	sbc a,(hl)			;a669
	sub c			;a66a
	sub (hl)			;a66b
	adc a,h			;a66c
	sub d			;a66d
	sub b			;a66e
	adc a,h			;a66f
	rst 18h			;a670
	add a,(hl)			;a671
	rst 18h			;a672
	sbc a,d			;a673
	sub e			;a674
	rst 18h			;a675
	adc a,h			;a676
	adc a,d			;a677
	sbc a,d			;a678
	sub e			;a679
	sub b			;a67a
	rst 18h			;a67b
	adc a,c			;a67c
	sub (hl)			;a67d
	sbc a,l			;a67e
	adc a,l			;a67f
	sbc a,(hl)			;a680
	rst 18h			;a681
	sbc a,e			;a682
	sbc a,d			;a683
	sbc a,l			;a684
	sbc a,(hl)			;a685
	sub l			;a686
	sub b			;a687
	rst 18h			;a688
	sbc a,e			;a689
	sbc a,d			;a68a
	rst 18h			;a68b
	adc a,e			;a68c
	ret pe			;a68d
	pop de			;a68e
	push af			;a68f
	xor 0bah		;a690
	sub e			;a692
	rst 18h			;a693
	adc a,e			;a694
	adc a,l			;a695
	sub b			;a696
	sub c			;a697
	sbc a,h			;a698
	sub b			;a699
	rst 18h			;a69a
	sbc a,e			;a69b
	sbc a,d			;a69c
	adc a,e			;a69d
	sub (hl)			;a69e
	sbc a,d			;a69f
	sub c			;a6a0
	sbc a,d			;a6a1
	rst 18h			;a6a2
	sub e			;a6a3
	sub b			;a6a4
	adc a,h			;a6a5
	rst 18h			;a6a6
	sub d			;a6a7
	adc a,d			;a6a8
	adc a,l			;a6a9
	sub b			;a6aa
	adc a,h			;a6ab
	sbc a,0f5h		;a6ac
	pop de			;a6ae
	rst 18h			;a6af
	cp d			;a6b0
	sub e			;a6b1
	rst 18h			;a6b2
	adc a,a			;a6b3
	sbc a,(hl)			;a6b4
	adc a,h			;a6b5
	sub b			;a6b6
	rst 18h			;a6b7
	sub a			;a6b8
	sbc a,(hl)			;a6b9
	sbc a,h			;a6ba
	sub (hl)			;a6bb
	sbc a,(hl)			;a6bc
	rst 18h			;a6bd
	push af			;a6be
	sbc a,d			;a6bf
	sub e			;a6c0
	rst 18h			;a6c1
	or b			;a6c2
	sbc a,d			;a6c3
	adc a,h			;a6c4
	adc a,e			;a6c5
	sbc a,d			;a6c6
	push af			;a6c7
	sbc a,(hl)			;a6c8
	adc a,l			;a6c9
	adc a,l			;a6ca
	sub (hl)			;a6cb
	sbc a,l			;a6cc
	sbc a,(hl)			;a6cd
	push af			;a6ce
	rst 18h			;a6cf
	sbc a,d			;a6d0
	adc a,h			;a6d1
	adc a,e			;a6d2
	jp pe,09ddfh		;a6d3
	sub e			;a6d6
	sub b			;a6d7
	adc a,(hl)			;a6d8
	adc a,d			;a6d9
	sbc a,d			;a6da
	sbc a,(hl)			;a6db
	sbc a,e			;a6dc
	sub b			;a6dd
	rst 18h			;a6de
	adc a,a			;a6df
	sub b			;a6e0
	adc a,l			;a6e1
	rst 18h			;a6e2
	sub e			;a6e3
	sub b			;a6e4
	adc a,h			;a6e5
	rst 18h			;a6e6
	sub d			;a6e7
	adc a,d			;a6e8
	adc a,l			;a6e9
	sub b			;a6ea
	adc a,h			;a6eb
	rst 18h			;a6ec
	adc a,(hl)			;a6ed
	adc a,d			;a6ee
	sbc a,d			;a6ef
	rst 18h			;a6f0
	adc a,h			;a6f1
	sbc a,d			;a6f2
	rst 18h			;a6f3
	sub a			;a6f4
	sbc a,(hl)			;a6f5
	sub c			;a6f6
	rst 18h			;a6f7
	sbc a,h			;a6f8
	sbc a,d			;a6f9
	adc a,l			;a6fa
	adc a,l			;a6fb
	sbc a,(hl)			;a6fc
	sbc a,e			;a6fd
	sub b			;a6fe
	push af			;a6ff
	cp d			;a700
	sub d			;a701
	adc a,a			;a702
	adc a,d			;a703
	sub l			;a704
	sbc a,(hl)			;a705
	adc a,h			;a706
	rst 18h			;a707
	and b			;a708
	push af			;a709
	cp a			;a70a
	rst 18h			;a70b
	adc a,a			;a70c
	sbc a,d			;a70d
	adc a,h			;a70e
	sbc a,(hl)			;a70f
	rst 18h			;a710
	sub d			;a711
	adc a,d			;a712
	sbc a,h			;a713
	sub a			;a714
	sub b			;a715
	rst 18h			;a716
	add a,(hl)			;a717
	rst 18h			;a718
	sub c			;a719
	sub b			;a71a
	rst 18h			;a71b
	adc a,a			;a71c
	adc a,d			;a71d
	sbc a,d			;a71e
	sbc a,e			;a71f
	sbc a,d			;a720
	adc a,h			;a721
	pop de			;a722
	push af			;a723
	or e			;a724
	sbc a,(hl)			;a725
	rst 18h			;a726
	sub e			;a727
	adc a,d			;a728
	add a,l			;a729
	rst 18h			;a72a
	sbc a,e			;a72b
	sbc a,d			;a72c
	rst 18h			;a72d
	sub e			;a72e
	sbc a,(hl)			;a72f
	rst 18h			;a730
	sbc a,d			;a731
	adc a,h			;a732
	sbc a,c			;a733
	sbc a,d			;a734
	adc a,l			;a735
	sbc a,(hl)			;a736
	rst 18h			;a737
	adc a,h			;a738
	sbc a,d			;a739
	rst 18h			;a73a
	adc a,l			;a73b
	sbc a,d			;a73c
	sbc a,c			;a73d
	sub e			;a73e
	sbc a,d			;a73f
	sub l			;a740
	sbc a,(hl)			;a741
	rst 18h			;a742
	sbc a,d			;a743
	sub c			;a744
	rst 18h			;a745
	sub e			;a746
	sbc a,(hl)			;a747
	adc a,h			;a748
	rst 18h			;a749
	adc a,a			;a74a
	sbc a,(hl)			;a74b
	adc a,l			;a74c
	sbc a,d			;a74d
	sbc a,e			;a74e
	sbc a,d			;a74f
	adc a,h			;a750
	rst 18h			;a751
	sbc a,h			;a752
	sub b			;a753
	sub c			;a754
	rst 18h			;a755
	adc a,e			;a756
	sbc a,(hl)			;a757
	sub c			;a758
	adc a,e			;a759
	sbc a,(hl)			;a75a
	rst 18h			;a75b
	sbc a,c			;a75c
	adc a,d			;a75d
	sbc a,d			;a75e
	adc a,l			;a75f
	add a,l			;a760
	sbc a,(hl)			;a761
	rst 18h			;a762
	adc a,(hl)			;a763
	adc a,d			;a764
	sbc a,d			;a765
	rst 18h			;a766
	adc a,e			;a767
	sbc a,d			;a768
	rst 18h			;a769
	sub a			;a76a
	sbc a,(hl)			;a76b
	sbc a,h			;a76c
	sbc a,d			;a76d
	rst 18h			;a76e
	adc a,l			;a76f
	sbc a,d			;a770
	adc a,e			;a771
	adc a,l			;a772
	sub b			;a773
	sbc a,h			;a774
	sbc a,d			;a775
	sbc a,e			;a776
	sbc a,d			;a777
	adc a,l			;a778
	pop de			;a779
	jp p,0bcf5h		;a77a
	adc a,d			;a77d
	sbc a,l			;a77e
	adc a,l			;a77f
	sbc a,d			;a780
	adc a,h			;a781
	rst 18h			;a782
	and b			;a783
	rst 18h			;a784
	sbc a,h			;a785
	sub b			;a786
	sub c			;a787
	rst 18h			;a788
	push af			;a789
	or e			;a78a
	sbc a,(hl)			;a78b
	rst 18h			;a78c
	sbc a,d			;a78d
	adc a,h			;a78e
	sbc a,c			;a78f
	sbc a,d			;a790
	adc a,l			;a791
	sbc a,(hl)			;a792
	rst 18h			;a793
	sbc a,d			;a794
	adc a,h			;a795
	adc a,e			;a796
	jp pe,08bdfh		;a797
	sbc a,(hl)			;a79a
	adc a,a			;a79b
	sbc a,(hl)			;a79c
	sbc a,e			;a79d
	sbc a,(hl)			;a79e
	rst 18h			;a79f
	sbc a,h			;a7a0
	sub b			;a7a1
	sub c			;a7a2
	rst 18h			;a7a3
	sub e			;a7a4
	sbc a,(hl)			;a7a5
	rst 18h			;a7a6
	sbc a,(hl)			;a7a7
	sub e			;a7a8
	sbc a,c			;a7a9
	sub b			;a7aa
	sub d			;a7ab
	sbc a,l			;a7ac
	adc a,l			;a7ad
	sub (hl)			;a7ae
	sub e			;a7af
	sub e			;a7b0
	sbc a,(hl)			;a7b1
	pop de			;a7b2
	push af			;a7b3
	cp d			;a7b4
	adc a,h			;a7b5
	adc a,e			;a7b6
	jp pe,09cdfh		;a7b7
	sbc a,d			;a7ba
	adc a,l			;a7bb
	adc a,l			;a7bc
	sbc a,(hl)			;a7bd
	sbc a,e			;a7be
	sbc a,(hl)			;a7bf
	rst 18h			;a7c0
	sbc a,h			;a7c1
	sub b			;a7c2
	sub c			;a7c3
	rst 18h			;a7c4
	sub e			;a7c5
	sub e			;a7c6
	sbc a,(hl)			;a7c7
	adc a,c			;a7c8
	sbc a,d			;a7c9
	pop de			;a7ca
	push af			;a7cb
	or (hl)			;a7cc
	sub c			;a7cd
	adc a,e			;a7ce
	adc a,l			;a7cf
	sub b			;a7d0
	sbc a,e			;a7d1
	adc a,d			;a7d2
	sbc a,h			;a7d3
	sbc a,d			;a7d4
	adc a,h			;a7d5
	rst 18h			;a7d6
	sub e			;a7d7
	sbc a,(hl)			;a7d8
	rst 18h			;a7d9
	sub e			;a7da
	sub e			;a7db
	sbc a,(hl)			;a7dc
	adc a,c			;a7dd
	sbc a,d			;a7de
	rst 18h			;a7df
	sbc a,d			;a7e0
	sub c			;a7e1
	rst 18h			;a7e2
	sub e			;a7e3
	sbc a,(hl)			;a7e4
	rst 18h			;a7e5
	adc a,l			;a7e6
	sbc a,(hl)			;a7e7
	sub c			;a7e8
	adc a,d			;a7e9
	adc a,l			;a7ea
	sbc a,(hl)			;a7eb
	rst 18h			;a7ec
	add a,(hl)			;a7ed
	rst 18h			;a7ee
	sbc a,(hl)			;a7ef
	sbc a,l			;a7f0
	adc a,l			;a7f1
	sbc a,d			;a7f2
	adc a,h			;a7f3
	rst 18h			;a7f4
	sub e			;a7f5
	sbc a,(hl)			;a7f6
	rst 18h			;a7f7
	adc a,a			;a7f8
	adc a,d			;a7f9
	sbc a,d			;a7fa
	adc a,l			;a7fb
	adc a,e			;a7fc
	sbc a,(hl)			;a7fd
	pop de			;a7fe
	push af			;a7ff
	or d			;a800
	sub (hl)			;a801
	adc a,l			;a802
	sbc a,(hl)			;a803
	adc a,h			;a804
	rst 18h			;a805
	adc a,a			;a806
	sub b			;a807
	adc a,l			;a808
	rst 18h			;a809
	sub e			;a80a
	sbc a,(hl)			;a80b
	rst 18h			;a80c
	adc a,l			;a80d
	sbc a,(hl)			;a80e
	sub c			;a80f
	adc a,d			;a810
	adc a,l			;a811
	sbc a,(hl)			;a812
	rst 18h			;a813
	push af			;a814
	add a,(hl)			;a815
	rst 18h			;a816
	adc a,c			;a817
	sbc a,d			;a818
	adc a,h			;a819
	rst 18h			;a81a
	sub e			;a81b
	sbc a,(hl)			;a81c
	rst 18h			;a81d
	sub e			;a81e
	sub e			;a81f
	sbc a,(hl)			;a820
	adc a,c			;a821
	sbc a,d			;a822
	rst 18h			;a823
	adc a,a			;a824
	adc a,d			;a825
	sbc a,d			;a826
	adc a,h			;a827
	adc a,e			;a828
	sbc a,(hl)			;a829
	rst 18h			;a82a
	sbc a,(hl)			;a82b
	sub e			;a82c
	rst 18h			;a82d
	sub b			;a82e
	adc a,e			;a82f
	adc a,l			;a830
	sub b			;a831
	rst 18h			;a832
	sub e			;a833
	sbc a,(hl)			;a834
	sbc a,e			;a835
	sub b			;a836
	pop de			;a837
	push af			;a838
	add a,(hl)			;a839
	rst 18h			;a83a
	adc a,c			;a83b
	sbc a,d			;a83c
	adc a,h			;a83d
	rst 18h			;a83e
	adc a,d			;a83f
	sub c			;a840
	sbc a,(hl)			;a841
	rst 18h			;a842
	sub b			;a843
	adc a,h			;a844
	sbc a,h			;a845
	adc a,d			;a846
	adc a,l			;a847
	sbc a,(hl)			;a848
	rst 18h			;a849
	sbc a,h			;a84a
	jp pe,09e92h		;a84b
	adc a,l			;a84e
	sbc a,(hl)			;a84f
	pop de			;a850
	push af			;a851
	or (hl)			;a852
	sub c			;a853
	adc a,e			;a854
	adc a,l			;a855
	sub b			;a856
	sbc a,e			;a857
	adc a,d			;a858
	sbc a,h			;a859
	sbc a,d			;a85a
	adc a,h			;a85b
	rst 18h			;a85c
	and b			;a85d
	rst 18h			;a85e
	sbc a,d			;a85f
	sub c			;a860
	rst 18h			;a861
	sub e			;a862
	sbc a,(hl)			;a863
	rst 18h			;a864
	adc a,l			;a865
	sbc a,(hl)			;a866
	sub c			;a867
	adc a,d			;a868
	adc a,l			;a869
	sbc a,(hl)			;a86a
	out (0dfh),a		;a86b
	sbc a,h			;a86d
	sbc a,(hl)			;a86e
	add a,(hl)			;a86f
	sbc a,d			;a870
	sub c			;a871
	sbc a,e			;a872
	sub b			;a873
	rst 18h			;a874
	sub e			;a875
	sbc a,(hl)			;a876
	rst 18h			;a877
	sub e			;a878
	sub e			;a879
	sbc a,(hl)			;a87a
	adc a,c			;a87b
	sbc a,d			;a87c
	rst 18h			;a87d
	sbc a,(hl)			;a87e
	sub e			;a87f
	rst 18h			;a880
	sub b			;a881
	adc a,e			;a882
	adc a,l			;a883
	sub b			;a884
	rst 18h			;a885
	sub e			;a886
	sbc a,(hl)			;a887
	sbc a,e			;a888
	sub b			;a889
	pop de			;a88a
	push af			;a88b
	xor a			;a88c
	sbc a,(hl)			;a88d
	adc a,h			;a88e
	sbc a,(hl)			;a88f
	adc a,h			;a890
	rst 18h			;a891
	sub e			;a892
	sbc a,(hl)			;a893
	rst 18h			;a894
	sbc a,(hl)			;a895
	sub e			;a896
	sbc a,c			;a897
	sub b			;a898
	sub d			;a899
	sbc a,l			;a89a
	adc a,l			;a89b
	sub (hl)			;a89c
	sub e			;a89d
	sub e			;a89e
	sbc a,(hl)			;a89f
	rst 18h			;a8a0
	adc a,a			;a8a1
	sub b			;a8a2
	adc a,l			;a8a3
	rst 18h			;a8a4
	sbc a,e			;a8a5
	sbc a,d			;a8a6
	sbc a,l			;a8a7
	sbc a,(hl)			;a8a8
	sub l			;a8a9
	sub b			;a8aa
	rst 18h			;a8ab
	sbc a,e			;a8ac
	sbc a,d			;a8ad
	rst 18h			;a8ae
	sub e			;a8af
	sbc a,(hl)			;a8b0
	rst 18h			;a8b1
	adc a,a			;a8b2
	adc a,d			;a8b3
	sbc a,d			;a8b4
	adc a,l			;a8b5
	adc a,e			;a8b6
	sbc a,(hl)			;a8b7
	pop de			;a8b8
	rst 18h			;a8b9
	push af			;a8ba
	cp (hl)			;a8bb
	sub e			;a8bc
	sbc a,d			;a8bd
	sub l			;a8be
	sbc a,(hl)			;a8bf
	adc a,h			;a8c0
	rst 18h			;a8c1
	sub e			;a8c2
	sbc a,(hl)			;a8c3
	rst 18h			;a8c4
	sub e			;a8c5
	sub e			;a8c6
	sbc a,(hl)			;a8c7
	adc a,c			;a8c8
	sbc a,d			;a8c9
	rst 18h			;a8ca
	sbc a,(hl)			;a8cb
	sub e			;a8cc
	rst 18h			;a8cd
	sbc a,d			;a8ce
	sub d			;a8cf
	adc a,a			;a8d0
	adc a,d			;a8d1
	sub l			;a8d2
	sbc a,(hl)			;a8d3
	adc a,l			;a8d4
	sub e			;a8d5
	sbc a,(hl)			;a8d6
	rst 18h			;a8d7
	sbc a,h			;a8d8
	sub b			;a8d9
	sub c			;a8da
	rst 18h			;a8db
	sub e			;a8dc
	sbc a,(hl)			;a8dd
	rst 18h			;a8de
	sbc a,(hl)			;a8df
	sub e			;a8e0
	sbc a,c			;a8e1
	sub b			;a8e2
	sub d			;a8e3
	sbc a,l			;a8e4
	adc a,l			;a8e5
	sbc a,(hl)			;a8e6
	pop de			;a8e7
	push af			;a8e8
	xor e			;a8e9
	sbc a,d			;a8ea
	rst 18h			;a8eb
	adc a,e			;a8ec
	adc a,l			;a8ed
	sbc a,(hl)			;a8ee
	sbc a,d			;a8ef
	adc a,h			;a8f0
	rst 18h			;a8f1
	sbc a,h			;a8f2
	sub b			;a8f3
	sub c			;a8f4
	rst 18h			;a8f5
	sbc a,d			;a8f6
	sub e			;a8f7
	sub e			;a8f8
	sbc a,(hl)			;a8f9
	rst 18h			;a8fa
	sub e			;a8fb
	sbc a,(hl)			;a8fc
	rst 18h			;a8fd
	sub e			;a8fe
	sub e			;a8ff
	sbc a,(hl)			;a900
	adc a,c			;a901
	sbc a,d			;a902
	out (0dfh),a		;a903
	adc a,(hl)			;a905
	adc a,d			;a906
	sbc a,d			;a907
	rst 18h			;a908
	sbc a,h			;a909
	sbc a,(hl)			;a90a
	sbc a,d			;a90b
	rst 18h			;a90c
	sbc a,(hl)			;a90d
	sub e			;a90e
	rst 18h			;a90f
	adc a,h			;a910
	adc a,d			;a911
	sbc a,d			;a912
	sub e			;a913
	sub b			;a914
	pop de			;a915
	push af			;a916
	cp l			;a917
	sbc a,(hl)			;a918
	sub l			;a919
	sub b			;a91a
	rst 18h			;a91b
	sub e			;a91c
	sbc a,(hl)			;a91d
	rst 18h			;a91e
	adc a,a			;a91f
	adc a,d			;a920
	sbc a,d			;a921
	adc a,l			;a922
	adc a,e			;a923
	sbc a,(hl)			;a924
	pop de			;a925
	push af			;a926
	or c			;a927
	sub b			;a928
	rst 18h			;a929
	adc a,a			;a92a
	sub (hl)			;a92b
	sbc a,d			;a92c
	adc a,l			;a92d
	sbc a,e			;a92e
	sbc a,(hl)			;a92f
	adc a,h			;a930
	rst 18h			;a931
	adc a,e			;a932
	sub (hl)			;a933
	sbc a,d			;a934
	sub d			;a935
	adc a,a			;a936
	sub b			;a937
	rst 18h			;a938
	sbc a,h			;a939
	sub b			;a93a
	sub c			;a93b
	rst 18h			;a93c
	sbc a,d			;a93d
	adc a,h			;a93e
	sub b			;a93f
	pop de			;a940
	push af			;a941
	or e			;a942
	sbc a,(hl)			;a943
	rst 18h			;a944
	sub e			;a945
	sub b			;a946
	adc a,h			;a947
	sbc a,(hl)			;a948
	rst 18h			;a949
	sbc a,l			;a94a
	sbc a,(hl)			;a94b
	sub l			;a94c
	sbc a,(hl)			;a94d
	rst 18h			;a94e
	add a,(hl)			;a94f
	rst 18h			;a950
	adc a,d			;a951
	sub c			;a952
	rst 18h			;a953
	adc a,a			;a954
	sbc a,(hl)			;a955
	adc a,h			;a956
	sbc a,(hl)			;a957
	sub l			;a958
	sbc a,d			;a959
	rst 18h			;a95a
	adc a,h			;a95b
	sbc a,d			;a95c
	rst 18h			;a95d
	sbc a,(hl)			;a95e
	sbc a,l			;a95f
	adc a,l			;a960
	sbc a,d			;a961
	rst 18h			;a962
	sbc a,(hl)			;a963
	sub e			;a964
	rst 18h			;a965
	cp d			;a966
	adc a,h			;a967
	adc a,e			;a968
	sbc a,d			;a969
	pop de			;a96a
	rst 18h			;a96b
	push af			;a96c
	or e			;a96d
	sbc a,(hl)			;a96e
	rst 18h			;a96f
	sbc a,h			;a970
	sbc a,(hl)			;a971
	sbc a,h			;a972
	sub a			;a973
	sub (hl)			;a974
	adc a,a			;a975
	sub b			;a976
	adc a,l			;a977
	adc a,l			;a978
	sbc a,(hl)			;a979
	rst 18h			;a97a
	adc a,e			;a97b
	adc a,l			;a97c
	sbc a,(hl)			;a97d
	sbc a,l			;a97e
	sbc a,(hl)			;a97f
	rst 18h			;a980
	sub e			;a981
	sbc a,(hl)			;a982
	rst 18h			;a983
	sub e			;a984
	sub b			;a985
	adc a,h			;a986
	sbc a,(hl)			;a987
	out (0dfh),a		;a988
	sbc a,e			;a98a
	sbc a,d			;a98b
	sub l			;a98c
	sbc a,(hl)			;a98d
	sub c			;a98e
	sbc a,e			;a98f
	sub b			;a990
	rst 18h			;a991
	sbc a,d			;a992
	sub e			;a993
	rst 18h			;a994
	adc a,a			;a995
	sbc a,(hl)			;a996
	adc a,h			;a997
	sbc a,(hl)			;a998
	sub l			;a999
	sbc a,d			;a99a
	rst 18h			;a99b
	sbc a,(hl)			;a99c
	sbc a,l			;a99d
	sub (hl)			;a99e
	sbc a,d			;a99f
	adc a,l			;a9a0
	adc a,e			;a9a1
	sub b			;a9a2
	pop de			;a9a3
	push af			;a9a4
	xor e			;a9a5
	sbc a,d			;a9a6
	rst 18h			;a9a7
	sbc a,e			;a9a8
	sub (hl)			;a9a9
	adc a,c			;a9aa
	sub (hl)			;a9ab
	sbc a,d			;a9ac
	adc a,l			;a9ad
	adc a,e			;a9ae
	sbc a,d			;a9af
	adc a,h			;a9b0
	rst 18h			;a9b1
	sbc a,h			;a9b2
	sbc a,(hl)			;a9b3
	sub c			;a9b4
	adc a,e			;a9b5
	sub (hl)			;a9b6
	sbc a,e			;a9b7
	sbc a,(hl)			;a9b8
	sbc a,e			;a9b9
	pop de			;a9ba
	push af			;a9bb
	or e			;a9bc
	sbc a,(hl)			;a9bd
	rst 18h			;a9be
	sub e			;a9bf
	sub b			;a9c0
	adc a,h			;a9c1
	sbc a,(hl)			;a9c2
	rst 18h			;a9c3
	adc a,h			;a9c4
	adc a,d			;a9c5
	sbc a,l			;a9c6
	sbc a,d			;a9c7
	rst 18h			;a9c8
	add a,(hl)			;a9c9
	rst 18h			;a9ca
	sbc a,d			;a9cb
	sub e			;a9cc
	rst 18h			;a9cd
	adc a,a			;a9ce
	sbc a,(hl)			;a9cf
	adc a,h			;a9d0
	sbc a,(hl)			;a9d1
	sbc a,e			;a9d2
	sub (hl)			;a9d3
	add a,l			;a9d4
	sub b			;a9d5
	rst 18h			;a9d6
	adc a,h			;a9d7
	sbc a,d			;a9d8
	rst 18h			;a9d9
	sbc a,h			;a9da
	sub (hl)			;a9db
	sbc a,d			;a9dc
	adc a,l			;a9dd
	adc a,l			;a9de
	sbc a,(hl)			;a9df
	pop de			;a9e0
	push af			;a9e1
	or e			;a9e2
	sbc a,(hl)			;a9e3
	rst 18h			;a9e4
	sub e			;a9e5
	sub b			;a9e6
	adc a,h			;a9e7
	sbc a,(hl)			;a9e8
	rst 18h			;a9e9
	sub c			;a9ea
	sub b			;a9eb
	rst 18h			;a9ec
	sbc a,l			;a9ed
	sbc a,(hl)			;a9ee
	sub l			;a9ef
	sbc a,(hl)			;a9f0
	pop de			;a9f1
	push af			;a9f2
	cp a			;a9f3
	rst 18h			;a9f4
	adc a,h			;a9f5
	sbc a,d			;a9f6
	rst 18h			;a9f7
	sbc a,(hl)			;a9f8
	adc a,e			;a9f9
	sbc a,(hl)			;a9fa
	adc a,h			;a9fb
	sbc a,h			;a9fc
	sbc a,(hl)			;a9fd
	pop de			;a9fe
	push af			;a9ff
	cp d			;aa00
	sub d			;aa01
	adc a,a			;aa02
	adc a,d			;aa03
	sub l			;aa04
	sbc a,(hl)			;aa05
	adc a,h			;aa06
	rst 18h			;aa07
	sub e			;aa08
	sbc a,(hl)			;aa09
	rst 18h			;aa0a
	sub e			;aa0b
	sub b			;aa0c
	adc a,h			;aa0d
	sbc a,(hl)			;aa0e
	rst 18h			;aa0f
	add a,(hl)			;aa10
	rst 18h			;aa11
	adc a,a			;aa12
	sub b			;aa13
	sub c			;aa14
	sbc a,d			;aa15
	adc a,h			;aa16
	rst 18h			;aa17
	sub e			;aa18
	sbc a,(hl)			;aa19
	rst 18h			;aa1a
	adc a,a			;aa1b
	sub b			;aa1c
	adc a,l			;aa1d
	adc a,l			;aa1e
	sbc a,(hl)			;aa1f
	rst 18h			;aa20
	sbc a,d			;aa21
	sub c			;aa22
	adc a,e			;aa23
	adc a,l			;aa24
	sbc a,d			;aa25
	rst 18h			;aa26
	sub e			;aa27
	sbc a,(hl)			;aa28
	adc a,h			;aa29
	rst 18h			;aa2a
	sbc a,(hl)			;aa2b
	adc a,l			;aa2c
	sbc a,b			;aa2d
	sub b			;aa2e
	sub e			;aa2f
	sub e			;aa30
	sbc a,(hl)			;aa31
	adc a,h			;aa32
	pop de			;aa33
	rst 18h			;aa34
	push af			;aa35
	or c			;aa36
	sbc a,d			;aa37
	sbc a,h			;aa38
	sbc a,d			;aa39
	adc a,h			;aa3a
	sub (hl)			;aa3b
	adc a,e			;aa3c
	sbc a,(hl)			;aa3d
	adc a,h			;aa3e
	rst 18h			;aa3f
	sbc a,(hl)			;aa40
	sub e			;aa41
	sbc a,b			;aa42
	sub b			;aa43
	rst 18h			;aa44
	sub d			;aa45
	jp pe,0df8ch		;aa46
	sub e			;aa49
	sbc a,(hl)			;aa4a
	adc a,l			;aa4b
	sbc a,b			;aa4c
	sub b			;aa4d
	pop de			;aa4e
	push af			;aa4f
	cp d			;aa50
	adc a,h			;aa51
	adc a,e			;aa52
	jp pe,09adfh		;aa53
	sub c			;aa56
	adc a,e			;aa57
	adc a,l			;aa58
	sbc a,d			;aa59
	rst 18h			;aa5a
	sub e			;aa5b
	sbc a,(hl)			;aa5c
	adc a,h			;aa5d
	rst 18h			;aa5e
	sbc a,(hl)			;aa5f
	adc a,l			;aa60
	sbc a,b			;aa61
	sub b			;aa62
	sub e			;aa63
	sub e			;aa64
	sbc a,(hl)			;aa65
	adc a,h			;aa66
	pop de			;aa67
	push af			;aa68
	cp d			;aa69
	sub e			;aa6a
	rst 18h			;aa6b
	adc a,a			;aa6c
	sbc a,d			;aa6d
	adc a,h			;aa6e
	sub b			;aa6f
	rst 18h			;aa70
	sbc a,e			;aa71
	sbc a,d			;aa72
	rst 18h			;aa73
	sub e			;aa74
	sub b			;aa75
	adc a,h			;aa76
	rst 18h			;aa77
	sub e			;aa78
	sub (hl)			;aa79
	sbc a,l			;aa7a
	adc a,l			;aa7b
	sub b			;aa7c
	adc a,h			;aa7d
	rst 18h			;aa7e
	sbc a,(hl)			;aa7f
	sbc a,h			;aa80
	adc a,e			;aa81
	sub (hl)			;aa82
	adc a,c			;aa83
	sbc a,(hl)			;aa84
	rst 18h			;aa85
	adc a,d			;aa86
	sub c			;aa87
	rst 18h			;aa88
	sub d			;aa89
	sbc a,d			;aa8a
	sbc a,h			;aa8b
	sbc a,(hl)			;aa8c
	sub c			;aa8d
	sub (hl)			;aa8e
	adc a,h			;aa8f
	sub d			;aa90
	sub b			;aa91
	pop de			;aa92
	di			;aa93
	call p,091aah		;aa94
	sbc a,(hl)			;aa97
	rst 18h			;aa98
	sub e			;aa99
	sub b			;aa9a
	adc a,h			;aa9b
	sbc a,(hl)			;aa9c
	rst 18h			;aa9d
	adc a,h			;aa9e
	sbc a,d			;aa9f
	rst 18h			;aaa0
	sbc a,(hl)			;aaa1
	sbc a,l			;aaa2
	adc a,l			;aaa3
	sbc a,d			;aaa4
	rst 18h			;aaa5
	add a,(hl)			;aaa6
	rst 18h			;aaa7
	adc a,c			;aaa8
	sbc a,d			;aaa9
	adc a,h			;aaaa
	rst 18h			;aaab
	adc a,d			;aaac
	sub c			;aaad
	rst 18h			;aaae
	adc a,a			;aaaf
	sbc a,(hl)			;aab0
	adc a,h			;aab1
	sbc a,(hl)			;aab2
	sub l			;aab3
	sbc a,d			;aab4
	rst 18h			;aab5
	sbc a,e			;aab6
	sbc a,d			;aab7
	adc a,h			;aab8
	sbc a,h			;aab9
	sbc a,d			;aaba
	sub c			;aabb
	sbc a,e			;aabc
	sbc a,d			;aabd
	sub c			;aabe
	adc a,e			;aabf
	sbc a,d			;aac0
	pop de			;aac1
	push af			;aac2
	cp d			;aac3
	sub e			;aac4
	rst 18h			;aac5
	adc a,a			;aac6
	sbc a,(hl)			;aac7
	adc a,h			;aac8
	sbc a,(hl)			;aac9
	sub l			;aaca
	sbc a,d			;aacb
	rst 18h			;aacc
	adc a,h			;aacd
	sbc a,d			;aace
	rst 18h			;aacf
	sbc a,h			;aad0
	sub (hl)			;aad1
	sbc a,d			;aad2
	adc a,l			;aad3
	adc a,l			;aad4
	sbc a,(hl)			;aad5
	pop de			;aad6
	push af			;aad7
	pop de			;aad8
	rst 18h			;aad9
	cp (hl)			;aada
	sub e			;aadb
	rst 18h			;aadc
	sbc a,c			;aadd
	sub b			;aade
	sub c			;aadf
	sbc a,e			;aae0
	sub b			;aae1
	rst 18h			;aae2
	adc a,c			;aae3
	sbc a,d			;aae4
	adc a,h			;aae5
	rst 18h			;aae6
	adc a,d			;aae7
	sub c			;aae8
	rst 18h			;aae9
	sbc a,d			;aaea
	adc a,h			;aaeb
	adc a,e			;aaec
	adc a,l			;aaed
	sbc a,d			;aaee
	sbc a,h			;aaef
	sub a			;aaf0
	sub b			;aaf1
	rst 18h			;aaf2
	adc a,a			;aaf3
	sbc a,(hl)			;aaf4
	adc a,h			;aaf5
	sbc a,(hl)			;aaf6
	sub l			;aaf7
	sbc a,d			;aaf8
	push af			;aaf9
	pop de			;aafa
	rst 18h			;aafb
	xor e			;aafc
	sbc a,(hl)			;aafd
	sub d			;aafe
	sbc a,l			;aaff
	sub (hl)			;ab00
	jp (hl)			;ab01
	sub c			;ab02
	rst 18h			;ab03
	adc a,c			;ab04
	sbc a,d			;ab05
	adc a,h			;ab06
	rst 18h			;ab07
	adc a,d			;ab08
	sub c			;ab09
	rst 18h			;ab0a
	sbc a,b			;ab0b
	adc a,l			;ab0c
	sbc a,(hl)			;ab0d
	sub c			;ab0e
	rst 18h			;ab0f
	adc a,h			;ab10
	sub b			;ab11
	sub e			;ab12
	rst 18h			;ab13
	sbc a,e			;ab14
	sub b			;ab15
	adc a,l			;ab16
	sbc a,(hl)			;ab17
	sbc a,e			;ab18
	sub b			;ab19
	push af			;ab1a
	or (hl)			;ab1b
	sub d			;ab1c
	adc a,a			;ab1d
	sub b			;ab1e
	adc a,h			;ab1f
	sub (hl)			;ab20
	sbc a,l			;ab21
	sub e			;ab22
	sbc a,d			;ab23
	pop de			;ab24
	push af			;ab25
	or e			;ab26
	sbc a,(hl)			;ab27
	rst 18h			;ab28
	sbc a,h			;ab29
	adc a,d			;ab2a
	push hl			;ab2b
	sbc a,(hl)			;ab2c
	rst 18h			;ab2d
	adc a,h			;ab2e
	sbc a,(hl)			;ab2f
	sub e			;ab30
	adc a,e			;ab31
	sbc a,(hl)			;ab32
	pop de			;ab33
	rst 18h			;ab34
	push af			;ab35
	xor 0bah		;ab36
	sub e			;ab38
	rst 18h			;ab39
	sbc a,d			;ab3a
	sub c			;ab3b
	sub b			;ab3c
	adc a,l			;ab3d
	sub d			;ab3e
	sbc a,d			;ab3f
	rst 18h			;ab40
	adc a,h			;ab41
	sub b			;ab42
	sub e			;ab43
	rst 18h			;ab44
	adc a,h			;ab45
	sbc a,d			;ab46
	rst 18h			;ab47
	adc a,e			;ab48
	sbc a,d			;ab49
	rst 18h			;ab4a
	adc a,c			;ab4b
	sub (hl)			;ab4c
	sbc a,d			;ab4d
	sub c			;ab4e
	sbc a,d			;ab4f
	rst 18h			;ab50
	sbc a,d			;ab51
	sub c			;ab52
	sbc a,h			;ab53
	sub (hl)			;ab54
	sub d			;ab55
	sbc a,(hl)			;ab56
	sbc a,0f5h		;ab57
	cp d			;ab59
	sub e			;ab5a
	rst 18h			;ab5b
	adc a,h			;ab5c
	sub b			;ab5d
	sub e			;ab5e
	rst 18h			;ab5f
	adc a,a			;ab60
	sbc a,(hl)			;ab61
	adc a,h			;ab62
	sbc a,(hl)			;ab63
	rst 18h			;ab64
	adc a,a			;ab65
	sub b			;ab66
	adc a,l			;ab67
	rst 18h			;ab68
	adc a,e			;ab69
	adc a,d			;ab6a
	rst 18h			;ab6b
	sub e			;ab6c
	sbc a,(hl)			;ab6d
	sbc a,e			;ab6e
	sub b			;ab6f
	rst 18h			;ab70
	add a,(hl)			;ab71
	rst 18h			;ab72
	sbc a,e			;ab73
	sbc a,d			;ab74
	adc a,h			;ab75
	adc a,e			;ab76
	adc a,l			;ab77
	sub b			;ab78
	add a,l			;ab79
	sbc a,(hl)			;ab7a
	rst 18h			;ab7b
	sbc a,d			;ab7c
	sub e			;ab7d
	rst 18h			;ab7e
	sub d			;ab7f
	adc a,d			;ab80
	adc a,l			;ab81
	sub b			;ab82
	rst 18h			;ab83
	sbc a,e			;ab84
	sbc a,d			;ab85
	sub e			;ab86
	rst 18h			;ab87
	sbc a,c			;ab88
	sub b			;ab89
	sub c			;ab8a
	sbc a,e			;ab8b
	sub b			;ab8c
	pop de			;ab8d
	push af			;ab8e
	cp d			;ab8f
	sub e			;ab90
	rst 18h			;ab91
	adc a,h			;ab92
	sub b			;ab93
	sub e			;ab94
	rst 18h			;ab95
	adc a,e			;ab96
	sbc a,d			;ab97
	rst 18h			;ab98
	sbc a,(hl)			;ab99
	adc a,a			;ab9a
	sub e			;ab9b
	sbc a,(hl)			;ab9c
	adc a,h			;ab9d
	adc a,e			;ab9e
	rst 20h			;ab9f
	pop de			;aba0
	push af			;aba1
	pop de			;aba2
	rst 18h			;aba3
	or e			;aba4
	sbc a,(hl)			;aba5
	rst 18h			;aba6
	sbc a,l			;aba7
	sub b			;aba8
	sub e			;aba9
	sbc a,(hl)			;abaa
	rst 18h			;abab
	sbc a,(hl)			;abac
	sbc a,l			;abad
	adc a,l			;abae
	sub (hl)			;abaf
	rst 20h			;abb0
	rst 18h			;abb1
	adc a,d			;abb2
	sub c			;abb3
	rst 18h			;abb4
	sbc a,(hl)			;abb5
	sbc a,b			;abb6
	adc a,d			;abb7
	sub l			;abb8
	sbc a,d			;abb9
	adc a,l			;abba
	sub b			;abbb
	rst 18h			;abbc
	sbc a,d			;abbd
	sub c			;abbe
	rst 18h			;abbf
	sbc a,d			;abc0
	sub e			;abc1
	rst 18h			;abc2
	sub d			;abc3
	adc a,d			;abc4
	adc a,l			;abc5
	sub b			;abc6
	push af			;abc7
	pop de			;abc8
	rst 18h			;abc9
	cp d			;abca
	sub e			;abcb
	rst 18h			;abcc
	adc a,h			;abcd
	sub b			;abce
	sub e			;abcf
	rst 18h			;abd0
	sbc a,e			;abd1
	sub b			;abd2
	adc a,l			;abd3
	sbc a,(hl)			;abd4
	sbc a,e			;abd5
	sub b			;abd6
	rst 18h			;abd7
	sbc a,d			;abd8
	adc a,h			;abd9
	adc a,e			;abda
	jp pe,09edfh		;abdb
	adc a,e			;abde
	sbc a,(hl)			;abdf
	adc a,h			;abe0
	sbc a,h			;abe1
	sbc a,(hl)			;abe2
	sbc a,e			;abe3
	sub b			;abe4
	rst 18h			;abe5
	sbc a,(hl)			;abe6
	adc a,(hl)			;abe7
	adc a,d			;abe8
	ret pe			;abe9
	push af			;abea
	cp d			;abeb
	sub e			;abec
	rst 18h			;abed
	adc a,h			;abee
	sub b			;abef
	sub e			;abf0
	rst 18h			;abf1
	adc a,e			;abf2
	sbc a,(hl)			;abf3
	adc a,a			;abf4
	sub b			;abf5
	sub c			;abf6
	sbc a,(hl)			;abf7
	rst 18h			;abf8
	sub e			;abf9
	sbc a,(hl)			;abfa
	rst 18h			;abfb
	sbc a,h			;abfc
	sbc a,(hl)			;abfd
	adc a,h			;abfe
	sbc a,h			;abff
	sbc a,(hl)			;ac00
	sbc a,e			;ac01
	sbc a,(hl)			;ac02
	push af			;ac03
	xor h			;ac04
	rst 20h			;ac05
	sub e			;ac06
	sub b			;ac07
	rst 18h			;ac08
	adc a,d			;ac09
	sub c			;ac0a
	rst 18h			;ac0b
	sbc a,e			;ac0c
	sub (hl)			;ac0d
	sub b			;ac0e
	adc a,h			;ac0f
	rst 18h			;ac10
	adc a,a			;ac11
	sub b			;ac12
	sbc a,e			;ac13
	adc a,l			;ac14
	ret pe			;ac15
	sbc a,(hl)			;ac16
	pop de			;ac17
	push af			;ac18
	cp d			;ac19
	sub e			;ac1a
	rst 18h			;ac1b
	adc a,h			;ac1c
	sbc a,d			;ac1d
	adc a,l			;ac1e
	rst 18h			;ac1f
	adc a,e			;ac20
	sbc a,d			;ac21
	rst 18h			;ac22
	sub d			;ac23
	sub (hl)			;ac24
	adc a,l			;ac25
	sbc a,(hl)			;ac26
	rst 18h			;ac27
	add a,(hl)			;ac28
	rst 18h			;ac29
	sbc a,h			;ac2a
	sbc a,(hl)			;ac2b
	sub d			;ac2c
	sub (hl)			;ac2d
	sub c			;ac2e
	sbc a,(hl)			;ac2f
	rst 18h			;ac30
	sub a			;ac31
	sbc a,(hl)			;ac32
	sbc a,h			;ac33
	sub (hl)			;ac34
	sbc a,(hl)			;ac35
	rst 18h			;ac36
	adc a,e			;ac37
	ret pe			;ac38
	pop de			;ac39
	push af			;ac3a
	or d			;ac3b
	sbc a,d			;ac3c
	sub l			;ac3d
	sub b			;ac3e
	adc a,l			;ac3f
	rst 18h			;ac40
	adc a,h			;ac41
	sbc a,d			;ac42
	adc a,l			;ac43
	jp pe,098dfh		;ac44
	adc a,d			;ac47
	sbc a,(hl)			;ac48
	adc a,l			;ac49
	sbc a,e			;ac4a
	sbc a,(hl)			;ac4b
	adc a,l			;ac4c
	rst 18h			;ac4d
	sub e			;ac4e
	sbc a,(hl)			;ac4f
	adc a,h			;ac50
	rst 18h			;ac51
	sbc a,e			;ac52
	sub (hl)			;ac53
	adc a,h			;ac54
	adc a,e			;ac55
	sbc a,(hl)			;ac56
	sub c			;ac57
	sbc a,h			;ac58
	sub (hl)			;ac59
	sbc a,(hl)			;ac5a
	adc a,h			;ac5b
	pop de			;ac5c
	push af			;ac5d
	cp e			;ac5e
	sbc a,d			;ac5f
	sub e			;ac60
	rst 18h			;ac61
	sbc a,d			;ac62
	adc a,h			;ac63
	adc a,(hl)			;ac64
	adc a,d			;ac65
	sbc a,d			;ac66
	sub e			;ac67
	sbc a,d			;ac68
	adc a,e			;ac69
	sub b			;ac6a
	rst 18h			;ac6b
	sbc a,d			;ac6c
	sub d			;ac6d
	sbc a,(hl)			;ac6e
	sub c			;ac6f
	sbc a,(hl)			;ac70
	rst 18h			;ac71
	sub (hl)			;ac72
	sub c			;ac73
	adc a,e			;ac74
	sbc a,d			;ac75
	sub c			;ac76
	adc a,h			;ac77
	sub b			;ac78
	rst 18h			;ac79
	sbc a,c			;ac7a
	adc a,l			;ac7b
	ret pe			;ac7c
	sub b			;ac7d
	pop de			;ac7e
	push af			;ac7f
	xor e			;ac80
	sbc a,d			;ac81
	rst 18h			;ac82
	sbc a,d			;ac83
	adc a,h			;ac84
	adc a,e			;ac85
	jp pe,0df8ch		;ac86
	sub a			;ac89
	sbc a,d			;ac8a
	sub e			;ac8b
	sbc a,(hl)			;ac8c
	sub c			;ac8d
	sbc a,e			;ac8e
	sub b			;ac8f
	pop de			;ac90
	pop de			;ac91
	pop de			;ac92
	push af			;ac93
	cp d			;ac94
	sub e			;ac95
	rst 18h			;ac96
	sub a			;ac97
	sub (hl)			;ac98
	sbc a,d			;ac99
	sub e			;ac9a
	sub b			;ac9b
	rst 18h			;ac9c
	adc a,e			;ac9d
	sbc a,d			;ac9e
	rst 18h			;ac9f
	sbc a,h			;aca0
	sub b			;aca1
	sub c			;aca2
	sbc a,b			;aca3
	sbc a,d			;aca4
	sub e			;aca5
	sbc a,(hl)			;aca6
	pop de			;aca7
	push af			;aca8
	cp d			;aca9
	adc a,l			;acaa
	sbc a,d			;acab
	adc a,h			;acac
	rst 18h			;acad
	adc a,d			;acae
	sub c			;acaf
	sbc a,(hl)			;acb0
	rst 18h			;acb1
	sbc a,d			;acb2
	adc a,h			;acb3
	adc a,e			;acb4
	sbc a,(hl)			;acb5
	adc a,e			;acb6
	adc a,d			;acb7
	sbc a,(hl)			;acb8
	rst 18h			;acb9
	sbc a,e			;acba
	sbc a,d			;acbb
	rst 18h			;acbc
	sub a			;acbd
	sub (hl)			;acbe
	sbc a,d			;acbf
	sub e			;acc0
	sub b			;acc1
	pop de			;acc2
	push af			;acc3
	cp d			;acc4
	sub e			;acc5
	rst 18h			;acc6
	sbc a,d			;acc7
	adc a,h			;acc8
	adc a,(hl)			;acc9
	adc a,d			;acca
	sbc a,d			;accb
	sub e			;accc
	sbc a,d			;accd
	adc a,e			;acce
	sub b			;accf
	rst 18h			;acd0
	adc a,l			;acd1
	sbc a,d			;acd2
	sbc a,h			;acd3
	sub b			;acd4
	sbc a,b			;acd5
	sbc a,d			;acd6
	rst 18h			;acd7
	sub e			;acd8
	sbc a,(hl)			;acd9
	rst 18h			;acda
	sbc a,h			;acdb
	sbc a,(hl)			;acdc
	sub e			;acdd
	sbc a,(hl)			;acde
	adc a,c			;acdf
	sbc a,d			;ace0
	adc a,l			;ace1
	sbc a,(hl)			;ace2
	rst 18h			;ace3
	add a,(hl)			;ace4
	rst 18h			;ace5
	adc a,h			;ace6
	sbc a,d			;ace7
	rst 18h			;ace8
	sbc a,e			;ace9
	sbc a,d			;acea
	adc a,e			;aceb
	sub (hl)			;acec
	sbc a,d			;aced
	sub c			;acee
	sbc a,d			;acef
	pop de			;acf0
	push af			;acf1
	xor a			;acf2
	sbc a,(hl)			;acf3
	adc a,l			;acf4
	sbc a,d			;acf5
	sbc a,h			;acf6
	sbc a,d			;acf7
	rst 18h			;acf8
	sub a			;acf9
	sub (hl)			;acfa
	adc a,a			;acfb
	sub c			;acfc
	sub b			;acfd
	adc a,e			;acfe
	sub (hl)			;acff
	add a,l			;ad00
	sbc a,(hl)			;ad01
	sbc a,e			;ad02
	sub b			;ad03
	rst 18h			;ad04
	adc a,a			;ad05
	sub b			;ad06
	adc a,l			;ad07
	rst 18h			;ad08
	sub e			;ad09
	sbc a,(hl)			;ad0a
	rst 18h			;ad0b
	sbc a,h			;ad0c
	sbc a,(hl)			;ad0d
	sub e			;ad0e
	sbc a,(hl)			;ad0f
	adc a,c			;ad10
	sbc a,d			;ad11
	adc a,l			;ad12
	sbc a,(hl)			;ad13
	pop de			;ad14
	rst 18h			;ad15
	push af			;ad16
	or e			;ad17
	sub b			;ad18
	rst 18h			;ad19
	sub (hl)			;ad1a
	sub c			;ad1b
	adc a,e			;ad1c
	sbc a,d			;ad1d
	sub c			;ad1e
	adc a,e			;ad1f
	sbc a,(hl)			;ad20
	adc a,h			;ad21
	out (0dfh),a		;ad22
	adc a,a			;ad24
	sbc a,d			;ad25
	adc a,l			;ad26
	sub b			;ad27
	rst 18h			;ad28
	sbc a,(hl)			;ad29
	sub c			;ad2a
	adc a,e			;ad2b
	sbc a,d			;ad2c
	rst 18h			;ad2d
	sub e			;ad2e
	sbc a,(hl)			;ad2f
	rst 18h			;ad30
	sub d			;ad31
	sub (hl)			;ad32
	adc a,l			;ad33
	sbc a,(hl)			;ad34
	sbc a,e			;ad35
	sbc a,(hl)			;ad36
	rst 18h			;ad37
	sbc a,e			;ad38
	sbc a,d			;ad39
	sub e			;ad3a
	rst 18h			;ad3b
	adc a,h			;ad3c
	sbc a,d			;ad3d
	adc a,l			;ad3e
	rst 18h			;ad3f
	adc a,l			;ad40
	sbc a,d			;ad41
	adc a,e			;ad42
	adc a,l			;ad43
	sub b			;ad44
	sbc a,h			;ad45
	sbc a,d			;ad46
	sbc a,e			;ad47
	sbc a,d			;ad48
	adc a,h			;ad49
	pop de			;ad4a
	push af			;ad4b
	cp d			;ad4c
	sub e			;ad4d
	rst 18h			;ad4e
	sbc a,(hl)			;ad4f
	sbc a,b			;ad50
	adc a,d			;ad51
	sbc a,(hl)			;ad52
	rst 18h			;ad53
	adc a,(hl)			;ad54
	adc a,d			;ad55
	sbc a,d			;ad56
	rst 18h			;ad57
	sbc a,l			;ad58
	sbc a,(hl)			;ad59
	sub l			;ad5a
	sbc a,(hl)			;ad5b
	sbc a,l			;ad5c
	sbc a,(hl)			;ad5d
	rst 18h			;ad5e
	adc a,a			;ad5f
	sub b			;ad60
	adc a,l			;ad61
	rst 18h			;ad62
	sub e			;ad63
	sbc a,(hl)			;ad64
	adc a,h			;ad65
	rst 18h			;ad66
	adc a,a			;ad67
	sbc a,(hl)			;ad68
	adc a,l			;ad69
	sbc a,d			;ad6a
	sbc a,e			;ad6b
	sbc a,d			;ad6c
	adc a,h			;ad6d
	rst 18h			;ad6e
	adc a,h			;ad6f
	sbc a,d			;ad70
	rst 18h			;ad71
	sbc a,h			;ad72
	sub b			;ad73
	sub c			;ad74
	sbc a,b			;ad75
	sbc a,d			;ad76
	sub e			;ad77
	sbc a,(hl)			;ad78
	pop de			;ad79
	push af			;ad7a
	cp d			;ad7b
	sub e			;ad7c
	rst 18h			;ad7d
	sbc a,(hl)			;ad7e
	sbc a,b			;ad7f
	adc a,d			;ad80
	sbc a,(hl)			;ad81
	rst 18h			;ad82
	sbc a,h			;ad83
	sub a			;ad84
	sub b			;ad85
	adc a,l			;ad86
	adc a,l			;ad87
	sbc a,d			;ad88
	sbc a,(hl)			;ad89
	rst 18h			;ad8a
	adc a,a			;ad8b
	sub b			;ad8c
	adc a,l			;ad8d
	rst 18h			;ad8e
	adc a,e			;ad8f
	sub b			;ad90
	sbc a,e			;ad91
	sbc a,(hl)			;ad92
	adc a,h			;ad93
	rst 18h			;ad94
	sub e			;ad95
	sbc a,(hl)			;ad96
	adc a,h			;ad97
	rst 18h			;ad98
	adc a,a			;ad99
	sbc a,(hl)			;ad9a
	adc a,l			;ad9b
	sbc a,d			;ad9c
	sbc a,e			;ad9d
	sbc a,d			;ad9e
	adc a,h			;ad9f
	push af			;ada0
	cp d			;ada1
	sub e			;ada2
	rst 18h			;ada3
	sbc a,(hl)			;ada4
	sbc a,b			;ada5
	adc a,d			;ada6
	sbc a,(hl)			;ada7
	rst 18h			;ada8
	sub a			;ada9
	sbc a,d			;adaa
	sub e			;adab
	sbc a,(hl)			;adac
	sbc a,e			;adad
	sbc a,(hl)			;adae
	rst 18h			;adaf
	sbc a,c			;adb0
	sub b			;adb1
	adc a,l			;adb2
	sub d			;adb3
	sbc a,(hl)			;adb4
	rst 18h			;adb5
	adc a,a			;adb6
	adc a,d			;adb7
	sub e			;adb8
	sub (hl)			;adb9
	sbc a,e			;adba
	sub b			;adbb
	adc a,h			;adbc
	rst 18h			;adbd
	sbc a,d			;adbe
	adc a,h			;adbf
	adc a,a			;adc0
	sbc a,d			;adc1
	sub l			;adc2
	sub b			;adc3
	adc a,h			;adc4
	push af			;adc5
	or e			;adc6
	sbc a,(hl)			;adc7
	rst 18h			;adc8
	adc a,c			;adc9
	sub (hl)			;adca
	sbc a,e			;adcb
	sbc a,(hl)			;adcc
	rst 18h			;adcd
	adc a,e			;adce
	sbc a,d			;adcf
	rst 18h			;add0
	adc a,c			;add1
	adc a,d			;add2
	sbc a,d			;add3
	sub e			;add4
	adc a,c			;add5
	sbc a,d			;add6
	pop de			;add7
	pop de			;add8
	pop de			;add9
	push af			;adda
	cp d			;addb
	adc a,e			;addc
	sbc a,d			;addd
	adc a,l			;adde
	sub c			;addf
	sub b			;ade0
	adc a,h			;ade1
	rst 18h			;ade2
	adc a,l			;ade3
	sub (hl)			;ade4
	adc a,c			;ade5
	sbc a,(hl)			;ade6
	sub e			;ade7
	sbc a,d			;ade8
	adc a,h			;ade9
	out (0dfh),a		;adea
	sub c			;adec
	sub b			;aded
	rst 18h			;adee
	adc a,a			;adef
	adc a,d			;adf0
	sbc a,d			;adf1
	sbc a,e			;adf2
	sbc a,d			;adf3
	sub c			;adf4
	rst 18h			;adf5
	adc a,c			;adf6
	sbc a,d			;adf7
	sub c			;adf8
	sbc a,h			;adf9
	sbc a,d			;adfa
	adc a,l			;adfb
	adc a,h			;adfc
	sbc a,d			;adfd
	rst 18h			;adfe
	sbc a,c			;adff
	ret pe			;ae00
	adc a,h			;ae01
	sub (hl)			;ae02
	sbc a,h			;ae03
	sbc a,(hl)			;ae04
	sub d			;ae05
	sbc a,d			;ae06
	sub c			;ae07
	adc a,e			;ae08
	sbc a,d			;ae09
	out (0dfh),a		;ae0a
	adc a,a			;ae0c
	sub b			;ae0d
	adc a,l			;ae0e
	rst 18h			;ae0f
	sub e			;ae10
	sub b			;ae11
	rst 18h			;ae12
	adc a,(hl)			;ae13
	adc a,d			;ae14
	sbc a,d			;ae15
	rst 18h			;ae16
	xor e			;ae17
	sbc a,d			;ae18
	add a,l			;ae19
	sbc a,h			;ae1a
	sbc a,(hl)			;ae1b
	adc a,e			;ae1c
	sub e			;ae1d
	sub (hl)			;ae1e
	adc a,a			;ae1f
	sub b			;ae20
	sbc a,h			;ae21
	sbc a,(hl)			;ae22
	rst 18h			;ae23
	sbc a,(hl)			;ae24
	sub e			;ae25
	add a,l			;ae26
	sbc a,(hl)			;ae27
	rst 18h			;ae28
	adc a,h			;ae29
	adc a,d			;ae2a
	rst 18h			;ae2b
	sbc a,d			;ae2c
	adc a,h			;ae2d
	sbc a,h			;ae2e
	adc a,d			;ae2f
	sbc a,e			;ae30
	sub b			;ae31
	rst 18h			;ae32
	add a,(hl)			;ae33
	rst 18h			;ae34
	and (hl)			;ae35
	adc a,d			;ae36
	sub d			;ae37
	rst 18h			;ae38
	or h			;ae39
	sbc a,h			;ae3a
	sub (hl)			;ae3b
	sub d			;ae3c
	sub (hl)			;ae3d
	sub e			;ae3e
	rst 18h			;ae3f
	sbc a,d			;ae40
	adc a,h			;ae41
	rst 18h			;ae42
	sbc a,(hl)			;ae43
	sbc a,l			;ae44
	adc a,h			;ae45
	sub b			;ae46
	adc a,l			;ae47
	sbc a,l			;ae48
	sub (hl)			;ae49
	sbc a,e			;ae4a
	sub b			;ae4b
	pop de			;ae4c
	push af			;ae4d
	xor e			;ae4e
	sbc a,d			;ae4f
	add a,l			;ae50
	sbc a,h			;ae51
	sbc a,(hl)			;ae52
	adc a,e			;ae53
	sub e			;ae54
	sub (hl)			;ae55
	adc a,a			;ae56
	sub b			;ae57
	sbc a,h			;ae58
	sbc a,(hl)			;ae59
	rst 18h			;ae5a
	adc a,e			;ae5b
	sbc a,d			;ae5c
	rst 18h			;ae5d
	sbc a,d			;ae5e
	sub c			;ae5f
	sbc a,c			;ae60
	sub b			;ae61
	sbc a,h			;ae62
	sbc a,(hl)			;ae63
	rst 18h			;ae64
	sbc a,h			;ae65
	sub b			;ae66
	sub c			;ae67
	rst 18h			;ae68
	adc a,h			;ae69
	adc a,d			;ae6a
	rst 18h			;ae6b
	sbc a,d			;ae6c
	adc a,h			;ae6d
	adc a,a			;ae6e
	sbc a,d			;ae6f
	sub l			;ae70
	sub b			;ae71
	rst 18h			;ae72
	sub b			;ae73
	adc a,h			;ae74
	sbc a,h			;ae75
	adc a,d			;ae76
	adc a,l			;ae77
	sub b			;ae78
	out (0dfh),a		;ae79
	adc a,e			;ae7b
	adc a,l			;ae7c
	sbc a,(hl)			;ae7d
	adc a,h			;ae7e
	rst 18h			;ae7f
	sub e			;ae80
	sub b			;ae81
	rst 18h			;ae82
	sbc a,h			;ae83
	adc a,d			;ae84
	sbc a,(hl)			;ae85
	sub e			;ae86
	rst 18h			;ae87
	adc a,e			;ae88
	adc a,d			;ae89
	rst 18h			;ae8a
	adc a,c			;ae8b
	sub b			;ae8c
	sub e			;ae8d
	adc a,d			;ae8e
	sub c			;ae8f
	adc a,e			;ae90
	sbc a,(hl)			;ae91
	sbc a,e			;ae92
	rst 18h			;ae93
	sbc a,e			;ae94
	sbc a,d			;ae95
	adc a,h			;ae96
	sbc a,(hl)			;ae97
	adc a,a			;ae98
	sbc a,(hl)			;ae99
	adc a,l			;ae9a
	sbc a,d			;ae9b
	sbc a,h			;ae9c
	sbc a,d			;ae9d
	pop de			;ae9e
	di			;ae9f
	call p,09ea9h		;aea0
	sbc a,b			;aea3
	sbc a,(hl)			;aea4
	adc a,l			;aea5
	jp pe,0df8ch		;aea6
	sbc a,d			;aea9
	adc a,e			;aeaa
	sbc a,d			;aeab
	adc a,l			;aeac
	sub c			;aead
	sbc a,(hl)			;aeae
	sub d			;aeaf
	sbc a,d			;aeb0
	sub c			;aeb1
	adc a,e			;aeb2
	sbc a,d			;aeb3
	rst 18h			;aeb4
	adc a,a			;aeb5
	sub b			;aeb6
	adc a,l			;aeb7
	rst 18h			;aeb8
	and a			;aeb9
	sub (hl)			;aeba
	sbc a,l			;aebb
	sbc a,(hl)			;aebc
	sub e			;aebd
	sbc a,l			;aebe
	jp pe,0d1d1h		;aebf
	pop de			;aec2
	push af			;aec3
	adc a,c			;aec4
	sbc a,d			;aec5
	rst 18h			;aec6
	adc a,h			;aec7
	adc a,d			;aec8
	rst 18h			;aec9
	adc a,l			;aeca
	sbc a,d			;aecb
	sbc a,c			;aecc
	sub e			;aecd
	sbc a,d			;aece
	sub l			;aecf
	sub b			;aed0
	rst 18h			;aed1
	sbc a,d			;aed2
	sub c			;aed3
	rst 18h			;aed4
	sbc a,d			;aed5
	sub e			;aed6
	rst 18h			;aed7
	sub a			;aed8
	sub (hl)			;aed9
	sbc a,d			;aeda
	sub e			;aedb
	sub b			;aedc
	out (0dfh),a		;aedd
	adc a,a			;aedf
	sbc a,d			;aee0
	adc a,l			;aee1
	sbc a,e			;aee2
	sub (hl)			;aee3
	sbc a,d			;aee4
	sub c			;aee5
	sbc a,e			;aee6
	sub b			;aee7
	rst 18h			;aee8
	sbc a,(hl)			;aee9
	sub e			;aeea
	rst 18h			;aeeb
	sub (hl)			;aeec
	sub c			;aeed
	adc a,h			;aeee
	adc a,e			;aeef
	sbc a,(hl)			;aef0
	sub c			;aef1
	adc a,e			;aef2
	sbc a,d			;aef3
	rst 18h			;aef4
	adc a,h			;aef5
	adc a,d			;aef6
	rst 18h			;aef7
	adc a,c			;aef8
	sub b			;aef9
	sub e			;aefa
	adc a,d			;aefb
	sub c			;aefc
	adc a,e			;aefd
	sbc a,(hl)			;aefe
	sbc a,e			;aeff
	pop de			;af00
	push af			;af01
	adc a,e			;af02
	sbc a,d			;af03
	rst 18h			;af04
	sub (hl)			;af05
	sub d			;af06
	sub (hl)			;af07
	adc a,e			;af08
	sbc a,(hl)			;af09
	pop de			;af0a
	push af			;af0b
	cp d			;af0c
	sub e			;af0d
	rst 18h			;af0e
	sbc a,e			;af0f
	sub (hl)			;af10
	sub b			;af11
	adc a,h			;af12
	rst 18h			;af13
	adc a,e			;af14
	sbc a,d			;af15
	rst 18h			;af16
	sub (hl)			;af17
	sub d			;af18
	sub (hl)			;af19
	adc a,e			;af1a
	sbc a,(hl)			;af1b
	out (0dfh),a		;af1c
	add a,(hl)			;af1e
	rst 18h			;af1f
	adc a,h			;af20
	adc a,d			;af21
	rst 18h			;af22
	sbc a,c			;af23
	adc a,d			;af24
	sbc a,d			;af25
	adc a,l			;af26
	add a,l			;af27
	sbc a,(hl)			;af28
	rst 18h			;af29
	sub e			;af2a
	sbc a,(hl)			;af2b
	sub c			;af2c
	add a,l			;af2d
	sbc a,(hl)			;af2e
	rst 18h			;af2f
	sub e			;af30
	sbc a,(hl)			;af31
	rst 18h			;af32
	sbc a,l			;af33
	sub b			;af34
	sub e			;af35
	sbc a,(hl)			;af36
	rst 18h			;af37
	adc a,a			;af38
	adc a,l			;af39
	sbc a,d			;af3a
	sbc a,h			;af3b
	sub (hl)			;af3c
	adc a,a			;af3d
	sub (hl)			;af3e
	sbc a,h			;af3f
	sub (hl)			;af40
	sub b			;af41
	rst 18h			;af42
	sbc a,(hl)			;af43
	sbc a,l			;af44
	sbc a,(hl)			;af45
	sub l			;af46
	sub b			;af47
	pop de			;af48
	push af			;af49
	or e			;af4a
	sbc a,(hl)			;af4b
	rst 18h			;af4c
	sbc a,e			;af4d
	sbc a,d			;af4e
	adc a,h			;af4f
	sbc a,e			;af50
	sub (hl)			;af51
	sbc a,h			;af52
	sub a			;af53
	sbc a,(hl)			;af54
	rst 18h			;af55
	adc a,a			;af56
	sbc a,(hl)			;af57
	adc a,l			;af58
	sbc a,d			;af59
	sbc a,h			;af5a
	sbc a,d			;af5b
	rst 18h			;af5c
	adc a,l			;af5d
	sub b			;af5e
	sbc a,e			;af5f
	sbc a,d			;af60
	sbc a,(hl)			;af61
	adc a,l			;af62
	rst 18h			;af63
	sbc a,(hl)			;af64
	rst 18h			;af65
	xor e			;af66
	sbc a,d			;af67
	add a,l			;af68
	sbc a,h			;af69
	sbc a,(hl)			;af6a
	adc a,e			;af6b
	sub e			;af6c
	sub (hl)			;af6d
	adc a,a			;af6e
	sub b			;af6f
	sbc a,h			;af70
	sbc a,(hl)			;af71
	out (0dfh),a		;af72
	sub c			;af74
	sbc a,d			;af75
	sbc a,b			;af76
	adc a,l			;af77
	sbc a,(hl)			;af78
	rst 18h			;af79
	adc a,h			;af7a
	sub b			;af7b
	sub d			;af7c
	sbc a,l			;af7d
	adc a,l			;af7e
	sbc a,(hl)			;af7f
	rst 18h			;af80
	sbc a,d			;af81
	sub d			;af82
	adc a,a			;af83
	adc a,d			;af84
	push hl			;af85
	sbc a,(hl)			;af86
	sub c			;af87
	sbc a,e			;af88
	sub b			;af89
	rst 18h			;af8a
	adc a,d			;af8b
	sub c			;af8c
	rst 18h			;af8d
	sbc a,d			;af8e
	adc a,h			;af8f
	sbc a,h			;af90
	adc a,d			;af91
	sbc a,e			;af92
	sub b			;af93
	pop de			;af94
	push af			;af95
	cp d			;af96
	sub e			;af97
	rst 18h			;af98
	sbc a,c			;af99
	adc a,l			;af9a
	ret pe			;af9b
	sub b			;af9c
	rst 18h			;af9d
	sbc a,d			;af9e
	adc a,h			;af9f
	rst 18h			;afa0
	sub e			;afa1
	sbc a,(hl)			;afa2
	rst 18h			;afa3
	adc a,a			;afa4
	sub (hl)			;afa5
	sbc a,d			;afa6
	sub e			;afa7
	rst 18h			;afa8
	sbc a,e			;afa9
	sbc a,d			;afaa
	sub e			;afab
	rst 18h			;afac
	sbc a,d			;afad
	sub c			;afae
	sub b			;afaf
	adc a,l			;afb0
	sub d			;afb1
	sbc a,d			;afb2
	rst 18h			;afb3
	sbc a,d			;afb4
	adc a,h			;afb5
	adc a,(hl)			;afb6
	adc a,d			;afb7
	sbc a,d			;afb8
	sub e			;afb9
	sbc a,d			;afba
	adc a,e			;afbb
	sub b			;afbc
	rst 18h			;afbd
	and (hl)			;afbe
	adc a,d			;afbf
	sub d			;afc0
	rst 18h			;afc1
	or h			;afc2
	sbc a,h			;afc3
	sub (hl)			;afc4
	sub d			;afc5
	sub (hl)			;afc6
	sub e			;afc7
	pop de			;afc8
	push af			;afc9
	xor e			;afca
	sub (hl)			;afcb
	adc a,l			;afcc
	sbc a,(hl)			;afcd
	adc a,h			;afce
	rst 18h			;afcf
	and b			;afd0
	rst 18h			;afd1
	sbc a,(hl)			;afd2
	sub e			;afd3
	rst 18h			;afd4
	sbc a,(hl)			;afd5
	sbc a,b			;afd6
	adc a,d			;afd7
	sbc a,(hl)			;afd8
	pop de			;afd9
	push af			;afda
	or e			;afdb
	sbc a,(hl)			;afdc
	rst 18h			;afdd
	sbc a,h			;afde
	sbc a,(hl)			;afdf
	adc a,h			;afe0
	sbc a,h			;afe1
	sbc a,(hl)			;afe2
	sbc a,e			;afe3
	sbc a,(hl)			;afe4
	rst 18h			;afe5
	sub c			;afe6
	sub b			;afe7
	rst 18h			;afe8
	sbc a,c			;afe9
	sub e			;afea
	adc a,d			;afeb
	add a,(hl)			;afec
	sbc a,d			;afed
	out (0dfh),a		;afee
	sbc a,e			;aff0
	sbc a,d			;aff1
	sub l			;aff2
	sbc a,(hl)			;aff3
	sub c			;aff4
	sbc a,e			;aff5
	sub b			;aff6
	rst 18h			;aff7
	adc a,c			;aff8
	sbc a,d			;aff9
	adc a,l			;affa
	rst 18h			;affb
	adc a,d			;affc
	sub c			;affd
	sbc a,(hl)			;affe
	rst 18h			;afff
	sbc a,b			;b000
	adc a,l			;b001
	sub (hl)			;b002
	sbc a,d			;b003
	adc a,e			;b004
	sbc a,(hl)			;b005
	rst 18h			;b006
	sbc a,(hl)			;b007
	sub e			;b008
	rst 18h			;b009
	sub c			;b00a
	sub b			;b00b
	adc a,l			;b00c
	adc a,e			;b00d
	sbc a,d			;b00e
	push af			;b00f
	cp h			;b010
	sbc a,(hl)			;b011
	sbc a,d			;b012
	adc a,h			;b013
	pop de			;b014
	di			;b015
	call p,09ebch		;b016
	sbc a,d			;b019
	adc a,h			;b01a
	rst 18h			;b01b
	adc a,a			;b01c
	sub b			;b01d
	adc a,l			;b01e
	rst 18h			;b01f
	sbc a,(hl)			;b020
	sbc a,l			;b021
	sub (hl)			;b022
	adc a,h			;b023
	sub d			;b024
	sub b			;b025
	adc a,h			;b026
	rst 18h			;b027
	sbc a,e			;b028
	sbc a,d			;b029
	rst 18h			;b02a
	sbc a,d			;b02b
	adc a,h			;b02c
	adc a,a			;b02d
	sbc a,(hl)			;b02e
	sbc a,h			;b02f
	sub (hl)			;b030
	sub b			;b031
	rst 18h			;b032
	add a,(hl)			;b033
	rst 18h			;b034
	adc a,e			;b035
	sub (hl)			;b036
	sbc a,d			;b037
	sub d			;b038
	adc a,a			;b039
	sub b			;b03a
	rst 18h			;b03b
	sub a			;b03c
	sbc a,(hl)			;b03d
	adc a,h			;b03e
	adc a,e			;b03f
	sbc a,(hl)			;b040
	rst 18h			;b041
	and a			;b042
	sub (hl)			;b043
	sbc a,l			;b044
	sbc a,(hl)			;b045
	sub e			;b046
	sbc a,l			;b047
	jp pe,0dfd3h		;b048
	sbc a,d			;b04b
	sub e			;b04c
	rst 18h			;b04d
	sub (hl)			;b04e
	sub c			;b04f
	sbc a,c			;b050
	sub (hl)			;b051
	sbc a,d			;b052
	adc a,l			;b053
	sub c			;b054
	sub b			;b055
	rst 18h			;b056
	sub d			;b057
	sbc a,(hl)			;b058
	add a,(hl)			;b059
	sbc a,(hl)			;b05a
	pop de			;b05b
	di			;b05c
	call p,0bcf5h		;b05d
	adc a,l			;b060
	adc a,d			;b061
	add a,l			;b062
	sbc a,(hl)			;b063
	adc a,h			;b064
	rst 18h			;b065
	sbc a,e			;b066
	sbc a,d			;b067
	rst 18h			;b068
	sub c			;b069
	adc a,d			;b06a
	sbc a,d			;b06b
	adc a,c			;b06c
	sub b			;b06d
	rst 18h			;b06e
	sbc a,(hl)			;b06f
	rst 18h			;b070
	sub b			;b071
	adc a,e			;b072
	adc a,l			;b073
	sbc a,(hl)			;b074
	rst 18h			;b075
	sbc a,e			;b076
	sub (hl)			;b077
	sub d			;b078
	sbc a,d			;b079
	sub c			;b07a
	adc a,h			;b07b
	sub (hl)			;b07c
	rst 20h			;b07d
	sub c			;b07e
	pop de			;b07f
	di			;b080
	call p,09eb2h		;b081
	adc a,h			;b084
	rst 18h			;b085
	sbc a,(hl)			;b086
	sub a			;b087
	sub b			;b088
	adc a,l			;b089
	sbc a,(hl)			;b08a
	rst 18h			;b08b
	sub c			;b08c
	sub b			;b08d
	adc a,e			;b08e
	sbc a,(hl)			;b08f
	adc a,h			;b090
	rst 18h			;b091
	adc a,(hl)			;b092
	adc a,d			;b093
	sbc a,d			;b094
	rst 18h			;b095
	sbc a,(hl)			;b096
	adc a,h			;b097
	sbc a,h			;b098
	sub (hl)			;b099
	sbc a,d			;b09a
	sub c			;b09b
	sbc a,e			;b09c
	sbc a,d			;b09d
	adc a,h			;b09e
	rst 18h			;b09f
	sbc a,e			;b0a0
	sbc a,d			;b0a1
	sub e			;b0a2
	rst 18h			;b0a3
	adc a,e			;b0a4
	sbc a,d			;b0a5
	sub c			;b0a6
	sbc a,d			;b0a7
	sbc a,l			;b0a8
	adc a,l			;b0a9
	sub b			;b0aa
	adc a,h			;b0ab
	sub b			;b0ac
	rst 18h			;b0ad
	and a			;b0ae
	sub (hl)			;b0af
	sbc a,l			;b0b0
	sbc a,(hl)			;b0b1
	sub e			;b0b2
	sbc a,l			;b0b3
	jp pe,0f3d1h		;b0b4
	call p,0f5f5h		;b0b7
	push af			;b0ba
	cp h			;b0bb
	sub e			;b0bc
	sbc a,(hl)			;b0bd
	adc a,c			;b0be
	sbc a,(hl)			;b0bf
	adc a,h			;b0c0
	rst 18h			;b0c1
	adc a,d			;b0c2
	sub c			;b0c3
	sbc a,(hl)			;b0c4
	rst 18h			;b0c5
	adc a,a			;b0c6
	and 09eh		;b0c7
	rst 18h			;b0c9
	sbc a,d			;b0ca
	sub c			;b0cb
	rst 18h			;b0cc
	sbc a,h			;b0cd
	sbc a,(hl)			;b0ce
	sbc a,e			;b0cf
	sbc a,(hl)			;b0d0
	rst 18h			;b0d1
	sbc a,e			;b0d2
	jp pe,0968bh		;b0d3
	sub e			;b0d6
	pop de			;b0d7
	push af			;b0d8
	or a			;b0d9
	sbc a,(hl)			;b0da
	adc a,h			;b0db
	rst 18h			;b0dc
	sbc a,h			;b0dd
	sub b			;b0de
	sub d			;b0df
	sbc a,d			;b0e0
	adc a,e			;b0e1
	sub (hl)			;b0e2
	sbc a,e			;b0e3
	sub b			;b0e4
	rst 18h			;b0e5
	adc a,d			;b0e6
	sub c			;b0e7
	rst 18h			;b0e8
	sbc a,(hl)			;b0e9
	sbc a,h			;b0ea
	adc a,e			;b0eb
	sub b			;b0ec
	rst 18h			;b0ed
	sbc a,d			;b0ee
	adc a,h			;b0ef
	adc a,e			;b0f0
	and 08fh		;b0f1
	sub (hl)			;b0f3
	sbc a,e			;b0f4
	sub b			;b0f5
	pop de			;b0f6
	push af			;b0f7
	xor l			;b0f8
	sbc a,d			;b0f9
	sub e			;b0fa
	sub e			;b0fb
	sbc a,d			;b0fc
	sub c			;b0fd
	sub b			;b0fe
	adc a,h			;b0ff
	rst 18h			;b100
	sbc a,e			;b101
	sbc a,d			;b102
	rst 18h			;b103
	adc a,a			;b104
	and 09eh		;b105
	adc a,h			;b107
	pop de			;b108
	push af			;b109
	cp e			;b10a
	sbc a,d			;b10b
	rst 18h			;b10c
	adc a,a			;b10d
	adc a,l			;b10e
	sub b			;b10f
	sub c			;b110
	adc a,e			;b111
	sub b			;b112
	out (0dfh),a		;b113
	adc a,h			;b115
	sbc a,d			;b116
	rst 18h			;b117
	add a,(hl)			;b118
	sbc a,d			;b119
	adc a,l			;b11a
	sbc a,b			;b11b
	adc a,d			;b11c
	sbc a,d			;b11d
	rst 18h			;b11e
	sbc a,(hl)			;b11f
	sub c			;b120
	adc a,e			;b121
	sbc a,d			;b122
	rst 18h			;b123
	adc a,e			;b124
	ret pe			;b125
	rst 18h			;b126
	sbc a,d			;b127
	sub e			;b128
	rst 18h			;b129
	sbc a,b			;b12a
	sub (hl)			;b12b
	sbc a,b			;b12c
	sbc a,(hl)			;b12d
	sub c			;b12e
	adc a,e			;b12f
	sbc a,d			;b130
	rst 18h			;b131
	xor h			;b132
	sub (hl)			;b133
	adc a,a			;b134
	sbc a,(hl)			;b135
	sbc a,h			;b136
	pop de			;b137
	rst 18h			;b138
	push af			;b139
	cp (hl)			;b13a
	sub e			;b13b
	rst 18h			;b13c
	adc a,h			;b13d
	adc a,d			;b13e
	adc a,l			;b13f
	rst 18h			;b140
	adc a,h			;b141
	sbc a,d			;b142
	rst 18h			;b143
	sbc a,(hl)			;b144
	sub e			;b145
	add a,l			;b146
	sbc a,(hl)			;b147
	rst 18h			;b148
	sbc a,d			;b149
	sub e			;b14a
	rst 18h			;b14b
	sub (hl)			;b14c
	sub d			;b14d
	adc a,a			;b14e
	sub b			;b14f
	sub c			;b150
	sbc a,d			;b151
	sub c			;b152
	adc a,e			;b153
	sbc a,d			;b154
	rst 18h			;b155
	adc a,c			;b156
	sub b			;b157
	sub e			;b158
	sbc a,h			;b159
	jp pe,0df91h		;b15a
	xor h			;b15d
	sub (hl)			;b15e
	adc a,a			;b15f
	sbc a,(hl)			;b160
	sbc a,h			;b161
	pop de			;b162
	rst 18h			;b163
	push af			;b164
	adc a,e			;b165
	sbc a,d			;b166
	rst 18h			;b167
	adc a,c			;b168
	sbc a,d			;b169
	rst 18h			;b16a
	add a,(hl)			;b16b
	rst 18h			;b16c
	adc a,h			;b16d
	sbc a,d			;b16e
	rst 18h			;b16f
	sbc a,(hl)			;b170
	sbc a,h			;b171
	sbc a,d			;b172
	adc a,l			;b173
	sbc a,h			;b174
	sbc a,(hl)			;b175
	rst 18h			;b176
	sbc a,(hl)			;b177
	sbc a,b			;b178
	adc a,l			;b179
	sbc a,d			;b17a
	adc a,h			;b17b
	sub (hl)			;b17c
	adc a,c			;b17d
	sub b			;b17e
	push af			;b17f
	pop de			;b180
	rst 18h			;b181
	xor h			;b182
	sbc a,d			;b183
	rst 18h			;b184
	sbc a,c			;b185
	sub (hl)			;b186
	sub l			;b187
	sbc a,(hl)			;b188
	rst 18h			;b189
	adc a,d			;b18a
	sub c			;b18b
	rst 18h			;b18c
	sub d			;b18d
	sub b			;b18e
	sub d			;b18f
	sbc a,d			;b190
	sub c			;b191
	adc a,e			;b192
	sub b			;b193
	rst 18h			;b194
	sbc a,d			;b195
	sub c			;b196
	rst 18h			;b197
	sub e			;b198
	sub b			;b199
	adc a,h			;b19a
	rst 18h			;b19b
	sbc a,e			;b19c
	jp pe,0968bh		;b19d
	sub e			;b1a0
	sbc a,d			;b1a1
	adc a,h			;b1a2
	rst 18h			;b1a3
	sbc a,e			;b1a4
	sbc a,d			;b1a5
	sub e			;b1a6
	rst 18h			;b1a7
	adc a,h			;b1a8
	adc a,d			;b1a9
	sbc a,h			;b1aa
	sub (hl)			;b1ab
	sub b			;b1ac
	rst 18h			;b1ad
	adc a,h			;b1ae
	adc a,d			;b1af
	sbc a,d			;b1b0
	sub e			;b1b1
	sub b			;b1b2
	out (0dfh),a		;b1b3
	adc a,a			;b1b5
	sbc a,d			;b1b6
	adc a,l			;b1b7
	sub b			;b1b8
	rst 18h			;b1b9
	sbc a,(hl)			;b1ba
	sub e			;b1bb
	rst 18h			;b1bc
	sub d			;b1bd
	sub b			;b1be
	sub d			;b1bf
	sbc a,d			;b1c0
	sub c			;b1c1
	adc a,e			;b1c2
	sub b			;b1c3
	rst 18h			;b1c4
	adc a,h			;b1c5
	sbc a,d			;b1c6
	rst 18h			;b1c7
	adc a,c			;b1c8
	adc a,d			;b1c9
	sbc a,d			;b1ca
	sub e			;b1cb
	adc a,c			;b1cc
	sbc a,d			;b1cd
	rst 18h			;b1ce
	sub a			;b1cf
	sbc a,(hl)			;b1d0
	sbc a,h			;b1d1
	sub (hl)			;b1d2
	sbc a,(hl)			;b1d3
	rst 18h			;b1d4
	adc a,e			;b1d5
	ret pe			;b1d6
	push af			;b1d7
	pop de			;b1d8
	rst 18h			;b1d9
	or e			;b1da
	sbc a,(hl)			;b1db
	rst 18h			;b1dc
	sbc a,h			;b1dd
	sbc a,d			;b1de
	adc a,h			;b1df
	adc a,e			;b1e0
	sbc a,(hl)			;b1e1
	rst 18h			;b1e2
	sbc a,e			;b1e3
	sbc a,d			;b1e4
	rst 18h			;b1e5
	sbc a,e			;b1e6
	jp pe,0968bh		;b1e7
	sub e			;b1ea
	sbc a,d			;b1eb
	adc a,h			;b1ec
	rst 18h			;b1ed
	sub e			;b1ee
	sub e			;b1ef
	sbc a,(hl)			;b1f0
	sub d			;b1f1
	sbc a,(hl)			;b1f2
	rst 18h			;b1f3
	adc a,h			;b1f4
	adc a,d			;b1f5
	rst 18h			;b1f6
	sbc a,(hl)			;b1f7
	adc a,e			;b1f8
	sbc a,d			;b1f9
	sub c			;b1fa
	sbc a,h			;b1fb
	sub (hl)			;b1fc
	rst 20h			;b1fd
	sub c			;b1fe
	out (0dfh),a		;b1ff
	add a,(hl)			;b201
	rst 18h			;b202
	adc a,h			;b203
	sub (hl)			;b204
	sub c			;b205
	rst 18h			;b206
	adc a,h			;b207
	sub b			;b208
	sub e			;b209
	adc a,e			;b20a
	sbc a,(hl)			;b20b
	adc a,l			;b20c
	adc a,e			;b20d
	sbc a,d			;b20e
	rst 18h			;b20f
	adc a,h			;b210
	sbc a,d			;b211
	rst 18h			;b212
	sub e			;b213
	sub b			;b214
	adc a,h			;b215
	rst 18h			;b216
	sbc a,h			;b217
	sub b			;b218
	sub d			;b219
	sbc a,d			;b21a
	push af			;b21b
	rst 18h			;b21c
	sbc a,(hl)			;b21d
	adc a,a			;b21e
	sbc a,(hl)			;b21f
	adc a,l			;b220
	adc a,e			;b221
	sbc a,(hl)			;b222
	sub c			;b223
	sbc a,e			;b224
	sub b			;b225
	rst 18h			;b226
	sub e			;b227
	sbc a,(hl)			;b228
	adc a,h			;b229
	rst 18h			;b22a
	adc a,a			;b22b
	and 09eh		;b22c
	adc a,h			;b22e
	push af			;b22f
	pop de			;b230
	rst 18h			;b231
	cp (hl)			;b232
	sbc a,h			;b233
	adc a,e			;b234
	sub b			;b235
	rst 18h			;b236
	adc a,h			;b237
	sbc a,d			;b238
	sbc a,b			;b239
	adc a,d			;b23a
	sub (hl)			;b23b
	sbc a,e			;b23c
	sub b			;b23d
	rst 18h			;b23e
	sbc a,d			;b23f
	adc a,l			;b240
	sbc a,d			;b241
	adc a,h			;b242
	rst 18h			;b243
	sbc a,e			;b244
	sbc a,d			;b245
	adc a,c			;b246
	sub b			;b247
	adc a,l			;b248
	sbc a,(hl)			;b249
	sbc a,e			;b24a
	sub b			;b24b
	pop de			;b24c
	rst 18h			;b24d
	push af			;b24e
	pop de			;b24f
	rst 18h			;b250
	cp (hl)			;b251
	sub e			;b252
	rst 18h			;b253
	sub d			;b254
	sub b			;b255
	sub d			;b256
	sbc a,d			;b257
	sub c			;b258
	adc a,e			;b259
	sub b			;b25a
	out (0dfh),a		;b25b
	adc a,e			;b25d
	sbc a,d			;b25e
	rst 18h			;b25f
	adc a,h			;b260
	adc a,d			;b261
	sbc a,d			;b262
	sub e			;b263
	adc a,e			;b264
	sbc a,(hl)			;b265
	rst 18h			;b266
	add a,(hl)			;b267
	rst 18h			;b268
	sbc a,d			;b269
	sub c			;b26a
	adc a,e			;b26b
	adc a,l			;b26c
	sbc a,d			;b26d
	rst 18h			;b26e
	sbc a,d			;b26f
	adc a,h			;b270
	adc a,e			;b271
	sbc a,d			;b272
	adc a,l			;b273
	adc a,e			;b274
	sub b			;b275
	adc a,l			;b276
	sbc a,d			;b277
	adc a,h			;b278
	rst 18h			;b279
	sbc a,h			;b27a
	sbc a,(hl)			;b27b
	sbc a,d			;b27c
	rst 18h			;b27d
	sbc a,(hl)			;b27e
	sub e			;b27f
	rst 18h			;b280
	adc a,h			;b281
	adc a,d			;b282
	sbc a,d			;b283
	sub e			;b284
	sub b			;b285
	out (0dfh),a		;b286
	adc a,(hl)			;b288
	adc a,d			;b289
	sbc a,d			;b28a
	sbc a,e			;b28b
	sbc a,(hl)			;b28c
	sub c			;b28d
	sbc a,e			;b28e
	sub b			;b28f
	rst 18h			;b290
	sub (hl)			;b291
	sub c			;b292
	sbc a,h			;b293
	adc a,l			;b294
	adc a,d			;b295
	adc a,h			;b296
	adc a,e			;b297
	sbc a,(hl)			;b298
	sbc a,e			;b299
	sub b			;b29a
	rst 18h			;b29b
	sbc a,d			;b29c
	sub c			;b29d
	rst 18h			;b29e
	jp (hl)			;b29f
	sub e			;b2a0
	rst 18h			;b2a1
	add a,(hl)			;b2a2
	out (0dfh),a		;b2a3
	sbc a,h			;b2a5
	sub b			;b2a6
	sub d			;b2a7
	sub b			;b2a8
	rst 18h			;b2a9
	sbc a,e			;b2aa
	sub (hl)			;b2ab
	sbc a,h			;b2ac
	sbc a,d			;b2ad
	rst 18h			;b2ae
	sub e			;b2af
	sbc a,(hl)			;b2b0
	rst 18h			;b2b1
	sub d			;b2b2
	sub (hl)			;b2b3
	adc a,e			;b2b4
	sub b			;b2b5
	sub e			;b2b6
	sub b			;b2b7
	sbc a,b			;b2b8
	ret pe			;b2b9
	sbc a,(hl)			;b2ba
	out (0dfh),a		;b2bb
	defb 0ddh,099h,090h	;illegal sequence		;b2bd
	adc a,l			;b2c0
	sub d			;b2c1
	sbc a,(hl)			;b2c2
	sub c			;b2c3
	sbc a,e			;b2c4
	sub b			;b2c5
	rst 18h			;b2c6
	adc a,d			;b2c7
	sub c			;b2c8
	rst 18h			;b2c9
	sub c			;b2ca
	adc a,d			;b2cb
	sbc a,d			;b2cc
	adc a,c			;b2cd
	sub b			;b2ce
	rst 18h			;b2cf
	adc a,c			;b2d0
	sub b			;b2d1
	sub e			;b2d2
	sbc a,h			;b2d3
	jp pe,0dd91h		;b2d4
	pop de			;b2d7
	push af			;b2d8
	or b			;b2d9
	add a,(hl)			;b2da
	sbc a,d			;b2db
	adc a,h			;b2dc
	rst 18h			;b2dd
	adc a,d			;b2de
	sub c			;b2df
	rst 18h			;b2e0
	sbc a,b			;b2e1
	adc a,l			;b2e2
	sub (hl)			;b2e3
	adc a,e			;b2e4
	sub b			;b2e5
	rst 18h			;b2e6
	add a,(hl)			;b2e7
	rst 18h			;b2e8
	adc a,d			;b2e9
	sub c			;b2ea
	rst 18h			;b2eb
	sbc a,d			;b2ec
	adc a,h			;b2ed
	adc a,e			;b2ee
	adc a,l			;b2ef
	adc a,d			;b2f0
	sbc a,d			;b2f1
	sub c			;b2f2
	sbc a,e			;b2f3
	sub b			;b2f4
	out (0dfh),a		;b2f5
	adc a,a			;b2f7
	sub b			;b2f8
	adc a,l			;b2f9
	rst 18h			;b2fa
	sub e			;b2fb
	sub b			;b2fc
	rst 18h			;b2fd
	adc a,(hl)			;b2fe
	adc a,d			;b2ff
	sbc a,d			;b300
	rst 18h			;b301
	xor h			;b302
	sub (hl)			;b303
	adc a,a			;b304
	sbc a,(hl)			;b305
	sbc a,h			;b306
	rst 18h			;b307
	sub a			;b308
	sbc a,(hl)			;b309
	rst 18h			;b30a
	sbc a,e			;b30b
	sbc a,d			;b30c
	sbc a,l			;b30d
	sub (hl)			;b30e
	sbc a,e			;b30f
	sub b			;b310
	rst 18h			;b311
	sbc a,h			;b312
	sub b			;b313
	sub d			;b314
	sbc a,d			;b315
	adc a,l			;b316
	rst 18h			;b317
	sub e			;b318
	sub b			;b319
	adc a,h			;b31a
	rst 18h			;b31b
	sbc a,e			;b31c
	jp pe,0968bh		;b31d
	sub e			;b320
	sbc a,d			;b321
	adc a,h			;b322
	pop de			;b323
	rst 18h			;b324
	xor h			;b325
	sub (hl)			;b326
	rst 18h			;b327
	sub e			;b328
	sbc a,(hl)			;b329
	rst 18h			;b32a
	sub d			;b32b
	sub (hl)			;b32c
	adc a,e			;b32d
	sub b			;b32e
	sub e			;b32f
	sub b			;b330
	sbc a,b			;b331
	ret pe			;b332
	sbc a,(hl)			;b333
	rst 18h			;b334
	sub c			;b335
	sub b			;b336
	rst 18h			;b337
	sbc a,c			;b338
	sbc a,(hl)			;b339
	sub e			;b33a
	sub e			;b33b
	sbc a,(hl)			;b33c
	out (0dfh),a		;b33d
	adc a,h			;b33f
	sbc a,d			;b340
	rst 18h			;b341
	sub a			;b342
	sbc a,(hl)			;b343
	sbc a,l			;b344
	adc a,l			;b345
	jp pe,09cdfh		;b346
	sub b			;b349
	sub c			;b34a
	adc a,c			;b34b
	sbc a,d			;b34c
	adc a,l			;b34d
	adc a,e			;b34e
	sub (hl)			;b34f
	sbc a,e			;b350
	sub b			;b351
	rst 18h			;b352
	sbc a,d			;b353
	sub c			;b354
	rst 18h			;b355
	adc a,c			;b356
	sub b			;b357
	sub e			;b358
	sbc a,h			;b359
	jp pe,0d191h		;b35a
	push af			;b35d
	cp d			;b35e
	sub e			;b35f
	rst 18h			;b360
	adc a,e			;b361
	rst 20h			;b362
	add a,a			;b363
	sub (hl)			;b364
	sbc a,h			;b365
	sub b			;b366
	rst 18h			;b367
	sub a			;b368
	adc a,d			;b369
	sub d			;b36a
	sub b			;b36b
	rst 18h			;b36c
	adc a,(hl)			;b36d
	adc a,d			;b36e
	sbc a,d			;b36f
	sub d			;b370
	sbc a,(hl)			;b371
	rst 18h			;b372
	adc a,e			;b373
	adc a,d			;b374
	adc a,h			;b375
	rst 18h			;b376
	adc a,a			;b377
	adc a,d			;b378
	sub e			;b379
	sub d			;b37a
	sub b			;b37b
	sub c			;b37c
	sbc a,d			;b37d
	adc a,h			;b37e
	pop de			;b37f
	push af			;b380
	or e			;b381
	sbc a,(hl)			;b382
	rst 18h			;b383
	sub d			;b384
	jp pe,09c8ch		;b385
	sbc a,(hl)			;b388
	adc a,l			;b389
	sbc a,(hl)			;b38a
	rst 18h			;b38b
	adc a,e			;b38c
	sbc a,d			;b38d
	rst 18h			;b38e
	adc a,a			;b38f
	adc a,l			;b390
	sub b			;b391
	adc a,e			;b392
	sbc a,d			;b393
	sbc a,b			;b394
	sbc a,d			;b395
	rst 18h			;b396
	sbc a,e			;b397
	sbc a,d			;b398
	sub e			;b399
	rst 18h			;b39a
	sub a			;b39b
	adc a,d			;b39c
	sub d			;b39d
	sub b			;b39e
	pop de			;b39f
	push af			;b3a0
	cp (hl)			;b3a1
	sub c			;b3a2
	adc a,e			;b3a3
	sbc a,d			;b3a4
	rst 18h			;b3a5
	adc a,e			;b3a6
	sub (hl)			;b3a7
	rst 18h			;b3a8
	sbc a,d			;b3a9
	adc a,h			;b3aa
	adc a,e			;b3ab
	jp pe,0a7dfh		;b3ac
	sub (hl)			;b3af
	adc a,d			;b3b0
	adc a,e			;b3b1
	sbc a,d			;b3b2
	sbc a,h			;b3b3
	adc a,d			;b3b4
	adc a,e			;b3b5
	sub e			;b3b6
	sub (hl)			;b3b7
	pop de			;b3b8
	rst 18h			;b3b9
	push af			;b3ba
	sbc a,(hl)			;b3bb
	sub e			;b3bc
	add a,l			;b3bd
	sbc a,(hl)			;b3be
	rst 18h			;b3bf
	sub e			;b3c0
	sbc a,(hl)			;b3c1
	rst 18h			;b3c2
	sub d			;b3c3
	sub (hl)			;b3c4
	adc a,l			;b3c5
	sbc a,(hl)			;b3c6
	sbc a,e			;b3c7
	sbc a,(hl)			;b3c8
	rst 18h			;b3c9
	add a,(hl)			;b3ca
	rst 18h			;b3cb
	sbc a,e			;b3cc
	sub (hl)			;b3cd
	sbc a,h			;b3ce
	sbc a,d			;b3cf
	rst 18h			;b3d0
	defb 0ddh,0edh,0afh	;illegal sequence		;b3d1
	adc a,d			;b3d4
	sbc a,d			;b3d5
	sbc a,e			;b3d6
	sbc a,d			;b3d7
	adc a,h			;b3d8
	rst 18h			;b3d9
	sbc a,d			;b3da
	sub c			;b3db
	sbc a,e			;b3dc
	adc a,d			;b3dd
	sub e			;b3de
	add a,l			;b3df
	sbc a,(hl)			;b3e0
	adc a,l			;b3e1
	rst 18h			;b3e2
	sub d			;b3e3
	sub (hl)			;b3e4
	rst 18h			;b3e5
	sbc a,(hl)			;b3e6
	sub d			;b3e7
	sbc a,(hl)			;b3e8
	adc a,l			;b3e9
	sbc a,b			;b3ea
	sbc a,(hl)			;b3eb
	rst 18h			;b3ec
	adc a,c			;b3ed
	sub (hl)			;b3ee
	sbc a,e			;b3ef
	sbc a,(hl)			;b3f0
	ret nz			;b3f1
	defb 0ddh,0d1h,0f5h	;illegal sequence		;b3f2
	sbc a,d			;b3f5
	add a,a			;b3f6
	sbc a,h			;b3f7
	sub e			;b3f8
	sbc a,(hl)			;b3f9
	sub d			;b3fa
	sbc a,(hl)			;b3fb
	rst 18h			;b3fc
	defb 0ddh,0eeh,0b8h	;illegal sequence		;b3fd
	adc a,l			;b400
	sbc a,(hl)			;b401
	sbc a,h			;b402
	sub (hl)			;b403
	sbc a,(hl)			;b404
	adc a,h			;b405
	out (0dfh),a		;b406
	sub d			;b408
	sub b			;b409
	adc a,l			;b40a
	adc a,e			;b40b
	sbc a,(hl)			;b40c
	sub e			;b40d
	sbc a,0ddh		;b40e
	rst 18h			;b410
	add a,(hl)			;b411
	rst 18h			;b412
	sbc a,h			;b413
	sub b			;b414
	sbc a,b			;b415
	sub (hl)			;b416
	sbc a,d			;b417
	sub c			;b418
	sbc a,e			;b419
	sub b			;b41a
	rst 18h			;b41b
	sbc a,d			;b41c
	sub e			;b41d
	rst 18h			;b41e
	sbc a,h			;b41f
	adc a,d			;b420
	sbc a,d			;b421
	sub c			;b422
	sbc a,h			;b423
	sub b			;b424
	rst 18h			;b425
	sbc a,(hl)			;b426
	push hl			;b427
	sbc a,(hl)			;b428
	sbc a,e			;b429
	sbc a,d			;b42a
	push bc			;b42b
	rst 18h			;b42c
	defb 0ddh,0abh,090h	;illegal sequence		;b42d
	sub d			;b430
	sbc a,(hl)			;b431
	rst 18h			;b432
	sub d			;b433
	sub (hl)			;b434
	rst 18h			;b435
	sub d			;b436
	jp pe,09c8ch		;b437
	sbc a,(hl)			;b43a
	adc a,l			;b43b
	sbc a,(hl)			;b43c
	rst 18h			;b43d
	sbc a,(hl)			;b43e
	rst 18h			;b43f
	sbc a,h			;b440
	sbc a,(hl)			;b441
	sub d			;b442
	sbc a,l			;b443
	sub (hl)			;b444
	sub b			;b445
	defb 0ddh,0dfh,092h	;illegal sequence		;b446
	sbc a,(hl)			;b449
	adc a,l			;b44a
	sbc a,h			;b44b
	sub a			;b44c
	jp pe,09b91h		;b44d
	sub b			;b450
	adc a,h			;b451
	sbc a,d			;b452
	rst 18h			;b453
	sbc a,(hl)			;b454
	rst 18h			;b455
	sbc a,h			;b456
	sub b			;b457
	sub c			;b458
	adc a,e			;b459
	sub (hl)			;b45a
	sub c			;b45b
	adc a,d			;b45c
	sbc a,(hl)			;b45d
	sbc a,h			;b45e
	sub (hl)			;b45f
	rst 20h			;b460
	sub c			;b461
	pop de			;b462
	push af			;b463
	sub c			;b464
	sbc a,d			;b465
	sbc a,h			;b466
	sbc a,d			;b467
	adc a,h			;b468
	sub (hl)			;b469
	adc a,e			;b46a
	sbc a,(hl)			;b46b
	rst 18h			;b46c
	adc a,d			;b46d
	sub c			;b46e
	rst 18h			;b46f
	sbc a,e			;b470
	adc a,d			;b471
	sub e			;b472
	sbc a,h			;b473
	sbc a,d			;b474
	rst 18h			;b475
	sbc a,d			;b476
	adc a,h			;b477
	adc a,e			;b478
	ret pe			;b479
	sub d			;b47a
	adc a,d			;b47b
	sub e			;b47c
	sub b			;b47d
	rst 18h			;b47e
	adc a,a			;b47f
	sbc a,(hl)			;b480
	adc a,l			;b481
	sbc a,(hl)			;b482
	rst 18h			;b483
	adc a,(hl)			;b484
	adc a,d			;b485
	sbc a,d			;b486
	rst 18h			;b487
	adc a,e			;b488
	sbc a,d			;b489
	rst 18h			;b48a
	sub a			;b48b
	sbc a,(hl)			;b48c
	sbc a,b			;b48d
	sbc a,(hl)			;b48e
	rst 18h			;b48f
	sbc a,h			;b490
	sbc a,(hl)			;b491
	adc a,h			;b492
	sub b			;b493
	pop de			;b494
	push af			;b495
	or a			;b496
	sbc a,(hl)			;b497
	sbc a,h			;b498
	sbc a,d			;b499
	adc a,h			;b49a
	rst 18h			;b49b
	adc a,d			;b49c
	sub c			;b49d
	rst 18h			;b49e
	adc a,a			;b49f
	sbc a,(hl)			;b4a0
	adc a,l			;b4a1
	rst 18h			;b4a2
	sbc a,e			;b4a3
	sbc a,d			;b4a4
	rst 18h			;b4a5
	adc a,e			;b4a6
	sbc a,(hl)			;b4a7
	adc a,a			;b4a8
	sub b			;b4a9
	sub c			;b4aa
	sbc a,d			;b4ab
	adc a,h			;b4ac
	rst 18h			;b4ad
	sbc a,h			;b4ae
	sub b			;b4af
	sub c			;b4b0
	rst 18h			;b4b1
	sub e			;b4b2
	sbc a,(hl)			;b4b3
	rst 18h			;b4b4
	sbc a,h			;b4b5
	sbc a,d			;b4b6
	adc a,l			;b4b7
	sbc a,(hl)			;b4b8
	pop de			;b4b9
	rst 18h			;b4ba
	push af			;b4bb
	xor e			;b4bc
	sbc a,d			;b4bd
	rst 18h			;b4be
	adc a,e			;b4bf
	sbc a,(hl)			;b4c0
	adc a,a			;b4c1
	sbc a,(hl)			;b4c2
	adc a,h			;b4c3
	rst 18h			;b4c4
	sub e			;b4c5
	sub b			;b4c6
	adc a,h			;b4c7
	rst 18h			;b4c8
	sub b			;b4c9
	sub (hl)			;b4ca
	sbc a,e			;b4cb
	sub b			;b4cc
	adc a,h			;b4cd
	rst 18h			;b4ce
	sbc a,h			;b4cf
	sub b			;b4d0
	sub c			;b4d1
	rst 18h			;b4d2
	and b			;b4d3
	pop de			;b4d4
	push af			;b4d5
	xor h			;b4d6
	sub (hl)			;b4d7
	sbc a,d			;b4d8
	sub c			;b4d9
	adc a,e			;b4da
	sbc a,d			;b4db
	adc a,h			;b4dc
	rst 18h			;b4dd
	adc a,(hl)			;b4de
	adc a,d			;b4df
	sbc a,d			;b4e0
	rst 18h			;b4e1
	sub e			;b4e2
	sbc a,(hl)			;b4e3
	rst 18h			;b4e4
	sbc a,c			;b4e5
	adc a,d			;b4e6
	sbc a,d			;b4e7
	adc a,l			;b4e8
	add a,l			;b4e9
	sbc a,(hl)			;b4ea
	rst 18h			;b4eb
	adc a,e			;b4ec
	sbc a,d			;b4ed
	rst 18h			;b4ee
	sub (hl)			;b4ef
	sub c			;b4f0
	adc a,c			;b4f1
	sbc a,(hl)			;b4f2
	sbc a,e			;b4f3
	sbc a,d			;b4f4
	pop de			;b4f5
	push af			;b4f6
	xor c			;b4f7
	sbc a,(hl)			;b4f8
	sbc a,h			;b4f9
	ret pe			;b4fa
	sbc a,(hl)			;b4fb
	adc a,h			;b4fc
	rst 18h			;b4fd
	and b			;b4fe
	rst 18h			;b4ff
	sbc a,d			;b500
	sub c			;b501
	rst 18h			;b502
	sbc a,d			;b503
	sub e			;b504
	rst 18h			;b505
	adc a,h			;b506
	adc a,d			;b507
	sbc a,d			;b508
	sub e			;b509
	sub b			;b50a
	pop de			;b50b
	push af			;b50c
	xor h			;b50d
	sub (hl)			;b50e
	sub c			;b50f
	rst 18h			;b510
	sbc a,h			;b511
	sub b			;b512
	sub c			;b513
	adc a,e			;b514
	sbc a,d			;b515
	sub c			;b516
	sub (hl)			;b517
	sbc a,e			;b518
	sub b			;b519
	out (0dfh),a		;b51a
	sbc a,d			;b51c
	sub e			;b51d
	rst 18h			;b51e
	sbc a,c			;b51f
	adc a,l			;b520
	sbc a,(hl)			;b521
	adc a,h			;b522
	sbc a,h			;b523
	sub b			;b524
	rst 18h			;b525
	adc a,h			;b526
	sbc a,d			;b527
	rst 18h			;b528
	adc a,a			;b529
	adc a,d			;b52a
	sub e			;b52b
	adc a,c			;b52c
	sbc a,d			;b52d
	adc a,l			;b52e
	sub (hl)			;b52f
	add a,l			;b530
	sbc a,(hl)			;b531
	pop de			;b532
	push af			;b533
	xor d			;b534
	sub c			;b535
	rst 18h			;b536
	adc a,h			;b537
	adc a,d			;b538
	sbc a,(hl)			;b539
	adc a,c			;b53a
	sbc a,d			;b53b
	rst 18h			;b53c
	sbc a,h			;b53d
	sbc a,(hl)			;b53e
	sub c			;b53f
	adc a,e			;b540
	sub b			;b541
	rst 18h			;b542
	adc a,e			;b543
	sbc a,d			;b544
	rst 18h			;b545
	sbc a,(hl)			;b546
	adc a,e			;b547
	adc a,l			;b548
	sbc a,(hl)			;b549
	sbc a,d			;b54a
	pop de			;b54b
	push af			;b54c
	cp d			;b54d
	sub e			;b54e
	rst 18h			;b54f
	sub a			;b550
	sub (hl)			;b551
	adc a,a			;b552
	sub c			;b553
	rst 20h			;b554
	adc a,e			;b555
	sub (hl)			;b556
	sbc a,h			;b557
	sub b			;b558
	rst 18h			;b559
	sbc a,h			;b55a
	sbc a,(hl)			;b55b
	sub c			;b55c
	adc a,e			;b55d
	sub b			;b55e
	rst 18h			;b55f
	sbc a,e			;b560
	sbc a,d			;b561
	rst 18h			;b562
	sub e			;b563
	sbc a,(hl)			;b564
	adc a,h			;b565
	rst 18h			;b566
	adc a,a			;b567
	sub (hl)			;b568
	sbc a,d			;b569
	sbc a,e			;b56a
	adc a,l			;b56b
	sbc a,(hl)			;b56c
	adc a,h			;b56d
	rst 18h			;b56e
	adc a,h			;b56f
	sbc a,d			;b570
	rst 18h			;b571
	sub a			;b572
	sbc a,(hl)			;b573
	rst 18h			;b574
	sbc a,(hl)			;b575
	adc a,a			;b576
	sub b			;b577
	sbc a,e			;b578
	sbc a,d			;b579
	adc a,l			;b57a
	sbc a,(hl)			;b57b
	sbc a,e			;b57c
	sub b			;b57d
	rst 18h			;b57e
	sbc a,e			;b57f
	sbc a,d			;b580
	rst 18h			;b581
	adc a,e			;b582
	ret pe			;b583
	pop de			;b584
	di			;b585
	call p,09aabh		;b586
	rst 18h			;b589
	sub a			;b58a
	sbc a,(hl)			;b58b
	adc a,h			;b58c
	rst 18h			;b58d
	adc a,e			;b58e
	adc a,l			;b58f
	sbc a,(hl)			;b590
	sub c			;b591
	adc a,h			;b592
	sbc a,c			;b593
	sub b			;b594
	adc a,l			;b595
	sub d			;b596
	sbc a,(hl)			;b597
	sbc a,e			;b598
	sub b			;b599
	rst 18h			;b59a
	sbc a,d			;b59b
	sub c			;b59c
	rst 18h			;b59d
	sub b			;b59e
	adc a,e			;b59f
	adc a,l			;b5a0
	sbc a,(hl)			;b5a1
	rst 18h			;b5a2
	sbc a,e			;b5a3
	sbc a,d			;b5a4
	rst 18h			;b5a5
	sub e			;b5a6
	sbc a,(hl)			;b5a7
	adc a,h			;b5a8
	rst 18h			;b5a9
	adc a,l			;b5aa
	sub b			;b5ab
	sbc a,h			;b5ac
	sbc a,(hl)			;b5ad
	adc a,h			;b5ae
	rst 18h			;b5af
	adc a,(hl)			;b5b0
	adc a,d			;b5b1
	sbc a,d			;b5b2
	rst 18h			;b5b3
	sbc a,(hl)			;b5b4
	sbc a,e			;b5b5
	sub b			;b5b6
	adc a,l			;b5b7
	sub c			;b5b8
	sbc a,(hl)			;b5b9
	sub c			;b5ba
	rst 18h			;b5bb
	sbc a,d			;b5bc
	sub e			;b5bd
	rst 18h			;b5be
	sub e			;b5bf
	adc a,d			;b5c0
	sbc a,b			;b5c1
	sbc a,(hl)			;b5c2
	adc a,l			;b5c3
	pop de			;b5c4
	push af			;b5c5
	and l			;b5c6
	add a,(hl)			;b5c7
	sbc a,(hl)			;b5c8
	sub c			;b5c9
	add a,(hl)			;b5ca
	sbc a,(hl)			;b5cb
	rst 18h			;b5cc
	sbc a,h			;b5cd
	sub b			;b5ce
	sbc a,l			;b5cf
	adc a,l			;b5d0
	sbc a,(hl)			;b5d1
	rst 18h			;b5d2
	adc a,c			;b5d3
	sub (hl)			;b5d4
	sbc a,e			;b5d5
	sbc a,(hl)			;b5d6
	rst 18h			;b5d7
	sbc a,(hl)			;b5d8
	sub c			;b5d9
	adc a,e			;b5da
	sbc a,d			;b5db
	rst 18h			;b5dc
	adc a,e			;b5dd
	ret pe			;b5de
	out (0dfh),a		;b5df
	add a,(hl)			;b5e1
	rst 18h			;b5e2
	adc a,e			;b5e3
	adc a,l			;b5e4
	sbc a,(hl)			;b5e5
	adc a,h			;b5e6
	rst 18h			;b5e7
	sbc a,(hl)			;b5e8
	sbc a,h			;b5e9
	sbc a,d			;b5ea
	adc a,a			;b5eb
	adc a,e			;b5ec
	sbc a,(hl)			;b5ed
	adc a,l			;b5ee
	rst 18h			;b5ef
	adc a,e			;b5f0
	adc a,d			;b5f1
	rst 18h			;b5f2
	sbc a,c			;b5f3
	sub e			;b5f4
	sub b			;b5f5
	adc a,l			;b5f6
	rst 18h			;b5f7
	adc a,e			;b5f8
	sbc a,d			;b5f9
	rst 18h			;b5fa
	sbc a,d			;b5fb
	sub c			;b5fc
	adc a,e			;b5fd
	adc a,l			;b5fe
	sbc a,d			;b5ff
	sbc a,b			;b600
	sbc a,(hl)			;b601
	rst 18h			;b602
	adc a,d			;b603
	sub c			;b604
	rst 18h			;b605
	sub c			;b606
	adc a,d			;b607
	sbc a,d			;b608
	adc a,c			;b609
	sub b			;b60a
	rst 18h			;b60b
	sbc a,c			;b60c
	sub (hl)			;b60d
	sub e			;b60e
	adc a,e			;b60f
	adc a,l			;b610
	sub b			;b611
	out (0dfh),a		;b612
	adc a,e			;b614
	adc a,l			;b615
	sbc a,(hl)			;b616
	adc a,h			;b617
	rst 18h			;b618
	sub e			;b619
	sub b			;b61a
	rst 18h			;b61b
	sbc a,h			;b61c
	adc a,d			;b61d
	sbc a,(hl)			;b61e
	sub e			;b61f
	rst 18h			;b620
	adc a,c			;b621
	adc a,d			;b622
	sbc a,d			;b623
	sub e			;b624
	adc a,c			;b625
	sbc a,d			;b626
	rst 18h			;b627
	sbc a,(hl)			;b628
	rst 18h			;b629
	adc a,h			;b62a
	adc a,d			;b62b
	rst 18h			;b62c
	sbc a,d			;b62d
	adc a,h			;b62e
	adc a,e			;b62f
	sbc a,(hl)			;b630
	sbc a,e			;b631
	sub b			;b632
	rst 18h			;b633
	adc a,a			;b634
	jp (hl)			;b635
	adc a,e			;b636
	adc a,l			;b637
	sbc a,d			;b638
	sub b			;b639
	pop de			;b63a
	push af			;b63b
	or e			;b63c
	sub b			;b63d
	adc a,h			;b63e
	rst 18h			;b63f
	adc a,e			;b640
	sbc a,(hl)			;b641
	adc a,a			;b642
	sub b			;b643
	sub c			;b644
	sbc a,d			;b645
	adc a,h			;b646
	rst 18h			;b647
	adc a,h			;b648
	sbc a,d			;b649
	rst 18h			;b64a
	sbc a,e			;b64b
	sbc a,d			;b64c
	adc a,l			;b64d
	adc a,l			;b64e
	sub (hl)			;b64f
	adc a,e			;b650
	sbc a,d			;b651
	sub c			;b652
	pop de			;b653
	push af			;b654
	rst 18h			;b655
	xor c			;b656
	sbc a,(hl)			;b657
	add a,(hl)			;b658
	sbc a,(hl)			;b659
	pop de			;b65a
	pop de			;b65b
	pop de			;b65c
	rst 18h			;b65d
	jp (hl)			;b65e
	adc a,h			;b65f
	sbc a,d			;b660
	rst 18h			;b661
	adc a,a			;b662
	sbc a,(hl)			;b663
	adc a,l			;b664
	sbc a,d			;b665
	sbc a,h			;b666
	sbc a,d			;b667
	pop de			;b668
	pop de			;b669
	pop de			;b66a
	rst 18h			;b66b
	xor 09ah		;b66c
	adc a,h			;b66e
	rst 18h			;b66f
	or h			;b670
	adc a,d			;b671
	sub (hl)			;b672
	sub e			;b673
	sub e			;b674
	sbc a,0dfh		;b675
	and (hl)			;b677
	rst 18h			;b678
	adc a,h			;b679
	sbc a,d			;b67a
	rst 18h			;b67b
	sbc a,d			;b67c
	adc a,h			;b67d
	adc a,e			;b67e
	jp pe,09edfh		;b67f
	sbc a,h			;b682
	sbc a,d			;b683
	adc a,l			;b684
	sbc a,h			;b685
	sbc a,(hl)			;b686
	sub c			;b687
	sbc a,e			;b688
	sub b			;b689
	pop de			;b68a
	pop de			;b68b
	pop de			;b68c
	rst 18h			;b68d
	push af			;b68e
	xor c			;b68f
	sbc a,d			;b690
	sub c			;b691
	pop de			;b692
	pop de			;b693
	pop de			;b694
	rst 18h			;b695
	cp (hl)			;b696
	sbc a,(hl)			;b697
	sbc a,(hl)			;b698
	adc a,l			;b699
	sub h			;b69a
	pop de			;b69b
	pop de			;b69c
	pop de			;b69d
	rst 18h			;b69e
	xor c			;b69f
	sbc a,d			;b6a0
	sub c			;b6a1
	push af			;b6a2
	sub (hl)			;b6a3
	sub c			;b6a4
	adc a,h			;b6a5
	sub (hl)			;b6a6
	adc a,h			;b6a7
	adc a,e			;b6a8
	sbc a,d			;b6a9
	rst 18h			;b6aa
	sbc a,d			;b6ab
	sub c			;b6ac
	rst 18h			;b6ad
	adc a,(hl)			;b6ae
	adc a,d			;b6af
	sbc a,d			;b6b0
	rst 18h			;b6b1
	sub e			;b6b2
	sbc a,d			;b6b3
	rst 18h			;b6b4
	adc a,h			;b6b5
	sub (hl)			;b6b6
	sbc a,b			;b6b7
	sbc a,(hl)			;b6b8
	adc a,h			;b6b9
	pop de			;b6ba
	push af			;b6bb
	cp e			;b6bc
	sbc a,d			;b6bd
	adc a,h			;b6be
	sub b			;b6bf
	add a,(hl)			;b6c0
	sbc a,d			;b6c1
	sub c			;b6c2
	sbc a,e			;b6c3
	sub b			;b6c4
	rst 18h			;b6c5
	sbc a,(hl)			;b6c6
	rst 18h			;b6c7
	or h			;b6c8
	adc a,d			;b6c9
	sub (hl)			;b6ca
	sub e			;b6cb
	sub e			;b6cc
	out (0dfh),a		;b6cd
	adc a,c			;b6cf
	adc a,d			;b6d0
	sbc a,d			;b6d1
	sub e			;b6d2
	adc a,c			;b6d3
	sbc a,d			;b6d4
	adc a,h			;b6d5
	rst 18h			;b6d6
	sbc a,(hl)			;b6d7
	rst 18h			;b6d8
	sub e			;b6d9
	sub b			;b6da
	adc a,h			;b6db
	rst 18h			;b6dc
	sub a			;b6dd
	adc a,d			;b6de
	sub d			;b6df
	sub b			;b6e0
	adc a,h			;b6e1
	pop de			;b6e2
	jp p,08cf5h		;b6e3
	sbc a,d			;b6e6
	rst 18h			;b6e7
	sbc a,e			;b6e8
	sub (hl)			;b6e9
	adc a,l			;b6ea
	sub (hl)			;b6eb
	sbc a,b			;b6ec
	sbc a,d			;b6ed
	rst 18h			;b6ee
	sub a			;b6ef
	sbc a,(hl)			;b6f0
	sbc a,h			;b6f1
	sub (hl)			;b6f2
	sbc a,(hl)			;b6f3
	rst 18h			;b6f4
	sub e			;b6f5
	sbc a,(hl)			;b6f6
	rst 18h			;b6f7
	sub d			;b6f8
	sub b			;b6f9
	sub c			;b6fa
	adc a,e			;b6fb
	sbc a,(hl)			;b6fc
	push hl			;b6fd
	sbc a,(hl)			;b6fe
	rst 18h			;b6ff
	add a,(hl)			;b700
	rst 18h			;b701
	adc a,e			;b702
	sbc a,d			;b703
	rst 18h			;b704
	sbc a,b			;b705
	adc a,d			;b706
	ret pe			;b707
	sbc a,(hl)			;b708
	rst 18h			;b709
	adc a,a			;b70a
	sub b			;b70b
	adc a,l			;b70c
	rst 18h			;b70d
	adc a,h			;b70e
	sbc a,d			;b70f
	sub c			;b710
	sbc a,e			;b711
	sbc a,d			;b712
	adc a,l			;b713
	sub b			;b714
	adc a,h			;b715
	rst 18h			;b716
	add a,(hl)			;b717
	rst 18h			;b718
	sbc a,h			;b719
	sbc a,(hl)			;b71a
	sub d			;b71b
	sub (hl)			;b71c
	sub c			;b71d
	sub b			;b71e
	adc a,h			;b71f
	pop de			;b720
	di			;b721
	call p,08abch		;b722
	sbc a,(hl)			;b725
	sub c			;b726
	sbc a,e			;b727
	sub b			;b728
	rst 18h			;b729
	adc a,e			;b72a
	sbc a,d			;b72b
	rst 18h			;b72c
	adc a,c			;b72d
	sbc a,d			;b72e
	rst 18h			;b72f
	sbc a,d			;b730
	sub c			;b731
	sbc a,h			;b732
	sbc a,(hl)			;b733
	sub d			;b734
	sub (hl)			;b735
	sub c			;b736
	sbc a,(hl)			;b737
	sbc a,e			;b738
	sub b			;b739
	out (0dfh),a		;b73a
	adc a,c			;b73c
	adc a,d			;b73d
	sbc a,d			;b73e
	sub e			;b73f
	adc a,c			;b740
	sbc a,d			;b741
	rst 18h			;b742
	sbc a,h			;b743
	sub b			;b744
	sub c			;b745
	rst 18h			;b746
	sub e			;b747
	sub b			;b748
	adc a,h			;b749
	rst 18h			;b74a
	adc a,h			;b74b
	adc a,d			;b74c
	add a,(hl)			;b74d
	sub b			;b74e
	adc a,h			;b74f
	pop de			;b750
	push af			;b751
	push af			;b752
	xor h			;b753
	sub (hl)			;b754
	sub c			;b755
	rst 18h			;b756
	sub e			;b757
	sbc a,(hl)			;b758
	rst 18h			;b759
	sbc a,(hl)			;b75a
	add a,(hl)			;b75b
	adc a,d			;b75c
	sbc a,e			;b75d
	sbc a,(hl)			;b75e
	rst 18h			;b75f
	sbc a,e			;b760
	sbc a,d			;b761
	rst 18h			;b762
	or h			;b763
	adc a,d			;b764
	sub (hl)			;b765
	sub e			;b766
	sub e			;b767
	rst 18h			;b768
	adc a,h			;b769
	sbc a,d			;b76a
	adc a,l			;b76b
	ret pe			;b76c
	sbc a,(hl)			;b76d
	rst 18h			;b76e
	adc a,d			;b76f
	sub c			;b770
	sbc a,(hl)			;b771
	rst 18h			;b772
	sub e			;b773
	sub b			;b774
	sbc a,h			;b775
	adc a,d			;b776
	adc a,l			;b777
	sbc a,(hl)			;b778
	pop de			;b779
	push af			;b77a
	xor c			;b77b
	sbc a,(hl)			;b77c
	sbc a,b			;b77d
	sbc a,(hl)			;b77e
	adc a,h			;b77f
	rst 18h			;b780
	adc a,d			;b781
	sub c			;b782
	rst 18h			;b783
	adc a,l			;b784
	sbc a,(hl)			;b785
	adc a,e			;b786
	sub b			;b787
	rst 18h			;b788
	add a,(hl)			;b789
	rst 18h			;b78a
	sub e			;b78b
	adc a,d			;b78c
	sbc a,d			;b78d
	sbc a,b			;b78e
	sub b			;b78f
	rst 18h			;b790
	adc a,c			;b791
	adc a,d			;b792
	sbc a,d			;b793
	sub e			;b794
	adc a,c			;b795
	sbc a,d			;b796
	adc a,h			;b797
	rst 18h			;b798
	sbc a,(hl)			;b799
	sbc a,l			;b79a
	adc a,d			;b79b
	adc a,l			;b79c
	adc a,l			;b79d
	sub (hl)			;b79e
	sbc a,e			;b79f
	sub b			;b7a0
	pop de			;b7a1
	push af			;b7a2
	push af			;b7a3
	cp b			;b7a4
	adc a,d			;b7a5
	sbc a,(hl)			;b7a6
	adc a,l			;b7a7
	sbc a,e			;b7a8
	sbc a,(hl)			;b7a9
	sub c			;b7aa
	sbc a,e			;b7ab
	sub b			;b7ac
	rst 18h			;b7ad
	sbc a,d			;b7ae
	sub e			;b7af
	rst 18h			;b7b0
	adc a,a			;b7b1
	sbc a,(hl)			;b7b2
	adc a,h			;b7b3
	sub b			;b7b4
	rst 18h			;b7b5
	sbc a,(hl)			;b7b6
	sub e			;b7b7
	rst 18h			;b7b8
	sub c			;b7b9
	sub b			;b7ba
	adc a,l			;b7bb
	adc a,e			;b7bc
	sbc a,d			;b7bd
	rst 18h			;b7be
	adc a,h			;b7bf
	sbc a,d			;b7c0
	rst 18h			;b7c1
	sbc a,d			;b7c2
	sub c			;b7c3
	sbc a,h			;b7c4
	adc a,d			;b7c5
	sbc a,d			;b7c6
	sub c			;b7c7
	adc a,e			;b7c8
	adc a,l			;b7c9
	sbc a,(hl)			;b7ca
	rst 18h			;b7cb
	or a			;b7cc
	adc a,d			;b7cd
	sub (hl)			;b7ce
	adc a,e			;b7cf
	add a,l			;b7d0
	sub (hl)			;b7d1
	sub e			;b7d2
	sub b			;b7d3
	adc a,a			;b7d4
	sub b			;b7d5
	sbc a,h			;b7d6
	sub a			;b7d7
	adc a,e			;b7d8
	sub e			;b7d9
	sub (hl)			;b7da
	pop de			;b7db
	rst 18h			;b7dc
	push af			;b7dd
	or e			;b7de
	sub b			;b7df
	rst 18h			;b7e0
	sub (hl)			;b7e1
	sub c			;b7e2
	adc a,e			;b7e3
	sbc a,d			;b7e4
	sub c			;b7e5
	adc a,e			;b7e6
	sbc a,(hl)			;b7e7
	adc a,h			;b7e8
	out (0dfh),a		;b7e9
	adc a,a			;b7eb
	sbc a,d			;b7ec
	adc a,l			;b7ed
	sub b			;b7ee
	rst 18h			;b7ef
	sbc a,d			;b7f0
	sub e			;b7f1
	rst 18h			;b7f2
	sbc a,b			;b7f3
	adc a,l			;b7f4
	sbc a,(hl)			;b7f5
	sub c			;b7f6
	rst 18h			;b7f7
	or a			;b7f8
	adc a,d			;b7f9
	sub (hl)			;b7fa
	adc a,e			;b7fb
	add a,l			;b7fc
	sub (hl)			;b7fd
	sub e			;b7fe
	sub b			;b7ff
	adc a,a			;b800
	sub b			;b801
	sbc a,h			;b802
	sub a			;b803
	adc a,e			;b804
	sub e			;b805
	sub (hl)			;b806
	rst 18h			;b807
	adc a,e			;b808
	sbc a,d			;b809
	rst 18h			;b80a
	sbc a,(hl)			;b80b
	sub e			;b80c
	sbc a,h			;b80d
	sbc a,(hl)			;b80e
	sub c			;b80f
	add a,l			;b810
	sbc a,(hl)			;b811
	push af			;b812
	pop de			;b813
	rst 18h			;b814
	xor e			;b815
	sbc a,d			;b816
	rst 18h			;b817
	sbc a,d			;b818
	adc a,h			;b819
	sbc a,h			;b81a
	adc a,d			;b81b
	sbc a,e			;b81c
	sbc a,(hl)			;b81d
	adc a,h			;b81e
	rst 18h			;b81f
	sbc a,h			;b820
	sub b			;b821
	sub c			;b822
	rst 18h			;b823
	sbc a,d			;b824
	sub e			;b825
	rst 18h			;b826
	sbc a,d			;b827
	adc a,h			;b828
	adc a,a			;b829
	sbc a,d			;b82a
	sub l			;b82b
	sub b			;b82c
	pop de			;b82d
	rst 18h			;b82e
	cp d			;b82f
	sub e			;b830
	rst 18h			;b831
	sbc a,e			;b832
	sub (hl)			;b833
	sub b			;b834
	adc a,h			;b835
	rst 18h			;b836
	adc a,h			;b837
	sbc a,d			;b838
	rst 18h			;b839
	adc a,c			;b83a
	sbc a,d			;b83b
	rst 18h			;b83c
	adc a,l			;b83d
	sbc a,d			;b83e
	sbc a,c			;b83f
	sub e			;b840
	sbc a,d			;b841
	sub l			;b842
	sbc a,(hl)			;b843
	sbc a,e			;b844
	sub b			;b845
	rst 18h			;b846
	add a,(hl)			;b847
	rst 18h			;b848
	adc a,(hl)			;b849
	adc a,d			;b84a
	sbc a,d			;b84b
	sbc a,e			;b84c
	sbc a,(hl)			;b84d
	rst 18h			;b84e
	sbc a,e			;b84f
	sbc a,d			;b850
	adc a,h			;b851
	sbc a,h			;b852
	sub b			;b853
	sub c			;b854
	sbc a,h			;b855
	sbc a,d			;b856
	adc a,l			;b857
	adc a,e			;b858
	sbc a,(hl)			;b859
	sbc a,e			;b85a
	sub b			;b85b
	pop de			;b85c
	push af			;b85d
	cp e			;b85e
	sbc a,d			;b85f
	rst 18h			;b860
	adc a,d			;b861
	sub c			;b862
	rst 18h			;b863
	adc a,e			;b864
	adc a,l			;b865
	sbc a,d			;b866
	sub d			;b867
	sbc a,d			;b868
	sub c			;b869
	sbc a,e			;b86a
	sub b			;b86b
	rst 18h			;b86c
	sub d			;b86d
	sbc a,(hl)			;b86e
	sub c			;b86f
	sbc a,e			;b870
	sub b			;b871
	sbc a,l			;b872
	sub e			;b873
	sbc a,d			;b874
	rst 18h			;b875
	sub a			;b876
	sbc a,(hl)			;b877
	adc a,h			;b878
	rst 18h			;b879
	sbc a,e			;b87a
	sbc a,d			;b87b
	sbc a,h			;b87c
	sbc a,(hl)			;b87d
	adc a,a			;b87e
	sub (hl)			;b87f
	adc a,e			;b880
	sbc a,(hl)			;b881
	sbc a,e			;b882
	sub b			;b883
	rst 18h			;b884
	sbc a,(hl)			;b885
	rst 18h			;b886
	adc a,e			;b887
	sub b			;b888
	sbc a,e			;b889
	sub b			;b88a
	rst 18h			;b88b
	adc a,d			;b88c
	sub c			;b88d
	rst 18h			;b88e
	sub (hl)			;b88f
	sub c			;b890
	sub d			;b891
	sub b			;b892
	adc a,l			;b893
	adc a,e			;b894
	sbc a,(hl)			;b895
	sub e			;b896
	rst 18h			;b897
	sbc a,e			;b898
	sub (hl)			;b899
	sub b			;b89a
	adc a,h			;b89b
	rst 18h			;b89c
	sub d			;b89d
	sub (hl)			;b89e
	adc a,e			;b89f
	sub b			;b8a0
	sub e			;b8a1
	rst 20h			;b8a2
	sbc a,b			;b8a3
	sub (hl)			;b8a4
	sbc a,h			;b8a5
	sub b			;b8a6
	pop de			;b8a7
	push af			;b8a8
	xor e			;b8a9
	adc a,l			;b8aa
	sbc a,(hl)			;b8ab
	adc a,h			;b8ac
	rst 18h			;b8ad
	adc a,d			;b8ae
	sub c			;b8af
	rst 18h			;b8b0
	sub d			;b8b1
	sub b			;b8b2
	sub d			;b8b3
	sbc a,d			;b8b4
	sub c			;b8b5
	adc a,e			;b8b6
	sub b			;b8b7
	out (0dfh),a		;b8b8
	or a			;b8ba
	adc a,d			;b8bb
	sub (hl)			;b8bc
	adc a,e			;b8bd
	add a,l			;b8be
	sub (hl)			;b8bf
	sub e			;b8c0
	sub b			;b8c1
	adc a,a			;b8c2
	sub b			;b8c3
	sbc a,h			;b8c4
	sub a			;b8c5
	adc a,e			;b8c6
	sub e			;b8c7
	sub (hl)			;b8c8
	rst 18h			;b8c9
	adc a,l			;b8ca
	sbc a,d			;b8cb
	sbc a,h			;b8cc
	sub b			;b8cd
	sbc a,l			;b8ce
	adc a,l			;b8cf
	sbc a,(hl)			;b8d0
	rst 18h			;b8d1
	adc a,h			;b8d2
	adc a,d			;b8d3
	adc a,h			;b8d4
	rst 18h			;b8d5
	sbc a,c			;b8d6
	sbc a,(hl)			;b8d7
	sbc a,h			;b8d8
	adc a,d			;b8d9
	sub e			;b8da
	adc a,e			;b8db
	sbc a,(hl)			;b8dc
	sbc a,e			;b8dd
	sbc a,d			;b8de
	adc a,h			;b8df
	push af			;b8e0
	rst 18h			;b8e1
	add a,(hl)			;b8e2
	rst 18h			;b8e3
	adc a,e			;b8e4
	sbc a,d			;b8e5
	rst 18h			;b8e6
	adc a,a			;b8e7
	sbc a,(hl)			;b8e8
	adc a,l			;b8e9
	adc a,e			;b8ea
	sbc a,d			;b8eb
	rst 18h			;b8ec
	sbc a,d			;b8ed
	sub c			;b8ee
	rst 18h			;b8ef
	sbc a,e			;b8f0
	sub b			;b8f1
	adc a,h			;b8f2
	rst 18h			;b8f3
	sbc a,e			;b8f4
	sbc a,d			;b8f5
	rst 18h			;b8f6
	adc a,d			;b8f7
	sub c			;b8f8
	rst 18h			;b8f9
	adc a,h			;b8fa
	sub b			;b8fb
	sub e			;b8fc
	sub b			;b8fd
	rst 18h			;b8fe
	adc a,e			;b8ff
	sbc a,(hl)			;b900
	sub l			;b901
	sub b			;b902
	pop de			;b903
	push af			;b904
	xor 0b7h		;b905
	sub b			;b907
	adc a,l			;b908
	adc a,l			;b909
	sub b			;b90a
	adc a,l			;b90b
	sbc a,0dfh		;b90c
	xor e			;b90e
	adc a,d			;b90f
	rst 18h			;b910
	sub (hl)			;b911
	sub c			;b912
	adc a,e			;b913
	sbc a,d			;b914
	adc a,l			;b915
	sub (hl)			;b916
	sub b			;b917
	adc a,l			;b918
	rst 18h			;b919
	sbc a,h			;b91a
	adc a,l			;b91b
	sbc a,d			;b91c
	sbc a,h			;b91d
	sbc a,d			;b91e
	rst 18h			;b91f
	sub d			;b920
	jp pe,0df8ch		;b921
	adc a,(hl)			;b924
	adc a,d			;b925
	sbc a,d			;b926
	rst 18h			;b927
	adc a,e			;b928
	adc a,d			;b929
	rst 18h			;b92a
	sbc a,d			;b92b
	add a,a			;b92c
	adc a,e			;b92d
	sbc a,d			;b92e
	adc a,l			;b92f
	sub (hl)			;b930
	sub b			;b931
	adc a,l			;b932
	out (0dfh),a		;b933
	add a,(hl)			;b935
	pop de			;b936
	pop de			;b937
	pop de			;b938
	rst 18h			;b939
	sub d			;b93a
	adc a,d			;b93b
	sbc a,d			;b93c
	adc a,l			;b93d
	sbc a,d			;b93e
	adc a,h			;b93f
	rst 18h			;b940
	adc a,l			;b941
	sbc a,d			;b942
	adc a,a			;b943
	adc a,d			;b944
	sub e			;b945
	adc a,h			;b946
	sub (hl)			;b947
	adc a,c			;b948
	sbc a,(hl)			;b949
	sub d			;b94a
	sbc a,d			;b94b
	sub c			;b94c
	adc a,e			;b94d
	sbc a,d			;b94e
	pop de			;b94f
	push af			;b950
	xor c			;b951
	sbc a,(hl)			;b952
	sbc a,h			;b953
	ret pe			;b954
	sbc a,(hl)			;b955
	adc a,h			;b956
	rst 18h			;b957
	sub e			;b958
	sbc a,(hl)			;b959
	rst 18h			;b95a
	sbc a,l			;b95b
	sub b			;b95c
	adc a,e			;b95d
	sbc a,d			;b95e
	sub e			;b95f
	sub e			;b960
	sbc a,(hl)			;b961
	rst 18h			;b962
	push af			;b963
	adc a,h			;b964
	sub b			;b965
	sbc a,l			;b966
	adc a,l			;b967
	sbc a,d			;b968
	rst 18h			;b969
	and b			;b96a
	out (0dfh),a		;b96b
	adc a,(hl)			;b96d
	adc a,d			;b96e
	sbc a,d			;b96f
	rst 18h			;b970
	sbc a,h			;b971
	adc a,l			;b972
	sbc a,d			;b973
	sbc a,h			;b974
	sbc a,d			;b975
	rst 18h			;b976
	sub a			;b977
	sbc a,(hl)			;b978
	adc a,h			;b979
	adc a,e			;b97a
	sbc a,(hl)			;b97b
	rst 18h			;b97c
	adc a,d			;b97d
	sub c			;b97e
	sub b			;b97f
	adc a,h			;b980
	rst 18h			;b981
	ret			;b982
	rst 18h			;b983
	sub d			;b984
	sbc a,d			;b985
	adc a,e			;b986
	adc a,l			;b987
	sub b			;b988
	adc a,h			;b989
	out (0dfh),a		;b98a
	adc a,e			;b98c
	adc a,l			;b98d
	sbc a,(hl)			;b98e
	adc a,h			;b98f
	rst 18h			;b990
	sub e			;b991
	sub b			;b992
	rst 18h			;b993
	sbc a,h			;b994
	adc a,d			;b995
	sbc a,(hl)			;b996
	sub e			;b997
	rst 18h			;b998
	adc a,c			;b999
	adc a,d			;b99a
	sbc a,d			;b99b
	sub e			;b99c
	adc a,c			;b99d
	sbc a,d			;b99e
	rst 18h			;b99f
	sbc a,(hl)			;b9a0
	rst 18h			;b9a1
	adc a,h			;b9a2
	adc a,d			;b9a3
	rst 18h			;b9a4
	adc a,e			;b9a5
	sbc a,(hl)			;b9a6
	sub d			;b9a7
	sbc a,(hl)			;b9a8
	push hl			;b9a9
	sub b			;b9aa
	pop de			;b9ab
	push af			;b9ac
	adc a,h			;b9ad
	sub b			;b9ae
	sbc a,l			;b9af
	adc a,l			;b9b0
	sbc a,d			;b9b1
	rst 18h			;b9b2
	sub e			;b9b3
	sbc a,(hl)			;b9b4
	rst 18h			;b9b5
	adc a,l			;b9b6
	sbc a,(hl)			;b9b7
	sub d			;b9b8
	adc a,a			;b9b9
	sbc a,(hl)			;b9ba
	out (0dfh),a		;b9bb
	sbc a,c			;b9bd
	sub b			;b9be
	adc a,l			;b9bf
	sub d			;b9c0
	sbc a,(hl)			;b9c1
	sub c			;b9c2
	sbc a,e			;b9c3
	sub b			;b9c4
	rst 18h			;b9c5
	adc a,d			;b9c6
	sub c			;b9c7
	rst 18h			;b9c8
	adc a,l			;b9c9
	sbc a,d			;b9ca
	sbc a,b			;b9cb
	adc a,d			;b9cc
	sbc a,d			;b9cd
	adc a,l			;b9ce
	sub b			;b9cf
	rst 18h			;b9d0
	sbc a,d			;b9d1
	sub c			;b9d2
	rst 18h			;b9d3
	jp (hl)			;b9d4
	adc a,h			;b9d5
	adc a,e			;b9d6
	sbc a,(hl)			;b9d7
	pop de			;b9d8
	push af			;b9d9
	xor d			;b9da
	sub c			;b9db
	rst 18h			;b9dc
	adc a,l			;b9dd
	sbc a,d			;b9de
	sbc a,b			;b9df
	adc a,d			;b9e0
	sbc a,d			;b9e1
	adc a,l			;b9e2
	sub b			;b9e3
	rst 18h			;b9e4
	sbc a,e			;b9e5
	sbc a,d			;b9e6
	rst 18h			;b9e7
	sub e			;b9e8
	ret pe			;b9e9
	adc a,(hl)			;b9ea
	adc a,d			;b9eb
	sub (hl)			;b9ec
	sbc a,e			;b9ed
	sub b			;b9ee
	rst 18h			;b9ef
	sub e			;b9f0
	sub e			;b9f1
	sbc a,d			;b9f2
	sbc a,b			;b9f3
	sbc a,(hl)			;b9f4
	rst 18h			;b9f5
	sbc a,h			;b9f6
	sbc a,(hl)			;b9f7
	adc a,h			;b9f8
	sub (hl)			;b9f9
	rst 18h			;b9fa
	sub a			;b9fb
	sbc a,(hl)			;b9fc
	adc a,h			;b9fd
	adc a,e			;b9fe
	sbc a,(hl)			;b9ff
	rst 18h			;ba00
	sub e			;ba01
	sbc a,(hl)			;ba02
	rst 18h			;ba03
	adc a,a			;ba04
	adc a,d			;ba05
	sbc a,d			;ba06
	adc a,l			;ba07
	adc a,e			;ba08
	sbc a,(hl)			;ba09
	rst 18h			;ba0a
	sbc a,e			;ba0b
	sbc a,d			;ba0c
	sub e			;ba0d
	rst 18h			;ba0e
	adc a,e			;ba0f
	sbc a,d			;ba10
	sub d			;ba11
	adc a,a			;ba12
	sub e			;ba13
	sub b			;ba14
	pop de			;ba15
	push af			;ba16
	or e			;ba17
	sbc a,(hl)			;ba18
	rst 18h			;ba19
	sbc a,d			;ba1a
	adc a,h			;ba1b
	sbc a,c			;ba1c
	sbc a,d			;ba1d
	adc a,l			;ba1e
	sbc a,(hl)			;ba1f
	rst 18h			;ba20
	sbc a,l			;ba21
	sbc a,(hl)			;ba22
	sub l			;ba23
	sbc a,(hl)			;ba24
	rst 18h			;ba25
	adc a,l			;ba26
	sub b			;ba27
	sbc a,e			;ba28
	sbc a,(hl)			;ba29
	sub c			;ba2a
	sbc a,e			;ba2b
	sub b			;ba2c
	rst 18h			;ba2d
	adc a,a			;ba2e
	sub b			;ba2f
	adc a,l			;ba30
	rst 18h			;ba31
	sub e			;ba32
	sbc a,(hl)			;ba33
	rst 18h			;ba34
	adc a,l			;ba35
	sbc a,(hl)			;ba36
	sub d			;ba37
	adc a,a			;ba38
	sbc a,(hl)			;ba39
	rst 18h			;ba3a
	push af			;ba3b
	add a,(hl)			;ba3c
	rst 18h			;ba3d
	adc a,h			;ba3e
	sbc a,d			;ba3f
	rst 18h			;ba40
	sbc a,d			;ba41
	adc a,h			;ba42
	adc a,e			;ba43
	adc a,l			;ba44
	sbc a,d			;ba45
	sub e			;ba46
	sub e			;ba47
	sbc a,(hl)			;ba48
	rst 18h			;ba49
	sbc a,h			;ba4a
	sub b			;ba4b
	sub c			;ba4c
	adc a,e			;ba4d
	adc a,l			;ba4e
	sbc a,(hl)			;ba4f
	rst 18h			;ba50
	sub e			;ba51
	sbc a,(hl)			;ba52
	rst 18h			;ba53
	adc a,a			;ba54
	adc a,d			;ba55
	sbc a,d			;ba56
	adc a,l			;ba57
	adc a,e			;ba58
	sbc a,(hl)			;ba59
	rst 18h			;ba5a
	sbc a,e			;ba5b
	sbc a,d			;ba5c
	sub e			;ba5d
	rst 18h			;ba5e
	adc a,e			;ba5f
	sbc a,d			;ba60
	sub d			;ba61
	adc a,a			;ba62
	sub e			;ba63
	sub b			;ba64
	rst 18h			;ba65
	sbc a,e			;ba66
	sbc a,d			;ba67
	adc a,h			;ba68
	adc a,e			;ba69
	adc a,l			;ba6a
	sub b			;ba6b
	add a,l			;ba6c
	jp pe,09b91h		;ba6d
	sub b			;ba70
	adc a,h			;ba71
	sbc a,d			;ba72
	pop de			;ba73
	push af			;ba74
	sub (hl)			;ba75
	sub d			;ba76
	adc a,a			;ba77
	adc a,l			;ba78
	sbc a,d			;ba79
	sbc a,b			;ba7a
	sub c			;ba7b
	jp pe,09b91h		;ba7c
	sub b			;ba7f
	adc a,h			;ba80
	sbc a,d			;ba81
	rst 18h			;ba82
	sbc a,h			;ba83
	sub b			;ba84
	sub c			;ba85
	rst 18h			;ba86
	sbc a,d			;ba87
	sub e			;ba88
	rst 18h			;ba89
	sub e			;ba8a
	sub (hl)			;ba8b
	adc a,(hl)			;ba8c
	adc a,d			;ba8d
	sub (hl)			;ba8e
	sbc a,e			;ba8f
	sub b			;ba90
	rst 18h			;ba91
	add a,(hl)			;ba92
	rst 18h			;ba93
	sbc a,h			;ba94
	adc a,l			;ba95
	sbc a,d			;ba96
	sbc a,h			;ba97
	sub (hl)			;ba98
	sbc a,d			;ba99
	sub c			;ba9a
	sbc a,e			;ba9b
	sub b			;ba9c
	rst 18h			;ba9d
	sbc a,(hl)			;ba9e
	sub e			;ba9f
	rst 18h			;baa0
	sbc a,(hl)			;baa1
	adc a,c			;baa2
	sbc a,(hl)			;baa3
	sub c			;baa4
	add a,l			;baa5
	sbc a,(hl)			;baa6
	adc a,l			;baa7
	pop de			;baa8
	di			;baa9
	call p,08abch		;baaa
	sbc a,(hl)			;baad
	sub c			;baae
	sbc a,e			;baaf
	sub b			;bab0
	rst 18h			;bab1
	sbc a,(hl)			;bab2
	sub e			;bab3
	sbc a,h			;bab4
	sbc a,(hl)			;bab5
	sub c			;bab6
	add a,l			;bab7
	sbc a,(hl)			;bab8
	rst 18h			;bab9
	sbc a,d			;baba
	sub e			;babb
	rst 18h			;babc
	adc a,e			;babd
	sbc a,d			;babe
	sub d			;babf
	adc a,a			;bac0
	sub e			;bac1
	sub b			;bac2
	rst 18h			;bac3
	adc a,h			;bac4
	sbc a,d			;bac5
	rst 18h			;bac6
	sbc a,d			;bac7
	adc a,h			;bac8
	adc a,e			;bac9
	adc a,l			;baca
	sbc a,d			;bacb
	sub e			;bacc
	sub e			;bacd
	sbc a,(hl)			;bace
	rst 18h			;bacf
	sbc a,h			;bad0
	sub b			;bad1
	sub c			;bad2
	adc a,e			;bad3
	adc a,l			;bad4
	sbc a,(hl)			;bad5
	rst 18h			;bad6
	sub e			;bad7
	sbc a,(hl)			;bad8
	rst 18h			;bad9
	adc a,a			;bada
	adc a,d			;badb
	sbc a,d			;badc
	adc a,l			;badd
	adc a,e			;bade
	sbc a,(hl)			;badf
	out (0dfh),a		;bae0
	sbc a,e			;bae2
	sbc a,d			;bae3
	adc a,h			;bae4
	adc a,e			;bae5
	adc a,l			;bae6
	sub b			;bae7
	add a,l			;bae8
	jp pe,09b91h		;bae9
	sub b			;baec
	adc a,h			;baed
	sbc a,d			;baee
	rst 18h			;baef
	sbc a,(hl)			;baf0
	sub d			;baf1
	sbc a,l			;baf2
	sbc a,(hl)			;baf3
	adc a,h			;baf4
	pop de			;baf5
	push af			;baf6
	or e			;baf7
	sub b			;baf8
	adc a,h			;baf9
	rst 18h			;bafa
	sub d			;bafb
	adc a,d			;bafc
	sbc a,d			;bafd
	adc a,l			;bafe
	adc a,e			;baff
	sub b			;bb00
	adc a,h			;bb01
	rst 18h			;bb02
	sbc a,d			;bb03
	sub c			;bb04
	rst 18h			;bb05
	sub d			;bb06
	adc a,d			;bb07
	sbc a,d			;bb08
	adc a,l			;bb09
	adc a,e			;bb0a
	sbc a,d			;bb0b
	rst 18h			;bb0c
	sbc a,(hl)			;bb0d
	adc a,c			;bb0e
	sbc a,(hl)			;bb0f
	sub c			;bb10
	add a,l			;bb11
	sbc a,(hl)			;bb12
	sub c			;bb13
	rst 18h			;bb14
	adc a,h			;bb15
	sub b			;bb16
	sbc a,l			;bb17
	adc a,l			;bb18
	sbc a,d			;bb19
	rst 18h			;bb1a
	adc a,e			;bb1b
	sub (hl)			;bb1c
	pop de			;bb1d
	push af			;bb1e
	or e			;bb1f
	sub b			;bb20
	adc a,h			;bb21
	rst 18h			;bb22
	adc a,h			;bb23
	sbc a,d			;bb24
	adc a,l			;bb25
	sbc a,d			;bb26
	adc a,h			;bb27
	rst 18h			;bb28
	sbc a,d			;bb29
	add a,a			;bb2a
	adc a,e			;bb2b
	sub (hl)			;bb2c
	sbc a,d			;bb2d
	sub c			;bb2e
	sbc a,e			;bb2f
	sbc a,d			;bb30
	sub c			;bb31
	rst 18h			;bb32
	adc a,h			;bb33
	adc a,d			;bb34
	adc a,h			;bb35
	rst 18h			;bb36
	sbc a,b			;bb37
	sbc a,(hl)			;bb38
	adc a,l			;bb39
	adc a,l			;bb3a
	sbc a,(hl)			;bb3b
	adc a,h			;bb3c
	rst 18h			;bb3d
	add a,(hl)			;bb3e
	rst 18h			;bb3f
	sbc a,d			;bb40
	sub d			;bb41
	adc a,a			;bb42
	sub (hl)			;bb43
	sbc a,d			;bb44
	add a,l			;bb45
	sbc a,(hl)			;bb46
	sub c			;bb47
	rst 18h			;bb48
	sbc a,(hl)			;bb49
	rst 18h			;bb4a
	adc a,e			;bb4b
	sub b			;bb4c
	sbc a,h			;bb4d
	sbc a,(hl)			;bb4e
	adc a,l			;bb4f
	adc a,e			;bb50
	sbc a,d			;bb51
	pop de			;bb52
	push af			;bb53
	xor e			;bb54
	adc a,d			;bb55
	rst 18h			;bb56
	sbc a,d			;bb57
	sub c			;bb58
	sbc a,d			;bb59
	adc a,l			;bb5a
	sbc a,b			;bb5b
	ret pe			;bb5c
	sbc a,(hl)			;bb5d
	rst 18h			;bb5e
	add a,(hl)			;bb5f
	rst 18h			;bb60
	sub d			;bb61
	sub b			;bb62
	adc a,l			;bb63
	sbc a,(hl)			;bb64
	sub e			;bb65
	rst 18h			;bb66
	adc a,h			;bb67
	sbc a,d			;bb68
	rst 18h			;bb69
	adc a,c			;bb6a
	sbc a,(hl)			;bb6b
	sub c			;bb6c
	rst 18h			;bb6d
	sbc a,e			;bb6e
	adc a,l			;bb6f
	sbc a,d			;bb70
	sub c			;bb71
	sbc a,(hl)			;bb72
	sub c			;bb73
	sbc a,e			;bb74
	sub b			;bb75
	rst 18h			;bb76
	adc a,a			;bb77
	sub b			;bb78
	adc a,l			;bb79
	rst 18h			;bb7a
	sbc a,d			;bb7b
	sub e			;bb7c
	rst 18h			;bb7d
	sbc a,h			;bb7e
	sub b			;bb7f
	sub c			;bb80
	adc a,e			;bb81
	sbc a,(hl)			;bb82
	sbc a,h			;bb83
	adc a,e			;bb84
	sub b			;bb85
	rst 18h			;bb86
	sbc a,h			;bb87
	sub b			;bb88
	sub c			;bb89
	rst 18h			;bb8a
	sub e			;bb8b
	sub b			;bb8c
	adc a,h			;bb8d
	rst 18h			;bb8e
	sub d			;bb8f
	adc a,d			;bb90
	sbc a,d			;bb91
	adc a,l			;bb92
	adc a,e			;bb93
	sub b			;bb94
	adc a,h			;bb95
	rst 18h			;bb96
	sbc a,d			;bb97
	sub c			;bb98
	rst 18h			;bb99
	sub d			;bb9a
	adc a,d			;bb9b
	sbc a,d			;bb9c
	adc a,l			;bb9d
	adc a,e			;bb9e
	sbc a,d			;bb9f
	pop de			;bba0
	push af			;bba1
	xor c			;bba2
	sbc a,(hl)			;bba3
	sbc a,h			;bba4
	ret pe			;bba5
	sub b			;bba6
	rst 18h			;bba7
	sbc a,e			;bba8
	sbc a,d			;bba9
	rst 18h			;bbaa
	sbc a,d			;bbab
	sub c			;bbac
	sbc a,d			;bbad
	adc a,l			;bbae
	sbc a,b			;bbaf
	ret pe			;bbb0
	sbc a,(hl)			;bbb1
	rst 18h			;bbb2
	add a,(hl)			;bbb3
	rst 18h			;bbb4
	sbc a,e			;bbb5
	sbc a,d			;bbb6
	rst 18h			;bbb7
	sub (hl)			;bbb8
	sub e			;bbb9
	adc a,d			;bbba
	adc a,h			;bbbb
	sub (hl)			;bbbc
	sub b			;bbbd
	sub c			;bbbe
	sbc a,d			;bbbf
	adc a,h			;bbc0
	out (0dfh),a		;bbc1
	adc a,a			;bbc3
	sbc a,(hl)			;bbc4
	adc a,h			;bbc5
	sbc a,(hl)			;bbc6
	adc a,h			;bbc7
	rst 18h			;bbc8
	sbc a,(hl)			;bbc9
	rst 18h			;bbca
	adc a,h			;bbcb
	sbc a,d			;bbcc
	adc a,l			;bbcd
	rst 18h			;bbce
	adc a,d			;bbcf
	sub c			;bbd0
	sub b			;bbd1
	rst 18h			;bbd2
	sbc a,e			;bbd3
	sbc a,d			;bbd4
	rst 18h			;bbd5
	sbc a,d			;bbd6
	sub e			;bbd7
	sub e			;bbd8
	sub b			;bbd9
	adc a,h			;bbda
	pop de			;bbdb
	push af			;bbdc
	cp h			;bbdd
	sub (hl)			;bbde
	sbc a,d			;bbdf
	sub c			;bbe0
	adc a,e			;bbe1
	sub b			;bbe2
	adc a,h			;bbe3
	rst 18h			;bbe4
	sbc a,e			;bbe5
	sbc a,d			;bbe6
	rst 18h			;bbe7
	sub d			;bbe8
	adc a,d			;bbe9
	sbc a,d			;bbea
	adc a,l			;bbeb
	adc a,e			;bbec
	sub b			;bbed
	adc a,h			;bbee
	rst 18h			;bbef
	sbc a,d			;bbf0
	sub c			;bbf1
	rst 18h			;bbf2
	sub d			;bbf3
	adc a,d			;bbf4
	sbc a,d			;bbf5
	adc a,l			;bbf6
	adc a,e			;bbf7
	sbc a,d			;bbf8
	rst 18h			;bbf9
	adc a,e			;bbfa
	sbc a,d			;bbfb
	rst 18h			;bbfc
	sbc a,l			;bbfd
	sub e			;bbfe
	sub b			;bbff
	adc a,(hl)			;bc00
	adc a,d			;bc01
	sbc a,d			;bc02
	sbc a,(hl)			;bc03
	sub c			;bc04
	pop de			;bc05
	push af			;bc06
	xor e			;bc07
	adc a,l			;bc08
	sbc a,(hl)			;bc09
	adc a,h			;bc0a
	rst 18h			;bc0b
	adc a,l			;bc0c
	sbc a,d			;bc0d
	sbc a,h			;bc0e
	sub (hl)			;bc0f
	sbc a,l			;bc10
	sub (hl)			;bc11
	adc a,l			;bc12
	rst 18h			;bc13
	sub e			;bc14
	sub b			;bc15
	rst 18h			;bc16
	adc a,(hl)			;bc17
	adc a,d			;bc18
	sbc a,d			;bc19
	rst 18h			;bc1a
	sbc a,e			;bc1b
	sbc a,d			;bc1c
	adc a,h			;bc1d
	sbc a,d			;bc1e
	sbc a,(hl)			;bc1f
	sub c			;bc20
	out (0dfh),a		;bc21
	adc a,e			;bc23
	sbc a,d			;bc24
	rst 18h			;bc25
	sbc a,e			;bc26
	sbc a,d			;bc27
	sub l			;bc28
	sbc a,(hl)			;bc29
	sub c			;bc2a
	rst 18h			;bc2b
	sbc a,d			;bc2c
	sub c			;bc2d
	rst 18h			;bc2e
	adc a,a			;bc2f
	sbc a,(hl)			;bc30
	add a,l			;bc31
	pop de			;bc32
	push af			;bc33
	cp d			;bc34
	adc a,l			;bc35
	sbc a,d			;bc36
	adc a,h			;bc37
	rst 18h			;bc38
	sub (hl)			;bc39
	sbc a,b			;bc3a
	sub c			;bc3b
	sub b			;bc3c
	adc a,l			;bc3d
	sbc a,(hl)			;bc3e
	sbc a,e			;bc3f
	sub b			;bc40
	pop de			;bc41
	push af			;bc42
	cp h			;bc43
	sub e			;bc44
	sbc a,(hl)			;bc45
	adc a,c			;bc46
	sbc a,d			;bc47
	rst 18h			;bc48
	sbc a,e			;bc49
	sbc a,d			;bc4a
	rst 18h			;bc4b
	sbc a,(hl)			;bc4c
	sbc a,h			;bc4d
	sbc a,h			;bc4e
	sbc a,d			;bc4f
	adc a,h			;bc50
	sub b			;bc51
	push bc			;bc52
	push af			;bc53
	cp h			;bc54
	sub e			;bc55
	sbc a,(hl)			;bc56
	adc a,c			;bc57
	sbc a,d			;bc58
	rst 18h			;bc59
	sub (hl)			;bc5a
	sub c			;bc5b
	sbc a,h			;bc5c
	sub b			;bc5d
	adc a,l			;bc5e
	adc a,l			;bc5f
	sbc a,d			;bc60
	sbc a,h			;bc61
	adc a,e			;bc62
	sbc a,(hl)			;bc63
	pop de			;bc64
	push af			;bc65
	rla			;bc66
	sub (hl)			;bc67
	dec hl			;bc68
	sub (hl)			;bc69
	ld l,e			;bc6a
	sub (hl)			;bc6b
	ld (hl),a			;bc6c
	sub (hl)			;bc6d
	adc a,e			;bc6e
	sub (hl)			;bc6f
	or a			;bc70
	sub (hl)			;bc71
	cp (hl)			;bc72
	sub (hl)			;bc73
	call z,0cd96h		;bc74
	sub (hl)			;bc77
	adc a,096h		;bc78
	sbc a,096h		;bc7a
	dec b			;bc7c
	sub a			;bc7d
	inc d			;bc7e
	sub a			;bc7f
	jr c,$-103		;bc80
	ld d,e			;bc82
	sub a			;bc83
	ld e,a			;bc84
	sub a			;bc85
	ld h,(hl)			;bc86
	sub a			;bc87
	ld h,a			;bc88
	sub a			;bc89
	ld (hl),b			;bc8a
	sub a			;bc8b
	ld a,c			;bc8c
	sub a			;bc8d
	add a,(hl)			;bc8e
	sub a			;bc8f
	or (hl)			;bc90
	sub a			;bc91
	jp (hl)			;bc92
	sub a			;bc93
	ld a,(bc)			;bc94
	sbc a,b			;bc95
	dec l			;bc96
	sbc a,b			;bc97
	ld l,(hl)			;bc98
	sbc a,b			;bc99
	sub b			;bc9a
	sbc a,b			;bc9b
	jp pe,0eb98h		;bc9c
	sbc a,b			;bc9f
	call pe,0ed98h		;bca0
	sbc a,b			;bca3
	dec bc			;bca4
	sbc a,c			;bca5
	inc c			;bca6
	sbc a,c			;bca7
	dec c			;bca8
	sbc a,c			;bca9
	dec l			;bcaa
	sbc a,c			;bcab
	ld d,h			;bcac
	sbc a,c			;bcad
	ld e,l			;bcae
	sbc a,c			;bcaf
	ld a,(hl)			;bcb0
	sbc a,c			;bcb1
	and h			;bcb2
	sbc a,c			;bcb3
	cp b			;bcb4
	sbc a,c			;bcb5
	ret p			;bcb6
	sbc a,c			;bcb7
	ld sp,hl			;bcb8
	sbc a,c			;bcb9
	rlca			;bcba
	sbc a,d			;bcbb
	dec e			;bcbc
	sbc a,d			;bcbd
	inc h			;bcbe
	sbc a,d			;bcbf
	ld sp,0409ah		;bcc0
	sbc a,d			;bcc3
	ld b,l			;bcc4
	sbc a,d			;bcc5
	push bc			;bcc6
	sbc a,d			;bcc7
	inc h			;bcc8
	sbc a,e			;bcc9
	ld c,d			;bcca
	sbc a,e			;bccb
	ld a,e			;bccc
	sbc a,e			;bccd
	and e			;bcce
	sbc a,e			;bccf
	call nc,0e69bh		;bcd0
	sbc a,e			;bcd3
	ld sp,hl			;bcd4
	sbc a,e			;bcd5
	ld l,h			;bcd6
	sbc a,h			;bcd7
	add a,d			;bcd8
	sbc a,h			;bcd9
	and a			;bcda
	sbc a,h			;bcdb
	call z,01e9ch		;bcdc
	sbc a,l			;bcdf
	ld a,b			;bce0
	sbc a,l			;bce1
	xor h			;bce2
	sbc a,l			;bce3
	jr nc,$-96		;bce4
	sbc a,h			;bce6
	sbc a,(hl)			;bce7
	cp a			;bce8
	sbc a,(hl)			;bce9
	rst 18h			;bcea
	sbc a,(hl)			;bceb
	ld (de),a			;bcec
	sbc a,a			;bced
	ld b,a			;bcee
	sbc a,a			;bcef
	ld e,c			;bcf0
	sbc a,a			;bcf1
	ld l,(hl)			;bcf2
	sbc a,a			;bcf3
	ld a,d			;bcf4
	sbc a,a			;bcf5
	or l			;bcf6
	sbc a,a			;bcf7
	call c,0ed9fh		;bcf8
	sbc a,a			;bcfb
	add hl,bc			;bcfc
	and b			;bcfd
	ld c,c			;bcfe
	and b			;bcff
	ld a,c			;bd00
	and b			;bd01
	or d			;bd02
	and b			;bd03
	ex (sp),hl			;bd04
	and b			;bd05
	cp 0a0h		;bd06
	ld e,0a1h		;bd08
	inc sp			;bd0a
	and c			;bd0b
	ld c,(hl)			;bd0c
	and c			;bd0d
	add a,l			;bd0e
	and c			;bd0f
	xor h			;bd10
	and c			;bd11
	and 0a1h		;bd12
	ld de,023a2h		;bd14
	and d			;bd17
	scf			;bd18
	and d			;bd19
	ld (hl),d			;bd1a
	and d			;bd1b
	sub b			;bd1c
	and d			;bd1d
	pop bc			;bd1e
	and d			;bd1f
	rla			;bd20
	and e			;bd21
	ld hl,(04aa3h)		;bd22
	and e			;bd25
	ld d,a			;bd26
	and e			;bd27
	ld a,(hl)			;bd28
	and e			;bd29
	sbc a,h			;bd2a
	and e			;bd2b
	xor (hl)			;bd2c
	and e			;bd2d
	exx			;bd2e
	and e			;bd2f
	ex af,af'			;bd30
	and h			;bd31
	ld l,0a4h		;bd32
	ld a,0a4h		;bd34
	ld d,(hl)			;bd36
	and h			;bd37
	add a,c			;bd38
	and h			;bd39
	sbc a,a			;bd3a
	and h			;bd3b
	ret nc			;bd3c
	and h			;bd3d
	or 0a4h		;bd3e
	inc h			;bd40
	and l			;bd41
	scf			;bd42
	and l			;bd43
	ld a,h			;bd44
	and l			;bd45
	xor e			;bd46
	and l			;bd47
	jp 0faa5h		;bd48
	and l			;bd4b
	jr nc,$-88		;bd4c
	ld h,c			;bd4e
	and (hl)			;bd4f
	sub b			;bd50
	and (hl)			;bd51
	xor (hl)			;bd52
	and (hl)			;bd53
	cp a			;bd54
	and (hl)			;bd55
	ret z			;bd56
	and (hl)			;bd57
	rst 8			;bd58
	and (hl)			;bd59
	nop			;bd5a
	and a			;bd5b
	ld a,(bc)			;bd5c
	and a			;bd5d
	inc h			;bd5e
	and a			;bd5f
	ld a,h			;bd60
	and a			;bd61
	adc a,d			;bd62
	and a			;bd63
	or h			;bd64
	and a			;bd65
	call z,000a7h		;bd66
	xor b			;bd69
	dec d			;bd6a
	xor b			;bd6b
	add hl,sp			;bd6c
	xor b			;bd6d
	ld d,d			;bd6e
	xor b			;bd6f
	adc a,h			;bd70
	xor b			;bd71
	cp e			;bd72
	xor b			;bd73
	jp (hl)			;bd74
	xor b			;bd75
	rla			;bd76
	xor c			;bd77
	daa			;bd78
	xor c			;bd79
	ld b,d			;bd7a
	xor c			;bd7b
	ld l,l			;bd7c
	xor c			;bd7d
	and l			;bd7e
	xor c			;bd7f
	cp h			;bd80
	xor c			;bd81
	jp po,0f3a9h		;bd82
	xor c			;bd85
	nop			;bd86
	xor d			;bd87
	ld (hl),0aah		;bd88
	ld d,b			;bd8a
	xor d			;bd8b
	ld l,c			;bd8c
	xor d			;bd8d
	jp 0d8aah		;bd8e
	xor d			;bd91
	jp m,01baah		;bd92
	xor e			;bd95
	ld h,0abh		;bd96
	ld (hl),0abh		;bd98
	ld e,c			;bd9a
	xor e			;bd9b
	adc a,a			;bd9c
	xor e			;bd9d
	and d			;bd9e
	xor e			;bd9f
	ret z			;bda0
	xor e			;bda1
	ex de,hl			;bda2
	xor e			;bda3
	inc b			;bda4
	xor h			;bda5
	add hl,de			;bda6
	xor h			;bda7
	dec sp			;bda8
	xor h			;bda9
	ld e,(hl)			;bdaa
	xor h			;bdab
	add a,b			;bdac
	xor h			;bdad
	sub h			;bdae
	xor h			;bdaf
	xor c			;bdb0
	xor h			;bdb1
	call nz,0f2ach		;bdb2
	xor h			;bdb5
	rla			;bdb6
	xor l			;bdb7
	ld c,h			;bdb8
	xor l			;bdb9
	ld a,e			;bdba
	xor l			;bdbb
	and c			;bdbc
	xor l			;bdbd
	add a,0adh		;bdbe
	in a,(0adh)		;bdc0
	ld c,(hl)			;bdc2
	xor (hl)			;bdc3
	call nz,002aeh		;bdc4
	xor a			;bdc7
	inc c			;bdc8
	xor a			;bdc9
	ld c,d			;bdca
	xor a			;bdcb
	sub (hl)			;bdcc
	xor a			;bdcd
	jp z,0dbafh		;bdce
	xor a			;bdd1
	djnz $-78		;bdd2
	ld e,a			;bdd4
	or b			;bdd5
	cp c			;bdd6
	or b			;bdd7
	cp d			;bdd8
	or b			;bdd9
	cp e			;bdda
	or b			;bddb
	exx			;bddc
	or b			;bddd
	ret m			;bdde
	or b			;bddf
	ld a,(bc)			;bde0
	or c			;bde1
	ld a,(065b1h)		;bde2
	or c			;bde5
	add a,b			;bde6
	or c			;bde7
	ret c			;bde8
	or c			;bde9
	inc e			;bdea
	or d			;bdeb
	jr nc,$-76		;bdec
	ld c,a			;bdee
	or d			;bdef
	exx			;bdf0
	or d			;bdf1
	ld e,(hl)			;bdf2
	or e			;bdf3
	add a,c			;bdf4
	or e			;bdf5
	and c			;bdf6
	or e			;bdf7
	cp e			;bdf8
	or e			;bdf9
	push af			;bdfa
	or e			;bdfb
	ld h,h			;bdfc
	or h			;bdfd
	sub (hl)			;bdfe
	or h			;bdff
	cp h			;be00
	or h			;be01
	sub 0b4h		;be02
	rst 30h			;be04
	or h			;be05
	dec c			;be06
	or l			;be07
	inc (hl)			;be08
	or l			;be09
	ld c,l			;be0a
	or l			;be0b
	add a,0b5h		;be0c
	inc a			;be0e
	or (hl)			;be0f
	ld d,l			;be10
	or (hl)			;be11
	adc a,a			;be12
	or (hl)			;be13
	and e			;be14
	or (hl)			;be15
	cp h			;be16
	or (hl)			;be17
	push hl			;be18
	or (hl)			;be19
	ld d,d			;be1a
	or a			;be1b
	ld d,e			;be1c
	or a			;be1d
	ld a,e			;be1e
	or a			;be1f
	and e			;be20
	or a			;be21
	and h			;be22
	or a			;be23
	sbc a,0b7h		;be24
	inc de			;be26
	cp b			;be27
	ld e,(hl)			;be28
	cp b			;be29
	xor c			;be2a
	cp b			;be2b
	pop hl			;be2c
	cp b			;be2d
	dec b			;be2e
	cp c			;be2f
	ld d,c			;be30
	cp c			;be31
	ld h,h			;be32
	cp c			;be33
	xor l			;be34
	cp c			;be35
	jp c,017b9h		;be36
	cp d			;be39
	inc a			;be3a
	cp d			;be3b
	ld (hl),l			;be3c
	cp d			;be3d
	rst 30h			;be3e
	cp d			;be3f
	rra			;be40
	cp e			;be41
	ld d,h			;be42
	cp e			;be43
	and d			;be44
	cp e			;be45
	defb 0ddh,0bbh,007h	;illegal sequence		;be46
	cp h			;be49
	inc (hl)			;be4a
	cp h			;be4b
	ld b,e			;be4c
	cp h			;be4d
	ld d,h			;be4e
	cp h			;be4f
	adc a,d			;be50
	sub c			;be51
	rst 18h			;be52
	adc a,h			;be53
	sub b			;be54
	adc a,a			;be55
	sub b			;be56
	adc a,l			;be57
	adc a,e			;be58
	sbc a,d			;be59
	push af			;be5a
	adc a,d			;be5b
	sub c			;be5c
	sbc a,(hl)			;be5d
	rst 18h			;be5e
	adc a,d			;be5f
	adc a,l			;be60
	sub c			;be61
	sbc a,(hl)			;be62
	push af			;be63
	adc a,d			;be64
	sub c			;be65
	rst 18h			;be66
	sbc a,h			;be67
	sbc a,d			;be68
	adc a,h			;be69
	adc a,e			;be6a
	sub b			;be6b
	push af			;be6c
	adc a,d			;be6d
	sub c			;be6e
	rst 18h			;be6f
	sbc a,d			;be70
	adc a,h			;be71
	adc a,e			;be72
	sbc a,(hl)			;be73
	sub c			;be74
	adc a,e			;be75
	sbc a,d			;be76
	push af			;be77
	push af			;be78
	push af			;be79
	push af			;be7a
	push af			;be7b
	adc a,d			;be7c
	sub c			;be7d
	sbc a,(hl)			;be7e
	rst 18h			;be7f
	sub e			;be80
	sub e			;be81
	sbc a,(hl)			;be82
	adc a,c			;be83
	sbc a,d			;be84
	push af			;be85
	adc a,d			;be86
	sub c			;be87
	rst 18h			;be88
	sbc a,h			;be89
	sbc a,(hl)			;be8a
	add a,l			;be8b
	sub b			;be8c
	push af			;be8d
	adc a,d			;be8e
	sub c			;be8f
	rst 18h			;be90
	sbc a,(hl)			;be91
	sub c			;be92
	sub (hl)			;be93
	sub e			;be94
	sub e			;be95
	sub b			;be96
	push af			;be97
	adc a,d			;be98
	sub c			;be99
	sbc a,(hl)			;be9a
	rst 18h			;be9b
	sbc a,d			;be9c
	adc a,h			;be9d
	sbc a,c			;be9e
	sbc a,d			;be9f
	adc a,l			;bea0
	sbc a,(hl)			;bea1
	rst 18h			;bea2
	sub e			;bea3
	adc a,d			;bea4
	sub d			;bea5
	sub (hl)			;bea6
	sub c			;bea7
	sub b			;bea8
	adc a,h			;bea9
	sbc a,(hl)			;beaa
	push af			;beab
	adc a,d			;beac
	sub c			;bead
	sbc a,(hl)			;beae
	rst 18h			;beaf
	sbc a,d			;beb0
	adc a,h			;beb1
	sbc a,c			;beb2
	sbc a,d			;beb3
	adc a,l			;beb4
	sbc a,(hl)			;beb5
	push af			;beb6
	adc a,d			;beb7
	sub c			;beb8
	rst 18h			;beb9
	sub a			;beba
	sub b			;bebb
	sub c			;bebc
	sbc a,b			;bebd
	sub b			;bebe
	push af			;bebf
	adc a,d			;bec0
	sub c			;bec1
	rst 18h			;bec2
	adc a,e			;bec3
	adc a,l			;bec4
	sub b			;bec5
	sub c			;bec6
	sbc a,h			;bec7
	sub b			;bec8
	push af			;bec9
	adc a,d			;beca
	sub c			;becb
	sbc a,(hl)			;becc
	rst 18h			;becd
	sbc a,h			;bece
	sbc a,(hl)			;becf
	sub e			;bed0
	sbc a,(hl)			;bed1
	adc a,c			;bed2
	sbc a,d			;bed3
	adc a,l			;bed4
	sbc a,(hl)			;bed5
	push af			;bed6
	adc a,d			;bed7
	sub c			;bed8
	rst 18h			;bed9
	sbc a,l			;beda
	sbc a,(hl)			;bedb
	adc a,h			;bedc
	adc a,e			;bedd
	rst 20h			;bede
	sub c			;bedf
	rst 18h			;bee0
	sbc a,e			;bee1
	sbc a,d			;bee2
	rst 18h			;bee3
	sub d			;bee4
	sbc a,(hl)			;bee5
	sub c			;bee6
	sbc a,e			;bee7
	sub b			;bee8
	push af			;bee9
	adc a,d			;beea
	sub c			;beeb
	sbc a,(hl)			;beec
	rst 18h			;beed
	sbc a,h			;beee
	sbc a,(hl)			;beef
	sbc a,h			;bef0
	sub a			;bef1
	sub (hl)			;bef2
	adc a,a			;bef3
	sub b			;bef4
	adc a,l			;bef5
	adc a,l			;bef6
	sbc a,(hl)			;bef7
	push af			;bef8
	adc a,d			;bef9
	sub c			;befa
	rst 18h			;befb
	sub d			;befc
	sbc a,(hl)			;befd
	add a,l			;befe
	sub b			;beff
	push af			;bf00
	adc a,d			;bf01
	sub c			;bf02
	sbc a,(hl)			;bf03
	rst 18h			;bf04
	adc a,c			;bf05
	sbc a,(hl)			;bf06
	adc a,h			;bf07
	sub (hl)			;bf08
	sub l			;bf09
	sbc a,(hl)			;bf0a
	push af			;bf0b
	adc a,d			;bf0c
	sub c			;bf0d
	sbc a,(hl)			;bf0e
	rst 18h			;bf0f
	sbc a,(hl)			;bf10
	sub e			;bf11
	sbc a,c			;bf12
	sub b			;bf13
	sub d			;bf14
	sbc a,l			;bf15
	adc a,l			;bf16
	sub (hl)			;bf17
	sub e			;bf18
	sub e			;bf19
	sbc a,(hl)			;bf1a
	push af			;bf1b
	adc a,d			;bf1c
	sub c			;bf1d
	rst 18h			;bf1e
	sbc a,d			;bf1f
	sub l			;bf20
	sbc a,d			;bf21
	sub d			;bf22
	adc a,a			;bf23
	sub e			;bf24
	sbc a,(hl)			;bf25
	adc a,l			;bf26
	rst 18h			;bf27
	sbc a,e			;bf28
	sbc a,d			;bf29
	sub e			;bf2a
	rst 18h			;bf2b
	xor a			;bf2c
	sub b			;bf2d
	adc a,a			;bf2e
	sub b			;bf2f
	sub e			;bf30
	rst 18h			;bf31
	xor c			;bf32
	adc a,d			;bf33
	sub a			;bf34
	push af			;bf35
	adc a,d			;bf36
	sub c			;bf37
	rst 18h			;bf38
	sbc a,d			;bf39
	sub l			;bf3a
	sbc a,d			;bf3b
	sub d			;bf3c
	adc a,a			;bf3d
	sub e			;bf3e
	sbc a,(hl)			;bf3f
	adc a,l			;bf40
	rst 18h			;bf41
	sbc a,e			;bf42
	sbc a,d			;bf43
	sub e			;bf44
	rst 18h			;bf45
	cp h			;bf46
	sub a			;bf47
	sub (hl)			;bf48
	sub e			;bf49
	sbc a,(hl)			;bf4a
	sub c			;bf4b
	rst 18h			;bf4c
	cp l			;bf4d
	sbc a,(hl)			;bf4e
	sub e			;bf4f
	sbc a,(hl)			;bf50
	sub d			;bf51
	push af			;bf52
	adc a,d			;bf53
	sub c			;bf54
	rst 18h			;bf55
	sbc a,d			;bf56
	sub l			;bf57
	sbc a,d			;bf58
	sub d			;bf59
	adc a,a			;bf5a
	sub e			;bf5b
	sbc a,(hl)			;bf5c
	adc a,l			;bf5d
	rst 18h			;bf5e
	sbc a,e			;bf5f
	sbc a,d			;bf60
	rst 18h			;bf61
	sub e			;bf62
	sub b			;bf63
	adc a,h			;bf64
	rst 18h			;bf65
	cp (hl)			;bf66
	sub c			;bf67
	sbc a,(hl)			;bf68
	sub e			;bf69
	sbc a,d			;bf6a
	adc a,h			;bf6b
	rst 18h			;bf6c
	sbc a,e			;bf6d
	sbc a,d			;bf6e
	rst 18h			;bf6f
	sub e			;bf70
	sub b			;bf71
	adc a,h			;bf72
	rst 18h			;bf73
	cp h			;bf74
	sbc a,(hl)			;bf75
	sub h			;bf76
	sbc a,h			;bf77
	sub a			;bf78
	sub (hl)			;bf79
	adc a,(hl)			;bf7a
	adc a,d			;bf7b
	sbc a,d			;bf7c
	sub e			;bf7d
	sbc a,d			;bf7e
	adc a,h			;bf7f
	push af			;bf80
	adc a,d			;bf81
	sub c			;bf82
	rst 18h			;bf83
	sbc a,d			;bf84
	sub l			;bf85
	sbc a,d			;bf86
	sub d			;bf87
	adc a,a			;bf88
	sub e			;bf89
	sbc a,(hl)			;bf8a
	adc a,l			;bf8b
	rst 18h			;bf8c
	sbc a,e			;bf8d
	sbc a,d			;bf8e
	sub e			;bf8f
	rst 18h			;bf90
	or e			;bf91
	sub (hl)			;bf92
	sbc a,l			;bf93
	adc a,l			;bf94
	sub b			;bf95
	rst 18h			;bf96
	sbc a,e			;bf97
	sbc a,d			;bf98
	rst 18h			;bf99
	sub e			;bf9a
	sub b			;bf9b
	adc a,h			;bf9c
	rst 18h			;bf9d
	xor h			;bf9e
	sbc a,d			;bf9f
	push hl			;bfa0
	sub b			;bfa1
	adc a,l			;bfa2
	sbc a,d			;bfa3
	adc a,h			;bfa4
	rst 18h			;bfa5
	sbc a,e			;bfa6
	sbc a,d			;bfa7
	rst 18h			;bfa8
	xor e			;bfa9
	sub b			;bfaa
	adc a,e			;bfab
	sub b			;bfac
	sub c			;bfad
	sub (hl)			;bfae
	sbc a,h			;bfaf
	sbc a,(hl)			;bfb0
	adc a,a			;bfb1
	sbc a,(hl)			;bfb2
	sub c			;bfb3
	push af			;bfb4
	adc a,d			;bfb5
	sub c			;bfb6
	rst 18h			;bfb7
	sbc a,d			;bfb8
	adc a,h			;bfb9
	adc a,a			;bfba
	sbc a,d			;bfbb
	sub l			;bfbc
	sub b			;bfbd
	push af			;bfbe
	adc a,d			;bfbf
	sub c			;bfc0
	sbc a,(hl)			;bfc1
	rst 18h			;bfc2
	adc a,l			;bfc3
	sub b			;bfc4
	adc a,h			;bfc5
	sbc a,(hl)			;bfc6
	rst 18h			;bfc7
	sbc a,e			;bfc8
	sbc a,d			;bfc9
	sub e			;bfca
	rst 18h			;bfcb
	sbc a,e			;bfcc
	sbc a,d			;bfcd
	adc a,h			;bfce
	sub (hl)			;bfcf
	sbc a,d			;bfd0
	adc a,l			;bfd1
	adc a,e			;bfd2
	sub b			;bfd3
	push af			;bfd4
	adc a,d			;bfd5
	sub c			;bfd6
	rst 18h			;bfd7
	adc a,a			;bfd8
	adc a,d			;bfd9
	push hl			;bfda
	sbc a,(hl)			;bfdb
	sbc a,e			;bfdc
	sub b			;bfdd
	rst 18h			;bfde
	sbc a,e			;bfdf
	sbc a,d			;bfe0
	rst 18h			;bfe1
	adc a,a			;bfe2
	and 09eh		;bfe3
	adc a,h			;bfe5
	rst 18h			;bfe6
	sbc a,e			;bfe7
	sbc a,d			;bfe8
	rst 18h			;bfe9
	sbc a,h			;bfea
	sbc a,(hl)			;bfeb
	sbc a,h			;bfec
	adc a,e			;bfed
	adc a,d			;bfee
	adc a,h			;bfef
	push af			;bff0
	adc a,d			;bff1
	sub c			;bff2
	rst 18h			;bff3
	adc a,l			;bff4
	sbc a,(hl)			;bff5
	sbc a,h			;bff6
	sub (hl)			;bff7
	sub d			;bff8
	sub b			;bff9
	rst 18h			;bffa
	sbc a,e			;bffb
	sbc a,d			;bffc
	rst 18h			;bffd
	sbc a,e			;bffe
	jp pe,0968bh		;bfff
	sub e			;c002
	sbc a,d			;c003
	adc a,h			;c004
	push af			;c005
	adc a,d			;c006
	sub c			;c007
	sbc a,(hl)			;c008
	rst 18h			;c009
	sbc a,d			;c00a
	adc a,h			;c00b
	adc a,a			;c00c
	sbc a,(hl)			;c00d
	sbc a,e			;c00e
	sbc a,(hl)			;c00f
	push af			;c010
	adc a,d			;c011
	sub c			;c012
	rst 18h			;c013
	adc a,e			;c014
	adc a,l			;c015
	sub b			;c016
	add a,l			;c017
	sub b			;c018
	rst 18h			;c019
	sbc a,e			;c01a
	sbc a,d			;c01b
	rst 18h			;c01c
	sbc a,h			;c01d
	sbc a,d			;c01e
	adc a,l			;c01f
	sbc a,(hl)			;c020
	push af			;c021
	adc a,d			;c022
	sub c			;c023
	sub b			;c024
	adc a,h			;c025
	rst 18h			;c026
	adc a,e			;c027
	sbc a,(hl)			;c028
	adc a,a			;c029
	sub b			;c02a
	sub c			;c02b
	sbc a,d			;c02c
	adc a,h			;c02d
	rst 18h			;c02e
	sbc a,e			;c02f
	sbc a,d			;c030
	rst 18h			;c031
	sbc a,h			;c032
	sbc a,d			;c033
	adc a,l			;c034
	sbc a,(hl)			;c035
	push af			;c036
	adc a,d			;c037
	sub c			;c038
	rst 18h			;c039
	sbc a,c			;c03a
	sub (hl)			;c03b
	sub e			;c03c
	adc a,e			;c03d
	adc a,l			;c03e
	sub b			;c03f
	rst 18h			;c040
	sub d			;c041
	jp pe,09698h		;c042
	sbc a,h			;c045
	sub b			;c046
	push af			;c047
	adc a,d			;c048
	sub c			;c049
	sbc a,(hl)			;c04a
	rst 18h			;c04b
	sbc a,l			;c04c
	sub b			;c04d
	adc a,e			;c04e
	sbc a,d			;c04f
	sub e			;c050
	sub e			;c051
	sbc a,(hl)			;c052
	push af			;c053
	adc a,d			;c054
	sub c			;c055
	sbc a,(hl)			;c056
	rst 18h			;c057
	sub l			;c058
	sbc a,(hl)			;c059
	adc a,l			;c05a
	adc a,l			;c05b
	sbc a,(hl)			;c05c
	rst 18h			;c05d
	sbc a,h			;c05e
	sub b			;c05f
	sub c			;c060
	rst 18h			;c061
	sub d			;c062
	sub (hl)			;c063
	sbc a,d			;c064
	sub e			;c065
	push af			;c066
	adc a,d			;c067
	sub c			;c068
	sbc a,(hl)			;c069
	rst 18h			;c06a
	sub d			;c06b
	jp pe,09c8ch		;c06c
	sbc a,(hl)			;c06f
	adc a,l			;c070
	sbc a,(hl)			;c071
	push af			;c072
	sub e			;c073
	sbc a,(hl)			;c074
	adc a,h			;c075
	rst 18h			;c076
	sbc a,c			;c077
	adc a,l			;c078
	adc a,d			;c079
	adc a,e			;c07a
	sbc a,(hl)			;c07b
	adc a,h			;c07c
	rst 18h			;c07d
	sbc a,e			;c07e
	sbc a,d			;c07f
	rst 18h			;c080
	sub h			;c081
	sbc a,(hl)			;c082
	adc a,a			;c083
	adc a,a			;c084
	sub b			;c085
	sub h			;c086
	push af			;c087
	ld d,b			;c088
	cp (hl)			;c089
	ld e,e			;c08a
	cp (hl)			;c08b
	ld h,h			;c08c
	cp (hl)			;c08d
	ld l,l			;c08e
	cp (hl)			;c08f
	ld a,b			;c090
	cp (hl)			;c091
	ld a,c			;c092
	cp (hl)			;c093
	ld a,d			;c094
	cp (hl)			;c095
	ld a,e			;c096
	cp (hl)			;c097
	ld a,h			;c098
	cp (hl)			;c099
	add a,(hl)			;c09a
	cp (hl)			;c09b
	adc a,(hl)			;c09c
	cp (hl)			;c09d
	sbc a,b			;c09e
	cp (hl)			;c09f
	xor h			;c0a0
	cp (hl)			;c0a1
	or a			;c0a2
	cp (hl)			;c0a3
	ret nz			;c0a4
	cp (hl)			;c0a5
	jp z,0d7beh		;c0a6
	cp (hl)			;c0a9
	jp pe,0f9beh		;c0aa
	cp (hl)			;c0ad
	ld bc,00cbfh		;c0ae
	cp a			;c0b1
	inc e			;c0b2
	cp a			;c0b3
	ld (hl),0bfh		;c0b4
	ld d,e			;c0b6
	cp a			;c0b7
	add a,c			;c0b8
	cp a			;c0b9
	or l			;c0ba
	cp a			;c0bb
	cp a			;c0bc
	cp a			;c0bd
	push de			;c0be
	cp a			;c0bf
	pop af			;c0c0
	cp a			;c0c1
	ld b,0c0h		;c0c2
	ld de,022c0h		;c0c4
	ret nz			;c0c7
	scf			;c0c8
	ret nz			;c0c9
	ld c,b			;c0ca
	ret nz			;c0cb
	ld d,h			;c0cc
	ret nz			;c0cd
	ld h,a			;c0ce
	ret nz			;c0cf
	ld (hl),e			;c0d0
	ret nz			;c0d1
	jp p,07f7fh		;c0d2
	ld a,a			;c0d5
	ld a,a			;c0d6
	ld a,a			;c0d7
	ld a,a			;c0d8
	ld a,a			;c0d9
	ld a,a			;c0da
	jp p,0f2f2h		;c0db
	ld a,c			;c0de
	rst 18h			;c0df
	rst 18h			;c0e0
	rst 18h			;c0e1
	cp h			;c0e2
	or a			;c0e3
	or (hl)			;c0e4
	cp h			;c0e5
	or a			;c0e6
	cp d			;c0e7
	or c			;c0e8
	rst 18h			;c0e9
	or (hl)			;c0ea
	xor e			;c0eb
	and l			;c0ec
	cp (hl)			;c0ed
	rst 18h			;c0ee
	jp nc,0b6dfh		;c0ef
	or (hl)			;c0f2
	rst 18h			;c0f3
	xor a			;c0f4
	cp (hl)			;c0f5
	xor l			;c0f6
	xor e			;c0f7
	cp d			;c0f8
	jp p,0df79h		;c0f9
	rst 18h			;c0fc
	rst 18h			;c0fd
	ld (hl),b			;c0fe
	ld (hl),b			;c0ff
	ld (hl),b			;c100
	ld (hl),b			;c101
	jp nz,0c2c2h		;c102
	jp p,0f2f2h		;c105
	ld a,c			;c108
	rst 18h			;c109
	rst 18h			;c10a
	cp e			;c10b
	sub (hl)			;c10c
	inc a			;c10d
	sbc a,h			;c10e
	ld b,e			;c10f
	inc hl			;c110
	push bc			;c111
	rst 18h			;c112
	cp (hl)			;c113
	sub c			;c114
	sbc a,e			;c115
	adc a,l			;c116
	jp (hl)			;c117
	add hl,hl			;c118
	xor h			;c119
	nop			;c11a
	adc a,d			;c11b
	scf			;c11c
	sub b			;c11d
	jp p,0dff2h		;c11e
	rst 18h			;c121
	rst 18h			;c122
	rst 18h			;c123
	xor a			;c124
	jr $-102		;c125
	dec de			;c127
	ld (02343h),hl		;c128
	push bc			;c12b
	rst 18h			;c12c
	or l			;c12d
	adc a,d			;c12e
	ld c,d			;c12f
	rst 18h			;c130
	or d			;c131
	ld c,d			;c132
	adc a,d			;c133
	ld d,(hl)			;c134
	or d			;c135
	add hl,de			;c136
	ld a,09eh		;c137
	jp p,079f2h		;c139
	ld a,c			;c13c
	cp b			;c13d
	adc a,l			;c13e
	jp pe,00899h		;c13f
	ld b,(hl)			;c142
	push bc			;c143
	rst 18h			;c144
	xor a			;c145
	dec h			;c146
	ld d,d			;c147
	and l			;c148
	ld c,e			;c149
	daa			;c14a
	jp p,079f2h		;c14b
	ld a,c			;c14e
	rst 18h			;c14f
	rst 18h			;c150
	rst 18h			;c151
	cp h			;c152
	ld c,e			;c153
	sub e			;c154
	ld e,(hl)			;c155
	or d			;c156
	ld c,e			;c157
	inc sp			;c158
	jp (hl)			;c159
	adc a,h			;c15a
	jp p,079f2h		;c15b
	cp (hl)			;c15e
	sbc a,e			;c15f
	sbc a,(hl)			;c160
	adc a,a			;c161
	ld b,b			;c162
	ld b,e			;c163
	inc hl			;c164
	rst 18h			;c165
	dec (hl)			;c166
	add a,a			;c167
	jr nc,$-57		;c168
	rst 18h			;c16a
	or l			;c16b
	adc a,d			;c16c
	ld c,d			;c16d
	sub l			;c16e
	ld d,d			;c16f
	or d			;c170
	adc a,d			;c171
	push hl			;c172
	sub b			;c173
	add a,l			;c174
	jp p,079f2h		;c175
	ld a,c			;c178
	xor a			;c179
	adc a,l			;c17a
	adc a,d			;c17b
	sbc a,d			;c17c
	sbc a,l			;c17d
	ld c,h			;c17e
	push bc			;c17f
	rst 18h			;c180
	cp d			;c181
	adc a,c			;c182
	ld d,e			;c183
	xor h			;c184
	sbc a,(hl)			;c185
	ld e,02eh		;c186
	ld d,c			;c188
	jp p,07ff2h		;c189
	ld a,a			;c18c
	ld a,a			;c18d
	ld a,a			;c18e
	ld a,a			;c18f
	ld a,a			;c190
	ld a,a			;c191
	ld a,a			;c192
	jp p,0f4f3h		;c193
	cp l			;c196
	sbc a,(hl)			;c197
	sub l			;c198
	ld c,h			;c199
	ld l,e			;c19a
	sub (hl)			;c19b
	ld d,l			;c19c
	ld sp,07b49h		;c19d
	ld d,e			;c1a0
	adc a,a			;c1a1
	dec b			;c1a2
	rrca			;c1a3
	ld b,c			;c1a4
	ld d,b			;c1a5
	add a,(hl)			;c1a6
	ld l,c			;c1a7
	adc a,h			;c1a8
	ld c,l			;c1a9
	ld b,c			;c1aa
	sbc a,(hl)			;c1ab
	ld l,l			;c1ac
	ld b,e			;c1ad
	ld d,c			;c1ae
	adc a,l			;c1af
	ld d,e			;c1b0
	ld b,a			;c1b1
	sbc a,(hl)			;c1b2
	ld l,(hl)			;c1b3
	ld l,0d1h		;c1b4
	push af			;c1b6
	ld e,l			;c1b7
	jp pe,09229h		;c1b8
	ld h,d			;c1bb
	dec sp			;c1bc
	jp p,0f5f5h		;c1bd
	push af			;c1c0
	push af			;c1c1
	push af			;c1c2
	push af			;c1c3
	push af			;c1c4
	push af			;c1c5
	push af			;c1c6
	ld e,l			;c1c7
	inc a			;c1c8
	ld hl,00f5ah		;c1c9
	ld c,e			;c1cc
	ld e,d			;c1cd
	dec c			;c1ce
	inc (hl)			;c1cf
	ex af,af'			;c1d0
	ld e,e			;c1d1
	ld l,e			;c1d2
	ld e,l			;c1d3
	ld d,b			;c1d4
	add a,(hl)			;c1d5
	ld a,b			;c1d6
	inc (hl)			;c1d7
	halt			;c1d8
	scf			;c1d9
	add a,l			;c1da
	sub b			;c1db
	ld l,d			;c1dc
	ld d,(hl)			;c1dd
	ld a,(09044h)		;c1de
	ccf			;c1e1
	xor c			;c1e2
	ld c,a			;c1e3
	ld a,h			;c1e4
	ld b,d			;c1e5
	sub c			;c1e6
	ld d,e			;c1e7
	ld c,(hl)			;c1e8
	ld l,h			;c1e9
	adc a,l			;c1ea
	ld a,09ch		;c1eb
	inc hl			;c1ed
	ld e,a			;c1ee
	sbc a,(hl)			;c1ef
	ld l,h			;c1f0
	sub d			;c1f1
	sbc a,d			;c1f2
	ld b,a			;c1f3
	ld d,d			;c1f4
	inc d			;c1f5
	dec hl			;c1f6
	ld d,b			;c1f7
	ld b,h			;c1f8
	ld de,0146ch		;c1f9
	adc a,a			;c1fc
	ld c,c			;c1fd
	dec (hl)			;c1fe
	push af			;c1ff
	cp h			;c200
	rrca			;c201
	ld c,e			;c202
	ld e,d			;c203
	dec c			;c204
	inc (hl)			;c205
	ex af,af'			;c206
	ld e,e			;c207
	ld a,l			;c208
	ld a,(0688ch)		;c209
	ld (hl),a			;c20c
	ld e,l			;c20d
	sbc a,d			;c20e
	ld e,a			;c20f
	ld (hl),l			;c210
	rst 18h			;c211
	add a,(hl)			;c212
	ld a,b			;c213
	inc (hl)			;c214
	halt			;c215
	scf			;c216
	add a,l			;c217
	ld d,d			;c218
	ld e,b			;c219
	sbc a,h			;c21a
	ld c,(hl)			;c21b
	sbc a,e			;c21c
	ld h,h			;c21d
	push af			;c21e
	cp d			;c21f
	sub c			;c220
	ld h,(hl)			;c221
	ld d,b			;c222
	sub e			;c223
	adc a,d			;c224
	sbc a,b			;c225
	ld c,e			;c226
	ld d,h			;c227
	add a,(hl)			;c228
	ld l,h			;c229
	adc a,a			;c22a
	ld c,h			;c22b
	sub (hl)			;c22c
	jr z,$-110		;c22d
	ld a,(hl)			;c22f
	inc l			;c230
	sub l			;c231
	ld d,e			;c232
	add a,(hl)			;c233
	ld a,h			;c234
	adc a,h			;c235
	ld c,l			;c236
	ld b,c			;c237
	sbc a,(hl)			;c238
	ld l,e			;c239
	ld (hl),l			;c23a
	ccf			;c23b
	or e			;c23c
	ld c,h			;c23d
	ld l,b			;c23e
	ld (hl),a			;c23f
	ld c,a			;c240
	adc a,e			;c241
	jp pe,02d0bh		;c242
	rra			;c245
	ld d,c			;c246
	ld b,b			;c247
	ld l,(hl)			;c248
	sub a			;c249
	ld c,b			;c24a
	sbc a,b			;c24b
	ld b,(hl)			;c24c
	push af			;c24d
	ld e,l			;c24e
	inc a			;c24f
	ld hl,00f5ah		;c250
	ld c,e			;c253
	sbc a,(hl)			;c254
	ld a,e			;c255
	sbc a,(hl)			;c256
	ld a,(hl)			;c257
	ld h,077h		;c258
	adc a,h			;c25a
	ld c,l			;c25b
	dec b			;c25c
	ld l,e			;c25d
	xor h			;c25e
	ld b,d			;c25f
	rst 18h			;c260
	sub b			;c261
	ld a,l			;c262
	inc (hl)			;c263
	rst 18h			;c264
	halt			;c265
	scf			;c266
	add a,l			;c267
	sub b			;c268
	ld a,(hl)			;c269
	dec e			;c26a
	add hl,bc			;c26b
	ld d,b			;c26c
	inc l			;c26d
	inc b			;c26e
	ld e,c			;c26f
	ccf			;c270
	cp d			;c271
	sub c			;c272
	ld a,h			;c273
	adc a,a			;c274
	ld c,e			;c275
	add hl,de			;c276
	dec d			;c277
	ld c,a			;c278
	ld l,h			;c279
	sbc a,h			;c27a
	ld c,d			;c27b
	ld c,l			;c27c
	inc hl			;c27d
	ld a,l			;c27e
	ld b,h			;c27f
	ld a,(hl)			;c280
	adc a,h			;c281
	ld d,b			;c282
	scf			;c283
	adc a,h			;c284
	ld b,a			;c285
	sub (hl)			;c286
	sbc a,l			;c287
	adc a,d			;c288
	add a,(hl)			;c289
	ld d,b			;c28a
	ld (0538ah),a		;c28b
	ld d,e			;c28e
	sub b			;c28f
	ld b,a			;c290
	ld h,c			;c291
	adc a,h			;c292
	ld c,l			;c293
	ld c,h			;c294
	push af			;c295
	ld e,l			;c296
	ld d,e			;c297
	adc a,h			;c298
	ld c,l			;c299
	sbc a,(hl)			;c29a
	ld l,l			;c29b
	ld c,(hl)			;c29c
	dec l			;c29d
	ld c,(hl)			;c29e
	ld b,a			;c29f
	sbc a,(hl)			;c2a0
	ld l,d			;c2a1
	sub d			;c2a2
	sbc a,d			;c2a3
	scf			;c2a4
	sub b			;c2a5
	ld a,e			;c2a6
	ld d,e			;c2a7
	ld c,a			;c2a8
	sbc a,h			;c2a9
	ld c,l			;c2aa
	ld d,c			;c2ab
	sbc a,(hl)			;c2ac
	out (07eh),a		;c2ad
	ld h,077h		;c2af
	adc a,d			;c2b1
	adc a,h			;c2b2
	ld c,e			;c2b3
	ld l,b			;c2b4
	ld d,e			;c2b5
	ld a,(08d1fh)		;c2b6
	rst 18h			;c2b9
	ld d,d			;c2ba
	inc l			;c2bb
	sub l			;c2bc
	ld c,e			;c2bd
	ccf			;c2be
	cp (hl)			;c2bf
	ld c,0b1h		;c2c0
	ld c,c			;c2c2
	dec (hl)			;c2c3
	ld d,h			;c2c4
	inc e			;c2c5
	sub b			;c2c6
	ld b,a			;c2c7
	ld d,e			;c2c8
	adc a,h			;c2c9
	ld c,l			;c2ca
	ld b,c			;c2cb
	sbc a,(hl)			;c2cc
	ld b,l			;c2cd
	add a,(hl)			;c2ce
	ld h,a			;c2cf
	ld a,(09044h)		;c2d0
	out (07dh),a		;c2d3
	dec h			;c2d5
	ld b,e			;c2d6
	inc hl			;c2d7
	ld h,l			;c2d8
	ld c,l			;c2d9
	sbc a,b			;c2da
	and 091h		;c2db
	dec d			;c2dd
	add hl,sp			;c2de
	sbc a,h			;c2df
	jp pe,0d391h		;c2e0
	ld (hl),d			;c2e3
	rst 18h			;c2e4
	ld a,09ch		;c2e5
	ld c,d			;c2e7
	ld e,b			;c2e8
	sbc a,h			;c2e9
	ld h,h			;c2ea
	push af			;c2eb
	cp e			;c2ec
	sbc a,d			;c2ed
	ld h,(hl)			;c2ee
	sbc a,(hl)			;c2ef
	ld h,(hl)			;c2f0
	ld c,d			;c2f1
	ld b,e			;c2f2
	ld d,e			;c2f3
	adc a,h			;c2f4
	rst 20h			;c2f5
	sub e			;c2f6
	ld d,d			;c2f7
	ld h,077h		;c2f8
	adc a,h			;c2fa
	ld c,l			;c2fb
	dec b			;c2fc
	ld a,l			;c2fd
	ld b,h			;c2fe
	halt			;c2ff
	scf			;c300
	add a,l			;c301
	ld d,d			;c302
	ld c,h			;c303
	sbc a,h			;c304
	ld c,(hl)			;c305
	sbc a,e			;c306
	ld h,h			;c307
	ccf			;c308
	cp d			;c309
	sub c			;c30a
	ld a,h			;c30b
	adc a,a			;c30c
	ld c,e			;c30d
	add hl,de			;c30e
	dec d			;c30f
	ld e,h			;c310
	dec l			;c311
	sbc a,(hl)			;c312
	ld b,a			;c313
	ld d,d			;c314
	sub c			;c315
	sub (hl)			;c316
	ld hl,0f546h		;c317
	cp e			;c31a
	ld c,a			;c31b
	jr c,$+104		;c31c
	ld d,e			;c31e
	sbc a,(hl)			;c31f
	cpl			;c320
	ld d,05ah		;c321
	rrca			;c323
	ld c,e			;c324
	ld d,e			;c325
	ld h,077h		;c326
	ld a,(08d1fh)		;c328
	rst 18h			;c32b
	ld d,d			;c32c
	inc l			;c32d
	sub l			;c32e
	ld c,e			;c32f
	ld a,l			;c330
	sub e			;c331
	ld d,e			;c332
	ld c,a			;c333
	sbc a,h			;c334
	ld c,l			;c335
	ld d,c			;c336
	sbc a,(hl)			;c337
	ld a,(hl)			;c338
	sub e			;c339
	ld e,d			;c33a
	adc a,l			;c33b
	adc a,d			;c33c
	add a,l			;c33d
	sbc a,(hl)			;c33e
	ccf			;c33f
	or a			;c340
	ld (hl),h			;c341
	ld d,(hl)			;c342
	xor h			;c343
	ld b,d			;c344
	ld d,h			;c345
	add a,(hl)			;c346
	ld l,h			;c347
	adc a,a			;c348
	ld c,h			;c349
	sub (hl)			;c34a
	jr z,$-110		;c34b
	ld b,l			;c34d
	sbc a,l			;c34e
	jr nz,$+53		;c34f
	sbc a,d			;c351
	ld h,b			;c352
	ld a,l			;c353
	inc (hl)			;c354
	ld d,e			;c355
	adc a,h			;c356
	rst 20h			;c357
	sub e			;c358
	ld b,c			;c359
	ld d,e			;c35a
	adc a,a			;c35b
	ld h,d			;c35c
	sbc a,(hl)			;c35d
	push af			;c35e
	cp h			;c35f
	rrca			;c360
	ld c,e			;c361
	sbc a,(hl)			;c362
	ld h,(hl)			;c363
	inc a			;c364
	ld hl,00d5ah		;c365
	inc (hl)			;c368
	ex af,af'			;c369
	ld e,e			;c36a
	rst 18h			;c36b
	sub a			;c36c
	ld (hl),h			;c36d
	ld d,(hl)			;c36e
	or c			;c36f
	ld c,c			;c370
	dec (hl)			;c371
	ld e,a			;c372
	ld e,b			;c373
	sbc a,e			;c374
	ld d,b			;c375
	dec l			;c376
	add a,(hl)			;c377
	ld d,d			;c378
	ld a,(05244h)		;c379
	inc l			;c37c
	inc b			;c37d
	ld l,h			;c37e
	adc a,a			;c37f
	ld c,h			;c380
	sub (hl)			;c381
	jr z,$+84		;c382
	ld c,a			;c384
	sbc a,h			;c385
	ld c,l			;c386
	ld c,b			;c387
	ld h,b			;c388
	push af			;c389
	cp h			;c38a
	rrca			;c38b
	ld c,e			;c38c
	ld e,d			;c38d
	dec c			;c38e
	inc (hl)			;c38f
	ex af,af'			;c390
	ld e,e			;c391
	ld l,e			;c392
	ld e,l			;c393
	sbc a,d			;c394
	ld e,a			;c395
	sub a			;c396
	ld (hl),h			;c397
	sbc a,(hl)			;c398
	inc l			;c399
	sub l			;c39a
	sub b			;c39b
	ld a,l			;c39c
	inc (hl)			;c39d
	halt			;c39e
	scf			;c39f
	add a,l			;c3a0
	sub b			;c3a1
	push af			;c3a2
	cp e			;c3a3
	sbc a,d			;c3a4
	ld h,(hl)			;c3a5
	ld d,e			;c3a6
	adc a,h			;c3a7
	ld c,l			;c3a8
	ld d,e			;c3a9
	ld h,077h		;c3aa
	ld a,(08d1fh)		;c3ac
	ld a,l			;c3af
	ld d,(hl)			;c3b0
	sub a			;c3b1
	sbc a,(hl)			;c3b2
	rra			;c3b3
	rla			;c3b4
	ld c,l			;c3b5
	halt			;c3b6
	scf			;c3b7
	add a,l			;c3b8
	ld d,d			;c3b9
	ld d,d			;c3ba
	adc a,h			;c3bb
	ld c,l			;c3bc
	dec b			;c3bd
	ld l,e			;c3be
	ld (hl),l			;c3bf
	push af			;c3c0
	xor c			;c3c1
	ld e,h			;c3c2
	adc a,h			;c3c3
	ld c,l			;c3c4
	ld b,c			;c3c5
	ld h,c			;c3c6
	ld c,e			;c3c7
	ld sp,07d2ch		;c3c8
	inc (hl)			;c3cb
	halt			;c3cc
	scf			;c3cd
	add a,l			;c3ce
	ld d,d			;c3cf
	ld c,a			;c3d0
	sbc a,h			;c3d1
	ld c,l			;c3d2
	ld c,b			;c3d3
	ld h,b			;c3d4
	rst 18h			;c3d5
	add a,(hl)			;c3d6
	ld h,a			;c3d7
	ld e,l			;c3d8
	sbc a,d			;c3d9
	ld a,l			;c3da
	inc (hl)			;c3db
	halt			;c3dc
	sub l			;c3dd
	sbc a,d			;c3de
	ccf			;c3df
	cp (hl)			;c3e0
	sub e			;c3e1
	inc a			;c3e2
	jr c,$-99		;c3e3
	ld c,c			;c3e5
	ld a,d			;c3e6
	adc a,a			;c3e7
	ld c,h			;c3e8
	sbc a,(hl)			;c3e9
	scf			;c3ea
	add a,l			;c3eb
	ld d,d			;c3ec
	adc a,c			;c3ed
	ld e,h			;c3ee
	sbc a,b			;c3ef
	dec de			;c3f0
	sbc a,l			;c3f1
	ld h,b			;c3f2
	ld l,(hl)			;c3f3
	xor e			;c3f4
	sbc a,d			;c3f5
	add a,l			;c3f6
	dec a			;c3f7
	adc a,e			;c3f8
	ld d,012h		;c3f9
	dec a			;c3fb
	push af			;c3fc
	ld e,l			;c3fd
	sbc a,(hl)			;c3fe
	ld h,(hl)			;c3ff
	ld c,d			;c400
	ld b,e			;c401
	sbc a,(hl)			;c402
	ld b,l			;c403
	jr c,$+57		;c404
	sbc a,h			;c406
	ld e,e			;c407
	rst 18h			;c408
	ld d,e			;c409
	xor e			;c40a
	sbc a,d			;c40b
	add a,l			;c40c
	dec a			;c40d
	adc a,e			;c40e
	ld d,012h		;c40f
	dec a			;c411
	ld b,l			;c412
	ld (hl),e			;c413
	ld bc,0684ch		;c414
	ld (hl),a			;c417
	sbc a,c			;c418
	ld c,c			;c419
	sub d			;c41a
	ld e,e			;c41b
	ld l,(hl)			;c41c
	ld h,093h		;c41d
	ld b,c			;c41f
	ld d,e			;c420
	sub b			;c421
	sbc a,l			;c422
	adc a,h			;c423
	ld b,c			;c424
	sub (hl)			;c425
	ld c,d			;c426
	sbc a,(hl)			;c427
	ccf			;c428
	xor d			;c429
	sub c			;c42a
	halt			;c42b
	scf			;c42c
	add a,l			;c42d
	ld d,d			;c42e
	ld c,a			;c42f
	sbc a,h			;c430
	ld c,l			;c431
	ld c,b			;c432
	ld h,b			;c433
	rst 18h			;c434
	sbc a,h			;c435
	ld c,b			;c436
	sbc a,e			;c437
	adc a,d			;c438
	sbc a,h			;c439
	ld d,b			;c43a
	sub a			;c43b
	ld (hl),h			;c43c
	sbc a,(hl)			;c43d
	inc l			;c43e
	sub l			;c43f
	dec sp			;c440
	push af			;c441
	cp (hl)			;c442
	ld c,096h		;c443
	add hl,bc			;c445
	ld c,l			;c446
	ld a,(hl)			;c447
	sub b			;c448
	ld b,a			;c449
	ld h,c			;c44a
	sbc a,h			;c44b
	rrca			;c44c
	ld c,e			;c44d
	ld c,h			;c44e
	out (066h),a		;c44f
	ld d,e			;c451
	ld (hl),e			;c452
	rst 18h			;c453
	adc a,h			;c454
	ld c,l			;c455
	ld b,c			;c456
	sbc a,(hl)			;c457
	ld l,e			;c458
	ld e,l			;c459
	sbc a,d			;c45a
	ld e,a			;c45b
	sbc a,(hl)			;c45c
	inc l			;c45d
	sub l			;c45e
	sub b			;c45f
	out (07dh),a		;c460
	inc (hl)			;c462
	halt			;c463
	scf			;c464
	add a,l			;c465
	ld d,d			;c466
	ld c,a			;c467
	sbc a,h			;c468
	ld c,l			;c469
	ld c,b			;c46a
	ld h,b			;c46b
	push af			;c46c
	ld e,l			;c46d
	ld c,d			;c46e
	ld b,e			;c46f
	sbc a,(hl)			;c470
	ld a,(hl)			;c471
	ld h,077h		;c472
	sbc a,(hl)			;c474
	inc l			;c475
	ld e,c			;c476
	sub c			;c477
	ld c,e			;c478
	ld l,e			;c479
	ld (hl),l			;c47a
	rst 18h			;c47b
	sub b			;c47c
	ld a,l			;c47d
	ld c,e			;c47e
	ld sp,0452ch		;c47f
	ld d,e			;c482
	ld b,a			;c483
	ld a,(de)			;c484
	jp (hl)			;c485
	ld l,(hl)			;c486
	inc (hl)			;c487
	halt			;c488
	scf			;c489
	add a,l			;c48a
	sub b			;c48b
	push af			;c48c
	xor d			;c48d
	sub c			;c48e
	ld d,e			;c48f
	sub c			;c490
	adc a,d			;c491
	sbc a,d			;c492
	adc a,c			;c493
	ld d,e			;c494
	adc a,h			;c495
	ld c,l			;c496
	sbc a,(hl)			;c497
	ld b,l			;c498
	adc a,a			;c499
	ld d,c			;c49a
	sub b			;c49b
	ld a,b			;c49c
	ld de,02e68h		;c49d
	dec l			;c4a0
	sub e			;c4a1
	ld c,e			;c4a2
	ld b,c			;c4a3
	sbc a,(hl)			;c4a4
	sbc a,e			;c4a5
	ld h,l			;c4a6
	adc a,e			;c4a7
	ld c,(hl)			;c4a8
	ld d,c			;c4a9
	ld a,h			;c4aa
	sub e			;c4ab
	ld b,(hl)			;c4ac
	sbc a,(hl)			;c4ad
	ld a,(hl)			;c4ae
	inc d			;c4af
	dec hl			;c4b0
	ld c,a			;c4b1
	ld c,l			;c4b2
	sbc a,d			;c4b3
	ld a,d			;c4b4
	ld a,(05244h)		;c4b5
	ld c,(hl)			;c4b8
	ld b,a			;c4b9
	ld d,b			;c4ba
	sbc a,e			;c4bb
	ld e,(hl)			;c4bc
	ld c,e			;c4bd
	sbc a,b			;c4be
	add hl,sp			;c4bf
	sub e			;c4c0
	ld c,h			;c4c1
	push af			;c4c2
	ld e,l			;c4c3
	sbc a,(hl)			;c4c4
	ld h,(hl)			;c4c5
	inc a			;c4c6
	ld hl,00f5ah		;c4c7
	ld c,e			;c4ca
	sbc a,(hl)			;c4cb
	ld (hl),d			;c4cc
	rst 18h			;c4cd
	daa			;c4ce
	sub d			;c4cf
	inc (hl)			;c4d0
	ex af,af'			;c4d1
	ld e,e			;c4d2
	ld l,e			;c4d3
	ld (hl),l			;c4d4
	ld e,a			;c4d5
	sub a			;c4d6
	ld (hl),h			;c4d7
	sbc a,(hl)			;c4d8
	inc l			;c4d9
	sub l			;c4da
	sub b			;c4db
	push af			;c4dc
	ld e,l			;c4dd
	inc a			;c4de
	ld hl,01de8h		;c4df
	sub d			;c4e2
	ld e,d			;c4e3
	rrca			;c4e4
	ld c,e			;c4e5
	sbc a,(hl)			;c4e6
	ld b,l			;c4e7
	sbc a,h			;c4e8
	ld c,h			;c4e9
	sub (hl)			;c4ea
	ld l,h			;c4eb
	dec l			;c4ec
	sbc a,l			;c4ed
	ret pe			;c4ee
	dec l			;c4ef
	jr nz,$+71		;c4f0
	dec l			;c4f2
	add a,(hl)			;c4f3
	ld d,e			;c4f4
	and 091h		;c4f5
	ex af,af'			;c4f7
	ld d,e			;c4f8
	adc a,h			;c4f9
	ld c,l			;c4fa
	ld b,c			;c4fb
	ld d,e			;c4fc
	ld e,h			;c4fd
	sub a			;c4fe
	ld (hl),h			;c4ff
	ld c,e			;c500
	ld sp,07d2ch		;c501
	inc (hl)			;c504
	ld d,e			;c505
	ld c,a			;c506
	sbc a,h			;c507
	ld c,l			;c508
	ld d,c			;c509
	sub (hl)			;c50a
	jr z,$+85		;c50b
	adc a,e			;c50d
	ld c,l			;c50e
	sub e			;c50f
	ld e,e			;c510
	ld l,d			;c511
	sub e			;c512
	ld d,e			;c513
	jr $+63		;c514
	push af			;c516
	push af			;c517
	push af			;c518
	push af			;c519
	cp b			;c51a
	adc a,l			;c51b
	ld c,d			;c51c
	rst 18h			;c51d
	adc a,h			;c51e
	ld c,l			;c51f
	sbc a,(hl)			;c520
	ld a,b			;c521
	adc a,h			;c522
	ld c,l			;c523
	ld b,c			;c524
	ld h,c			;c525
	sub a			;c526
	ld (hl),h			;c527
	ld c,e			;c528
	ld sp,0539dh		;c529
	add a,(hl)			;c52c
	ld l,e			;c52d
	ld e,l			;c52e
	sbc a,d			;c52f
	ccf			;c530
	xor d			;c531
	dec bc			;c532
	sub d			;c533
	ld b,d			;c534
	ld (hl),c			;c535
	inc a			;c536
	ld b,e			;c537
	ld h,h			;c538
	rst 18h			;c539
	sbc a,h			;c53a
	ld c,b			;c53b
	adc a,h			;c53c
	ld b,a			;c53d
	adc a,d			;c53e
	sbc a,h			;c53f
	ld b,e			;c540
	inc hl			;c541
	rst 18h			;c542
	sbc a,l			;c543
	jr nz,$+53		;c544
	sbc a,d			;c546
	ld l,a			;c547
	adc a,h			;c548
	ld c,l			;c549
	ld b,c			;c54a
	ld d,e			;c54b
	ld (hl),l			;c54c
	push af			;c54d
	cp h			;c54e
	ld c,b			;c54f
	sbc a,e			;c550
	adc a,d			;c551
	sbc a,h			;c552
	adc a,e			;c553
	ld d,d			;c554
	ld a,09ch		;c555
	sub e			;c557
	ld a,060h		;c558
	ccf			;c55a
	or e			;c55b
	sbc a,(hl)			;c55c
	ld l,b			;c55d
	adc a,e			;c55e
	ld d,b			;c55f
	ld c,l			;c560
	adc a,e			;c561
	ld d,e			;c562
	inc sp			;c563
	add hl,de			;c564
	sbc a,(hl)			;c565
	ld l,e			;c566
	ld e,l			;c567
	ld d,b			;c568
	add a,(hl)			;c569
	ld l,c			;c56a
	inc l			;c56b
	inc b			;c56c
	ld l,e			;c56d
	ld (hl),l			;c56e
	ccf			;c56f
	or a			;c570
	sbc a,(hl)			;c571
	add a,(hl)			;c572
	ld a,h			;c573
	sbc a,e			;c574
	ld d,c			;c575
	sub (hl)			;c576
	adc a,c			;c577
	sbc a,(hl)			;c578
	ld b,e			;c579
	inc hl			;c57a
	ld l,e			;c57b
	or c			;c57c
	ld c,c			;c57d
	dec (hl)			;c57e
	push af			;c57f
	ld e,l			;c580
	ld e,d			;c581
	rrca			;c582
	ld c,e			;c583
	ld d,e			;c584
	ld (hl),e			;c585
	ld bc,0684ch		;c586
	ld (hl),a			;c589
	jr c,$-98		;c58a
	ld c,c			;c58c
	ld e,e			;c58d
	adc a,h			;c58e
	ld a,b			;c58f
	ld d,(hl)			;c590
	inc a			;c591
	sbc a,h			;c592
	ld c,c			;c593
	adc a,l			;c594
	ld b,c			;c595
	ld d,d			;c596
	adc a,h			;c597
	add hl,sp			;c598
	ld c,e			;c599
	push af			;c59a
	ld e,l			;c59b
	jp pe,04e29h		;c59c
	ld a,h			;c59f
	djnz $+53		;c5a0
	sbc a,d			;c5a2
	push hl			;c5a3
	ret pe			;c5a4
	dec e			;c5a5
	ld (01f54h),hl		;c5a6
	ld b,b			;c5a9
	ld b,e			;c5aa
	inc hl			;c5ab
	ld b,l			;c5ac
	inc sp			;c5ad
	sub (hl)			;c5ae
	add a,l			;c5af
	jp pe,0476ch		;c5b0
	ld c,h			;c5b3
	adc a,e			;c5b4
	ld d,c			;c5b5
	dec sp			;c5b6
	pop de			;c5b7
	push af			;c5b8
	cp b			;c5b9
	adc a,l			;c5ba
	ld c,d			;c5bb
	rst 18h			;c5bc
	dec a			;c5bd
	adc a,c			;c5be
	ld d,c			;c5bf
	sub c			;c5c0
	sbc a,(hl)			;c5c1
	ld a,(hl)			;c5c2
	adc a,h			;c5c3
	ld d,b			;c5c4
	rlca			;c5c5
	ld l,04eh		;c5c6
	jr c,$+109		;c5c8
	ld (hl),l			;c5ca
	ld b,l			;c5cb
	sub a			;c5cc
	ld (hl),h			;c5cd
	ld d,(hl)			;c5ce
	xor h			;c5cf
	ld b,d			;c5d0
	rst 18h			;c5d1
	inc l			;c5d2
	inc b			;c5d3
	ld a,h			;c5d4
	dec de			;c5d5
	cpl			;c5d6
	ld d,e			;c5d7
	jr $-98		;c5d8
	ld b,(hl)			;c5da
	sbc a,(hl)			;c5db
	push af			;c5dc
	cp b			;c5dd
	adc a,l			;c5de
	ld c,d			;c5df
	rst 18h			;c5e0
	dec a			;c5e1
	adc a,c			;c5e2
	ld d,c			;c5e3
	sub c			;c5e4
	sbc a,(hl)			;c5e5
	ld a,(hl)			;c5e6
	adc a,h			;c5e7
	ld d,b			;c5e8
	rlca			;c5e9
	ld l,04eh		;c5ea
	jr c,$+109		;c5ec
	xor h			;c5ee
	ld b,d			;c5ef
	ccf			;c5f0
	xor d			;c5f1
	sub c			;c5f2
	ld d,e			;c5f3
	dec de			;c5f4
	cpl			;c5f5
	ld d,e			;c5f6
	ld a,(0509dh)		;c5f7
	sub a			;c5fa
	ld (hl),h			;c5fb
	ld d,(hl)			;c5fc
	or c			;c5fd
	ld c,c			;c5fe
	dec (hl)			;c5ff
	out (06bh),a		;c600
	ld (hl),l			;c602
	dec d			;c603
	ld c,a			;c604
	ld l,h			;c605
	sub e			;c606
	ld (09652h),a		;c607
	ld d,l			;c60a
	ld sp,0df49h		;c60b
	add a,(hl)			;c60e
	ld l,e			;c60f
	ld e,l			;c610
	sbc a,d			;c611
	ld a,h			;c612
	adc a,e			;c613
	ld c,(hl)			;c614
	sbc a,d			;c615
	dec hl			;c616
	ld b,(hl)			;c617
	ld d,e			;c618
	ld c,(hl)			;c619
	ld b,a			;c61a
	ld e,e			;c61b
	push af			;c61c
	cp b			;c61d
	adc a,l			;c61e
	ld c,d			;c61f
	rst 18h			;c620
	dec a			;c621
	adc a,c			;c622
	ld d,c			;c623
	sub c			;c624
	sbc a,(hl)			;c625
	ld a,(hl)			;c626
	adc a,h			;c627
	ld d,b			;c628
	rlca			;c629
	ld l,04eh		;c62a
	jr c,$+103		;c62c
	or c			;c62e
	ld c,c			;c62f
	adc a,e			;c630
	ld d,b			;c631
	ld d,e			;c632
	xor h			;c633
	ld b,d			;c634
	ld e,a			;c635
	inc l			;c636
	inc b			;c637
	ld l,d			;c638
	adc a,a			;c639
	ld c,(hl)			;c63a
	scf			;c63b
	ld h,h			;c63c
	ld l,e			;c63d
	ld (hl),l			;c63e
	push af			;c63f
	cp b			;c640
	adc a,l			;c641
	ld c,d			;c642
	rst 18h			;c643
	dec a			;c644
	adc a,c			;c645
	ld d,c			;c646
	sub c			;c647
	sbc a,(hl)			;c648
	ld a,(hl)			;c649
	adc a,h			;c64a
	ld d,b			;c64b
	rlca			;c64c
	ld l,04eh		;c64d
	jr c,$+109		;c64f
	or c			;c651
	ld c,c			;c652
	dec (hl)			;c653
	ld e,a			;c654
	inc l			;c655
	inc b			;c656
	ld a,l			;c657
	inc (hl)			;c658
	ld e,d			;c659
	adc a,d			;c65a
	ld c,a			;c65b
	adc a,e			;c65c
	ld d,e			;c65d
	sub a			;c65e
	ld (hl),h			;c65f
	ld d,(hl)			;c660
	ld (hl),l			;c661
	push af			;c662
	or b			;c663
	adc a,h			;c664
	sbc a,h			;c665
	ld b,d			;c666
	ld d,d			;c667
	adc a,l			;c668
	ld a,09ch		;c669
	inc hl			;c66b
	ld a,e			;c66c
	ld e,d			;c66d
	ld a,(de)			;c66e
	ld d,c			;c66f
	sub c			;c670
	ld e,d			;c671
	ld c,b			;c672
	ld a,h			;c673
	ld c,a			;c674
	ld b,a			;c675
	sbc a,d			;c676
	ld hl,01b53h		;c677
	cpl			;c67a
	sbc a,(hl)			;c67b
	ld h,l			;c67c
	ld a,(0419dh)		;c67d
	sbc a,(hl)			;c680
	ld l,e			;c681
	xor h			;c682
	ld b,d			;c683
	push af			;c684
	cp b			;c685
	adc a,l			;c686
	ld c,d			;c687
	rst 18h			;c688
	dec a			;c689
	adc a,c			;c68a
	ld d,c			;c68b
	sub c			;c68c
	sbc a,(hl)			;c68d
	ld a,(hl)			;c68e
	adc a,h			;c68f
	ld d,b			;c690
	rlca			;c691
	ld l,04eh		;c692
	jr c,$+103		;c694
	ld e,l			;c696
	ld d,b			;c697
	ld d,e			;c698
	ld (hl),l			;c699
	ccf			;c69a
	cp (hl)			;c69b
	ld c,0b1h		;c69c
	ld c,c			;c69e
	dec (hl)			;c69f
	ld l,h			;c6a0
	inc a			;c6a1
	djnz $+35		;c6a2
	ld d,d			;c6a4
	inc l			;c6a5
	sub l			;c6a6
	ld d,e			;c6a7
	sbc a,(hl)			;c6a8
	ld a,h			;c6a9
	add a,l			;c6aa
	ld c,b			;c6ab
	ld d,e			;c6ac
	sub d			;c6ad
	jp pe,04629h		;c6ae
	sbc a,h			;c6b1
	ld b,d			;c6b2
	sbc a,(hl)			;c6b3
	ccf			;c6b4
	cp (hl)			;c6b5
	ld c,0ach		;c6b6
	ld b,d			;c6b8
	out (06ch),a		;c6b9
	adc a,a			;c6bb
	ld b,h			;c6bc
	sub (hl)			;c6bd
	inc bc			;c6be
	ld b,(hl)			;c6bf
	ld d,d			;c6c0
	ld e,b			;c6c1
	sub c			;c6c2
	sub (hl)			;c6c3
	adc a,c			;c6c4
	ld d,(hl)			;c6c5
	dec a			;c6c6
	sbc a,d			;c6c7
	ld d,h			;c6c8
	ld b,e			;c6c9
	sbc a,(hl)			;c6ca
	ld a,h			;c6cb
	sub e			;c6cc
	ld (05334h),a		;c6cd
	sub (hl)			;c6d0
	ld d,l			;c6d1
	ld sp,0f549h		;c6d2
	ld e,l			;c6d5
	ld d,e			;c6d6
	inc bc			;c6d7
	ld c,d			;c6d8
	rst 18h			;c6d9
	sbc a,h			;c6da
	rrca			;c6db
	ld c,e			;c6dc
	sbc a,(hl)			;c6dd
	ld h,(hl)			;c6de
	ld d,e			;c6df
	sub b			;c6e0
	dec l			;c6e1
	adc a,a			;c6e2
	ld e,e			;c6e3
	ld a,l			;c6e4
	inc (hl)			;c6e5
	rst 18h			;c6e6
	sbc a,b			;c6e7
	jp (hl)			;c6e8
	sub e			;c6e9
	ld b,c			;c6ea
	ld d,d			;c6eb
	sub e			;c6ec
	ld (09152h),a		;c6ed
	adc a,d			;c6f0
	ld b,a			;c6f1
	ld b,c			;c6f2
	ld (hl),c			;c6f3
	inc (hl)			;c6f4
	rst 18h			;c6f5
	sub d			;c6f6
	ld c,d			;c6f7
	ld c,d			;c6f8
	ld l,04dh		;c6f9
	rst 18h			;c6fb
	sub (hl)			;c6fc
	ld d,l			;c6fd
	ld sp,0df49h		;c6fe
	add a,(hl)			;c701
	ld a,(hl)			;c702
	adc a,h			;c703
	ld d,b			;c704
	adc a,a			;c705
	adc a,l			;c706
	add hl,sp			;c707
	ld c,b			;c708
	sbc a,b			;c709
	ld d,e			;c70a
	sub a			;c70b
	ld (hl),h			;c70c
	ld d,(hl)			;c70d
	ld (hl),l			;c70e
	ccf			;c70f
	ld e,l			;c710
	jp pe,04e29h		;c711
	ld a,h			;c714
	sbc a,h			;c715
	ld c,c			;c716
	sub c			;c717
	sub (hl)			;c718
	adc a,h			;c719
	sbc a,(hl)			;c71a
	ld a,(hl)			;c71b
	adc a,c			;c71c
	sbc a,(hl)			;c71d
	ld h,l			;c71e
	ld e,l			;c71f
	ld d,b			;c720
	ld d,e			;c721
	ld (hl),l			;c722
	ld a,b			;c723
	ld d,(hl)			;c724
	sub e			;c725
	ld (06b90h),a		;c726
	or c			;c729
	ld c,c			;c72a
	adc a,e			;c72b
	ld d,b			;c72c
	add a,(hl)			;c72d
	ld l,h			;c72e
	adc a,a			;c72f
	ld b,h			;c730
	sub (hl)			;c731
	inc bc			;c732
	ld b,(hl)			;c733
	ld d,d			;c734
	sbc a,h			;c735
	ld c,c			;c736
	adc a,e			;c737
	ld h,b			;c738
	ld l,e			;c739
	xor h			;c73a
	ld b,d			;c73b
	push af			;c73c
	ld e,l			;c73d
	sbc a,(hl)			;c73e
	ld l,b			;c73f
	dec (hl)			;c740
	ld a,e			;c741
	ld e,d			;c742
	ld a,(de)			;c743
	ld d,c			;c744
	sub c			;c745
	ld e,d			;c746
	ld c,b			;c747
	adc a,e			;c748
	ld a,0e6h		;c749
	ld d,e			;c74b
	sub a			;c74c
	ld (hl),h			;c74d
	ld d,(hl)			;c74e
	ld (hl),l			;c74f
	ld e,a			;c750
	ld (hl),e			;c751
	ld a,h			;c752
	dec de			;c753
	cpl			;c754
	ld d,e			;c755
	ld c,h			;c756
	sbc a,h			;c757
	ld c,(hl)			;c758
	sbc a,e			;c759
	ld h,h			;c75a
	ld l,e			;c75b
	ld e,l			;c75c
	sbc a,d			;c75d
	push af			;c75e
	xor a			;c75f
	ld c,e			;c760
	dec (hl)			;c761
	ld a,e			;c762
	ld e,d			;c763
	ld a,(de)			;c764
	ld d,c			;c765
	sub c			;c766
	ld d,e			;c767
	sub d			;c768
	adc a,d			;c769
	inc e			;c76a
	ld a,09ch		;c76b
	sub e			;c76d
	ld a,05bh		;c76e
	ld b,l			;c770
	sbc a,h			;c771
	ld c,b			;c772
	ld a,h			;c773
	ld a,(0419dh)		;c774
	sbc a,(hl)			;c777
	ld l,e			;c778
	ld e,l			;c779
	ld d,b			;c77a
	add a,(hl)			;c77b
	ld l,h			;c77c
	sbc a,c			;c77d
	ld h,d			;c77e
	ld d,b			;c77f
	jr c,$-98		;c780
	ld d,089h		;c782
	sbc a,d			;c784
	ld l,e			;c785
	or c			;c786
	ld c,c			;c787
	sub b			;c788
	ld c,a			;c789
	dec (hl)			;c78a
	push af			;c78b
	or a			;c78c
	ld h,c			;c78d
	jr z,$-100		;c78e
	sbc a,b			;c790
	ld h,b			;c791
	ld l,e			;c792
	sbc a,c			;c793
	ld a,04dh		;c794
	ld a,e			;c796
	ld d,e			;c797
	inc bc			;c798
	ld c,d			;c799
	rst 18h			;c79a
	dec a			;c79b
	adc a,c			;c79c
	ld d,c			;c79d
	sub c			;c79e
	ld d,e			;c79f
	ld e,l			;c7a0
	sbc a,d			;c7a1
	jp nc,0f575h		;c7a2
	or e			;c7a5
	ld e,d			;c7a6
	ld c,c			;c7a7
	sub c			;c7a8
	sub (hl)			;c7a9
	adc a,h			;c7aa
	ld d,e			;c7ab
	adc a,h			;c7ac
	add hl,sp			;c7ad
	ld d,d			;c7ae
	ld c,l			;c7af
	sbc a,h			;c7b0
	ld c,d			;c7b1
	add a,l			;c7b2
	sbc a,(hl)			;c7b3
	ld d,h			;c7b4
	ld a,(bc)			;c7b5
	ld l,a			;c7b6
	ld e,040h		;c7b7
	sbc a,e			;c7b9
	rst 18h			;c7ba
	jr c,$+104		;c7bb
	ld e,d			;c7bd
	rrca			;c7be
	ld c,e			;c7bf
	sbc a,(hl)			;c7c0
	ld b,l			;c7c1
	sbc a,e			;c7c2
	ld c,b			;c7c3
	jr c,$+107		;c7c4
	adc a,a			;c7c6
	ld c,e			;c7c7
	add hl,de			;c7c8
	rst 18h			;c7c9
	ld (hl),l			;c7ca
	rst 18h			;c7cb
	sbc a,l			;c7cc
	jr nz,$+53		;c7cd
	sbc a,d			;c7cf
	sbc a,(hl)			;c7d0
	ld h,a			;c7d1
	sbc a,b			;c7d2
	jp (hl)			;c7d3
	sub e			;c7d4
	ld b,c			;c7d5
	ld d,d			;c7d6
	sub e			;c7d7
	ld (0d390h),a		;c7d8
	ld a,(hl)			;c7db
	ld c,l			;c7dc
	rst 18h			;c7dd
	xor h			;c7de
	ld b,d			;c7df
	rst 18h			;c7e0
	sbc a,h			;c7e1
	inc a			;c7e2
	sbc a,(hl)			;c7e3
	ld a,h			;c7e4
	sbc a,h			;c7e5
	ld c,h			;c7e6
	sbc a,h			;c7e7
	ld e,e			;c7e8
	ccf			;c7e9
	cp (hl)			;c7ea
	ld c,090h		;c7eb
	ld b,a			;c7ed
	ld d,d			;c7ee
	sub e			;c7ef
	ld h,b			;c7f0
	ld a,d			;c7f1
	sub e			;c7f2
	ld (0d390h),a		;c7f3
	ld l,d			;c7f6
	sub e			;c7f7
	ld d,d			;c7f8
	ld c,l			;c7f9
	jr nc,$+124		;c7fa
	sbc a,h			;c7fc
	ld c,c			;c7fd
	adc a,e			;c7fe
	ld h,b			;c7ff
	rst 18h			;c800
	or c			;c801
	ld c,c			;c802
	dec (hl)			;c803
	ld b,l			;c804
	adc a,c			;c805
	ld c,a			;c806
	ld l,c			;c807
	ld c,(hl)			;c808
	ld c,c			;c809
	sub d			;c80a
	ld d,b			;c80b
	sub d			;c80c
	ld c,h			;c80d
	sbc a,(hl)			;c80e
	ld a,d			;c80f
	adc a,h			;c810
	add hl,sp			;c811
	ld h,l			;c812
	adc a,a			;c813
	sub (hl)			;c814
	add hl,de			;c815
	dec de			;c816
	push af			;c817
	ld d,a			;c818
	sub e			;c819
	ld (06d90h),a		;c81a
	sbc a,e			;c81d
	ld d,c			;c81e
	dec de			;c81f
	ld (0117dh),hl		;c820
	ld l,b			;c823
	add hl,de			;c824
	rst 18h			;c825
	or c			;c826
	ld c,c			;c827
	dec (hl)			;c828
	ld b,l			;c829
	sbc a,c			;c82a
	ld c,c			;c82b
	ld (07c59h),hl		;c82c
	sbc a,h			;c82f
	ld c,h			;c830
	sbc a,h			;c831
	ld e,e			;c832
	rst 18h			;c833
	sub (hl)			;c834
	ld d,l			;c835
	ld sp,04549h		;c836
	dec l			;c839
	add a,(hl)			;c83a
	ld h,c			;c83b
	sub a			;c83c
	ld b,h			;c83d
	sbc a,(hl)			;c83e
	sbc a,e			;c83f
	ld h,c			;c840
	ld (04c8ah),a		;c841
	ld l,l			;c844
	sbc a,c			;c845
	sub (hl)			;c846
	sub e			;c847
	ld b,a			;c848
	ld c,d			;c849
	rst 18h			;c84a
	sub a			;c84b
	ld (hl),h			;c84c
	add a,l			;c84d
	ld c,b			;c84e
	ld h,c			;c84f
	ld a,099h		;c850
	ld d,c			;c852
	sub (hl)			;c853
	ld c,c			;c854
	ld c,a			;c855
	push af			;c856
	ld d,a			;c857
	sub a			;c858
	sub (hl)			;c859
	ld b,h			;c85a
	sub b			;c85b
	ld a,(hl)			;c85c
	dec l			;c85d
	dec hl			;c85e
	ret pe			;c85f
	ld d,e			;c860
	sub e			;c861
	ld c,h			;c862
	ld l,b			;c863
	ld (hl),a			;c864
	jr c,$+104		;c865
	ld e,d			;c867
	rrca			;c868
	ld c,e			;c869
	sbc a,(hl)			;c86a
	ld l,l			;c86b
	sub a			;c86c
	ld d,e			;c86d
	sbc a,e			;c86e
	ld d,c			;c86f
	inc a			;c870
	adc a,e			;c871
	ld b,c			;c872
	sub b			;c873
	push af			;c874
	or b			;c875
	adc a,h			;c876
	sbc a,h			;c877
	ld b,d			;c878
	ld d,d			;c879
	adc a,e			;c87a
	and 091h		;c87b
	ld d,(hl)			;c87d
	ld de,0518bh		;c87e
	ld c,l			;c881
	ld a,(hl)			;c882
	daa			;c883
	sub d			;c884
	inc (hl)			;c885
	sub (hl)			;c886
	dec a			;c887
	ld a,b			;c888
	sub e			;c889
	ld e,d			;c88a
	ld a,(de)			;c88b
	ld d,c			;c88c
	sub c			;c88d
	ld d,e			;c88e
	adc a,a			;c88f
	adc a,l			;c890
	ld a,043h		;c891
	adc a,a			;c893
	ld c,l			;c894
	ld a,l			;c895
	ld d,(hl)			;c896
	ld (hl),l			;c897
	ld e,a			;c898
	inc l			;c899
	sub l			;c89a
	ld d,e			;c89b
	sub a			;c89c
	ld (hl),h			;c89d
	ld d,(hl)			;c89e
	xor h			;c89f
	ld b,d			;c8a0
	push af			;c8a1
	cp d			;c8a2
	sub c			;c8a3
	ld h,(hl)			;c8a4
	ld e,d			;c8a5
	adc a,d			;c8a6
	sbc a,d			;c8a7
	adc a,c			;c8a8
	ld d,e			;c8a9
	adc a,e			;c8aa
	ld d,c			;c8ab
	sub d			;c8ac
	ld a,04dh		;c8ad
	ld h,a			;c8af
	nop			;c8b0
	rra			;c8b1
	ld h,h			;c8b2
	ld (hl),d			;c8b3
	rst 18h			;c8b4
	sub a			;c8b5
	ld b,h			;c8b6
	ld h,b			;c8b7
	rst 18h			;c8b8
	add a,(hl)			;c8b9
	ld l,c			;c8ba
	ld b,a			;c8bb
	sub (hl)			;c8bc
	adc a,h			;c8bd
	dec (hl)			;c8be
	add a,l			;c8bf
	ld d,e			;c8c0
	ld e,h			;c8c1
	ld a,099h		;c8c2
	ld a,096h		;c8c4
	ld b,b			;c8c6
	push af			;c8c7
	cp d			;c8c8
	sub c			;c8c9
	ld h,(hl)			;c8ca
	ld d,b			;c8cb
	adc a,e			;c8cc
	rst 20h			;c8cd
	adc a,l			;c8ce
	adc a,l			;c8cf
	ld b,c			;c8d0
	ld d,d			;c8d1
	adc a,a			;c8d2
	ld b,d			;c8d3
	sbc a,b			;c8d4
	sbc a,(hl)			;c8d5
	adc a,e			;c8d6
	ld c,c			;c8d7
	sub (hl)			;c8d8
	ld (hl),c			;c8d9
	ld c,e			;c8da
	ld c,(hl)			;c8db
	sbc a,(hl)			;c8dc
	ld e,a			;c8dd
	adc a,h			;c8de
	add hl,sp			;c8df
	rst 18h			;c8e0
	ld c,a			;c8e1
	ld l,d			;c8e2
	ld d,(hl)			;c8e3
	and 091h		;c8e4
	ex af,af'			;c8e6
	ld d,d			;c8e7
	sub e			;c8e8
	adc a,d			;c8e9
	sbc a,b			;c8ea
	ld c,e			;c8eb
	rst 18h			;c8ec
	sbc a,e			;c8ed
	ld c,b			;c8ee
	sbc a,e			;c8ef
	ld d,b			;c8f0
	ld h,077h		;c8f1
	ld c,(hl)			;c8f3
	sbc a,h			;c8f4
	ld c,b			;c8f5
	ld b,a			;c8f6
	ld c,e			;c8f7
	rst 18h			;c8f8
	dec a			;c8f9
	sbc a,h			;c8fa
	rla			;c8fb
	ld l,(hl)			;c8fc
	adc a,e			;c8fd
	ld c,d			;c8fe
	rst 18h			;c8ff
	rlca			;c900
	ld b,a			;c901
	sbc a,(hl)			;c902
	push hl			;c903
	ld d,e			;c904
	ld c,a			;c905
	djnz $+69		;c906
	sbc a,d			;c908
	push af			;c909
	push af			;c90a
	push af			;c90b
	or b			;c90c
	ld b,a			;c90d
	ld d,e			;c90e
	adc a,c			;c90f
	sbc a,d			;c910
	add a,l			;c911
	ld h,a			;c912
	ld e,b			;c913
	sub (hl)			;c914
	ld d,c			;c915
	jr nc,$+65		;c916
	or a			;c918
	ld (hl),h			;c919
	ld d,(hl)			;c91a
	ld (hl),l			;c91b
	ld l,l			;c91c
	adc a,c			;c91d
	sbc a,d			;c91e
	ld a,h			;c91f
	sbc a,h			;c920
	add hl,sp			;c921
	inc h			;c922
	sub c			;c923
	sbc a,(hl)			;c924
	ld h,l			;c925
	sub a			;c926
	inc h			;c927
	sub b			;c928
	push af			;c929
	cp e			;c92a
	ld c,a			;c92b
	jr c,$+104		;c92c
	ld d,e			;c92e
	inc a			;c92f
	sbc a,b			;c930
	sub (hl)			;c931
	inc hl			;c932
	rst 18h			;c933
	jp pe,0418dh		;c934
	sbc a,(hl)			;c937
	ld e,a			;c938
	ld e,b			;c939
	add hl,sp			;c93a
	ld e,e			;c93b
	ld b,l			;c93c
	adc a,h			;c93d
	rst 20h			;c93e
	sub e			;c93f
	ld d,d			;c940
	sub e			;c941
	ld h,c			;c942
	sbc a,c			;c943
	ld c,c			;c944
	ld (04843h),hl		;c945
	ld e,h			;c948
	jr $-98		;c949
	ld b,(hl)			;c94b
	ld c,h			;c94c
	ld h,e			;c94d
	daa			;c94e
	ld d,l			;c94f
	cpl			;c950
	sub e			;c951
	ld c,d			;c952
	push af			;c953
	push af			;c954
	ccf			;c955
	or a			;c956
	ld (hl),h			;c957
	ld d,(hl)			;c958
	xor h			;c959
	ld b,d			;c95a
	sub b			;c95b
	ld c,a			;c95c
	dec (hl)			;c95d
	ld d,h			;c95e
	add a,(hl)			;c95f
	ld a,h			;c960
	ld c,(hl)			;c961
	ld c,c			;c962
	sub d			;c963
	ld d,b			;c964
	jr $+63		;c965
	push af			;c967
	cp (hl)			;c968
	ld c,09eh		;c969
	cpl			;c96b
	ld c,e			;c96c
	sub b			;c96d
	ld a,e			;c96e
	ld d,e			;c96f
	jr $+63		;c970
	ld l,l			;c972
	sub a			;c973
	ld c,d			;c974
	rst 18h			;c975
	sbc a,c			;c976
	ld c,c			;c977
	sub d			;c978
	ld h,b			;c979
	rst 18h			;c97a
	sub c			;c97b
	inc h			;c97c
	ld d,c			;c97d
	ld b,(hl)			;c97e
	ld h,c			;c97f
	adc a,l			;c980
	ld b,(hl)			;c981
	ld c,h			;c982
	ld a,d			;c983
	ld e,b			;c984
	sub (hl)			;c985
	ld d,c			;c986
	jr nc,$-9		;c987
	or e			;c989
	ld h,c			;c98a
	sbc a,e			;c98b
	sbc a,(hl)			;c98c
	ld l,093h		;c98d
	ld d,c			;c98f
	ld h,c			;c990
	add a,(hl)			;c991
	ld l,c			;c992
	adc a,c			;c993
	ld d,c			;c994
	sbc a,e			;c995
	ld d,b			;c996
	sub a			;c997
	sub (hl)			;c998
	ld d,c			;c999
	sbc a,l			;c99a
	ld d,e			;c99b
	adc a,h			;c99c
	ld c,b			;c99d
	rst 18h			;c99e
	sub d			;c99f
	adc a,d			;c9a0
	ld c,a			;c9a1
	ld b,a			;c9a2
	ld h,c			;c9a3
	jr c,$+128		;c9a4
	ld c,(hl)			;c9a6
	ld h,(hl)			;c9a7
	ld d,b			;c9a8
	sub b			;c9a9
	ld c,h			;c9aa
	sub (hl)			;c9ab
	adc a,h			;c9ac
	ld d,h			;c9ad
	inc e			;c9ae
	sbc a,l			;c9af
	ld c,h			;c9b0
	ld b,b			;c9b1
	ld d,l			;c9b2
	rst 18h			;c9b3
	sub a			;c9b4
	inc h			;c9b5
	add hl,de			;c9b6
	sbc a,(hl)			;c9b7
	sbc a,e			;c9b8
	push af			;c9b9
	or e			;c9ba
	ld e,d			;c9bb
	ld c,l			;c9bc
	add a,l			;c9bd
	ld e,e			;c9be
	ld a,e			;c9bf
	ld e,(hl)			;c9c0
	cp b			;c9c1
	sub (hl)			;c9c2
	sbc a,b			;c9c3
	sbc a,(hl)			;c9c4
	ld d,l			;c9c5
	adc a,h			;c9c6
	ld (hl),d			;c9c7
	rst 18h			;c9c8
	sbc a,c			;c9c9
	ld c,c			;c9ca
	sub d			;c9cb
	ld e,e			;c9cc
	ld a,l			;c9cd
	sbc a,c			;c9ce
	ld c,c			;c9cf
	ld (04843h),hl		;c9d0
	sbc a,d			;c9d3
	ld l,(hl)			;c9d4
	sbc a,l			;c9d5
	ld c,h			;c9d6
	ld c,l			;c9d7
	adc a,e			;c9d8
	ld d,d			;c9d9
	nop			;c9da
	ld c,b			;c9db
	adc a,e			;c9dc
	ld c,b			;c9dd
	ld e,e			;c9de
	adc a,h			;c9df
	push af			;c9e0
	xor e			;c9e1
	sbc a,d			;c9e2
	ld d,h			;c9e3
	jr z,$+78		;c9e4
	ld l,d			;c9e6
	ld d,(hl)			;c9e7
	sbc a,h			;c9e8
	ld c,(hl)			;c9e9
	ld b,a			;c9ea
	sub b			;c9eb
	ld a,e			;c9ec
	ld e,d			;c9ed
	ld c,l			;c9ee
	add a,l			;c9ef
	ld e,e			;c9f0
	push af			;c9f1
	ld d,a			;c9f2
	rlca			;c9f3
	ld b,a			;c9f4
	sbc a,d			;c9f5
	sub d			;c9f6
	ld d,d			;c9f7
	adc a,h			;c9f8
	ld b,d			;c9f9
	ld a,e			;c9fa
	ld e,d			;c9fb
	ld c,l			;c9fc
	add a,l			;c9fd
	ld e,e			;c9fe
	rst 18h			;c9ff
	adc a,a			;ca00
	adc a,l			;ca01
	ld c,a			;ca02
	ld c,(hl)			;ca03
	adc a,e			;ca04
	ld l,a			;ca05
	ld e,08ch		;ca06
	sub d			;ca08
	ld e,d			;ca09
	ld c,b			;ca0a
	sbc a,c			;ca0b
	sub (hl)			;ca0c
	sbc a,b			;ca0d
	ld b,d			;ca0e
	sbc a,(hl)			;ca0f
	ld b,e			;ca10
	inc hl			;ca11
	rst 18h			;ca12
	sbc a,b			;ca13
	sbc a,d			;ca14
	add hl,sp			;ca15
	rst 20h			;ca16
	sbc a,b			;ca17
	sub (hl)			;ca18
	dec a			;ca19
	push af			;ca1a
	xor e			;ca1b
	ld d,b			;ca1c
	sub a			;ca1d
	ld h,c			;ca1e
	sub d			;ca1f
	ld (bc),a			;ca20
	ld b,c			;ca21
	sub b			;ca22
	ld l,d			;ca23
	sub e			;ca24
	ld d,e			;ca25
	ld e,08ch		;ca26
	sub d			;ca28
	ret pe			;ca29
	dec e			;ca2a
	sub d			;ca2b
	ld d,e			;ca2c
	add hl,bc			;ca2d
	ld c,e			;ca2e
	ld b,c			;ca2f
	sbc a,(hl)			;ca30
	ld h,l			;ca31
	xor h			;ca32
	sub (hl)			;ca33
	adc a,a			;ca34
	dec h			;ca35
	ccf			;ca36
	cp (hl)			;ca37
	adc a,a			;ca38
	ld c,a			;ca39
	adc a,e			;ca3a
	ld d,e			;ca3b
	ld d,e			;ca3c
	adc a,l			;ca3d
	ld c,d			;ca3e
	ld b,e			;ca3f
	sub b			;ca40
	ld e,a			;ca41
	jr nc,$-99		;ca42
	sub b			;ca44
	ld (hl),d			;ca45
	rst 18h			;ca46
	sub d			;ca47
	adc a,d			;ca48
	inc e			;ca49
	ld e,b			;ca4a
	ld c,c			;ca4b
	sbc a,e			;ca4c
	ld c,(hl)			;ca4d
	ld h,b			;ca4e
	push af			;ca4f
	cp d			;ca50
	sub c			;ca51
	ld h,(hl)			;ca52
	ld d,b			;ca53
	sub e			;ca54
	adc a,d			;ca55
	sbc a,b			;ca56
	ld c,e			;ca57
	ld d,h			;ca58
	inc e			;ca59
	inc (hl)			;ca5a
	ld h,c			;ca5b
	rlca			;ca5c
	ld b,a			;ca5d
	sbc a,(hl)			;ca5e
	push hl			;ca5f
	ret pe			;ca60
	dec e			;ca61
	sub d			;ca62
	ld h,c			;ca63
	sbc a,c			;ca64
	ld c,c			;ca65
	ld (04843h),hl		;ca66
	ld e,h			;ca69
	jr $-98		;ca6a
	ld b,(hl)			;ca6c
	ld c,h			;ca6d
	ld b,l			;ca6e
	ld c,l			;ca6f
	sbc a,b			;ca70
	inc (hl)			;ca71
	ld c,h			;ca72
	ld l,d			;ca73
	inc bc			;ca74
	adc a,d			;ca75
	adc a,a			;ca76
	ld b,(hl)			;ca77
	ld b,l			;ca78
	sub b			;ca79
	ld b,a			;ca7a
	ld c,h			;ca7b
	ld l,d			;ca7c
	adc a,a			;ca7d
	ld c,e			;ca7e
	sbc a,d			;ca7f
	sub l			;ca80
	ld h,c			;ca81
	inc e			;ca82
	ld c,l			;ca83
	sbc a,b			;ca84
	inc (hl)			;ca85
	sbc a,(hl)			;ca86
	ld a,(hl)			;ca87
	sub b			;ca88
	ld b,a			;ca89
	ld d,e			;ca8a
	adc a,h			;ca8b
	add hl,sp			;ca8c
	sub (hl)			;ca8d
	adc a,e			;ca8e
	ld c,e			;ca8f
	sub (hl)			;ca90
	sbc a,(hl)			;ca91
	push af			;ca92
	xor a			;ca93
	ld c,c			;ca94
	ld h,(hl)			;ca95
	ld d,b			;ca96
	or e			;ca97
	adc a,d			;ca98
	sbc a,b			;ca99
	ld c,e			;ca9a
	rst 18h			;ca9b
	or a			;ca9c
	inc h			;ca9d
	sbc a,d			;ca9e
	sbc a,(hl)			;ca9f
	ld d,l			;caa0
	ld l,l			;caa1
	ld c,a			;caa2
	dec a			;caa3
	adc a,a			;caa4
	sbc a,(hl)			;caa5
	ld a,e			;caa6
	ld d,e			;caa7
	ld l,051h		;caa8
	adc a,l			;caaa
	ld l,a			;caab
	sbc a,c			;caac
	ld b,d			;caad
	sub (hl)			;caae
	ld d,e			;caaf
	adc a,c			;cab0
	add hl,sp			;cab1
	sbc a,h			;cab2
	jp pe,09691h		;cab3
	dec a			;cab6
	ld l,d			;cab7
	sbc a,c			;cab8
	ld c,c			;cab9
	ld (08b65h),hl		;caba
	rst 20h			;cabd
	add a,a			;cabe
	ex af,af'			;cabf
	ld e,(hl)			;cac0
	sbc a,b			;cac1
	ld c,h			;cac2
	ld c,a			;cac3
	push af			;cac4
	xor e			;cac5
	sub b			;cac6
	sbc a,e			;cac7
	ld l,a			;cac8
	ld de,0519bh		;cac9
	sbc a,(hl)			;cacc
	ld a,d			;cacd
	adc a,c			;cace
	add hl,sp			;cacf
	sbc a,h			;cad0
	jp pe,0ac0bh		;cad1
	sub (hl)			;cad4
	adc a,a			;cad5
	jp pe,0df9ch		;cad6
	inc a			;cad9
	adc a,e			;cada
	inc h			;cadb
	sbc a,l			;cadc
	ld d,e			;cadd
	add a,(hl)			;cade
	ld l,l			;cadf
	ld c,a			;cae0
	ld b,a			;cae1
	sbc a,d			;cae2
	sub d			;cae3
	inc de			;cae4
	sbc a,d			;cae5
	ld a,b			;cae6
	ld d,(hl)			;cae7
	adc a,a			;cae8
	jr $-101		;cae9
	adc a,d			;caeb
	ld e,c			;caec
	rst 18h			;caed
	adc a,l			;caee
	adc a,d			;caef
	sbc a,b			;caf0
	ld b,c			;caf1
	sub b			;caf2
	ld a,d			;caf3
	sbc a,b			;caf4
	sub (hl)			;caf5
	sbc a,b			;caf6
	sbc a,(hl)			;caf7
	ld d,l			;caf8
	push af			;caf9
	xor d			;cafa
	sub c			;cafb
	ld d,e			;cafc
	ld c,l			;cafd
	adc a,e			;cafe
	ld d,e			;caff
	sub d			;cb00
	ld b,d			;cb01
	ld c,l			;cb02
	sub e			;cb03
	ld d,e			;cb04
	inc bc			;cb05
	ld c,d			;cb06
	ret pe			;cb07
	ld l,03dh		;cb08
	ld l,l			;cb0a
	ld c,l			;cb0b
	add a,l			;cb0c
	ld d,e			;cb0d
	sbc a,(hl)			;cb0e
	ld d,l			;cb0f
	rst 18h			;cb10
	adc a,e			;cb11
	ret pe			;cb12
	ccf			;cb13
	or c			;cb14
	sbc a,d			;cb15
	inc bc			;cb16
	ld e,(hl)			;cb17
	sbc a,l			;cb18
	adc a,d			;cb19
	sub (hl)			;cb1a
	ld b,a			;cb1b
	ld e,h			;cb1c
	sbc a,b			;cb1d
	dec b			;cb1e
	ld c,d			;cb1f
	ld l,d			;cb20
	sub e			;cb21
	ld d,d			;cb22
	ld c,l			;cb23
	jr nc,$-9		;cb24
	ld e,l			;cb26
	ld b,06ah		;cb27
	sub e			;cb29
	ld d,e			;cb2a
	jr nz,$-98		;cb2b
	ld c,l			;cb2d
	ld b,c			;cb2e
	sbc a,(hl)			;cb2f
	sbc a,e			;cb30
	ld a,d			;cb31
	adc a,a			;cb32
	ld c,h			;cb33
	sub b			;cb34
	push af			;cb35
	xor d			;cb36
	sub c			;cb37
	ld l,b			;cb38
	sbc a,(hl)			;cb39
	scf			;cb3a
	dec e			;cb3b
	dec h			;cb3c
	ld d,d			;cb3d
	adc a,c			;cb3e
	ld c,l			;cb3f
	sub e			;cb40
	sbc a,d			;cb41
	ld l,l			;cb42
	sbc a,(hl)			;cb43
	dec hl			;cb44
	ld d,b			;cb45
	sbc a,c			;cb46
	adc a,l			;cb47
	ld h,h			;cb48
	rst 18h			;cb49
	ld d,e			;cb4a
	ld l,0f5h		;cb4b
	or e			;cb4d
	ld d,e			;cb4e
	sub (hl)			;cb4f
	cpl			;cb50
	ld c,b			;cb51
	ld h,h			;cb52
	rst 18h			;cb53
	sub d			;cb54
	ld c,h			;cb55
	ld d,e			;cb56
	adc a,c			;cb57
	sbc a,d			;cb58
	sbc a,b			;cb59
	ld (bc),a			;cb5a
	ld c,l			;cb5b
	ld h,l			;cb5c
	or h			;cb5d
	sbc a,(hl)			;cb5e
	adc a,a			;cb5f
	ld (de),a			;cb60
	sbc a,h			;cb61
	sub h			;cb62
	out (067h),a		;cb63
	cp (hl)			;cb65
	adc a,l			;cb66
	sbc a,l			;cb67
	add hl,sp			;cb68
	ld a,e			;cb69
	ld d,e			;cb6a
	xor c			;cb6b
	ld b,c			;cb6c
	sbc a,(hl)			;cb6d
	ld b,l			;cb6e
	sbc a,e			;cb6f
	dec c			;cb70
	ld a,053h		;cb71
	jr nc,$-99		;cb73
	sub b			;cb75
	ld h,(hl)			;cb76
	ld d,b			;cb77
	inc h			;cb78
	dec hl			;cb79
	ret pe			;cb7a
	ld d,d			;cb7b
	adc a,l			;cb7c
	ld a,09ch		;cb7d
	inc hl			;cb7f
	push af			;cb80
	xor l			;cb81
	inc de			;cb82
	ld c,c			;cb83
	adc a,l			;cb84
	ld c,a			;cb85
	ld l,h			;cb86
	sbc a,c			;cb87
	jr $+91		;cb88
	adc a,h			;cb8a
	ld d,d			;cb8b
	adc a,h			;cb8c
	ld c,(hl)			;cb8d
	sbc a,e			;cb8e
	ld d,c			;cb8f
	sub b			;cb90
	push af			;cb91
	ld e,l			;cb92
	jp pe,04e29h		;cb93
	ld l,h			;cb96
	add a,(hl)			;cb97
	ld d,c			;cb98
	sub d			;cb99
	ld d,d			;cb9a
	adc a,h			;cb9b
	ld c,(hl)			;cb9c
	sbc a,e			;cb9d
	ld d,c			;cb9e
	sub b			;cb9f
	push af			;cba0
	ld e,l			;cba1
	ld b,06ah		;cba2
	ld d,(hl)			;cba4
	or e			;cba5
	adc a,d			;cba6
	sbc a,b			;cba7
	ld c,e			;cba8
	ld a,d			;cba9
	or b			;cbaa
	sub e			;cbab
	adc a,c			;cbac
	ld b,c			;cbad
	sub b			;cbae
	ld b,l			;cbaf
	sbc a,e			;cbb0
	ld c,b			;cbb1
	sbc a,e			;cbb2
	ld d,b			;cbb3
	adc a,c			;cbb4
	ld (0014ah),a		;cbb5
	ld e,(hl)			;cbb8
	defb 0ddh,092h,062h	;illegal sequence		;cbb9
	ld b,(hl)			;cbbc
	ld l,d			;cbbd
	sub d			;cbbe
	ld h,d			;cbbf
	sbc a,d			;cbc0
	defb 0ddh,0f5h,05dh	;illegal sequence		;cbc1
	ld b,06ah		;cbc4
	sub e			;cbc6
	ld d,d			;cbc7
	ld c,l			;cbc8
	adc a,e			;cbc9
	ld d,d			;cbca
	jr c,$+126		;cbcb
	djnz $+53		;cbcd
	sbc a,d			;cbcf
	push hl			;cbd0
	ld d,e			;cbd1
	jr nz,$-108		;cbd2
	ld d,e			;cbd4
	ld e,b			;cbd5
	jr c,$+107		;cbd6
	dec l			;cbd8
	ld c,l			;cbd9
	rst 18h			;cbda
	ld e,b			;cbdb
	ld b,e			;cbdc
	ld c,(hl)			;cbdd
	jr c,$+126		;cbde
	dec de			;cbe0
	cpl			;cbe1
	sbc a,(hl)			;cbe2
	ld d,h			;cbe3
	ld a,(bc)			;cbe4
	ld l,a			;cbe5
	adc a,a			;cbe6
	ld h,d			;cbe7
	sbc a,(hl)			;cbe8
	ld a,d			;cbe9
	adc a,a			;cbea
	ld c,l			;cbeb
	sbc a,(hl)			;cbec
	ld b,e			;cbed
	ld (hl),c			;cbee
	or h			;cbef
	adc a,d			;cbf0
	sub h			;cbf1
	adc a,d			;cbf2
	sub e			;cbf3
	sub h			;cbf4
	jp pe,0f591h		;cbf5
	ld e,l			;cbf8
	ld b,06bh		;cbf9
	sbc a,c			;cbfb
	ld a,04dh		;cbfc
	ld a,e			;cbfe
	ld d,e			;cbff
	dec de			;cc00
	cpl			;cc01
	sbc a,(hl)			;cc02
	ld b,l			;cc03
	sbc a,(hl)			;cc04
	ld d,l			;cc05
	ld l,c			;cc06
	adc a,a			;cc07
	ld h,d			;cc08
	sbc a,(hl)			;cc09
	ld a,d			;cc0a
	adc a,a			;cc0b
	ld c,l			;cc0c
	sbc a,(hl)			;cc0d
	ld b,e			;cc0e
	sub b			;cc0f
	push af			;cc10
	xor e			;cc11
	ld d,b			;cc12
	ld c,(hl)			;cc13
	dec l			;cc14
	ld c,(hl)			;cc15
	ld b,a			;cc16
	ld h,c			;cc17
	sbc a,c			;cc18
	adc a,l			;cc19
	ld h,h			;cc1a
	rst 18h			;cc1b
	or h			;cc1c
	adc a,d			;cc1d
	sub h			;cc1e
	adc a,d			;cc1f
	sub e			;cc20
	sub h			;cc21
	jp pe,03f91h		;cc22
	ld d,a			;cc25
	scf			;cc26
	ld e,(hl)			;cc27
	ld (0381bh),a		;cc28
	sbc a,h			;cc2b
	sbc a,d			;cc2c
	ld a,b			;cc2d
	ld a,(08cdfh)		;cc2e
	ld c,b			;cc31
	ld sp,0538ch		;cc32
	rla			;cc35
	dec d			;cc36
	ld c,l			;cc37
	ld c,c			;cc38
	rst 18h			;cc39
	add a,(hl)			;cc3a
	ld h,e			;cc3b
	sub a			;cc3c
	dec h			;cc3d
	sbc a,d			;cc3e
	ld l,h			;cc3f
	sub b			;cc40
	sbc a,l			;cc41
	adc a,h			;cc42
	sbc a,d			;cc43
	inc sp			;cc44
	sub (hl)			;cc45
	sub b			;cc46
	out (07ch),a		;cc47
	djnz $+53		;cc49
	sbc a,d			;cc4b
	push hl			;cc4c
	ld d,e			;cc4d
	djnz $+66		;cc4e
	dec a			;cc50
	pop de			;cc51
	di			;cc52
	call p,0b2ddh		;cc53
	ld c,c			;cc56
	adc a,e			;cc57
	ld c,l			;cc58
	out (066h),a		;cc59
	ld d,b			;cc5b
	sub b			;cc5c
	sbc a,l			;cc5d
	sub l			;cc5e
	ld (bc),a			;cc5f
	ld d,d			;cc60
	sbc a,h			;cc61
	ld c,b			;cc62
	ld (hl),e			;cc63
	rst 18h			;cc64
	jr nc,$-99		;cc65
	ld e,(hl)			;cc67
	sub e			;cc68
	ld e,(hl)			;cc69
	sub d			;cc6a
	ld c,l			;cc6b
	ld c,a			;cc6c
	ld e,a			;cc6d
	ld e,b			;cc6e
	scf			;cc6f
	ld hl,07e4ch		;cc70
	adc a,e			;cc73
	ld d,b			;cc74
	ld c,a			;cc75
	adc a,a			;cc76
	ld d,c			;cc77
	ld c,d			;cc78
	ld l,d			;cc79
	rla			;cc7a
	ld bc,0984bh		;cc7b
	ld d,e			;cc7e
	adc a,c			;cc7f
	ld b,c			;cc80
	ld (hl),0ddh		;cc81
	di			;cc83
	call p,048bch		;cc84
	ld a,h			;cc87
	adc a,h			;cc88
	ld c,b			;cc89
	ld sp,09e8ch		;cc8a
	out (067h),a		;cc8d
	scf			;cc8f
	ld e,(hl)			;cc90
	ld e,b			;cc91
	sbc a,(hl)			;cc92
	adc a,a			;cc93
	ld c,e			;cc94
	inc de			;cc95
	inc c			;cc96
	di			;cc97
	call p,02bbeh		;cc98
	ld c,a			;cc9b
	ld l,c			;cc9c
	djnz $+66		;cc9d
	dec a			;cc9f
	ld a,b			;cca0
	sub d			;cca1
	ld c,d			;cca2
	ld e,(hl)			;cca3
	dec (hl)			;cca4
	sub d			;cca5
	sbc a,l			;cca6
	sub e			;cca7
	ld c,c			;cca8
	ld b,(hl)			;cca9
	ld c,h			;ccaa
	ld l,b			;ccab
	ld d,e			;ccac
	rlca			;ccad
	nop			;ccae
	ld a,04bh		;ccaf
	rst 18h			;ccb1
	ld a,(027dfh)		;ccb2
	ld d,l			;ccb5
	sub c			;ccb6
	ld b,c			;ccb7
	dec sp			;ccb8
	ld hl,(0d2f5h)		;ccb9
	ret nz			;ccbc
	or a			;ccbd
	pop bc			;ccbe
	cp a			;ccbf
	pop bc			;ccc0
	ret nz			;ccc1
	pop bc			;ccc2
	pop bc			;ccc3
	pop bc			;ccc4
	jp nz,0c3c1h		;ccc5
	pop bc			;ccc8
	call nz,0c5c1h		;ccc9
	pop bc			;cccc
	add a,0c1h		;cccd
	rst 0			;cccf
	pop bc			;ccd0
	nop			;ccd1
	jp nz,0c21fh		;ccd2
	ld c,(hl)			;ccd5
	jp nz,0c296h		;ccd6
	call pe,01ac2h		;ccd9
	jp 0c35fh		;ccdc
	adc a,d			;ccdf
	jp 0c3a3h		;cce0
	pop bc			;cce3
	jp 0c3fdh		;cce4
	ld b,d			;cce7
	call nz,0c46dh		;cce8
	adc a,l			;cceb
	call nz,0c4c3h		;ccec
	defb 0ddh,0c4h,017h	;illegal sequence		;ccef
	push bc			;ccf2
	jr $-57		;ccf3
	add hl,de			;ccf5
	push bc			;ccf6
	ld a,(de)			;ccf7
	push bc			;ccf8
	ld c,(hl)			;ccf9
	push bc			;ccfa
	add a,b			;ccfb
	push bc			;ccfc
	sbc a,e			;ccfd
	push bc			;ccfe
	cp c			;ccff
	push bc			;cd00
	defb 0ddh,0c5h,01dh	;illegal sequence		;cd01
	add a,040h		;cd04
	add a,063h		;cd06
	add a,085h		;cd08
	add a,0d5h		;cd0a
	add a,03dh		;cd0c
	rst 0			;cd0e
	ld e,a			;cd0f
	rst 0			;cd10
	adc a,h			;cd11
	rst 0			;cd12
	and l			;cd13
	rst 0			;cd14
	jr $-54		;cd15
	ld d,a			;cd17
	ret z			;cd18
	ld (hl),l			;cd19
	ret z			;cd1a
	and d			;cd1b
	ret z			;cd1c
	ret z			;cd1d
	ret z			;cd1e
	ld a,(bc)			;cd1f
	ret			;cd20
	dec bc			;cd21
	ret			;cd22
	inc c			;cd23
	ret			;cd24
	ld hl,(054c9h)		;cd25
	ret			;cd28
	ld d,l			;cd29
	ret			;cd2a
	ld l,b			;cd2b
	ret			;cd2c
	adc a,c			;cd2d
	ret			;cd2e
	cp d			;cd2f
	ret			;cd30
	pop hl			;cd31
	ret			;cd32
	jp p,01bc9h		;cd33
	jp z,0ca50h		;cd36
	sub e			;cd39
	jp z,0cac5h		;cd3a
	jp m,026cah		;cd3d
	defb 0cbh,036h	;sli (hl)		;cd40
	bit 1,l		;cd42
	res 0,c		;cd44
	res 2,d		;cd46
	res 4,c		;cd48
	set 0,e		;cd4a
	set 7,b		;cd4c
	rl c		;cd4e
	call z,0ffffh		;cd50
	rst 38h			;cd53
	rst 38h			;cd54
	rst 38h			;cd55
	rst 38h			;cd56
	rst 38h			;cd57
	rst 38h			;cd58
	rst 38h			;cd59
	rst 38h			;cd5a
	inc bc			;cd5b
	dec bc			;cd5c
	ld a,(bc)			;cd5d
	ld c,0ffh		;cd5e
	inc b			;cd60
	ld a,(bc)			;cd61
	ld a,(bc)			;cd62
	rrca			;cd63
	inc bc			;cd64
	inc c			;cd65
	rst 38h			;cd66
	inc b			;cd67
	dec bc			;cd68
	ld a,(bc)			;cd69
	djnz $+1		;cd6a
	ld (bc),a			;cd6c
	ld c,00ah		;cd6d
	inc de			;cd6f
	rst 38h			;cd70
	ld bc,0090dh		;cd71
	ld a,(bc)			;cd74
	ld a,(bc)			;cd75
	inc d			;cd76
	rst 38h			;cd77
	add hl,bc			;cd78
	dec bc			;cd79
	ld a,(bc)			;cd7a
	ld e,0ffh		;cd7b
	ld (bc),a			;cd7d
	ld de,00c09h		;cd7e
	ld a,(bc)			;cd81
	rla			;cd82
	rst 38h			;cd83
	ld bc,00a10h		;cd84
	jr $+1		;cd87
	inc bc			;cd89
	inc de			;cd8a
	ld a,(bc)			;cd8b
	ld a,(de)			;cd8c
	rst 38h			;cd8d
	inc b			;cd8e
	ld (de),a			;cd8f
	add hl,bc			;cd90
	dec c			;cd91
	rst 38h			;cd92
	inc bc			;cd93
	dec d			;cd94
	add hl,bc			;cd95
	ld c,0ffh		;cd96
	inc b			;cd98
	inc d			;cd99
	ld a,(bc)			;cd9a
	dec de			;cd9b
	rst 38h			;cd9c
	inc bc			;cd9d
	rla			;cd9e
	ld a,(bc)			;cd9f
	inc e			;cda0
	rst 38h			;cda1
	inc b			;cda2
	ld d,009h		;cda3
	djnz $+1		;cda5
	inc bc			;cda7
	add hl,de			;cda8
	add hl,bc			;cda9
	ld de,004ffh		;cdaa
	jr $+12		;cdad
	dec e			;cdaf
	rst 38h			;cdb0
	add hl,bc			;cdb1
	ld (de),a			;cdb2
	rst 38h			;cdb3
	add hl,bc			;cdb4
	dec d			;cdb5
	rst 38h			;cdb6
	add hl,bc			;cdb7
	ld d,0ffh		;cdb8
	add hl,bc			;cdba
	add hl,de			;cdbb
	rst 38h			;cdbc
	inc bc			;cdbd
	rra			;cdbe
	inc b			;cdbf
	ld (00f09h),hl		;cdc0
	rst 38h			;cdc3
	inc bc			;cdc4
	jr nz,$+6		;cdc5
	ld e,001h		;cdc7
	ld hl,004ffh		;cdc9
	rra			;cdcc
	rst 38h			;cdcd
	ld (bc),a			;cdce
	rra			;cdcf
	rst 38h			;cdd0
	inc b			;cdd1
	daa			;cdd2
	ld (bc),a			;cdd3
	inc hl			;cdd4
	rst 38h			;cdd5
	inc bc			;cdd6
	cpl			;cdd7
	inc b			;cdd8
	jr z,$+12		;cdd9
	jr z,$+3		;cddb
	ld (02402h),hl		;cddd
	rst 38h			;cde0
	ld bc,00223h		;cde1
	dec h			;cde4
	inc b			;cde5
	add hl,hl			;cde6
	ld a,(bc)			;cde7
	add hl,hl			;cde8
	rst 38h			;cde9
	ld bc,00424h		;cdea
	ld hl,(02a0ah)		;cded
	rst 38h			;cdf0
	ld (bc),a			;cdf1
	daa			;cdf2
	add hl,bc			;cdf3
	daa			;cdf4
	rst 38h			;cdf5
	inc bc			;cdf6
	ld (02b04h),hl		;cdf7
	ld bc,00a26h		;cdfa
	ld h,0ffh		;cdfd
	inc bc			;cdff
	inc hl			;ce00
	add hl,bc			;ce01
	inc hl			;ce02
	inc b			;ce03
	inc l			;ce04
	rst 38h			;ce05
	inc b			;ce06
	dec l			;ce07
	inc bc			;ce08
	inc h			;ce09
	add hl,bc			;ce0a
	inc h			;ce0b
	rst 38h			;ce0c
	ld b,02eh		;ce0d
	ld a,(bc)			;ce0f
	ld l,003h		;ce10
	dec h			;ce12
	add hl,bc			;ce13
	dec h			;ce14
	rst 38h			;ce15
	inc bc			;ce16
	daa			;ce17
	rst 38h			;ce18
	inc bc			;ce19
	jr z,$+1		;ce1a
	inc bc			;ce1c
	add hl,hl			;ce1d
	ld bc,0ff32h		;ce1e
	rlca			;ce21
	ld hl,(02a09h)		;ce22
	rst 38h			;ce25
	inc b			;ce26
	inc hl			;ce27
	ld (bc),a			;ce28
	jr nc,$+12		;ce29
	jr nc,$+1		;ce2b
	ld bc,0092fh		;ce2d
	cpl			;ce30
	rst 38h			;ce31
	ld bc,00231h		;ce32
	ld (03203h),a		;ce35
	inc b			;ce38
	inc sp			;ce39
	rst 38h			;ce3a
	ld bc,00232h		;ce3b
	ld sp,03303h		;ce3e
	inc b			;ce41
	ld sp,001ffh		;ce42
	inc sp			;ce45
	ld (bc),a			;ce46
	ld (hl),003h		;ce47
	ld sp,03204h		;ce49
	rst 38h			;ce4c
	ld bc,00339h		;ce4d
	ld a,(03f04h)		;ce50
	rst 38h			;ce53
	ld bc,00235h		;ce54
	add hl,sp			;ce57
	inc bc			;ce58
	ld (hl),004h		;ce59
	scf			;ce5b
	rst 38h			;ce5c
	ld bc,00233h		;ce5d
	scf			;ce60
	inc bc			;ce61
	scf			;ce62
	inc b			;ce63
	ld (hl),0ffh		;ce64
	ld bc,00237h		;ce66
	ld (hl),003h		;ce69
	dec (hl)			;ce6b
	inc b			;ce6c
	ld (hl),008h		;ce6d
	jr c,$+1		;ce6f
	dec b			;ce71
	scf			;ce72
	rst 38h			;ce73
	ld bc,00235h		;ce74
	inc (hl)			;ce77
	inc bc			;ce78
	scf			;ce79
	inc b			;ce7a
	ld (hl),0ffh		;ce7b
	inc b			;ce7d
	inc (hl)			;ce7e
	ld (bc),a			;ce7f
	dec sp			;ce80
	rst 38h			;ce81
	ld bc,0023ah		;ce82
	inc a			;ce85
	rst 38h			;ce86
	ld bc,0023bh		;ce87
	ld b,b			;ce8a
	inc bc			;ce8b
	ld a,004h		;ce8c
	dec a			;ce8e
	rst 38h			;ce8f
	inc bc			;ce90
	inc a			;ce91
	rst 38h			;ce92
	inc b			;ce93
	inc a			;ce94
	rst 38h			;ce95
	inc bc			;ce96
	inc (hl)			;ce97
	ld (bc),a			;ce98
	ld b,c			;ce99
	rst 38h			;ce9a
	ld bc,0ff3ch		;ce9b
	ld bc,0033fh		;ce9e
	ld b,c			;cea1
	inc b			;cea2
	ld b,c			;cea3
	rst 38h			;cea4
	ld b,041h		;cea5
	ex af,af'			;cea7
	ld b,e			;cea8
	rst 38h			;cea9
	dec b			;ceaa
	ld b,d			;ceab
	inc bc			;ceac
	ld b,h			;cead
	inc b			;ceae
	ld b,l			;ceaf
	rst 38h			;ceb0
	inc b			;ceb1
	ld b,e			;ceb2
	rst 38h			;ceb3
	inc bc			;ceb4
	ld b,e			;ceb5
	inc b			;ceb6
	ld b,(hl)			;ceb7
	rst 38h			;ceb8
	inc bc			;ceb9
	ld b,l			;ceba
	ld bc,0ff47h		;cebb
	ld bc,00248h		;cebe
	ld b,(hl)			;cec1
	rst 38h			;cec2
	ld bc,00a49h		;cec3
	ld c,c			;cec6
	ld (bc),a			;cec7
	ld b,a			;cec8
	rst 38h			;cec9
	ld bc,00b4ah		;ceca
	ld c,d			;cecd
	ld (bc),a			;cece
	ld c,b			;cecf
	add hl,bc			;ced0
	ld c,b			;ced1
	rst 38h			;ced2
	rst 38h			;ced3
	ld d,c			;ced4
	call 0cd52h		;ced5
	ld d,e			;ced8
	call 0cd54h		;ced9
	ld d,l			;cedc
	call 0cd56h		;cedd
	ld d,a			;cee0
	call 0cd58h		;cee1
	ld e,c			;cee4
	call 0cd5ah		;cee5
	ld e,e			;cee8
	call 0cd60h		;cee9
	ld h,a			;ceec
	call 0cd6ch		;ceed
	ld (hl),c			;cef0
	call 0cd78h		;cef1
	ld a,l			;cef4
	call 0cd84h		;cef5
	adc a,c			;cef8
	call 0cd8eh		;cef9
	sub e			;cefc
	call 0cd98h		;cefd
	sbc a,l			;cf00
	call 0cda2h		;cf01
	and a			;cf04
	call 0cdach		;cf05
	or c			;cf08
	call 0cdb4h		;cf09
	or a			;cf0c
	call 0cdbah		;cf0d
	cp l			;cf10
	call 0cdc4h		;cf11
	set 1,l		;cf14
	adc a,0cdh		;cf16
	pop de			;cf18
	call 0cdd6h		;cf19
	pop hl			;cf1c
	call 0cdeah		;cf1d
	pop af			;cf20
	call 0cdf6h		;cf21
	rst 38h			;cf24
	call 0ce06h		;cf25
	dec c			;cf28
	adc a,016h		;cf29
	adc a,019h		;cf2b
	adc a,01ch		;cf2d
	adc a,021h		;cf2f
	adc a,026h		;cf31
	adc a,02dh		;cf33
	adc a,032h		;cf35
	adc a,03bh		;cf37
	adc a,044h		;cf39
	adc a,04dh		;cf3b
	adc a,054h		;cf3d
	adc a,05dh		;cf3f
	adc a,066h		;cf41
	adc a,071h		;cf43
	adc a,074h		;cf45
	adc a,07dh		;cf47
	adc a,082h		;cf49
	adc a,087h		;cf4b
	adc a,090h		;cf4d
	adc a,093h		;cf4f
	adc a,096h		;cf51
	adc a,09bh		;cf53
	adc a,09eh		;cf55
	adc a,0a5h		;cf57
	adc a,0aah		;cf59
	adc a,0b1h		;cf5b
	adc a,0b4h		;cf5d
	adc a,0b9h		;cf5f
	adc a,0beh		;cf61
	adc a,0c3h		;cf63
	adc a,0cah		;cf65
	adc a,0d3h		;cf67
	adc a,032h		;cf69
	rst 38h			;cf6b
	ld c,h			;cf6c
	rst 38h			;cf6d
	inc (hl)			;cf6e
	rst 38h			;cf6f
	ld c,(hl)			;cf70
	rst 38h			;cf71
	rst 38h			;cf72
	rst 38h			;cf73
	rst 38h			;cf74
	rst 38h			;cf75
	rst 38h			;cf76
	rst 38h			;cf77
	rst 38h			;cf78
	rst 38h			;cf79
	ld c,l			;cf7a
	rst 38h			;cf7b
	inc sp			;cf7c
	rst 38h			;cf7d
	dec (hl)			;cf7e
	rst 38h			;cf7f
	ld (hl),0ffh		;cf80
	ld (hl),032h		;cf82
	scf			;cf84
	rst 38h			;cf85
	jr c,$+1		;cf86
	add hl,sp			;cf88
	rst 38h			;cf89
	ld a,(03bffh)		;cf8a
	rst 38h			;cf8d
	inc a			;cf8e
	rst 38h			;cf8f
	dec a			;cf90
	rst 38h			;cf91
	ld a,0ffh		;cf92
	ccf			;cf94
	rst 38h			;cf95
	ld b,b			;cf96
	rst 38h			;cf97
	ld b,c			;cf98
	rst 38h			;cf99
	ld b,d			;cf9a
	rst 38h			;cf9b
	ld b,e			;cf9c
	rst 38h			;cf9d
	ld b,h			;cf9e
	rst 38h			;cf9f
	ld b,l			;cfa0
	rst 38h			;cfa1
	ld b,(hl)			;cfa2
	rst 38h			;cfa3
	ld b,a			;cfa4
	rst 38h			;cfa5
	ld c,b			;cfa6
	rst 38h			;cfa7
	ld c,b			;cfa8
	ld (0ff4fh),a		;cfa9
	ld d,b			;cfac
	rst 38h			;cfad
	ld c,c			;cfae
	rst 38h			;cfaf
	ld c,d			;cfb0
	rst 38h			;cfb1
	ld c,e			;cfb2
	rst 38h			;cfb3
	ld a,h			;cfb4
	ld a,h			;cfb5
	ld b,c			;cfb6
	ld a,h			;cfb7
	ld bc,00101h		;cfb8
	ld bc,00101h		;cfbb
	add a,c			;cfbe
	ld bc,00101h		;cfbf
	inc a			;cfc2
	ld bc,00101h		;cfc3
	ld bc,00101h		;cfc6
	ld bc,00101h		;cfc9
	ld bc,00101h		;cfcc
	ld bc,00101h		;cfcf
	ld bc,00181h		;cfd2
	ld bc,08181h		;cfd5
	ld bc,08008h		;cfd8
	nop			;cfdb
	add a,b			;cfdc
	ex af,af'			;cfdd
	nop			;cfde
	ex af,af'			;cfdf
	add a,b			;cfe0
	nop			;cfe1
	nop			;cfe2
	nop			;cfe3
	nop			;cfe4
	nop			;cfe5
	nop			;cfe6
	nop			;cfe7
	nop			;cfe8
	ld b,b			;cfe9
	nop			;cfea
	ex af,af'			;cfeb
	nop			;cfec
	ld c,b			;cfed
	nop			;cfee
	nop			;cfef
	nop			;cff0
	nop			;cff1
	nop			;cff2
	add hl,bc			;cff3
	nop			;cff4
	ex af,af'			;cff5
	add a,b			;cff6
	nop			;cff7
	ld bc,00008h		;cff8
	nop			;cffb
	nop			;cffc
	ex af,af'			;cffd
	nop			;cffe
	nop			;cfff
	nop			;d000
	nop			;d001
	nop			;d002
	ex af,af'			;d003
	nop			;d004
	ex af,af'			;d005
	nop			;d006
	ex af,af'			;d007
	nop			;d008
	ex af,af'			;d009
	nop			;d00a
	ex af,af'			;d00b
	nop			;d00c
	nop			;d00d
	ld bc,00100h		;d00e
	add hl,bc			;d011
	ld bc,00000h		;d012
	nop			;d015
	ld bc,00108h		;d016
	ex af,af'			;d019
	nop			;d01a
	nop			;d01b
	nop			;d01c
	nop			;d01d
	nop			;d01e
	nop			;d01f
	nop			;d020
	ld bc,00a00h		;d021
	ld a,(bc)			;d024
	inc a			;d025
	rrca			;d026
	call m,0fcfch		;d027
	call m,00005h		;d02a
	defb 0fdh,005h,00ch	;illegal sequence		;d02d
	call m,0190bh		;d030
	dec c			;d033
	inc d			;d034
	ld (de),a			;d035
	ld de,01a17h		;d036
	dec de			;d039
	inc e			;d03a
	dec e			;d03b
	call m,0fcfch		;d03c
	call m,03d3dh		;d03f
	call m,03d05h		;d042
	dec a			;d045
	call m,0fffch		;d046
	nop			;d049
	nop			;d04a
	ld c,(hl)			;d04b
	ld bc,00052h		;d04c
	nop			;d04f
	ld l,e			;d050
	rra			;d051
	ld h,h			;d052
	dec e			;d053
	ld l,e			;d054
	rra			;d055
	dec (hl)			;d056
	ld l,l			;d057
	inc de			;d058
	nop			;d059
	jr $+31		;d05a
	ld c,e			;d05c
	ld (bc),a			;d05d
	ld c,e			;d05e
	inc e			;d05f
	dec h			;d060
	dec bc			;d061
	ld c,e			;d062
	inc c			;d063
	ld (hl),l			;d064
	rst 38h			;d065
	ld (bc),a			;d066
	ld c,d			;d067
	ld c,l			;d068
	nop			;d069
	rst 38h			;d06a
	nop			;d06b
	ld bc,0fd0bh		;d06c
	ld d,h			;d06f
	ld c,e			;d070
	jr nc,$+10		;d071
	ld c,e			;d073
	ld a,(bc)			;d074
	ld c,(hl)			;d075
	ld bc,000ffh		;d076
	ld bc,00113h		;d079
	dec d			;d07c
	rst 38h			;d07d
	inc c			;d07e
	add a,d			;d07f
	inc l			;d080
	ld c,04dh		;d081
	ld a,d			;d083
	ld (hl),033h		;d084
	inc (hl)			;d086
	rst 38h			;d087
	jr nc,$-124		;d088
	jr nc,$+2		;d08a
	inc bc			;d08c
	ld (00e01h),hl		;d08d
	ld bc,02f0dh		;d090
	nop			;d093
	rst 38h			;d094
	jr nc,$+30		;d095
	ld a,l			;d097
	ld a,c			;d098
	inc b			;d099
	jr nc,$+123		;d09a
	inc c			;d09c
	nop			;d09d
	dec b			;d09e
	dec bc			;d09f
	jr c,$+13		;d0a0
	ld c,e			;d0a2
	dec c			;d0a3
	ld (hl),e			;d0a4
	rrca			;d0a5
	ld a,d			;d0a6
	ld (bc),a			;d0a7
	cpl			;d0a8
	inc e			;d0a9
	rst 38h			;d0aa
	inc c			;d0ab
	nop			;d0ac
	dec b			;d0ad
	dec bc			;d0ae
	jr c,$+13		;d0af
	ld c,e			;d0b1
	dec c			;d0b2
	ld (hl),e			;d0b3
	dec bc			;d0b4
	inc e			;d0b5
	ld (bc),a			;d0b6
	ld c,02fh		;d0b7
	inc e			;d0b9
	rst 38h			;d0ba
	inc c			;d0bb
	inc e			;d0bc
	ld a,l			;d0bd
	inc b			;d0be
	ld a,c			;d0bf
	dec bc			;d0c0
	ld a,c			;d0c1
	inc sp			;d0c2
	ld a,c			;d0c3
	dec b			;d0c4
	rst 38h			;d0c5
	nop			;d0c6
	dec d			;d0c7
	ex af,af'			;d0c8
	dec bc			;d0c9
	dec bc			;d0ca
	add a,e			;d0cb
	ld h,07ch		;d0cc
	and l			;d0ce
	add a,h			;d0cf
	ld (hl),l			;d0d0
	rst 38h			;d0d1
	ld a,l			;d0d2
	ld h,002h		;d0d3
	dec bc			;d0d5
	defb 0fdh,00bh,01ch	;illegal sequence		;d0d6
	ld c,e			;d0d9
	add hl,de			;d0da
	inc c			;d0db
	ld (bc),a			;d0dc
	ld d,b			;d0dd
	ld (bc),a			;d0de
	ex af,af'			;d0df
	call nc,04b02h		;d0e0
	ld a,(bc)			;d0e3
	ld c,(hl)			;d0e4
	nop			;d0e5
	sbc a,h			;d0e6
	inc e			;d0e7
	ld a,l			;d0e8
	ld (bc),a			;d0e9
	ex af,af'			;d0ea
	ld (hl),h			;d0eb
	ld (bc),a			;d0ec
	rst 38h			;d0ed
	inc c			;d0ee
	ex af,af'			;d0ef
	ld d,b			;d0f0
	ld (bc),a			;d0f1
	ex af,af'			;d0f2
	ld c,e			;d0f3
	dec bc			;d0f4
	ld c,e			;d0f5
	inc c			;d0f6
	rst 38h			;d0f7
	inc c			;d0f8
	ex af,af'			;d0f9
	inc c			;d0fa
	inc e			;d0fb
	ld c,e			;d0fc
	dec bc			;d0fd
	ld c,e			;d0fe
	inc c			;d0ff
	rst 38h			;d100
	ld c,(hl)			;d101
	dec b			;d102
	dec e			;d103
	ld c,(hl)			;d104
	inc bc			;d105
	ld h,e			;d106
	nop			;d107
	nop			;d108
	halt			;d109
	nop			;d10a
	rst 38h			;d10b
	inc sp			;d10c
	ld (bc),a			;d10d
	adc a,b			;d10e
	ld (bc),a			;d10f
	inc c			;d110
	inc sp			;d111
	ld (bc),a			;d112
	adc a,c			;d113
	ld (bc),a			;d114
	ld de,00233h		;d115
	adc a,d			;d118
	ld (bc),a			;d119
	add hl,de			;d11a
	inc sp			;d11b
	ld (bc),a			;d11c
	adc a,e			;d11d
	ld (bc),a			;d11e
	dec e			;d11f
	inc sp			;d120
	ld (bc),a			;d121
	adc a,h			;d122
	ld (bc),a			;d123
	jr nz,$+53		;d124
	ld (bc),a			;d126
	adc a,l			;d127
	ld (bc),a			;d128
	jr nc,$+53		;d129
	ld (bc),a			;d12b
	adc a,(hl)			;d12c
	ld (bc),a			;d12d
	inc (hl)			;d12e
	inc sp			;d12f
	ld (bc),a			;d130
	adc a,a			;d131
	ld (bc),a			;d132
	jr c,$+53		;d133
	ld (bc),a			;d135
	sub b			;d136
	ld (bc),a			;d137
	add hl,sp			;d138
	inc sp			;d139
	ld (bc),a			;d13a
	sub c			;d13b
	ld (bc),a			;d13c
	ld b,b			;d13d
	inc sp			;d13e
	ld (bc),a			;d13f
	sub d			;d140
	ld (bc),a			;d141
	ld b,d			;d142
	inc sp			;d143
	ld (bc),a			;d144
	sub e			;d145
	rst 38h			;d146
	dec bc			;d147
	inc e			;d148
	inc bc			;d149
	ld (08736h),hl		;d14a
	rst 38h			;d14d
	dec bc			;d14e
	inc e			;d14f
	or (hl)			;d150
	ld (bc),a			;d151
	inc bc			;d152
	ld (0054dh),hl		;d153
	rst 38h			;d156
	dec bc			;d157
	inc e			;d158
	ld (hl),041h		;d159
	rst 38h			;d15b
	inc c			;d15c
	inc e			;d15d
	ld (hl),005h		;d15e
	rst 38h			;d160
	jr nc,$+11		;d161
	ld c,(hl)			;d163
	ld bc,01c0ch		;d164
	ld (hl),000h		;d167
	rst 38h			;d169
	dec bc			;d16a
	inc e			;d16b
	ld c,e			;d16c
	jr $+1		;d16d
	ld c,e			;d16f
	ld de,04bffh		;d170
	ld bc,0ffffh		;d173
	rst 38h			;d176
	ld c,c			;d177
	ret nc			;d178
	rst 38h			;d179
	rst 38h			;d17a
	ld h,(hl)			;d17b
	ret nc			;d17c
	rst 38h			;d17d
	rst 38h			;d17e
	ld l,e			;d17f
	ret nc			;d180
	rst 38h			;d181
	rst 38h			;d182
	ld a,b			;d183
	ret nc			;d184
	rst 38h			;d185
	rst 38h			;d186
	ld a,(hl)			;d187
	ret nc			;d188
	rst 38h			;d189
	rst 38h			;d18a
	adc a,b			;d18b
	ret nc			;d18c
	rst 38h			;d18d
	rst 38h			;d18e
	sub l			;d18f
	ret nc			;d190
	rst 38h			;d191
	rst 38h			;d192
	xor e			;d193
	ret nc			;d194
	rst 38h			;d195
	rst 38h			;d196
	cp e			;d197
	ret nc			;d198
	rst 38h			;d199
	rst 38h			;d19a
	add a,0d0h		;d19b
	rst 38h			;d19d
	rst 38h			;d19e
	jp nc,0ffd0h		;d19f
	rst 38h			;d1a2
	xor 0d0h		;d1a3
	rst 38h			;d1a5
	rst 38h			;d1a6
	ret m			;d1a7
	ret nc			;d1a8
	rst 38h			;d1a9
	rst 38h			;d1aa
	ld bc,0ffd1h		;d1ab
	rst 38h			;d1ae
	inc c			;d1af
	pop de			;d1b0
	rst 38h			;d1b1
	rst 38h			;d1b2
	ld b,a			;d1b3
	pop de			;d1b4
	rst 38h			;d1b5
	rst 38h			;d1b6
	ld c,(hl)			;d1b7
	pop de			;d1b8
	rst 38h			;d1b9
	rst 38h			;d1ba
	ld d,a			;d1bb
	pop de			;d1bc
	rst 38h			;d1bd
	rst 38h			;d1be
	ld e,h			;d1bf
	pop de			;d1c0
	rst 38h			;d1c1
	rst 38h			;d1c2
	ld h,c			;d1c3
	pop de			;d1c4
	rst 38h			;d1c5
	rst 38h			;d1c6
	ld l,d			;d1c7
	pop de			;d1c8
	rst 38h			;d1c9
	rst 38h			;d1ca
	ld l,a			;d1cb
	pop de			;d1cc
	rst 38h			;d1cd
	rst 38h			;d1ce
	ld (hl),d			;d1cf
	pop de			;d1d0
	nop			;d1d1
	nop			;d1d2
	ld c,e			;d1d3
	inc bc			;d1d4
	rst 38h			;d1d5
	ld c,e			;d1d6
	ld (de),a			;d1d7
	rst 38h			;d1d8
	ld c,c			;d1d9
	nop			;d1da
	ld (hl),006h		;d1db
	ld l,h			;d1dd
	rst 38h			;d1de
	ld b,l			;d1df
	ei			;d1e0
	rrca			;d1e1
	ld (00dfah),hl		;d1e2
	inc c			;d1e5
	rst 38h			;d1e6
	ld a,l			;d1e7
	dec bc			;d1e8
	inc c			;d1e9
	ld a,l			;d1ea
	dec c			;d1eb
	ld c,0ffh		;d1ec
	ld b,l			;d1ee
	ei			;d1ef
	rrca			;d1f0
	ld (07dfah),hl		;d1f1
	ld (0240bh),hl		;d1f4
	rst 38h			;d1f7
	ei			;d1f8
	rst 38h			;d1f9
	ld b,l			;d1fa
	ei			;d1fb
	rrca			;d1fc
	dec l			;d1fd
	jp m,02d7dh		;d1fe
	ld c,0ffh		;d201
	rrca			;d203
	ld hl,07dfah		;d204
	ld hl,0ff0ah		;d207
	rrca			;d20a
	inc hl			;d20b
	jp m,0237dh		;d20c
	dec c			;d20f
	rst 38h			;d210
	rrca			;d211
	inc l			;d212
	jp m,02c7dh		;d213
	inc c			;d216
	rrca			;d217
	dec l			;d218
	jp m,02d7dh		;d219
	ld c,0ffh		;d21c
	inc h			;d21e
	jp m,02fffh		;d21f
	ld (00dffh),hl		;d222
	ld (07dffh),hl		;d225
	dec bc			;d228
	ld (00d7dh),hl		;d229
	inc hl			;d22c
	ld a,l			;d22d
	inc c			;d22e
	inc l			;d22f
	ld a,l			;d230
	ld c,02dh		;d231
	rst 38h			;d233
	dec c			;d234
	dec hl			;d235
	rst 38h			;d236
	ld a,l			;d237
	djnz $+45		;d238
	rst 38h			;d23a
	ld a,l			;d23b
	ld a,(bc)			;d23c
	ld hl,0240dh		;d23d
	rst 38h			;d240
	ld a,l			;d241
	rrca			;d242
	inc h			;d243
	rst 38h			;d244
	ld a,l			;d245
	ld hl,07d0ah		;d246
	ld (07d0bh),hl		;d249
	inc l			;d24c
	inc c			;d24d
	ld a,l			;d24e
	inc hl			;d24f
	dec c			;d250
	ld a,l			;d251
	dec l			;d252
	ld c,07dh		;d253
	inc h			;d255
	rrca			;d256
	ld a,l			;d257
	dec hl			;d258
	djnz $+1		;d259
	dec c			;d25b
	rra			;d25c
	rst 38h			;d25d
	ld sp,00120h		;d25e
	jr nc,$+33		;d261
	ld (hl),h			;d263
	ld bc,031ffh		;d264
	rra			;d267
	ld bc,04fffh		;d268
	ld (044ffh),hl		;d26b
	rst 38h			;d26e
	inc h			;d26f
	inc l			;d270
	rst 38h			;d271
	rst 38h			;d272
	dec c			;d273
	ld (073ffh),hl		;d274
	ld (hl),042h		;d277
	ld l,h			;d279
	rst 38h			;d27a
	inc h			;d27b
	ld d,l			;d27c
	or b			;d27d
	rst 38h			;d27e
	inc h			;d27f
	ld d,(hl)			;d280
	or b			;d281
	rst 38h			;d282
	ld b,h			;d283
	inc b			;d284
	inc h			;d285
	ld c,d			;d286
	rst 38h			;d287
	rst 38h			;d288
	ld b,l			;d289
	rst 38h			;d28a
	inc h			;d28b
	ld c,e			;d28c
	rst 38h			;d28d
	rst 38h			;d28e
	ld b,h			;d28f
	ld (bc),a			;d290
	inc h			;d291
	ld c,c			;d292
	rst 38h			;d293
	rst 38h			;d294
	ld (hl),04eh		;d295
	ld l,h			;d297
	rst 38h			;d298
	ld (bc),a			;d299
	ld b,a			;d29a
	inc bc			;d29b
	ld c,d			;d29c
	inc h			;d29d
	rst 38h			;d29e
	ld l,h			;d29f
	rst 38h			;d2a0
	ld (bc),a			;d2a1
	ld b,a			;d2a2
	inc bc			;d2a3
	ld c,d			;d2a4
	ld b,l			;d2a5
	ld a,(hl)			;d2a6
	inc sp			;d2a7
	inc l			;d2a8
	ld l,h			;d2a9
	rst 38h			;d2aa
	ld c,e			;d2ab
	ld c,04fh		;d2ac
	add hl,de			;d2ae
	rst 38h			;d2af
	ld a,l			;d2b0
	ld (07d02h),hl		;d2b1
	inc l			;d2b4
	ld (02d7dh),hl		;d2b5
	inc hl			;d2b8
	ld a,l			;d2b9
	ld (bc),a			;d2ba
	inc l			;d2bb
	rst 38h			;d2bc
	ld b,l			;d2bd
	ld a,h			;d2be
	inc sp			;d2bf
	inc l			;d2c0
	ld a,e			;d2c1
	rst 38h			;d2c2
	ld b,l			;d2c3
	ld a,e			;d2c4
	inc h			;d2c5
	ld b,d			;d2c6
	rst 38h			;d2c7
	rst 38h			;d2c8
	inc h			;d2c9
	ld (hl),0ffh		;d2ca
	rst 38h			;d2cc
	scf			;d2cd
	dec bc			;d2ce
	call m,02333h		;d2cf
	ld (045ffh),a		;d2d2
	ld (hl),037h		;d2d5
	dec bc			;d2d7
	call m,02333h		;d2d8
	ld (058ffh),a		;d2db
	rra			;d2de
	call m,02333h		;d2df
	ld (045ffh),a		;d2e2
	ld c,b			;d2e5
	ld e,b			;d2e6
	rra			;d2e7
	call m,02d33h		;d2e8
	ld (045ffh),a		;d2eb
	rst 38h			;d2ee
	inc sp			;d2ef
	inc l			;d2f0
	ld c,b			;d2f1
	rst 38h			;d2f2
	ld b,l			;d2f3
	ld c,b			;d2f4
	ld a,l			;d2f5
	ld (0242ch),hl		;d2f6
	ld b,a			;d2f9
	ld c,b			;d2fa
	rst 38h			;d2fb
	inc h			;d2fc
	add hl,sp			;d2fd
	ld (hl),0ffh		;d2fe
	inc h			;d300
	add hl,sp			;d301
	ld (hl),0ffh		;d302
	inc h			;d304
	add hl,sp			;d305
	ld (hl),0ffh		;d306
	inc h			;d308
	ld c,c			;d309
	ld h,(hl)			;d30a
	rst 38h			;d30b
	inc h			;d30c
	ld c,c			;d30d
	ld h,(hl)			;d30e
	rst 38h			;d30f
	ld b,l			;d310
	ld h,a			;d311
	inc h			;d312
	add hl,sp			;d313
	ld (hl),0ffh		;d314
	ld b,l			;d316
	ld (hl),024h		;d317
	add hl,sp			;d319
	ld (hl),0ffh		;d31a
	inc h			;d31c
	add hl,sp			;d31d
	ld l,l			;d31e
	rst 38h			;d31f
	ld c,a			;d320
	inc l			;d321
	rst 38h			;d322
	inc h			;d323
	ld c,c			;d324
	dec a			;d325
	rst 38h			;d326
	ld b,l			;d327
	ld l,c			;d328
	inc h			;d329
	add hl,sp			;d32a
	ld l,l			;d32b
	rst 38h			;d32c
	ld b,l			;d32d
	ld l,l			;d32e
	inc h			;d32f
	add hl,sp			;d330
	ld l,l			;d331
	rst 38h			;d332
	inc h			;d333
	ld a,(0ff6dh)		;d334
	ld c,a			;d337
	inc l			;d338
	rst 38h			;d339
	inc h			;d33a
	ld c,d			;d33b
	dec a			;d33c
	rst 38h			;d33d
	ld b,l			;d33e
	ld l,c			;d33f
	inc h			;d340
	ld a,(0ff6dh)		;d341
	ld b,l			;d344
	ld l,l			;d345
	inc h			;d346
	ld a,(0ff6dh)		;d347
	ld b,l			;d34a
	ld h,a			;d34b
	ex af,af'			;d34c
	ex af,af'			;d34d
	nop			;d34e
	djnz $+38		;d34f
	ld e,d			;d351
	ld l,a			;d352
	rst 38h			;d353
	ld b,l			;d354
	ld l,a			;d355
	inc h			;d356
	ld c,c			;d357
	ld a,0ffh		;d358
	ld b,l			;d35a
	ld (hl),c			;d35b
	inc h			;d35c
	ld c,c			;d35d
	rst 38h			;d35e
	rst 38h			;d35f
	ld b,l			;d360
	ld l,a			;d361
	inc h			;d362
	ld c,e			;d363
	ld a,0ffh		;d364
	inc c			;d366
	add a,(hl)			;d367
	inc h			;d368
	ld c,e			;d369
	ld a,0ffh		;d36a
	nop			;d36c
	djnz $+38		;d36d
	inc l			;d36f
	ld h,a			;d370
	rst 38h			;d371
	ld b,l			;d372
	ld (hl),c			;d373
	nop			;d374
	jr $+38		;d375
	ld c,e			;d377
	rst 38h			;d378
	rst 38h			;d379
	ld b,l			;d37a
	ld l,d			;d37b
	inc c			;d37c
	sbc a,c			;d37d
	inc sp			;d37e
	inc l			;d37f
	ld (hl),l			;d380
	rst 38h			;d381
	ld b,l			;d382
	ld (hl),l			;d383
	inc c			;d384
	sbc a,c			;d385
	ld h,h			;d386
	adc a,b			;d387
	inc sp			;d388
	xor e			;d389
	inc sp			;d38a
	ld h,0b4h		;d38b
	ld l,h			;d38d
	rst 38h			;d38e
	inc h			;d38f
	ld c,h			;d390
	rst 38h			;d391
	rst 38h			;d392
	ld b,l			;d393
	ld (hl),b			;d394
	inc h			;d395
	ld c,h			;d396
	rst 38h			;d397
	rst 38h			;d398
	dec b			;d399
	ld c,036h		;d39a
	ld a,(de)			;d39c
	ld l,h			;d39d
	rst 38h			;d39e
	ld c,02ch		;d39f
	inc c			;d3a1
	ld (hl),054h		;d3a2
	ld l,h			;d3a4
	rst 38h			;d3a5
	ld b,l			;d3a6
	ld a,(bc)			;d3a7
	nop			;d3a8
	ld de,02664h		;d3a9
	adc a,a			;d3ac
	ld l,h			;d3ad
	rst 38h			;d3ae
	cpl			;d3af
	add a,d			;d3b0
	ld a,l			;d3b1
	inc l			;d3b2
	ld hl,02c0dh		;d3b3
	add hl,bc			;d3b6
	ld a,l			;d3b7
	ld h,002h		;d3b8
	ld l,d			;d3ba
	ld (bc),a			;d3bb
	ld c,e			;d3bc
	inc de			;d3bd
	ld (hl),e			;d3be
	ld h,h			;d3bf
	ld h,07bh		;d3c0
	jr nc,$-124		;d3c2
	ld l,h			;d3c4
	rst 38h			;d3c5
	nop			;d3c6
	djnz $+57		;d3c7
	ex af,af'			;d3c9
	dec b			;d3ca
	ld a,l			;d3cb
	inc l			;d3cc
	ld (02c33h),hl		;d3cd
	ld h,a			;d3d0
	inc h			;d3d1
	ld c,c			;d3d2
	rst 38h			;d3d3
	rst 38h			;d3d4
	inc h			;d3d5
	inc a			;d3d6
	ld (hl),d			;d3d7
	rst 38h			;d3d8
	inc h			;d3d9
	inc a			;d3da
	ld (hl),d			;d3db
	rst 38h			;d3dc
	inc h			;d3dd
	inc a			;d3de
	ld (hl),d			;d3df
	rst 38h			;d3e0
	inc h			;d3e1
	inc a			;d3e2
	ld (hl),d			;d3e3
	rst 38h			;d3e4
	dec c			;d3e5
	ld (00cffh),hl		;d3e6
	sbc a,c			;d3e9
	inc h			;d3ea
	ld b,l			;d3eb
	ld l,d			;d3ec
	rst 38h			;d3ed
	ld b,l			;d3ee
	rst 38h			;d3ef
	inc sp			;d3f0
	inc l			;d3f1
	ld c,b			;d3f2
	rst 38h			;d3f3
	inc c			;d3f4
	sbc a,c			;d3f5
	inc h			;d3f6
	ld b,e			;d3f7
	rst 38h			;d3f8
	rst 38h			;d3f9
	ld b,l			;d3fa
	ld b,l			;d3fb
	ld a,l			;d3fc
	ld (0242ch),hl		;d3fd
	ld b,b			;d400
	ld b,l			;d401
	rst 38h			;d402
	ld b,l			;d403
	ld b,(hl)			;d404
	inc h			;d405
	ld c,c			;d406
	ld b,l			;d407
	rst 38h			;d408
	ex af,af'			;d409
	dec e			;d40a
	inc h			;d40b
	ld b,c			;d40c
	rst 38h			;d40d
	rst 38h			;d40e
	ld b,l			;d40f
	rst 38h			;d410
	inc sp			;d411
	inc l			;d412
	ld l,h			;d413
	rst 38h			;d414
	nop			;d415
	ld c,024h		;d416
	inc l			;d418
	ld l,b			;d419
	rst 38h			;d41a
	nop			;d41b
	ld c,024h		;d41c
	inc l			;d41e
	ld l,b			;d41f
	rst 38h			;d420
	nop			;d421
	jr $+38		;d422
	inc a			;d424
	ld (hl),b			;d425
	rst 38h			;d426
	ld b,l			;d427
	ld (hl),b			;d428
	nop			;d429
	jr $+38		;d42a
	inc a			;d42c
	ld (hl),b			;d42d
	rst 38h			;d42e
	ld b,l			;d42f
	rst 38h			;d430
	inc sp			;d431
	inc l			;d432
	ld l,h			;d433
	rst 38h			;d434
	ld a,l			;d435
	ld (04b02h),hl		;d436
	dec de			;d439
	ld (hl),e			;d43a
	ld l,h			;d43b
	rst 38h			;d43c
	ld a,l			;d43d
	inc l			;d43e
	ld (bc),a			;d43f
	ld c,e			;d440
	dec de			;d441
	ld (hl),e			;d442
	ld l,h			;d443
	rst 38h			;d444
	ld b,h			;d445
	ld (bc),a			;d446
	inc h			;d447
	ld c,c			;d448
	rst 38h			;d449
	rst 38h			;d44a
	ld h,h			;d44b
	rst 38h			;d44c
	ld c,021h		;d44d
	ld c,00fh		;d44f
	ld hl,02415h		;d451
	ld e,c			;d454
	rst 38h			;d455
	rst 38h			;d456
	ld c,e			;d457
	djnz $+116		;d458
	ld l,h			;d45a
	rst 38h			;d45b
	ld a,l			;d45c
	ld h,002h		;d45d
	ld l,d			;d45f
	ld (bc),a			;d460
	ld c,e			;d461
	inc de			;d462
	ld (hl),e			;d463
	ld a,l			;d464
	ld (bc),a			;d465
	ld h,032h		;d466
	ld a,c			;d468
	ld bc,0ff75h		;d469
	ld e,h			;d46c
	ld c,021h		;d46d
	inc c			;d46f
	ld (hl),008h		;d470
	ld l,h			;d472
	rst 38h			;d473
	ld (hl),007h		;d474
	rrca			;d476
	ld hl,03609h		;d477
	inc bc			;d47a
	rst 38h			;d47b
	ld a,l			;d47c
	ld hl,03102h		;d47d
	ld (bc),a			;d480
	ld a,d			;d481
	or (hl)			;d482
	ld (bc),a			;d483
	ld (hl),030h		;d484
	ld c,e			;d486
	inc b			;d487
	jr nc,$-124		;d488
	ld l,h			;d48a
	rst 38h			;d48b
	rst 38h			;d48c
	rst 38h			;d48d
	out (0d1h),a		;d48e
	rst 38h			;d490
	rst 38h			;d491
	sub 0d1h		;d492
	rst 38h			;d494
	rst 38h			;d495
	exx			;d496
	pop de			;d497
	rst 38h			;d498
	rst 38h			;d499
	rst 18h			;d49a
	pop de			;d49b
	rst 38h			;d49c
	rst 38h			;d49d
	xor 0d1h		;d49e
	rst 38h			;d4a0
	rst 38h			;d4a1
	jp m,0ffd1h		;d4a2
	ei			;d4a5
	inc bc			;d4a6
	jp nc,0fbffh		;d4a7
	ld a,(bc)			;d4aa
	jp nc,0fbffh		;d4ab
	ld de,0ffd2h		;d4ae
	ei			;d4b1
	ld e,0d2h		;d4b2
	jp m,024ffh		;d4b4
	jp nc,0fffah		;d4b7
	inc (hl)			;d4ba
	jp nc,0fffah		;d4bb
	dec sp			;d4be
	jp nc,0ffffh		;d4bf
	ld b,l			;d4c2
	jp nc,0ffffh		;d4c3
	ld e,e			;d4c6
	jp nc,0ffffh		;d4c7
	ld h,(hl)			;d4ca
	jp nc,0ff2ah		;d4cb
	ld l,d			;d4ce
	jp nc,0ff59h		;d4cf
	ld (hl),e			;d4d2
	jp nc,0ff33h		;d4d3
	ld a,e			;d4d6
	jp nc,0ff34h		;d4d7
	ld a,a			;d4da
	jp nc,0ff4bh		;d4db
	add a,e			;d4de
	jp nc,0ff4ah		;d4df
	adc a,c			;d4e2
	jp nc,0ff4ch		;d4e3
	adc a,a			;d4e6
	jp nc,0ff30h		;d4e7
	sub l			;d4ea
	jp nc,07effh		;d4eb
	sbc a,c			;d4ee
	jp nc,0ffffh		;d4ef
	and c			;d4f2
	jp nc,0ff42h		;d4f3
	xor e			;d4f6
	jp nc,0ff47h		;d4f7
	cp l			;d4fa
	jp nc,0ff47h		;d4fb
	jp 038d2h		;d4fe
	rst 38h			;d501
	ret			;d502
	jp nc,036ffh		;d503
	call 0ffd2h		;d506
	rst 38h			;d509
	call nc,0ffd2h		;d50a
	ld c,b			;d50d
	defb 0ddh,0d2h,0ffh	;illegal sequence		;d50e
	rst 38h			;d511
	call po,039d2h		;d512
	ld a,d			;d515
	defb 0edh;next byte illegal after ed		;d516
	jp nc,07a39h		;d517
	di			;d51a
	jp nc,06739h		;d51b
	call m,044d2h		;d51e
	ld h,a			;d521
	nop			;d522
	out (044h),a		;d523
	ld (hl),004h		;d525
	out (044h),a		;d527
	ld h,(hl)			;d529
	ex af,af'			;d52a
	out (038h),a		;d52b
	ld h,(hl)			;d52d
	inc c			;d52e
	out (049h),a		;d52f
	ld h,(hl)			;d531
	djnz $-43		;d532
	ld c,c			;d534
	ld h,(hl)			;d535
	ld d,0d3h		;d536
	add hl,sp			;d538
	ld l,c			;d539
	inc e			;d53a
	out (047h),a		;d53b
	dec a			;d53d
	jr nz,$-43		;d53e
	ld c,c			;d540
	dec a			;d541
	daa			;d542
	out (049h),a		;d543
	dec a			;d545
	dec l			;d546
	out (03ah),a		;d547
	ld l,c			;d549
	inc sp			;d54a
	out (048h),a		;d54b
	dec a			;d54d
	scf			;d54e
	out (04ah),a		;d54f
	dec a			;d551
	ld a,0d3h		;d552
	ld c,d			;d554
	dec a			;d555
	ld b,h			;d556
	out (049h),a		;d557
	ld c,l			;d559
	ld c,d			;d55a
	out (03bh),a		;d55b
	ld a,054h		;d55d
	out (03bh),a		;d55f
	rst 38h			;d561
	ld e,d			;d562
	out (04ah),a		;d563
	ld a,060h		;d565
	out (04dh),a		;d567
	ld a,066h		;d569
	out (02ah),a		;d56b
	ld h,a			;d56d
	ld l,h			;d56e
	out (04ah),a		;d56f
	rst 38h			;d571
	ld (hl),d			;d572
	out (04dh),a		;d573
	rst 38h			;d575
	ld a,d			;d576
	out (04dh),a		;d577
	rst 38h			;d579
	add a,d			;d57a
	out (04dh),a		;d57b
	rst 38h			;d57d
	adc a,a			;d57e
	out (047h),a		;d57f
	rst 38h			;d581
	sub e			;d582
	out (051h),a		;d583
	jr c,$-101		;d585
	out (051h),a		;d587
	jr c,$-95		;d589
	out (051h),a		;d58b
	jr c,$-88		;d58d
	out (051h),a		;d58f
	jr c,$-79		;d591
	out (051h),a		;d593
	ld c,l			;d595
	add a,0d3h		;d596
	ld c,e			;d598
	ld (hl),d			;d599
	push de			;d59a
	out (051h),a		;d59b
	ld (hl),d			;d59d
	exx			;d59e
	out (048h),a		;d59f
	ld (hl),d			;d5a1
	defb 0ddh,0d3h,04ah	;illegal sequence		;d5a2
	ld (hl),d			;d5a5
	pop hl			;d5a6
	out (045h),a		;d5a7
	rst 38h			;d5a9
	push hl			;d5aa
	out (057h),a		;d5ab
	ld c,b			;d5ad
	xor 0d3h		;d5ae
	ld bc,0f4ffh		;d5b0
	out (040h),a		;d5b3
	rst 38h			;d5b5
	jp m,040d3h		;d5b6
	ld b,l			;d5b9
	inc bc			;d5ba
	call nc,04740h		;d5bb
	add hl,bc			;d5be
	call nc,05036h		;d5bf
	rrca			;d5c2
	call nc,06c2ch		;d5c3
	dec d			;d5c6
	call nc,07b2ch		;d5c7
	dec de			;d5ca
	call nc,07051h		;d5cb
	ld hl,009d4h		;d5ce
	rst 38h			;d5d1
	daa			;d5d2
	call nc,0ff36h		;d5d3
	cpl			;d5d6
	call nc,0ffffh		;d5d7
	dec (hl)			;d5da
	call nc,0ffffh		;d5db
	dec a			;d5de
	call nc,0ff47h		;d5df
	ld b,l			;d5e2
	call nc,0ffffh		;d5e3
	ld c,e			;d5e6
	call nc,0ffffh		;d5e7
	ld c,l			;d5ea
	call nc,0ffffh		;d5eb
	ld d,a			;d5ee
	call nc,0ffffh		;d5ef
	ld e,h			;d5f2
	call nc,0ffffh		;d5f3
	ld l,h			;d5f6
	call nc,0ffffh		;d5f7
	ld (hl),h			;d5fa
	call nc,0ffffh		;d5fb
	ld a,h			;d5fe
	call nc,00000h		;d5ff
	ld c,(hl)			;d602
	ld (bc),a			;d603
	ld d,d			;d604
	ld bc,06b01h		;d605
	ld c,028h		;d608
	ld c,(hl)			;d60a
	dec b			;d60b
	ld d,d			;d60c
	nop			;d60d
	nop			;d60e
	ld l,e			;d60f
	ld bc,04e1ch		;d610
	inc bc			;d613
	ld d,d			;d614
	nop			;d615
	nop			;d616
	ld l,e			;d617
	ld bc,0517fh		;d618
	ld (bc),a			;d61b
	ld c,e			;d61c
	inc c			;d61d
	rst 38h			;d61e
	jr nc,$+0		;d61f
	rst 38h			;d621
	ld c,a			;d622
	cp 01dh		;d623
	ld c,a			;d625
	cp 03eh		;d626
	ld c,a			;d628
	cp 0a5h		;d629
	or b			;d62b
	cp 0ffh		;d62c
	ld sp,001feh		;d62e
	rrca			;d631
	cp 0feh		;d632
	ld (hl),h			;d634
	cp 0ffh		;d635
	inc sp			;d637
	ld de,03300h		;d638
	ld (de),a			;d63b
	ld bc,07fffh		;d63c
	inc sp			;d63f
	ld hl,(03002h)		;d640
	jr nc,$+53		;d643
	dec (hl)			;d645
	ld b,b			;d646
	inc sp			;d647
	inc (hl)			;d648
	ld (02533h),a		;d649
	ld b,033h		;d64c
	ld a,(bc)			;d64e
	ld hl,(033ffh)		;d64f
	sub c			;d652
	ld b,(hl)			;d653
	rst 38h			;d654
	rst 38h			;d655
	rst 38h			;d656
	ld (bc),a			;d657
	sub 0ffh		;d658
	rst 38h			;d65a
	rra			;d65b
	sub 0ffh		;d65c
	rst 38h			;d65e
	ld (0ffd6h),hl		;d65f
	rst 38h			;d662
	ld l,0d6h		;d663
	rst 38h			;d665
	rst 38h			;d666
	scf			;d667
	sub 0ffh		;d668
	rst 38h			;d66a
	ld a,0d6h		;d66b
	rst 38h			;d66d
	rst 38h			;d66e
	ld d,c			;d66f
	sub 000h		;d670
	nop			;d672
	ld c,(hl)			;d673
	inc bc			;d674
	ld h,e			;d675
	nop			;d676
	inc e			;d677
	dec sp			;d678
	rst 30h			;d679
	halt			;d67a
	inc l			;d67b
	rst 38h			;d67c
	ld (hl),011h		;d67d
	dec de			;d67f
	rra			;d680
	ld c,(hl)			;d681
	ld bc,0ff67h		;d682
	rst 38h			;d685
	rst 38h			;d686
	ld (hl),e			;d687
	sub 0ffh		;d688
	rst 38h			;d68a
	ld a,l			;d68b
	sub 000h		;d68c
	nop			;d68e
	inc c			;d68f
	inc e			;d690
	ld h,000h		;d691
	ld d,0ffh		;d693
	jr nc,$+5		;d695
	inc sp			;d697
	ld (bc),a			;d698
	ld (hl),l			;d699
	inc sp			;d69a
	ld hl,04b01h		;d69b
	dec b			;d69e
	ld c,003h		;d69f
	ld bc,07936h		;d6a1
	rst 38h			;d6a4
	dec c			;d6a5
	inc bc			;d6a6
	ld bc,07a36h		;d6a7
	rst 38h			;d6aa
	or (hl)			;d6ab
	ld (bc),a			;d6ac
	ld (hl),077h		;d6ad
	rst 38h			;d6af
	rst 38h			;d6b0
	rst 38h			;d6b1
	adc a,a			;d6b2
	sub 0ffh		;d6b3
	rst 38h			;d6b5
	sub l			;d6b6
	sub 0ffh		;d6b7
	rst 38h			;d6b9
	and l			;d6ba
	sub 0ffh		;d6bb
	rst 38h			;d6bd
	xor e			;d6be
	sub 000h		;d6bf
	nop			;d6c1
	ld a,l			;d6c2
	ld h,004h		;d6c3
	ld l,d			;d6c5
	inc b			;d6c6
	ld c,e			;d6c7
	inc de			;d6c8
	ld (hl),e			;d6c9
	ld c,e			;d6ca
	ld b,0ffh		;d6cb
	ld sp,00121h		;d6cd
	rrca			;d6d0
	ld hl,06c0ch		;d6d1
	rst 38h			;d6d4
	rst 38h			;d6d5
	rst 38h			;d6d6
	jp nz,0ffd6h		;d6d7
	rst 38h			;d6da
	call 000d6h		;d6db
	nop			;d6de
	dec c			;d6df
	inc bc			;d6e0
	ld bc,07636h		;d6e1
	rst 38h			;d6e4
	ld c,003h		;d6e5
	ld bc,07836h		;d6e7
	rst 38h			;d6ea
	inc c			;d6eb
	inc bc			;d6ec
	or (hl)			;d6ed
	ld (bc),a			;d6ee
	rst 38h			;d6ef
	ld a,l			;d6f0
	ld hl,03102h		;d6f1
	ld (bc),a			;d6f4
	ld a,d			;d6f5
	ld sp,00103h		;d6f6
	rst 38h			;d6f9
	rst 38h			;d6fa
	rst 38h			;d6fb
	rst 18h			;d6fc
	sub 0ffh		;d6fd
	rst 38h			;d6ff
	push hl			;d700
	sub 0ffh		;d701
	rst 38h			;d703
	ex de,hl			;d704
	sub 0ffh		;d705
	rst 38h			;d707
	ret p			;d708
	sub 000h		;d709
	nop			;d70b
	dec c			;d70c
	inc sp			;d70d
	rst 38h			;d70e
	ld h,a			;d70f
	rst 38h			;d710
	add a,l			;d711
	inc sp			;d712
	add a,h			;d713
	ld (hl),074h		;d714
	ld bc,085ffh		;d716
	inc sp			;d719
	ld (hl),01ah		;d71a
	ld d,0ffh		;d71c
	ld a,l			;d71e
	inc sp			;d71f
	ld (bc),a			;d720
	ld a,(03608h)		;d721
	ld l,e			;d724
	rst 38h			;d725
	inc c			;d726
	add a,(hl)			;d727
	ld h,088h		;d728
	ld d,0ffh		;d72a
	ld sp,00102h		;d72c
	call 03b02h		;d72f
	rlca			;d732
	ld (hl),030h		;d733
	rst 38h			;d735
	inc b			;d736
	dec bc			;d737
	dec bc			;d738
	ld a,l			;d739
	ld c,l			;d73a
	ld h,c			;d73b
	rst 38h			;d73c
	inc c			;d73d
	add a,e			;d73e
	ld c,l			;d73f
	ld a,(hl)			;d740
	rst 38h			;d741
	inc c			;d742
	add a,e			;d743
	ld c,l			;d744
	ld a,(hl)			;d745
	rst 38h			;d746
	ld c,07ah		;d747
	ld bc,0274dh		;d749
	ld (hl),h			;d74c
	ld b,0ffh		;d74d
	rrca			;d74f
	ld a,d			;d750
	ld (bc),a			;d751
	ld c,l			;d752
	jr z,$+1		;d753
	ld e,c			;d755
	nop			;d756
	ld (bc),a			;d757
	ld c,a			;d758
	ld (bc),a			;d759
	inc a			;d75a
	ld c,l			;d75b
	ld e,a			;d75c
	ld c,d			;d75d
	nop			;d75e
	ld (hl),h			;d75f
	inc b			;d760
	rst 38h			;d761
	dec c			;d762
	adc a,b			;d763
	rst 38h			;d764
	ld c,l			;d765
	sub d			;d766
	rst 38h			;d767
	inc (hl)			;d768
	dec d			;d769
	rst 38h			;d76a
	inc c			;d76b
	sbc a,l			;d76c
	ld c,l			;d76d
	cp h			;d76e
	rst 38h			;d76f
	ld a,(04b1fh)		;d770
	add hl,bc			;d773
	rst 38h			;d774
	inc (hl)			;d775
	rst 38h			;d776
	rst 38h			;d777
	rst 38h			;d778
	inc c			;d779
	rst 10h			;d77a
	rst 38h			;d77b
	rst 38h			;d77c
	ld de,0ffd7h		;d77d
	rst 38h			;d780
	jr $-39		;d781
	rst 38h			;d783
	rst 38h			;d784
	ld e,0d7h		;d785
	inc l			;d787
	ld a,026h		;d788
	rst 10h			;d78a
	rst 38h			;d78b
	rst 38h			;d78c
	inc l			;d78d
	rst 10h			;d78e
	inc l			;d78f
	ld (hl),036h		;d790
	rst 10h			;d792
	inc l			;d793
	ld (hl),03dh		;d794
	rst 10h			;d796
	inc l			;d797
	ld a,042h		;d798
	rst 10h			;d79a
	inc l			;d79b
	ld c,h			;d79c
	ld b,a			;d79d
	rst 10h			;d79e
	inc l			;d79f
	ld c,h			;d7a0
	ld c,a			;d7a1
	rst 10h			;d7a2
	inc l			;d7a3
	ld (0d755h),a		;d7a4
	inc l			;d7a7
	dec sp			;d7a8
	ld h,d			;d7a9
	rst 10h			;d7aa
	inc l			;d7ab
	ld b,e			;d7ac
	ld l,b			;d7ad
	rst 10h			;d7ae
	inc l			;d7af
	ld b,(hl)			;d7b0
	ld l,e			;d7b1
	rst 10h			;d7b2
	rst 38h			;d7b3
	rst 38h			;d7b4
	ld (hl),b			;d7b5
	rst 10h			;d7b6
	rst 38h			;d7b7
	rst 38h			;d7b8
	ld (hl),l			;d7b9
	rst 10h			;d7ba
	nop			;d7bb
	nop			;d7bc
	ld a,(03603h)		;d7bd
	ld h,a			;d7c0
	ld d,0ffh		;d7c1
	ld (hl),066h		;d7c3
	rst 38h			;d7c5
	rst 38h			;d7c6
	rst 38h			;d7c7
	cp l			;d7c8
	rst 10h			;d7c9
	rst 38h			;d7ca
	rst 38h			;d7cb
	jp 000d7h		;d7cc
	nop			;d7cf
	inc sp			;d7d0
	ld (bc),a			;d7d1
	inc a			;d7d2
	ld c,a			;d7d3
	inc sp			;d7d4
	nop			;d7d5
	ld c,a			;d7d6
	inc sp			;d7d7
	ld bc,0334fh		;d7d8
	inc bc			;d7db
	inc sp			;d7dc
	ld (bc),a			;d7dd
	ld bc,04cffh		;d7de
	scf			;d7e1
	ld (bc),a			;d7e2
	ld (hl),04bh		;d7e3
	ld c,e			;d7e5
	ex af,af'			;d7e6
	ld (hl),041h		;d7e7
	ld d,0ffh		;d7e9
	ld (hl),04fh		;d7eb
	jp z,0ff33h		;d7ed
	rst 38h			;d7f0
	rst 38h			;d7f1
	ret nc			;d7f2
	rst 10h			;d7f3
	rst 38h			;d7f4
	rst 38h			;d7f5
	ret po			;d7f6
	rst 10h			;d7f7
	rst 38h			;d7f8
	rst 38h			;d7f9
	ex de,hl			;d7fa
	rst 10h			;d7fb
	nop			;d7fc
	nop			;d7fd
	dec bc			;d7fe
	ex af,af'			;d7ff
	ld c,e			;d800
	dec bc			;d801
	ld c,(hl)			;d802
	ld bc,0521dh		;d803
	rrca			;d806
	nop			;d807
	ld l,e			;d808
	ld a,(bc)			;d809
	ld a,a			;d80a
	rst 38h			;d80b
	rst 38h			;d80c
	rst 38h			;d80d
	cp 0d7h		;d80e
	nop			;d810
	nop			;d811
	inc c			;d812
	add hl,bc			;d813
	jr $+50		;d814
	add hl,bc			;d816
	rst 38h			;d817
	rst 38h			;d818
	rst 38h			;d819
	ld (de),a			;d81a
	ret c			;d81b
	nop			;d81c
	nop			;d81d
	ld c,(hl)			;d81e
	rlca			;d81f
	dec e			;d820
	ld c,(hl)			;d821
	ld bc,00252h		;d822
	nop			;d825
	ld l,e			;d826
	rla			;d827
	ld a,a			;d828
	jr nc,$+10		;d829
	ld b,c			;d82b
	nop			;d82c
	ld b,d			;d82d
	ld bc,0ffffh		;d82e
	rst 38h			;d831
	ld e,0d8h		;d832
	nop			;d834
	nop			;d835
	jr nc,$+4		;d836
	ld a,l			;d838
	inc sp			;d839
	inc bc			;d83a
	rst 38h			;d83b
	add a,h			;d83c
	ld (bc),a			;d83d
	cp b			;d83e
	ld (bc),a			;d83f
	ld a,(0b81fh)		;d840
	inc bc			;d843
	ld c,h			;d844
	ld (hl),002h		;d845
	ld d,0ffh		;d847
	ld c,a			;d849
	ld (bc),a			;d84a
	inc h			;d84b
	ld sp,00102h		;d84c
	ld (hl),h			;d84f
	cp 0ffh		;d850
	cp b			;d852
	inc bc			;d853
	ld h,a			;d854
	rst 38h			;d855
	rst 38h			;d856
	rst 38h			;d857
	ld (hl),0d8h		;d858
	rst 38h			;d85a
	rst 38h			;d85b
	inc a			;d85c
	ret c			;d85d
	rst 38h			;d85e
	rst 38h			;d85f
	ld c,c			;d860
	ret c			;d861
	rst 38h			;d862
	rst 38h			;d863
	ld d,d			;d864
	ret c			;d865
	nop			;d866
	nop			;d867
	ld c,e			;d868
	rrca			;d869
	ld a,l			;d86a
	inc sp			;d86b
	add hl,de			;d86c
	ld a,l			;d86d
	ld (hl),01bh		;d86e
	ld a,l			;d870
	scf			;d871
	jr $+127		;d872
	jr c,$+28		;d874
	ld a,l			;d876
	ld a,(07d27h)		;d877
	dec sp			;d87a
	jr z,$+102		;d87b
	ld h,a			;d87d
	rst 38h			;d87e
	rst 38h			;d87f
	rst 38h			;d880
	ld l,b			;d881
	ret c			;d882
	nop			;d883
	nop			;d884
	ld a,l			;d885
	ld (07d02h),hl		;d886
	inc hl			;d889
	inc bc			;d88a
	ld a,l			;d88b
	inc l			;d88c
	ld (02d7dh),hl		;d88d
	inc hl			;d890
	ld h,h			;d891
	ld a,l			;d892
	ld (bc),a			;d893
	ld (0037dh),hl		;d894
	inc hl			;d897
	rst 38h			;d898
	rst 38h			;d899
	rst 38h			;d89a
	add a,l			;d89b
	ret c			;d89c
	nop			;d89d
	nop			;d89e
	nop			;d89f
	jr nz,$+15		;d8a0
	adc a,e			;d8a2
	jr nz,$+81		;d8a3
	ld hl,02604h		;d8a5
	sbc a,e			;d8a8
	dec h			;d8a9
	ld bc,0ff75h		;d8aa
	nop			;d8ad
	rra			;d8ae
	dec c			;d8af
	adc a,e			;d8b0
	jr nz,$+81		;d8b1
	ld hl,02601h		;d8b3
	sbc a,e			;d8b6
	dec h			;d8b7
	ld bc,0ff75h		;d8b8
	add a,b			;d8bb
	sub c			;d8bc
	inc c			;d8bd
	and c			;d8be
	ex af,af'			;d8bf
	dec e			;d8c0
	ld h,0e1h		;d8c1
	cpl			;d8c3
	sub c			;d8c4
	ld d,0ffh		;d8c5
	add a,b			;d8c7
	sub c			;d8c8
	inc c			;d8c9
	and c			;d8ca
	ld c,l			;d8cb
	jp po,0e326h		;d8cc
	dec h			;d8cf
	ld bc,0ff75h		;d8d0
	jr nc,$-1		;d8d3
	ld (hl),l			;d8d5
	rst 38h			;d8d6
	cpl			;d8d7
	defb 0fdh,04bh,00ch	;illegal sequence		;d8d8
	ld (hl),l			;d8db
	rst 38h			;d8dc
	ld a,036h		;d8dd
	rrca			;d8df
	ld d,0ffh		;d8e0
	add hl,de			;d8e2
	nop			;d8e3
	ld d,0ffh		;d8e4
	ccf			;d8e6
	rst 38h			;d8e7
	ld c,e			;d8e8
	inc c			;d8e9
	ld (hl),l			;d8ea
	rst 38h			;d8eb
	ld h,a			;d8ec
	rst 38h			;d8ed
	ld a,(de)			;d8ee
	nop			;d8ef
	ld c,e			;d8f0
	inc c			;d8f1
	ld (hl),l			;d8f2
	rst 38h			;d8f3
	ld (hl),012h		;d8f4
	inc d			;d8f6
	dec d			;d8f7
	rst 38h			;d8f8
	ld d,0ffh		;d8f9
	ld (hl),050h		;d8fb
	ld (hl),051h		;d8fd
	cpl			;d8ff
	ld a,b			;d900
	ld d,0ffh		;d901
	ld (hl),050h		;d903
	ld (hl),052h		;d905
	cpl			;d907
	ld a,b			;d908
	ld d,0ffh		;d909
	ld c,e			;d90b
	inc b			;d90c
	ld d,0ffh		;d90d
	dec bc			;d90f
	ld bc,00a07h		;d910
	rlca			;d913
	rra			;d914
	rlca			;d915
	inc hl			;d916
	ld (hl),00ah		;d917
	ld d,0ffh		;d919
	inc c			;d91b
	ld bc,00936h		;d91c
	ld c,d			;d91f
	cp 0ffh		;d920
	rlca			;d922
	ld a,(bc)			;d923
	rlca			;d924
	rra			;d925
	rlca			;d926
	inc hl			;d927
	inc (hl)			;d928
	ld d,0ffh		;d929
	ld (hl),00bh		;d92b
	ld c,d			;d92d
	inc (iy+016h)		;d92e
	rst 38h			;d931
	ld (hl),023h		;d932
	ld d,0ffh		;d934
	nop			;d936
	ld c,00ch		;d937
	ld a,a			;d939
	ld h,06ah		;d93a
	ld h,a			;d93c
	rst 38h			;d93d
	nop			;d93e
	ld c,026h		;d93f
	ld l,b			;d941
	ld d,0ffh		;d942
	nop			;d944
	dec c			;d945
	inc c			;d946
	ld a,a			;d947
	ld h,06ah		;d948
	ld h,a			;d94a
	rst 38h			;d94b
	nop			;d94c
	dec c			;d94d
	ld h,068h		;d94e
	ld d,0ffh		;d950
	nop			;d952
	inc de			;d953
	dec bc			;d954
	add a,b			;d955
	ld h,06eh		;d956
	dec h			;d958
	ld bc,0ff75h		;d959
	nop			;d95c
	inc d			;d95d
	inc sp			;d95e
	add a,h			;d95f
	inc d			;d960
	ld h,a			;d961
	rst 38h			;d962
	nop			;d963
	dec de			;d964
	inc sp			;d965
	add a,h			;d966
	dec de			;d967
	ld h,a			;d968
	rst 38h			;d969
	nop			;d96a
	jr $+17		;d96b
	ld hl,00d0dh		;d96d
	adc a,b			;d970
	ld bc,08830h		;d971
	ld h,08dh		;d974
	inc (hl)			;d976
	ld h,a			;d977
	rst 38h			;d978
	nop			;d979
	ld e,00eh		;d97a
	adc a,e			;d97c
	jr nz,$+40		;d97d
	or (hl)			;d97f
	ld h,a			;d980
	rst 38h			;d981
	nop			;d982
	dec l			;d983
	dec c			;d984
	adc a,e			;d985
	inc l			;d986
	jr nc,$-105		;d987
	jr nc,$-102		;d989
	ld h,0b7h		;d98b
	ld h,a			;d98d
	rst 38h			;d98e
	add a,b			;d98f
	adc a,(hl)			;d990
	ld c,021h		;d991
	ld (bc),a			;d993
	rrca			;d994
	ld hl,04b05h		;d995
	dec d			;d998
	ld h,a			;d999
	rst 38h			;d99a
	nop			;d99b
	ld b,d			;d99c
	ld h,0dbh		;d99d
	ld d,0ffh		;d99f
	add a,b			;d9a1
	sub b			;d9a2
	ld h,0d8h		;d9a3
	inc sp			;d9a5
	sub b			;d9a6
	dec b			;d9a7
	ld h,a			;d9a8
	rst 38h			;d9a9
	nop			;d9aa
	ld b,c			;d9ab
	ld h,0dch		;d9ac
	ld d,0ffh		;d9ae
	nop			;d9b0
	ld b,c			;d9b1
	ld h,0dch		;d9b2
	ld d,0ffh		;d9b4
	add a,b			;d9b6
	sub c			;d9b7
	cpl			;d9b8
	and c			;d9b9
	ld c,l			;d9ba
	rst 18h			;d9bb
	add hl,bc			;d9bc
	add hl,de			;d9bd
	ld h,0e3h		;d9be
	dec h			;d9c0
	ld bc,0ff75h		;d9c1
	add a,b			;d9c4
	sub c			;d9c5
	ld h,0e0h		;d9c6
	ld d,0ffh		;d9c8
	nop			;d9ca
	ld b,a			;d9cb
	ld c,a			;d9cc
	and h			;d9cd
	rst 38h			;d9ce
	ld h,0f0h		;d9cf
	ld d,0ffh		;d9d1
	ld d,l			;d9d3
	cp 0ffh		;d9d4
	adc a,c			;d9d6
	inc sp			;d9d7
	add a,h			;d9d8
	inc sp			;d9d9
	ld (hl),031h		;d9da
	ld d,0ffh		;d9dc
	adc a,c			;d9de
	inc sp			;d9df
	ld h,a			;d9e0
	rst 38h			;d9e1
	dec hl			;d9e2
	dec c			;d9e3
	ld h,069h		;d9e4
	inc sp			;d9e6
	ld a,a			;d9e7
	ex af,af'			;d9e8
	ld d,0ffh		;d9e9
	inc c			;d9eb
	sbc a,l			;d9ec
	ld h,0bbh		;d9ed
	dec h			;d9ef
	ld bc,0ff75h		;d9f0
	ld a,(0ab00h)		;d9f3
	inc sp			;d9f6
	ld (hl),073h		;d9f7
	rst 38h			;d9f9
	inc c			;d9fa
	sbc a,c			;d9fb
	rla			;d9fc
	rst 38h			;d9fd
	ex af,af'			;d9fe
	jr nz,$+79		;d9ff
	adc a,039h		;da01
	ld h,0d0h		;da03
	dec hl			;da05
	jr nz,$+49		;da06
	sbc a,(hl)			;da08
	ld d,0ffh		;da09
	ex af,af'			;da0b
	ld hl,0e426h		;da0c
	dec h			;da0f
	ld bc,0ff75h		;da10
	ex af,af'			;da13
	ld (08926h),hl		;da14
	ld d,0ffh		;da17
	ld d,l			;da19
	cp 0ffh		;da1a
	jr nz,$+49		;da1c
	adc a,c			;da1e
	ld d,0ffh		;da1f
	ld d,l			;da21
	defb 0fdh,0ffh,00eh	;illegal sequence		;da22
	ld a,d			;da25
	ld bc,05626h		;da26
	ld d,0ffh		;da29
	ld (0ff16h),hl		;da2b
	ld d,l			;da2e
	cp 0ffh		;da2f
	ld b,l			;da31
	ld a,d			;da32
	ld c,e			;da33
	rla			;da34
	ld (hl),d			;da35
	ld l,01fh		;da36
	defb 0fdh,026h,0cdh	;ld iyh,0cdh		;da38
	ld d,0ffh		;da3b
	ld b,l			;da3d
	ld a,d			;da3e
	ld h,a			;da3f
	rst 38h			;da40
	ld hl,0ff16h		;da41
	adc a,c			;da44
	inc sp			;da45
	ld (hl),031h		;da46
	ld d,0ffh		;da48
	ld c,h			;da4a
	ld (0672ch),hl		;da4b
	rst 38h			;da4e
	ld h,066h		;da4f
	ld d,0ffh		;da51
	ld h,066h		;da53
	ld d,0ffh		;da55
	ld b,l			;da57
	ld l,h			;da58
	ld c,l			;da59
	rst 8			;da5a
	add hl,sp			;da5b
	ld h,0d0h		;da5c
	dec hl			;da5e
	jr nz,$+24		;da5f
	rst 38h			;da61
	ld h,066h		;da62
	ld d,0ffh		;da64
	ld b,l			;da66
	ld l,h			;da67
	nop			;da68
	ld c,b			;da69
	ld c,l			;da6a
	push hl			;da6b
	ld h,0e7h		;da6c
	cpl			;da6e
	and d			;da6f
	ld (hl),h			;da70
	inc bc			;da71
	rst 38h			;da72
	ld b,l			;da73
	ld l,h			;da74
	ld c,l			;da75
	rst 8			;da76
	add hl,sp			;da77
	ld (hl),h			;da78
	ld (bc),a			;da79
	rst 38h			;da7a
	ld c,e			;da7b
	ld c,085h		;da7c
	add hl,de			;da7e
	ld h,a			;da7f
	rst 38h			;da80
	ld c,l			;da81
	push hl			;da82
	ld c,e			;da83
	rrca			;da84
	ld h,0e6h		;da85
	xor h			;da87
	inc sp			;da88
	rst 38h			;da89
	ld h,0d0h		;da8a
	dec hl			;da8c
	ld hl,0ff16h		;da8d
	add a,h			;da90
	inc sp			;da91
	ld (hl),032h		;da92
	ld d,0ffh		;da94
	ld b,00ah		;da96
	dec bc			;da98
	ld a,d			;da99
	inc sp			;da9a
	ld a,d			;da9b
	ld e,026h		;da9c
	ld d,e			;da9e
	ld (hl),l			;da9f
	rst 38h			;daa0
	ld b,00ah		;daa1
	ld h,057h		;daa3
	ld d,0ffh		;daa5
	inc c			;daa7
	inc e			;daa8
	ld c,021h		;daa9
	inc c			;daab
	ld h,000h		;daac
	ld d,0ffh		;daae
	dec b			;dab0
	inc c			;dab1
	dec b			;dab2
	dec bc			;dab3
	ld h,a			;dab4
	rst 38h			;dab5
	ld b,l			;dab6
	rst 38h			;dab7
	ld (hl),053h		;dab8
	ld d,0ffh		;daba
	ld b,l			;dabc
	ld h,(hl)			;dabd
	inc c			;dabe
	ld a,l			;dabf
	ld (hl),04ch		;dac0
	ld d,0ffh		;dac2
	ld b,l			;dac4
	ld h,(hl)			;dac5
	dec b			;dac6
	add hl,bc			;dac7
	jr c,$+11		;dac8
	ld c,e			;daca
	dec c			;dacb
	ld (hl),e			;dacc
	ld h,a			;dacd
	rst 38h			;dace
	ld b,l			;dacf
	ld h,(hl)			;dad0
	dec c			;dad1
	ld a,(hl)			;dad2
	dec b			;dad3
	ld h,067h		;dad4
	ld d,0ffh		;dad6
	ld b,l			;dad8
	ld h,(hl)			;dad9
	cpl			;dada
	ld a,l			;dadb
	ld h,064h		;dadc
	ld d,0ffh		;dade
	ld b,l			;dae0
	ld a,00ch		;dae1
	add a,e			;dae3
	ld (hl),04ch		;dae4
	ld d,0ffh		;dae6
	ld b,l			;dae8
	ld a,009h		;dae9
	inc d			;daeb
	ld h,a			;daec
	rst 38h			;daed
	ld b,l			;daee
	ld a,02fh		;daef
	add a,e			;daf1
	ld a,l			;daf2
	ld (hl),002h		;daf3
	ld c,l			;daf5
	ld a,l			;daf6
	jr c,$+22		;daf7
	ld (hl),065h		;daf9
	and 002h		;dafb
	ld d,0ffh		;dafd
	dec b			;daff
	inc c			;db00
	dec b			;db01
	dec bc			;db02
	ld h,a			;db03
	rst 38h			;db04
	ld b,l			;db05
	ld a,00bh		;db06
	add a,e			;db08
	ld (hl),04ch		;db09
	ld d,0ffh		;db0b
	jr nc,$-123		;db0d
	ld (hl),00fh		;db0f
	ld (hl),l			;db11
	rst 38h			;db12
	ld bc,0670dh		;db13
	rst 38h			;db16
	inc c			;db17
	add a,b			;db18
	ld (hl),04ch		;db19
	ld d,0ffh		;db1b
	ld b,l			;db1d
	rst 38h			;db1e
	ld (hl),053h		;db1f
	ld d,0ffh		;db21
	ld b,l			;db23
	dec a			;db24
	ex af,af'			;db25
	inc de			;db26
	cpl			;db27
	add a,b			;db28
	dec hl			;db29
	inc de			;db2a
	ld h,06fh		;db2b
	ld d,0ffh		;db2d
	ld bc,0670dh		;db2f
	rst 38h			;db32
	dec bc			;db33
	add a,b			;db34
	ld (hl),04ch		;db35
	ld d,0ffh		;db37
	inc l			;db39
	inc de			;db3a
	jr nc,$-126		;db3b
	ld h,070h		;db3d
	rra			;db3f
	ld d,0ffh		;db40
	ld bc,06720h		;db42
	rst 38h			;db45
	inc c			;db46
	adc a,e			;db47
	ld h,089h		;db48
	ld d,0ffh		;db4a
	ld c,a			;db4c
	inc l			;db4d
	inc a			;db4e
	ld h,097h		;db4f
	ld d,0ffh		;db51
	add hl,bc			;db53
	ld (de),a			;db54
	ld (hl),01ch		;db55
	ld d,0ffh		;db57
	inc sp			;db59
	adc a,e			;db5a
	jr nz,$+79		;db5b
	sbc a,b			;db5d
	ld h,099h		;db5e
	ld d,0ffh		;db60
	ld b,l			;db62
	inc sp			;db63
	adc a,b			;db64
	inc sp			;db65
	inc b			;db66
	add hl,bc			;db67
	ld h,066h		;db68
	ld d,0ffh		;db6a
	ld b,l			;db6c
	ld c,c			;db6d
	adc a,b			;db6e
	inc sp			;db6f
	inc b			;db70
	ld (06626h),hl		;db71
	ld d,0ffh		;db74
	ld b,l			;db76
	ld b,(hl)			;db77
	ex af,af'			;db78
	dec de			;db79
	ex af,af'			;db7a
	inc e			;db7b
	inc c			;db7c
	sbc a,l			;db7d
	ld (hl),061h		;db7e
	ld d,0ffh		;db80
	ld b,l			;db82
	ld b,(hl)			;db83
	ex af,af'			;db84
	dec de			;db85
	ex af,af'			;db86
	inc e			;db87
	ld h,0bah		;db88
	dec hl			;db8a
	dec de			;db8b
	cpl			;db8c
	sbc a,l			;db8d
	ld d,0ffh		;db8e
	ld bc,07410h		;db90
	dec bc			;db93
	rst 38h			;db94
	ld b,l			;db95
	ld h,a			;db96
	adc a,c			;db97
	inc sp			;db98
	ld (hl),01ch		;db99
	ld d,0ffh		;db9b
	ld b,l			;db9d
	ld h,a			;db9e
	ld e,b			;db9f
	ex af,af'			;dba0
	dec b			;dba1
	ld (hl),06ah		;dba2
	ld d,0ffh		;dba4
	ld b,l			;dba6
	ld h,a			;dba7
	ld h,084h		;dba8
	ld l,008h		;dbaa
	add hl,de			;dbac
	inc c			;dbad
	add a,(hl)			;dbae
	cpl			;dbaf
	add a,a			;dbb0
	rst 38h			;dbb1
	ld b,l			;dbb2
	ld h,a			;dbb3
	ld d,0ffh		;dbb4
	ld b,l			;dbb6
	ld h,a			;dbb7
	ld h,a			;dbb8
	rst 38h			;dbb9
	ld b,l			;dbba
	ld l,a			;dbbb
	add a,l			;dbbc
	inc sp			;dbbd
	ld (hl),h			;dbbe
	dec b			;dbbf
	rst 38h			;dbc0
	ld b,l			;dbc1
	ld l,a			;dbc2
	inc c			;dbc3
	add a,l			;dbc4
	ld h,089h		;dbc5
	ld d,0ffh		;dbc7
	ld b,l			;dbc9
	ld l,a			;dbca
	inc c			;dbcb
	add a,(hl)			;dbcc
	ld (hl),04ch		;dbcd
	ld d,0ffh		;dbcf
	ld b,l			;dbd1
	ld l,a			;dbd2
	inc l			;dbd3
	inc d			;dbd4
	cpl			;dbd5
	add a,(hl)			;dbd6
	ld c,l			;dbd7
	add a,l			;dbd8
	scf			;dbd9
	ex af,af'			;dbda
	add hl,de			;dbdb
	ld c,l			;dbdc
	add a,(hl)			;dbdd
	dec hl			;dbde
	ex af,af'			;dbdf
	rst 38h			;dbe0
	ld b,l			;dbe1
	ld l,a			;dbe2
	inc (hl)			;dbe3
	ld d,0ffh		;dbe4
	ld b,l			;dbe6
	ld l,a			;dbe7
	ld h,a			;dbe8
	rst 38h			;dbe9
	ld b,l			;dbea
	ld (hl),c			;dbeb
	adc a,c			;dbec
	inc sp			;dbed
	ld (hl),01ch		;dbee
	ld d,0ffh		;dbf0
	ld b,l			;dbf2
	ld (hl),c			;dbf3
	nop			;dbf4
	jr $+16		;dbf5
	adc a,b			;dbf7
	ld bc,08c26h		;dbf8
	ld d,0ffh		;dbfb
	ld b,l			;dbfd
	ld (hl),c			;dbfe
	nop			;dbff
	jr $+79		;dc00
	sub b			;dc02
	inc l			;dc03
	ld de,0880bh		;dc04
	ld c,l			;dc07
	adc a,d			;dc08
	rst 38h			;dc09
	ld b,l			;dc0a
	ld (hl),c			;dc0b
	nop			;dc0c
	jr $+49		;dc0d
	adc a,b			;dc0f
	inc (hl)			;dc10
	ld d,0ffh		;dc11
	ld b,l			;dc13
	ld (hl),c			;dc14
	nop			;dc15
	jr $+40		;dc16
	sub c			;dc18
	ld d,0ffh		;dc19
	ld c,e			;dc1b
	ld c,085h		;dc1c
	add hl,de			;dc1e
	ld (hl),01ah		;dc1f
	ld e,h			;dc21
	ld d,0ffh		;dc22
	ld c,h			;dc24
	inc sp			;dc25
	add hl,de			;dc26
	ld h,a			;dc27
	rst 38h			;dc28
	dec bc			;dc29
	ld a,(de)			;dc2a
	ld e,h			;dc2b
	ld h,a			;dc2c
	rst 38h			;dc2d
	ld d,l			;dc2e
	cp 0ffh		;dc2f
	adc a,c			;dc31
	inc sp			;dc32
	ld (hl),01ch		;dc33
	ld d,0ffh		;dc35
	ld b,l			;dc37
	ld (00e4bh),a		;dc38
	ld c,a			;dc3b
	jr $+62		;dc3c
	ld (hl),06eh		;dc3e
	cp b			;dc40
	add hl,de			;dc41
	ld (hl),065h		;dc42
	ld d,0ffh		;dc44
	ld b,l			;dc46
	ld (0063ah),a		;dc47
	ld h,05eh		;dc4a
	ld d,0ffh		;dc4c
	ld b,l			;dc4e
	ld c,h			;dc4f
	ld c,07ah		;dc50
	ld bc,033abh		;dc52
	ld h,065h		;dc55
	ld d,0ffh		;dc57
	ret pe			;dc59
	add hl,de			;dc5a
	ld d,0ffh		;dc5b
	ld c,e			;dc5d
	ld c,00bh		;dc5e
	ld a,(de)			;dc60
	ld e,h			;dc61
	ld h,a			;dc62
	rst 38h			;dc63
	add a,l			;dc64
	add hl,de			;dc65
	ld (hl),01ah		;dc66
	ld e,h			;dc68
	ld d,0ffh		;dc69
	push de			;dc6b
	add hl,de			;dc6c
	rst 38h			;dc6d
	jp (hl)			;dc6e
	add hl,de			;dc6f
	ld d,0ffh		;dc70
	ld c,e			;dc72
	dec c			;dc73
	ld (hl),d			;dc74
	xor h			;dc75
	inc sp			;dc76
	rst 38h			;dc77
	nop			;dc78
	inc c			;dc79
	ld c,e			;dc7a
	ld a,(de)			;dc7b
	ld (hl),d			;dc7c
	ld d,0ffh		;dc7d
	nop			;dc7f
	jr c,$+77		;dc80
	ld a,(de)			;dc82
	ld (hl),d			;dc83
	ld d,0ffh		;dc84
	ld (bc),a			;dc86
	jr nc,$+5		;dc87
	inc (hl)			;dc89
	ld c,e			;dc8a
	ld a,(de)			;dc8b
	ld (hl),d			;dc8c
	ld d,0ffh		;dc8d
	nop			;dc8f
	add hl,sp			;dc90
	ld c,e			;dc91
	ld a,(de)			;dc92
	ld (hl),d			;dc93
	ld d,0ffh		;dc94
	nop			;dc96
	ld b,h			;dc97
	ld c,e			;dc98
	ld a,(de)			;dc99
	ld (hl),d			;dc9a
	ld d,0ffh		;dc9b
	ld d,l			;dc9d
	rst 38h			;dc9e
	rst 38h			;dc9f
	ld (hl),02bh		;dca0
	ld d,0ffh		;dca2
	ld a,(0360fh)		;dca4
	ld h,b			;dca7
	ld d,0ffh		;dca8
	inc b			;dcaa
	add hl,bc			;dcab
	ld h,066h		;dcac
	ld d,0ffh		;dcae
	scf			;dcb0
	rrca			;dcb1
	dec b			;dcb2
	add a,b			;dcb3
	adc a,h			;dcb4
	ld h,0a8h		;dcb5
	ld d,0ffh		;dcb7
	scf			;dcb9
	dec e			;dcba
	rst 38h			;dcbb
	dec bc			;dcbc
	sbc a,(hl)			;dcbd
	ld (hl),02bh		;dcbe
	ld d,0ffh		;dcc0
	rra			;dcc2
	ld c,e			;dcc3
	inc d			;dcc4
	ld d,0ffh		;dcc5
	nop			;dcc7
	jr nz,$+13		;dcc8
	adc a,e			;dcca
	ld h,09fh		;dccb
	ld d,0ffh		;dccd
	nop			;dccf
	dec hl			;dcd0
	dec c			;dcd1
	adc a,e			;dcd2
	dec hl			;dcd3
	dec bc			;dcd4
	sbc a,b			;dcd5
	ld h,09fh		;dcd6
	ld d,0ffh		;dcd8
	nop			;dcda
	dec hl			;dcdb
	dec c			;dcdc
	adc a,e			;dcdd
	dec hl			;dcde
	ld d,0ffh		;dcdf
	nop			;dce1
	inc l			;dce2
	dec c			;dce3
	adc a,e			;dce4
	inc l			;dce5
	ld h,a			;dce6
	rst 38h			;dce7
	add a,h			;dce8
	inc sp			;dce9
	ld (hl),06ah		;dcea
	ld d,0ffh		;dcec
	ld b,h			;dcee
	ld (bc),a			;dcef
	inc h			;dcf0
	inc l			;dcf1
	rst 38h			;dcf2
	rst 38h			;dcf3
	ld (hl),l			;dcf4
	rst 38h			;dcf5
	nop			;dcf6
	djnz $+14		;dcf7
	add a,l			;dcf9
	ld (hl),04ch		;dcfa
	ld d,0ffh		;dcfc
	nop			;dcfe
	djnz $+11		;dcff
	ex af,af'			;dd01
	ld h,07fh		;dd02
	ld d,0ffh		;dd04
	nop			;dd06
	djnz $+40		;dd07
	add a,b			;dd09
	cpl			;dd0a
	add a,l			;dd0b
	ld d,0ffh		;dd0c
	nop			;dd0e
	djnz $+40		;dd0f
	adc a,c			;dd11
	ld d,0ffh		;dd12
	nop			;dd14
	jr $+13		;dd15
	adc a,b			;dd17
	inc sp			;dd18
	adc a,b			;dd19
	ld bc,08a26h		;dd1a
	ld d,0ffh		;dd1d
	nop			;dd1f
	jr $+40		;dd20
	adc a,h			;dd22
	ld d,0ffh		;dd23
	inc c			;dd25
	sbc a,c			;dd26
	ld h,089h		;dd27
	ld d,0ffh		;dd29
	ex af,af'			;dd2b
	rra			;dd2c
	ld (hl),019h		;dd2d
	ld d,0ffh		;dd2f
	ld b,l			;dd31
	ld c,b			;dd32
	ld c,e			;dd33
	rla			;dd34
	ld (hl),e			;dd35
	ld (hl),008h		;dd36
	ld d,0ffh		;dd38
	add a,b			;dd3a
	sub b			;dd3b
	ld (hl),059h		;dd3c
	ld h,0d9h		;dd3e
	dec h			;dd40
	ld b,d			;dd41
	ld (hl),l			;dd42
	rst 38h			;dd43
	ld (hl),032h		;dd44
	ld d,0ffh		;dd46
	ld b,h			;dd48
	ld (bc),a			;dd49
	add a,l			;dd4a
	inc sp			;dd4b
	ld (hl),01ah		;dd4c
	ld d,0ffh		;dd4e
	ld b,h			;dd50
	ld (bc),a			;dd51
	ld a,(04b1fh)		;dd52
	add hl,bc			;dd55
	inc (hl)			;dd56
	ld d,0ffh		;dd57
	nop			;dd59
	ld a,(bc)			;dd5a
	ld c,07ah		;dd5b
	ld bc,02926h		;dd5d
	ld d,0ffh		;dd60
	inc b			;dd62
	dec bc			;dd63
	ld h,029h		;dd64
	ld d,0ffh		;dd66
	dec b			;dd68
	add hl,bc			;dd69
	jr c,$+11		;dd6a
	ld c,e			;dd6c
	dec c			;dd6d
	ld (hl),e			;dd6e
	ld (hl),h			;dd6f
	inc bc			;dd70
	rst 38h			;dd71
	ld c,l			;dd72
	ld hl,(00233h)		;dd73
	dec hl			;dd76
	inc c			;dd77
	ld a,(hl)			;dd78
	inc sp			;dd79
	ld (bc),a			;dd7a
	ld l,00fh		;dd7b
	ld a,(hl)			;dd7d
	dec b			;dd7e
	inc sp			;dd7f
	ld (bc),a			;dd80
	dec l			;dd81
	scf			;dd82
	add hl,bc			;dd83
	nop			;dd84
	ld c,07ah		;dd85
	ld bc,00233h		;dd87
	inc l			;dd8a
	rst 38h			;dd8b
	call 03602h		;dd8c
	inc sp			;dd8f
	ld d,0ffh		;dd90
	ld (hl),h			;dd92
	add hl,sp			;dd93
	rst 38h			;dd94
	inc b			;dd95
	dec bc			;dd96
	dec c			;dd97
	ld a,l			;dd98
	rst 38h			;dd99
	ld c,l			;dd9a
	ld hl,(02e4dh)		;dd9b
	ld (hl),033h		;dd9e
	ld d,0ffh		;dda0
	nop			;dda2
	ld c,026h		;dda3
	cpl			;dda5
	ld d,0ffh		;dda6
	nop			;dda8
	dec c			;dda9
	ld h,02fh		;ddaa
	ld d,0ffh		;ddac
	nop			;ddae
	inc c			;ddaf
	ld c,l			;ddb0
	ld c,036h		;ddb1
	inc sp			;ddb3
	ld d,0ffh		;ddb4
	nop			;ddb6
	dec c			;ddb7
	dec bc			;ddb8
	add a,b			;ddb9
	ld h,030h		;ddba
	ld d,0ffh		;ddbc
	nop			;ddbe
	dec c			;ddbf
	ld h,031h		;ddc0
	ld d,0ffh		;ddc2
	nop			;ddc4
	dec c			;ddc5
	dec bc			;ddc6
	add a,b			;ddc7
	ld h,032h		;ddc8
	ld d,0ffh		;ddca
	nop			;ddcc
	inc de			;ddcd
	dec bc			;ddce
	add a,b			;ddcf
	ld h,034h		;ddd0
	ld d,0ffh		;ddd2
	nop			;ddd4
	inc de			;ddd5
	dec bc			;ddd6
	add a,b			;ddd7
	ld h,034h		;ddd8
	ld d,0ffh		;ddda
	nop			;dddc
	inc de			;dddd
	ld h,035h		;ddde
	ld d,0ffh		;dde0
	nop			;dde2
	inc de			;dde3
	dec bc			;dde4
	add a,b			;dde5
	ld h,033h		;dde6
	ld d,0ffh		;dde8
	nop			;ddea
	inc de			;ddeb
	ld h,036h		;ddec
	ld d,0ffh		;ddee
	nop			;ddf0
	ld c,c			;ddf1
	dec bc			;ddf2
	and e			;ddf3
	ld h,051h		;ddf4
	ld d,0ffh		;ddf6
	nop			;ddf8
	ld c,c			;ddf9
	ld h,052h		;ddfa
	ld d,0ffh		;ddfc
	nop			;ddfe
	djnz $+79		;ddff
	scf			;de01
	inc sp			;de02
	ld (bc),a			;de03
	ld (hl),d			;de04
	dec bc			;de05
	add a,l			;de06
	inc sp			;de07
	ld (bc),a			;de08
	ld h,d			;de09
	rst 38h			;de0a
	nop			;de0b
	djnz $-72		;de0c
	ld (bc),a			;de0e
	ld (hl),066h		;de0f
	ld (hl),033h		;de11
	ld d,0ffh		;de13
	nop			;de15
	djnz $+79		;de16
	add a,c			;de18
	scf			;de19
	ex af,af'			;de1a
	dec b			;de1b
	ld h,082h		;de1c
	ld d,0ffh		;de1e
	nop			;de20
	djnz $+40		;de21
	add a,e			;de23
	ld d,0ffh		;de24
	nop			;de26
	jr $+40		;de27
	jr c,$+24		;de29
	rst 38h			;de2b
	nop			;de2c
	jr $+40		;de2d
	add hl,sp			;de2f
	ld d,0ffh		;de30
	nop			;de32
	jr nz,$+13		;de33
	adc a,e			;de35
	ld c,l			;de36
	ld a,(03b26h)		;de37
	ld d,0ffh		;de3a
	add a,b			;de3c
	adc a,e			;de3d
	ld h,03ah		;de3e
	ld d,0ffh		;de40
	nop			;de42
	ld e,00fh		;de43
	adc a,e			;de45
	jr nz,$+40		;de46
	inc a			;de48
	ld d,0ffh		;de49
	nop			;de4b
	ld e,00eh		;de4c
	adc a,e			;de4e
	jr nz,$+1		;de4f
	nop			;de51
	ld e,026h		;de52
	dec a			;de54
	ld d,0ffh		;de55
	nop			;de57
	ld e,00eh		;de58
	adc a,e			;de5a
	jr nz,$+40		;de5b
	dec a			;de5d
	ld d,0ffh		;de5e
	nop			;de60
	ld l,04fh		;de61
	adc a,e			;de63
	inc l			;de64
	rrca			;de65
	sub a			;de66
	inc b			;de67
	ld h,041h		;de68
	ld d,0ffh		;de6a
	nop			;de6c
	ld l,024h		;de6d
	inc l			;de6f
	ld (hl),h			;de70
	rst 38h			;de71
	nop			;de72
	ld l,04fh		;de73
	adc a,e			;de75
	inc l			;de76
	ld c,097h		;de77
	inc bc			;de79
	ld h,042h		;de7a
	ld d,0ffh		;de7c
	ld c,l			;de7e
	ld a,037h		;de7f
	rrca			;de81
	dec b			;de82
	ld c,l			;de83
	and a			;de84
	rst 38h			;de85
	inc (hl)			;de86
	ld d,0ffh		;de87
	ld c,l			;de89
	ccf			;de8a
	inc c			;de8b
	sbc a,b			;de8c
	ld c,l			;de8d
	ld b,b			;de8e
	rst 38h			;de8f
	inc (hl)			;de90
	ld d,0ffh		;de91
	inc c			;de93
	sbc a,c			;de94
	inc h			;de95
	inc l			;de96
	ld (hl),l			;de97
	rst 38h			;de98
	inc c			;de99
	sbc a,c			;de9a
	ld h,026h		;de9b
	ld d,0ffh		;de9d
	nop			;de9f
	dec l			;dea0
	ld c,a			;dea1
	adc a,e			;dea2
	inc l			;dea3
	ld h,043h		;dea4
	ld d,0ffh		;dea6
	ld (bc),a			;dea8
	jr nc,$+5		;dea9
	inc (hl)			;deab
	ld h,044h		;deac
	ld d,0ffh		;deae
	ld (bc),a			;deb0
	jr nc,$+5		;deb1
	inc (hl)			;deb3
	ld (hl),06bh		;deb4
	ld (hl),033h		;deb6
	ld d,0ffh		;deb8
	nop			;deba
	jr c,$+56		;debb
	ld l,e			;debd
	ld (hl),033h		;debe
	ld d,0ffh		;dec0
	nop			;dec2
	add hl,sp			;dec3
	ld h,045h		;dec4
	ld d,0ffh		;dec6
	nop			;dec8
	add hl,sp			;dec9
	dec b			;deca
	inc e			;decb
	ld h,045h		;decc
	ld d,0ffh		;dece
	ld h,046h		;ded0
	ld d,0ffh		;ded2
	ld h,047h		;ded4
	ld d,0ffh		;ded6
	nop			;ded8
	ld a,026h		;ded9
	ld c,a			;dedb
	ld d,0ffh		;dedc
	nop			;dede
	ld a,026h		;dedf
	ld d,b			;dee1
	ld d,0ffh		;dee2
	nop			;dee4
	ld b,c			;dee5
	ld c,l			;dee6
	ld c,b			;dee7
	dec bc			;dee8
	sub b			;dee9
	inc sp			;deea
	sub b			;deeb
	ld b,c			;deec
	ld c,l			;deed
	push de			;deee
	ld (hl),071h		;deef
	ld c,l			;def1
	sub 036h		;def2
	ld b,h			;def4
	rst 38h			;def5
	nop			;def6
	ld b,c			;def7
	inc (hl)			;def8
	ld d,0ffh		;def9
	ld h,049h		;defb
	ld d,0ffh		;defd
	ld h,04bh		;deff
	ld d,0ffh		;df01
	nop			;df03
	ld b,c			;df04
	ld h,04ah		;df05
	ld d,0ffh		;df07
	nop			;df09
	ld c,b			;df0a
	ld c,l			;df0b
	ld c,h			;df0c
	inc c			;df0d
	and d			;df0e
	ld c,l			;df0f
	ret pe			;df10
	rst 38h			;df11
	nop			;df12
	ld c,b			;df13
	inc (hl)			;df14
	ld d,0ffh		;df15
	nop			;df17
	ld b,h			;df18
	ld h,04dh		;df19
	ld d,0ffh		;df1b
	nop			;df1d
	ld b,h			;df1e
	ld c,l			;df1f
	dec h			;df20
	ld (hl),033h		;df21
	ld d,0ffh		;df23
	nop			;df25
	ld b,a			;df26
	ld h,04eh		;df27
	ld d,0ffh		;df29
	ld c,e			;df2b
	rlca			;df2c
	ld (hl),e			;df2d
	ld (hl),04dh		;df2e
	ld d,0ffh		;df30
	inc b			;df32
	add hl,bc			;df33
	ld h,066h		;df34
	ld d,0ffh		;df36
	nop			;df38
	ld a,(bc)			;df39
	ld c,07ah		;df3a
	ld bc,07b0bh		;df3c
	ld h,059h		;df3f
	ld d,0ffh		;df41
	ld c,e			;df43
	ld d,073h		;df44
	inc h			;df46
	ld e,c			;df47
	ld (de),a			;df48
	dec bc			;df49
	sbc a,d			;df4a
	ld (hl),058h		;df4b
	ld h,0c9h		;df4d
	cpl			;df4f
	sbc a,d			;df50
	ld d,0ffh		;df51
	ld (hl),058h		;df53
	ld h,0cbh		;df55
	ld d,0ffh		;df57
	add a,b			;df59
	sub b			;df5a
	ld (hl),059h		;df5b
	ld h,0d7h		;df5d
	ld d,0ffh		;df5f
	nop			;df61
	ld b,a			;df62
	ld h,0f2h		;df63
	ld d,0ffh		;df65
	ld c,022h		;df67
	ld c,00fh		;df69
	ld (02615h),hl		;df6b
	and c			;df6e
	ld d,0ffh		;df6f
	adc a,c			;df71
	inc sp			;df72
	ld h,a			;df73
	rst 38h			;df74
	ld b,l			;df75
	ld (de),a			;df76
	ld (hl),058h		;df77
	ld h,0cah		;df79
	cpl			;df7b
	adc a,a			;df7c
	dec l			;df7d
	ld (01623h),hl		;df7e
	rst 38h			;df81
	ld b,l			;df82
	ld (de),a			;df83
	ld (hl),058h		;df84
	ld h,0cbh		;df86
	ld d,0ffh		;df88
	ld c,02ch		;df8a
	ld c,00fh		;df8c
	inc l			;df8e
	dec d			;df8f
	ld h,0a1h		;df90
	ld d,0ffh		;df92
	ld b,l			;df94
	ld b,h			;df95
	nop			;df96
	ld a,008h		;df97
	ld a,(de)			;df99
	dec bc			;df9a
	sbc a,a			;df9b
	ld h,0d3h		;df9c
	cpl			;df9e
	sbc a,a			;df9f
	dec hl			;dfa0
	ld a,(de)			;dfa1
	ld l,020h		;dfa2
	cp 016h		;dfa4
	rst 38h			;dfa6
	ld b,l			;dfa7
	inc de			;dfa8
	add a,b			;dfa9
	sub b			;dfaa
	ld (hl),059h		;dfab
	ld h,0d7h		;dfad
	rst 38h			;dfaf
	ld b,l			;dfb0
	add a,b			;dfb1
	dec c			;dfb2
	and h			;dfb3
	rst 38h			;dfb4
	ld (hl),061h		;dfb5
	ld d,0ffh		;dfb7
	ld b,l			;dfb9
	add a,b			;dfba
	dec hl			;dfbb
	inc h			;dfbc
	cpl			;dfbd
	and h			;dfbe
	ld h,0f1h		;dfbf
	ld d,0ffh		;dfc1
	ld c,022h		;dfc3
	ld c,00fh		;dfc5
	ld (02615h),hl		;dfc7
	and c			;dfca
	ld d,0ffh		;dfcb
	rst 38h			;dfcd
	rst 38h			;dfce
	sbc a,a			;dfcf
	ret c			;dfd0
	rst 38h			;dfd1
	rst 38h			;dfd2
	xor l			;dfd3
	ret c			;dfd4
	ld b,c			;dfd5
	rst 38h			;dfd6
	cp e			;dfd7
	ret c			;dfd8
	rst 38h			;dfd9
	rst 38h			;dfda
	rst 0			;dfdb
	ret c			;dfdc
	ld l,0ffh		;dfdd
	out (0d8h),a		;dfdf
	cpl			;dfe1
	rst 38h			;dfe2
	rst 10h			;dfe3
	ret c			;dfe4
	ld d,l			;dfe5
	or b			;dfe6
	defb 0ddh,0d8h,055h	;illegal sequence		;dfe7
	rst 38h			;dfea
	jp po,056d8h		;dfeb
	or b			;dfee
	and 0d8h		;dfef
	ld d,(hl)			;dff1
	or b			;dff2
	call pe,056d8h		;dff3
	rst 38h			;dff6
	xor 0d8h		;dff7
	dec hl			;dff9
	rst 38h			;dffa
	call p,02bd8h		;dffb
	rst 38h			;dffe
	ld sp,hl			;dfff
	ret c			;e000
	ld (0fb30h),a		;e001
	ret c			;e004
	ld (00306h),a		;e005
	exx			;e008
	ld (00bffh),a		;e009
	exx			;e00c
	add hl,hl			;e00d
	rst 38h			;e00e
	rrca			;e00f
	exx			;e010
	add hl,hl			;e011
	rst 38h			;e012
	dec de			;e013
	exx			;e014
	add hl,hl			;e015
	rst 38h			;e016
	ld (029d9h),hl		;e017
	rst 38h			;e01a
	dec hl			;e01b
	exx			;e01c
	jr z,$+1		;e01d
	ld (001d9h),a		;e01f
	rst 38h			;e022
	ld (hl),0d9h		;e023
	ld bc,03effh		;e025
	exx			;e028
	ld (bc),a			;e029
	rst 38h			;e02a
	ld b,h			;e02b
	exx			;e02c
	ld (bc),a			;e02d
	rst 38h			;e02e
	ld c,h			;e02f
	exx			;e030
	inc b			;e031
	rst 38h			;e032
	ld d,d			;e033
	exx			;e034
	inc bc			;e035
	rst 38h			;e036
	ld e,h			;e037
	exx			;e038
	add hl,bc			;e039
	rst 38h			;e03a
	ld h,e			;e03b
	exx			;e03c
	rst 38h			;e03d
	rst 38h			;e03e
	ld l,d			;e03f
	exx			;e040
	inc b			;e041
	rst 38h			;e042
	ld a,c			;e043
	exx			;e044
	ld bc,082ffh		;e045
	exx			;e048
	rst 38h			;e049
	rst 38h			;e04a
	adc a,a			;e04b
	exx			;e04c
	ld b,0ffh		;e04d
	sbc a,e			;e04f
	exx			;e050
	ld bc,0a1ffh		;e051
	exx			;e054
	inc bc			;e055
	rst 38h			;e056
	xor d			;e057
	exx			;e058
	inc b			;e059
	rst 38h			;e05a
	or b			;e05b
	exx			;e05c
	ld bc,0b6ffh		;e05d
	exx			;e060
	ld bc,0c4ffh		;e061
	exx			;e064
	ld bc,0caffh		;e065
	exx			;e068
	ld b,(hl)			;e069
	ld sp,0d9d3h		;e06a
	ld b,(hl)			;e06d
	rst 38h			;e06e
	sub 0d9h		;e06f
	ld b,(hl)			;e071
	rst 38h			;e072
	sbc a,0d9h		;e073
	ld b,(hl)			;e075
	scf			;e076
	jp po,046d9h		;e077
	ld b,(hl)			;e07a
	ex de,hl			;e07b
	exx			;e07c
	ld b,(hl)			;e07d
	rst 38h			;e07e
	di			;e07f
	exx			;e080
	ld b,l			;e081
	ld l,d			;e082
	jp m,045d9h		;e083
	ld c,a			;e086
	cp 0d9h		;e087
	ld b,l			;e089
	ld d,b			;e08a
	dec bc			;e08b
	jp c,04945h		;e08c
	inc de			;e08f
	jp c,0314ch		;e090
	add hl,de			;e093
	jp c,0ff4ch		;e094
	inc e			;e097
	jp c,03148h		;e098
	ld hl,048dah		;e09b
	dec (hl)			;e09e
	inc h			;e09f
	jp c,0ff48h		;e0a0
	dec hl			;e0a3
	jp c,03147h		;e0a4
	ld l,0dah		;e0a7
	ld b,a			;e0a9
	ld c,b			;e0aa
	ld sp,047dah		;e0ab
	ld c,b			;e0ae
	dec a			;e0af
	jp c,0ff47h		;e0b0
	ld b,c			;e0b3
	jp c,0ff36h		;e0b4
	ld b,h			;e0b7
	jp c,0ff36h		;e0b8
	ld c,d			;e0bb
	jp c,03336h		;e0bc
	ld c,a			;e0bf
	jp c,04936h		;e0c0
	ld d,e			;e0c3
	jp c,04f36h		;e0c4
	ld d,a			;e0c7
	jp c,04f36h		;e0c8
	ld h,d			;e0cb
	jp c,05036h		;e0cc
	ld h,(hl)			;e0cf
	jp c,05036h		;e0d0
	ld (hl),e			;e0d3
	jp c,05036h		;e0d4
	ld a,e			;e0d7
	jp c,05036h		;e0d8
	add a,c			;e0db
	jp c,05036h		;e0dc
	adc a,d			;e0df
	jp c,0ff53h		;e0e0
	sub b			;e0e3
	jp c,03552h		;e0e4
	sub (hl)			;e0e7
	jp c,03552h		;e0e8
	and c			;e0eb
	jp c,0ffffh		;e0ec
	and a			;e0ef
	jp c,03639h		;e0f0
	or b			;e0f3
	jp c,03639h		;e0f4
	or (hl)			;e0f7
	jp c,03639h		;e0f8
	cp h			;e0fb
	jp c,03639h		;e0fc
	call nz,039dah		;e0ff
	ld (hl),0cfh		;e102
	jp c,03639h		;e104
	ret c			;e107
	jp c,03639h		;e108
	ret po			;e10b
	jp c,03639h		;e10c
	ret pe			;e10f
	jp c,03639h		;e110
	xor 0dah		;e113
	ld a,(0ff36h)		;e115
	jp c,0363ah		;e118
	dec b			;e11b
	in a,(03ah)		;e11c
	ld (hl),00dh		;e11e
	in a,(039h)		;e120
	ld l,l			;e122
	inc de			;e123
	in a,(039h)		;e124
	ld l,l			;e126
	rla			;e127
	in a,(039h)		;e128
	ld l,l			;e12a
	dec e			;e12b
	in a,(039h)		;e12c
	ld l,l			;e12e
	inc hl			;e12f
	in a,(03ah)		;e130
	ld l,l			;e132
	cpl			;e133
	in a,(03ah)		;e134
	ld l,l			;e136
	inc sp			;e137
	in a,(03ah)		;e138
	ld l,l			;e13a
	add hl,sp			;e13b
	in a,(03ch)		;e13c
	ld (hl),d			;e13e
	ld b,d			;e13f
	in a,(03ch)		;e140
	ld (hl),d			;e142
	ld b,(hl)			;e143
	in a,(03ch)		;e144
	ld (hl),d			;e146
	ld c,h			;e147
	in a,(03ch)		;e148
	ld (hl),d			;e14a
	ld d,e			;e14b
	in a,(03ch)		;e14c
	ld (hl),d			;e14e
	ld e,c			;e14f
	in a,(049h)		;e150
	rst 38h			;e152
	ld h,d			;e153
	in a,(049h)		;e154
	rst 38h			;e156
	ld l,h			;e157
	in a,(049h)		;e158
	ld b,l			;e15a
	halt			;e15b
	in a,(049h)		;e15c
	ld b,l			;e15e
	add a,d			;e15f
	in a,(049h)		;e160
	rst 38h			;e162
	sub b			;e163
	in a,(049h)		;e164
	rst 38h			;e166
	sub l			;e167
	in a,(049h)		;e168
	ld a,(0db9dh)		;e16a
	ld c,c			;e16d
	ld a,(0dba6h)		;e16e
	ld c,c			;e171
	ld a,(0dbb2h)		;e172
	ld c,c			;e175
	rst 38h			;e176
	or (hl)			;e177
	in a,(049h)		;e178
	rst 38h			;e17a
	cp d			;e17b
	in a,(049h)		;e17c
	ld a,0c1h		;e17e
	in a,(049h)		;e180
	ld a,0c9h		;e182
	in a,(049h)		;e184
	ld a,0d1h		;e186
	in a,(049h)		;e188
	ld a,0e1h		;e18a
	in a,(049h)		;e18c
	rst 38h			;e18e
	and 0dbh		;e18f
	ld c,c			;e191
	rst 38h			;e192
	jp pe,049dbh		;e193
	dec sp			;e196
	jp p,049dbh		;e197
	dec sp			;e19a
	defb 0fdh,0dbh,049h	;illegal sequence		;e19b
	dec sp			;e19e
	ld a,(bc)			;e19f
	call c,0ff49h		;e1a0
	inc de			;e1a3
	call c,0ff49h		;e1a4
	dec de			;e1a7
	call c,0ff49h		;e1a8
	inc h			;e1ab
	call c,0ff49h		;e1ac
	add hl,hl			;e1af
	call c,03149h		;e1b0
	ld l,0dch		;e1b3
	ld c,c			;e1b5
	rst 38h			;e1b6
	ld sp,049dch		;e1b7
	rst 38h			;e1ba
	scf			;e1bb
	call c,0ff49h		;e1bc
	ld b,(hl)			;e1bf
	call c,0ff49h		;e1c0
	ld c,(hl)			;e1c3
	call c,0ff49h		;e1c4
	ld e,c			;e1c7
	call c,0ff4ah		;e1c8
	ld e,l			;e1cb
	call c,0ff4ah		;e1cc
	ld h,h			;e1cf
	call c,0314ah		;e1d0
	ld l,e			;e1d3
	call c,0ff4ah		;e1d4
	ld l,(hl)			;e1d7
	call c,0ff4bh		;e1d8
	ld (hl),d			;e1db
	call c,0374bh		;e1dc
	ld a,b			;e1df
	call c,0444bh		;e1e0
	ld a,a			;e1e3
	call c,0454bh		;e1e4
	add a,(hl)			;e1e7
	call c,0464bh		;e1e8
	adc a,a			;e1eb
	call c,04b4bh		;e1ec
	sub (hl)			;e1ef
	call c,0314bh		;e1f0
	sbc a,l			;e1f3
	call c,0384bh		;e1f4
	and b			;e1f7
	call c,0ff4bh		;e1f8
	and h			;e1fb
	call c,0664bh		;e1fc
	xor d			;e1ff
	call c,0394bh		;e200
	or b			;e203
	call c,0474bh		;e204
	cp c			;e207
	call c,0ff4bh		;e208
	jp nz,051dch		;e20b
	ld (hl),e			;e20e
	rst 0			;e20f
	call c,07351h		;e210
	rst 8			;e213
	call c,07351h		;e214
	jp c,051dch		;e217
	ld (hl),e			;e21a
	pop hl			;e21b
	call c,0ff51h		;e21c
	ret pe			;e21f
	call c,0ff2ah		;e220
	xor 0dch		;e223
	ld hl,(0f4ffh)		;e225
	call c,06f5ah		;e228
	or 0dch		;e22b
	ld e,d			;e22d
	ld l,a			;e22e
	cp 0dch		;e22f
	ld e,d			;e231
	ld l,a			;e232
	ld b,0ddh		;e233
	ld e,e			;e235
	ld l,a			;e236
	ld c,0ddh		;e237
	inc a			;e239
	ld (hl),b			;e23a
	inc d			;e23b
	defb 0ddh,03ch,070h	;illegal sequence		;e23c
	rra			;e23f
	defb 0ddh,043h,0ffh	;illegal sequence		;e240
	dec h			;e243
	defb 0ddh,057h,048h	;illegal sequence		;e244
	dec hl			;e247
	defb 0ddh,057h,048h	;illegal sequence		;e248
	ld sp,03fddh		;e24b
	inc de			;e24e
	ld a,(02cddh)		;e24f
	ld sp,0dd44h		;e252
	inc l			;e255
	rst 38h			;e256
	ld c,b			;e257
	defb 0ddh,02ch	;inc ixl		;e258
	rst 38h			;e25a
	ld d,b			;e25b
	defb 0ddh,02ch	;inc ixl		;e25c
	ld h,l			;e25e
	ld e,c			;e25f
	defb 0ddh,02ch	;inc ixl		;e260
	ld h,l			;e262
	ld h,d			;e263
	defb 0ddh,02ch	;inc ixl		;e264
	ld h,(hl)			;e266
	ld l,b			;e267
	defb 0ddh,02ch	;inc ixl		;e268
	ld h,(hl)			;e26a
	ld (hl),d			;e26b
	defb 0ddh,02ch	;inc ixl		;e26c
	ld h,(hl)			;e26e
	adc a,h			;e26f
	defb 0ddh,02ch	;inc ixl		;e270
	ld h,h			;e272
	sub d			;e273
	defb 0ddh,02ch	;inc ixl		;e274
	ld h,(hl)			;e276
	sub l			;e277
	defb 0ddh,02ch	;inc ixl		;e278
	ld l,b			;e27a
	and d			;e27b
	defb 0ddh,02ch	;inc ixl		;e27c
	ld l,b			;e27e
	xor b			;e27f
	defb 0ddh,02ch	;inc ixl		;e280
	scf			;e282
	xor (hl)			;e283
	defb 0ddh,02ch	;inc ixl		;e284
	ld l,c			;e286
	or (hl)			;e287
	defb 0ddh,02ch	;inc ixl		;e288
	ld l,c			;e28a
	cp (hl)			;e28b
	defb 0ddh,02ch	;inc ixl		;e28c
	ld l,d			;e28e
	call nz,02cddh		;e28f
	ld l,d			;e292
	call z,02cddh		;e293
	ld l,e			;e296
	call nc,02cddh		;e297
	ld l,e			;e29a
	call c,02cddh		;e29b
	ld l,(hl)			;e29e
	jp po,02cddh		;e29f
	ld l,h			;e2a2
	jp pe,02cddh		;e2a3
	ld l,a			;e2a6
	ret p			;e2a7
	defb 0ddh,02ch	;inc ixl		;e2a8
	ld l,a			;e2aa
	ret m			;e2ab
	defb 0ddh,02ch	;inc ixl		;e2ac
	ld l,a			;e2ae
	cp 0ddh		;e2af
	inc l			;e2b1
	ld l,a			;e2b2
	dec bc			;e2b3
	sbc a,02ch		;e2b4
	ld h,a			;e2b6
	dec d			;e2b7
	sbc a,02ch		;e2b8
	ld h,a			;e2ba
	jr nz,$-32		;e2bb
	inc l			;e2bd
	ld (hl),b			;e2be
	ld h,0deh		;e2bf
	inc l			;e2c1
	ld (hl),c			;e2c2
	inc l			;e2c3
	sbc a,02ch		;e2c4
	ld (hl),e			;e2c6
	ld (02cdeh),a		;e2c7
	ld (hl),e			;e2ca
	inc a			;e2cb
	sbc a,02ch		;e2cc
	ld (hl),h			;e2ce
	ld b,d			;e2cf
	sbc a,02ch		;e2d0
	ld l,l			;e2d2
	ld c,e			;e2d3
	sbc a,02ch		;e2d4
	ld (hl),h			;e2d6
	ld d,c			;e2d7
	sbc a,02ch		;e2d8
	ld l,l			;e2da
	ld d,a			;e2db
	sbc a,02ch		;e2dc
	ld l,d			;e2de
	ld h,b			;e2df
	sbc a,02ch		;e2e0
	ld l,d			;e2e2
	ld l,h			;e2e3
	sbc a,02ch		;e2e4
	ld (hl),h			;e2e6
	ld (hl),d			;e2e7
	sbc a,02ch		;e2e8
	rrca			;e2ea
	ld a,(hl)			;e2eb
	sbc a,02ch		;e2ec
	rrca			;e2ee
	add a,(hl)			;e2ef
	sbc a,02ch		;e2f0
	djnz $-117		;e2f2
	sbc a,02ch		;e2f4
	djnz $-110		;e2f6
	sbc a,02ch		;e2f8
	ld l,d			;e2fa
	sub e			;e2fb
	sbc a,02ch		;e2fc
	ld (hl),l			;e2fe
	sbc a,c			;e2ff
	sbc a,02ch		;e300
	add a,d			;e302
	sbc a,a			;e303
	sbc a,02ch		;e304
	halt			;e306
	xor b			;e307
	sbc a,02ch		;e308
	ld b,l			;e30a
	or b			;e30b
	sbc a,02ch		;e30c
	ld b,h			;e30e
	cp d			;e30f
	sbc a,02ch		;e310
	ld (hl),a			;e312
	jp nz,02cdeh		;e313
	ld b,(hl)			;e316
	ret z			;e317
	sbc a,02ch		;e318
	ld de,0ded0h		;e31a
	inc l			;e31d
	ld (de),a			;e31e
	call nc,02cdeh		;e31f
	ld a,e			;e322
	ret c			;e323
	sbc a,02ch		;e324
	add a,c			;e326
	sbc a,0deh		;e327
	inc l			;e329
	ld a,l			;e32a
	call po,02cdeh		;e32b
	ld a,l			;e32e
	or 0deh		;e32f
	inc l			;e331
	inc de			;e332
	ei			;e333
	sbc a,02ch		;e334
	inc d			;e336
	rst 38h			;e337
	sbc a,02ch		;e338
	ld (hl),h			;e33a
	inc bc			;e33b
	rst 18h			;e33c
	inc l			;e33d
	ld l,h			;e33e
	add hl,bc			;e33f
	rst 18h			;e340
	inc l			;e341
	ld l,h			;e342
	ld (de),a			;e343
	rst 18h			;e344
	inc l			;e345
	ld a,a			;e346
	rla			;e347
	rst 18h			;e348
	inc l			;e349
	ld c,e			;e34a
	dec e			;e34b
	rst 18h			;e34c
	inc l			;e34d
	add a,b			;e34e
	dec h			;e34f
	rst 18h			;e350
	inc l			;e351
	rst 38h			;e352
	dec hl			;e353
	rst 18h			;e354
	rst 38h			;e355
	ld h,(hl)			;e356
	ld (0ffdfh),a		;e357
	ld h,h			;e35a
	jr c,$-31		;e35b
	ld e,c			;e35d
	ld (de),a			;e35e
	ld b,e			;e35f
	rst 18h			;e360
	ld e,c			;e361
	ld (de),a			;e362
	ld d,e			;e363
	rst 18h			;e364
	ld e,c			;e365
	inc de			;e366
	ld e,c			;e367
	rst 18h			;e368
	ld e,c			;e369
	add a,b			;e36a
	ld h,c			;e36b
	rst 18h			;e36c
	ld e,c			;e36d
	rst 38h			;e36e
	ld h,a			;e36f
	rst 18h			;e370
	ld b,d			;e371
	rst 38h			;e372
	ld (hl),c			;e373
	rst 18h			;e374
	ld b,d			;e375
	ld c,c			;e376
	ld (hl),l			;e377
	rst 18h			;e378
	ld b,d			;e379
	rst 38h			;e37a
	add a,d			;e37b
	rst 18h			;e37c
	ld b,d			;e37d
	rst 38h			;e37e
	adc a,d			;e37f
	rst 18h			;e380
	dec a			;e381
	add a,c			;e382
	sub h			;e383
	rst 18h			;e384
	ld b,d			;e385
	rst 38h			;e386
	and a			;e387
	rst 18h			;e388
	ld b,d			;e389
	ld c,e			;e38a
	or b			;e38b
	rst 18h			;e38c
	ld b,d			;e38d
	ld c,e			;e38e
	cp c			;e38f
	rst 18h			;e390
	ld b,c			;e391
	rst 38h			;e392
	jp 000dfh		;e393
	nop			;e396
	nop			;e397
	ld c,d			;e398
	jr $+80		;e399
	rlca			;e39b
	dec e			;e39c
	ld c,(hl)			;e39d
	ld b,052h		;e39e
	ld a,(bc)			;e3a0
	nop			;e3a1
	ld l,e			;e3a2
	ld bc,06d0eh		;e3a3
	ld c,l			;e3a6
	ld b,039h		;e3a7
	jr $+80		;e3a9
	rlca			;e3ab
	dec e			;e3ac
	dec d			;e3ad
	rst 38h			;e3ae
	cpl			;e3af
	sbc a,c			;e3b0
	ld bc,0012ch		;e3b1
	jr z,$+50		;e3b4
	sbc a,c			;e3b6
	rst 38h			;e3b7
	inc c			;e3b8
	inc e			;e3b9
	ld (hl),h			;e3ba
	ld a,(de)			;e3bb
	rst 38h			;e3bc
	ld bc,0740ah		;e3bd
	dec b			;e3c0
	rst 38h			;e3c1
	jr c,$+2		;e3c2
	ld c,a			;e3c4
	scf			;e3c5
	inc a			;e3c6
	ld c,l			;e3c7
	ld e,l			;e3c8
	ld c,d			;e3c9
	nop			;e3ca
	ld (hl),h			;e3cb
	ld bc,00effh		;e3cc
	ld a,d			;e3cf
	ld bc,03036h		;e3d0
	rst 38h			;e3d3
	ld c,07ah		;e3d4
	ld bc,05a4dh		;e3d6
	dec bc			;e3d9
	ld a,e			;e3da
	ld c,l			;e3db
	ld e,e			;e3dc
	rst 38h			;e3dd
	ld c,07ah		;e3de
	ld bc,07b0ch		;e3e0
	ld (hl),030h		;e3e3
	ld (hl),h			;e3e5
	inc d			;e3e6
	rst 38h			;e3e7
	ld c,a			;e3e8
	scf			;e3e9
	inc a			;e3ea
	ld (hl),h			;e3eb
	inc de			;e3ec
	rst 38h			;e3ed
	nop			;e3ee
	inc de			;e3ef
	dec bc			;e3f0
	add a,b			;e3f1
	ld (hl),030h		;e3f2
	ld c,l			;e3f4
	ld l,h			;e3f5
	rst 38h			;e3f6
	nop			;e3f7
	rla			;e3f8
	dec c			;e3f9
	add a,c			;e3fa
	rst 38h			;e3fb
	ld c,l			;e3fc
	halt			;e3fd
	ld c,l			;e3fe
	ld (hl),a			;e3ff
	ld c,l			;e400
	ld a,c			;e401
	rst 38h			;e402
	nop			;e403
	inc e			;e404
	dec c			;e405
	add a,c			;e406
	rst 38h			;e407
	ld c,l			;e408
	halt			;e409
	ld c,l			;e40a
	ld a,b			;e40b
	ld c,l			;e40c
	ld a,c			;e40d
	rst 38h			;e40e
	nop			;e40f
	rrca			;e410
	inc c			;e411
	adc a,d			;e412
	ld c,l			;e413
	sub l			;e414
	rst 38h			;e415
	nop			;e416
	jr nz,$+13		;e417
	adc a,e			;e419
	ld c,l			;e41a
	sub (hl)			;e41b
	rst 38h			;e41c
	nop			;e41d
	ld e,00eh		;e41e
	adc a,e			;e420
	jr nz,$+79		;e421
	sbc a,h			;e423
	rst 38h			;e424
	nop			;e425
	dec hl			;e426
	dec c			;e427
	adc a,e			;e428
	dec hl			;e429
	ld c,l			;e42a
	sbc a,l			;e42b
	rst 38h			;e42c
	ld bc,03615h		;e42d
	jr nc,$-126		;e430
	adc a,h			;e432
	ld (hl),055h		;e433
	ld (hl),05ch		;e435
	scf			;e437
	rrca			;e438
	dec b			;e439
	ld c,l			;e43a
	and a			;e43b
	rst 38h			;e43c
	add a,b			;e43d
	adc a,l			;e43e
	ld (hl),056h		;e43f
	ld (hl),05ch		;e441
	rst 38h			;e443
	add a,b			;e444
	adc a,(hl)			;e445
	ld (hl),057h		;e446
	ld (hl),05ch		;e448
	rst 38h			;e44a
	add a,b			;e44b
	adc a,a			;e44c
	ld (hl),058h		;e44d
	ld (hl),05ch		;e44f
	rst 38h			;e451
	add a,b			;e452
	sub b			;e453
	ld (hl),059h		;e454
	ld (hl),05ch		;e456
	rst 38h			;e458
	nop			;e459
	ld b,c			;e45a
	dec c			;e45b
	sub b			;e45c
	dec b			;e45d
	ld (hl),059h		;e45e
	ld (hl),05bh		;e460
	inc sp			;e462
	sub b			;e463
	ld b,c			;e464
	rst 38h			;e465
	jr nc,$-99		;e466
	nop			;e468
	ld h,00bh		;e469
	adc a,l			;e46b
	cpl			;e46c
	sbc a,e			;e46d
	ld c,l			;e46e
	or d			;e46f
	inc sp			;e470
	adc a,l			;e471
	ld h,0ffh		;e472
	nop			;e474
	jr nc,$+13		;e475
	adc a,h			;e477
	ld c,l			;e478
	or e			;e479
	inc sp			;e47a
	adc a,h			;e47b
	jr nc,$+1		;e47c
	jr nc,$-98		;e47e
	nop			;e480
	inc a			;e481
	dec bc			;e482
	adc a,(hl)			;e483
	cpl			;e484
	sbc a,h			;e485
	ld c,l			;e486
	cp l			;e487
	inc sp			;e488
	adc a,(hl)			;e489
	inc a			;e48a
	rst 38h			;e48b
	nop			;e48c
	ld b,b			;e48d
	dec bc			;e48e
	adc a,a			;e48f
	ld c,l			;e490
	ret z			;e491
	inc sp			;e492
	adc a,a			;e493
	ld b,b			;e494
	rst 38h			;e495
	nop			;e496
	inc a			;e497
	dec c			;e498
	adc a,(hl)			;e499
	rst 38h			;e49a
	ld c,l			;e49b
	cp (hl)			;e49c
	rst 38h			;e49d
	add a,b			;e49e
	sub c			;e49f
	ld c,l			;e4a0
	sbc a,0ffh		;e4a1
	dec hl			;e4a3
	nop			;e4a4
	dec hl			;e4a5
	ld bc,0032bh		;e4a6
	inc a			;e4a9
	ld l,000h		;e4aa
	ld a,(bc)			;e4ac
	ld l,001h		;e4ad
	ld a,(bc)			;e4af
	ld l,003h		;e4b0
	rrca			;e4b2
	rst 38h			;e4b3
	inc (hl)			;e4b4
	inc c			;e4b5
	ld a,b			;e4b6
	dec bc			;e4b7
	inc e			;e4b8
	ld c,e			;e4b9
	inc b			;e4ba
	rst 38h			;e4bb
	dec c			;e4bc
	ld a,c			;e4bd
	ld bc,05826h		;e4be
	dec h			;e4c1
	ld bc,0ff75h		;e4c2
	nop			;e4c5
	rra			;e4c6
	dec c			;e4c7
	adc a,e			;e4c8
	jr nz,$+40		;e4c9
	sbc a,c			;e4cb
	rst 38h			;e4cc
	nop			;e4cd
	ld hl,08b0dh		;e4ce
	jr nz,$+53		;e4d1
	adc a,e			;e4d3
	dec hl			;e4d4
	ld h,09ah		;e4d5
	rst 38h			;e4d7
	nop			;e4d8
	ccf			;e4d9
	ld b,023h		;e4da
	ld h,0c7h		;e4dc
	rst 38h			;e4de
	rst 38h			;e4df
	rst 38h			;e4e0
	sub a			;e4e1
	ex (sp),hl			;e4e2
	rst 38h			;e4e3
	rst 38h			;e4e4
	xor a			;e4e5
	ex (sp),hl			;e4e6
	rst 38h			;e4e7
	rst 38h			;e4e8
	cp b			;e4e9
	ex (sp),hl			;e4ea
	rst 38h			;e4eb
	rst 38h			;e4ec
	cp l			;e4ed
	ex (sp),hl			;e4ee
	rst 38h			;e4ef
	rst 38h			;e4f0
	jp nz,0ffe3h		;e4f1
	rst 38h			;e4f4
	adc a,0e3h		;e4f5
	rst 38h			;e4f7
	rst 38h			;e4f8
	call nc,0ffe3h		;e4f9
	rst 38h			;e4fc
	sbc a,0e3h		;e4fd
	rst 38h			;e4ff
	rst 38h			;e500
	ret pe			;e501
	ex (sp),hl			;e502
	rst 38h			;e503
	rst 38h			;e504
	xor 0e3h		;e505
	rst 38h			;e507
	rst 38h			;e508
	rst 30h			;e509
	ex (sp),hl			;e50a
	rst 38h			;e50b
	rst 38h			;e50c
	inc bc			;e50d
	call po,0ffffh		;e50e
	rrca			;e511
	call po,0ffffh		;e512
	ld d,0e4h		;e515
	rst 38h			;e517
	rst 38h			;e518
	dec e			;e519
	call po,0ffffh		;e51a
	dec h			;e51d
	call po,0ffffh		;e51e
	dec l			;e521
	call po,0ffffh		;e522
	dec a			;e525
	call po,0ffffh		;e526
	ld b,h			;e529
	call po,0ffffh		;e52a
	ld c,e			;e52d
	call po,0ffffh		;e52e
	ld d,d			;e531
	call po,0ffffh		;e532
	ld e,c			;e535
	call po,0ffffh		;e536
	ld h,(hl)			;e539
	call po,0ffffh		;e53a
	ld (hl),h			;e53d
	call po,0ffffh		;e53e
	ld a,(hl)			;e541
	call po,0ffffh		;e542
	adc a,h			;e545
	call po,0ffffh		;e546
	sub (hl)			;e549
	call po,0ffffh		;e54a
	sbc a,(hl)			;e54d
	call po,0ffffh		;e54e
	and e			;e551
	call po,0ffffh		;e552
	or h			;e555
	call po,0ffffh		;e556
	cp h			;e559
	call po,0ffffh		;e55a
	push bc			;e55d
	call po,0ffffh		;e55e
	call 0ffe4h		;e561
	rst 38h			;e564
	ret c			;e565
	call po,00000h		;e566
	jr nc,$+4		;e569
	scf			;e56b
	dec d			;e56c
	inc bc			;e56d
	scf			;e56e
	ld d,003h		;e56f
	scf			;e571
	jr $+5		;e572
	scf			;e574
	rla			;e575
	inc bc			;e576
	cpl			;e577
	ld (bc),a			;e578
	rst 38h			;e579
	inc c			;e57a
	ld (bc),a			;e57b
	dec bc			;e57c
	adc a,d			;e57d
	cpl			;e57e
	adc a,d			;e57f
	ld h,093h		;e580
	rst 38h			;e582
	dec bc			;e583
	ld (bc),a			;e584
	inc c			;e585
	adc a,d			;e586
	jr nc,$-116		;e587
	ld h,094h		;e589
	rst 38h			;e58b
	inc c			;e58c
	adc a,c			;e58d
	jr nc,$-117		;e58e
	ld b,l			;e590
	ld (hl),b			;e591
	nop			;e592
	jr $+40		;e593
	adc a,(hl)			;e595
	rst 38h			;e596
	dec c			;e597
	ld a,d			;e598
	ld (bc),a			;e599
	ld (0017ah),a		;e59a
	ld h,055h		;e59d
	inc sp			;e59f
	ld a,(hl)			;e5a0
	dec b			;e5a1
	ld (hl),l			;e5a2
	rst 38h			;e5a3
	ld c,a			;e5a4
	ld a,d			;e5a5
	ld bc,07a32h		;e5a6
	ld bc,07a0dh		;e5a9
	ld b,026h		;e5ac
	ld d,h			;e5ae
	rst 38h			;e5af
	inc c			;e5b0
	ld a,a			;e5b1
	ld (0017fh),a		;e5b2
	dec bc			;e5b5
	ld a,a			;e5b6
	ld h,06bh		;e5b7
	rst 38h			;e5b9
	ld c,a			;e5ba
	add a,c			;e5bb
	ld bc,00474h		;e5bc
	rst 38h			;e5bf
	scf			;e5c0
	ld c,016h		;e5c1
	ld (hl),h			;e5c3
	inc bc			;e5c4
	rst 38h			;e5c5
	cpl			;e5c6
	add a,c			;e5c7
	nop			;e5c8
	ld d,026h		;e5c9
	ld (hl),d			;e5cb
	dec h			;e5cc
	ld bc,0ff75h		;e5cd
	nop			;e5d0
	rla			;e5d1
	ld h,073h		;e5d2
	rst 38h			;e5d4
	nop			;e5d5
	inc e			;e5d6
	ld h,073h		;e5d7
	rst 38h			;e5d9
	nop			;e5da
	ld d,00bh		;e5db
	add a,c			;e5dd
	inc sp			;e5de
	add a,c			;e5df
	ld bc,07126h		;e5e0
	inc b			;e5e3
	ld c,026h		;e5e4
	ld (hl),l			;e5e6
	rst 38h			;e5e7
	inc c			;e5e8
	add a,c			;e5e9
	nop			;e5ea
	djnz $+40		;e5eb
	ld (hl),h			;e5ed
	jr nc,$-125		;e5ee
	rst 38h			;e5f0
	add a,b			;e5f1
	adc a,h			;e5f2
	ld sp,00196h		;e5f3
	inc sp			;e5f6
	ld (bc),a			;e5f7
	and c			;e5f8
	ld b,a			;e5f9
	sub (hl)			;e5fa
	ld (bc),a			;e5fb
	and (hl)			;e5fc
	ld (bc),a			;e5fd
	dec c			;e5fe
	sub (hl)			;e5ff
	inc b			;e600
	dec h			;e601
	ld bc,0ff75h		;e602
	add a,c			;e605
	adc a,h			;e606
	inc c			;e607
	sub (hl)			;e608
	jr nc,$-104		;e609
	ld h,0ach		;e60b
	rst 38h			;e60d
	inc c			;e60e
	sub e			;e60f
	add a,b			;e610
	sub d			;e611
	ld d,b			;e612
	adc a,h			;e613
	sub d			;e614
	ld (hl),055h		;e615
	ld (hl),05bh		;e617
	rst 38h			;e619
	inc c			;e61a
	sub e			;e61b
	add a,c			;e61c
	adc a,h			;e61d
	ld a,l			;e61e
	sub d			;e61f
	adc a,h			;e620
	ld a,l			;e621
	sub e			;e622
	sub d			;e623
	ld a,l			;e624
	ld h,093h		;e625
	rst 38h			;e627
	inc c			;e628
	sub l			;e629
	add a,b			;e62a
	sub h			;e62b
	ld d,b			;e62c
	adc a,l			;e62d
	sub h			;e62e
	ld (hl),056h		;e62f
	ld (hl),05bh		;e631
	rst 38h			;e633
	inc c			;e634
	sub l			;e635
	add a,c			;e636
	adc a,l			;e637
	ld a,l			;e638
	sub h			;e639
	adc a,l			;e63a
	ld a,l			;e63b
	sub l			;e63c
	sub h			;e63d
	ld a,l			;e63e
	ld h,095h		;e63f
	inc c			;e641
	sbc a,b			;e642
	ld a,l			;e643
	ld h,08dh		;e644
	rst 38h			;e646
	jr c,$+17		;e647
	ld c,h			;e649
	ld (hl),08ch		;e64a
	ld h,(hl)			;e64c
	dec b			;e64d
	jr nc,$-107		;e64e
	add a,b			;e650
	adc a,h			;e651
	ld h,0a6h		;e652
	rst 38h			;e654
	dec c			;e655
	adc a,h			;e656
	ld l,031h		;e657
	sub a			;e659
	ld bc,0970dh		;e65a
	inc b			;e65d
	add a,b			;e65e
	adc a,h			;e65f
	ld h,0a9h		;e660
	rst 38h			;e662
	ld c,a			;e663
	adc a,h			;e664
	ld l,00fh		;e665
	sub a			;e667
	inc b			;e668
	jr nc,$-103		;e669
	rst 38h			;e66b
	nop			;e66c
	dec hl			;e66d
	dec c			;e66e
	adc a,e			;e66f
	dec hl			;e670
	inc c			;e671
	sbc a,b			;e672
	ld h,0b1h		;e673
	inc sp			;e675
	adc a,e			;e676
	inc l			;e677
	ld (hl),h			;e678
	ld bc,00cffh		;e679
	sbc a,b			;e67c
	add a,b			;e67d
	adc a,l			;e67e
	ld (hl),056h		;e67f
	ld h,0b0h		;e681
	rst 38h			;e683
	ld c,h			;e684
	adc a,l			;e685
	adc a,h			;e686
	scf			;e687
	rrca			;e688
	dec b			;e689
	jr c,$+17		;e68a
	and 08ch		;e68c
	rst 38h			;e68e
	ld c,h			;e68f
	adc a,l			;e690
	adc a,h			;e691
	inc c			;e692
	adc a,h			;e693
	cpl			;e694
	adc a,h			;e695
	jr nc,$-107		;e696
	add a,b			;e698
	adc a,l			;e699
	ld h,0adh		;e69a
	rst 38h			;e69c
	dec c			;e69d
	adc a,l			;e69e
	ld l,00eh		;e69f
	sub a			;e6a1
	inc bc			;e6a2
	dec bc			;e6a3
	sbc a,b			;e6a4
	cpl			;e6a5
	sbc a,b			;e6a6
	jr nc,$-105		;e6a7
	ld l,019h		;e6a9
	ld l,080h		;e6ab
	adc a,l			;e6ad
	ld (hl),056h		;e6ae
	ld h,0afh		;e6b0
	rst 38h			;e6b2
	add a,b			;e6b3
	adc a,h			;e6b4
	dec bc			;e6b5
	sub e			;e6b6
	ex af,af'			;e6b7
	rrca			;e6b8
	ld a,l			;e6b9
	ld h,093h		;e6ba
	ld a,l			;e6bc
	ld h,092h		;e6bd
	ld h,0a0h		;e6bf
	rst 38h			;e6c1
	add a,b			;e6c2
	adc a,l			;e6c3
	dec bc			;e6c4
	sub l			;e6c5
	ld a,l			;e6c6
	ld h,095h		;e6c7
	ld a,l			;e6c9
	ld h,094h		;e6ca
	ld h,0a0h		;e6cc
	rst 38h			;e6ce
	add a,b			;e6cf
	adc a,l			;e6d0
	dec bc			;e6d1
	sbc a,e			;e6d2
	dec bc			;e6d3
	sbc a,b			;e6d4
	ld a,(bc)			;e6d5
	inc d			;e6d6
	ld h,0aeh		;e6d7
	dec d			;e6d9
	rst 38h			;e6da
	dec c			;e6db
	adc a,(hl)			;e6dc
	inc a			;e6dd
	dec bc			;e6de
	sbc a,h			;e6df
	ld a,(bc)			;e6e0
	inc d			;e6e1
	ld c,e			;e6e2
	dec d			;e6e3
	rst 38h			;e6e4
	ld bc,0303eh		;e6e5
	and b			;e6e8
	ld (hl),h			;e6e9
	inc bc			;e6ea
	rst 38h			;e6eb
	ld b,01fh		;e6ec
	jr nc,$-94		;e6ee
	ld (hl),h			;e6f0
	ld (bc),a			;e6f1
	rst 38h			;e6f2
	inc c			;e6f3
	and b			;e6f4
	ld h,0d2h		;e6f5
	dec h			;e6f7
	ld bc,0ff75h		;e6f8
	ld h,0d1h		;e6fb
	cpl			;e6fd
	and b			;e6fe
	rst 38h			;e6ff
	nop			;e700
	ccf			;e701
	inc b			;e702
	ld e,02bh		;e703
	ld e,026h		;e705
	call nc,000ffh		;e707
	ccf			;e70a
	inc b			;e70b
	rra			;e70c
	dec hl			;e70d
	rra			;e70e
	ld h,0d4h		;e70f
	rst 38h			;e711
	add a,b			;e712
	sub b			;e713
	ld a,(bc)			;e714
	ld e,036h		;e715
	ld e,c			;e717
	ld (hl),004h		;e718
	ld c,l			;e71a
	sub 036h		;e71b
	ld b,l			;e71d
	rst 38h			;e71e
	scf			;e71f
	dec bc			;e720
	ld c,b			;e721
	ld c,l			;e722
	jp (hl)			;e723
	inc sp			;e724
	ld (bc),a			;e725
	jp pe,0a20ch		;e726
	inc sp			;e729
	ld (bc),a			;e72a
	ex de,hl			;e72b
	rst 38h			;e72c
	scf			;e72d
	dec bc			;e72e
	ld c,b			;e72f
	and (hl)			;e730
	ld (bc),a			;e731
	dec hl			;e732
	dec bc			;e733
	inc c			;e734
	and d			;e735
	cpl			;e736
	and e			;e737
	rst 38h			;e738
	nop			;e739
	ccf			;e73a
	rlca			;e73b
	inc hl			;e73c
	ld h,0c6h		;e73d
	dec h			;e73f
	ld bc,0ff75h		;e740
	nop			;e743
	ld b,a			;e744
	scf			;e745
	inc h			;e746
	rst 38h			;e747
	dec hl			;e748
	inc h			;e749
	cpl			;e74a
	and h			;e74b
	ld h,0f1h		;e74c
	rst 38h			;e74e
	nop			;e74f
	ld b,a			;e750
	jr c,$+38		;e751
	ld c,e			;e753
	dec c			;e754
	ld (hl),d			;e755
	or a			;e756
	ld (bc),a			;e757
	rst 38h			;e758
	dec hl			;e759
	inc h			;e75a
	cpl			;e75b
	and h			;e75c
	ld h,0f1h		;e75d
	rst 38h			;e75f
	nop			;e760
	ld b,a			;e761
	ld c,a			;e762
	and h			;e763
	rst 38h			;e764
	inc sp			;e765
	ld (bc),a			;e766
	call pe,0a447h		;e767
	ld (bc),a			;e76a
	and (hl)			;e76b
	ld (bc),a			;e76c
	ld sp,001a4h		;e76d
	dec c			;e770
	and h			;e771
	inc b			;e772
	dec h			;e773
	ld bc,0ff75h		;e774
	ld bc,04f47h		;e777
	and h			;e77a
	rst 38h			;e77b
	ld (001a4h),a		;e77c
	rst 38h			;e77f
	jr c,$+13		;e780
	ld a,l			;e782
	ld (hl),002h		;e783
	jr c,$+22		;e785
	ld d,b			;e787
	ld (hl),002h		;e788
	jr nc,$-123		;e78a
	rst 38h			;e78c
	scf			;e78d
	add hl,bc			;e78e
	nop			;e78f
	ld c,07ah		;e790
	ld bc,07e32h		;e792
	ld bc,058ffh		;e795
	add hl,bc			;e798
	nop			;e799
	dec bc			;e79a
	ld a,e			;e79b
	cpl			;e79c
	ld a,e			;e79d
	ld h,05ch		;e79e
	rst 38h			;e7a0
	ld e,b			;e7a1
	add hl,bc			;e7a2
	nop			;e7a3
	rrca			;e7a4
	ld a,(hl)			;e7a5
	dec b			;e7a6
	ld sp,0017eh		;e7a7
	rst 38h			;e7aa
	inc c			;e7ab
	ld a,h			;e7ac
	ld e,b			;e7ad
	inc c			;e7ae
	dec b			;e7af
	dec l			;e7b0
	inc c			;e7b1
	dec bc			;e7b2
	rst 38h			;e7b3
	scf			;e7b4
	inc c			;e7b5
	nop			;e7b6
	ld c,07ah		;e7b7
	ld bc,00c2dh		;e7b9
	dec bc			;e7bc
	rst 38h			;e7bd
	jr nc,$+4		;e7be
	scf			;e7c0
	dec bc			;e7c1
	nop			;e7c2
	ld c,07ah		;e7c3
	ld bc,0022fh		;e7c5
	rst 38h			;e7c8
	inc c			;e7c9
	ld (bc),a			;e7ca
	dec c			;e7cb
	ld a,l			;e7cc
	rst 38h			;e7cd
	jr nc,$+127		;e7ce
	ld h,063h		;e7d0
	rst 38h			;e7d2
	inc c			;e7d3
	ld (bc),a			;e7d4
	rrca			;e7d5
	ld a,h			;e7d6
	ld a,(bc)			;e7d7
	inc sp			;e7d8
	ld a,h			;e7d9
	ld a,(bc)			;e7da
	ld h,060h		;e7db
	rst 38h			;e7dd
	ld c,a			;e7de
	ld a,l			;e7df
	rst 38h			;e7e0
	inc c			;e7e1
	ld a,h			;e7e2
	dec bc			;e7e3
	ld (bc),a			;e7e4
	ld (0017ch),a		;e7e5
	ld h,061h		;e7e8
	dec bc			;e7ea
	ld a,h			;e7eb
	dec l			;e7ec
	inc c			;e7ed
	dec bc			;e7ee
	inc b			;e7ef
	inc c			;e7f0
	ld h,062h		;e7f1
	rrca			;e7f3
	ld a,d			;e7f4
	ld (bc),a			;e7f5
	ld (hl),l			;e7f6
	rst 38h			;e7f7
	rst 38h			;e7f8
	rst 38h			;e7f9
	ld l,c			;e7fa
	push hl			;e7fb
	rst 38h			;e7fc
	rst 38h			;e7fd
	ld a,d			;e7fe
	push hl			;e7ff
	rst 38h			;e800
	rst 38h			;e801
	add a,e			;e802
	push hl			;e803
	rst 38h			;e804
	rst 38h			;e805
	adc a,h			;e806
	push hl			;e807
	rst 38h			;e808
	rst 38h			;e809
	sub a			;e80a
	push hl			;e80b
	rst 38h			;e80c
	rst 38h			;e80d
	and h			;e80e
	push hl			;e80f
	rst 38h			;e810
	rst 38h			;e811
	or b			;e812
	push hl			;e813
	rst 38h			;e814
	rst 38h			;e815
	cp d			;e816
	push hl			;e817
	rst 38h			;e818
	rst 38h			;e819
	ret nz			;e81a
	push hl			;e81b
	rst 38h			;e81c
	rst 38h			;e81d
	add a,0e5h		;e81e
	rst 38h			;e820
	rst 38h			;e821
	ret nc			;e822
	push hl			;e823
	rst 38h			;e824
	rst 38h			;e825
	push de			;e826
	push hl			;e827
	rst 38h			;e828
	rst 38h			;e829
	jp c,0ffe5h		;e82a
	rst 38h			;e82d
	ret pe			;e82e
	push hl			;e82f
	rst 38h			;e830
	rst 38h			;e831
	pop af			;e832
	push hl			;e833
	rst 38h			;e834
	rst 38h			;e835
	dec b			;e836
	and 0ffh		;e837
	rst 38h			;e839
	ld c,0e6h		;e83a
	rst 38h			;e83c
	rst 38h			;e83d
	ld a,(de)			;e83e
	and 0ffh		;e83f
	rst 38h			;e841
	jr z,$-24		;e842
	rst 38h			;e844
	rst 38h			;e845
	inc (hl)			;e846
	and 0ffh		;e847
	rst 38h			;e849
	ld b,a			;e84a
	and 0ffh		;e84b
	rst 38h			;e84d
	ld d,l			;e84e
	and 0ffh		;e84f
	rst 38h			;e851
	ld h,e			;e852
	and 051h		;e853
	ld (hl),e			;e855
	ld l,h			;e856
	and 0ffh		;e857
	rst 38h			;e859
	ld a,e			;e85a
	and 0ffh		;e85b
	rst 38h			;e85d
	add a,h			;e85e
	and 0ffh		;e85f
	rst 38h			;e861
	adc a,a			;e862
	and 0ffh		;e863
	rst 38h			;e865
	sbc a,l			;e866
	and 0ffh		;e867
	rst 38h			;e869
	or e			;e86a
	and 0ffh		;e86b
	rst 38h			;e86d
	jp nz,0ffe6h		;e86e
	rst 38h			;e871
	rst 8			;e872
	and 0ffh		;e873
	rst 38h			;e875
	in a,(0e6h)		;e876
	rst 38h			;e878
	rst 38h			;e879
	push hl			;e87a
	and 0ffh		;e87b
	rst 38h			;e87d
	call pe,0ffe6h		;e87e
	rst 38h			;e881
	di			;e882
	and 0ffh		;e883
	rst 38h			;e885
	ei			;e886
	and 0ffh		;e887
	rst 38h			;e889
	nop			;e88a
	rst 20h			;e88b
	rst 38h			;e88c
	rst 38h			;e88d
	add hl,bc			;e88e
	rst 20h			;e88f
	rst 38h			;e890
	rst 38h			;e891
	ld (de),a			;e892
	rst 20h			;e893
	rst 38h			;e894
	rst 38h			;e895
	rra			;e896
	rst 20h			;e897
	rst 38h			;e898
	rst 38h			;e899
	dec l			;e89a
	rst 20h			;e89b
	rst 38h			;e89c
	rst 38h			;e89d
	add hl,sp			;e89e
	rst 20h			;e89f
	rst 38h			;e8a0
	rst 38h			;e8a1
	ld b,e			;e8a2
	rst 20h			;e8a3
	rst 38h			;e8a4
	rst 38h			;e8a5
	ld c,a			;e8a6
	rst 20h			;e8a7
	rst 38h			;e8a8
	rst 38h			;e8a9
	ld h,b			;e8aa
	rst 20h			;e8ab
	rst 38h			;e8ac
	rst 38h			;e8ad
	ld (hl),a			;e8ae
	rst 20h			;e8af
	rst 38h			;e8b0
	rst 38h			;e8b1
	add a,b			;e8b2
	rst 20h			;e8b3
	rst 38h			;e8b4
	rst 38h			;e8b5
	adc a,l			;e8b6
	rst 20h			;e8b7
	rst 38h			;e8b8
	rst 38h			;e8b9
	sub a			;e8ba
	rst 20h			;e8bb
	rst 38h			;e8bc
	rst 38h			;e8bd
	and c			;e8be
	rst 20h			;e8bf
	rst 38h			;e8c0
	rst 38h			;e8c1
	xor e			;e8c2
	rst 20h			;e8c3
	rst 38h			;e8c4
	rst 38h			;e8c5
	or h			;e8c6
	rst 20h			;e8c7
	rst 38h			;e8c8
	rst 38h			;e8c9
	cp (hl)			;e8ca
	rst 20h			;e8cb
	rst 38h			;e8cc
	rst 38h			;e8cd
	ret			;e8ce
	rst 20h			;e8cf
	rst 38h			;e8d0
	rst 38h			;e8d1
	out (0e7h),a		;e8d2
	rst 38h			;e8d4
	rst 38h			;e8d5
	sbc a,0e7h		;e8d6
	nop			;e8d8
	nop			;e8d9
	nop			;e8da
	rla			;e8db
	dec c			;e8dc
	add a,c			;e8dd
	rst 38h			;e8de
	ld d,0ffh		;e8df
	nop			;e8e1
	inc e			;e8e2
	dec c			;e8e3
	add a,c			;e8e4
	rst 38h			;e8e5
	ld d,0ffh		;e8e6
	nop			;e8e8
	djnz $+13		;e8e9
	add a,l			;e8eb
	ld d,0ffh		;e8ec
	nop			;e8ee
	jr $+13		;e8ef
	adc a,b			;e8f1
	ld d,0ffh		;e8f2
	nop			;e8f4
	rrca			;e8f5
	dec bc			;e8f6
	adc a,d			;e8f7
	ld d,0ffh		;e8f8
	nop			;e8fa
	ld e,00fh		;e8fb
	adc a,e			;e8fd
	jr nz,$+24		;e8fe
	rst 38h			;e900
	nop			;e901
	dec l			;e902
	ld c,a			;e903
	adc a,e			;e904
	inc l			;e905
	ld d,0ffh		;e906
	nop			;e908
	inc a			;e909
	ld c,a			;e90a
	adc a,(hl)			;e90b
	rst 38h			;e90c
	ld d,0ffh		;e90d
	nop			;e90f
	ld c,c			;e910
	dec bc			;e911
	and e			;e912
	ld d,0ffh		;e913
	nop			;e915
	ld c,c			;e916
	dec bc			;e917
	and e			;e918
	ld d,0ffh		;e919
	inc b			;e91b
	rst 38h			;e91c
	jp c,009e8h		;e91d
	rst 38h			;e920
	pop hl			;e921
	ret pe			;e922
	ld (bc),a			;e923
	rst 38h			;e924
	ret pe			;e925
	ret pe			;e926
	inc bc			;e927
	rst 38h			;e928
	xor 0e8h		;e929
	ld a,(bc)			;e92b
	rst 38h			;e92c
	call p,004e8h		;e92d
	rst 38h			;e930
	jp m,001e8h		;e931
	rst 38h			;e934
	ld bc,002e9h		;e935
	rst 38h			;e938
	ex af,af'			;e939
	jp (hl)			;e93a
	ld bc,00fffh		;e93b
	jp (hl)			;e93e
	dec bc			;e93f
	rst 38h			;e940
	dec d			;e941
	jp (hl)			;e942
	nop			;e943
	nop			;e944
	jr nc,$-120		;e945
	inc c			;e947
	add a,a			;e948
	jr nc,$-119		;e949
	ld h,087h		;e94b
	inc l			;e94d
	ex af,af'			;e94e
	rst 38h			;e94f
	dec c			;e950
	adc a,b			;e951
	rst 38h			;e952
	jr nc,$-118		;e953
	ld h,08dh		;e955
	rst 38h			;e957
	ld c,e			;e958
	ld a,045h		;e959
	jp (hl)			;e95b
	ld c,e			;e95c
	dec sp			;e95d
	ld d,b			;e95e
	jp (hl)			;e95f
	nop			;e960
	nop			;e961
	nop			;e962
	inc a			;e963
	jr c,$+4		;e964
	ld a,l			;e966
	ld (hl),002h		;e967
	ex af,af'			;e969
	ld (bc),a			;e96a
	inc l			;e96b
	ld (bc),a			;e96c
	rst 38h			;e96d
	nop			;e96e
	inc a			;e96f
	ld (hl),057h		;e970
	ld c,l			;e972
	cp a			;e973
	scf			;e974
	inc e			;e975
	rst 38h			;e976
	ld c,l			;e977
	ret nz			;e978
	rst 38h			;e979
	scf			;e97a
	ld (bc),a			;e97b
	inc a			;e97c
	scf			;e97d
	inc e			;e97e
	ld (bc),a			;e97f
	inc c			;e980
	sbc a,l			;e981
	dec hl			;e982
	inc e			;e983
	cpl			;e984
	adc a,(hl)			;e985
	nop			;e986
	inc a			;e987
	ld c,l			;e988
	pop bc			;e989
	ld h,0c4h		;e98a
	jr c,$+4		;e98c
	and 002h		;e98e
	ld d,0ffh		;e990
	ld bc,00d3ch		;e992
	adc a,(hl)			;e995
	rst 38h			;e996
	ld h,0c5h		;e997
	rst 38h			;e999
	scf			;e99a
	ld (bc),a			;e99b
	inc a			;e99c
	scf			;e99d
	inc e			;e99e
	ld (bc),a			;e99f
	dec hl			;e9a0
	inc e			;e9a1
	nop			;e9a2
	inc a			;e9a3
	ld c,l			;e9a4
	pop bc			;e9a5
	scf			;e9a6
	dec de			;e9a7
	ld (bc),a			;e9a8
	ld c,l			;e9a9
	jp nz,080ffh		;e9aa
	adc a,(hl)			;e9ad
	ld c,l			;e9ae
	jp 00125h		;e9af
	ld (hl),l			;e9b2
	rst 38h			;e9b3
	rst 38h			;e9b4
	rst 38h			;e9b5
	ld h,d			;e9b6
	jp (hl)			;e9b7
	rst 38h			;e9b8
	rst 38h			;e9b9
	ld l,(hl)			;e9ba
	jp (hl)			;e9bb
	rst 38h			;e9bc
	rst 38h			;e9bd
	ld a,d			;e9be
	jp (hl)			;e9bf
	rst 38h			;e9c0
	rst 38h			;e9c1
	sub d			;e9c2
	jp (hl)			;e9c3
	rst 38h			;e9c4
	rst 38h			;e9c5
	sbc a,d			;e9c6
	jp (hl)			;e9c7
	rst 38h			;e9c8
	rst 38h			;e9c9
	xor h			;e9ca
	jp (hl)			;e9cb
	nop			;e9cc
	nop			;e9cd
	ld a,l			;e9ce
	ld (04902h),hl		;e9cf
	ld bc,07dffh		;e9d2
	ld (bc),a			;e9d5
	inc l			;e9d6
	ld h,h			;e9d7
	rst 38h			;e9d8
	inc h			;e9d9
	ld b,d			;e9da
	rst 38h			;e9db
	ld d,0ffh		;e9dc
	ld h,a			;e9de
	rst 38h			;e9df
	rst 38h			;e9e0
	rst 38h			;e9e1
	adc a,0e9h		;e9e2
	rst 38h			;e9e4
	rst 38h			;e9e5
	call nc,03de9h		;e9e6
	rst 38h			;e9e9
	exx			;e9ea
	jp (hl)			;e9eb
	rst 38h			;e9ec
	rst 38h			;e9ed
	sbc a,0e9h		;e9ee
	nop			;e9f0
	nop			;e9f1
	ex af,af'			;e9f2
	rra			;e9f3
	ld (hl),019h		;e9f4
	ld d,0ffh		;e9f6
	ex af,af'			;e9f8
	rra			;e9f9
	ld d,0ffh		;e9fa
	ex af,af'			;e9fc
	ld e,026h		;e9fd
	call z,01e2dh		;e9ff
	rra			;ea02
	ld d,0ffh		;ea03
	ld d,a			;ea05
	ld c,b			;ea06
	jp p,0ffe9h		;ea07
	rst 38h			;ea0a
	ret m			;ea0b
	jp (hl)			;ea0c
	rst 38h			;ea0d
	rst 38h			;ea0e
	call m,000e9h		;ea0f
	nop			;ea12
	nop			;ea13
	dec d			;ea14
	ex af,af'			;ea15
	dec bc			;ea16
	dec bc			;ea17
	ld a,l			;ea18
	ld d,0ffh		;ea19
	ld (bc),a			;ea1b
	add hl,de			;ea1c
	inc bc			;ea1d
	ld e,013h		;ea1e
	ld a,(de)			;ea20
	ld d,0ffh		;ea21
	nop			;ea23
	inc l			;ea24
	dec c			;ea25
	adc a,e			;ea26
	inc l			;ea27
	ld c,l			;ea28
	sbc a,(hl)			;ea29
	ld d,0ffh		;ea2a
	nop			;ea2c
	dec l			;ea2d
	dec c			;ea2e
	adc a,e			;ea2f
	inc l			;ea30
	ld c,l			;ea31
	or l			;ea32
	ld d,0ffh		;ea33
	nop			;ea35
	ld l,04fh		;ea36
	adc a,e			;ea38
	inc l			;ea39
	rrca			;ea3a
	sub a			;ea3b
	inc b			;ea3c
	ld c,l			;ea3d
	xor d			;ea3e
	ld d,0ffh		;ea3f
	nop			;ea41
	ld l,04fh		;ea42
	adc a,e			;ea44
	inc l			;ea45
	ld c,097h		;ea46
	inc bc			;ea48
	ld c,l			;ea49
	xor e			;ea4a
	ld d,0ffh		;ea4b
	ld (bc),a			;ea4d
	ld sp,03403h		;ea4e
	inc de			;ea51
	ld sp,002ffh		;ea52
	dec (hl)			;ea55
	inc bc			;ea56
	jr c,$+21		;ea57
	dec (hl)			;ea59
	rst 38h			;ea5a
	sub e			;ea5b
	ld h,0ffh		;ea5c
	rst 38h			;ea5e
	rst 38h			;ea5f
	inc de			;ea60
	jp pe,0ffffh		;ea61
	dec de			;ea64
	jp pe,0ffffh		;ea65
	inc hl			;ea68
	jp pe,0ffffh		;ea69
	inc l			;ea6c
	jp pe,0ffffh		;ea6d
	dec (hl)			;ea70
	jp pe,0ffffh		;ea71
	ld b,c			;ea74
	jp pe,0ffffh		;ea75
	ld c,l			;ea78
	jp pe,0ffffh		;ea79
	ld d,h			;ea7c
	jp pe,0ffffh		;ea7d
	ld e,e			;ea80
	jp pe,00000h		;ea81
	ld (bc),a			;ea84
	ld hl,03103h		;ea85
	inc sp			;ea88
	ld (bc),a			;ea89
	dec b			;ea8a
	rst 38h			;ea8b
	ld (bc),a			;ea8c
	jr nc,$+5		;ea8d
	dec (hl)			;ea8f
	inc sp			;ea90
	ld (bc),a			;ea91
	ld (bc),a			;ea92
	rst 38h			;ea93
	ld (bc),a			;ea94
	ld b,d			;ea95
	inc bc			;ea96
	ld b,l			;ea97
	inc sp			;ea98
	ld (bc),a			;ea99
	add hl,bc			;ea9a
	rst 38h			;ea9b
	ld (bc),a			;ea9c
	ld b,a			;ea9d
	inc sp			;ea9e
	ld (bc),a			;ea9f
	ld b,0ffh		;eaa0
	rst 38h			;eaa2
	rst 38h			;eaa3
	add a,h			;eaa4
	jp pe,0ffffh		;eaa5
	adc a,h			;eaa8
	jp pe,0ffffh		;eaa9
	sub h			;eaac
	jp pe,0ffffh		;eaad
	sbc a,h			;eab0
	jp pe,00000h		;eab1
	add a,l			;eab4
	inc sp			;eab5
	ret c			;eab6
	inc sp			;eab7
	call m,06336h		;eab8
	ld d,0ffh		;eabb
	or a			;eabd
	inc sp			;eabe
	call m,033ach		;eabf
	ld h,a			;eac2
	rst 38h			;eac3
	ld c,e			;eac4
	rst 38h			;eac5
	or h			;eac6
	jp pe,0ff4bh		;eac7
	cp l			;eaca
	jp pe,00000h		;eacb
	ld c,002h		;eace
	ld c,00fh		;ead0
	ld (bc),a			;ead2
	ld d,032h		;ead3
	ld (bc),a			;ead5
	rrca			;ead6
	inc sp			;ead7
	inc bc			;ead8
	adc a,h			;ead9
	ld b,a			;eada
	ld (bc),a			;eadb
	inc bc			;eadc
	defb 0fdh,003h,002h	;illegal sequence		;eadd
	add a,c			;eae0
	ld (bc),a			;eae1
	ld (hl),046h		;eae2
	ld h,a			;eae4
	rst 38h			;eae5
	ld d,0ffh		;eae6
	rst 38h			;eae8
	rst 38h			;eae9
	adc a,0eah		;eaea
	rst 38h			;eaec
	rst 38h			;eaed
	and 0eah		;eaee
	nop			;eaf0
	nop			;eaf1
	inc c			;eaf2
	and l			;eaf3
	ld d,0ffh		;eaf4
	ld a,l			;eaf6
	ccf			;eaf7
	inc de			;eaf8
	ld c,(hl)			;eaf9
	rlca			;eafa
	ld d,d			;eafb
	nop			;eafc
	nop			;eafd
	ld l,e			;eafe
	ld h,h			;eaff
	ld h,h			;eb00
	dec e			;eb01
	ld h,0f3h		;eb02
	ld e,h			;eb04
	rst 38h			;eb05
	ld c,c			;eb06
	nop			;eb07
	rst 38h			;eb08
	ld (hl),012h		;eb09
	inc d			;eb0b
	dec d			;eb0c
	rst 38h			;eb0d
	adc a,013h		;eb0e
	ld l,h			;eb10
	rst 38h			;eb11
	cpl			;eb12
	and l			;eb13
	ld e,h			;eb14
	adc a,013h		;eb15
	ld d,0ffh		;eb17
	inc (hl)			;eb19
	ld h,0f4h		;eb1a
	jr $-48		;eb1c
	inc de			;eb1e
	ld l,h			;eb1f
	rst 38h			;eb20
	rst 38h			;eb21
	rst 38h			;eb22
	jp p,0ffeah		;eb23
	rst 38h			;eb26
	or 0eah		;eb27
	rst 38h			;eb29
	rst 38h			;eb2a
	ld b,0ebh		;eb2b
	dec hl			;eb2d
	rst 38h			;eb2e
	add hl,bc			;eb2f
	ex de,hl			;eb30
	dec hl			;eb31
	rst 38h			;eb32
	ld c,0ebh		;eb33
	ld e,h			;eb35
	sbc a,h			;eb36
	ld (de),a			;eb37
	ex de,hl			;eb38
	rst 38h			;eb39
	rst 38h			;eb3a
	add hl,de			;eb3b
	ex de,hl			;eb3c
	nop			;eb3d
	nop			;eb3e
	ld (hl),l			;eb3f
	pop de			;eb40
	adc a,h			;eb41
	call nc,0d655h		;eb42
	add a,l			;eb45
	sub 0b0h		;eb46
	sub 0d5h		;eb48
	sub 0fah		;eb4a
	sub 077h		;eb4c
	rst 10h			;eb4e
	add a,0d7h		;eb4f
	ret p			;eb51
	rst 10h			;eb52
	inc c			;eb53
	ret c			;eb54
	jr $-38		;eb55
	jr nc,$-38		;eb57
	ld d,(hl)			;eb59
	ret c			;eb5a
	ld a,a			;eb5b
	ret c			;eb5c
	sbc a,c			;eb5d
	ret c			;eb5e
	call 0dfdfh		;eb5f
	call po,0e7f8h		;eb62
	dec de			;eb65
	jp (hl)			;eb66
	ld e,b			;eb67
	jp (hl)			;eb68
	or h			;eb69
	jp (hl)			;eb6a
	ret po			;eb6b
	jp (hl)			;eb6c
	dec b			;eb6d
	jp pe,0ea5eh		;eb6e
	and d			;eb71
	jp pe,0eac4h		;eb72
	ret pe			;eb75
	jp pe,0eb21h		;eb76
	nop			;eb79
	nop			;eb7a
	nop			;eb7b
	nop			;eb7c
	nop			;eb7d
	nop			;eb7e
	nop			;eb7f
	nop			;eb80
	nop			;eb81
	nop			;eb82
	nop			;eb83
	nop			;eb84
	nop			;eb85
	nop			;eb86
	nop			;eb87
	nop			;eb88
	nop			;eb89
	nop			;eb8a
	nop			;eb8b
	nop			;eb8c
	nop			;eb8d
	nop			;eb8e
	nop			;eb8f
	nop			;eb90
	nop			;eb91
	nop			;eb92
	nop			;eb93
	nop			;eb94
	nop			;eb95
	nop			;eb96
	nop			;eb97
	nop			;eb98
	nop			;eb99
	nop			;eb9a
	nop			;eb9b
	nop			;eb9c
	nop			;eb9d
	nop			;eb9e
	nop			;eb9f
	nop			;eba0
	nop			;eba1
	nop			;eba2
	nop			;eba3
	nop			;eba4
	nop			;eba5
	nop			;eba6
	nop			;eba7
	nop			;eba8
	nop			;eba9
	nop			;ebaa
	nop			;ebab
	nop			;ebac
	nop			;ebad
	nop			;ebae
	nop			;ebaf
	nop			;ebb0
	nop			;ebb1
	nop			;ebb2
	nop			;ebb3
	nop			;ebb4
	nop			;ebb5
	nop			;ebb6
	nop			;ebb7
	nop			;ebb8
	nop			;ebb9
	ld b,b			;ebba
	ld bc,000ffh		;ebbb
	rlca			;ebbe
	ld hl,0a150h		;ebbf
	call nz,0e121h		;ebc2
	ld h,c			;ebc5
	ld d,d			;ebc6
	ld h,c			;ebc7
	inc hl			;ebc8
	ld hl,02103h		;ebc9
	inc sp			;ebcc
	ld hl,0a140h		;ebcd
	inc sp			;ebd0
	and c			;ebd1
	ld de,02121h		;ebd2
	and c			;ebd5
	ld b,c			;ebd6
	and c			;ebd7
	dec (hl)			;ebd8
	and c			;ebd9
	dec b			;ebda
	ld hl,02120h		;ebdb
	ld (de),a			;ebde
	ld hl,0a121h		;ebdf
	ld (01281h),hl		;ebe2
	ld b,021h		;ebe5
	add a,e			;ebe7
	ld hl,0f970h		;ebe8
	di			;ebeb
	ld h,c			;ebec
	ld d,b			;ebed
	pop hl			;ebee
	ld h,d			;ebef
	ld h,c			;ebf0
	ret po			;ebf1
	ld hl,02133h		;ebf2
	inc b			;ebf5
	cp c			;ebf6
	ld (bc),a			;ebf7
	ld hl,02121h		;ebf8
	inc de			;ebfb
	ld sp,hl			;ebfc
	ld h,d			;ebfd
	pop hl			;ebfe
	ld (014e1h),a		;ebff
	and c			;ec02
	ld b,c			;ec03
	ld a,c			;ec04
	jp c,007a1h		;ec05
	and c			;ec08
	ld b,(hl)			;ec09
	and c			;ec0a
	ld (hl),d			;ec0b
	ld bc,00017h		;ec0c
	ld e,c			;ec0f
	dec de			;ec10
	ld bc,04421h		;ec11
	ld sp,hl			;ec14
	ld b,h			;ec15
	ld h,c			;ec16
	or e			;ec17
	add hl,sp			;ec18
	ld c,e			;ec19
	ld hl,02131h		;ec1a
	inc de			;ec1d
	ld hl,07903h		;ec1e
	sub e			;ec21
	ld h,c			;ec22
	ld (00321h),hl		;ec23
	ld hl,02122h		;ec26
	jr nc,$-93		;ec29
	ld (002a1h),hl		;ec2b
	pop hl			;ec2e
	ld (0b4b9h),hl		;ec2f
	ld hl,02103h		;ec32
	ld sp,031a1h		;ec35
	and c			;ec38
	inc sp			;ec39
	pop hl			;ec3a
	ld (de),a			;ec3b
	pop hl			;ec3c
	ld sp,021e1h		;ec3d
	ld a,c			;ec40
	jr $+99		;ec41
	ld (01421h),hl		;ec43
	ld hl,0a122h		;ec46
	ld sp,022a1h		;ec49
	pop hl			;ec4c
	inc d			;ec4d
	pop hl			;ec4e
	ld (02fd9h),hl		;ec4f
	ld c,0a1h		;ec52
	sub c			;ec54
	and c			;ec55
	push hl			;ec56
	ld hl,059b2h		;ec57
	jr $+5		;ec5a
	ld hl,0d994h		;ec5c
	inc e			;ec5f
	dec c			;ec60
	and c			;ec61
	add a,021h		;ec62
	jr nz,$-125		;ec64
	djnz $+4		;ec66
	ld bc,00218h		;ec68
	add a,c			;ec6b
	djnz $+6		;ec6c
	ld bc,00219h		;ec6e
	exx			;ec71
	ld (hl),h			;ec72
	ex af,af'			;ec73
	add a,c			;ec74
	inc d			;ec75
	ld b,081h		;ec76
	ld (de),a			;ec78
	ld b,081h		;ec79
	djnz $+6		;ec7b
	ld e,c			;ec7d
	inc e			;ec7e
	ex af,af'			;ec7f
	ld bc,00418h		;ec80
	add a,c			;ec83
	djnz $+4		;ec84
	add a,c			;ec86
	djnz $+8		;ec87
	add a,c			;ec89
	jr $+6		;ec8a
	ld e,c			;ec8c
	ld l,c			;ec8d
	djnz $+36		;ec8e
	ld c,b			;ec90
	jr nz,$-122		;ec91
	ld (02d3ah),hl		;ec93
	add a,h			;ec96
	ld (0253ah),hl		;ec97
	add a,h			;ec9a
	ld (0184ah),hl		;ec9b
	add a,h			;ec9e
	ld (0244dh),hl		;ec9f
	add a,h			;eca2
	ld (02c4bh),hl		;eca3
	add a,h			;eca6
	rlca			;eca7
	inc bc			;eca8
	nop			;eca9
	nop			;ecaa
	dec hl			;ecab
	ld (hl),c			;ecac
	inc bc			;ecad
	ld bc,0ff00h		;ecae
	ld a,h			;ecb1
	ld b,e			;ecb2
	inc bc			;ecb3
	nop			;ecb4
	call nc,04371h		;ecb5
	ld bc,0c759h		;ecb8
	ld hl,01841h		;ecbb
	inc b			;ecbe
	pop bc			;ecbf
	inc d			;ecc0
	dec b			;ecc1
	sbc a,c			;ecc2
	ld hl,(04106h)		;ecc3
	dec de			;ecc6
	ld (bc),a			;ecc7
	pop hl			;ecc8
	or 099h		;ecc9
	ld hl,0c107h		;eccb
	ld hl,0b904h		;ecce
	bit 4,c		;ecd1
	pop bc			;ecd3
	add hl,de			;ecd4
	ld b,(hl)			;ecd5
	ld (de),a			;ecd6
	ld h,c			;ecd7
	ld b,c			;ecd8
	sbc a,c			;ecd9
	ld (hl),a			;ecda
	ld bc,06121h		;ecdb
	nop			;ecde
	or a			;ecdf
	sbc a,l			;ece0
	inc bc			;ece1
	inc b			;ece2
	nop			;ece3
	daa			;ece4
	sbc a,l			;ece5
	inc bc			;ece6
	inc b			;ece7
	ld e,c			;ece8
	ld (09908h),hl		;ece9
	ret m			;ecec
	ld e,l			;eced
	ld hl,0b920h		;ecee
	dec b			;ecf1
	ld h,d			;ecf2
	ex af,af'			;ecf3
	djnz $-122		;ecf4
	ld h,d			;ecf6
	jr $+42		;ecf7
	add a,h			;ecf9
	ld h,d			;ecfa
	ex af,af'			;ecfb
	inc a			;ecfc
	add a,h			;ecfd
	ld h,d			;ecfe
	jr nz,$+68		;ecff
	add a,h			;ed01
	ld h,d			;ed02
	ld e,b			;ed03
	dec h			;ed04
	add a,h			;ed05
	ld h,d			;ed06
	ld d,b			;ed07
	djnz $-126		;ed08
	ld h,d			;ed0a
	jr nc,$+42		;ed0b
	add a,b			;ed0d
	ld h,d			;ed0e
	ld b,b			;ed0f
	jr z,$-126		;ed10
	ld h,d			;ed12
	ld h,b			;ed13
	ld h,080h		;ed14
	ld h,d			;ed16
	sbc a,e			;ed17
	inc hl			;ed18
	add a,b			;ed19
	ld h,d			;ed1a
	ret nz			;ed1b
	jr z,$-126		;ed1c
	ld h,d			;ed1e
	ret po			;ed1f
	ld l,080h		;ed20
	ld b,d			;ed22
	ld e,b			;ed23
	nop			;ed24
	ld b,d			;ed25
	cp b			;ed26
	nop			;ed27
	dec (hl)			;ed28
	adc a,l			;ed29
	ld (de),a			;ed2a
	inc c			;ed2b
	rra			;ed2c
	nop			;ed2d
	ld bc,0fa59h		;ed2e
	ld h,b			;ed31
	dec l			;ed32
	ld (de),a			;ed33
	inc bc			;ed34
	rra			;ed35
	nop			;ed36
	ld bc,00099h		;ed37
	ld e,012h		;ed3a
	ld bc,0001fh		;ed3c
	dec b			;ed3f
	ld (de),a			;ed40
	ld (bc),a			;ed41
	ld a,(de)			;ed42
	nop			;ed43
	dec b			;ed44
	sbc a,c			;ed45
	ld e,a			;ed46
	jr $+20		;ed47
	nop			;ed49
	rlca			;ed4a
	inc c			;ed4b
	ex af,af'			;ed4c
	add hl,de			;ed4d
	ld sp,03e33h		;ed4e
	ld (de),a			;ed51
	ld (bc),a			;ed52
	ld a,(bc)			;ed53
	ld (de),a			;ed54
	ld bc,090d9h		;ed55
	ld (bc),a			;ed58
	ld (de),a			;ed59
	ld bc,0000ah		;ed5a
	ld (bc),a			;ed5d
	rlca			;ed5e
	ld hl,0a160h		;ed5f
	sbc a,h			;ed62
	add a,c			;ed63
	ld bc,0c114h		;ed64
	rlca			;ed67
	ld de,073e1h		;ed68
	add hl,de			;ed6b
	ld c,013h		;ed6c
	ld hl,02160h		;ed6e
	and l			;ed71
	ld hl,0219ah		;ed72
	add hl,sp			;ed75
	ld h,c			;ed76
	ld c,b			;ed77
	ld h,c			;ed78
	sub (hl)			;ed79
	pop hl			;ed7a
	ld h,c			;ed7b
	pop hl			;ed7c
	add a,(hl)			;ed7d
	pop hl			;ed7e
	ld b,a			;ed7f
	add hl,sp			;ed80
	defb 0ddh,061h	;ld ixh,c		;ed81
	inc d			;ed83
	ld hl,02103h		;ed84
	ld d,l			;ed87
	ld hl,0a140h		;ed88
	ld b,h			;ed8b
	and c			;ed8c
	ld b,0e1h		;ed8d
	inc (hl)			;ed8f
	exx			;ed90
	rra			;ed91
	ld (bc),a			;ed92
	ld h,c			;ed93
	inc h			;ed94
	ld hl,02114h		;ed95
	ld (042a1h),a		;ed98
	and c			;ed9b
	inc de			;ed9c
	pop hl			;ed9d
	dec d			;ed9e
	pop hl			;ed9f
	ld sp,0e107h		;eda0
	ld de,011a1h		;eda3
	ld hl,02120h		;eda6
	ld de,03021h		;eda9
	and c			;edac
	ld de,01021h		;edad
	and c			;edb0
	ld de,01121h		;edb1
	and c			;edb4
	ld h,c			;edb5
	and c			;edb6
	ld (01021h),hl		;edb7
	ld hl,02111h		;edba
	djnz $-93		;edbd
	ld (01121h),hl		;edbf
	and c			;edc2
	ld de,02021h		;edc3
	ld hl,02111h		;edc6
	jr nz,$-93		;edc9
	ld de,03021h		;edcb
	and c			;edce
	ld de,03021h		;edcf
	and c			;edd2
	ld de,02021h		;edd3
	and c			;edd6
	ld de,011e1h		;edd7
	pop hl			;edda
	jp nz,011e1h		;eddb
	ld h,c			;edde
	jp nc,02261h		;eddf
	ld h,c			;ede2
	djnz $+99		;ede3
	ld (011e1h),hl		;ede5
	pop hl			;ede8
	ld (hl),c			;ede9
	pop hl			;edea
	inc sp			;edeb
	ld h,c			;edec
	djnz $-29		;eded
	ld de,05061h		;edef
	ld h,c			;edf2
	ld de,01061h		;edf3
	pop hl			;edf6
	sub c			;edf7
	ld h,c			;edf8
	ld de,02061h		;edf9
	ld h,c			;edfc
	ld de,07161h		;edfd
	ld h,c			;ee00
	inc h			;ee01
	ld hl,02123h		;ee02
	ld d,c			;ee05
	ld hl,021a2h		;ee06
	add a,d			;ee09
	and c			;ee0a
	ld (hl),d			;ee0b
	add a,d			;ee0c
	nop			;ee0d
	ex af,af'			;ee0e
	add a,d			;ee0f
	jr nz,$+10		;ee10
	rlca			;ee12
	inc bc			;ee13
	nop			;ee14
	nop			;ee15
	cp d			;ee16
	ld (hl),c			;ee17
	pop hl			;ee18
	inc de			;ee19
	pop hl			;ee1a
	ld (de),a			;ee1b
	and c			;ee1c
	ld de,021a1h		;ee1d
	ld hl,0a191h		;ee20
	jp nc,012a1h		;ee23
	pop hl			;ee26
	cp h			;ee27
	and c			;ee28
	ld (bc),a			;ee29
	and c			;ee2a
	ld hl,0b5a1h		;ee2b
	pop hl			;ee2e
	ld d,a			;ee2f
	and c			;ee30
	ld (bc),a			;ee31
	and c			;ee32
	ld (01781h),a		;ee33
	ex af,af'			;ee36
	ld e,c			;ee37
	dec d			;ee38
	inc de			;ee39
	ld hl,0219fh		;ee3a
	ld b,l			;ee3d
	ld hl,02167h		;ee3e
	daa			;ee41
	ld hl,02125h		;ee42
	ld h,e			;ee45
	ld hl,02172h		;ee46
	dec (hl)			;ee49
	exx			;ee4a
	add hl,hl			;ee4b
	inc e			;ee4c
	ld hl,00116h		;ee4d
	inc b			;ee50
	rla			;ee51
	ld bc,01406h		;ee52
	ld h,c			;ee55
	adc a,(hl)			;ee56
	nop			;ee57
	defb 0ddh,098h,0a1h	;illegal sequence		;ee58
	ld b,e			;ee5b
	and c			;ee5c
	ld d,0f9h		;ee5d
	adc a,061h		;ee5f
	ld a,e			;ee61
	ld h,c			;ee62
	inc de			;ee63
	ld b,c			;ee64
	inc c			;ee65
	djnz $+99		;ee66
	dec h			;ee68
	ld h,c			;ee69
	ld h,d			;ee6a
	sbc a,c			;ee6b
	nop			;ee6c
	dec (hl)			;ee6d
	ld hl,02116h		;ee6e
	ld b,h			;ee71
	ld h,c			;ee72
	ld d,061h		;ee73
	add hl,sp			;ee75
	add hl,de			;ee76
	daa			;ee77
	dec b			;ee78
	add a,c			;ee79
	rlca			;ee7a
	add hl,de			;ee7b
	nop			;ee7c
	sub a			;ee7d
	add a,d			;ee7e
	ld hl,0216ah		;ee7f
	dec b			;ee82
	ld hl,02167h		;ee83
	ld e,a			;ee86
	exx			;ee87
	ld de,0a126h		;ee88
	and d			;ee8b
	ld hl,02182h		;ee8c
	ld h,b			;ee8f
	pop hl			;ee90
	ld e,c			;ee91
	pop hl			;ee92
	ld e,b			;ee93
	and c			;ee94
	add a,c			;ee95
	ld hl,079d3h		;ee96
	rst 8			;ee99
	ld bc,02607h		;ee9a
	sbc a,c			;ee9d
	ld b,01eh		;ee9e
	ld bc,01906h		;eea0
	exx			;eea3
	ld hl,(04120h)		;eea4
	inc e			;eea7
	nop			;eea8
	pop hl			;eea9
	ld (0a6a1h),hl		;eeaa
	pop bc			;eead
	djnz $+8		;eeae
	pop bc			;eeb0
	dec de			;eeb1
	inc b			;eeb2
	pop bc			;eeb3
	ld (de),a			;eeb4
	inc bc			;eeb5
	add a,c			;eeb6
	inc e			;eeb7
	dec b			;eeb8
	pop hl			;eeb9
	or e			;eeba
	and c			;eebb
	ld b,e			;eebc
	and c			;eebd
	jp nz,01ac1h		;eebe
	ld b,0a1h		;eec1
	sub h			;eec3
	pop bc			;eec4
	djnz $+8		;eec5
	ld h,c			;eec7
	ld (hl),c			;eec8
	pop hl			;eec9
	ret c			;eeca
	pop bc			;eecb
	add hl,de			;eecc
	add hl,bc			;eecd
	add hl,sp			;eece
	push af			;eecf
	ld bc,0100bh		;eed0
	ld hl,021c3h		;eed3
	jr c,$+35		;eed6
	ld d,l			;eed8
	ld h,c			;eed9
	jr $+59		;eeda
	jr nc,$-93		;eedc
	ld c,b			;eede
	pop hl			;eedf
	dec (hl)			;eee0
	pop hl			;eee1
	scf			;eee2
	pop hl			;eee3
	rr c		;eee4
	ld (de),a			;eee6
	inc c			;eee7
	and c			;eee8
	inc de			;eee9
	pop hl			;eeea
	ld b,(hl)			;eeeb
	nop			;eeec
	ld d,a			;eeed
	ld h,l			;eeee
	and c			;eeef
	dec d			;eef0
	pop hl			;eef1
	inc (hl)			;eef2
	add hl,de			;eef3
	inc h			;eef4
	inc h			;eef5
	pop hl			;eef6
	ld (hl),0e1h		;eef7
	ld (hl),a			;eef9
	nop			;eefa
	nop			;eefb
	ld a,b			;eefc
	ld bc,01309h		;eefd
	ld h,c			;ef00
	jr z,$+3		;ef01
	ld c,014h		;ef03
	ld bc,000eah		;ef05
	ld b,c			;ef08
	rst 38h			;ef09
	nop			;ef0a
	sbc a,c			;ef0b
	ex af,af'			;ef0c
	ld h,a			;ef0d
	ld hl,0a12ah		;ef0e
	ld e,d			;ef11
	ld a,c			;ef12
	ld e,d			;ef13
	ld bc,02800h		;ef14
	ld b,c			;ef17
	dec b			;ef18
	djnz $-101		;ef19
	dec b			;ef1b
	djnz $+3		;ef1c
	ld (bc),a			;ef1e
	djnz $+35		;ef1f
	ld c,e			;ef21
	ld bc,01301h		;ef22
	nop			;ef25
	ld (hl),0a7h		;ef26
	and c			;ef28
	inc c			;ef29
	pop hl			;ef2a
	ld e,c			;ef2b
	and c			;ef2c
	jr z,$-93		;ef2d
	ld l,0e1h		;ef2f
	ld l,081h		;ef31
	ld b,017h		;ef33
	add hl,sp			;ef35
	ld h,c			;ef36
	ld h,c			;ef37
	inc l			;ef38
	ld b,c			;ef39
	add hl,bc			;ef3a
	djnz $+91		;ef3b
	ld bc,02114h		;ef3d
	dec (hl)			;ef40
	ld hl,00118h		;ef41
	add hl,bc			;ef44
	ld (de),a			;ef45
	add hl,de			;ef46
	jr z,$+2		;ef47
	pop hl			;ef49
	ld a,(047a1h)		;ef4a
	pop hl			;ef4d
	ccf			;ef4e
	pop hl			;ef4f
	dec (hl)			;ef50
	pop hl			;ef51
	rla			;ef52
	pop hl			;ef53
	ld a,(de)			;ef54
	add hl,sp			;ef55
	ld h,c			;ef56
	ld b,c			;ef57
	inc bc			;ef58
	ld (de),a			;ef59
	ld bc,01008h		;ef5a
	ld b,c			;ef5d
	ld bc,02110h		;ef5e
	ld b,e			;ef61
	ld bc,00020h		;ef62
	pop bc			;ef65
	inc bc			;ef66
	ld de,02ae1h		;ef67
	and c			;ef6a
	ld a,(bc)			;ef6b
	add hl,sp			;ef6c
	ld d,b			;ef6d
	ld hl,0610ah		;ef6e
	jr c,$+68		;ef71
	add a,b			;ef73
	nop			;ef74
	jp nz,03848h		;ef75
	ld e,c			;ef78
	adc a,b			;ef79
	djnz $+36		;ef7a
	ret pe			;ef7c
	nop			;ef7d
	add a,b			;ef7e
	add a,d			;ef7f
	ret c			;ef80
	jr nc,$+36		;ef81
	ret nz			;ef83
	nop			;ef84
	add a,b			;ef85
	and d			;ef86
	ret z			;ef87
	jr nz,$-126		;ef88
	ld (bc),a			;ef8a
	or d			;ef8b
	nop			;ef8c
	ld (000a8h),hl		;ef8d
	add a,b			;ef90
	ld (bc),a			;ef91
	dec (hl)			;ef92
	nop			;ef93
	and d			;ef94
	nop			;ef95
	jr $-126		;ef96
	add a,d			;ef98
	ex af,af'			;ef99
	ld h,c			;ef9a
	add a,d			;ef9b
	inc (hl)			;ef9c
	ld b,b			;ef9d
	ld (bc),a			;ef9e
	ld h,l			;ef9f
	nop			;efa0
	add a,d			;efa1
	ld h,b			;efa2
	jr z,$-124		;efa3
	adc a,b			;efa5
	jr $-92		;efa6
	ld c,b			;efa8
	ld b,(hl)			;efa9
	add a,b			;efaa
	and d			;efab
	halt			;efac
	jr z,$-126		;efad
	add a,d			;efaf
	ld e,b			;efb0
	ld b,h			;efb1
	add a,d			;efb2
	ld c,e			;efb3
	ld c,(hl)			;efb4
	and d			;efb5
	ld h,b			;efb6
	ld h,b			;efb7
	add a,h			;efb8
	dec c			;efb9
	adc a,l			;efba
	ld (de),a			;efbb
	inc c			;efbc
	rra			;efbd
	nop			;efbe
	ld bc,00307h		;efbf
	nop			;efc2
	nop			;efc3
	dec (hl)			;efc4
	ld e,b			;efc5
	ld hl,02180h		;efc6
	ex af,af'			;efc9
	ld hl,00196h		;efca
	nop			;efcd
	rla			;efce
	ld hl,02166h		;efcf
	jr nc,$-93		;efd2
	ld h,(hl)			;efd4
	add a,c			;efd5
	nop			;efd6
	inc e			;efd7
	ld hl,0a140h		;efd8
	ld d,l			;efdb
	and c			;efdc
	add hl,bc			;efdd
	ld hl,02180h		;efde
	ld c,021h		;efe1
	ld h,(hl)			;efe3
	ld hl,0a120h		;efe4
	ld h,(hl)			;efe7
	and c			;efe8
	ld c,001h		;efe9
	inc sp			;efeb
	nop			;efec
	ld hl,06108h		;efed
	rst 20h			;eff0
	ld b,c			;eff1
	add hl,de			;eff2
	nop			;eff3
	ld bc,02500h		;eff4
	ld h,c			;eff7
	ld (hl),a			;eff8
	ld h,c			;eff9
	jr nc,$-29		;effa
	ld (hl),a			;effc
	add a,c			;effd
	nop			;effe
	dec e			;efff
	ld b,c			;f000
	ld de,00100h		;f001
	nop			;f004
	add hl,hl			;f005
	ld h,c			;f006
	ld d,l			;f007
	ld h,c			;f008
	jr nz,$-29		;f009
	ld d,l			;f00b
	add a,c			;f00c
	nop			;f00d
	inc de			;f00e
	add hl,de			;f00f
	ld a,(bc)			;f010
	dec d			;f011
	ld hl,0210ch		;f012
	ld h,(hl)			;f015
	nop			;f016
	ld l,l			;f017
	and a			;f018
	and c			;f019
	ld h,(hl)			;f01a
	add a,c			;f01b
	nop			;f01c
	ld d,099h		;f01d
	dec c			;f01f
	inc de			;f020
	ld hl,0a1f0h		;f021
	add a,021h		;f024
	inc c			;f026
	ld hl,02155h		;f027
	jr nc,$-93		;f02a
	ld d,l			;f02c
	and c			;f02d
	ld c,021h		;f02e
	jr nc,$+3		;f030
	nop			;f032
	jr nz,$+35		;f033
	ld h,(hl)			;f035
	ld hl,0a140h		;f036
	ld h,(hl)			;f039
	add a,c			;f03a
	nop			;f03b
	add hl,de			;f03c
	and c			;f03d
	ld (00081h),hl		;f03e
	djnz $-93		;f041
	add a,l			;f043
	and c			;f044
	dec c			;f045
	ld b,c			;f046
	add a,a			;f047
	nop			;f048
	nop			;f049
	ld d,a			;f04a
	ld a,l			;f04b
	ld b,c			;f04c
	inc de			;f04d
	nop			;f04e
	nop			;f04f
	ld d,b			;f050
	sub e			;f051
	ld bc,00010h		;f052
	nop			;f055
	ld e,d			;f056
	and c			;f057
	ld bc,0001bh		;f058
	exx			;f05b
	ld b,01ah		;f05c
	ld h,c			;f05e
	jr nz,$+3		;f05f
	dec d			;f061
	nop			;f062
	exx			;f063
	ld c,026h		;f064
	ld hl,04120h		;f066
	ld (de),a			;f069
	nop			;f06a
	add hl,de			;f06b
	scf			;f06c
	dec e			;f06d
	ld h,c			;f06e
	jr nz,$+3		;f06f
	ld de,01900h		;f071
	ld bc,06112h		;f074
	jr nz,$+3		;f077
	inc d			;f079
	nop			;f07a
	exx			;f07b
	dec a			;f07c
	jr nz,$-125		;f07d
	nop			;f07f
	dec e			;f080
	add hl,de			;f081
	jr $+2		;f082
	ld hl,02108h		;f084
	ld (hl),b			;f087
	and c			;f088
	ex af,af'			;f089
	ld e,c			;f08a
	jr $+2		;f08b
	ld hl,0190fh		;f08d
	add hl,de			;f090
	ld hl,055a1h		;f091
	and c			;f094
	rrca			;f095
	ld h,c			;f096
	ld h,b			;f097
	ld h,c			;f098
	ld b,d			;f099
	ld e,c			;f09a
	ld d,l			;f09b
	nop			;f09c
	add a,c			;f09d
	nop			;f09e
	rla			;f09f
	ld h,c			;f0a0
	jr nc,$-93		;f0a1
	rlca			;f0a3
	add hl,de			;f0a4
	add hl,bc			;f0a5
	jr nc,$-93		;f0a6
	ld h,(hl)			;f0a8
	add a,c			;f0a9
	nop			;f0aa
	dec h			;f0ab
	and c			;f0ac
	ld d,l			;f0ad
	ld e,c			;f0ae
	dec b			;f0af
	inc sp			;f0b0
	ld hl,0a130h		;f0b1
	ld d,l			;f0b4
	add a,c			;f0b5
	nop			;f0b6
	rla			;f0b7
	ld hl,0a140h		;f0b8
	sbc a,c			;f0bb
	ld e,c			;f0bc
	dec bc			;f0bd
	add hl,sp			;f0be
	ld hl,02144h		;f0bf
	jr nc,$-93		;f0c2
	ld b,h			;f0c4
	add a,c			;f0c5
	nop			;f0c6
	ld (05021h),hl		;f0c7
	ld bc,02900h		;f0ca
	ld h,c			;f0cd
	ld h,(hl)			;f0ce
	sbc a,c			;f0cf
	djnz $+27		;f0d0
	and c			;f0d2
	ld (hl),a			;f0d3
	add a,c			;f0d4
	nop			;f0d5
	inc (hl)			;f0d6
	ld e,c			;f0d7
	dec c			;f0d8
	ld (de),a			;f0d9
	ld hl,02155h		;f0da
	jr nc,$-93		;f0dd
	ld d,l			;f0df
	add hl,de			;f0e0
	ld l,021h		;f0e1
	ld hl,0a140h		;f0e3
	ld b,h			;f0e6
	add a,c			;f0e7
	nop			;f0e8
	inc d			;f0e9
	ld hl,02180h		;f0ea
	ld a,(bc)			;f0ed
	ld e,c			;f0ee
	ld a,(bc)			;f0ef
	ld e,0a1h		;f0f0
	ld h,(hl)			;f0f2
	add a,c			;f0f3
	nop			;f0f4
	ld (0bf00h),hl		;f0f5
	and a			;f0f8
	inc bc			;f0f9
	ex af,af'			;f0fa
	nop			;f0fb
	nop			;f0fc
	adc a,e			;f0fd
	inc bc			;f0fe
	rlca			;f0ff
	sbc a,c			;f100
	ld l,b			;f101
	dec c			;f102
	ld bc,0008ah		;f103
	ld b,c			;f106
	jr $+10		;f107
	ld b,c			;f109
	jr $+2		;f10a
	and d			;f10c
	nop			;f10d
	djnz $-122		;f10e
	add a,d			;f110
	djnz $+3		;f111
	nop			;f113
	ld sp,hl			;f114
	and a			;f115
	ld h,c			;f116
	jr nz,$+2		;f117
	rst 28h			;f119
	and a			;f11a
	ld h,c			;f11b
	jr nc,$+2		;f11c
	jp (hl)			;f11e
	and a			;f11f
	ld h,c			;f120
	jr nc,$+2		;f121
	pop hl			;f123
	and a			;f124
	ld h,c			;f125
	jr nz,$+2		;f126
	sub 0a7h		;f128
	ld h,c			;f12a
	sub b			;f12b
	nop			;f12c
	add a,0a7h		;f12d
	ld h,c			;f12f
	jr nz,$+123		;f130
	ld d,b			;f132
	ld h,c			;f133
	ld (hl),b			;f134
	ld e,c			;f135
	ld c,e			;f136
	nop			;f137
	ld h,c			;f138
	or b			;f139
	nop			;f13a
	inc hl			;f13b
	sbc a,a			;f13c
	inc bc			;f13d
	inc b			;f13e
	add hl,de			;f13f
	ld c,c			;f140
	nop			;f141
	add a,c			;f142
	nop			;f143
	dec (hl)			;f144
	ld b,d			;f145
	ex af,af'			;f146
	ex af,af'			;f147
	ld (01001h),hl		;f148
	add a,b			;f14b
	ld (02802h),hl		;f14c
	add a,b			;f14f
	ld (03a00h),hl		;f150
	add a,b			;f153
	jp nz,00810h		;f154
	ld h,d			;f157
	jr $+2		;f158
	add a,b			;f15a
	ld h,d			;f15b
	dec e			;f15c
	jr $-126		;f15d
	jp po,0102ch		;f15f
	add a,b			;f162
	add a,d			;f163
	rrca			;f164
	ex af,af'			;f165
	ld (00012h),hl		;f166
	add a,b			;f169
	ld (01f10h),hl		;f16a
	add a,b			;f16d
	and d			;f16e
	add hl,de			;f16f
	djnz $-126		;f170
	add hl,de			;f172
	add hl,sp			;f173
	dec b			;f174
	ld hl,06231h		;f175
	ld bc,08003h		;f178
	ld h,d			;f17b
	inc bc			;f17c
	djnz $-126		;f17d
	ld h,d			;f17f
	inc b			;f180
	ld de,08280h		;f181
	nop			;f184
	dec b			;f185
	ld (00011h),hl		;f186
	add a,b			;f189
	ld (bc),a			;f18a
	ld c,023h		;f18b
	jp nz,0180bh		;f18d
	ld (bc),a			;f190
	ld c,b			;f191
	nop			;f192
	ld e,c			;f193
	and e			;f194
	ld (01225h),a		;f195
	inc c			;f198
	rra			;f199
	nop			;f19a
	ld bc,0122dh		;f19b
	ld bc,0000ah		;f19e
	ld bc,00312h		;f1a1
	add hl,bc			;f1a4
	nop			;f1a5
	ld bc,04999h		;f1a6
	inc e			;f1a9
	ld (de),a			;f1aa
	nop			;f1ab
	add hl,bc			;f1ac
	nop			;f1ad
	dec b			;f1ae
	exx			;f1af
	ld b,d			;f1b0
	ex af,af'			;f1b1
	ld (de),a			;f1b2
	nop			;f1b3
	rlca			;f1b4
	ld bc,0b906h		;f1b5
	ex af,af'			;f1b8
	ld (de),a			;f1b9
	nop			;f1ba
	rlca			;f1bb
	ld bc,09907h		;f1bc
	ld (hl),009h		;f1bf
	ld (de),a			;f1c1
	nop			;f1c2
	inc bc			;f1c3
	dec b			;f1c4
	ex af,af'			;f1c5
	exx			;f1c6
	ld d,007h		;f1c7
	ld (de),a			;f1c9
	nop			;f1ca
	inc bc			;f1cb
	dec b			;f1cc
	add hl,bc			;f1cd
	cp c			;f1ce
	ret c			;f1cf
	ld (de),a			;f1d0
	nop			;f1d1
	ld bc,00a06h		;f1d2
	add hl,de			;f1d5
	ld a,048h		;f1d6
	ld (de),a			;f1d8
	ld bc,00e11h		;f1d9
	ld bc,08499h		;f1dc
	ld de,00812h		;f1df
	rlca			;f1e2
	jr $+5		;f1e3
	ld e,c			;f1e5
	ld d,b			;f1e6
	nop			;f1e7
	ld (de),a			;f1e8
	nop			;f1e9
	ld b,00fh		;f1ea
	inc bc			;f1ec
	ld sp,hl			;f1ed
	ld (hl),a			;f1ee
	ld (de),a			;f1ef
	nop			;f1f0
	dec b			;f1f1
	rrca			;f1f2
	inc b			;f1f3
	exx			;f1f4
	ld hl,01208h		;f1f5
	nop			;f1f8
	inc b			;f1f9
	djnz $+7		;f1fa
	cp c			;f1fc
	add hl,bc			;f1fd
	ld (de),a			;f1fe
	nop			;f1ff
	ld (bc),a			;f200
	djnz $+8		;f201
	ld (de),a			;f203
	ld bc,01002h		;f204
	ld b,059h		;f207
	rrca			;f209
	inc de			;f20a
	ld (de),a			;f20b
	ld bc,00e00h		;f20c
	ld (bc),a			;f20f
	ld e,c			;f210
	ld a,(de)			;f211
	ld a,(bc)			;f212
	ld (de),a			;f213
	ld bc,00b00h		;f214
	ld bc,05218h		;f217
	sub a			;f21a
	jr $-68		;f21b
	sub a			;f21d
	cp c			;f21e
	add hl,sp			;f21f
	ld (de),a			;f220
	dec b			;f221
	nop			;f222
	rla			;f223
	inc b			;f224
	sbc a,c			;f225
	nop			;f226
	dec a			;f227
	dec h			;f228
	ld (de),a			;f229
	nop			;f22a
	rlca			;f22b
	rla			;f22c
	dec bc			;f22d
	ld e,c			;f22e
	cp b			;f22f
	ld d,b			;f230
	ld a,02dh		;f231
	ld hl,01200h		;f233
	ld (bc),a			;f236
	add hl,bc			;f237
	nop			;f238
	ld bc,02d06h		;f239
	jr $-72		;f23c
	sub (hl)			;f23e
	dec h			;f23f
	rlca			;f240
	and c			;f241
	dec h			;f242
	and c			;f243
	scf			;f244
	and c			;f245
	ld d,e			;f246
	and c			;f247
	ld a,(bc)			;f248
	ld hl,0a171h		;f249
	ld h,d			;f24c
	ld hl,0a150h		;f24d
	add a,081h		;f250
	rlca			;f252
	djnz $-93		;f253
	halt			;f255
	and c			;f256
	out (0a1h),a		;f257
	dec a			;f259
	and c			;f25a
	sub l			;f25b
	ld e,c			;f25c
	inc c			;f25d
	ld (de),a			;f25e
	pop hl			;f25f
	ld (hl),0e1h		;f260
	sub a			;f262
	ld h,c			;f263
	sub d			;f264
	ld sp,hl			;f265
	jr $+99		;f266
	jr z,$+99		;f268
	cp b			;f26a
	ld hl,079edh		;f26b
	ld l,a			;f26e
	pop hl			;f26f
	cp l			;f270
	pop hl			;f271
	add a,061h		;f272
	add a,e			;f274
	pop hl			;f275
	sub d			;f276
	add hl,sp			;f277
	inc bc			;f278
	ld hl,02152h		;f279
	ld h,a			;f27c
	ld hl,06125h		;f27d
	add hl,sp			;f280
	ld a,c			;f281
	ld c,e			;f282
	pop hl			;f283
	dec (hl)			;f284
	ld h,c			;f285
	jr nc,$-69		;f286
	ld c,0a1h		;f288
	ld b,d			;f28a
	and c			;f28b
	add hl,de			;f28c
	ld a,c			;f28d
	add hl,de			;f28e
	ld hl,09982h		;f28f
	rlca			;f292
	ld (de),a			;f293
	add a,c			;f294
	djnz $+14		;f295
	cp c			;f297
	or (hl)			;f298
	ld h,c			;f299
	ld b,b			;f29a
	cp c			;f29b
	jp nz,015a1h		;f29c
	ld b,d			;f29f
	jr nz,$+3		;f2a0
	ld b,d			;f2a2
	inc bc			;f2a3
	ld (bc),a			;f2a4
	ld (00208h),hl		;f2a5
	add a,b			;f2a8
	ld h,d			;f2a9
	ex af,af'			;f2aa
	add hl,bc			;f2ab
	add a,c			;f2ac
	ld h,d			;f2ad
	jr $+26		;f2ae
	add a,b			;f2b0
	ld h,d			;f2b1
	jr z,$+34		;f2b2
	add a,c			;f2b4
	ld h,d			;f2b5
	jr nc,$+50		;f2b6
	add a,c			;f2b8
	ld b,d			;f2b9
	jr nc,$+42		;f2ba
	ld b,c			;f2bc
	inc (hl)			;f2bd
	jr nz,$+100		;f2be
	ld bc,08000h		;f2c0
	ld (02000h),hl		;f2c3
	add a,b			;f2c6
	rlca			;f2c7
	and c			;f2c8
	inc hl			;f2c9
	ld hl,03933h		;f2ca
	jr nz,$-29		;f2cd
	ld hl,(0a2a1h)		;f2cf
	ld h,c			;f2d2
	inc e			;f2d3
	add hl,sp			;f2d4
	and b			;f2d5
	and c			;f2d6
	ld c,h			;f2d7
	ld hl,0394ch		;f2d8
	jr nz,$-29		;f2db
	ccf			;f2dd
	ld hl,02178h		;f2de
	rla			;f2e1
	add hl,sp			;f2e2
	jr nc,$-29		;f2e3
	inc d			;f2e5
	ld hl,03944h		;f2e6
	jr nc,$-29		;f2e9
	ld b,h			;f2eb
	pop hl			;f2ec
	dec sp			;f2ed
	pop hl			;f2ee
	ld d,(hl)			;f2ef
	and c			;f2f0
	ld a,(de)			;f2f1
	ld hl,001b1h		;f2f2
	ld b,011h		;f2f5
	ld h,c			;f2f7
	ld e,l			;f2f8
	add hl,sp			;f2f9
	jr nz,$-93		;f2fa
	ld c,c			;f2fc
	ld hl,03919h		;f2fd
	jr nz,$-29		;f300
	ld e,021h		;f302
	halt			;f304
	cp c			;f305
	inc bc			;f306
	pop hl			;f307
	add a,a			;f308
	pop bc			;f309
	ld (bc),a			;f30a
	ld de,0a3a1h		;f30b
	sbc a,c			;f30e
	nop			;f30f
	ld b,d			;f310
	ld b,c			;f311
	dec bc			;f312
	rla			;f313
	ld hl,06104h		;f314
	inc (hl)			;f317
	ld h,c			;f318
	ex de,hl			;f319
	ld h,c			;f31a
	inc hl			;f31b
	ld hl,06104h		;f31c
	ld b,h			;f31f
	ld h,c			;f320
	call c,00441h		;f321
	djnz $+67		;f324
	ld de,0610ch		;f326
	ld b,(hl)			;f329
	ld hl,00705h		;f32a
	inc bc			;f32d
	nop			;f32e
	nop			;f32f
	rst 38h			;f330
	adc a,e			;f331
	ld b,e			;f332
	rlca			;f333
	nop			;f334
	jr c,$-87		;f335
	nop			;f337
	ld c,b			;f338
	and a			;f339
	nop			;f33a
	ld b,b			;f33b
	and a			;f33c
	ld b,e			;f33d
	ex af,af'			;f33e
	ld h,c			;f33f
	ld (hl),c			;f340
	ld sp,hl			;f341
	pop af			;f342
	pop hl			;f343
	and c			;f344
	ld a,c			;f345
	add a,c			;f346
	pop hl			;f347
	ld sp,04179h		;f348
	pop hl			;f34b
	ld b,c			;f34c
	ld a,c			;f34d
	pop de			;f34e
	pop hl			;f34f
	ld hl,00000h		;f350
	sbc a,e			;f353
	ld hl,00010h		;f354
	dec h			;f357
	ld (hl),a			;f358
	ld bc,000d0h		;f359
	nop			;f35c
	adc a,l			;f35d
	sub a			;f35e
	inc bc			;f35f
	inc b			;f360
	nop			;f361
	ld d,l			;f362
	ld e,a			;f363
	ld hl,0a1b2h		;f364
	ld h,e			;f367
	nop			;f368
	ld l,066h		;f369
	ld bc,00210h		;f36b
	add a,c			;f36e
	djnz $+5		;f36f
	nop			;f371
	ld d,040h		;f372
	ld bc,01004h		;f374
	and c			;f377
	ld c,b			;f378
	ld hl,0614ch		;f379
	ld hl,(069a1h)		;f37c
	and c			;f37f
	dec de			;f380
	ld hl,0e173h		;f381
	ld b,a			;f384
	ld hl,0e1a3h		;f385
	add hl,sp			;f388
	nop			;f389
	ld d,c			;f38a
	ld d,b			;f38b
	ld bc,00128h		;f38c
	add a,c			;f38f
	ld a,(de)			;f390
	ld b,000h		;f391
	sub e			;f393
	ld h,e			;f394
	ld bc,00218h		;f395
	add a,c			;f398
	djnz $+6		;f399
	nop			;f39b
	sub e			;f39c
	ld b,b			;f39d
	ld h,c			;f39e
	add hl,hl			;f39f
	and c			;f3a0
	ld h,e			;f3a1
	ld hl,02155h		;f3a2
	rlca			;f3a5
	and c			;f3a6
	ld d,l			;f3a7
	ld hl,0a166h		;f3a8
	rlca			;f3ab
	and c			;f3ac
	ld d,c			;f3ad
	ld hl,0a13ah		;f3ae
	ld hl,(037e1h)		;f3b1
	and c			;f3b4
	inc b			;f3b5
	ld b,d			;f3b6
	add hl,bc			;f3b7
	ld bc,08842h		;f3b8
	ld (bc),a			;f3bb
	ld h,d			;f3bc
	jr c,$+10		;f3bd
	add a,h			;f3bf
	ld (00808h),hl		;f3c0
	add a,h			;f3c3
	ld h,d			;f3c4
	and b			;f3c5
	ex af,af'			;f3c6
	add a,h			;f3c7
	ld b,d			;f3c8
	and b			;f3c9
	jr nz,$+27		;f3ca
	ld d,b			;f3cc
	ld h,l			;f3cd
	dec h			;f3ce
	adc a,l			;f3cf
	ld (de),a			;f3d0
	inc c			;f3d1
	rra			;f3d2
	nop			;f3d3
	ld bc,0122dh		;f3d4
	dec b			;f3d7
	rra			;f3d8
	nop			;f3d9
	ld bc,090d9h		;f3da
	ex af,af'			;f3dd
	ld a,012h		;f3de
	inc bc			;f3e0
	ld a,(bc)			;f3e1
	dec c			;f3e2
	ld (bc),a			;f3e3
	rlca			;f3e4
	inc bc			;f3e5
	dec c			;f3e6
	rlca			;f3e7
	inc bc			;f3e8
	rra			;f3e9
	nop			;f3ea
	ld h,b			;f3eb
	ld b,b			;f3ec
	inc bc			;f3ed
	inc h			;f3ee
	exx			;f3ef
	ld l,e			;f3f0
	ld bc,0123dh		;f3f1
	inc c			;f3f4
	rra			;f3f5
	nop			;f3f6
	ld bc,09919h		;f3f7
	ld d,b			;f3fa
	adc a,l			;f3fb
	ld (de),a			;f3fc
	rlca			;f3fd
	rlca			;f3fe
	inc c			;f3ff
	inc bc			;f400
	rlca			;f401
	inc bc			;f402
	ld hl,0123dh		;f403
	inc c			;f406
	rra			;f407
	nop			;f408
	ld bc,09cd9h		;f409
	ld c,l			;f40c
	adc a,l			;f40d
	ld (de),a			;f40e
	rlca			;f40f
	rlca			;f410
	inc c			;f411
	inc bc			;f412
	ld (de),a			;f413
	rlca			;f414
	rlca			;f415
	inc c			;f416
	inc bc			;f417
	rlca			;f418
	inc bc			;f419
	ld (080e2h),hl		;f41a
	inc b			;f41d
	add a,b			;f41e
	jp nz,02828h		;f41f
	jp po,01838h		;f422
	add a,c			;f425
	jp po,06028h		;f426
	add a,b			;f429
	jp po,02808h		;f42a
	adc a,(hl)			;f42d
	jp po,010c0h		;f42e
	adc a,e			;f431
	jp po,01850h		;f432
	adc a,e			;f435
	dec a			;f436
	ld (de),a			;f437
	inc c			;f438
	rra			;f439
	nop			;f43a
	ld bc,061d9h		;f43b
	ld c,h			;f43e
	adc a,l			;f43f
	ld (de),a			;f440
	rlca			;f441
	rlca			;f442
	inc c			;f443
	inc bc			;f444
	rlca			;f445
	inc bc			;f446
	nop			;f447
	nop			;f448
	ld h,c			;f449
	ld b,b			;f44a
	inc bc			;f44b
	inc h			;f44c
	inc bc			;f44d
	inc de			;f44e
	rlca			;f44f
	inc bc			;f450
	dec h			;f451
	rlca			;f452
	inc bc			;f453
	nop			;f454
	nop			;f455
	or b			;f456
	ld b,b			;f457
	inc bc			;f458
	inc hl			;f459
	inc bc			;f45a
	dec c			;f45b
	ld (03850h),hl		;f45c
	adc a,(hl)			;f45f
	rlca			;f460
	inc bc			;f461
	inc c			;f462
	rlca			;f463
	inc bc			;f464
	dec c			;f465
	rlca			;f466
	inc bc			;f467
	nop			;f468
	nop			;f469
	nop			;f46a
	and a			;f46b
	inc bc			;f46c
	ld e,000h		;f46d
	rst 38h			;f46f
	and a			;f470
	ld b,e			;f471
	jr nz,$+2		;f472
	or b			;f474
	ld b,b			;f475
	inc bc			;f476
	inc hl			;f477
	ld e,c			;f478
	call m,00018h		;f479
	inc bc			;f47c
	and a			;f47d
	ld bc,000fah		;f47e
	jp po,00478h		;f481
	add a,b			;f484
	jp po,01010h		;f485
	adc a,e			;f488
	jp po,01870h		;f489
	adc a,(hl)			;f48c
	jp po,010f7h		;f48d
	adc a,(hl)			;f490
	jp nz,010ddh		;f491
	jp po,010b8h		;f494
	adc a,e			;f497
	jp po,010c0h		;f498
	add a,c			;f49b
	jp po,058d8h		;f49c
	add a,b			;f49f
	dec a			;f4a0
	ld (de),a			;f4a1
	inc c			;f4a2
	rra			;f4a3
	nop			;f4a4
	ld bc,098d9h		;f4a5
	ld (de),a			;f4a8
	adc a,l			;f4a9
	ld (de),a			;f4aa
	rlca			;f4ab
	rlca			;f4ac
	inc c			;f4ad
	inc bc			;f4ae
	and d			;f4af
	ld e,b			;f4b0
	ld c,b			;f4b1
	add a,b			;f4b2
	add a,d			;f4b3
	ld d,b			;f4b4
	ld d,b			;f4b5
	ld hl,00700h		;f4b6
	inc bc			;f4b9
	nop			;f4ba
	nop			;f4bb
	rst 38h			;f4bc
	and a			;f4bd
	ld b,e			;f4be
	ld e,000h		;f4bf
	or b			;f4c1
	ld b,b			;f4c2
	inc bc			;f4c3
	inc hl			;f4c4
	nop			;f4c5
	nop			;f4c6
	and a			;f4c7
	inc bc			;f4c8
	jr nz,$+36		;f4c9
	nop			;f4cb
	ld b,b			;f4cc
	adc a,e			;f4cd
	ld (02050h),hl		;f4ce
	adc a,(hl)			;f4d1
	ld (bc),a			;f4d2
	sub b			;f4d3
	ld bc,0a802h		;f4d4
	ex af,af'			;f4d7
	ld (bc),a			;f4d8
	sbc a,b			;f4d9
	dec bc			;f4da
	ld (bc),a			;f4db
	xor b			;f4dc
	dec de			;f4dd
	ld (00c8ch),hl		;f4de
	add a,b			;f4e1
	ld (02088h),hl		;f4e2
	adc a,e			;f4e5
	ld (03098h),hl		;f4e6
	add a,c			;f4e9
	ld (bc),a			;f4ea
	xor b			;f4eb
	jr c,$+36		;f4ec
	ret nz			;f4ee
	ld d,b			;f4ef
	adc a,(hl)			;f4f0
	ld e,c			;f4f1
	jr nc,$+105		;f4f2
	ld bc,000ffh		;f4f4
	jp po,00868h		;f4f7
	add a,b			;f4fa
	dec a			;f4fb
	ld (de),a			;f4fc
	inc c			;f4fd
	rra			;f4fe
	nop			;f4ff
	ld bc,09dd9h		;f500
	ld c,h			;f503
	adc a,l			;f504
	ld (de),a			;f505
	rlca			;f506
	rlca			;f507
	inc c			;f508
	inc bc			;f509
	rlca			;f50a
	inc bc			;f50b
	inc c			;f50c
	rlca			;f50d
	inc bc			;f50e
	ld (de),a			;f50f
	rlca			;f510
	inc bc			;f511
	inc de			;f512
	rlca			;f513
	inc bc			;f514
	inc d			;f515
	rlca			;f516
	inc bc			;f517
	dec d			;f518
	rlca			;f519
	inc bc			;f51a
	dec h			;f51b
	rlca			;f51c
	inc bc			;f51d
	dec h			;f51e
	rlca			;f51f
	inc bc			;f520
	dec h			;f521
	rlca			;f522
	inc bc			;f523
	dec h			;f524
	rlca			;f525
	add a,c			;f526
	ld h,b			;f527
	rrca			;f528
	exx			;f529
	jr nz,$+82		;f52a
	ld bc,05500h		;f52c
	sbc a,c			;f52f
	jr nz,$+7		;f530
	add a,c			;f532
	nop			;f533
	ld b,b			;f534
	pop bc			;f535
	ld e,010h		;f536
	add hl,de			;f538
	ld e,010h		;f539
	ld bc,0001fh		;f53b
	exx			;f53e
	ld a,010h		;f53f
	ld b,c			;f541
	ld de,00100h		;f542
	nop			;f545
	ld d,a			;f546
	exx			;f547
	jr $+97		;f548
	ld bc,06300h		;f54a
	sbc a,c			;f54d
	jr $+77		;f54e
	ld b,c			;f550
	jr $+2		;f551
	sbc a,c			;f553
	add hl,hl			;f554
	djnz $-61		;f555
	djnz $+10		;f557
	add hl,de			;f559
	cpl			;f55a
	ld e,b			;f55b
	ld bc,00020h		;f55c
	ld (de),a			;f55f
	ld bc,01000h		;f560
	ld (bc),a			;f563
	exx			;f564
	ld a,050h		;f565
	ld h,c			;f567
	jr nz,$+9		;f568
	inc bc			;f56a
	nop			;f56b
	nop			;f56c
	nop			;f56d
	and a			;f56e
	inc bc			;f56f
	ld e,000h		;f570
	rst 38h			;f572
	and a			;f573
	ld b,e			;f574
	ld e,062h		;f575
	jr c,$+26		;f577
	adc a,(hl)			;f579
	ld e,c			;f57a
	cp a			;f57b
	ld e,a			;f57c
	ld bc,000fdh		;f57d
	jp po,00378h		;f580
	add a,b			;f583
	jp po,018c0h		;f584
	add a,c			;f587
	jp nz,010d3h		;f588
	jp po,058d8h		;f58b
	add a,b			;f58e
	jp po,020a8h		;f58f
	adc a,e			;f592
	jp po,01850h		;f593
	adc a,e			;f596
	ld b,c			;f597
	jr $+2		;f598
	jp nz,01808h		;f59a
	jp po,01818h		;f59d
	add a,c			;f5a0
	and d			;f5a1
	nop			;f5a2
	ld e,b			;f5a3
	add a,b			;f5a4
	and d			;f5a5
	ex af,af'			;f5a6
	jr nz,$-112		;f5a7
	ld bc,00010h		;f5a9
	jp po,008f0h		;f5ac
	adc a,(hl)			;f5af
	rlca			;f5b0
	add a,c			;f5b1
	ld h,b			;f5b2
	rrca			;f5b3
	add a,c			;f5b4
	nop			;f5b5
	ld b,b			;f5b6
	ld bc,0001fh		;f5b7
	ld e,c			;f5ba
	rra			;f5bb
	ld b,b			;f5bc
	ld bc,0001fh		;f5bd
	exx			;f5c0
	rra			;f5c1
	ld b,b			;f5c2
	pop bc			;f5c3
	jr nc,$+26		;f5c4
	rlca			;f5c6
	inc bc			;f5c7
	nop			;f5c8
	nop			;f5c9
	nop			;f5ca
	and a			;f5cb
	inc bc			;f5cc
	ld e,000h		;f5cd
	rst 38h			;f5cf
	and a			;f5d0
	ld b,e			;f5d1
	jr nz,$+100		;f5d2
	ld d,b			;f5d4
	jr z,$-112		;f5d5
	nop			;f5d7
	ld h,b			;f5d8
	ld b,b			;f5d9
	inc bc			;f5da
	inc h			;f5db
	ld e,c			;f5dc
	ld l,a			;f5dd
	ld h,c			;f5de
	ld bc,000ffh		;f5df
	jp po,00450h		;f5e2
	add a,b			;f5e5
	jp po,02020h		;f5e6
	adc a,e			;f5e9
	jp po,010f8h		;f5ea
	adc a,(hl)			;f5ed
	jp po,018a8h		;f5ee
	adc a,e			;f5f1
	jp nz,010d8h		;f5f2
	jp po,010c8h		;f5f5
	add a,c			;f5f8
	jp po,058e0h		;f5f9
	add a,b			;f5fc
	rlca			;f5fd
	inc bc			;f5fe
	nop			;f5ff
	nop			;f600
	rst 38h			;f601
	and a			;f602
	ld b,e			;f603
	ld e,000h		;f604
	nop			;f606
	and a			;f607
	inc bc			;f608
	jr nz,$+36		;f609
	ld b,b			;f60b
	jr nz,$-112		;f60c
	nop			;f60e
	ld h,b			;f60f
	ld b,b			;f610
	inc bc			;f611
	inc h			;f612
	ld e,c			;f613
	ld l,a			;f614
	ld h,c			;f615
	ld bc,000ffh		;f616
	rlca			;f619
	ld hl,00107h		;f61a
	djnz $+2		;f61d
	ld bc,01000h		;f61f
	ld bc,00010h		;f622
	ld bc,01000h		;f625
	ld bc,00010h		;f628
	ld bc,01000h		;f62b
	ld bc,00010h		;f62e
	ld bc,01000h		;f631
	ld hl,0d9f0h		;f634
	ld c,a			;f637
	ld b,b			;f638
	ld bc,00910h		;f639
	add hl,sp			;f63c
	rlca			;f63d
	ld bc,00810h		;f63e
	add hl,sp			;f641
	ex af,af'			;f642
	ld bc,00810h		;f643
	add hl,sp			;f646
	ex af,af'			;f647
	ld bc,00810h		;f648
	add hl,sp			;f64b
	ex af,af'			;f64c
	ld hl,082f8h		;f64d
	nop			;f650
	jr $-28		;f651
	ld bc,08005h		;f653
	jp po,01414h		;f656
	add a,b			;f659
	jp po,02628h		;f65a
	add a,b			;f65d
	jp po,03434h		;f65e
	add a,b			;f661
	jp po,04648h		;f662
	add a,b			;f665
	rlca			;f666
	ld hl,001ffh		;f667
	jr z,$+2		;f66a
	and c			;f66c
	rst 38h			;f66d
	ld e,c			;f66e
	dec a			;f66f
	nop			;f670
	ld hl,00166h		;f671
	jr z,$+2		;f674
	and c			;f676
	ld h,(hl)			;f677
	ld a,c			;f678
	ld h,(hl)			;f679
	ld hl,05909h		;f67a
	jr z,$+2		;f67d
	and c			;f67f
	add hl,bc			;f680
	add a,d			;f681
	djnz $+4		;f682
	ld h,d			;f684
	dec b			;f685
	nop			;f686
	add a,b			;f687
	ld (00310h),hl		;f688
	add a,b			;f68b
	ld (0002bh),hl		;f68c
	add a,b			;f68f
	rlca			;f690
	inc bc			;f691
	nop			;f692
	nop			;f693
	nop			;f694
	and a			;f695
	inc bc			;f696
	jr nz,$+2		;f697
	rst 38h			;f699
	and a			;f69a
	ld b,e			;f69b
	jr nz,$+2		;f69c
	or b			;f69e
	ld b,b			;f69f
	inc bc			;f6a0
	inc hl			;f6a1
	add hl,de			;f6a2
	nop			;f6a3
	jr $+67		;f6a4
	rst 38h			;f6a6
	nop			;f6a7
	and d			;f6a8
	jr c,$+8		;f6a9
	add a,b			;f6ab
	and d			;f6ac
	nop			;f6ad
	djnz $-115		;f6ae
	and d			;f6b0
	ld l,b			;f6b1
	jr nz,$-112		;f6b2
	and d			;f6b4
	or b			;f6b5
	djnz $-115		;f6b6
	nop			;f6b8
	add hl,bc			;f6b9
	and a			;f6ba
	add a,d			;f6bb
	cp b			;f6bc
	ld h,h			;f6bd
	and d			;f6be
	or l			;f6bf
	ld e,e			;f6c0
	add a,b			;f6c1
	dec a			;f6c2
	ld b,079h		;f6c3
	add a,b			;f6c5
	ld (de),a			;f6c6
	inc c			;f6c7
	rra			;f6c8
	nop			;f6c9
	ld bc,09999h		;f6ca
	ld c,e			;f6cd
	adc a,l			;f6ce
	ld (de),a			;f6cf
	rlca			;f6d0
	rlca			;f6d1
	inc c			;f6d2
	inc bc			;f6d3
	rlca			;f6d4
	cp b			;f6d5
	ex de,hl			;f6d6
	cp a			;f6d7
	ex de,hl			;f6d8
	xor b			;f6d9
	call pe,0ed5fh		;f6da
	and d			;f6dd
	defb 0edh;next byte illegal after ed		;f6de
	inc de			;f6df
	xor 0c1h		;f6e0
	rst 28h			;f6e2
	ld b,c			;f6e3
	jp p,0f2c8h		;f6e4
	dec l			;f6e7
	di			;f6e8
	push hl			;f6e9
	di			;f6ea
	ret pe			;f6eb
	di			;f6ec
	ld (bc),a			;f6ed
	call p,0f419h		;f6ee
	ld b,(hl)			;f6f1
	call p,0f450h		;f6f2
	ld d,e			;f6f5
	call p,0f461h		;f6f6
	ld h,h			;f6f9
	call p,0f467h		;f6fa
	cp c			;f6fd
	call p,0f50bh		;f6fe
	ld c,0f5h		;f701
	ld de,014f5h		;f703
	push af			;f706
	rla			;f707
	push af			;f708
	ld a,(de)			;f709
	push af			;f70a
	dec e			;f70b
	push af			;f70c
	jr nz,$-9		;f70d
	inc hl			;f70f
	push af			;f710
	ld h,0f5h		;f711
	ld l,d			;f713
	push af			;f714
	or c			;f715
	push af			;f716
	rst 0			;f717
	push af			;f718
	cp 0f5h		;f719
	ld a,(de)			;f71b
	or 067h		;f71c
	or 091h		;f71e
	or 0d5h		;f720
	or 0ffh		;f722
	rst 38h			;f724
	rlca			;f725
	nop			;f726
	nop			;f727
	inc c			;f728
	ld hl,(0010fh)		;f729
	nop			;f72c
	dec c			;f72d
	ld hl,(00180h)		;f72e
	nop			;f731
	dec c			;f732
	ld hl,(0010fh)		;f733
	nop			;f736
	dec c			;f737
	ld hl,(0010fh)		;f738
	nop			;f73b
	dec c			;f73c
	ld hl,(00180h)		;f73d
	nop			;f740
	dec c			;f741
	ld hl,(00180h)		;f742
	nop			;f745
	dec c			;f746
	ld hl,(00007h)		;f747
	nop			;f74a
	inc c			;f74b
	ld hl,(00007h)		;f74c
	nop			;f74f
	inc c			;f750
	ld hl,(00180h)		;f751
	nop			;f754
	dec c			;f755
	ld hl,(00180h)		;f756
	nop			;f759
	dec c			;f75a
	ld hl,(00180h)		;f75b
	nop			;f75e
	dec c			;f75f
	ld hl,(00180h)		;f760
	nop			;f763
	dec c			;f764
	ld hl,(00180h)		;f765
	nop			;f768
	dec c			;f769
	ld hl,(00180h)		;f76a
	nop			;f76d
	dec c			;f76e
	ld hl,(00180h)		;f76f
	nop			;f772
	dec c			;f773
	ld hl,(00180h)		;f774
	nop			;f777
	dec c			;f778
	ld hl,(00180h)		;f779
	nop			;f77c
	dec c			;f77d
	ld hl,(00180h)		;f77e
	nop			;f781
	dec c			;f782
	ld hl,(00180h)		;f783
	nop			;f786
	dec c			;f787
	ld hl,(00180h)		;f788
	nop			;f78b
	dec c			;f78c
	ld hl,(00180h)		;f78d
	nop			;f790
	dec c			;f791
	ld hl,(00180h)		;f792
	nop			;f795
	dec c			;f796
	ld hl,(00180h)		;f797
	nop			;f79a
	dec c			;f79b
	ld hl,(00180h)		;f79c
	nop			;f79f
	dec c			;f7a0
	ld hl,(00180h)		;f7a1
	nop			;f7a4
	dec c			;f7a5
	ld hl,(00180h)		;f7a6
	nop			;f7a9
	dec c			;f7aa
	ld hl,(00180h)		;f7ab
	nop			;f7ae
	dec c			;f7af
	ld hl,(00180h)		;f7b0
	nop			;f7b3
	dec c			;f7b4
	ld hl,(00180h)		;f7b5
	nop			;f7b8
	dec c			;f7b9
	ld hl,(00007h)		;f7ba
	nop			;f7bd
	inc c			;f7be
	ld hl,(0000fh)		;f7bf
	nop			;f7c2
	inc c			;f7c3
	ld hl,(00007h)		;f7c4
	nop			;f7c7
	inc c			;f7c8
	ld hl,(00007h)		;f7c9
	nop			;f7cc
	inc c			;f7cd
	ld hl,(00007h)		;f7ce
	nop			;f7d1
	inc c			;f7d2
	ld hl,(00007h)		;f7d3
	nop			;f7d6
	inc c			;f7d7
	ld hl,(00007h)		;f7d8
	nop			;f7db
	inc c			;f7dc
	ld hl,(00007h)		;f7dd
	nop			;f7e0
	inc c			;f7e1
	ld hl,(000ffh)		;f7e2
	nop			;f7e5
	nop			;f7e6
	nop			;f7e7
	nop			;f7e8
	nop			;f7e9
	nop			;f7ea
	nop			;f7eb
	nop			;f7ec
	nop			;f7ed
	nop			;f7ee
	nop			;f7ef
	nop			;f7f0
	nop			;f7f1
	nop			;f7f2
	nop			;f7f3
	nop			;f7f4
	nop			;f7f5
	nop			;f7f6
	nop			;f7f7
	nop			;f7f8
	nop			;f7f9
	nop			;f7fa
	nop			;f7fb
	nop			;f7fc
	nop			;f7fd
	nop			;f7fe
	nop			;f7ff
	nop			;f800
	nop			;f801
	nop			;f802
	nop			;f803
	nop			;f804
	nop			;f805
	nop			;f806
	nop			;f807
	nop			;f808
	nop			;f809
	nop			;f80a
	nop			;f80b
	nop			;f80c
	nop			;f80d
	nop			;f80e
	nop			;f80f
	nop			;f810
	nop			;f811
	nop			;f812
	nop			;f813
	nop			;f814
	nop			;f815
	nop			;f816
	nop			;f817
	nop			;f818
	nop			;f819
	nop			;f81a
	nop			;f81b
	nop			;f81c
	nop			;f81d
	nop			;f81e
	nop			;f81f
	nop			;f820
	nop			;f821
	nop			;f822
	nop			;f823
	nop			;f824
	nop			;f825
	nop			;f826
	nop			;f827
	nop			;f828
	nop			;f829
	nop			;f82a
	nop			;f82b
	nop			;f82c
	nop			;f82d
	nop			;f82e
	nop			;f82f
	nop			;f830
	nop			;f831
	nop			;f832
	nop			;f833
	nop			;f834
	nop			;f835
	nop			;f836
	nop			;f837
	nop			;f838
	nop			;f839
	nop			;f83a
	nop			;f83b
	nop			;f83c
	nop			;f83d
	nop			;f83e
	nop			;f83f
	nop			;f840
	nop			;f841
	nop			;f842
	nop			;f843
	nop			;f844
	nop			;f845
	nop			;f846
	nop			;f847
	nop			;f848
	nop			;f849
	nop			;f84a
	nop			;f84b
	nop			;f84c
	nop			;f84d
	nop			;f84e
	nop			;f84f
	nop			;f850
	nop			;f851
	nop			;f852
	nop			;f853
	nop			;f854
	nop			;f855
	nop			;f856
	nop			;f857
	nop			;f858
	nop			;f859
	nop			;f85a
	nop			;f85b
	nop			;f85c
	nop			;f85d
	nop			;f85e
	nop			;f85f
	nop			;f860
	nop			;f861
	nop			;f862
	nop			;f863
	nop			;f864
	jr nz,$+82		;f865
	jr nc,$+2		;f867
	ld (hl),b			;f869
	nop			;f86a
	nop			;f86b
	jr nz,$+2		;f86c
	jr nz,$+34		;f86e
	jr nz,$+34		;f870
	jr nz,$+2		;f872
	jr nz,$+2		;f874
	jr nz,$+66		;f876
	adc a,b			;f878
	adc a,b			;f879
	ld (hl),b			;f87a
	nop			;f87b
	nop			;f87c
	nop			;f87d
	jr z,$+82		;f87e
	and b			;f880
	ld d,b			;f881
	jr z,$+2		;f882
	nop			;f884
	nop			;f885
	and b			;f886
	ld d,b			;f887
	jr z,$+82		;f888
	and b			;f88a
	nop			;f88b
	jr nz,$+66		;f88c
	nop			;f88e
	ld l,b			;f88f
	sbc a,b			;f890
	sbc a,b			;f891
	ld l,b			;f892
	nop			;f893
	djnz $+34		;f894
	ld (hl),b			;f896
	adc a,b			;f897
	ret m			;f898
	add a,b			;f899
	ld a,b			;f89a
	nop			;f89b
	djnz $+34		;f89c
	nop			;f89e
	ld h,b			;f89f
	jr nz,$+34		;f8a0
	ld (hl),b			;f8a2
	nop			;f8a3
	djnz $+34		;f8a4
	nop			;f8a6
	ld (hl),b			;f8a7
	adc a,b			;f8a8
	adc a,b			;f8a9
	ld (hl),b			;f8aa
	nop			;f8ab
	djnz $+34		;f8ac
	nop			;f8ae
	adc a,b			;f8af
	adc a,b			;f8b0
	adc a,b			;f8b1
	ld (hl),b			;f8b2
	nop			;f8b3
	jr z,$+82		;f8b4
	nop			;f8b6
	or b			;f8b7
	ret z			;f8b8
	adc a,b			;f8b9
	adc a,b			;f8ba
	nop			;f8bb
	jr z,$+82		;f8bc
	adc a,b			;f8be
	ret z			;f8bf
	xor b			;f8c0
	sbc a,b			;f8c1
	adc a,b			;f8c2
	nop			;f8c3
	nop			;f8c4
	ld (hl),b			;f8c5
	adc a,b			;f8c6
	add a,b			;f8c7
	adc a,b			;f8c8
	ld (hl),b			;f8c9
	jr nz,$+66		;f8ca
	ld (hl),b			;f8cc
	adc a,b			;f8cd
	add a,b			;f8ce
	add a,b			;f8cf
	adc a,b			;f8d0
	ld (hl),b			;f8d1
	jr nz,$+66		;f8d2
	nop			;f8d4
	ld d,b			;f8d5
	nop			;f8d6
	adc a,b			;f8d7
	adc a,b			;f8d8
	adc a,b			;f8d9
	ld (hl),b			;f8da
	nop			;f8db
	ld d,b			;f8dc
	nop			;f8dd
	adc a,b			;f8de
	adc a,b			;f8df
	adc a,b			;f8e0
	adc a,b			;f8e1
	ld (hl),b			;f8e2
	nop			;f8e3
	nop			;f8e4
	nop			;f8e5
	nop			;f8e6
	nop			;f8e7
	nop			;f8e8
	nop			;f8e9
	nop			;f8ea
	nop			;f8eb
	jr nz,$+34		;f8ec
	jr nz,$+34		;f8ee
	jr nz,$+2		;f8f0
	jr nz,$+2		;f8f2
	ld d,b			;f8f4
	ld d,b			;f8f5
	nop			;f8f6
	nop			;f8f7
	nop			;f8f8
	nop			;f8f9
	nop			;f8fa
	nop			;f8fb
	ld d,b			;f8fc
	ret m			;f8fd
	ld d,b			;f8fe
	ld d,b			;f8ff
	ld d,b			;f900
	ret m			;f901
	ld d,b			;f902
	nop			;f903
	jr nz,$-6		;f904
	and b			;f906
	ret m			;f907
	jr z,$-6		;f908
	jr nz,$+2		;f90a
	ret z			;f90c
	ret z			;f90d
	djnz $+34		;f90e
	ld b,b			;f910
	sbc a,b			;f911
	sbc a,b			;f912
	nop			;f913
	jr nz,$+82		;f914
	jr nz,$+98		;f916
	sbc a,b			;f918
	sub b			;f919
	ld l,b			;f91a
	nop			;f91b
	jr nz,$+66		;f91c
	nop			;f91e
	nop			;f91f
	nop			;f920
	nop			;f921
	nop			;f922
	nop			;f923
	ex af,af'			;f924
	djnz $+18		;f925
	djnz $+18		;f927
	djnz $+10		;f929
	nop			;f92b
	ld b,b			;f92c
	jr nz,$+34		;f92d
	jr nz,$+34		;f92f
	jr nz,$+66		;f931
	nop			;f933
	xor b			;f934
	xor b			;f935
	ld (hl),b			;f936
	ret m			;f937
	ld (hl),b			;f938
	xor b			;f939
	xor b			;f93a
	nop			;f93b
	nop			;f93c
	jr nz,$+34		;f93d
	ret m			;f93f
	jr nz,$+34		;f940
	nop			;f942
	nop			;f943
	nop			;f944
	nop			;f945
	nop			;f946
	nop			;f947
	nop			;f948
	djnz $+18		;f949
	jr nz,$+2		;f94b
	nop			;f94d
	nop			;f94e
	ld a,b			;f94f
	nop			;f950
	nop			;f951
	nop			;f952
	nop			;f953
	nop			;f954
	nop			;f955
	nop			;f956
	nop			;f957
	nop			;f958
	jr nc,$+50		;f959
	nop			;f95b
	ex af,af'			;f95c
	ex af,af'			;f95d
	djnz $+34		;f95e
	ld b,b			;f960
	add a,b			;f961
	add a,b			;f962
	nop			;f963
	ld (hl),b			;f964
	sbc a,b			;f965
	sbc a,b			;f966
	xor b			;f967
	ret z			;f968
	ret z			;f969
	ld (hl),b			;f96a
	nop			;f96b
	jr nz,$+98		;f96c
	jr nz,$+34		;f96e
	jr nz,$+34		;f970
	ld (hl),b			;f972
	nop			;f973
	ld (hl),b			;f974
	adc a,b			;f975
	ex af,af'			;f976
	ld (hl),b			;f977
	add a,b			;f978
	add a,b			;f979
	ret m			;f97a
	nop			;f97b
	ld (hl),b			;f97c
	adc a,b			;f97d
	ex af,af'			;f97e
	jr nc,$+10		;f97f
	adc a,b			;f981
	ld (hl),b			;f982
	nop			;f983
	djnz $+50		;f984
	ld d,b			;f986
	sub b			;f987
	ret m			;f988
	djnz $+18		;f989
	nop			;f98b
	ret m			;f98c
	add a,b			;f98d
	add a,b			;f98e
	ret p			;f98f
	ex af,af'			;f990
	adc a,b			;f991
	ld (hl),b			;f992
	nop			;f993
	ld (hl),b			;f994
	adc a,b			;f995
	add a,b			;f996
	ret p			;f997
	adc a,b			;f998
	adc a,b			;f999
	ld (hl),b			;f99a
	nop			;f99b
	ret m			;f99c
	ex af,af'			;f99d
	ex af,af'			;f99e
	djnz $+18		;f99f
	jr nz,$+34		;f9a1
	nop			;f9a3
	ld (hl),b			;f9a4
	adc a,b			;f9a5
	adc a,b			;f9a6
	ld (hl),b			;f9a7
	adc a,b			;f9a8
	adc a,b			;f9a9
	ld (hl),b			;f9aa
	nop			;f9ab
	ld (hl),b			;f9ac
	adc a,b			;f9ad
	adc a,b			;f9ae
	ld a,b			;f9af
	ex af,af'			;f9b0
	adc a,b			;f9b1
	ld (hl),b			;f9b2
	nop			;f9b3
	nop			;f9b4
	nop			;f9b5
	jr nz,$+2		;f9b6
	nop			;f9b8
	jr nz,$+2		;f9b9
	nop			;f9bb
	nop			;f9bc
	nop			;f9bd
	jr nz,$+2		;f9be
	nop			;f9c0
	jr nz,$+34		;f9c1
	ld b,b			;f9c3
	nop			;f9c4
	ex af,af'			;f9c5
	djnz $+34		;f9c6
	jr nz,$+18		;f9c8
	ex af,af'			;f9ca
	nop			;f9cb
	nop			;f9cc
	nop			;f9cd
	nop			;f9ce
	ld a,b			;f9cf
	nop			;f9d0
	ld a,b			;f9d1
	nop			;f9d2
	nop			;f9d3
	nop			;f9d4
	ld b,b			;f9d5
	jr nz,$+18		;f9d6
	djnz $+34		;f9d8
	ld b,b			;f9da
	nop			;f9db
	ld (hl),b			;f9dc
	adc a,b			;f9dd
	adc a,b			;f9de
	djnz $+34		;f9df
	nop			;f9e1
	jr nz,$+2		;f9e2
	nop			;f9e4
	ld (hl),b			;f9e5
	adc a,b			;f9e6
	xor b			;f9e7
	cp b			;f9e8
	add a,b			;f9e9
	ld (hl),b			;f9ea
	nop			;f9eb
	ld (hl),b			;f9ec
	adc a,b			;f9ed
	adc a,b			;f9ee
	ret m			;f9ef
	adc a,b			;f9f0
	adc a,b			;f9f1
	adc a,b			;f9f2
	nop			;f9f3
	ret p			;f9f4
	adc a,b			;f9f5
	adc a,b			;f9f6
	ret p			;f9f7
	adc a,b			;f9f8
	adc a,b			;f9f9
	ret p			;f9fa
	nop			;f9fb
	ld (hl),b			;f9fc
	adc a,b			;f9fd
	add a,b			;f9fe
	add a,b			;f9ff
	add a,b			;fa00
	adc a,b			;fa01
	ld (hl),b			;fa02
	nop			;fa03
	ret p			;fa04
	adc a,b			;fa05
	adc a,b			;fa06
	adc a,b			;fa07
	adc a,b			;fa08
	adc a,b			;fa09
	ret p			;fa0a
	nop			;fa0b
	ret m			;fa0c
	add a,b			;fa0d
	add a,b			;fa0e
	ret p			;fa0f
	add a,b			;fa10
	add a,b			;fa11
	ret m			;fa12
	nop			;fa13
	ret m			;fa14
	add a,b			;fa15
	add a,b			;fa16
	ret p			;fa17
	add a,b			;fa18
	add a,b			;fa19
	add a,b			;fa1a
	nop			;fa1b
	ld (hl),b			;fa1c
	adc a,b			;fa1d
	add a,b			;fa1e
	add a,b			;fa1f
	sbc a,b			;fa20
	adc a,b			;fa21
	ld (hl),b			;fa22
	nop			;fa23
	adc a,b			;fa24
	adc a,b			;fa25
	adc a,b			;fa26
	ret m			;fa27
	adc a,b			;fa28
	adc a,b			;fa29
	adc a,b			;fa2a
	nop			;fa2b
	ld (hl),b			;fa2c
	jr nz,$+34		;fa2d
	jr nz,$+34		;fa2f
	jr nz,$+114		;fa31
	nop			;fa33
	ex af,af'			;fa34
	ex af,af'			;fa35
	ex af,af'			;fa36
	ex af,af'			;fa37
	ex af,af'			;fa38
	adc a,b			;fa39
	ld (hl),b			;fa3a
	nop			;fa3b
	adc a,b			;fa3c
	sub b			;fa3d
	and b			;fa3e
	ret nz			;fa3f
	and b			;fa40
	sub b			;fa41
	adc a,b			;fa42
	nop			;fa43
	add a,b			;fa44
	add a,b			;fa45
	add a,b			;fa46
	add a,b			;fa47
	add a,b			;fa48
	add a,b			;fa49
	ret m			;fa4a
	nop			;fa4b
	adc a,b			;fa4c
	ret c			;fa4d
	xor b			;fa4e
	adc a,b			;fa4f
	adc a,b			;fa50
	adc a,b			;fa51
	adc a,b			;fa52
	nop			;fa53
	adc a,b			;fa54
	adc a,b			;fa55
	ret z			;fa56
	xor b			;fa57
	sbc a,b			;fa58
	adc a,b			;fa59
	adc a,b			;fa5a
	nop			;fa5b
	ld (hl),b			;fa5c
	adc a,b			;fa5d
	adc a,b			;fa5e
	adc a,b			;fa5f
	adc a,b			;fa60
	adc a,b			;fa61
	ld (hl),b			;fa62
	nop			;fa63
	ret p			;fa64
	adc a,b			;fa65
	adc a,b			;fa66
	ret p			;fa67
	add a,b			;fa68
	add a,b			;fa69
	add a,b			;fa6a
	nop			;fa6b
	ld (hl),b			;fa6c
	adc a,b			;fa6d
	adc a,b			;fa6e
	adc a,b			;fa6f
	xor b			;fa70
	sbc a,b			;fa71
	ld a,b			;fa72
	nop			;fa73
	ret p			;fa74
	adc a,b			;fa75
	adc a,b			;fa76
	ret p			;fa77
	sub b			;fa78
	adc a,b			;fa79
	adc a,b			;fa7a
	nop			;fa7b
	ld (hl),b			;fa7c
	adc a,b			;fa7d
	add a,b			;fa7e
	ld (hl),b			;fa7f
	ex af,af'			;fa80
	adc a,b			;fa81
	ld (hl),b			;fa82
	nop			;fa83
	ret m			;fa84
	jr nz,$+34		;fa85
	jr nz,$+34		;fa87
	jr nz,$+34		;fa89
	nop			;fa8b
	adc a,b			;fa8c
	adc a,b			;fa8d
	adc a,b			;fa8e
	adc a,b			;fa8f
	adc a,b			;fa90
	adc a,b			;fa91
	ld (hl),b			;fa92
	nop			;fa93
	adc a,b			;fa94
	adc a,b			;fa95
	adc a,b			;fa96
	adc a,b			;fa97
	adc a,b			;fa98
	ld d,b			;fa99
	jr nz,$+2		;fa9a
	adc a,b			;fa9c
	adc a,b			;fa9d
	adc a,b			;fa9e
	adc a,b			;fa9f
	xor b			;faa0
	xor b			;faa1
	ld d,b			;faa2
	nop			;faa3
	adc a,b			;faa4
	adc a,b			;faa5
	ld d,b			;faa6
	jr nz,$+82		;faa7
	adc a,b			;faa9
	adc a,b			;faaa
	nop			;faab
	adc a,b			;faac
	adc a,b			;faad
	ld d,b			;faae
	jr nz,$+34		;faaf
	jr nz,$+34		;fab1
	nop			;fab3
	ret m			;fab4
	ex af,af'			;fab5
	djnz $+34		;fab6
	ld b,b			;fab8
	add a,b			;fab9
	ret m			;faba
	nop			;fabb
	jr c,$+34		;fabc
	jr nz,$+34		;fabe
	jr nz,$+34		;fac0
	jr c,$+2		;fac2
	add a,b			;fac4
	add a,b			;fac5
	ld b,b			;fac6
	jr nz,$+18		;fac7
	ex af,af'			;fac9
	ex af,af'			;faca
	nop			;facb
	ld (hl),b			;facc
	djnz $+18		;facd
	djnz $+18		;facf
	djnz $+114		;fad1
	nop			;fad3
	jr nz,$+114		;fad4
	xor b			;fad6
	jr nz,$+34		;fad7
	jr nz,$+34		;fad9
	nop			;fadb
	nop			;fadc
	nop			;fadd
	nop			;fade
	nop			;fadf
	nop			;fae0
	nop			;fae1
	nop			;fae2
	call m,04830h		;fae3
	ld b,b			;fae6
	ret p			;fae7
	ld b,b			;fae8
	ld b,b			;fae9
	ret m			;faea
	nop			;faeb
	nop			;faec
	nop			;faed
	ld l,b			;faee
	sbc a,b			;faef
	adc a,b			;faf0
	sbc a,b			;faf1
	ld l,b			;faf2
	nop			;faf3
	add a,b			;faf4
	add a,b			;faf5
	or b			;faf6
	ret z			;faf7
	adc a,b			;faf8
	ret z			;faf9
	or b			;fafa
	nop			;fafb
	nop			;fafc
	nop			;fafd
	ld (hl),b			;fafe
	adc a,b			;faff
	add a,b			;fb00
	adc a,b			;fb01
	ld (hl),b			;fb02
	nop			;fb03
	ex af,af'			;fb04
	ex af,af'			;fb05
	ld l,b			;fb06
	sbc a,b			;fb07
	adc a,b			;fb08
	sbc a,b			;fb09
	ld l,b			;fb0a
	nop			;fb0b
	nop			;fb0c
	nop			;fb0d
	ld (hl),b			;fb0e
	adc a,b			;fb0f
	ret p			;fb10
	add a,b			;fb11
	ld a,b			;fb12
	nop			;fb13
	jr nc,$+74		;fb14
	ld b,b			;fb16
	ld h,b			;fb17
	ld b,b			;fb18
	ld b,b			;fb19
	ld b,b			;fb1a
	nop			;fb1b
	nop			;fb1c
	nop			;fb1d
	ld (hl),b			;fb1e
	adc a,b			;fb1f
	adc a,b			;fb20
	ld a,b			;fb21
	ex af,af'			;fb22
	ld (hl),b			;fb23
	add a,b			;fb24
	add a,b			;fb25
	or b			;fb26
	ret z			;fb27
	adc a,b			;fb28
	adc a,b			;fb29
	adc a,b			;fb2a
	nop			;fb2b
	jr nz,$+2		;fb2c
	ld h,b			;fb2e
	jr nz,$+34		;fb2f
	jr nz,$+114		;fb31
	nop			;fb33
	djnz $+2		;fb34
	djnz $+18		;fb36
	djnz $-110		;fb38
	ld h,b			;fb3a
	nop			;fb3b
	add a,b			;fb3c
	add a,b			;fb3d
	add a,b			;fb3e
	and b			;fb3f
	ret nz			;fb40
	and b			;fb41
	sub b			;fb42
	nop			;fb43
	ld b,b			;fb44
	ld b,b			;fb45
	ld b,b			;fb46
	ld b,b			;fb47
	ld b,b			;fb48
	ld b,b			;fb49
	jr nc,$+2		;fb4a
	nop			;fb4c
	nop			;fb4d
	ret nc			;fb4e
	xor b			;fb4f
	xor b			;fb50
	xor b			;fb51
	xor b			;fb52
	nop			;fb53
	nop			;fb54
	nop			;fb55
	or b			;fb56
	ret z			;fb57
	adc a,b			;fb58
	adc a,b			;fb59
	adc a,b			;fb5a
	nop			;fb5b
	nop			;fb5c
	nop			;fb5d
	ld (hl),b			;fb5e
	adc a,b			;fb5f
	adc a,b			;fb60
	adc a,b			;fb61
	ld (hl),b			;fb62
	nop			;fb63
	nop			;fb64
	nop			;fb65
	or b			;fb66
	ret z			;fb67
	adc a,b			;fb68
	ret p			;fb69
	add a,b			;fb6a
	add a,b			;fb6b
	nop			;fb6c
	nop			;fb6d
	ld l,b			;fb6e
	sbc a,b			;fb6f
	adc a,b			;fb70
	ld a,b			;fb71
	ex af,af'			;fb72
	inc c			;fb73
	nop			;fb74
	nop			;fb75
	or b			;fb76
	ld b,b			;fb77
	ld b,b			;fb78
	ld b,b			;fb79
	ld b,b			;fb7a
	nop			;fb7b
	nop			;fb7c
	nop			;fb7d
	ld (hl),b			;fb7e
	add a,b			;fb7f
	ld (hl),b			;fb80
	ex af,af'			;fb81
	ret p			;fb82
	nop			;fb83
	nop			;fb84
	ld b,b			;fb85
	ret po			;fb86
	ld b,b			;fb87
	ld b,b			;fb88
	ld b,b			;fb89
	jr nc,$+2		;fb8a
	nop			;fb8c
	nop			;fb8d
	adc a,b			;fb8e
	adc a,b			;fb8f
	adc a,b			;fb90
	adc a,b			;fb91
	ld (hl),b			;fb92
	nop			;fb93
	nop			;fb94
	nop			;fb95
	adc a,b			;fb96
	adc a,b			;fb97
	ld d,b			;fb98
	ld d,b			;fb99
	jr nz,$+2		;fb9a
	nop			;fb9c
	nop			;fb9d
	adc a,b			;fb9e
	xor b			;fb9f
	xor b			;fba0
	xor b			;fba1
	ld d,b			;fba2
	nop			;fba3
	nop			;fba4
	nop			;fba5
	adc a,b			;fba6
	ld d,b			;fba7
	jr nz,$+82		;fba8
	adc a,b			;fbaa
	nop			;fbab
	nop			;fbac
	nop			;fbad
	adc a,b			;fbae
	adc a,b			;fbaf
	sbc a,b			;fbb0
	ld l,b			;fbb1
	ex af,af'			;fbb2
	ld (hl),b			;fbb3
	nop			;fbb4
	nop			;fbb5
	ret m			;fbb6
	djnz $+34		;fbb7
	ld b,b			;fbb9
	ret m			;fbba
	nop			;fbbb
	jr $+34		;fbbc
	jr nz,$+66		;fbbe
	jr nz,$+34		;fbc0
	jr $+2		;fbc2
	djnz $+18		;fbc4
	djnz $+18		;fbc6
	djnz $+18		;fbc8
	djnz $+2		;fbca
	ld h,b			;fbcc
	djnz $+18		;fbcd
	ex af,af'			;fbcf
	djnz $+18		;fbd0
	ld h,b			;fbd2
	nop			;fbd3
	nop			;fbd4
	jr z,$+82		;fbd5
	nop			;fbd7
	nop			;fbd8
	nop			;fbd9
	nop			;fbda
	nop			;fbdb
	nop			;fbdc
	nop			;fbdd
	nop			;fbde
	nop			;fbdf
	nop			;fbe0
	nop			;fbe1
	nop			;fbe2
	nop			;fbe3
	xor d			;fbe4
	ld d,l			;fbe5
	xor d			;fbe6
	ld d,l			;fbe7
	xor d			;fbe8
	ld d,l			;fbe9
	xor d			;fbea
	ld d,l			;fbeb
	call z,0cc33h		;fbec
	inc sp			;fbef
	call z,0cc33h		;fbf0
	inc sp			;fbf3
	xor d			;fbf4
	xor d			;fbf5
	ld d,l			;fbf6
	ld d,l			;fbf7
	xor d			;fbf8
	xor d			;fbf9
	ld d,l			;fbfa
	ld d,l			;fbfb
	adc a,b			;fbfc
	nop			;fbfd
	ld (bc),a			;fbfe
	nop			;fbff
	adc a,b			;fc00
	nop			;fc01
	jr nz,$+2		;fc02
	nop			;fc04
	ld (bc),a			;fc05
	jr nz,$-122		;fc06
	jr nz,$-118		;fc08
	ld b,b			;fc0a
	jr nz,$+18		;fc0b
	djnz $+18		;fc0d
	djnz $+18		;fc0f
	djnz $+18		;fc11
	djnz $+2		;fc13
	nop			;fc15
	nop			;fc16
	rst 38h			;fc17
	nop			;fc18
	nop			;fc19
	nop			;fc1a
	nop			;fc1b
	ld b,h			;fc1c
	ld b,h			;fc1d
	ld b,h			;fc1e
	ld b,h			;fc1f
	ld b,h			;fc20
	ld b,h			;fc21
	ld b,h			;fc22
	ld b,h			;fc23
	nop			;fc24
	rst 38h			;fc25
	nop			;fc26
	nop			;fc27
	nop			;fc28
	rst 38h			;fc29
	nop			;fc2a
	nop			;fc2b
	add a,b			;fc2c
	ld b,b			;fc2d
	jr nz,$+18		;fc2e
	ex af,af'			;fc30
	inc b			;fc31
	ld (bc),a			;fc32
	ld bc,00201h		;fc33
	inc b			;fc36
	ex af,af'			;fc37
	djnz $+34		;fc38
	ld b,b			;fc3a
	add a,b			;fc3b
	ld (08811h),hl		;fc3c
	ld b,h			;fc3f
	ld (08811h),hl		;fc40
	ld b,h			;fc43
	ld b,h			;fc44
	adc a,b			;fc45
	ld de,04422h		;fc46
	adc a,b			;fc49
	ld de,0c322h		;fc4a
	inc a			;fc4d
	jp 0c33ch		;fc4e
	inc a			;fc51
	jp 0043ch		;fc52
	inc b			;fc55
	rst 38h			;fc56
	ld b,b			;fc57
	ld b,b			;fc58
	ld b,b			;fc59
	rst 38h			;fc5a
	inc b			;fc5b
	ld d,l			;fc5c
	xor d			;fc5d
	ld d,l			;fc5e
	xor d			;fc5f
	ld d,l			;fc60
	xor d			;fc61
	ld d,l			;fc62
	xor d			;fc63
	nop			;fc64
	nop			;fc65
	nop			;fc66
	nop			;fc67
	nop			;fc68
	nop			;fc69
	nop			;fc6a
	nop			;fc6b
	nop			;fc6c
	nop			;fc6d
	nop			;fc6e
	nop			;fc6f
	nop			;fc70
	nop			;fc71
	nop			;fc72
	nop			;fc73
	nop			;fc74
	nop			;fc75
	nop			;fc76
	nop			;fc77
	nop			;fc78
	nop			;fc79
	nop			;fc7a
	nop			;fc7b
	nop			;fc7c
	nop			;fc7d
	nop			;fc7e
	nop			;fc7f
	nop			;fc80
	nop			;fc81
	nop			;fc82
	nop			;fc83
	nop			;fc84
	nop			;fc85
	nop			;fc86
	nop			;fc87
	nop			;fc88
	nop			;fc89
	nop			;fc8a
	nop			;fc8b
	nop			;fc8c
	nop			;fc8d
	nop			;fc8e
	nop			;fc8f
	nop			;fc90
	nop			;fc91
	nop			;fc92
	nop			;fc93
	nop			;fc94
	nop			;fc95
	nop			;fc96
	nop			;fc97
	nop			;fc98
	nop			;fc99
	nop			;fc9a
	nop			;fc9b
	nop			;fc9c
	nop			;fc9d
	nop			;fc9e
	nop			;fc9f
	nop			;fca0
	nop			;fca1
	nop			;fca2
	nop			;fca3
	nop			;fca4
	nop			;fca5
	nop			;fca6
	nop			;fca7
	nop			;fca8
	nop			;fca9
	nop			;fcaa
	nop			;fcab
	nop			;fcac
	nop			;fcad
	nop			;fcae
	nop			;fcaf
	nop			;fcb0
	nop			;fcb1
	nop			;fcb2
	nop			;fcb3
	nop			;fcb4
	nop			;fcb5
	nop			;fcb6
	nop			;fcb7
	nop			;fcb8
	nop			;fcb9
	nop			;fcba
	nop			;fcbb
	nop			;fcbc
	nop			;fcbd
	nop			;fcbe
	nop			;fcbf
	nop			;fcc0
	nop			;fcc1
	nop			;fcc2
	nop			;fcc3
	nop			;fcc4
	nop			;fcc5
	nop			;fcc6
	nop			;fcc7
	nop			;fcc8
	nop			;fcc9
	nop			;fcca
	nop			;fccb
	nop			;fccc
	nop			;fccd
	nop			;fcce
	nop			;fccf
	nop			;fcd0
	nop			;fcd1
	nop			;fcd2
	nop			;fcd3
	nop			;fcd4
	nop			;fcd5
	nop			;fcd6
	nop			;fcd7
	nop			;fcd8
	nop			;fcd9
	nop			;fcda
	nop			;fcdb
	nop			;fcdc
	nop			;fcdd
	nop			;fcde
	nop			;fcdf
	nop			;fce0
	nop			;fce1
	nop			;fce2
	nop			;fce3
	nop			;fce4
	nop			;fce5
	nop			;fce6
	nop			;fce7
	nop			;fce8
	nop			;fce9
	nop			;fcea
	nop			;fceb
	nop			;fcec
	nop			;fced
	nop			;fcee
	nop			;fcef
	nop			;fcf0
	nop			;fcf1
	nop			;fcf2
	nop			;fcf3
	nop			;fcf4
	nop			;fcf5
	nop			;fcf6
	nop			;fcf7
	nop			;fcf8
	nop			;fcf9
	nop			;fcfa
	nop			;fcfb
	nop			;fcfc
	nop			;fcfd
	nop			;fcfe
	nop			;fcff
	nop			;fd00
	nop			;fd01
	nop			;fd02
	nop			;fd03
	nop			;fd04
	nop			;fd05
	nop			;fd06
	nop			;fd07
	nop			;fd08
	nop			;fd09
	nop			;fd0a
	nop			;fd0b
	nop			;fd0c
	nop			;fd0d
	nop			;fd0e
	nop			;fd0f
	nop			;fd10
	nop			;fd11
	nop			;fd12
	nop			;fd13
	nop			;fd14
	nop			;fd15
	nop			;fd16
	nop			;fd17
	nop			;fd18
	nop			;fd19
	nop			;fd1a
	nop			;fd1b
	nop			;fd1c
	nop			;fd1d
	nop			;fd1e
	nop			;fd1f
	nop			;fd20
	nop			;fd21
	nop			;fd22
	nop			;fd23
	nop			;fd24
	nop			;fd25
	nop			;fd26
	nop			;fd27
	nop			;fd28
	nop			;fd29
	nop			;fd2a
	nop			;fd2b
	nop			;fd2c
	nop			;fd2d
	nop			;fd2e
	nop			;fd2f
	nop			;fd30
	nop			;fd31
	nop			;fd32
	nop			;fd33
	nop			;fd34
	nop			;fd35
	nop			;fd36
	nop			;fd37
	nop			;fd38
	nop			;fd39
	nop			;fd3a
	nop			;fd3b
	nop			;fd3c
	nop			;fd3d
	nop			;fd3e
	nop			;fd3f
	nop			;fd40
	nop			;fd41
	nop			;fd42
	nop			;fd43
	nop			;fd44
	nop			;fd45
	nop			;fd46
	nop			;fd47
	nop			;fd48
	nop			;fd49
	nop			;fd4a
	nop			;fd4b
	nop			;fd4c
	nop			;fd4d
	nop			;fd4e
	nop			;fd4f
	nop			;fd50
	nop			;fd51
	nop			;fd52
	nop			;fd53
	nop			;fd54
	nop			;fd55
	nop			;fd56
	nop			;fd57
	nop			;fd58
	nop			;fd59
	nop			;fd5a
	nop			;fd5b
	nop			;fd5c
	nop			;fd5d
	nop			;fd5e
	nop			;fd5f
	nop			;fd60
	nop			;fd61
	nop			;fd62
	nop			;fd63
	nop			;fd64
	nop			;fd65
	nop			;fd66
	nop			;fd67
	nop			;fd68
	nop			;fd69
	nop			;fd6a
	nop			;fd6b
	nop			;fd6c
	nop			;fd6d
	nop			;fd6e
	nop			;fd6f
	nop			;fd70
	nop			;fd71
	nop			;fd72
	nop			;fd73
	nop			;fd74
	nop			;fd75
	nop			;fd76
	nop			;fd77
	nop			;fd78
	nop			;fd79
	nop			;fd7a
	nop			;fd7b
	nop			;fd7c
	nop			;fd7d
	nop			;fd7e
	nop			;fd7f
	nop			;fd80
	nop			;fd81
	nop			;fd82
	nop			;fd83
	nop			;fd84
	nop			;fd85
	nop			;fd86
	nop			;fd87
	nop			;fd88
	nop			;fd89
	nop			;fd8a
	nop			;fd8b
	nop			;fd8c
	nop			;fd8d
	nop			;fd8e
	nop			;fd8f
	nop			;fd90
	nop			;fd91
	nop			;fd92
	nop			;fd93
	nop			;fd94
	nop			;fd95
	nop			;fd96
	nop			;fd97
	nop			;fd98
	nop			;fd99
	nop			;fd9a
	nop			;fd9b
	nop			;fd9c
	nop			;fd9d
	nop			;fd9e
	nop			;fd9f
	nop			;fda0
	nop			;fda1
	nop			;fda2
	nop			;fda3
	nop			;fda4
	nop			;fda5
	nop			;fda6
	nop			;fda7
	nop			;fda8
	nop			;fda9
	nop			;fdaa
	nop			;fdab
	nop			;fdac
	nop			;fdad
	nop			;fdae
	nop			;fdaf
	nop			;fdb0
	nop			;fdb1
	nop			;fdb2
	nop			;fdb3
	nop			;fdb4
	nop			;fdb5
	nop			;fdb6
	nop			;fdb7
	nop			;fdb8
	nop			;fdb9
	nop			;fdba
	nop			;fdbb
	nop			;fdbc
	nop			;fdbd
	nop			;fdbe
	nop			;fdbf
	nop			;fdc0
	nop			;fdc1
	nop			;fdc2
	nop			;fdc3
	nop			;fdc4
	nop			;fdc5
	nop			;fdc6
	nop			;fdc7
	nop			;fdc8
	nop			;fdc9
	nop			;fdca
	nop			;fdcb
	nop			;fdcc
	nop			;fdcd
	nop			;fdce
	nop			;fdcf
	nop			;fdd0
	nop			;fdd1
	nop			;fdd2
	nop			;fdd3
	nop			;fdd4
	nop			;fdd5
	nop			;fdd6
	nop			;fdd7
	nop			;fdd8
	nop			;fdd9
	nop			;fdda
	nop			;fddb
	nop			;fddc
	nop			;fddd
	nop			;fdde
	nop			;fddf
	nop			;fde0
	nop			;fde1
	nop			;fde2
	nop			;fde3
	nop			;fde4
	nop			;fde5
	nop			;fde6
	nop			;fde7
	nop			;fde8
	nop			;fde9
	nop			;fdea
	nop			;fdeb
	nop			;fdec
	nop			;fded
	nop			;fdee
	nop			;fdef
	nop			;fdf0
	nop			;fdf1
	nop			;fdf2
	nop			;fdf3
	nop			;fdf4
	nop			;fdf5
	nop			;fdf6
	nop			;fdf7
	nop			;fdf8
	nop			;fdf9
	nop			;fdfa
	nop			;fdfb
	nop			;fdfc
	nop			;fdfd
	nop			;fdfe
	nop			;fdff
	nop			;fe00
	nop			;fe01
	nop			;fe02
	nop			;fe03
	nop			;fe04
	nop			;fe05
	nop			;fe06
	nop			;fe07
	nop			;fe08
	nop			;fe09
	nop			;fe0a
	nop			;fe0b
	nop			;fe0c
	nop			;fe0d
	nop			;fe0e
	nop			;fe0f
	nop			;fe10
	nop			;fe11
	nop			;fe12
	nop			;fe13
	nop			;fe14
	nop			;fe15
	nop			;fe16
	nop			;fe17
	nop			;fe18
	nop			;fe19
	nop			;fe1a
	nop			;fe1b
	nop			;fe1c
	nop			;fe1d
	nop			;fe1e
	nop			;fe1f
	nop			;fe20
	nop			;fe21
	nop			;fe22
	nop			;fe23
	nop			;fe24
	nop			;fe25
	nop			;fe26
	nop			;fe27
	nop			;fe28
	nop			;fe29
	nop			;fe2a
	nop			;fe2b
	nop			;fe2c
	nop			;fe2d
	nop			;fe2e
	nop			;fe2f
	nop			;fe30
	nop			;fe31
	nop			;fe32
	nop			;fe33
	nop			;fe34
	nop			;fe35
	nop			;fe36
	nop			;fe37
	nop			;fe38
	nop			;fe39
	nop			;fe3a
	nop			;fe3b
	nop			;fe3c
	nop			;fe3d
	nop			;fe3e
	nop			;fe3f
	nop			;fe40
	nop			;fe41
	nop			;fe42
	nop			;fe43
	nop			;fe44
	nop			;fe45
	nop			;fe46
	nop			;fe47
	nop			;fe48
	nop			;fe49
	nop			;fe4a
	nop			;fe4b
	nop			;fe4c
	nop			;fe4d
	nop			;fe4e
	nop			;fe4f
	nop			;fe50
	nop			;fe51
	nop			;fe52
	nop			;fe53
	nop			;fe54
	nop			;fe55
	nop			;fe56
	nop			;fe57
	nop			;fe58
	nop			;fe59
	nop			;fe5a
	nop			;fe5b
	nop			;fe5c
	nop			;fe5d
	nop			;fe5e
	nop			;fe5f
	nop			;fe60
	nop			;fe61
	nop			;fe62
	nop			;fe63
	nop			;fe64
	nop			;fe65
	nop			;fe66
	nop			;fe67
	nop			;fe68
	nop			;fe69
	nop			;fe6a
	nop			;fe6b
	nop			;fe6c
	nop			;fe6d
	nop			;fe6e
	nop			;fe6f
	nop			;fe70
	nop			;fe71
	nop			;fe72
	nop			;fe73
	nop			;fe74
	nop			;fe75
	nop			;fe76
	nop			;fe77
	nop			;fe78
	nop			;fe79
	nop			;fe7a
	nop			;fe7b
	nop			;fe7c
	nop			;fe7d
	nop			;fe7e
	nop			;fe7f
	nop			;fe80
	nop			;fe81
	nop			;fe82
	nop			;fe83
	nop			;fe84
	nop			;fe85
	nop			;fe86
	nop			;fe87
	nop			;fe88
	nop			;fe89
	nop			;fe8a
	nop			;fe8b
	nop			;fe8c
	nop			;fe8d
	nop			;fe8e
	nop			;fe8f
	nop			;fe90
	nop			;fe91
	nop			;fe92
	nop			;fe93
	nop			;fe94
	nop			;fe95
	nop			;fe96
	nop			;fe97
	nop			;fe98
	nop			;fe99
	nop			;fe9a
	nop			;fe9b
	nop			;fe9c
	nop			;fe9d
	nop			;fe9e
	nop			;fe9f
	nop			;fea0
	nop			;fea1
	nop			;fea2
	nop			;fea3
	nop			;fea4
	nop			;fea5
	nop			;fea6
	nop			;fea7
	nop			;fea8
	nop			;fea9
	nop			;feaa
	nop			;feab
	nop			;feac
	nop			;fead
	nop			;feae
	nop			;feaf
	nop			;feb0
	nop			;feb1
	nop			;feb2
	nop			;feb3
	nop			;feb4
	nop			;feb5
	nop			;feb6
	nop			;feb7
	nop			;feb8
	nop			;feb9
	nop			;feba
	nop			;febb
	nop			;febc
	nop			;febd
	nop			;febe
	nop			;febf
	nop			;fec0
	nop			;fec1
	nop			;fec2
	nop			;fec3
	nop			;fec4
	nop			;fec5
	nop			;fec6
	nop			;fec7
	nop			;fec8
	nop			;fec9
	nop			;feca
	nop			;fecb
	nop			;fecc
	nop			;fecd
	nop			;fece
	nop			;fecf
	nop			;fed0
	nop			;fed1
	nop			;fed2
	nop			;fed3
	nop			;fed4
	nop			;fed5
	nop			;fed6
	nop			;fed7
	nop			;fed8
	nop			;fed9
	nop			;feda
	nop			;fedb
	nop			;fedc
	nop			;fedd
	nop			;fede
	nop			;fedf
	nop			;fee0
	nop			;fee1
	nop			;fee2
	nop			;fee3
	nop			;fee4
	nop			;fee5
	nop			;fee6
	nop			;fee7
	nop			;fee8
	nop			;fee9
	nop			;feea
	nop			;feeb
	nop			;feec
	nop			;feed
	nop			;feee
	nop			;feef
	nop			;fef0
	nop			;fef1
	nop			;fef2
	nop			;fef3
	nop			;fef4
	nop			;fef5
	nop			;fef6
	nop			;fef7
	nop			;fef8
	nop			;fef9
	nop			;fefa
	nop			;fefb
	nop			;fefc
	nop			;fefd
	nop			;fefe
	nop			;feff
	nop			;ff00
	nop			;ff01
	nop			;ff02
	nop			;ff03
	nop			;ff04
	nop			;ff05
	nop			;ff06
	nop			;ff07
	nop			;ff08
	nop			;ff09
	nop			;ff0a
	nop			;ff0b
	nop			;ff0c
	nop			;ff0d
	nop			;ff0e
	nop			;ff0f
	nop			;ff10
	nop			;ff11
	nop			;ff12
	nop			;ff13
	nop			;ff14
	nop			;ff15
	nop			;ff16
	nop			;ff17
	nop			;ff18
	nop			;ff19
	nop			;ff1a
	nop			;ff1b
	nop			;ff1c
	nop			;ff1d
	nop			;ff1e
	nop			;ff1f
	nop			;ff20
	nop			;ff21
	nop			;ff22
	nop			;ff23
	nop			;ff24
	nop			;ff25
	nop			;ff26
	nop			;ff27
	nop			;ff28
	nop			;ff29
	nop			;ff2a
	nop			;ff2b
	nop			;ff2c
	nop			;ff2d
	nop			;ff2e
	nop			;ff2f
	nop			;ff30
	nop			;ff31
	nop			;ff32
	nop			;ff33
	nop			;ff34
	nop			;ff35
	nop			;ff36
	nop			;ff37
	nop			;ff38
	nop			;ff39
	nop			;ff3a
	nop			;ff3b
	nop			;ff3c
	nop			;ff3d
	nop			;ff3e
	nop			;ff3f
	nop			;ff40
	nop			;ff41
	nop			;ff42
	nop			;ff43
	nop			;ff44
	nop			;ff45
	nop			;ff46
	nop			;ff47
	nop			;ff48
	nop			;ff49
	nop			;ff4a
	nop			;ff4b
	nop			;ff4c
	nop			;ff4d
	nop			;ff4e
	nop			;ff4f
	nop			;ff50
	nop			;ff51
	nop			;ff52
	nop			;ff53
	nop			;ff54
	nop			;ff55
	nop			;ff56
	nop			;ff57
	nop			;ff58
	nop			;ff59
	nop			;ff5a
	nop			;ff5b
	nop			;ff5c
	nop			;ff5d
	nop			;ff5e
	nop			;ff5f
	nop			;ff60
	nop			;ff61
	nop			;ff62
	nop			;ff63
	nop			;ff64
	nop			;ff65
	nop			;ff66
	nop			;ff67
	nop			;ff68
	nop			;ff69
	nop			;ff6a
	nop			;ff6b
	nop			;ff6c
	nop			;ff6d
	nop			;ff6e
	nop			;ff6f
	nop			;ff70
	nop			;ff71
	nop			;ff72
	nop			;ff73
	nop			;ff74
	nop			;ff75
	nop			;ff76
	nop			;ff77
	nop			;ff78
	nop			;ff79
	nop			;ff7a
	nop			;ff7b
	nop			;ff7c
	nop			;ff7d
	nop			;ff7e
	nop			;ff7f
	nop			;ff80
	nop			;ff81
	nop			;ff82
	nop			;ff83
	nop			;ff84
	nop			;ff85
	nop			;ff86
	nop			;ff87
	nop			;ff88
	nop			;ff89
	nop			;ff8a
	nop			;ff8b
	nop			;ff8c
	nop			;ff8d
	nop			;ff8e
	nop			;ff8f
	nop			;ff90
	nop			;ff91
	nop			;ff92
	nop			;ff93
	nop			;ff94
	nop			;ff95
	nop			;ff96
	nop			;ff97
	nop			;ff98
	nop			;ff99
	nop			;ff9a
	nop			;ff9b
	nop			;ff9c
	nop			;ff9d
	nop			;ff9e
	nop			;ff9f
	nop			;ffa0
	nop			;ffa1
	nop			;ffa2
	nop			;ffa3
	nop			;ffa4
	nop			;ffa5
	nop			;ffa6
	nop			;ffa7
	nop			;ffa8
	nop			;ffa9
	nop			;ffaa
	nop			;ffab
	nop			;ffac
	nop			;ffad
	nop			;ffae
	nop			;ffaf
	nop			;ffb0
	nop			;ffb1
	nop			;ffb2
	nop			;ffb3
	nop			;ffb4
	nop			;ffb5
	nop			;ffb6
	nop			;ffb7
	nop			;ffb8
	nop			;ffb9
	nop			;ffba
	nop			;ffbb
	nop			;ffbc
	nop			;ffbd
	nop			;ffbe
	nop			;ffbf
	nop			;ffc0
	nop			;ffc1
	nop			;ffc2
	nop			;ffc3
	nop			;ffc4
	nop			;ffc5
	nop			;ffc6
	nop			;ffc7
	nop			;ffc8
	nop			;ffc9
	nop			;ffca
	nop			;ffcb
	nop			;ffcc
	nop			;ffcd
	nop			;ffce
	nop			;ffcf
	nop			;ffd0
	nop			;ffd1
	nop			;ffd2
	nop			;ffd3
	nop			;ffd4
	nop			;ffd5
	nop			;ffd6
	nop			;ffd7
	nop			;ffd8
	nop			;ffd9
	nop			;ffda
	nop			;ffdb
	nop			;ffdc
	nop			;ffdd
	nop			;ffde
	nop			;ffdf
	nop			;ffe0
	nop			;ffe1
	nop			;ffe2
	nop			;ffe3
	nop			;ffe4
	nop			;ffe5
	rlca			;ffe6
	ld (bc),a			;ffe7
	inc bc			;ffe8
	inc b			;ffe9
	dec b			;ffea
	ld b,001h		;ffeb
	rst 10h			;ffed
	sub a			;ffee
	cp b			;ffef
	ex de,hl			;fff0
	push de			;fff1
	or 025h		;fff2
	rst 30h			;fff4
	ex (sp),hl			;fff5
	rst 30h			;fff6
	call po,0e4f7h		;fff7
	rst 38h			;fffa
	rst 38h			;fffb
	rst 38h			;fffc
	ld h,000h		;fffd
	nop			;ffff
