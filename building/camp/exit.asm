; Attributes: bp-based frame

camp_exit	proc far

	FUNC_ENTER
	CHKSTK

	NEAR_CALL(roster_writeParty)
	NEAR_CALL(roster_countCharacters)
	push	ax
	NEAR_CALL(writeCharacterFile, 2)
	NEAR_CALL(roster_countParties)
	push	ax
	NEAR_CALL(writePartyFile, 2)

	mov	g_currentHour, 6
	sub	al, al
	mov	levelNoMaybe, al
	mov	gs:isNight, al
	mov	buildingRvalMaybe, 2

	FUNC_EXIT
	retf
camp_exit	endp
