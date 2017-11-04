; Attributes: bp-based frame

summon_printNoRoom	proc far

	noRoomFlag= word ptr	 6

	FUNC_ENTER
	CHKSTK

	cmp	[bp+noRoomFlag], 0
	jnz	short l_return
	PUSH_OFFSET(s_noRoomForSummon)
	PRINTSTRING()
	DELAY()

l_return:
	FUNC_EXIT
	retf
summon_printNoRoom	endp

