; Attributes: bp-based frame

sp_levitation proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	levitationDuration, al
	mov	ax, icon_levitation
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_levitation endp
