; Attributes: bp-based frame
sp_haltFoe proc	far

	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	[bp+spellCaster]
	near_call spellSavingThrowHelper,2
	or	ax, ax
	jz	short l_return
	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	inc	gs:monFrozenFlag
	jmp	short l_return
l_monCaster:
	inc	gs:partyFrozenFlag
	mov	ax, offset aAndThePartyFre
	push	ds
	push	ax
	func_printString
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_haltFoe endp
