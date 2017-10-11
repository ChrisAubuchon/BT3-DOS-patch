; Attributes: bp-based frame
_sp_reenergizeMage proc	far

	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+spellCaster], si
	mov	ax, gs:roster.maxSppt[si]
	mov	gs:roster.currentSppt[si], ax
	push_ds_string aIsReEnergized
	func_printString
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_reenergizeMage endp
