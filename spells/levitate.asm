; Attributes: bp-based frame

sp_levitation proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	mov	levitationDuration, al
	mov	ax, icon_levitation
	push	ax
	CALL(icon_activate)

	FUNC_EXIT
	retf
sp_levitation endp
