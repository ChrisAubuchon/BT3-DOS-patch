; Attributes: bp-based frame

song_playSong proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber= word ptr	 6
	songNumber= byte ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	al, byte ptr [bp+partySlotNumber]
	mov	gs:g_currentSinger, al
	mov	g_songDuration, 5
	mov	al, [bp+songNumber]
	inc	al
	mov	gs:g_currentSongPlusOne, al
	mov	al, [bp+songNumber]
	mov	gs:g_currentSong, al
	call	song_endMusic

	mov	ax, offset byte_40420
	mov	dx, seg	seg026
	push	dx
	push	ax
	mov	bx, word ptr [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	push	gs:musicBufs._segment[bx]
	push	word ptr gs:musicBufs._offset[bx]
	call	d3comp
	add	sp, 8

	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	call	inven_getTypeEqSlot
	add	sp, 4
	mov	[bp+var_4], ax
	inc	ax
	jz	short loc_22D59
	mov	bx, [bp+var_4]
	mov	al, g_instrumentType[bx]
	cbw
	mov	[bp+var_2], ax
	jmp	short loc_22D5E
loc_22D59:
	mov	[bp+var_2], 0
loc_22D5E:
	push	[bp+var_2]
	mov	ax, offset byte_40420
	mov	dx, seg	seg026
	push	dx
	push	ax
	call	song_initSound
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
song_playSong endp