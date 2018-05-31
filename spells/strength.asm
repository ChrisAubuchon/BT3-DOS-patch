; Attributes: bp-based frame

sp_strengthBonus proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	test	byte ptr [bp+spellCaster], 80h
	jz	short l_partCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	mov	gs:monAttackBonus[bx], al
	jmp	short l_return
l_partCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 7
	mov	gs:g_strengthSpellBonus[bx], al
l_return:
	FUNC_EXIT
	retf
sp_strengthBonus endp
