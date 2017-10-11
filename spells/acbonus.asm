; Attributes: bp-based frame
sp_acBonus proc	far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:partySpellAcBonus, al
	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	sub	gs:g_monFreezeAcPenalty[bx], al
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_acBonus endp

