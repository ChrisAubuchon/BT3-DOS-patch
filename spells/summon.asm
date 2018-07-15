; Attributes: bp-based frame

sp_summonSpell proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	sub	ah, ah
	push	ax
	push	[bp+spellCaster]
	CALL(summon_execute)

	FUNC_EXIT
	retf
sp_summonSpell endp
