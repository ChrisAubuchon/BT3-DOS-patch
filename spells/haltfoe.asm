; Attributes: bp-based frame
sp_haltFoe proc	far

	spellCaster= word ptr	 6

	FUNC_ENTER

	push	[bp+spellCaster]
	CALL(spellSavingThrowHelper, near)
	or	ax, ax
	jz	short l_return
	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	inc	gs:monFrozenFlag
	jmp	short l_return
l_monCaster:
	inc	gs:partyFrozenFlag
	PUSH_OFFSET(s_partyFreezes)
	PRINTSTRING
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_haltFoe endp
