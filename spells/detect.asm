; Attributes: bp-based frame

sp_areaEnchant proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	mov	detectDuration, al
	mov	al, g_spellExtraData[bx]
	mov	g_detectType, al
	mov	ax, icon_areaEnchant
	push	ax
	CALL(icon_activate)

	FUNC_EXIT
	retf
sp_areaEnchant endp
