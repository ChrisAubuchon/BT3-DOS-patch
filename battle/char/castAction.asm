; Attributes: bp-based frame

bat_charCastAction proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, 1
	push	ax
	push	[bp+arg_0]
	call	getSpellNumber
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1D4ED
	sub	ax, ax
	jmp	short loc_1D541
loc_1D4ED:
	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
	cmp	[bp+var_2], 4
	jg	short loc_1D52D
	mov	ax, offset s_castAt
	push	ds
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr bat_charGetActionTarget
	add	sp, 6
	or	ax,ax
	jge	l_bat_charCastAction_gotTarget

	mov	ax, 0				; Return 0 if no target selected.
	jmp	loc_1D541

l_bat_charCastAction_gotTarget:
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
	mov	ax, 1
	jmp	short loc_1D541
loc_1D52D:
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
loc_1D53C:
	mov	ax, 1
	jmp	short $+2
loc_1D541:
	mov	sp, bp
	pop	bp
	retf
bat_charCastAction endp
