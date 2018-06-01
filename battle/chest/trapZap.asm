; Attributes: bp-based frame

chest_trapZap proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aWhoWillCastATrzp?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1FA44
	sub	ax, ax
	jmp	loc_1FB00
loc_1FA44:
	getCharP	[bp+var_2], bx
	test	gs:party.status[bx], 7Ch
	jz	short loc_1FA5D
	sub	ax, ax
	jmp	loc_1FB00
loc_1FA5D:
	getCharP	[bp+var_2], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1FA72
	sub	ax, ax
	jmp	loc_1FB00
loc_1FA72:
	mov	ax, 2
	push	ax
	push	[bp+var_2]
	call	character_learnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_1FAEF
	getCharP	[bp+var_2], bx
	cmp	gs:party.currentSppt[bx], 2
	jnb	short loc_1FAAA
	mov	ax, offset aYouNeedAtLeast2SpellP
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_1FB00
loc_1FAAA:
	getCharP	[bp+var_2], bx
	sub	gs:party.currentSppt[bx], 2
	mov	gs:trapIndex, 0
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, offset aYouDisarmedIt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	mov	ax, 1
	jmp	short loc_1FB00
loc_1FAEF:
	mov	ax, offset s_dontKnowThatSpell_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short $+2
loc_1FB00:
	mov	sp, bp
	pop	bp
	retf
chest_trapZap endp
