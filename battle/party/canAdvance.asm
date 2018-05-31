; Attributes: bp-based frame
bat_partyCanAdvance proc	far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx], 1
	push	cs
	call	near ptr bat_monGroupInMeleeRange
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+1], al
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+2], 1
	mov	sp, bp
	pop	bp
	retf
bat_partyCanAdvance endp

