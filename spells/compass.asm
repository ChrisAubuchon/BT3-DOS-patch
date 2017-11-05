; Attributes: bp-based frame

sp_compassSpell	proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	compassDuration, al
	mov	ax, icon_compass
	push	ax
	CALL(icon_activate)
	mov	sp, bp
	pop	bp
	retf
sp_compassSpell	endp

