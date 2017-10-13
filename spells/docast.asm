; Attributes: bp-based frame

doCastSpell proc far

	stringBuf= word ptr -108h
	stringBufP= dword ptr -8
	partySlotNumber=	word ptr  6
	spellNumber= word ptr  8
	itemUsedFlag= word ptr	 0Ah
	useSppt= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	[bp+partySlotNumber]

	push_ss_string	stringBuf
	std_call	bat_getAttackerName,6
	save_ptr_stack	dx,ax,stringBufP
	dword_appendChar	stringBufP, ' '

	cmp	[bp+spellNumber], 7Eh 
	jge	short l_spptCheck

	strcat_offset aCastsASpell,stringBufP
	dword_appendChar stringBufP, ' '

	; Append full spell name to output string
	mov	bx, [bp+spellNumber]
	mov	cl, 3
	shl	bx, cl
	push	word ptr (spellString.fullName+2)[bx]
	push	word ptr spellString.fullName[bx]
	push	word ptr [bp+stringBufP+2]
	push	word ptr [bp+stringBufP]
	do_strcat stringBufP

l_spptCheck:
	cmp	[bp+useSppt], 0
	jz	short l_castIt
	push	[bp+spellNumber]
	push	[bp+partySlotNumber]
	near_call	_sp_checkSPPT,4
	or	ax, ax
	jz	short l_fizzled
	mov	al, gs:sq_antiMagicFlag
	sub	ah, ah
	or	ax, ax
	jz	short l_castIt

l_fizzled:
	null_terminate	[bp+stringBufP]
	push_ss_string	stringBuf
	std_call	printString,4

	call	printSpellFizzled

	sub	ax, ax
	jmp	short l_return
l_castIt:
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	push	[bp+itemUsedFlag]
	push	[bp+spellNumber]
	push	[bp+partySlotNumber]
	near_call	spell_cast,6
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
doCastSpell endp
