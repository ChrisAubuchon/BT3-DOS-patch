; Attributes: bp-based frame

_batchSpellCast proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	and	[bp+spellIndexNumber], 7Fh
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	mov	bx, [bp+spellIndexNumber]
	shl	bx, 1
	shl	bx, 1
	call	spellFuncList[bx]
	add	sp, 4

	FUNC_EXIT
	retf
_batchSpellCast endp

