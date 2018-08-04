; Attributes: bp-based frame

sp_antiMagic proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	add	gs:g_spellAntiMagicValue, al

	FUNC_EXIT
	retf
sp_antiMagic endp
