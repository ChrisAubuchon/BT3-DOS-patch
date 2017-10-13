
; Attributes: bp-based frame

song_stopPlaying proc far

	partySlotNumber= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+partySlotNumber]
	jnz	short l_return			; Not the current singer
	cmp	gs:g_currentSongPlusOne, ah
	jz	short l_return			; No song playing
	push	cs
	call	near ptr endNoncombatSong
l_return:
	mov	sp, bp
	pop	bp
	retf
song_stopPlaying endp

