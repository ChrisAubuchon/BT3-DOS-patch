; Attributes: bp-based frame

; XXX - arg_4 should probably be a word ptr

printCharPronoun proc far

	var_16=	word ptr -16h
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= byte ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr  0Eh

	FUNC_ENTER(16h)
	push	si

	test	[bp+arg_4], 80h
	jz	short loc_1452D
	mov	ax, word ptr [bp+arg_4]
	and	ax, 3
	MONINDEX(cx, cx)
	mov	si, ax
	mov	al, gs:g_monGroups.packedGenAc[si]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	mov	[bp+var_2], ax
	cmp	ax, 3
	jnz	short loc_1452B
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	lea	ax, g_monGroups._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)
	sub	ax, ax
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	PUSH_STACK_ADDRESS(var_16)
	PLURALIZE
	jmp	short loc_14586
loc_1452B:
	jmp	short loc_14564
loc_1452D:
	CHARINDEX(ax, word ptr [bp+arg_4], si)
	mov	al, gs:party.gender[si]
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_2], ax
	cmp	ax, 3
	jnz	short loc_14564
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	STRCAT
	jmp	short loc_14586
loc_14564:
	mov	bx, [bp+var_2]
	add	bx, [bp+arg_6]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_pronounList+2)[bx]
	push	word ptr g_pronounList[bx]
	push	[bp+arg_2]
	push	[bp+arg_0]
	STRCAT
loc_14586:
	cmp	[bp+arg_8], 0
	jz	printCharPronoun_exit
	PUSH_OFFSET(s_exclBlankLine)
	push	dx
	push	ax
	STRCAT

printCharPronoun_exit:
	pop	si
	FUNC_EXIT
	retf
printCharPronoun endp
