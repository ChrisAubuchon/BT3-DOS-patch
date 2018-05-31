
; Attributes: bp-based frame

bat_monSummonHelp proc far

	stringBufferP= dword ptr -104h
	stringBuffer= word ptr -100h
	slotNumber= word ptr	 6
	arg_4= word ptr	 0Ah

	FUNC_ENTER(104h)
	push	si

	push	[bp+slotNumber]
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(bat_monGetName, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	PUSH_OFFSET(s_summonsHelp)
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	CALL(random)
	sub	ah, ah
	cmp	ax, [bp+arg_4]
	jnb	short l_noHelp

	MONINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:monGroups.groupSize[bx]
	and	al, 1Fh
	cmp	al, 1Fh
	jz	short l_noHelp

	test	gs:disbelieveFlags, disb_nohelp
	jz	short loc_1B5B0

l_noHelp:
	PUSH_OFFSET(s_noneAppears)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	jmp	l_return

loc_1B5B0:
	PUSH_OFFSET(s_anotherJoins)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	MONINDEX(ax, STACKVAR(slotNumber), si)
	inc	gs:monGroups.groupSize[si]
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	CALL(randomYdX, near)
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bl, gs:monGroups.groupSize[si]
	and	bx, 1Fh
	shl	bx, 1
	mov	ax, [bp+slotNumber]
	mov	dx, cx
	mov	cl, 6
	shl	ax, cl
	add	bx, ax
	mov	gs:monHpList[bx], dx
	MONINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:monGroups.groupSize[bx]
	and	bx, 1Fh
	shl	bx, 1
	mov	ax, [bp+slotNumber]
	shl	ax, cl
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0

l_return:
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING

	pop	si
	FUNC_EXIT
	retf
bat_monSummonHelp endp
