; Attributes: bp-based frame
bat_giveExperience proc	far

	rostSize= word ptr -8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	call	party_getLastSlot
	inc	ax
	mov	[bp+rostSize], ax
	cmp	ax, 7
	jle	short loc_1E9E4
	sub	ax, ax
	cwd
	jmp	short loc_1EA3B
loc_1E9E4:
	mov	ax, [bp+rostSize]
	cwd
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	__32bitDivide
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	[bp+var_6], 0
	jmp	short loc_1EA05
loc_1EA02:
	inc	[bp+var_6]
loc_1EA05:
	mov	ax, [bp+rostSize]
	cmp	[bp+var_6], ax
	jge	short loc_1EA33
	getCharP	[bp+var_6], si
	cmp	gs:party.class[si], class_monster
	jnb	short loc_1EA31
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	add	word ptr gs:party.experience[si], ax
	adc	word ptr gs:(party.experience+2)[si], dx
loc_1EA31:
	jmp	short loc_1EA02
loc_1EA33:
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	jmp	short $+2
loc_1EA3B:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_giveExperience endp
