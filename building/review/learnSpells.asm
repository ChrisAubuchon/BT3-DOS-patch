; Attributes: bp-based frame

review_learnSpells	proc far

	stringBuffer= word ptr -10Eh
	payeeSlotNumber= word ptr	-0Eh
	spellBase= word	ptr -0Ch
	loopCounter= word ptr -0Ah
	levelCost= word ptr	-8
	stringBufferP= dword ptr -6
	slotNumber=	word ptr -2

	FUNC_ENTER(10Eh)
	push	si

	PUSH_OFFSET(s_whoSeeksKnowledge)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	mov	[bp+spellBase],	ax
	cmp	ax, 0FFh
	jnz	short l_isSpellcaster
	PUSH_OFFSET(s_thouArtNotASpellcaster)
	PRINTSTRING(wait)
	jmp	l_return

l_isSpellcaster:
	mov	[bp+loopCounter], 0

l_searchSpellLevelsLoop:
	push	[bp+spellBase]
	push	[bp+loopCounter]
	push	[bp+slotNumber]
	CALL(character_learnedSpellLevel, near)
	or	ax, ax
	jz	short l_learnedAllLevelsCheck
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_searchSpellLevelsLoop

l_learnedAllLevelsCheck:
	cmp	[bp+loopCounter], 6
	jle	short l_levelCheckForSpells
	PRINTOFFSET(s_learnedAllSpells, wait)
	jmp	l_return

l_levelCheckForSpells:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, gs:party.level[bx]
	inc	ax
	shr	ax, 1
	mov	cx, [bp+loopCounter]
	inc	cx
	cmp	ax, cx
	jnb	short l_ioLoop
	PUSH_OFFSET(s_cannotAcquireNewSpells)
	PRINTSTRING(wait)
	jmp	l_return

l_ioLoop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_classString+2)[bx]
	push	word ptr g_classString[bx]
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_spellLevel)
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	al, byte ptr [bp+loopCounter]
	add	al, '1'
	mov	fs:[bx], al
	PUSH_OFFSET(s_willCost)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	mov	ax, spellLevelCost[bx]
	mov	[bp+levelCost], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+levelCost]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	ITOA(stringBufferP)
	PUSH_OFFSET(s_inGoldWhoWillPay)
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+payeeSlotNumber], ax
	or	ax, ax
	jl	short l_return

	mov	ax, [bp+levelCost]
	cwd
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(payeeSlotNumber), si)
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short l_removeGold
	jb	short l_notEnoughGold
	cmp	word ptr gs:party.gold[si], cx
	jnb	short l_removeGold

l_notEnoughGold:
	PUSH_OFFSET(s_notEnoughGoldNl)
	PRINTSTRING(wait)
	jmp	l_ioLoop

l_removeGold:
	mov	ax, [bp+levelCost]
	cwd
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(payeeSlotNumber), si)
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	PUSH_OFFSET(s_elderTeachersLore)
	PRINTSTRING(wait)
	push	[bp+spellBase]
	push	[bp+loopCounter]
	push	[bp+slotNumber]
	CALL(character_learnSpellLevel, near)
	jmp	short l_return

l_return:
	pop	si
	FUNC_EXIT
	retf
review_learnSpells	endp
