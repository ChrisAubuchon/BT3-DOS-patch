; Attributes: bp-based frame

camp_saveAndExit proc far

	FUNC_ENTER

	PUSH_OFFSET(s_saveAndExit)
	PRINTSTRING(true)
	CALL(roster_writeParty, near)
	sub	ax, ax
	push	ax
	CALL(getKey)
	cmp	ax, 0Dh
	jnz	short loc_13412
	mov	g_mapRval, 0FFh
	CALL(roster_countCharacters, near)
	push	ax
	CALL(writeCharacterFile, near)
	CALL(roster_countParties, near)
	push	ax
	CALL(writePartyFile, near)
loc_13412:
	CALL(text_clear)
	mov	sp, bp
	pop	bp
	retf
camp_saveAndExit endp
