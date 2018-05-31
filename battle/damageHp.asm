; Attributes: bp-based frame

bat_damageHp proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 80h
	jge	short loc_1E3A1
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_charDamageHp
	add	sp, 2
	jmp	short loc_1E3B1
	jmp	short loc_1E3B1
loc_1E3A1:
	mov	ax, [bp+arg_0]
	and	ax, 7Fh
	push	ax
	push	cs
	call	near ptr bat_monDamageHp
	add	sp, 2
	jmp	short $+2
loc_1E3B1:
	mov	sp, bp
	pop	bp
	retf
bat_damageHp endp

