; Attributes: bp-based frame

sp_freezeFoes proc far

	spellCaster=	word ptr  6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	push	[bp+spellCaster]
	CALL(spellSavingThrowHelper, near)
	or	ax, ax
	jz	short l_return

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 3
	add	gs:g_monFreezeAcPenalty[bx], al
	add	gs:g_charFreezeToHitBonus, 2
	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	add	gs:g_charFreezeAcPenalty, al
l_return:
	FUNC_EXIT
	retf
sp_freezeFoes endp

