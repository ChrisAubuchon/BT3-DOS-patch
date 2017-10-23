; Attributes: bp-based frame
_sp_reenergizeMage proc	far

	spellCaster= word ptr	 6

	FUNC_ENTER
	CHKSTK
	push	si

	CHARINDEX(ax, STACKVAR(spellCaster), si)
	mov	ax, gs:party.maxSppt[si]
	mov	gs:party.currentSppt[si], ax
	PUSH_OFFSET(s_isReenergized)
	PRINTSTRING

	pop	si
	FUNC_EXIT
	retf
_sp_reenergizeMage endp
