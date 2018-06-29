; Attributes: bp-based frame

endNoncombatSong proc far
	FUNC_ENTER

	CALL(song_endNoncombatEffect, near)
	CALL(sound_stop)

	FUNC_EXIT
	retf
endNoncombatSong endp

