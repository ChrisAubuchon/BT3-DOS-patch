; Attributes: bp-based frame

endNoncombatSong proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	cs
	call	near ptr song_endNoncombatEffect
	call	song_endMusic
	mov	sp, bp
	pop	bp
	retf
endNoncombatSong endp
