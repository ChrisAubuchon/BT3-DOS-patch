; Attributes: bp-based frame
spell_cast proc	far

	partySlotNumber=	word ptr  6
	spellNo= word ptr  8
	itemUsedFlag= word ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation

	cmp	[bp+itemUsedFlag], 0
	jnz	short l_notMapSpell

	; Spell is from an item. Pass the spell through map_execute to
	; see if it triggers a map function.
	mov	ax, [bp+spellNo]
	mov	g_curSpellNumber, ax
	mov	ax, 1
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	std_call	map_execute, 6
	or	ax, ax
	jnz	l_return

l_notMapSpell:
	cmp	[bp+itemUsedFlag], 0
	jz	short l_combatCheck

	; I think this checks for spells that shouldn't be able
	; to be cast from items
	mov	bx, [bp+spellNo]
	test	spellCastFlags[bx], spellcast_spellOnly
	jz	l_returnZero
	jmp	short l_callSpellFunction

l_combatCheck:
	mov	bx, [bp+spellNo]
	test	spellCastFlags[bx], spellcast_combatOnly
	jz	l_returnZero

l_callSpellFunction:
	push	[bp+spellNo]
	push	[bp+partySlotNumber]
	mov	bx, [bp+spellNo]
	shl	bx, 1
	shl	bx, 1
	call	spellFuncList[bx]
	add	sp, 4
	jmp	l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
spell_cast endp
