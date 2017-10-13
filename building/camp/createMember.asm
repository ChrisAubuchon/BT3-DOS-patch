
; Attributes: bp-based frame

camp_createMember proc far

	var_23A= byte ptr -23Ah
	var_EC=	byte ptr -0ECh
	var_EA=	word ptr -0EAh
	var_E8=	word ptr -0E8h
	var_7E=	byte ptr -7Eh
	var_34=	word ptr -34h
	counter= word ptr -32h
	var_30=	word ptr -30h
	var_2E=	word ptr -2Eh
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	dword ptr -20h
	var_1C=	word ptr -1Ch
	var_8= word ptr	-8
	raceGenderValue= word ptr -6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0ECh 
	call	someStackOperation
	push	di
	push	si
	mov	word ptr [bp+var_20], offset newCharBuffer
	mov	word ptr [bp+var_20+2],	seg seg027
loc_129B3:
	mov	[bp+counter], 0
	jmp	short loc_129BD
loc_129BA:
	inc	[bp+counter]
loc_129BD:
	cmp	[bp+counter], 78h 
	jge	short loc_129CF
	mov	bx, [bp+counter]
	lfs	si, [bp+var_20]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_129BA
loc_129CF:
	push	cs
	call	near ptr getCharacterGender
	mov	gs:newCharBuffer.gender, al
	cmp	al, 0FFh
	jnz	short loc_129E4
	sub	ax, ax
	jmp	loc_12DAE
loc_129E4:
	push	cs
	call	near ptr getCharacterRace
	mov	gs:newCharBuffer.race, al
	cmp	al, 0FFh
	jnz	short loc_129F9
	sub	ax, ax
	jmp	loc_12DAE
loc_129F9:
	mov	al, gs:newCharBuffer.race
	sub	ah, ah
	shl	ax, 1
	mov	cl, gs:newCharBuffer.gender
	sub	ch, ch
	add	ax, cx
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	[bp+raceGenderValue], ax
	mov	[bp+counter], 0
	jmp	short loc_12A1F
loc_12A1C:
	inc	[bp+counter]
loc_12A1F:
	cmp	[bp+counter], 5
	jge	short loc_12A5A
	call	_random
	and	ax, 7
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	mov	cx, ax
	mov	al, byte ptr baseAttributes.male_st[bx+si]
	cbw
	add	ax, cx
	mov	si, bx
	shl	si, 1
	mov	[bp+si+var_2E],	ax
	mov	si, [bp+counter]
	shl	si, 1
	cmp	[bp+si+var_2E],	1Eh
	jle	short loc_12A58
	mov	si, [bp+counter]
	shl	si, 1
	mov	[bp+si+var_2E],	1Eh
loc_12A58:
	jmp	short loc_12A1C
loc_12A5A:
	call	_random
	and	ax, 0Fh
	add	ax, 13
	mov	[bp+var_30], ax
	mov	gs:newCharBuffer.currentHP, ax
	mov	gs:newCharBuffer.maxHP,	ax
	mov	[bp+var_24], ax
	call	clearTextWindow
	mov	ax, 5
	push	ax
	lea	ax, [bp+var_E8]
	push	ss
	push	ax
	lea	ax, [bp+var_2E]
	push	ss
	push	ax
	call	getAttributeString
	add	sp, 0Ah
	lea	ax, [bp+var_E8]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	al, gs:newCharBuffer.race
	sub	ah, ah
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	[bp+raceGenderValue], ax
	sub	ax, ax
	mov	[bp+var_EA], ax
	mov	[bp+var_2], ax
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	[bp+var_8], ax
	mov	[bp+counter], 0
	jmp	short loc_12AD8
loc_12AD5:
	inc	[bp+counter]
loc_12AD8:
	cmp	[bp+counter], 10
	jge	short loc_12B30
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	cmp	byte ptr startingClasses.canBeWarrior[bx+si], 0
	jz	short loc_12B2E
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_2], ax
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (classString+2)[bx]
	push	word ptr classString[bx]
	push	[bp+var_EA]
	push	cs
	call	near ptr printListItem
	add	sp, 6
	mov	si, [bp+var_EA]
	inc	[bp+var_EA]
	shl	si, 1
	mov	ax, [bp+counter]
	mov	[bp+si+var_1C],	ax
loc_12B2E:
	jmp	short loc_12AD5
loc_12B30:
	mov	[bp+var_4], 0
	mov	[bp+var_34], 1
loc_12B3A:
	push	[bp+var_2]
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_22], ax
	mov	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+var_22]
	jg	short loc_12B7B
	mov	ax, [bp+var_EA]
	add	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+var_22]
	jl	short loc_12B7B
	mov	si, [bp+var_22]
	sub	si, [bp+var_8]
	shl	si, 1
	mov	al, [bp+si+var_23A]
	mov	gs:newCharBuffer.class,	al
	mov	[bp+var_34], 0
loc_12B7B:
	cmp	[bp+var_22], 30h 
	jle	short loc_12BA4
	mov	ax, [bp+var_EA]
	add	ax, 30h	
	cmp	ax, [bp+var_22]
	jl	short loc_12BA4
	mov	si, [bp+var_22]
	shl	si, 1
	mov	al, [bp+si+var_7E]
	mov	gs:newCharBuffer.class,	al
	mov	[bp+var_34], 0
	jmp	short loc_12BB4
loc_12BA4:
	cmp	[bp+var_22], 1Bh
	jnz	short loc_12BB4
	mov	[bp+var_34], 0
	mov	[bp+var_4], 1
loc_12BB4:
	cmp	[bp+var_34], 0
	jz	short loc_12BBD
	jmp	loc_12B3A
loc_12BBD:
	cmp	[bp+var_4], 0
	jz	short loc_12BC6
	jmp	loc_129B3
loc_12BC6:
	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	mov	si, ax
	mov	di, word ptr gs:newCharBuffer.gender
	and	di, 0FFh
	mov	bx, si
	shl	bx, 1
	mov	al, byte_42F8C[bx+di]
	mov	gs:newCharBuffer.picIndex, al
	mov	ax, si
	jmp	short loc_12C3B
loc_12BEB:
	mov	gs:newCharBuffer.spells, 0E0h ;	'à'
	jmp	short loc_12C56
loc_12BF7:
	mov	gs:newCharBuffer.spells+2, 1Ch
	jmp	short loc_12C56
loc_12C03:
	mov	gs:newCharBuffer.specAbil, 14h
	mov	gs:newCharBuffer.specAbil+1, 14h
	mov	gs:newCharBuffer.specAbil+2, 14h
	jmp	short loc_12C56
loc_12C1B:
	mov	gs:newCharBuffer.specAbil, 1
	mov	gs:newCharBuffer.specAbil+1, 0FCh 
	jmp	short loc_12C56
loc_12C2D:
	mov	gs:newCharBuffer.specAbil, 5
	jmp	short loc_12C56
	jmp	short loc_12C56
loc_12C3B:
	cmp	ax, class_conjurer
	jz	short loc_12BEB
	cmp	ax, class_magician
	jz	short loc_12BF7
	cmp	ax, class_rogue
	jz	short loc_12C03
	cmp	ax, class_bard
	jz	short loc_12C1B
	cmp	ax, class_hunter
	jz	short loc_12C2D
	jmp	short $+2
loc_12C56:
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, byte_4302E[bx]
	cbw
	mov	[bp+raceGenderValue], ax
	mov	[bp+counter], 0
loc_12C6E:
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	mov	al, startingInventory[bx+si]
	mov	[bp+var_EC], al
	cmp	al, 0FEh 
	jz	short loc_12C8A
	mov	gs:newCharBuffer.inventory.itemFlags[bx], al
	inc	[bp+counter]
	jmp	short loc_12C6E
loc_12C8A:
	mov	word ptr [bp+var_20], offset newCharBuffer.strength
	mov	word ptr [bp+var_20+2],	seg seg027
	mov	[bp+counter], 0
	jmp	short loc_12C9E
loc_12C9B:
	inc	[bp+counter]
loc_12C9E:
	cmp	[bp+counter], 5
	jge	short loc_12CB7
	mov	si, [bp+counter]
	shl	si, 1
	mov	al, byte ptr [bp+si+var_2E]
	mov	bx, [bp+counter]
	lfs	si, [bp+var_20]
	mov	fs:[bx+si], al
	jmp	short loc_12C9B
loc_12CB7:
	mov	gs:newCharBuffer.level,	1
	mov	gs:newCharBuffer.maxLevel, 1
	cmp	gs:newCharBuffer.class,	class_warrior
	jz	short loc_12CEE
	cmp	gs:newCharBuffer.class,	class_rogue
	jnb	short loc_12CEE
	call	_random
	and	ax, 0Fh
	add	ax, 8
	mov	gs:newCharBuffer.currentSppt, ax
	jmp	short loc_12CF5
loc_12CEE:
	mov	gs:newCharBuffer.currentSppt, 0
loc_12CF5:
	mov	ax, gs:newCharBuffer.currentSppt
	mov	gs:newCharBuffer.maxSppt, ax
loc_12CFD:
	mov	ax, offset aNameYourNewCha
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 0Eh
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jnz	short loc_12D25
	jmp	loc_12DAE
loc_12D25:
	cmp	gs:newCharBuffer._name,	2Ah 
	jnz	short loc_12D37
	mov	gs:newCharBuffer._name,	58h 
loc_12D37:
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr roster_nameExists
	add	sp, 4
	or	ax, ax
	jl	short loc_12D6A
	mov	ax, offset aThereIsAlready
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	mov	[bp+var_4], 1
	jmp	short loc_12D6F
loc_12D6A:
	mov	[bp+var_4], 0
loc_12D6F:
	cmp	[bp+var_4], 0
	jnz	short loc_12CFD
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_30], ax
	getCharP	[bp+var_30], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	getCharP	[bp+var_30], bx
	mov	fs, seg022_x
	assume fs:seg022
	mov	fs:(characterIOBuf+78h)[bx], 0
loc_12DAE:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
camp_createMember endp
