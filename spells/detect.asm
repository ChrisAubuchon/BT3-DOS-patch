; Attributes: bp-based frame

sp_areaEnchant proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	detectDuration, al
	mov	al, spellExtraFlags[bx]
	mov	detectType, al
	mov	ax, icon_areaEnchant
	push	ax
	CALL(icon_activate, 2)
	mov	sp, bp
	pop	bp
	retf
sp_areaEnchant endp
