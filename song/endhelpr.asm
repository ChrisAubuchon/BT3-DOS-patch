; Attributes: bp-based frame

endNoncombatSong proc far
	FUNC_ENTER

	CALL(song_endNoncombatEffect, near)
	CALL(song_endMusic)
	mov	sp, bp
	pop	bp
	retf
endNoncombatSong endp

