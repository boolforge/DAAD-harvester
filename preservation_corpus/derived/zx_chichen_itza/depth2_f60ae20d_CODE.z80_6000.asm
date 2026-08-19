; z80dasm 1.1.6
; command line: z80dasm -a -g 0x6000 preservation_corpus/extracted/depth2_f60ae20d_CODE.bin

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
	ld de,02a5fh		;8401
	jr c,$-76		;8404
	rst 8			;8406
	inc hl			;8407
	ld (hl),a			;8408
	adc a,h			;8409
	ld l,h			;840a
	jp c,0b5e1h		;840b
	ld a,l			;840e
	ret nz			;840f
	dec bc			;8410
	or d			;8411
	add a,(hl)			;8412
	sbc a,c			;8413
	rst 20h			;8414
	pop bc			;8415
	ld a,d			;8416
	add a,h			;8417
	add hl,hl			;8418
	jp 0c257h		;8419
	xor e			;841c
	jp nz,0c2d5h		;841d
	or d			;8420
	jp c,0846eh		;8421
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
	nop			;843c
	nop			;843d
	nop			;843e
	nop			;843f
	nop			;8440
	nop			;8441
	nop			;8442
	nop			;8443
	ld e,01eh		;8444
	ld e,01eh		;8446
	nop			;8448
	nop			;8449
	nop			;844a
	ld bc,00100h		;844b
	inc d			;844e
	rra			;844f
	dec l			;8450
	nop			;8451
	inc (hl)			;8452
	nop			;8453
	ld c,00fh		;8454
	djnz $+2		;8456
	nop			;8458
	nop			;8459
	ld d,020h		;845a
	ld l,01dh		;845c
	dec (hl)			;845e
	scf			;845f
	ld h,018h		;8460
	rra			;8462
	ld hl,0241bh		;8463
	dec c			;8466
	dec bc			;8467
	jr nz,$+4		;8468
	inc e			;846a
	dec h			;846b
	rst 38h			;846c
	rst 38h			;846d
	push bc			;846e
	ex de,hl			;846f
	ld bc,00032h		;8470
	ld hl,0843ch		;8473
	ldir		;8476
	pop bc			;8478
	ret			;8479
	rst 8			;847a
	rst 18h			;847b
	rst 18h			;847c
	rst 18h			;847d
	rst 18h			;847e
	sub a			;847f
	ld (bc),a			;8480
	adc a,0dfh		;8481
	rst 18h			;8483
	rst 18h			;8484
	rst 18h			;8485
	sbc a,b			;8486
	ld (bc),a			;8487
	call 0dfdfh		;8488
	rst 18h			;848b
	rst 18h			;848c
	sbc a,c			;848d
	ld (bc),a			;848e
	call z,0dfdfh		;848f
	rst 18h			;8492
	rst 18h			;8493
	sbc a,d			;8494
	ld (bc),a			;8495
	set 3,a		;8496
	rst 18h			;8498
	rst 18h			;8499
	rst 18h			;849a
	sbc a,e			;849b
	ld (bc),a			;849c
	jp z,0dfdfh		;849d
	rst 18h			;84a0
	rst 18h			;84a1
	sbc a,h			;84a2
	ld (bc),a			;84a3
	ret			;84a4
	rst 18h			;84a5
	rst 18h			;84a6
	rst 18h			;84a7
	rst 18h			;84a8
	sbc a,l			;84a9
	ld (bc),a			;84aa
	ret z			;84ab
	rst 18h			;84ac
	rst 18h			;84ad
	rst 18h			;84ae
	rst 18h			;84af
	sbc a,(hl)			;84b0
	ld (bc),a			;84b1
	rst 0			;84b2
	rst 18h			;84b3
	rst 18h			;84b4
	rst 18h			;84b5
	rst 18h			;84b6
	sbc a,a			;84b7
	ld (bc),a			;84b8
	add a,0dfh		;84b9
	rst 18h			;84bb
	rst 18h			;84bc
	rst 18h			;84bd
	and b			;84be
	ld (bc),a			;84bf
	cp (hl)			;84c0
	cp l			;84c1
	rst 18h			;84c2
	rst 18h			;84c3
	rst 18h			;84c4
	ld a,(bc)			;84c5
	ld (bc),a			;84c6
	cp (hl)			;84c7
	cp l			;84c8
	cp (hl)			;84c9
	or l			;84ca
	or b			;84cb
	ld a,(bc)			;84cc
	ld (bc),a			;84cd
	cp (hl)			;84ce
	cp l			;84cf
	xor l			;84d0
	cp d			;84d1
	rst 18h			;84d2
	ld e,d			;84d3
	nop			;84d4
	cp (hl)			;84d5
	cp l			;84d6
	xor l			;84d7
	cp d			;84d8
	or e			;84d9
	ld e,d			;84da
	nop			;84db
	cp (hl)			;84dc
	cp l			;84dd
	xor l			;84de
	or (hl)			;84df
	xor l			;84e0
	ld e,d			;84e1
	nop			;84e2
	cp (hl)			;84e3
	cp l			;84e4
	xor l			;84e5
	or b			;84e6
	rst 18h			;84e7
	ld e,d			;84e8
	nop			;84e9
	cp (hl)			;84ea
	cp b			;84eb
	cp (hl)			;84ec
	xor l			;84ed
	xor l			;84ee
	ld c,e			;84ef
	nop			;84f0
	cp (hl)			;84f1
	cp b			;84f2
	xor d			;84f3
	cp (hl)			;84f4
	rst 18h			;84f5
	ld l,a			;84f6
	ld (bc),a			;84f7
	cp (hl)			;84f8
	or h			;84f9
	cp (hl)			;84fa
	cp l			;84fb
	rst 18h			;84fc
	and (hl)			;84fd
	ld (bc),a			;84fe
	cp (hl)			;84ff
	or e			;8500
	xor e			;8501
	cp (hl)			;8502
	xor l			;8503
	scf			;8504
	ld (bc),a			;8505
	cp (hl)			;8506
	or c			;8507
	or (hl)			;8508
	or e			;8509
	or e			;850a
	ld d,b			;850b
	ld (bc),a			;850c
	cp (hl)			;850d
	xor a			;850e
	cp (hl)			;850f
	cp b			;8510
	cp (hl)			;8511
	ld e,(hl)			;8512
	nop			;8513
	cp (hl)			;8514
	xor a			;8515
	cp (hl)			;8516
	cp b			;8517
	or b			;8518
	ld e,(hl)			;8519
	nop			;851a
	cp (hl)			;851b
	xor l			;851c
	rst 18h			;851d
	rst 18h			;851e
	rst 18h			;851f
	add hl,bc			;8520
	ld (bc),a			;8521
	cp (hl)			;8522
	xor l			;8523
	cp (hl)			;8524
	call po,04abeh		;8525
	ld (bc),a			;8528
	cp (hl)			;8529
	xor l			;852a
	cp (hl)			;852b
	or c			;852c
	cp (hl)			;852d
	ld c,d			;852e
	ld (bc),a			;852f
	cp (hl)			;8530
	xor l			;8531
	cp l			;8532
	or b			;8533
	or e			;8534
	adc a,h			;8535
	ld (bc),a			;8536
	cp (hl)			;8537
	xor l			;8538
	cp l			;8539
	xor d			;853a
	xor h			;853b
	adc a,h			;853c
	ld (bc),a			;853d
	cp (hl)			;853e
	xor l			;853f
	xor l			;8540
	cp (hl)			;8541
	or c			;8542
	ld b,b			;8543
	nop			;8544
	cp (hl)			;8545
	xor l			;8546
	xor l			;8547
	or (hl)			;8548
	cp l			;8549
	add hl,bc			;854a
	ld (bc),a			;854b
	cp (hl)			;854c
	xor l			;854d
	xor l			;854e
	or b			;854f
	or l			;8550
	ld c,l			;8551
	nop			;8552
	cp l			;8553
	cp (hl)			;8554
	or l			;8555
	cp (hl)			;8556
	rst 18h			;8557
	ld a,(bc)			;8558
	ld (bc),a			;8559
	cp l			;855a
	cp (hl)			;855b
	or l			;855c
	cp (hl)			;855d
	xor l			;855e
	ld a,(bc)			;855f
	ld (bc),a			;8560
	cp l			;8561
	cp (hl)			;8562
	or l			;8563
	or b			;8564
	rst 18h			;8565
	ld a,(bc)			;8566
	ld (bc),a			;8567
	cp l			;8568
	cp d			;8569
	cp l			;856a
	cp d			;856b
	rst 18h			;856c
	ld b,l			;856d
	nop			;856e
	cp l			;856f
	cp d			;8570
	cp l			;8571
	cp d			;8572
	or e			;8573
	ld b,l			;8574
	nop			;8575
	cp l			;8576
	cp d			;8577
	cp l			;8578
	cp d			;8579
	xor l			;857a
	ld b,l			;857b
	nop			;857c
	cp l			;857d
	cp d			;857e
	cp l			;857f
	cp d			;8580
	xor e			;8581
	ld b,l			;8582
	nop			;8583
	cp l			;8584
	cp d			;8585
	cp l			;8586
	or b			;8587
	rst 18h			;8588
	ld b,l			;8589
	nop			;858a
	cp l			;858b
	cp d			;858c
	or e			;858d
	cp h			;858e
	or a			;858f
	halt			;8590
	ld (bc),a			;8591
	cp l			;8592
	or b			;8593
	xor l			;8594
	or e			;8595
	cp (hl)			;8596
	ld (0bd02h),a		;8597
	or b			;859a
	xor e			;859b
	or b			;859c
	or c			;859d
	ld l,(hl)			;859e
	ld (bc),a			;859f
	cp l			;85a0
	xor l			;85a1
	or (hl)			;85a2
	or e			;85a3
	or e			;85a4
	ld d,(hl)			;85a5
	ld (bc),a			;85a6
	cp h			;85a7
	cp (hl)			;85a8
	cp h			;85a9
	cp (hl)			;85aa
	or b			;85ab
	ld e,b			;85ac
	ld (bc),a			;85ad
	cp h			;85ae
	cp (hl)			;85af
	cp h			;85b0
	xor e			;85b1
	xor d			;85b2
	adc a,a			;85b3
	ld (bc),a			;85b4
	cp h			;85b5
	cp (hl)			;85b6
	or e			;85b7
	cp (hl)			;85b8
	cp l			;85b9
	ld b,b			;85ba
	ld (bc),a			;85bb
	cp h			;85bc
	cp (hl)			;85bd
	xor l			;85be
	cp l			;85bf
	or b			;85c0
	ld d,d			;85c1
	ld (bc),a			;85c2
	cp h			;85c3
	cp (hl)			;85c4
	xor l			;85c5
	cp b			;85c6
	cp (hl)			;85c7
	ld d,(hl)			;85c8
	nop			;85c9
	cp h			;85ca
	cp (hl)			;85cb
	xor l			;85cc
	cp b			;85cd
	or b			;85ce
	ld d,(hl)			;85cf
	nop			;85d0
	cp h			;85d1
	cp (hl)			;85d2
	xor d			;85d3
	cp h			;85d4
	or a			;85d5
	scf			;85d6
	inc bc			;85d7
	cp h			;85d8
	cp (hl)			;85d9
	and l			;85da
	or b			;85db
	rst 18h			;85dc
	dec a			;85dd
	ld (bc),a			;85de
	cp h			;85df
	cp d			;85e0
	xor l			;85e1
	xor l			;85e2
	cp (hl)			;85e3
	ld e,e			;85e4
	nop			;85e5
	cp h			;85e6
	or a			;85e7
	cp (hl)			;85e8
	cp h			;85e9
	rst 18h			;85ea
	adc a,(hl)			;85eb
	ld (bc),a			;85ec
	cp h			;85ed
	or a			;85ee
	cp (hl)			;85ef
	xor a			;85f0
	cp (hl)			;85f1
	sub (hl)			;85f2
	ld (bc),a			;85f3
	cp h			;85f4
	or a			;85f5
	or b			;85f6
	cp h			;85f7
	or b			;85f8
	ld l,l			;85f9
	ld (bc),a			;85fa
	cp h			;85fb
	or (hl)			;85fc
	cp d			;85fd
	xor l			;85fe
	xor l			;85ff
	ld e,e			;8600
	nop			;8601
	cp h			;8602
	or (hl)			;8603
	cp b			;8604
	cp (hl)			;8605
	xor l			;8606
	ld h,d			;8607
	ld (bc),a			;8608
	cp h			;8609
	or (hl)			;860a
	or e			;860b
	or (hl)			;860c
	or c			;860d
	dec (hl)			;860e
	ld (bc),a			;860f
	cp h			;8610
	or b			;8611
	cp e			;8612
	or (hl)			;8613
	cp h			;8614
	ld c,a			;8615
	ld (bc),a			;8616
	cp h			;8617
	or b			;8618
	cp b			;8619
	cp d			;861a
	rst 18h			;861b
	ld c,e			;861c
	nop			;861d
	cp h			;861e
	or b			;861f
	cp b			;8620
	cp d			;8621
	or e			;8622
	ld c,e			;8623
	nop			;8624
	cp h			;8625
	or b			;8626
	cp b			;8627
	cp d			;8628
	xor l			;8629
	ld c,e			;862a
	nop			;862b
	cp h			;862c
	or b			;862d
	or l			;862e
	or b			;862f
	rst 18h			;8630
	ld c,e			;8631
	nop			;8632
	cp h			;8633
	or b			;8634
	or e			;8635
	xor d			;8636
	or d			;8637
	xor e			;8638
	ld (bc),a			;8639
	cp h			;863a
	or b			;863b
	or d			;863c
	cp d			;863d
	rst 18h			;863e
	ld b,(hl)			;863f
	nop			;8640
	cp h			;8641
	or b			;8642
	or d			;8643
	cp d			;8644
	or e			;8645
	ld b,(hl)			;8646
	nop			;8647
	cp h			;8648
	or b			;8649
	or d			;864a
	cp d			;864b
	xor l			;864c
	ld b,(hl)			;864d
	nop			;864e
	cp h			;864f
	or b			;8650
	or d			;8651
	cp d			;8652
	xor e			;8653
	ld b,(hl)			;8654
	nop			;8655
	cp h			;8656
	or b			;8657
	or d			;8658
	or b			;8659
	rst 18h			;865a
	ld b,(hl)			;865b
	nop			;865c
	cp h			;865d
	or b			;865e
	or c			;865f
	or b			;8660
	rst 18h			;8661
	and d			;8662
	ld (bc),a			;8663
	cp h			;8664
	or b			;8665
	or c			;8666
	or b			;8667
	xor h			;8668
	and d			;8669
	ld (bc),a			;866a
	cp h			;866b
	or b			;866c
	xor l			;866d
	xor e			;866e
	cp d			;866f
	ld h,h			;8670
	ld (bc),a			;8671
	cp h			;8672
	xor d			;8673
	cp l			;8674
	xor l			;8675
	cp d			;8676
	add hl,sp			;8677
	nop			;8678
	cp h			;8679
	xor d			;867a
	cp l			;867b
	xor l			;867c
	or (hl)			;867d
	add hl,sp			;867e
	nop			;867f
	cp h			;8680
	xor d			;8681
	cp l			;8682
	xor l			;8683
	or b			;8684
	add hl,sp			;8685
	nop			;8686
	cp h			;8687
	xor d			;8688
	cp h			;8689
	or a			;868a
	or (hl)			;868b
	ld h,b			;868c
	ld (bc),a			;868d
	cp h			;868e
	xor d			;868f
	cp d			;8690
	or c			;8691
	cp h			;8692
	inc sp			;8693
	ld (bc),a			;8694
	cp e			;8695
	cp d			;8696
	rst 18h			;8697
	rst 18h			;8698
	rst 18h			;8699
	inc b			;869a
	inc b			;869b
	cp e			;869c
	cp d			;869d
	or l			;869e
	cp (hl)			;869f
	rst 18h			;86a0
	ld c,h			;86a1
	nop			;86a2
	cp e			;86a3
	cp d			;86a4
	or l			;86a5
	cp (hl)			;86a6
	or e			;86a7
	ld c,h			;86a8
	nop			;86a9
	cp e			;86aa
	cp d			;86ab
	or l			;86ac
	cp (hl)			;86ad
	xor l			;86ae
	ld c,h			;86af
	nop			;86b0
	cp e			;86b1
	cp d			;86b2
	or l			;86b3
	or b			;86b4
	rst 18h			;86b5
	ld c,h			;86b6
	nop			;86b7
	cp e			;86b8
	cp d			;86b9
	or e			;86ba
	rst 18h			;86bb
	rst 18h			;86bc
	inc b			;86bd
	inc b			;86be
	cp e			;86bf
	cp d			;86c0
	or c			;86c1
	xor e			;86c2
	xor l			;86c3
	ld (bc),a			;86c4
	inc b			;86c5
	cp e			;86c6
	cp d			;86c7
	xor h			;86c8
	cp h			;86c9
	xor l			;86ca
	ld hl,(0bb00h)		;86cb
	cp d			;86ce
	xor h			;86cf
	cp h			;86d0
	xor d			;86d1
	ld a,(0bb00h)		;86d2
	cp d			;86d5
	xor h			;86d6
	xor e			;86d7
	cp (hl)			;86d8
	ld a,(0bb00h)		;86d9
	or (hl)			;86dc
	cp (hl)			;86dd
	or d			;86de
	cp (hl)			;86df
	ld d,(hl)			;86e0
	ld (bc),a			;86e1
	cp e			;86e2
	or (hl)			;86e3
	cp l			;86e4
	xor d			;86e5
	or l			;86e6
	ld l,000h		;86e7
	cp e			;86e9
	or (hl)			;86ea
	xor h			;86eb
	cp h			;86ec
	or b			;86ed
	adc a,l			;86ee
	ld (bc),a			;86ef
	cp e			;86f0
	or (hl)			;86f1
	xor h			;86f2
	or b			;86f3
	or e			;86f4
	ld (hl),e			;86f5
	ld (bc),a			;86f6
	cp d			;86f7
	rst 18h			;86f8
	rst 18h			;86f9
	rst 18h			;86fa
	rst 18h			;86fb
	inc bc			;86fc
	ld (bc),a			;86fd
	cp d			;86fe
	cp h			;86ff
	or a			;8700
	cp (hl)			;8701
	rst 18h			;8702
	jr c,$+2		;8703
	cp d			;8705
	cp h			;8706
	or a			;8707
	cp (hl)			;8708
	or e			;8709
	jr c,$+2		;870a
	cp d			;870c
	cp h			;870d
	or a			;870e
	cp (hl)			;870f
	xor l			;8710
	jr c,$+2		;8711
	cp d			;8713
	cp h			;8714
	or a			;8715
	or b			;8716
	rst 18h			;8717
	jr c,$+2		;8718
	cp d			;871a
	or d			;871b
	xor a			;871c
	xor d			;871d
	or l			;871e
	ld d,c			;871f
	nop			;8720
	cp d			;8721
	or c			;8722
	rst 18h			;8723
	rst 18h			;8724
	rst 18h			;8725
	ld (bc),a			;8726
	inc b			;8727
	cp d			;8728
	or c			;8729
	cp h			;872a
	cp d			;872b
	or c			;872c
	ld e,l			;872d
	nop			;872e
	cp d			;872f
	or c			;8730
	cp h			;8731
	or (hl)			;8732
	cp d			;8733
	ld e,l			;8734
	nop			;8735
	cp d			;8736
	or c			;8737
	xor l			;8738
	cp d			;8739
	or l			;873a
	xor c			;873b
	ld (bc),a			;873c
	cp d			;873d
	or c			;873e
	xor e			;873f
	xor l			;8740
	cp (hl)			;8741
	dec bc			;8742
	ld (bc),a			;8743
	cp d			;8744
	or c			;8745
	xor e			;8746
	xor l			;8747
	or b			;8748
	dec bc			;8749
	ld (bc),a			;874a
	cp d			;874b
	xor h			;874c
	cp h			;874d
	xor d			;874e
	cp e			;874f
	ld a,002h		;8750
	cp d			;8752
	xor h			;8753
	xor a			;8754
	cp d			;8755
	xor l			;8756
	jr z,$+2		;8757
	cp d			;8759
	xor h			;875a
	xor e			;875b
	cp (hl)			;875c
	xor e			;875d
	adc a,(hl)			;875e
	ld (bc),a			;875f
	cp d			;8760
	xor h			;8761
	xor e			;8762
	cp d			;8763
	rst 18h			;8764
	inc bc			;8765
	ld (bc),a			;8766
	cp d			;8767
	and a			;8768
	rst 18h			;8769
	rst 18h			;876a
	rst 18h			;876b
	inc l			;876c
	nop			;876d
	cp d			;876e
	and a			;876f
	cp (hl)			;8770
	or d			;8771
	or (hl)			;8772
	inc l			;8773
	nop			;8774
	cp c			;8775
	rst 18h			;8776
	rst 18h			;8777
	rst 18h			;8778
	rst 18h			;8779
	dec hl			;877a
	nop			;877b
	cp c			;877c
	cp (hl)			;877d
	cp h			;877e
	or a			;877f
	cp (hl)			;8780
	sub h			;8781
	ld (bc),a			;8782
	cp c			;8783
	or (hl)			;8784
	cp b			;8785
	xor d			;8786
	xor l			;8787
	ld c,d			;8788
	ld (bc),a			;8789
	cp c			;878a
	or (hl)			;878b
	or c			;878c
	rst 18h			;878d
	rst 18h			;878e
	dec hl			;878f
	nop			;8790
	cp c			;8791
	or e			;8792
	or b			;8793
	xor l			;8794
	rst 18h			;8795
	ld a,d			;8796
	ld (bc),a			;8797
	cp c			;8798
	xor d			;8799
	or d			;879a
	cp (hl)			;879b
	rst 18h			;879c
	ld a,000h		;879d
	cp c			;879f
	xor d			;87a0
	or d			;87a1
	cp (hl)			;87a2
	or e			;87a3
	ld a,000h		;87a4
	cp c			;87a6
	xor d			;87a7
	or d			;87a8
	cp (hl)			;87a9
	xor l			;87aa
	ld a,000h		;87ab
	cp c			;87ad
	xor d			;87ae
	or d			;87af
	or b			;87b0
	rst 18h			;87b1
	ld a,000h		;87b2
	cp b			;87b4
	rst 18h			;87b5
	rst 18h			;87b6
	rst 18h			;87b7
	rst 18h			;87b8
	ld l,000h		;87b9
	cp b			;87bb
	or (hl)			;87bc
	xor l			;87bd
	cp (hl)			;87be
	rst 18h			;87bf
	ld d,d			;87c0
	nop			;87c1
	cp b			;87c2
	or (hl)			;87c3
	xor l			;87c4
	cp (hl)			;87c5
	or e			;87c6
	ld d,d			;87c7
	nop			;87c8
	cp b			;87c9
	or (hl)			;87ca
	xor l			;87cb
	cp (hl)			;87cc
	xor l			;87cd
	ld d,d			;87ce
	nop			;87cf
	cp b			;87d0
	or (hl)			;87d1
	xor l			;87d2
	or b			;87d3
	rst 18h			;87d4
	ld d,d			;87d5
	nop			;87d6
	cp b			;87d7
	xor l			;87d8
	cp (hl)			;87d9
	cp l			;87da
	cp (hl)			;87db
	ld d,l			;87dc
	nop			;87dd
	cp b			;87de
	xor l			;87df
	cp (hl)			;87e0
	cp l			;87e1
	or b			;87e2
	ld d,l			;87e3
	nop			;87e4
	cp b			;87e5
	xor l			;87e6
	cp (hl)			;87e7
	cp c			;87e8
	or (hl)			;87e9
	ld l,000h		;87ea
	or a			;87ec
	cp (hl)			;87ed
	cp h			;87ee
	cp d			;87ef
	xor l			;87f0
	ld d,a			;87f1
	nop			;87f2
	or a			;87f3
	cp (hl)			;87f4
	cp b			;87f5
	or b			;87f6
	rst 18h			;87f7
	ld d,a			;87f8
	nop			;87f9
	or a			;87fa
	cp (hl)			;87fb
	and l			;87fc
	rst 18h			;87fd
	rst 18h			;87fe
	ld d,a			;87ff
	nop			;8800
	or a			;8801
	or b			;8802
	or l			;8803
	cp (hl)			;8804
	rst 18h			;8805
	ld h,c			;8806
	ld (bc),a			;8807
	or a			;8808
	or b			;8809
	or l			;880a
	cp (hl)			;880b
	xor h			;880c
	ld h,c			;880d
	ld (bc),a			;880e
	or (hl)			;880f
	rst 18h			;8810
	rst 18h			;8811
	rst 18h			;8812
	rst 18h			;8813
	add hl,hl			;8814
	nop			;8815
	or (hl)			;8816
	or c			;8817
	xor h			;8818
	cp h			;8819
	xor l			;881a
	xor (hl)			;881b
	ld (bc),a			;881c
	or (hl)			;881d
	or c			;881e
	xor e			;881f
	cp d			;8820
	or e			;8821
	xor (hl)			;8822
	ld (bc),a			;8823
	or (hl)			;8824
	or c			;8825
	xor c			;8826
	cp d			;8827
	or c			;8828
	add hl,hl			;8829
	nop			;882a
	or e			;882b
	cp (hl)			;882c
	or c			;882d
	cp h			;882e
	cp d			;882f
	ld e,h			;8830
	ld (bc),a			;8831
	or e			;8832
	cp (hl)			;8833
	or c			;8834
	and l			;8835
	cp (hl)			;8836
	ld c,l			;8837
	nop			;8838
	or e			;8839
	cp (hl)			;883a
	or c			;883b
	and l			;883c
	or b			;883d
	ld c,l			;883e
	nop			;883f
	or e			;8840
	cp (hl)			;8841
	xor e			;8842
	cp d			;8843
	and a			;8844
	ld a,e			;8845
	ld (bc),a			;8846
	or e			;8847
	cp d			;8848
	cp d			;8849
	rst 18h			;884a
	rst 18h			;884b
	inc l			;884c
	nop			;884d
	or e			;884e
	cp d			;884f
	cp d			;8850
	or e			;8851
	cp (hl)			;8852
	inc l			;8853
	nop			;8854
	or e			;8855
	cp d			;8856
	cp d			;8857
	or e			;8858
	or b			;8859
	inc l			;885a
	nop			;885b
	or e			;885c
	cp d			;885d
	cp d			;885e
	xor l			;885f
	rst 18h			;8860
	inc l			;8861
	nop			;8862
	or e			;8863
	cp d			;8864
	cp d			;8865
	xor l			;8866
	or e			;8867
	inc l			;8868
	nop			;8869
	or e			;886a
	cp d			;886b
	or b			;886c
	rst 18h			;886d
	rst 18h			;886e
	inc l			;886f
	nop			;8870
	or e			;8871
	cp d			;8872
	xor c			;8873
	cp (hl)			;8874
	or c			;8875
	ld d,c			;8876
	nop			;8877
	or e			;8878
	or (hl)			;8879
	cp (hl)			;887a
	rst 18h			;887b
	rst 18h			;887c
	ld d,a			;887d
	nop			;887e
	or e			;887f
	or (hl)			;8880
	cp (hl)			;8881
	or e			;8882
	cp (hl)			;8883
	ld d,a			;8884
	nop			;8885
	or e			;8886
	or (hl)			;8887
	cp (hl)			;8888
	or e			;8889
	or b			;888a
	ld d,a			;888b
	nop			;888c
	or e			;888d
	or (hl)			;888e
	cp (hl)			;888f
	xor l			;8890
	rst 18h			;8891
	ld d,a			;8892
	nop			;8893
	or e			;8894
	or (hl)			;8895
	cp (hl)			;8896
	xor l			;8897
	or e			;8898
	ld d,a			;8899
	nop			;889a
	or e			;889b
	or (hl)			;889c
	or b			;889d
	rst 18h			;889e
	rst 18h			;889f
	ld d,a			;88a0
	nop			;88a1
	or e			;88a2
	or e			;88a3
	cp (hl)			;88a4
	xor c			;88a5
	cp d			;88a6
	ld l,e			;88a7
	ld (bc),a			;88a8
	or e			;88a9
	or e			;88aa
	cp d			;88ab
	or c			;88ac
	cp (hl)			;88ad
	scf			;88ae
	nop			;88af
	or e			;88b0
	or e			;88b1
	cp d			;88b2
	or c			;88b3
	or b			;88b4
	scf			;88b5
	nop			;88b6
	or e			;88b7
	or b			;88b8
	cp (hl)			;88b9
	cp e			;88ba
	rst 18h			;88bb
	ld d,(hl)			;88bc
	nop			;88bd
	or e			;88be
	or b			;88bf
	xor h			;88c0
	cp (hl)			;88c1
	rst 18h			;88c2
	and c			;88c3
	ld (bc),a			;88c4
	or e			;88c5
	or b			;88c6
	xor h			;88c7
	cp (hl)			;88c8
	xor h			;88c9
	and c			;88ca
	ld (bc),a			;88cb
	or e			;88cc
	xor l			;88cd
	rst 18h			;88ce
	rst 18h			;88cf
	rst 18h			;88d0
	inc (hl)			;88d1
	nop			;88d2
	or d			;88d3
	rst 18h			;88d4
	rst 18h			;88d5
	rst 18h			;88d6
	rst 18h			;88d7
	ld hl,(0b200h)		;88d8
	cp (hl)			;88db
	or c			;88dc
	xor e			;88dd
	cp (hl)			;88de
	ld h,a			;88df
	ld (bc),a			;88e0
	or d			;88e1
	cp (hl)			;88e2
	xor l			;88e3
	cp h			;88e4
	or b			;88e5
	or c			;88e6
	ld (bc),a			;88e7
	or d			;88e8
	cp (hl)			;88e9
	xor l			;88ea
	xor l			;88eb
	or b			;88ec
	ld (0b203h),a		;88ed
	cp (hl)			;88f0
	xor h			;88f1
	cp h			;88f2
	cp (hl)			;88f3
	xor b			;88f4
	ld (bc),a			;88f5
	or d			;88f6
	cp d			;88f7
	cp e			;88f8
	or (hl)			;88f9
	cp h			;88fa
	ld (hl),h			;88fb
	ld (bc),a			;88fc
	or d			;88fd
	cp d			;88fe
	xor h			;88ff
	cp h			;8900
	cp (hl)			;8901
	ld l,(hl)			;8902
	ld (bc),a			;8903
	or d			;8904
	cp d			;8905
	xor e			;8906
	cp d			;8907
	rst 18h			;8908
	ld c,c			;8909
	nop			;890a
	or d			;890b
	cp d			;890c
	xor e			;890d
	cp d			;890e
	or e			;890f
	ld c,c			;8910
	nop			;8911
	or d			;8912
	cp d			;8913
	xor e			;8914
	cp d			;8915
	xor l			;8916
	ld c,c			;8917
	nop			;8918
	or d			;8919
	cp d			;891a
	xor e			;891b
	or b			;891c
	rst 18h			;891d
	ld c,c			;891e
	nop			;891f
	or d			;8920
	or (hl)			;8921
	xor l			;8922
	cp (hl)			;8923
	rst 18h			;8924
	ld hl,(0b200h)		;8925
	or (hl)			;8928
	xor l			;8929
	cp (hl)			;892a
	xor l			;892b
	ld hl,(0b200h)		;892c
	or (hl)			;892f
	xor l			;8930
	or b			;8931
	rst 18h			;8932
	ld hl,(0b200h)		;8933
	or b			;8936
	or e			;8937
	cp e			;8938
	cp d			;8939
	ld b,b			;893a
	ld (bc),a			;893b
	or d			;893c
	or b			;893d
	xor c			;893e
	cp d			;893f
	xor l			;8940
	ld d,c			;8941
	nop			;8942
	or d			;8943
	xor d			;8944
	cp d			;8945
	xor c			;8946
	cp d			;8947
	ld d,c			;8948
	nop			;8949
	or d			;894a
	xor d			;894b
	cp d			;894c
	xor c			;894d
	or b			;894e
	ld d,c			;894f
	nop			;8950
	or d			;8951
	xor d			;8952
	xor l			;8953
	or b			;8954
	rst 18h			;8955
	sub c			;8956
	ld (bc),a			;8957
	or d			;8958
	xor d			;8959
	xor l			;895a
	or b			;895b
	xor h			;895c
	sub c			;895d
	ld (bc),a			;895e
	or c			;895f
	rst 18h			;8960
	rst 18h			;8961
	rst 18h			;8962
	rst 18h			;8963
	ld bc,0b102h		;8964
	cp d			;8967
	rst 18h			;8968
	rst 18h			;8969
	rst 18h			;896a
	dec b			;896b
	ld (bc),a			;896c
	or c			;896d
	or b			;896e
	rst 18h			;896f
	rst 18h			;8970
	rst 18h			;8971
	ld b,002h		;8972
	or c			;8974
	or b			;8975
	xor l			;8976
	cp d			;8977
	xor h			;8978
	dec b			;8979
	ld (bc),a			;897a
	or c			;897b
	or b			;897c
	xor l			;897d
	or b			;897e
	cp d			;897f
	ld b,002h		;8980
	or c			;8982
	or b			;8983
	xor l			;8984
	xor e			;8985
	cp d			;8986
	ld bc,0b002h		;8987
	rst 18h			;898a
	rst 18h			;898b
	rst 18h			;898c
	rst 18h			;898d
	inc b			;898e
	ld (bc),a			;898f
	or b			;8990
	cp l			;8991
	xor h			;8992
	cp d			;8993
	xor l			;8994
	ld a,c			;8995
	ld (bc),a			;8996
	or b			;8997
	cp d			;8998
	xor h			;8999
	xor e			;899a
	cp d			;899b
	inc b			;899c
	ld (bc),a			;899d
	or b			;899e
	cp c			;899f
	cp c			;89a0
	rst 18h			;89a1
	rst 18h			;89a2
	dec sp			;89a3
	inc bc			;89a4
	or b			;89a5
	or c			;89a6
	or (hl)			;89a7
	cp h			;89a8
	cp d			;89a9
	ld d,e			;89aa
	ld (bc),a			;89ab
	xor a			;89ac
	rst 18h			;89ad
	rst 18h			;89ae
	rst 18h			;89af
	rst 18h			;89b0
	ei			;89b1
	ld (bc),a			;89b2
	xor a			;89b3
	cp (hl)			;89b4
	xor l			;89b5
	cp d			;89b6
	cp e			;89b7
	sub c			;89b8
	ld (bc),a			;89b9
	xor a			;89ba
	cp (hl)			;89bb
	xor h			;89bc
	xor e			;89bd
	cp (hl)			;89be
	ld (hl),e			;89bf
	ld (bc),a			;89c0
	xor a			;89c1
	cp d			;89c2
	or e			;89c3
	or b			;89c4
	xor e			;89c5
	ld l,d			;89c6
	ld (bc),a			;89c7
	xor a			;89c8
	cp d			;89c9
	and (hl)			;89ca
	or b			;89cb
	xor e			;89cc
	adc a,a			;89cd
	ld (bc),a			;89ce
	xor a			;89cf
	or (hl)			;89d0
	cp d			;89d1
	cp e			;89d2
	xor l			;89d3
	ld d,c			;89d4
	ld (bc),a			;89d5
	xor a			;89d6
	or (hl)			;89d7
	or e			;89d8
	cp (hl)			;89d9
	xor l			;89da
	sub b			;89db
	ld (bc),a			;89dc
	xor a			;89dd
	or (hl)			;89de
	xor a			;89df
	cp (hl)			;89e0
	rst 18h			;89e1
	ld h,e			;89e2
	ld (bc),a			;89e3
	xor a			;89e4
	or e			;89e5
	cp (hl)			;89e6
	or c			;89e7
	xor e			;89e8
	adc a,h			;89e9
	ld (bc),a			;89ea
	xor a			;89eb
	or b			;89ec
	or c			;89ed
	rst 18h			;89ee
	rst 18h			;89ef
	ld b,a			;89f0
	nop			;89f1
	xor a			;89f2
	or b			;89f3
	or c			;89f4
	cp d			;89f5
	xor l			;89f6
	ld b,a			;89f7
	nop			;89f8
	xor a			;89f9
	or b			;89fa
	or c			;89fb
	cp b			;89fc
	or b			;89fd
	ld b,a			;89fe
	nop			;89ff
	xor a			;8a00
	or b			;8a01
	or c			;8a02
	or e			;8a03
	cp (hl)			;8a04
	ld b,a			;8a05
	nop			;8a06
	xor a			;8a07
	or b			;8a08
	or c			;8a09
	or e			;8a0a
	or b			;8a0b
	ld b,a			;8a0c
	nop			;8a0d
	xor a			;8a0e
	or b			;8a0f
	or c			;8a10
	xor e			;8a11
	cp d			;8a12
	ld b,a			;8a13
	nop			;8a14
	xor a			;8a15
	or b			;8a16
	xor l			;8a17
	rst 18h			;8a18
	rst 18h			;8a19
	inc bc			;8a1a
	inc b			;8a1b
	xor a			;8a1c
	or b			;8a1d
	xor l			;8a1e
	xor e			;8a1f
	or (hl)			;8a20
	and a			;8a21
	ld (bc),a			;8a22
	xor a			;8a23
	xor d			;8a24
	cp d			;8a25
	xor l			;8a26
	xor e			;8a27
	sub d			;8a28
	ld (bc),a			;8a29
	xor a			;8a2a
	xor d			;8a2b
	xor l			;8a2c
	or (hl)			;8a2d
	cp c			;8a2e
	ld e,h			;8a2f
	nop			;8a30
	xor a			;8a31
	xor d			;8a32
	xor l			;8a33
	or b			;8a34
	rst 18h			;8a35
	ld h,d			;8a36
	ld (bc),a			;8a37
	xor (hl)			;8a38
	xor d			;8a39
	or (hl)			;8a3a
	xor e			;8a3b
	cp (hl)			;8a3c
	ld c,b			;8a3d
	nop			;8a3e
	xor (hl)			;8a3f
	xor d			;8a40
	or (hl)			;8a41
	xor e			;8a42
	or b			;8a43
	ld c,b			;8a44
	nop			;8a45
	xor l			;8a46
	rst 18h			;8a47
	rst 18h			;8a48
	rst 18h			;8a49
	rst 18h			;8a4a
	ld hl,(0ad00h)		;8a4b
	cp (hl)			;8a4e
	or d			;8a4f
	rst 18h			;8a50
	rst 18h			;8a51
	or b			;8a52
	ld (bc),a			;8a53
	xor l			;8a54
	cp (hl)			;8a55
	or c			;8a56
	xor d			;8a57
	xor l			;8a58
	sub (hl)			;8a59
	ld (bc),a			;8a5a
	xor l			;8a5b
	cp d			;8a5c
	xor h			;8a5d
	or (hl)			;8a5e
	or c			;8a5f
	ld (hl),c			;8a60
	ld (bc),a			;8a61
	xor l			;8a62
	or e			;8a63
	rst 18h			;8a64
	rst 18h			;8a65
	rst 18h			;8a66
	inc (hl)			;8a67
	nop			;8a68
	xor l			;8a69
	or b			;8a6a
	or l			;8a6b
	cp (hl)			;8a6c
	rst 18h			;8a6d
	inc sp			;8a6e
	inc bc			;8a6f
	xor l			;8a70
	or b			;8a71
	or d			;8a72
	xor a			;8a73
	cp d			;8a74
	ld d,e			;8a75
	nop			;8a76
	xor l			;8a77
	or b			;8a78
	or d			;8a79
	xor a			;8a7a
	or b			;8a7b
	ld d,e			;8a7c
	nop			;8a7d
	xor l			;8a7e
	or b			;8a7f
	xor h			;8a80
	cp (hl)			;8a81
	rst 18h			;8a82
	ld h,l			;8a83
	ld (bc),a			;8a84
	xor l			;8a85
	xor h			;8a86
	rst 18h			;8a87
	rst 18h			;8a88
	rst 18h			;8a89
	inc sp			;8a8a
	nop			;8a8b
	xor l			;8a8c
	xor d			;8a8d
	cp l			;8a8e
	or (hl)			;8a8f
	rst 18h			;8a90
	ld d,h			;8a91
	ld (bc),a			;8a92
	xor h			;8a93
	rst 18h			;8a94
	rst 18h			;8a95
	rst 18h			;8a96
	rst 18h			;8a97
	ld (bc),a			;8a98
	ld (bc),a			;8a99
	xor h			;8a9a
	cp (hl)			;8a9b
	cp h			;8a9c
	cp (hl)			;8a9d
	rst 18h			;8a9e
	ld c,d			;8a9f
	nop			;8aa0
	xor h			;8aa1
	cp (hl)			;8aa2
	cp h			;8aa3
	cp (hl)			;8aa4
	or e			;8aa5
	ld c,d			;8aa6
	nop			;8aa7
	xor h			;8aa8
	cp (hl)			;8aa9
	cp h			;8aaa
	cp (hl)			;8aab
	xor l			;8aac
	ld c,d			;8aad
	nop			;8aae
	xor h			;8aaf
	cp (hl)			;8ab0
	cp h			;8ab1
	or b			;8ab2
	rst 18h			;8ab3
	ld c,d			;8ab4
	nop			;8ab5
	xor h			;8ab6
	cp (hl)			;8ab7
	cp h			;8ab8
	xor d			;8ab9
	cp e			;8aba
	ld d,c			;8abb
	nop			;8abc
	xor h			;8abd
	cp (hl)			;8abe
	or e			;8abf
	rst 18h			;8ac0
	rst 18h			;8ac1
	inc c			;8ac2
	ld (bc),a			;8ac3
	xor h			;8ac4
	cp (hl)			;8ac5
	or e			;8ac6
	cp b			;8ac7
	or b			;8ac8
	inc c			;8ac9
	ld (bc),a			;8aca
	xor h			;8acb
	cp (hl)			;8acc
	or e			;8acd
	or (hl)			;8ace
	cp e			;8acf
	ld (0ac00h),a		;8ad0
	cp (hl)			;8ad3
	or e			;8ad4
	or (hl)			;8ad5
	xor l			;8ad6
	inc c			;8ad7
	ld (bc),a			;8ad8
	xor h			;8ad9
	cp (hl)			;8ada
	or e			;8adb
	xor e			;8adc
	cp (hl)			;8add
	dec c			;8ade
	ld (bc),a			;8adf
	xor h			;8ae0
	cp (hl)			;8ae1
	or e			;8ae2
	xor e			;8ae3
	or b			;8ae4
	dec c			;8ae5
	ld (bc),a			;8ae6
	xor h			;8ae7
	cp (hl)			;8ae8
	or c			;8ae9
	cp b			;8aea
	xor l			;8aeb
	inc a			;8aec
	nop			;8aed
	xor h			;8aee
	cp (hl)			;8aef
	xor c			;8af0
	cp d			;8af1
	rst 18h			;8af2
	ld d,l			;8af3
	nop			;8af4
	xor h			;8af5
	cp d			;8af6
	rst 18h			;8af7
	rst 18h			;8af8
	rst 18h			;8af9
	rlca			;8afa
	ld (bc),a			;8afb
	xor h			;8afc
	cp d			;8afd
	or e			;8afe
	or e			;8aff
	or b			;8b00
	and l			;8b01
	ld (bc),a			;8b02
	xor h			;8b03
	cp d			;8b04
	xor l			;8b05
	xor a			;8b06
	or (hl)			;8b07
	ld l,b			;8b08
	ld (bc),a			;8b09
	xor h			;8b0a
	or (hl)			;8b0b
	rst 18h			;8b0c
	rst 18h			;8b0d
	rst 18h			;8b0e
	jr nc,$+4		;8b0f
	xor h			;8b11
	or (hl)			;8b12
	or d			;8b13
	cp l			;8b14
	or b			;8b15
	sub h			;8b16
	ld (bc),a			;8b17
	xor h			;8b18
	or b			;8b19
	rst 18h			;8b1a
	rst 18h			;8b1b
	rst 18h			;8b1c
	ex af,af'			;8b1d
	ld (bc),a			;8b1e
	xor h			;8b1f
	or b			;8b20
	cp l			;8b21
	xor l			;8b22
	cp d			;8b23
	ld (bc),a			;8b24
	inc b			;8b25
	xor h			;8b26
	or b			;8b27
	or e			;8b28
	rst 18h			;8b29
	rst 18h			;8b2a
	ld h,(hl)			;8b2b
	ld (bc),a			;8b2c
	xor h			;8b2d
	or b			;8b2e
	or e			;8b2f
	xor e			;8b30
	cp (hl)			;8b31
	ld c,h			;8b32
	nop			;8b33
	xor h			;8b34
	xor l			;8b35
	rst 18h			;8b36
	rst 18h			;8b37
	rst 18h			;8b38
	inc sp			;8b39
	nop			;8b3a
	xor h			;8b3b
	xor d			;8b3c
	cp l			;8b3d
	cp d			;8b3e
	rst 18h			;8b3f
	add hl,bc			;8b40
	ld (bc),a			;8b41
	xor h			;8b42
	xor d			;8b43
	cp l			;8b44
	or (hl)			;8b45
	xor l			;8b46
	add hl,bc			;8b47
	ld (bc),a			;8b48
	xor h			;8b49
	xor d			;8b4a
	cp l			;8b4b
	or b			;8b4c
	rst 18h			;8b4d
	add hl,bc			;8b4e
	ld (bc),a			;8b4f
	xor h			;8b50
	xor d			;8b51
	cp d			;8b52
	or e			;8b53
	or b			;8b54
	sub l			;8b55
	ld (bc),a			;8b56
	xor h			;8b57
	xor d			;8b58
	cp d			;8b59
	or e			;8b5a
	xor e			;8b5b
	ld c,h			;8b5c
	nop			;8b5d
	xor h			;8b5e
	xor d			;8b5f
	xor l			;8b60
	rst 18h			;8b61
	rst 18h			;8b62
	ld (bc),a			;8b63
	ld (bc),a			;8b64
	xor h			;8b65
	xor d			;8b66
	xor l			;8b67
	cp d			;8b68
	xor h			;8b69
	rlca			;8b6a
	ld (bc),a			;8b6b
	xor h			;8b6c
	xor d			;8b6d
	xor l			;8b6e
	or b			;8b6f
	cp d			;8b70
	ex af,af'			;8b71
	ld (bc),a			;8b72
	xor h			;8b73
	xor d			;8b74
	xor h			;8b75
	xor e			;8b76
	cp (hl)			;8b77
	ld (hl),a			;8b78
	ld (bc),a			;8b79
	xor e			;8b7a
	rst 18h			;8b7b
	rst 18h			;8b7c
	rst 18h			;8b7d
	rst 18h			;8b7e
	cpl			;8b7f
	nop			;8b80
	xor e			;8b81
	cp (hl)			;8b82
	cp l			;8b83
	cp (hl)			;8b84
	cp h			;8b85
	ld h,c			;8b86
	ld (bc),a			;8b87
	xor e			;8b88
	cp (hl)			;8b89
	xor a			;8b8a
	cp (hl)			;8b8b
	rst 18h			;8b8c
	and l			;8b8d
	ld (bc),a			;8b8e
	xor e			;8b8f
	cp (hl)			;8b90
	xor a			;8b91
	cp (hl)			;8b92
	or e			;8b93
	add hl,sp			;8b94
	nop			;8b95
	xor e			;8b96
	cp (hl)			;8b97
	xor a			;8b98
	cp (hl)			;8b99
	xor l			;8b9a
	add hl,sp			;8b9b
	nop			;8b9c
	xor e			;8b9d
	cp (hl)			;8b9e
	xor a			;8b9f
	or b			;8ba0
	rst 18h			;8ba1
	add hl,sp			;8ba2
	nop			;8ba3
	xor e			;8ba4
	cp (hl)			;8ba5
	xor l			;8ba6
	xor l			;8ba7
	or b			;8ba8
	ld c,b			;8ba9
	ld (bc),a			;8baa
	xor e			;8bab
	cp d			;8bac
	and a			;8bad
	xor e			;8bae
	or b			;8baf
	cpl			;8bb0
	nop			;8bb1
	xor e			;8bb2
	or (hl)			;8bb3
	xor l			;8bb4
	cp (hl)			;8bb5
	rst 18h			;8bb6
	ld c,l			;8bb7
	nop			;8bb8
	xor e			;8bb9
	or (hl)			;8bba
	xor l			;8bbb
	cp (hl)			;8bbc
	or e			;8bbd
	ld c,l			;8bbe
	nop			;8bbf
	xor e			;8bc0
	or (hl)			;8bc1
	xor l			;8bc2
	cp (hl)			;8bc3
	xor l			;8bc4
	ld c,l			;8bc5
	nop			;8bc6
	xor e			;8bc7
	or (hl)			;8bc8
	xor l			;8bc9
	or b			;8bca
	rst 18h			;8bcb
	ld c,l			;8bcc
	nop			;8bcd
	xor e			;8bce
	or b			;8bcf
	cp h			;8bd0
	cp (hl)			;8bd1
	rst 18h			;8bd2
	dec a			;8bd3
	nop			;8bd4
	xor e			;8bd5
	or b			;8bd6
	cp h			;8bd7
	cp (hl)			;8bd8
	or e			;8bd9
	dec a			;8bda
	nop			;8bdb
	xor e			;8bdc
	or b			;8bdd
	cp h			;8bde
	cp (hl)			;8bdf
	xor l			;8be0
	dec a			;8be1
	nop			;8be2
	xor e			;8be3
	or b			;8be4
	cp h			;8be5
	or b			;8be6
	rst 18h			;8be7
	dec a			;8be8
	nop			;8be9
	xor e			;8bea
	or b			;8beb
	cp e			;8bec
	or b			;8bed
	rst 18h			;8bee
	ld sp,0ab02h		;8bef
	xor d			;8bf2
	or d			;8bf3
	cp l			;8bf4
	cp (hl)			;8bf5
	xor h			;8bf6
	ld (bc),a			;8bf7
	xor d			;8bf8
	or c			;8bf9
	xor e			;8bfa
	cp (hl)			;8bfb
	rst 18h			;8bfc
	ld b,h			;8bfd
	nop			;8bfe
	xor d			;8bff
	or c			;8c00
	xor e			;8c01
	cp (hl)			;8c02
	or e			;8c03
	ld b,h			;8c04
	nop			;8c05
	xor d			;8c06
	or c			;8c07
	xor e			;8c08
	cp (hl)			;8c09
	xor l			;8c0a
	ld b,h			;8c0b
	nop			;8c0c
	xor d			;8c0d
	or c			;8c0e
	xor e			;8c0f
	cp (hl)			;8c10
	xor e			;8c11
	ld b,h			;8c12
	nop			;8c13
	xor d			;8c14
	or c			;8c15
	xor e			;8c16
	or b			;8c17
	rst 18h			;8c18
	ld b,h			;8c19
	nop			;8c1a
	xor d			;8c1b
	xor l			;8c1c
	or c			;8c1d
	cp (hl)			;8c1e
	rst 18h			;8c1f
	ld (hl),002h		;8c20
	xor c			;8c22
	rst 18h			;8c23
	rst 18h			;8c24
	rst 18h			;8c25
	rst 18h			;8c26
	jp m,0a900h		;8c27
	cp (hl)			;8c2a
	cp h			;8c2b
	or (hl)			;8c2c
	cp (hl)			;8c2d
	ld (hl),000h		;8c2e
	xor c			;8c30
	cp (hl)			;8c31
	cp h			;8c32
	or (hl)			;8c33
	or b			;8c34
	ld (hl),000h		;8c35
	xor c			;8c37
	cp (hl)			;8c38
	xor h			;8c39
	or (hl)			;8c3a
	or l			;8c3b
	inc a			;8c3c
	ld (bc),a			;8c3d
	xor c			;8c3e
	cp d			;8c3f
	or c			;8c40
	xor e			;8c41
	cp (hl)			;8c42
	xor l			;8c43
	ld (bc),a			;8c44
	xor c			;8c45
	cp d			;8c46
	xor l			;8c47
	xor e			;8c48
	cp d			;8c49
	jr c,$+2		;8c4a
	xor c			;8c4c
	cp d			;8c4d
	xor e			;8c4e
	cp (hl)			;8c4f
	rst 18h			;8c50
	xor d			;8c51
	ld (bc),a			;8c52
	xor c			;8c53
	cp d			;8c54
	xor e			;8c55
	cp (hl)			;8c56
	xor h			;8c57
	xor d			;8c58
	ld (bc),a			;8c59
	xor c			;8c5a
	or (hl)			;8c5b
	cp d			;8c5c
	xor l			;8c5d
	xor e			;8c5e
	jr c,$+2		;8c5f
	xor b			;8c61
	or b			;8c62
	or a			;8c63
	or b			;8c64
	rst 18h			;8c65
	jr nc,$+2		;8c66
	and a			;8c68
	rst 18h			;8c69
	rst 18h			;8c6a
	rst 18h			;8c6b
	rst 18h			;8c6c
	ld (0a600h),a		;8c6d
	rst 18h			;8c70
	rst 18h			;8c71
	rst 18h			;8c72
	rst 18h			;8c73
	ld (bc),a			;8c74
	dec b			;8c75
	nop			;8c76
	rst 38h			;8c77
	ld hl,(02a2ah)		;8c78
	ld hl,(020aah)		;8c7b
	ld (hl),l			;8c7e
	ld l,(hl)			;8c7f
	ld h,c			;8c80
	and b			;8c81
	jr nz,$+102		;8c82
	ld h,l			;8c84
	ld l,h			;8c85
	and b			;8c86
	jr nz,$+102		;8c87
	ld h,l			;8c89
	jr nz,$-18		;8c8a
	jr nz,$+34		;8c8c
	jr nz,$+34		;8c8e
	and b			;8c90
	jr nz,$+103		;8c91
	ld (hl),e			;8c93
	ld (hl),h			;8c94
	sub l			;8c95
	jr nz,$+115		;8c96
	ld (hl),l			;8c98
	ld h,l			;8c99
	and b			;8c9a
	ld (hl),h			;8c9b
	ld l,c			;8c9c
	ld h,l			;8c9d
	ld l,(hl)			;8c9e
	push hl			;8c9f
	jr nz,$+101		;8ca0
	ld l,a			;8ca2
	ld l,(hl)			;8ca3
	and b			;8ca4
	ld h,c			;8ca5
	jr nz,$+102		;8ca6
	ld h,l			;8ca8
	and b			;8ca9
	ld l,a			;8caa
	jr nz,$+102		;8cab
	ld h,l			;8cad
	and b			;8cae
	dec a			;8caf
	dec a			;8cb0
	dec a			;8cb1
	dec a			;8cb2
	cp l			;8cb3
	jr nz,$+110		;8cb4
	ld h,c			;8cb6
	and b			;8cb7
	jr nz,$+103		;8cb8
	ld l,h			;8cba
	and b			;8cbb
	jr nz,$+102		;8cbc
	ld h,l			;8cbe
	and b			;8cbf
	jr nz,$+119		;8cc0
	ld l,(hl)			;8cc2
	and b			;8cc3
	ld h,l			;8cc4
	ld l,(hl)			;8cc5
	ld (hl),h			;8cc6
	push hl			;8cc7
	ld h,c			;8cc8
	ld (hl),e			;8cc9
	and b			;8cca
	ld h,l			;8ccb
	ld (hl),e			;8ccc
	and b			;8ccd
	ld h,c			;8cce
	ld h,h			;8ccf
	pop hl			;8cd0
	jr nz,$+103		;8cd1
	xor 061h		;8cd3
	ld h,h			;8cd5
	rst 28h			;8cd6
	ld l,a			;8cd7
	ld (hl),e			;8cd8
	and b			;8cd9
	ld h,l			;8cda
	ld (hl),e			;8cdb
	call p,06e65h		;8cdc
	call p,07320h		;8cdf
	push hl			;8ce2
	ld h,c			;8ce3
	and b			;8ce4
	ld l,a			;8ce5
	and b			;8ce6
	ld h,l			;8ce7
	jp p,0ee61h		;8ce8
	ld h,l			;8ceb
	and b			;8cec
	ld h,c			;8ced
	jp p,0f26fh		;8cee
	ld h,c			;8cf1
	call pe,0f365h		;8cf2
	ld l,a			;8cf5
	xor 063h		;8cf6
	jp (hl)			;8cf8
	ld h,l			;8cf9
	xor 061h		;8cfa
	di			;8cfc
	ld l,a			;8cfd
	di			;8cfe
	ld (hl),l			;8cff
	push hl			;8d00
	ld l,c			;8d01
	xor 079h		;8d02
	and b			;8d04
	ld l,a			;8d05
	call pe,0e572h		;8d06
	ld (hl),l			;8d09
	jp p,0a06ch		;8d0a
	ld (hl),l			;8d0d
	xor 069h		;8d0e
	call po,0e361h		;8d10
	ld l,c			;8d13
	ex (sp),hl			;8d14
	ld (hl),e			;8d15
	call p,0f020h		;8d16
	ld l,h			;8d19
	call pe,0e564h		;8d1a
	ld h,c			;8d1d
	rrd		;8d1e
	jp p,0a073h		;8d20
	ld h,c			;8d23
	call po,0ec70h		;8d24
	jr $-16		;8d27
	ld h,c			;8d29
	xor (hl)			;8d2a
	ld (hl),e			;8d2b
	push af			;8d2c
	inc l			;8d2d
	and b			;8d2e
	ld (hl),l			;8d2f
	out (c),h		;8d30
	jp po,0e964h		;8d32
	ld (hl),h			;8d35
	jp p,0e320h		;8d36
	ld h,c			;8d39
	call p,0ae6fh		;8d3a
	ld (hl),h			;8d3d
	push hl			;8d3e
	ld h,a			;8d3f
	push af			;8d40
	ld (hl),l			;8d41
	call pe,0ed6fh		;8d42
	ld l,b			;8d45
	pop hl			;8d46
	ld l,c			;8d47
	call p,0ee20h		;8d48
	ld l,c			;8d4b
	call pe,0f571h		;8d4c
	ld h,l			;8d4f
	call po,0f269h		;8d50
	ld h,d			;8d53
	jp p,0f665h		;8d54
	ld l,0a0h		;8d57
	ld h,e			;8d59
	ret pe			;8d5a
	ld h,e			;8d5b
	pop hl			;8d5c
	ld h,l			;8d5d
	defb 0edh;next byte illegal after ed		;8d5e
	ld h,l			;8d5f
	call pe,0f46fh		;8d60
	jr nz,$-18		;8d63
	jr nz,$-10		;8d65
	jr nz,$-26		;8d67
	ld h,e			;8d69
	push af			;8d6a
	ld h,(hl)			;8d6b
	jp (hl)			;8d6c
	ld (hl),d			;8d6d
	rst 28h			;8d6e
	ld (hl),e			;8d6f
	ex (sp),hl			;8d70
	ld (hl),d			;8d71
	pop hl			;8d72
	ld (hl),b			;8d73
	jp (hl)			;8d74
	jr nz,$-17		;8d75
	ld l,a			;8d77
	call po,0e976h		;8d78
	ld h,l			;8d7b
	ret m			;8d7c
	ld h,c			;8d7d
	or 075h		;8d7e
	and b			;8d80
	ld (hl),e			;8d81
	jp (hl)			;8d82
	ld a,c			;8d83
	rst 28h			;8d84
	ld b,l			;8d85
	xor 074h		;8d86
	pop hl			;8d88
	ld (hl),h			;8d89
	jp (hl)			;8d8a
	ld l,a			;8d8b
	jp po,0a020h		;8d8c
	ld h,d			;8d8f
	jp (hl)			;8d90
	ld l,h			;8d91
	pop hl			;8d92
	ld h,e			;8d93
	rst 28h			;8d94
	ld l,h			;8d95
	jp (hl)			;8d96
	ld l,c			;8d97
	jp po,0e820h		;8d98
	ld (hl),b			;8d9b
	push hl			;8d9c
	ld (hl),l			;8d9d
	di			;8d9e
	ld h,l			;8d9f
	jp pe,0f266h		;8da0
	jr nz,$-5		;8da3
	ld h,(hl)			;8da5
	call pe,0f215h		;8da6
	jr nz,$-11		;8da9
	jr $-18		;8dab
	ld h,h			;8dad
	rst 28h			;8dae
	push af			;8daf
	xor e			;8db0
	sbc a,(hl)			;8db1
	sub d			;8db2
	sbc a,l			;8db3
	sub (hl)			;8db4
	jp (hl)			;8db5
	sub c			;8db6
	rst 18h			;8db7
	adc a,a			;8db8
	adc a,d			;8db9
	sbc a,d			;8dba
	sbc a,e			;8dbb
	sbc a,d			;8dbc
	adc a,h			;8dbd
	rst 18h			;8dbe
	adc a,c			;8dbf
	sbc a,d			;8dc0
	adc a,l			;8dc1
	rst 18h			;8dc2
	push af			;8dc3
	push af			;8dc4
	sub (hl)			;8dc5
	adc a,l			;8dc6
	rst 18h			;8dc7
	sbc a,(hl)			;8dc8
	sub e			;8dc9
	rst 18h			;8dca
	push af			;8dcb
	defb 0ddh,0f5h,0f5h	;illegal sequence		;8dcc
	or c			;8dcf
	sub b			;8dd0
	rst 18h			;8dd1
	sbc a,d			;8dd2
	adc a,h			;8dd3
	rst 18h			;8dd4
	sub c			;8dd5
	sbc a,d			;8dd6
	sbc a,h			;8dd7
	sbc a,d			;8dd8
	adc a,h			;8dd9
	sbc a,(hl)			;8dda
	adc a,l			;8ddb
	sub (hl)			;8ddc
	sub b			;8ddd
	rst 18h			;8dde
	sbc a,d			;8ddf
	sub c			;8de0
	rst 18h			;8de1
	sbc a,d			;8de2
	adc a,h			;8de3
	adc a,e			;8de4
	sbc a,(hl)			;8de5
	rst 18h			;8de6
	sbc a,(hl)			;8de7
	adc a,c			;8de8
	sbc a,d			;8de9
	sub c			;8dea
	adc a,e			;8deb
	adc a,d			;8dec
	adc a,l			;8ded
	sbc a,(hl)			;8dee
	pop de			;8def
	jp p,0b1f5h		;8df0
	sub b			;8df3
	rst 18h			;8df4
	adc a,a			;8df5
	adc a,d			;8df6
	sbc a,d			;8df7
	sbc a,e			;8df8
	sbc a,d			;8df9
	adc a,h			;8dfa
	rst 18h			;8dfb
	push af			;8dfc
	or c			;8dfd
	sub b			;8dfe
	rst 18h			;8dff
	adc a,a			;8e00
	adc a,d			;8e01
	sbc a,d			;8e02
	sbc a,e			;8e03
	sbc a,d			;8e04
	adc a,h			;8e05
	rst 18h			;8e06
	sub a			;8e07
	sbc a,(hl)			;8e08
	sbc a,h			;8e09
	sbc a,d			;8e0a
	adc a,l			;8e0b
	sub e			;8e0c
	sub b			;8e0d
	pop de			;8e0e
	jp p,0abf5h		;8e0f
	sub (hl)			;8e12
	sbc a,d			;8e13
	sub c			;8e14
	sbc a,d			;8e15
	adc a,h			;8e16
	rst 18h			;8e17
	push af			;8e18
	or c			;8e19
	sub b			;8e1a
	rst 18h			;8e1b
	adc a,e			;8e1c
	sub (hl)			;8e1d
	sbc a,d			;8e1e
	sub c			;8e1f
	sbc a,d			;8e20
	adc a,h			;8e21
	rst 18h			;8e22
	sub c			;8e23
	sbc a,(hl)			;8e24
	sbc a,e			;8e25
	sbc a,(hl)			;8e26
	pop de			;8e27
	jp p,0abf5h		;8e28
	sub (hl)			;8e2b
	sbc a,d			;8e2c
	sub c			;8e2d
	sbc a,d			;8e2e
	adc a,h			;8e2f
	rst 18h			;8e30
	adc a,a			;8e31
	adc a,d			;8e32
	sbc a,d			;8e33
	adc a,h			;8e34
	adc a,e			;8e35
	sub b			;8e36
	rst 18h			;8e37
	push af			;8e38
	ret nz			;8e39
	rst 18h			;8e3a
	rst 10h			;8e3b
	xor h			;8e3c
	sub (hl)			;8e3d
	ret nc			;8e3e
	or c			;8e3f
	sub b			;8e40
	sub 0f5h		;8e41
	jp p,0b3edh		;8e43
	sub b			;8e46
	rst 18h			;8e47
	sub (hl)			;8e48
	sub c			;8e49
	adc a,e			;8e4a
	sbc a,d			;8e4b
	sub c			;8e4c
	adc a,e			;8e4d
	sbc a,(hl)			;8e4e
	adc a,h			;8e4f
	rst 18h			;8e50
	sub b			;8e51
	adc a,e			;8e52
	adc a,l			;8e53
	sbc a,(hl)			;8e54
	rst 18h			;8e55
	adc a,c			;8e56
	sbc a,d			;8e57
	add a,l			;8e58
	ret nz			;8e59
	rst 18h			;8e5a
	rst 10h			;8e5b
	xor h			;8e5c
	sub (hl)			;8e5d
	ret nc			;8e5e
	or c			;8e5f
	sub b			;8e60
	sub 0f5h		;8e61
	push af			;8e63
	xor c			;8e64
	sbc a,(hl)			;8e65
	sub e			;8e66
	sbc a,d			;8e67
	pop de			;8e68
	jp p,0f5f5h		;8e69
	xor e			;8e6c
	adc a,d			;8e6d
	adc a,l			;8e6e
	sub c			;8e6f
	sub b			;8e70
	push bc			;8e71
	rst 18h			;8e72
	push af			;8e73
	indr		;8e74
	adc a,h			;8e76
	adc a,e			;8e77
	jp pe,0df8ch		;8e78
	adc a,h			;8e7b
	sbc a,d			;8e7c
	sbc a,b			;8e7d
	adc a,d			;8e7e
	adc a,l			;8e7f
	sub b			;8e80
	push af			;8e81
	cp l			;8e82
	sbc a,d			;8e83
	sbc a,l			;8e84
	sbc a,d			;8e85
	adc a,h			;8e86
	rst 18h			;8e87
	adc a,d			;8e88
	sub c			;8e89
	rst 18h			;8e8a
	adc a,e			;8e8b
	adc a,l			;8e8c
	sbc a,(hl)			;8e8d
	sbc a,b			;8e8e
	sub b			;8e8f
	rst 18h			;8e90
	sbc a,e			;8e91
	sbc a,d			;8e92
	rst 18h			;8e93
	and b			;8e94
	pop de			;8e95
	jp p,0eef5h		;8e96
	or a			;8e99
	sub b			;8e9a
	sub d			;8e9b
	sbc a,l			;8e9c
	adc a,l			;8e9d
	sbc a,d			;8e9e
	sbc a,0dfh		;8e9f
	xor h			;8ea1
	rst 20h			;8ea2
	sub e			;8ea3
	sub b			;8ea4
	rst 18h			;8ea5
	sbc a,h			;8ea6
	sub b			;8ea7
	sub c			;8ea8
	rst 18h			;8ea9
	adc a,e			;8eaa
	adc a,d			;8eab
	adc a,h			;8eac
	rst 18h			;8ead
	sub d			;8eae
	sbc a,(hl)			;8eaf
	sub c			;8eb0
	sub b			;8eb1
	adc a,h			;8eb2
	out (0dfh),a		;8eb3
	sub c			;8eb5
	sub (hl)			;8eb6
	rst 18h			;8eb7
	sub a			;8eb8
	sbc a,(hl)			;8eb9
	sbc a,l			;8eba
	sub e			;8ebb
	sbc a,(hl)			;8ebc
	adc a,l			;8ebd
	pop de			;8ebe
	jp p,0b2f5h		;8ebf
	adc a,d			;8ec2
	sbc a,d			;8ec3
	adc a,l			;8ec4
	sbc a,d			;8ec5
	adc a,h			;8ec6
	rst 18h			;8ec7
	sbc a,d			;8ec8
	sub c			;8ec9
	adc a,c			;8eca
	sbc a,d			;8ecb
	sub c			;8ecc
	sbc a,d			;8ecd
	sub c			;8ece
	sbc a,(hl)			;8ecf
	sbc a,e			;8ed0
	sub b			;8ed1
	pop de			;8ed2
	jp p,0f5f5h		;8ed3
	or c			;8ed6
	sub b			;8ed7
	rst 18h			;8ed8
	sub e			;8ed9
	sub b			;8eda
	rst 18h			;8edb
	sub e			;8edc
	sub e			;8edd
	sbc a,d			;8ede
	adc a,c			;8edf
	sbc a,(hl)			;8ee0
	adc a,h			;8ee1
	rst 18h			;8ee2
	adc a,a			;8ee3
	adc a,d			;8ee4
	sbc a,d			;8ee5
	adc a,h			;8ee6
	adc a,e			;8ee7
	sub b			;8ee8
	pop de			;8ee9
	jp p,0b1f5h		;8eea
	sub b			;8eed
	rst 18h			;8eee
	adc a,a			;8eef
	adc a,d			;8ef0
	sbc a,d			;8ef1
	sbc a,e			;8ef2
	sbc a,d			;8ef3
	adc a,h			;8ef4
	pop de			;8ef5
	rst 18h			;8ef6
	or e			;8ef7
	sub e			;8ef8
	sbc a,d			;8ef9
	adc a,c			;8efa
	sbc a,(hl)			;8efb
	adc a,h			;8efc
	rst 18h			;8efd
	and b			;8efe
	pop de			;8eff
	jp p,0a6f5h		;8f00
	sbc a,(hl)			;8f03
	rst 18h			;8f04
	adc a,e			;8f05
	sub (hl)			;8f06
	sbc a,d			;8f07
	sub c			;8f08
	sbc a,d			;8f09
	adc a,h			;8f0a
	rst 18h			;8f0b
	and b			;8f0c
	pop de			;8f0d
	jp p,0eef5h		;8f0e
	or c			;8f11
	sub b			;8f12
	rst 18h			;8f13
	sbc a,d			;8f14
	adc a,h			;8f15
	adc a,e			;8f16
	jp pe,09edfh		;8f17
	rst 18h			;8f1a
	adc a,e			;8f1b
	adc a,d			;8f1c
	rst 18h			;8f1d
	sbc a,(hl)			;8f1e
	sub e			;8f1f
	sbc a,h			;8f20
	sbc a,(hl)			;8f21
	sub c			;8f22
	sbc a,h			;8f23
	sbc a,d			;8f24
	sbc a,0f2h		;8f25
	push af			;8f27
	or e			;8f28
	sub e			;8f29
	sbc a,d			;8f2a
	adc a,c			;8f2b
	sbc a,(hl)			;8f2c
	adc a,h			;8f2d
	rst 18h			;8f2e
	adc a,e			;8f2f
	sbc a,(hl)			;8f30
	sub c			;8f31
	adc a,e			;8f32
	sbc a,(hl)			;8f33
	adc a,h			;8f34
	rst 18h			;8f35
	sbc a,h			;8f36
	sub b			;8f37
	adc a,h			;8f38
	sbc a,(hl)			;8f39
	adc a,h			;8f3a
	rst 18h			;8f3b
	adc a,(hl)			;8f3c
	adc a,d			;8f3d
	sbc a,d			;8f3e
	rst 18h			;8f3f
	and b			;8f40
	rst 18h			;8f41
	adc a,h			;8f42
	sbc a,d			;8f43
	rst 18h			;8f44
	adc a,e			;8f45
	sbc a,d			;8f46
	rst 18h			;8f47
	sbc a,d			;8f48
	adc a,h			;8f49
	sbc a,h			;8f4a
	sbc a,(hl)			;8f4b
	adc a,a			;8f4c
	sbc a,(hl)			;8f4d
	rst 18h			;8f4e
	sbc a,e			;8f4f
	sbc a,d			;8f50
	rst 18h			;8f51
	sub e			;8f52
	sbc a,(hl)			;8f53
	adc a,h			;8f54
	rst 18h			;8f55
	sub d			;8f56
	sbc a,(hl)			;8f57
	sub c			;8f58
	sub b			;8f59
	adc a,h			;8f5a
	pop de			;8f5b
	jp p,0aff5h		;8f5c
	sbc a,d			;8f5f
	adc a,l			;8f60
	sub b			;8f61
	pop de			;8f62
	pop de			;8f63
	pop de			;8f64
	rst 18h			;8f65
	xor 08ch		;8f66
	sub (hl)			;8f68
	rst 18h			;8f69
	sub c			;8f6a
	sub b			;8f6b
	rst 18h			;8f6c
	sub e			;8f6d
	sub b			;8f6e
	rst 18h			;8f6f
	adc a,e			;8f70
	sub (hl)			;8f71
	sbc a,d			;8f72
	sub c			;8f73
	sbc a,d			;8f74
	adc a,h			;8f75
	sbc a,0f2h		;8f76
	push af			;8f78
	and (hl)			;8f79
	sbc a,(hl)			;8f7a
	rst 18h			;8f7b
	sub e			;8f7c
	sub e			;8f7d
	sbc a,d			;8f7e
	adc a,c			;8f7f
	sbc a,(hl)			;8f80
	adc a,h			;8f81
	rst 18h			;8f82
	and b			;8f83
	pop de			;8f84
	jp p,0acf5h		;8f85
	push af			;8f88
	or c			;8f89
	push af			;8f8a
	sub d			;8f8b
	jp pe,0d18ch		;8f8c
	pop de			;8f8f
	pop de			;8f90
	push af			;8f91
	jp p,0dfc1h		;8f92
	push af			;8f95
	push af			;8f96
	cp d			;8f97
	sub e			;8f98
	rst 18h			;8f99
	adc a,e			;8f9a
	sub (hl)			;8f9b
	sbc a,d			;8f9c
	sub d			;8f9d
	adc a,a			;8f9e
	sub b			;8f9f
	rst 18h			;8fa0
	adc a,a			;8fa1
	sbc a,(hl)			;8fa2
	adc a,h			;8fa3
	sbc a,(hl)			;8fa4
	pop de			;8fa5
	pop de			;8fa6
	pop de			;8fa7
	jp p,0bcf5h		;8fa8
	sub b			;8fab
	sbc a,b			;8fac
	sbc a,d			;8fad
	adc a,h			;8fae
	rst 18h			;8faf
	and b			;8fb0
	pop de			;8fb1
	jp p,0abf5h		;8fb2
	sbc a,d			;8fb5
	rst 18h			;8fb6
	adc a,a			;8fb7
	sub b			;8fb8
	sub c			;8fb9
	sbc a,d			;8fba
	adc a,h			;8fbb
	rst 18h			;8fbc
	and b			;8fbd
	pop de			;8fbe
	jp p,0abf5h		;8fbf
	sbc a,d			;8fc2
	rst 18h			;8fc3
	adc a,(hl)			;8fc4
	adc a,d			;8fc5
	sub (hl)			;8fc6
	adc a,e			;8fc7
	sbc a,(hl)			;8fc8
	adc a,h			;8fc9
	rst 18h			;8fca
	and b			;8fcb
	pop de			;8fcc
	jp p,0bbf5h		;8fcd
	sbc a,d			;8fd0
	sub l			;8fd1
	sbc a,(hl)			;8fd2
	adc a,h			;8fd3
	rst 18h			;8fd4
	and b			;8fd5
	pop de			;8fd6
	jp p,0b1f5h		;8fd7
	sub b			;8fda
	rst 18h			;8fdb
	adc a,a			;8fdc
	adc a,d			;8fdd
	sbc a,d			;8fde
	sbc a,e			;8fdf
	sbc a,d			;8fe0
	adc a,h			;8fe1
	rst 18h			;8fe2
	adc a,a			;8fe3
	sub b			;8fe4
	sub c			;8fe5
	sbc a,d			;8fe6
	adc a,l			;8fe7
	adc a,e			;8fe8
	sbc a,d			;8fe9
	rst 18h			;8fea
	and b			;8feb
	pop de			;8fec
	jp p,0b1f5h		;8fed
	sub b			;8ff0
	rst 18h			;8ff1
	adc a,a			;8ff2
	adc a,d			;8ff3
	sbc a,d			;8ff4
	sbc a,e			;8ff5
	sbc a,d			;8ff6
	adc a,h			;8ff7
	rst 18h			;8ff8
	adc a,(hl)			;8ff9
	adc a,d			;8ffa
	sub (hl)			;8ffb
	adc a,e			;8ffc
	sbc a,(hl)			;8ffd
	adc a,l			;8ffe
	adc a,e			;8fff
	sbc a,d			;9000
	rst 18h			;9001
	and b			;9002
	pop de			;9003
	jp p,0b1f5h		;9004
	sub b			;9007
	rst 18h			;9008
	adc a,a			;9009
	adc a,d			;900a
	sbc a,d			;900b
	sbc a,e			;900c
	sbc a,d			;900d
	adc a,h			;900e
	rst 18h			;900f
	adc a,(hl)			;9010
	adc a,d			;9011
	sub (hl)			;9012
	adc a,e			;9013
	sbc a,(hl)			;9014
	adc a,l			;9015
	adc a,e			;9016
	sbc a,d			;9017
	rst 18h			;9018
	and b			;9019
	out (0dfh),a		;901a
	adc a,a			;901c
	sub b			;901d
	adc a,l			;901e
	adc a,(hl)			;901f
	adc a,d			;9020
	sbc a,d			;9021
	rst 18h			;9022
	adc a,e			;9023
	sub (hl)			;9024
	sbc a,d			;9025
	sub c			;9026
	sbc a,d			;9027
	adc a,h			;9028
	rst 18h			;9029
	sub e			;902a
	sbc a,(hl)			;902b
	adc a,h			;902c
	rst 18h			;902d
	sub d			;902e
	sbc a,(hl)			;902f
	sub c			;9030
	sub b			;9031
	adc a,h			;9032
	rst 18h			;9033
	sub e			;9034
	sub e			;9035
	sbc a,d			;9036
	sub c			;9037
	sbc a,(hl)			;9038
	adc a,h			;9039
	pop de			;903a
	jp p,0bff5h		;903b
	rst 18h			;903e
	adc a,a			;903f
	sbc a,d			;9040
	adc a,h			;9041
	sbc a,(hl)			;9042
	rst 18h			;9043
	sbc a,e			;9044
	sbc a,d			;9045
	sub d			;9046
	sbc a,(hl)			;9047
	adc a,h			;9048
	sub (hl)			;9049
	sbc a,(hl)			;904a
	sbc a,e			;904b
	sub b			;904c
	rst 18h			;904d
	add a,(hl)			;904e
	rst 18h			;904f
	adc a,h			;9050
	sbc a,d			;9051
	rst 18h			;9052
	adc a,e			;9053
	sbc a,d			;9054
	rst 18h			;9055
	sbc a,h			;9056
	sbc a,(hl)			;9057
	sbc a,d			;9058
	pop de			;9059
	jp p,0aff5h		;905a
	sub b			;905d
	sub c			;905e
	sbc a,d			;905f
	adc a,h			;9060
	rst 18h			;9061
	and b			;9062
	rst 18h			;9063
	sbc a,d			;9064
	sub c			;9065
	rst 18h			;9066
	push af			;9067
	cp a			;9068
	rst 18h			;9069
	sub c			;906a
	sub b			;906b
	rst 18h			;906c
	sbc a,d			;906d
	adc a,h			;906e
	adc a,e			;906f
	jp pe,09adfh		;9070
	sub c			;9073
	rst 18h			;9074
	push af			;9075
	out (0dfh),a		;9076
	push af			;9078
	rst 18h			;9079
	add a,(hl)			;907a
	rst 18h			;907b
	push af			;907c
	pop de			;907d
	rst 18h			;907e
	push af			;907f
	or c			;9080
	sub b			;9081
	rst 18h			;9082
	adc a,e			;9083
	sub (hl)			;9084
	sbc a,d			;9085
	sub c			;9086
	sbc a,d			;9087
	adc a,h			;9088
	rst 18h			;9089
	and b			;908a
	pop de			;908b
	jp p,0eef5h		;908c
	or c			;908f
	sub b			;9090
	rst 18h			;9091
	adc a,h			;9092
	sbc a,d			;9093
	sbc a,(hl)			;9094
	adc a,h			;9095
	rst 18h			;9096
	sbc a,l			;9097
	adc a,l			;9098
	adc a,d			;9099
	adc a,e			;909a
	sub b			;909b
	sbc a,0f2h		;909c
	push af			;909e
	pop de			;909f
	jp p,0b1f5h		;90a0
	sub b			;90a3
	rst 18h			;90a4
	sub a			;90a5
	sbc a,(hl)			;90a6
	add a,(hl)			;90a7
	rst 18h			;90a8
	sub c			;90a9
	sbc a,(hl)			;90aa
	sbc a,e			;90ab
	sbc a,(hl)			;90ac
	rst 18h			;90ad
	sbc a,e			;90ae
	sbc a,d			;90af
	rst 18h			;90b0
	sbc a,d			;90b1
	adc a,h			;90b2
	sub b			;90b3
	rst 18h			;90b4
	sbc a,d			;90b5
	sub c			;90b6
	rst 18h			;90b7
	push af			;90b8
	sbc a,(hl)			;90b9
	sub (hl)			;90ba
	adc a,l			;90bb
	sbc a,d			;90bc
	pop de			;90bd
	jp p,0bcf5h		;90be
	push af			;90c1
	cp e			;90c2
	push af			;90c3
	push af			;90c4
	cp d			;90c5
	adc a,l			;90c6
	adc a,l			;90c7
	sub b			;90c8
	adc a,l			;90c9
	pop de			;90ca
	jp p,0f5f5h		;90cb
	or c			;90ce
	sub b			;90cf
	sub d			;90d0
	sbc a,l			;90d1
	adc a,l			;90d2
	sbc a,d			;90d3
	rst 18h			;90d4
	sbc a,d			;90d5
	adc a,l			;90d6
	adc a,l			;90d7
	rst 20h			;90d8
	sub c			;90d9
	sbc a,d			;90da
	sub b			;90db
	pop de			;90dc
	jp p,0b1f5h		;90dd
	sub b			;90e0
	sub d			;90e1
	sbc a,l			;90e2
	adc a,l			;90e3
	sbc a,d			;90e4
	rst 18h			;90e5
	sbc a,e			;90e6
	sbc a,d			;90e7
	sub e			;90e8
	rst 18h			;90e9
	sbc a,c			;90ea
	sub (hl)			;90eb
	sbc a,h			;90ec
	sub a			;90ed
	sbc a,d			;90ee
	adc a,l			;90ef
	sub b			;90f0
	push bc			;90f1
	push af			;90f2
	xor a			;90f3
	adc a,l			;90f4
	sbc a,d			;90f5
	adc a,a			;90f6
	sbc a,(hl)			;90f7
	adc a,l			;90f8
	sbc a,(hl)			;90f9
	rst 18h			;90fa
	sub e			;90fb
	sbc a,(hl)			;90fc
	rst 18h			;90fd
	sbc a,h			;90fe
	sub (hl)			;90ff
	sub c			;9100
	adc a,e			;9101
	sbc a,(hl)			;9102
	pop de			;9103
	pop de			;9104
	pop de			;9105
	jp p,0edf5h		;9106
	cp h			;9109
	sub (hl)			;910a
	sub c			;910b
	adc a,e			;910c
	sbc a,(hl)			;910d
	rst 18h			;910e
	sub b			;910f
	rst 18h			;9110
	cp e			;9111
	sub (hl)			;9112
	adc a,h			;9113
	sbc a,h			;9114
	sub b			;9115
	ret nz			;9116
	rst 18h			;9117
	rst 10h			;9118
	cp h			;9119
	ret nc			;911a
	cp e			;911b
	sub 0f5h		;911c
	sub c			;911e
	push af			;911f
	rst 18h			;9120
	and b			;9121
	pop de			;9122
	push af			;9123
	pop de			;9124
	push af			;9125
	cp d			;9126
	adc a,h			;9127
	adc a,e			;9128
	jp pe,0df8ch		;9129
	sub a			;912c
	sbc a,(hl)			;912d
	sbc a,l			;912e
	sub e			;912f
	sbc a,(hl)			;9130
	sub c			;9131
	sbc a,e			;9132
	sub b			;9133
	rst 18h			;9134
	adc a,h			;9135
	sub b			;9136
	sub e			;9137
	sub b			;9138
	pop de			;9139
	jp p,08cf5h		;913a
	push af			;913d
	defb 0ddh,0d1h,0f5h	;illegal sequence		;913e
	defb 0ddh,0d1h,0f2h	;illegal sequence		;9141
	push af			;9144
	xor a			;9145
	sbc a,d			;9146
	adc a,l			;9147
	sub b			;9148
	pop de			;9149
	pop de			;914a
	pop de			;914b
	rst 18h			;914c
	adc a,h			;914d
	sub (hl)			;914e
	rst 18h			;914f
	sub c			;9150
	sub b			;9151
	rst 18h			;9152
	sbc a,d			;9153
	adc a,h			;9154
	adc a,e			;9155
	jp pe,0f2d1h		;9156
	push af			;9159
	push af			;915a
	push af			;915b
	push af			;915c
	push af			;915d
	cp d			;915e
	adc a,h			;915f
	adc a,e			;9160
	jp pe,089dfh		;9161
	sbc a,(hl)			;9164
	sbc a,h			;9165
	ret pe			;9166
	push af			;9167
	and (hl)			;9168
	sbc a,(hl)			;9169
	rst 18h			;916a
	sub e			;916b
	sub b			;916c
	rst 18h			;916d
	sbc a,d			;916e
	adc a,h			;916f
	adc a,e			;9170
	sbc a,(hl)			;9171
	sbc a,l			;9172
	sbc a,(hl)			;9173
	pop de			;9174
	jp p,0b1f5h		;9175
	sbc a,(hl)			;9178
	sbc a,e			;9179
	sbc a,(hl)			;917a
	rst 18h			;917b
	adc a,(hl)			;917c
	adc a,d			;917d
	sbc a,d			;917e
	rst 18h			;917f
	sbc a,e			;9180
	sbc a,d			;9181
	adc a,h			;9182
	adc a,e			;9183
	sbc a,(hl)			;9184
	sbc a,h			;9185
	sbc a,(hl)			;9186
	adc a,l			;9187
	pop de			;9188
	jp p,0f4f5h		;9189
	cp h			;918c
	sub b			;918d
	sub c			;918e
	sbc a,b			;918f
	adc a,l			;9190
	sbc a,(hl)			;9191
	adc a,e			;9192
	adc a,d			;9193
	sub e			;9194
	sbc a,(hl)			;9195
	adc a,e			;9196
	sub (hl)			;9197
	sub b			;9198
	sub c			;9199
	adc a,h			;919a
	out (0dfh),a		;919b
	add a,(hl)			;919d
	sub b			;919e
	adc a,d			;919f
	rst 18h			;91a0
	sub a			;91a1
	sbc a,(hl)			;91a2
	adc a,c			;91a3
	sbc a,d			;91a4
	rst 18h			;91a5
	sbc a,c			;91a6
	sub b			;91a7
	adc a,d			;91a8
	sub c			;91a9
	sbc a,e			;91aa
	rst 18h			;91ab
	adc a,e			;91ac
	sub a			;91ad
	sbc a,d			;91ae
	rst 18h			;91af
	adc a,h			;91b0
	sbc a,d			;91b1
	sbc a,h			;91b2
	adc a,l			;91b3
	sbc a,d			;91b4
	adc a,e			;91b5
	rst 18h			;91b6
	or h			;91b7
	sub (hl)			;91b8
	sub c			;91b9
	sub h			;91ba
	add a,(hl)			;91bb
	rst 18h			;91bc
	or h			;91bd
	sub (hl)			;91be
	adc a,a			;91bf
	adc a,a			;91c0
	sbc a,d			;91c1
	adc a,l			;91c2
	rst 18h			;91c3
	sub d			;91c4
	sbc a,d			;91c5
	adc a,h			;91c6
	adc a,h			;91c7
	sbc a,(hl)			;91c8
	sbc a,b			;91c9
	sbc a,d			;91ca
	pop de			;91cb
	rst 18h			;91cc
	xor e			;91cd
	sbc a,d			;91ce
	sub e			;91cf
	sub e			;91d0
	rst 18h			;91d1
	add a,(hl)			;91d2
	sub b			;91d3
	adc a,d			;91d4
	adc a,l			;91d5
	rst 18h			;91d6
	sbc a,c			;91d7
	sbc a,(hl)			;91d8
	sub d			;91d9
	sub (hl)			;91da
	sub e			;91db
	add a,(hl)			;91dc
	out (0dfh),a		;91dd
	sbc a,c			;91df
	adc a,l			;91e0
	sub (hl)			;91e1
	sbc a,d			;91e2
	sub c			;91e3
	sbc a,e			;91e4
	adc a,h			;91e5
	rst 18h			;91e6
	sbc a,(hl)			;91e7
	sub c			;91e8
	sbc a,e			;91e9
	rst 18h			;91ea
	sub c			;91eb
	sbc a,d			;91ec
	sub (hl)			;91ed
	sbc a,b			;91ee
	sub a			;91ef
	sbc a,l			;91f0
	sub b			;91f1
	adc a,l			;91f2
	adc a,h			;91f3
	rst 18h			;91f4
	sbc a,(hl)			;91f5
	adc a,e			;91f6
	rst 18h			;91f7
	adc a,0ceh		;91f8
	pop de			;91fa
	rst 18h			;91fb
	cp l			;91fc
	add a,(hl)			;91fd
	rst 18h			;91fe
	adc a,e			;91ff
	sub a			;9200
	sbc a,d			;9201
	rst 18h			;9202
	adc a,b			;9203
	sbc a,(hl)			;9204
	add a,(hl)			;9205
	out (0dfh),a		;9206
	sub a			;9208
	sbc a,(hl)			;9209
	adc a,c			;920a
	sbc a,d			;920b
	rst 18h			;920c
	add a,(hl)			;920d
	sub b			;920e
	adc a,d			;920f
	rst 18h			;9210
	sbc a,d			;9211
	adc a,c			;9212
	sbc a,d			;9213
	adc a,l			;9214
	rst 18h			;9215
	sub d			;9216
	sbc a,(hl)			;9217
	sbc a,e			;9218
	sbc a,d			;9219
	rst 18h			;921a
	sub c			;921b
	sub b			;921c
	sub (hl)			;921d
	adc a,h			;921e
	sbc a,d			;921f
	rst 18h			;9220
	sbc a,(hl)			;9221
	adc a,e			;9222
	rst 18h			;9223
	set 3,a		;9224
	sbc a,(hl)			;9226
	pop de			;9227
	sub d			;9228
	pop de			;9229
	ret nz			;922a
	rst 18h			;922b
	or a			;922c
	sbc a,(hl)			;922d
	adc a,c			;922e
	sbc a,d			;922f
	rst 18h			;9230
	add a,(hl)			;9231
	sub b			;9232
	adc a,d			;9233
	rst 18h			;9234
	sbc a,d			;9235
	adc a,c			;9236
	sbc a,d			;9237
	adc a,l			;9238
	rst 18h			;9239
	adc a,a			;923a
	sub e			;923b
	sbc a,(hl)			;923c
	add a,(hl)			;923d
	sbc a,d			;923e
	sbc a,e			;923f
	rst 18h			;9240
	adc a,e			;9241
	adc a,d			;9242
	sbc a,l			;9243
	adc a,d			;9244
	sub e			;9245
	sbc a,(hl)			;9246
	adc a,l			;9247
	rst 18h			;9248
	sbc a,l			;9249
	sbc a,(hl)			;924a
	sub e			;924b
	sub e			;924c
	adc a,h			;924d
	ret nz			;924e
	rst 18h			;924f
	or a			;9250
	sbc a,(hl)			;9251
	adc a,c			;9252
	sbc a,d			;9253
	rst 18h			;9254
	add a,(hl)			;9255
	sub b			;9256
	adc a,d			;9257
	rst 18h			;9258
	sbc a,d			;9259
	adc a,c			;925a
	sbc a,d			;925b
	adc a,l			;925c
	rst 18h			;925d
	sbc a,e			;925e
	sbc a,(hl)			;925f
	sub c			;9260
	sbc a,h			;9261
	sbc a,d			;9262
	sbc a,e			;9263
	rst 18h			;9264
	adc a,b			;9265
	sub (hl)			;9266
	adc a,e			;9267
	sub a			;9268
	rst 18h			;9269
	adc a,e			;926a
	sub a			;926b
	sbc a,d			;926c
	rst 18h			;926d
	or h			;926e
	sub (hl)			;926f
	sub c			;9270
	sub h			;9271
	add a,(hl)			;9272
	rst 18h			;9273
	or h			;9274
	sub (hl)			;9275
	adc a,a			;9276
	adc a,a			;9277
	sbc a,d			;9278
	adc a,l			;9279
	adc a,h			;927a
	rst 18h			;927b
	sub (hl)			;927c
	sub c			;927d
	rst 18h			;927e
	adc a,e			;927f
	sub a			;9280
	sbc a,d			;9281
	rst 18h			;9282
	adc a,a			;9283
	sbc a,(hl)			;9284
	sub e			;9285
	sbc a,d			;9286
	rst 18h			;9287
	sub d			;9288
	sub b			;9289
	sub b			;928a
	sub c			;928b
	sub e			;928c
	sub (hl)			;928d
	sbc a,b			;928e
	sub a			;928f
	adc a,e			;9290
	ret nz			;9291
	rst 18h			;9292
	or a			;9293
	sbc a,(hl)			;9294
	adc a,c			;9295
	sbc a,d			;9296
	rst 18h			;9297
	add a,(hl)			;9298
	sub b			;9299
	adc a,d			;929a
	rst 18h			;929b
	sbc a,d			;929c
	adc a,c			;929d
	sbc a,d			;929e
	adc a,l			;929f
	rst 18h			;92a0
	sbc a,d			;92a1
	sbc a,(hl)			;92a2
	adc a,e			;92a3
	sbc a,d			;92a4
	sub c			;92a5
	rst 18h			;92a6
	sbc a,(hl)			;92a7
	rst 18h			;92a8
	sub c			;92a9
	sub b			;92aa
	sub b			;92ab
	sbc a,e			;92ac
	sub e			;92ad
	sbc a,d			;92ae
	rst 18h			;92af
	sub b			;92b0
	sub d			;92b1
	sbc a,d			;92b2
	sub e			;92b3
	sbc a,d			;92b4
	adc a,e			;92b5
	adc a,e			;92b6
	sbc a,d			;92b7
	ret nz			;92b8
	rst 18h			;92b9
	or a			;92ba
	sbc a,(hl)			;92bb
	adc a,c			;92bc
	sbc a,d			;92bd
	rst 18h			;92be
	add a,(hl)			;92bf
	sub b			;92c0
	adc a,d			;92c1
	rst 18h			;92c2
	sbc a,d			;92c3
	adc a,c			;92c4
	sbc a,d			;92c5
	adc a,l			;92c6
	rst 18h			;92c7
	sub a			;92c8
	sbc a,(hl)			;92c9
	sbc a,e			;92ca
	rst 18h			;92cb
	sbc a,(hl)			;92cc
	rst 18h			;92cd
	sbc a,e			;92ce
	adc a,l			;92cf
	sbc a,d			;92d0
	sbc a,(hl)			;92d1
	sub d			;92d2
	rst 18h			;92d3
	sub b			;92d4
	adc a,l			;92d5
	rst 18h			;92d6
	adc a,e			;92d7
	adc a,b			;92d8
	sub b			;92d9
	ret nz			;92da
	rst 18h			;92db
	or (hl)			;92dc
	sbc a,c			;92dd
	rst 18h			;92de
	add a,(hl)			;92df
	sub b			;92e0
	adc a,d			;92e1
	rst 18h			;92e2
	sub a			;92e3
	sbc a,(hl)			;92e4
	adc a,c			;92e5
	sbc a,d			;92e6
	rst 18h			;92e7
	adc a,e			;92e8
	sub a			;92e9
	sbc a,d			;92ea
	sub c			;92eb
	rst 18h			;92ec
	add a,(hl)			;92ed
	sub b			;92ee
	adc a,d			;92ef
	rst 18h			;92f0
	adc a,h			;92f1
	adc a,d			;92f2
	adc a,l			;92f3
	sbc a,d			;92f4
	sub e			;92f5
	add a,(hl)			;92f6
	rst 18h			;92f7
	sbc a,(hl)			;92f8
	adc a,l			;92f9
	sbc a,d			;92fa
	rst 18h			;92fb
	or h			;92fc
	sub (hl)			;92fd
	sub c			;92fe
	sub h			;92ff
	add a,(hl)			;9300
	rst 18h			;9301
	sbc a,l			;9302
	adc a,d			;9303
	adc a,e			;9304
	out (0dfh),a		;9305
	sbc a,(hl)			;9307
	adc a,l			;9308
	sbc a,d			;9309
	rst 18h			;930a
	add a,(hl)			;930b
	sub b			;930c
	adc a,d			;930d
	rst 18h			;930e
	sbc a,(hl)			;930f
	rst 18h			;9310
	or h			;9311
	sub (hl)			;9312
	adc a,a			;9313
	adc a,a			;9314
	sbc a,d			;9315
	adc a,l			;9316
	ret nz			;9317
	rst 18h			;9318
	rst 10h			;9319
	sub b			;931a
	adc a,l			;931b
	rst 18h			;931c
	or h			;931d
	sub (hl)			;931e
	adc a,a			;931f
	sbc a,d			;9320
	adc a,l			;9321
	sbc a,d			;9322
	adc a,e			;9323
	adc a,e			;9324
	sbc a,d			;9325
	ret nz			;9326
	sub 0f3h		;9327
	call p,0bbf5h		;9329
	sbc a,d			;932c
	sub c			;932d
	adc a,e			;932e
	adc a,l			;932f
	sub b			;9330
	rst 18h			;9331
	sub a			;9332
	sbc a,(hl)			;9333
	add a,(hl)			;9334
	rst 18h			;9335
	push af			;9336
	cp (hl)			;9337
	sub a			;9338
	sub b			;9339
	adc a,l			;933a
	sbc a,(hl)			;933b
	rst 18h			;933c
	sub e			;933d
	sbc a,(hl)			;933e
	adc a,h			;933f
	rst 18h			;9340
	adc a,h			;9341
	sbc a,(hl)			;9342
	sub e			;9343
	sub (hl)			;9344
	sbc a,e			;9345
	sbc a,(hl)			;9346
	adc a,h			;9347
	rst 18h			;9348
	adc a,h			;9349
	sbc a,d			;934a
	rst 18h			;934b
	sbc a,e			;934c
	sbc a,(hl)			;934d
	adc a,l			;934e
	jp pe,0df91h		;934f
	push af			;9352
	sbc a,h			;9353
	sub b			;9354
	sub c			;9355
	rst 18h			;9356
	sub e			;9357
	sbc a,(hl)			;9358
	rst 18h			;9359
	sbc a,e			;935a
	sbc a,d			;935b
	adc a,h			;935c
	sbc a,h			;935d
	adc a,l			;935e
	sub (hl)			;935f
	adc a,a			;9360
	sbc a,h			;9361
	sub (hl)			;9362
	rst 20h			;9363
	sub c			;9364
	pop de			;9365
	jp p,08cf5h		;9366
	rst 20h			;9369
	sub e			;936a
	sub b			;936b
	rst 18h			;936c
	sbc a,h			;936d
	sub b			;936e
	sub c			;936f
	rst 18h			;9370
	ret c			;9371
	and a			;9372
	ret c			;9373
	pop de			;9374
	jp p,0a9f5h		;9375
	sub (hl)			;9378
	sbc a,d			;9379
	adc a,l			;937a
	adc a,e			;937b
	sbc a,d			;937c
	adc a,h			;937d
	rst 18h			;937e
	adc a,d			;937f
	sub c			;9380
	sbc a,(hl)			;9381
	adc a,h			;9382
	rst 18h			;9383
	sbc a,b			;9384
	sub b			;9385
	adc a,e			;9386
	sbc a,(hl)			;9387
	adc a,h			;9388
	rst 18h			;9389
	sbc a,e			;938a
	sbc a,d			;938b
	rst 18h			;938c
	push af			;938d
	or c			;938e
	sub b			;938f
	rst 18h			;9390
	adc a,e			;9391
	sbc a,d			;9392
	rst 18h			;9393
	adc a,(hl)			;9394
	adc a,d			;9395
	sbc a,d			;9396
	sbc a,e			;9397
	sbc a,(hl)			;9398
	rst 18h			;9399
	push af			;939a
	push af			;939b
	sbc a,e			;939c
	sub (hl)			;939d
	adc a,h			;939e
	sub b			;939f
	sub e			;93a0
	adc a,c			;93a1
	sbc a,d			;93a2
	sub c			;93a3
	adc a,e			;93a4
	sbc a,d			;93a5
	push af			;93a6
	rst 18h			;93a7
	adc a,(hl)			;93a8
	adc a,d			;93a9
	sbc a,d			;93aa
	rst 18h			;93ab
	sub (hl)			;93ac
	sub c			;93ad
	sub d			;93ae
	sbc a,d			;93af
	sbc a,e			;93b0
	sub (hl)			;93b1
	sbc a,(hl)			;93b2
	adc a,e			;93b3
	sbc a,(hl)			;93b4
	sub d			;93b5
	sbc a,d			;93b6
	sub c			;93b7
	adc a,e			;93b8
	sbc a,d			;93b9
	rst 18h			;93ba
	adc a,h			;93bb
	sbc a,d			;93bc
	rst 18h			;93bd
	adc a,c			;93be
	sub b			;93bf
	sub e			;93c0
	sbc a,(hl)			;93c1
	adc a,e			;93c2
	sub (hl)			;93c3
	sub e			;93c4
	sub (hl)			;93c5
	add a,l			;93c6
	sbc a,(hl)			;93c7
	pop de			;93c8
	jp p,0a9f5h		;93c9
	sub (hl)			;93cc
	sbc a,d			;93cd
	adc a,l			;93ce
	adc a,e			;93cf
	sbc a,d			;93d0
	adc a,h			;93d1
	rst 18h			;93d2
	adc a,e			;93d3
	sub b			;93d4
	sbc a,e			;93d5
	sub b			;93d6
	rst 18h			;93d7
	adc a,h			;93d8
	adc a,d			;93d9
	rst 18h			;93da
	sbc a,h			;93db
	sub b			;93dc
	sub c			;93dd
	adc a,e			;93de
	sbc a,d			;93df
	sub c			;93e0
	sub (hl)			;93e1
	sbc a,e			;93e2
	sub b			;93e3
	out (0f5h),a		;93e4
	push af			;93e6
	push af			;93e7
	push af			;93e8
	push af			;93e9
	cp (hl)			;93ea
	sbc a,l			;93eb
	adc a,l			;93ec
	sbc a,d			;93ed
	adc a,h			;93ee
	rst 18h			;93ef
	and b			;93f0
	pop de			;93f1
	push af			;93f2
	or c			;93f3
	sub b			;93f4
	rst 18h			;93f5
	adc a,a			;93f6
	adc a,d			;93f7
	sbc a,d			;93f8
	sbc a,e			;93f9
	sbc a,d			;93fa
	adc a,h			;93fb
	rst 18h			;93fc
	sub d			;93fd
	sbc a,d			;93fe
	adc a,e			;93ff
	sbc a,d			;9400
	adc a,l			;9401
	rst 18h			;9402
	and b			;9403
	rst 18h			;9404
	sbc a,d			;9405
	sub c			;9406
	push af			;9407
	cp h			;9408
	sub (hl)			;9409
	sbc a,d			;940a
	adc a,l			;940b
	adc a,l			;940c
	sbc a,(hl)			;940d
	adc a,h			;940e
	rst 18h			;940f
	and b			;9410
	pop de			;9411
	jp p,0b1f5h		;9412
	sub b			;9415
	rst 18h			;9416
	adc a,a			;9417
	adc a,d			;9418
	sbc a,d			;9419
	sbc a,e			;941a
	sbc a,d			;941b
	adc a,h			;941c
	rst 18h			;941d
	sub d			;941e
	sub b			;941f
	adc a,c			;9420
	sbc a,d			;9421
	adc a,l			;9422
	rst 18h			;9423
	and b			;9424
	pop de			;9425
	jp p,0bff5h		;9426
	rst 18h			;9429
	adc a,h			;942a
	sbc a,d			;942b
	rst 18h			;942c
	adc a,l			;942d
	sbc a,d			;942e
	adc a,h			;942f
	sub (hl)			;9430
	adc a,h			;9431
	adc a,e			;9432
	sbc a,d			;9433
	pop de			;9434
	jp p,0baf5h		;9435
	adc a,h			;9438
	adc a,e			;9439
	jp pe,09cdfh		;943a
	sbc a,d			;943d
	adc a,l			;943e
	adc a,l			;943f
	sbc a,(hl)			;9440
	sbc a,e			;9441
	push af			;9442
	and (hl)			;9443
	sbc a,(hl)			;9444
	rst 18h			;9445
	sub a			;9446
	sbc a,(hl)			;9447
	adc a,h			;9448
	rst 18h			;9449
	sbc a,h			;944a
	sub b			;944b
	sbc a,b			;944c
	sub (hl)			;944d
	sbc a,e			;944e
	sub b			;944f
	pop de			;9450
	jp p,0a0f5h		;9451
	pop de			;9454
	push af			;9455
	and b			;9456
	pop de			;9457
	jp p,09ef5h		;9458
	push af			;945b
	sub b			;945c
	push af			;945d
	cp a			;945e
	rst 18h			;945f
	sbc a,d			;9460
	adc a,h			;9461
	adc a,e			;9462
	jp pe,09cdfh		;9463
	sbc a,d			;9466
	adc a,l			;9467
	adc a,l			;9468
	sbc a,(hl)			;9469
	sbc a,e			;946a
	push af			;946b
	cp a			;946c
	rst 18h			;946d
	sub c			;946e
	sub b			;946f
	rst 18h			;9470
	adc a,h			;9471
	sub (hl)			;9472
	adc a,l			;9473
	adc a,c			;9474
	sbc a,d			;9475
	rst 18h			;9476
	adc a,a			;9477
	sbc a,(hl)			;9478
	adc a,l			;9479
	sbc a,(hl)			;947a
	rst 18h			;947b
	sub e			;947c
	ret pe			;947d
	adc a,(hl)			;947e
	adc a,d			;947f
	sub (hl)			;9480
	sbc a,e			;9481
	sub b			;9482
	adc a,h			;9483
	pop de			;9484
	push af			;9485
	or c			;9486
	sub b			;9487
	rst 18h			;9488
	adc a,a			;9489
	sbc a,(hl)			;948a
	adc a,h			;948b
	sbc a,(hl)			;948c
	rst 18h			;948d
	sub c			;948e
	sbc a,(hl)			;948f
	sbc a,e			;9490
	sbc a,(hl)			;9491
	rst 18h			;9492
	sbc a,d			;9493
	adc a,h			;9494
	adc a,a			;9495
	sbc a,d			;9496
	sbc a,h			;9497
	sub (hl)			;9498
	sbc a,(hl)			;9499
	sub e			;949a
	pop de			;949b
	jp p,0bff5h		;949c
	rst 18h			;949f
	sub c			;94a0
	sub b			;94a1
	rst 18h			;94a2
	adc a,e			;94a3
	sub (hl)			;94a4
	sbc a,d			;94a5
	sub c			;94a6
	sbc a,d			;94a7
	rst 18h			;94a8
	sub c			;94a9
	sbc a,(hl)			;94aa
	sbc a,e			;94ab
	sbc a,(hl)			;94ac
	rst 18h			;94ad
	sub (hl)			;94ae
	sub c			;94af
	adc a,e			;94b0
	sbc a,d			;94b1
	adc a,l			;94b2
	sbc a,d			;94b3
	adc a,h			;94b4
	sbc a,(hl)			;94b5
	sub c			;94b6
	adc a,e			;94b7
	sbc a,d			;94b8
	push af			;94b9
	push af			;94ba
	push af			;94bb
	cp a			;94bc
	rst 18h			;94bd
	sub c			;94be
	sub b			;94bf
	rst 18h			;94c0
	sbc a,h			;94c1
	sbc a,(hl)			;94c2
	sbc a,l			;94c3
	sbc a,d			;94c4
	rst 18h			;94c5
	sbc a,d			;94c6
	sub c			;94c7
	rst 18h			;94c8
	push af			;94c9
	push af			;94ca
	defb 0edh;next byte illegal after ed		;94cb
	cp h			;94cc
	adc a,d			;94cd
	jp pe,0c093h		;94ce
	jp p,0abf5h		;94d1
	sbc a,d			;94d4
	rst 18h			;94d5
	sbc a,e			;94d6
	sub (hl)			;94d7
	sbc a,h			;94d8
	sbc a,d			;94d9
	push bc			;94da
	rst 18h			;94db
	defb 0ddh,0f5h,0bah	;illegal sequence		;94dc
	adc a,h			;94df
	adc a,e			;94e0
	jp pe,09edfh		;94e1
	sbc a,l			;94e4
	sub (hl)			;94e5
	sbc a,d			;94e6
	adc a,l			;94e7
	adc a,e			;94e8
	push af			;94e9
	xor e			;94ea
	sbc a,d			;94eb
	rst 18h			;94ec
	add a,l			;94ed
	sbc a,(hl)			;94ee
	sub d			;94ef
	adc a,a			;94f0
	sbc a,(hl)			;94f1
	adc a,h			;94f2
	rst 18h			;94f3
	and b			;94f4
	pop de			;94f5
	jp p,0eef5h		;94f6
	or (hl)			;94f9
	sbc a,(hl)			;94fa
	sbc a,(hl)			;94fb
	sub a			;94fc
	sbc a,b			;94fd
	sbc a,0dfh		;94fe
	xor c			;9500
	sbc a,(hl)			;9501
	add a,(hl)			;9502
	sbc a,(hl)			;9503
	rst 18h			;9504
	adc a,a			;9505
	sub b			;9506
	adc a,l			;9507
	adc a,(hl)			;9508
	adc a,d			;9509
	sbc a,d			;950a
	adc a,l			;950b
	ret pe			;950c
	sbc a,(hl)			;950d
	pop de			;950e
	jp p,093f5h		;950f
	sbc a,(hl)			;9512
	push af			;9513
	sbc a,d			;9514
	sub e			;9515
	push af			;9516
	sub e			;9517
	sbc a,(hl)			;9518
	adc a,h			;9519
	push af			;951a
	sub e			;951b
	sub b			;951c
	adc a,h			;951d
	push af			;951e
	or e			;951f
	sbc a,(hl)			;9520
	push af			;9521
	cp d			;9522
	sub e			;9523
	push af			;9524
	or e			;9525
	sbc a,(hl)			;9526
	adc a,h			;9527
	push af			;9528
	or e			;9529
	sub b			;952a
	adc a,h			;952b
	push af			;952c
	cp a			;952d
	rst 18h			;952e
	add a,(hl)			;952f
	sbc a,(hl)			;9530
	rst 18h			;9531
	adc a,e			;9532
	sub (hl)			;9533
	sbc a,d			;9534
	sub c			;9535
	sbc a,d			;9536
	rst 18h			;9537
	push af			;9538
	cp a			;9539
	rst 18h			;953a
	add a,(hl)			;953b
	sbc a,(hl)			;953c
	rst 18h			;953d
	sbc a,d			;953e
	adc a,h			;953f
	adc a,e			;9540
	sbc a,(hl)			;9541
	rst 18h			;9542
	sub e			;9543
	sub e			;9544
	sbc a,d			;9545
	sub c			;9546
	push af			;9547
	or e			;9548
	sub e			;9549
	sbc a,d			;954a
	sub c			;954b
	sbc a,(hl)			;954c
	adc a,h			;954d
	rst 18h			;954e
	and b			;954f
	rst 18h			;9550
	sbc a,e			;9551
	sbc a,d			;9552
	adc a,h			;9553
	sbc a,e			;9554
	sbc a,d			;9555
	rst 18h			;9556
	push af			;9557
	xor c			;9558
	sbc a,(hl)			;9559
	sbc a,h			;955a
	ret pe			;955b
	sbc a,(hl)			;955c
	adc a,h			;955d
	rst 18h			;955e
	and b			;955f
	rst 18h			;9560
	sbc a,d			;9561
	sub c			;9562
	rst 18h			;9563
	push af			;9564
	cp a			;9565
	rst 18h			;9566
	sub c			;9567
	sub b			;9568
	rst 18h			;9569
	sbc a,h			;956a
	sub b			;956b
	sub c			;956c
	adc a,e			;956d
	sub (hl)			;956e
	sbc a,d			;956f
	sub c			;9570
	sbc a,d			;9571
	rst 18h			;9572
	sub c			;9573
	sub (hl)			;9574
	sub c			;9575
	sbc a,b			;9576
	and 091h		;9577
	rst 18h			;9579
	sub e			;957a
	ret pe			;957b
	adc a,(hl)			;957c
	adc a,d			;957d
	sub (hl)			;957e
	sbc a,e			;957f
	sub b			;9580
	pop de			;9581
	jp p,0b1f5h		;9582
	sub b			;9585
	rst 18h			;9586
	adc a,a			;9587
	adc a,d			;9588
	sbc a,d			;9589
	sbc a,e			;958a
	sbc a,d			;958b
	adc a,h			;958c
	rst 18h			;958d
	sub e			;958e
	sub e			;958f
	sbc a,d			;9590
	sub c			;9591
	sbc a,(hl)			;9592
	adc a,l			;9593
	rst 18h			;9594
	and b			;9595
	rst 18h			;9596
	sbc a,h			;9597
	sub b			;9598
	sub c			;9599
	rst 18h			;959a
	push af			;959b
	jp (hl)			;959c
	sub e			;959d
	push af			;959e
	sbc a,d			;959f
	sub e			;95a0
	sub e			;95a1
	sbc a,(hl)			;95a2
	push af			;95a3
	rst 18h			;95a4
	sub d			;95a5
	sub (hl)			;95a6
	adc a,h			;95a7
	sub d			;95a8
	push af			;95a9
	defb 0edh;next byte illegal after ed		;95aa
	cp h			;95ab
	sub b			;95ac
	sub c			;95ad
	rst 18h			;95ae
	adc a,(hl)			;95af
	adc a,d			;95b0
	jp (hl)			;95b1
	ret nz			;95b2
	push af			;95b3
	sbc a,d			;95b4
	sub e			;95b5
	rst 18h			;95b6
	adc a,h			;95b7
	adc a,d			;95b8
	sbc a,d			;95b9
	sub e			;95ba
	sub b			;95bb
	pop de			;95bc
	push af			;95bd
	or c			;95be
	sub b			;95bf
	rst 18h			;95c0
	sub a			;95c1
	sbc a,(hl)			;95c2
	add a,(hl)			;95c3
	rst 18h			;95c4
	sub c			;95c5
	sub (hl)			;95c6
	sub c			;95c7
	sbc a,b			;95c8
	adc a,d			;95c9
	sub c			;95ca
	sbc a,(hl)			;95cb
	rst 18h			;95cc
	adc a,h			;95cd
	sbc a,(hl)			;95ce
	sub e			;95cf
	sub (hl)			;95d0
	sbc a,e			;95d1
	sbc a,(hl)			;95d2
	push af			;95d3
	or e			;95d4
	sbc a,(hl)			;95d5
	adc a,h			;95d6
	rst 18h			;95d7
	adc a,h			;95d8
	sbc a,(hl)			;95d9
	sub e			;95da
	sub (hl)			;95db
	sbc a,e			;95dc
	sbc a,(hl)			;95dd
	adc a,h			;95de
	rst 18h			;95df
	adc a,a			;95e0
	sub b			;95e1
	adc a,h			;95e2
	sub (hl)			;95e3
	sbc a,l			;95e4
	sub e			;95e5
	sbc a,d			;95e6
	adc a,h			;95e7
	rst 18h			;95e8
	adc a,h			;95e9
	sub b			;95ea
	sub c			;95eb
	rst 18h			;95ec
	push af			;95ed
	pop de			;95ee
	jp p,0d3f5h		;95ef
	rst 18h			;95f2
	push af			;95f3
	rst 18h			;95f4
	add a,(hl)			;95f5
	rst 18h			;95f6
	push af			;95f7
	or e			;95f8
	sbc a,(hl)			;95f9
	rst 18h			;95fa
	and 091h		;95fb
	sub (hl)			;95fd
	sbc a,h			;95fe
	sbc a,(hl)			;95ff
	rst 18h			;9600
	adc a,h			;9601
	sbc a,(hl)			;9602
	sub e			;9603
	sub (hl)			;9604
	sbc a,e			;9605
	sbc a,(hl)			;9606
	rst 18h			;9607
	sbc a,d			;9608
	adc a,h			;9609
	rst 18h			;960a
	push af			;960b
	or c			;960c
	sub b			;960d
	adc a,l			;960e
	adc a,e			;960f
	sbc a,d			;9610
	push af			;9611
	xor h			;9612
	adc a,d			;9613
	adc a,l			;9614
	push af			;9615
	cp d			;9616
	adc a,h			;9617
	adc a,e			;9618
	sbc a,d			;9619
	push af			;961a
	or b			;961b
	sbc a,d			;961c
	adc a,h			;961d
	adc a,e			;961e
	sbc a,d			;961f
	push af			;9620
	or c			;9621
	sub b			;9622
	adc a,l			;9623
	sbc a,d			;9624
	adc a,h			;9625
	adc a,e			;9626
	sbc a,d			;9627
	push af			;9628
	or c			;9629
	sub b			;962a
	adc a,l			;962b
	sub b			;962c
	sbc a,d			;962d
	adc a,h			;962e
	adc a,e			;962f
	sbc a,d			;9630
	push af			;9631
	xor h			;9632
	adc a,d			;9633
	adc a,l			;9634
	sbc a,d			;9635
	adc a,h			;9636
	adc a,e			;9637
	sbc a,d			;9638
	push af			;9639
	xor h			;963a
	adc a,d			;963b
	adc a,l			;963c
	sub b			;963d
	sbc a,d			;963e
	adc a,h			;963f
	adc a,e			;9640
	sbc a,d			;9641
	push af			;9642
	adc a,h			;9643
	adc a,d			;9644
	sbc a,l			;9645
	sub (hl)			;9646
	adc a,l			;9647
	push af			;9648
	sbc a,l			;9649
	sbc a,(hl)			;964a
	sub l			;964b
	sbc a,(hl)			;964c
	adc a,l			;964d
	push af			;964e
	sbc a,d			;964f
	sub c			;9650
	adc a,e			;9651
	adc a,l			;9652
	sbc a,(hl)			;9653
	adc a,l			;9654
	push af			;9655
	adc a,h			;9656
	sbc a,(hl)			;9657
	sub e			;9658
	sub (hl)			;9659
	adc a,l			;965a
	push af			;965b
	and l			;965c
	sub b			;965d
	sub c			;965e
	sbc a,(hl)			;965f
	rst 18h			;9660
	cp d			;9661
	add a,a			;9662
	adc a,e			;9663
	sbc a,d			;9664
	adc a,l			;9665
	sub (hl)			;9666
	sub b			;9667
	adc a,l			;9668
	push af			;9669
	or d			;966a
	sub (hl)			;966b
	sub e			;966c
	rst 18h			;966d
	cp h			;966e
	sub b			;966f
	sub e			;9670
	adc a,d			;9671
	sub d			;9672
	sub c			;9673
	sbc a,(hl)			;9674
	adc a,h			;9675
	push af			;9676
	and l			;9677
	sub b			;9678
	sub c			;9679
	sbc a,(hl)			;967a
	rst 18h			;967b
	sbc a,h			;967c
	sbc a,d			;967d
	sub c			;967e
	adc a,e			;967f
	adc a,l			;9680
	sbc a,(hl)			;9681
	sub e			;9682
	push af			;9683
	and l			;9684
	sub b			;9685
	sub c			;9686
	sbc a,(hl)			;9687
	rst 18h			;9688
	sbc a,h			;9689
	sub (hl)			;968a
	adc a,c			;968b
	sub (hl)			;968c
	sub e			;968d
	push af			;968e
	xor e			;968f
	sbc a,d			;9690
	sub d			;9691
	adc a,a			;9692
	sub e			;9693
	sub b			;9694
	rst 18h			;9695
	sbc a,e			;9696
	sbc a,d			;9697
	rst 18h			;9698
	sub e			;9699
	sub b			;969a
	adc a,h			;969b
	rst 18h			;969c
	cp b			;969d
	adc a,d			;969e
	sbc a,d			;969f
	adc a,l			;96a0
	adc a,l			;96a1
	sbc a,d			;96a2
	adc a,l			;96a3
	sub b			;96a4
	adc a,h			;96a5
	push af			;96a6
	xor h			;96a7
	sbc a,d			;96a8
	adc a,a			;96a9
	adc a,d			;96aa
	sub e			;96ab
	sbc a,h			;96ac
	adc a,l			;96ad
	sub b			;96ae
	push af			;96af
	cp h			;96b0
	sub a			;96b1
	sub (hl)			;96b2
	sbc a,h			;96b3
	sub a			;96b4
	sbc a,(hl)			;96b5
	sub c			;96b6
	sbc a,h			;96b7
	sub a			;96b8
	sub b			;96b9
	sbc a,l			;96ba
	push af			;96bb
	or b			;96bc
	sbc a,l			;96bd
	adc a,h			;96be
	sbc a,d			;96bf
	adc a,l			;96c0
	adc a,c			;96c1
	sbc a,(hl)			;96c2
	adc a,e			;96c3
	sub b			;96c4
	adc a,l			;96c5
	sub (hl)			;96c6
	sub b			;96c7
	push af			;96c8
	and l			;96c9
	sub b			;96ca
	sub c			;96cb
	sbc a,(hl)			;96cc
	rst 18h			;96cd
	xor h			;96ce
	adc a,d			;96cf
	adc a,l			;96d0
	push af			;96d1
	and l			;96d2
	sub b			;96d3
	sub c			;96d4
	sbc a,(hl)			;96d5
	rst 18h			;96d6
	xor h			;96d7
	sbc a,(hl)			;96d8
	sbc a,b			;96d9
	adc a,l			;96da
	sbc a,(hl)			;96db
	sbc a,e			;96dc
	sbc a,(hl)			;96dd
	push af			;96de
	xor e			;96df
	sbc a,d			;96e0
	sub d			;96e1
	adc a,a			;96e2
	sub e			;96e3
	sub b			;96e4
	rst 18h			;96e5
	sbc a,e			;96e6
	sbc a,d			;96e7
	sub e			;96e8
	rst 18h			;96e9
	or l			;96ea
	sbc a,(hl)			;96eb
	sbc a,b			;96ec
	adc a,d			;96ed
	sbc a,(hl)			;96ee
	adc a,l			;96ef
	push af			;96f0
	cp d			;96f1
	adc a,h			;96f2
	adc a,e			;96f3
	sbc a,(hl)			;96f4
	sbc a,e			;96f5
	sub (hl)			;96f6
	sub b			;96f7
	push af			;96f8
	cp a			;96f9
	rst 18h			;96fa
	adc a,h			;96fb
	sbc a,d			;96fc
	rst 18h			;96fd
	adc a,e			;96fe
	adc a,l			;96ff
	sbc a,(hl)			;9700
	sub c			;9701
	adc a,h			;9702
	sbc a,c			;9703
	sub b			;9704
	adc a,l			;9705
	sub d			;9706
	sbc a,(hl)			;9707
	rst 18h			;9708
	sbc a,d			;9709
	sub c			;970a
	rst 18h			;970b
	push af			;970c
	xor c			;970d
	sbc a,d			;970e
	adc a,h			;970f
	rst 18h			;9710
	adc a,e			;9711
	sub b			;9712
	sbc a,e			;9713
	sub b			;9714
	rst 18h			;9715
	sbc a,e			;9716
	sbc a,d			;9717
	rst 18h			;9718
	sbc a,h			;9719
	sub b			;971a
	sub e			;971b
	sub b			;971c
	adc a,l			;971d
	rst 18h			;971e
	push af			;971f
	sub d			;9720
	sbc a,(hl)			;9721
	adc a,l			;9722
	adc a,l			;9723
	rst 20h			;9724
	sub c			;9725
	push af			;9726
	adc a,l			;9727
	sub b			;9728
	sub l			;9729
	sub b			;972a
	push af			;972b
	sbc a,(hl)			;972c
	add a,l			;972d
	adc a,d			;972e
	sub e			;972f
	push af			;9730
	or a			;9731
	sbc a,d			;9732
	adc a,l			;9733
	sub d			;9734
	sub b			;9735
	adc a,h			;9736
	sbc a,(hl)			;9737
	rst 18h			;9738
	adc a,c			;9739
	sub (hl)			;973a
	adc a,h			;973b
	adc a,e			;973c
	sbc a,(hl)			;973d
	rst 18h			;973e
	push af			;973f
	sbc a,(hl)			;9740
	sub d			;9741
	adc a,a			;9742
	sub e			;9743
	sub (hl)			;9744
	sbc a,(hl)			;9745
	sbc a,e			;9746
	sbc a,(hl)			;9747
	rst 18h			;9748
	push af			;9749
	sbc a,e			;974a
	sbc a,d			;974b
	sub e			;974c
	rst 18h			;974d
	or l			;974e
	adc a,d			;974f
	sbc a,d			;9750
	sbc a,b			;9751
	sub b			;9752
	rst 18h			;9753
	sbc a,e			;9754
	sbc a,d			;9755
	rst 18h			;9756
	xor a			;9757
	sbc a,d			;9758
	sub e			;9759
	sub b			;975a
	adc a,e			;975b
	sbc a,(hl)			;975c
	rst 18h			;975d
	add a,(hl)			;975e
	rst 18h			;975f
	sbc a,d			;9760
	sub e			;9761
	rst 18h			;9762
	or d			;9763
	adc a,d			;9764
	adc a,l			;9765
	sub b			;9766
	push af			;9767
	sbc a,e			;9768
	sbc a,d			;9769
	rst 18h			;976a
	sub e			;976b
	sbc a,(hl)			;976c
	rst 18h			;976d
	sub l			;976e
	adc a,d			;976f
	sub c			;9770
	sbc a,b			;9771
	sub e			;9772
	sbc a,(hl)			;9773
	push af			;9774
	sbc a,e			;9775
	sbc a,d			;9776
	rst 18h			;9777
	sub e			;9778
	sbc a,(hl)			;9779
	rst 18h			;977a
	cp d			;977b
	add a,a			;977c
	adc a,a			;977d
	sub e			;977e
	sbc a,(hl)			;977f
	sub c			;9780
	sbc a,(hl)			;9781
	sbc a,e			;9782
	sbc a,(hl)			;9783
	rst 18h			;9784
	sbc a,e			;9785
	sbc a,d			;9786
	sub e			;9787
	rst 18h			;9788
	or b			;9789
	sbc a,l			;978a
	adc a,h			;978b
	sbc a,d			;978c
	adc a,l			;978d
	adc a,c			;978e
	sbc a,(hl)			;978f
	adc a,e			;9790
	sub b			;9791
	adc a,l			;9792
	sub (hl)			;9793
	sub b			;9794
	push af			;9795
	sbc a,e			;9796
	sbc a,d			;9797
	rst 18h			;9798
	sub e			;9799
	sbc a,(hl)			;979a
	rst 18h			;979b
	sub l			;979c
	adc a,d			;979d
	sub c			;979e
	sbc a,b			;979f
	sub e			;97a0
	sbc a,(hl)			;97a1
	push af			;97a2
	sbc a,e			;97a3
	sbc a,d			;97a4
	sub e			;97a5
	rst 18h			;97a6
	sbc a,h			;97a7
	sbc a,(hl)			;97a8
	adc a,h			;97a9
	adc a,e			;97aa
	sub (hl)			;97ab
	sub e			;97ac
	sub e			;97ad
	sub b			;97ae
	rst 18h			;97af
	sbc a,e			;97b0
	sbc a,d			;97b1
	rst 18h			;97b2
	or h			;97b3
	adc a,d			;97b4
	sub h			;97b5
	adc a,d			;97b6
	sub e			;97b7
	sub h			;97b8
	sbc a,(hl)			;97b9
	sub c			;97ba
	push af			;97bb
	sbc a,e			;97bc
	sbc a,d			;97bd
	rst 18h			;97be
	sub e			;97bf
	sbc a,(hl)			;97c0
	rst 18h			;97c1
	sub l			;97c2
	adc a,d			;97c3
	sub c			;97c4
	sbc a,b			;97c5
	sub e			;97c6
	sbc a,(hl)			;97c7
	push af			;97c8
	sbc a,e			;97c9
	sbc a,d			;97ca
	sub e			;97cb
	rst 18h			;97cc
	cp (hl)			;97cd
	sub h			;97ce
	sbc a,(hl)			;97cf
	sbc a,l			;97d0
	rst 18h			;97d1
	cp e			;97d2
	ret c			;97d3
	add a,l			;97d4
	sub (hl)			;97d5
	sbc a,l			;97d6
	push af			;97d7
	xor 0b1h		;97d8
	sub b			;97da
	rst 18h			;97db
	sub a			;97dc
	sbc a,(hl)			;97dd
	add a,(hl)			;97de
	rst 18h			;97df
	adc a,c			;97e0
	sbc a,d			;97e1
	sub c			;97e2
	adc a,e			;97e3
	sbc a,(hl)			;97e4
	sub c			;97e5
	sbc a,(hl)			;97e6
	sbc a,0f2h		;97e7
	push af			;97e9
	adc a,d			;97ea
	sub c			;97eb
	sbc a,(hl)			;97ec
	rst 18h			;97ed
	adc a,h			;97ee
	sbc a,d			;97ef
	adc a,l			;97f0
	adc a,a			;97f1
	sub (hl)			;97f2
	sbc a,d			;97f3
	sub c			;97f4
	adc a,e			;97f5
	sbc a,d			;97f6
	push af			;97f7
	adc a,d			;97f8
	sub c			;97f9
	rst 18h			;97fa
	jp pe,08a98h		;97fb
	sub (hl)			;97fe
	sub e			;97ff
	sbc a,(hl)			;9800
	push af			;9801
	adc a,d			;9802
	sub c			;9803
	rst 18h			;9804
	sub l			;9805
	sbc a,(hl)			;9806
	sbc a,b			;9807
	adc a,d			;9808
	sbc a,(hl)			;9809
	adc a,l			;980a
	push af			;980b
	adc a,d			;980c
	sub c			;980d
	rst 18h			;980e
	sub d			;980f
	sub b			;9810
	sub c			;9811
	sub b			;9812
	push af			;9813
	adc a,d			;9814
	sub c			;9815
	rst 18h			;9816
	sbc a,h			;9817
	sub b			;9818
	sbc a,h			;9819
	sub b			;981a
	sbc a,e			;981b
	adc a,l			;981c
	sub (hl)			;981d
	sub e			;981e
	sub b			;981f
	push af			;9820
	adc a,d			;9821
	sub c			;9822
	sbc a,(hl)			;9823
	rst 18h			;9824
	sbc a,(hl)			;9825
	adc a,l			;9826
	sbc a,(hl)			;9827
	push hl			;9828
	sbc a,(hl)			;9829
	push af			;982a
	adc a,d			;982b
	sub c			;982c
	rst 18h			;982d
	sbc a,d			;982e
	adc a,h			;982f
	sbc a,h			;9830
	sub b			;9831
	adc a,l			;9832
	adc a,a			;9833
	sub (hl)			;9834
	rst 20h			;9835
	sub c			;9836
	push af			;9837
	adc a,d			;9838
	sub c			;9839
	rst 18h			;983a
	sub e			;983b
	sub b			;983c
	adc a,l			;983d
	sub b			;983e
	push af			;983f
	adc a,d			;9840
	sub c			;9841
	sbc a,(hl)			;9842
	rst 18h			;9843
	sub b			;9844
	adc a,c			;9845
	sbc a,d			;9846
	sub l			;9847
	sub (hl)			;9848
	adc a,e			;9849
	sbc a,(hl)			;984a
	push af			;984b
	adc a,d			;984c
	sub c			;984d
	rst 18h			;984e
	adc a,e			;984f
	sub (hl)			;9850
	sbc a,l			;9851
	adc a,d			;9852
	adc a,l			;9853
	rst 20h			;9854
	sub c			;9855
	push af			;9856
	rst 18h			;9857
	pop de			;9858
	jp nc,0f5dfh		;9859
	cp d			;985c
	adc a,h			;985d
	rst 18h			;985e
	or h			;985f
	adc a,d			;9860
	sub h			;9861
	adc a,d			;9862
	sub e			;9863
	sub h			;9864
	sbc a,(hl)			;9865
	sub c			;9866
	push af			;9867
	cp d			;9868
	adc a,h			;9869
	rst 18h			;986a
	and a			;986b
	sub b			;986c
	sbc a,h			;986d
	sub a			;986e
	sub (hl)			;986f
	add a,(hl)			;9870
	sbc a,(hl)			;9871
	sub b			;9872
	add a,(hl)			;9873
	sub b			;9874
	adc a,e			;9875
	sub e			;9876
	push af			;9877
	cp d			;9878
	adc a,h			;9879
	rst 18h			;987a
	and a			;987b
	sub b			;987c
	sbc a,h			;987d
	sub a			;987e
	sub (hl)			;987f
	adc a,(hl)			;9880
	adc a,d			;9881
	jp (hl)			;9882
	adc a,e			;9883
	add a,l			;9884
	sbc a,(hl)			;9885
	sub e			;9886
	push af			;9887
	cp d			;9888
	adc a,h			;9889
	rst 18h			;988a
	sbc a,d			;988b
	sub e			;988c
	rst 18h			;988d
	sbc a,e			;988e
	sub (hl)			;988f
	sub b			;9890
	adc a,h			;9891
	rst 18h			;9892
	xor e			;9893
	sub e			;9894
	sbc a,(hl)			;9895
	sub e			;9896
	sub b			;9897
	sbc a,h			;9898
	push af			;9899
	xor h			;989a
	sub b			;989b
	sub c			;989c
	rst 18h			;989d
	or c			;989e
	sub b			;989f
	sub h			;98a0
	sub b			;98a1
	sub c			;98a2
	rst 18h			;98a3
	and l			;98a4
	sub (hl)			;98a5
	sbc a,l			;98a6
	sub b			;98a7
	sub e			;98a8
	sbc a,(hl)			;98a9
	sbc a,l			;98aa
	rst 18h			;98ab
	add a,(hl)			;98ac
	rst 18h			;98ad
	cp e			;98ae
	sbc a,(hl)			;98af
	add a,l			;98b0
	sub (hl)			;98b1
	sub c			;98b2
	rst 18h			;98b3
	or e			;98b4
	sub (hl)			;98b5
	sub h			;98b6
	sub b			;98b7
	adc a,l			;98b8
	push af			;98b9
	cp d			;98ba
	adc a,h			;98bb
	rst 18h			;98bc
	or a			;98bd
	adc a,d			;98be
	sub c			;98bf
	sub a			;98c0
	adc a,d			;98c1
	sub c			;98c2
	jp nc,097beh		;98c3
	adc a,a			;98c6
	adc a,d			;98c7
	push af			;98c8
	cp d			;98c9
	adc a,h			;98ca
	rst 18h			;98cb
	cp h			;98cc
	sub b			;98cd
	sbc a,(hl)			;98ce
	adc a,e			;98cf
	sub e			;98d0
	sub (hl)			;98d1
	sbc a,h			;98d2
	adc a,d			;98d3
	sbc a,d			;98d4
	push af			;98d5
	sbc a,e			;98d6
	sub (hl)			;98d7
	sub b			;98d8
	adc a,h			;98d9
	rst 18h			;98da
	sub d			;98db
	sbc a,d			;98dc
	adc a,h			;98dd
	sub b			;98de
	sbc a,(hl)			;98df
	sub d			;98e0
	sbc a,d			;98e1
	adc a,l			;98e2
	sub (hl)			;98e3
	sbc a,h			;98e4
	sbc a,(hl)			;98e5
	sub c			;98e6
	sub b			;98e7
	push af			;98e8
	sub l			;98e9
	sbc a,d			;98ea
	sbc a,c			;98eb
	sbc a,d			;98ec
	rst 18h			;98ed
	sbc a,e			;98ee
	sbc a,d			;98ef
	sub e			;98f0
	rst 18h			;98f1
	cp h			;98f2
	sub e			;98f3
	sbc a,(hl)			;98f4
	sub c			;98f5
	rst 18h			;98f6
	cp (hl)			;98f7
	sbc a,b			;98f8
	adc a,d			;98f9
	sub (hl)			;98fa
	sub e			;98fb
	sbc a,(hl)			;98fc
	push af			;98fd
	sbc a,e			;98fe
	sub (hl)			;98ff
	sub b			;9900
	adc a,h			;9901
	sbc a,(hl)			;9902
	rst 18h			;9903
	sbc a,e			;9904
	sbc a,d			;9905
	rst 18h			;9906
	sub e			;9907
	sbc a,(hl)			;9908
	adc a,h			;9909
	rst 18h			;990a
	sbc a,c			;990b
	sub e			;990c
	sub b			;990d
	adc a,l			;990e
	sbc a,d			;990f
	adc a,h			;9910
	push af			;9911
	adc a,h			;9912
	sbc a,d			;9913
	push hl			;9914
	sub b			;9915
	adc a,l			;9916
	rst 18h			;9917
	sbc a,e			;9918
	sbc a,d			;9919
	rst 18h			;991a
	sub e			;991b
	sbc a,(hl)			;991c
	rst 18h			;991d
	sub e			;991e
	sub e			;991f
	adc a,d			;9920
	adc a,c			;9921
	sub (hl)			;9922
	sbc a,(hl)			;9923
	push af			;9924
	sub e			;9925
	sub b			;9926
	adc a,h			;9927
	rst 18h			;9928
	sub l			;9929
	adc a,d			;992a
	sbc a,d			;992b
	adc a,l			;992c
	sbc a,b			;992d
	adc a,d			;992e
	sub (hl)			;992f
	adc a,h			;9930
	adc a,e			;9931
	sbc a,(hl)			;9932
	adc a,h			;9933
	rst 18h			;9934
	sbc a,l			;9935
	sub b			;9936
	adc a,l			;9937
	adc a,l			;9938
	sbc a,(hl)			;9939
	sbc a,h			;993a
	sub a			;993b
	sub b			;993c
	adc a,h			;993d
	push af			;993e
	sbc a,b			;993f
	adc a,l			;9940
	sbc a,(hl)			;9941
	sub c			;9942
	rst 18h			;9943
	sub l			;9944
	adc a,d			;9945
	sbc a,b			;9946
	sbc a,(hl)			;9947
	sbc a,e			;9948
	sub b			;9949
	adc a,l			;994a
	rst 18h			;994b
	sbc a,e			;994c
	sbc a,d			;994d
	rst 18h			;994e
	xor e			;994f
	sub e			;9950
	sbc a,(hl)			;9951
	sbc a,h			;9952
	sub a			;9953
	adc a,e			;9954
	sub e			;9955
	sub (hl)			;9956
	push af			;9957
	sub e			;9958
	sbc a,(hl)			;9959
	rst 18h			;995a
	or d			;995b
	sbc a,(hl)			;995c
	sbc a,e			;995d
	adc a,l			;995e
	sbc a,d			;995f
	rst 18h			;9960
	or e			;9961
	sub b			;9962
	sbc a,h			;9963
	sbc a,(hl)			;9964
	rst 18h			;9965
	sbc a,e			;9966
	sbc a,d			;9967
	rst 18h			;9968
	sub e			;9969
	sbc a,(hl)			;996a
	adc a,h			;996b
	rst 18h			;996c
	xor h			;996d
	sbc a,d			;996e
	adc a,l			;996f
	adc a,a			;9970
	sub (hl)			;9971
	sbc a,d			;9972
	sub c			;9973
	adc a,e			;9974
	sbc a,d			;9975
	adc a,h			;9976
	push af			;9977
	or b			;9978
	add a,(hl)			;9979
	sbc a,d			;997a
	adc a,h			;997b
	rst 18h			;997c
	adc a,h			;997d
	adc a,d			;997e
	rst 18h			;997f
	adc a,c			;9980
	sub b			;9981
	add a,l			;9982
	push bc			;9983
	rst 18h			;9984
	push af			;9985
	xor a			;9986
	adc a,l			;9987
	or b			;9988
	adc a,l			;9989
	call nz,0c58dh		;998a
	adc a,l			;998d
	call z,0ce8dh		;998e
	adc a,l			;9991
	rst 8			;9992
	adc a,l			;9993
	jp p,0fd8dh		;9994
	adc a,l			;9997
	ld de,0198eh		;9998
	adc a,(hl)			;999b
	ld hl,(0398eh)		;999c
	adc a,(hl)			;999f
	ld b,e			;99a0
	adc a,(hl)			;99a1
	ld h,e			;99a2
	adc a,(hl)			;99a3
	ld h,h			;99a4
	adc a,(hl)			;99a5
	ld l,e			;99a6
	adc a,(hl)			;99a7
	ld l,h			;99a8
	adc a,(hl)			;99a9
	ld (hl),h			;99aa
	adc a,(hl)			;99ab
	add a,d			;99ac
	adc a,(hl)			;99ad
	sbc a,b			;99ae
	adc a,(hl)			;99af
	pop bc			;99b0
	adc a,(hl)			;99b1
	push de			;99b2
	adc a,(hl)			;99b3
	sub 08eh		;99b4
	call pe,0028eh		;99b6
	adc a,a			;99b9
	djnz $-111		;99ba
	jr z,$-111		;99bc
	ld e,(hl)			;99be
	adc a,a			;99bf
	ld a,c			;99c0
	adc a,a			;99c1
	add a,a			;99c2
	adc a,a			;99c3
	adc a,c			;99c4
	adc a,a			;99c5
	adc a,e			;99c6
	adc a,a			;99c7
	sub d			;99c8
	adc a,a			;99c9
	sub (hl)			;99ca
	adc a,a			;99cb
	sub a			;99cc
	adc a,a			;99cd
	xor d			;99ce
	adc a,a			;99cf
	or h			;99d0
	adc a,a			;99d1
	pop bc			;99d2
	adc a,a			;99d3
	rst 8			;99d4
	adc a,a			;99d5
	exx			;99d6
	adc a,a			;99d7
	rst 28h			;99d8
	adc a,a			;99d9
	ld b,090h		;99da
	dec a			;99dc
	sub b			;99dd
	ld e,h			;99de
	sub b			;99df
	ld l,b			;99e0
	sub b			;99e1
	halt			;99e2
	sub b			;99e3
	ld a,c			;99e4
	sub b			;99e5
	ld a,l			;99e6
	sub b			;99e7
	add a,b			;99e8
	sub b			;99e9
	adc a,(hl)			;99ea
	sub b			;99eb
	sbc a,a			;99ec
	sub b			;99ed
	and d			;99ee
	sub b			;99ef
	cp c			;99f0
	sub b			;99f1
	ret nz			;99f2
	sub b			;99f3
	jp nz,0c490h		;99f4
	sub b			;99f7
	push bc			;99f8
	sub b			;99f9
	call 0ce90h		;99fa
	sub b			;99fd
	rst 18h			;99fe
	sub b			;99ff
	di			;9a00
	sub b			;9a01
	ex af,af'			;9a02
	sub c			;9a03
	ld e,091h		;9a04
	jr nz,$-109		;9a06
	inc h			;9a08
	sub c			;9a09
	ld h,091h		;9a0a
	inc a			;9a0c
	sub c			;9a0d
	ld a,091h		;9a0e
	ld b,c			;9a10
	sub c			;9a11
	ld b,l			;9a12
	sub c			;9a13
	ld e,d			;9a14
	sub c			;9a15
	ld e,e			;9a16
	sub c			;9a17
	ld e,h			;9a18
	sub c			;9a19
	ld e,l			;9a1a
	sub c			;9a1b
	ld e,(hl)			;9a1c
	sub c			;9a1d
	ld l,b			;9a1e
	sub c			;9a1f
	ld (hl),a			;9a20
	sub c			;9a21
	adc a,e			;9a22
	sub c			;9a23
	dec hl			;9a24
	sub e			;9a25
	scf			;9a26
	sub e			;9a27
	ld d,e			;9a28
	sub e			;9a29
	ld l,b			;9a2a
	sub e			;9a2b
	ld (hl),a			;9a2c
	sub e			;9a2d
	adc a,(hl)			;9a2e
	sub e			;9a2f
	sbc a,e			;9a30
	sub e			;9a31
	sbc a,h			;9a32
	sub e			;9a33
	and a			;9a34
	sub e			;9a35
	res 2,e		;9a36
	and 093h		;9a38
	rst 20h			;9a3a
	sub e			;9a3b
	ret pe			;9a3c
	sub e			;9a3d
	jp (hl)			;9a3e
	sub e			;9a3f
	jp pe,0f393h		;9a40
	sub e			;9a43
	ex af,af'			;9a44
	sub h			;9a45
	inc d			;9a46
	sub h			;9a47
	jr z,$-106		;9a48
	scf			;9a4a
	sub h			;9a4b
	ld b,e			;9a4c
	sub h			;9a4d
	ld d,e			;9a4e
	sub h			;9a4f
	ld d,(hl)			;9a50
	sub h			;9a51
	ld e,d			;9a52
	sub h			;9a53
	ld e,h			;9a54
	sub h			;9a55
	ld e,(hl)			;9a56
	sub h			;9a57
	ld l,h			;9a58
	sub h			;9a59
	add a,(hl)			;9a5a
	sub h			;9a5b
	sbc a,(hl)			;9a5c
	sub h			;9a5d
	cp d			;9a5e
	sub h			;9a5f
	cp e			;9a60
	sub h			;9a61
	cp h			;9a62
	sub h			;9a63
	jp z,0cb94h		;9a64
	sub h			;9a67
	out (094h),a		;9a68
	sbc a,094h		;9a6a
	jp pe,0f894h		;9a6c
	sub h			;9a6f
	ld de,01495h		;9a70
	sub l			;9a73
	rla			;9a74
	sub l			;9a75
	dec de			;9a76
	sub l			;9a77
	rra			;9a78
	sub l			;9a79
	ld (02595h),hl		;9a7a
	sub l			;9a7d
	add hl,hl			;9a7e
	sub l			;9a7f
	dec l			;9a80
	sub l			;9a81
	add hl,sp			;9a82
	sub l			;9a83
	ld c,b			;9a84
	sub l			;9a85
	ld e,b			;9a86
	sub l			;9a87
	ld h,l			;9a88
	sub l			;9a89
	add a,h			;9a8a
	sub l			;9a8b
	sbc a,h			;9a8c
	sub l			;9a8d
	sbc a,a			;9a8e
	sub l			;9a8f
	and h			;9a90
	sub l			;9a91
	xor d			;9a92
	sub l			;9a93
	or h			;9a94
	sub l			;9a95
	cp (hl)			;9a96
	sub l			;9a97
	call nc,0ee95h		;9a98
	sub l			;9a9b
	pop af			;9a9c
	sub l			;9a9d
	call p,0f895h		;9a9e
	sub l			;9aa1
	inc c			;9aa2
	sub (hl)			;9aa3
	ld (de),a			;9aa4
	sub (hl)			;9aa5
	ld d,096h		;9aa6
	dec de			;9aa8
	sub (hl)			;9aa9
	ld hl,02996h		;9aaa
	sub (hl)			;9aad
	ld (03a96h),a		;9aae
	sub (hl)			;9ab1
	ld b,e			;9ab2
	sub (hl)			;9ab3
	ld c,c			;9ab4
	sub (hl)			;9ab5
	ld c,a			;9ab6
	sub (hl)			;9ab7
	ld d,(hl)			;9ab8
	sub (hl)			;9ab9
	ld e,h			;9aba
	sub (hl)			;9abb
	ld l,d			;9abc
	sub (hl)			;9abd
	ld (hl),a			;9abe
	sub (hl)			;9abf
	add a,h			;9ac0
	sub (hl)			;9ac1
	adc a,a			;9ac2
	sub (hl)			;9ac3
	and a			;9ac4
	sub (hl)			;9ac5
	or b			;9ac6
	sub (hl)			;9ac7
	cp h			;9ac8
	sub (hl)			;9ac9
	ret			;9aca
	sub (hl)			;9acb
	jp nc,0df96h		;9acc
	sub (hl)			;9acf
	pop af			;9ad0
	sub (hl)			;9ad1
	ld sp,hl			;9ad2
	sub (hl)			;9ad3
	dec c			;9ad4
	sub a			;9ad5
	jr nz,$-103		;9ad6
	daa			;9ad8
	sub a			;9ad9
	inc l			;9ada
	sub a			;9adb
	ld sp,04097h		;9adc
	sub a			;9adf
	ld c,d			;9ae0
	sub a			;9ae1
	ld l,b			;9ae2
	sub a			;9ae3
	ld (hl),l			;9ae4
	sub a			;9ae5
	sub (hl)			;9ae6
	sub a			;9ae7
	and e			;9ae8
	sub a			;9ae9
	cp h			;9aea
	sub a			;9aeb
	ret			;9aec
	sub a			;9aed
	ret c			;9aee
	sub a			;9aef
	jp pe,0f897h		;9af0
	sub a			;9af3
	ld (bc),a			;9af4
	sbc a,b			;9af5
	inc c			;9af6
	sbc a,b			;9af7
	inc d			;9af8
	sbc a,b			;9af9
	ld hl,02b98h		;9afa
	sbc a,b			;9afd
	jr c,$-102		;9afe
	ld b,b			;9b00
	sbc a,b			;9b01
	ld c,h			;9b02
	sbc a,b			;9b03
	ld d,a			;9b04
	sbc a,b			;9b05
	ld e,h			;9b06
	sbc a,b			;9b07
	ld l,b			;9b08
	sbc a,b			;9b09
	ld a,b			;9b0a
	sbc a,b			;9b0b
	adc a,b			;9b0c
	sbc a,b			;9b0d
	sbc a,d			;9b0e
	sbc a,b			;9b0f
	cp d			;9b10
	sbc a,b			;9b11
	ret			;9b12
	sbc a,b			;9b13
	sub 098h		;9b14
	jp (hl)			;9b16
	sbc a,b			;9b17
	cp 098h		;9b18
	ld (de),a			;9b1a
	sbc a,c			;9b1b
	dec h			;9b1c
	sbc a,c			;9b1d
	ccf			;9b1e
	sbc a,c			;9b1f
	ld e,b			;9b20
	sbc a,c			;9b21
	ld a,b			;9b22
	sbc a,c			;9b23
	cp d			;9b24
	adc a,h			;9b25
	adc a,e			;9b26
	jp pe,090dfh		;9b27
	adc a,h			;9b2a
	sbc a,h			;9b2b
	adc a,d			;9b2c
	adc a,l			;9b2d
	sub b			;9b2e
	push af			;9b2f
	xor h			;9b30
	adc a,d			;9b31
	rst 18h			;9b32
	sub e			;9b33
	adc a,d			;9b34
	add a,l			;9b35
	rst 18h			;9b36
	sbc a,e			;9b37
	sbc a,d			;9b38
	adc a,h			;9b39
	adc a,e			;9b3a
	sbc a,(hl)			;9b3b
	sbc a,h			;9b3c
	sbc a,(hl)			;9b3d
	rst 18h			;9b3e
	sub c			;9b3f
	adc a,d			;9b40
	sbc a,d			;9b41
	adc a,c			;9b42
	sub b			;9b43
	adc a,h			;9b44
	rst 18h			;9b45
	adc a,l			;9b46
	sbc a,d			;9b47
	sub e			;9b48
	sub (hl)			;9b49
	sbc a,d			;9b4a
	adc a,c			;9b4b
	sbc a,d			;9b4c
	adc a,h			;9b4d
	rst 18h			;9b4e
	sbc a,d			;9b4f
	sub c			;9b50
	rst 18h			;9b51
	sub e			;9b52
	sbc a,(hl)			;9b53
	adc a,h			;9b54
	rst 18h			;9b55
	adc a,a			;9b56
	sub (hl)			;9b57
	sbc a,d			;9b58
	sbc a,e			;9b59
	adc a,l			;9b5a
	sbc a,(hl)			;9b5b
	adc a,h			;9b5c
	push af			;9b5d
	cp e			;9b5e
	sbc a,d			;9b5f
	adc a,a			;9b60
	adc a,l			;9b61
	sbc a,d			;9b62
	adc a,h			;9b63
	sub (hl)			;9b64
	rst 20h			;9b65
	sub c			;9b66
	rst 18h			;9b67
	sbc a,d			;9b68
	sub c			;9b69
	rst 18h			;9b6a
	sbc a,d			;9b6b
	sub e			;9b6c
	rst 18h			;9b6d
	adc a,c			;9b6e
	sub (hl)			;9b6f
	sbc a,d			;9b70
	sub c			;9b71
	adc a,e			;9b72
	adc a,l			;9b73
	sbc a,d			;9b74
	rst 18h			;9b75
	sbc a,e			;9b76
	sbc a,d			;9b77
	sub e			;9b78
	rst 18h			;9b79
	sbc a,e			;9b7a
	sub (hl)			;9b7b
	sub b			;9b7c
	adc a,h			;9b7d
	pop de			;9b7e
	rst 18h			;9b7f
	or d			;9b80
	adc a,d			;9b81
	add a,(hl)			;9b82
	rst 18h			;9b83
	adc a,d			;9b84
	adc a,h			;9b85
	sbc a,(hl)			;9b86
	sbc a,e			;9b87
	sbc a,(hl)			;9b88
	rst 18h			;9b89
	add a,(hl)			;9b8a
	rst 18h			;9b8b
	sbc a,h			;9b8c
	sbc a,(hl)			;9b8d
	adc a,l			;9b8e
	sbc a,b			;9b8f
	sbc a,(hl)			;9b90
	sbc a,e			;9b91
	sbc a,(hl)			;9b92
	rst 18h			;9b93
	sbc a,e			;9b94
	sbc a,d			;9b95
	rst 18h			;9b96
	sbc a,d			;9b97
	sub c			;9b98
	sbc a,d			;9b99
	adc a,l			;9b9a
	sbc a,b			;9b9b
	ret pe			;9b9c
	sbc a,(hl)			;9b9d
	push af			;9b9e
	cp h			;9b9f
	sub (hl)			;9ba0
	sub e			;9ba1
	sub (hl)			;9ba2
	sub c			;9ba3
	sbc a,e			;9ba4
	adc a,l			;9ba5
	sub b			;9ba6
	rst 18h			;9ba7
	sbc a,(hl)			;9ba8
	adc a,l			;9ba9
	adc a,e			;9baa
	sub (hl)			;9bab
	sbc a,c			;9bac
	sub (hl)			;9bad
	sbc a,h			;9bae
	sub (hl)			;9baf
	sbc a,(hl)			;9bb0
	sub e			;9bb1
	rst 18h			;9bb2
	sub d			;9bb3
	adc a,d			;9bb4
	add a,(hl)			;9bb5
	rst 18h			;9bb6
	adc a,a			;9bb7
	adc a,d			;9bb8
	sub e			;9bb9
	sub (hl)			;9bba
	sbc a,e			;9bbb
	sub b			;9bbc
	push af			;9bbd
	xor a			;9bbe
	sbc a,d			;9bbf
	adc a,(hl)			;9bc0
	adc a,d			;9bc1
	sbc a,d			;9bc2
	push hl			;9bc3
	sbc a,(hl)			;9bc4
	rst 18h			;9bc5
	add a,(hl)			;9bc6
	rst 18h			;9bc7
	sbc a,e			;9bc8
	sbc a,d			;9bc9
	adc a,h			;9bca
	adc a,e			;9bcb
	sub (hl)			;9bcc
	sub c			;9bcd
	sbc a,(hl)			;9bce
	sbc a,e			;9bcf
	sbc a,(hl)			;9bd0
	rst 18h			;9bd1
	sbc a,(hl)			;9bd2
	rst 18h			;9bd3
	adc a,e			;9bd4
	adc a,l			;9bd5
	sbc a,(hl)			;9bd6
	sub c			;9bd7
	adc a,h			;9bd8
	sub d			;9bd9
	adc a,d			;9bda
	adc a,e			;9bdb
	sbc a,(hl)			;9bdc
	sbc a,h			;9bdd
	sub (hl)			;9bde
	sub b			;9bdf
	sub c			;9be0
	sbc a,d			;9be1
	adc a,h			;9be2
	rst 18h			;9be3
	sub d			;9be4
	jp pe,09698h		;9be5
	sbc a,h			;9be8
	sbc a,(hl)			;9be9
	adc a,h			;9bea
	push af			;9beb
	cp h			;9bec
	sub b			;9bed
	adc a,a			;9bee
	sub (hl)			;9bef
	adc a,e			;9bf0
	sbc a,(hl)			;9bf1
	rst 18h			;9bf2
	adc a,a			;9bf3
	jp (hl)			;9bf4
	adc a,e			;9bf5
	adc a,l			;9bf6
	sbc a,d			;9bf7
	sbc a,(hl)			;9bf8
	rst 18h			;9bf9
	sbc a,e			;9bfa
	sbc a,d			;9bfb
	rst 18h			;9bfc
	adc a,d			;9bfd
	sub c			;9bfe
	rst 18h			;9bff
	sub d			;9c00
	sbc a,d			;9c01
	adc a,e			;9c02
	adc a,l			;9c03
	sub b			;9c04
	rst 18h			;9c05
	sbc a,e			;9c06
	sbc a,d			;9c07
	rst 18h			;9c08
	sbc a,(hl)			;9c09
	sub e			;9c0a
	adc a,e			;9c0b
	adc a,d			;9c0c
	adc a,l			;9c0d
	sbc a,(hl)			;9c0e
	pop de			;9c0f
	rst 18h			;9c10
	or d			;9c11
	adc a,d			;9c12
	add a,(hl)			;9c13
	rst 18h			;9c14
	sbc a,h			;9c15
	sub a			;9c16
	sbc a,(hl)			;9c17
	sub d			;9c18
	adc a,d			;9c19
	adc a,h			;9c1a
	sbc a,h			;9c1b
	sbc a,(hl)			;9c1c
	sbc a,e			;9c1d
	sbc a,(hl)			;9c1e
	push af			;9c1f
	xor a			;9c20
	sbc a,(hl)			;9c21
	adc a,l			;9c22
	sbc a,(hl)			;9c23
	rst 18h			;9c24
	sbc a,c			;9c25
	sbc a,d			;9c26
	adc a,l			;9c27
	sub d			;9c28
	sbc a,d			;9c29
	sub c			;9c2a
	adc a,e			;9c2b
	sbc a,(hl)			;9c2c
	adc a,l			;9c2d
	rst 18h			;9c2e
	sbc a,l			;9c2f
	sbc a,d			;9c30
	sbc a,l			;9c31
	sub (hl)			;9c32
	sbc a,e			;9c33
	sbc a,(hl)			;9c34
	adc a,h			;9c35
	push af			;9c36
	cp d			;9c37
	adc a,h			;9c38
	rst 18h			;9c39
	adc a,d			;9c3a
	sub c			;9c3b
	sbc a,(hl)			;9c3c
	rst 18h			;9c3d
	adc a,c			;9c3e
	sbc a,(hl)			;9c3f
	adc a,h			;9c40
	sub (hl)			;9c41
	sub l			;9c42
	sbc a,(hl)			;9c43
	rst 18h			;9c44
	sbc a,e			;9c45
	sbc a,d			;9c46
	rst 18h			;9c47
	sbc a,l			;9c48
	sbc a,(hl)			;9c49
	adc a,l			;9c4a
	adc a,l			;9c4b
	sub b			;9c4c
	push af			;9c4d
	push af			;9c4e
	cp e			;9c4f
	sbc a,d			;9c50
	sub e			;9c51
	rst 18h			;9c52
	adc a,e			;9c53
	sbc a,(hl)			;9c54
	sub d			;9c55
	sbc a,(hl)			;9c56
	push hl			;9c57
	sub b			;9c58
	rst 18h			;9c59
	sbc a,e			;9c5a
	sbc a,d			;9c5b
	rst 18h			;9c5c
	adc a,d			;9c5d
	sub c			;9c5e
	sbc a,(hl)			;9c5f
	rst 18h			;9c60
	adc a,a			;9c61
	sbc a,d			;9c62
	sub e			;9c63
	sub b			;9c64
	adc a,e			;9c65
	sbc a,(hl)			;9c66
	rst 18h			;9c67
	add a,(hl)			;9c68
	rst 18h			;9c69
	adc a,e			;9c6a
	sub (hl)			;9c6b
	sbc a,d			;9c6c
	sub c			;9c6d
	sbc a,d			;9c6e
	rst 18h			;9c6f
	adc a,d			;9c70
	sub c			;9c71
	rst 18h			;9c72
	sbc a,(hl)			;9c73
	sbc a,b			;9c74
	adc a,d			;9c75
	sub l			;9c76
	sbc a,d			;9c77
	adc a,l			;9c78
	sub b			;9c79
	push af			;9c7a
	cp h			;9c7b
	sub b			;9c7c
	sub c			;9c7d
	adc a,e			;9c7e
	sub (hl)			;9c7f
	sbc a,d			;9c80
	sub c			;9c81
	sbc a,d			;9c82
	rst 18h			;9c83
	adc a,d			;9c84
	sub c			;9c85
	sbc a,(hl)			;9c86
	rst 18h			;9c87
	adc a,a			;9c88
	sbc a,(hl)			;9c89
	adc a,h			;9c8a
	adc a,e			;9c8b
	sbc a,(hl)			;9c8c
	rst 18h			;9c8d
	adc a,d			;9c8e
	adc a,h			;9c8f
	sbc a,(hl)			;9c90
	sbc a,e			;9c91
	sbc a,(hl)			;9c92
	rst 18h			;9c93
	sbc a,h			;9c94
	sub b			;9c95
	sub d			;9c96
	sub b			;9c97
	rst 18h			;9c98
	sbc a,e			;9c99
	sub (hl)			;9c9a
	adc a,h			;9c9b
	sub b			;9c9c
	sub e			;9c9d
	adc a,c			;9c9e
	sbc a,d			;9c9f
	sub c			;9ca0
	adc a,e			;9ca1
	sbc a,d			;9ca2
	push af			;9ca3
	cp l			;9ca4
	sbc a,d			;9ca5
	sub e			;9ca6
	sub e			;9ca7
	sbc a,(hl)			;9ca8
	rst 18h			;9ca9
	sub b			;9caa
	sbc a,l			;9cab
	adc a,l			;9cac
	sbc a,(hl)			;9cad
	rst 18h			;9cae
	sbc a,e			;9caf
	sbc a,d			;9cb0
	rst 18h			;9cb1
	sub b			;9cb2
	sbc a,l			;9cb3
	adc a,h			;9cb4
	sub (hl)			;9cb5
	sbc a,e			;9cb6
	sub (hl)			;9cb7
	sbc a,(hl)			;9cb8
	sub c			;9cb9
	sbc a,(hl)			;9cba
	push af			;9cbb
	cp e			;9cbc
	sbc a,d			;9cbd
	rst 18h			;9cbe
	adc a,a			;9cbf
	sub e			;9cc0
	sbc a,(hl)			;9cc1
	adc a,e			;9cc2
	sbc a,(hl)			;9cc3
	out (0dfh),a		;9cc4
	sub a			;9cc6
	sbc a,d			;9cc7
	add a,a			;9cc8
	sbc a,(hl)			;9cc9
	sbc a,b			;9cca
	sub b			;9ccb
	sub c			;9ccc
	sbc a,(hl)			;9ccd
	sub e			;9cce
	rst 18h			;9ccf
	add a,(hl)			;9cd0
	rst 18h			;9cd1
	sbc a,h			;9cd2
	sub b			;9cd3
	sub c			;9cd4
	rst 18h			;9cd5
	adc a,d			;9cd6
	sub c			;9cd7
	rst 18h			;9cd8
	sub c			;9cd9
	adc a,d			;9cda
	sbc a,h			;9cdb
	sub e			;9cdc
	sbc a,d			;9cdd
	sub b			;9cde
	rst 18h			;9cdf
	sbc a,e			;9ce0
	sbc a,d			;9ce1
	rst 18h			;9ce2
	sbc a,h			;9ce3
	adc a,d			;9ce4
	sbc a,(hl)			;9ce5
	adc a,l			;9ce6
	add a,l			;9ce7
	sub b			;9ce8
	push af			;9ce9
	xor h			;9cea
	rst 20h			;9ceb
	sub e			;9cec
	sub b			;9ced
	rst 18h			;9cee
	adc a,(hl)			;9cef
	adc a,d			;9cf0
	sbc a,d			;9cf1
	sbc a,e			;9cf2
	sbc a,(hl)			;9cf3
	rst 18h			;9cf4
	adc a,d			;9cf5
	sub c			;9cf6
	sbc a,(hl)			;9cf7
	rst 18h			;9cf8
	add a,l			;9cf9
	sub b			;9cfa
	sub c			;9cfb
	sbc a,(hl)			;9cfc
	rst 18h			;9cfd
	sbc a,h			;9cfe
	sub b			;9cff
	sub c			;9d00
	rst 18h			;9d01
	sub c			;9d02
	sub b			;9d03
	sub d			;9d04
	sbc a,l			;9d05
	adc a,l			;9d06
	sbc a,d			;9d07
	adc a,h			;9d08
	push bc			;9d09
	push af			;9d0a
	cp e			;9d0b
	sbc a,d			;9d0c
	rst 18h			;9d0d
	sub b			;9d0e
	adc a,l			;9d0f
	sub b			;9d10
	push af			;9d11
	xor l			;9d12
	sub b			;9d13
	sbc a,h			;9d14
	sbc a,(hl)			;9d15
	rst 18h			;9d16
	sbc a,h			;9d17
	sub b			;9d18
	sub c			;9d19
	rst 18h			;9d1a
	sub d			;9d1b
	adc a,d			;9d1c
	sbc a,h			;9d1d
	sub a			;9d1e
	sub b			;9d1f
	rst 18h			;9d20
	sbc a,h			;9d21
	adc a,l			;9d22
	sub (hl)			;9d23
	adc a,h			;9d24
	adc a,e			;9d25
	sbc a,(hl)			;9d26
	sub e			;9d27
	push af			;9d28
	cp d			;9d29
	sub c			;9d2a
	rst 18h			;9d2b
	sbc a,d			;9d2c
	sub e			;9d2d
	rst 18h			;9d2e
	sbc a,h			;9d2f
	adc a,d			;9d30
	sbc a,d			;9d31
	sub c			;9d32
	sbc a,h			;9d33
	sub b			;9d34
	rst 18h			;9d35
	adc a,(hl)			;9d36
	adc a,d			;9d37
	sbc a,d			;9d38
	sbc a,e			;9d39
	sbc a,(hl)			;9d3a
	rst 18h			;9d3b
	adc a,d			;9d3c
	sub c			;9d3d
	sbc a,(hl)			;9d3e
	rst 18h			;9d3f
	adc a,a			;9d40
	sbc a,d			;9d41
	sub e			;9d42
	sub b			;9d43
	adc a,e			;9d44
	sbc a,(hl)			;9d45
	rst 18h			;9d46
	sbc a,e			;9d47
	sbc a,d			;9d48
	rst 18h			;9d49
	sbc a,h			;9d4a
	sbc a,(hl)			;9d4b
	adc a,d			;9d4c
	sbc a,h			;9d4d
	sub a			;9d4e
	sub b			;9d4f
	pop de			;9d50
	push af			;9d51
	or c			;9d52
	sbc a,d			;9d53
	sbc a,b			;9d54
	adc a,l			;9d55
	sub b			;9d56
	rst 18h			;9d57
	add a,(hl)			;9d58
	rst 18h			;9d59
	adc a,h			;9d5a
	adc a,d			;9d5b
	sbc a,h			;9d5c
	sub (hl)			;9d5d
	sub b			;9d5e
	push af			;9d5f
	cp e			;9d60
	sbc a,d			;9d61
	rst 18h			;9d62
	sbc a,b			;9d63
	adc a,l			;9d64
	sbc a,(hl)			;9d65
	sub c			;9d66
	rst 18h			;9d67
	adc a,e			;9d68
	adc a,l			;9d69
	sbc a,(hl)			;9d6a
	sub c			;9d6b
	adc a,h			;9d6c
	adc a,a			;9d6d
	sbc a,(hl)			;9d6e
	adc a,l			;9d6f
	sbc a,d			;9d70
	sub c			;9d71
	sbc a,h			;9d72
	sub (hl)			;9d73
	sbc a,(hl)			;9d74
	push af			;9d75
	push af			;9d76
	or e			;9d77
	sbc a,(hl)			;9d78
	rst 18h			;9d79
	sbc a,e			;9d7a
	adc a,l			;9d7b
	sub b			;9d7c
	sbc a,b			;9d7d
	sbc a,(hl)			;9d7e
	rst 18h			;9d7f
	adc a,e			;9d80
	sbc a,d			;9d81
	rst 18h			;9d82
	adc a,a			;9d83
	sub b			;9d84
	sub c			;9d85
	sbc a,d			;9d86
	rst 18h			;9d87
	sbc a,d			;9d88
	sub c			;9d89
	rst 18h			;9d8a
	adc a,e			;9d8b
	adc a,l			;9d8c
	sbc a,(hl)			;9d8d
	sub c			;9d8e
	sbc a,h			;9d8f
	sbc a,d			;9d90
	pop de			;9d91
	di			;9d92
	call p,0acf5h		;9d93
	sbc a,d			;9d96
	sub d			;9d97
	sub (hl)			;9d98
	sbc a,d			;9d99
	adc a,h			;9d9a
	sbc a,c			;9d9b
	jp (hl)			;9d9c
	adc a,l			;9d9d
	sub (hl)			;9d9e
	sbc a,h			;9d9f
	sub b			;9da0
	rst 18h			;9da1
	add a,(hl)			;9da2
	rst 18h			;9da3
	sbc a,h			;9da4
	sub b			;9da5
	sub c			;9da6
	rst 18h			;9da7
	sbc a,h			;9da8
	jp pe,09c8ch		;9da9
	sbc a,(hl)			;9dac
	adc a,l			;9dad
	sbc a,(hl)			;9dae
	push af			;9daf
	xor a			;9db0
	sbc a,d			;9db1
	adc a,(hl)			;9db2
	adc a,d			;9db3
	sbc a,d			;9db4
	push hl			;9db5
	sbc a,(hl)			;9db6
	rst 18h			;9db7
	add a,(hl)			;9db8
	rst 18h			;9db9
	sbc a,l			;9dba
	sub e			;9dbb
	sbc a,(hl)			;9dbc
	sub c			;9dbd
	sbc a,h			;9dbe
	sbc a,(hl)			;9dbf
	push af			;9dc0
	cp (hl)			;9dc1
	sub e			;9dc2
	adc a,d			;9dc3
	sbc a,h			;9dc4
	sub (hl)			;9dc5
	sub c			;9dc6
	rst 20h			;9dc7
	sbc a,b			;9dc8
	sbc a,d			;9dc9
	sub c			;9dca
	sub b			;9dcb
	rst 18h			;9dcc
	sbc a,e			;9dcd
	sbc a,d			;9dce
	adc a,h			;9dcf
	sbc a,d			;9dd0
	sbc a,h			;9dd1
	sbc a,(hl)			;9dd2
	sbc a,e			;9dd3
	sub b			;9dd4
	rst 18h			;9dd5
	sbc a,e			;9dd6
	sbc a,d			;9dd7
	sub e			;9dd8
	rst 18h			;9dd9
	adc a,a			;9dda
	sbc a,d			;9ddb
	add a,(hl)			;9ddc
	sub b			;9ddd
	adc a,e			;9dde
	sbc a,d			;9ddf
	push af			;9de0
	or d			;9de1
	adc a,d			;9de2
	add a,(hl)			;9de3
	rst 18h			;9de4
	sbc a,(hl)			;9de5
	sbc a,c			;9de6
	sub (hl)			;9de7
	sub e			;9de8
	sbc a,(hl)			;9de9
	sbc a,e			;9dea
	sbc a,(hl)			;9deb
	rst 18h			;9dec
	sbc a,d			;9ded
	sub c			;9dee
	rst 18h			;9def
	adc a,h			;9df0
	adc a,d			;9df1
	adc a,h			;9df2
	rst 18h			;9df3
	sbc a,l			;9df4
	sub b			;9df5
	adc a,l			;9df6
	sbc a,e			;9df7
	sbc a,d			;9df8
	adc a,h			;9df9
	rst 18h			;9dfa
	adc a,a			;9dfb
	sbc a,(hl)			;9dfc
	adc a,l			;9dfd
	sbc a,(hl)			;9dfe
	rst 18h			;9dff
	adc a,a			;9e00
	sbc a,d			;9e01
	sub e			;9e02
	sbc a,(hl)			;9e03
	adc a,l			;9e04
	rst 18h			;9e05
	add a,(hl)			;9e06
	rst 18h			;9e07
	adc a,h			;9e08
	sbc a,(hl)			;9e09
	sub c			;9e0a
	sbc a,b			;9e0b
	adc a,l			;9e0c
	sbc a,(hl)			;9e0d
	adc a,l			;9e0e
	rst 18h			;9e0f
	jp pe,09d8dh		;9e10
	sub b			;9e13
	sub e			;9e14
	sbc a,d			;9e15
	adc a,h			;9e16
	push af			;9e17
	cp l			;9e18
	sbc a,d			;9e19
	sub e			;9e1a
	sub e			;9e1b
	sbc a,(hl)			;9e1c
	rst 18h			;9e1d
	sbc a,(hl)			;9e1e
	adc a,l			;9e1f
	sub d			;9e20
	sbc a,(hl)			;9e21
	rst 18h			;9e22
	sbc a,e			;9e23
	sbc a,d			;9e24
	rst 18h			;9e25
	sub e			;9e26
	sbc a,(hl)			;9e27
	rst 18h			;9e28
	or b			;9e29
	adc a,l			;9e2a
	sbc a,e			;9e2b
	sbc a,d			;9e2c
	sub c			;9e2d
	rst 18h			;9e2e
	sbc a,e			;9e2f
	sbc a,d			;9e30
	sub e			;9e31
	rst 18h			;9e32
	cp (hl)			;9e33
	sbc a,b			;9e34
	adc a,d			;9e35
	sub (hl)			;9e36
	sub e			;9e37
	sbc a,(hl)			;9e38
	push af			;9e39
	cp (hl)			;9e3a
	sub e			;9e3b
	sbc a,(hl)			;9e3c
	adc a,l			;9e3d
	sbc a,b			;9e3e
	sbc a,(hl)			;9e3f
	sbc a,e			;9e40
	sbc a,(hl)			;9e41
	rst 18h			;9e42
	add a,(hl)			;9e43
	rst 18h			;9e44
	sbc a,c			;9e45
	sub e			;9e46
	sbc a,d			;9e47
	add a,a			;9e48
	sub (hl)			;9e49
	sbc a,l			;9e4a
	sub e			;9e4b
	sbc a,d			;9e4c
	push af			;9e4d
	xor h			;9e4e
	sbc a,d			;9e4f
	sbc a,h			;9e50
	sbc a,(hl)			;9e51
	rst 18h			;9e52
	add a,(hl)			;9e53
	rst 18h			;9e54
	sbc a,l			;9e55
	sub (hl)			;9e56
	sbc a,d			;9e57
	sub c			;9e58
	rst 18h			;9e59
	sbc a,h			;9e5a
	adc a,d			;9e5b
	adc a,l			;9e5c
	sbc a,(hl)			;9e5d
	sbc a,e			;9e5e
	sbc a,(hl)			;9e5f
	push af			;9e60
	or d			;9e61
	sbc a,(hl)			;9e62
	sbc a,b			;9e63
	sub c			;9e64
	ret pe			;9e65
	sbc a,c			;9e66
	sub (hl)			;9e67
	sbc a,h			;9e68
	sub b			;9e69
	rst 18h			;9e6a
	adc a,a			;9e6b
	adc a,d			;9e6c
	adc a,l			;9e6d
	sub b			;9e6e
	push af			;9e6f
	cp e			;9e70
	sbc a,d			;9e71
	sub e			;9e72
	rst 18h			;9e73
	cp c			;9e74
	adc a,d			;9e75
	sbc a,d			;9e76
	sbc a,b			;9e77
	sub b			;9e78
	rst 18h			;9e79
	cp d			;9e7a
	adc a,e			;9e7b
	sbc a,d			;9e7c
	adc a,l			;9e7d
	sub c			;9e7e
	sub b			;9e7f
	push af			;9e80
	or d			;9e81
	sbc a,(hl)			;9e82
	adc a,l			;9e83
	adc a,l			;9e84
	rst 20h			;9e85
	sub c			;9e86
	rst 18h			;9e87
	add a,(hl)			;9e88
	rst 18h			;9e89
	sbc a,e			;9e8a
	sbc a,d			;9e8b
	rst 18h			;9e8c
	sbc a,c			;9e8d
	adc a,d			;9e8e
	sbc a,d			;9e8f
	adc a,l			;9e90
	adc a,e			;9e91
	sbc a,d			;9e92
	rst 18h			;9e93
	sub b			;9e94
	sub e			;9e95
	sub b			;9e96
	adc a,l			;9e97
	push af			;9e98
	cp e			;9e99
	sbc a,d			;9e9a
	rst 18h			;9e9b
	adc a,c			;9e9c
	sub (hl)			;9e9d
	adc a,c			;9e9e
	sub b			;9e9f
	adc a,h			;9ea0
	rst 18h			;9ea1
	sbc a,h			;9ea2
	sub b			;9ea3
	sub e			;9ea4
	sub b			;9ea5
	adc a,l			;9ea6
	sbc a,d			;9ea7
	adc a,h			;9ea8
	rst 18h			;9ea9
	adc a,e			;9eaa
	adc a,l			;9eab
	sub b			;9eac
	adc a,a			;9ead
	sub (hl)			;9eae
	sbc a,h			;9eaf
	sbc a,(hl)			;9eb0
	sub e			;9eb1
	sbc a,d			;9eb2
	adc a,h			;9eb3
	push af			;9eb4
	cp e			;9eb5
	sbc a,d			;9eb6
	rst 18h			;9eb7
	sbc a,e			;9eb8
	adc a,d			;9eb9
	adc a,l			;9eba
	sub b			;9ebb
	rst 18h			;9ebc
	adc a,a			;9ebd
	sbc a,d			;9ebe
	sbc a,e			;9ebf
	sbc a,d			;9ec0
	adc a,l			;9ec1
	sub c			;9ec2
	sbc a,(hl)			;9ec3
	sub e			;9ec4
	push af			;9ec5
	cp e			;9ec6
	sbc a,d			;9ec7
	rst 18h			;9ec8
	sbc a,b			;9ec9
	adc a,l			;9eca
	sbc a,(hl)			;9ecb
	sub c			;9ecc
	rst 18h			;9ecd
	sbc a,h			;9ece
	sbc a,(hl)			;9ecf
	sub e			;9ed0
	sub (hl)			;9ed1
	sbc a,e			;9ed2
	sbc a,(hl)			;9ed3
	sbc a,e			;9ed4
	rst 18h			;9ed5
	sbc a,d			;9ed6
	rst 18h			;9ed7
	sub (hl)			;9ed8
	sub d			;9ed9
	adc a,a			;9eda
	adc a,l			;9edb
	sbc a,d			;9edc
	sbc a,b			;9edd
	sub c			;9ede
	sbc a,(hl)			;9edf
	sbc a,e			;9ee0
	sbc a,(hl)			;9ee1
	rst 18h			;9ee2
	sbc a,e			;9ee3
	sbc a,d			;9ee4
	rst 18h			;9ee5
	adc a,d			;9ee6
	sub c			;9ee7
	sbc a,(hl)			;9ee8
	rst 18h			;9ee9
	adc a,h			;9eea
	adc a,d			;9eeb
	adc a,h			;9eec
	adc a,e			;9eed
	sbc a,(hl)			;9eee
	sub c			;9eef
	sbc a,h			;9ef0
	sub (hl)			;9ef1
	sbc a,(hl)			;9ef2
	rst 18h			;9ef3
	sub b			;9ef4
	sub e			;9ef5
	sbc a,d			;9ef6
	sub b			;9ef7
	adc a,h			;9ef8
	sbc a,(hl)			;9ef9
	push af			;9efa
	cp (hl)			;9efb
	adc a,l			;9efc
	adc a,e			;9efd
	sbc a,d			;9efe
	adc a,h			;9eff
	sbc a,(hl)			;9f00
	sub c			;9f01
	ret pe			;9f02
	sbc a,(hl)			;9f03
	rst 18h			;9f04
	sbc a,d			;9f05
	sub c			;9f06
	rst 18h			;9f07
	sub b			;9f08
	adc a,l			;9f09
	sub b			;9f0a
	rst 18h			;9f0b
	adc a,l			;9f0c
	sbc a,d			;9f0d
	adc a,a			;9f0e
	adc a,l			;9f0f
	sbc a,d			;9f10
	adc a,h			;9f11
	sbc a,d			;9f12
	sub c			;9f13
	adc a,e			;9f14
	sbc a,(hl)			;9f15
	sub c			;9f16
	sbc a,e			;9f17
	sub b			;9f18
	rst 18h			;9f19
	sbc a,(hl)			;9f1a
	sub e			;9f1b
	rst 18h			;9f1c
	sbc a,e			;9f1d
	sub (hl)			;9f1e
	adc a,h			;9f1f
	sbc a,h			;9f20
	sub b			;9f21
	rst 18h			;9f22
	adc a,h			;9f23
	sub b			;9f24
	sub e			;9f25
	sbc a,(hl)			;9f26
	adc a,l			;9f27
	push af			;9f28
	cp b			;9f29
	adc a,l			;9f2a
	sbc a,(hl)			;9f2b
	sub c			;9f2c
	sbc a,e			;9f2d
	sbc a,d			;9f2e
	out (0dfh),a		;9f2f
	adc a,a			;9f31
	sbc a,d			;9f32
	adc a,l			;9f33
	sub b			;9f34
	rst 18h			;9f35
	sbc a,d			;9f36
	adc a,h			;9f37
	adc a,e			;9f38
	jp pe,092dfh		;9f39
	adc a,d			;9f3c
	add a,(hl)			;9f3d
	rst 18h			;9f3e
	sbc a,e			;9f3f
	sbc a,d			;9f40
	adc a,e			;9f41
	sbc a,d			;9f42
	adc a,l			;9f43
	sub (hl)			;9f44
	sub b			;9f45
	adc a,l			;9f46
	sbc a,(hl)			;9f47
	sbc a,e			;9f48
	sbc a,(hl)			;9f49
	push af			;9f4a
	cp e			;9f4b
	sbc a,d			;9f4c
	rst 18h			;9f4d
	sub l			;9f4e
	sbc a,(hl)			;9f4f
	sbc a,e			;9f50
	sbc a,d			;9f51
	rst 18h			;9f52
	add a,(hl)			;9f53
	rst 18h			;9f54
	sbc a,h			;9f55
	sub b			;9f56
	sub c			;9f57
	rst 18h			;9f58
	sbc a,e			;9f59
	sub b			;9f5a
	adc a,h			;9f5b
	rst 18h			;9f5c
	sbc a,h			;9f5d
	sbc a,(hl)			;9f5e
	sbc a,l			;9f5f
	sbc a,d			;9f60
	add a,l			;9f61
	sbc a,(hl)			;9f62
	adc a,h			;9f63
	push af			;9f64
	cp e			;9f65
	sbc a,d			;9f66
	rst 18h			;9f67
	sbc a,h			;9f68
	sbc a,(hl)			;9f69
	adc a,a			;9f6a
	sbc a,(hl)			;9f6b
	adc a,h			;9f6c
	rst 18h			;9f6d
	sbc a,e			;9f6e
	sbc a,d			;9f6f
	rst 18h			;9f70
	sbc a,h			;9f71
	sbc a,(hl)			;9f72
	adc a,d			;9f73
	sbc a,h			;9f74
	sub a			;9f75
	sub b			;9f76
	push af			;9f77
	cp d			;9f78
	sub c			;9f79
	sub b			;9f7a
	adc a,l			;9f7b
	sub d			;9f7c
	sbc a,d			;9f7d
	rst 18h			;9f7e
	add a,(hl)			;9f7f
	rst 18h			;9f80
	sbc a,e			;9f81
	sbc a,d			;9f82
	rst 18h			;9f83
	sbc a,(hl)			;9f84
	sub e			;9f85
	sbc a,(hl)			;9f86
	sbc a,l			;9f87
	sbc a,(hl)			;9f88
	adc a,h			;9f89
	adc a,e			;9f8a
	adc a,l			;9f8b
	sub b			;9f8c
	push af			;9f8d
	cp l			;9f8e
	sbc a,d			;9f8f
	sbc a,l			;9f90
	sub (hl)			;9f91
	sbc a,e			;9f92
	sbc a,(hl)			;9f93
	rst 18h			;9f94
	sub c			;9f95
	sbc a,(hl)			;9f96
	sbc a,h			;9f97
	sub (hl)			;9f98
	sub b			;9f99
	sub c			;9f9a
	sbc a,(hl)			;9f9b
	sub e			;9f9c
	rst 18h			;9f9d
	sbc a,(hl)			;9f9e
	rst 18h			;9f9f
	sbc a,l			;9fa0
	sbc a,(hl)			;9fa1
	adc a,h			;9fa2
	sbc a,d			;9fa3
	rst 18h			;9fa4
	sbc a,e			;9fa5
	sbc a,d			;9fa6
	rst 18h			;9fa7
	sbc a,h			;9fa8
	sbc a,(hl)			;9fa9
	sbc a,h			;9faa
	sbc a,(hl)			;9fab
	sub b			;9fac
	push af			;9fad
	cp d			;9fae
	adc a,h			;9faf
	rst 18h			;9fb0
	sub e			;9fb1
	jp pe,09a8bh		;9fb2
	add a,a			;9fb5
	out (0dfh),a		;9fb6
	adc a,h			;9fb8
	sbc a,d			;9fb9
	sbc a,h			;9fba
	adc a,l			;9fbb
	sbc a,d			;9fbc
	sbc a,h			;9fbd
	sub (hl)			;9fbe
	rst 20h			;9fbf
	sub c			;9fc0
	rst 18h			;9fc1
	sub e			;9fc2
	sbc a,d			;9fc3
	sbc a,h			;9fc4
	sub a			;9fc5
	sub b			;9fc6
	adc a,h			;9fc7
	sbc a,(hl)			;9fc8
	push af			;9fc9
	or e			;9fca
	ret pe			;9fcb
	adc a,(hl)			;9fcc
	adc a,d			;9fcd
	sub (hl)			;9fce
	sbc a,e			;9fcf
	sub b			;9fd0
	rst 18h			;9fd1
	sbc a,c			;9fd2
	sbc a,d			;9fd3
	adc a,l			;9fd4
	sub d			;9fd5
	sbc a,d			;9fd6
	sub c			;9fd7
	adc a,e			;9fd8
	sbc a,(hl)			;9fd9
	sbc a,e			;9fda
	sub b			;9fdb
	rst 18h			;9fdc
	sub d			;9fdd
	adc a,d			;9fde
	add a,(hl)			;9fdf
	rst 18h			;9fe0
	sbc a,(hl)			;9fe1
	sub e			;9fe2
	sbc a,h			;9fe3
	sub b			;9fe4
	sub a			;9fe5
	rst 20h			;9fe6
	sub e			;9fe7
	sub (hl)			;9fe8
	sbc a,h			;9fe9
	sub b			;9fea
	push af			;9feb
	or (hl)			;9fec
	sub c			;9fed
	and 08bh		;9fee
	sub (hl)			;9ff0
	sub e			;9ff1
	rst 18h			;9ff2
	adc a,h			;9ff3
	adc a,d			;9ff4
	adc a,h			;9ff5
	adc a,e			;9ff6
	sbc a,(hl)			;9ff7
	sub c			;9ff8
	sbc a,h			;9ff9
	sub (hl)			;9ffa
	sbc a,(hl)			;9ffb
	rst 18h			;9ffc
	adc a,c			;9ffd
	sub (hl)			;9ffe
	adc a,h			;9fff
	sbc a,h			;a000
	sub b			;a001
	adc a,h			;a002
	sbc a,(hl)			;a003
	push af			;a004
	or e			;a005
	sub b			;a006
	rst 18h			;a007
	sbc a,h			;a008
	sub b			;a009
	sub c			;a00a
	adc a,h			;a00b
	sub (hl)			;a00c
	sbc a,e			;a00d
	sbc a,d			;a00e
	adc a,l			;a00f
	sbc a,(hl)			;a010
	adc a,h			;a011
	out (0dfh),a		;a012
	adc a,a			;a014
	sbc a,d			;a015
	adc a,l			;a016
	sub b			;a017
	rst 18h			;a018
	sbc a,d			;a019
	adc a,h			;a01a
	adc a,e			;a01b
	jp pe,09bdfh		;a01c
	sbc a,d			;a01f
	sub d			;a020
	sbc a,(hl)			;a021
	adc a,h			;a022
	sub (hl)			;a023
	sbc a,(hl)			;a024
	sbc a,e			;a025
	sub b			;a026
	rst 18h			;a027
	adc a,h			;a028
	adc a,d			;a029
	sbc a,h			;a02a
	sub (hl)			;a02b
	sbc a,(hl)			;a02c
	pop de			;a02d
	push af			;a02e
	cp (hl)			;a02f
	adc a,l			;a030
	sbc a,l			;a031
	sub b			;a032
	sub e			;a033
	rst 18h			;a034
	sbc a,(hl)			;a035
	sub d			;a036
	sbc a,d			;a037
	adc a,l			;a038
	sub (hl)			;a039
	sbc a,h			;a03a
	sbc a,(hl)			;a03b
	sub c			;a03c
	sub b			;a03d
	rst 18h			;a03e
	sbc a,h			;a03f
	sbc a,(hl)			;a040
	adc a,l			;a041
	sbc a,b			;a042
	sbc a,(hl)			;a043
	sbc a,e			;a044
	sub b			;a045
	rst 18h			;a046
	sbc a,e			;a047
	sbc a,d			;a048
	rst 18h			;a049
	sbc a,c			;a04a
	adc a,l			;a04b
	adc a,d			;a04c
	adc a,e			;a04d
	sub b			;a04e
	adc a,h			;a04f
	pop de			;a050
	push af			;a051
	cp d			;a052
	adc a,h			;a053
	adc a,e			;a054
	jp pe,08cdfh		;a055
	sbc a,d			;a058
	sub e			;a059
	sub e			;a05a
	sbc a,(hl)			;a05b
	sbc a,e			;a05c
	sub b			;a05d
	rst 18h			;a05e
	sub a			;a05f
	sbc a,d			;a060
	adc a,l			;a061
	sub d			;a062
	jp (hl)			;a063
	adc a,e			;a064
	sub (hl)			;a065
	sbc a,h			;a066
	sbc a,(hl)			;a067
	sub d			;a068
	sbc a,d			;a069
	sub c			;a06a
	adc a,e			;a06b
	sbc a,d			;a06c
	rst 18h			;a06d
	sbc a,h			;a06e
	sub b			;a06f
	sub c			;a070
	rst 18h			;a071
	adc a,d			;a072
	sub c			;a073
	sbc a,(hl)			;a074
	rst 18h			;a075
	adc a,h			;a076
	adc a,d			;a077
	adc a,h			;a078
	adc a,e			;a079
	sbc a,(hl)			;a07a
	sub c			;a07b
	sbc a,h			;a07c
	sub (hl)			;a07d
	sbc a,(hl)			;a07e
	rst 18h			;a07f
	adc a,h			;a080
	sbc a,d			;a081
	adc a,l			;a082
	sub b			;a083
	adc a,h			;a084
	sbc a,(hl)			;a085
	rst 18h			;a086
	sbc a,d			;a087
	sub c			;a088
	sbc a,e			;a089
	adc a,d			;a08a
	adc a,l			;a08b
	sbc a,d			;a08c
	sbc a,h			;a08d
	sub (hl)			;a08e
	sbc a,e			;a08f
	sbc a,(hl)			;a090
	pop de			;a091
	push af			;a092
	cp d			;a093
	adc a,h			;a094
	rst 18h			;a095
	sbc a,d			;a096
	sub e			;a097
	rst 18h			;a098
	jp pe,09d8dh		;a099
	sub b			;a09c
	sub e			;a09d
	rst 18h			;a09e
	sub a			;a09f
	sbc a,d			;a0a0
	adc a,l			;a0a1
	sub (hl)			;a0a2
	sbc a,e			;a0a3
	sub b			;a0a4
	rst 18h			;a0a5
	adc a,a			;a0a6
	sub b			;a0a7
	adc a,l			;a0a8
	rst 18h			;a0a9
	sbc a,d			;a0aa
	sub e			;a0ab
	rst 18h			;a0ac
	adc a,l			;a0ad
	sbc a,(hl)			;a0ae
	add a,(hl)			;a0af
	sub b			;a0b0
	out (0dfh),a		;a0b1
	adc a,h			;a0b3
	adc a,d			;a0b4
	rst 18h			;a0b5
	adc a,e			;a0b6
	adc a,l			;a0b7
	sub b			;a0b8
	sub c			;a0b9
	sbc a,h			;a0ba
	sub b			;a0bb
	rst 18h			;a0bc
	sbc a,d			;a0bd
	adc a,h			;a0be
	adc a,e			;a0bf
	jp pe,09cdfh		;a0c0
	sub a			;a0c3
	sbc a,(hl)			;a0c4
	sub d			;a0c5
	adc a,d			;a0c6
	adc a,h			;a0c7
	sbc a,h			;a0c8
	sbc a,(hl)			;a0c9
	sbc a,e			;a0ca
	sub b			;a0cb
	pop de			;a0cc
	push af			;a0cd
	cp e			;a0ce
	sbc a,d			;a0cf
	rst 18h			;a0d0
	sbc a,b			;a0d1
	adc a,l			;a0d2
	sbc a,(hl)			;a0d3
	sub c			;a0d4
	sbc a,e			;a0d5
	sbc a,d			;a0d6
	adc a,h			;a0d7
	rst 18h			;a0d8
	sub a			;a0d9
	sub b			;a0da
	sub l			;a0db
	sbc a,(hl)			;a0dc
	adc a,h			;a0dd
	pop de			;a0de
	push af			;a0df
	push af			;a0e0
	xor h			;a0e1
	sub b			;a0e2
	sub c			;a0e3
	rst 18h			;a0e4
	sbc a,h			;a0e5
	sbc a,(hl)			;a0e6
	sbc a,h			;a0e7
	adc a,e			;a0e8
	adc a,d			;a0e9
	adc a,h			;a0ea
	rst 18h			;a0eb
	sbc a,d			;a0ec
	sub c			;a0ed
	sbc a,(hl)			;a0ee
	sub c			;a0ef
	sub b			;a0f0
	adc a,h			;a0f1
	rst 18h			;a0f2
	sbc a,e			;a0f3
	sbc a,d			;a0f4
	rst 18h			;a0f5
	adc a,a			;a0f6
	sbc a,d			;a0f7
	add a,(hl)			;a0f8
	sub b			;a0f9
	adc a,e			;a0fa
	sub e			;a0fb
	out (0dfh),a		;a0fc
	adc a,h			;a0fe
	sub (hl)			;a0ff
	sub c			;a100
	rst 18h			;a101
	sbc a,d			;a102
	adc a,h			;a103
	adc a,a			;a104
	sub (hl)			;a105
	sub c			;a106
	sbc a,(hl)			;a107
	adc a,h			;a108
	rst 18h			;a109
	add a,(hl)			;a10a
	rst 18h			;a10b
	sbc a,h			;a10c
	sub b			;a10d
	sub c			;a10e
	rst 18h			;a10f
	adc a,d			;a110
	sub c			;a111
	sbc a,(hl)			;a112
	rst 18h			;a113
	sbc a,c			;a114
	sub e			;a115
	sub b			;a116
	adc a,l			;a117
	pop de			;a118
	push af			;a119
	xor l			;a11a
	jp (hl)			;a11b
	adc a,a			;a11c
	sub e			;a11d
	sub (hl)			;a11e
	sbc a,h			;a11f
	sbc a,(hl)			;a120
	rst 18h			;a121
	sbc a,d			;a122
	sub c			;a123
	rst 18h			;a124
	adc a,a			;a125
	sub (hl)			;a126
	sbc a,d			;a127
	sbc a,e			;a128
	adc a,l			;a129
	sbc a,(hl)			;a12a
	rst 18h			;a12b
	sbc a,e			;a12c
	sbc a,d			;a12d
	sub e			;a12e
	rst 18h			;a12f
	sbc a,e			;a130
	sub (hl)			;a131
	adc a,h			;a132
	sbc a,h			;a133
	sub b			;a134
	rst 18h			;a135
	adc a,h			;a136
	sub b			;a137
	sub e			;a138
	sbc a,(hl)			;a139
	adc a,l			;a13a
	pop de			;a13b
	push af			;a13c
	cp d			;a13d
	sub e			;a13e
	rst 18h			;a13f
	sbc a,e			;a140
	sub (hl)			;a141
	adc a,h			;a142
	sbc a,h			;a143
	sub b			;a144
	rst 18h			;a145
	sbc a,d			;a146
	adc a,h			;a147
	adc a,e			;a148
	jp pe,08bdfh		;a149
	sbc a,(hl)			;a14c
	adc a,a			;a14d
	sbc a,(hl)			;a14e
	sbc a,e			;a14f
	sub b			;a150
	rst 18h			;a151
	sbc a,h			;a152
	sub b			;a153
	sub c			;a154
	rst 18h			;a155
	sub e			;a156
	sbc a,(hl)			;a157
	rst 18h			;a158
	sub d			;a159
	sbc a,(hl)			;a15a
	sub c			;a15b
	adc a,e			;a15c
	sbc a,(hl)			;a15d
	push af			;a15e
	cp e			;a15f
	sbc a,d			;a160
	rst 18h			;a161
	adc a,e			;a162
	sbc a,(hl)			;a163
	sub d			;a164
	sbc a,(hl)			;a165
	push hl			;a166
	sub b			;a167
	rst 18h			;a168
	sub c			;a169
	sbc a,(hl)			;a16a
	adc a,e			;a16b
	adc a,d			;a16c
	adc a,l			;a16d
	sbc a,(hl)			;a16e
	sub e			;a16f
	pop de			;a170
	rst 18h			;a171
	cp d			;a172
	adc a,h			;a173
	adc a,e			;a174
	jp pe,08ddfh		;a175
	sbc a,d			;a178
	sbc a,h			;a179
	sub b			;a17a
	adc a,h			;a17b
	adc a,e			;a17c
	sbc a,(hl)			;a17d
	sbc a,e			;a17e
	sub b			;a17f
	rst 18h			;a180
	add a,(hl)			;a181
	rst 18h			;a182
	sbc a,h			;a183
	sub b			;a184
	sub c			;a185
	rst 18h			;a186
	adc a,d			;a187
	sub c			;a188
	rst 18h			;a189
	sbc a,h			;a18a
	adc a,d			;a18b
	sbc a,d			;a18c
	sub c			;a18d
	sbc a,h			;a18e
	sub b			;a18f
	rst 18h			;a190
	sbc a,d			;a191
	sub c			;a192
	rst 18h			;a193
	adc a,h			;a194
	adc a,d			;a195
	rst 18h			;a196
	adc a,l			;a197
	sbc a,d			;a198
	sbc a,b			;a199
	sbc a,(hl)			;a19a
	add a,l			;a19b
	sub b			;a19c
	pop de			;a19d
	rst 18h			;a19e
	push af			;a19f
	cp e			;a1a0
	sbc a,d			;a1a1
	rst 18h			;a1a2
	sbc a,b			;a1a3
	adc a,l			;a1a4
	adc a,d			;a1a5
	sbc a,d			;a1a6
	adc a,h			;a1a7
	sub b			;a1a8
	rst 18h			;a1a9
	adc a,e			;a1aa
	adc a,l			;a1ab
	sub b			;a1ac
	sub c			;a1ad
	sbc a,h			;a1ae
	sub b			;a1af
	rst 18h			;a1b0
	adc a,l			;a1b1
	sbc a,d			;a1b2
	sbc a,h			;a1b3
	adc a,d			;a1b4
	sbc a,l			;a1b5
	sub (hl)			;a1b6
	sbc a,d			;a1b7
	adc a,l			;a1b8
	adc a,e			;a1b9
	sub b			;a1ba
	rst 18h			;a1bb
	sbc a,e			;a1bc
	sbc a,d			;a1bd
	rst 18h			;a1be
	sbc a,h			;a1bf
	sub b			;a1c0
	adc a,l			;a1c1
	adc a,e			;a1c2
	sbc a,d			;a1c3
	add a,l			;a1c4
	sbc a,(hl)			;a1c5
	push af			;a1c6
	push af			;a1c7
	cp e			;a1c8
	sbc a,d			;a1c9
	rst 18h			;a1ca
	adc a,a			;a1cb
	sub (hl)			;a1cc
	sbc a,d			;a1cd
	sbc a,e			;a1ce
	adc a,l			;a1cf
	sbc a,(hl)			;a1d0
	pop de			;a1d1
	rst 18h			;a1d2
	or e			;a1d3
	sbc a,(hl)			;a1d4
	rst 18h			;a1d5
	sbc a,c			;a1d6
	sub e			;a1d7
	sub b			;a1d8
	adc a,l			;a1d9
	rst 18h			;a1da
	sbc a,b			;a1db
	adc a,l			;a1dc
	sbc a,(hl)			;a1dd
	sbc a,l			;a1de
	sbc a,(hl)			;a1df
	sbc a,e			;a1e0
	sbc a,(hl)			;a1e1
	rst 18h			;a1e2
	sbc a,d			;a1e3
	adc a,h			;a1e4
	rst 18h			;a1e5
	adc a,d			;a1e6
	sub c			;a1e7
	rst 18h			;a1e8
	adc a,h			;a1e9
	sub (hl)			;a1ea
	sub d			;a1eb
	sbc a,l			;a1ec
	sub b			;a1ed
	sub e			;a1ee
	sub (hl)			;a1ef
	adc a,h			;a1f0
	sub d			;a1f1
	sub b			;a1f2
	rst 18h			;a1f3
	sbc a,c			;a1f4
	sbc a,d			;a1f5
	sub d			;a1f6
	sbc a,d			;a1f7
	sub c			;a1f8
	sub (hl)			;a1f9
	sub c			;a1fa
	sub b			;a1fb
	rst 18h			;a1fc
	sub e			;a1fd
	sub (hl)			;a1fe
	sbc a,b			;a1ff
	sbc a,(hl)			;a200
	sbc a,e			;a201
	sub b			;a202
	rst 18h			;a203
	sbc a,(hl)			;a204
	rst 18h			;a205
	sub e			;a206
	sbc a,(hl)			;a207
	rst 18h			;a208
	sbc a,c			;a209
	sbc a,d			;a20a
	adc a,l			;a20b
	adc a,e			;a20c
	sub (hl)			;a20d
	sub e			;a20e
	sub (hl)			;a20f
	sbc a,e			;a210
	sbc a,(hl)			;a211
	sbc a,e			;a212
	pop de			;a213
	push af			;a214
	or d			;a215
	adc a,d			;a216
	sbc a,d			;a217
	adc a,h			;a218
	adc a,e			;a219
	adc a,l			;a21a
	sbc a,(hl)			;a21b
	sub c			;a21c
	rst 18h			;a21d
	sbc a,(hl)			;a21e
	sbc a,h			;a21f
	adc a,e			;a220
	sub b			;a221
	adc a,h			;a222
	rst 18h			;a223
	adc a,(hl)			;a224
	adc a,d			;a225
	sub (hl)			;a226
	adc a,l			;a227
	and 08dh		;a228
	sbc a,b			;a22a
	sub (hl)			;a22b
	sbc a,h			;a22c
	sub b			;a22d
	adc a,h			;a22e
	pop de			;a22f
	push af			;a230
	rst 18h			;a231
	sbc a,e			;a232
	sbc a,d			;a233
	sub e			;a234
	rst 18h			;a235
	sbc a,h			;a236
	adc a,d			;a237
	sbc a,(hl)			;a238
	sub e			;a239
	rst 18h			;a23a
	sbc a,l			;a23b
	adc a,l			;a23c
	sub b			;a23d
	adc a,e			;a23e
	sbc a,(hl)			;a23f
	rst 18h			;a240
	adc a,d			;a241
	sub c			;a242
	sbc a,(hl)			;a243
	rst 18h			;a244
	adc a,l			;a245
	sbc a,d			;a246
	adc a,h			;a247
	sub (hl)			;a248
	sub c			;a249
	sbc a,(hl)			;a24a
	push af			;a24b
	cp h			;a24c
	sub (hl)			;a24d
	sbc a,d			;a24e
	adc a,l			;a24f
	adc a,l			;a250
	sbc a,(hl)			;a251
	rst 18h			;a252
	sbc a,d			;a253
	sub e			;a254
	rst 18h			;a255
	sub l			;a256
	adc a,d			;a257
	sbc a,d			;a258
	sbc a,b			;a259
	sub b			;a25a
	rst 18h			;a25b
	adc a,a			;a25c
	sub b			;a25d
	adc a,l			;a25e
	rst 18h			;a25f
	sbc a,d			;a260
	sub e			;a261
	rst 18h			;a262
	or c			;a263
	sub b			;a264
	adc a,l			;a265
	adc a,e			;a266
	sbc a,d			;a267
	rst 18h			;a268
	add a,(hl)			;a269
	rst 18h			;a26a
	adc a,e			;a26b
	sub (hl)			;a26c
	sbc a,d			;a26d
	sub c			;a26e
	sbc a,d			;a26f
	rst 18h			;a270
	sbc a,b			;a271
	adc a,l			;a272
	sbc a,(hl)			;a273
	sbc a,l			;a274
	sbc a,(hl)			;a275
	sbc a,e			;a276
	sub b			;a277
	adc a,h			;a278
	rst 18h			;a279
	sbc a,e			;a27a
	sbc a,d			;a27b
	rst 18h			;a27c
	sbc a,(hl)			;a27d
	sub c			;a27e
	sub (hl)			;a27f
	sub d			;a280
	sbc a,(hl)			;a281
	sub e			;a282
	sbc a,d			;a283
	adc a,h			;a284
	pop de			;a285
	push af			;a286
	push af			;a287
	cp d			;a288
	sub e			;a289
	rst 18h			;a28a
	sub d			;a28b
	sbc a,(hl)			;a28c
	adc a,l			;a28d
	sbc a,h			;a28e
	sub b			;a28f
	rst 18h			;a290
	sbc a,d			;a291
	adc a,h			;a292
	adc a,e			;a293
	jp pe,092dfh		;a294
	adc a,d			;a297
	add a,(hl)			;a298
	rst 18h			;a299
	sbc a,e			;a29a
	sbc a,d			;a29b
	adc a,e			;a29c
	sbc a,d			;a29d
	adc a,l			;a29e
	sub (hl)			;a29f
	sub b			;a2a0
	adc a,l			;a2a1
	sbc a,(hl)			;a2a2
	sbc a,e			;a2a3
	sub b			;a2a4
	pop de			;a2a5
	rst 18h			;a2a6
	or e			;a2a7
	sbc a,(hl)			;a2a8
	adc a,h			;a2a9
	rst 18h			;a2aa
	sbc a,c			;a2ab
	sub (hl)			;a2ac
	sbc a,b			;a2ad
	adc a,d			;a2ae
	adc a,l			;a2af
	sbc a,(hl)			;a2b0
	adc a,h			;a2b1
	rst 18h			;a2b2
	sbc a,e			;a2b3
	sbc a,d			;a2b4
	rst 18h			;a2b5
	sbc a,(hl)			;a2b6
	adc a,l			;a2b7
	jp pe,0919ch		;a2b8
	sub (hl)			;a2bb
	sbc a,e			;a2bc
	sub b			;a2bd
	adc a,h			;a2be
	rst 18h			;a2bf
	adc a,(hl)			;a2c0
	adc a,d			;a2c1
	sbc a,d			;a2c2
	rst 18h			;a2c3
	sub e			;a2c4
	sub b			;a2c5
	rst 18h			;a2c6
	sbc a,e			;a2c7
	sbc a,d			;a2c8
	sbc a,h			;a2c9
	sub b			;a2ca
	adc a,l			;a2cb
	sbc a,(hl)			;a2cc
	sbc a,l			;a2cd
	sbc a,(hl)			;a2ce
	sub c			;a2cf
	rst 18h			;a2d0
	sbc a,d			;a2d1
	adc a,h			;a2d2
	adc a,e			;a2d3
	jp pe,0df91h		;a2d4
	sub d			;a2d7
	adc a,d			;a2d8
	add a,(hl)			;a2d9
	rst 18h			;a2da
	sbc a,d			;a2db
	adc a,h			;a2dc
	adc a,e			;a2dd
	adc a,l			;a2de
	sub b			;a2df
	adc a,a			;a2e0
	sbc a,d			;a2e1
	sbc a,(hl)			;a2e2
	sbc a,e			;a2e3
	sbc a,(hl)			;a2e4
	adc a,h			;a2e5
	pop de			;a2e6
	push af			;a2e7
	rst 18h			;a2e8
	or a			;a2e9
	sbc a,(hl)			;a2ea
	add a,(hl)			;a2eb
	rst 18h			;a2ec
	adc a,d			;a2ed
	sub c			;a2ee
	sbc a,(hl)			;a2ef
	rst 18h			;a2f0
	sbc a,l			;a2f1
	sub (hl)			;a2f2
	sbc a,d			;a2f3
	sub c			;a2f4
	rst 18h			;a2f5
	sbc a,h			;a2f6
	sub b			;a2f7
	sub c			;a2f8
	adc a,h			;a2f9
	sbc a,d			;a2fa
	adc a,l			;a2fb
	adc a,c			;a2fc
	sbc a,(hl)			;a2fd
	sbc a,e			;a2fe
	sbc a,(hl)			;a2ff
	rst 18h			;a300
	adc a,(hl)			;a301
	adc a,d			;a302
	sbc a,d			;a303
	rst 18h			;a304
	sbc a,d			;a305
	adc a,h			;a306
	adc a,e			;a307
	jp pe,09cdfh		;a308
	sbc a,(hl)			;a30b
	adc a,h			;a30c
	sub (hl)			;a30d
	rst 18h			;a30e
	adc a,h			;a30f
	adc a,d			;a310
	sbc a,d			;a311
	sub e			;a312
	adc a,e			;a313
	sbc a,(hl)			;a314
	pop de			;a315
	rst 18h			;a316
	push af			;a317
	or a			;a318
	sub b			;a319
	add a,(hl)			;a31a
	rst 18h			;a31b
	adc a,h			;a31c
	rst 20h			;a31d
	sub e			;a31e
	sub b			;a31f
	rst 18h			;a320
	adc a,(hl)			;a321
	adc a,d			;a322
	sbc a,d			;a323
	sbc a,e			;a324
	sbc a,(hl)			;a325
	sub c			;a326
	rst 18h			;a327
	sub e			;a328
	sub b			;a329
	adc a,h			;a32a
	rst 18h			;a32b
	sub d			;a32c
	adc a,d			;a32d
	adc a,l			;a32e
	sub b			;a32f
	adc a,h			;a330
	rst 18h			;a331
	sbc a,e			;a332
	sbc a,d			;a333
	sub e			;a334
	rst 18h			;a335
	sub d			;a336
	sbc a,(hl)			;a337
	adc a,l			;a338
	sbc a,h			;a339
	sub b			;a33a
	rst 18h			;a33b
	sub e			;a33c
	sub e			;a33d
	sbc a,d			;a33e
	sub c			;a33f
	sub b			;a340
	adc a,h			;a341
	rst 18h			;a342
	sbc a,e			;a343
	sbc a,d			;a344
	rst 18h			;a345
	adc a,e			;a346
	sbc a,d			;a347
	sub e			;a348
	sbc a,(hl)			;a349
	adc a,l			;a34a
	sbc a,(hl)			;a34b
	push hl			;a34c
	sbc a,(hl)			;a34d
	adc a,h			;a34e
	pop de			;a34f
	push af			;a350
	push af			;a351
	cp h			;a352
	sub b			;a353
	sub c			;a354
	rst 18h			;a355
	sbc a,(hl)			;a356
	sub e			;a357
	sbc a,(hl)			;a358
	adc a,l			;a359
	sbc a,b			;a35a
	sbc a,(hl)			;a35b
	sbc a,e			;a35c
	sbc a,(hl)			;a35d
	adc a,h			;a35e
	rst 18h			;a35f
	adc a,c			;a360
	sbc a,d			;a361
	sub c			;a362
	adc a,e			;a363
	sbc a,(hl)			;a364
	sub c			;a365
	sbc a,(hl)			;a366
	adc a,h			;a367
	pop de			;a368
	push af			;a369
	cp d			;a36a
	sub c			;a36b
	rst 18h			;a36c
	adc a,c			;a36d
	sbc a,d			;a36e
	add a,l			;a36f
	rst 18h			;a370
	sbc a,e			;a371
	sbc a,d			;a372
	rst 18h			;a373
	adc a,c			;a374
	sbc a,d			;a375
	sub c			;a376
	adc a,e			;a377
	sbc a,(hl)			;a378
	sub c			;a379
	sbc a,(hl)			;a37a
	rst 18h			;a37b
	sub a			;a37c
	sbc a,(hl)			;a37d
	add a,(hl)			;a37e
	rst 18h			;a37f
	adc a,d			;a380
	sub c			;a381
	sbc a,(hl)			;a382
	rst 18h			;a383
	sub (hl)			;a384
	sub d			;a385
	sbc a,(hl)			;a386
	sbc a,b			;a387
	sbc a,d			;a388
	sub c			;a389
	rst 18h			;a38a
	sbc a,e			;a38b
	sbc a,d			;a38c
	rst 18h			;a38d
	or h			;a38e
	adc a,d			;a38f
	sub h			;a390
	adc a,d			;a391
	sub e			;a392
	sub h			;a393
	sbc a,(hl)			;a394
	sub c			;a395
	pop de			;a396
	push af			;a397
	or e			;a398
	sub (hl)			;a399
	sub c			;a39a
	sbc a,d			;a39b
	sbc a,(hl)			;a39c
	adc a,h			;a39d
	rst 18h			;a39e
	add a,(hl)			;a39f
	rst 18h			;a3a0
	adc a,e			;a3a1
	adc a,l			;a3a2
	sbc a,(hl)			;a3a3
	sub d			;a3a4
	sbc a,(hl)			;a3a5
	adc a,h			;a3a6
	rst 18h			;a3a7
	adc a,h			;a3a8
	sbc a,d			;a3a9
	rst 18h			;a3aa
	sbc a,d			;a3ab
	sub c			;a3ac
	adc a,e			;a3ad
	adc a,l			;a3ae
	sbc a,d			;a3af
	sub d			;a3b0
	sbc a,d			;a3b1
	add a,l			;a3b2
	sbc a,h			;a3b3
	sub e			;a3b4
	sbc a,(hl)			;a3b5
	sub c			;a3b6
	rst 18h			;a3b7
	sbc a,d			;a3b8
	sub c			;a3b9
	rst 18h			;a3ba
	adc a,d			;a3bb
	sub c			;a3bc
	sbc a,(hl)			;a3bd
	rst 18h			;a3be
	sbc a,h			;a3bf
	sub b			;a3c0
	sub c			;a3c1
	sbc a,c			;a3c2
	adc a,d			;a3c3
	adc a,h			;a3c4
	sbc a,(hl)			;a3c5
	rst 18h			;a3c6
	sbc a,(hl)			;a3c7
	sub d			;a3c8
	sbc a,(hl)			;a3c9
	sub e			;a3ca
	sbc a,b			;a3cb
	sbc a,(hl)			;a3cc
	sub d			;a3cd
	sbc a,(hl)			;a3ce
	pop de			;a3cf
	push af			;a3d0
	or e			;a3d1
	sbc a,(hl)			;a3d2
	rst 18h			;a3d3
	sub e			;a3d4
	adc a,d			;a3d5
	add a,l			;a3d6
	rst 18h			;a3d7
	sbc a,e			;a3d8
	sbc a,d			;a3d9
	rst 18h			;a3da
	sub e			;a3db
	sbc a,(hl)			;a3dc
	rst 18h			;a3dd
	sbc a,l			;a3de
	sub b			;a3df
	adc a,l			;a3e0
	sub e			;a3e1
	sbc a,(hl)			;a3e2
	rst 18h			;a3e3
	adc a,l			;a3e4
	sbc a,d			;a3e5
	adc a,h			;a3e6
	sbc a,(hl)			;a3e7
	sub e			;a3e8
	adc a,e			;a3e9
	sbc a,(hl)			;a3ea
	rst 18h			;a3eb
	adc a,d			;a3ec
	sub c			;a3ed
	sub b			;a3ee
	adc a,h			;a3ef
	rst 18h			;a3f0
	adc a,h			;a3f1
	ret pe			;a3f2
	sub d			;a3f3
	sbc a,l			;a3f4
	sub b			;a3f5
	sub e			;a3f6
	sub b			;a3f7
	adc a,h			;a3f8
	out (0dfh),a		;a3f9
	adc a,a			;a3fb
	sbc a,d			;a3fc
	adc a,l			;a3fd
	sub b			;a3fe
	rst 18h			;a3ff
	sbc a,d			;a400
	adc a,h			;a401
	adc a,e			;a402
	jp pe,0df8ch		;a403
	sub d			;a406
	adc a,d			;a407
	add a,(hl)			;a408
	rst 18h			;a409
	sbc a,h			;a40a
	sbc a,d			;a40b
	adc a,l			;a40c
	sbc a,h			;a40d
	sbc a,(hl)			;a40e
	pop de			;a40f
	push af			;a410
	or e			;a411
	sbc a,(hl)			;a412
	adc a,h			;a413
	rst 18h			;a414
	sub e			;a415
	sub b			;a416
	adc a,h			;a417
	sbc a,(hl)			;a418
	adc a,h			;a419
	rst 18h			;a41a
	sbc a,c			;a41b
	sub b			;a41c
	adc a,l			;a41d
	sub d			;a41e
	sbc a,(hl)			;a41f
	sub c			;a420
	rst 18h			;a421
	adc a,d			;a422
	sub c			;a423
	rst 18h			;a424
	adc a,e			;a425
	sbc a,(hl)			;a426
	sbc a,l			;a427
	sub e			;a428
	sbc a,d			;a429
	adc a,l			;a42a
	sub b			;a42b
	pop de			;a42c
	push af			;a42d
	cp b			;a42e
	adc a,l			;a42f
	sbc a,(hl)			;a430
	sub c			;a431
	sbc a,e			;a432
	sbc a,d			;a433
	rst 18h			;a434
	add a,(hl)			;a435
	rst 18h			;a436
	sub b			;a437
	add a,a			;a438
	sub (hl)			;a439
	sbc a,e			;a43a
	sbc a,(hl)			;a43b
	sbc a,e			;a43c
	sbc a,(hl)			;a43d
	pop de			;a43e
	push af			;a43f
	cp e			;a440
	sbc a,d			;a441
	sbc a,h			;a442
	sub b			;a443
	adc a,l			;a444
	sbc a,(hl)			;a445
	sbc a,e			;a446
	sbc a,(hl)			;a447
	adc a,h			;a448
	rst 18h			;a449
	sbc a,h			;a44a
	sub b			;a44b
	sub c			;a44c
	rst 18h			;a44d
	sbc a,l			;a44e
	sbc a,(hl)			;a44f
	sub l			;a450
	sub b			;a451
	adc a,l			;a452
	adc a,l			;a453
	sbc a,d			;a454
	sub e			;a455
	sub (hl)			;a456
	sbc a,d			;a457
	adc a,c			;a458
	sbc a,d			;a459
	adc a,h			;a45a
	rst 18h			;a45b
	sbc a,e			;a45c
	sbc a,d			;a45d
	rst 18h			;a45e
	sub e			;a45f
	sbc a,(hl)			;a460
	adc a,h			;a461
	rst 18h			;a462
	rst 20h			;a463
	adc a,l			;a464
	sbc a,e			;a465
	sbc a,d			;a466
	sub c			;a467
	sbc a,d			;a468
	adc a,h			;a469
	rst 18h			;a46a
	sbc a,e			;a46b
	sbc a,d			;a46c
	sub e			;a46d
	rst 18h			;a46e
	jp pe,08a98h		;a46f
	sub (hl)			;a472
	sub e			;a473
	sbc a,(hl)			;a474
	pop de			;a475
	push af			;a476
	xor h			;a477
	sub b			;a478
	sub c			;a479
	rst 18h			;a47a
	adc a,h			;a47b
	sbc a,d			;a47c
	adc a,l			;a47d
	adc a,a			;a47e
	sub (hl)			;a47f
	sbc a,d			;a480
	sub c			;a481
	adc a,e			;a482
	sbc a,d			;a483
	adc a,h			;a484
	rst 18h			;a485
	sbc a,d			;a486
	sub d			;a487
	adc a,a			;a488
	sub e			;a489
	adc a,d			;a48a
	sub d			;a48b
	sbc a,(hl)			;a48c
	sbc a,e			;a48d
	sbc a,(hl)			;a48e
	adc a,h			;a48f
	rst 18h			;a490
	sbc a,(hl)			;a491
	adc a,a			;a492
	sub b			;a493
	add a,(hl)			;a494
	sbc a,(hl)			;a495
	sbc a,e			;a496
	sbc a,(hl)			;a497
	adc a,h			;a498
	rst 18h			;a499
	sbc a,d			;a49a
	sub c			;a49b
	rst 18h			;a49c
	sub e			;a49d
	sbc a,(hl)			;a49e
	adc a,h			;a49f
	rst 18h			;a4a0
	sbc a,h			;a4a1
	sbc a,(hl)			;a4a2
	sbc a,l			;a4a3
	sbc a,d			;a4a4
	add a,l			;a4a5
	sbc a,(hl)			;a4a6
	adc a,h			;a4a7
	pop de			;a4a8
	push af			;a4a9
	cp c			;a4aa
	sub e			;a4ab
	sbc a,(hl)			;a4ac
	sub c			;a4ad
	adc a,(hl)			;a4ae
	adc a,d			;a4af
	sbc a,d			;a4b0
	sbc a,(hl)			;a4b1
	sbc a,e			;a4b2
	sub b			;a4b3
	rst 18h			;a4b4
	adc a,a			;a4b5
	sub b			;a4b6
	adc a,l			;a4b7
	rst 18h			;a4b8
	sbc a,e			;a4b9
	sub b			;a4ba
	adc a,h			;a4bb
	rst 18h			;a4bc
	sbc a,b			;a4bd
	adc a,l			;a4be
	sbc a,(hl)			;a4bf
	sub c			;a4c0
	sbc a,e			;a4c1
	sbc a,d			;a4c2
	adc a,h			;a4c3
	rst 18h			;a4c4
	sbc a,h			;a4c5
	sub b			;a4c6
	sub e			;a4c7
	adc a,d			;a4c8
	sub d			;a4c9
	sub c			;a4ca
	sbc a,(hl)			;a4cb
	adc a,h			;a4cc
	pop de			;a4cd
	push af			;a4ce
	cp d			;a4cf
	adc a,h			;a4d0
	rst 18h			;a4d1
	adc a,d			;a4d2
	sub c			;a4d3
	sbc a,(hl)			;a4d4
	rst 18h			;a4d5
	sbc a,d			;a4d6
	adc a,h			;a4d7
	adc a,e			;a4d8
	sbc a,(hl)			;a4d9
	adc a,e			;a4da
	adc a,d			;a4db
	sbc a,(hl)			;a4dc
	rst 18h			;a4dd
	add a,(hl)			;a4de
	sbc a,(hl)			;a4df
	sbc a,h			;a4e0
	sbc a,d			;a4e1
	sub c			;a4e2
	adc a,e			;a4e3
	sbc a,d			;a4e4
	rst 18h			;a4e5
	sbc a,e			;a4e6
	sbc a,d			;a4e7
	sub e			;a4e8
	rst 18h			;a4e9
	cp h			;a4ea
	sub a			;a4eb
	sbc a,(hl)			;a4ec
	sbc a,h			;a4ed
	jp nc,090b2h		;a4ee
	sub b			;a4f1
	sub e			;a4f2
	pop de			;a4f3
	push af			;a4f4
	push af			;a4f5
	push af			;a4f6
	push af			;a4f7
	push af			;a4f8
	push af			;a4f9
	push af			;a4fa
	cp h			;a4fb
	sub b			;a4fc
	sub c			;a4fd
	rst 18h			;a4fe
	adc a,d			;a4ff
	sub c			;a500
	sbc a,(hl)			;a501
	rst 18h			;a502
	sub (hl)			;a503
	sub c			;a504
	adc a,e			;a505
	sbc a,d			;a506
	adc a,l			;a507
	sbc a,d			;a508
	adc a,h			;a509
	sbc a,(hl)			;a50a
	sub c			;a50b
	adc a,e			;a50c
	sbc a,d			;a50d
	rst 18h			;a50e
	adc a,c			;a50f
	sub (hl)			;a510
	adc a,h			;a511
	adc a,e			;a512
	sbc a,(hl)			;a513
	rst 18h			;a514
	sub a			;a515
	sbc a,(hl)			;a516
	sbc a,h			;a517
	sub (hl)			;a518
	sbc a,(hl)			;a519
	rst 18h			;a51a
	adc a,c			;a51b
	sbc a,(hl)			;a51c
	adc a,l			;a51d
	sub (hl)			;a51e
	sub b			;a51f
	adc a,h			;a520
	rst 18h			;a521
	sbc a,d			;a522
	sbc a,e			;a523
	sub (hl)			;a524
	sbc a,c			;a525
	sub (hl)			;a526
	sbc a,h			;a527
	sub (hl)			;a528
	sub b			;a529
	adc a,h			;a52a
	pop de			;a52b
	push af			;a52c
	cp c			;a52d
	sub b			;a52e
	adc a,l			;a52f
	sub d			;a530
	sbc a,(hl)			;a531
	sub c			;a532
	rst 18h			;a533
	sbc a,e			;a534
	sub b			;a535
	adc a,h			;a536
	rst 18h			;a537
	sub a			;a538
	sub (hl)			;a539
	sub e			;a53a
	sbc a,d			;a53b
	adc a,l			;a53c
	sbc a,(hl)			;a53d
	adc a,h			;a53e
	rst 18h			;a53f
	sbc a,(hl)			;a540
	sbc a,e			;a541
	add a,(hl)			;a542
	sbc a,(hl)			;a543
	sbc a,h			;a544
	sbc a,d			;a545
	sub c			;a546
	adc a,e			;a547
	sbc a,d			;a548
	adc a,h			;a549
	rst 18h			;a54a
	sbc a,e			;a54b
	sbc a,d			;a54c
	rst 18h			;a54d
	adc a,0cfh		;a54e
	rst 18h			;a550
	sbc a,h			;a551
	sub b			;a552
	sub e			;a553
	adc a,d			;a554
	sub d			;a555
	sub c			;a556
	sbc a,(hl)			;a557
	adc a,h			;a558
	rst 18h			;a559
	sub d			;a55a
	sbc a,(hl)			;a55b
	adc a,l			;a55c
	sbc a,h			;a55d
	sbc a,(hl)			;a55e
	sbc a,e			;a55f
	sbc a,(hl)			;a560
	adc a,h			;a561
	rst 18h			;a562
	sbc a,e			;a563
	sbc a,d			;a564
	sub e			;a565
	rst 18h			;a566
	sbc a,h			;a567
	sbc a,d			;a568
	adc a,l			;a569
	sub b			;a56a
	rst 18h			;a56b
	sbc a,(hl)			;a56c
	sub e			;a56d
	rst 18h			;a56e
	sub c			;a56f
	adc a,d			;a570
	sbc a,d			;a571
	adc a,c			;a572
	sbc a,d			;a573
	rst 18h			;a574
	sbc a,d			;a575
	sub c			;a576
	rst 18h			;a577
	sub d			;a578
	sbc a,(hl)			;a579
	add a,(hl)			;a57a
	sbc a,(hl)			;a57b
	pop de			;a57c
	push af			;a57d
	xor d			;a57e
	sub c			;a57f
	sbc a,(hl)			;a580
	rst 18h			;a581
	adc a,e			;a582
	sub (hl)			;a583
	sbc a,d			;a584
	sub c			;a585
	sbc a,d			;a586
	rst 18h			;a587
	adc a,d			;a588
	sub c			;a589
	sbc a,(hl)			;a58a
	rst 18h			;a58b
	sbc a,h			;a58c
	sub a			;a58d
	sbc a,(hl)			;a58e
	adc a,a			;a58f
	sbc a,(hl)			;a590
	rst 18h			;a591
	sbc a,h			;a592
	sub b			;a593
	sub c			;a594
	rst 18h			;a595
	adc a,d			;a596
	sub c			;a597
	sbc a,(hl)			;a598
	rst 18h			;a599
	adc a,l			;a59a
	sbc a,(hl)			;a59b
	sub c			;a59c
	adc a,d			;a59d
	adc a,l			;a59e
	sbc a,(hl)			;a59f
	pop de			;a5a0
	push af			;a5a1
	cp e			;a5a2
	sbc a,d			;a5a3
	adc a,h			;a5a4
	adc a,e			;a5a5
	adc a,l			;a5a6
	adc a,d			;a5a7
	sub (hl)			;a5a8
	sbc a,e			;a5a9
	sbc a,(hl)			;a5aa
	adc a,h			;a5ab
	rst 18h			;a5ac
	add a,(hl)			;a5ad
	rst 18h			;a5ae
	adc a,c			;a5af
	sbc a,(hl)			;a5b0
	sbc a,h			;a5b1
	ret pe			;a5b2
	sbc a,(hl)			;a5b3
	adc a,h			;a5b4
	pop de			;a5b5
	push af			;a5b6
	cp d			;a5b7
	sub e			;a5b8
	rst 18h			;a5b9
	sbc a,h			;a5ba
	sub b			;a5bb
	sub e			;a5bc
	sub b			;a5bd
	adc a,l			;a5be
	rst 18h			;a5bf
	sbc a,e			;a5c0
	sbc a,d			;a5c1
	sub e			;a5c2
	rst 18h			;a5c3
	sbc a,h			;a5c4
	adc a,l			;a5c5
	sub (hl)			;a5c6
	adc a,h			;a5c7
	adc a,e			;a5c8
	sbc a,(hl)			;a5c9
	sub e			;a5ca
	rst 18h			;a5cb
	sbc a,e			;a5cc
	sbc a,d			;a5cd
	adc a,h			;a5ce
	adc a,e			;a5cf
	sbc a,(hl)			;a5d0
	sbc a,h			;a5d1
	sbc a,(hl)			;a5d2
	rst 18h			;a5d3
	adc a,d			;a5d4
	sub c			;a5d5
	sbc a,(hl)			;a5d6
	rst 18h			;a5d7
	sbc a,d			;a5d8
	adc a,h			;a5d9
	sbc a,h			;a5da
	sbc a,d			;a5db
	sub c			;a5dc
	sbc a,(hl)			;a5dd
	rst 18h			;a5de
	sbc a,d			;a5df
	sub c			;a5e0
	rst 18h			;a5e1
	sub e			;a5e2
	sbc a,(hl)			;a5e3
	rst 18h			;a5e4
	adc a,(hl)			;a5e5
	adc a,d			;a5e6
	sbc a,d			;a5e7
	rst 18h			;a5e8
	adc a,h			;a5e9
	sbc a,d			;a5ea
	rst 18h			;a5eb
	adc a,c			;a5ec
	sbc a,d			;a5ed
	push bc			;a5ee
	push af			;a5ef
	cp (hl)			;a5f0
	rst 18h			;a5f1
	adc a,d			;a5f2
	sub c			;a5f3
	rst 18h			;a5f4
	adc a,a			;a5f5
	sbc a,d			;a5f6
	adc a,l			;a5f7
	adc a,h			;a5f8
	sub b			;a5f9
	sub c			;a5fa
	sbc a,(hl)			;a5fb
	sub l			;a5fc
	sbc a,d			;a5fd
	rst 18h			;a5fe
	push af			;a5ff
	cp (hl)			;a600
	rst 18h			;a601
	cp h			;a602
	sub a			;a603
	sbc a,(hl)			;a604
	sbc a,h			;a605
	rst 18h			;a606
	or d			;a607
	sub b			;a608
	sub b			;a609
	sub e			;a60a
	rst 18h			;a60b
	adc a,l			;a60c
	sbc a,d			;a60d
	sbc a,h			;a60e
	sub b			;a60f
	adc a,h			;a610
	adc a,e			;a611
	sbc a,(hl)			;a612
	sbc a,e			;a613
	sub b			;a614
	rst 18h			;a615
	sub (hl)			;a616
	adc a,l			;a617
	adc a,l			;a618
	sbc a,(hl)			;a619
	sbc a,e			;a61a
	sub (hl)			;a61b
	sbc a,(hl)			;a61c
	sub c			;a61d
	sbc a,e			;a61e
	sub b			;a61f
	rst 18h			;a620
	sbc a,d			;a621
	sub c			;a622
	sbc a,d			;a623
	adc a,l			;a624
	sbc a,b			;a625
	ret pe			;a626
	sbc a,(hl)			;a627
	pop de			;a628
	push af			;a629
	sbc a,h			;a62a
	sub b			;a62b
	sbc a,b			;a62c
	sub (hl)			;a62d
	sbc a,d			;a62e
	sub c			;a62f
	sbc a,e			;a630
	sub b			;a631
	rst 18h			;a632
	push af			;a633
	push af			;a634
	sbc a,(hl)			;a635
	adc a,l			;a636
	adc a,l			;a637
	sbc a,(hl)			;a638
	sub c			;a639
	sbc a,h			;a63a
	sbc a,(hl)			;a63b
	sub c			;a63c
	sbc a,e			;a63d
	sub b			;a63e
	rst 18h			;a63f
	sub e			;a640
	sbc a,(hl)			;a641
	rst 18h			;a642
	sbc a,h			;a643
	sub b			;a644
	adc a,l			;a645
	adc a,e			;a646
	sbc a,d			;a647
	add a,l			;a648
	sbc a,(hl)			;a649
	rst 18h			;a64a
	sbc a,e			;a64b
	push af			;a64c
	sbc a,d			;a64d
	sub c			;a64e
	adc a,e			;a64f
	adc a,l			;a650
	sbc a,(hl)			;a651
	sub c			;a652
	sbc a,e			;a653
	sub b			;a654
	rst 18h			;a655
	sbc a,d			;a656
	sub c			;a657
	rst 18h			;a658
	adc a,e			;a659
	adc a,l			;a65a
	sbc a,(hl)			;a65b
	sub c			;a65c
	sbc a,h			;a65d
	sbc a,d			;a65e
	rst 18h			;a65f
	adc a,a			;a660
	sub b			;a661
	adc a,l			;a662
	rst 18h			;a663
	sub e			;a664
	sbc a,(hl)			;a665
	rst 18h			;a666
	push af			;a667
	push af			;a668
	adc a,d			;a669
	sub c			;a66a
	rst 18h			;a66b
	sbc a,c			;a66c
	adc a,l			;a66d
	adc a,d			;a66e
	adc a,e			;a66f
	sub b			;a670
	rst 18h			;a671
	sbc a,e			;a672
	sbc a,d			;a673
	rst 18h			;a674
	sbc a,h			;a675
	sbc a,(hl)			;a676
	sbc a,h			;a677
	sbc a,(hl)			;a678
	sub b			;a679
	pop de			;a67a
	push af			;a67b
	push af			;a67c
	adc a,d			;a67d
	sub c			;a67e
	sbc a,(hl)			;a67f
	rst 18h			;a680
	sbc a,c			;a681
	sub e			;a682
	sub b			;a683
	adc a,l			;a684
	rst 18h			;a685
	sbc a,e			;a686
	sbc a,d			;a687
	rst 18h			;a688
	adc a,a			;a689
	sbc a,d			;a68a
	add a,(hl)			;a68b
	sub b			;a68c
	adc a,e			;a68d
	sub e			;a68e
	push af			;a68f
	rst 18h			;a690
	sbc a,e			;a691
	sbc a,d			;a692
	adc a,h			;a693
	sbc a,d			;a694
	sbc a,h			;a695
	sbc a,(hl)			;a696
	sbc a,e			;a697
	sbc a,(hl)			;a698
	pop de			;a699
	push af			;a69a
	push af			;a69b
	sub (hl)			;a69c
	sub c			;a69d
	sbc a,b			;a69e
	sbc a,d			;a69f
	adc a,h			;a6a0
	adc a,e			;a6a1
	sub (hl)			;a6a2
	rst 20h			;a6a3
	sub c			;a6a4
	rst 18h			;a6a5
	sbc a,e			;a6a6
	sbc a,d			;a6a7
	rst 18h			;a6a8
	push af			;a6a9
	adc a,d			;a6aa
	sub c			;a6ab
	sbc a,(hl)			;a6ac
	rst 18h			;a6ad
	sbc a,l			;a6ae
	sbc a,d			;a6af
	sbc a,l			;a6b0
	sub (hl)			;a6b1
	sbc a,e			;a6b2
	sbc a,(hl)			;a6b3
	rst 18h			;a6b4
	sbc a,c			;a6b5
	sbc a,d			;a6b6
	adc a,l			;a6b7
	sub d			;a6b8
	sbc a,d			;a6b9
	sub c			;a6ba
	adc a,e			;a6bb
	sbc a,(hl)			;a6bc
	sbc a,e			;a6bd
	sbc a,(hl)			;a6be
	pop de			;a6bf
	push af			;a6c0
	cp (hl)			;a6c1
	rst 18h			;a6c2
	adc a,d			;a6c3
	sub c			;a6c4
	rst 18h			;a6c5
	sbc a,e			;a6c6
	sub (hl)			;a6c7
	sub b			;a6c8
	adc a,h			;a6c9
	rst 18h			;a6ca
	sbc a,l			;a6cb
	sbc a,d			;a6cc
	sbc a,l			;a6cd
	sub (hl)			;a6ce
	sbc a,d			;a6cf
	sub c			;a6d0
	sbc a,e			;a6d1
	sub b			;a6d2
	pop de			;a6d3
	push af			;a6d4
	sbc a,d			;a6d5
	sub e			;a6d6
	rst 18h			;a6d7
	adc a,e			;a6d8
	adc a,l			;a6d9
	sub b			;a6da
	sub c			;a6db
	sbc a,h			;a6dc
	sub b			;a6dd
	rst 18h			;a6de
	sbc a,e			;a6df
	sbc a,d			;a6e0
	rst 18h			;a6e1
	adc a,d			;a6e2
	sub c			;a6e3
	rst 18h			;a6e4
	jp pe,09d8dh		;a6e5
	sub b			;a6e8
	sub e			;a6e9
	pop de			;a6ea
	push af			;a6eb
	push af			;a6ec
	xor c			;a6ed
	sub (hl)			;a6ee
	adc a,h			;a6ef
	sub (hl)			;a6f0
	sub b			;a6f1
	sub c			;a6f2
	sbc a,d			;a6f3
	adc a,h			;a6f4
	rst 18h			;a6f5
	sbc a,e			;a6f6
	sbc a,d			;a6f7
	sub e			;a6f8
	rst 18h			;a6f9
	adc a,c			;a6fa
	sub (hl)			;a6fb
	adc a,c			;a6fc
	sub b			;a6fd
	rst 18h			;a6fe
	adc a,a			;a6ff
	sbc a,(hl)			;a700
	adc a,h			;a701
	sbc a,(hl)			;a702
	sbc a,e			;a703
	sub b			;a704
	rst 18h			;a705
	sub (hl)			;a706
	adc a,l			;a707
	adc a,l			;a708
	adc a,d			;a709
	sub d			;a70a
	adc a,a			;a70b
	sbc a,d			;a70c
	sub c			;a70d
	rst 18h			;a70e
	adc a,h			;a70f
	and 09dh		;a710
	sub (hl)			;a712
	adc a,e			;a713
	sbc a,(hl)			;a714
	sub d			;a715
	sbc a,d			;a716
	sub c			;a717
	adc a,e			;a718
	sbc a,d			;a719
	pop de			;a71a
	di			;a71b
	call p,09aafh		;a71c
	adc a,l			;a71f
	sub b			;a720
	rst 18h			;a721
	adc a,a			;a722
	adc a,l			;a723
	sub b			;a724
	sub c			;a725
	adc a,e			;a726
	sub b			;a727
	rst 18h			;a728
	adc a,c			;a729
	adc a,d			;a72a
	sbc a,d			;a72b
	sub e			;a72c
	adc a,c			;a72d
	sbc a,d			;a72e
	adc a,h			;a72f
	rst 18h			;a730
	sbc a,(hl)			;a731
	rst 18h			;a732
	sub e			;a733
	sbc a,(hl)			;a734
	adc a,h			;a735
	rst 18h			;a736
	adc a,h			;a737
	sub b			;a738
	sub e			;a739
	sub (hl)			;a73a
	adc a,e			;a73b
	sbc a,(hl)			;a73c
	adc a,l			;a73d
	sub (hl)			;a73e
	sbc a,(hl)			;a73f
	adc a,h			;a740
	rst 18h			;a741
	adc a,l			;a742
	adc a,d			;a743
	sub (hl)			;a744
	sub c			;a745
	sbc a,(hl)			;a746
	adc a,h			;a747
	pop de			;a748
	push af			;a749
	cp d			;a74a
	sub c			;a74b
	sbc a,h			;a74c
	adc a,d			;a74d
	sbc a,d			;a74e
	sub c			;a74f
	adc a,e			;a750
	adc a,l			;a751
	sbc a,(hl)			;a752
	rst 18h			;a753
	sub d			;a754
	sub (hl)			;a755
	rst 18h			;a756
	sub e			;a757
	adc a,d			;a758
	sbc a,b			;a759
	sbc a,(hl)			;a75a
	adc a,l			;a75b
	rst 18h			;a75c
	sbc a,e			;a75d
	sbc a,d			;a75e
	rst 18h			;a75f
	adc a,l			;a760
	sbc a,d			;a761
	adc a,a			;a762
	sub b			;a763
	adc a,h			;a764
	sub b			;a765
	push af			;a766
	xor e			;a767
	adc a,l			;a768
	sbc a,(hl)			;a769
	sbc a,d			;a76a
	rst 18h			;a76b
	sub e			;a76c
	sbc a,(hl)			;a76d
	rst 18h			;a76e
	sbc a,l			;a76f
	sbc a,d			;a770
	sbc a,l			;a771
	sub (hl)			;a772
	sbc a,e			;a773
	sbc a,(hl)			;a774
	rst 18h			;a775
	sbc a,e			;a776
	sbc a,d			;a777
	rst 18h			;a778
	sub e			;a779
	sub b			;a77a
	adc a,h			;a77b
	rst 18h			;a77c
	sbc a,e			;a77d
	sub (hl)			;a77e
	sub b			;a77f
	adc a,h			;a780
	sbc a,d			;a781
	adc a,h			;a782
	rst 18h			;a783
	add a,(hl)			;a784
	rst 18h			;a785
	adc a,e			;a786
	sbc a,d			;a787
	rst 18h			;a788
	sbc a,(hl)			;a789
	add a,(hl)			;a78a
	adc a,d			;a78b
	sbc a,e			;a78c
	sbc a,(hl)			;a78d
	adc a,l			;a78e
	jp (hl)			;a78f
	push af			;a790
	xor e			;a791
	sub b			;a792
	sub d			;a793
	sbc a,(hl)			;a794
	rst 18h			;a795
	sub d			;a796
	sub (hl)			;a797
	rst 18h			;a798
	xor a			;a799
	adc a,l			;a79a
	sbc a,d			;a79b
	adc a,h			;a79c
	sbc a,d			;a79d
	sub c			;a79e
	adc a,e			;a79f
	sbc a,d			;a7a0
	out (0dfh),a		;a7a1
	sbc a,b			;a7a3
	ret pe			;a7a4
	adc a,l			;a7a5
	sbc a,(hl)			;a7a6
	sub e			;a7a7
	sub b			;a7a8
	rst 18h			;a7a9
	add a,(hl)			;a7aa
	rst 18h			;a7ab
	adc a,c			;a7ac
	sub (hl)			;a7ad
	adc a,c			;a7ae
	sbc a,d			;a7af
	rst 18h			;a7b0
	sbc a,d			;a7b1
	sub e			;a7b2
	rst 18h			;a7b3
	xor a			;a7b4
	sbc a,(hl)			;a7b5
	adc a,h			;a7b6
	sbc a,(hl)			;a7b7
	sbc a,e			;a7b8
	sub b			;a7b9
	push af			;a7ba
	cp d			;a7bb
	sub c			;a7bc
	sbc a,h			;a7bd
	adc a,d			;a7be
	sbc a,d			;a7bf
	sub c			;a7c0
	adc a,e			;a7c1
	adc a,l			;a7c2
	sbc a,(hl)			;a7c3
	rst 18h			;a7c4
	sub d			;a7c5
	sub (hl)			;a7c6
	rst 18h			;a7c7
	sbc a,(hl)			;a7c8
	adc a,l			;a7c9
	sub d			;a7ca
	sbc a,(hl)			;a7cb
	push af			;a7cc
	cp e			;a7cd
	sbc a,d			;a7ce
	sbc a,l			;a7cf
	sub b			;a7d0
	rst 18h			;a7d1
	adc a,a			;a7d2
	adc a,d			;a7d3
	adc a,l			;a7d4
	sub (hl)			;a7d5
	sbc a,c			;a7d6
	sub (hl)			;a7d7
	sbc a,h			;a7d8
	sbc a,(hl)			;a7d9
	adc a,l			;a7da
	rst 18h			;a7db
	sub d			;a7dc
	sub (hl)			;a7dd
	rst 18h			;a7de
	sbc a,h			;a7df
	adc a,d			;a7e0
	sbc a,h			;a7e1
	sub a			;a7e2
	sub (hl)			;a7e3
	sub e			;a7e4
	sub e			;a7e5
	sub b			;a7e6
	rst 18h			;a7e7
	adc a,a			;a7e8
	adc a,l			;a7e9
	sub b			;a7ea
	sbc a,c			;a7eb
	sbc a,(hl)			;a7ec
	sub c			;a7ed
	sbc a,(hl)			;a7ee
	sbc a,e			;a7ef
	sub b			;a7f0
	push af			;a7f1
	cp d			;a7f2
	sub c			;a7f3
	rst 18h			;a7f4
	sbc a,(hl)			;a7f5
	sbc a,b			;a7f6
	adc a,l			;a7f7
	sbc a,(hl)			;a7f8
	sbc a,e			;a7f9
	sbc a,d			;a7fa
	sbc a,h			;a7fb
	sub (hl)			;a7fc
	sub d			;a7fd
	sub (hl)			;a7fe
	sbc a,d			;a7ff
	sub c			;a800
	adc a,e			;a801
	sub b			;a802
	rst 18h			;a803
	adc a,e			;a804
	sbc a,d			;a805
	rst 18h			;a806
	sbc a,e			;a807
	sub b			;a808
	add a,(hl)			;a809
	rst 18h			;a80a
	sub e			;a80b
	sbc a,(hl)			;a80c
	rst 18h			;a80d
	adc a,c			;a80e
	sub (hl)			;a80f
	adc a,h			;a810
	sub (hl)			;a811
	rst 20h			;a812
	sub c			;a813
	rst 18h			;a814
	sub e			;a815
	sbc a,d			;a816
	sub l			;a817
	sbc a,(hl)			;a818
	sub c			;a819
	sbc a,(hl)			;a81a
	push af			;a81b
	cp e			;a81c
	sbc a,(hl)			;a81d
	sub d			;a81e
	sbc a,d			;a81f
	rst 18h			;a820
	adc a,d			;a821
	sub c			;a822
	rst 18h			;a823
	sub b			;a824
	sbc a,l			;a825
	sub l			;a826
	sbc a,d			;a827
	adc a,e			;a828
	sub b			;a829
	rst 18h			;a82a
	sbc a,e			;a82b
	sbc a,d			;a82c
	rst 18h			;a82d
	sbc a,(hl)			;a82e
	sub d			;a82f
	sub b			;a830
	adc a,l			;a831
	push af			;a832
	or c			;a833
	sub b			;a834
	rst 18h			;a835
	sbc a,e			;a836
	sbc a,d			;a837
	sbc a,l			;a838
	sbc a,d			;a839
	rst 18h			;a83a
	adc a,h			;a83b
	sbc a,d			;a83c
	adc a,l			;a83d
	rst 18h			;a83e
	adc a,c			;a83f
	sbc a,(hl)			;a840
	sub e			;a841
	sub (hl)			;a842
	sub b			;a843
	adc a,h			;a844
	sub b			;a845
	out (0dfh),a		;a846
	adc a,a			;a848
	sbc a,d			;a849
	adc a,l			;a84a
	sub b			;a84b
	rst 18h			;a84c
	adc a,h			;a84d
	sub (hl)			;a84e
	rst 18h			;a84f
	sub a			;a850
	sbc a,d			;a851
	adc a,l			;a852
	sub d			;a853
	sub b			;a854
	adc a,h			;a855
	sub b			;a856
	push af			;a857
	xor e			;a858
	sub b			;a859
	sub d			;a85a
	sbc a,(hl)			;a85b
	rst 18h			;a85c
	sub e			;a85d
	sbc a,(hl)			;a85e
	rst 18h			;a85f
	sbc a,l			;a860
	sub b			;a861
	adc a,l			;a862
	sub e			;a863
	sbc a,(hl)			;a864
	rst 18h			;a865
	sbc a,d			;a866
	rst 18h			;a867
	sub (hl)			;a868
	sub e			;a869
	adc a,d			;a86a
	sub d			;a86b
	sub (hl)			;a86c
	sub c			;a86d
	sbc a,(hl)			;a86e
	rst 18h			;a86f
	sub e			;a870
	sbc a,(hl)			;a871
	rst 18h			;a872
	sub b			;a873
	adc a,h			;a874
	sbc a,h			;a875
	adc a,d			;a876
	adc a,l			;a877
	sbc a,(hl)			;a878
	rst 18h			;a879
	sub e			;a87a
	sub b			;a87b
	adc a,h			;a87c
	sbc a,(hl)			;a87d
	push af			;a87e
	push af			;a87f
	xor e			;a880
	adc a,l			;a881
	sbc a,(hl)			;a882
	sbc a,d			;a883
	rst 18h			;a884
	sbc a,d			;a885
	sub e			;a886
	rst 18h			;a887
	xor h			;a888
	adc a,d			;a889
	sbc a,e			;a88a
	sub b			;a88b
	adc a,l			;a88c
	rst 18h			;a88d
	sbc a,e			;a88e
	sbc a,d			;a88f
	sub e			;a890
	rst 18h			;a891
	xor h			;a892
	sub b			;a893
	sub e			;a894
	push af			;a895
	cp h			;a896
	adc a,d			;a897
	sbc a,l			;a898
	adc a,l			;a899
	sbc a,d			;a89a
	rst 18h			;a89b
	sbc a,d			;a89c
	sub e			;a89d
	rst 18h			;a89e
	adc a,h			;a89f
	sub b			;a8a0
	sub e			;a8a1
	rst 18h			;a8a2
	add a,(hl)			;a8a3
	rst 18h			;a8a4
	adc a,c			;a8a5
	sbc a,d			;a8a6
	sub c			;a8a7
	sbc a,e			;a8a8
	adc a,l			;a8a9
	jp pe,093dfh		;a8aa
	sbc a,(hl)			;a8ad
	rst 18h			;a8ae
	adc a,e			;a8af
	sub b			;a8b0
	adc a,l			;a8b1
	sub d			;a8b2
	sbc a,d			;a8b3
	sub c			;a8b4
	adc a,e			;a8b5
	sbc a,(hl)			;a8b6
	push af			;a8b7
	or d			;a8b8
	sub b			;a8b9
	adc a,l			;a8ba
	adc a,e			;a8bb
	jp nc,09e8bh		;a8bc
	sub e			;a8bf
	out (0dfh),a		;a8c0
	sbc a,e			;a8c2
	sbc a,(hl)			;a8c3
	sub c			;a8c4
	sub b			;a8c5
	adc a,h			;a8c6
	adc a,h			;a8c7
	rst 18h			;a8c8
	sub a			;a8c9
	adc a,d			;a8ca
	sub d			;a8cb
	sub b			;a8cc
	out (0dfh),a		;a8cd
	xor 0b7h		;a8cf
	sub (hl)			;a8d1
	sbc a,h			;a8d2
	adc a,h			;a8d3
	sbc a,0f5h		;a8d4
	xor a			;a8d6
	sub b			;a8d7
	adc a,l			;a8d8
	rst 18h			;a8d9
	adc a,d			;a8da
	sub c			;a8db
	rst 18h			;a8dc
	sbc a,c			;a8dd
	sub (hl)			;a8de
	sbc a,b			;a8df
	sbc a,(hl)			;a8e0
	adc a,l			;a8e1
	adc a,l			;a8e2
	sub b			;a8e3
	rst 18h			;a8e4
	adc a,e			;a8e5
	sbc a,d			;a8e6
	rst 18h			;a8e7
	sbc a,e			;a8e8
	sbc a,(hl)			;a8e9
	adc a,l			;a8ea
	sbc a,d			;a8eb
	sub d			;a8ec
	sub b			;a8ed
	adc a,h			;a8ee
	rst 18h			;a8ef
	sbc a,d			;a8f0
	sub e			;a8f1
	rst 18h			;a8f2
	adc a,a			;a8f3
	sub b			;a8f4
	sbc a,e			;a8f5
	sbc a,d			;a8f6
	adc a,l			;a8f7
	rst 18h			;a8f8
	sbc a,e			;a8f9
	sbc a,d			;a8fa
	sub e			;a8fb
	rst 18h			;a8fc
	adc a,a			;a8fd
	sbc a,c			;a8fe
	adc a,d			;a8ff
	sbc a,d			;a900
	sbc a,b			;a901
	sub b			;a902
	push af			;a903
	xor e			;a904
	sbc a,d			;a905
	sub c			;a906
	rst 18h			;a907
	sub e			;a908
	sbc a,(hl)			;a909
	rst 18h			;a90a
	adc a,a			;a90b
	sbc a,c			;a90c
	sub (hl)			;a90d
	adc a,a			;a90e
	sbc a,(hl)			;a90f
	rst 18h			;a910
	sbc a,e			;a911
	sbc a,d			;a912
	sub e			;a913
	rst 18h			;a914
	adc a,a			;a915
	sbc a,c			;a916
	adc a,d			;a917
	sbc a,d			;a918
	sbc a,b			;a919
	sub b			;a91a
	rst 18h			;a91b
	sbc a,d			;a91c
	adc a,e			;a91d
	jp nc,09a8bh		;a91e
	adc a,l			;a921
	sub c			;a922
	sub b			;a923
	push af			;a924
	push af			;a925
	xor e			;a926
	adc a,l			;a927
	sbc a,(hl)			;a928
	sbc a,d			;a929
	rst 18h			;a92a
	adc a,d			;a92b
	sub c			;a92c
	sbc a,(hl)			;a92d
	rst 18h			;a92e
	adc a,a			;a92f
	sbc a,d			;a930
	sub e			;a931
	sub b			;a932
	adc a,e			;a933
	sbc a,(hl)			;a934
	rst 18h			;a935
	sbc a,e			;a936
	sbc a,d			;a937
	rst 18h			;a938
	sbc a,h			;a939
	sbc a,(hl)			;a93a
	adc a,d			;a93b
	sbc a,h			;a93c
	sub a			;a93d
	sub b			;a93e
	push af			;a93f
	xor e			;a940
	sub b			;a941
	sub d			;a942
	sbc a,(hl)			;a943
	rst 18h			;a944
	sub e			;a945
	sbc a,(hl)			;a946
	rst 18h			;a947
	sub e			;a948
	sub e			;a949
	sbc a,(hl)			;a94a
	adc a,c			;a94b
	sbc a,d			;a94c
	rst 18h			;a94d
	sbc a,e			;a94e
	sbc a,d			;a94f
	rst 18h			;a950
	adc a,e			;a951
	adc a,d			;a952
	rst 18h			;a953
	sbc a,e			;a954
	sbc a,d			;a955
	adc a,h			;a956
	adc a,e			;a957
	sub (hl)			;a958
	sub c			;a959
	sub b			;a95a
	push af			;a95b
	xor h			;a95c
	sbc a,d			;a95d
	rst 18h			;a95e
	adc a,c			;a95f
	sbc a,(hl)			;a960
	rst 18h			;a961
	adc a,l			;a962
	sbc a,d			;a963
	adc a,d			;a964
	sub c			;a965
	sub (hl)			;a966
	sbc a,d			;a967
	sub c			;a968
	sbc a,e			;a969
	sub b			;a96a
	rst 18h			;a96b
	adc a,d			;a96c
	sub c			;a96d
	sbc a,(hl)			;a96e
	rst 18h			;a96f
	sbc a,l			;a970
	adc a,l			;a971
	adc a,d			;a972
	sub d			;a973
	sbc a,(hl)			;a974
	rst 18h			;a975
	adc a,(hl)			;a976
	adc a,d			;a977
	sbc a,d			;a978
	rst 18h			;a979
	adc a,h			;a97a
	sbc a,d			;a97b
	rst 18h			;a97c
	sbc a,h			;a97d
	sub b			;a97e
	sub c			;a97f
	sbc a,e			;a980
	sbc a,d			;a981
	sub c			;a982
	adc a,h			;a983
	sbc a,(hl)			;a984
	rst 18h			;a985
	sbc a,d			;a986
	sub c			;a987
	rst 18h			;a988
	adc a,d			;a989
	sub c			;a98a
	sbc a,(hl)			;a98b
	rst 18h			;a98c
	sbc a,c			;a98d
	sub (hl)			;a98e
	sbc a,b			;a98f
	adc a,d			;a990
	adc a,l			;a991
	sbc a,(hl)			;a992
	pop de			;a993
	push af			;a994
	or e			;a995
	sbc a,(hl)			;a996
	rst 18h			;a997
	sbc a,(hl)			;a998
	adc a,a			;a999
	sbc a,(hl)			;a99a
	adc a,l			;a99b
	sub (hl)			;a99c
	sbc a,h			;a99d
	sub (hl)			;a99e
	rst 20h			;a99f
	sub c			;a9a0
	rst 18h			;a9a1
	adc a,h			;a9a2
	sbc a,d			;a9a3
	rst 18h			;a9a4
	sbc a,d			;a9a5
	adc a,h			;a9a6
	sbc a,c			;a9a7
	adc a,d			;a9a8
	sub d			;a9a9
	sbc a,(hl)			;a9aa
	pop de			;a9ab
	di			;a9ac
	call p,0bbf5h		;a9ad
	sub b			;a9b0
	sub c			;a9b1
	sbc a,e			;a9b2
	sbc a,d			;a9b3
	rst 18h			;a9b4
	sbc a,d			;a9b5
	sub e			;a9b6
	rst 18h			;a9b7
	or c			;a9b8
	sub b			;a9b9
	adc a,l			;a9ba
	adc a,e			;a9bb
	sbc a,d			;a9bc
	rst 18h			;a9bd
	adc a,h			;a9be
	sbc a,d			;a9bf
	rst 18h			;a9c0
	sbc a,d			;a9c1
	sub c			;a9c2
	sbc a,h			;a9c3
	adc a,d			;a9c4
	sbc a,d			;a9c5
	sub c			;a9c6
	adc a,e			;a9c7
	adc a,l			;a9c8
	sbc a,(hl)			;a9c9
	rst 18h			;a9ca
	sbc a,h			;a9cb
	sub b			;a9cc
	sub c			;a9cd
	rst 18h			;a9ce
	sbc a,d			;a9cf
	sub e			;a9d0
	rst 18h			;a9d1
	xor h			;a9d2
	adc a,d			;a9d3
	adc a,l			;a9d4
	sbc a,d			;a9d5
	adc a,h			;a9d6
	adc a,e			;a9d7
	sbc a,d			;a9d8
	rst 18h			;a9d9
	sbc a,d			;a9da
	adc a,h			;a9db
	adc a,e			;a9dc
	jp pe,092dfh		;a9dd
	sub (hl)			;a9e0
	rst 18h			;a9e1
	sub e			;a9e2
	adc a,d			;a9e3
	sbc a,b			;a9e4
	sbc a,(hl)			;a9e5
	adc a,l			;a9e6
	rst 18h			;a9e7
	sbc a,e			;a9e8
	sbc a,d			;a9e9
	rst 18h			;a9ea
	adc a,l			;a9eb
	sbc a,d			;a9ec
	adc a,a			;a9ed
	sub b			;a9ee
	adc a,h			;a9ef
	sub b			;a9f0
	push af			;a9f1
	or c			;a9f2
	sub b			;a9f3
	rst 18h			;a9f4
	adc a,e			;a9f5
	sub (hl)			;a9f6
	sbc a,d			;a9f7
	sub c			;a9f8
	sbc a,d			;a9f9
	adc a,h			;a9fa
	rst 18h			;a9fb
	adc a,e			;a9fc
	sub b			;a9fd
	sbc a,e			;a9fe
	sub b			;a9ff
	rst 18h			;aa00
	sub e			;aa01
	sub b			;aa02
	rst 18h			;aa03
	sub c			;aa04
	sbc a,d			;aa05
	sbc a,h			;aa06
	sbc a,d			;aa07
	adc a,h			;aa08
	sbc a,(hl)			;aa09
	adc a,l			;aa0a
	sub (hl)			;aa0b
	sub b			;aa0c
	rst 18h			;aa0d
	adc a,a			;aa0e
	sbc a,(hl)			;aa0f
	adc a,l			;aa10
	sbc a,(hl)			;aa11
	rst 18h			;aa12
	sbc a,d			;aa13
	sub c			;aa14
	adc a,e			;aa15
	adc a,l			;aa16
	sbc a,(hl)			;aa17
	adc a,l			;aa18
	rst 18h			;aa19
	sbc a,(hl)			;aa1a
	rst 18h			;aa1b
	and a			;aa1c
	sub (hl)			;aa1d
	sbc a,l			;aa1e
	sbc a,(hl)			;aa1f
	sub e			;aa20
	sbc a,l			;aa21
	jp pe,0aef5h		;aa22
	adc a,d			;aa25
	jp (hl)			;aa26
	sbc a,e			;aa27
	sbc a,(hl)			;aa28
	adc a,e			;aa29
	sbc a,d			;aa2a
	rst 18h			;aa2b
	adc a,h			;aa2c
	rst 20h			;aa2d
	sub e			;aa2e
	sub b			;aa2f
	rst 18h			;aa30
	sbc a,h			;aa31
	sub b			;aa32
	sub c			;aa33
	rst 18h			;aa34
	sub e			;aa35
	sbc a,(hl)			;aa36
	rst 18h			;aa37
	xor l			;aa38
	adc a,d			;aa39
	sbc a,d			;aa3a
	sbc a,e			;aa3b
	sbc a,(hl)			;aa3c
	rst 18h			;aa3d
	sbc a,e			;aa3e
	sbc a,d			;aa3f
	sub e			;aa40
	rst 18h			;aa41
	cp e			;aa42
	sbc a,d			;aa43
	adc a,h			;aa44
	adc a,e			;aa45
	sub (hl)			;aa46
	sub c			;aa47
	sub b			;aa48
	push af			;aa49
	cp d			;aa4a
	adc a,h			;aa4b
	adc a,e			;aa4c
	jp pe,08fdfh		;aa4d
	adc a,d			;aa50
	adc a,l			;aa51
	sub (hl)			;aa52
	sbc a,c			;aa53
	sub (hl)			;aa54
	sbc a,h			;aa55
	sbc a,(hl)			;aa56
	sbc a,e			;aa57
	sub b			;aa58
	pop de			;aa59
	push af			;aa5a
	cp (hl)			;aa5b
	and 091h		;aa5c
	rst 18h			;aa5e
	sub c			;aa5f
	sub b			;aa60
	rst 18h			;aa61
	sbc a,d			;aa62
	adc a,h			;aa63
	adc a,e			;aa64
	jp pe,08fdfh		;aa65
	adc a,d			;aa68
	adc a,l			;aa69
	sub (hl)			;aa6a
	sbc a,c			;aa6b
	sub (hl)			;aa6c
	sbc a,h			;aa6d
	sbc a,(hl)			;aa6e
	sbc a,e			;aa6f
	sub b			;aa70
	push af			;aa71
	cp d			;aa72
	adc a,h			;aa73
	adc a,e			;aa74
	sbc a,(hl)			;aa75
	sub e			;aa76
	sub e			;aa77
	sbc a,(hl)			;aa78
	rst 18h			;aa79
	adc a,d			;aa7a
	sub c			;aa7b
	sbc a,(hl)			;aa7c
	rst 18h			;aa7d
	adc a,e			;aa7e
	sub b			;aa7f
	adc a,l			;aa80
	sub d			;aa81
	sbc a,d			;aa82
	sub c			;aa83
	adc a,e			;aa84
	sbc a,(hl)			;aa85
	rst 18h			;aa86
	adc a,h			;aa87
	sub b			;aa88
	sbc a,l			;aa89
	adc a,l			;aa8a
	sbc a,d			;aa8b
	rst 18h			;aa8c
	sbc a,d			;aa8d
	sub e			;aa8e
	rst 18h			;aa8f
	sbc a,h			;aa90
	sbc a,d			;aa91
	sub c			;aa92
	sub b			;aa93
	adc a,e			;aa94
	sbc a,d			;aa95
	rst 18h			;aa96
	adc a,h			;aa97
	sbc a,(hl)			;aa98
	sbc a,b			;aa99
	adc a,l			;aa9a
	sbc a,(hl)			;aa9b
	sbc a,e			;aa9c
	sub b			;aa9d
	rst 18h			;aa9e
	add a,(hl)			;aa9f
	rst 18h			;aaa0
	adc a,d			;aaa1
	sub c			;aaa2
	rst 18h			;aaa3
	adc a,l			;aaa4
	sbc a,(hl)			;aaa5
	add a,(hl)			;aaa6
	sub b			;aaa7
	rst 18h			;aaa8
	sbc a,e			;aaa9
	sbc a,d			;aaaa
	adc a,l			;aaab
	adc a,l			;aaac
	sub (hl)			;aaad
	sbc a,l			;aaae
	sbc a,(hl)			;aaaf
	rst 18h			;aab0
	adc a,d			;aab1
	sub c			;aab2
	rst 18h			;aab3
	jp pe,09d8dh		;aab4
	sub b			;aab7
	sub e			;aab8
	pop de			;aab9
	push af			;aaba
	pop de			;aabb
	rst 18h			;aabc
	xor d			;aabd
	sub c			;aabe
	rst 18h			;aabf
	jp pe,09d8dh		;aac0
	sub b			;aac3
	sub e			;aac4
	rst 18h			;aac5
	sbc a,(hl)			;aac6
	sbc a,l			;aac7
	sbc a,(hl)			;aac8
	adc a,e			;aac9
	sub (hl)			;aaca
	sbc a,e			;aacb
	sub b			;aacc
	rst 18h			;aacd
	adc a,a			;aace
	sub b			;aacf
	adc a,l			;aad0
	rst 18h			;aad1
	sub e			;aad2
	sbc a,(hl)			;aad3
	rst 18h			;aad4
	adc a,e			;aad5
	sub b			;aad6
	adc a,l			;aad7
	sub d			;aad8
	sbc a,d			;aad9
	sub c			;aada
	adc a,e			;aadb
	sbc a,(hl)			;aadc
	rst 18h			;aadd
	sub e			;aade
	sub e			;aadf
	sbc a,d			;aae0
	sbc a,b			;aae1
	sbc a,(hl)			;aae2
	rst 18h			;aae3
	sub a			;aae4
	sbc a,(hl)			;aae5
	adc a,h			;aae6
	adc a,e			;aae7
	sbc a,(hl)			;aae8
	rst 18h			;aae9
	sbc a,d			;aaea
	sub e			;aaeb
	rst 18h			;aaec
	sbc a,(hl)			;aaed
	sbc a,b			;aaee
	adc a,d			;aaef
	sbc a,(hl)			;aaf0
	rst 18h			;aaf1
	sbc a,e			;aaf2
	sbc a,d			;aaf3
	sub e			;aaf4
	rst 18h			;aaf5
	sbc a,h			;aaf6
	sbc a,d			;aaf7
	sub c			;aaf8
	sub b			;aaf9
	adc a,e			;aafa
	sbc a,d			;aafb
	push af			;aafc
	or e			;aafd
	sbc a,(hl)			;aafe
	rst 18h			;aaff
	adc a,e			;ab00
	sbc a,(hl)			;ab01
	adc a,a			;ab02
	sbc a,(hl)			;ab03
	rst 18h			;ab04
	adc a,h			;ab05
	sbc a,d			;ab06
	rst 18h			;ab07
	sbc a,e			;ab08
	sub (hl)			;ab09
	adc a,h			;ab0a
	adc a,d			;ab0b
	sbc a,d			;ab0c
	sub e			;ab0d
	adc a,c			;ab0e
	sbc a,d			;ab0f
	pop de			;ab10
	push af			;ab11
	cp d			;ab12
	sub e			;ab13
	rst 18h			;ab14
	sbc a,h			;ab15
	adc a,d			;ab16
	sbc a,h			;ab17
	sub a			;ab18
	sub (hl)			;ab19
	sub e			;ab1a
	sub e			;ab1b
	sub b			;ab1c
	rst 18h			;ab1d
	sub a			;ab1e
	sbc a,(hl)			;ab1f
	rst 18h			;ab20
	adc a,h			;ab21
	sub (hl)			;ab22
	sbc a,e			;ab23
	sub b			;ab24
	rst 18h			;ab25
	adc a,a			;ab26
	adc a,d			;ab27
	adc a,l			;ab28
	sub (hl)			;ab29
	sbc a,c			;ab2a
	sub (hl)			;ab2b
	sbc a,h			;ab2c
	sbc a,(hl)			;ab2d
	sbc a,e			;ab2e
	sub b			;ab2f
	pop de			;ab30
	push af			;ab31
	or e			;ab32
	sbc a,(hl)			;ab33
	rst 18h			;ab34
	adc a,e			;ab35
	sbc a,(hl)			;ab36
	adc a,a			;ab37
	sbc a,(hl)			;ab38
	rst 18h			;ab39
	sbc a,d			;ab3a
	adc a,h			;ab3b
	adc a,e			;ab3c
	jp pe,08cdfh		;ab3d
	sbc a,d			;ab40
	sub e			;ab41
	sub e			;ab42
	sbc a,(hl)			;ab43
	sbc a,e			;ab44
	sbc a,(hl)			;ab45
	pop de			;ab46
	push af			;ab47
	or e			;ab48
	sbc a,(hl)			;ab49
	rst 18h			;ab4a
	sbc a,d			;ab4b
	sub c			;ab4c
	sbc a,d			;ab4d
	adc a,l			;ab4e
	sbc a,b			;ab4f
	ret pe			;ab50
	sbc a,(hl)			;ab51
	rst 18h			;ab52
	sbc a,(hl)			;ab53
	sbc a,h			;ab54
	adc a,e			;ab55
	and 09eh		;ab56
	rst 18h			;ab58
	adc a,h			;ab59
	sub b			;ab5a
	sbc a,l			;ab5b
	adc a,l			;ab5c
	sbc a,d			;ab5d
	rst 18h			;ab5e
	and b			;ab5f
	rst 18h			;ab60
	add a,(hl)			;ab61
	rst 18h			;ab62
	adc a,h			;ab63
	sbc a,d			;ab64
	rst 18h			;ab65
	sbc a,e			;ab66
	sbc a,d			;ab67
	adc a,h			;ab68
	sub (hl)			;ab69
	sub c			;ab6a
	adc a,e			;ab6b
	sbc a,d			;ab6c
	sbc a,b			;ab6d
	adc a,l			;ab6e
	sbc a,(hl)			;ab6f
	pop de			;ab70
	push af			;ab71
	cp d			;ab72
	sub e			;ab73
	rst 18h			;ab74
	sbc a,h			;ab75
	adc a,d			;ab76
	sbc a,d			;ab77
	sub c			;ab78
	sbc a,h			;ab79
	sub b			;ab7a
	rst 18h			;ab7b
	sub a			;ab7c
	adc a,d			;ab7d
	sub d			;ab7e
	sbc a,d			;ab7f
	sbc a,(hl)			;ab80
	pop de			;ab81
	push af			;ab82
	xor c			;ab83
	sbc a,d			;ab84
	adc a,h			;ab85
	rst 18h			;ab86
	adc a,d			;ab87
	sub c			;ab88
	sbc a,(hl)			;ab89
	rst 18h			;ab8a
	sbc a,c			;ab8b
	sub e			;ab8c
	sub b			;ab8d
	adc a,l			;ab8e
	rst 18h			;ab8f
	sub c			;ab90
	sbc a,(hl)			;ab91
	adc a,e			;ab92
	adc a,d			;ab93
	adc a,l			;ab94
	sbc a,(hl)			;ab95
	sub e			;ab96
	rst 18h			;ab97
	sbc a,h			;ab98
	sub b			;ab99
	sub c			;ab9a
	adc a,c			;ab9b
	sbc a,d			;ab9c
	adc a,l			;ab9d
	adc a,e			;ab9e
	sub (hl)			;ab9f
	adc a,l			;aba0
	adc a,h			;aba1
	sbc a,d			;aba2
	rst 18h			;aba3
	sbc a,d			;aba4
	sub c			;aba5
	rst 18h			;aba6
	adc a,a			;aba7
	sub (hl)			;aba8
	sbc a,d			;aba9
	sbc a,e			;abaa
	adc a,l			;abab
	sbc a,(hl)			;abac
	rst 18h			;abad
	sbc a,(hl)			;abae
	sub e			;abaf
	rst 18h			;abb0
	adc a,e			;abb1
	sub b			;abb2
	sbc a,h			;abb3
	sbc a,(hl)			;abb4
	adc a,l			;abb5
	rst 18h			;abb6
	adc a,d			;abb7
	sub c			;abb8
	sbc a,(hl)			;abb9
	rst 18h			;abba
	sbc a,c			;abbb
	sub e			;abbc
	sub b			;abbd
	adc a,l			;abbe
	rst 18h			;abbf
	adc a,e			;abc0
	sbc a,(hl)			;abc1
	sub e			;abc2
	sub e			;abc3
	sbc a,(hl)			;abc4
	sbc a,e			;abc5
	sbc a,(hl)			;abc6
	pop de			;abc7
	push af			;abc8
	cp d			;abc9
	adc a,l			;abca
	sbc a,d			;abcb
	adc a,h			;abcc
	rst 18h			;abcd
	adc a,d			;abce
	sub c			;abcf
	rst 18h			;abd0
	jp pe,08a98h		;abd1
	sub (hl)			;abd4
	sub e			;abd5
	sbc a,(hl)			;abd6
	rst 18h			;abd7
	adc a,(hl)			;abd8
	adc a,d			;abd9
	sbc a,d			;abda
	rst 18h			;abdb
	adc a,l			;abdc
	sbc a,d			;abdd
	sbc a,h			;abde
	sub b			;abdf
	sbc a,b			;abe0
	sbc a,d			;abe1
	rst 18h			;abe2
	adc a,d			;abe3
	sub c			;abe4
	rst 18h			;abe5
	sbc a,h			;abe6
	adc a,d			;abe7
	sbc a,h			;abe8
	sub a			;abe9
	sub (hl)			;abea
	sub e			;abeb
	sub e			;abec
	sub b			;abed
	rst 18h			;abee
	sbc a,e			;abef
	sbc a,d			;abf0
	rst 18h			;abf1
	sub e			;abf2
	sub b			;abf3
	rst 18h			;abf4
	sbc a,(hl)			;abf5
	sub e			;abf6
	adc a,e			;abf7
	sub b			;abf8
	rst 18h			;abf9
	sbc a,e			;abfa
	sbc a,d			;abfb
	rst 18h			;abfc
	adc a,d			;abfd
	sub c			;abfe
	sbc a,(hl)			;abff
	rst 18h			;ac00
	sbc a,e			;ac01
	sbc a,d			;ac02
	rst 18h			;ac03
	sub e			;ac04
	sbc a,(hl)			;ac05
	adc a,h			;ac06
	rst 18h			;ac07
	or d			;ac08
	sub (hl)			;ac09
	sub e			;ac0a
	rst 18h			;ac0b
	cp h			;ac0c
	sub b			;ac0d
	sub e			;ac0e
	adc a,d			;ac0f
	sub d			;ac10
	sub c			;ac11
	sbc a,(hl)			;ac12
	adc a,h			;ac13
	rst 18h			;ac14
	add a,(hl)			;ac15
	rst 18h			;ac16
	sbc a,e			;ac17
	sbc a,d			;ac18
	adc a,h			;ac19
	sbc a,h			;ac1a
	sub (hl)			;ac1b
	sbc a,d			;ac1c
	sub c			;ac1d
	sbc a,e			;ac1e
	sbc a,d			;ac1f
	pop de			;ac20
	push af			;ac21
	cp d			;ac22
	adc a,l			;ac23
	sbc a,d			;ac24
	adc a,h			;ac25
	rst 18h			;ac26
	adc a,d			;ac27
	sub c			;ac28
	rst 18h			;ac29
	adc a,a			;ac2a
	jp pe,09e95h		;ac2b
	adc a,l			;ac2e
	sub b			;ac2f
	rst 18h			;ac30
	cp h			;ac31
	sub a			;ac32
	sub b			;ac33
	adc a,d			;ac34
	ret pe			;ac35
	rst 18h			;ac36
	adc a,h			;ac37
	sub (hl)			;ac38
	sub c			;ac39
	rst 18h			;ac3a
	sbc a,c			;ac3b
	adc a,d			;ac3c
	sbc a,d			;ac3d
	adc a,l			;ac3e
	add a,l			;ac3f
	sbc a,(hl)			;ac40
	adc a,h			;ac41
	rst 18h			;ac42
	adc a,a			;ac43
	sbc a,(hl)			;ac44
	adc a,l			;ac45
	sbc a,(hl)			;ac46
	rst 18h			;ac47
	adc a,l			;ac48
	sbc a,d			;ac49
	sbc a,h			;ac4a
	sub b			;ac4b
	sbc a,b			;ac4c
	sbc a,d			;ac4d
	adc a,l			;ac4e
	rst 18h			;ac4f
	adc a,d			;ac50
	sub c			;ac51
	rst 18h			;ac52
	sub b			;ac53
	sbc a,l			;ac54
	sub l			;ac55
	sbc a,d			;ac56
	adc a,e			;ac57
	sub b			;ac58
	rst 18h			;ac59
	adc a,h			;ac5a
	sub b			;ac5b
	sbc a,l			;ac5c
	adc a,l			;ac5d
	sbc a,d			;ac5e
	rst 18h			;ac5f
	adc a,d			;ac60
	sub c			;ac61
	sbc a,(hl)			;ac62
	rst 18h			;ac63
	sbc a,e			;ac64
	sbc a,d			;ac65
	rst 18h			;ac66
	sub e			;ac67
	sbc a,(hl)			;ac68
	adc a,h			;ac69
	rst 18h			;ac6a
	or d			;ac6b
	sub (hl)			;ac6c
	sub e			;ac6d
	rst 18h			;ac6e
	cp h			;ac6f
	sub b			;ac70
	sub e			;ac71
	adc a,d			;ac72
	sub d			;ac73
	sub c			;ac74
	sbc a,(hl)			;ac75
	adc a,h			;ac76
	pop de			;ac77
	push af			;ac78
	cp d			;ac79
	sub e			;ac7a
	rst 18h			;ac7b
	jp pe,08a98h		;ac7c
	sub (hl)			;ac7f
	sub e			;ac80
	sbc a,(hl)			;ac81
	rst 18h			;ac82
	add a,(hl)			;ac83
	sbc a,(hl)			;ac84
	rst 18h			;ac85
	sub c			;ac86
	sub b			;ac87
	rst 18h			;ac88
	adc a,e			;ac89
	sub (hl)			;ac8a
	sbc a,d			;ac8b
	sub c			;ac8c
	sbc a,d			;ac8d
	rst 18h			;ac8e
	sub c			;ac8f
	sbc a,d			;ac90
	sbc a,h			;ac91
	sbc a,d			;ac92
	adc a,h			;ac93
	sub (hl)			;ac94
	sbc a,e			;ac95
	sbc a,(hl)			;ac96
	sbc a,e			;ac97
	rst 18h			;ac98
	sbc a,e			;ac99
	sbc a,d			;ac9a
	rst 18h			;ac9b
	adc a,c			;ac9c
	sub b			;ac9d
	sub e			;ac9e
	sbc a,(hl)			;ac9f
	adc a,l			;aca0
	pop de			;aca1
	push af			;aca2
	or e			;aca3
	sbc a,(hl)			;aca4
	rst 18h			;aca5
	sub a			;aca6
	sub b			;aca7
	sub l			;aca8
	sbc a,(hl)			;aca9
	rst 18h			;acaa
	sbc a,d			;acab
	adc a,h			;acac
	adc a,e			;acad
	jp pe,089dfh		;acae
	sbc a,d			;acb1
	adc a,l			;acb2
	sbc a,e			;acb3
	sbc a,d			;acb4
	pop de			;acb5
	push af			;acb6
	or e			;acb7
	ret pe			;acb8
	sbc a,(hl)			;acb9
	adc a,h			;acba
	rst 18h			;acbb
	adc a,d			;acbc
	sub c			;acbd
	rst 18h			;acbe
	adc a,a			;acbf
	adc a,d			;acc0
	adc a,l			;acc1
	sub b			;acc2
	pop de			;acc3
	push af			;acc4
	cp (hl)			;acc5
	sub e			;acc6
	adc a,(hl)			;acc7
	adc a,d			;acc8
	sub (hl)			;acc9
	adc a,e			;acca
	adc a,l			;accb
	sbc a,(hl)			;accc
	sub c			;accd
	sbc a,(hl)			;acce
	adc a,h			;accf
	rst 18h			;acd0
	adc a,e			;acd1
	adc a,d			;acd2
	adc a,h			;acd3
	rst 18h			;acd4
	adc a,a			;acd5
	adc a,d			;acd6
	sub e			;acd7
	sub d			;acd8
	sub b			;acd9
	sub c			;acda
	sbc a,d			;acdb
	adc a,h			;acdc
	pop de			;acdd
	push af			;acde
	xor h			;acdf
	sbc a,(hl)			;ace0
	sub c			;ace1
	sbc a,b			;ace2
	adc a,l			;ace3
	sbc a,(hl)			;ace4
	adc a,h			;ace5
	rst 18h			;ace6
	sbc a,d			;ace7
	sub e			;ace8
	rst 18h			;ace9
	jp pe,09d8dh		;acea
	sub b			;aced
	sub e			;acee
	rst 18h			;acef
	add a,(hl)			;acf0
	rst 18h			;acf1
	sbc a,l			;acf2
	adc a,l			;acf3
	sub b			;acf4
	adc a,e			;acf5
	sbc a,(hl)			;acf6
	rst 18h			;acf7
	adc a,d			;acf8
	sub c			;acf9
	sbc a,(hl)			;acfa
	rst 18h			;acfb
	adc a,l			;acfc
	sbc a,d			;acfd
	adc a,h			;acfe
	sub (hl)			;acff
	sub c			;ad00
	sbc a,(hl)			;ad01
	pop de			;ad02
	push af			;ad03
	or e			;ad04
	sub e			;ad05
	sbc a,d			;ad06
	sub c			;ad07
	sbc a,(hl)			;ad08
	adc a,h			;ad09
	rst 18h			;ad0a
	and b			;ad0b
	rst 18h			;ad0c
	sbc a,e			;ad0d
	sbc a,d			;ad0e
	rst 18h			;ad0f
	push af			;ad10
	xor e			;ad11
	sbc a,(hl)			;ad12
	adc a,a			;ad13
	sbc a,(hl)			;ad14
	adc a,h			;ad15
	rst 18h			;ad16
	sbc a,d			;ad17
	sub e			;ad18
	rst 18h			;ad19
	sbc a,e			;ad1a
	sub (hl)			;ad1b
	adc a,h			;ad1c
	sbc a,h			;ad1d
	sub b			;ad1e
	rst 18h			;ad1f
	adc a,h			;ad20
	sub b			;ad21
	sub e			;ad22
	sbc a,(hl)			;ad23
	adc a,l			;ad24
	rst 18h			;ad25
	sbc a,h			;ad26
	sub b			;ad27
	sub c			;ad28
	push af			;ad29
	xor h			;ad2a
	sub (hl)			;ad2b
	sbc a,d			;ad2c
	sub c			;ad2d
	adc a,e			;ad2e
	sbc a,d			;ad2f
	adc a,h			;ad30
	rst 18h			;ad31
	sbc a,d			;ad32
	sub e			;ad33
	rst 18h			;ad34
	adc a,l			;ad35
	sub b			;ad36
	sbc a,h			;ad37
	sbc a,d			;ad38
	rst 18h			;ad39
	sbc a,e			;ad3a
	sbc a,d			;ad3b
	rst 18h			;ad3c
	adc a,c			;ad3d
	sbc a,(hl)			;ad3e
	adc a,l			;ad3f
	sub (hl)			;ad40
	sbc a,(hl)			;ad41
	adc a,h			;ad42
	rst 18h			;ad43
	adc a,e			;ad44
	sbc a,d			;ad45
	sub e			;ad46
	sbc a,(hl)			;ad47
	adc a,l			;ad48
	sbc a,(hl)			;ad49
	push hl			;ad4a
	sbc a,(hl)			;ad4b
	adc a,h			;ad4c
	pop de			;ad4d
	di			;ad4e
	call p,09eb3h		;ad4f
	adc a,h			;ad52
	rst 18h			;ad53
	adc a,a			;ad54
	sbc a,d			;ad55
	sub e			;ad56
	adc a,d			;ad57
	sbc a,e			;ad58
	sbc a,(hl)			;ad59
	adc a,h			;ad5a
	rst 18h			;ad5b
	xor c			;ad5c
	sub (hl)			;ad5d
	adc a,d			;ad5e
	sbc a,e			;ad5f
	sbc a,(hl)			;ad60
	adc a,h			;ad61
	rst 18h			;ad62
	or c			;ad63
	sbc a,d			;ad64
	sbc a,b			;ad65
	adc a,l			;ad66
	sbc a,(hl)			;ad67
	adc a,h			;ad68
	rst 18h			;ad69
	sbc a,h			;ad6a
	sbc a,(hl)			;ad6b
	sbc a,d			;ad6c
	sub c			;ad6d
	rst 18h			;ad6e
	adc a,h			;ad6f
	sub b			;ad70
	sbc a,l			;ad71
	adc a,l			;ad72
	sbc a,d			;ad73
	rst 18h			;ad74
	adc a,e			;ad75
	sub (hl)			;ad76
	rst 18h			;ad77
	add a,(hl)			;ad78
	rst 18h			;ad79
	adc a,e			;ad7a
	sbc a,d			;ad7b
	rst 18h			;ad7c
	sub (hl)			;ad7d
	sub c			;ad7e
	sub b			;ad7f
	sbc a,h			;ad80
	adc a,d			;ad81
	sub e			;ad82
	sbc a,(hl)			;ad83
	sub c			;ad84
	rst 18h			;ad85
	adc a,h			;ad86
	adc a,d			;ad87
	adc a,h			;ad88
	rst 18h			;ad89
	adc a,e			;ad8a
	sub b			;ad8b
	add a,a			;ad8c
	sub (hl)			;ad8d
	sub c			;ad8e
	sbc a,(hl)			;ad8f
	adc a,h			;ad90
	pop de			;ad91
	di			;ad92
	call p,0baf5h		;ad93
	sub e			;ad96
	rst 18h			;ad97
	adc a,a			;ad98
	sub b			;ad99
	sbc a,e			;ad9a
	sbc a,d			;ad9b
	adc a,l			;ad9c
	rst 18h			;ad9d
	sbc a,e			;ad9e
	sbc a,d			;ad9f
	rst 18h			;ada0
	sub e			;ada1
	sbc a,(hl)			;ada2
	rst 18h			;ada3
	sbc a,(hl)			;ada4
	adc a,l			;ada5
	sbc a,(hl)			;ada6
	push hl			;ada7
	sbc a,(hl)			;ada8
	rst 18h			;ada9
	sbc a,e			;adaa
	sbc a,d			;adab
	rst 18h			;adac
	adc a,a			;adad
	sub (hl)			;adae
	sbc a,d			;adaf
	sbc a,e			;adb0
	adc a,l			;adb1
	sbc a,(hl)			;adb2
	rst 18h			;adb3
	sbc a,(hl)			;adb4
	sub e			;adb5
	sbc a,d			;adb6
	sub l			;adb7
	sbc a,(hl)			;adb8
	rst 18h			;adb9
	sbc a,(hl)			;adba
	rst 18h			;adbb
	sub e			;adbc
	sbc a,(hl)			;adbd
	adc a,h			;adbe
	rst 18h			;adbf
	xor c			;adc0
	sub (hl)			;adc1
	adc a,d			;adc2
	sbc a,e			;adc3
	sbc a,(hl)			;adc4
	adc a,h			;adc5
	rst 18h			;adc6
	or c			;adc7
	sbc a,d			;adc8
	sbc a,b			;adc9
	adc a,l			;adca
	sbc a,(hl)			;adcb
	adc a,h			;adcc
	pop de			;adcd
	di			;adce
	call p,0f5f5h		;adcf
	push af			;add2
	xor e			;add3
	sbc a,d			;add4
	rst 18h			;add5
	sbc a,d			;add6
	adc a,h			;add7
	sbc a,h			;add8
	adc a,d			;add9
	sbc a,d			;adda
	sbc a,h			;addb
	sbc a,d			;addc
	sub c			;addd
	rst 18h			;adde
	sub e			;addf
	sbc a,(hl)			;ade0
	adc a,h			;ade1
	rst 18h			;ade2
	adc a,a			;ade3
	sub (hl)			;ade4
	sbc a,h			;ade5
	sbc a,(hl)			;ade6
	sbc a,e			;ade7
	adc a,d			;ade8
	adc a,l			;ade9
	sbc a,(hl)			;adea
	adc a,h			;adeb
	rst 18h			;adec
	sbc a,e			;aded
	sbc a,d			;adee
	rst 18h			;adef
	sbc a,(hl)			;adf0
	adc a,l			;adf1
	sbc a,(hl)			;adf2
	push hl			;adf3
	sbc a,(hl)			;adf4
	pop de			;adf5
	push af			;adf6
	cp d			;adf7
	adc a,h			;adf8
	adc a,e			;adf9
	jp pe,0df8ch		;adfa
	adc a,l			;adfd
	sbc a,d			;adfe
	sbc a,(hl)			;adff
	sub e			;ae00
	sub d			;ae01
	sbc a,d			;ae02
	sub c			;ae03
	adc a,e			;ae04
	sbc a,d			;ae05
	rst 18h			;ae06
	sub d			;ae07
	sbc a,(hl)			;ae08
	sub e			;ae09
	out (0dfh),a		;ae0a
	sbc a,h			;ae0c
	sub b			;ae0d
	sub c			;ae0e
	rst 18h			;ae0f
	sbc a,c			;ae10
	sub (hl)			;ae11
	sbc a,d			;ae12
	sbc a,l			;ae13
	adc a,l			;ae14
	sbc a,d			;ae15
	rst 18h			;ae16
	add a,(hl)			;ae17
	rst 18h			;ae18
	adc a,c			;ae19
	rst 20h			;ae1a
	sub d			;ae1b
	sub (hl)			;ae1c
	adc a,e			;ae1d
	sub b			;ae1e
	adc a,h			;ae1f
	pop de			;ae20
	push af			;ae21
	cp h			;ae22
	sbc a,(hl)			;ae23
	sbc a,d			;ae24
	adc a,h			;ae25
	rst 18h			;ae26
	sbc a,(hl)			;ae27
	sub e			;ae28
	rst 18h			;ae29
	adc a,h			;ae2a
	adc a,d			;ae2b
	sbc a,d			;ae2c
	sub e			;ae2d
	sub b			;ae2e
	rst 18h			;ae2f
	adc a,a			;ae30
	adc a,l			;ae31
	sbc a,d			;ae32
	adc a,h			;ae33
	sbc a,(hl)			;ae34
	rst 18h			;ae35
	sbc a,e			;ae36
	sbc a,d			;ae37
	rst 18h			;ae38
	sub a			;ae39
	sub b			;ae3a
	adc a,l			;ae3b
	adc a,l			;ae3c
	sub (hl)			;ae3d
	sbc a,l			;ae3e
	sub e			;ae3f
	sbc a,d			;ae40
	adc a,h			;ae41
	rst 18h			;ae42
	sbc a,h			;ae43
	sub b			;ae44
	sub c			;ae45
	adc a,c			;ae46
	adc a,d			;ae47
	sub e			;ae48
	adc a,h			;ae49
	sub (hl)			;ae4a
	sub b			;ae4b
	sub c			;ae4c
	sbc a,d			;ae4d
	adc a,h			;ae4e
	pop de			;ae4f
	push af			;ae50
	or a			;ae51
	sbc a,(hl)			;ae52
	sbc a,h			;ae53
	sub (hl)			;ae54
	sbc a,(hl)			;ae55
	rst 18h			;ae56
	sbc a,d			;ae57
	adc a,h			;ae58
	sbc a,d			;ae59
	rst 18h			;ae5a
	sub e			;ae5b
	sbc a,(hl)			;ae5c
	sbc a,e			;ae5d
	sub b			;ae5e
	out (0dfh),a		;ae5f
	sub l			;ae61
	adc a,d			;ae62
	sbc a,d			;ae63
	sbc a,b			;ae64
	sbc a,(hl)			;ae65
	rst 18h			;ae66
	or e			;ae67
	sub b			;ae68
	adc a,h			;ae69
	rst 18h			;ae6a
	xor e			;ae6b
	sbc a,d			;ae6c
	sub d			;ae6d
	adc a,a			;ae6e
	sub e			;ae6f
	sub b			;ae70
	adc a,h			;ae71
	rst 18h			;ae72
	xor h			;ae73
	sbc a,(hl)			;ae74
	sbc a,b			;ae75
	adc a,l			;ae76
	sbc a,(hl)			;ae77
	sbc a,e			;ae78
	sub b			;ae79
	adc a,h			;ae7a
	pop de			;ae7b
	push af			;ae7c
	or d			;ae7d
	sub b			;ae7e
	adc a,l			;ae7f
	adc a,e			;ae80
	sbc a,(hl)			;ae81
	sub e			;ae82
	defb 0ddh,0d3h,0dfh	;illegal sequence		;ae83
	sbc a,(hl)			;ae86
	adc a,d			;ae87
	sub e			;ae88
	sub e			;ae89
	sbc a,(hl)			;ae8a
	rst 18h			;ae8b
	sub e			;ae8c
	sbc a,(hl)			;ae8d
	rst 18h			;ae8e
	sbc a,(hl)			;ae8f
	adc a,a			;ae90
	sbc a,(hl)			;ae91
	adc a,l			;ae92
	sub (hl)			;ae93
	sbc a,h			;ae94
	sub (hl)			;ae95
	rst 20h			;ae96
	sub c			;ae97
	out (0dfh),a		;ae98
	defb 0ddh,0b1h,090h	;illegal sequence		;ae9a
	adc a,h			;ae9d
	rst 18h			;ae9e
	sbc a,h			;ae9f
	sub b			;aea0
	sub c			;aea1
	sbc a,c			;aea2
	sub (hl)			;aea3
	adc a,h			;aea4
	sbc a,h			;aea5
	sbc a,(hl)			;aea6
	sub d			;aea7
	sub b			;aea8
	adc a,h			;aea9
	rst 18h			;aeaa
	sub e			;aeab
	sub b			;aeac
	rst 18h			;aead
	adc a,(hl)			;aeae
	adc a,d			;aeaf
	sbc a,d			;aeb0
	rst 18h			;aeb1
	sub e			;aeb2
	sub e			;aeb3
	sbc a,d			;aeb4
	adc a,c			;aeb5
	jp pe,08c96h		;aeb6
	rst 18h			;aeb9
	adc a,c			;aeba
	sub b			;aebb
	adc a,h			;aebc
	push af			;aebd
	or e			;aebe
	sbc a,(hl)			;aebf
	rst 18h			;aec0
	adc a,l			;aec1
	sub b			;aec2
	adc a,h			;aec3
	sbc a,(hl)			;aec4
	rst 18h			;aec5
	adc a,h			;aec6
	sbc a,d			;aec7
	rst 18h			;aec8
	adc a,a			;aec9
	sbc a,d			;aeca
	adc a,e			;aecb
	adc a,l			;aecc
	sub (hl)			;aecd
	sbc a,c			;aece
	sub (hl)			;aecf
	sbc a,h			;aed0
	sbc a,(hl)			;aed1
	rst 18h			;aed2
	sbc a,(hl)			;aed3
	sub e			;aed4
	rst 18h			;aed5
	sbc a,h			;aed6
	sub b			;aed7
	sub c			;aed8
	adc a,e			;aed9
	sbc a,(hl)			;aeda
	sbc a,h			;aedb
	adc a,e			;aedc
	sub b			;aedd
	rst 18h			;aede
	sbc a,h			;aedf
	sub b			;aee0
	sub c			;aee1
	rst 18h			;aee2
	sbc a,d			;aee3
	sub e			;aee4
	rst 18h			;aee5
	sbc a,h			;aee6
	sub b			;aee7
	sub c			;aee8
	sub b			;aee9
	pop de			;aeea
	rst 18h			;aeeb
	push af			;aeec
	xor h			;aeed
	sub b			;aeee
	sbc a,l			;aeef
	adc a,l			;aef0
	sbc a,d			;aef1
	rst 18h			;aef2
	and b			;aef3
	rst 18h			;aef4
	sub a			;aef5
	sbc a,(hl)			;aef6
	add a,(hl)			;aef7
	rst 18h			;aef8
	push af			;aef9
	or c			;aefa
	sub b			;aefb
	rst 18h			;aefc
	adc a,e			;aefd
	sub (hl)			;aefe
	sbc a,d			;aeff
	sub c			;af00
	sbc a,d			;af01
	adc a,h			;af02
	rst 18h			;af03
	sbc a,c			;af04
	adc a,d			;af05
	sbc a,d			;af06
	sbc a,b			;af07
	sub b			;af08
	pop de			;af09
	push af			;af0a
	cp d			;af0b
	sub c			;af0c
	sbc a,h			;af0d
	sub (hl)			;af0e
	sbc a,d			;af0f
	sub c			;af10
	sbc a,e			;af11
	sbc a,d			;af12
	adc a,h			;af13
	rst 18h			;af14
	and b			;af15
	pop de			;af16
	push af			;af17
	xor e			;af18
	sbc a,d			;af19
	rst 18h			;af1a
	adc a,(hl)			;af1b
	adc a,d			;af1c
	sbc a,d			;af1d
	sub d			;af1e
	sbc a,(hl)			;af1f
	adc a,h			;af20
	rst 18h			;af21
	sbc a,h			;af22
	sub b			;af23
	sub c			;af24
	rst 18h			;af25
	and b			;af26
	rst 18h			;af27
	add a,(hl)			;af28
	rst 18h			;af29
	sub e			;af2a
	sbc a,(hl)			;af2b
	rst 18h			;af2c
	sbc a,e			;af2d
	sbc a,d			;af2e
	sub l			;af2f
	sbc a,(hl)			;af30
	adc a,h			;af31
	rst 18h			;af32
	sbc a,h			;af33
	sbc a,(hl)			;af34
	sbc a,d			;af35
	adc a,l			;af36
	pop de			;af37
	push af			;af38
	cp (hl)			;af39
	adc a,a			;af3a
	sbc a,(hl)			;af3b
	sbc a,b			;af3c
	sbc a,(hl)			;af3d
	adc a,h			;af3e
	rst 18h			;af3f
	and b			;af40
	pop de			;af41
	push af			;af42
	cp d			;af43
	adc a,h			;af44
	rst 18h			;af45
	sbc a,e			;af46
	sbc a,d			;af47
	sub e			;af48
	rst 18h			;af49
	cp c			;af4a
	adc a,d			;af4b
	sbc a,d			;af4c
	sbc a,b			;af4d
	sub b			;af4e
	rst 18h			;af4f
	cp d			;af50
	adc a,e			;af51
	sbc a,d			;af52
	adc a,l			;af53
	sub c			;af54
	sub b			;af55
	pop de			;af56
	pop de			;af57
	pop de			;af58
	push af			;af59
	cp (hl)			;af5a
	adc a,h			;af5b
	adc a,a			;af5c
	sub (hl)			;af5d
	adc a,l			;af5e
	sbc a,(hl)			;af5f
	adc a,h			;af60
	rst 18h			;af61
	sbc a,h			;af62
	sub b			;af63
	sub c			;af64
	rst 18h			;af65
	sbc a,c			;af66
	adc a,l			;af67
	adc a,d			;af68
	sub (hl)			;af69
	sbc a,h			;af6a
	sub (hl)			;af6b
	rst 20h			;af6c
	sub c			;af6d
	out (0dfh),a		;af6e
	add a,(hl)			;af70
	rst 18h			;af71
	sbc a,d			;af72
	sub e			;af73
	rst 18h			;af74
	or a			;af75
	adc a,d			;af76
	sub d			;af77
	sub b			;af78
	rst 18h			;af79
	cp d			;af7a
	adc a,e			;af7b
	sbc a,d			;af7c
	adc a,l			;af7d
	sub c			;af7e
	sub b			;af7f
	rst 18h			;af80
	sbc a,d			;af81
	sub c			;af82
	adc a,h			;af83
	adc a,d			;af84
	sbc a,h			;af85
	sub (hl)			;af86
	sbc a,(hl)			;af87
	rst 18h			;af88
	adc a,e			;af89
	adc a,d			;af8a
	adc a,h			;af8b
	rst 18h			;af8c
	adc a,a			;af8d
	adc a,d			;af8e
	sub e			;af8f
	sub d			;af90
	sub b			;af91
	sub c			;af92
	sbc a,d			;af93
	adc a,h			;af94
	pop de			;af95
	push af			;af96
	cp a			;af97
	rst 18h			;af98
	sub (hl)			;af99
	sub e			;af9a
	adc a,d			;af9b
	sub d			;af9c
	sub (hl)			;af9d
	sub c			;af9e
	sbc a,(hl)			;af9f
	rst 18h			;afa0
	sub e			;afa1
	sub b			;afa2
	adc a,h			;afa3
	rst 18h			;afa4
	adc a,h			;afa5
	sub (hl)			;afa6
	sub d			;afa7
	sbc a,l			;afa8
	sub b			;afa9
	sub e			;afaa
	sub b			;afab
	adc a,h			;afac
	rst 18h			;afad
	sbc a,e			;afae
	sbc a,d			;afaf
	sub e			;afb0
	rst 18h			;afb1
	cp (hl)			;afb2
	sub h			;afb3
	sbc a,(hl)			;afb4
	sbc a,l			;afb5
	rst 18h			;afb6
	sbc a,e			;afb7
	sbc a,d			;afb8
	adc a,h			;afb9
	adc a,e			;afba
	sbc a,(hl)			;afbb
	sbc a,h			;afbc
	sbc a,(hl)			;afbd
	sub c			;afbe
	sbc a,e			;afbf
	sub b			;afc0
	rst 18h			;afc1
	adc a,l			;afc2
	sbc a,d			;afc3
	sub e			;afc4
	sub (hl)			;afc5
	sbc a,d			;afc6
	adc a,c			;afc7
	sbc a,d			;afc8
	adc a,h			;afc9
	rst 18h			;afca
	sbc a,(hl)			;afcb
	sub c			;afcc
	adc a,e			;afcd
	sbc a,d			;afce
	adc a,h			;afcf
	rst 18h			;afd0
	sbc a,e			;afd1
	sbc a,d			;afd2
	adc a,h			;afd3
	sbc a,(hl)			;afd4
	adc a,a			;afd5
	sbc a,d			;afd6
	adc a,l			;afd7
	sbc a,h			;afd8
	sub (hl)			;afd9
	sbc a,l			;afda
	sub (hl)			;afdb
	sbc a,e			;afdc
	sub b			;afdd
	adc a,h			;afde
	push af			;afdf
	cp d			;afe0
	sub e			;afe1
	rst 18h			;afe2
	sub b			;afe3
	sbc a,l			;afe4
	adc a,h			;afe5
	sbc a,d			;afe6
	adc a,l			;afe7
	adc a,c			;afe8
	sbc a,(hl)			;afe9
	sbc a,e			;afea
	sub b			;afeb
	adc a,l			;afec
	rst 18h			;afed
	adc a,e			;afee
	sbc a,d			;afef
	rst 18h			;aff0
	sbc a,e			;aff1
	sbc a,(hl)			;aff2
	rst 18h			;aff3
	adc a,d			;aff4
	sub c			;aff5
	sbc a,(hl)			;aff6
	rst 18h			;aff7
	adc a,c			;aff8
	sub (hl)			;aff9
	adc a,h			;affa
	sub (hl)			;affb
	rst 20h			;affc
	sub c			;affd
	rst 18h			;affe
	sbc a,(hl)			;afff
	sub d			;b000
	adc a,a			;b001
	sub e			;b002
	sub (hl)			;b003
	sbc a,(hl)			;b004
	sbc a,e			;b005
	sbc a,(hl)			;b006
	rst 18h			;b007
	sbc a,e			;b008
	sbc a,d			;b009
	rst 18h			;b00a
	sub e			;b00b
	sbc a,(hl)			;b00c
	rst 18h			;b00d
	add a,l			;b00e
	sub b			;b00f
	sub c			;b010
	sbc a,(hl)			;b011
	rst 18h			;b012
	sbc a,(hl)			;b013
	adc a,a			;b014
	adc a,d			;b015
	sub c			;b016
	adc a,e			;b017
	sbc a,(hl)			;b018
	sbc a,e			;b019
	sbc a,(hl)			;b01a
	pop de			;b01b
	push af			;b01c
	indr		;b01d
	sub c			;b01f
	rst 18h			;b020
	adc a,(hl)			;b021
	adc a,d			;b022
	jp (hl)			;b023
	rst 18h			;b024
	sbc a,e			;b025
	sub (hl)			;b026
	adc a,l			;b027
	sbc a,d			;b028
	sbc a,h			;b029
	sbc a,h			;b02a
	sub (hl)			;b02b
	rst 20h			;b02c
	sub c			;b02d
	ret nz			;b02e
	push af			;b02f
	sbc a,d			;b030
	sub c			;b031
	rst 18h			;b032
	sbc a,d			;b033
	sub e			;b034
	rst 18h			;b035
	sbc a,h			;b036
	sbc a,d			;b037
	sub c			;b038
	adc a,e			;b039
	adc a,l			;b03a
	sub b			;b03b
	rst 18h			;b03c
	adc a,h			;b03d
	sbc a,d			;b03e
	rst 18h			;b03f
	sbc a,e			;b040
	sbc a,d			;b041
	adc a,h			;b042
	adc a,e			;b043
	sbc a,(hl)			;b044
	sbc a,h			;b045
	sbc a,(hl)			;b046
	rst 18h			;b047
	sub e			;b048
	sbc a,(hl)			;b049
	rst 18h			;b04a
	sbc a,c			;b04b
	sub (hl)			;b04c
	sbc a,b			;b04d
	adc a,d			;b04e
	adc a,l			;b04f
	sbc a,(hl)			;b050
	rst 18h			;b051
	sbc a,e			;b052
	sbc a,d			;b053
	rst 18h			;b054
	push af			;b055
	adc a,h			;b056
	sub (hl)			;b057
	sub c			;b058
	rst 18h			;b059
	adc a,(hl)			;b05a
	adc a,d			;b05b
	sbc a,d			;b05c
	rst 18h			;b05d
	sub c			;b05e
	sub (hl)			;b05f
	sub c			;b060
	sbc a,b			;b061
	adc a,d			;b062
	sub c			;b063
	sub b			;b064
	rst 18h			;b065
	sbc a,e			;b066
	sbc a,d			;b067
	adc a,h			;b068
	adc a,e			;b069
	sbc a,(hl)			;b06a
	adc a,(hl)			;b06b
	adc a,d			;b06c
	sbc a,d			;b06d
	rst 18h			;b06e
	sbc a,d			;b06f
	sub c			;b070
	rst 18h			;b071
	adc a,a			;b072
	sbc a,(hl)			;b073
	adc a,l			;b074
	adc a,e			;b075
	sub (hl)			;b076
	sbc a,h			;b077
	adc a,d			;b078
	sub e			;b079
	sbc a,(hl)			;b07a
	adc a,l			;b07b
	pop de			;b07c
	push af			;b07d
	cp e			;b07e
	sub (hl)			;b07f
	adc a,h			;b080
	adc a,e			;b081
	sub (hl)			;b082
	sub c			;b083
	sbc a,b			;b084
	adc a,d			;b085
	sbc a,d			;b086
	adc a,h			;b087
	rst 18h			;b088
	adc a,d			;b089
	sub c			;b08a
	rst 18h			;b08b
	sbc a,b			;b08c
	adc a,l			;b08d
	adc a,d			;b08e
	adc a,a			;b08f
	sub b			;b090
	rst 18h			;b091
	sbc a,e			;b092
	sbc a,d			;b093
	rst 18h			;b094
	sbc a,l			;b095
	sbc a,(hl)			;b096
	sub l			;b097
	sub b			;b098
	adc a,l			;b099
	adc a,l			;b09a
	sbc a,d			;b09b
	sub e			;b09c
	sub (hl)			;b09d
	sbc a,d			;b09e
	adc a,c			;b09f
	sbc a,d			;b0a0
	adc a,h			;b0a1
	out (0dfh),a		;b0a2
	adc a,a			;b0a4
	sbc a,d			;b0a5
	adc a,l			;b0a6
	sub b			;b0a7
	rst 18h			;b0a8
	push af			;b0a9
	or d			;b0aa
	sbc a,d			;b0ab
	adc a,e			;b0ac
	sbc a,d			;b0ad
	adc a,h			;b0ae
	rst 18h			;b0af
	sub e			;b0b0
	sbc a,(hl)			;b0b1
	rst 18h			;b0b2
	sub e			;b0b3
	sub e			;b0b4
	sbc a,(hl)			;b0b5
	adc a,c			;b0b6
	sbc a,d			;b0b7
	rst 18h			;b0b8
	sbc a,d			;b0b9
	sub c			;b0ba
	rst 18h			;b0bb
	sub e			;b0bc
	sbc a,(hl)			;b0bd
	rst 18h			;b0be
	adc a,l			;b0bf
	sbc a,(hl)			;b0c0
	sub c			;b0c1
	adc a,d			;b0c2
	adc a,l			;b0c3
	sbc a,(hl)			;b0c4
	rst 18h			;b0c5
	push af			;b0c6
	push af			;b0c7
	add a,(hl)			;b0c8
	rst 18h			;b0c9
	sub e			;b0ca
	sbc a,(hl)			;b0cb
	rst 18h			;b0cc
	sbc a,b			;b0cd
	sub (hl)			;b0ce
	adc a,l			;b0cf
	sbc a,(hl)			;b0d0
	adc a,h			;b0d1
	rst 18h			;b0d2
	push af			;b0d3
	adc a,a			;b0d4
	sbc a,d			;b0d5
	adc a,l			;b0d6
	sub b			;b0d7
	rst 18h			;b0d8
	sub c			;b0d9
	sbc a,(hl)			;b0da
	sbc a,e			;b0db
	sbc a,(hl)			;b0dc
	rst 18h			;b0dd
	sub b			;b0de
	sbc a,h			;b0df
	adc a,d			;b0e0
	adc a,l			;b0e1
	adc a,l			;b0e2
	sbc a,d			;b0e3
	push af			;b0e4
	add a,(hl)			;b0e5
	rst 18h			;b0e6
	sub b			;b0e7
	add a,(hl)			;b0e8
	sbc a,d			;b0e9
	adc a,h			;b0ea
	rst 18h			;b0eb
	adc a,d			;b0ec
	sub c			;b0ed
	rst 18h			;b0ee
	adc a,l			;b0ef
	sub b			;b0f0
	sbc a,h			;b0f1
	sbc a,d			;b0f2
	rst 18h			;b0f3
	sbc a,e			;b0f4
	sbc a,d			;b0f5
	rst 18h			;b0f6
	adc a,a			;b0f7
	sub (hl)			;b0f8
	sbc a,d			;b0f9
	sbc a,e			;b0fa
	adc a,l			;b0fb
	sbc a,(hl)			;b0fc
	adc a,h			;b0fd
	push af			;b0fe
	xor a			;b0ff
	sbc a,(hl)			;b100
	adc a,l			;b101
	sbc a,(hl)			;b102
	rst 18h			;b103
	adc a,l			;b104
	sbc a,d			;b105
	sbc a,c			;b106
	sbc a,d			;b107
	adc a,l			;b108
	sub (hl)			;b109
	adc a,l			;b10a
	adc a,e			;b10b
	sbc a,d			;b10c
	rst 18h			;b10d
	sbc a,(hl)			;b10e
	rst 18h			;b10f
	adc a,d			;b110
	sub c			;b111
	sbc a,(hl)			;b112
	rst 18h			;b113
	sub e			;b114
	sub b			;b115
	adc a,h			;b116
	sbc a,(hl)			;b117
	rst 18h			;b118
	sbc a,e			;b119
	sbc a,d			;b11a
	adc a,e			;b11b
	sbc a,d			;b11c
	adc a,l			;b11d
	sub d			;b11e
	sub (hl)			;b11f
	sub c			;b120
	sbc a,(hl)			;b121
	sbc a,e			;b122
	sbc a,(hl)			;b123
	rst 18h			;b124
	adc a,d			;b125
	adc a,h			;b126
	sbc a,(hl)			;b127
	rst 18h			;b128
	cp (ix-043h)		;b129
	xor l			;b12c
	or (hl)			;b12d
	xor l			;b12e
	rst 18h			;b12f
	cp h			;b130
	or (hl)			;b131
	cp c			;b132
	xor l			;b133
	cp (hl)			;b134
	adc a,0dfh		;b135
	cp h			;b137
	or (hl)			;b138
	cp c			;b139
	xor l			;b13a
	cp (hl)			;b13b
	call 0d1ddh		;b13c
	push af			;b13f
	cp (hl)			;b140
	sub e			;b141
	sbc a,b			;b142
	sub b			;b143
	rst 18h			;b144
	adc a,e			;b145
	adc a,l			;b146
	sbc a,(hl)			;b147
	sbc a,l			;b148
	sbc a,(hl)			;b149
	rst 18h			;b14a
	sub e			;b14b
	sbc a,(hl)			;b14c
	rst 18h			;b14d
	sub e			;b14e
	sub b			;b14f
	adc a,h			;b150
	sbc a,(hl)			;b151
	pop de			;b152
	push af			;b153
	or e			;b154
	sbc a,d			;b155
	adc a,c			;b156
	sbc a,(hl)			;b157
	sub c			;b158
	adc a,e			;b159
	sbc a,(hl)			;b15a
	adc a,h			;b15b
	rst 18h			;b15c
	sub e			;b15d
	sbc a,(hl)			;b15e
	rst 18h			;b15f
	sub e			;b160
	sub b			;b161
	adc a,h			;b162
	sbc a,(hl)			;b163
	rst 18h			;b164
	add a,(hl)			;b165
	rst 18h			;b166
	sbc a,e			;b167
	sbc a,d			;b168
	adc a,h			;b169
	sbc a,h			;b16a
	adc a,d			;b16b
	sbc a,l			;b16c
	adc a,l			;b16d
	sbc a,d			;b16e
	adc a,h			;b16f
	rst 18h			;b170
	adc a,d			;b171
	sub c			;b172
	rst 18h			;b173
	adc a,a			;b174
	sbc a,(hl)			;b175
	adc a,h			;b176
	sbc a,(hl)			;b177
	sbc a,e			;b178
	sub (hl)			;b179
	add a,l			;b17a
	sub b			;b17b
	rst 18h			;b17c
	sub a			;b17d
	sbc a,(hl)			;b17e
	sbc a,h			;b17f
	sub (hl)			;b180
	sbc a,(hl)			;b181
	rst 18h			;b182
	sub e			;b183
	sbc a,(hl)			;b184
	adc a,h			;b185
	rst 18h			;b186
	sbc a,d			;b187
	sub c			;b188
	adc a,e			;b189
	adc a,l			;b18a
	sbc a,(hl)			;b18b
	push hl			;b18c
	sbc a,(hl)			;b18d
	adc a,h			;b18e
	rst 18h			;b18f
	sbc a,e			;b190
	sbc a,d			;b191
	rst 18h			;b192
	sub e			;b193
	sbc a,(hl)			;b194
	rst 18h			;b195
	adc a,a			;b196
	sub (hl)			;b197
	adc a,l			;b198
	jp pe,09692h		;b199
	sbc a,e			;b19c
	sbc a,d			;b19d
	pop de			;b19e
	push af			;b19f
	xor a			;b1a0
	sub b			;b1a1
	sub c			;b1a2
	sbc a,d			;b1a3
	adc a,h			;b1a4
	rst 18h			;b1a5
	sub e			;b1a6
	sbc a,(hl)			;b1a7
	rst 18h			;b1a8
	sub e			;b1a9
	sub b			;b1aa
	adc a,h			;b1ab
	sbc a,(hl)			;b1ac
	rst 18h			;b1ad
	sbc a,d			;b1ae
	sub c			;b1af
	rst 18h			;b1b0
	adc a,h			;b1b1
	adc a,d			;b1b2
	rst 18h			;b1b3
	adc a,h			;b1b4
	sub (hl)			;b1b5
	adc a,e			;b1b6
	sub (hl)			;b1b7
	sub b			;b1b8
	pop de			;b1b9
	push af			;b1ba
	xor e			;b1bb
	sbc a,d			;b1bc
	rst 18h			;b1bd
	adc a,h			;b1be
	adc a,d			;b1bf
	sub d			;b1c0
	sbc a,d			;b1c1
	adc a,l			;b1c2
	sbc a,b			;b1c3
	sbc a,d			;b1c4
	adc a,h			;b1c5
	rst 18h			;b1c6
	sbc a,d			;b1c7
	sub c			;b1c8
	rst 18h			;b1c9
	sbc a,d			;b1ca
	sub e			;b1cb
	rst 18h			;b1cc
	sbc a,h			;b1cd
	sbc a,(hl)			;b1ce
	rst 20h			;b1cf
	adc a,e			;b1d0
	sub (hl)			;b1d1
	sbc a,h			;b1d2
	sub b			;b1d3
	rst 18h			;b1d4
	sub c			;b1d5
	adc a,d			;b1d6
	sbc a,h			;b1d7
	sub e			;b1d8
	sbc a,d			;b1d9
	sub b			;b1da
	rst 18h			;b1db
	sbc a,e			;b1dc
	sbc a,d			;b1dd
	sub e			;b1de
	rst 18h			;b1df
	or d			;b1e0
	jp pe,0df8ch		;b1e1
	cp (hl)			;b1e4
	sub e			;b1e5
	sub e			;b1e6
	jp pe,0b2dfh		;b1e7
	sbc a,(hl)			;b1ea
	add a,(hl)			;b1eb
	sbc a,(hl)			;b1ec
	pop de			;b1ed
	di			;b1ee
	call p,09eb3h		;b1ef
	rst 18h			;b1f2
	sbc a,h			;b1f3
	sub e			;b1f4
	sbc a,(hl)			;b1f5
	adc a,c			;b1f6
	sbc a,d			;b1f7
	rst 18h			;b1f8
	sbc a,d			;b1f9
	adc a,h			;b1fa
	rst 18h			;b1fb
	xor l			;b1fc
	or (hl)			;b1fd
	cp h			;b1fe
	or b			;b1ff
	rst 18h			;b200
	xor a			;b201
	cp (hl)			;b202
	xor a			;b203
	cp (hl)			;b204
	xor h			;b205
	or (hl)			;b206
	xor e			;b207
	or b			;b208
	pop de			;b209
	push af			;b20a
	inc h			;b20b
	sbc a,e			;b20c
	jr nc,$-99		;b20d
	ld e,(hl)			;b20f
	sbc a,e			;b210
	sbc a,a			;b211
	sbc a,e			;b212
	cp (hl)			;b213
	sbc a,e			;b214
	call pe,0209bh		;b215
	sbc a,h			;b218
	scf			;b219
	sbc a,h			;b21a
	ld c,(hl)			;b21b
	sbc a,h			;b21c
	ld c,a			;b21d
	sbc a,h			;b21e
	ld a,e			;b21f
	sbc a,h			;b220
	and h			;b221
	sbc a,h			;b222
	cp h			;b223
	sbc a,h			;b224
	jp pe,00b9ch		;b225
	sbc a,l			;b228
	ld (de),a			;b229
	sbc a,l			;b22a
	add hl,hl			;b22b
	sbc a,l			;b22c
	ld d,d			;b22d
	sbc a,l			;b22e
	ld h,b			;b22f
	sbc a,l			;b230
	halt			;b231
	sbc a,l			;b232
	ld (hl),a			;b233
	sbc a,l			;b234
	sub l			;b235
	sbc a,l			;b236
	or b			;b237
	sbc a,l			;b238
	pop bc			;b239
	sbc a,l			;b23a
	pop hl			;b23b
	sbc a,l			;b23c
	jr $-96		;b23d
	ld a,(04e9eh)		;b23f
	sbc a,(hl)			;b242
	ld h,c			;b243
	sbc a,(hl)			;b244
	ld (hl),b			;b245
	sbc a,(hl)			;b246
	add a,c			;b247
	sbc a,(hl)			;b248
	sbc a,c			;b249
	sbc a,(hl)			;b24a
	or l			;b24b
	sbc a,(hl)			;b24c
	add a,09eh		;b24d
	ei			;b24f
	sbc a,(hl)			;b250
	add hl,hl			;b251
	sbc a,a			;b252
	ld c,e			;b253
	sbc a,a			;b254
	ld h,l			;b255
	sbc a,a			;b256
	ld a,b			;b257
	sbc a,a			;b258
	adc a,(hl)			;b259
	sbc a,a			;b25a
	xor (hl)			;b25b
	sbc a,a			;b25c
	jp z,0ec9fh		;b25d
	sbc a,a			;b260
	dec b			;b261
	and b			;b262
	cpl			;b263
	and b			;b264
	ld d,d			;b265
	and b			;b266
	sub e			;b267
	and b			;b268
	adc a,0a0h		;b269
	ret po			;b26b
	and b			;b26c
	pop hl			;b26d
	and b			;b26e
	ld a,(de)			;b26f
	and c			;b270
	dec a			;b271
	and c			;b272
	ld e,a			;b273
	and c			;b274
	and b			;b275
	and c			;b276
	rst 0			;b277
	and c			;b278
	ret z			;b279
	and c			;b27a
	dec d			;b27b
	and d			;b27c
	ld sp,04ca2h		;b27d
	and d			;b280
	add a,a			;b281
	and d			;b282
	adc a,b			;b283
	and d			;b284
	ret pe			;b285
	and d			;b286
	jr $-91		;b287
	ld d,c			;b289
	and e			;b28a
	ld d,d			;b28b
	and e			;b28c
	ld l,d			;b28d
	and e			;b28e
	sbc a,b			;b28f
	and e			;b290
	pop de			;b291
	and e			;b292
	ld de,02ea4h		;b293
	and h			;b296
	ld b,b			;b297
	and h			;b298
	ld (hl),a			;b299
	and h			;b29a
	xor d			;b29b
	and h			;b29c
	rst 8			;b29d
	and h			;b29e
	push af			;b29f
	and h			;b2a0
	or 0a4h		;b2a1
	rst 30h			;b2a3
	and h			;b2a4
	ret m			;b2a5
	and h			;b2a6
	ld sp,hl			;b2a7
	and h			;b2a8
	jp m,0fba4h		;b2a9
	and h			;b2ac
	dec l			;b2ad
	and l			;b2ae
	ld a,(hl)			;b2af
	and l			;b2b0
	and d			;b2b1
	and l			;b2b2
	or a			;b2b3
	and l			;b2b4
	ret p			;b2b5
	and l			;b2b6
	nop			;b2b7
	and (hl)			;b2b8
	ld hl,(034a6h)		;b2b9
	and (hl)			;b2bc
	dec (hl)			;b2bd
	and (hl)			;b2be
	ld c,l			;b2bf
	and (hl)			;b2c0
	ld l,b			;b2c1
	and (hl)			;b2c2
	ld l,c			;b2c3
	and (hl)			;b2c4
	ld a,h			;b2c5
	and (hl)			;b2c6
	ld a,l			;b2c7
	and (hl)			;b2c8
	sub b			;b2c9
	and (hl)			;b2ca
	sbc a,e			;b2cb
	and (hl)			;b2cc
	sbc a,h			;b2cd
	and (hl)			;b2ce
	xor d			;b2cf
	and (hl)			;b2d0
	pop bc			;b2d1
	and (hl)			;b2d2
	push de			;b2d3
	and (hl)			;b2d4
	call pe,0eda6h		;b2d5
	and (hl)			;b2d8
	ld c,d			;b2d9
	and a			;b2da
	ld h,a			;b2db
	and a			;b2dc
	sub c			;b2dd
	and a			;b2de
	cp e			;b2df
	and a			;b2e0
	call 0f2a7h		;b2e1
	and a			;b2e4
	inc e			;b2e5
	xor b			;b2e6
	inc sp			;b2e7
	xor b			;b2e8
	ld e,b			;b2e9
	xor b			;b2ea
	ld a,a			;b2eb
	xor b			;b2ec
	add a,b			;b2ed
	xor b			;b2ee
	sub (hl)			;b2ef
	xor b			;b2f0
	cp b			;b2f1
	xor b			;b2f2
	sub 0a8h		;b2f3
	inc b			;b2f5
	xor c			;b2f6
	dec h			;b2f7
	xor c			;b2f8
	ld h,0a9h		;b2f9
	ld b,b			;b2fb
	xor c			;b2fc
	ld e,h			;b2fd
	xor c			;b2fe
	sub l			;b2ff
	xor c			;b300
	xor a			;b301
	xor c			;b302
	jp p,024a9h		;b303
	xor d			;b306
	ld c,d			;b307
	xor d			;b308
	ld e,e			;b309
	xor d			;b30a
	ld (hl),d			;b30b
	xor d			;b30c
	cp e			;b30d
	xor d			;b30e
	defb 0fdh,0aah,012h	;illegal sequence		;b30f
	xor e			;b312
	ld (048abh),a		;b313
	xor e			;b316
	ld (hl),d			;b317
	xor e			;b318
	add a,e			;b319
	xor e			;b31a
	ret			;b31b
	xor e			;b31c
	ld (079ach),hl		;b31d
	xor h			;b320
	and e			;b321
	xor h			;b322
	or a			;b323
	xor h			;b324
	push bc			;b325
	xor h			;b326
	rst 18h			;b327
	xor h			;b328
	inc b			;b329
	xor l			;b32a
	ld de,02aadh		;b32b
	xor l			;b32e
	sub l			;b32f
	xor l			;b330
	pop de			;b331
	xor l			;b332
	jp nc,0d3adh		;b333
	xor l			;b336
	rst 30h			;b337
	xor l			;b338
	ld (051aeh),hl		;b339
	xor (hl)			;b33c
	ld a,l			;b33d
	xor (hl)			;b33e
	cp (hl)			;b33f
	xor (hl)			;b340
	defb 0edh;next byte illegal after ed		;b341
	xor (hl)			;b342
	jp m,00baeh		;b343
	xor a			;b346
	jr $-79		;b347
	add hl,sp			;b349
	xor a			;b34a
	ld b,e			;b34b
	xor a			;b34c
	ld e,d			;b34d
	xor a			;b34e
	sub a			;b34f
	xor a			;b350
	ret po			;b351
	xor a			;b352
	dec e			;b353
	or b			;b354
	jr nc,$-78		;b355
	ld d,(hl)			;b357
	or b			;b358
	ld a,(hl)			;b359
	or b			;b35a
	xor d			;b35b
	or b			;b35c
	rst 0			;b35d
	or b			;b35e
	ret z			;b35f
	or b			;b360
	call nc,0e5b0h		;b361
	or b			;b364
	rst 38h			;b365
	or b			;b366
	ld b,b			;b367
	or c			;b368
	ld d,h			;b369
	or c			;b36a
	and b			;b36b
	or c			;b36c
	cp e			;b36d
	or c			;b36e
	adc a,d			;b36f
	sub c			;b370
	sbc a,(hl)			;b371
	rst 18h			;b372
	sbc a,l			;b373
	sub b			;b374
	adc a,l			;b375
	sub e			;b376
	sbc a,(hl)			;b377
	rst 18h			;b378
	sbc a,d			;b379
	sub c			;b37a
	sbc a,h			;b37b
	sbc a,d			;b37c
	sub c			;b37d
	sbc a,e			;b37e
	sub (hl)			;b37f
	sbc a,e			;b380
	sbc a,(hl)			;b381
	push af			;b382
	adc a,d			;b383
	sub c			;b384
	rst 18h			;b385
	sbc a,h			;b386
	adc a,d			;b387
	sbc a,d			;b388
	sub c			;b389
	sbc a,h			;b38a
	sub b			;b38b
	rst 18h			;b38c
	sbc a,e			;b38d
	sbc a,d			;b38e
	sub e			;b38f
	rst 18h			;b390
	cp h			;b391
	sub a			;b392
	sbc a,(hl)			;b393
	sbc a,h			;b394
	rst 18h			;b395
	or d			;b396
	sub b			;b397
	sub b			;b398
	sub e			;b399
	push af			;b39a
	adc a,d			;b39b
	sub c			;b39c
	rst 18h			;b39d
	sbc a,h			;b39e
	sub (hl)			;b39f
	sub e			;b3a0
	sub (hl)			;b3a1
	sub c			;b3a2
	sbc a,e			;b3a3
	adc a,l			;b3a4
	sub b			;b3a5
	rst 18h			;b3a6
	sbc a,e			;b3a7
	sbc a,d			;b3a8
	rst 18h			;b3a9
	sub d			;b3aa
	sbc a,(hl)			;b3ab
	sbc a,e			;b3ac
	sbc a,d			;b3ad
	adc a,l			;b3ae
	sbc a,(hl)			;b3af
	push af			;b3b0
	adc a,d			;b3b1
	sub c			;b3b2
	sbc a,(hl)			;b3b3
	rst 18h			;b3b4
	adc a,d			;b3b5
	adc a,l			;b3b6
	sub c			;b3b7
	sbc a,(hl)			;b3b8
	push af			;b3b9
	adc a,d			;b3ba
	sub c			;b3bb
	rst 18h			;b3bc
	sbc a,(hl)			;b3bd
	sub e			;b3be
	adc a,e			;b3bf
	sbc a,(hl)			;b3c0
	adc a,l			;b3c1
	push af			;b3c2
	adc a,d			;b3c3
	sub c			;b3c4
	sbc a,(hl)			;b3c5
	rst 18h			;b3c6
	adc a,c			;b3c7
	sbc a,(hl)			;b3c8
	adc a,h			;b3c9
	sub (hl)			;b3ca
	sub l			;b3cb
	sbc a,(hl)			;b3cc
	push af			;b3cd
	adc a,d			;b3ce
	sub c			;b3cf
	rst 18h			;b3d0
	sbc a,h			;b3d1
	sbc a,(hl)			;b3d2
	add a,l			;b3d3
	sub b			;b3d4
	push af			;b3d5
	adc a,d			;b3d6
	sub c			;b3d7
	sbc a,(hl)			;b3d8
	rst 18h			;b3d9
	sbc a,d			;b3da
	adc a,h			;b3db
	sbc a,h			;b3dc
	adc a,d			;b3dd
	sbc a,e			;b3de
	sub (hl)			;b3df
	sub e			;b3e0
	sub e			;b3e1
	sbc a,(hl)			;b3e2
	push af			;b3e3
	adc a,d			;b3e4
	sub c			;b3e5
	sbc a,(hl)			;b3e6
	rst 18h			;b3e7
	sbc a,h			;b3e8
	sbc a,(hl)			;b3e9
	sub e			;b3ea
	sbc a,(hl)			;b3eb
	sbc a,l			;b3ec
	sbc a,(hl)			;b3ed
	add a,l			;b3ee
	sbc a,(hl)			;b3ef
	push af			;b3f0
	adc a,d			;b3f1
	sub c			;b3f2
	rst 18h			;b3f3
	adc a,e			;b3f4
	sbc a,(hl)			;b3f5
	adc a,l			;b3f6
	adc a,l			;b3f7
	sub b			;b3f8
	push af			;b3f9
	adc a,d			;b3fa
	sub c			;b3fb
	sbc a,(hl)			;b3fc
	rst 18h			;b3fd
	sbc a,(hl)			;b3fe
	adc a,l			;b3ff
	sbc a,(hl)			;b400
	push hl			;b401
	sbc a,(hl)			;b402
	rst 18h			;b403
	adc a,e			;b404
	sbc a,(hl)			;b405
	sub e			;b406
	sub e			;b407
	sbc a,(hl)			;b408
	sbc a,e			;b409
	sbc a,(hl)			;b40a
	push af			;b40b
	adc a,d			;b40c
	sub c			;b40d
	rst 18h			;b40e
	sub b			;b40f
	sbc a,l			;b410
	adc a,h			;b411
	sbc a,d			;b412
	adc a,l			;b413
	adc a,c			;b414
	sbc a,(hl)			;b415
	sbc a,e			;b416
	sub b			;b417
	adc a,l			;b418
	push af			;b419
	adc a,d			;b41a
	sub c			;b41b
	rst 18h			;b41c
	sbc a,h			;b41d
	rst 20h			;b41e
	sbc a,e			;b41f
	sub (hl)			;b420
	sbc a,h			;b421
	sbc a,d			;b422
	push af			;b423
	adc a,d			;b424
	sub c			;b425
	rst 18h			;b426
	sbc a,(hl)			;b427
	sub c			;b428
	sub (hl)			;b429
	sub e			;b42a
	sub e			;b42b
	sub b			;b42c
	push af			;b42d
	adc a,d			;b42e
	sub c			;b42f
	sbc a,(hl)			;b430
	rst 18h			;b431
	adc a,a			;b432
	sub (hl)			;b433
	sbc a,d			;b434
	sbc a,e			;b435
	adc a,l			;b436
	sbc a,(hl)			;b437
	rst 18h			;b438
	sub d			;b439
	sbc a,(hl)			;b43a
	adc a,l			;b43b
	adc a,l			;b43c
	rst 20h			;b43d
	sub c			;b43e
	push af			;b43f
	adc a,d			;b440
	sub c			;b441
	sbc a,(hl)			;b442
	rst 18h			;b443
	adc a,a			;b444
	sub (hl)			;b445
	sbc a,d			;b446
	sbc a,e			;b447
	adc a,l			;b448
	sbc a,(hl)			;b449
	rst 18h			;b44a
	adc a,l			;b44b
	sub b			;b44c
	sub l			;b44d
	sbc a,(hl)			;b44e
	push af			;b44f
	adc a,d			;b450
	sub c			;b451
	rst 18h			;b452
	adc a,e			;b453
	adc a,l			;b454
	sub b			;b455
	add a,l			;b456
	sub b			;b457
	rst 18h			;b458
	sbc a,e			;b459
	sbc a,d			;b45a
	rst 18h			;b45b
	sbc a,h			;b45c
	sbc a,(hl)			;b45d
	adc a,l			;b45e
	sbc a,l			;b45f
	rst 20h			;b460
	sub c			;b461
	push af			;b462
	adc a,d			;b463
	sub c			;b464
	rst 18h			;b465
	rst 20h			;b466
	sub c			;b467
	sub (hl)			;b468
	sbc a,h			;b469
	sbc a,d			;b46a
	push af			;b46b
	adc a,d			;b46c
	sub c			;b46d
	rst 18h			;b46e
	adc a,l			;b46f
	adc a,d			;b470
	sbc a,l			;b471
	ret pe			;b472
	push af			;b473
	adc a,d			;b474
	sub c			;b475
	rst 18h			;b476
	sbc a,l			;b477
	adc a,l			;b478
	sub (hl)			;b479
	sub e			;b47a
	sub e			;b47b
	sbc a,(hl)			;b47c
	sub c			;b47d
	adc a,e			;b47e
	sbc a,d			;b47f
	push af			;b480
	adc a,d			;b481
	sub c			;b482
	rst 18h			;b483
	sbc a,c			;b484
	adc a,l			;b485
	adc a,d			;b486
	adc a,e			;b487
	sub b			;b488
	rst 18h			;b489
	sbc a,e			;b48a
	sbc a,d			;b48b
	rst 18h			;b48c
	sbc a,h			;b48d
	sbc a,(hl)			;b48e
	sbc a,h			;b48f
	sbc a,(hl)			;b490
	sub b			;b491
	push af			;b492
	adc a,d			;b493
	sub c			;b494
	sbc a,(hl)			;b495
	rst 18h			;b496
	sbc a,c			;b497
	sub e			;b498
	sub b			;b499
	adc a,l			;b49a
	rst 18h			;b49b
	sbc a,e			;b49c
	sbc a,d			;b49d
	rst 18h			;b49e
	adc a,a			;b49f
	sbc a,d			;b4a0
	add a,(hl)			;b4a1
	sub b			;b4a2
	adc a,e			;b4a3
	sub e			;b4a4
	push af			;b4a5
	adc a,d			;b4a6
	sub c			;b4a7
	rst 18h			;b4a8
	sbc a,l			;b4a9
	sub b			;b4aa
	adc a,e			;b4ab
	rst 20h			;b4ac
	sub c			;b4ad
	rst 18h			;b4ae
	sbc a,e			;b4af
	sbc a,d			;b4b0
	rst 18h			;b4b1
	sub d			;b4b2
	sbc a,d			;b4b3
	adc a,h			;b4b4
	sbc a,h			;b4b5
	sbc a,(hl)			;b4b6
	sub e			;b4b7
	push af			;b4b8
	adc a,d			;b4b9
	sub c			;b4ba
	sbc a,(hl)			;b4bb
	rst 18h			;b4bc
	sub e			;b4bd
	sbc a,(hl)			;b4be
	sub c			;b4bf
	sbc a,h			;b4c0
	sbc a,d			;b4c1
	adc a,e			;b4c2
	sbc a,(hl)			;b4c3
	push af			;b4c4
	adc a,d			;b4c5
	sub c			;b4c6
	rst 18h			;b4c7
	sbc a,h			;b4c8
	adc a,d			;b4c9
	sbc a,h			;b4ca
	sub a			;b4cb
	sub (hl)			;b4cc
	sub e			;b4cd
	sub e			;b4ce
	sub b			;b4cf
	push af			;b4d0
	adc a,d			;b4d1
	sub c			;b4d2
	sbc a,(hl)			;b4d3
	rst 18h			;b4d4
	sub a			;b4d5
	sub b			;b4d6
	sub l			;b4d7
	sbc a,(hl)			;b4d8
	rst 18h			;b4d9
	sbc a,e			;b4da
	sbc a,d			;b4db
	rst 18h			;b4dc
	adc a,e			;b4dd
	sbc a,(hl)			;b4de
	sbc a,l			;b4df
	sbc a,(hl)			;b4e0
	sbc a,h			;b4e1
	sub b			;b4e2
	push af			;b4e3
	adc a,d			;b4e4
	sub c			;b4e5
	sbc a,(hl)			;b4e6
	rst 18h			;b4e7
	sub a			;b4e8
	sub b			;b4e9
	sub l			;b4ea
	sbc a,(hl)			;b4eb
	rst 18h			;b4ec
	adc a,h			;b4ed
	sbc a,d			;b4ee
	sbc a,h			;b4ef
	sbc a,(hl)			;b4f0
	rst 18h			;b4f1
	sbc a,e			;b4f2
	sbc a,d			;b4f3
	rst 18h			;b4f4
	adc a,e			;b4f5
	sbc a,(hl)			;b4f6
	sbc a,l			;b4f7
	sbc a,(hl)			;b4f8
	sbc a,h			;b4f9
	sub b			;b4fa
	push af			;b4fb
	adc a,d			;b4fc
	sub c			;b4fd
	rst 18h			;b4fe
	sbc a,h			;b4ff
	sub (hl)			;b500
	sbc a,b			;b501
	sbc a,(hl)			;b502
	adc a,l			;b503
	adc a,l			;b504
	sub b			;b505
	push af			;b506
	adc a,d			;b507
	sub c			;b508
	sbc a,(hl)			;b509
	rst 18h			;b50a
	adc a,a			;b50b
	sub (hl)			;b50c
	adc a,a			;b50d
	sbc a,(hl)			;b50e
	push af			;b50f
	adc a,d			;b510
	sub c			;b511
	sbc a,(hl)			;b512
	rst 18h			;b513
	sbc a,h			;b514
	sub b			;b515
	adc a,l			;b516
	adc a,e			;b517
	sbc a,d			;b518
	add a,l			;b519
	sbc a,(hl)			;b51a
	rst 18h			;b51b
	sbc a,e			;b51c
	sbc a,d			;b51d
	rst 18h			;b51e
	sbc a,l			;b51f
	sbc a,d			;b520
	sub e			;b521
	sbc a,h			;b522
	sub a			;b523
	jp (hl)			;b524
	push af			;b525
	adc a,d			;b526
	sub c			;b527
	sbc a,(hl)			;b528
	rst 18h			;b529
	adc a,l			;b52a
	sub b			;b52b
	adc a,h			;b52c
	sbc a,(hl)			;b52d
	push af			;b52e
	adc a,d			;b52f
	sub c			;b530
	sbc a,(hl)			;b531
	rst 18h			;b532
	adc a,l			;b533
	sub b			;b534
	adc a,h			;b535
	sbc a,(hl)			;b536
	rst 18h			;b537
	sbc a,e			;b538
	sbc a,d			;b539
	rst 18h			;b53a
	adc a,a			;b53b
	sub (hl)			;b53c
	sbc a,d			;b53d
	sbc a,e			;b53e
	adc a,l			;b53f
	sbc a,(hl)			;b540
	push af			;b541
	adc a,d			;b542
	sub c			;b543
	sbc a,(hl)			;b544
	rst 18h			;b545
	sbc a,l			;b546
	sub b			;b547
	adc a,l			;b548
	sub e			;b549
	sbc a,(hl)			;b54a
	rst 18h			;b54b
	sbc a,e			;b54c
	sbc a,d			;b54d
	rst 18h			;b54e
	sbc a,(hl)			;b54f
	sub e			;b550
	sbc a,b			;b551
	sub b			;b552
	sbc a,e			;b553
	rst 20h			;b554
	sub c			;b555
	push af			;b556
	adc a,d			;b557
	sub c			;b558
	rst 18h			;b559
	adc a,h			;b55a
	sub b			;b55b
	sub e			;b55c
	rst 18h			;b55d
	sbc a,e			;b55e
	sbc a,d			;b55f
	rst 18h			;b560
	sub b			;b561
	adc a,l			;b562
	sub b			;b563
	push af			;b564
	adc a,d			;b565
	sub c			;b566
	sbc a,(hl)			;b567
	rst 18h			;b568
	sub d			;b569
	sbc a,(hl)			;b56a
	sub c			;b56b
	adc a,e			;b56c
	sbc a,(hl)			;b56d
	push af			;b56e
	adc a,d			;b56f
	sub c			;b570
	sbc a,(hl)			;b571
	rst 18h			;b572
	adc a,h			;b573
	sbc a,d			;b574
	adc a,l			;b575
	adc a,a			;b576
	sub (hl)			;b577
	sbc a,d			;b578
	sub c			;b579
	adc a,e			;b57a
	sbc a,d			;b57b
	rst 18h			;b57c
	sbc a,e			;b57d
	sbc a,d			;b57e
	rst 18h			;b57f
	sub l			;b580
	sbc a,(hl)			;b581
	sbc a,e			;b582
	sbc a,d			;b583
	push af			;b584
	adc a,d			;b585
	sub c			;b586
	sbc a,(hl)			;b587
	rst 18h			;b588
	adc a,a			;b589
	sbc a,d			;b58a
	sub e			;b58b
	sub b			;b58c
	adc a,e			;b58d
	sbc a,(hl)			;b58e
	push af			;b58f
	adc a,d			;b590
	sub c			;b591
	sbc a,(hl)			;b592
	rst 18h			;b593
	sub e			;b594
	sub e			;b595
	sbc a,(hl)			;b596
	adc a,c			;b597
	sbc a,d			;b598
	push af			;b599
	sbc a,h			;b59a
	sub a			;b59b
	sub b			;b59c
	sbc a,h			;b59d
	sub b			;b59e
	sub e			;b59f
	sbc a,(hl)			;b5a0
	adc a,e			;b5a1
	sbc a,d			;b5a2
	rst 18h			;b5a3
	sbc a,h			;b5a4
	sbc a,(hl)			;b5a5
	sub e			;b5a6
	sub (hl)			;b5a7
	sbc a,d			;b5a8
	sub c			;b5a9
	adc a,e			;b5aa
	sbc a,d			;b5ab
	push af			;b5ac
	adc a,l			;b5ad
	sbc a,d			;b5ae
	adc a,h			;b5af
	sub (hl)			;b5b0
	sub c			;b5b1
	sbc a,(hl)			;b5b2
	rst 18h			;b5b3
	sbc a,e			;b5b4
	sbc a,d			;b5b5
	rst 18h			;b5b6
	sbc a,h			;b5b7
	sbc a,(hl)			;b5b8
	adc a,d			;b5b9
	sbc a,h			;b5ba
	sub a			;b5bb
	sub b			;b5bc
	push af			;b5bd
	sbc a,l			;b5be
	sbc a,d			;b5bf
	sbc a,l			;b5c0
	sub (hl)			;b5c1
	sbc a,e			;b5c2
	sbc a,(hl)			;b5c3
	rst 18h			;b5c4
	sbc a,e			;b5c5
	sbc a,d			;b5c6
	rst 18h			;b5c7
	sbc a,l			;b5c8
	sbc a,d			;b5c9
	sub e			;b5ca
	sbc a,h			;b5cb
	sub a			;b5cc
	jp (hl)			;b5cd
	push af			;b5ce
	adc a,h			;b5cf
	adc a,d			;b5d0
	adc a,h			;b5d1
	adc a,e			;b5d2
	sbc a,(hl)			;b5d3
	sub c			;b5d4
	sbc a,h			;b5d5
	sub (hl)			;b5d6
	sbc a,(hl)			;b5d7
	rst 18h			;b5d8
	adc a,c			;b5d9
	sub (hl)			;b5da
	adc a,h			;b5db
	sbc a,h			;b5dc
	sub b			;b5dd
	adc a,h			;b5de
	sbc a,(hl)			;b5df
	push af			;b5e0
	ld l,a			;b5e1
	or e			;b5e2
	add a,e			;b5e3
	or e			;b5e4
	sbc a,e			;b5e5
	or e			;b5e6
	or c			;b5e7
	or e			;b5e8
	cp d			;b5e9
	or e			;b5ea
	jp 0ceb3h		;b5eb
	or e			;b5ee
	sub 0b3h		;b5ef
	call po,0f1b3h		;b5f1
	or e			;b5f4
	jp m,00cb3h		;b5f5
	or h			;b5f8
	ld a,(de)			;b5f9
	or h			;b5fa
	inc h			;b5fb
	or h			;b5fc
	ld l,0b4h		;b5fd
	ld b,b			;b5ff
	or h			;b600
	ld d,b			;b601
	or h			;b602
	ld h,e			;b603
	or h			;b604
	ld l,h			;b605
	or h			;b606
	ld (hl),h			;b607
	or h			;b608
	add a,c			;b609
	or h			;b60a
	sub e			;b60b
	or h			;b60c
	and (hl)			;b60d
	or h			;b60e
	cp c			;b60f
	or h			;b610
	push bc			;b611
	or h			;b612
	pop de			;b613
	or h			;b614
	call po,0fcb4h		;b615
	or h			;b618
	rlca			;b619
	or l			;b61a
	djnz $-73		;b61b
	ld h,0b5h		;b61d
	cpl			;b61f
	or l			;b620
	ld b,d			;b621
	or l			;b622
	ld d,a			;b623
	or l			;b624
	ld h,l			;b625
	or l			;b626
	ld l,a			;b627
	or l			;b628
	add a,l			;b629
	or l			;b62a
	sub b			;b62b
	or l			;b62c
	sbc a,d			;b62d
	or l			;b62e
	xor l			;b62f
	or l			;b630
	cp (hl)			;b631
	or l			;b632
	rst 8			;b633
	or l			;b634
	jp p,07f7fh		;b635
	ld a,a			;b638
	ld a,a			;b639
	ld a,a			;b63a
	ld a,a			;b63b
	ld a,a			;b63c
	ld a,a			;b63d
	jp p,0f2f2h		;b63e
	ld a,e			;b641
	djnz $+18		;b642
	cp h			;b644
	or a			;b645
	or (hl)			;b646
	cp h			;b647
	or a			;b648
	cp d			;b649
	or c			;b64a
	rst 18h			;b64b
	or (hl)			;b64c
	xor e			;b64d
	and l			;b64e
	cp (hl)			;b64f
	rst 18h			;b650
	jp nc,0b6dfh		;b651
	rst 18h			;b654
	xor a			;b655
	cp (hl)			;b656
	xor l			;b657
	xor e			;b658
	cp d			;b659
	jp p,0107bh		;b65a
	rst 18h			;b65d
	ld (hl),h			;b65e
	ld (hl),h			;b65f
	ld (hl),h			;b660
	ld (hl),h			;b661
	jp nz,0c2c2h		;b662
	jp nz,0f2f2h		;b665
	jp p,0107bh		;b668
	cp e			;b66b
	sub (hl)			;b66c
	ld d,e			;b66d
	sbc a,h			;b66e
	ld e,e			;b66f
	ld b,e			;b670
	push bc			;b671
	rst 18h			;b672
	cp (hl)			;b673
	sub c			;b674
	sbc a,e			;b675
	adc a,l			;b676
	jp (hl)			;b677
	ld b,(hl)			;b678
	xor h			;b679
	ld c,b			;b67a
	adc a,d			;b67b
	dec a			;b67c
	sub b			;b67d
	jp p,010f2h		;b67e
	djnz $-79		;b681
	jr nz,$+73		;b683
	ld c,b			;b685
	sbc a,(hl)			;b686
	ld e,e			;b687
	ld b,e			;b688
	push bc			;b689
	rst 18h			;b68a
	or l			;b68b
	adc a,d			;b68c
	ld h,d			;b68d
	rst 18h			;b68e
	or d			;b68f
	ld h,d			;b690
	ld d,a			;b691
	ld d,c			;b692
	or d			;b693
	cpl			;b694
	ld d,(hl)			;b695
	sbc a,(hl)			;b696
	jp p,07bf2h		;b697
	ld a,e			;b69a
	cp b			;b69b
	adc a,l			;b69c
	jp pe,04d99h		;b69d
	ld e,b			;b6a0
	push bc			;b6a1
	rst 18h			;b6a2
	xor a			;b6a3
	ld c,(hl)			;b6a4
	ld h,h			;b6a5
	and l			;b6a6
	ld h,b			;b6a7
	dec c			;b6a8
	jp p,07bf2h		;b6a9
	ld a,e			;b6ac
	djnz $-31		;b6ad
	cp h			;b6af
	ld h,b			;b6b0
	sub e			;b6b1
	ld l,c			;b6b2
	or d			;b6b3
	ld h,b			;b6b4
	jr nc,$-21		;b6b5
	adc a,h			;b6b7
	jp p,07bf2h		;b6b8
	ld a,e			;b6bb
	xor a			;b6bc
	adc a,l			;b6bd
	ld d,a			;b6be
	sbc a,l			;b6bf
	ld e,c			;b6c0
	push bc			;b6c1
	rst 18h			;b6c2
	cp d			;b6c3
	adc a,c			;b6c4
	ld h,l			;b6c5
	xor h			;b6c6
	ld c,b			;b6c7
	inc sp			;b6c8
	sub (hl)			;b6c9
	ld h,e			;b6ca
	jp p,07ff2h		;b6cb
	ld a,a			;b6ce
	ld a,a			;b6cf
	ld a,a			;b6d0
	ld a,a			;b6d1
	ld a,a			;b6d2
	ld a,a			;b6d3
	ld a,a			;b6d4
	jp p,0f4f3h		;b6d5
	cp d			;b6d8
	ld d,c			;b6d9
	xor h			;b6da
	ld a,094h		;b6db
	ld h,c			;b6dd
	xor h			;b6de
	sbc a,(hl)			;b6df
	ld b,a			;b6e0
	ld l,d			;b6e1
	ld a,c			;b6e2
	adc a,h			;b6e3
	ld h,e			;b6e4
	adc a,a			;b6e5
	ld l,a			;b6e6
	sbc a,(hl)			;b6e7
	ld l,e			;b6e8
	adc a,e			;b6e9
	ld d,e			;b6ea
	ld (hl),e			;b6eb
	sbc a,e			;b6ec
	ld e,d			;b6ed
	adc a,h			;b6ee
	ld h,l			;b6ef
	adc a,c			;b6f0
	sbc a,d			;b6f1
	sbc a,b			;b6f2
	sbc a,d			;b6f3
	inc de			;b6f4
	ld e,e			;b6f5
	ld b,e			;b6f6
	rst 18h			;b6f7
	inc a			;b6f8
	sub b			;b6f9
	adc a,a			;b6fa
	ld c,l			;b6fb
	ld e,(hl)			;b6fc
	rst 18h			;b6fd
	inc (hl)			;b6fe
	ld e,e			;b6ff
	ld e,d			;b700
	sbc a,e			;b701
	ld (hl),l			;b702
	adc a,a			;b703
	adc a,d			;b704
	ld l,a			;b705
	ld (bc),a			;b706
	sub b			;b707
	dec l			;b708
	ld h,c			;b709
	adc a,e			;b70a
	ld e,a			;b70b
	adc a,l			;b70c
	ld h,a			;b70d
	ld e,b			;b70e
	ld l,c			;b70f
	adc a,l			;b710
	ret pe			;b711
	ld l,c			;b712
	adc a,e			;b713
	ld h,c			;b714
	sub a			;b715
	ld h,l			;b716
	sbc a,h			;b717
	ld e,h			;b718
	sbc a,e			;b719
	adc a,d			;b71a
	ld e,e			;b71b
	sbc a,e			;b71c
	ld h,h			;b71d
	ld h,l			;b71e
	adc a,h			;b71f
	ld e,(hl)			;b720
	adc a,c			;b721
	ld h,h			;b722
	sub a			;b723
	ld e,c			;b724
	inc de			;b725
	ld (hl),e			;b726
	sub d			;b727
	sbc a,d			;b728
	adc a,e			;b729
	halt			;b72a
	adc a,e			;b72b
	rla			;b72c
	ld a,(de)			;b72d
	sbc a,(hl)			;b72e
	sub l			;b72f
	sbc a,d			;b730
	push bc			;b731
	rst 18h			;b732
	or e			;b733
	ld h,l			;b734
	sub d			;b735
	ret pe			;b736
	adc a,e			;b737
	ld c,l			;b738
	ld h,l			;b739
	cp h			;b73a
	sub a			;b73b
	ld c,l			;b73c
	sub a			;b73d
	jp (hl)			;b73e
	sub c			;b73f
	rst 18h			;b740
	or (hl)			;b741
	adc a,e			;b742
	add a,l			;b743
	jp pe,0f5d1h		;b744
	cp d			;b747
	ld c,h			;b748
	jp pe,09246h		;b749
	adc a,d			;b74c
	ld h,e			;b74d
	adc a,e			;b74e
	add hl,sp			;b74f
	jp p,0f5f5h		;b750
	push af			;b753
	push af			;b754
	push af			;b755
	push af			;b756
	push af			;b757
	push af			;b758
	push af			;b759
	push af			;b75a
	push af			;b75b
	push af			;b75c
	push af			;b75d
	push af			;b75e
	push af			;b75f
	cp d			;b760
	ld c,h			;b761
	ld h,c			;b762
	sbc a,h			;b763
	sub e			;b764
	ld h,b			;b765
	ld h,h			;b766
	ld h,d			;b767
	jr c,$+117		;b768
	xor a			;b76a
	adc a,d			;b76b
	ld h,e			;b76c
	inc de			;b76d
	ld a,h			;b76e
	ld l,(hl)			;b76f
	cp (hl)			;b770
	ld e,0e5h		;b771
	ld e,c			;b773
	ld a,d			;b774
	dec sp			;b775
	ld e,c			;b776
	sub (hl)			;b777
	rst 18h			;b778
	ld d,(hl)			;b779
	adc a,c			;b77a
	ld b,l			;b77b
	ld c,a			;b77c
	ld h,h			;b77d
	adc a,a			;b77e
	ld e,a			;b77f
	ld (hl),e			;b780
	adc a,h			;b781
	daa			;b782
	adc a,c			;b783
	ld b,d			;b784
	rst 18h			;b785
	or a			;b786
	sbc a,(hl)			;b787
	ld e,e			;b788
	sbc a,(hl)			;b789
	ld (hl),d			;b78a
	xor h			;b78b
	ld d,d			;b78c
	inc h			;b78d
	dec de			;b78e
	jr $-22		;b78f
	ld h,l			;b791
	adc a,(hl)			;b792
	ld d,a			;b793
	sbc a,e			;b794
	sbc a,(hl)			;b795
	ld (hl),b			;b796
	adc a,a			;b797
	sub b			;b798
	sbc a,h			;b799
	ld (hl),l			;b79a
	sbc a,l			;b79b
	ld e,b			;b79c
	jr nc,$+99		;b79d
	inc c			;b79f
	sub d			;b7a0
	ret pe			;b7a1
	inc a			;b7a2
	sub b			;b7a3
	sbc a,c			;b7a4
	ld h,c			;b7a5
	ld d,l			;b7a6
	inc (hl)			;b7a7
	ld e,e			;b7a8
	sbc a,(hl)			;b7a9
	ld (hl),d			;b7aa
	cp d			;b7ab
	ld c,h			;b7ac
	sbc a,d			;b7ad
	ld (hl),d			;b7ae
	xor h			;b7af
	ld a,094h		;b7b0
	sbc a,d			;b7b2
	ld h,(hl)			;b7b3
	rst 18h			;b7b4
	ld e,(hl)			;b7b5
	rlca			;b7b6
	ld h,l			;b7b7
	inc (hl)			;b7b8
	ld e,e			;b7b9
	ld h,l			;b7ba
	sub e			;b7bb
	ld l,c			;b7bc
	xor e			;b7bd
	jr z,$+70		;b7be
	ld l,c			;b7c0
	xor h			;b7c1
	sbc a,(hl)			;b7c2
	ld b,a			;b7c3
	ld l,d			;b7c4
	adc a,h			;b7c5
	push af			;b7c6
	push af			;b7c7
	cp (hl)			;b7c8
	sub c			;b7c9
	ld (de),a			;b7ca
	scf			;b7cb
	ld h,l			;b7cc
	add a,l			;b7cd
	ld e,h			;b7ce
	halt			;b7cf
	sbc a,h			;b7d0
	ld (hl),012h		;b7d1
	adc a,c			;b7d3
	ld h,h			;b7d4
	sbc a,h			;b7d5
	ld e,c			;b7d6
	sub (hl)			;b7d7
	rst 18h			;b7d8
	sbc a,(hl)			;b7d9
	sub a			;b7da
	sub b			;b7db
	sbc a,b			;b7dc
	ld l,h			;b7dd
	ld c,e			;b7de
	ld e,a			;b7df
	ld (hl),d			;b7e0
	ld e,l			;b7e1
	adc a,a			;b7e2
	ld e,l			;b7e3
	ld h,h			;b7e4
	sub d			;b7e5
	ld e,h			;b7e6
	adc a,e			;b7e7
	ld h,c			;b7e8
	ld d,l			;b7e9
	sbc a,e			;b7ea
	ld e,h			;b7eb
	sbc a,e			;b7ec
	ld h,c			;b7ed
	ld b,c			;b7ee
	sbc a,l			;b7ef
	ld d,04ch		;b7f0
	ld e,d			;b7f2
	rst 18h			;b7f3
	inc bc			;b7f4
	sbc a,l			;b7f5
	ld d,h			;b7f6
	ld e,l			;b7f7
	ld (hl),c			;b7f8
	sbc a,l			;b7f9
	daa			;b7fa
	ld hl,(0dfe9h)		;b7fb
	ld d,l			;b7fe
	sbc a,h			;b7ff
	ld c,(hl)			;b800
	sbc a,(hl)			;b801
	sub b			;b802
	push af			;b803
	cp d			;b804
	ld c,h			;b805
	ld h,l			;b806
	add a,l			;b807
	ld e,h			;b808
	ld h,l			;b809
	ld c,d			;b80a
	ld e,d			;b80b
	halt			;b80c
	sbc a,h			;b80d
	ld d,h			;b80e
	ccf			;b80f
	sub c			;b810
	ld l,(hl)			;b811
	ld h,e			;b812
	sbc a,(hl)			;b813
	ld (hl),d			;b814
	adc a,h			;b815
	inc sp			;b816
	sub (hl)			;b817
	ld (hl),l			;b818
	ld d,e			;b819
	ld d,b			;b81a
	sub (hl)			;b81b
	ld b,e			;b81c
	ld a,h			;b81d
	ld l,(hl)			;b81e
	rst 20h			;b81f
	adc a,l			;b820
	sbc a,e			;b821
	ld e,d			;b822
	ld l,l			;b823
	sub d			;b824
	ld sp,06033h		;b825
	ld l,l			;b828
	ld d,l			;b829
	add a,l			;b82a
	ld e,h			;b82b
	halt			;b82c
	ld h,a			;b82d
	adc a,l			;b82e
	ld l,h			;b82f
	rst 18h			;b830
	inc (hl)			;b831
	ld e,e			;b832
	sbc a,(hl)			;b833
	ld (hl),e			;b834
	ld e,e			;b835
	adc a,d			;b836
	sbc a,e			;b837
	ld b,l			;b838
	push af			;b839
	or e			;b83a
	ld h,l			;b83b
	add hl,de			;b83c
	ld b,h			;b83d
	ld h,d			;b83e
	ld b,l			;b83f
	halt			;b840
	xor d			;b841
	sbc a,h			;b842
	add a,(hl)			;b843
	ld a,091h		;b844
	ld e,(hl)			;b846
	rst 18h			;b847
	ld e,l			;b848
	ld a,(hl)			;b849
	adc a,e			;b84a
	ld h,e			;b84b
	ld e,085h		;b84c
	sbc a,(hl)			;b84e
	ld a,c			;b84f
	ld d,b			;b850
	ld h,c			;b851
	sub e			;b852
	ld l,(hl)			;b853
	or d			;b854
	sub (hl)			;b855
	ld d,c			;b856
	cp h			;b857
	ld d,h			;b858
	ccf			;b859
	sub c			;b85a
	ld e,c			;b85b
	ld (hl),a			;b85c
	sub e			;b85d
	ld h,l			;b85e
	sub (hl)			;b85f
	sub d			;b860
	adc a,a			;b861
	ld e,h			;b862
	ld l,a			;b863
	rst 18h			;b864
	xor a			;b865
	ld l,0eah		;b866
	sub d			;b868
	ld c,a			;b869
	ld h,c			;b86a
	sbc a,h			;b86b
	ld h,a			;b86c
	adc a,l			;b86d
	ld e,(hl)			;b86e
	push af			;b86f
	push af			;b870
	or e			;b871
	ld h,l			;b872
	sub a			;b873
	jp pe,0510fh		;b874
	dec a			;b877
	ld c,h			;b878
	adc a,l			;b879
	dec bc			;b87a
	adc a,d			;b87b
	ld e,e			;b87c
	ld b,e			;b87d
	ld a,h			;b87e
	ld h,l			;b87f
	sub e			;b880
	adc a,d			;b881
	add a,l			;b882
	rst 18h			;b883
	adc a,l			;b884
	ld e,l			;b885
	ld e,(hl)			;b886
	inc de			;b887
	ld (hl),d			;b888
	adc a,c			;b889
	ld d,h			;b88a
	ccf			;b88b
	ld e,d			;b88c
	ld a,h			;b88d
	ld l,c			;b88e
	adc a,a			;b88f
	ld sp,05d60h		;b890
	out (073h),a		;b893
	adc a,a			;b895
	ld e,d			;b896
	ccf			;b897
	dec l			;b898
	sbc a,(hl)			;b899
	ld a,h			;b89a
	ld l,(hl)			;b89b
	adc a,a			;b89c
	ld h,b			;b89d
	cpl			;b89e
	ld l,l			;b89f
	add a,(hl)			;b8a0
	ld (hl),d			;b8a1
	add hl,de			;b8a2
	inc a			;b8a3
	sbc a,(hl)			;b8a4
	push hl			;b8a5
	ld h,h			;b8a6
	adc a,h			;b8a7
	ld d,a			;b8a8
	sub e			;b8a9
	sub b			;b8aa
	push af			;b8ab
	or e			;b8ac
	ld h,l			;b8ad
	add hl,de			;b8ae
	ld b,h			;b8af
	ld h,d			;b8b0
	ld l,h			;b8b1
	ld a,l			;b8b2
	cp h			;b8b3
	ld e,c			;b8b4
	ld (de),a			;b8b5
	ld c,d			;b8b6
	sub b			;b8b7
	ld b,b			;b8b8
	sbc a,e			;b8b9
	dec (hl)			;b8ba
	ld d,(hl)			;b8bb
	ld l,h			;b8bc
	rst 18h			;b8bd
	ld e,(hl)			;b8be
	ld (08b5fh),a		;b8bf
	ld h,c			;b8c2
	adc a,a			;b8c3
	ld e,a			;b8c4
	ld (hl),e			;b8c5
	sbc a,h			;b8c6
	ld d,h			;b8c7
	ld e,b			;b8c8
	ld e,(hl)			;b8c9
	rst 18h			;b8ca
	xor a			;b8cb
	ld l,0eah		;b8cc
	sub d			;b8ce
	ld c,a			;b8cf
	sbc a,d			;b8d0
	ld b,b			;b8d1
	ld e,l			;b8d2
	ld (hl),b			;b8d3
	ld c,b			;b8d4
	ld b,h			;b8d5
	sub (hl)			;b8d6
	ld h,h			;b8d7
	adc a,a			;b8d8
	ld a,(06496h)		;b8d9
	sbc a,e			;b8dc
	ld e,l			;b8dd
	sbc a,e			;b8de
	ld h,c			;b8df
	daa			;b8e0
	ld a,c			;b8e1
	ld h,b			;b8e2
	adc a,l			;b8e3
	ld h,d			;b8e4
	add hl,hl			;b8e5
	ld (hl),e			;b8e6
	adc a,l			;b8e7
	adc a,d			;b8e8
	adc a,e			;b8e9
	ld h,l			;b8ea
	xor h			;b8eb
	ld d,d			;b8ec
	push af			;b8ed
	or e			;b8ee
	ld h,l			;b8ef
	add hl,de			;b8f0
	ld b,h			;b8f1
	ld h,d			;b8f2
	ld l,h			;b8f3
	ld a,h			;b8f4
	ld l,c			;b8f5
	cp h			;b8f6
	ld e,h			;b8f7
	ld e,b			;b8f8
	ld b,b			;b8f9
	ld e,(hl)			;b8fa
	rst 18h			;b8fb
	or c			;b8fc
	ld e,a			;b8fd
	jr c,$+126		;b8fe
	ld h,l			;b900
	xor a			;b901
	ld l,0eah		;b902
	sub d			;b904
	ld c,a			;b905
	sbc a,d			;b906
	ld b,b			;b907
	ld a,b			;b908
	rst 18h			;b909
	ld e,e			;b90a
	ld h,a			;b90b
	ld e,b			;b90c
	ld (hl),c			;b90d
	sbc a,h			;b90e
	ld e,h			;b90f
	ld e,b			;b910
	ld (hl),c			;b911
	dec e			;b912
	cpl			;b913
	ld e,066h		;b914
	sub d			;b916
	sub (hl)			;b917
	ld l,a			;b918
	adc a,l			;b919
	adc a,l			;b91a
	ld l,d			;b91b
	adc a,h			;b91c
	push af			;b91d
	cp d			;b91e
	ld d,c			;b91f
	xor e			;b920
	add a,l			;b921
	dec (hl)			;b922
	adc a,a			;b923
	ld h,d			;b924
	adc a,e			;b925
	inc c			;b926
	ld b,b			;b927
	ld h,h			;b928
	add a,l			;b929
	ld e,h			;b92a
	sbc a,(hl)			;b92b
	ld a,h			;b92c
	ld l,(hl)			;b92d
	sbc a,h			;b92e
	ld e,(hl)			;b92f
	jr $+101		;b930
	ld e,c			;b932
	ld b,b			;b933
	ld l,l			;b934
	ld c,d			;b935
	ld c,b			;b936
	ld l,h			;b937
	rst 18h			;b938
	ld e,c			;b939
	ret pe			;b93a
	ld c,e			;b93b
	ld e,a			;b93c
	ld (hl),e			;b93d
	sub d			;b93e
	ld (hl),08bh		;b93f
	inc sp			;b941
	adc a,d			;b942
	sbc a,e			;b943
	ld (hl),c			;b944
	sbc a,h			;b945
	adc a,l			;b946
	ld h,d			;b947
	sbc a,d			;b948
	ld e,b			;b949
	ld l,e			;b94a
	sbc a,h			;b94b
	ld e,h			;b94c
	inc a			;b94d
	ld l,d			;b94e
	adc a,h			;b94f
	ld b,b			;b950
	adc a,e			;b951
	ld h,d			;b952
	adc a,e			;b953
	ld (hl),l			;b954
	dec e			;b955
	cpl			;b956
	adc a,l			;b957
	ld h,l			;b958
	sbc a,h			;b959
	dec (hl)			;b95a
	ld (hl),l			;b95b
	sub a			;b95c
	adc a,d			;b95d
	ld e,l			;b95e
	sub b			;b95f
	push af			;b960
	push af			;b961
	or e			;b962
	ld h,l			;b963
	add hl,de			;b964
	ld b,h			;b965
	ld h,d			;b966
	ld l,h			;b967
	ld a,h			;b968
	ld l,(hl)			;b969
	cp (hl)			;b96a
	scf			;b96b
	ld sp,07a59h		;b96c
	rst 18h			;b96f
	ld e,(hl)			;b970
	rst 18h			;b971
	or b			;b972
	ld l,b			;b973
	sbc a,d			;b974
	ld a,h			;b975
	ld h,l			;b976
	xor a			;b977
	ld l,0eah		;b978
	sub d			;b97a
	ld c,a			;b97b
	sbc a,d			;b97c
	dec hl			;b97d
	cp d			;b97e
	ld b,(hl)			;b97f
	ld c,d			;b980
	ld c,b			;b981
	ld l,h			;b982
	rst 18h			;b983
	ld e,c			;b984
	ret pe			;b985
	ld c,e			;b986
	ld e,a			;b987
	adc a,(hl)			;b988
	ld d,a			;b989
	ld l,e			;b98a
	rst 18h			;b98b
	sbc a,d			;b98c
	ld c,d			;b98d
	ld h,l			;b98e
	inc (hl)			;b98f
	ld d,l			;b990
	adc a,c			;b991
	ld h,b			;b992
	sub (hl)			;b993
	ld l,(hl)			;b994
	ld d,e			;b995
	adc a,a			;b996
	adc a,l			;b997
	ld e,l			;b998
	ld h,a			;b999
	sbc a,(hl)			;b99a
	ld e,e			;b99b
	ld e,h			;b99c
	ld e,l			;b99d
	ld (hl),c			;b99e
	ld l,b			;b99f
	ld l,(hl)			;b9a0
	adc a,c			;b9a1
	ld e,d			;b9a2
	ld h,e			;b9a3
	ld b,l			;b9a4
	ld l,(hl)			;b9a5
	ld e,08fh		;b9a6
	ld c,(hl)			;b9a8
	ld e,l			;b9a9
	push af			;b9aa
	cp d			;b9ab
	ld d,c			;b9ac
	ld h,d			;b9ad
	inc de			;b9ae
	push hl			;b9af
	ld h,h			;b9b0
	sbc a,l			;b9b1
	adc a,d			;b9b2
	ld c,d			;b9b3
	sub (hl)			;b9b4
	ld e,e			;b9b5
	ld e,b			;b9b6
	ld h,h			;b9b7
	sub d			;b9b8
	ld h,e			;b9b9
	sbc a,h			;b9ba
	ld l,d			;b9bb
	ld (06d64h),a		;b9bc
	sub a			;b9bf
	sub b			;b9c0
	ld d,l			;b9c1
	sub d			;b9c2
	jp pe,0798ch		;b9c3
	ld d,b			;b9c6
	rst 18h			;b9c7
	ld c,b			;b9c8
	ld b,h			;b9c9
	sub (hl)			;b9ca
	ld h,h			;b9cb
	ld d,e			;b9cc
	ld e,e			;b9cd
	sub c			;b9ce
	adc a,e			;b9cf
	ld h,h			;b9d0
	adc a,c			;b9d1
	ld c,(hl)			;b9d2
	ret pe			;b9d3
	add hl,sp			;b9d4
	rst 18h			;b9d5
	xor h			;b9d6
	rla			;b9d7
	adc a,h			;b9d8
	ld d,a			;b9d9
	sub e			;b9da
	ld h,h			;b9db
	sub a			;b9dc
	ld h,l			;b9dd
	ld d,e			;b9de
	adc a,c			;b9df
	daa			;b9e0
	ld l,d			;b9e1
	rst 18h			;b9e2
	adc a,l			;b9e3
	ld l,b			;b9e4
	ld e,b			;b9e5
	ld (hl),c			;b9e6
	ld b,a			;b9e7
	ld h,d			;b9e8
	ld e,b			;b9e9
	ld b,b			;b9ea
	adc a,e			;b9eb
	ld d,(hl)			;b9ec
	adc a,e			;b9ed
	ld l,l			;b9ee
	ld d,l			;b9ef
	ld e,l			;b9f0
	add hl,bc			;b9f1
	ld e,e			;b9f2
	ld e,c			;b9f3
	push af			;b9f4
	cp d			;b9f5
	ld c,h			;b9f6
	sbc a,d			;b9f7
	ld h,(hl)			;b9f8
	sub c			;b9f9
	sbc a,e			;b9fa
	ld h,e			;b9fb
	ld h,h			;b9fc
	ld d,b			;b9fd
	ret pe			;b9fe
	sbc a,(hl)			;b9ff
	ld (hl),d			;ba00
	sbc a,h			;ba01
	ld h,a			;ba02
	adc a,l			;ba03
	ld h,h			;ba04
	sbc a,h			;ba05
	dec (hl)			;ba06
	ld h,e			;ba07
	ld e,e			;ba08
	ld e,(hl)			;ba09
	ld (hl),a			;ba0a
	sbc a,d			;ba0b
	ld d,c			;ba0c
	sbc a,(hl)			;ba0d
	scf			;ba0e
	sbc a,(hl)			;ba0f
	push af			;ba10
	cp d			;ba11
	ld d,c			;ba12
	sbc a,h			;ba13
	ld e,d			;ba14
	sub b			;ba15
	jr c,$+115		;ba16
	and a			;ba18
	adc a,e			;ba19
	sub e			;ba1a
	ld d,h			;ba1b
	sub b			;ba1c
	sbc a,h			;ba1d
	rst 18h			;ba1e
	ld l,l			;ba1f
	sub a			;ba20
	sub b			;ba21
	add a,(hl)			;ba22
	ld a,(hl)			;ba23
	ld c,098h		;ba24
	ld d,b			;ba26
	halt			;ba27
	sbc a,(hl)			;ba28
	scf			;ba29
	ld l,(hl)			;ba2a
	ld b,c			;ba2b
	ld e,e			;ba2c
	ld e,c			;ba2d
	push af			;ba2e
	cp d			;ba2f
	ld d,c			;ba30
	xor e			;ba31
	jr z,$+70		;ba32
	sub b			;ba34
	ld a,h			;ba35
	ld l,c			;ba36
	cp b			;ba37
	adc a,d			;ba38
	ld h,e			;ba39
	adc a,l			;ba3a
	ld h,e			;ba3b
	ld l,c			;ba3c
	ld a,b			;ba3d
	ld a,(hl)			;ba3e
	ld e,l			;ba3f
	sbc a,h			;ba40
	ld e,(hl)			;ba41
	ld d,(hl)			;ba42
	ld a,(04e76h)		;ba43
	sbc a,h			;ba46
	ld e,l			;ba47
	ld h,h			;ba48
	inc b			;ba49
	ld h,d			;ba4a
	adc a,(hl)			;ba4b
	ld d,a			;ba4c
	ld l,h			;ba4d
	ld c,e			;ba4e
	ld e,a			;ba4f
	dec sp			;ba50
	ld d,h			;ba51
	ccf			;ba52
	sub c			;ba53
	ld e,c			;ba54
	dec hl			;ba55
	cp c			;ba56
	ld e,a			;ba57
	sub d			;ba58
	sbc a,(hl)			;ba59
	ld (hl),e			;ba5a
	ld e,l			;ba5b
	jr nc,$+88		;ba5c
	ld h,l			;ba5e
	or c			;ba5f
	ld e,a			;ba60
	ld e,a			;ba61
	sub (hl)			;ba62
	ld h,a			;ba63
	ld e,(hl)			;ba64
	ld a,l			;ba65
	sbc a,h			;ba66
	dec (hl)			;ba67
	ld b,h			;ba68
	rlca			;ba69
	ld h,h			;ba6a
	ld h,b			;ba6b
	jr nc,$-104		;ba6c
	jr c,$-98		;ba6e
	adc a,e			;ba70
	ld b,e			;ba71
	ld c,l			;ba72
	sub b			;ba73
	push af			;ba74
	or e			;ba75
	ld h,l			;ba76
	xor e			;ba77
	ld h,e			;ba78
	ld e,085h		;ba79
	ld h,l			;ba7b
	xor h			;ba7c
	adc a,d			;ba7d
	adc a,a			;ba7e
	ld h,e			;ba7f
	sub (hl)			;ba80
	ld e,a			;ba81
	ld a,l			;ba82
	xor e			;ba83
	jr z,$+70		;ba84
	sub b			;ba86
	ld a,h			;ba87
	ld l,c			;ba88
	cp b			;ba89
	adc a,d			;ba8a
	ld h,e			;ba8b
	adc a,l			;ba8c
	ld h,e			;ba8d
	ld e,b			;ba8e
	ld a,d			;ba8f
	rst 18h			;ba90
	ld l,d			;ba91
	adc a,l			;ba92
	sub c			;ba93
	ld l,h			;ba94
	dec sp			;ba95
	ld e,h			;ba96
	ld a,(hl)			;ba97
	ld l,b			;ba98
	ld a,(0658ah)		;ba99
	add a,(hl)			;ba9c
	ld c,(hl)			;ba9d
	ld l,a			;ba9e
	dec hl			;ba9f
	cp (hl)			;baa0
	ld d,c			;baa1
	cp d			;baa2
	ld c,h			;baa3
	sbc a,d			;baa4
	ld a,d			;baa5
	ld (hl),d			;baa6
	adc a,a			;baa7
	rst 20h			;baa8
	adc a,l			;baa9
	adc a,e			;baaa
	ld c,l			;baab
	sub b			;baac
	ld a,c			;baad
	ld c,d			;baae
	inc l			;baaf
	ld h,l			;bab0
	ld e,(hl)			;bab1
	rst 18h			;bab2
	ld d,(hl)			;bab3
	adc a,e			;bab4
	ld h,e			;bab5
	sub (hl)			;bab6
	ld e,a			;bab7
	push af			;bab8
	cp d			;bab9
	ld d,c			;baba
	ld d,(hl)			;babb
	adc a,e			;babc
	ld h,e			;babd
	sub (hl)			;babe
	ld e,a			;babf
	ld a,l			;bac0
	xor e			;bac1
	jr z,$+70		;bac2
	ld h,h			;bac4
	ld e,l			;bac5
	ld a,(hl)			;bac6
	ld c,b			;bac7
	ld b,h			;bac8
	sub (hl)			;bac9
	ld h,l			;baca
	ld l,b			;bacb
	ld h,d			;bacc
	ld e,e			;bacd
	sbc a,(hl)			;bace
	ld l,e			;bacf
	ld h,(hl)			;bad0
	sub d			;bad1
	sub (hl)			;bad2
	adc a,a			;bad3
	ld e,d			;bad4
	ccf			;bad5
	dec l			;bad6
	sbc a,(hl)			;bad7
	ld l,e			;bad8
	dec h			;bad9
	sbc a,(hl)			;bada
	ld a,c			;badb
	sbc a,e			;badc
	ld l,b			;badd
	ld c,(hl)			;bade
	ld h,d			;badf
	rst 18h			;bae0
	adc a,c			;bae1
	ld h,b			;bae2
	sub (hl)			;bae3
	ld l,(hl)			;bae4
	sbc a,h			;bae5
	ld d,h			;bae6
	ccf			;bae7
	sub c			;bae8
	ld e,c			;bae9
	ld (hl),a			;baea
	inc l			;baeb
	ld c,a			;baec
	ld l,a			;baed
	rst 18h			;baee
	sbc a,c			;baef
	ld d,b			;baf0
	ld e,e			;baf1
	ld b,e			;baf2
	rst 18h			;baf3
	ld d,092h		;baf4
	sbc a,l			;baf6
	ld bc,09e4dh		;baf7
	push af			;bafa
	or e			;bafb
	ld h,l			;bafc
	xor l			;bafd
	adc a,d			;bafe
	adc a,e			;baff
	ld h,l			;bb00
	xor h			;bb01
	ld d,d			;bb02
	ld c,e			;bb03
	ld e,c			;bb04
	ld h,l			;bb05
	ld b,06fh		;bb06
	rst 18h			;bb08
	ld e,(hl)			;bb09
	rst 18h			;bb0a
	xor h			;bb0b
	sbc a,d			;bb0c
	adc a,a			;bb0d
	ld (hl),09ch		;bb0e
	jr nz,$+127		;bb10
	cp b			;bb12
	adc a,l			;bb13
	ld h,d			;bb14
	rst 18h			;bb15
	xor h			;bb16
	ld c,(hl)			;bb17
	ld h,e			;bb18
	nop			;bb19
	jr c,$+66		;bb1a
	sbc a,d			;bb1c
	dec a			;bb1d
	ld hl,0645bh		;bb1e
	sbc a,h			;bb21
	ld e,h			;bb22
	ld c,h			;bb23
	adc a,l			;bb24
	adc a,d			;bb25
	ld c,a			;bb26
	ld h,h			;bb27
	ld e,(hl)			;bb28
	ld d,e			;bb29
	ld c,c			;bb2a
	sbc a,e			;bb2b
	ld e,a			;bb2c
	ld (hl),c			;bb2d
	ld d,b			;bb2e
	ld (09c8ah),a		;bb2f
	sub e			;bb32
	sbc a,d			;bb33
	ld h,h			;bb34
	sub d			;bb35
	sbc a,(hl)			;bb36
	ld e,e			;bb37
	add a,l			;bb38
	sub b			;bb39
	ld a,c			;bb3a
	ld l,l			;bb3b
	sub e			;bb3c
	ld h,h			;bb3d
	and 091h		;bb3e
	ld c,l			;bb40
	sub b			;bb41
	ld a,c			;bb42
	sub a			;bb43
	sub b			;bb44
	ld d,l			;bb45
	dec a			;bb46
	ld h,l			;bb47
	adc a,a			;bb48
	ld d,a			;bb49
	sbc a,e			;bb4a
	ld h,c			;bb4b
	ld a,(de)			;bb4c
	adc a,h			;bb4d
	inc sp			;bb4e
	ld h,b			;bb4f
	adc a,h			;bb50
	sbc a,d			;bb51
	push af			;bb52
	cp d			;bb53
	ld c,h			;bb54
	ld h,l			;bb55
	ld l,b			;bb56
	ld h,d			;bb57
	ld e,e			;bb58
	halt			;bb59
	sbc a,l			;bb5a
	sbc a,(hl)			;bb5b
	sub l			;bb5c
	ld h,h			;bb5d
	jr c,$+44		;bb5e
	ld h,h			;bb60
	ld d,l			;bb61
	jr z,$-111		;bb62
	cpl			;bb64
	adc a,l			;bb65
	ld b,l			;bb66
	ld l,(hl)			;bb67
	adc a,a			;bb68
	ld h,b			;bb69
	cpl			;bb6a
	ld l,l			;bb6b
	sub a			;bb6c
	ld h,l			;bb6d
	adc a,h			;bb6e
	ld c,a			;bb6f
	ld h,h			;bb70
	ld c,d			;bb71
	ld c,b			;bb72
	ld l,h			;bb73
	ld (hl),d			;bb74
	xor h			;bb75
	sbc a,d			;bb76
	adc a,a			;bb77
	ld (hl),09ch		;bb78
	adc a,l			;bb7a
	ld h,h			;bb7b
	adc a,a			;bb7c
	ld e,a			;bb7d
	adc a,(hl)			;bb7e
	ld d,a			;bb7f
	ld l,e			;bb80
	rst 18h			;bb81
	sbc a,d			;bb82
	ld c,d			;bb83
	sbc a,(hl)			;bb84
	ld h,(hl)			;bb85
	ld a,(bc)			;bb86
	ld h,d			;bb87
	ld l,e			;bb88
	sbc a,h			;bb89
	ld e,h			;bb8a
	inc a			;bb8b
	ld l,d			;bb8c
	rst 18h			;bb8d
	ld e,(hl)			;bb8e
	sbc a,b			;bb8f
	ld d,b			;bb90
	ld l,(hl)			;bb91
	adc a,e			;bb92
	ccf			;bb93
	sbc a,l			;bb94
	ld l,(hl)			;bb95
	adc a,h			;bb96
	ld c,(hl)			;bb97
	ld h,e			;bb98
	sbc a,e			;bb99
	ld h,05eh		;bb9a
	ld e,l			;bb9c
	push af			;bb9d
	push af			;bb9e
	or e			;bb9f
	ld h,l			;bba0
	xor l			;bba1
	adc a,d			;bba2
	adc a,e			;bba3
	ld h,l			;bba4
	xor h			;bba5
	ld d,d			;bba6
	ld c,e			;bba7
	ld e,c			;bba8
	ld h,l			;bba9
	ld b,06fh		;bbaa
	rst 18h			;bbac
	ld e,(hl)			;bbad
	rst 18h			;bbae
	cp h			;bbaf
	sub a			;bbb0
	ld c,l			;bbb1
	sub a			;bbb2
	ld h,d			;bbb3
	ld hl,(0df11h)		;bbb4
	ld h,h			;bbb7
	cp h			;bbb8
	ld e,c			;bbb9
	ld h,l			;bbba
	cp h			;bbbb
	ld d,h			;bbbc
	ld e,a			;bbbd
	ld l,h			;bbbe
	dec hl			;bbbf
	cp (hl)			;bbc0
	sub e			;bbc1
	sbc a,b			;bbc2
	ld d,b			;bbc3
	ld l,(hl)			;bbc4
	ld d,(hl)			;bbc5
	rra			;bbc6
	adc a,l			;bbc7
	sub (hl)			;bbc8
	adc a,a			;bbc9
	ld e,e			;bbca
	ld e,h			;bbcb
	ld l,l			;bbcc
	ld e,d			;bbcd
	rst 18h			;bbce
	ld b,c			;bbcf
	adc a,h			;bbd0
	ld c,e			;bbd1
	ld h,b			;bbd2
	cpl			;bbd3
	ld l,l			;bbd4
	ld b,c			;bbd5
	sbc a,b			;bbd6
	sub (hl)			;bbd7
	ld h,e			;bbd8
	ld e,d			;bbd9
	ld a,c			;bbda
	sbc a,c			;bbdb
	ld d,a			;bbdc
	ld (hl),b			;bbdd
	sub e			;bbde
	adc a,d			;bbdf
	sbc a,b			;bbe0
	ld h,b			;bbe1
	ld (hl),c			;bbe2
	sbc a,h			;bbe3
	ld d,d			;bbe4
	sbc a,(hl)			;bbe5
	ld e,e			;bbe6
	ld b,e			;bbe7
	push af			;bbe8
	inc d			;bbe9
	dec h			;bbea
	ld l,(hl)			;bbeb
	add hl,de			;bbec
	add hl,hl			;bbed
	adc a,c			;bbee
	sbc a,(hl)			;bbef
	ld e,e			;bbf0
	ld e,h			;bbf1
	ld l,l			;bbf2
	sub a			;bbf3
	sbc a,d			;bbf4
	ld hl,(05a6eh)		;bbf5
	ld (hl),d			;bbf8
	ld d,(hl)			;bbf9
	adc a,e			;bbfa
	ld h,e			;bbfb
	sub (hl)			;bbfc
	ld e,a			;bbfd
	ld h,(hl)			;bbfe
	ld a,(bc)			;bbff
	ld h,d			;bc00
	inc hl			;bc01
	ld e,l			;bc02
	ld (0630fh),hl		;bc03
	adc a,e			;bc06
	ld h,h			;bc07
	ld d,(hl)			;bc08
	ld c,h			;bc09
	adc a,l			;bc0a
	ccf			;bc0b
	ld h,a			;bc0c
	ld e,b			;bc0d
	ld a,c			;bc0e
	sbc a,h			;bc0f
	ld e,h			;bc10
	sbc a,c			;bc11
	ld l,092h		;bc12
	ld h,d			;bc14
	ld a,c			;bc15
	sbc a,c			;bc16
	ld d,a			;bc17
	ld a,(hl)			;bc18
	ld e,l			;bc19
	add hl,bc			;bc1a
	ld e,e			;bc1b
	sbc a,d			;bc1c
	ld (hl),c			;bc1d
	sub a			;bc1e
	ld e,b			;bc1f
	adc a,a			;bc20
	inc sp			;bc21
	ld e,(hl)			;bc22
	push af			;bc23
	or e			;bc24
	ld l,(hl)			;bc25
	add hl,de			;bc26
	ld b,h			;bc27
	ld h,d			;bc28
	ld b,l			;bc29
	ld l,(hl)			;bc2a
	ld d,e			;bc2b
	ld e,e			;bc2c
	sbc a,l			;bc2d
	ld e,d			;bc2e
	ld (09d35h),a		;bc2f
	ld d,e			;bc32
	ld h,(hl)			;bc33
	sbc a,b			;bc34
	and 091h		;bc35
	ld (hl),d			;bc37
	sbc a,d			;bc38
	dec a			;bc39
	ld hl,0645bh		;bc3a
	ld b,06fh		;bc3d
	rst 18h			;bc3f
	ld e,(hl)			;bc40
	ld a,c			;bc41
	adc a,h			;bc42
	sbc a,d			;bc43
	ld l,e			;bc44
	ld (08d67h),hl		;bc45
	ld h,d			;bc48
	dec hl			;bc49
	cp e			;bc4a
	ld e,l			;bc4b
	sbc a,e			;bc4c
	ld h,c			;bc4d
	ld c,07dh		;bc4e
	or b			;bc50
	sbc a,l			;bc51
	adc a,h			;bc52
	ld h,e			;bc53
	adc a,c			;bc54
	ld a,(0965fh)		;bc55
	ld h,h			;bc58
	adc a,c			;bc59
	jr z,$+90		;bc5a
	ld (hl),d			;bc5c
	cp h			;bc5d
	ld h,b			;bc5e
	ld c,(hl)			;bc5f
	ld d,h			;bc60
	ld b,b			;bc61
	ld b,a			;bc62
	ld h,d			;bc63
	inc h			;bc64
	ld e,a			;bc65
	ld d,e			;bc66
	ld b,e			;bc67
	rst 18h			;bc68
	ld e,e			;bc69
	adc a,l			;bc6a
	sbc a,h			;bc6b
	ld (hl),060h		;bc6c
	rst 18h			;bc6e
	ld c,c			;bc6f
	sbc a,e			;bc70
	ld c,l			;bc71
	ld l,d			;bc72
	rst 18h			;bc73
	sbc a,(hl)			;bc74
	ld (hl),e			;bc75
	ld de,0638ch		;bc76
	adc a,c			;bc79
	sbc a,(hl)			;bc7a
	ld e,e			;bc7b
	ld b,e			;bc7c
	ld a,h			;bc7d
	ld l,c			;bc7e
	ld e,c			;bc7f
	inc a			;bc80
	ld e,b			;bc81
	push af			;bc82
	cp d			;bc83
	ld d,c			;bc84
	ld e,b			;bc85
	sbc a,h			;bc86
	ld d,d			;bc87
	ld h,h			;bc88
	ld d,(hl)			;bc89
	adc a,e			;bc8a
	ld h,e			;bc8b
	sub (hl)			;bc8c
	ld e,a			;bc8d
	ld a,d			;bc8e
	inc hl			;bc8f
	dec (hl)			;bc90
	ld d,(hl)			;bc91
	ld l,d			;bc92
	ld c,e			;bc93
	ld e,a			;bc94
	ld a,(hl)			;bc95
	ld e,l			;bc96
	sbc a,h			;bc97
	ld e,(hl)			;bc98
	ld h,e			;bc99
	ld h,l			;bc9a
	sub a			;bc9b
	daa			;bc9c
	ld c,l			;bc9d
	sub b			;bc9e
	ld c,a			;bc9f
	ld e,(hl)			;bca0
	rst 18h			;bca1
	ld h,l			;bca2
	ld c,079h		;bca3
	adc a,h			;bca5
	ld h,c			;bca6
	ld c,c			;bca7
	sbc a,l			;bca8
	sbc a,d			;bca9
	ld (hl),d			;bcaa
	adc a,h			;bcab
	sub b			;bcac
	dec l			;bcad
	ld e,d			;bcae
	dec (hl)			;bcaf
	sbc a,l			;bcb0
	ld d,e			;bcb1
	ld a,l			;bcb2
	sbc a,h			;bcb3
	ld h,b			;bcb4
	ld c,(hl)			;bcb5
	ld d,h			;bcb6
	push af			;bcb7
	or e			;bcb8
	ld h,l			;bcb9
	cp h			;bcba
	and 08fh		;bcbb
	ld (hl),065h		;bcbd
	ld a,b			;bcbf
	ld c,e			;bcc0
	ld h,b			;bcc1
	cpl			;bcc2
	ld l,l			;bcc3
	adc a,h			;bcc4
	jr z,$-104		;bcc5
	ld e,e			;bcc7
	adc a,l			;bcc8
	sbc a,h			;bcc9
	ld (hl),060h		;bcca
	ld e,l			;bccc
	ld (hl),a			;bccd
	adc a,c			;bcce
	ld h,a			;bccf
	ld h,d			;bcd0
	ld l,(hl)			;bcd1
	ld e,(hl)			;bcd2
	ld h,b			;bcd3
	sbc a,b			;bcd4
	ld l,h			;bcd5
	adc a,h			;bcd6
	ld a,c			;bcd7
	adc a,a			;bcd8
	ld h,e			;bcd9
	sub d			;bcda
	inc sp			;bcdb
	ld e,d			;bcdc
	ld a,(hl)			;bcdd
	sub d			;bcde
	rlca			;bcdf
	ld e,a			;bce0
	rst 18h			;bce1
	ld de,0638ch		;bce2
	adc a,c			;bce5
	sbc a,(hl)			;bce6
	ld e,e			;bce7
	ld b,e			;bce8
	push af			;bce9
	cp d			;bcea
	ld c,h			;bceb
	ld h,l			;bcec
	add a,l			;bced
	ld e,h			;bcee
	ld h,l			;bcef
	ld d,(hl)			;bcf0
	adc a,c			;bcf1
	ld b,l			;bcf2
	ld c,a			;bcf3
	ld h,l			;bcf4
	adc a,a			;bcf5
	ld e,a			;bcf6
	ld (hl),e			;bcf7
	sub d			;bcf8
	ld e,(hl)			;bcf9
	sbc a,d			;bcfa
	add a,l			;bcfb
	ld h,l			;bcfc
	sbc a,c			;bcfd
	ld d,a			;bcfe
	ld (hl),b			;bcff
	ld h,d			;bd00
	ld (de),a			;bd01
	scf			;bd02
	ld h,h			;bd03
	ld a,(de)			;bd04
	adc a,c			;bd05
	ld h,e			;bd06
	add hl,sp			;bd07
	rst 18h			;bd08
	or a			;bd09
	sub b			;bd0a
	ld d,l			;bd0b
	sbc a,e			;bd0c
	ret pe			;bd0d
	ld h,l			;bd0e
	sub a			;bd0f
	ld h,d			;bd10
	rst 18h			;bd11
	adc a,c			;bd12
	ld d,a			;bd13
	sub e			;bd14
	adc a,e			;bd15
	ld h,h			;bd16
	ld h,l			;bd17
	sub c			;bd18
	ld c,(hl)			;bd19
	ld h,e			;bd1a
	rst 18h			;bd1b
	ld e,(hl)			;bd1c
	sbc a,b			;bd1d
	ld d,b			;bd1e
	ld l,(hl)			;bd1f
	ld b,h			;bd20
	ld h,d			;bd21
	adc a,e			;bd22
	ld e,c			;bd23
	ld (hl),c			;bd24
	adc a,e			;bd25
	ld a,04eh		;bd26
	sub e			;bd28
	push af			;bd29
	or e			;bd2a
	ld h,l			;bd2b
	add hl,de			;bd2c
	ld b,h			;bd2d
	ld h,d			;bd2e
	ld l,h			;bd2f
	ld a,h			;bd30
	ld l,(hl)			;bd31
	xor a			;bd32
	sub (hl)			;bd33
	cpl			;bd34
	adc a,l			;bd35
	ld l,(hl)			;bd36
	xor c			;bd37
	sub (hl)			;bd38
	rlca			;bd39
	ld l,(hl)			;bd3a
	ld a,b			;bd3b
	ld l,e			;bd3c
	ld (hl),d			;bd3d
	sbc a,h			;bd3e
	ld h,a			;bd3f
	jr nz,$+128		;bd40
	add hl,bc			;bd42
	adc a,(hl)			;bd43
	ld d,a			;bd44
	push hl			;bd45
	ld h,l			;bd46
	ld d,d			;bd47
	sub c			;bd48
	sbc a,(hl)			;bd49
	push af			;bd4a
	cp e			;bd4b
	sbc a,d			;bd4c
	ld d,c			;bd4d
	cp (hl)			;bd4e
	sub h			;bd4f
	ld a,0dfh		;bd50
	cp e			;bd52
	ret c			;bd53
	add a,l			;bd54
	dec bc			;bd55
	rst 18h			;bd56
	ld h,h			;bd57
	sbc a,d			;bd58
	dec a			;bd59
	ld hl,0905bh		;bd5a
	ld a,h			;bd5d
	ld l,(hl)			;bd5e
	cp d			;bd5f
	rra			;bd60
	adc a,l			;bd61
	inc sp			;bd62
	ld d,d			;bd63
	ld l,(hl)			;bd64
	or b			;bd65
	rra			;bd66
	ld d,d			;bd67
	ld l,(hl)			;bd68
	adc a,h			;bd69
	ld bc,08e64h		;bd6a
	ld d,a			;bd6d
	sbc a,e			;bd6e
	ld h,l			;bd6f
	ld b,c			;bd70
	rst 18h			;bd71
	sub (hl)			;bd72
	sub d			;bd73
	adc a,a			;bd74
	ld e,h			;bd75
	ld l,a			;bd76
	rst 18h			;bd77
	sbc a,c			;bd78
	ld c,(hl)			;bd79
	sub a			;bd7a
	ld l,h			;bd7b
	dec sp			;bd7c
	adc a,d			;bd7d
	rrca			;bd7e
	ld h,e			;bd7f
	adc a,e			;bd80
	halt			;bd81
	adc a,h			;bd82
	ret pe			;bd83
	sub d			;bd84
	sbc a,l			;bd85
	ld d,h			;bd86
	ld l,c			;bd87
	add a,(hl)			;bd88
	ld (hl),b			;bd89
	add hl,bc			;bd8a
	adc a,(hl)			;bd8b
	ld d,a			;bd8c
	push hl			;bd8d
	ld h,h			;bd8e
	ld e,(hl)			;bd8f
	adc a,e			;bd90
	ld h,b			;bd91
	rst 18h			;bd92
	ld b,06fh		;bd93
	rst 18h			;bd95
	ld h,l			;bd96
	sbc a,d			;bd97
	ld c,d			;bd98
	sbc a,(hl)			;bd99
	push af			;bd9a
	or e			;bd9b
	ld h,l			;bd9c
	and 093h		;bd9d
	ld (de),a			;bd9f
	sub d			;bda0
	ld h,l			;bda1
	add hl,de			;bda2
	ld b,h			;bda3
	ld h,d			;bda4
	ld l,h			;bda5
	ld a,l			;bda6
	adc a,h			;bda7
	ld d,d			;bda8
	rst 18h			;bda9
	ld l,l			;bdaa
	ld c,07ch		;bdab
	ld l,(hl)			;bdad
	cp e			;bdae
	ld e,h			;bdaf
	sbc a,h			;bdb0
	sbc a,d			;bdb1
	ld c,d			;bdb2
	ld e,c			;bdb3
	out (04bh),a		;bdb4
	sbc a,d			;bdb6
	adc a,(hl)			;bdb7
	ld d,a			;bdb8
	push hl			;bdb9
	ld h,h			;bdba
	adc a,a			;bdbb
	ld a,(06496h)		;bdbc
	sbc a,e			;bdbf
	dec (hl)			;bdc0
	ld d,(hl)			;bdc1
	ld l,d			;bdc2
	ld c,e			;bdc3
	ld e,a			;bdc4
	ld (hl),d			;bdc5
	sbc a,d			;bdc6
	dec a			;bdc7
	ld hl,0645bh		;bdc8
	defb 0ddh,09bh,061h	;illegal sequence		;bdcb
	sub e			;bdce
	ld l,(hl)			;bdcf
	sub d			;bdd0
	ld e,h			;bdd1
	sub l			;bdd2
	ld e,c			;bdd3
	dec ix		;bdd4
	xor h			;bdd6
	adc a,d			;bdd7
	ld c,e			;bdd8
	ld h,b			;bdd9
	adc a,e			;bdda
	ld h,c			;bddb
	ld b,c			;bddc
	adc a,a			;bddd
	ld h,e			;bdde
	sub (hl)			;bddf
	ld e,a			;bde0
	ld h,(hl)			;bde1
	ld a,(bc)			;bde2
	ld h,l			;bde3
	sbc a,e			;bde4
	ld h,e			;bde5
	adc a,l			;bde6
	ccf			;bde7
	sbc a,l			;bde8
	ld l,d			;bde9
	push af			;bdea
	xor d			;bdeb
	sub c			;bdec
	rst 18h			;bded
	adc a,l			;bdee
	adc a,d			;bdef
	ld d,(hl)			;bdf0
	ld e,b			;bdf1
	ld h,h			;bdf2
	ld d,(hl)			;bdf3
	adc a,e			;bdf4
	ld h,e			;bdf5
	sub (hl)			;bdf6
	ld e,a			;bdf7
	rst 18h			;bdf8
	ld l,l			;bdf9
	adc a,e			;bdfa
	dec de			;bdfb
	ld h,h			;bdfc
	sub e			;bdfd
	sub b			;bdfe
	ld a,c			;bdff
	adc a,(hl)			;be00
	ld d,a			;be01
	sbc a,e			;be02
	sbc a,(hl)			;be03
	ld a,l			;be04
	daa			;be05
	sbc a,d			;be06
	sbc a,b			;be07
	ld h,d			;be08
	adc a,e			;be09
	ld h,c			;be0a
	adc a,a			;be0b
	ld e,(hl)			;be0c
	sbc a,(hl)			;be0d
	ld e,e			;be0e
	sub b			;be0f
	ld a,c			;be10
	ld h,d			;be11
	inc de			;be12
	push hl			;be13
	ld h,h			;be14
	ld e,(hl)			;be15
	sbc a,l			;be16
	ld h,e			;be17
	sbc a,b			;be18
	rst 20h			;be19
	rst 18h			;be1a
	ld h,l			;be1b
	sub e			;be1c
	ld l,(hl)			;be1d
	adc a,c			;be1e
	ret pe			;be1f
	adc a,l			;be20
	sbc a,b			;be21
	ld e,d			;be22
	ld e,l			;be23
	ld a,l			;be24
	adc a,h			;be25
	ld d,h			;be26
	push af			;be27
	inc d			;be28
	ld (hl),d			;be29
	ld d,(hl)			;be2a
	sub (hl)			;be2b
	ld e,e			;be2c
	sub b			;be2d
	ld a,h			;be2e
	ld h,l			;be2f
	xor c			;be30
	ret pe			;be31
	ld h,l			;be32
	xor h			;be33
	sbc a,(hl)			;be34
	ld b,a			;be35
	ld l,h			;be36
	ld a,d			;be37
	ld (hl),d			;be38
	jr c,$-108		;be39
	ld b,h			;be3b
	sub b			;be3c
	ld a,h			;be3d
	ld l,c			;be3e
	xor e			;be3f
	adc a,l			;be40
	ld l,l			;be41
	cp e			;be42
	ld d,(hl)			;be43
	jr c,$-107		;be44
	ld e,l			;be46
	ld b,b			;be47
	dec c			;be48
	dec e			;be49
	sbc a,(hl)			;be4a
	ld a,l			;be4b
	sbc a,e			;be4c
	ld h,c			;be4d
	or e			;be4e
	ld a,091h		;be4f
	jp pe,0baf5h		;be51
	ld d,c			;be54
	ld e,(hl)			;be55
	adc a,e			;be56
	ld h,b			;be57
	ld (hl),c			;be58
	cp h			;be59
	sub a			;be5a
	ld c,(hl)			;be5b
	rst 18h			;be5c
	or d			;be5d
	sub b			;be5e
	ld d,h			;be5f
	ld a,d			;be60
	inc hl			;be61
	dec (hl)			;be62
	ld d,(hl)			;be63
	ld l,d			;be64
	ld c,e			;be65
	ld e,a			;be66
	ld (hl),e			;be67
	ld l,b			;be68
	ld a,(0768ah)		;be69
	ld b,c			;be6c
	rst 18h			;be6d
	dec a			;be6e
	ld e,b			;be6f
	dec hl			;be70
	inc d			;be71
	inc h			;be72
	dec de			;be73
	sub b			;be74
	ld (hl),d			;be75
	sub e			;be76
	adc a,d			;be77
	sbc a,b			;be78
	ld h,b			;be79
	ld h,(hl)			;be7a
	ld c,e			;be7b
	ld h,e			;be7c
	ld e,e			;be7d
	sbc a,l			;be7e
	sbc a,d			;be7f
	ld a,(hl)			;be80
	adc a,h			;be81
	ld e,d			;be82
	adc a,h			;be83
	sbc a,(hl)			;be84
	ld e,e			;be85
	ld b,e			;be86
	ld (hl),c			;be87
	ld e,d			;be88
	ld h,e			;be89
	sbc a,b			;be8a
	ret pe			;be8b
	ld h,l			;be8c
	sbc a,h			;be8d
	ld e,h			;be8e
	adc a,e			;be8f
	ld e,d			;be90
	ld c,a			;be91
	sbc a,(hl)			;be92
	push af			;be93
	or e			;be94
	ld h,l			;be95
	xor c			;be96
	sub (hl)			;be97
	ld h,l			;be98
	xor h			;be99
	sbc a,(hl)			;be9a
	ld b,a			;be9b
	ld l,h			;be9c
	ld b,b			;be9d
	ld h,b			;be9e
	adc a,e			;be9f
	ld h,e			;bea0
	sub (hl)			;bea1
	ld h,l			;bea2
	adc a,a			;bea3
	adc a,l			;bea4
	ld d,(hl)			;bea5
	ld e,e			;bea6
	adc a,a			;bea7
	ld e,(hl)			;bea8
	ld (hl),c			;bea9
	cp h			;beaa
	sub a			;beab
	ld c,l			;beac
	sub a			;bead
	jp (hl)			;beae
	sub c			;beaf
	rst 18h			;beb0
	or (hl)			;beb1
	adc a,e			;beb2
	add a,l			;beb3
	jp pe,06ddfh		;beb4
	adc a,e			;beb7
	dec de			;beb8
	jr $-22		;beb9
	ld h,l			;bebb
	sbc a,l			;bebc
	ld e,c			;bebd
	adc a,e			;bebe
	ld h,d			;bebf
	adc a,e			;bec0
	ld h,c			;bec1
	ld c,b			;bec2
	ld b,h			;bec3
	sub (hl)			;bec4
	ld h,l			;bec5
	add a,(hl)			;bec6
	ld a,d			;bec7
	rst 18h			;bec8
	inc b			;bec9
	ld h,d			;beca
	adc a,(hl)			;becb
	ld d,a			;becc
	ld l,h			;becd
	ld c,e			;bece
	ld e,a			;becf
	rst 18h			;bed0
	inc bc			;bed1
	sbc a,l			;bed2
	ld d,h			;bed3
	ld e,l			;bed4
	ld (hl),c			;bed5
	add hl,hl			;bed6
	sub a			;bed7
	adc a,d			;bed8
	ld hl,(0938bh)		;bed9
	push af			;bedc
	or e			;bedd
	ld l,(hl)			;bede
	adc a,e			;bedf
	ld d,d			;bee0
	rrca			;bee1
	ld l,(hl)			;bee2
	sbc a,(hl)			;bee3
	scf			;bee4
	ld e,c			;bee5
	ld a,l			;bee6
	cp h			;bee7
	ld e,d			;bee8
	ld h,061h		;bee9
	xor h			;beeb
	sbc a,(hl)			;beec
	ld b,a			;beed
	ld l,d			;beee
	rst 18h			;beef
	adc a,(hl)			;bef0
	ld d,a			;bef1
	sbc a,e			;bef2
	ld h,d			;bef3
	rst 18h			;bef4
	ld e,(hl)			;bef5
	rst 18h			;bef6
	sbc a,c			;bef7
	ld e,h			;bef8
	sbc a,e			;bef9
	ld (hl),l			;befa
	ld d,b			;befb
	ld c,e			;befc
	jr nz,$-101		;befd
	ld d,b			;beff
	nop			;bf00
	ld h,(hl)			;bf01
	sub d			;bf02
	ld c,l			;bf03
	ret pe			;bf04
	adc a,l			;bf05
	sbc a,h			;bf06
	ld (hl),064h		;bf07
	ld h,b			;bf09
	sbc a,l			;bf0a
	ld d,h			;bf0b
	ld l,d			;bf0c
	dec hl			;bf0d
	inc d			;bf0e
	ld (hl),e			;bf0f
	add a,l			;bf10
	ld e,h			;bf11
	ld h,l			;bf12
	ld e,(hl)			;bf13
	adc a,e			;bf14
	ld h,l			;bf15
	inc (hl)			;bf16
	add a,(hl)			;bf17
	ld (hl),b			;bf18
	sub d			;bf19
	ld e,h			;bf1a
	ccf			;bf1b
	ld h,a			;bf1c
	ld h,h			;bf1d
	ld e,(hl)			;bf1e
	rst 18h			;bf1f
	dec a			;bf20
	rra			;bf21
	ld h,h			;bf22
	adc a,h			;bf23
	ld d,h			;bf24
	ld h,b			;bf25
	push af			;bf26
	or e			;bf27
	ld l,(hl)			;bf28
	ld b,c			;bf29
	ld e,e			;bf2a
	ld l,(hl)			;bf2b
	sbc a,(hl)			;bf2c
	scf			;bf2d
	ld e,c			;bf2e
	ld a,l			;bf2f
	sbc a,h			;bf30
	ld e,d			;bf31
	ld h,061h		;bf32
	adc a,h			;bf34
	ld e,h			;bf35
	rst 18h			;bf36
	sbc a,l			;bf37
	ld e,c			;bf38
	adc a,e			;bf39
	ld h,d			;bf3a
	adc a,e			;bf3b
	ld h,c			;bf3c
	sbc a,e			;bf3d
	ld e,l			;bf3e
	sbc a,(hl)			;bf3f
	ld b,a			;bf40
	ld l,h			;bf41
	sbc a,l			;bf42
	sub e			;bf43
	ld l,l			;bf44
	ld d,066h		;bf45
	ld c,e			;bf47
	sub (hl)			;bf48
	ld e,d			;bf49
	adc a,h			;bf4a
	ld h,l			;bf4b
	ld (00a5eh),hl		;bf4c
	ld h,l			;bf4f
	adc a,a			;bf50
	dec de			;bf51
	ld c,a			;bf52
	sub b			;bf53
	ld h,(hl)			;bf54
	adc a,l			;bf55
	ld (hl),e			;bf56
	add hl,hl			;bf57
	ex af,af'			;bf58
	ld h,l			;bf59
	rst 10h			;bf5a
	adc a,h			;bf5b
	ld c,(hl)			;bf5c
	adc a,l			;bf5d
	sub (hl)			;bf5e
	ld hl,0585bh		;bf5f
	sub 07ch		;bf62
	ld h,l			;bf64
	adc a,a			;bf65
	ld d,h			;bf66
	adc a,d			;bf67
	ld e,e			;bf68
	ld b,e			;bf69
	push af			;bf6a
	cp d			;bf6b
	ld d,c			;bf6c
	xor e			;bf6d
	jr z,$+70		;bf6e
	sub b			;bf70
	ld a,l			;bf71
	or l			;bf72
	sbc a,(hl)			;bf73
	scf			;bf74
	ld h,b			;bf75
	rst 18h			;bf76
	ld a,b			;bf77
	inc hl			;bf78
	ld l,c			;bf79
	dec e			;bf7a
	adc a,h			;bf7b
	ld l,c			;bf7c
	rrca			;bf7d
	ld e,d			;bf7e
	dec sp			;bf7f
	ld e,h			;bf80
	adc a,h			;bf81
	ld h,e			;bf82
	adc a,c			;bf83
	ld l,d			;bf84
	ld b,(hl)			;bf85
	add a,(hl)			;bf86
	ld a,d			;bf87
	ld (bc),a			;bf88
	inc sp			;bf89
	adc a,d			;bf8a
	ld l,d			;bf8b
	rst 18h			;bf8c
	ld e,(hl)			;bf8d
	rst 18h			;bf8e
	or c			;bf8f
	ld e,a			;bf90
	sub b			;bf91
	ld l,b			;bf92
	sbc a,d			;bf93
	ld a,l			;bf94
	sbc a,h			;bf95
	dec (hl)			;bf96
	ld b,h			;bf97
	rlca			;bf98
	sub b			;bf99
	push af			;bf9a
	cp d			;bf9b
	ld d,c			;bf9c
	dec e			;bf9d
	adc a,h			;bf9e
	ld h,h			;bf9f
	ld d,(hl)			;bfa0
	sbc a,c			;bfa1
	ld h,e			;bfa2
	sub (hl)			;bfa3
	ld e,a			;bfa4
	rst 18h			;bfa5
	ld h,e			;bfa6
	sbc a,(hl)			;bfa7
	ld (hl),b			;bfa8
	ld e,(hl)			;bfa9
	sub d			;bfaa
	ld c,(hl)			;bfab
	jp (hl)			;bfac
	sub c			;bfad
	ld c,e			;bfae
	jr nz,$-101		;bfaf
	ld h,d			;bfb1
	ld h,h			;bfb2
	sbc a,e			;bfb3
	ld e,h			;bfb4
	ld c,c			;bfb5
	ld h,(hl)			;bfb6
	rst 18h			;bfb7
	scf			;bfb8
	ld h,b			;bfb9
	sbc a,e			;bfba
	ld a,062h		;bfbb
	rst 18h			;bfbd
	ld h,d			;bfbe
	sub (hl)			;bfbf
	sub d			;bfc0
	ld e,(hl)			;bfc1
	ld l,l			;bfc2
	ld d,l			;bfc3
	sub b			;bfc4
	ld b,05ah		;bfc5
	sbc a,e			;bfc7
	ld l,(hl)			;bfc8
	adc a,a			;bfc9
	ld h,b			;bfca
	ld h,l			;bfcb
	sub e			;bfcc
	ld l,c			;bfcd
	adc a,l			;bfce
	inc sp			;bfcf
	ld e,b			;bfd0
	ld a,h			;bfd1
	ld h,l			;bfd2
	add a,l			;bfd3
	ld e,h			;bfd4
	ld h,l			;bfd5
	ld b,c			;bfd6
	adc a,a			;bfd7
	ld h,e			;bfd8
	sub (hl)			;bfd9
	ld e,a			;bfda
	push af			;bfdb
	cp d			;bfdc
	ld d,c			;bfdd
	sub d			;bfde
	sub (hl)			;bfdf
	ld c,h			;bfe0
	ld h,e			;bfe1
	sub (hl)			;bfe2
	ld e,b			;bfe3
	ld h,h			;bfe4
	ld d,e			;bfe5
	ld e,e			;bfe6
	sub c			;bfe7
	adc a,e			;bfe8
	ld h,h			;bfe9
	ld b,c			;bfea
	adc a,a			;bfeb
	ld h,e			;bfec
	sub (hl)			;bfed
	ld e,a			;bfee
	rst 18h			;bfef
	ld h,e			;bff0
	sbc a,(hl)			;bff1
	ld a,(hl)			;bff2
	add a,l			;bff3
	ld e,h			;bff4
	ld h,l			;bff5
	sbc a,c			;bff6
	jr $+97		;bff7
	ld a,093h		;bff9
	ld h,c			;bffb
	ld h,l			;bffc
	adc a,e			;bffd
	dec de			;bffe
	ld h,h			;bfff
	ld (de),a			;c000
	adc a,a			;c001
	ld (hl),l			;c002
	add hl,de			;c003
	adc a,a			;c004
	ld h,e			;c005
	sub (hl)			;c006
	ld e,d			;c007
	ld e,e			;c008
	ld l,(hl)			;c009
	sub d			;c00a
	ret pe			;c00b
	ld c,h			;c00c
	ld c,l			;c00d
	ld e,c			;c00e
	push af			;c00f
	cp d			;c010
	ld d,c			;c011
	ld l,b			;c012
	ld b,l			;c013
	sub (hl)			;c014
	sub b			;c015
	ld a,l			;c016
	sub l			;c017
	ld d,a			;c018
	sbc a,b			;c019
	sub b			;c01a
	ld a,h			;c01b
	ld h,l			;c01c
	adc a,a			;c01d
	daa			;c01e
	ld h,065h		;c01f
	ld h,h			;c021
	cp h			;c022
	ld c,b			;c023
	adc a,a			;c024
	ld (hl),l			;c025
	xor e			;c026
	sub e			;c027
	ld c,(hl)			;c028
	sub a			;c029
	adc a,e			;c02a
	inc c			;c02b
	rst 18h			;c02c
	ld a,b			;c02d
	ld a,(hl)			;c02e
	sbc a,h			;c02f
	ld h,d			;c030
	sbc a,h			;c031
	inc (hl)			;c032
	ld l,e			;c033
	rst 18h			;c034
	sbc a,c			;c035
	ld e,a			;c036
	sub d			;c037
	halt			;c038
	sbc a,e			;c039
	ld de,06193h		;c03a
	xor e			;c03d
	rst 18h			;c03e
	ld d,l			;c03f
	sbc a,l			;c040
	ld h,d			;c041
	sbc a,h			;c042
	ld b,l			;c043
	ld l,(hl)			;c044
	sub e			;c045
	ld a,(05e63h)		;c046
	ld l,l			;c049
	sbc a,c			;c04a
	ld e,a			;c04b
	sub d			;c04c
	ld h,d			;c04d
	sbc a,e			;c04e
	ld h,h			;c04f
	ld b,a			;c050
	ld l,h			;c051
	adc a,h			;c052
	dec hl			;c053
	cp (hl)			;c054
	ld d,c			;c055
	or c			;c056
	ld e,a			;c057
	adc a,e			;c058
	ld h,c			;c059
	inc (hl)			;c05a
	add a,(hl)			;c05b
	ld (hl),b			;c05c
	ld e,(hl)			;c05d
	adc a,e			;c05e
	ld h,h			;c05f
	sub d			;c060
	ld d,d			;c061
	ld h,h			;c062
	add a,(hl)			;c063
	ld l,e			;c064
	rst 18h			;c065
	ld b,c			;c066
	rst 18h			;c067
	inc bc			;c068
	ld c,a			;c069
	ld h,h			;c06a
	adc a,h			;c06b
	ld d,a			;c06c
	sub e			;c06d
	ld h,h			;c06e
	sbc a,h			;c06f
	ld d,e			;c070
	sbc a,h			;c071
	ld e,d			;c072
	rst 18h			;c073
	ld e,(hl)			;c074
	sbc a,b			;c075
	ld d,b			;c076
	ld l,c			;c077
	sbc a,h			;c078
	ld c,(hl)			;c079
	adc a,e			;c07a
	ex af,af'			;c07b
	push af			;c07c
	dec (hl)			;c07d
	or (hl)			;c07e
	ld b,a			;c07f
	or a			;c080
	ld d,d			;c081
	or a			;c082
	ld d,e			;c083
	or a			;c084
	ld d,h			;c085
	or a			;c086
	ld d,l			;c087
	or a			;c088
	ld d,(hl)			;c089
	or a			;c08a
	ld d,a			;c08b
	or a			;c08c
	ld e,b			;c08d
	or a			;c08e
	ld e,c			;c08f
	or a			;c090
	ld e,d			;c091
	or a			;c092
	ld e,e			;c093
	or a			;c094
	ld e,h			;c095
	or a			;c096
	ld e,l			;c097
	or a			;c098
	ld e,(hl)			;c099
	or a			;c09a
	ld e,a			;c09b
	or a			;c09c
	ld h,b			;c09d
	or a			;c09e
	rst 0			;c09f
	or a			;c0a0
	ret z			;c0a1
	or a			;c0a2
	inc b			;c0a3
	cp b			;c0a4
	ld a,(070b8h)		;c0a5
	cp b			;c0a8
	ld (hl),c			;c0a9
	cp b			;c0aa
	xor h			;c0ab
	cp b			;c0ac
	xor 0b8h		;c0ad
	ld e,0b9h		;c0af
	ld h,c			;c0b1
	cp c			;c0b2
	ld h,d			;c0b3
	cp c			;c0b4
	xor e			;c0b5
	cp c			;c0b6
	push af			;c0b7
	cp c			;c0b8
	ld de,02fbah		;c0b9
	cp d			;c0bc
	ld (hl),l			;c0bd
	cp d			;c0be
	cp c			;c0bf
	cp d			;c0c0
	ei			;c0c1
	cp d			;c0c2
	ld d,e			;c0c3
	cp e			;c0c4
	sbc a,(hl)			;c0c5
	cp e			;c0c6
	sbc a,a			;c0c7
	cp e			;c0c8
	jp (hl)			;c0c9
	cp e			;c0ca
	inc h			;c0cb
	cp h			;c0cc
	add a,e			;c0cd
	cp h			;c0ce
	cp b			;c0cf
	cp h			;c0d0
	jp pe,02abch		;c0d1
	cp l			;c0d4
	ld c,e			;c0d5
	cp l			;c0d6
	sbc a,e			;c0d7
	cp l			;c0d8
	ex de,hl			;c0d9
	cp l			;c0da
	jr z,$-64		;c0db
	ld d,e			;c0dd
	cp (hl)			;c0de
	sub h			;c0df
	cp (hl)			;c0e0
	cp (ix+027h)		;c0e1
	cp a			;c0e4
	ld l,e			;c0e5
	cp a			;c0e6
	sbc a,e			;c0e7
	cp a			;c0e8
	call c,010bfh		;c0e9
	ret nz			;c0ec
	rst 38h			;c0ed
	rst 38h			;c0ee
	rst 38h			;c0ef
	rst 38h			;c0f0
	rst 38h			;c0f1
	rst 38h			;c0f2
	rst 38h			;c0f3
	rst 38h			;c0f4
	rst 38h			;c0f5
	rst 38h			;c0f6
	rst 38h			;c0f7
	rst 38h			;c0f8
	rst 38h			;c0f9
	rst 38h			;c0fa
	rst 38h			;c0fb
	rst 38h			;c0fc
	ld (bc),a			;c0fd
	ld (de),a			;c0fe
	inc b			;c0ff
	inc de			;c100
	inc bc			;c101
	djnz $+1		;c102
	rst 38h			;c104
	ld bc,0ff10h		;c105
	inc bc			;c108
	djnz $+6		;c109
	inc d			;c10b
	rst 38h			;c10c
	ld bc,0031fh		;c10d
	inc de			;c110
	ld (bc),a			;c111
	inc e			;c112
	add hl,bc			;c113
	ld d,004h		;c114
	ld d,0ffh		;c116
	rst 38h			;c118
	ld bc,00318h		;c119
	inc d			;c11c
	ld (bc),a			;c11d
	rla			;c11e
	inc b			;c11f
	dec de			;c120
	ld a,(bc)			;c121
	ld d,0ffh		;c122
	inc bc			;c124
	inc e			;c125
	ld (bc),a			;c126
	ld (01609h),hl		;c127
	ld bc,0ff16h		;c12a
	ld bc,0032fh		;c12d
	rra			;c130
	inc b			;c131
	add hl,de			;c132
	add hl,bc			;c133
	ld d,002h		;c134
	ld d,0ffh		;c136
	inc bc			;c138
	jr $+4		;c139
	dec de			;c13b
	inc b			;c13c
	inc (hl)			;c13d
	rst 38h			;c13e
	rst 38h			;c13f
	ld bc,00919h		;c140
	ld d,003h		;c143
	ld d,0ffh		;c145
	ld bc,00214h		;c147
	dec e			;c14a
	inc b			;c14b
	rla			;c14c
	rst 38h			;c14d
	ld bc,0021ch		;c14e
	ld e,0ffh		;c151
	ld bc,0ff1dh		;c153
	ld (bc),a			;c156
	inc d			;c157
	inc b			;c158
	jr $+11		;c159
	jr nz,$+1		;c15b
	inc bc			;c15d
	ld hl,0210bh		;c15e
	ld a,(bc)			;c161
	rra			;c162
	rst 38h			;c163
	inc b			;c164
	jr nz,$+14		;c165
	jr nz,$+1		;c167
	ld bc,00217h		;c169
	dec h			;c16c
	inc b			;c16d
	inc hl			;c16e
	dec bc			;c16f
	inc hl			;c170
	rst 38h			;c171
	inc bc			;c172
	ld (0220ch),hl		;c173
	rst 38h			;c176
	rst 38h			;c177
	ld bc,00222h		;c178
	daa			;c17b
	inc b			;c17c
	ld h,00bh		;c17d
	ld h,0ffh		;c17f
	inc bc			;c181
	dec h			;c182
	inc c			;c183
	dec h			;c184
	rst 38h			;c185
	ld bc,00425h		;c186
	jr z,$+10		;c189
	ld hl,(02b02h)		;c18b
	dec bc			;c18e
	jr z,$+1		;c18f
	add hl,bc			;c191
	add hl,hl			;c192
	inc bc			;c193
	daa			;c194
	inc c			;c195
	daa			;c196
	rst 38h			;c197
	ld a,(bc)			;c198
	jr z,$+14		;c199
	jr z,$+1		;c19b
	inc bc			;c19d
	dec hl			;c19e
	dec b			;c19f
	daa			;c1a0
	rst 38h			;c1a1
	ld bc,00327h		;c1a2
	inc l			;c1a5
	ld (bc),a			;c1a6
	dec l			;c1a7
	inc b			;c1a8
	ld hl,(004ffh)		;c1a9
	dec hl			;c1ac
	rst 38h			;c1ad
	ld bc,0022bh		;c1ae
	ld l,00bh		;c1b1
	ld l,0ffh		;c1b3
	ld bc,00c2dh		;c1b5
	dec l			;c1b8
	rst 38h			;c1b9
	ld bc,00331h		;c1ba
	jr nc,$+4		;c1bd
	jr $+13		;c1bf
	jr nc,$+1		;c1c1
	inc b			;c1c3
	cpl			;c1c4
	inc c			;c1c5
	cpl			;c1c6
	rst 38h			;c1c7
	ld (bc),a			;c1c8
	cpl			;c1c9
	ld bc,0ff32h		;c1ca
	ld (bc),a			;c1cd
	ld sp,0330ah		;c1ce
	rst 38h			;c1d1
	add hl,bc			;c1d2
	ld (001ffh),a		;c1d3
	scf			;c1d6
	inc bc			;c1d7
	add hl,de			;c1d8
	ld (bc),a			;c1d9
	dec (hl)			;c1da
	rst 38h			;c1db
	ld bc,00934h		;c1dc
	ld (hl),0ffh		;c1df
	ld a,(bc)			;c1e1
	dec (hl)			;c1e2
	rst 38h			;c1e3
	ld (bc),a			;c1e4
	inc (hl)			;c1e5
	rst 38h			;c1e6
	defb 0edh;next byte illegal after ed		;c1e7
	ret nz			;c1e8
	xor 0c0h		;c1e9
	rst 28h			;c1eb
	ret nz			;c1ec
	ret p			;c1ed
	ret nz			;c1ee
	pop af			;c1ef
	ret nz			;c1f0
	jp p,0f3c0h		;c1f1
	ret nz			;c1f4
	call p,0f5c0h		;c1f5
	ret nz			;c1f8
	or 0c0h		;c1f9
	rst 30h			;c1fb
	ret nz			;c1fc
	ret m			;c1fd
	ret nz			;c1fe
	ld sp,hl			;c1ff
	ret nz			;c200
	jp m,0fbc0h		;c201
	ret nz			;c204
	call m,0fdc0h		;c205
	ret nz			;c208
	inc b			;c209
	pop bc			;c20a
	dec b			;c20b
	pop bc			;c20c
	ex af,af'			;c20d
	pop bc			;c20e
	dec c			;c20f
	pop bc			;c210
	jr $-61		;c211
	add hl,de			;c213
	pop bc			;c214
	inc h			;c215
	pop bc			;c216
	dec l			;c217
	pop bc			;c218
	jr c,$-61		;c219
	ccf			;c21b
	pop bc			;c21c
	ld b,b			;c21d
	pop bc			;c21e
	ld b,a			;c21f
	pop bc			;c220
	ld c,(hl)			;c221
	pop bc			;c222
	ld d,e			;c223
	pop bc			;c224
	ld d,(hl)			;c225
	pop bc			;c226
	ld e,l			;c227
	pop bc			;c228
	ld h,h			;c229
	pop bc			;c22a
	ld l,c			;c22b
	pop bc			;c22c
	ld (hl),d			;c22d
	pop bc			;c22e
	ld (hl),a			;c22f
	pop bc			;c230
	ld a,b			;c231
	pop bc			;c232
	add a,c			;c233
	pop bc			;c234
	add a,(hl)			;c235
	pop bc			;c236
	sub c			;c237
	pop bc			;c238
	sbc a,b			;c239
	pop bc			;c23a
	sbc a,l			;c23b
	pop bc			;c23c
	and d			;c23d
	pop bc			;c23e
	xor e			;c23f
	pop bc			;c240
	xor (hl)			;c241
	pop bc			;c242
	or l			;c243
	pop bc			;c244
	cp d			;c245
	pop bc			;c246
	jp 0c8c1h		;c247
	pop bc			;c24a
	call 0d2c1h		;c24b
	pop bc			;c24e
	push de			;c24f
	pop bc			;c250
	call c,0e1c1h		;c251
	pop bc			;c254
	call po,032c1h		;c255
	rst 38h			;c258
	inc sp			;c259
	rst 38h			;c25a
	dec (hl)			;c25b
	rst 38h			;c25c
	ld (hl),0ffh		;c25d
	scf			;c25f
	rst 38h			;c260
	inc a			;c261
	rst 38h			;c262
	dec a			;c263
	rst 38h			;c264
	ld a,0ffh		;c265
	ld b,b			;c267
	rst 38h			;c268
	ld c,b			;c269
	rst 38h			;c26a
	ld c,d			;c26b
	rst 38h			;c26c
	ld a,c			;c26d
	rst 38h			;c26e
	ld c,a			;c26f
	rst 38h			;c270
	ld d,b			;c271
	rst 38h			;c272
	ld d,c			;c273
	ld (03351h),a		;c274
	ld d,d			;c277
	rst 38h			;c278
	ld d,e			;c279
	rst 38h			;c27a
	ld d,h			;c27b
	rst 38h			;c27c
	ld d,(hl)			;c27d
	rst 38h			;c27e
	ld e,b			;c27f
	rst 38h			;c280
	ld a,d			;c281
	rst 38h			;c282
	ld l,(hl)			;c283
	rst 38h			;c284
	ld e,h			;c285
	rst 38h			;c286
	ld h,b			;c287
	rst 38h			;c288
	ld h,c			;c289
	rst 38h			;c28a
	ld h,c			;c28b
	dec sp			;c28c
	ld h,d			;c28d
	rst 38h			;c28e
	ld h,e			;c28f
	rst 38h			;c290
	ld h,h			;c291
	rst 38h			;c292
	ld h,l			;c293
	rst 38h			;c294
	ld h,l			;c295
	rst 38h			;c296
	ld (0663bh),a		;c297
	rst 38h			;c29a
	ld h,a			;c29b
	rst 38h			;c29c
	ld l,b			;c29d
	rst 38h			;c29e
	ld l,d			;c29f
	rst 38h			;c2a0
	ld l,e			;c2a1
	rst 38h			;c2a2
	ld l,l			;c2a3
	rst 38h			;c2a4
	ld (hl),c			;c2a5
	scf			;c2a6
	halt			;c2a7
	rst 38h			;c2a8
	ld (hl),a			;c2a9
	rst 38h			;c2aa
	ld bc,0417ch		;c2ab
	ld a,h			;c2ae
	ld a,h			;c2af
	ld b,c			;c2b0
	ld b,c			;c2b1
	ld b,c			;c2b2
	ld bc,00101h		;c2b3
	ld bc,08101h		;c2b6
	ld bc,00101h		;c2b9
	ld bc,00101h		;c2bc
	ld bc,00101h		;c2bf
	ld bc,00101h		;c2c2
	ld bc,00101h		;c2c5
	ld bc,00101h		;c2c8
	ld bc,00101h		;c2cb
	ld bc,00101h		;c2ce
	ld bc,00101h		;c2d1
	ld bc,00040h		;c2d4
	ex af,af'			;c2d7
	ret nz			;c2d8
	inc c			;c2d9
	ld d,b			;c2da
	inc b			;c2db
	and b			;c2dc
	inc c			;c2dd
	and b			;c2de
	inc h			;c2df
	ld h,b			;c2e0
	inc l			;c2e1
	ld h,b			;c2e2
	inc h			;c2e3
	ld h,b			;c2e4
	jr nz,$+2		;c2e5
	ld c,b			;c2e7
	jr nz,$+66		;c2e8
	jr nz,$+74		;c2ea
	jr nz,$-54		;c2ec
	nop			;c2ee
	ld c,b			;c2ef
	jr nz,$+66		;c2f0
	jr nz,$+66		;c2f2
	jr nz,$+74		;c2f4
	jr nz,$+74		;c2f6
	jr z,$+74		;c2f8
	jr z,$+74		;c2fa
	jr z,$+74		;c2fc
	ld (bc),a			;c2fe
	ld c,c			;c2ff
	nop			;c300
	ld c,c			;c301
	nop			;c302
	ld b,b			;c303
	jr nz,$+74		;c304
	jr nz,$+66		;c306
	ld b,040h		;c308
	nop			;c30a
	ld c,b			;c30b
	nop			;c30c
	nop			;c30d
	jr nz,$+66		;c30e
	nop			;c310
	ld b,b			;c311
	nop			;c312
	ld b,b			;c313
	nop			;c314
	ld b,b			;c315
	nop			;c316
	ex af,af'			;c317
	jr nz,$+2		;c318
	jr nz,$+66		;c31a
	jr nz,$+2		;c31c
	jr nz,$+66		;c31e
	jr nz,$+27		;c320
	nop			;c322
	inc de			;c323
	nop			;c324
	add hl,de			;c325
	ld (bc),a			;c326
	inc de			;c327
	nop			;c328
	call m,0fc30h		;c329
	dec hl			;c32c
	inc l			;c32d
	ld l,036h		;c32e
	ld hl,0112ah		;c330
	ld de,002fch		;c333
	call m,0fcfch		;c336
	call m,0fcfch		;c339
	call m,0fcfch		;c33c
	call m,01120h		;c33f
	call m,0fcfch		;c342
	call m,031fch		;c345
	call m,029fch		;c348
	ld h,029h		;c34b
	call m,0fcfch		;c34d
	call m,0fcfch		;c350
	rst 38h			;c353
	nop			;c354
	nop			;c355
	ld c,(hl)			;c356
	ld bc,00052h		;c357
	nop			;c35a
	ld l,e			;c35b
	rra			;c35c
	ld h,h			;c35d
	dec e			;c35e
	ld l,e			;c35f
	rra			;c360
	dec (hl)			;c361
	ld l,l			;c362
	inc de			;c363
	nop			;c364
	jr $+31		;c365
	ld c,e			;c367
	ld (bc),a			;c368
	dec h			;c369
	djnz $+119		;c36a
	rst 38h			;c36c
	ld (bc),a			;c36d
	scf			;c36e
	ld c,l			;c36f
	nop			;c370
	rst 38h			;c371
	nop			;c372
	ld bc,0fd0bh		;c373
	ld d,h			;c376
	ld c,e			;c377
	jr nc,$+10		;c378
	ld c,e			;c37a
	dec c			;c37b
	ld c,(hl)			;c37c
	ld bc,000ffh		;c37d
	ld bc,00113h		;c380
	dec d			;c383
	rst 38h			;c384
	ld a,l			;c385
	ld h,002h		;c386
	dec bc			;c388
	defb 0fdh,04bh,022h	;illegal sequence		;c389
	inc c			;c38c
	ld (bc),a			;c38d
	ld d,b			;c38e
	ld (bc),a			;c38f
	ex af,af'			;c390
	call nc,04b02h		;c391
	dec c			;c394
	ld c,(hl)			;c395
	nop			;c396
	sbc a,h			;c397
	inc e			;c398
	ld a,l			;c399
	ld (bc),a			;c39a
	ex af,af'			;c39b
	ld (hl),h			;c39c
	ld bc,00cffh		;c39d
	ex af,af'			;c3a0
	ld d,b			;c3a1
	ld (bc),a			;c3a2
	ex af,af'			;c3a3
	ld c,e			;c3a4
	ld c,04bh		;c3a5
	rrca			;c3a7
	rst 38h			;c3a8
	ld c,(hl)			;c3a9
	dec b			;c3aa
	dec e			;c3ab
	ld c,(hl)			;c3ac
	inc bc			;c3ad
	ld h,e			;c3ae
	nop			;c3af
	nop			;c3b0
	halt			;c3b1
	nop			;c3b2
	rst 38h			;c3b3
	inc sp			;c3b4
	ld (bc),a			;c3b5
	sbc a,d			;c3b6
	ld (bc),a			;c3b7
	ld (de),a			;c3b8
	inc sp			;c3b9
	ld (bc),a			;c3ba
	sbc a,e			;c3bb
	ld (bc),a			;c3bc
	inc de			;c3bd
	inc sp			;c3be
	ld (bc),a			;c3bf
	sbc a,h			;c3c0
	ld (bc),a			;c3c1
	dec de			;c3c2
	inc sp			;c3c3
	ld (bc),a			;c3c4
	sbc a,l			;c3c5
	ld (bc),a			;c3c6
	ld e,033h		;c3c7
	ld (bc),a			;c3c9
	sbc a,(hl)			;c3ca
	ld (bc),a			;c3cb
	ld hl,00233h		;c3cc
	sbc a,a			;c3cf
	ld (bc),a			;c3d0
	inc hl			;c3d1
	inc sp			;c3d2
	ld (bc),a			;c3d3
	and b			;c3d4
	ld (bc),a			;c3d5
	ld h,033h		;c3d6
	ld (bc),a			;c3d8
	and c			;c3d9
	ld (bc),a			;c3da
	ld hl,(00233h)		;c3db
	and d			;c3de
	ld (bc),a			;c3df
	ld l,033h		;c3e0
	ld (bc),a			;c3e2
	and e			;c3e3
	ld (bc),a			;c3e4
	inc sp			;c3e5
	inc sp			;c3e6
	ld (bc),a			;c3e7
	and h			;c3e8
	ld (bc),a			;c3e9
	ld (hl),033h		;c3ea
	ld (bc),a			;c3ec
	and l			;c3ed
	rst 38h			;c3ee
	or (hl)			;c3ef
	ld (bc),a			;c3f0
	ld (hl),041h		;c3f1
	rst 38h			;c3f3
	jr nc,$+11		;c3f4
	ld c,(hl)			;c3f6
	ld bc,0cd0ch		;c3f7
	jr nc,$-49		;c3fa
	ld c,l			;c3fc
	ld a,d			;c3fd
	rst 38h			;c3fe
	dec bc			;c3ff
	inc e			;c400
	sub e			;c401
	ld h,0ffh		;c402
	ld c,e			;c404
	jr $+1		;c405
	ld c,e			;c407
	ld bc,0ffffh		;c408
	rst 38h			;c40b
	ld d,h			;c40c
	jp 0ffffh		;c40d
	ld l,l			;c410
	jp 0ffffh		;c411
	ld (hl),d			;c414
	jp 0ffffh		;c415
	ld a,a			;c418
	jp 0ffffh		;c419
	add a,l			;c41c
	jp 0ffffh		;c41d
	sbc a,a			;c420
	jp 0ffffh		;c421
	xor c			;c424
	jp 0ffffh		;c425
	or h			;c428
	jp 0ffffh		;c429
	rst 28h			;c42c
	jp 0ffffh		;c42d
	call p,0ffc3h		;c430
	rst 38h			;c433
	rst 38h			;c434
	jp 0ffffh		;c435
	inc b			;c438
	call nz,0ffffh		;c439
	rlca			;c43c
	call nz,00000h		;c43d
	ld c,e			;c440
	inc bc			;c441
	ld c,a			;c442
	rst 0			;c443
	rst 38h			;c444
	ld (001c7h),a		;c445
	dec c			;c448
	rst 0			;c449
	ld bc,09726h		;c44a
	dec h			;c44d
	ld bc,0092fh		;c44e
	ld (hl),l			;c451
	rst 38h			;c452
	dec c			;c453
	rst 0			;c454
	rlca			;c455
	ld h,095h		;c456
	rst 38h			;c458
	inc c			;c459
	rst 0			;c45a
	dec c			;c45b
	rst 0			;c45c
	inc bc			;c45d
	ld h,096h		;c45e
	rst 38h			;c460
	ld c,e			;c461
	add hl,de			;c462
	rst 38h			;c463
	ld c,c			;c464
	nop			;c465
	ld (hl),006h		;c466
	ld l,h			;c468
	rst 38h			;c469
	ld b,l			;c46a
	ei			;c46b
	rrca			;c46c
	ld (00dfah),hl		;c46d
	inc c			;c470
	rst 38h			;c471
	ld a,l			;c472
	dec bc			;c473
	inc c			;c474
	ld a,l			;c475
	dec c			;c476
	ld c,0ffh		;c477
	ld b,l			;c479
	ei			;c47a
	rrca			;c47b
	ld (07dfah),hl		;c47c
	ld (0240bh),hl		;c47f
	rst 38h			;c482
	ei			;c483
	rst 38h			;c484
	ld b,l			;c485
	ei			;c486
	rrca			;c487
	dec l			;c488
	jp m,02d7dh		;c489
	ld c,0ffh		;c48c
	rrca			;c48e
	ld hl,07dfah		;c48f
	ld hl,0ff0ah		;c492
	rrca			;c495
	inc hl			;c496
	jp m,0237dh		;c497
	dec c			;c49a
	rst 38h			;c49b
	rrca			;c49c
	inc l			;c49d
	jp m,02c7dh		;c49e
	inc c			;c4a1
	rrca			;c4a2
	dec l			;c4a3
	jp m,02d7dh		;c4a4
	ld c,0ffh		;c4a7
	inc h			;c4a9
	jp m,02fffh		;c4aa
	ld (00dffh),hl		;c4ad
	ld (07dffh),hl		;c4b0
	dec bc			;c4b3
	ld (00d7dh),hl		;c4b4
	inc hl			;c4b7
	ld a,l			;c4b8
	inc c			;c4b9
	inc l			;c4ba
	ld a,l			;c4bb
	ld c,02dh		;c4bc
	rst 38h			;c4be
	dec c			;c4bf
	dec hl			;c4c0
	rst 38h			;c4c1
	ld a,l			;c4c2
	djnz $+45		;c4c3
	rst 38h			;c4c5
	ld a,l			;c4c6
	ld a,(bc)			;c4c7
	ld hl,0240dh		;c4c8
	rst 38h			;c4cb
	ld a,l			;c4cc
	rrca			;c4cd
	inc h			;c4ce
	rst 38h			;c4cf
	ld a,l			;c4d0
	ld hl,07d0ah		;c4d1
	ld (07d0bh),hl		;c4d4
	inc l			;c4d7
	inc c			;c4d8
	ld a,l			;c4d9
	inc hl			;c4da
	dec c			;c4db
	ld a,l			;c4dc
	dec l			;c4dd
	ld c,07dh		;c4de
	inc h			;c4e0
	rrca			;c4e1
	ld a,l			;c4e2
	dec hl			;c4e3
	djnz $+1		;c4e4
	dec c			;c4e6
	rra			;c4e7
	rst 38h			;c4e8
	ld sp,00120h		;c4e9
	jr nc,$+33		;c4ec
	ld (hl),h			;c4ee
	ld bc,031ffh		;c4ef
	rra			;c4f2
	ld bc,033ffh		;c4f3
	ld (03371h),hl		;c4f6
	inc hl			;c4f9
	scf			;c4fa
	rst 38h			;c4fb
	dec c			;c4fc
	inc l			;c4fd
	ld a,e			;c4fe
	inc sp			;c4ff
	inc l			;c500
	ld (hl),c			;c501
	inc sp			;c502
	dec l			;c503
	scf			;c504
	rst 38h			;c505
	ld b,l			;c506
	halt			;c507
	cpl			;c508
	inc l			;c509
	rst 38h			;c50a
	ld b,h			;c50b
	inc bc			;c50c
	inc h			;c50d
	ld hl,(0ffffh)		;c50e
	ld c,02ch		;c511
	ex af,af'			;c513
	ld (hl),070h		;c514
	ld l,h			;c516
	rst 38h			;c517
	inc h			;c518
	inc l			;c519
	xor l			;c51a
	rst 38h			;c51b
	ld b,l			;c51c
	ld a,c			;c51d
	rrca			;c51e
	ld (07d09h),hl		;c51f
	ld (0332ch),hl		;c522
	dec hl			;c525
	inc bc			;c526
	inc h			;c527
	ld hl,(0ff79h)		;c528
	ld c,a			;c52b
	inc l			;c52c
	rst 38h			;c52d
	ld c,02ch		;c52e
	ex af,af'			;c530
	ld b,h			;c531
	inc bc			;c532
	ld a,l			;c533
	inc l			;c534
	ld (02c2fh),hl		;c535
	rst 38h			;c538
	ld c,a			;c539
	ld (044ffh),hl		;c53a
	rst 38h			;c53d
	inc h			;c53e
	inc l			;c53f
	rst 38h			;c540
	rst 38h			;c541
	inc h			;c542
	ld d,l			;c543
	or b			;c544
	rst 38h			;c545
	inc h			;c546
	ld d,(hl)			;c547
	or b			;c548
	rst 38h			;c549
	ld b,h			;c54a
	inc b			;c54b
	inc h			;c54c
	ld c,d			;c54d
	rst 38h			;c54e
	rst 38h			;c54f
	ld b,l			;c550
	rst 38h			;c551
	inc h			;c552
	ld c,e			;c553
	rst 38h			;c554
	rst 38h			;c555
	ld b,h			;c556
	ld (bc),a			;c557
	inc h			;c558
	ld c,c			;c559
	rst 38h			;c55a
	rst 38h			;c55b
	ld (hl),04eh		;c55c
	ld l,h			;c55e
	rst 38h			;c55f
	inc h			;c560
	ld c,h			;c561
	rst 38h			;c562
	rst 38h			;c563
	nop			;c564
	djnz $+38		;c565
	inc l			;c567
	sub c			;c568
	rst 38h			;c569
	ld b,l			;c56a
	adc a,l			;c56b
	ld a,l			;c56c
	ld (0242ch),hl		;c56d
	add hl,sp			;c570
	adc a,l			;c571
	rst 38h			;c572
	ld b,l			;c573
	rst 38h			;c574
	inc sp			;c575
	inc l			;c576
	ld h,a			;c577
	rst 38h			;c578
	inc h			;c579
	ld c,e			;c57a
	ld h,a			;c57b
	rst 38h			;c57c
	ld h,h			;c57d
	ld a,(04f04h)		;c57e
	inc l			;c581
	rst 38h			;c582
	ld a,l			;c583
	ld (07d02h),hl		;c584
	inc hl			;c587
	inc bc			;c588
	ld a,l			;c589
	inc l			;c58a
	ld (02d7dh),hl		;c58b
	inc hl			;c58e
	ld a,l			;c58f
	ld (bc),a			;c590
	inc l			;c591
	ld a,l			;c592
	inc bc			;c593
	dec l			;c594
	inc h			;c595
	scf			;c596
	rst 38h			;c597
	rst 38h			;c598
	inc h			;c599
	ld (hl),048h		;c59a
	rst 38h			;c59c
	inc h			;c59d
	jr c,$+117		;c59e
	rst 38h			;c5a0
	inc h			;c5a1
	jr c,$+117		;c5a2
	rst 38h			;c5a4
	ld b,l			;c5a5
	and l			;c5a6
	inc sp			;c5a7
	inc l			;c5a8
	dec (hl)			;c5a9
	rst 38h			;c5aa
	ld h,h			;c5ab
	ld a,(02404h)		;c5ac
	ld (hl),0ffh		;c5af
	rst 38h			;c5b1
	inc h			;c5b2
	ld d,a			;c5b3
	ld h,d			;c5b4
	rst 38h			;c5b5
	inc h			;c5b6
	ld e,l			;c5b7
	ld h,d			;c5b8
	rst 38h			;c5b9
	inc h			;c5ba
	ld c,e			;c5bb
	ld h,h			;c5bc
	rst 38h			;c5bd
	inc h			;c5be
	ld e,d			;c5bf
	and c			;c5c0
	rst 38h			;c5c1
	ld c,022h		;c5c2
	sub (hl)			;c5c4
	rrca			;c5c5
	ld (024a1h),hl		;c5c6
	ld e,d			;c5c9
	and c			;c5ca
	rst 38h			;c5cb
	ld c,022h		;c5cc
	sub (hl)			;c5ce
	rrca			;c5cf
	ld (00ea1h),hl		;c5d0
	inc l			;c5d3
	sub (hl)			;c5d4
	rrca			;c5d5
	inc l			;c5d6
	and c			;c5d7
	ld (09722h),a		;c5d8
	ld (0972ch),a		;c5db
	ld c,h			;c5de
	ld (04cb3h),hl		;c5df
	inc l			;c5e2
	or h			;c5e3
	inc h			;c5e4
	ld e,d			;c5e5
	and c			;c5e6
	rst 38h			;c5e7
	scf			;c5e8
	nop			;c5e9
	call m,02333h		;c5ea
	dec sp			;c5ed
	rst 38h			;c5ee
	ld b,l			;c5ef
	ld (00037h),a		;c5f0
	call m,02d33h		;c5f3
	dec sp			;c5f6
	rst 38h			;c5f7
	ld e,b			;c5f8
	ld a,(de)			;c5f9
	call m,02333h		;c5fa
	dec sp			;c5fd
	rst 38h			;c5fe
	ld b,l			;c5ff
	ld h,c			;c600
	ld e,b			;c601
	ld a,(de)			;c602
	call m,02d33h		;c603
	dec sp			;c606
	rst 38h			;c607
	ld b,l			;c608
	and d			;c609
	ld a,l			;c60a
	ld (0242ch),hl		;c60b
	dec a			;c60e
	and d			;c60f
	rst 38h			;c610
	ld b,h			;c611
	ld (bc),a			;c612
	inc h			;c613
	ld c,c			;c614
	rst 38h			;c615
	rst 38h			;c616
	ld h,h			;c617
	rst 38h			;c618
	ld c,e			;c619
	rla			;c61a
	ld (hl),d			;c61b
	ld l,h			;c61c
	rst 38h			;c61d
	ld a,l			;c61e
	ld h,002h		;c61f
	ld l,d			;c621
	ld (bc),a			;c622
	ld c,e			;c623
	ld a,(de)			;c624
	ld (hl),e			;c625
	ld a,l			;c626
	ld (bc),a			;c627
	ld h,075h		;c628
	rst 38h			;c62a
	ld e,h			;c62b
	ld c,021h		;c62c
	inc c			;c62e
	ld (hl),008h		;c62f
	ld l,h			;c631
	rst 38h			;c632
	ld (hl),007h		;c633
	rrca			;c635
	ld hl,03609h		;c636
	inc bc			;c639
	rst 38h			;c63a
	ld a,l			;c63b
	ld hl,03102h		;c63c
	ld (bc),a			;c63f
	adc a,l			;c640
	or (hl)			;c641
	ld (bc),a			;c642
	ld (hl),030h		;c643
	ld c,e			;c645
	inc b			;c646
	ld l,h			;c647
	rst 38h			;c648
	rst 38h			;c649
	rst 38h			;c64a
	ld b,b			;c64b
	call nz,0ffffh		;c64c
	ld d,e			;c64f
	call nz,0ffffh		;c650
	ld e,c			;c653
	call nz,0ffffh		;c654
	ld h,c			;c657
	call nz,0ffffh		;c658
	ld h,h			;c65b
	call nz,0ffffh		;c65c
	ld l,d			;c65f
	call nz,0ffffh		;c660
	ld a,c			;c663
	call nz,0ffffh		;c664
	add a,l			;c667
	call nz,0fbffh		;c668
	adc a,(hl)			;c66b
	call nz,0fbffh		;c66c
	sub l			;c66f
	call nz,0fbffh		;c670
	sbc a,h			;c673
	call nz,0fbffh		;c674
	xor c			;c677
	call nz,0fffah		;c678
	xor a			;c67b
	call nz,0fffah		;c67c
	cp a			;c67f
	call nz,0fffah		;c680
	add a,0c4h		;c683
	rst 38h			;c685
	rst 38h			;c686
	ret nc			;c687
	call nz,0ffffh		;c688
	and 0c4h		;c68b
	rst 38h			;c68d
	rst 38h			;c68e
	pop af			;c68f
	call nz,07bffh		;c690
	push af			;c693
	call nz,0ffffh		;c694
	call m,0ffc4h		;c697
	ld h,h			;c69a
	ld b,0c5h		;c69b
	inc l			;c69d
	rst 38h			;c69e
	dec bc			;c69f
	push bc			;c6a0
	ld hl,(011adh)		;c6a1
	push bc			;c6a4
	ld hl,(018adh)		;c6a5
	push bc			;c6a8
	ld hl,(01cffh)		;c6a9
	push bc			;c6ac
	ld hl,(02bffh)		;c6ad
	push bc			;c6b0
	ld hl,(039ffh)		;c6b1
	push bc			;c6b4
	inc sp			;c6b5
	rst 38h			;c6b6
	ld b,d			;c6b7
	push bc			;c6b8
	inc (hl)			;c6b9
	rst 38h			;c6ba
	ld b,(hl)			;c6bb
	push bc			;c6bc
	ld c,e			;c6bd
	rst 38h			;c6be
	ld c,d			;c6bf
	push bc			;c6c0
	ld c,d			;c6c1
	rst 38h			;c6c2
	ld d,b			;c6c3
	push bc			;c6c4
	ld c,h			;c6c5
	rst 38h			;c6c6
	ld d,(hl)			;c6c7
	push bc			;c6c8
	jr nc,$+1		;c6c9
	ld e,h			;c6cb
	push bc			;c6cc
	ld c,l			;c6cd
	rst 38h			;c6ce
	ld h,b			;c6cf
	push bc			;c6d0
	inc l			;c6d1
	or c			;c6d2
	ld h,h			;c6d3
	push bc			;c6d4
	ld b,a			;c6d5
	ld h,a			;c6d6
	ld l,d			;c6d7
	push bc			;c6d8
	add hl,sp			;c6d9
	adc a,l			;c6da
	ld (hl),e			;c6db
	push bc			;c6dc
	ld a,(0798dh)		;c6dd
	push bc			;c6e0
	ld b,a			;c6e1
	rst 38h			;c6e2
	ld a,l			;c6e3
	push bc			;c6e4
	ld (hl),073h		;c6e5
	sbc a,c			;c6e7
	push bc			;c6e8
	ld (hl),048h		;c6e9
	sbc a,l			;c6eb
	push bc			;c6ec
	ld b,a			;c6ed
	ld (hl),e			;c6ee
	and c			;c6ef
	push bc			;c6f0
	jr c,$+117		;c6f1
	and l			;c6f3
	push bc			;c6f4
	jr c,$+1		;c6f5
	xor e			;c6f7
	push bc			;c6f8
	ld d,a			;c6f9
	ld h,c			;c6fa
	or d			;c6fb
	push bc			;c6fc
	ld a,062h		;c6fd
	or (hl)			;c6ff
	push bc			;c700
	ld b,b			;c701
	ld h,h			;c702
	cp d			;c703
	push bc			;c704
	ld d,c			;c705
	and c			;c706
	cp (hl)			;c707
	push bc			;c708
	ld d,c			;c709
	rst 38h			;c70a
	jp nz,05bc5h		;c70b
	rst 38h			;c70e
	call z,0ffc5h		;c70f
	ld (0c5e8h),a		;c712
	rst 38h			;c715
	rst 38h			;c716
	rst 28h			;c717
	push bc			;c718
	rst 38h			;c719
	ld h,c			;c71a
	ret m			;c71b
	push bc			;c71c
	rst 38h			;c71d
	rst 38h			;c71e
	rst 38h			;c71f
	push bc			;c720
	dec a			;c721
	ld h,l			;c722
	ex af,af'			;c723
	add a,047h		;c724
	rst 38h			;c726
	ld de,0ffc6h		;c727
	rst 38h			;c72a
	rla			;c72b
	add a,0ffh		;c72c
	rst 38h			;c72e
	add hl,de			;c72f
	add a,0ffh		;c730
	rst 38h			;c732
	ld e,0c6h		;c733
	rst 38h			;c735
	rst 38h			;c736
	dec hl			;c737
	add a,0ffh		;c738
	rst 38h			;c73a
	inc sp			;c73b
	add a,0ffh		;c73c
	rst 38h			;c73e
	dec sp			;c73f
	add a,000h		;c740
	nop			;c742
	ld c,(hl)			;c743
	ld (bc),a			;c744
	ld d,d			;c745
	ld bc,06b01h		;c746
	ld c,028h		;c749
	ld c,(hl)			;c74b
	dec b			;c74c
	ld d,d			;c74d
	nop			;c74e
	nop			;c74f
	ld l,e			;c750
	ld bc,04e1ch		;c751
	inc bc			;c754
	ld d,d			;c755
	nop			;c756
	nop			;c757
	ld l,e			;c758
	ld bc,0517fh		;c759
	ld (bc),a			;c75c
	ld c,e			;c75d
	rrca			;c75e
	rst 38h			;c75f
	jr nc,$+0		;c760
	rst 38h			;c762
	ld c,a			;c763
	cp 01dh		;c764
	ld c,a			;c766
	cp 03eh		;c767
	or b			;c769
	cp 0ffh		;c76a
	ld sp,001feh		;c76c
	rrca			;c76f
	cp 0feh		;c770
	ld (hl),h			;c772
	cp 0ffh		;c773
	inc sp			;c775
	ld de,03300h		;c776
	ld (de),a			;c779
	ld bc,07fffh		;c77a
	inc sp			;c77d
	ld hl,(03002h)		;c77e
	jr nc,$+53		;c781
	dec (hl)			;c783
	ld b,b			;c784
	inc sp			;c785
	inc (hl)			;c786
	ld (02533h),a		;c787
	ld b,033h		;c78a
	ld a,(bc)			;c78c
	ld hl,(0833dh)		;c78d
	nop			;c790
	rst 38h			;c791
	inc sp			;c792
	ret nz			;c793
	dec b			;c794
	rst 38h			;c795
	rst 38h			;c796
	rst 38h			;c797
	ld b,e			;c798
	rst 0			;c799
	rst 38h			;c79a
	rst 38h			;c79b
	ld h,b			;c79c
	rst 0			;c79d
	rst 38h			;c79e
	rst 38h			;c79f
	ld h,e			;c7a0
	rst 0			;c7a1
	rst 38h			;c7a2
	rst 38h			;c7a3
	ld l,h			;c7a4
	rst 0			;c7a5
	rst 38h			;c7a6
	rst 38h			;c7a7
	ld (hl),l			;c7a8
	rst 0			;c7a9
	rst 38h			;c7aa
	rst 38h			;c7ab
	ld a,h			;c7ac
	rst 0			;c7ad
	rst 38h			;c7ae
	rst 38h			;c7af
	sub d			;c7b0
	rst 0			;c7b1
	nop			;c7b2
	nop			;c7b3
	ld c,(hl)			;c7b4
	inc bc			;c7b5
	ld h,e			;c7b6
	nop			;c7b7
	inc e			;c7b8
	dec sp			;c7b9
	rst 30h			;c7ba
	halt			;c7bb
	inc l			;c7bc
	rst 38h			;c7bd
	ld (hl),011h		;c7be
	dec de			;c7c0
	rra			;c7c1
	ld c,(hl)			;c7c2
	ld bc,0ff67h		;c7c3
	rst 38h			;c7c6
	rst 38h			;c7c7
	or h			;c7c8
	rst 0			;c7c9
	rst 38h			;c7ca
	rst 38h			;c7cb
	cp (hl)			;c7cc
	rst 0			;c7cd
	nop			;c7ce
	nop			;c7cf
	jr nc,$+5		;c7d0
	inc sp			;c7d2
	ld (bc),a			;c7d3
	adc a,b			;c7d4
	inc sp			;c7d5
	ld hl,04b01h		;c7d6
	dec b			;c7d9
	ld c,003h		;c7da
	ld bc,08c36h		;c7dc
	rst 38h			;c7df
	dec c			;c7e0
	inc bc			;c7e1
	ld bc,08d36h		;c7e2
	rst 38h			;c7e5
	or (hl)			;c7e6
	ld (bc),a			;c7e7
	ld (hl),08ah		;c7e8
	rst 38h			;c7ea
	rst 38h			;c7eb
	rst 38h			;c7ec
	ret nc			;c7ed
	rst 0			;c7ee
	rst 38h			;c7ef
	rst 38h			;c7f0
	ret po			;c7f1
	rst 0			;c7f2
	rst 38h			;c7f3
	rst 38h			;c7f4
	and 0c7h		;c7f5
	nop			;c7f7
	nop			;c7f8
	ld a,l			;c7f9
	ld h,004h		;c7fa
	ld l,d			;c7fc
	inc b			;c7fd
	ld c,e			;c7fe
	ld a,(de)			;c7ff
	ld (hl),e			;c800
	ld c,e			;c801
	ld b,0ffh		;c802
	ld sp,00121h		;c804
	rrca			;c807
	ld hl,06c0ch		;c808
	rst 38h			;c80b
	rst 38h			;c80c
	rst 38h			;c80d
	ld sp,hl			;c80e
	rst 0			;c80f
	rst 38h			;c810
	rst 38h			;c811
	inc b			;c812
	ret z			;c813
	nop			;c814
	nop			;c815
	dec c			;c816
	inc bc			;c817
	ld bc,08936h		;c818
	rst 38h			;c81b
	ld c,003h		;c81c
	ld bc,08b36h		;c81e
	rst 38h			;c821
	inc c			;c822
	inc bc			;c823
	or (hl)			;c824
	ld (bc),a			;c825
	rst 38h			;c826
	ld a,l			;c827
	ld hl,03102h		;c828
	ld (bc),a			;c82b
	adc a,l			;c82c
	ld sp,00103h		;c82d
	rst 38h			;c830
	rst 38h			;c831
	rst 38h			;c832
	ld d,0c8h		;c833
	rst 38h			;c835
	rst 38h			;c836
	inc e			;c837
	ret z			;c838
	rst 38h			;c839
	rst 38h			;c83a
	ld (0ffc8h),hl		;c83b
	rst 38h			;c83e
	daa			;c83f
	ret z			;c840
	nop			;c841
	nop			;c842
	dec c			;c843
	inc sp			;c844
	rst 38h			;c845
	ld h,a			;c846
	rst 38h			;c847
	add a,l			;c848
	inc sp			;c849
	add a,h			;c84a
	ld (hl),04fh		;c84b
	ld (hl),002h		;c84d
	ld c,a			;c84f
	ld (hl),005h		;c850
	ld (hl),h			;c852
	ld (bc),a			;c853
	rst 38h			;c854
	ld a,(04b04h)		;c855
	inc de			;c858
	ld (hl),d			;c859
	add a,h			;c85a
	ld a,c			;c85b
	ld (hl),h			;c85c
	ld bc,085ffh		;c85d
	inc sp			;c860
	ld (hl),01ah		;c861
	ld d,0ffh		;c863
	ld a,l			;c865
	inc sp			;c866
	ld (bc),a			;c867
	ld a,(03608h)		;c868
	ld l,e			;c86b
	rst 38h			;c86c
	ld c,033h		;c86d
	dec c			;c86f
	rrca			;c870
	inc sp			;c871
	ld de,0334fh		;c872
	djnz $+53		;c875
	ld (bc),a			;c877
	ld c,0ffh		;c878
	ld c,033h		;c87a
	djnz $+17		;c87c
	inc sp			;c87e
	inc d			;c87f
	inc sp			;c880
	ld (bc),a			;c881
	ld de,00effh		;c882
	inc sp			;c885
	dec b			;c886
	rrca			;c887
	inc sp			;c888
	ex af,af'			;c889
	inc sp			;c88a
	ld (bc),a			;c88b
	ld b,0ffh		;c88c
	ld sp,00102h		;c88e
	call 03b02h		;c891
	rlca			;c894
	ld (hl),030h		;c895
	rst 38h			;c897
	inc c			;c898
	or l			;c899
	ld c,l			;c89a
	ld a,(hl)			;c89b
	rst 38h			;c89c
	inc (hl)			;c89d
	jr nc,$+4		;c89e
	rst 38h			;c8a0
	dec (hl)			;c8a1
	ld (bc),a			;c8a2
	ld (hl),0bfh		;c8a3
	inc sp			;c8a5
	inc bc			;c8a6
	or l			;c8a7
	ld b,a			;c8a8
	ld (bc),a			;c8a9
	inc bc			;c8aa
	or (hl)			;c8ab
	inc bc			;c8ac
	ld (hl),033h		;c8ad
	ld c,a			;c8af
	ld (bc),a			;c8b0
	add hl,bc			;c8b1
	ld sp,00102h		;c8b2
	ld (hl),h			;c8b5
	rst 38h			;c8b6
	rst 38h			;c8b7
	inc c			;c8b8
	cp b			;c8b9
	ld c,e			;c8ba
	add hl,bc			;c8bb
	rst 38h			;c8bc
	dec bc			;c8bd
	cp b			;c8be
	ld h,02dh		;c8bf
	ld d,0ffh		;c8c1
	ld e,c			;c8c3
	inc b			;c8c4
	ld (bc),a			;c8c5
	ld c,a			;c8c6
	ld (bc),a			;c8c7
	inc a			;c8c8
	ld c,l			;c8c9
	sbc a,e			;c8ca
	ld c,d			;c8cb
	inc b			;c8cc
	ld (hl),h			;c8cd
	ld (bc),a			;c8ce
	rst 38h			;c8cf
	ld a,(04b1fh)		;c8d0
	dec bc			;c8d3
	rst 38h			;c8d4
	ld a,(03b05h)		;c8d5
	rra			;c8d8
	ld c,e			;c8d9
	inc c			;c8da
	rst 38h			;c8db
	inc (hl)			;c8dc
	rst 38h			;c8dd
	rst 38h			;c8de
	rst 38h			;c8df
	ld b,e			;c8e0
	ret z			;c8e1
	rst 38h			;c8e2
	rst 38h			;c8e3
	ld c,b			;c8e4
	ret z			;c8e5
	rst 38h			;c8e6
	rst 38h			;c8e7
	ld d,l			;c8e8
	ret z			;c8e9
	rst 38h			;c8ea
	rst 38h			;c8eb
	ld e,a			;c8ec
	ret z			;c8ed
	rst 38h			;c8ee
	rst 38h			;c8ef
	ld h,l			;c8f0
	ret z			;c8f1
	rst 38h			;c8f2
	rst 38h			;c8f3
	ld l,l			;c8f4
	ret z			;c8f5
	rst 38h			;c8f6
	rst 38h			;c8f7
	ld a,d			;c8f8
	ret z			;c8f9
	rst 38h			;c8fa
	rst 38h			;c8fb
	add a,h			;c8fc
	ret z			;c8fd
	rst 38h			;c8fe
	rst 38h			;c8ff
	adc a,(hl)			;c900
	ret z			;c901
	inc l			;c902
	ld h,b			;c903
	sbc a,b			;c904
	ret z			;c905
	inc l			;c906
	ld c,a			;c907
	sbc a,l			;c908
	ret z			;c909
	inc l			;c90a
	ld c,a			;c90b
	and c			;c90c
	ret z			;c90d
	inc l			;c90e
	dec (hl)			;c90f
	cp b			;c910
	ret z			;c911
	inc l			;c912
	dec (hl)			;c913
	cp l			;c914
	ret z			;c915
	inc l			;c916
	scf			;c917
	jp 0ffc8h		;c918
	rst 38h			;c91b
	ret nc			;c91c
	ret z			;c91d
	rst 38h			;c91e
	rst 38h			;c91f
	push de			;c920
	ret z			;c921
	rst 38h			;c922
	rst 38h			;c923
	call c,000c8h		;c924
	nop			;c927
	ld (hl),062h		;c928
	ld c,e			;c92a
	ld a,(bc)			;c92b
	ld (hl),030h		;c92c
	rst 38h			;c92e
	rst 38h			;c92f
	rst 38h			;c930
	jr z,$-53		;c931
	nop			;c933
	nop			;c934
	ld (hl),072h		;c935
	ld c,e			;c937
	ld a,(bc)			;c938
	ld (hl),030h		;c939
	rst 38h			;c93b
	rst 38h			;c93c
	rst 38h			;c93d
	dec (hl)			;c93e
	ret			;c93f
	nop			;c940
	nop			;c941
	ld a,(03603h)		;c942
	ld h,a			;c945
	ld d,0ffh		;c946
	ld (hl),066h		;c948
	rst 38h			;c94a
	rst 38h			;c94b
	rst 38h			;c94c
	ld b,d			;c94d
	ret			;c94e
	rst 38h			;c94f
	rst 38h			;c950
	ld c,b			;c951
	ret			;c952
	nop			;c953
	nop			;c954
	dec bc			;c955
	cp b			;c956
	ld c,e			;c957
	ex af,af'			;c958
	ld d,0ffh		;c959
	ld a,(04b05h)		;c95b
	inc d			;c95e
	adc a,h			;c95f
	ld a,e			;c960
	ld a,l			;c961
	inc sp			;c962
	ld (bc),a			;c963
	defb 0fdh,07ch	;ld a,iyh		;c964
	inc bc			;c966
	cp b			;c967
	inc bc			;c968
	and 002h		;c969
	cp b			;c96b
	ld (bc),a			;c96c
	ld (hl),h			;c96d
	ld (bc),a			;c96e
	rst 38h			;c96f
	inc sp			;c970
	ld (bc),a			;c971
	inc a			;c972
	ld c,a			;c973
	inc sp			;c974
	ld bc,0334fh		;c975
	inc bc			;c978
	ld c,a			;c979
	inc sp			;c97a
	inc b			;c97b
	inc sp			;c97c
	ld (bc),a			;c97d
	ld bc,04cffh		;c97e
	scf			;c981
	ld (bc),a			;c982
	ld (hl),04bh		;c983
	ld c,e			;c985
	ld a,(bc)			;c986
	ld (hl),041h		;c987
	ld d,0ffh		;c989
	ld (hl),04fh		;c98b
	jp z,0ff33h		;c98d
	ld a,(08c05h)		;c990
	ld a,e			;c993
	xor e			;c994
	inc bc			;c995
	rst 38h			;c996
	rst 38h			;c997
	dec (hl)			;c998
	ld d,l			;c999
	ret			;c99a
	rst 38h			;c99b
	rst 38h			;c99c
	ld e,e			;c99d
	ret			;c99e
	rst 38h			;c99f
	rst 38h			;c9a0
	ld (hl),b			;c9a1
	ret			;c9a2
	rst 38h			;c9a3
	rst 38h			;c9a4
	add a,b			;c9a5
	ret			;c9a6
	rst 38h			;c9a7
	rst 38h			;c9a8
	adc a,e			;c9a9
	ret			;c9aa
	rst 38h			;c9ab
	rst 38h			;c9ac
	sub b			;c9ad
	ret			;c9ae
	nop			;c9af
	nop			;c9b0
	ld c,e			;c9b1
	inc d			;c9b2
	adc a,e			;c9b3
	ld a,e			;c9b4
	ld (hl),04bh		;c9b5
	ld c,e			;c9b7
	ld a,(bc)			;c9b8
	ld (hl),041h		;c9b9
	ld d,0ffh		;c9bb
	ld (hl),04fh		;c9bd
	ld sp,08233h		;c9bf
	defb 0fdh,033h,033h	;illegal sequence		;c9c2
	ld (hl),064h		;c9c5
	rst 38h			;c9c7
	rst 38h			;c9c8
	rst 38h			;c9c9
	or c			;c9ca
	ret			;c9cb
	rst 38h			;c9cc
	rst 38h			;c9cd
	cp l			;c9ce
	ret			;c9cf
	nop			;c9d0
	nop			;c9d1
	dec bc			;c9d2
	ex af,af'			;c9d3
	ld c,e			;c9d4
	ld c,04eh		;c9d5
	ld bc,0521dh		;c9d7
	rrca			;c9da
	nop			;c9db
	ld l,e			;c9dc
	ld a,(bc)			;c9dd
	ld a,a			;c9de
	rst 38h			;c9df
	rst 38h			;c9e0
	rst 38h			;c9e1
	jp nc,000c9h		;c9e2
	nop			;c9e5
	inc c			;c9e6
	add hl,bc			;c9e7
	jr $+50		;c9e8
	add hl,bc			;c9ea
	rst 38h			;c9eb
	rst 38h			;c9ec
	rst 38h			;c9ed
	and 0c9h		;c9ee
	nop			;c9f0
	nop			;c9f1
	ld c,(hl)			;c9f2
	rlca			;c9f3
	dec e			;c9f4
	ld c,(hl)			;c9f5
	ld bc,00252h		;c9f6
	nop			;c9f9
	ld l,e			;c9fa
	rla			;c9fb
	ld a,a			;c9fc
	jr nc,$+10		;c9fd
	ld b,c			;c9ff
	nop			;ca00
	ld b,d			;ca01
	ld bc,0ffffh		;ca02
	rst 38h			;ca05
	jp p,000c9h		;ca06
	nop			;ca09
	jr nc,$+4		;ca0a
	ld a,l			;ca0c
	inc sp			;ca0d
	inc bc			;ca0e
	rst 38h			;ca0f
	dec c			;ca10
	ld (bc),a			;ca11
	ld (bc),a			;ca12
	dec bc			;ca13
	cp b			;ca14
	ld (hl),h			;ca15
	ld bc,084ffh		;ca16
	ld (bc),a			;ca19
	cp b			;ca1a
	ld (bc),a			;ca1b
	ld a,(0b81fh)		;ca1c
	inc bc			;ca1f
	ld c,h			;ca20
	ld (hl),002h		;ca21
	ld d,0ffh		;ca23
	ld c,a			;ca25
	ld (bc),a			;ca26
	add hl,hl			;ca27
	ld sp,00102h		;ca28
	ld (hl),h			;ca2b
	defb 0fdh,0ffh,0b8h	;illegal sequence		;ca2c
	inc bc			;ca2f
	ld h,a			;ca30
	rst 38h			;ca31
	rst 38h			;ca32
	rst 38h			;ca33
	ld a,(bc)			;ca34
	jp z,0ffffh		;ca35
	djnz $-52		;ca38
	rst 38h			;ca3a
	rst 38h			;ca3b
	jr $-52		;ca3c
	rst 38h			;ca3e
	rst 38h			;ca3f
	dec h			;ca40
	jp z,0ffffh		;ca41
	ld l,0cah		;ca44
	nop			;ca46
	nop			;ca47
	ld c,e			;ca48
	ld (de),a			;ca49
	ld a,l			;ca4a
	inc sp			;ca4b
	add hl,de			;ca4c
	ld a,l			;ca4d
	ld (hl),01bh		;ca4e
	ld a,l			;ca50
	scf			;ca51
	jr $+127		;ca52
	jr c,$+28		;ca54
	ld a,l			;ca56
	ld a,(07d27h)		;ca57
	dec sp			;ca5a
	jr z,$+102		;ca5b
	ld h,a			;ca5d
	rst 38h			;ca5e
	rst 38h			;ca5f
	rst 38h			;ca60
	ld c,b			;ca61
	jp z,00000h		;ca62
	ld a,l			;ca65
	ld (07d02h),hl		;ca66
	inc hl			;ca69
	inc bc			;ca6a
	ld a,l			;ca6b
	inc l			;ca6c
	ld (02d7dh),hl		;ca6d
	inc hl			;ca70
	ld h,h			;ca71
	ld a,l			;ca72
	ld (bc),a			;ca73
	ld (0037dh),hl		;ca74
	inc hl			;ca77
	rst 38h			;ca78
	rst 38h			;ca79
	rst 38h			;ca7a
	ld h,l			;ca7b
	jp z,00000h		;ca7c
	ld a,(04b05h)		;ca7f
	inc d			;ca82
	ld d,0ffh		;ca83
	dec sp			;ca85
	inc b			;ca86
	cpl			;ca87
	ld a,c			;ca88
	ld h,a			;ca89
	rst 38h			;ca8a
	jr nc,$+4		;ca8b
	ld a,l			;ca8d
	inc sp			;ca8e
	inc bc			;ca8f
	rst 38h			;ca90
	cp b			;ca91
	ld (bc),a			;ca92
	ld a,(04b05h)		;ca93
	inc d			;ca96
	adc a,h			;ca97
	ld a,e			;ca98
	call z,0037ch		;ca99
	ld h,h			;ca9c
	ld d,0ffh		;ca9d
	ld sp,00102h		;ca9f
	rrca			;caa2
	ld (bc),a			;caa3
	add hl,bc			;caa4
	ld (hl),h			;caa5
	cp 0ffh		;caa6
	ld h,h			;caa8
	ld h,a			;caa9
	rst 38h			;caaa
	rst 38h			;caab
	rst 38h			;caac
	ld a,a			;caad
	jp z,0ffffh		;caae
	add a,l			;cab1
	jp z,0ffffh		;cab2
	adc a,e			;cab5
	jp z,0ffffh		;cab6
	sub c			;cab9
	jp z,0ffffh		;caba
	sbc a,a			;cabd
	jp z,0ffffh		;cabe
	xor b			;cac1
	jp z,00000h		;cac2
	dec sp			;cac5
	dec b			;cac6
	ld h,a			;cac7
	rst 38h			;cac8
	ld a,l			;cac9
	inc sp			;caca
	ld a,c			;cacb
	ld a,l			;cacc
	ld (hl),07ah		;cacd
	ld a,l			;cacf
	inc sp			;cad0
	ld a,h			;cad1
	ld sp,0827ch		;cad2
	ld a,l			;cad5
	inc sp			;cad6
	ld a,e			;cad7
	ld sp,07e7bh		;cad8
	ld a,l			;cadb
	inc sp			;cadc
	ld a,l			;cadd
	ld sp,0867dh		;cade
	rst 38h			;cae1
	rst 38h			;cae2
	rst 38h			;cae3
	push bc			;cae4
	jp z,0ffffh		;cae5
	ret			;cae8
	jp z,00000h		;cae9
	ld a,l			;caec
	ld a,c			;caed
	ld a,(hl)			;caee
	ld a,l			;caef
	ld a,d			;caf0
	ld a,a			;caf1
	ld a,l			;caf2
	ld a,h			;caf3
	add a,c			;caf4
	ld a,l			;caf5
	ld a,e			;caf6
	add a,b			;caf7
	ld a,l			;caf8
	ld a,l			;caf9
	add a,d			;cafa
	rst 38h			;cafb
	rst 38h			;cafc
	rst 38h			;cafd
	call pe,000cah		;cafe
	nop			;cb01
	cp b			;cb02
	ld a,c			;cb03
	ld d,b			;cb04
	ld a,c			;cb05
	ld a,(hl)			;cb06
	ld (hl),h			;cb07
	inc bc			;cb08
	rst 38h			;cb09
	ld (hl),082h		;cb0a
	ld a,(03603h)		;cb0c
	add a,e			;cb0f
	ld (hl),h			;cb10
	ld bc,036ffh		;cb11
	add a,h			;cb14
	rst 38h			;cb15
	ld (hl),085h		;cb16
	ld c,e			;cb18
	ld a,(bc)			;cb19
	ld (hl),033h		;cb1a
	ld d,0ffh		;cb1c
	adc a,e			;cb1e
	ld a,e			;cb1f
	ld (hl),081h		;cb20
	ld d,0ffh		;cb22
	dec c			;cb24
	ld a,(hl)			;cb25
	rst 38h			;cb26
	or b			;cb27
	ld a,e			;cb28
	ld (hl),080h		;cb29
	ld (hl),087h		;cb2b
	inc (hl)			;cb2d
	ld d,0ffh		;cb2e
	cp b			;cb30
	ld a,(hl)			;cb31
	rst 38h			;cb32
	adc a,h			;cb33
	add a,b			;cb34
	defb 0fdh,081h,002h	;illegal sequence		;cb35
	ld (hl),07dh		;cb38
	cp b			;cb3a
	ld (bc),a			;cb3b
	ld (hl),065h		;cb3c
	ld d,0ffh		;cb3e
	defb 0fdh,082h,002h	;illegal sequence		;cb40
	call z,00280h		;cb43
	ld (hl),07eh		;cb46
	ld c,e			;cb48
	ld a,(bc)			;cb49
	ld (hl),033h		;cb4a
	ld d,0ffh		;cb4c
	defb 0fdh,07ch	;ld a,iyh		;cb4e
	ld (bc),a			;cb50
	cp 081h		;cb51
	ld (bc),a			;cb53
	defb 0fdh,07bh,003h	;illegal sequence		;cb54
	defb 0fdh,082h,004h	;illegal sequence		;cb57
	ret z			;cb5a
	add a,b			;cb5b
	inc b			;cb5c
	ld (hl),c			;cb5d
	inc b			;cb5e
	inc bc			;cb5f
	cp 080h		;cb60
	inc b			;cb62
	ld c,b			;cb63
	inc b			;cb64
	inc bc			;cb65
	cp 07bh		;cb66
	inc bc			;cb68
	ld a,l			;cb69
	ld a,(hl)			;cb6a
	inc sp			;cb6b
	ld (hl),07fh		;cb6c
	ld a,l			;cb6e
	ld a,c			;cb6f
	inc sp			;cb70
	ld (hl),065h		;cb71
	ld d,0ffh		;cb73
	cp 080h		;cb75
	inc bc			;cb77
	or b			;cb78
	ld a,e			;cb79
	ld a,l			;cb7a
	ld a,c			;cb7b
	inc sp			;cb7c
	ld (hl),080h		;cb7d
	ld a,l			;cb7f
	ld a,(hl)			;cb80
	inc sp			;cb81
	ld (hl),065h		;cb82
	rst 38h			;cb84
	rst 38h			;cb85
	rst 38h			;cb86
	ld (bc),a			;cb87
	set 7,a		;cb88
	rst 38h			;cb8a
	ld a,(bc)			;cb8b
	set 7,a		;cb8c
	rst 38h			;cb8e
	inc de			;cb8f
	set 7,a		;cb90
	rst 38h			;cb92
	ld d,0cbh		;cb93
	rst 38h			;cb95
	rst 38h			;cb96
	ld e,0cbh		;cb97
	rst 38h			;cb99
	rst 38h			;cb9a
	inc h			;cb9b
	set 7,a		;cb9c
	rst 38h			;cb9e
	jr nc,$-51		;cb9f
	rst 38h			;cba1
	rst 38h			;cba2
	inc sp			;cba3
	set 7,a		;cba4
	rst 38h			;cba6
	ld b,b			;cba7
	set 7,a		;cba8
	rst 38h			;cbaa
	ld c,(hl)			;cbab
	set 7,a		;cbac
	rst 38h			;cbae
	ld (hl),l			;cbaf
	rlc b		;cbb0
	nop			;cbb2
	jr nc,$-1		;cbb3
	ld (hl),l			;cbb5
	rst 38h			;cbb6
	cpl			;cbb7
	defb 0fdh,04bh,00fh	;illegal sequence		;cbb8
	ld (hl),l			;cbbb
	rst 38h			;cbbc
	ld a,036h		;cbbd
	rrca			;cbbf
	ld d,0ffh		;cbc0
	add hl,de			;cbc2
	nop			;cbc3
	ld d,0ffh		;cbc4
	ccf			;cbc6
	rst 38h			;cbc7
	ld c,e			;cbc8
	rrca			;cbc9
	ld (hl),l			;cbca
	rst 38h			;cbcb
	ld h,a			;cbcc
	rst 38h			;cbcd
	ld a,(de)			;cbce
	nop			;cbcf
	ld c,e			;cbd0
	rrca			;cbd1
	ld (hl),l			;cbd2
	rst 38h			;cbd3
	ld (hl),012h		;cbd4
	inc d			;cbd6
	dec d			;cbd7
	rst 38h			;cbd8
	ld d,0ffh		;cbd9
	ld (hl),050h		;cbdb
	ld (hl),051h		;cbdd
	cpl			;cbdf
	ld a,b			;cbe0
	ld d,0ffh		;cbe1
	ld (hl),050h		;cbe3
	ld (hl),052h		;cbe5
	cpl			;cbe7
	ld a,b			;cbe8
	ld d,0ffh		;cbe9
	ld c,e			;cbeb
	inc b			;cbec
	ld d,0ffh		;cbed
	dec bc			;cbef
	ld bc,00d07h		;cbf0
	ld (hl),00ah		;cbf3
	ld d,0ffh		;cbf5
	inc c			;cbf7
	ld bc,00936h		;cbf8
	ld c,d			;cbfb
	cp 0ffh		;cbfc
	rlca			;cbfe
	dec c			;cbff
	inc (hl)			;cc00
	ld d,0ffh		;cc01
	ld (hl),00bh		;cc03
	ld c,d			;cc05
	inc (iy+016h)		;cc06
	rst 38h			;cc09
	ld (hl),023h		;cc0a
	ld d,0ffh		;cc0c
	nop			;cc0e
	djnz $+40		;cc0f
	sbc a,b			;cc11
	ld d,0ffh		;cc12
	nop			;cc14
	djnz $+50		;cc15
	ld (bc),a			;cc17
	add hl,bc			;cc18
	ld a,(bc)			;cc19
	jr c,$+12		;cc1a
	ld c,e			;cc1c
	djnz $+117		;cc1d
	cpl			;cc1f
	ld (bc),a			;cc20
	ld h,091h		;cc21
	dec bc			;cc23
	rst 0			;cc24
	inc sp			;cc25
	rst 0			;cc26
	ld a,(bc)			;cc27
	rst 38h			;cc28
	nop			;cc29
	djnz $+13		;cc2a
	ld (bc),a			;cc2c
	ld h,092h		;cc2d
	rst 38h			;cc2f
	nop			;cc30
	djnz $+105		;cc31
	rst 38h			;cc33
	nop			;cc34
	inc de			;cc35
	inc h			;cc36
	inc bc			;cc37
	rst 38h			;cc38
	rst 38h			;cc39
	nop			;cc3a
	inc de			;cc3b
	add hl,bc			;cc3c
	ld a,(bc)			;cc3d
	jr c,$+12		;cc3e
	ld c,e			;cc40
	djnz $+117		;cc41
	ld h,091h		;cc43
	ld h,a			;cc45
	rst 38h			;cc46
	nop			;cc47
	inc de			;cc48
	ld h,092h		;cc49
	ld h,a			;cc4b
	rst 38h			;cc4c
	nop			;cc4d
	ld d,00dh		;cc4e
	cp (hl)			;cc50
	rst 38h			;cc51
	dec bc			;cc52
	jp z,0cb33h		;cc53
	ld (bc),a			;cc56
	cpl			;cc57
	ld (bc),a			;cc58
	ld c,e			;cc59
	rra			;cc5a
	ld (hl),l			;cc5b
	rst 38h			;cc5c
	nop			;cc5d
	ld d,00dh		;cc5e
	cp (hl)			;cc60
	rst 38h			;cc61
	ld e,(hl)			;cc62
	ld (bc),a			;cc63
	ld c,a			;cc64
	ld (bc),a			;cc65
	ld bc,0cb33h		;cc66
	inc bc			;cc69
	cpl			;cc6a
	ld (bc),a			;cc6b
	ld c,e			;cc6c
	rra			;cc6d
	ld (hl),l			;cc6e
	rst 38h			;cc6f
	nop			;cc70
	ld d,00dh		;cc71
	cp (hl)			;cc73
	rst 38h			;cc74
	rlca			;cc75
	dec c			;cc76
	add hl,bc			;cc77
	dec c			;cc78
	inc sp			;cc79
	rlc e		;cc7a
	cpl			;cc7c
	ld (bc),a			;cc7d
	ld c,e			;cc7e
	rra			;cc7f
	ld (hl),l			;cc80
	rst 38h			;cc81
	nop			;cc82
	ld d,00dh		;cc83
	cp (hl)			;cc85
	rst 38h			;cc86
	ld h,0b1h		;cc87
	dec d			;cc89
	rst 38h			;cc8a
	ld d,l			;cc8b
	cp 0ffh		;cc8c
	adc a,c			;cc8e
	inc sp			;cc8f
	add a,h			;cc90
	inc sp			;cc91
	ld (hl),031h		;cc92
	ld d,0ffh		;cc94
	adc a,c			;cc96
	inc sp			;cc97
	ld (hl),01ah		;cc98
	ld d,0ffh		;cc9a
	ld a,(0ab00h)		;cc9c
	inc sp			;cc9f
	ld (hl),073h		;cca0
	ld a,(03601h)		;cca2
	ld (hl),h			;cca5
	ld (hl),015h		;cca6
	dec h			;cca8
	ld bc,0ff75h		;cca9
	ld e,b			;ccac
	jr $+19		;ccad
	ld h,08ah		;ccaf
	ld d,0ffh		;ccb1
	nop			;ccb3
	dec de			;ccb4
	ld c,l			;ccb5
	inc d			;ccb6
	ld h,088h		;ccb7
	dec h			;ccb9
	inc de			;ccba
	inc l			;ccbb
	jr $+119		;ccbc
	rst 38h			;ccbe
	ld c,l			;ccbf
	inc d			;ccc0
	ld h,089h		;ccc1
	ld (hl),l			;ccc3
	rst 38h			;ccc4
	ld c,e			;ccc5
	inc de			;ccc6
	ld (hl),e			;ccc7
	ld h,a			;ccc8
	rst 38h			;ccc9
	adc a,c			;ccca
	ld a,c			;cccb
	add a,h			;cccc
	ld a,c			;cccd
	cp b			;ccce
	ld a,c			;cccf
	ld (hl),031h		;ccd0
	ld d,0ffh		;ccd2
	adc a,c			;ccd4
	ld a,c			;ccd5
	ld (hl),01ah		;ccd6
	ld d,0ffh		;ccd8
	adc a,e			;ccda
	ld a,e			;ccdb
	cp b			;ccdc
	ld a,c			;ccdd
	ld (hl),081h		;ccde
	ld d,0ffh		;cce0
	or d			;cce2
	ld a,e			;cce3
	ld bc,07cfdh		;cce4
	ld (bc),a			;cce7
	cp b			;cce8
	ld (bc),a			;cce9
	ld (hl),013h		;ccea
	ld a,(03601h)		;ccec
	ld (hl),h			;ccef
	ld (hl),015h		;ccf0
	dec h			;ccf2
	ld bc,0ff75h		;ccf3
	ld c,l			;ccf6
	inc d			;ccf7
	ld h,087h		;ccf8
	or b			;ccfa
	ld a,e			;ccfb
	ld d,0ffh		;ccfc
	ld b,l			;ccfe
	rst 38h			;ccff
	ex af,af'			;cd00
	add hl,bc			;cd01
	inc c			;cd02
	ret nz			;cd03
	jr nc,$-62		;cd04
	ld (hl),058h		;cd06
	ld (hl),057h		;cd08
	ld d,0ffh		;cd0a
	ld b,l			;cd0c
	dec (hl)			;cd0d
	dec b			;cd0e
	ld (bc),a			;cd0f
	ld (hl),01ah		;cd10
	ld d,0ffh		;cd12
	ld b,l			;cd14
	dec (hl)			;cd15
	ld c,e			;cd16
	inc e			;cd17
	ld (hl),d			;cd18
	dec bc			;cd19
	cp b			;cd1a
	cpl			;cd1b
	cp b			;cd1c
	ld h,082h		;cd1d
	rst 38h			;cd1f
	ld b,l			;cd20
	dec (hl)			;cd21
	ld d,0ffh		;cd22
	ld c,e			;cd24
	inc e			;cd25
	ld d,0ffh		;cd26
	ld b,l			;cd28
	rst 38h			;cd29
	ld c,e			;cd2a
	inc de			;cd2b
	ld (hl),d			;cd2c
	adc a,b			;cd2d
	ld a,c			;cd2e
	cpl			;cd2f
	ld a,(hl)			;cd30
	ld c,e			;cd31
	ld d,016h		;cd32
	rst 38h			;cd34
	rrca			;cd35
	inc l			;cd36
	rst 38h			;cd37
	ld c,e			;cd38
	ld (de),a			;cd39
	ld c,e			;cd3a
	inc de			;cd3b
	ld (hl),d			;cd3c
	add a,h			;cd3d
	ld a,c			;cd3e
	ld c,e			;cd3f
	dec d			;cd40
	ld h,h			;cd41
	ld c,e			;cd42
	inc de			;cd43
	ld (hl),d			;cd44
	add a,h			;cd45
	ld a,c			;cd46
	ld c,e			;cd47
	ld d,016h		;cd48
	rst 38h			;cd4a
	ld a,(03604h)		;cd4b
	ld a,(de)			;cd4e
	ld d,0ffh		;cd4f
	ld a,(03605h)		;cd51
	ld a,(de)			;cd54
	ld d,0ffh		;cd55
	ld c,a			;cd57
	inc sp			;cd58
	rst 38h			;cd59
	add a,h			;cd5a
	inc sp			;cd5b
	ld (hl),069h		;cd5c
	inc (hl)			;cd5e
	ld d,0ffh		;cd5f
	ld h,a			;cd61
	rst 38h			;cd62
	ld b,l			;cd63
	rst 38h			;cd64
	ld (hl),086h		;cd65
	inc (hl)			;cd67
	ld d,0ffh		;cd68
	ld b,l			;cd6a
	ld (hl),c			;cd6b
	nop			;cd6c
	ld sp,0bc0ch		;cd6d
	ld c,e			;cd70
	inc de			;cd71
	add a,h			;cd72
	ld a,c			;cd73
	adc a,e			;cd74
	ld a,e			;cd75
	defb 0fdh,07dh	;ld a,iyl		;cd76
	ld (bc),a			;cd78
	cp 07bh		;cd79
	ld (bc),a			;cd7b
	or e			;cd7c
	ld a,h			;cd7d
	daa			;cd7e
	ld c,l			;cd7f
	adc a,a			;cd80
	jr c,$+41		;cd81
	ld (hl),065h		;cd83
	ld d,0ffh		;cd85
	ld b,l			;cd87
	ld l,a			;cd88
	adc a,b			;cd89
	inc sp			;cd8a
	nop			;cd8b
	ld e,026h		;cd8c
	dec hl			;cd8e
	ld d,0ffh		;cd8f
	ld b,l			;cd91
	ld l,a			;cd92
	adc a,b			;cd93
	inc sp			;cd94
	nop			;cd95
	inc sp			;cd96
	ld h,02bh		;cd97
	ld d,0ffh		;cd99
	ld c,e			;cd9b
	inc de			;cd9c
	ld (hl),d			;cd9d
	add a,h			;cd9e
	ld a,c			;cd9f
	ld c,e			;cda0
	dec d			;cda1
	ld c,e			;cda2
	ld (de),a			;cda3
	ld c,e			;cda4
	inc de			;cda5
	ld (hl),d			;cda6
	add a,h			;cda7
	ld a,c			;cda8
	ld c,e			;cda9
	ld d,016h		;cdaa
	rst 38h			;cdac
	ld a,(03604h)		;cdad
	ld a,(de)			;cdb0
	ld d,0ffh		;cdb1
	ld a,(03605h)		;cdb3
	ld a,(de)			;cdb6
	ld d,0ffh		;cdb7
	ld c,a			;cdb9
	inc sp			;cdba
	rst 38h			;cdbb
	ld c,a			;cdbc
	inc sp			;cdbd
	add hl,bc			;cdbe
	ld (hl),069h		;cdbf
	inc (hl)			;cdc1
	ld d,0ffh		;cdc2
	ld h,a			;cdc4
	rst 38h			;cdc5
	ld bc,07416h		;cdc6
	ex af,af'			;cdc9
	rst 38h			;cdca
	nop			;cdcb
	ld d,026h		;cdcc
	xor l			;cdce
	ld d,0ffh		;cdcf
	ld c,022h		;cdd1
	sub (hl)			;cdd3
	rrca			;cdd4
	ld (074a1h),hl		;cdd5
	ld bc,074ffh		;cdd8
	dec b			;cddb
	rst 38h			;cddc
	ld c,02ch		;cddd
	sub (hl)			;cddf
	rrca			;cde0
	inc l			;cde1
	and c			;cde2
	ld (hl),h			;cde3
	ld bc,026ffh		;cde4
	xor l			;cde7
	ld d,0ffh		;cde8
	ld (09722h),a		;cdea
	ld (0972ch),a		;cded
	ld c,h			;cdf0
	ld (04cb3h),hl		;cdf1
	inc l			;cdf4
	or h			;cdf5
	dec c			;cdf6
	cp (hl)			;cdf7
	ld (bc),a			;cdf8
	cpl			;cdf9
	cp (hl)			;cdfa
	ld h,0afh		;cdfb
	ld d,0ffh		;cdfd
	ld c,h			;cdff
	ld (04cb3h),hl		;ce00
	inc l			;ce03
	or h			;ce04
	dec c			;ce05
	cp (hl)			;ce06
	rst 38h			;ce07
	ld (hl),04ch		;ce08
	ld d,0ffh		;ce0a
	ld h,0aeh		;ce0c
	ld d,0ffh		;ce0e
	ld c,e			;ce10
	dec de			;ce11
	rst 38h			;ce12
	dec c			;ce13
	cp (hl)			;ce14
	rst 38h			;ce15
	inc sp			;ce16
	cp (hl)			;ce17
	ld (bc),a			;ce18
	ld h,0b0h		;ce19
	ld d,0ffh		;ce1b
	ld c,e			;ce1d
	dec de			;ce1e
	rst 38h			;ce1f
	ld d,l			;ce20
	cp 0ffh		;ce21
	jr nz,$+24		;ce23
	rst 38h			;ce25
	ld d,l			;ce26
	defb 0fdh,0ffh,022h	;illegal sequence		;ce27
	ld d,0ffh		;ce2a
	ld d,l			;ce2c
	cp 0ffh		;ce2d
	ld hl,016ffh		;ce2f
	rst 38h			;ce32
	ld b,l			;ce33
	sub (hl)			;ce34
	ex af,af'			;ce35
	dec h			;ce36
	ld c,l			;ce37
	xor b			;ce38
	nop			;ce39
	ld d,04dh		;ce3a
	xor d			;ce3c
	inc sp			;ce3d
	ld (bc),a			;ce3e
	xor e			;ce3f
	dec bc			;ce40
	cp (hl)			;ce41
	inc sp			;ce42
	ld (bc),a			;ce43
	xor h			;ce44
	inc sp			;ce45
	cp (hl)			;ce46
	ld (bc),a			;ce47
	rst 38h			;ce48
	ld b,l			;ce49
	sub (hl)			;ce4a
	ex af,af'			;ce4b
	dec h			;ce4c
	nop			;ce4d
	ld d,0cdh		;ce4e
	ld (bc),a			;ce50
	ld (hl),033h		;ce51
	ld d,0ffh		;ce53
	ld c,e			;ce55
	ld de,01985h		;ce56
	ld (hl),01ah		;ce59
	ld e,h			;ce5b
	ld d,0ffh		;ce5c
	ld c,h			;ce5e
	inc sp			;ce5f
	add hl,de			;ce60
	ld h,a			;ce61
	rst 38h			;ce62
	dec bc			;ce63
	ld a,(de)			;ce64
	ld e,h			;ce65
	ld h,a			;ce66
	rst 38h			;ce67
	ld b,l			;ce68
	dec (hl)			;ce69
	dec bc			;ce6a
	cp b			;ce6b
	jr c,$+4		;ce6c
	ld (hl),068h		;ce6e
	ld c,e			;ce70
	ld a,(bc)			;ce71
	ld (hl),033h		;ce72
	ld d,0ffh		;ce74
	ld d,l			;ce76
	cp 0ffh		;ce77
	adc a,c			;ce79
	inc sp			;ce7a
	ld (hl),01ch		;ce7b
	ld d,0ffh		;ce7d
	dec sp			;ce7f
	ld b,03ah		;ce80
	sbc a,d			;ce82
	ld (hl),06eh		;ce83
	cp b			;ce85
	add hl,de			;ce86
	ld (hl),065h		;ce87
	ld d,0ffh		;ce89
	ld (hl),06eh		;ce8b
	cp b			;ce8d
	add hl,de			;ce8e
	ld (hl),065h		;ce8f
	ld d,0ffh		;ce91
	ld c,a			;ce93
	add hl,de			;ce94
	inc bc			;ce95
	ld c,a			;ce96
	add hl,de			;ce97
	inc b			;ce98
	ld c,a			;ce99
	add hl,de			;ce9a
	ld bc,00174h		;ce9b
	rst 38h			;ce9e
	ld c,e			;ce9f
	ld de,0184fh		;cea0
	inc a			;cea3
	ld (hl),06eh		;cea4
	cp b			;cea6
	add hl,de			;cea7
	ld (hl),065h		;cea8
	ld d,0ffh		;ceaa
	ld b,l			;ceac
	inc sp			;cead
	ret pe			;ceae
	add hl,de			;ceaf
	ld c,e			;ceb0
	dec e			;ceb1
	ld d,0ffh		;ceb2
	ret pe			;ceb4
	add hl,de			;ceb5
	ld d,0ffh		;ceb6
	ld c,e			;ceb8
	ld de,01a0bh		;ceb9
	ld e,h			;cebc
	ld h,a			;cebd
	rst 38h			;cebe
	add a,l			;cebf
	add hl,de			;cec0
	ld (hl),01ah		;cec1
	ld e,h			;cec3
	ld d,0ffh		;cec4
	ld b,l			;cec6
	dec (hl)			;cec7
	dec bc			;cec8
	cp b			;cec9
	jr c,$+4		;ceca
	ld (hl),068h		;cecc
	ld c,e			;cece
	ld a,(bc)			;cecf
	ld (hl),033h		;ced0
	ld d,0ffh		;ced2
	push de			;ced4
	add hl,de			;ced5
	rst 38h			;ced6
	jp (hl)			;ced7
	add hl,de			;ced8
	ld d,0ffh		;ced9
	ld c,e			;cedb
	djnz $+116		;cedc
	xor h			;cede
	inc sp			;cedf
	cp b			;cee0
	inc sp			;cee1
	rst 38h			;cee2
	nop			;cee3
	djnz $+57		;cee4
	ld a,(bc)			;cee6
	ld de,00a2ch		;cee7
	rst 38h			;ceea
	nop			;ceeb
	scf			;ceec
	scf			;ceed
	dec d			;ceee
	call m,01637h		;ceef
	call m,0152ch		;cef2
	ld (hl),h			;cef5
	dec bc			;cef6
	rst 38h			;cef7
	nop			;cef8
	scf			;cef9
	dec b			;cefa
	dec d			;cefb
	ld (hl),063h		;cefc
	ld d,0ffh		;cefe
	ld d,l			;cf00
	rst 38h			;cf01
	rst 38h			;cf02
	ld a,(0360fh)		;cf03
	ld h,b			;cf06
	ld d,0ffh		;cf07
	inc b			;cf09
	dec e			;cf0a
	ld (hl),h			;cf0b
	rlca			;cf0c
	rst 38h			;cf0d
	nop			;cf0e
	ld (de),a			;cf0f
	ld b,l			;cf10
	ld e,h			;cf11
	ex af,af'			;cf12
	rla			;cf13
	ld a,l			;cf14
	ld (hl),002h		;cf15
	inc l			;cf17
	dec e			;cf18
	ld c,a			;cf19
	ld (bc),a			;cf1a
	call m,00250h		;cf1b
	ld h,0e6h		;cf1e
	ld (bc),a			;cf20
	ld (hl),063h		;cf21
	ld d,0ffh		;cf23
	nop			;cf25
	ld (de),a			;cf26
	ld c,a			;cf27
	inc l			;cf28
	ld e,h			;cf29
	ld (hl),061h		;cf2a
	ld d,0ffh		;cf2c
	nop			;cf2e
	ld (de),a			;cf2f
	ld a,l			;cf30
	ld (hl),002h		;cf31
	inc l			;cf33
	inc d			;cf34
	ld c,a			;cf35
	ld (bc),a			;cf36
	call m,00250h		;cf37
	ld h,0e6h		;cf3a
	ld (bc),a			;cf3c
	ld (hl),063h		;cf3d
	ld d,0ffh		;cf3f
	inc b			;cf41
	nop			;cf42
	ld h,09eh		;cf43
	ld d,0ffh		;cf45
	nop			;cf47
	ld hl,(00a3ah)		;cf48
	ld a,l			;cf4b
	ld (hl),002h		;cf4c
	xor h			;cf4e
	inc sp			;cf4f
	ld c,a			;cf50
	ld (bc),a			;cf51
	call m,00250h		;cf52
	ld h,0e6h		;cf55
	ld (bc),a			;cf57
	ld (hl),063h		;cf58
	ld d,0ffh		;cf5a
	nop			;cf5c
	ld hl,(01a37h)		;cf5d
	call m,01b37h		;cf60
	call m,00174h		;cf63
	rst 38h			;cf66
	nop			;cf67
	ld hl,(01a05h)		;cf68
	ld (hl),063h		;cf6b
	dec hl			;cf6d
	add hl,de			;cf6e
	ld d,0ffh		;cf6f
	rra			;cf71
	ld d,0ffh		;cf72
	add a,h			;cf74
	inc sp			;cf75
	ld (hl),06ah		;cf76
	ld d,0ffh		;cf78
	ld c,a			;cf7a
	dec hl			;cf7b
	inc bc			;cf7c
	ld (hl),h			;cf7d
	ld c,0ffh		;cf7e
	adc a,c			;cf80
	inc sp			;cf81
	ld h,a			;cf82
	rst 38h			;cf83
	dec sp			;cf84
	dec bc			;cf85
	ld (hl),h			;cf86
	inc b			;cf87
	rst 38h			;cf88
	ld bc,0362ch		;cf89
	and a			;cf8c
	ld a,l			;cf8d
	inc sp			;cf8e
	ld (bc),a			;cf8f
	ld (01102h),a		;cf90
	ld sp,0a802h		;cf93
	or (hl)			;cf96
	ld (bc),a			;cf97
	ld (hl),033h		;cf98
	ld d,0ffh		;cf9a
	ld h,054h		;cf9c
	ld c,l			;cf9e
	ld d,l			;cf9f
	dec c			;cfa0
	inc sp			;cfa1
	ld de,0574dh		;cfa2
	ld h,05ch		;cfa5
	ld h,056h		;cfa7
	ld h,063h		;cfa9
	ld d,0ffh		;cfab
	ld c,l			;cfad
	ld d,a			;cfae
	ld c,l			;cfaf
	ld e,(hl)			;cfb0
	ld (hl),033h		;cfb1
	ld h,056h		;cfb3
	ld c,l			;cfb5
	ld d,l			;cfb6
	ld c,l			;cfb7
	ld e,d			;cfb8
	ld c,l			;cfb9
	ld h,c			;cfba
	ld c,l			;cfbb
	ld e,(hl)			;cfbc
	ld h,05fh		;cfbd
	ld d,0ffh		;cfbf
	ld c,l			;cfc1
	ld e,c			;cfc2
	ld h,064h		;cfc3
	ld h,056h		;cfc5
	ld c,l			;cfc7
	ld d,l			;cfc8
	ld c,l			;cfc9
	ld e,d			;cfca
	ld c,l			;cfcb
	ld h,c			;cfcc
	ld h,062h		;cfcd
	ld d,0ffh		;cfcf
	ld bc,02629h		;cfd1
	and e			;cfd4
	ld d,0ffh		;cfd5
	ld c,02ch		;cfd7
	ex af,af'			;cfd9
	ld h,0a4h		;cfda
	ld d,0ffh		;cfdc
	ld b,l			;cfde
	ld bc,0ab36h		;cfdf
	ld (hl),0ach		;cfe2
	ld (hl),0adh		;cfe4
	ld (hl),030h		;cfe6
	dec c			;cfe8
	or e			;cfe9
	rst 38h			;cfea
	inc sp			;cfeb
	ld (bc),a			;cfec
	add hl,bc			;cfed
	ld c,e			;cfee
	ld hl,0037dh		;cfef
	or e			;cff2
	rst 38h			;cff3
	ld b,l			;cff4
	ld bc,0a74dh		;cff5
	ld c,l			;cff8
	and l			;cff9
	inc sp			;cffa
	inc bc			;cffb
	or l			;cffc
	ld b,a			;cffd
	or e			;cffe
	inc bc			;cfff
	or (hl)			;d000
	inc bc			;d001
	ld (hl),033h		;d002
	ld d,0ffh		;d004
	ld b,l			;d006
	rlca			;d007
	ld (hl),0abh		;d008
	ld (hl),0ach		;d00a
	ld (hl),0b3h		;d00c
	scf			;d00e
	nop			;d00f
	inc b			;d010
	dec c			;d011
	or h			;d012
	rst 38h			;d013
	inc sp			;d014
	ld (bc),a			;d015
	add hl,bc			;d016
	ld c,e			;d017
	ld hl,0037dh		;d018
	or h			;d01b
	rst 38h			;d01c
	ld b,l			;d01d
	rlca			;d01e
	ld (hl),033h		;d01f
	ld c,l			;d021
	and a			;d022
	scf			;d023
	nop			;d024
	inc b			;d025
	ld c,l			;d026
	and l			;d027
	inc sp			;d028
	inc bc			;d029
	or l			;d02a
	ld b,a			;d02b
	or h			;d02c
	inc bc			;d02d
	or (hl)			;d02e
	inc bc			;d02f
	ld (hl),033h		;d030
	ld d,0ffh		;d032
	ld b,l			;d034
	rlca			;d035
	ld h,0a6h		;d036
	ld d,0ffh		;d038
	cpl			;d03a
	cp l			;d03b
	inc h			;d03c
	inc l			;d03d
	xor l			;d03e
	rst 38h			;d03f
	ld b,h			;d040
	ld (bc),a			;d041
	inc h			;d042
	inc l			;d043
	rst 38h			;d044
	rst 38h			;d045
	ld (hl),l			;d046
	rst 38h			;d047
	ld (hl),032h		;d048
	ld d,0ffh		;d04a
	ld b,h			;d04c
	ld (bc),a			;d04d
	add a,l			;d04e
	inc sp			;d04f
	ld (hl),01ah		;d050
	ld d,0ffh		;d052
	ld b,h			;d054
	ld (bc),a			;d055
	ld a,(04b1fh)		;d056
	dec bc			;d059
	inc (hl)			;d05a
	ld d,0ffh		;d05b
	ld b,h			;d05d
	ld (bc),a			;d05e
	ld a,(04b05h)		;d05f
	inc c			;d062
	inc (hl)			;d063
	ld d,0ffh		;d064
	add a,l			;d066
	inc sp			;d067
	ld a,(03a09h)		;d068
	inc b			;d06b
	ld c,e			;d06c
	inc de			;d06d
	ld (hl),d			;d06e
	add a,h			;d06f
	ld a,c			;d070
	ld (hl),h			;d071
	ld bc,085ffh		;d072
	inc sp			;d075
	ld a,(04b09h)		;d076
	djnz $+117		;d079
	ld a,l			;d07b
	ld (0242ch),hl		;d07c
	inc l			;d07f
	adc a,h			;d080
	ld h,h			;d081
	rst 38h			;d082
	nop			;d083
	ld (de),a			;d084
	ld b,l			;d085
	ld e,b			;d086
	ld h,02ch		;d087
	ld d,0ffh		;d089
	nop			;d08b
	ld (de),a			;d08c
	ld b,l			;d08d
	halt			;d08e
	ld c,l			;d08f
	dec (hl)			;d090
	ld (hl),033h		;d091
	ld d,0ffh		;d093
	nop			;d095
	ld (de),a			;d096
	ld (hl),070h		;d097
	ld d,0ffh		;d099
	nop			;d09b
	ld (de),a			;d09c
	ld c,l			;d09d
	ld e,036h		;d09e
	inc sp			;d0a0
	ld d,0ffh		;d0a1
	nop			;d0a3
	ld hl,(06145h)		;d0a4
	ld h,02fh		;d0a7
	ld d,0ffh		;d0a9
	nop			;d0ab
	ld hl,(07036h)		;d0ac
	ld d,0ffh		;d0af
	nop			;d0b1
	ld e,036h		;d0b2
	inc sp			;d0b4
	ld d,0ffh		;d0b5
	nop			;d0b7
	ld sp,0354dh		;d0b8
	inc c			;d0bb
	cp h			;d0bc
	ld c,l			;d0bd
	add hl,sp			;d0be
	rst 38h			;d0bf
	nop			;d0c0
	ld sp,03336h		;d0c1
	ld d,0ffh		;d0c4
	nop			;d0c6
	ld (0b60ch),a		;d0c7
	ld h,02eh		;d0ca
	ld d,0ffh		;d0cc
	nop			;d0ce
	ld sp,0bc0ch		;d0cf
	ld c,l			;d0d2
	jr z,$+56		;d0d3
	inc sp			;d0d5
	ld d,0ffh		;d0d6
	nop			;d0d8
	scf			;d0d9
	ld h,031h		;d0da
	ld d,0ffh		;d0dc
	nop			;d0de
	scf			;d0df
	ld c,l			;d0e0
	ld d,036h		;d0e1
	inc sp			;d0e3
	ld d,0ffh		;d0e4
	nop			;d0e6
	inc l			;d0e7
	scf			;d0e8
	nop			;d0e9
	inc b			;d0ea
	ld h,043h		;d0eb
	ld d,0ffh		;d0ed
	nop			;d0ef
	inc l			;d0f0
	ld h,042h		;d0f1
	ld d,0ffh		;d0f3
	nop			;d0f5
	ld (0b70bh),a		;d0f6
	ld h,032h		;d0f9
	ld d,0ffh		;d0fb
	nop			;d0fd
	ld (0334dh),a		;d0fe
	ld (hl),033h		;d101
	ld d,0ffh		;d103
	nop			;d105
	jr nc,$+40		;d106
	inc (hl)			;d108
	ld d,0ffh		;d109
	nop			;d10b
	jr nz,$+40		;d10c
	ld c,c			;d10e
	ld d,0ffh		;d10f
	nop			;d111
	djnz $+40		;d112
	ld a,016h		;d114
	rst 38h			;d116
	nop			;d117
	djnz $+57		;d118
	ld a,(bc)			;d11a
	ld de,00b4dh		;d11b
	ld (hl),033h		;d11e
	ld d,0ffh		;d120
	nop			;d122
	jr $+40		;d123
	scf			;d125
	ld d,0ffh		;d126
	nop			;d128
	djnz $+79		;d129
	inc a			;d12b
	scf			;d12c
	ld a,(bc)			;d12d
	ld de,03d4dh		;d12e
	rst 38h			;d131
	nop			;d132
	djnz $+54		;d133
	ld d,0ffh		;d135
	nop			;d137
	scf			;d138
	ld h,03ah		;d139
	ld d,0ffh		;d13b
	ld bc,07429h		;d13d
	rlca			;d140
	rst 38h			;d141
	ld c,02ch		;d142
	ex af,af'			;d144
	ld (hl),070h		;d145
	ld d,0ffh		;d147
	ld b,l			;d149
	ex af,af'			;d14a
	ld h,041h		;d14b
	ld d,0ffh		;d14d
	ld h,040h		;d14f
	ld d,0ffh		;d151
	ld c,02ch		;d153
	ex af,af'			;d155
	ld h,050h		;d156
	ld d,0ffh		;d158
	dec c			;d15a
	inc l			;d15b
	ex af,af'			;d15c
	ld (hl),0b4h		;d15d
	ld d,0ffh		;d15f
	ld (hl),0abh		;d161
	inc c			;d163
	cp l			;d164
	jr nc,$-65		;d165
	ld (hl),0ach		;d167
	rst 38h			;d169
	inc sp			;d16a
	ld (bc),a			;d16b
	xor h			;d16c
	ld b,a			;d16d
	inc l			;d16e
	ld (bc),a			;d16f
	or (hl)			;d170
	ld (bc),a			;d171
	ld (hl),033h		;d172
	ld d,0ffh		;d174
	nop			;d176
	ld d,026h		;d177
	ld d,d			;d179
	ld d,0ffh		;d17a
	nop			;d17c
	ld d,026h		;d17d
	ld b,h			;d17f
	ld d,0ffh		;d180
	nop			;d182
	ld d,026h		;d183
	ld b,l			;d185
	ld d,0ffh		;d186
	nop			;d188
	ld d,026h		;d189
	xor l			;d18b
	ld d,0ffh		;d18c
	nop			;d18e
	ld d,026h		;d18f
	ld d,c			;d191
	ld d,0ffh		;d192
	nop			;d194
	inc de			;d195
	ld h,046h		;d196
	ld d,0ffh		;d198
	nop			;d19a
	rra			;d19b
	ld h,046h		;d19c
	ld d,0ffh		;d19e
	nop			;d1a0
	jr nz,$+3		;d1a1
	ld hl,04726h		;d1a3
	ld d,0ffh		;d1a6
	nop			;d1a8
	jr nz,$+3		;d1a9
	ld hl,04826h		;d1ab
	ld d,0ffh		;d1ae
	nop			;d1b0
	dec h			;d1b1
	ld h,038h		;d1b2
	ld d,0ffh		;d1b4
	nop			;d1b6
	inc hl			;d1b7
	ld h,053h		;d1b8
	ld d,0ffh		;d1ba
	ld e,h			;d1bc
	nop			;d1bd
	inc l			;d1be
	ld (hl),l			;d1bf
	rst 38h			;d1c0
	ld c,e			;d1c1
	rlca			;d1c2
	ld (hl),e			;d1c3
	ld (hl),04dh		;d1c4
	rst 38h			;d1c6
	ld b,00dh		;d1c7
	nop			;d1c9
	inc e			;d1ca
	scf			;d1cb
	add hl,bc			;d1cc
	ld de,06626h		;d1cd
	inc l			;d1d0
	add hl,bc			;d1d1
	jr $+31		;d1d2
	ld (hl),l			;d1d4
	rst 38h			;d1d5
	ld b,00dh		;d1d6
	ld c,e			;d1d8
	ld e,026h		;d1d9
	ld h,(hl)			;d1db
	ld d,0ffh		;d1dc
	adc a,b			;d1de
	inc sp			;d1df
	rla			;d1e0
	rst 38h			;d1e1
	ld b,l			;d1e2
	ld h,a			;d1e3
	nop			;d1e4
	ld (02208h),a		;d1e5
	inc l			;d1e8
	ld (0b72fh),hl		;d1e9
	ld c,l			;d1ec
	sub b			;d1ed
	ld (hl),040h		;d1ee
	inc (hl)			;d1f0
	ld d,0ffh		;d1f1
	add a,h			;d1f3
	inc sp			;d1f4
	ld (hl),032h		;d1f5
	ld d,0ffh		;d1f7
	nop			;d1f9
	ld sp,01708h		;d1fa
	dec bc			;d1fd
	cp h			;d1fe
	cpl			;d1ff
	cp h			;d200
	ld h,08eh		;d201
	ld d,0ffh		;d203
	nop			;d205
	ld sp,0bc0ch		;d206
	ld (hl),04ch		;d209
	ld d,0ffh		;d20b
	ex af,af'			;d20d
	add hl,de			;d20e
	ld h,08bh		;d20f
	ld d,0ffh		;d211
	ex af,af'			;d213
	ld a,(de)			;d214
	ld h,08ch		;d215
	dec l			;d217
	dec de			;d218
	ld a,(de)			;d219
	ld d,0ffh		;d21a
	ex af,af'			;d21c
	inc e			;d21d
	ld h,0a1h		;d21e
	ld d,0ffh		;d220
	dec b			;d222
	inc e			;d223
	dec b			;d224
	nop			;d225
	jr c,$+2		;d226
	ld a,l			;d228
	inc sp			;d229
	inc b			;d22a
	jr c,$+2		;d22b
	ld c,e			;d22d
	djnz $-70		;d22e
	inc b			;d230
	ld h,09ch		;d231
	ld d,0ffh		;d233
	add a,l			;d235
	inc sp			;d236
	ld c,e			;d237
	djnz $+117		;d238
	ld (hl),01ah		;d23a
	ld d,0ffh		;d23c
	scf			;d23e
	jr nz,$+4		;d23f
	ld (hl),01ah		;d241
	ld d,0ffh		;d243
	ld e,b			;d245
	nop			;d246
	call m,04c36h		;d247
	ld d,0ffh		;d24a
	ld h,09dh		;d24c
	dec l			;d24e
	jr nz,$+2		;d24f
	ex af,af'			;d251
	nop			;d252
	ld h,09eh		;d253
	jr c,$+34		;d255
	inc l			;d257
	nop			;d258
	rst 38h			;d259
	scf			;d25a
	nop			;d25b
	inc b			;d25c
	ld c,l			;d25d
	and d			;d25e
	ld (hl),033h		;d25f
	ld d,0ffh		;d261
	ld d,0ffh		;d263
	ld h,08dh		;d265
	dec hl			;d267
	dec de			;d268
	ld d,0ffh		;d269
	ld (hl),032h		;d26b
	ld d,0ffh		;d26d
	add a,l			;d26f
	inc sp			;d270
	ld c,e			;d271
	djnz $+117		;d272
	ld (hl),01ah		;d274
	ld d,0ffh		;d276
	ld e,b			;d278
	nop			;d279
	call m,0202dh		;d27a
	nop			;d27d
	ld h,09fh		;d27e
	ld d,0ffh		;d280
	ld h,0a0h		;d282
	ld d,0ffh		;d284
	ld (hl),04ch		;d286
	ld d,0ffh		;d288
	ld b,l			;d28a
	ld h,l			;d28b
	nop			;d28c
	jr $+10		;d28d
	ld e,026h		;d28f
	sbc a,d			;d291
	dec l			;d292
	rra			;d293
	ld e,016h		;d294
	rst 38h			;d296
	ld b,l			;d297
	ld h,l			;d298
	ld (hl),01ah		;d299
	ld d,0ffh		;d29b
	ld l,0ffh		;d29d
	or e			;d29f
	sra a		;d2a0
	rst 38h			;d2a2
	or a			;d2a3
	bit 2,l		;d2a4
	or b			;d2a6
	cp l			;d2a7
	bit 2,l		;d2a8
	rst 38h			;d2aa
	jp nz,056cbh		;d2ab
	or b			;d2ae
	add a,0cbh		;d2af
	ld d,(hl)			;d2b1
	or b			;d2b2
	call z,056cbh		;d2b3
	rst 38h			;d2b6
	adc a,0cbh		;d2b7
	dec hl			;d2b9
	rst 38h			;d2ba
	call nc,02bcbh		;d2bb
	rst 38h			;d2be
	exx			;d2bf
	defb 0cbh,032h	;sli d		;d2c0
	jr nc,$-35		;d2c2
	defb 0cbh,032h	;sli d		;d2c4
	ld b,0e3h		;d2c6
	defb 0cbh,032h	;sli d		;d2c8
	rst 38h			;d2ca
	ex de,hl			;d2cb
	sra c		;d2cc
	rst 38h			;d2ce
	rst 28h			;d2cf
	sra c		;d2d0
	rst 38h			;d2d2
	rst 30h			;d2d3
	sra c		;d2d4
	rst 38h			;d2d6
	cp 0cbh		;d2d7
	add hl,hl			;d2d9
	rst 38h			;d2da
	inc bc			;d2db
	call z,0ff28h		;d2dc
	ld a,(bc)			;d2df
	call z,0ff03h		;d2e0
	ld c,0cch		;d2e3
	inc b			;d2e5
	rst 38h			;d2e6
	inc d			;d2e7
	call z,0ff04h		;d2e8
	add hl,hl			;d2eb
	call z,0ff04h		;d2ec
	jr nc,$-50		;d2ef
	inc c			;d2f1
	rst 38h			;d2f2
	inc (hl)			;d2f3
	call z,0ff03h		;d2f4
	ld a,(003cch)		;d2f7
	rst 38h			;d2fa
	ld b,a			;d2fb
	call z,0ff0ah		;d2fc
	ld c,l			;d2ff
	call z,0ff0ah		;d300
	ld e,l			;d303
	call z,0ff0ah		;d304
	ld (hl),b			;d307
	call z,0ff0ah		;d308
	add a,d			;d30b
	call z,03146h		;d30c
	adc a,e			;d30f
	call z,0ff46h		;d310
	adc a,(hl)			;d313
	call z,0ff46h		;d314
	sub (hl)			;d317
	call z,0ff46h		;d318
	sbc a,h			;d31b
	call z,06e46h		;d31c
	xor h			;d31f
	call z,06e46h		;d320
	or e			;d323
	call z,06e46h		;d324
	cp a			;d327
	call z,0ff45h		;d328
	push bc			;d32b
	call z,0ff45h		;d32c
	jp z,045cch		;d32f
	rst 38h			;d332
	call nc,045cch		;d333
	rst 38h			;d336
	jp c,045cch		;d337
	rst 38h			;d33a
	jp po,045cch		;d33b
	halt			;d33e
	or 0cch		;d33f
	jr c,$+117		;d341
	cp 0cch		;d343
	jr c,$+117		;d345
	inc c			;d347
	call 07338h		;d348
	inc d			;d34b
	call 07338h		;d34c
	jr nz,$-49		;d34f
	jr c,$+117		;d351
	inc h			;d353
	call 0ff36h		;d354
	jr z,$-49		;d357
	ld (hl),0ffh		;d359
	dec (hl)			;d35b
	call 0ff36h		;d35c
	ld c,e			;d35f
	call 0ff36h		;d360
	ld d,c			;d363
	call 0ff36h		;d364
	ld d,a			;d367
	call 0ff36h		;d368
	ld h,c			;d36b
	call 0ff37h		;d36c
	ld h,e			;d36f
	call 0ff37h		;d370
	ld l,d			;d373
	call 0ff37h		;d374
	add a,a			;d377
	call 0ff37h		;d378
	sub c			;d37b
	call 0ff37h		;d37c
	sbc a,e			;d37f
	call 0ff37h		;d380
	xor l			;d383
	call 0ff37h		;d384
	or e			;d387
	call 0ff37h		;d388
	cp c			;d38b
	call 0ff37h		;d38c
	call nz,05acdh		;d38f
	rst 38h			;d392
	add a,0cdh		;d393
	ld e,d			;d395
	and c			;d396
	set 1,l		;d397
	ld e,d			;d399
	rst 38h			;d39a
	pop de			;d39b
	call 0ff5ah		;d39c
	jp c,05acdh		;d39f
	rst 38h			;d3a2
	defb 0ddh,0cdh,05ah	;illegal sequence		;d3a3
	rst 38h			;d3a6
	and 0cdh		;d3a7
	ld e,d			;d3a9
	rst 38h			;d3aa
	jp pe,05acdh		;d3ab
	rst 38h			;d3ae
	rst 38h			;d3af
	call 0ff5ah		;d3b0
	inc c			;d3b3
	adc a,05ah		;d3b4
	rst 38h			;d3b6
	djnz $-48		;d3b7
	ld e,e			;d3b9
	and c			;d3ba
	inc de			;d3bb
	adc a,05bh		;d3bc
	rst 38h			;d3be
	dec e			;d3bf
	adc a,04ch		;d3c0
	ld sp,0ce20h		;d3c2
	ld c,h			;d3c5
	rst 38h			;d3c6
	inc hl			;d3c7
	adc a,048h		;d3c8
	ld sp,0ce26h		;d3ca
	ld c,b			;d3cd
	rst 38h			;d3ce
	add hl,hl			;d3cf
	adc a,047h		;d3d0
	ld sp,0ce2ch		;d3d2
	ld b,a			;d3d5
	rst 38h			;d3d6
	cpl			;d3d7
	adc a,047h		;d3d8
	rst 38h			;d3da
	ld sp,049ceh		;d3db
	ld l,e			;d3de
	inc sp			;d3df
	adc a,049h		;d3e0
	ld l,e			;d3e2
	ld c,c			;d3e3
	adc a,049h		;d3e4
	rst 38h			;d3e6
	ld d,l			;d3e7
	adc a,049h		;d3e8
	rst 38h			;d3ea
	ld e,(hl)			;d3eb
	adc a,049h		;d3ec
	rst 38h			;d3ee
	ld h,e			;d3ef
	adc a,049h		;d3f0
	rst 38h			;d3f2
	ld l,b			;d3f3
	adc a,049h		;d3f4
	ld sp,0ce76h		;d3f6
	ld c,c			;d3f9
	rst 38h			;d3fa
	ld a,c			;d3fb
	adc a,049h		;d3fc
	rst 38h			;d3fe
	ld a,a			;d3ff
	adc a,049h		;d400
	ld h,a			;d402
	adc a,e			;d403
	adc a,049h		;d404
	rst 38h			;d406
	sub e			;d407
	adc a,049h		;d408
	rst 38h			;d40a
	sbc a,a			;d40b
	adc a,049h		;d40c
	rst 38h			;d40e
	xor h			;d40f
	adc a,049h		;d410
	rst 38h			;d412
	or h			;d413
	adc a,04ah		;d414
	rst 38h			;d416
	cp b			;d417
	adc a,04ah		;d418
	rst 38h			;d41a
	cp a			;d41b
	adc a,04ah		;d41c
	rst 38h			;d41e
	add a,0ceh		;d41f
	ld c,d			;d421
	ld sp,0ced4h		;d422
	ld c,d			;d425
	rst 38h			;d426
	rst 10h			;d427
	adc a,04bh		;d428
	rst 38h			;d42a
	in a,(0ceh)		;d42b
	ld c,e			;d42d
	ld c,d			;d42e
	ex (sp),hl			;d42f
	adc a,04bh		;d430
	ld a,d			;d432
	ex de,hl			;d433
	adc a,04bh		;d434
	ld a,d			;d436
	ret m			;d437
	adc a,04bh		;d438
	ld sp,0cf00h		;d43a
	ld c,e			;d43d
	rst 38h			;d43e
	inc bc			;d43f
	rst 8			;d440
	ld c,e			;d441
	ld h,h			;d442
	add hl,bc			;d443
	rst 8			;d444
	ld c,e			;d445
	ld h,h			;d446
	ld c,0cfh		;d447
	ld c,e			;d449
	ld h,h			;d44a
	dec h			;d44b
	rst 8			;d44c
	ld c,e			;d44d
	ld e,b			;d44e
	ld l,0cfh		;d44f
	ld c,e			;d451
	ld (0cf41h),a		;d452
	ld c,e			;d455
	rst 38h			;d456
	ld b,a			;d457
	rst 8			;d458
	ld c,e			;d459
	ld h,c			;d45a
	ld e,h			;d45b
	rst 8			;d45c
	ld c,e			;d45d
	ld h,c			;d45e
	ld h,a			;d45f
	rst 8			;d460
	ld c,e			;d461
	rst 38h			;d462
	ld (hl),c			;d463
	rst 8			;d464
	ld d,c			;d465
	rst 38h			;d466
	ld (hl),h			;d467
	rst 8			;d468
	ld hl,(07affh)		;d469
	rst 8			;d46c
	ld hl,(080ffh)		;d46d
	rst 8			;d470
	ld hl,(084ffh)		;d471
	rst 8			;d474
	ld hl,(089ffh)		;d475
	rst 8			;d478
	ld hl,(09cffh)		;d479
	rst 8			;d47c
	ld hl,(0ad54h)		;d47d
	rst 8			;d480
	ld hl,(0c156h)		;d481
	rst 8			;d484
	ld hl,(0d179h)		;d485
	rst 8			;d488
	ld hl,(0d779h)		;d489
	rst 8			;d48c
	ld hl,(0de79h)		;d48d
	rst 8			;d490
	ld hl,(0f479h)		;d491
	rst 8			;d494
	ld hl,(00679h)		;d495
	ret nc			;d498
	ld hl,(01d79h)		;d499
	ret nc			;d49c
	ld hl,(03479h)		;d49d
	ret nc			;d4a0
	ld hl,(03a79h)		;d4a1
	ret nc			;d4a4
	ld hl,(040ffh)		;d4a5
	ret nc			;d4a8
	ld hl,(046ffh)		;d4a9
	ret nc			;d4ac
	inc l			;d4ad
	ld sp,0d048h		;d4ae
	inc l			;d4b1
	rst 38h			;d4b2
	ld c,h			;d4b3
	ret nc			;d4b4
	inc l			;d4b5
	rst 38h			;d4b6
	ld d,h			;d4b7
	ret nc			;d4b8
	inc l			;d4b9
	rst 38h			;d4ba
	ld e,l			;d4bb
	ret nc			;d4bc
	inc l			;d4bd
	rst 38h			;d4be
	ld h,(hl)			;d4bf
	ret nc			;d4c0
	inc l			;d4c1
	rst 38h			;d4c2
	ld (hl),h			;d4c3
	ret nc			;d4c4
	inc l			;d4c5
	adc a,h			;d4c6
	add a,e			;d4c7
	ret nc			;d4c8
	inc l			;d4c9
	adc a,h			;d4ca
	adc a,e			;d4cb
	ret nc			;d4cc
	inc l			;d4cd
	adc a,h			;d4ce
	sub l			;d4cf
	ret nc			;d4d0
	inc l			;d4d1
	ld h,h			;d4d2
	sbc a,e			;d4d3
	ret nc			;d4d4
	inc l			;d4d5
	adc a,h			;d4d6
	and e			;d4d7
	ret nc			;d4d8
	inc l			;d4d9
	adc a,h			;d4da
	xor e			;d4db
	ret nc			;d4dc
	inc l			;d4dd
	adc a,h			;d4de
	or c			;d4df
	ret nc			;d4e0
	inc l			;d4e1
	adc a,h			;d4e2
	or a			;d4e3
	ret nc			;d4e4
	inc l			;d4e5
	adc a,h			;d4e6
	ret nz			;d4e7
	ret nc			;d4e8
	inc l			;d4e9
	adc a,h			;d4ea
	add a,0d0h		;d4eb
	inc l			;d4ed
	ld (hl),c			;d4ee
	adc a,0d0h		;d4ef
	inc l			;d4f1
	adc a,a			;d4f2
	ret c			;d4f3
	ret nc			;d4f4
	inc l			;d4f5
	ld a,d			;d4f6
	sbc a,0d0h		;d4f7
	inc l			;d4f9
	sub h			;d4fa
	and 0d0h		;d4fb
	inc l			;d4fd
	sub h			;d4fe
	rst 28h			;d4ff
	ret nc			;d500
	inc l			;d501
	adc a,l			;d502
	push af			;d503
	ret nc			;d504
	inc l			;d505
	adc a,l			;d506
	defb 0fdh,0d0h,02ch	;illegal sequence		;d507
	adc a,(hl)			;d50a
	dec b			;d50b
	pop de			;d50c
	inc l			;d50d
	adc a,(hl)			;d50e
	dec bc			;d50f
	pop de			;d510
	inc l			;d511
	sub d			;d512
	ld de,02cd1h		;d513
	ld c,d			;d516
	rla			;d517
	pop de			;d518
	inc l			;d519
	and d			;d51a
	ld (02cd1h),hl		;d51b
	sub c			;d51e
	jr z,$-45		;d51f
	inc l			;d521
	sub c			;d522
	ld (02cd1h),a		;d523
	sub c			;d526
	scf			;d527
	pop de			;d528
	inc l			;d529
	rst 38h			;d52a
	dec a			;d52b
	pop de			;d52c
	inc l			;d52d
	sub c			;d52e
	ld b,d			;d52f
	pop de			;d530
	inc l			;d531
	sub c			;d532
	ld c,c			;d533
	pop de			;d534
	inc l			;d535
	sub c			;d536
	ld c,a			;d537
	pop de			;d538
	inc l			;d539
	xor l			;d53a
	ld d,e			;d53b
	pop de			;d53c
	inc l			;d53d
	xor l			;d53e
	ld e,d			;d53f
	pop de			;d540
	inc l			;d541
	xor l			;d542
	ld h,c			;d543
	pop de			;d544
	inc l			;d545
	xor l			;d546
	ld l,d			;d547
	pop de			;d548
	inc l			;d549
	sub c			;d54a
	halt			;d54b
	pop de			;d54c
	inc l			;d54d
	sub l			;d54e
	ld a,h			;d54f
	pop de			;d550
	inc l			;d551
	sub (hl)			;d552
	add a,d			;d553
	pop de			;d554
	inc l			;d555
	and c			;d556
	adc a,b			;d557
	pop de			;d558
	inc l			;d559
	sub b			;d55a
	adc a,(hl)			;d55b
	pop de			;d55c
	inc l			;d55d
	xor e			;d55e
	sub h			;d55f
	pop de			;d560
	inc l			;d561
	xor e			;d562
	sbc a,d			;d563
	pop de			;d564
	inc l			;d565
	xor e			;d566
	and b			;d567
	pop de			;d568
	inc l			;d569
	xor e			;d56a
	xor b			;d56b
	pop de			;d56c
	inc l			;d56d
	xor (hl)			;d56e
	or b			;d56f
	pop de			;d570
	inc l			;d571
	xor h			;d572
	or (hl)			;d573
	pop de			;d574
	inc l			;d575
	and (hl)			;d576
	cp h			;d577
	pop de			;d578
	inc l			;d579
	rst 38h			;d57a
	pop bc			;d57b
	pop de			;d57c
	ld d,d			;d57d
	ld d,b			;d57e
	rst 0			;d57f
	pop de			;d580
	ld d,d			;d581
	ld d,b			;d582
	sub 0d1h		;d583
	ld d,d			;d585
	rst 38h			;d586
	sbc a,0d1h		;d587
	add hl,sp			;d589
	adc a,l			;d58a
	jp po,053d1h		;d58b
	rst 38h			;d58e
	di			;d58f
	pop de			;d590
	inc a			;d591
	adc a,h			;d592
	ld sp,hl			;d593
	pop de			;d594
	inc a			;d595
	adc a,h			;d596
	dec b			;d597
	jp nc,06257h		;d598
	dec c			;d59b
	jp nc,06257h		;d59c
	inc de			;d59f
	jp nc,0633eh		;d5a0
	inc e			;d5a3
	jp nc,0ff5dh		;d5a4
	ld (05dd2h),hl		;d5a7
	rst 38h			;d5aa
	dec (hl)			;d5ab
	jp nc,0325dh		;d5ac
	ld a,0d2h		;d5af
	ld e,l			;d5b1
	ld (0d245h),a		;d5b2
	ld e,l			;d5b5
	ld (0d24ch),a		;d5b6
	ld e,l			;d5b9
	ld (0d25ah),a		;d5ba
	ld e,l			;d5bd
	ld (0d263h),a		;d5be
	ld e,l			;d5c1
	ld h,d			;d5c2
	ld h,l			;d5c3
	jp nc,0ff5dh		;d5c4
	ld l,e			;d5c7
	jp nc,0ff5eh		;d5c8
	ld l,a			;d5cb
	jp nc,0325eh		;d5cc
	ld a,b			;d5cf
	jp nc,0635eh		;d5d0
	add a,d			;d5d3
	jp nc,0ff5eh		;d5d4
	add a,(hl)			;d5d7
	jp nc,0a23dh		;d5d8
	adc a,d			;d5db
	jp nc,0a23dh		;d5dc
	sub a			;d5df
	jp nc,00000h		;d5e0
	nop			;d5e3
	inc l			;d5e4
	scf			;d5e5
	nop			;d5e6
	inc b			;d5e7
	jr c,$+2		;d5e8
	ld (hl),030h		;d5ea
	ld c,l			;d5ec
	and d			;d5ed
	rst 38h			;d5ee
	nop			;d5ef
	ld (0b60ch),a		;d5f0
	ld c,l			;d5f3
	add a,c			;d5f4
	rst 38h			;d5f5
	nop			;d5f6
	ld (0b70ch),a		;d5f7
	ld (hl),030h		;d5fa
	ld c,l			;d5fc
	inc sp			;d5fd
	dec hl			;d5fe
	ld (02bffh),hl		;d5ff
	ld bc,0042bh		;d602
	dec hl			;d605
	inc bc			;d606
	ld (hl),030h		;d607
	inc a			;d609
	inc (hl)			;d60a
	ld l,001h		;d60b
	jr nc,$+48		;d60d
	inc b			;d60f
	inc l			;d610
	ld l,003h		;d611
	dec hl			;d613
	inc c			;d614
	ld a,b			;d615
	ld c,e			;d616
	inc b			;d617
	rst 38h			;d618
	nop			;d619
	ld (0b70ch),a		;d61a
	inc l			;d61d
	ld (001ffh),hl		;d61e
	ld d,00dh		;d621
	adc a,a			;d623
	ld a,a			;d624
	inc sp			;d625
	adc a,a			;d626
	ld (bc),a			;d627
	rst 38h			;d628
	ld bc,00116h		;d629
	dec e			;d62c
	ld bc,00137h		;d62d
	dec (hl)			;d630
	ld (hl),h			;d631
	ld bc,04fffh		;d632
	adc a,a			;d635
	ld a,a			;d636
	inc h			;d637
	ld d,d			;d638
	ld d,b			;d639
	nop			;d63a
	ld d,04fh		;d63b
	adc a,a			;d63d
	rst 38h			;d63e
	jr nc,$-56		;d63f
	rst 38h			;d641
	dec c			;d642
	jp z,00a01h		;d643
	ld (02701h),a		;d646
	cpl			;d649
	jp z,0cb33h		;d64a
	ld bc,0022fh		;d64d
	ld c,e			;d650
	rra			;d651
	ld (hl),l			;d652
	rst 38h			;d653
	dec bc			;d654
	add a,04bh		;d655
	ld e,0ffh		;d657
	rst 38h			;d659
	rst 38h			;d65a
	ex (sp),hl			;d65b
	push de			;d65c
	rst 38h			;d65d
	rst 38h			;d65e
	rst 28h			;d65f
	push de			;d660
	rst 38h			;d661
	rst 38h			;d662
	or 0d5h		;d663
	rst 38h			;d665
	rst 38h			;d666
	ld bc,0ffd6h		;d667
	rst 38h			;d66a
	add hl,de			;d66b
	sub 0ffh		;d66c
	rst 38h			;d66e
	jr nz,$-40		;d66f
	rst 38h			;d671
	rst 38h			;d672
	add hl,hl			;d673
	sub 0ffh		;d674
	rst 38h			;d676
	inc (hl)			;d677
	sub 0ffh		;d678
	rst 38h			;d67a
	ld b,d			;d67b
	sub 0ffh		;d67c
	rst 38h			;d67e
	ld d,h			;d67f
	sub 000h		;d680
	nop			;d682
	dec c			;d683
	adc a,a			;d684
	rst 38h			;d685
	dec c			;d686
	sub b			;d687
	rst 38h			;d688
	dec c			;d689
	sub c			;d68a
	rst 38h			;d68b
	dec c			;d68c
	sub d			;d68d
	rst 38h			;d68e
	dec c			;d68f
	sub e			;d690
	rst 38h			;d691
	dec c			;d692
	sub h			;d693
	rst 38h			;d694
	dec bc			;d695
	jp z,0ca33h		;d696
	ld bc,058ffh		;d699
	ld (03032h),hl		;d69c
	or a			;d69f
	rst 38h			;d6a0
	inc sp			;d6a1
	ld (bc),a			;d6a2
	ld c,030h		;d6a3
	inc sp			;d6a5
	ld (001c6h),a		;d6a6
	rst 38h			;d6a9
	or a			;d6aa
	ld (bc),a			;d6ab
	inc bc			;d6ac
	xor e			;d6ad
	ld (bc),a			;d6ae
	ld (hl),0a6h		;d6af
	ld sp,00333h		;d6b1
	xor (hl)			;d6b4
	inc sp			;d6b5
	inc bc			;d6b6
	ld (hl),065h		;d6b7
	rst 38h			;d6b9
	ld c,a			;d6ba
	ld (bc),a			;d6bb
	djnz $+51		;d6bc
	ld (bc),a			;d6be
	ld bc,0fe74h		;d6bf
	rst 38h			;d6c2
	nop			;d6c3
	ld (0b70ch),a		;d6c4
	dec bc			;d6c7
	or (hl)			;d6c8
	dec c			;d6c9
	sub d			;d6ca
	rst 38h			;d6cb
	ld h,080h		;d6cc
	cpl			;d6ce
	or (hl)			;d6cf
	rst 38h			;d6d0
	rrca			;d6d1
	ret			;d6d2
	jr z,$+51		;d6d3
	ret			;d6d5
	ld bc,000ffh		;d6d6
	daa			;d6d9
	ld e,(hl)			;d6da
	ld (bc),a			;d6db
	inc c			;d6dc
	ld (bc),a			;d6dd
	adc a,d			;d6de
	ret			;d6df
	jr nc,$-53		;d6e0
	dec b			;d6e2
	inc hl			;d6e3
	jr c,$+37		;d6e4
	ld c,e			;d6e6
	djnz $+117		;d6e7
	cpl			;d6e9
	ld (bc),a			;d6ea
	ld c,e			;d6eb
	rra			;d6ec
	inc sp			;d6ed
	ld (bc),a			;d6ee
	cp 033h		;d6ef
	inc bc			;d6f1
	add hl,de			;d6f2
	cpl			;d6f3
	inc b			;d6f4
	ld c,e			;d6f5
	jr nz,$+53		;d6f6
	ld (bc),a			;d6f8
	defb 0fdh,04bh,020h	;illegal sequence		;d6f9
	ld (hl),l			;d6fc
	rst 38h			;d6fd
	rst 38h			;d6fe
	rst 38h			;d6ff
	add a,e			;d700
	sub 0ffh		;d701
	rst 38h			;d703
	sbc a,e			;d704
	sub 0ffh		;d705
	rst 38h			;d707
	and c			;d708
	sub 0ffh		;d709
	rst 38h			;d70b
	xor d			;d70c
	sub 0ffh		;d70d
	rst 38h			;d70f
	cp d			;d710
	sub 0ffh		;d711
	rst 38h			;d713
	jp 0ffd6h		;d714
	rst 38h			;d717
	pop de			;d718
	sub 0ffh		;d719
	rst 38h			;d71b
	ret c			;d71c
	sub 000h		;d71d
	nop			;d71f
	nop			;d720
	ld (0b60bh),a		;d721
	ld d,0ffh		;d724
	nop			;d726
	ld d,04fh		;d727
	cp (hl)			;d729
	rst 38h			;d72a
	ld d,0ffh		;d72b
	ld a,(bc)			;d72d
	rst 38h			;d72e
	jr nz,$-39		;d72f
	ld a,(bc)			;d731
	rst 38h			;d732
	ld h,0d7h		;d733
	nop			;d735
	nop			;d736
	dec c			;d737
	inc sp			;d738
	rst 38h			;d739
	ld (hl),008h		;d73a
	ld d,0ffh		;d73c
	add a,l			;d73e
	inc sp			;d73f
	ld (hl),01ah		;d740
	ld d,0ffh		;d742
	dec bc			;d744
	cp b			;d745
	ld h,084h		;d746
	ld d,0ffh		;d748
	inc c			;d74a
	cp b			;d74b
	ld (hl),008h		;d74c
	ld d,0ffh		;d74e
	ld a,(0360ch)		;d750
	ld c,h			;d753
	ld d,0ffh		;d754
	rst 38h			;d756
	rst 38h			;d757
	scf			;d758
	rst 10h			;d759
	rst 38h			;d75a
	rst 38h			;d75b
	ld a,0d7h		;d75c
	ld e,d			;d75e
	dec (hl)			;d75f
	ld b,h			;d760
	rst 10h			;d761
	ld e,e			;d762
	dec (hl)			;d763
	ld c,d			;d764
	rst 10h			;d765
	rst 38h			;d766
	rst 38h			;d767
	ld d,b			;d768
	rst 10h			;d769
	nop			;d76a
	nop			;d76b
	inc sp			;d76c
	inc bc			;d76d
	add hl,bc			;d76e
	inc sp			;d76f
	inc b			;d770
	ret nz			;d771
	inc sp			;d772
	dec b			;d773
	ld d,(hl)			;d774
	rst 38h			;d775
	cp b			;d776
	inc bc			;d777
	adc a,c			;d778
	inc bc			;d779
	adc a,c			;d77a
	inc bc			;d77b
	ld (hl),031h		;d77c
	ld h,a			;d77e
	rst 38h			;d77f
	adc a,e			;d780
	inc b			;d781
	ld (hl),054h		;d782
	or (hl)			;d784
	dec b			;d785
	ld (hl),033h		;d786
	ld h,a			;d788
	rst 38h			;d789
	or d			;d78a
	inc b			;d78b
	ld bc,05336h		;d78c
	or (hl)			;d78f
	dec b			;d790
	ld (hl),057h		;d791
	rst 38h			;d793
	rst 38h			;d794
	rst 38h			;d795
	ld l,h			;d796
	rst 10h			;d797
	rst 38h			;d798
	rst 38h			;d799
	halt			;d79a
	rst 10h			;d79b
	rst 38h			;d79c
	rst 38h			;d79d
	add a,b			;d79e
	rst 10h			;d79f
	rst 38h			;d7a0
	rst 38h			;d7a1
	adc a,d			;d7a2
	rst 10h			;d7a3
	nop			;d7a4
	nop			;d7a5
	dec c			;d7a6
	inc sp			;d7a7
	jr $+49		;d7a8
	or l			;d7aa
	ld c,l			;d7ab
	add a,(hl)			;d7ac
	add hl,sp			;d7ad
	ld h,083h		;d7ae
	ld d,0ffh		;d7b0
	ld a,(03b0dh)		;d7b2
	dec b			;d7b5
	ld d,0ffh		;d7b6
	dec sp			;d7b8
	dec c			;d7b9
	ld h,085h		;d7ba
	xor e			;d7bc
	inc sp			;d7bd
	ld c,a			;d7be
	inc sp			;d7bf
	ex af,af'			;d7c0
	ld d,0ffh		;d7c1
	ld c,e			;d7c3
	inc d			;d7c4
	adc a,e			;d7c5
	ld a,e			;d7c6
	xor a			;d7c7
	ld a,h			;d7c8
	rst 38h			;d7c9
	ld a,l			;d7ca
	scf			;d7cb
	ld (bc),a			;d7cc
	ld (00102h),a		;d7cd
	jr nc,$+6		;d7d0
	adc a,l			;d7d2
	ld a,h			;d7d3
	daa			;d7d4
	inc sp			;d7d5
	inc b			;d7d6
	add hl,hl			;d7d7
	dec c			;d7d8
	ld a,c			;d7d9
	ex af,af'			;d7da
	dec bc			;d7db
	ld (bc),a			;d7dc
	inc sp			;d7dd
	inc b			;d7de
	inc h			;d7df
	rst 38h			;d7e0
	adc a,l			;d7e1
	ld a,h			;d7e2
	daa			;d7e3
	ld (hl),h			;d7e4
	inc b			;d7e5
	rst 38h			;d7e6
	ld (hl),a			;d7e7
	inc d			;d7e8
	dec b			;d7e9
	ld c,h			;d7ea
	ld a,c			;d7eb
	dec b			;d7ec
	inc sp			;d7ed
	inc b			;d7ee
	ld h,0ffh		;d7ef
	dec c			;d7f1
	ld a,c			;d7f2
	dec b			;d7f3
	ld (hl),a			;d7f4
	dec e			;d7f5
	dec b			;d7f6
	ld c,h			;d7f7
	ld a,c			;d7f8
	dec b			;d7f9
	inc sp			;d7fa
	inc b			;d7fb
	jr z,$+1		;d7fc
	ld (hl),a			;d7fe
	dec d			;d7ff
	inc bc			;d800
	ld c,h			;d801
	ld a,c			;d802
	inc bc			;d803
	inc sp			;d804
	inc b			;d805
	ld d,0ffh		;d806
	ld (hl),a			;d808
	add hl,de			;d809
	inc bc			;d80a
	ld c,h			;d80b
	ld a,c			;d80c
	inc bc			;d80d
	inc sp			;d80e
	inc b			;d80f
	ld a,(de)			;d810
	rst 38h			;d811
	jr nc,$+4		;d812
	or b			;d814
	ld a,e			;d815
	or b			;d816
	ld a,h			;d817
	rst 38h			;d818
	rst 30h			;d819
	ld (bc),a			;d81a
	inc bc			;d81b
	ld c,h			;d81c
	ld a,c			;d81d
	inc bc			;d81e
	xor e			;d81f
	ld (bc),a			;d820
	rst 38h			;d821
	ld c,a			;d822
	ld (bc),a			;d823
	add hl,hl			;d824
	ld sp,00102h		;d825
	ld (hl),h			;d828
	cp 0ffh		;d829
	dec c			;d82b
	inc b			;d82c
	inc h			;d82d
	ld l,024h		;d82e
	ld bc,01026h		;d830
	ld d,0ffh		;d833
	ld h,086h		;d835
	dec bc			;d837
	inc b			;d838
	ld d,0ffh		;d839
	cp b			;d83b
	inc b			;d83c
	dec sp			;d83d
	inc b			;d83e
	ld a,l			;d83f
	ld a,c			;d840
	inc b			;d841
	and 004h		;d842
	ld d,0ffh		;d844
	cp 07ch		;d846
	inc b			;d848
	defb 0fdh,07dh	;ld a,iyl		;d849
	inc b			;d84b
	cp 07bh		;d84c
	inc b			;d84e
	rst 38h			;d84f
	rst 38h			;d850
	rst 38h			;d851
	and (hl)			;d852
	rst 10h			;d853
	rst 38h			;d854
	rst 38h			;d855
	or d			;d856
	rst 10h			;d857
	rst 38h			;d858
	rst 38h			;d859
	cp b			;d85a
	rst 10h			;d85b
	rst 38h			;d85c
	rst 38h			;d85d
	jp 0ffd7h		;d85e
	rst 38h			;d861
	jp z,0ffd7h		;d862
	rst 38h			;d865
	pop hl			;d866
	rst 10h			;d867
	rst 38h			;d868
	rst 38h			;d869
	rst 20h			;d86a
	rst 10h			;d86b
	rst 38h			;d86c
	rst 38h			;d86d
	pop af			;d86e
	rst 10h			;d86f
	rst 38h			;d870
	rst 38h			;d871
	cp 0d7h		;d872
	rst 38h			;d874
	rst 38h			;d875
	ex af,af'			;d876
	ret c			;d877
	rst 38h			;d878
	rst 38h			;d879
	ld (de),a			;d87a
	ret c			;d87b
	rst 38h			;d87c
	rst 38h			;d87d
	add hl,de			;d87e
	ret c			;d87f
	rst 38h			;d880
	rst 38h			;d881
	ld (0ffd8h),hl		;d882
	rst 38h			;d885
	dec hl			;d886
	ret c			;d887
	rst 38h			;d888
	rst 38h			;d889
	dec (hl)			;d88a
	ret c			;d88b
	rst 38h			;d88c
	rst 38h			;d88d
	dec sp			;d88e
	ret c			;d88f
	rst 38h			;d890
	rst 38h			;d891
	ld b,(hl)			;d892
	ret c			;d893
	nop			;d894
	nop			;d895
	jr c,$+40		;d896
	ld c,e			;d898
	inc de			;d899
	ld (hl),e			;d89a
	jr nc,$+123		;d89b
	rst 38h			;d89d
	inc sp			;d89e
	ld (bc),a			;d89f
	adc a,a			;d8a0
	rst 38h			;d8a1
	ld a,l			;d8a2
	ld (bc),a			;d8a3
	inc bc			;d8a4
	ld sp,00603h		;d8a5
	adc a,e			;d8a8
	ld (bc),a			;d8a9
	defb 0fdh,003h,004h	;illegal sequence		;d8aa
	add a,b			;d8ad
	inc b			;d8ae
	dec bc			;d8af
	add a,04bh		;d8b0
	rra			;d8b2
	or c			;d8b3
	ld (bc),a			;d8b4
	ld bc,0ff75h		;d8b5
	ld sp,00c03h		;d8b8
	defb 0fdh,003h,003h	;illegal sequence		;d8bb
	ld a,l			;d8be
	ld (bc),a			;d8bf
	inc b			;d8c0
	ld sp,01804h		;d8c1
	defb 0fdh,004h,005h	;illegal sequence		;d8c4
	dec c			;d8c7
	dec b			;d8c8
	ld h,00ch		;d8c9
	ld a,c			;d8cb
	ld a,l			;d8cc
	ld a,c			;d8cd
	dec b			;d8ce
	rst 38h			;d8cf
	adc a,l			;d8d0
	ld (bc),a			;d8d1
	ld bc,00380h		;d8d2
	adc a,c			;d8d5
	dec b			;d8d6
	ld (00c04h),a		;d8d7
	ld c,e			;d8da
	rra			;d8db
	or c			;d8dc
	ld (bc),a			;d8dd
	ld bc,00374h		;d8de
	rst 38h			;d8e1
	adc a,h			;d8e2
	ld (bc),a			;d8e3
	adc a,a			;d8e4
	ld (bc),a			;d8e5
	rst 38h			;d8e6
	add a,b			;d8e7
	inc bc			;d8e8
	adc a,b			;d8e9
	dec b			;d8ea
	xor e			;d8eb
	dec b			;d8ec
	or e			;d8ed
	ld (bc),a			;d8ee
	ld (bc),a			;d8ef
	ld sp,00604h		;d8f0
	ld c,e			;d8f3
	rra			;d8f4
	xor a			;d8f5
	ld (bc),a			;d8f6
	ld (hl),h			;d8f7
	ld (bc),a			;d8f8
	rst 38h			;d8f9
	ld c,a			;d8fa
	ld (bc),a			;d8fb
	sub h			;d8fc
	ld sp,00102h		;d8fd
	ld (hl),h			;d900
	ei			;d901
	rst 38h			;d902
	ld d,0ffh		;d903
	defb 0fdh,004h,004h	;illegal sequence		;d905
	inc c			;d908
	inc b			;d909
	xor h			;d90a
	inc b			;d90b
	rst 38h			;d90c
	dec c			;d90d
	inc sp			;d90e
	ld (bc),a			;d90f
	ld h,(hl)			;d910
	inc sp			;d911
	rst 38h			;d912
	ld (hl),l			;d913
	rst 38h			;d914
	rst 38h			;d915
	rst 38h			;d916
	sub (hl)			;d917
	ret c			;d918
	rst 38h			;d919
	rst 38h			;d91a
	sbc a,(hl)			;d91b
	ret c			;d91c
	rst 38h			;d91d
	rst 38h			;d91e
	and d			;d91f
	ret c			;d920
	ld d,d			;d921
	ld d,b			;d922
	cp b			;d923
	ret c			;d924
	ld d,d			;d925
	ld d,b			;d926
	ret nc			;d927
	ret c			;d928
	ld d,d			;d929
	ld d,b			;d92a
	jp po,0ffd8h		;d92b
	rst 38h			;d92e
	jp m,0ffd8h		;d92f
	rst 38h			;d932
	inc bc			;d933
	exx			;d934
	rst 38h			;d935
	rst 38h			;d936
	dec b			;d937
	exx			;d938
	rst 38h			;d939
	rst 38h			;d93a
	dec c			;d93b
	exx			;d93c
	rst 38h			;d93d
	rst 38h			;d93e
	inc de			;d93f
	exx			;d940
	nop			;d941
	nop			;d942
	ld h,079h		;d943
	inc sp			;d945
	add a,01eh		;d946
	jr $+77		;d948
	rrca			;d94a
	rst 38h			;d94b
	ld (08f02h),a		;d94c
	ld a,l			;d94f
	ld (bc),a			;d950
	inc bc			;d951
	ld b,a			;d952
	ld (bc),a			;d953
	inc bc			;d954
	ld b,a			;d955
	ld (bc),a			;d956
	inc bc			;d957
	ld a,l			;d958
	ld (bc),a			;d959
	ld b,031h		;d95a
	ld (bc),a			;d95c
	adc a,a			;d95d
	ld sp,06703h		;d95e
	rst 0			;d961
	ld (bc),a			;d962
	inc bc			;d963
	ld sp,0c006h		;d964
	inc sp			;d967
	rlca			;d968
	ld l,08ch		;d969
	ld (bc),a			;d96b
	inc sp			;d96c
	rlca			;d96d
	jr nc,$+81		;d96e
	ld (bc),a			;d970
	sub d			;d971
	ld c,a			;d972
	ld (bc),a			;d973
	sub h			;d974
	ld (hl),h			;d975
	ld bc,08dffh		;d976
	ld (bc),a			;d979
	ld bc,00733h		;d97a
	ld l,0ffh		;d97d
	dec c			;d97f
	ld (bc),a			;d980
	sub b			;d981
	adc a,l			;d982
	ld (bc),a			;d983
	ld (bc),a			;d984
	dec bc			;d985
	or l			;d986
	inc sp			;d987
	ld (bc),a			;d988
	rst 38h			;d989
	inc sp			;d98a
	inc bc			;d98b
	ld a,a			;d98c
	xor (hl)			;d98d
	dec b			;d98e
	cp 030h		;d98f
	inc b			;d991
	cpl			;d992
	ld hl,00cffh		;d993
	rrc a		;d996
	rlc h		;d998
	inc sp			;d99a
	inc bc			;d99b
	ld a,d			;d99c
	ld b,a			;d99d
	rlc e		;d99e
	inc sp			;d9a0
	ld b,0c0h		;d9a1
	inc sp			;d9a3
	rlca			;d9a4
	jr nc,$+1		;d9a5
	nop			;d9a7
	daa			;d9a8
	inc sp			;d9a9
	inc bc			;d9aa
	sbc a,c			;d9ab
	inc sp			;d9ac
	ld b,0c6h		;d9ad
	inc sp			;d9af
	rlca			;d9b0
	ld l,0ffh		;d9b1
	or (hl)			;d9b3
	ld b,0b6h		;d9b4
	rlca			;d9b6
	dec c			;d9b7
	rlca			;d9b8
	ld l,031h		;d9b9
	ld b,007h		;d9bb
	or (hl)			;d9bd
	ld b,036h		;d9be
	inc sp			;d9c0
	rst 38h			;d9c1
	ld (hl),0ceh		;d9c2
	rst 38h			;d9c4
	ld (hl),004h		;d9c5
	call 03603h		;d9c7
	ld b,h			;d9ca
	jr $+31		;d9cb
	jr nc,$+10		;d9cd
	cpl			;d9cf
	call 0ffffh		;d9d0
	rst 38h			;d9d3
	ld b,e			;d9d4
	exx			;d9d5
	rst 38h			;d9d6
	rst 38h			;d9d7
	ld c,h			;d9d8
	exx			;d9d9
	rst 38h			;d9da
	rst 38h			;d9db
	ld a,b			;d9dc
	exx			;d9dd
	rst 38h			;d9de
	rst 38h			;d9df
	ld a,a			;d9e0
	exx			;d9e1
	rst 38h			;d9e2
	rst 38h			;d9e3
	sub l			;d9e4
	exx			;d9e5
	rst 38h			;d9e6
	rst 38h			;d9e7
	and a			;d9e8
	exx			;d9e9
	rst 38h			;d9ea
	rst 38h			;d9eb
	or e			;d9ec
	exx			;d9ed
	rst 38h			;d9ee
	rst 38h			;d9ef
	jp nz,0ffd9h		;d9f0
	rst 38h			;d9f3
	push bc			;d9f4
	exx			;d9f5
	nop			;d9f6
	nop			;d9f7
	jr nc,$+9		;d9f8
	rst 38h			;d9fa
	cp b			;d9fb
	rlca			;d9fc
	ld c,h			;d9fd
	ld (bc),a			;d9fe
	ld (hl),0e6h		;d9ff
	inc bc			;da01
	ld c,a			;da02
	inc b			;da03
	rst 38h			;da04
	cp e			;da05
	inc b			;da06
	and 002h		;da07
	rst 38h			;da09
	ld c,a			;da0a
	rlca			;da0b
	add hl,hl			;da0c
	ld sp,00107h		;da0d
	ld (hl),h			;da10
	cp 0ffh		;da11
	rst 38h			;da13
	rst 38h			;da14
	ret m			;da15
	exx			;da16
	rst 38h			;da17
	rst 38h			;da18
	ei			;da19
	exx			;da1a
	rst 38h			;da1b
	rst 38h			;da1c
	ld a,(bc)			;da1d
	jp c,00000h		;da1e
	ld e,a			;da21
	inc bc			;da22
	ld (00103h),a		;da23
	rst 38h			;da26
	ld (hl),b			;da27
	inc bc			;da28
	ld (bc),a			;da29
	ld c,b			;da2a
	ld (bc),a			;da2b
	inc bc			;da2c
	ld (hl),h			;da2d
	rst 38h			;da2e
	rst 38h			;da2f
	rst 38h			;da30
	rst 38h			;da31
	ld hl,0ffdah		;da32
	rst 38h			;da35
	daa			;da36
	jp c,00000h		;da37
	inc sp			;da3a
	ld (bc),a			;da3b
	ld bc,01001h		;da3c
	inc sp			;da3f
	ld (bc),a			;da40
	ld (bc),a			;da41
	ld bc,03334h		;da42
	ld (bc),a			;da45
	inc bc			;da46
	ld bc,00114h		;da47
	rla			;da4a
	inc sp			;da4b
	ld (bc),a			;da4c
	inc b			;da4d
	ld bc,03327h		;da4e
	ld (bc),a			;da51
	add hl,bc			;da52
	ld bc,0332ch		;da53
	ld (bc),a			;da56
	ld a,(bc)			;da57
	ld bc,00116h		;da58
	ld hl,02301h		;da5b
	ld bc,00126h		;da5e
	ld l,07dh		;da61
	ld h,002h		;da63
	rst 38h			;da65
	rst 38h			;da66
	rst 38h			;da67
	ld a,(000dah)		;da68
	nop			;da6b
	ld a,(bc)			;da6c
	call nz,0c649h		;da6d
	sub (hl)			;da70
	rst 0			;da71
	add a,0c7h		;da72
	ex de,hl			;da74
	rst 0			;da75
	inc c			;da76
	ret z			;da77
	ld sp,0dec8h		;da78
	ret z			;da7b
	cpl			;da7c
	ret			;da7d
	inc a			;da7e
	ret			;da7f
	ld c,e			;da80
	ret			;da81
	sub a			;da82
	ret			;da83
	ret z			;da84
	ret			;da85
	ret po			;da86
	ret			;da87
	call pe,004c9h		;da88
	jp z,0ca32h		;da8b
	ld e,a			;da8e
	jp z,0ca79h		;da8f
	xor e			;da92
	jp z,0cae2h		;da93
	call m,085cah		;da96
	res 3,l		;da99
	jp nc,0d659h		;da9b
	cp 0d6h		;da9e
	dec l			;daa0
	rst 10h			;daa1
	ld d,(hl)			;daa2
	rst 10h			;daa3
	sub h			;daa4
	rst 10h			;daa5
	ld d,b			;daa6
	ret c			;daa7
	dec d			;daa8
	exx			;daa9
	jp nc,013d9h		;daaa
	jp c,0da30h		;daad
	ld h,(hl)			;dab0
	jp c,00000h		;dab1
	nop			;dab4
	nop			;dab5
	nop			;dab6
	nop			;dab7
	nop			;dab8
	nop			;dab9
	nop			;daba
	nop			;dabb
	nop			;dabc
	nop			;dabd
	nop			;dabe
	nop			;dabf
	nop			;dac0
	nop			;dac1
	nop			;dac2
	nop			;dac3
	nop			;dac4
	nop			;dac5
	nop			;dac6
	nop			;dac7
	nop			;dac8
	nop			;dac9
	nop			;daca
	nop			;dacb
	nop			;dacc
	nop			;dacd
	nop			;dace
	nop			;dacf
	nop			;dad0
	nop			;dad1
	nop			;dad2
	nop			;dad3
	nop			;dad4
	nop			;dad5
	nop			;dad6
	nop			;dad7
	nop			;dad8
	nop			;dad9
	nop			;dada
	nop			;dadb
	nop			;dadc
	nop			;dadd
	nop			;dade
	nop			;dadf
	nop			;dae0
	nop			;dae1
	nop			;dae2
	nop			;dae3
	nop			;dae4
	nop			;dae5
	nop			;dae6
	nop			;dae7
	nop			;dae8
	nop			;dae9
	nop			;daea
	nop			;daeb
	nop			;daec
	nop			;daed
	nop			;daee
	nop			;daef
	nop			;daf0
	nop			;daf1
	nop			;daf2
	nop			;daf3
	nop			;daf4
	nop			;daf5
	nop			;daf6
	nop			;daf7
	nop			;daf8
	nop			;daf9
	nop			;dafa
	nop			;dafb
	nop			;dafc
	nop			;dafd
	nop			;dafe
	nop			;daff
	nop			;db00
	nop			;db01
	nop			;db02
	nop			;db03
	nop			;db04
	nop			;db05
	nop			;db06
	nop			;db07
	nop			;db08
	nop			;db09
	nop			;db0a
	nop			;db0b
	nop			;db0c
	nop			;db0d
	nop			;db0e
	nop			;db0f
	nop			;db10
	nop			;db11
	nop			;db12
	nop			;db13
	nop			;db14
	nop			;db15
	nop			;db16
	nop			;db17
	nop			;db18
	nop			;db19
	nop			;db1a
	nop			;db1b
	nop			;db1c
	nop			;db1d
	nop			;db1e
	nop			;db1f
	nop			;db20
	nop			;db21
	nop			;db22
	nop			;db23
	nop			;db24
	nop			;db25
	nop			;db26
	nop			;db27
	nop			;db28
	nop			;db29
	nop			;db2a
	nop			;db2b
	nop			;db2c
	nop			;db2d
	nop			;db2e
	nop			;db2f
	nop			;db30
	nop			;db31
	nop			;db32
	nop			;db33
	nop			;db34
	nop			;db35
	nop			;db36
	nop			;db37
	nop			;db38
	nop			;db39
	nop			;db3a
	nop			;db3b
	nop			;db3c
	nop			;db3d
	nop			;db3e
	nop			;db3f
	nop			;db40
	nop			;db41
	nop			;db42
	nop			;db43
	nop			;db44
	nop			;db45
	nop			;db46
	nop			;db47
	nop			;db48
	nop			;db49
	nop			;db4a
	nop			;db4b
	nop			;db4c
	nop			;db4d
	nop			;db4e
	nop			;db4f
	nop			;db50
	nop			;db51
	nop			;db52
	nop			;db53
	nop			;db54
	nop			;db55
	nop			;db56
	nop			;db57
	nop			;db58
	nop			;db59
	nop			;db5a
	nop			;db5b
	nop			;db5c
	nop			;db5d
	nop			;db5e
	nop			;db5f
	nop			;db60
	nop			;db61
	nop			;db62
	nop			;db63
	nop			;db64
	nop			;db65
	nop			;db66
	nop			;db67
	nop			;db68
	nop			;db69
	nop			;db6a
	nop			;db6b
	nop			;db6c
	nop			;db6d
	nop			;db6e
	nop			;db6f
	nop			;db70
	nop			;db71
	nop			;db72
	nop			;db73
	nop			;db74
	nop			;db75
	nop			;db76
	nop			;db77
	nop			;db78
	nop			;db79
	nop			;db7a
	nop			;db7b
	nop			;db7c
	nop			;db7d
	nop			;db7e
	nop			;db7f
	nop			;db80
	nop			;db81
	nop			;db82
	nop			;db83
	nop			;db84
	nop			;db85
	nop			;db86
	nop			;db87
	nop			;db88
	nop			;db89
	nop			;db8a
	nop			;db8b
	nop			;db8c
	nop			;db8d
	nop			;db8e
	nop			;db8f
	nop			;db90
	nop			;db91
	nop			;db92
	nop			;db93
	nop			;db94
	nop			;db95
	nop			;db96
	nop			;db97
	nop			;db98
	nop			;db99
	nop			;db9a
	nop			;db9b
	nop			;db9c
	nop			;db9d
	nop			;db9e
	nop			;db9f
	nop			;dba0
	nop			;dba1
	nop			;dba2
	nop			;dba3
	nop			;dba4
	nop			;dba5
	nop			;dba6
	nop			;dba7
	nop			;dba8
	nop			;dba9
	nop			;dbaa
	nop			;dbab
	nop			;dbac
	nop			;dbad
	nop			;dbae
	nop			;dbaf
	nop			;dbb0
	nop			;dbb1
	nop			;dbb2
	nop			;dbb3
	nop			;dbb4
	nop			;dbb5
	nop			;dbb6
	nop			;dbb7
	nop			;dbb8
	nop			;dbb9
	nop			;dbba
	nop			;dbbb
	nop			;dbbc
	nop			;dbbd
	nop			;dbbe
	nop			;dbbf
	nop			;dbc0
	nop			;dbc1
	nop			;dbc2
	nop			;dbc3
	nop			;dbc4
	nop			;dbc5
	nop			;dbc6
	nop			;dbc7
	nop			;dbc8
	nop			;dbc9
	nop			;dbca
	nop			;dbcb
	nop			;dbcc
	nop			;dbcd
	nop			;dbce
	nop			;dbcf
	nop			;dbd0
	nop			;dbd1
	nop			;dbd2
	nop			;dbd3
	nop			;dbd4
	nop			;dbd5
	nop			;dbd6
	nop			;dbd7
	nop			;dbd8
	nop			;dbd9
	nop			;dbda
	nop			;dbdb
	nop			;dbdc
	nop			;dbdd
	nop			;dbde
	nop			;dbdf
	nop			;dbe0
	nop			;dbe1
	nop			;dbe2
	nop			;dbe3
	nop			;dbe4
	nop			;dbe5
	nop			;dbe6
	nop			;dbe7
	nop			;dbe8
	nop			;dbe9
	nop			;dbea
	nop			;dbeb
	nop			;dbec
	nop			;dbed
	nop			;dbee
	nop			;dbef
	nop			;dbf0
	nop			;dbf1
	nop			;dbf2
	nop			;dbf3
	nop			;dbf4
	nop			;dbf5
	nop			;dbf6
	nop			;dbf7
	nop			;dbf8
	nop			;dbf9
	nop			;dbfa
	nop			;dbfb
	nop			;dbfc
	nop			;dbfd
	nop			;dbfe
	nop			;dbff
	nop			;dc00
	nop			;dc01
	nop			;dc02
	nop			;dc03
	nop			;dc04
	nop			;dc05
	nop			;dc06
	nop			;dc07
	nop			;dc08
	nop			;dc09
	nop			;dc0a
	nop			;dc0b
	nop			;dc0c
	nop			;dc0d
	nop			;dc0e
	nop			;dc0f
	nop			;dc10
	nop			;dc11
	nop			;dc12
	nop			;dc13
	nop			;dc14
	nop			;dc15
	nop			;dc16
	nop			;dc17
	nop			;dc18
	nop			;dc19
	nop			;dc1a
	nop			;dc1b
	nop			;dc1c
	nop			;dc1d
	nop			;dc1e
	nop			;dc1f
	nop			;dc20
	nop			;dc21
	nop			;dc22
	nop			;dc23
	nop			;dc24
	nop			;dc25
	nop			;dc26
	nop			;dc27
	nop			;dc28
	nop			;dc29
	nop			;dc2a
	nop			;dc2b
	nop			;dc2c
	nop			;dc2d
	nop			;dc2e
	nop			;dc2f
	nop			;dc30
	nop			;dc31
	nop			;dc32
	nop			;dc33
	nop			;dc34
	nop			;dc35
	nop			;dc36
	nop			;dc37
	nop			;dc38
	nop			;dc39
	nop			;dc3a
	nop			;dc3b
	nop			;dc3c
	nop			;dc3d
	nop			;dc3e
	nop			;dc3f
	nop			;dc40
	nop			;dc41
	nop			;dc42
	nop			;dc43
	nop			;dc44
	nop			;dc45
	nop			;dc46
	nop			;dc47
	nop			;dc48
	nop			;dc49
	nop			;dc4a
	nop			;dc4b
	nop			;dc4c
	nop			;dc4d
	nop			;dc4e
	nop			;dc4f
	nop			;dc50
	nop			;dc51
	nop			;dc52
	nop			;dc53
	nop			;dc54
	nop			;dc55
	nop			;dc56
	nop			;dc57
	nop			;dc58
	nop			;dc59
	nop			;dc5a
	nop			;dc5b
	nop			;dc5c
	nop			;dc5d
	nop			;dc5e
	nop			;dc5f
	nop			;dc60
	nop			;dc61
	nop			;dc62
	nop			;dc63
	nop			;dc64
	nop			;dc65
	nop			;dc66
	nop			;dc67
	nop			;dc68
	nop			;dc69
	nop			;dc6a
	nop			;dc6b
	nop			;dc6c
	nop			;dc6d
	nop			;dc6e
	nop			;dc6f
	nop			;dc70
	nop			;dc71
	nop			;dc72
	nop			;dc73
	nop			;dc74
	nop			;dc75
	nop			;dc76
	nop			;dc77
	nop			;dc78
	nop			;dc79
	nop			;dc7a
	nop			;dc7b
	nop			;dc7c
	nop			;dc7d
	nop			;dc7e
	nop			;dc7f
	nop			;dc80
	nop			;dc81
	nop			;dc82
	nop			;dc83
	nop			;dc84
	nop			;dc85
	nop			;dc86
	nop			;dc87
	nop			;dc88
	nop			;dc89
	nop			;dc8a
	nop			;dc8b
	nop			;dc8c
	nop			;dc8d
	nop			;dc8e
	nop			;dc8f
	nop			;dc90
	nop			;dc91
	nop			;dc92
	nop			;dc93
	nop			;dc94
	nop			;dc95
	nop			;dc96
	nop			;dc97
	nop			;dc98
	nop			;dc99
	nop			;dc9a
	nop			;dc9b
	nop			;dc9c
	nop			;dc9d
	nop			;dc9e
	nop			;dc9f
	nop			;dca0
	nop			;dca1
	nop			;dca2
	nop			;dca3
	nop			;dca4
	nop			;dca5
	nop			;dca6
	nop			;dca7
	nop			;dca8
	nop			;dca9
	nop			;dcaa
	nop			;dcab
	nop			;dcac
	nop			;dcad
	nop			;dcae
	nop			;dcaf
	nop			;dcb0
	nop			;dcb1
	nop			;dcb2
	nop			;dcb3
	nop			;dcb4
	nop			;dcb5
	nop			;dcb6
	nop			;dcb7
	nop			;dcb8
	nop			;dcb9
	ld a,a			;dcba
	nop			;dcbb
	nop			;dcbc
	nop			;dcbd
	nop			;dcbe
	nop			;dcbf
	nop			;dcc0
	nop			;dcc1
	nop			;dcc2
	nop			;dcc3
	nop			;dcc4
	nop			;dcc5
	nop			;dcc6
	nop			;dcc7
	nop			;dcc8
	nop			;dcc9
	nop			;dcca
	nop			;dccb
	nop			;dccc
	nop			;dccd
	nop			;dcce
	nop			;dccf
	nop			;dcd0
	nop			;dcd1
	nop			;dcd2
	nop			;dcd3
	nop			;dcd4
	nop			;dcd5
	nop			;dcd6
	nop			;dcd7
	nop			;dcd8
	nop			;dcd9
	nop			;dcda
	nop			;dcdb
	nop			;dcdc
	nop			;dcdd
	nop			;dcde
	nop			;dcdf
	nop			;dce0
	nop			;dce1
	nop			;dce2
	nop			;dce3
	nop			;dce4
	nop			;dce5
	nop			;dce6
	nop			;dce7
	nop			;dce8
	nop			;dce9
	nop			;dcea
	nop			;dceb
	nop			;dcec
	nop			;dced
	nop			;dcee
	nop			;dcef
	nop			;dcf0
	nop			;dcf1
	nop			;dcf2
	nop			;dcf3
	nop			;dcf4
	nop			;dcf5
	nop			;dcf6
	nop			;dcf7
	nop			;dcf8
	nop			;dcf9
	nop			;dcfa
	nop			;dcfb
	nop			;dcfc
	nop			;dcfd
	nop			;dcfe
	nop			;dcff
	nop			;dd00
	nop			;dd01
	nop			;dd02
	nop			;dd03
	nop			;dd04
	nop			;dd05
	nop			;dd06
	nop			;dd07
	nop			;dd08
	nop			;dd09
	nop			;dd0a
	nop			;dd0b
	nop			;dd0c
	nop			;dd0d
	nop			;dd0e
	nop			;dd0f
	nop			;dd10
	nop			;dd11
	nop			;dd12
	nop			;dd13
	nop			;dd14
	nop			;dd15
	nop			;dd16
	nop			;dd17
	nop			;dd18
	nop			;dd19
	nop			;dd1a
	nop			;dd1b
	nop			;dd1c
	nop			;dd1d
	nop			;dd1e
	nop			;dd1f
	nop			;dd20
	nop			;dd21
	nop			;dd22
	nop			;dd23
	nop			;dd24
	nop			;dd25
	nop			;dd26
	nop			;dd27
	nop			;dd28
	nop			;dd29
	nop			;dd2a
	nop			;dd2b
	nop			;dd2c
	nop			;dd2d
	nop			;dd2e
	nop			;dd2f
	nop			;dd30
	nop			;dd31
	nop			;dd32
	nop			;dd33
	nop			;dd34
	nop			;dd35
	nop			;dd36
	nop			;dd37
	nop			;dd38
	nop			;dd39
	nop			;dd3a
	nop			;dd3b
	nop			;dd3c
	nop			;dd3d
	nop			;dd3e
	nop			;dd3f
	nop			;dd40
	nop			;dd41
	nop			;dd42
	nop			;dd43
	nop			;dd44
	nop			;dd45
	nop			;dd46
	nop			;dd47
	nop			;dd48
	nop			;dd49
	nop			;dd4a
	nop			;dd4b
	nop			;dd4c
	nop			;dd4d
	nop			;dd4e
	nop			;dd4f
	nop			;dd50
	nop			;dd51
	nop			;dd52
	nop			;dd53
	nop			;dd54
	nop			;dd55
	nop			;dd56
	nop			;dd57
	nop			;dd58
	nop			;dd59
	nop			;dd5a
	nop			;dd5b
	nop			;dd5c
	nop			;dd5d
	nop			;dd5e
	nop			;dd5f
	nop			;dd60
	nop			;dd61
	nop			;dd62
	nop			;dd63
	nop			;dd64
	nop			;dd65
	nop			;dd66
	nop			;dd67
	nop			;dd68
	nop			;dd69
	nop			;dd6a
	nop			;dd6b
	nop			;dd6c
	nop			;dd6d
	nop			;dd6e
	nop			;dd6f
	nop			;dd70
	nop			;dd71
	nop			;dd72
	nop			;dd73
	nop			;dd74
	nop			;dd75
	nop			;dd76
	nop			;dd77
	nop			;dd78
	nop			;dd79
	nop			;dd7a
	nop			;dd7b
	nop			;dd7c
	nop			;dd7d
	nop			;dd7e
	nop			;dd7f
	nop			;dd80
	nop			;dd81
	nop			;dd82
	nop			;dd83
	nop			;dd84
	nop			;dd85
	nop			;dd86
	nop			;dd87
	nop			;dd88
	nop			;dd89
	nop			;dd8a
	nop			;dd8b
	nop			;dd8c
	nop			;dd8d
	nop			;dd8e
	nop			;dd8f
	nop			;dd90
	nop			;dd91
	nop			;dd92
	nop			;dd93
	nop			;dd94
	nop			;dd95
	nop			;dd96
	nop			;dd97
	nop			;dd98
	nop			;dd99
	nop			;dd9a
	nop			;dd9b
	nop			;dd9c
	nop			;dd9d
	nop			;dd9e
	nop			;dd9f
	nop			;dda0
	nop			;dda1
	nop			;dda2
	nop			;dda3
	nop			;dda4
	nop			;dda5
	nop			;dda6
	nop			;dda7
	nop			;dda8
	nop			;dda9
	nop			;ddaa
	nop			;ddab
	nop			;ddac
	nop			;ddad
	nop			;ddae
	nop			;ddaf
	nop			;ddb0
	nop			;ddb1
	nop			;ddb2
	nop			;ddb3
	nop			;ddb4
	nop			;ddb5
	nop			;ddb6
	nop			;ddb7
	nop			;ddb8
	nop			;ddb9
	nop			;ddba
	nop			;ddbb
	nop			;ddbc
	nop			;ddbd
	nop			;ddbe
	nop			;ddbf
	nop			;ddc0
	nop			;ddc1
	nop			;ddc2
	nop			;ddc3
	nop			;ddc4
	nop			;ddc5
	nop			;ddc6
	nop			;ddc7
	nop			;ddc8
	nop			;ddc9
	nop			;ddca
	nop			;ddcb
	nop			;ddcc
	nop			;ddcd
	nop			;ddce
	nop			;ddcf
	nop			;ddd0
	nop			;ddd1
	nop			;ddd2
	nop			;ddd3
	nop			;ddd4
	nop			;ddd5
	nop			;ddd6
	nop			;ddd7
	nop			;ddd8
	nop			;ddd9
	nop			;ddda
	nop			;dddb
	nop			;dddc
	nop			;dddd
	nop			;ddde
	nop			;dddf
	nop			;dde0
	nop			;dde1
	nop			;dde2
	nop			;dde3
	nop			;dde4
	nop			;dde5
	nop			;dde6
	nop			;dde7
	nop			;dde8
	nop			;dde9
	nop			;ddea
	nop			;ddeb
	nop			;ddec
	nop			;dded
	nop			;ddee
	nop			;ddef
	nop			;ddf0
	nop			;ddf1
	nop			;ddf2
	nop			;ddf3
	nop			;ddf4
	nop			;ddf5
	nop			;ddf6
	nop			;ddf7
	nop			;ddf8
	nop			;ddf9
	nop			;ddfa
	nop			;ddfb
	nop			;ddfc
	nop			;ddfd
	nop			;ddfe
	nop			;ddff
	nop			;de00
	nop			;de01
	nop			;de02
	nop			;de03
	nop			;de04
	nop			;de05
	nop			;de06
	nop			;de07
	nop			;de08
	nop			;de09
	nop			;de0a
	nop			;de0b
	nop			;de0c
	nop			;de0d
	nop			;de0e
	nop			;de0f
	nop			;de10
	nop			;de11
	nop			;de12
	nop			;de13
	nop			;de14
	nop			;de15
	nop			;de16
	nop			;de17
	nop			;de18
	nop			;de19
	nop			;de1a
	nop			;de1b
	nop			;de1c
	nop			;de1d
	nop			;de1e
	nop			;de1f
	nop			;de20
	nop			;de21
	nop			;de22
	nop			;de23
	nop			;de24
	nop			;de25
	nop			;de26
	nop			;de27
	nop			;de28
	nop			;de29
	nop			;de2a
	nop			;de2b
	nop			;de2c
	nop			;de2d
	nop			;de2e
	nop			;de2f
	nop			;de30
	nop			;de31
	nop			;de32
	nop			;de33
	nop			;de34
	nop			;de35
	nop			;de36
	nop			;de37
	nop			;de38
	nop			;de39
	nop			;de3a
	nop			;de3b
	nop			;de3c
	nop			;de3d
	nop			;de3e
	nop			;de3f
	nop			;de40
	nop			;de41
	nop			;de42
	nop			;de43
	nop			;de44
	nop			;de45
	nop			;de46
	nop			;de47
	nop			;de48
	nop			;de49
	nop			;de4a
	nop			;de4b
	nop			;de4c
	nop			;de4d
	nop			;de4e
	nop			;de4f
	nop			;de50
	nop			;de51
	nop			;de52
	nop			;de53
	nop			;de54
	nop			;de55
	nop			;de56
	nop			;de57
	nop			;de58
	nop			;de59
	nop			;de5a
	nop			;de5b
	nop			;de5c
	nop			;de5d
	nop			;de5e
	nop			;de5f
	nop			;de60
	nop			;de61
	nop			;de62
	nop			;de63
	nop			;de64
	nop			;de65
	nop			;de66
	nop			;de67
	nop			;de68
	nop			;de69
	nop			;de6a
	nop			;de6b
	nop			;de6c
	nop			;de6d
	nop			;de6e
	nop			;de6f
	nop			;de70
	nop			;de71
	nop			;de72
	nop			;de73
	nop			;de74
	nop			;de75
	nop			;de76
	nop			;de77
	nop			;de78
	nop			;de79
	nop			;de7a
	nop			;de7b
	nop			;de7c
	nop			;de7d
	nop			;de7e
	nop			;de7f
	nop			;de80
	nop			;de81
	nop			;de82
	nop			;de83
	nop			;de84
	nop			;de85
	nop			;de86
	nop			;de87
	nop			;de88
	nop			;de89
	nop			;de8a
	nop			;de8b
	nop			;de8c
	nop			;de8d
	nop			;de8e
	nop			;de8f
	nop			;de90
	nop			;de91
	nop			;de92
	nop			;de93
	nop			;de94
	nop			;de95
	nop			;de96
	nop			;de97
	nop			;de98
	nop			;de99
	nop			;de9a
	nop			;de9b
	nop			;de9c
	nop			;de9d
	nop			;de9e
	nop			;de9f
	nop			;dea0
	nop			;dea1
	nop			;dea2
	nop			;dea3
	nop			;dea4
	nop			;dea5
	nop			;dea6
	nop			;dea7
	nop			;dea8
	nop			;dea9
	nop			;deaa
	nop			;deab
	nop			;deac
	nop			;dead
	nop			;deae
	nop			;deaf
	nop			;deb0
	nop			;deb1
	nop			;deb2
	nop			;deb3
	nop			;deb4
	nop			;deb5
	nop			;deb6
	nop			;deb7
	nop			;deb8
	nop			;deb9
	nop			;deba
	nop			;debb
	nop			;debc
	nop			;debd
	nop			;debe
	nop			;debf
	nop			;dec0
	nop			;dec1
	nop			;dec2
	nop			;dec3
	nop			;dec4
	nop			;dec5
	nop			;dec6
	nop			;dec7
	nop			;dec8
	nop			;dec9
	nop			;deca
	nop			;decb
	nop			;decc
	nop			;decd
	nop			;dece
	nop			;decf
	nop			;ded0
	nop			;ded1
	nop			;ded2
	nop			;ded3
	nop			;ded4
	nop			;ded5
	nop			;ded6
	nop			;ded7
	nop			;ded8
	nop			;ded9
	nop			;deda
	nop			;dedb
	nop			;dedc
	nop			;dedd
	nop			;dede
	nop			;dedf
	nop			;dee0
	nop			;dee1
	nop			;dee2
	nop			;dee3
	nop			;dee4
	nop			;dee5
	nop			;dee6
	nop			;dee7
	nop			;dee8
	nop			;dee9
	nop			;deea
	nop			;deeb
	nop			;deec
	nop			;deed
	nop			;deee
	nop			;deef
	nop			;def0
	nop			;def1
	nop			;def2
	nop			;def3
	nop			;def4
	nop			;def5
	nop			;def6
	nop			;def7
	nop			;def8
	nop			;def9
	nop			;defa
	nop			;defb
	nop			;defc
	nop			;defd
	nop			;defe
	nop			;deff
	nop			;df00
	nop			;df01
	nop			;df02
	nop			;df03
	nop			;df04
	nop			;df05
	nop			;df06
	nop			;df07
	nop			;df08
	nop			;df09
	nop			;df0a
	nop			;df0b
	nop			;df0c
	nop			;df0d
	nop			;df0e
	nop			;df0f
	nop			;df10
	nop			;df11
	nop			;df12
	nop			;df13
	nop			;df14
	nop			;df15
	nop			;df16
	nop			;df17
	nop			;df18
	nop			;df19
	nop			;df1a
	nop			;df1b
	nop			;df1c
	nop			;df1d
	nop			;df1e
	nop			;df1f
	nop			;df20
	nop			;df21
	nop			;df22
	nop			;df23
	nop			;df24
	nop			;df25
	nop			;df26
	nop			;df27
	nop			;df28
	nop			;df29
	nop			;df2a
	nop			;df2b
	nop			;df2c
	nop			;df2d
	nop			;df2e
	nop			;df2f
	nop			;df30
	nop			;df31
	nop			;df32
	nop			;df33
	nop			;df34
	nop			;df35
	nop			;df36
	nop			;df37
	nop			;df38
	nop			;df39
	nop			;df3a
	nop			;df3b
	nop			;df3c
	nop			;df3d
	nop			;df3e
	nop			;df3f
	nop			;df40
	nop			;df41
	nop			;df42
	nop			;df43
	nop			;df44
	nop			;df45
	nop			;df46
	nop			;df47
	nop			;df48
	nop			;df49
	nop			;df4a
	nop			;df4b
	nop			;df4c
	nop			;df4d
	nop			;df4e
	nop			;df4f
	nop			;df50
	nop			;df51
	nop			;df52
	nop			;df53
	nop			;df54
	nop			;df55
	nop			;df56
	nop			;df57
	nop			;df58
	nop			;df59
	nop			;df5a
	nop			;df5b
	nop			;df5c
	nop			;df5d
	nop			;df5e
	nop			;df5f
	nop			;df60
	nop			;df61
	nop			;df62
	nop			;df63
	nop			;df64
	nop			;df65
	nop			;df66
	nop			;df67
	nop			;df68
	nop			;df69
	nop			;df6a
	nop			;df6b
	nop			;df6c
	nop			;df6d
	nop			;df6e
	nop			;df6f
	nop			;df70
	nop			;df71
	nop			;df72
	nop			;df73
	nop			;df74
	nop			;df75
	nop			;df76
	nop			;df77
	nop			;df78
	nop			;df79
	nop			;df7a
	nop			;df7b
	nop			;df7c
	nop			;df7d
	nop			;df7e
	nop			;df7f
	nop			;df80
	nop			;df81
	nop			;df82
	nop			;df83
	nop			;df84
	nop			;df85
	nop			;df86
	nop			;df87
	nop			;df88
	nop			;df89
	nop			;df8a
	nop			;df8b
	nop			;df8c
	nop			;df8d
	nop			;df8e
	nop			;df8f
	nop			;df90
	nop			;df91
	nop			;df92
	nop			;df93
	nop			;df94
	nop			;df95
	nop			;df96
	nop			;df97
	nop			;df98
	nop			;df99
	nop			;df9a
	nop			;df9b
	nop			;df9c
	nop			;df9d
	nop			;df9e
	nop			;df9f
	nop			;dfa0
	nop			;dfa1
	nop			;dfa2
	nop			;dfa3
	nop			;dfa4
	nop			;dfa5
	nop			;dfa6
	nop			;dfa7
	nop			;dfa8
	nop			;dfa9
	nop			;dfaa
	nop			;dfab
	nop			;dfac
	nop			;dfad
	nop			;dfae
	nop			;dfaf
	nop			;dfb0
	nop			;dfb1
	nop			;dfb2
	nop			;dfb3
	nop			;dfb4
	nop			;dfb5
	nop			;dfb6
	nop			;dfb7
	nop			;dfb8
	nop			;dfb9
	nop			;dfba
	nop			;dfbb
	nop			;dfbc
	nop			;dfbd
	nop			;dfbe
	nop			;dfbf
	nop			;dfc0
	nop			;dfc1
	nop			;dfc2
	nop			;dfc3
	nop			;dfc4
	nop			;dfc5
	nop			;dfc6
	nop			;dfc7
	nop			;dfc8
	nop			;dfc9
	nop			;dfca
	nop			;dfcb
	nop			;dfcc
	nop			;dfcd
	nop			;dfce
	nop			;dfcf
	nop			;dfd0
	nop			;dfd1
	nop			;dfd2
	nop			;dfd3
	nop			;dfd4
	nop			;dfd5
	nop			;dfd6
	nop			;dfd7
	nop			;dfd8
	nop			;dfd9
	nop			;dfda
	nop			;dfdb
	nop			;dfdc
	nop			;dfdd
	nop			;dfde
	nop			;dfdf
	nop			;dfe0
	nop			;dfe1
	nop			;dfe2
	nop			;dfe3
	nop			;dfe4
	nop			;dfe5
	nop			;dfe6
	nop			;dfe7
	nop			;dfe8
	nop			;dfe9
	nop			;dfea
	nop			;dfeb
	nop			;dfec
	nop			;dfed
	nop			;dfee
	nop			;dfef
	nop			;dff0
	nop			;dff1
	nop			;dff2
	nop			;dff3
	nop			;dff4
	nop			;dff5
	nop			;dff6
	nop			;dff7
	nop			;dff8
	nop			;dff9
	nop			;dffa
	nop			;dffb
	nop			;dffc
	nop			;dffd
	nop			;dffe
	nop			;dfff
	nop			;e000
	nop			;e001
	nop			;e002
	nop			;e003
	nop			;e004
	nop			;e005
	nop			;e006
	nop			;e007
	nop			;e008
	nop			;e009
	nop			;e00a
	nop			;e00b
	nop			;e00c
	nop			;e00d
	nop			;e00e
	nop			;e00f
	nop			;e010
	nop			;e011
	nop			;e012
	nop			;e013
	nop			;e014
	nop			;e015
	nop			;e016
	nop			;e017
	nop			;e018
	nop			;e019
	nop			;e01a
	nop			;e01b
	nop			;e01c
	nop			;e01d
	nop			;e01e
	nop			;e01f
	nop			;e020
	nop			;e021
	nop			;e022
	nop			;e023
	nop			;e024
	nop			;e025
	nop			;e026
	nop			;e027
	nop			;e028
	nop			;e029
	nop			;e02a
	nop			;e02b
	nop			;e02c
	nop			;e02d
	nop			;e02e
	nop			;e02f
	nop			;e030
	nop			;e031
	nop			;e032
	nop			;e033
	nop			;e034
	nop			;e035
	nop			;e036
	nop			;e037
	nop			;e038
	nop			;e039
	nop			;e03a
	nop			;e03b
	nop			;e03c
	nop			;e03d
	nop			;e03e
	nop			;e03f
	nop			;e040
	nop			;e041
	nop			;e042
	nop			;e043
	nop			;e044
	nop			;e045
	nop			;e046
	nop			;e047
	nop			;e048
	nop			;e049
	nop			;e04a
	nop			;e04b
	nop			;e04c
	nop			;e04d
	nop			;e04e
	nop			;e04f
	nop			;e050
	nop			;e051
	nop			;e052
	nop			;e053
	nop			;e054
	nop			;e055
	nop			;e056
	nop			;e057
	nop			;e058
	nop			;e059
	nop			;e05a
	nop			;e05b
	nop			;e05c
	nop			;e05d
	nop			;e05e
	nop			;e05f
	nop			;e060
	nop			;e061
	nop			;e062
	nop			;e063
	nop			;e064
	nop			;e065
	nop			;e066
	nop			;e067
	nop			;e068
	nop			;e069
	nop			;e06a
	nop			;e06b
	nop			;e06c
	nop			;e06d
	nop			;e06e
	nop			;e06f
	nop			;e070
	nop			;e071
	nop			;e072
	nop			;e073
	nop			;e074
	nop			;e075
	nop			;e076
	nop			;e077
	nop			;e078
	nop			;e079
	nop			;e07a
	nop			;e07b
	nop			;e07c
	nop			;e07d
	nop			;e07e
	nop			;e07f
	nop			;e080
	nop			;e081
	nop			;e082
	nop			;e083
	nop			;e084
	nop			;e085
	nop			;e086
	nop			;e087
	nop			;e088
	nop			;e089
	nop			;e08a
	nop			;e08b
	nop			;e08c
	nop			;e08d
	nop			;e08e
	nop			;e08f
	nop			;e090
	nop			;e091
	nop			;e092
	nop			;e093
	nop			;e094
	nop			;e095
	nop			;e096
	nop			;e097
	nop			;e098
	nop			;e099
	nop			;e09a
	nop			;e09b
	nop			;e09c
	nop			;e09d
	nop			;e09e
	nop			;e09f
	nop			;e0a0
	nop			;e0a1
	nop			;e0a2
	nop			;e0a3
	nop			;e0a4
	nop			;e0a5
	nop			;e0a6
	nop			;e0a7
	nop			;e0a8
	nop			;e0a9
	nop			;e0aa
	nop			;e0ab
	nop			;e0ac
	nop			;e0ad
	nop			;e0ae
	nop			;e0af
	nop			;e0b0
	nop			;e0b1
	nop			;e0b2
	nop			;e0b3
	nop			;e0b4
	nop			;e0b5
	nop			;e0b6
	nop			;e0b7
	nop			;e0b8
	nop			;e0b9
	nop			;e0ba
	nop			;e0bb
	nop			;e0bc
	nop			;e0bd
	nop			;e0be
	nop			;e0bf
	nop			;e0c0
	nop			;e0c1
	nop			;e0c2
	nop			;e0c3
	nop			;e0c4
	nop			;e0c5
	nop			;e0c6
	nop			;e0c7
	nop			;e0c8
	nop			;e0c9
	nop			;e0ca
	nop			;e0cb
	nop			;e0cc
	nop			;e0cd
	nop			;e0ce
	nop			;e0cf
	nop			;e0d0
	nop			;e0d1
	nop			;e0d2
	nop			;e0d3
	nop			;e0d4
	nop			;e0d5
	nop			;e0d6
	nop			;e0d7
	nop			;e0d8
	nop			;e0d9
	nop			;e0da
	nop			;e0db
	nop			;e0dc
	nop			;e0dd
	nop			;e0de
	nop			;e0df
	nop			;e0e0
	nop			;e0e1
	nop			;e0e2
	nop			;e0e3
	nop			;e0e4
	nop			;e0e5
	nop			;e0e6
	nop			;e0e7
	nop			;e0e8
	nop			;e0e9
	nop			;e0ea
	nop			;e0eb
	nop			;e0ec
	nop			;e0ed
	nop			;e0ee
	nop			;e0ef
	nop			;e0f0
	nop			;e0f1
	nop			;e0f2
	nop			;e0f3
	nop			;e0f4
	nop			;e0f5
	nop			;e0f6
	nop			;e0f7
	nop			;e0f8
	nop			;e0f9
	nop			;e0fa
	nop			;e0fb
	nop			;e0fc
	nop			;e0fd
	nop			;e0fe
	nop			;e0ff
	nop			;e100
	nop			;e101
	nop			;e102
	nop			;e103
	nop			;e104
	nop			;e105
	nop			;e106
	nop			;e107
	nop			;e108
	nop			;e109
	nop			;e10a
	nop			;e10b
	nop			;e10c
	nop			;e10d
	nop			;e10e
	nop			;e10f
	nop			;e110
	nop			;e111
	nop			;e112
	nop			;e113
	nop			;e114
	nop			;e115
	nop			;e116
	nop			;e117
	nop			;e118
	nop			;e119
	nop			;e11a
	nop			;e11b
	nop			;e11c
	nop			;e11d
	nop			;e11e
	nop			;e11f
	nop			;e120
	nop			;e121
	nop			;e122
	nop			;e123
	nop			;e124
	nop			;e125
	nop			;e126
	nop			;e127
	nop			;e128
	nop			;e129
	nop			;e12a
	nop			;e12b
	nop			;e12c
	nop			;e12d
	nop			;e12e
	nop			;e12f
	nop			;e130
	nop			;e131
	nop			;e132
	nop			;e133
	nop			;e134
	nop			;e135
	nop			;e136
	nop			;e137
	nop			;e138
	nop			;e139
	nop			;e13a
	nop			;e13b
	nop			;e13c
	nop			;e13d
	nop			;e13e
	nop			;e13f
	nop			;e140
	nop			;e141
	nop			;e142
	nop			;e143
	nop			;e144
	nop			;e145
	nop			;e146
	nop			;e147
	nop			;e148
	nop			;e149
	nop			;e14a
	nop			;e14b
	nop			;e14c
	nop			;e14d
	nop			;e14e
	nop			;e14f
	nop			;e150
	nop			;e151
	nop			;e152
	nop			;e153
	nop			;e154
	nop			;e155
	nop			;e156
	nop			;e157
	nop			;e158
	nop			;e159
	nop			;e15a
	nop			;e15b
	nop			;e15c
	nop			;e15d
	nop			;e15e
	nop			;e15f
	nop			;e160
	nop			;e161
	nop			;e162
	nop			;e163
	nop			;e164
	nop			;e165
	nop			;e166
	nop			;e167
	nop			;e168
	nop			;e169
	nop			;e16a
	nop			;e16b
	nop			;e16c
	nop			;e16d
	nop			;e16e
	nop			;e16f
	nop			;e170
	nop			;e171
	nop			;e172
	nop			;e173
	nop			;e174
	nop			;e175
	nop			;e176
	nop			;e177
	nop			;e178
	nop			;e179
	nop			;e17a
	nop			;e17b
	nop			;e17c
	nop			;e17d
	nop			;e17e
	nop			;e17f
	nop			;e180
	nop			;e181
	nop			;e182
	nop			;e183
	nop			;e184
	nop			;e185
	nop			;e186
	nop			;e187
	nop			;e188
	nop			;e189
	nop			;e18a
	nop			;e18b
	nop			;e18c
	nop			;e18d
	nop			;e18e
	nop			;e18f
	nop			;e190
	nop			;e191
	nop			;e192
	nop			;e193
	nop			;e194
	nop			;e195
	nop			;e196
	nop			;e197
	nop			;e198
	nop			;e199
	nop			;e19a
	nop			;e19b
	nop			;e19c
	nop			;e19d
	nop			;e19e
	nop			;e19f
	nop			;e1a0
	nop			;e1a1
	nop			;e1a2
	nop			;e1a3
	nop			;e1a4
	nop			;e1a5
	nop			;e1a6
	nop			;e1a7
	nop			;e1a8
	nop			;e1a9
	nop			;e1aa
	nop			;e1ab
	nop			;e1ac
	nop			;e1ad
	nop			;e1ae
	nop			;e1af
	nop			;e1b0
	nop			;e1b1
	nop			;e1b2
	nop			;e1b3
	nop			;e1b4
	nop			;e1b5
	nop			;e1b6
	nop			;e1b7
	nop			;e1b8
	nop			;e1b9
	nop			;e1ba
	nop			;e1bb
	nop			;e1bc
	nop			;e1bd
	nop			;e1be
	nop			;e1bf
	nop			;e1c0
	nop			;e1c1
	nop			;e1c2
	nop			;e1c3
	nop			;e1c4
	nop			;e1c5
	nop			;e1c6
	nop			;e1c7
	nop			;e1c8
	nop			;e1c9
	nop			;e1ca
	nop			;e1cb
	nop			;e1cc
	nop			;e1cd
	nop			;e1ce
	nop			;e1cf
	nop			;e1d0
	nop			;e1d1
	nop			;e1d2
	nop			;e1d3
	nop			;e1d4
	nop			;e1d5
	nop			;e1d6
	nop			;e1d7
	nop			;e1d8
	nop			;e1d9
	nop			;e1da
	nop			;e1db
	nop			;e1dc
	nop			;e1dd
	nop			;e1de
	nop			;e1df
	nop			;e1e0
	nop			;e1e1
	nop			;e1e2
	nop			;e1e3
	nop			;e1e4
	nop			;e1e5
	nop			;e1e6
	nop			;e1e7
	nop			;e1e8
	nop			;e1e9
	nop			;e1ea
	nop			;e1eb
	nop			;e1ec
	nop			;e1ed
	nop			;e1ee
	nop			;e1ef
	nop			;e1f0
	nop			;e1f1
	nop			;e1f2
	nop			;e1f3
	nop			;e1f4
	nop			;e1f5
	nop			;e1f6
	nop			;e1f7
	nop			;e1f8
	nop			;e1f9
	nop			;e1fa
	nop			;e1fb
	nop			;e1fc
	nop			;e1fd
	nop			;e1fe
	nop			;e1ff
	nop			;e200
	nop			;e201
	nop			;e202
	nop			;e203
	nop			;e204
	nop			;e205
	nop			;e206
	nop			;e207
	nop			;e208
	nop			;e209
	nop			;e20a
	nop			;e20b
	nop			;e20c
	nop			;e20d
	nop			;e20e
	nop			;e20f
	nop			;e210
	nop			;e211
	nop			;e212
	nop			;e213
	nop			;e214
	nop			;e215
	nop			;e216
	nop			;e217
	nop			;e218
	nop			;e219
	nop			;e21a
	nop			;e21b
	nop			;e21c
	nop			;e21d
	nop			;e21e
	nop			;e21f
	nop			;e220
	nop			;e221
	nop			;e222
	nop			;e223
	nop			;e224
	nop			;e225
	nop			;e226
	nop			;e227
	nop			;e228
	nop			;e229
	nop			;e22a
	nop			;e22b
	nop			;e22c
	nop			;e22d
	nop			;e22e
	nop			;e22f
	nop			;e230
	nop			;e231
	nop			;e232
	nop			;e233
	nop			;e234
	nop			;e235
	nop			;e236
	nop			;e237
	nop			;e238
	nop			;e239
	nop			;e23a
	nop			;e23b
	nop			;e23c
	nop			;e23d
	nop			;e23e
	nop			;e23f
	nop			;e240
	nop			;e241
	nop			;e242
	nop			;e243
	nop			;e244
	nop			;e245
	nop			;e246
	nop			;e247
	nop			;e248
	nop			;e249
	nop			;e24a
	nop			;e24b
	nop			;e24c
	nop			;e24d
	nop			;e24e
	nop			;e24f
	nop			;e250
	nop			;e251
	nop			;e252
	nop			;e253
	nop			;e254
	nop			;e255
	nop			;e256
	nop			;e257
	nop			;e258
	nop			;e259
	nop			;e25a
	nop			;e25b
	nop			;e25c
	nop			;e25d
	nop			;e25e
	nop			;e25f
	nop			;e260
	nop			;e261
	nop			;e262
	nop			;e263
	nop			;e264
	nop			;e265
	nop			;e266
	nop			;e267
	nop			;e268
	nop			;e269
	nop			;e26a
	nop			;e26b
	nop			;e26c
	nop			;e26d
	nop			;e26e
	nop			;e26f
	nop			;e270
	nop			;e271
	nop			;e272
	nop			;e273
	nop			;e274
	nop			;e275
	nop			;e276
	nop			;e277
	nop			;e278
	nop			;e279
	nop			;e27a
	nop			;e27b
	nop			;e27c
	nop			;e27d
	nop			;e27e
	nop			;e27f
	nop			;e280
	nop			;e281
	nop			;e282
	nop			;e283
	nop			;e284
	nop			;e285
	nop			;e286
	nop			;e287
	nop			;e288
	nop			;e289
	nop			;e28a
	nop			;e28b
	nop			;e28c
	nop			;e28d
	nop			;e28e
	nop			;e28f
	nop			;e290
	nop			;e291
	nop			;e292
	nop			;e293
	nop			;e294
	nop			;e295
	nop			;e296
	nop			;e297
	nop			;e298
	nop			;e299
	nop			;e29a
	nop			;e29b
	nop			;e29c
	nop			;e29d
	nop			;e29e
	nop			;e29f
	nop			;e2a0
	nop			;e2a1
	nop			;e2a2
	nop			;e2a3
	nop			;e2a4
	nop			;e2a5
	nop			;e2a6
	nop			;e2a7
	nop			;e2a8
	nop			;e2a9
	nop			;e2aa
	nop			;e2ab
	nop			;e2ac
	nop			;e2ad
	nop			;e2ae
	nop			;e2af
	nop			;e2b0
	nop			;e2b1
	nop			;e2b2
	nop			;e2b3
	nop			;e2b4
	nop			;e2b5
	nop			;e2b6
	nop			;e2b7
	nop			;e2b8
	nop			;e2b9
	nop			;e2ba
	nop			;e2bb
	nop			;e2bc
	nop			;e2bd
	nop			;e2be
	nop			;e2bf
	nop			;e2c0
	nop			;e2c1
	nop			;e2c2
	nop			;e2c3
	nop			;e2c4
	nop			;e2c5
	nop			;e2c6
	nop			;e2c7
	nop			;e2c8
	nop			;e2c9
	nop			;e2ca
	nop			;e2cb
	nop			;e2cc
	nop			;e2cd
	nop			;e2ce
	nop			;e2cf
	nop			;e2d0
	nop			;e2d1
	nop			;e2d2
	nop			;e2d3
	nop			;e2d4
	nop			;e2d5
	nop			;e2d6
	nop			;e2d7
	nop			;e2d8
	nop			;e2d9
	nop			;e2da
	nop			;e2db
	nop			;e2dc
	nop			;e2dd
	nop			;e2de
	nop			;e2df
	nop			;e2e0
	nop			;e2e1
	nop			;e2e2
	nop			;e2e3
	nop			;e2e4
	nop			;e2e5
	nop			;e2e6
	nop			;e2e7
	nop			;e2e8
	nop			;e2e9
	nop			;e2ea
	nop			;e2eb
	nop			;e2ec
	nop			;e2ed
	nop			;e2ee
	nop			;e2ef
	nop			;e2f0
	nop			;e2f1
	nop			;e2f2
	nop			;e2f3
	nop			;e2f4
	nop			;e2f5
	nop			;e2f6
	nop			;e2f7
	nop			;e2f8
	nop			;e2f9
	nop			;e2fa
	nop			;e2fb
	nop			;e2fc
	nop			;e2fd
	nop			;e2fe
	nop			;e2ff
	nop			;e300
	nop			;e301
	nop			;e302
	nop			;e303
	nop			;e304
	nop			;e305
	nop			;e306
	nop			;e307
	nop			;e308
	nop			;e309
	nop			;e30a
	nop			;e30b
	nop			;e30c
	nop			;e30d
	nop			;e30e
	nop			;e30f
	nop			;e310
	nop			;e311
	nop			;e312
	nop			;e313
	nop			;e314
	nop			;e315
	nop			;e316
	nop			;e317
	nop			;e318
	nop			;e319
	nop			;e31a
	nop			;e31b
	nop			;e31c
	nop			;e31d
	nop			;e31e
	nop			;e31f
	nop			;e320
	nop			;e321
	nop			;e322
	nop			;e323
	nop			;e324
	nop			;e325
	nop			;e326
	nop			;e327
	nop			;e328
	nop			;e329
	nop			;e32a
	nop			;e32b
	nop			;e32c
	nop			;e32d
	nop			;e32e
	nop			;e32f
	nop			;e330
	nop			;e331
	nop			;e332
	nop			;e333
	nop			;e334
	nop			;e335
	nop			;e336
	nop			;e337
	nop			;e338
	nop			;e339
	nop			;e33a
	nop			;e33b
	nop			;e33c
	nop			;e33d
	nop			;e33e
	nop			;e33f
	nop			;e340
	nop			;e341
	nop			;e342
	nop			;e343
	nop			;e344
	nop			;e345
	nop			;e346
	nop			;e347
	nop			;e348
	nop			;e349
	nop			;e34a
	nop			;e34b
	nop			;e34c
	nop			;e34d
	nop			;e34e
	nop			;e34f
	nop			;e350
	nop			;e351
	nop			;e352
	nop			;e353
	nop			;e354
	nop			;e355
	nop			;e356
	nop			;e357
	nop			;e358
	nop			;e359
	nop			;e35a
	nop			;e35b
	nop			;e35c
	nop			;e35d
	nop			;e35e
	nop			;e35f
	nop			;e360
	nop			;e361
	nop			;e362
	nop			;e363
	nop			;e364
	nop			;e365
	nop			;e366
	nop			;e367
	nop			;e368
	nop			;e369
	nop			;e36a
	nop			;e36b
	nop			;e36c
	nop			;e36d
	nop			;e36e
	nop			;e36f
	nop			;e370
	nop			;e371
	nop			;e372
	nop			;e373
	nop			;e374
	ld b,b			;e375
	ld bc,000ffh		;e376
	rlca			;e379
	inc bc			;e37a
	nop			;e37b
	nop			;e37c
	ld b,a			;e37d
	sub b			;e37e
	ld bc,00f74h		;e37f
	add a,c			;e382
	nop			;e383
	dec d			;e384
	ld bc,00214h		;e385
	ld hl,04109h		;e388
	inc d			;e38b
	ld a,(bc)			;e38c
	sbc a,c			;e38d
	inc d			;e38e
	inc de			;e38f
	pop hl			;e390
	ld (022a1h),hl		;e391
	and c			;e394
	ld (02e01h),hl		;e395
	inc bc			;e398
	nop			;e399
	rst 38h			;e39a
	add a,e			;e39b
	pop bc			;e39c
	jr nc,$+5		;e39d
	and c			;e39f
	add hl,bc			;e3a0
	pop hl			;e3a1
	ld h,h			;e3a2
	and c			;e3a3
	dec b			;e3a4
	and c			;e3a5
	ld (007a1h),a		;e3a6
	pop hl			;e3a9
	inc hl			;e3aa
	add a,c			;e3ab
	nop			;e3ac
	djnz $-93		;e3ad
	ld b,h			;e3af
	and c			;e3b0
	ld c,000h		;e3b1
	jp 00140h		;e3b3
	nop			;e3b6
	ld (01261h),hl		;e3b7
	ld hl,02109h		;e3ba
	ld de,00621h		;e3bd
	ld h,c			;e3c0
	dec (hl)			;e3c1
	ld hl,0210eh		;e3c2
	inc (hl)			;e3c5
	ld sp,hl			;e3c6
	add a,c			;e3c7
	pop bc			;e3c8
	ld d,a			;e3c9
	ex af,af'			;e3ca
	and c			;e3cb
	ld hl,00ea1h		;e3cc
	pop hl			;e3cf
	ld (03061h),a		;e3d0
	and c			;e3d3
	ld b,0a1h		;e3d4
	ld (006a1h),hl		;e3d6
	pop hl			;e3d9
	ld (008a1h),hl		;e3da
	pop hl			;e3dd
	ld de,011a1h		;e3de
	and c			;e3e1
	ld b,021h		;e3e2
	djnz $-93		;e3e4
	dec c			;e3e6
	ld hl,0a141h		;e3e7
	ld (023a1h),a		;e3ea
	ld a,c			;e3ed
	ld (de),a			;e3ee
	ld hl,0a152h		;e3ef
	ld (hl),d			;e3f2
	and c			;e3f3
	ld (bc),a			;e3f4
	add hl,sp			;e3f5
	ld (bc),a			;e3f6
	ld hl,02141h		;e3f7
	ld d,c			;e3fa
	and c			;e3fb
	inc h			;e3fc
	nop			;e3fd
	sbc a,a			;e3fe
	add a,a			;e3ff
	pop hl			;e400
	inc sp			;e401
	and c			;e402
	inc c			;e403
	and c			;e404
	ld d,l			;e405
	and c			;e406
	dec b			;e407
	pop hl			;e408
	inc hl			;e409
	and c			;e40a
	rlca			;e40b
	and c			;e40c
	ld (01021h),hl		;e40d
	add a,c			;e410
	nop			;e411
	inc d			;e412
	and c			;e413
	ld de,011e1h		;e414
	and c			;e417
	dec b			;e418
	ld h,c			;e419
	jr nz,$-93		;e41a
	rlca			;e41c
	ld hl,03900h		;e41d
	add hl,hl			;e420
	ld hl,0a130h		;e421
	rlca			;e424
	ld hl,00160h		;e425
	nop			;e428
	ld d,061h		;e429
	ld e,d			;e42b
	ld h,c			;e42c
	ld b,b			;e42d
	nop			;e42e
	and b			;e42f
	ld l,l			;e430
	ld bc,00022h		;e431
	cp c			;e434
	ld (bc),a			;e435
	ld b,c			;e436
	inc hl			;e437
	nop			;e438
	sbc a,c			;e439
	inc h			;e43a
	add hl,bc			;e43b
	ld h,c			;e43c
	sub b			;e43d
	pop hl			;e43e
	ld e,d			;e43f
	add a,c			;e440
	nop			;e441
	ld d,021h		;e442
	add a,b			;e444
	ld hl,02109h		;e445
	ld h,b			;e448
	add hl,de			;e449
	nop			;e44a
	add hl,hl			;e44b
	pop bc			;e44c
	ld (07901h),hl		;e44d
	ld d,l			;e450
	ld bc,00124h		;e451
	cp c			;e454
	call 03381h		;e455
	ld bc,03059h		;e458
	dec d			;e45b
	ld h,c			;e45c
	jr nc,$+35		;e45d
	ld b,021h		;e45f
	ld (hl),b			;e461
	sbc a,c			;e462
	inc d			;e463
	dec b			;e464
	ld h,c			;e465
	inc h			;e466
	ld hl,00033h		;e467
	rst 10h			;e46a
	ld a,d			;e46b
	ld hl,0a1e2h		;e46c
	ld b,0e1h		;e46f
	inc sp			;e471
	pop hl			;e472
	sub c			;e473
	ld h,c			;e474
	ld b,e			;e475
	ld hl,02102h		;e476
	inc sp			;e479
	ld h,c			;e47a
	ld d,e			;e47b
	pop hl			;e47c
	inc sp			;e47d
	cp c			;e47e
	ld d,e			;e47f
	ld h,c			;e480
	ld sp,033e1h		;e481
	cp c			;e484
	sub d			;e485
	ld h,c			;e486
	ld h,c			;e487
	pop hl			;e488
	ld b,h			;e489
	and c			;e48a
	inc sp			;e48b
	add hl,de			;e48c
	inc d			;e48d
	rrca			;e48e
	ld hl,0a173h		;e48f
	ld d,l			;e492
	and c			;e493
	ex af,af'			;e494
	pop hl			;e495
	ld b,h			;e496
	ld a,c			;e497
	adc a,d			;e498
	ld hl,0a152h		;e499
	ld b,(hl)			;e49c
	pop hl			;e49d
	ld b,h			;e49e
	ld a,c			;e49f
	ld (hl),h			;e4a0
	ld hl,0a162h		;e4a1
	inc de			;e4a4
	pop hl			;e4a5
	ld d,l			;e4a6
	nop			;e4a7
	jp c,02170h		;e4a8
	jr nz,$-93		;e4ab
	inc bc			;e4ad
	ld h,c			;e4ae
	inc hl			;e4af
	nop			;e4b0
	rst 18h			;e4b1
	ld (hl),b			;e4b2
	ld hl,0a120h		;e4b3
	inc bc			;e4b6
	ld h,c			;e4b7
	inc hl			;e4b8
	nop			;e4b9
	rst 30h			;e4ba
	ld a,(hl)			;e4bb
	ld hl,0a151h		;e4bc
	inc b			;e4bf
	ld h,c			;e4c0
	ld d,b			;e4c1
	ld hl,00003h		;e4c2
	rst 30h			;e4c5
	ld a,b			;e4c6
	ld hl,0a150h		;e4c7
	inc b			;e4ca
	ld h,c			;e4cb
	ld d,b			;e4cc
	ld hl,00004h		;e4cd
	rst 30h			;e4d0
	ld (hl),c			;e4d1
	ld hl,0a150h		;e4d2
	inc b			;e4d5
	ld h,c			;e4d6
	ld d,b			;e4d7
	ld hl,00003h		;e4d8
	jp z,00152h		;e4db
	dec (hl)			;e4de
	nop			;e4df
	nop			;e4e0
	rst 38h			;e4e1
	ld c,(hl)			;e4e2
	ld b,c			;e4e3
	ld sp,00000h		;e4e4
	rst 8			;e4e7
	ld h,a			;e4e8
	ld hl,0a140h		;e4e9
	inc bc			;e4ec
	ld h,c			;e4ed
	ld b,b			;e4ee
	ld hl,00003h		;e4ef
	rst 8			;e4f2
	ld h,c			;e4f3
	ld hl,0a140h		;e4f4
	inc c			;e4f7
	ld h,c			;e4f8
	ld b,b			;e4f9
	ld hl,0000ch		;e4fa
	ret c			;e4fd
	ld h,a			;e4fe
	ld hl,0a1b0h		;e4ff
	ld b,061h		;e502
	ld d,b			;e504
	ld h,c			;e505
	ld (05061h),hl		;e506
	ld hl,00003h		;e509
	jp c,0a15eh		;e50c
	dec b			;e50f
	pop hl			;e510
	ld (02261h),hl		;e511
	ld hl,00045h		;e514
	ld e,(ix-05fh)		;e517
	ld (bc),a			;e51a
	ld hl,06141h		;e51b
	ld b,d			;e51e
	nop			;e51f
	defb 0ddh,058h,021h	;illegal sequence		;e520
	ld h,h			;e523
	ld hl,0a140h		;e524
	dec b			;e527
	pop hl			;e528
	inc sp			;e529
	ld h,c			;e52a
	and b			;e52b
	ld hl,02103h		;e52c
	jr nz,$+2		;e52f
	ex de,hl			;e531
	ld l,b			;e532
	ld hl,08150h		;e533
	nop			;e536
	inc d			;e537
	ld h,c			;e538
	ld d,b			;e539
	ld bc,01400h		;e53a
	nop			;e53d
	call p,02160h		;e53e
	ld (03421h),a		;e541
	ld hl,00052h		;e544
	rst 38h			;e547
	ld h,b			;e548
	pop hl			;e549
	ld h,e			;e54a
	ld h,c			;e54b
	ld d,e			;e54c
	nop			;e54d
	rst 38h			;e54e
	ld e,c			;e54f
	ld h,c			;e550
	ld (066e1h),hl		;e551
	nop			;e554
	rst 30h			;e555
	ld c,(hl)			;e556
	pop hl			;e557
	ld d,h			;e558
	pop hl			;e559
	ld (hl),c			;e55a
	pop hl			;e55b
	inc (hl)			;e55c
	pop hl			;e55d
	ld b,l			;e55e
	ld h,c			;e55f
	ld d,l			;e560
	ld h,c			;e561
	ld (hl),d			;e562
	pop hl			;e563
	sub a			;e564
	add hl,de			;e565
	jr z,$+16		;e566
	ld hl,00044h		;e568
	ld c,(ix-05fh)		;e56b
	ex af,af'			;e56e
	and c			;e56f
	ld b,e			;e570
	ld hl,0000bh		;e571
	jp pe,0a14eh		;e574
	ld b,021h		;e577
	ld h,d			;e579
	ld hl,0c204h		;e57a
	jr $+12		;e57d
	add a,d			;e57f
	nop			;e580
	ex af,af'			;e581
	ld (bc),a			;e582
	inc c			;e583
	inc bc			;e584
	ld e,c			;e585
	dec sp			;e586
	dec bc			;e587
	and c			;e588
	adc a,b			;e589
	ld hl,0b9e0h		;e58a
	inc sp			;e58d
	ld b,c			;e58e
	inc de			;e58f
	nop			;e590
	ld h,c			;e591
	ld h,(hl)			;e592
	nop			;e593
	xor e			;e594
	ld d,h			;e595
	pop hl			;e596
	ld (hl),a			;e597
	ld h,c			;e598
	jr nz,$+59		;e599
	dec b			;e59b
	ld hl,00088h		;e59c
	ld b,a			;e59f
	sub b			;e5a0
	pop hl			;e5a1
	ld (00ca1h),hl		;e5a2
	and c			;e5a5
	ld (02001h),hl		;e5a6
	ld (bc),a			;e5a9
	nop			;e5aa
	ld d,l			;e5ab
	add a,c			;e5ac
	pop hl			;e5ad
	ld (00ca1h),hl		;e5ae
	and c			;e5b1
	ld (0b021h),hl		;e5b2
	ld a,c			;e5b5
	or b			;e5b6
	and c			;e5b7
	ld b,021h		;e5b8
	or b			;e5ba
	ld a,c			;e5bb
	or b			;e5bc
	pop hl			;e5bd
	ld (007a1h),hl		;e5be
	and c			;e5c1
	ld (0b021h),hl		;e5c2
	ld a,c			;e5c5
	or b			;e5c6
	add a,c			;e5c7
	nop			;e5c8
	ld de,0a8e1h		;e5c9
	and c			;e5cc
	inc bc			;e5cd
	and c			;e5ce
	and c			;e5cf
	and c			;e5d0
	or c			;e5d1
	ld hl,05922h		;e5d2
	dec de			;e5d5
	inc a			;e5d6
	and d			;e5d7
	djnz $+10		;e5d8
	add a,b			;e5da
	and d			;e5db
	dec d			;e5dc
	ld (de),a			;e5dd
	add a,b			;e5de
	and d			;e5df
	djnz $+26		;e5e0
	add a,b			;e5e2
	and d			;e5e3
	ld de,08030h		;e5e4
	pop hl			;e5e7
	pop af			;e5e8
	pop hl			;e5e9
	ld hl,00ba1h		;e5ea
	and c			;e5ed
	ld (003a1h),hl		;e5ee
	add a,c			;e5f1
	dec e			;e5f2
	inc bc			;e5f3
	ld e,c			;e5f4
	dec e			;e5f5
	inc bc			;e5f6
	pop hl			;e5f7
	ld (009a1h),hl		;e5f8
	and c			;e5fb
	ld (02081h),hl		;e5fc
	ld bc,02059h		;e5ff
	ld bc,006a1h		;e602
	and c			;e605
	ld de,00ba1h		;e606
	pop hl			;e609
	ld (hl),a			;e60a
	and c			;e60b
	inc bc			;e60c
	ld hl,02161h		;e60d
	ld sp,051a1h		;e610
	and c			;e613
	or d			;e614
	ld e,c			;e615
	dec d			;e616
	scf			;e617
	pop bc			;e618
	ld (hl),002h		;e619
	nop			;e61b
	nop			;e61c
	ld (hl),l			;e61d
	ld bc,00236h		;e61e
	sbc a,c			;e621
	nop			;e622
	djnz $-61		;e623
	ld (hl),002h		;e625
	nop			;e627
	nop			;e628
	ld d,(hl)			;e629
	add a,c			;e62a
	add hl,sp			;e62b
	ld (bc),a			;e62c
	ld e,c			;e62d
	inc e			;e62e
	ld (de),a			;e62f
	ld hl,0210eh		;e630
	ld (012d9h),hl		;e633
	ld de,00fa1h		;e636
	sbc a,c			;e639
	dec e			;e63a
	ld bc,00001h		;e63b
	ld (de),a			;e63e
	sbc a,c			;e63f
	ex af,af'			;e640
	ld (08261h),hl		;e641
	pop hl			;e644
	and c			;e645
	ld h,c			;e646
	ld d,d			;e647
	pop hl			;e648
	sub d			;e649
	ld b,c			;e64a
	ld (de),a			;e64b
	ld (bc),a			;e64c
	nop			;e64d
	jr $+87		;e64e
	and c			;e650
	inc hl			;e651
	pop hl			;e652
	ld h,0e1h		;e653
	ld h,000h		;e655
	ex af,af'			;e657
	ld l,a			;e658
	ld hl,0a192h		;e659
	inc sp			;e65c
	pop hl			;e65d
	inc (hl)			;e65e
	pop hl			;e65f
	add a,c			;e660
	ld h,c			;e661
	ld (02421h),a		;e662
	ld h,c			;e665
	ld b,h			;e666
	pop hl			;e667
	ld b,h			;e668
	cp c			;e669
	ld (hl),e			;e66a
	ld h,c			;e66b
	ld (044e1h),a		;e66c
	add hl,de			;e66f
	ld de,02107h		;e670
	ld b,e			;e673
	and c			;e674
	ld (hl),e			;e675
	ld sp,hl			;e676
	sub d			;e677
	ld hl,0a132h		;e678
	ld h,h			;e67b
	ld a,c			;e67c
	sub b			;e67d
	ld hl,0a131h		;e67e
	ld d,l			;e681
	ld e,c			;e682
	inc de			;e683
	ld bc,04161h		;e684
	pop hl			;e687
	inc d			;e688
	add hl,de			;e689
	daa			;e68a
	djnz $-93		;e68b
	ex af,af'			;e68d
	ld hl,02150h		;e68e
	ex af,af'			;e691
	cp c			;e692
	inc b			;e693
	ld hl,07970h		;e694
	ret nz			;e697
	ld h,c			;e698
	ld (hl),b			;e699
	pop hl			;e69a
	ld h,h			;e69b
	cp c			;e69c
	ld l,c			;e69d
	ld hl,02136h		;e69e
	ret nz			;e6a1
	and c			;e6a2
	dec h			;e6a3
	nop			;e6a4
	ld de,02162h		;e6a5
	add a,b			;e6a8
	and c			;e6a9
	ld (003a1h),hl		;e6aa
	ld h,c			;e6ad
	or b			;e6ae
	ld hl,02102h		;e6af
	inc de			;e6b2
	nop			;e6b3
	ld e,063h		;e6b4
	and c			;e6b6
	ex af,af'			;e6b7
	ld hl,02130h		;e6b8
	ex af,af'			;e6bb
	ld h,c			;e6bc
	jr nc,$+2		;e6bd
	inc h			;e6bf
	ld h,e			;e6c0
	ld hl,0a130h		;e6c1
	ld (bc),a			;e6c4
	ld h,c			;e6c5
	jr nc,$+35		;e6c6
	ld (bc),a			;e6c8
	nop			;e6c9
	inc h			;e6ca
	ld e,(hl)			;e6cb
	and c			;e6cc
	inc sp			;e6cd
	ld h,c			;e6ce
	ld b,b			;e6cf
	ld hl,00013h		;e6d0
	ld h,059h		;e6d3
	ld h,c			;e6d5
	sub b			;e6d6
	and c			;e6d7
	ld (bc),a			;e6d8
	ld hl,02190h		;e6d9
	ld (bc),a			;e6dc
	nop			;e6dd
	ld de,0a15bh		;e6de
	inc b			;e6e1
	ld hl,06130h		;e6e2
	inc sp			;e6e5
	nop			;e6e6
	ld d,05bh		;e6e7
	and c			;e6e9
	inc b			;e6ea
	ld hl,06140h		;e6eb
	ld b,h			;e6ee
	add hl,de			;e6ef
	jr $+14		;e6f0
	and c			;e6f2
	ld c,h			;e6f3
	ld hl,0f950h		;e6f4
	rla			;e6f7
	ld h,c			;e6f8
	push bc			;e6f9
	ld h,d			;e6fa
	jr z,$+2		;e6fb
	adc a,h			;e6fd
	nop			;e6fe
	ld (0a152h),hl		;e6ff
	inc c			;e702
	add hl,sp			;e703
	ld h,c			;e704
	ld hl,0610bh		;e705
	ld h,b			;e708
	nop			;e709
	inc sp			;e70a
	ld d,d			;e70b
	pop hl			;e70c
	adc a,b			;e70d
	ld hl,02140h		;e70e
	adc a,b			;e711
	ld h,c			;e712
	ld b,b			;e713
	nop			;e714
	nop			;e715
	ld d,d			;e716
	and c			;e717
	sub d			;e718
	pop hl			;e719
	dec h			;e71a
	ld hl,02180h		;e71b
	xor d			;e71e
	ld sp,hl			;e71f
	xor d			;e720
	and c			;e721
	dec b			;e722
	ld a,c			;e723
	add a,l			;e724
	and c			;e725
	inc b			;e726
	add hl,de			;e727
	ld (0210ch),a		;e728
	sub e			;e72b
	ld hl,0e10bh		;e72c
	ld (hl),a			;e72f
	ld h,c			;e730
	jr nz,$+27		;e731
	ld de,0a106h		;e733
	ld a,(bc)			;e736
	and c			;e737
	or l			;e738
	ld hl,059c0h		;e739
	rla			;e73c
	rrca			;e73d
	and c			;e73e
	adc a,b			;e73f
	ld hl,05930h		;e740
	inc de			;e743
	nop			;e744
	and c			;e745
	add hl,bc			;e746
	ld hl,02180h		;e747
	ex af,af'			;e74a
	ld a,c			;e74b
	add hl,hl			;e74c
	add a,c			;e74d
	nop			;e74e
	ld de,03079h		;e74f
	pop hl			;e752
	ld d,l			;e753
	and c			;e754
	inc b			;e755
	add hl,sp			;e756
	jr nz,$+35		;e757
	inc bc			;e759
	ld hl,01966h		;e75a
	ld b,031h		;e75d
	and c			;e75f
	dec c			;e760
	ld b,c			;e761
	jr $+2		;e762
	cp c			;e764
	ld (01701h),hl		;e765
	nop			;e768
	ld h,c			;e769
	ld (022b9h),hl		;e76a
	and c			;e76d
	ld b,099h		;e76e
	inc de			;e770
	inc b			;e771
	ld bc,00015h		;e772
	and c			;e775
	ld (00081h),hl		;e776
	djnz $-29		;e779
	ld (07061h),hl		;e77b
	ld hl,0e104h		;e77e
	add a,d			;e781
	and c			;e782
	rlca			;e783
	ld hl,02183h		;e784
	ld (bc),a			;e787
	add hl,sp			;e788
	inc b			;e789
	ld b,c			;e78a
	djnz $+2		;e78b
	cp c			;e78d
	add a,e			;e78e
	ld h,c			;e78f
	add a,b			;e790
	cp c			;e791
	add a,(hl)			;e792
	ld h,c			;e793
	ld (hl),b			;e794
	add hl,de			;e795
	ld a,(bc)			;e796
	add hl,de			;e797
	add a,c			;e798
	nop			;e799
	djnz $+99		;e79a
	ld d,l			;e79c
	ld h,c			;e79d
	ld h,b			;e79e
	add hl,de			;e79f
	rla			;e7a0
	dec bc			;e7a1
	ld hl,0a160h		;e7a2
	ld (00081h),hl		;e7a5
	ld de,091e1h		;e7a8
	add hl,de			;e7ab
	inc bc			;e7ac
	ld (de),a			;e7ad
	and c			;e7ae
	ld h,c			;e7af
	cp c			;e7b0
	inc b			;e7b1
	ld bc,00023h		;e7b2
	ld h,d			;e7b5
	ld h,000h		;e7b6
	add a,b			;e7b8
	jp po,00e3eh		;e7b9
	add a,b			;e7bc
	nop			;e7bd
	ld a,b			;e7be
	sub (hl)			;e7bf
	ld hl,06125h		;e7c0
	inc d			;e7c3
	and c			;e7c4
	ld b,c			;e7c5
	ld hl,06143h		;e7c6
	ld h,h			;e7c9
	ld hl,0a162h		;e7ca
	ld b,e			;e7cd
	and c			;e7ce
	pop bc			;e7cf
	and c			;e7d0
	dec (hl)			;e7d1
	ld hl,0a133h		;e7d2
	inc d			;e7d5
	and c			;e7d6
	ld (00000h),a		;e7d7
	sub b			;e7da
	and c			;e7db
	ld sp,015a1h		;e7dc
	and c			;e7df
	ld d,c			;e7e0
	pop hl			;e7e1
	inc hl			;e7e2
	and c			;e7e3
	ld (hl),c			;e7e4
	and c			;e7e5
	inc de			;e7e6
	and c			;e7e7
	inc sp			;e7e8
	and c			;e7e9
	dec h			;e7ea
	nop			;e7eb
	call pe,02188h		;e7ec
	scf			;e7ef
	ld hl,02181h		;e7f0
	jr z,$+35		;e7f3
	ld h,d			;e7f5
	nop			;e7f6
	rla			;e7f7
	sbc a,d			;e7f8
	inc bc			;e7f9
	dec b			;e7fa
	add hl,de			;e7fb
	ret nz			;e7fc
	dec c			;e7fd
	add a,d			;e7fe
	dec h			;e7ff
	jr $-60		;e800
	ret nc			;e802
	jr z,$-60		;e803
	ret nz			;e805
	ld h,l			;e806
	jp nz,06472h		;e807
	jp nz,06666h		;e80a
	jp nz,0665ah		;e80d
	jp po,03020h		;e810
	add a,b			;e813
	jp nz,03598h		;e814
	add hl,de			;e817
	jr z,$+8		;e818
	exx			;e81a
	xor 02dh		;e81b
	ld hl,0a162h		;e81d
	ld h,d			;e820
	ld hl,02162h		;e821
	add a,d			;e824
	and c			;e825
	ld (hl),d			;e826
	ld hl,02192h		;e827
	ld (01561h),a		;e82a
	ld h,c			;e82d
	ld (03221h),hl		;e82e
	ld hl,02112h		;e831
	ld (hl),c			;e834
	ld h,c			;e835
	dec d			;e836
	ld hl,02172h		;e837
	ld (hl),c			;e83a
	and c			;e83b
	ld (hl),d			;e83c
	ld hl,02162h		;e83d
	ld (hl),d			;e840
	and c			;e841
	ld (hl),e			;e842
	ld hl,019c2h		;e843
	add hl,de			;e846
	dec b			;e847
	ld hl,02181h		;e848
	ld (hl),c			;e84b
	and c			;e84c
	ld d,d			;e84d
	ld hl,02152h		;e84e
	and c			;e851
	and c			;e852
	add a,d			;e853
	and c			;e854
	sub c			;e855
	ld hl,0a133h		;e856
	ld d,h			;e859
	and c			;e85a
	ld c,c			;e85b
	and c			;e85c
	ld b,(hl)			;e85d
	ld hl,0a192h		;e85e
	ld h,d			;e861
	ld hl,0a164h		;e862
	out (0c2h),a		;e865
	jr $+6		;e867
	ld b,d			;e869
	ld e,b			;e86a
	dec c			;e86b
	ld b,d			;e86c
	xor b			;e86d
	inc b			;e86e
	jp nz,00ed0h		;e86f
	jp nz,011e0h		;e872
	jp nz,010e3h		;e875
	jp nz,02540h		;e878
	jp po,01030h		;e87b
	add a,d			;e87e
	ld b,d			;e87f
	ret po			;e880
	ld b,0e2h		;e881
	jr nc,$+74		;e883
	add a,d			;e885
	jp nz,04130h		;e886
	ld h,d			;e889
	jr c,$+2		;e88a
	add a,b			;e88c
	jp nz,02090h		;e88d
	ld b,d			;e890
	ld (hl),b			;e891
	add hl,bc			;e892
	ld b,d			;e893
	ld h,l			;e894
	ld c,042h		;e895
	add a,b			;e897
	ld b,059h		;e898
	ret m			;e89a
	ld (de),a			;e89b
	dec (hl)			;e89c
	adc a,l			;e89d
	ld (de),a			;e89e
	inc c			;e89f
	rra			;e8a0
	nop			;e8a1
	ld bc,0122dh		;e8a2
	nop			;e8a5
	rra			;e8a6
	nop			;e8a7
	ld bc,00112h		;e8a8
	rrca			;e8ab
	nop			;e8ac
	ld bc,00412h		;e8ad
	rlca			;e8b0
	nop			;e8b1
	ld bc,04099h		;e8b2
	dec c			;e8b5
	ld (de),a			;e8b6
	nop			;e8b7
	nop			;e8b8
	ex af,af'			;e8b9
	inc bc			;e8ba
	add hl,de			;e8bb
	sub d			;e8bc
	rlca			;e8bd
	ld (de),a			;e8be
	ld bc,01a05h		;e8bf
	ld (bc),a			;e8c2
	ld e,c			;e8c3
	pop bc			;e8c4
	nop			;e8c5
	ld a,012h		;e8c6
	ld bc,00203h		;e8c8
	ld (bc),a			;e8cb
	sbc a,c			;e8cc
	ld (hl),b			;e8cd
	ld b,b			;e8ce
	ld b,025h		;e8cf
	ld (de),a			;e8d1
	nop			;e8d2
	inc bc			;e8d3
	djnz $+12		;e8d4
	exx			;e8d6
	djnz $+13		;e8d7
	ld (de),a			;e8d9
	ld (bc),a			;e8da
	dec b			;e8db
	ld c,00bh		;e8dc
	ld sp,hl			;e8de
	push af			;e8df
	ld (de),a			;e8e0
	ld bc,00c02h		;e8e1
	inc c			;e8e4
	rlca			;e8e5
	inc bc			;e8e6
	nop			;e8e7
	nop			;e8e8
	ld h,(hl)			;e8e9
	and a			;e8ea
	ld bc,00033h		;e8eb
	and c			;e8ee
	xor 0a1h		;e8ef
	ld (bc),a			;e8f1
	ld h,c			;e8f2
	call pe,00421h		;e8f3
	and c			;e8f6
	inc b			;e8f7
	ld b,c			;e8f8
	inc sp			;e8f9
	nop			;e8fa
	ld hl,0b904h		;e8fb
	inc d			;e8fe
	and c			;e8ff
	ld a,(bc)			;e900
	ld bc,00033h		;e901
	and c			;e904
	ret c			;e905
	and c			;e906
	inc bc			;e907
	ld h,c			;e908
	rst 20h			;e909
	ld hl,07904h		;e90a
	jr nz,$+35		;e90d
	ld a,(bc)			;e90f
	cp c			;e910
	ld l,041h		;e911
	inc (hl)			;e913
	nop			;e914
	ld hl,02104h		;e915
	jr nc,$+27		;e918
	cpl			;e91a
	nop			;e91b
	cp c			;e91c
	inc b			;e91d
	add a,c			;e91e
	nop			;e91f
	ld a,(de)			;e920
	ld b,c			;e921
	scf			;e922
	nop			;e923
	add hl,de			;e924
	rlca			;e925
	ld a,(de)			;e926
	add a,c			;e927
	nop			;e928
	ld a,(de)			;e929
	add hl,de			;e92a
	ccf			;e92b
	dec e			;e92c
	and c			;e92d
	ld b,0b9h		;e92e
	inc bc			;e930
	add a,c			;e931
	nop			;e932
	ld a,(de)			;e933
	and c			;e934
	inc sp			;e935
	and c			;e936
	dec (hl)			;e937
	ld bc,00053h		;e938
	nop			;e93b
	rst 38h			;e93c
	ld c,a			;e93d
	ld b,c			;e93e
	ld d,l			;e93f
	nop			;e940
	ld b,c			;e941
	rlca			;e942
	ld e,021h		;e943
	or b			;e945
	ld a,c			;e946
	adc a,b			;e947
	ld h,c			;e948
	sub (hl)			;e949
	ld h,c			;e94a
	add a,b			;e94b
	add hl,sp			;e94c
	add a,b			;e94d
	add a,c			;e94e
	ld a,(bc)			;e94f
	ld l,021h		;e950
	ld b,d			;e952
	ld sp,hl			;e953
	ld b,d			;e954
	ld b,c			;e955
	ld a,(de)			;e956
	nop			;e957
	ld hl,0e10dh		;e958
	sub c			;e95b
	ld b,c			;e95c
	jr nc,$+2		;e95d
	ld hl,00102h		;e95f
	ld sp,0a100h		;e962
	ld (bc),a			;e965
	add hl,sp			;e966
	ld (bc),a			;e967
	ld hl,0a1a1h		;e968
	ld (bc),a			;e96b
	ld h,c			;e96c
	jr nz,$-5		;e96d
	sub c			;e96f
	and c			;e970
	ld c,021h		;e971
	sub d			;e973
	ld sp,hl			;e974
	sub d			;e975
	ld b,c			;e976
	ld l,000h		;e977
	ld hl,0390eh		;e979
	ld (bc),a			;e97c
	ld hl,00106h		;e97d
	jr nc,$+2		;e980
	ld hl,02191h		;e982
	ld (bc),a			;e985
	pop hl			;e986
	and c			;e987
	ld b,c			;e988
	jr nc,$+2		;e989
	and c			;e98b
	ld (bc),a			;e98c
	ld hl,01920h		;e98d
	dec l			;e990
	nop			;e991
	and c			;e992
	ld b,0b9h		;e993
	sub c			;e995
	add hl,sp			;e996
	ld (bc),a			;e997
	ld hl,05906h		;e998
	dec l			;e99b
	add hl,de			;e99c
	pop bc			;e99d
	add hl,bc			;e99e
	jr $-61		;e99f
	rlca			;e9a1
	ld d,021h		;e9a2
	ld h,b			;e9a4
	nop			;e9a5
	ld d,d			;e9a6
	ld d,l			;e9a7
	ld b,c			;e9a8
	ld sp,06100h		;e9a9
	dec a			;e9ac
	ld bc,02209h		;e9ad
	ld hl,0217dh		;e9b0
	rlc c		;e9b3
	inc de			;e9b5
	ld a,(bc)			;e9b6
	nop			;e9b7
	ld l,0a7h		;e9b8
	pop hl			;e9ba
	xor (hl)			;e9bb
	add a,c			;e9bc
	ld bc,02112h		;e9bd
	ld l,b			;e9c0
	ld hl,00020h		;e9c1
	ld (0e1a7h),hl		;e9c4
	inc a			;e9c7
	add a,c			;e9c8
	nop			;e9c9
	rla			;e9ca
	pop hl			;e9cb
	ld c,e			;e9cc
	pop bc			;e9cd
	dec b			;e9ce
	inc d			;e9cf
	ld b,c			;e9d0
	ld d,010h		;e9d1
	nop			;e9d3
	nop			;e9d4
	ld l,e			;e9d5
	add a,c			;e9d6
	dec d			;e9d7
	dec c			;e9d8
	add a,c			;e9d9
	inc bc			;e9da
	djnz $-93		;e9db
	rlca			;e9dd
	ld h,c			;e9de
	sub h			;e9df
	pop hl			;e9e0
	ld h,c			;e9e1
	pop hl			;e9e2
	inc hl			;e9e3
	and c			;e9e4
	ld (071a1h),a		;e9e5
	ld hl,02150h		;e9e8
	inc hl			;e9eb
	ld hl,0a183h		;e9ec
	ld (hl),d			;e9ef
	and c			;e9f0
	inc hl			;e9f1
	pop bc			;e9f2
	ld (de),a			;e9f3
	ld (bc),a			;e9f4
	ld h,c			;e9f5
	ld de,00c19h		;e9f6
	ld de,02da1h		;e9f9
	ld a,c			;e9fc
	defb 0ddh,041h,017h	;illegal sequence		;e9fd
	nop			;ea00
	nop			;ea01
	nop			;ea02
	ld h,h			;ea03
	and c			;ea04
	ld b,d			;ea05
	ld hl,03982h		;ea06
	ld (hl),021h		;ea09
	inc sp			;ea0b
	ld hl,0b961h		;ea0c
	adc a,b			;ea0f
	ld hl,0a151h		;ea10
	ld d,d			;ea13
	and c			;ea14
	dec h			;ea15
	ld hl,0a141h		;ea16
	ld h,d			;ea19
	ld hl,02173h		;ea1a
	ld h,c			;ea1d
	and c			;ea1e
	inc sp			;ea1f
	ld hl,0a142h		;ea20
	ld h,d			;ea23
	ld hl,09952h		;ea24
	ld b,017h		;ea27
	ld hl,0390eh		;ea29
	sub b			;ea2c
	and c			;ea2d
	ld c,039h		;ea2e
	ld b,b			;ea30
	ld hl,0390eh		;ea31
	ret p			;ea34
	and c			;ea35
	ld c,079h		;ea36
	ld b,b			;ea38
	ld hl,0390eh		;ea39
	ret nz			;ea3c
	and c			;ea3d
	ld c,039h		;ea3e
	dec b			;ea40
	ld h,c			;ea41
	add a,b			;ea42
	ld a,c			;ea43
	ld b,b			;ea44
	ld h,c			;ea45
	or b			;ea46
	ld a,c			;ea47
	ld b,b			;ea48
	ld h,c			;ea49
	ld d,b			;ea4a
	pop hl			;ea4b
	ld d,l			;ea4c
	ld (bc),a			;ea4d
	ld b,008h		;ea4e
	ld (bc),a			;ea50
	dec d			;ea51
	ex af,af'			;ea52
	ld (bc),a			;ea53
	jr nz,$+10		;ea54
	ld e,c			;ea56
	jr nz,$+83		;ea57
	ld hl,0212ah		;ea59
	ld d,c			;ea5c
	sbc a,c			;ea5d
	ld h,006h		;ea5e
	ld bc,00030h		;ea60
	cp c			;ea63
	ld c,041h		;ea64
	jr nc,$+2		;ea66
	exx			;ea68
	ld de,00134h		;ea69
	ld l,000h		;ea6c
	ld b,d			;ea6e
	ld a,(bc)			;ea6f
	ld bc,09121h		;ea70
	ld b,d			;ea73
	ld b,000h		;ea74
	ld b,d			;ea76
	ld (bc),a			;ea77
	ld bc,00002h		;ea78
	ld b,d			;ea7b
	ld b,d			;ea7c
	ex af,af'			;ea7d
	inc (hl)			;ea7e
	add hl,sp			;ea7f
	inc h			;ea80
	and c			;ea81
	ld c,c			;ea82
	and c			;ea83
	ld c,062h		;ea84
	ld (bc),a			;ea86
	ex af,af'			;ea87
	add a,b			;ea88
	ld e,c			;ea89
	jr c,$+34		;ea8a
	ld hl,02172h		;ea8c
	inc d			;ea8f
	ld hl,01988h		;ea90
	dec de			;ea93
	nop			;ea94
	and c			;ea95
	dec d			;ea96
	pop hl			;ea97
	ld h,039h		;ea98
	inc d			;ea9a
	and c			;ea9b
	ld d,h			;ea9c
	and c			;ea9d
	ld d,059h		;ea9e
	dec h			;eaa0
	ld (05021h),hl		;eaa1
	ld hl,02133h		;eaa4
	ld b,c			;eaa7
	ld hl,01933h		;eaa8
	rla			;eaab
	nop			;eaac
	and c			;eaad
	rla			;eaae
	and c			;eaaf
	ld (hl),e			;eab0
	and c			;eab1
	inc hl			;eab2
	ld a,c			;eab3
	ld b,h			;eab4
	pop hl			;eab5
	ld c,a			;eab6
	ld e,c			;eab7
	add hl,bc			;eab8
	ld e,021h		;eab9
	inc de			;eabb
	ld h,c			;eabc
	ld b,d			;eabd
	ld hl,09913h		;eabe
	inc sp			;eac1
	inc (hl)			;eac2
	and c			;eac3
	add hl,hl			;eac4
	pop hl			;eac5
	ld d,a			;eac6
	pop hl			;eac7
	ld h,h			;eac8
	sbc a,c			;eac9
	inc de			;eaca
	ld a,(bc)			;eacb
	ld hl,02175h		;eacc
	inc d			;eacf
	ld hl,06138h		;ead0
	ld h,l			;ead3
	ld hl,09928h		;ead4
	ld bc,0a115h		;ead7
	ld b,e			;eada
	and c			;eadb
	ld h,019h		;eadc
	jr z,$+32		;eade
	and c			;eae0
	scf			;eae1
	and c			;eae2
	ld d,a			;eae3
	ld e,c			;eae4
	sbc a,007h		;eae5
	ld h,c			;eae7
	jr nz,$-124		;eae8
	djnz $+15		;eaea
	ld b,d			;eaec
	dec bc			;eaed
	dec b			;eaee
	jp nz,00818h		;eaef
	nop			;eaf2
	jp nc,003a4h		;eaf3
	ld b,039h		;eaf6
	ld (bc),a			;eaf8
	add a,d			;eaf9
	nop			;eafa
	add hl,bc			;eafb
	add a,d			;eafc
	jr $+14		;eafd
	jp po,00e30h		;eaff
	add a,b			;eb02
	jp po,02030h		;eb03
	add a,b			;eb06
	jp po,03030h		;eb07
	add a,b			;eb0a
	jp po,01eaah		;eb0b
	add a,c			;eb0e
	jp po,038d0h		;eb0f
	add a,c			;eb12
	ld e,c			;eb13
	or b			;eb14
	ld bc,034a1h		;eb15
	ld hl,0e272h		;eb18
	ex af,af'			;eb1b
	ex af,af'			;eb1c
	add a,c			;eb1d
	sbc a,c			;eb1e
	out (038h),a		;eb1f
	ld h,c			;eb21
	ld (hl),061h		;eb22
	sub d			;eb24
	pop hl			;eb25
	add a,e			;eb26
	ld h,c			;eb27
	sub d			;eb28
	pop hl			;eb29
	sub e			;eb2a
	ld h,c			;eb2b
	inc h			;eb2c
	ld h,c			;eb2d
	ld d,d			;eb2e
	pop hl			;eb2f
	ld h,d			;eb30
	pop hl			;eb31
	ld h,e			;eb32
	ld h,c			;eb33
	sub d			;eb34
	pop hl			;eb35
	ld (hl),d			;eb36
	ld h,c			;eb37
	ld d,h			;eb38
	pop hl			;eb39
	and d			;eb3a
	add a,d			;eb3b
	jr nc,$+7		;eb3c
	sbc a,c			;eb3e
	nop			;eb3f
	daa			;eb40
	pop hl			;eb41
	defb 0ddh,059h,04ah	;illegal sequence		;eb42
	dec c			;eb45
	pop hl			;eb46
	add ix,de		;eb47
	inc de			;eb49
	dec bc			;eb4a
	pop hl			;eb4b
	cp e			;eb4c
	add hl,de			;eb4d
	add hl,sp			;eb4e
	dec bc			;eb4f
	pop hl			;eb50
	cp e			;eb51
	ld e,c			;eb52
	dec d			;eb53
	dec bc			;eb54
	pop hl			;eb55
	cp e			;eb56
	add hl,sp			;eb57
	ei			;eb58
	pop hl			;eb59
	cp e			;eb5a
	add hl,de			;eb5b
	ld d,00bh		;eb5c
	pop hl			;eb5e
	cp e			;eb5f
	add hl,sp			;eb60
	ei			;eb61
	pop hl			;eb62
	cp e			;eb63
	ld b,d			;eb64
	ld e,008h		;eb65
	ld (bc),a			;eb67
	jr nz,$+10		;eb68
	add hl,de			;eb6a
	inc de			;eb6b
	dec bc			;eb6c
	pop hl			;eb6d
	cp e			;eb6e
	ld e,c			;eb6f
	ld a,(de)			;eb70
	dec bc			;eb71
	pop hl			;eb72
	cp e			;eb73
	ld (0080bh),hl		;eb74
	add a,b			;eb77
	ld (00418h),hl		;eb78
	add a,b			;eb7b
	ld (00828h),hl		;eb7c
	add a,b			;eb7f
	ld (bc),a			;eb80
	ld b,008h		;eb81
	ld (bc),a			;eb83
	inc d			;eb84
	ex af,af'			;eb85
	ld (bc),a			;eb86
	inc h			;eb87
	add hl,bc			;eb88
	ld (bc),a			;eb89
	jr nc,$+10		;eb8a
	add hl,de			;eb8c
	ld c,a			;eb8d
	ld c,061h		;eb8e
	inc d			;eb90
	ld hl,02152h		;eb91
	ld b,b			;eb94
	ld sp,hl			;eb95
	add a,l			;eb96
	and c			;eb97
	ld (de),a			;eb98
	ld (bc),a			;eb99
	dec b			;eb9a
	ld (bc),a			;eb9b
	nop			;eb9c
	ld d,a			;eb9d
	ld h,h			;eb9e
	ld h,c			;eb9f
	dec (hl)			;eba0
	ld hl,02124h		;eba1
	inc d			;eba4
	ld h,c			;eba5
	inc hl			;eba6
	ld hl,02124h		;eba7
	ld (04221h),a		;ebaa
	ld hl,02125h		;ebad
	ld h,d			;ebb0
	jp nz,0100ch		;ebb1
	ld e,c			;ebb4
	ld h,b			;ebb5
	ld (0123dh),hl		;ebb6
	inc c			;ebb9
	rra			;ebba
	nop			;ebbb
	ld bc,0122dh		;ebbc
	ld b,00ah		;ebbf
	nop			;ebc1
	ld bc,05219h		;ebc2
	nop			;ebc5
	ld (de),a			;ebc6
	inc b			;ebc7
	ld bc,0010bh		;ebc8
	ld (de),a			;ebcb
	dec b			;ebcc
	nop			;ebcd
	dec bc			;ebce
	ld bc,057d9h		;ebcf
	ld a,012h		;ebd2
	ld bc,0000ah		;ebd4
	ex af,af'			;ebd7
	add hl,de			;ebd8
	sbc a,(hl)			;ebd9
	ld a,012h		;ebda
	nop			;ebdc
	inc c			;ebdd
	inc de			;ebde
	ld bc,05b99h		;ebdf
	add hl,bc			;ebe2
	ld (de),a			;ebe3
	inc b			;ebe4
	ld a,(bc)			;ebe5
	dec d			;ebe6
	ld (bc),a			;ebe7
	sbc a,c			;ebe8
	inc b			;ebe9
	ld hl,(00012h)		;ebea
	ld a,(bc)			;ebed
	dec d			;ebee
	rlca			;ebef
	jr $-89		;ebf0
	sbc a,l			;ebf2
	add hl,sp			;ebf3
	ret c			;ebf4
	ld a,012h		;ebf5
	ld (bc),a			;ebf7
	add hl,bc			;ebf8
	ld d,001h		;ebf9
	exx			;ebfb
	or b			;ebfc
	ld d,e			;ebfd
	dec h			;ebfe
	ld b,012h		;ebff
	nop			;ec01
	add hl,bc			;ec02
	nop			;ec03
	dec bc			;ec04
	cp c			;ec05
	ld b,012h		;ec06
	ld bc,00009h		;ec08
	inc c			;ec0b
	sbc a,c			;ec0c
	sbc a,d			;ec0d
	dec bc			;ec0e
	ld (de),a			;ec0f
	nop			;ec10
	inc c			;ec11
	inc de			;ec12
	dec c			;ec13
	add hl,de			;ec14
	ld h,b			;ec15
	ex af,af'			;ec16
	ld (de),a			;ec17
	nop			;ec18
	dec bc			;ec19
	inc d			;ec1a
	inc c			;ec1b
	ld e,c			;ec1c
	defb 0edh;next byte illegal after ed		;ec1d
	inc de			;ec1e
	ld (de),a			;ec1f
	nop			;ec20
	inc bc			;ec21
	ld bc,0070ah		;ec22
	inc bc			;ec25
	nop			;ec26
	nop			;ec27
	ld l,b			;ec28
	adc a,a			;ec29
	ld bc,00022h		;ec2a
	add a,c			;ec2d
	inc de			;ec2e
	rlca			;ec2f
	and c			;ec30
	inc c			;ec31
	ld b,c			;ec32
	inc de			;ec33
	inc bc			;ec34
	ld b,c			;ec35
	jr z,$+2		;ec36
	and c			;ec38
	ld bc,01061h		;ec39
	and c			;ec3c
	ld b,061h		;ec3d
	ld h,b			;ec3f
	and c			;ec40
	ld b,061h		;ec41
	ld h,b			;ec43
	and c			;ec44
	ld b,061h		;ec45
	ld h,b			;ec47
	and c			;ec48
	ld b,061h		;ec49
	ld h,b			;ec4b
	and c			;ec4c
	ld b,061h		;ec4d
	ld h,b			;ec4f
	and c			;ec50
	ld b,061h		;ec51
	ld h,b			;ec53
	and c			;ec54
	ld b,061h		;ec55
	ld h,b			;ec57
	and c			;ec58
	ld b,001h		;ec59
	dec de			;ec5b
	nop			;ec5c
	ld bc,0311bh		;ec5d
	nop			;ec60
	adc a,(hl)			;ec61
	ld a,(hl)			;ec62
	and c			;ec63
	ld b,021h		;ec64
	ld b,b			;ec66
	and c			;ec67
	ld b,021h		;ec68
	ld b,b			;ec6a
	and c			;ec6b
	ld b,021h		;ec6c
	ld b,b			;ec6e
	and c			;ec6f
	ld b,021h		;ec70
	ld b,b			;ec72
	and c			;ec73
	ld b,021h		;ec74
	ld b,b			;ec76
	and c			;ec77
	ld b,021h		;ec78
	ld b,b			;ec7a
	and c			;ec7b
	ld b,021h		;ec7c
	ld b,b			;ec7e
	and c			;ec7f
	ld b,041h		;ec80
	ld sp,0e100h		;ec82
	add a,e			;ec85
	ld bc,03412h		;ec86
	exx			;ec89
	ld (de),a			;ec8a
	inc (hl)			;ec8b
	ld b,c			;ec8c
	ld (02100h),hl		;ec8d
	inc sp			;ec90
	ld e,c			;ec91
	jr $+8		;ec92
	ld bc,0001bh		;ec94
	sbc a,c			;ec97
	inc hl			;ec98
	ld b,021h		;ec99
	ld b,021h		;ec9b
	jr nz,$+35		;ec9d
	ld b,021h		;ec9f
	jr nz,$+35		;eca1
	ld b,021h		;eca3
	jr nz,$+35		;eca5
	ld b,021h		;eca7
	jr nz,$+35		;eca9
	ld b,021h		;ecab
	jr nz,$+35		;ecad
	ld b,021h		;ecaf
	jr nz,$+35		;ecb1
	ld b,021h		;ecb3
	jr nz,$+35		;ecb5
	rlca			;ecb7
	cp c			;ecb8
	rlca			;ecb9
	ld hl,05990h		;ecba
	ld h,000h		;ecbd
	ld h,c			;ecbf
	add a,b			;ecc0
	ld sp,hl			;ecc1
	halt			;ecc2
	ld hl,019c0h		;ecc3
	dec e			;ecc6
	nop			;ecc7
	ld bc,00010h		;ecc8
	cp c			;eccb
	ld b,(hl)			;eccc
	ld b,c			;eccd
	rla			;ecce
	nop			;eccf
	ld e,c			;ecd0
	dec e			;ecd1
	nop			;ecd2
	ld b,c			;ecd3
	djnz $+2		;ecd4
	ld sp,hl			;ecd6
	ld d,(hl)			;ecd7
	ld bc,00011h		;ecd8
	add hl,de			;ecdb
	jr nz,$+2		;ecdc
	ld bc,0001eh		;ecde
	cp c			;ece1
	ld h,041h		;ece2
	ld (05900h),hl		;ece4
	ld hl,04100h		;ece7
	jr $+2		;ecea
	ld sp,hl			;ecec
	ld d,001h		;eced
	ld d,000h		;ecef
	add hl,de			;ecf1
	inc hl			;ecf2
	nop			;ecf3
	ld bc,00028h		;ecf4
	cp c			;ecf7
	ld h,041h		;ecf8
	dec l			;ecfa
	nop			;ecfb
	sbc a,c			;ecfc
	ld sp,02106h		;ecfd
	jp nz,0a021h		;ed00
	ld b,c			;ed03
	dec h			;ed04
	inc l			;ed05
	and c			;ed06
	add a,e			;ed07
	add a,c			;ed08
	inc h			;ed09
	add hl,hl			;ed0a
	ld h,c			;ed0b
	add a,b			;ed0c
	ld e,c			;ed0d
	inc h			;ed0e
	inc l			;ed0f
	and c			;ed10
	ld b,0a1h		;ed11
	ld h,c			;ed13
	and c			;ed14
	inc b			;ed15
	ld hl,0a130h		;ed16
	dec b			;ed19
	ld hl,0a130h		;ed1a
	ld b,021h		;ed1d
	ld b,b			;ed1f
	and c			;ed20
	dec b			;ed21
	ld hl,0a130h		;ed22
	inc b			;ed25
	ld hl,0a140h		;ed26
	dec b			;ed29
	ld hl,0a140h		;ed2a
	ex af,af'			;ed2d
	ld a,c			;ed2e
	call nz,0c421h		;ed2f
	ld a,c			;ed32
	ld b,l			;ed33
	pop hl			;ed34
	jp 04679h		;ed35
	ld hl,079c1h		;ed38
	dec (hl)			;ed3b
	ld h,c			;ed3c
	ret nc			;ed3d
	ld a,c			;ed3e
	ld b,(hl)			;ed3f
	ld hl,059c0h		;ed40
	djnz $+8		;ed43
	and c			;ed45
	or c			;ed46
	add hl,sp			;ed47
	inc b			;ed48
	ld h,c			;ed49
	di			;ed4a
	add hl,sp			;ed4b
	or e			;ed4c
	and c			;ed4d
	sub d			;ed4e
	and c			;ed4f
	inc bc			;ed50
	cp c			;ed51
	ld (de),a			;ed52
	ld hl,0a140h		;ed53
	inc b			;ed56
	ld hl,0a140h		;ed57
	dec b			;ed5a
	ld hl,0a150h		;ed5b
	dec b			;ed5e
	ld hl,0a150h		;ed5f
	ld b,021h		;ed62
	ld d,b			;ed64
	and c			;ed65
	ld b,021h		;ed66
	ld d,b			;ed68
	and c			;ed69
	dec b			;ed6a
	ld e,c			;ed6b
	jr c,$+60		;ed6c
	add a,c			;ed6e
	nop			;ed6f
	djnz $+91		;ed70
	inc hl			;ed72
	djnz $-125		;ed73
	nop			;ed75
	djnz $+59		;ed76
	inc c			;ed78
	ld bc,00023h		;ed79
	add a,c			;ed7c
	ld (de),a			;ed7d
	ld b,0b9h		;ed7e
	ld (bc),a			;ed80
	ld b,c			;ed81
	ld (de),a			;ed82
	dec b			;ed83
	ld b,c			;ed84
	inc hl			;ed85
	nop			;ed86
	cp c			;ed87
	inc b			;ed88
	ld bc,00023h		;ed89
	add a,c			;ed8c
	ld (de),a			;ed8d
	dec b			;ed8e
	cp c			;ed8f
	ld (bc),a			;ed90
	ld b,c			;ed91
	ld (de),a			;ed92
	inc b			;ed93
	ld b,c			;ed94
	inc hl			;ed95
	nop			;ed96
	exx			;ed97
	ld l,b			;ed98
	dec h			;ed99
	ld bc,00043h		;ed9a
	add hl,de			;ed9d
	ld a,e			;ed9e
	nop			;ed9f
	ld bc,00041h		;eda0
	nop			;eda3
	nop			;eda4
	sub a			;eda5
	ld hl,0a120h		;eda6
	ld h,h			;eda9
	ld hl,0a183h		;edaa
	ld sp,041a1h		;edad
	ld hl,06122h		;edb0
	ld (de),a			;edb3
	and c			;edb4
	ld (hl),d			;edb5
	and c			;edb6
	call p,0a221h		;edb7
	ld hl,02132h		;edba
	ld b,h			;edbd
	ld hl,02181h		;edbe
	ld h,e			;edc1
	ld hl,0a156h		;edc2
	ld (hl),h			;edc5
	ld hl,02182h		;edc6
	ld b,h			;edc9
	ld hl,04101h		;edca
	ld h,l			;edcd
	nop			;edce
	nop			;edcf
	or d			;edd0
	and e			;edd1
	inc bc			;edd2
	ld b,099h		;edd3
	ld (bc),a			;edd5
	jr c,$+35		;edd6
	add a,d			;edd8
	ld hl,02124h		;edd9
	ld b,c			;eddc
	and c			;eddd
	ld b,e			;edde
	and c			;eddf
	ld (05421h),a		;ede0
	ld h,c			;ede3
	inc sp			;ede4
	ld hl,0a114h		;ede5
	ld (hl),c			;ede8
	and c			;ede9
	add hl,sp			;edea
	ld hl,021b1h		;edeb
	ld h,0a1h		;edee
	ld b,c			;edf0
	and c			;edf1
	inc h			;edf2
	and c			;edf3
	ld (03221h),a		;edf4
	ld hl,0a161h		;edf7
	ld b,d			;edfa
	ld hl,05960h		;edfb
	rst 38h			;edfe
	nop			;edff
	and c			;ee00
	ld d,d			;ee01
	ld hl,02182h		;ee02
	dec b			;ee05
	ld hl,0a161h		;ee06
	inc sp			;ee09
	and c			;ee0a
	ld (hl),021h		;ee0b
	add a,e			;ee0d
	ld hl,02103h		;ee0e
	ld d,d			;ee11
	and c			;ee12
	ld h,d			;ee13
	and c			;ee14
	inc (hl)			;ee15
	ld hl,0a191h		;ee16
	ld d,d			;ee19
	ld hl,0a164h		;ee1a
	ld b,d			;ee1d
	ld hl,02152h		;ee1e
	dec h			;ee21
	and c			;ee22
	ld h,d			;ee23
	and c			;ee24
	inc d			;ee25
	jp nz,01038h		;ee26
	add a,d			;ee29
	add a,b			;ee2a
	ld de,06e99h		;ee2b
	jr $+3		;ee2e
	jr c,$+2		;ee30
	pop bc			;ee32
	jr c,$+10		;ee33
	ld (bc),a			;ee35
	djnz $+7		;ee36
	exx			;ee38
	ld d,e			;ee39
	dec b			;ee3a
	ld bc,00010h		;ee3b
	ld hl,07973h		;ee3e
	ld d,b			;ee41
	ld h,c			;ee42
	ld h,039h		;ee43
	jr nc,$+99		;ee45
	ld h,039h		;ee47
	jr nc,$+99		;ee49
	ld h,039h		;ee4b
	jr nc,$+99		;ee4d
	ld (hl),039h		;ee4f
	jr nc,$+99		;ee51
	ld h,039h		;ee53
	jr nc,$+99		;ee55
	ld h,039h		;ee57
	jr nc,$+99		;ee59
	ld d,039h		;ee5b
	jr nc,$+99		;ee5d
	daa			;ee5f
	jp nz,03208h		;ee60
	and d			;ee63
	nop			;ee64
	dec a			;ee65
	add a,d			;ee66
	jp nz,01008h		;ee67
	jp po,02e08h		;ee6a
	add a,b			;ee6d
	jp po,02808h		;ee6e
	add a,b			;ee71
	jp po,02208h		;ee72
	add a,b			;ee75
	jp po,01c07h		;ee76
	add a,b			;ee79
	jp po,01605h		;ee7a
	add a,b			;ee7d
	jp po,01103h		;ee7e
	add a,b			;ee81
	jp po,00a02h		;ee82
	add a,b			;ee85
	and d			;ee86
	nop			;ee87
	inc b			;ee88
	add a,b			;ee89
	add hl,sp			;ee8a
	ld c,b			;ee8b
	ld b,c			;ee8c
	inc hl			;ee8d
	nop			;ee8e
	cp c			;ee8f
	rlca			;ee90
	ld (00b28h),hl		;ee91
	add a,b			;ee94
	ld (00230h),hl		;ee95
	add a,b			;ee98
	ld b,d			;ee99
	ld c,b			;ee9a
	ld a,(de)			;ee9b
	ld b,d			;ee9c
	djnz $+37		;ee9d
	ld b,d			;ee9f
	ld c,a			;eea0
	rla			;eea1
	ld (bc),a			;eea2
	ld d,b			;eea3
	inc e			;eea4
	ld (bc),a			;eea5
	ld l,b			;eea6
	add hl,de			;eea7
	ld e,c			;eea8
	ld h,(hl)			;eea9
	inc h			;eeaa
	dec h			;eeab
	adc a,l			;eeac
	ld (de),a			;eead
	inc c			;eeae
	rra			;eeaf
	nop			;eeb0
	ld bc,0122dh		;eeb1
	ld (bc),a			;eeb4
	rra			;eeb5
	nop			;eeb6
	ld bc,001d9h		;eeb7
	rla			;eeba
	ld (de),a			;eebb
	ld bc,0000ch		;eebc
	inc b			;eebf
	ld (de),a			;eec0
	ld (bc),a			;eec1
	dec bc			;eec2
	nop			;eec3
	inc b			;eec4
	sbc a,c			;eec5
	nop			;eec6
	jr $+20		;eec7
	nop			;eec9
	ld a,(bc)			;eeca
	nop			;eecb
	rlca			;eecc
	ld (de),a			;eecd
	ld bc,00008h		;eece
	rlca			;eed1
	add hl,de			;eed2
	defb 0fdh,017h,012h	;illegal sequence		;eed3
	ld bc,0140bh		;eed6
	inc b			;eed9
	ld (de),a			;eeda
	inc b			;eedb
	ex af,af'			;eedc
	rla			;eedd
	inc b			;eede
	exx			;eedf
	ld c,c			;eee0
	rra			;eee1
	ld (de),a			;eee2
	ld (bc),a			;eee3
	nop			;eee4
	ld d,006h		;eee5
	ld e,c			;eee7
	ex af,af'			;eee8
	djnz $+20		;eee9
	nop			;eeeb
	nop			;eeec
	dec d			;eeed
	ld b,012h		;eeee
	ld bc,01500h		;eef0
	ld b,012h		;eef3
	nop			;eef5
	ld bc,00614h		;eef6
	ld e,c			;eef9
	add hl,de			;eefa
	djnz $+20		;eefb
	nop			;eefd
	ld bc,00412h		;eefe
	exx			;ef01
	sub e			;ef02
	dec (hl)			;ef03
	add hl,de			;ef04
	sub b			;ef05
	ld c,h			;ef06
	ld a,012h		;ef07
	ld (bc),a			;ef09
	ld a,(bc)			;ef0a
	ld (de),a			;ef0b
	ld bc,02959h		;ef0c
	nop			;ef0f
	ld (de),a			;ef10
	ld (bc),a			;ef11
	dec c			;ef12
	nop			;ef13
	ld bc,00307h		;ef14
	nop			;ef17
	nop			;ef18
	ld a,a			;ef19
	and d			;ef1a
	inc bc			;ef1b
	rlca			;ef1c
	nop			;ef1d
	add a,b			;ef1e
	and d			;ef1f
	ld b,e			;ef20
	rlca			;ef21
	nop			;ef22
	ei			;ef23
	ld c,(hl)			;ef24
	ld hl,00040h		;ef25
	nop			;ef28
	ld c,(hl)			;ef29
	ld hl,02220h		;ef2a
	nop			;ef2d
	inc bc			;ef2e
	add a,c			;ef2f
	ld (005e8h),hl		;ef30
	add a,c			;ef33
	ld (bc),a			;ef34
	ld b,b			;ef35
	ld b,002h		;ef36
	ld e,b			;ef38
	ld b,002h		;ef39
	ld d,a			;ef3b
	rlca			;ef3c
	ld (bc),a			;ef3d
	ld (hl),d			;ef3e
	rlca			;ef3f
	ld (bc),a			;ef40
	adc a,b			;ef41
	dec b			;ef42
	ld (bc),a			;ef43
	and (hl)			;ef44
	ld b,002h		;ef45
	cp h			;ef47
	dec b			;ef48
	ld (bc),a			;ef49
	ld a,h			;ef4a
	jr nz,$+2		;ef4b
	nop			;ef4d
	ld c,(hl)			;ef4e
	ld hl,08220h		;ef4f
	ex af,af'			;ef52
	dec bc			;ef53
	add a,d			;ef54
	ld a,b			;ef55
	inc c			;ef56
	add a,d			;ef57
	ret m			;ef58
	ex af,af'			;ef59
	add a,d			;ef5a
	cp b			;ef5b
	ld b,082h		;ef5c
	and b			;ef5e
	dec b			;ef5f
	add hl,de			;ef60
	nop			;ef61
	jr $+2		;ef62
	nop			;ef64
	sbc a,b			;ef65
	inc bc			;ef66
	ex af,af'			;ef67
	ld b,c			;ef68
	ld h,l			;ef69
	nop			;ef6a
	add a,d			;ef6b
	jr nc,$+18		;ef6c
	add a,d			;ef6e
	ex af,af'			;ef6f
	djnz $-124		;ef70
	ld d,010h		;ef72
	add a,d			;ef74
	ld e,b			;ef75
	inc b			;ef76
	add a,d			;ef77
	add hl,de			;ef78
	rrca			;ef79
	and d			;ef7a
	jr z,$+74		;ef7b
	add a,b			;ef7d
	and d			;ef7e
	ret nc			;ef7f
	ld c,b			;ef80
	add a,b			;ef81
	dec (hl)			;ef82
	ld (de),a			;ef83
	inc c			;ef84
	rra			;ef85
	nop			;ef86
	ld bc,0122dh		;ef87
	ld bc,0000ch		;ef8a
	ld bc,00499h		;ef8d
	ld d,012h		;ef90
	dec b			;ef92
	ld a,(bc)			;ef93
	nop			;ef94
	inc bc			;ef95
	exx			;ef96
	inc bc			;ef97
	dec hl			;ef98
	ld (de),a			;ef99
	nop			;ef9a
	dec b			;ef9b
	nop			;ef9c
	add hl,bc			;ef9d
	add hl,de			;ef9e
	ld e,b			;ef9f
	cpl			;efa0
	ld (de),a			;efa1
	nop			;efa2
	ld bc,0030bh		;efa3
	ld (de),a			;efa6
	ld bc,00b00h		;efa7
	inc bc			;efaa
	add hl,de			;efab
	djnz $+18		;efac
	ld (de),a			;efae
	nop			;efaf
	ld (de),a			;efb0
	dec c			;efb1
	ld bc,02b99h		;efb2
	ex af,af'			;efb5
	ld (de),a			;efb6
	nop			;efb7
	dec c			;efb8
	ld (de),a			;efb9
	ld (bc),a			;efba
	sbc a,c			;efbb
	ld l,b			;efbc
	ex af,af'			;efbd
	ld (de),a			;efbe
	dec b			;efbf
	ld a,(bc)			;efc0
	dec d			;efc1
	inc bc			;efc2
	ld e,c			;efc3
	ld e,b			;efc4
	nop			;efc5
	ld (de),a			;efc6
	ld bc,01400h		;efc7
	inc bc			;efca
	ld (de),a			;efcb
	nop			;efcc
	ld bc,00313h		;efcd
	ld e,c			;efd0
	dec sp			;efd1
	ex af,af'			;efd2
	ld (de),a			;efd3
	nop			;efd4
	nop			;efd5
	dec c			;efd6
	ld (bc),a			;efd7
	sbc a,c			;efd8
	ld l,e			;efd9
	scf			;efda
	ld (de),a			;efdb
	nop			;efdc
	dec b			;efdd
	ld a,(de)			;efde
	add hl,bc			;efdf
	ld a,059h		;efe0
	out (040h),a		;efe2
	ld (de),a			;efe4
	nop			;efe5
	inc c			;efe6
	nop			;efe7
	ld bc,04c99h		;efe8
	ex af,af'			;efeb
	ld (de),a			;efec
	ld bc,00009h		;efed
	ld (bc),a			;eff0
	rlca			;eff1
	ld hl,0a1c0h		;eff2
	ld de,08021h		;eff5
	and c			;eff8
	ld de,001a1h		;eff9
	pop hl			;effc
	ld de,05061h		;effd
	pop hl			;f000
	ld de,03061h		;f001
	pop hl			;f004
	ld de,07061h		;f005
	ld h,c			;f008
	ld de,03061h		;f009
	ld h,c			;f00c
	ld de,04061h		;f00d
	ld h,c			;f010
	ld de,01121h		;f011
	ld hl,02130h		;f014
	ld de,01121h		;f017
	rlca			;f01a
	pop hl			;f01b
	ld de,011a1h		;f01c
	ld hl,02120h		;f01f
	ld de,03021h		;f022
	and c			;f025
	ld de,01021h		;f026
	and c			;f029
	ld de,01121h		;f02a
	and c			;f02d
	ld h,c			;f02e
	and c			;f02f
	ld (01021h),hl		;f030
	ld hl,02111h		;f033
	djnz $-93		;f036
	ld (01121h),hl		;f038
	and c			;f03b
	ld de,02021h		;f03c
	ld hl,02111h		;f03f
	jr nz,$-93		;f042
	ld de,03021h		;f044
	and c			;f047
	ld de,03021h		;f048
	and c			;f04b
	ld de,02021h		;f04c
	and c			;f04f
	ld de,011e1h		;f050
	pop hl			;f053
	jp nz,011e1h		;f054
	ld h,c			;f057
	jp nc,02261h		;f058
	ld h,c			;f05b
	djnz $+99		;f05c
	ld (011e1h),hl		;f05e
	pop hl			;f061
	ld (hl),c			;f062
	pop hl			;f063
	inc sp			;f064
	ld h,c			;f065
	djnz $-29		;f066
	ld de,05061h		;f068
	ld h,c			;f06b
	ld de,01061h		;f06c
	pop hl			;f06f
	sub c			;f070
	ld h,c			;f071
	ld de,02061h		;f072
	ld h,c			;f075
	ld de,07161h		;f076
	ld h,c			;f079
	inc h			;f07a
	ld hl,02123h		;f07b
	ld d,c			;f07e
	ld hl,021a2h		;f07f
	add a,d			;f082
	and c			;f083
	ld (hl),d			;f084
	rlca			;f085
	ld b,c			;f086
	inc de			;f087
	nop			;f088
	and c			;f089
	ld (bc),a			;f08a
	ld bc,00013h		;f08b
	cp c			;f08e
	jr $+67		;f08f
	rra			;f091
	nop			;f092
	and c			;f093
	ld (bc),a			;f094
	ld bc,0001eh		;f095
	cp c			;f098
	ld d,041h		;f099
	inc h			;f09b
	nop			;f09c
	and c			;f09d
	rlca			;f09e
	ld h,c			;f09f
	ld d,b			;f0a0
	and c			;f0a1
	rlca			;f0a2
	ld hl,08130h		;f0a3
	nop			;f0a6
	add hl,de			;f0a7
	ld b,c			;f0a8
	dec hl			;f0a9
	nop			;f0aa
	and c			;f0ab
	inc b			;f0ac
	ld hl,08150h		;f0ad
	nop			;f0b0
	inc de			;f0b1
	add hl,de			;f0b2
	nop			;f0b3
	inc de			;f0b4
	ld bc,0004bh		;f0b5
	ld e,c			;f0b8
	jr z,$+6		;f0b9
	ld bc,00028h		;f0bb
	ld e,c			;f0be
	dec h			;f0bf
	add hl,de			;f0c0
	ld bc,00025h		;f0c1
	ld e,c			;f0c4
	inc hl			;f0c5
	rlca			;f0c6
	ld bc,00023h		;f0c7
	ld e,c			;f0ca
	inc e			;f0cb
	dec c			;f0cc
	and c			;f0cd
	ld b,019h		;f0ce
	dec bc			;f0d0
	djnz $-93		;f0d1
	ex af,af'			;f0d3
	exx			;f0d4
	ccf			;f0d5
	ld sp,01fc1h		;f0d6
	ld (de),a			;f0d9
	ld bc,00024h		;f0da
	ld e,c			;f0dd
	rra			;f0de
	inc bc			;f0df
	ld b,c			;f0e0
	dec d			;f0e1
	nop			;f0e2
	sbc a,c			;f0e3
	inc (hl)			;f0e4
	ld b,021h		;f0e5
	and b			;f0e7
	ld hl,02123h		;f0e8
	ld b,c			;f0eb
	and c			;f0ec
	ld (012a1h),a		;f0ed
	ld hl,021b0h		;f0f0
	inc hl			;f0f3
	ld hl,0a131h		;f0f4
	ld b,c			;f0f7
	and c			;f0f8
	inc hl			;f0f9
	ld bc,00011h		;f0fa
	ld hl,02124h		;f0fd
	ld b,c			;f100
	and c			;f101
	ld (022a1h),a		;f102
	and c			;f105
	ld bc,05021h		;f106
	ld e,c			;f109
	ld d,h			;f10a
	inc de			;f10b
	ld h,c			;f10c
	or d			;f10d
	pop hl			;f10e
	add a,e			;f10f
	pop hl			;f110
	inc hl			;f111
	ld h,c			;f112
	jr c,$+99		;f113
	add a,d			;f115
	pop hl			;f116
	ld h,h			;f117
	pop hl			;f118
	ld d,(hl)			;f119
	add a,d			;f11a
	djnz $+9		;f11b
	sbc a,c			;f11d
	nop			;f11e
	inc de			;f11f
	ld hl,0a1b0h		;f120
	ld (02221h),hl		;f123
	ld bc,00016h		;f126
	and c			;f129
	add a,a			;f12a
	ld hl,00176h		;f12b
	rra			;f12e
	nop			;f12f
	and c			;f130
	dec d			;f131
	ld hl,02134h		;f132
	ld (hl),b			;f135
	and c			;f136
	ld e,b			;f137
	and c			;f138
	inc b			;f139
	ld a,c			;f13a
	dec d			;f13b
	ld hl,00188h		;f13c
	djnz $+4		;f13f
	and c			;f141
	ld d,h			;f142
	ld e,c			;f143
	ld c,e			;f144
	dec d			;f145
	ld hl,02160h		;f146
	dec b			;f149
	cp c			;f14a
	add a,a			;f14b
	ld hl,0a170h		;f14c
	inc b			;f14f
	ld h,c			;f150
	and b			;f151
	ld hl,02104h		;f152
	ld d,b			;f155
	add hl,de			;f156
	djnz $+3		;f157
	ld hl,02104h		;f159
	or b			;f15c
	and c			;f15d
	inc bc			;f15e
	ld h,c			;f15f
	or b			;f160
	add hl,de			;f161
	ld a,(de)			;f162
	nop			;f163
	ld hl,0a180h		;f164
	inc bc			;f167
	ld hl,0a160h		;f168
	inc bc			;f16b
	ld h,c			;f16c
	sub b			;f16d
	ld hl,06103h		;f16e
	ld b,b			;f171
	ld hl,0b903h		;f172
	inc bc			;f175
	ld hl,05980h		;f176
	dec (hl)			;f179
	inc c			;f17a
	and c			;f17b
	ld (bc),a			;f17c
	ld hl,02180h		;f17d
	ld (bc),a			;f180
	add hl,sp			;f181
	ld h,b			;f182
	and c			;f183
	inc b			;f184
	ld e,c			;f185
	dec d			;f186
	nop			;f187
	ld hl,01904h		;f188
	inc e			;f18b
	nop			;f18c
	and c			;f18d
	ld (bc),a			;f18e
	ld hl,0a120h		;f18f
	ld (bc),a			;f192
	add hl,sp			;f193
	ret nc			;f194
	ld hl,02102h		;f195
	add a,b			;f198
	and c			;f199
	ld (bc),a			;f19a
	ld a,c			;f19b
	ld d,d			;f19c
	ld hl,03902h		;f19d
	ret nc			;f1a0
	and c			;f1a1
	ld (bc),a			;f1a2
	ld hl,0a140h		;f1a3
	ld (bc),a			;f1a6
	add hl,sp			;f1a7
	ld l,(hl)			;f1a8
	ld h,c			;f1a9
	ld d,b			;f1aa
	and c			;f1ab
	ld a,(bc)			;f1ac
	ld h,c			;f1ad
	ld b,b			;f1ae
	ld hl,02102h		;f1af
	ld b,b			;f1b2
	ld a,c			;f1b3
	jr nc,$+35		;f1b4
	ld (bc),a			;f1b6
	ld hl,06130h		;f1b7
	ld h,b			;f1ba
	ld hl,02102h		;f1bb
	jr nz,$+35		;f1be
	ld (bc),a			;f1c0
	ld hl,06140h		;f1c1
	ld (hl),b			;f1c4
	ld hl,02102h		;f1c5
	ld (hl),b			;f1c8
	ld a,c			;f1c9
	ld b,b			;f1ca
	ld hl,02102h		;f1cb
	ld b,b			;f1ce
	and c			;f1cf
	ld (bc),a			;f1d0
	ld hl,02105h		;f1d1
	jr nz,$-93		;f1d4
	dec b			;f1d6
	add hl,sp			;f1d7
	ld (bc),a			;f1d8
	ld hl,0d920h		;f1d9
	dec h			;f1dc
	dec b			;f1dd
	ld hl,02160h		;f1de
	inc b			;f1e1
	ld hl,0a180h		;f1e2
	inc b			;f1e5
	ld h,c			;f1e6
	add a,b			;f1e7
	add hl,sp			;f1e8
	ld b,b			;f1e9
	and c			;f1ea
	inc b			;f1eb
	ld h,c			;f1ec
	and b			;f1ed
	add hl,de			;f1ee
	ld a,(bc)			;f1ef
	inc d			;f1f0
	ld hl,0a160h		;f1f1
	inc b			;f1f4
	ld hl,0a170h		;f1f5
	inc b			;f1f8
	ld h,c			;f1f9
	ld (hl),b			;f1fa
	ld hl,06104h		;f1fb
	ld d,b			;f1fe
	ld hl,09904h		;f1ff
	dec de			;f202
	ld (bc),a			;f203
	ld h,c			;f204
	ld d,b			;f205
	and c			;f206
	inc bc			;f207
	ld hl,05940h		;f208
	jr z,$+12		;f20b
	ld hl,02140h		;f20d
	inc b			;f210
	cp c			;f211
	add a,e			;f212
	ld hl,0a180h		;f213
	ld (bc),a			;f216
	ld h,c			;f217
	ld (hl),b			;f218
	ld hl,0b902h		;f219
	call nz,00321h		;f21c
	ld hl,0a180h		;f21f
	inc bc			;f222
	add hl,sp			;f223
	daa			;f224
	and c			;f225
	inc bc			;f226
	ld hl,05950h		;f227
	inc hl			;f22a
	ld b,021h		;f22b
	ld h,b			;f22d
	and c			;f22e
	inc bc			;f22f
	add hl,sp			;f230
	ld d,a			;f231
	and c			;f232
	inc bc			;f233
	ld hl,021a0h		;f234
	inc bc			;f237
	cp c			;f238
	ld b,e			;f239
	ld hl,0a150h		;f23a
	ld (bc),a			;f23d
	ld h,c			;f23e
	ld h,b			;f23f
	ld hl,02102h		;f240
	jr nz,$+91		;f243
	inc de			;f245
	ex af,af'			;f246
	ld bc,0001ch		;f247
	add hl,sp			;f24a
	ld a,(de)			;f24b
	ld b,c			;f24c
	ld (de),a			;f24d
	nop			;f24e
	cp c			;f24f
	scf			;f250
	ld hl,02105h		;f251
	ld d,b			;f254
	and c			;f255
	dec b			;f256
	ld a,c			;f257
	jr nc,$+35		;f258
	dec b			;f25a
	add a,d			;f25b
	ld bc,03901h		;f25c
	inc bc			;f25f
	ld hl,03902h		;f260
	add a,b			;f263
	and c			;f264
	ld (bc),a			;f265
	cp c			;f266
	ex af,af'			;f267
	and c			;f268
	inc bc			;f269
	ld e,c			;f26a
	djnz $+2		;f26b
	ld hl,00703h		;f26d
	ld hl,0a120h		;f270
	ld h,h			;f273
	ld hl,0a183h		;f274
	ld sp,041a1h		;f277
	ld hl,06122h		;f27a
	ld (de),a			;f27d
	and c			;f27e
	ld (hl),d			;f27f
	and c			;f280
	call p,0a221h		;f281
	ld hl,02132h		;f284
	ld b,h			;f287
	ld hl,02181h		;f288
	ld h,e			;f28b
	ld hl,0a156h		;f28c
	ld (hl),h			;f28f
	ld hl,02182h		;f290
	ld b,h			;f293
	rlca			;f294
	inc bc			;f295
	nop			;f296
	nop			;f297
	rrca			;f298
	and a			;f299
	inc bc			;f29a
	inc c			;f29b
	nop			;f29c
	ret p			;f29d
	and a			;f29e
	ld b,e			;f29f
	inc c			;f2a0
	nop			;f2a1
	call c,02140h		;f2a2
	ld c,d			;f2a5
	and c			;f2a6
	ld d,l			;f2a7
	ld b,c			;f2a8
	ld (bc),a			;f2a9
	jr $-93		;f2aa
	adc a,b			;f2ac
	ld bc,01003h		;f2ad
	and c			;f2b0
	ld d,l			;f2b1
	add a,c			;f2b2
	inc bc			;f2b3
	djnz $+3		;f2b4
	inc b			;f2b6
	djnz $-93		;f2b7
	dec l			;f2b9
	and c			;f2ba
	inc (hl)			;f2bb
	jp nz,00808h		;f2bc
	ld b,d			;f2bf
	ld c,000h		;f2c0
	ld b,d			;f2c2
	jr $+2		;f2c3
	jp nz,0081eh		;f2c5
	nop			;f2c8
	ld (hl),a			;f2c9
	ld a,a			;f2ca
	inc bc			;f2cb
	dec c			;f2cc
	nop			;f2cd
	adc a,c			;f2ce
	ld a,a			;f2cf
	ld b,e			;f2d0
	dec c			;f2d1
	nop			;f2d2
	jr $+105		;f2d3
	inc bc			;f2d5
	ld c,000h		;f2d6
	jr nz,$+82		;f2d8
	pop hl			;f2da
	cp e			;f2db
	ld bc,00018h		;f2dc
	ld h,c			;f2df
	call z,022e1h		;f2e0
	nop			;f2e3
	rlca			;f2e4
	ld h,a			;f2e5
	ld h,c			;f2e6
	jr nz,$-125		;f2e7
	nop			;f2e9
	ld hl,02021h		;f2ea
	ld bc,02100h		;f2ed
	cp c			;f2f0
	inc b			;f2f1
	ld hl,0a130h		;f2f2
	rlca			;f2f5
	ld h,c			;f2f6
	sub b			;f2f7
	ld hl,02107h		;f2f8
	add a,b			;f2fb
	jp nz,00301h		;f2fc
	jp nz,00206h		;f2ff
	jp nz,00103h		;f302
	nop			;f305
	ld b,c			;f306
	ld h,e			;f307
	pop bc			;f308
	inc bc			;f309
	jr $+67		;f30a
	rlca			;f30c
	jr $+35		;f30d
	and a			;f30f
	and c			;f310
	ex af,af'			;f311
	nop			;f312
	ld b,c			;f313
	ld b,b			;f314
	ld hl,06148h		;f315
	ld hl,(03462h)		;f318
	nop			;f31b
	add a,b			;f31c
	ld (018adh),hl		;f31d
	add a,b			;f320
	ld (04848h),hl		;f321
	adc a,h			;f324
	ld (bc),a			;f325
	inc sp			;f326
	dec h			;f327
	ld (bc),a			;f328
	ld b,l			;f329
	dec h			;f32a
	nop			;f32b
	add a,l			;f32c
	ld l,d			;f32d
	ld h,c			;f32e
	add a,b			;f32f
	jp nz,00201h		;f330
	add a,d			;f333
	ex af,af'			;f334
	ld (bc),a			;f335
	jp po,00858h		;f336
	add a,b			;f339
	jp nz,0045fh		;f33a
	jp nz,02058h		;f33d
	jp po,00840h		;f340
	add a,b			;f343
	nop			;f344
	ld e,b			;f345
	sub b			;f346
	ld bc,0004fh		;f347
	jp po,00310h		;f34a
	add a,e			;f34d
	and d			;f34e
	jr $+42		;f34f
	add a,h			;f351
	and d			;f352
	jr nc,$+42		;f353
	add a,a			;f355
	and d			;f356
	ld d,b			;f357
	jr z,$-118		;f358
	add hl,de			;f35a
	ld d,a			;f35b
	inc d			;f35c
	dec (hl)			;f35d
	ld (de),a			;f35e
	inc c			;f35f
	rra			;f360
	nop			;f361
	ld bc,0a4d9h		;f362
	rla			;f365
	dec l			;f366
	ld (de),a			;f367
	add hl,bc			;f368
	add hl,bc			;f369
	dec bc			;f36a
	inc b			;f36b
	sbc a,c			;f36c
	ld e,b			;f36d
	ld c,d			;f36e
	dec a			;f36f
	ld (de),a			;f370
	add hl,bc			;f371
	ld bc,00415h		;f372
	ld e,c			;f375
	ld h,l			;f376
	ld c,e			;f377
	ld (de),a			;f378
	add hl,bc			;f379
	ld bc,00409h		;f37a
	ld e,c			;f37d
	ld a,(bc)			;f37e
	inc de			;f37f
	ld (de),a			;f380
	ld (bc),a			;f381
	rrca			;f382
	ex af,af'			;f383
	ld bc,00307h		;f384
	nop			;f387
	nop			;f388
	rst 28h			;f389
	and a			;f38a
	add a,c			;f38b
	nop			;f38c
	ld h,a			;f38d
	nop			;f38e
	ret nz			;f38f
	ld b,b			;f390
	ld bc,06700h		;f391
	ld b,c			;f394
	ret nz			;f395
	nop			;f396
	ld bc,000ffh		;f397
	ld a,c			;f39a
	add a,b			;f39b
	add a,c			;f39c
	nop			;f39d
	ld c,e			;f39e
	and c			;f39f
	add a,d			;f3a0
	ld a,c			;f3a1
	add a,d			;f3a2
	pop bc			;f3a3
	inc b			;f3a4
	inc e			;f3a5
	add hl,de			;f3a6
	inc b			;f3a7
	inc e			;f3a8
	ld h,c			;f3a9
	add a,d			;f3aa
	nop			;f3ab
	ret nz			;f3ac
	ld h,e			;f3ad
	ld b,c			;f3ae
	ld (00107h),a		;f3af
	nop			;f3b2
	dec a			;f3b3
	ld a,c			;f3b4
	or b			;f3b5
	add a,c			;f3b6
	nop			;f3b7
	ld b,d			;f3b8
	ld hl,0f9b5h		;f3b9
	or l			;f3bc
	ld b,c			;f3bd
	dec d			;f3be
	inc bc			;f3bf
	ld bc,03f00h		;f3c0
	sbc a,c			;f3c3
	nop			;f3c4
	add hl,sp			;f3c5
	ld b,c			;f3c6
	rra			;f3c7
	dec b			;f3c8
	ld bc,03400h		;f3c9
	sbc a,c			;f3cc
	nop			;f3cd
	inc (hl)			;f3ce
	pop bc			;f3cf
	ld h,00bh		;f3d0
	ld bc,03900h		;f3d2
	ld hl,05966h		;f3d5
	daa			;f3d8
	nop			;f3d9
	and c			;f3da
	ld h,(hl)			;f3db
	ld bc,0001bh		;f3dc
	ld e,c			;f3df
	dec de			;f3e0
	nop			;f3e1
	add a,c			;f3e2
	nop			;f3e3
	ld e,c			;f3e4
	ld h,c			;f3e5
	jr nc,$-29		;f3e6
	inc sp			;f3e8
	and c			;f3e9
	dec b			;f3ea
	add hl,sp			;f3eb
	dec b			;f3ec
	ld bc,00029h		;f3ed
	and c			;f3f0
	dec b			;f3f1
	add hl,sp			;f3f2
	dec b			;f3f3
	ld h,c			;f3f4
	inc sp			;f3f5
	ld b,c			;f3f6
	jr nz,$+2		;f3f7
	add hl,de			;f3f9
	dec de			;f3fa
	jr z,$-125		;f3fb
	nop			;f3fd
	jr z,$+2		;f3fe
	nop			;f400
	ld e,e			;f401
	ld hl,019e4h		;f402
	adc a,h			;f405
	ld c,b			;f406
	add a,c			;f407
	nop			;f408
	ccf			;f409
	pop bc			;f40a
	rla			;f40b
	inc bc			;f40c
	add hl,de			;f40d
	ld e,042h		;f40e
	add a,c			;f410
	nop			;f411
	ld b,b			;f412
	pop bc			;f413
	ld a,(01927h)		;f414
	ld sp,00100h		;f417
	inc h			;f41a
	inc h			;f41b
	ld bc,04300h		;f41c
	exx			;f41f
	adc a,e			;f420
	ld h,a			;f421
	ld bc,0264ah		;f422
	ld e,c			;f425
	inc de			;f426
	ld b,c			;f427
	add a,c			;f428
	nop			;f429
	jr c,$-61		;f42a
	ccf			;f42c
	rla			;f42d
	add hl,de			;f42e
	dec b			;f42f
	ld c,a			;f430
	add a,c			;f431
	nop			;f432
	ld a,022h		;f433
	ex af,af'			;f435
	djnz $-123		;f436
	ld (0183ch),hl		;f438
	add a,e			;f43b
	ld (00080h),hl		;f43c
	add a,e			;f43f
	ld h,d			;f440
	ld hl,(08300h)		;f441
	add a,c			;f444
	rra			;f445
	inc b			;f446
	exx			;f447
	inc e			;f448
	ld a,(bc)			;f449
	add a,c			;f44a
	dec l			;f44b
	inc b			;f44c
	add hl,de			;f44d
	ld (de),a			;f44e
	add hl,bc			;f44f
	add a,c			;f450
	jr nz,$+6		;f451
	exx			;f453
	dec d			;f454
	rrca			;f455
	add a,c			;f456
	inc h			;f457
	ld b,019h		;f458
	ld hl,0c10fh		;f45a
	ld (hl),h			;f45d
	ld d,019h		;f45e
	ld (hl),h			;f460
	dec b			;f461
	pop bc			;f462
	dec de			;f463
	dec b			;f464
	add hl,de			;f465
	ld c,01bh		;f466
	and c			;f468
	jp nc,0b2d9h		;f469
	dec bc			;f46c
	pop hl			;f46d
	and 039h		;f46e
	ex af,af'			;f470
	and c			;f471
	or e			;f472
	nop			;f473
	nop			;f474
	ld (hl),d			;f475
	ld hl,000e3h		;f476
	nop			;f479
	sbc a,(hl)			;f47a
	ld hl,099e2h		;f47b
	dec de			;f47e
	djnz $+35		;f47f
	ld d,b			;f481
	add hl,de			;f482
	nop			;f483
	djnz $+3		;f484
	ld hl,08102h		;f486
	add hl,de			;f489
	ld (bc),a			;f48a
	exx			;f48b
	ld a,(00124h)		;f48c
	ld hl,08107h		;f48f
	add hl,de			;f492
	inc bc			;f493
	add hl,de			;f494
	nop			;f495
	inc de			;f496
	and c			;f497
	ld h,c			;f498
	add hl,sp			;f499
	ld a,(bc)			;f49a
	add a,c			;f49b
	dec d			;f49c
	ld (bc),a			;f49d
	sbc a,c			;f49e
	nop			;f49f
	inc h			;f4a0
	ld b,c			;f4a1
	dec d			;f4a2
	ld (bc),a			;f4a3
	ld (00018h),hl		;f4a4
	add a,b			;f4a7
	ld (bc),a			;f4a8
	jr z,$+2		;f4a9
	add a,d			;f4ab
	jr nz,$+18		;f4ac
	sbc a,c			;f4ae
	inc l			;f4af
	inc b			;f4b0
	and c			;f4b1
	ld (hl),c			;f4b2
	ld e,c			;f4b3
	rlca			;f4b4
	daa			;f4b5
	and c			;f4b6
	ld (hl),c			;f4b7
	cp c			;f4b8
	dec bc			;f4b9
	add a,c			;f4ba
	dec de			;f4bb
	ld (bc),a			;f4bc
	add hl,sp			;f4bd
	add hl,bc			;f4be
	and c			;f4bf
	ld b,c			;f4c0
	sbc a,c			;f4c1
	nop			;f4c2
	ld (04261h),hl		;f4c3
	ld e,c			;f4c6
	sbc a,l			;f4c7
	inc sp			;f4c8
	nop			;f4c9
	inc hl			;f4ca
	and a			;f4cb
	pop hl			;f4cc
	ld h,(hl)			;f4cd
	add a,c			;f4ce
	nop			;f4cf
	ld e,c			;f4d0
	and c			;f4d1
	inc sp			;f4d2
	and c			;f4d3
	dec b			;f4d4
	ld (bc),a			;f4d5
	inc bc			;f4d6
	ld h,e			;f4d7
	ld (02000h),hl		;f4d8
	add a,b			;f4db
	ld (bc),a			;f4dc
	ex af,af'			;f4dd
	ld b,022h		;f4de
	ex af,af'			;f4e0
	ld (bc),a			;f4e1
	add a,b			;f4e2
	ld (0013fh),hl		;f4e3
	add a,b			;f4e6
	ld (00260h),hl		;f4e7
	add a,b			;f4ea
	ld (00c80h),hl		;f4eb
	add a,b			;f4ee
	ld (00890h),hl		;f4ef
	add a,b			;f4f2
	ld (bc),a			;f4f3
	out (018h),a		;f4f4
	ld (bc),a			;f4f6
	out (038h),a		;f4f7
	ld (028dbh),hl		;f4f9
	add a,e			;f4fc
	ld (008d8h),hl		;f4fd
	add a,b			;f500
	ld e,c			;f501
	ld a,(de)			;f502
	inc (hl)			;f503
	ld h,c			;f504
	jr z,$+35		;f505
	inc sp			;f507
	ld sp,hl			;f508
	inc sp			;f509
	ld h,c			;f50a
	ld hl,(04699h)		;f50b
	inc b			;f50e
	and c			;f50f
	inc sp			;f510
	ld hl,0e120h		;f511
	ld h,019h		;f514
	ld (de),a			;f516
	jr z,$+35		;f517
	ld (bc),a			;f519
	ld h,c			;f51a
	ld (01121h),hl		;f51b
	sbc a,c			;f51e
	ld (de),a			;f51f
	jr z,$+35		;f520
	add a,(hl)			;f522
	ld h,c			;f523
	rla			;f524
	cp c			;f525
	rla			;f526
	ld hl,09985h		;f527
	inc sp			;f52a
	inc h			;f52b
	ld h,c			;f52c
	ld d,061h		;f52d
	ld b,h			;f52f
	ld hl,0f95ah		;f530
	dec h			;f533
	ld h,c			;f534
	ld c,d			;f535
	ld e,c			;f536
	xor b			;f537
	ld h,02dh		;f538
	adc a,l			;f53a
	ld (de),a			;f53b
	inc c			;f53c
	rra			;f53d
	nop			;f53e
	ld bc,0c019h		;f53f
	nop			;f542
	dec a			;f543
	ld (de),a			;f544
	inc c			;f545
	dec b			;f546
	jr $+3		;f547
	ld e,c			;f549
	ld d,b			;f54a
	nop			;f54b
	ld (de),a			;f54c
	ld b,002h		;f54d
	ld c,001h		;f54f
	exx			;f551
	ld bc,01238h		;f552
	nop			;f555
	ld (bc),a			;f556
	ld c,008h		;f557
	ld e,c			;f559
	ld h,d			;f55a
	inc sp			;f55b
	ld (de),a			;f55c
	dec bc			;f55d
	ld bc,00202h		;f55e
	exx			;f561
	inc b			;f562
	ld e,l			;f563
	ld (de),a			;f564
	nop			;f565
	nop			;f566
	ld bc,0070dh		;f567
	rlca			;f56a
	add a,c			;f56b
	nop			;f56c
	ld (03b01h),a		;f56d
	nop			;f570
	and c			;f571
	ld (bc),a			;f572
	ld hl,0a120h		;f573
	inc bc			;f576
	ld h,c			;f577
	jr nz,$-93		;f578
	rrca			;f57a
	ld hl,0a120h		;f57b
	inc bc			;f57e
	ld h,c			;f57f
	jr nz,$-93		;f580
	inc c			;f582
	ld hl,0a120h		;f583
	inc bc			;f586
	ld h,c			;f587
	jr nz,$-93		;f588
	rrca			;f58a
	add hl,de			;f58b
	ld (hl),064h		;f58c
	ld b,c			;f58e
	ld a,000h		;f58f
	pop hl			;f591
	inc sp			;f592
	and c			;f593
	dec c			;f594
	and c			;f595
	inc sp			;f596
	ld bc,00016h		;f597
	and c			;f59a
	rrca			;f59b
	ld h,c			;f59c
	jr nz,$-93		;f59d
	inc bc			;f59f
	ld hl,0a120h		;f5a0
	inc c			;f5a3
	ld h,c			;f5a4
	jr nz,$-93		;f5a5
	inc bc			;f5a7
	ld hl,0a120h		;f5a8
	rrca			;f5ab
	ld h,c			;f5ac
	jr nz,$-93		;f5ad
	inc bc			;f5af
	ld hl,0a120h		;f5b0
	inc c			;f5b3
	ld h,c			;f5b4
	jr nz,$-93		;f5b5
	inc bc			;f5b7
	ld hl,0a120h		;f5b8
	rrca			;f5bb
	ld e,c			;f5bc
	ld c,051h		;f5bd
	and c			;f5bf
	rrca			;f5c0
	ld hl,0a120h		;f5c1
	inc bc			;f5c4
	ld h,c			;f5c5
	jr nz,$-93		;f5c6
	ld a,(bc)			;f5c8
	cp c			;f5c9
	rlca			;f5ca
	ld b,c			;f5cb
	ld c,d			;f5cc
	nop			;f5cd
	add hl,de			;f5ce
	jr $+9		;f5cf
	ld b,c			;f5d1
	jr $+2		;f5d2
	add hl,de			;f5d4
	ld c,d			;f5d5
	dec c			;f5d6
	ld hl,0b9c0h		;f5d7
	inc bc			;f5da
	ld h,c			;f5db
	and b			;f5dc
	cp c			;f5dd
	inc c			;f5de
	ld hl,0b9a0h		;f5df
	inc bc			;f5e2
	ld h,c			;f5e3
	and b			;f5e4
	cp c			;f5e5
	rrca			;f5e6
	ld hl,0b9a0h		;f5e7
	inc bc			;f5ea
	ld h,c			;f5eb
	and b			;f5ec
	cp c			;f5ed
	inc c			;f5ee
	ld hl,0b9a0h		;f5ef
	inc bc			;f5f2
	ld h,c			;f5f3
	and b			;f5f4
	add hl,de			;f5f5
	nop			;f5f6
	ld b,d			;f5f7
	ld bc,00033h		;f5f8
	ld e,c			;f5fb
	ld (hl),b			;f5fc
	ld (de),a			;f5fd
	pop hl			;f5fe
	ld b,h			;f5ff
	and c			;f600
	ld b,h			;f601
	ld a,c			;f602
	ld b,h			;f603
	ld h,c			;f604
	or b			;f605
	cp c			;f606
	call m,044e1h		;f607
	and c			;f60a
	ld b,h			;f60b
	ld a,c			;f60c
	ld b,h			;f60d
	ld h,c			;f60e
	or b			;f60f
	cp c			;f610
	pop iy		;f611
	ld b,h			;f613
	and c			;f614
	ld b,h			;f615
	ld a,c			;f616
	ld b,h			;f617
	ld h,c			;f618
	or b			;f619
	add hl,de			;f61a
	rrca			;f61b
	add hl,hl			;f61c
	ld h,c			;f61d
	ret p			;f61e
	ld bc,00010h		;f61f
	ld sp,hl			;f622
	dec de			;f623
	and c			;f624
	ld b,h			;f625
	pop hl			;f626
	ld b,h			;f627
	add hl,sp			;f628
	ld b,h			;f629
	ld bc,0002ch		;f62a
	ld b,c			;f62d
	dec e			;f62e
	nop			;f62f
	add hl,sp			;f630
	nop			;f631
	pop hl			;f632
	inc sp			;f633
	ld h,c			;f634
	inc sp			;f635
	cp c			;f636
	inc sp			;f637
	and c			;f638
	dec c			;f639
	pop hl			;f63a
	inc sp			;f63b
	add hl,sp			;f63c
	inc sp			;f63d
	and c			;f63e
	inc sp			;f63f
	ld b,c			;f640
	djnz $+2		;f641
	ld h,c			;f643
	inc sp			;f644
	cp c			;f645
	inc sp			;f646
	pop hl			;f647
	inc sp			;f648
	add hl,sp			;f649
	inc sp			;f64a
	ld bc,00035h		;f64b
	ld hl,0f933h		;f64e
	inc sp			;f651
	and c			;f652
	inc sp			;f653
	ld e,c			;f654
	jr $+24		;f655
	ld hl,0a133h		;f657
	inc sp			;f65a
	ld a,c			;f65b
	inc sp			;f65c
	ld hl,0410ch		;f65d
	dec h			;f660
	nop			;f661
	ld bc,0003fh		;f662
	and c			;f665
	inc bc			;f666
	add hl,sp			;f667
	inc bc			;f668
	ld bc,00030h		;f669
	ld e,c			;f66c
	jr $+2		;f66d
	and c			;f66f
	inc bc			;f670
	add hl,de			;f671
	inc d			;f672
	nop			;f673
	ld hl,0d903h		;f674
	ld c,(hl)			;f677
	ld (033a1h),hl		;f678
	ld hl,0f933h		;f67b
	inc sp			;f67e
	and c			;f67f
	dec c			;f680
	ld b,c			;f681
	inc e			;f682
	nop			;f683
	add hl,sp			;f684
	nop			;f685
	and c			;f686
	rlca			;f687
	add hl,de			;f688
	djnz $+2		;f689
	ld hl,01907h		;f68b
	dec de			;f68e
	nop			;f68f
	and c			;f690
	rlca			;f691
	ld e,c			;f692
	inc sp			;f693
	nop			;f694
	add a,c			;f695
	nop			;f696
	ld l,039h		;f697
	ld d,b			;f699
	ld bc,02e00h		;f69a
	add hl,de			;f69d
	ld e,000h		;f69e
	add a,c			;f6a0
	nop			;f6a1
	ld l,039h		;f6a2
	ld b,b			;f6a4
	ld bc,02e00h		;f6a5
	ld (01820h),hl		;f6a8
	add a,b			;f6ab
	ld (00820h),hl		;f6ac
	add a,b			;f6af
	and d			;f6b0
	jr nz,$+10		;f6b1
	add a,b			;f6b3
	and d			;f6b4
	jr nz,$+26		;f6b5
	add a,b			;f6b7
	and d			;f6b8
	jr nz,$+42		;f6b9
	add a,b			;f6bb
	ld (bc),a			;f6bc
	jr nz,$+21		;f6bd
	ld (bc),a			;f6bf
	jr nz,$+6		;f6c0
	add a,d			;f6c2
	jr nz,$+16		;f6c3
	add a,d			;f6c5
	inc e			;f6c6
	dec e			;f6c7
	jp po,01002h		;f6c8
	add a,b			;f6cb
	ld (bc),a			;f6cc
	ld (bc),a			;f6cd
	dec hl			;f6ce
	ld b,d			;f6cf
	inc bc			;f6d0
	ld d,042h		;f6d1
	inc d			;f6d3
	jr $+68		;f6d4
	inc d			;f6d6
	add hl,hl			;f6d7
	ld b,d			;f6d8
	inc hl			;f6d9
	rla			;f6da
	ld b,d			;f6db
	dec h			;f6dc
	djnz $+68		;f6dd
	ld (0422ah),hl		;f6df
	dec h			;f6e2
	jr nz,$+68		;f6e3
	ld h,031h		;f6e5
	rlca			;f6e7
	and c			;f6e8
	dec b			;f6e9
	ld hl,0a130h		;f6ea
	dec bc			;f6ed
	ld hl,0a120h		;f6ee
	inc sp			;f6f1
	and c			;f6f2
	ld (bc),a			;f6f3
	ld h,c			;f6f4
	ld b,b			;f6f5
	pop hl			;f6f6
	ld de,005a1h		;f6f7
	and c			;f6fa
	ld de,05021h		;f6fb
	ld e,c			;f6fe
	ld b,012h		;f6ff
	ld h,c			;f701
	sub b			;f702
	ld h,c			;f703
	ld (06021h),hl		;f704
	ld hl,02107h		;f707
	jr nz,$-69		;f70a
	inc (hl)			;f70c
	ld hl,02122h		;f70d
	ld b,b			;f710
	exx			;f711
	inc b			;f712
	inc d			;f713
	ld hl,07940h		;f714
	jr nc,$-93		;f717
	inc bc			;f719
	ld hl,07930h		;f71a
	ld e,(hl)			;f71d
	ld hl,00730h		;f71e
	pop hl			;f721
	inc sp			;f722
	and c			;f723
	dec bc			;f724
	and c			;f725
	inc sp			;f726
	ld bc,00011h		;f727
	ld hl,02133h		;f72a
	dec bc			;f72d
	ld h,c			;f72e
	inc sp			;f72f
	ld b,c			;f730
	djnz $+2		;f731
	cp c			;f733
	inc bc			;f734
	ld hl,0a1e0h		;f735
	ld (007a1h),hl		;f738
	pop hl			;f73b
	ld (0d061h),hl		;f73c
	ld h,c			;f73f
	ld (00721h),hl		;f740
	ld hl,00722h		;f743
	rlca			;f746
	rlca			;f747
	rlca			;f748
	rlca			;f749
	rlca			;f74a
	rlca			;f74b
	ld (hl),e			;f74c
	ex (sp),hl			;f74d
	ld a,d			;f74e
	ex (sp),hl			;f74f
	and 0e8h		;f750
	dec h			;f752
	call pe,0ef16h		;f753
	jp p,01befh		;f756
	ret p			;f759
	add a,(hl)			;f75a
	ret p			;f75b
	ld (hl),b			;f75c
	jp p,0f295h		;f75d
	add a,(hl)			;f760
	di			;f761
	ld l,d			;f762
	push af			;f763
	ld l,e			;f764
	push af			;f765
	ret pe			;f766
	or 021h		;f767
	rst 30h			;f769
	ld b,(hl)			;f76a
	rst 30h			;f76b
	ld b,a			;f76c
	rst 30h			;f76d
	ld c,b			;f76e
	rst 30h			;f76f
	ld c,c			;f770
	rst 30h			;f771
	ld c,d			;f772
	rst 30h			;f773
	ld c,e			;f774
	rst 30h			;f775
	ld c,h			;f776
	rst 30h			;f777
	rst 38h			;f778
	rst 38h			;f779
	rlca			;f77a
	nop			;f77b
	nop			;f77c
	inc c			;f77d
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
	ld hl,(00007h)		;f792
	nop			;f795
	inc c			;f796
	ld hl,(00007h)		;f797
	nop			;f79a
	inc c			;f79b
	ld hl,(00007h)		;f79c
	nop			;f79f
	inc c			;f7a0
	ld hl,(00007h)		;f7a1
	nop			;f7a4
	inc c			;f7a5
	ld hl,(00180h)		;f7a6
	nop			;f7a9
	dec c			;f7aa
	ld hl,(00180h)		;f7ab
	nop			;f7ae
	dec c			;f7af
	ld hl,(00007h)		;f7b0
	nop			;f7b3
	inc c			;f7b4
	ld hl,(00007h)		;f7b5
	nop			;f7b8
	inc c			;f7b9
	ld hl,(00007h)		;f7ba
	nop			;f7bd
	inc c			;f7be
	ld hl,(00007h)		;f7bf
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
	nop			;fc05
	jr nz,$+66		;fc06
	cp b			;fc08
	adc a,b			;fc09
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
	ld (hl),e			;ffef
	ex (sp),hl			;fff0
	ld c,h			;fff1
	rst 30h			;fff2
	ld a,d			;fff3
	rst 30h			;fff4
	ex (sp),hl			;fff5
	rst 30h			;fff6
	call po,0e4f7h		;fff7
	rst 38h			;fffa
	rst 38h			;fffb
	rst 38h			;fffc
	dec d			;fffd
	nop			;fffe
	nop			;ffff
