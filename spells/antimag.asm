; Attributes: bp-based frame

sp_antiMagic proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:antiMagicFlag, al
	mov	sp, bp
	pop	bp
	retf
sp_antiMagic endp
