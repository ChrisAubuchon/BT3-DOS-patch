; Attributes: bp-based frame

sp_luckSpell proc far

	spellCaster= word ptr	 6
	spelIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+spelIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_41E70, al
	push	bx
	push	[bp+spellCaster]
	near_call	sp_antiMagic,4
	mov	sp, bp
	pop	bp
	retf
sp_luckSpell endp
