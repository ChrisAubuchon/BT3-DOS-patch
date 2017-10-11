; Attributes: bp-based frame

sp_wordOfFear proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si

	push	[bp+spellCaster]
	near_call	spellSavingThrowHelper,2
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
	mov	sp, bp
	pop	bp
	retf
sp_wordOfFear endp

