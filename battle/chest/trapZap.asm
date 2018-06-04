; Attributes: bp-based frame

chest_trapZap proc far


define(`slotNumber', `di')
define(`charP', `si')
	FUNC_ENTER
	push	di
	push	si

	PRINTOFFSET(s_whoWillCastTrzp, clear)
	CALL(readSlotNumber)
	mov	slotNumber, ax
	or	ax, ax
	jl	l_returnZero

	CHARINDEX(ax, slotNumber, charP)
	test	gs:party.status[charP], 7Ch
	jnz	l_returnZero

	cmp	gs:party.class[charP], class_monster
	jnb	l_returnZero

	mov	ax, 2
	push	ax
	push	slotNumber
	CALL(character_learnedSpell)
	or	ax, ax
	jz	short l_dontKnowSpell

	cmp	gs:party.currentSppt[charP], 2
	jnb	short l_castSpell

	PRINTOFFSET(s_needTwoSpellPoints, clear)
	jmp	l_returnZero

l_castSpell:
	sub	gs:party.currentSppt[charP], 2
	mov	gs:trapIndex, 0
	mov	byte ptr g_printPartyFlag,	0
	PRINTOFFSET(s_youDisarmedIt, clear)
	IOWAIT
	mov	ax, 1
	jmp	short l_return

l_dontKnowSpell:
	PRINTOFFSET(s_dontKnowThatSpell_, clear)

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	pop	di
	FUNC_EXIT
	retf
chest_trapZap endp

undefine(`slotNumber')
undefine(`charP')
