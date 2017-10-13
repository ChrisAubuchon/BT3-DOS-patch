; Attributes: bp-based frame

_sp_useAcorn proc far

	spellCaster= byte ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aAteIt_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	al, [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	word ptr [bp+spellCaster]
	near_call	_batchSpellCast, 4
	mov	sp, bp
	pop	bp
	retf
_sp_useAcorn endp

