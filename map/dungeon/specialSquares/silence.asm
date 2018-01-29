; Attributes: bp-based frame

dunsq_doSilence	proc far
	FUNC_ENTER

	cmp	gs:g_currentSongPlusOne, 0
	jz	short l_return
	PUSH_OFFSET(s_soundOfSilence)
	PRINTSTRING(true)
	CALL(endNoncombatSong)
l_return:
	sub	ax, ax
	FUNC_EXIT
	retf
dunsq_doSilence	endp

