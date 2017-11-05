; Attributes: bp-based frame

sp_vorpalPlating proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 7Fh
	add	gs:vorpalPlateBonus[bx], al

	FUNC_EXIT
	retf
sp_vorpalPlating endp
