; Attributes: bp-based frame

_sp_useAcorn proc far

	spellCaster= byte ptr	 6

	FUNC_ENTER
	CHKSTK

	PUSH_OFFSET(s_ateIt)
	PRINTSTRING
	mov	al, [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	word ptr [bp+spellCaster]
	NEAR_CALL(_batchSpellCast, 4)
	mov	sp, bp
	pop	bp
	retf
_sp_useAcorn endp

