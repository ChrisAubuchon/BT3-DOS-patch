; DWORD - stringBuffer & var_104
;
; Attributes: bp-based frame

summon_addMonToGroup proc far

	var_116= word ptr -116h
	var_106= word ptr -106h
	var_104= word ptr -104h
	stringBuffer= word ptr -102h
	groupSize= word	ptr -2
	arg_0= byte ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER(116h)
	push	si

	MONINDEX(ax, STACKVAR(arg_2), bx)
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	cmp	ax, 1Fh
	jnz	short loc_2607B
	sub	ax, ax
	jmp	l_return
loc_2607B:
	MONINDEX(ax, STACKVAR(arg_2), si)
	inc	gs:monGroups.groupSize[si]
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	CALL(randomYdX)
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+arg_2]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+groupSize]
	shl	cx, 1
	add	bx, cx
	mov	gs:monHpList[bx], ax
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
	or	gs:monGroups.flags[bx],	10h
	jmp	short loc_26101
loc_260EF:
	MONINDEX(ax, STACKVAR(arg_2), bx)
	and	gs:monGroups.flags[bx],	0EFh
loc_26101:
	PUSH_STACK_ADDRESS(var_116)
	MONINDEX(ax, STACKVAR(arg_2), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)
	PUSH_OFFSET(s_andA)
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(strcat)
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	sub	ax, ax
	push	ax
	push	dx
	push	[bp+var_106]
	PUSH_STACK_ADDRESS(var_116)
	CALL(str_pluralize)
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	PUSH_OFFSET(s_appears)
	push	dx
	push	[bp+var_106]
	CALL(strcat)
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	ax, 1
l_return:
	pop	si
	FUNC_EXIT
	retf
summon_addMonToGroup endp
