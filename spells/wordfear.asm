; Attributes: bp-based frame

sp_wordOfFear proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK
	push	si

	push	[bp+spellCaster]
	NEAR_CALL(spellSavingThrowHelper,2)
	or	ax, ax
	jz	short l_return
	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	si, ax
	and	si, 3
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:monSpellToHitPenalty[si], al
	mov	bx, [bp+spellIndexNumber]

	; byte_41E50 isn't used anywhere else
	mov	al, spellEffectFlags[bx]
	add	gs:byte_41E50[si], al

	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_42567, al
l_return:
	pop	si
	FUNC_EXIT
	retf
sp_wordOfFear endp

