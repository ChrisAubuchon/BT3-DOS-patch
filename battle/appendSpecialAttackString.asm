; Attributes: bp-based frame

bat_appendSpecialAttackString proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, gs:specialAttackVal
	shl	bx, 1
	shl	bx, 1
	push	word ptr (specialAttString+2)[bx]
	push	word ptr specialAttString[bx]
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	strcat
	add	sp, 8
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_appendSpecialAttackString endp
