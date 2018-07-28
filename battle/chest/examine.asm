; Attributes: bp-based frame

chest_examine proc far

	slotNumber= word ptr -106h
	stringBufferP= dword ptr -104h
	stringBuffer= word ptr -100h

	FUNC_ENTER(106h)
	push	si
	PRINTOFFSET(s_whoWillExamine, clear)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	l_returnZero

	mov	bx, [bp+slotNumber]
	mov	al, g_byteMaskList[bx]
	sub	ah, ah
	test	gs:g_chestExamined, ax
	jz	short l_newExaminer

	PRINTOFFSET(s_alreadyExamined, clear)
	jmp	l_returnZero

l_newExaminer:
	mov	bx, [bp+slotNumber]
	mov	al, g_byteMaskList[bx]
	sub	ah, ah
	or	gs:g_chestExamined, ax

	CHARINDEX(ax, bx, bx)
	test	gs:party.status[bx], 1Ch
	jnz	l_returnZero
	CHARINDEX(ax, STACKVAR(slotNumber), si)

	cmp	gs:party.class[si], class_rogue
	jnz	short l_foundNothing
	CALL(random)

	cmp	gs:(party.specAbil+1)[si], al
	jnb	short l_foundTrap

l_foundNothing:
	PRINTOFFSET(s_foundNothing, clear)
	jmp	short l_returnZero

l_foundTrap:
	PUSH_OFFSET(s_looksLike)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	mov	bx, gs:g_trapIndex
	mov	al, g_chestTrapIndexToName[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_chestTrapName+2)[bx]
	push	word ptr g_chestTrapName[bx]
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(clear)

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
chest_examine endp
