; Attributes: bp-based frame

sp_luckSpell proc far

	spellCaster= word ptr	 6
	spelIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spelIndexNumber]
	mov	al, g_spellEffectData[bx]
	add	gs:g_charFreezeToHitBonus, al
	push	bx
	push	[bp+spellCaster]
	CALL(sp_antiMagic, near)

	FUNC_EXIT
	retf
sp_luckSpell endp
