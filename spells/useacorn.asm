; Attributes: bp-based frame

_sp_useAcorn proc far

	spellCaster= byte ptr	 6

	FUNC_ENTER

	PUSH_OFFSET(s_ateIt)
	PRINTSTRING
	mov	al, [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	word ptr [bp+spellCaster]
	CALL(_batchSpellCast)
	mov	sp, bp
	pop	bp
	retf
_sp_useAcorn endp

