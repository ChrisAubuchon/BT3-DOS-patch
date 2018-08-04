; Attributes: bp-based frame
spell_cast proc	far

	partySlotNumber=	word ptr  6
	spellNo= word ptr  8
	itemUsedFlag= word ptr	 0Ah

	FUNC_ENTER

	cmp	[bp+itemUsedFlag], 0
	jnz	short l_notMapSpell

	; Spell is from an item. Pass the spell through vm_execute to
	; see if it triggers a map function.
	mov	ax, [bp+spellNo]
	mov	g_curSpellNumber, ax
	mov	ax, 1
	push	ax
	push	word ptr gs:g_mapData+2
	push	word ptr gs:g_mapData
	CALL(vm_execute)
	or	ax, ax
	jnz	l_return

l_notMapSpell:
	cmp	[bp+itemUsedFlag], 0
	jz	short l_combatCheck

	; I think this checks for spells that shouldn't be able
	; to be cast from items
	mov	bx, [bp+spellNo]
	test	g_spellCastFlags[bx], spellcast_spellOnly
	jz	l_returnZero
	jmp	short l_callSpellFunction

l_combatCheck:
	mov	bx, [bp+spellNo]
	test	g_spellCastFlags[bx], spellcast_noncombatCastable
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
	FUNC_EXIT
	retf
spell_cast endp
