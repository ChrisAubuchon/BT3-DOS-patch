; Attributes: bp-based frame

summon_addMonToGroup proc far

	var_116= word ptr -116h
	stringBufferP= dword ptr -106h
	stringBuffer= word ptr -102h
	groupSize= word	ptr -2
	arg_0= byte ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER(116h)
	push	si

	MONINDEX(ax, STACKVAR(arg_2), bx)
	mov	al, gs:g_monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	cmp	ax, 1Fh
	jnz	short loc_2607B
	sub	ax, ax
	jmp	l_return
loc_2607B:
	MONINDEX(ax, STACKVAR(arg_2), si)
	inc	gs:g_monGroups.groupSize[si]
	mov	al, gs:g_monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	CALL(randomYdX)
	mov	cx, gs:g_monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+arg_2]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+groupSize]
	shl	cx, 1
	add	bx, cx
	mov	gs:g_monHpList[bx], ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+groupSize]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	test	[bp+arg_0], 80h
	jz	short loc_260EF
	MONINDEX(ax, STACKVAR(arg_2), bx)
	or	gs:g_monGroups.flags[bx],	10h
	jmp	short loc_26101
loc_260EF:
	MONINDEX(ax, STACKVAR(arg_2), bx)
	and	gs:g_monGroups.flags[bx],	0EFh
loc_26101:
	PUSH_STACK_ADDRESS(var_116)
	MONINDEX(ax, STACKVAR(arg_2), bx)
	lea	ax, g_monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)
	PUSH_OFFSET(s_andA)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	sub	ax, ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_STACK_ADDRESS(var_116)
	PLURALIZE(stringBufferP)
	PUSH_OFFSET(s_appears)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	ax, 1
l_return:
	pop	si
	FUNC_EXIT
	retf
summon_addMonToGroup endp
