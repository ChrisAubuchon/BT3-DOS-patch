; Attributes: bp-based frame

bat_giveGold proc far

	var_8= word ptr	-8
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
	mov	[bp+var_8], ax
	cmp	ax, 7
	jle	short loc_1EA5F
	sub	ax, ax
	cwd
	jmp	short loc_1EAB6
loc_1EA5F:
	mov	ax, [bp+var_8]
	cwd
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	__32bitDivide
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	[bp+var_6], 0
	jmp	short loc_1EA80
loc_1EA7D:
	inc	[bp+var_6]
loc_1EA80:
	mov	ax, [bp+var_8]
	cmp	[bp+var_6], ax
	jge	short loc_1EAAE
	getCharP	[bp+var_6], si
	cmp	gs:party.class[si], class_illusion
	jnb	short loc_1EAAC
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	add	word ptr gs:party.gold[si], ax
	adc	word ptr gs:(party.gold+2)[si], dx
loc_1EAAC:
	jmp	short loc_1EA7D
loc_1EAAE:
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	jmp	short $+2
loc_1EAB6:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_giveGold endp
