; Attributes: bp-based frame

sp_summonSpell proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	push	ax
	push	[bp+spellCaster]
	CALL(doSummon)

	FUNC_EXIT
	retf
sp_summonSpell endp
