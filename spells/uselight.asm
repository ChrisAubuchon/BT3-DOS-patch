; Attributes: bp-based frame

_sp_useLightObj	proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER

	PUSH_OFFSET(s_makesLight)
	PRINTSTRING
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	CALL(sp_lightSpell)

	FUNC_EXIT
	retf
_sp_useLightObj	endp
