; Attributes: bp-based frame
sp_acBonus proc	far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	add	gs:partySpellAcBonus, al
	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	sub	gs:g_monFreezeAcPenalty[bx], al
l_return:
	FUNC_EXIT
	retf
sp_acBonus endp

