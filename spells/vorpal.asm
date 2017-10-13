; Attributes: bp-based frame

sp_vorpalPlating proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 7Fh
	add	gs:vorpalPlateBonus[bx], al
	mov	sp, bp
	pop	bp
	retf
sp_vorpalPlating endp
