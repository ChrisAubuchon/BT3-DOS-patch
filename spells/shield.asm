; Attributes: bp-based frame

sp_shieldSpell proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	cmp	[bp+spellCaster], 80h
	jl	short l_partyCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellExtraData[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	sub	gs:g_monFreezeAcPenalty[bx], al
	jmp	short loc_215BE
l_partyCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	mov	shieldDuration, al
	mov	al, g_spellExtraData[bx]
	mov	shieldAcBonus, al
	mov	ax, icon_shield
	push	ax
	CALL(icon_activate)
	mov	byte ptr g_printPartyFlag,	0
loc_215BE:
	FUNC_EXIT
	retf
sp_shieldSpell endp
