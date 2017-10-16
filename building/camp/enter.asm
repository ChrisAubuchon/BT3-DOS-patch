; Attributes: bp-based frame

camp_enter proc	far

	var_58=	word ptr -58h
	loopCounter=	word ptr -56h
	var_54=	word ptr -54h
	var_52=	word ptr -52h
	var_3E=	word ptr -3Eh
	var_3C=	word ptr -3Ch
	campOptionList=	word ptr -14h

	push	bp
	mov	bp, sp
	mov	ax, 58h	
	call	someStackOperation
	push	si
	call	endNoncombatSong

	; End all duration spells when entering camp
	mov	[bp+loopCounter], 0
l_durationSpellLoopEntry:
	mov	bx, [bp+loopCounter]
	cmp	lightDuration[bx], 0
	jz	short l_notActive
	push	bx
	call	sub_17920
	add	sp, 2
l_notActive:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_durationSpellLoopEntry

	mov	gs:gl_detectSecretDoorFlag, 0
	mov	gs:songACBonus,	0
	push	cs
	call	near ptr readRosterFiles
	push	cs
	call	near ptr roster_writeParty
	mov	ax, offset aTheRuin
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	sub	ax, ax
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
l_mainIoLoopEntry:
	call	clearTextWindow
	lea	ax, [bp+campOptionList]
	push	ss
	push	ax
	push	cs
	call	near ptr camp_configOptionList
	add	sp, 4
	lea	ax, [bp+var_3C]
	push	ss
	push	ax
	lea	ax, [bp+var_52]
	push	ss
	push	ax
	lea	ax, [bp+campOptionList]
	push	ss
	push	ax
	mov	ax, offset aThouArtInTheCa
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_54], ax
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_58], ax
	mov	ax, [bp+var_54]
	or	ah, 20h
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_3E], ax
	cmp	ax, 30h	
	jle	short loc_13564
	mov	ax, [bp+var_58]
	add	ax, 31h	
	cmp	ax, [bp+var_3E]
	jle	short loc_13564
	mov	ax, [bp+var_3E]
	sub	ax, 31h	
	push	ax
	call	printCharacter
	add	sp, 2
	sub	ax, ax
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	mov	ax, offset aTheRuin
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	jmp	short loc_135A7
loc_13564:
	mov	[bp+loopCounter], 0
loc_13569:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+var_52], 0
	jz	short loc_135A7
	mov	al, byte ptr [bp+si+var_52]
	cbw
	cmp	ax, [bp+var_3E]
	jz	short loc_13585
	shl	si, 1
	mov	ax, [bp+var_3E]
	cmp	[bp+si+var_3C],	ax
	jnz	short loc_135A2
loc_13585:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_campActionFunctions[bx]
	cmp	buildingRvalMaybe, 0
	jz	short loc_135A2
	mov	ax, buildingRvalMaybe
	jmp	short loc_135AA
loc_135A2:
	inc	[bp+loopCounter]
	jmp	short loc_13569
loc_135A7:
	jmp	l_mainIoLoopEntry
loc_135AA:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_enter endp

