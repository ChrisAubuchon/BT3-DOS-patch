; Attributes: bp-based frame

sp_antiMagic proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:antiMagicFlag, al
	mov	sp, bp
	pop	bp
	retf
sp_antiMagic endp
