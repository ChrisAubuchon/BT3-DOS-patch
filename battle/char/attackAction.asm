; Attributes: bp-based frame

bat_charPartyAttackActionion proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aAttack
	push	ds
	push	ax
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr bat_charGetActionTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D4A2
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D4A2:
	cmp	[bp+var_2], 0
	jl	short loc_1D4AD
	mov	ax, 1
	jmp	short loc_1D4AF
loc_1D4AD:
	sub	ax, ax
loc_1D4AF:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_charPartyAttackActionion endp
