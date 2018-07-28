; Attributes: bp-based frame

temple_getHealee proc far

	deltaHP= word ptr -112h
	payee= word ptr	-110h
	statusAilment= word ptr	-10Eh
	stringBufferP= dword ptr -10Ah
	stringBuffer= word ptr -104h
	healeeSlotNumber= word ptr	-4
	healCost= word ptr -2
	lastPartySlot= word ptr	 6

	FUNC_ENTER(112h)
	push	si

	PUSH_OFFSET(s_whoNeedsHealing)
	PRINTSTRING(true)

	CALL(readSlotNumber, near)
	mov	[bp+healeeSlotNumber], ax
	or	ax, ax
	jl	l_return

	mov	ax, [bp+lastPartySlot]
	cmp	[bp+healeeSlotNumber], ax
	jge	l_return

	CHARINDEX(ax, STACKVAR(healeeSlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	push	[bp+healeeSlotNumber]
	CALL(temple_getStatusAilment, near)
	mov	[bp+statusAilment], ax
	or	ax, ax
	jz	short l_noStatusAilment
	PUSH_OFFSET(s_isInBadShape)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_thouMustSacrifice)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	push	[bp+statusAilment]
	push	[bp+healeeSlotNumber]
	CALL(temple_getHealPrice, near)
	mov	[bp+healCost], ax
	jmp	l_getPayer
l_noStatusAilment:
	CHARINDEX(ax, STACKVAR(healeeSlotNumber), si)
	mov	ax, gs:party.maxHP[si]
	sub	ax, gs:party.currentHP[si]
	mov	[bp+deltaHP], ax
	or	ax, ax
	jnz	short l_healHpAmount

	mov	ax, gs:party.maxLevel[si]
	cmp	gs:party.level[si], ax
	jnz	short l_healLevelDrain

	PUSH_OFFSET(s_dontNeedHealing)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	jmp	l_return

l_healLevelDrain:
	PUSH_OFFSET(s_drainedOfLife)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	mov	ax, 8
	push	ax
	push	[bp+healeeSlotNumber]
	CALL(temple_getHealPrice, near)
	mov	[bp+healCost], ax
	jmp	short l_getPayer
l_healHpAmount:
	PUSH_OFFSET(s_hasWounds)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	mov	ax, [bp+deltaHP]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	[bp+healCost], ax
	PUSH_OFFSET(s_donationWillBe)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
l_getPayer:
	sub	ax, ax
	push	ax
	mov	ax, [bp+healCost]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)
	PUSH_OFFSET(s_templeGoldForfeit)
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	CALL(readSlotNumber, near)
	mov	[bp+payee], ax
	or	ax, ax
	jl	l_return

	mov	ax, [bp+healCost]
	cwd
	push	dx
	push	ax
	push	[bp+payee]
	CALL(character_removeGold, near)
	or	ax, ax
	jnz	short l_clearStatus
	PUSH_OFFSET(s_sorryButWithoutProper)
	PRINTSTRING(true)
	jmp	l_return
l_clearStatus:
	cmp	[bp+statusAilment], 0
	jz	short l_healLevel
	push	[bp+statusAilment]
	push	[bp+healeeSlotNumber]
	CALL(temple_clearStatusAilment, near)
	jmp	short l_layHands
l_healLevel:
	CHARINDEX(ax, STACKVAR(healeeSlotNumber), si)
	mov	ax, gs:party.maxLevel[si]
	cmp	gs:party.level[si], ax
	jz	short l_healHp
	dec	ax
	push	ax
	push	[bp+healeeSlotNumber]
	CALL(getLevelXp, near)
	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	CHARINDEX(ax, STACKVAR(healeeSlotNumber), si)
	mov	ax, gs:party.maxLevel[si]
	mov	gs:party.level[si], ax
	jmp	short l_layHands
l_healHp:
	CHARINDEX(ax, STACKVAR(healeeSlotNumber), si)
	mov	ax, gs:party.maxHP[si]
	mov	gs:party.currentHP[si], ax
l_layHands:
	PUSH_OFFSET(s_layHands)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	xor	ax, ax
	push	ax
	mov	ax, 3
	push	ax
	push	[bp+healeeSlotNumber]
	PUSH_STACK_DWORD(stringBufferP)
	CALL(printCharPronoun, near)
	SAVE_STACK_DWORD(dx,ax,stringBufferP)
	PUSH_OFFSET(s_elipsis)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_elipsisAnd)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	sub	ax, ax
	push	ax
	push	ax
	push	[bp+healeeSlotNumber]
	PUSH_STACK_DWORD(stringBufferP)
	CALL(printCharPronoun, near)
	SAVE_STACK_DWORD(dx,ax,stringBufferP)
	PUSH_OFFSET(s_isHealed)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
l_return:
	pop	si
	FUNC_EXIT
	retf
temple_getHealee endp
