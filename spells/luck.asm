; Attributes: bp-based frame

sp_luckSpell proc far

	spellCaster= word ptr	 6
	spelIndexNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK

	mov	bx, [bp+spelIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_41E70, al
	push	bx
	push	[bp+spellCaster]
	NEAR_CALL(sp_antiMagic,4)
	mov	sp, bp
	pop	bp
	retf
sp_luckSpell endp
