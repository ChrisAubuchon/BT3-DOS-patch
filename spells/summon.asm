; Attributes: bp-based frame

sp_summonSpell proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	push	ax
	push	[bp+spellCaster]
	call	doSummon
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sp_summonSpell endp
