; Attributes: bp-based frame

; DWORD - var_108 & var_10A

temple_getHealee proc far

	deltaHP= word ptr -112h
	payee= word ptr	-110h
	statusAilment= word ptr	-10Eh
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
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
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	push	[bp+healeeSlotNumber]
	CALL(temple_getStatusAilment, near)
	mov	[bp+statusAilment], ax
	or	ax, ax
	jz	short l_noStatusAilment
	PUSH_OFFSET(s_isInBadShape)
	push	[bp+var_108]
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_OFFSET(s_thouMustSacrifice)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
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
	push	[bp+var_108]
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	jmp	l_return

l_healLevelDrain:
	PUSH_OFFSET(s_drainedOfLife)
	push	[bp+var_108]
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, 8
	push	ax
	push	[bp+healeeSlotNumber]
	CALL(temple_getHealPrice, near)
	mov	[bp+healCost], ax
	jmp	short l_getPayer
l_healHpAmount:
	PUSH_OFFSET(s_hasWounds)
	push	[bp+var_108]
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, [bp+deltaHP]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	[bp+healCost], ax
	PUSH_OFFSET(s_donationWillBe)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
l_getPayer:
	sub	ax, ax
	push	ax
	mov	ax, [bp+healCost]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	ITOA
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_OFFSET(s_templeGoldForfeit)
	push	ax
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
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
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	xor	ax, ax
	push	ax
	mov	ax, 3
	push	ax
	push	[bp+healeeSlotNumber]
	push	dx
	push	[bp+var_10A]
	CALL(printCharPronoun, near)
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_OFFSET(s_elipsis)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_OFFSET(s_elipsisAnd)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	sub	ax, ax
	push	ax
	push	ax
	push	[bp+healeeSlotNumber]
	push	dx
	push	[bp+var_10A]
	CALL(printCharPronoun, near)
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_OFFSET(s_isHealed)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
l_return:
	pop	si
	FUNC_EXIT
	retf
temple_getHealee endp
