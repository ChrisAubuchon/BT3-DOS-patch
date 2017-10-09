; Attributes: bp-based frame

sp_freezeFoes proc far

	spellCaster=	word ptr  6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation

	push	[bp+spellCaster]
	near_call	spellSavingThrowHelper, 2
	or	ax, ax
	jz	short l_return

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 3
	add	gs:g_monFreezeAcPenalty[bx], al
	add	gs:byte_41E70, 2
	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:g_charFreezeAcPenalty, al
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_freezeFoes endp

