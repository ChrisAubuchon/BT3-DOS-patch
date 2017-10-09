; Segment type:	Pure code
seg017 segment word public 'CODE' use16
	assume cs:seg017
;org 3
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_263E3:
align 2
; Attributes: bp-based frame

transferCharacter proc far

	var_4= word ptr	-4

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
loc_263EF:
	mov	ax, offset aTransferCharac
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 3Ch	
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_4], ax
	cmp	ax, 110h
	jl	short loc_2641A
	cmp	ax, 112h
	jg	short loc_2641A
	sub	[bp+var_4], 0DFh 
loc_2641A:
	mov	ax, [bp+var_4]
	jmp	short loc_26442
loc_2641F:
	jmp	short loc_26464
loc_26421:
	push	cs
	call	near ptr getTransferCharacters
	jmp	short loc_26462
loc_26427:
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr importCharacter
	add	sp, 2
	jmp	short loc_26462
loc_26434:
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr importCharacter
	add	sp, 2
loc_2643E:
	jmp	short loc_26462
	jmp	short loc_26462
loc_26442:
	cmp	ax, 1Bh
	jz	short loc_2641F
	cmp	ax, 31h	
	jz	short loc_26434
	cmp	ax, 32h	
	jz	short loc_26427
	cmp	ax, 33h	
	jz	short loc_26421
	cmp	ax, 45h	
	jz	short loc_2641F
	cmp	ax, 113h
	jz	short loc_2641F
	jmp	short loc_2643E
loc_26462:
	jmp	short loc_263EF
loc_26464:
	mov	sp, bp
	pop	bp
	retf
transferCharacter endp

; Attributes: bp-based frame

getTransferCharacters proc far

	var_1CA= dword ptr -1CAh
	var_1C6= word ptr -1C6h
	var_1C4= word ptr -1C4h
	var_1C2= word ptr -1C2h
	var_1C0= word ptr -1C0h
	var_1BC= word ptr -1BCh
	var_1BA= dword ptr -1BAh
	var_1B6= word ptr -1B6h
	var_1B4= word ptr -1B4h
	var_182= word ptr -182h
	var_180= word ptr -180h
	var_17E= word ptr -17Eh
	var_17C= word ptr -17Ch
	var_17A= dword ptr -17Ah
	var_26=	word ptr -26h
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh

	push	bp
	mov	bp, sp
	mov	ax, 1CAh
	call	someStackOperation
	push	si
	mov	ax, 9000
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_1C6], ax
	mov	[bp+var_1C4], dx
	mov	ax, 500h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_180], ax
	mov	[bp+var_17E], dx
loc_2649C:
	mov	ax, offset aDiskToTransfer
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1B4]
	mov	[bp+var_26], ax
	mov	[bp+var_24], ss
	mov	ax, 18h
	push	ax
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jz	short loc_264E1
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	push	[bp+var_24]
	push	[bp+var_26]
	call	_strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx
loc_264E1:
	mov	ax, offset aThieves_inf
	push	ds
	push	ax
	push	[bp+var_24]
	push	[bp+var_26]
	call	_strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx
	sub	ax, ax
	push	ax
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	openFile
	add	sp, 6
	mov	[bp+var_182], ax
	inc	ax
	jnz	short loc_2653C
	mov	ax, offset aNoCharactersFoundOn
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	loc_267CC
loc_2653C:
	mov	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	mov	word ptr [bp+var_1BA], ax
	mov	word ptr [bp+var_1BA+2], dx
	mov	[bp+var_1C2], 0
	jmp	short loc_26558
loc_26554:
	inc	[bp+var_1C2]
loc_26558:
	cmp	[bp+var_1C2], 4Bh 
	jge	short loc_26572
	getCharP	[bp+var_1C2], bx
	lfs	si, [bp+var_1BA]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_26554
loc_26572:
	mov	ax, 9000
	push	ax
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	push	[bp+var_182]
	call	_read
	add	sp, 8
	push	[bp+var_182]
	call	_close
	add	sp, 2
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx
	mov	ax, offset aParties_inf
	push	ds
	push	ax
	push	dx
	push	[bp+var_26]
	call	_strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx
	mov	ax, [bp+var_180]
	mov	dx, [bp+var_17E]
	mov	word ptr [bp+var_1BA], ax
	mov	word ptr [bp+var_1BA+2], dx
	mov	[bp+var_1C2], 0
	jmp	short loc_265E2
loc_265DE:
	inc	[bp+var_1C2]
loc_265E2:
	cmp	[bp+var_1C2], 0Ah
	jge	short loc_265FB
	mov	bx, [bp+var_1C2]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+var_1BA]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_265DE
loc_265FB:
	sub	ax, ax
	push	ax
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	openFile
	add	sp, 6
	mov	[bp+var_182], ax
	inc	ax
	jnz	short loc_2663C
	mov	ax, offset aNoPartiesFoundOn
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	short loc_26654
loc_2663C:
	mov	ax, 500h
	push	ax
	push	[bp+var_17E]
	push	[bp+var_180]
	push	[bp+var_182]
	call	_read
	add	sp, 8
loc_26654:
	mov	[bp+var_1C2], 0
	mov	[bp+var_1C0], 0
loc_2665A:
	cmp	[bp+var_1C0], 10
	jge	l_transfer_partyLimitReached
	mov	si, [bp+var_1C2]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+var_1C2]
	mov	cl, 7
	shl	ax, cl
	add	ax, [bp+var_180]
	mov	dx, [bp+var_17E]
	mov	word ptr [bp+si+var_17A], ax
	mov	word ptr [bp+si+var_17A+2], dx
	mov	si, [bp+var_1C2]
	inc	[bp+var_1C2]
	inc	[bp+var_1C0]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_17A]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_2665A
l_transfer_partyLimitReached:
	dec	[bp+var_1C2]
	mov	ax, [bp+var_1C2]
	mov	[bp+var_1BC], ax
	mov	[bp+var_1C0], 0
loc_2669C:
	cmp	[bp+var_1C0], 75
	jge	l_transfer_charLimitReached
	mov	ax, [bp+var_1C2]
	sub	ax, [bp+var_1BC]
	getCharIndex	cx, cx
	add	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	mov	si, [bp+var_1C2]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+var_17A], ax
	mov	word ptr [bp+si+var_17A+2], dx
	mov	si, [bp+var_1C2]
	inc	[bp+var_1C2]
	inc	[bp+var_1C0]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_17A]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_2669C
l_transfer_charLimitReached:
	dec	[bp+var_1C2]
loc_266DB:
	push	[bp+var_1C2]
	lea	ax, [bp+var_17A]
	push	ss
	push	ax
	mov	ax, offset aWhoShallTransfer?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_1C0], ax
	or	ax, ax
	jge	short loc_2671D
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	call	_freeMaybe
	add	sp, 4
	push	[bp+var_17E]
	push	[bp+var_180]
	call	_freeMaybe
	add	sp, 4
	jmp	loc_267CF
loc_2671D:
	mov	ax, [bp+var_1BC]
	cmp	[bp+var_1C0], ax
	jl	short loc_2672A
	jmp	loc_267B2
loc_2672A:
	mov	si, [bp+var_1C0]
	shl	si, 1
	shl	si, 1
	mov	ax, word ptr [bp+si+var_17A]
	mov	dx, word ptr [bp+si+var_17A+2]
	mov	[bp+var_22], ax
	mov	[bp+var_20], dx
	mov	[bp+var_17C], 0
	jmp	short loc_2674C
loc_26748:
	inc	[bp+var_17C]
loc_2674C:
	cmp	[bp+var_17C], 7
	jge	short loc_267B0
	mov	ax, [bp+var_17C]
	mov	cl, 4
	shl	ax, cl
	add	ax, [bp+var_22]
	mov	dx, [bp+var_20]
	add	ax, 10h
	mov	word ptr [bp+var_1CA], ax
	mov	word ptr [bp+var_1CA+2], dx
	lfs	bx, [bp+var_1CA]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_2678D
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	push	dx
	push	ax
	push	cs
	call	near ptr sub_267D4
	add	sp, 8
	mov	[bp+var_1B6], ax
	jmp	short loc_2678F
loc_2678D:
	jmp	short loc_267B0
loc_2678F:
	cmp	[bp+var_1B6], 0
	jl	short loc_267AE
	getCharIndex	ax, [bp+var_1B6]
	add	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	push	dx
	push	ax
	push	cs
	call	near ptr sub_2681F
	add	sp, 4
loc_267AE:
	jmp	short loc_26748
loc_267B0:
	jmp	short loc_267C9
loc_267B2:
	mov	si, [bp+var_1C0]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_17A+2]
	push	word ptr [bp+si+var_17A]
	push	cs
	call	near ptr sub_2681F
	add	sp, 4
loc_267C9:
	jmp	loc_266DB
loc_267CC:
	jmp	loc_2649C
loc_267CF:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getTransferCharacters endp

; Attributes: bp-based frame

sub_267D4 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_267E9
loc_267E6:
	inc	[bp+var_2]
loc_267E9:
	cmp	[bp+var_2], 75
	jge	short loc_26816
	getCharIndex	ax, [bp+var_2]
	add	ax, [bp+arg_4]
	mov	dx, [bp+arg_6]
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcmp
	add	sp, 8
	or	ax, ax
	jnz	short loc_26814
	mov	ax, [bp+var_2]
	jmp	short loc_2681B
loc_26814:
	jmp	short loc_267E6
loc_26816:
	mov	ax, 0FFFFh
	jmp	short $+2
loc_2681B:
	mov	sp, bp
	pop	bp
	retf
sub_267D4 endp

; Attributes: bp-based frame

sub_2681F proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	rost_charNameExists
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_26868
	call	countSavedChars
	mov	[bp+var_2], ax
	getCharP	[bp+var_2], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	copyCharacterBuf
	add	sp, 8
	jmp	short loc_26881
loc_26868:
	mov	ax, offset aThisCharacterAlready
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
loc_26881:
	mov	sp, bp
	pop	bp
	retf
sub_2681F endp

; Attributes: bp-based frame

importCharacter	proc far

	var_1F0= dword ptr -1F0h
	var_1EC= word ptr -1ECh
	var_1EA= word ptr -1EAh
	var_1E8= word ptr -1E8h
	var_1E6= word ptr -1E6h
	var_1E0= word ptr -1E0h
	var_1C2= word ptr -1C2h
	var_1AE= word ptr -1AEh
	var_17C= word ptr -17Ch
	var_178= word ptr -178h
	var_176= word ptr -176h
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 1F0h
	call	someStackOperation
	push	si
	mov	ax, 2BF2h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_1EC], ax
	mov	[bp+var_1EA], dx
	mov	word ptr [bp+var_1F0], ax
	mov	word ptr [bp+var_1F0+2], dx
loc_268AD:
	mov	ax, offset aDiskToTransfer
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1AE]
	mov	[bp+var_24], ax
	mov	[bp+var_22], ss
	mov	ax, 18h
	push	ax
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jz	short loc_268F2
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	push	[bp+var_22]
	push	[bp+var_24]
	call	_strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
loc_268F2:
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (oldCharFilters+2)[bx]
	push	word ptr oldCharFilters[bx]
	push	[bp+var_22]
	push	[bp+var_24]
	call	_strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	lea	ax, [bp+var_1E0]
	push	ss
	push	ax
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	findFirstFile
	add	sp, 8
	or	ax, ax
	jz	short loc_26931
	jmp	short loc_26965
	jmp	short loc_26962
loc_26931:
	mov	ax, offset aNoCharactersFoundOn
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	sub	ax, ax
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_20], ax
	cmp	ax, 1Bh
	jnz	short loc_26962
	jmp	loc_26A85
loc_26962:
	jmp	loc_268AD
loc_26965:
	mov	[bp+var_1E8], 0
loc_2696B:
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	lea	ax, [bp+var_1C2]
	push	ss
	push	ax
	push	dx
	push	[bp+var_24]
	call	_strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	sub	ax, ax
	push	ax
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	openFile
	add	sp, 6
	mov	[bp+var_17C], ax
	inc	ax
	jz	short loc_26A01
	mov	ax, 81h	
	push	ax
	push	word ptr [bp+var_1F0+2]
	push	word ptr [bp+var_1F0]
	push	[bp+var_17C]
	call	_read
	add	sp, 8
	lfs	bx, [bp+var_1F0]
	cmp	byte ptr fs:[bx+10h], 1
	jnz	short loc_269F5
	mov	si, [bp+var_1E8]
	inc	[bp+var_1E8]
	shl	si, 1
	shl	si, 1
	mov	ax, bx
	mov	dx, fs
	mov	[bp+si+var_178], ax
	mov	[bp+si+var_176], dx
	add	word ptr [bp+var_1F0], 96h 
loc_269F5:
	push	[bp+var_17C]
	call	_close
	add	sp, 2
loc_26A01:
	call	sub_27C4A
	or	ax, ax
	jz	short loc_26A0D
	jmp	loc_2696B
loc_26A0D:
	push	[bp+var_1E8]
	lea	ax, [bp+var_178]
	push	ss
	push	ax
	mov	ax, offset aWhoShallTransfer?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_1E6], ax
	or	ax, ax
	jge	short loc_26A3E
	push	[bp+var_1EA]
	push	[bp+var_1EC]
	call	_freeMaybe
	add	sp, 4
	jmp	short loc_26A85
loc_26A3E:
	cmp	[bp+arg_0], 0
	jz	short loc_26A5D
	mov	si, [bp+var_1E6]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_176]
	push	[bp+si+var_178]
	push	cs
	call	near ptr importBIIChar
	add	sp, 4
	jmp	short loc_26A74
loc_26A5D:
	mov	si, [bp+var_1E6]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_176]
	push	[bp+si+var_178]
	push	cs
	call	near ptr importBICharacter
	add	sp, 4
loc_26A74:
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr sub_2681F
	add	sp, 4
	jmp	short loc_26A0D
loc_26A85:
	pop	si
	mov	sp, bp
	pop	bp
	retf
importCharacter	endp

; Attributes: bp-based frame

convertSpellLevel proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	spLevel= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	cmp	[bp+spLevel], 0
	jz	short loc_26AD7
	mov	bx, [bp+arg_0]
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 0FFh
	jz	short loc_26AD7
	mov	[bp+var_4], 0
	jmp	short loc_26ABB
loc_26AB8:
	inc	[bp+var_4]
loc_26ABB:
	mov	ax, [bp+spLevel]
	cmp	[bp+var_4], ax
	jge	short loc_26AD7
	push	[bp+var_2]
	push	[bp+var_4]
	mov	ax, 7
	push	ax
	call	mage_learnSpellLevel
	add	sp, 6
	jmp	short loc_26AB8
loc_26AD7:
	mov	sp, bp
	pop	bp
	retf
convertSpellLevel endp

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	sp, bp
	pop	bp
	retf
; Attributes: bp-based frame

importBIIChar proc far

	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	ax, 78h	
	push	ax
	sub	ax, ax
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memset
	add	sp, 8
	mov	[bp+var_4], 0
	jmp	short loc_26B16
loc_26B13:
	inc	[bp+var_4]
loc_26B16:
	mov	bx, [bp+var_4]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	mov	[bp+var_8], al
	or	al, al
	jz	short loc_26B31
	mov	byte ptr gs:newCharBuffer._name[bx], al
	jmp	short loc_26B13
loc_26B31:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.strength]
	mov	gs:newCharBuffer.strength, al
	mov	al, fs:[bx+bii_char_t.intelligence]
	mov	gs:newCharBuffer.intelligence, al
	mov	al, fs:[bx+bii_char_t.dexterity]
	mov	gs:newCharBuffer.dexterity, al
	mov	al, fs:[bx+bii_char_t.constitution]
	mov	gs:newCharBuffer.constitution, al
	mov	al, fs:[bx+bii_char_t.luck]
	mov	gs:newCharBuffer.luck, al
	mov	ax, word ptr fs:[bx+bii_char_t.experience]
	mov	dx, fs:[bx+45h]
	mov	word ptr gs:newCharBuffer.experience, ax
	mov	word ptr gs:newCharBuffer.experience+2,	dx
	mov	ax, word ptr fs:[bx+bii_char_t.gold]
	mov	dx, fs:[bx+49h]
	mov	word ptr gs:newCharBuffer.gold,	ax
	mov	word ptr gs:newCharBuffer.gold+2, dx
	mov	al, fs:[bx+bii_char_t.level]
	sub	al, 35
	sbb	cl, cl
	and	al, cl
	add	al, 35
	sub	ah, ah
	mov	gs:newCharBuffer.level,	ax
	mov	gs:newCharBuffer.maxLevel, ax
	mov	ax, fs:[bx+bii_char_t.maxHp]
	mov	gs:newCharBuffer.currentHP, ax
	mov	ax, fs:[bx+bii_char_t.maxHp]
	mov	gs:newCharBuffer.maxHP,	ax
	mov	ax, fs:[bx+bii_char_t.maxSppt]
	mov	gs:newCharBuffer.currentSppt, ax
	mov	ax, fs:[bx+bii_char_t.currentSppt]
	mov	gs:newCharBuffer.maxSppt, ax
	mov	bl, fs:[bx+bii_char_t.class]
	sub	bh, bh
	mov	al, bii_classMap[bx]
	mov	gs:newCharBuffer.class,	al
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.race]
	mov	gs:newCharBuffer.race, al
	call	getCharacterGender
	and	al, 1
	mov	gs:newCharBuffer.gender, al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	shl	bx, 1
	sub	ah, ah
	add	bx, ax
	mov	al, byte_42F8C[bx]
	mov	gs:newCharBuffer.picIndex, al
	mov	gs:newCharBuffer.status, ah
	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
	jmp	short loc_26C6A
loc_26C67:
	inc	[bp+var_4]
loc_26C6A:
	cmp	[bp+var_4], 8
	jge	short loc_26CE9
	mov	si, [bp+var_4]
	shl	si, 1
	lfs	bx, [bp+arg_0]
	mov	bl, byte ptr fs:[bx+si+bii_char_t.inventory]
	sub	bh, bh
	mov	al, bii_inventoryMap[bx]
	cbw
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_26CE6
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemNo[bx], al
	mov	bx, [bp+var_2]
	mov	al, byte_464B8[bx]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemCount[bx], al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, classEquipMask[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, itemEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short loc_26CE2
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemFlags[bx], 2
loc_26CE2:
	add	[bp+var_6], 3
loc_26CE6:
	jmp	loc_26C67
loc_26CE9:
	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	jmp	short loc_26D49
loc_26CF5:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.field_52]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, al
	mov	gs:newCharBuffer.specAbil+2, al
	jmp	short loc_26D68
loc_26D0E:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.songsLeft]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, 0FCh 
	jmp	short loc_26D68
loc_26D25:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.numAttacks]
	mov	gs:newCharBuffer.numAttacks, al
	jmp	short loc_26D68
loc_26D36:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.field_55]
	mov	gs:newCharBuffer.specAbil, al
loc_26D45:
	jmp	short loc_26D68
	jmp	short loc_26D68
loc_26D49:
	or	ax, ax
	jz	short loc_26D25
	cmp	ax, class_rogue
	jz	short loc_26CF5
	cmp	ax, class_bard
	jz	short loc_26D0E
	cmp	ax, class_paladin
	jz	short loc_26D25
	cmp	ax, class_hunter
	jz	short loc_26D36
	cmp	ax, class_monk
	jz	short loc_26D25
	jmp	short loc_26D45
loc_26D68:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.wizdLevel]
	sub	ah, ah
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.sorcLevel]
	sub	ah, ah
	push	ax
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.conjLevel]
	sub	ah, ah
	push	ax
	mov	ax, 3
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.magiLevel]
	sub	ah, ah
	push	ax
	mov	ax, 4
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.archLevel]
	sub	ah, ah
	push	ax
	mov	ax, 0Ah
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
importBIIChar endp

; Attributes: bp-based frame

importBICharacter proc far

	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	ax, 78h	
	push	ax
	sub	ax, ax
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memset
	add	sp, 8
	mov	[bp+var_4], 0
	jmp	short loc_26E03
loc_26E00:
	inc	[bp+var_4]
loc_26E03:
	mov	bx, [bp+var_4]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	mov	[bp+var_8], al
	or	al, al
	jz	short loc_26E1E
	mov	byte ptr gs:newCharBuffer._name[bx], al
	jmp	short loc_26E00
loc_26E1E:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.strength]
	mov	gs:newCharBuffer.strength, al
	mov	al, byte ptr fs:[bx+bi_char_t.intelligence]
	mov	gs:newCharBuffer.intelligence, al
	mov	al, byte ptr fs:[bx+bi_char_t.dexterity]
	mov	gs:newCharBuffer.dexterity, al
	mov	al, byte ptr fs:[bx+bi_char_t.constitution]
	mov	gs:newCharBuffer.constitution, al
	mov	al, byte ptr fs:[bx+bi_char_t.luck]
	mov	gs:newCharBuffer.luck, al
	mov	ax, word ptr fs:[bx+bi_char_t.experience]
	mov	dx, fs:[bx+47h]
	mov	word ptr gs:newCharBuffer.experience, ax
	mov	word ptr gs:newCharBuffer.experience+2,	dx
	mov	ax, word ptr fs:[bx+bi_char_t.gold]
	mov	dx, fs:[bx+4Bh]
	mov	word ptr gs:newCharBuffer.gold,	ax
	mov	word ptr gs:newCharBuffer.gold+2, dx
	mov	ax, fs:[bx+bi_char_t.level]
	sub	ax, 35
	sbb	cx, cx
	and	ax, cx
	add	ax, 35
	mov	gs:newCharBuffer.level,	ax
	mov	gs:newCharBuffer.maxLevel, ax
	mov	ax, fs:[bx+bi_char_t.maxHP]
	mov	gs:newCharBuffer.currentHP, ax
	mov	ax, fs:[bx+bi_char_t.maxHP]
	mov	gs:newCharBuffer.maxHP,	ax
	mov	ax, fs:[bx+bi_char_t.currentSppt]
	mov	gs:newCharBuffer.currentSppt, ax
	mov	ax, fs:[bx+bi_char_t.maxSppt]
	mov	gs:newCharBuffer.maxSppt, ax
	mov	bx, fs:[bx+bi_char_t.class]
	mov	al, bii_classMap[bx]
	mov	gs:newCharBuffer.class,	al
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.race]
	mov	gs:newCharBuffer.race, al
	call	getCharacterGender
	and	al, 1
	mov	gs:newCharBuffer.gender, al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	shl	bx, 1
	sub	ah, ah
	add	bx, ax
	mov	al, byte_42F8C[bx]
	mov	gs:newCharBuffer.picIndex, al
	mov	gs:newCharBuffer.status, ah
	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
	jmp	short loc_26F55
loc_26F52:
	inc	[bp+var_4]
loc_26F55:
	cmp	[bp+var_4], 8
	jge	short loc_26FD4
	mov	si, [bp+var_4]
	shl	si, 1
	lfs	bx, [bp+arg_0]
	mov	bl, byte ptr fs:[bx+si+bi_char_t.inventory]
	sub	bh, bh
	mov	al, bi_inventoryMap[bx]
	cbw
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_26FD1
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemNo[bx], al
	mov	bx, [bp+var_2]
	mov	al, byte_464B8[bx]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemCount[bx], al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, classEquipMask[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, itemEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short loc_26FCD
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemFlags[bx], 2
loc_26FCD:
	add	[bp+var_6], 3
loc_26FD1:
	jmp	loc_26F52
loc_26FD4:
	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	jmp	short loc_27034
loc_26FE0:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.field_55]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, al
	mov	gs:newCharBuffer.specAbil+2, al
	jmp	short loc_27053
loc_26FF9:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.songsLeft]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, 0FCh
	jmp	short loc_27053
loc_27010:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.numAttacks]
	mov	gs:newCharBuffer.numAttacks, al
	jmp	short loc_27053
loc_27021:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.field_5B]
	mov	gs:newCharBuffer.specAbil, al
loc_27030:
	jmp	short loc_27053
	jmp	short loc_27053
loc_27034:
	or	ax, ax
	jz	short loc_27010
	cmp	ax, class_rogue
	jz	short loc_26FE0
	cmp	ax, class_bard
	jz	short loc_26FF9
	cmp	ax, class_paladin
	jz	short loc_27010
	cmp	ax, class_hunter
	jz	short loc_27021
	cmp	ax, class_monk
	jz	short loc_27010
	jmp	short loc_27030
loc_27053:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.wizdLevel]
	sub	ah, ah
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.sorcLevel]
	sub	ah, ah
	push	ax
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.conjLevel]
	sub	ah, ah
	push	ax
	mov	ax, 3
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.magiLevel]
	sub	ah, ah
	push	ax
	mov	ax, 4
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
importBICharacter endp

seg017 ends
