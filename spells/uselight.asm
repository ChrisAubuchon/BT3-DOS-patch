; Attributes: bp-based frame

_sp_useLightObj	proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push_ds_string	aMakesALight
	func_printString
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	near_call	sp_lightSpell,4
	mov	sp, bp
	pop	bp
	retf
_sp_useLightObj	endp
