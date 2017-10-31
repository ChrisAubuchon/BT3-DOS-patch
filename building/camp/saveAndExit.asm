; Attributes: bp-based frame

camp_saveAndExit proc far

	FUNC_ENTER
	CHKSTK()
	PUSH_OFFSET(s_saveAndExit)
	PRINTSTRING(true)
	NEAR_CALL(roster_writeParty)
	sub	ax, ax
	push	ax
	GETKEY
	cmp	ax, 0Dh
	jnz	short loc_13412
	mov	buildingRvalMaybe, 0FFh
	NEAR_CALL(roster_countCharacters)
	push	ax
	NEAR_CALL(writeCharacterFile, 2)
	NEAR_CALL(roster_countParties)
	push	ax
	NEAR_CALL(writePartyFile, 2)
loc_13412:
	CALL(text_clear)
	mov	sp, bp
	pop	bp
	retf
camp_saveAndExit endp
