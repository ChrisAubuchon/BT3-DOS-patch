; Attributes: bp-based frame

bat_monResetGroups proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	[bp+var_2], ax
	jmp	short loc_1C9AD
loc_1C9AA:
	inc	[bp+var_2]
loc_1C9AD:
	cmp	[bp+var_2], 3
	jge	short loc_1C9D5
	mov	ax, monStruSize
	push	ax
	sub	ax, ax
	push	ax
	getMonP	[bp+var_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8
	jmp	short loc_1C9AA
loc_1C9D5:
	mov	sp, bp
	pop	bp
	retf
bat_monResetGroups endp
