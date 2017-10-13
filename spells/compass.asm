; Attributes: bp-based frame

sp_compassSpell	proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	compassDuration, al
	mov	ax, icon_compass
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_compassSpell	endp

