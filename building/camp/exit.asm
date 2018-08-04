; Attributes: bp-based frame

camp_exit	proc far

	FUNC_ENTER

	CALL(roster_writeParty, near)
	CALL(roster_countCharacters, near)
	push	ax
	CALL(writeCharacterFile, near)
	CALL(roster_countParties, near)
	push	ax
	CALL(writePartyFile, near)

	mov	g_currentHour, 6
	sub	al, al
	mov	g_levelNumber, al
	mov	gs:g_isNightFlag, al
	mov	g_mapRval, 2

	FUNC_EXIT
	retf
camp_exit	endp
