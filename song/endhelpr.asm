; Attributes: bp-based frame

endNoncombatSong proc far
	FUNC_ENTER
	CHKSTK
	NEAR_CALL(song_endNoncombatEffect)
	CALL(song_endMusic)
	mov	sp, bp
	pop	bp
	retf
endNoncombatSong endp

