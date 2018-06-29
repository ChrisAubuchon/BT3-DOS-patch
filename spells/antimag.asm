; Attributes: bp-based frame

sp_antiMagic proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:antiMagicFlag, al

	FUNC_EXIT
	retf
sp_antiMagic endp
