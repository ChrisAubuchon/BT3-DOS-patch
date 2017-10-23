; Attributes: bp-based frame

; byte_4EEC3 and byte_4EEC4 don't seem to be
; used for anything.

_batchSpellCast proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK

	and	[bp+spellIndexNumber], 7Fh
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	mov	bx, [bp+spellIndexNumber]
	shl	bx, 1
	shl	bx, 1
	call	spellFuncList[bx]
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
_batchSpellCast endp

