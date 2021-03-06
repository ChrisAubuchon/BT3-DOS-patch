
; Attributes: bp-based frame

song_stopPlaying proc far

	partySlotNumber= word ptr	 6

	FUNC_ENTER

	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+partySlotNumber]
	jnz	short l_return			; Not the current singer
	cmp	gs:g_currentSongPlusOne, ah
	jz	short l_return			; No song playing
	CALL(endNoncombatSong, near)
l_return:
	FUNC_EXIT
	retf
song_stopPlaying endp

