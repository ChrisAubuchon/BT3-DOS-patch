; Attributes: bp-based frame

sp_levitation proc far

	spellIndexNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	levitationDuration, al
	mov	ax, icon_levitation
	push	ax
	CALL(icon_activate)
	mov	sp, bp
	pop	bp
	retf
sp_levitation endp
