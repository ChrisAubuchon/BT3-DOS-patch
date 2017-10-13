; Attributes: bp-based frame

sp_areaEnchant proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	detectDuration, al
	mov	al, spellExtraFlags[bx]
	mov	detectType, al
	mov	ax, icon_areaEnchant
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_areaEnchant endp
