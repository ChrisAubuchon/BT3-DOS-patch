; Attributes: bp-based frame

endNoncombatSong proc far
	FUNC_ENTER

	CALL(song_endNoncombatEffect, near)
	CALL(sound_stop)
	mov	sp, bp
	pop	bp
	retf
endNoncombatSong endp

