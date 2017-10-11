; Attributes: bp-based frame

sp_shieldSpell proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+spellCaster], 80h
	jl	short l_partyCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellExtraFlags[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	sub	gs:g_monFreezeAcPenalty[bx], al
	jmp	short loc_215BE
l_partyCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	shieldDuration, al
	mov	al, spellExtraFlags[bx]
	mov	shieldAcBonus, al
	mov	ax, icon_shield
	push	ax
	call	icon_activate
	add	sp, 2
	mov	byte ptr word_44166,	0
loc_215BE:
	mov	sp, bp
	pop	bp
	retf
sp_shieldSpell endp
