; Attributes: bp-based frame

sp_compassSpell	proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	mov	compassDuration, al
	mov	ax, icon_compass
	push	ax
	CALL(icon_activate)

	FUNC_EXIT
	retf
sp_compassSpell	endp

