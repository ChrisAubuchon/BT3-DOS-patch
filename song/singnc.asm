; Attributes: bp-based frame

song_singNonCombat	proc far

	partySlotNumber= word ptr	-6
	subtractor= word ptr	-4
	songNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	call	clearTextWindow
	push_ds_string aWhoWillPlay?
	func_printString

	call	getCharNumber
	mov	[bp+partySlotNumber], ax
	or	ax, ax
	jl	short l_return

	push	ax
	near_call	sing_getSongSubtractor, 2
	mov	[bp+subtractor], ax

	push	[bp+partySlotNumber]
	near_call	_canSingSong,2
	or	ax, ax
	jz	short l_waitAndReturn

	cmp	[bp+subtractor], 0
	jl	short l_waitAndReturn

	call	clearTextWindow
	sub	ax, ax
	push	ax
	push	[bp+partySlotNumber]
	near_call	song_getSong, 4
	mov	[bp+songNumber], ax
	or	ax, ax
	jl	short l_waitAndReturn

	; End currently playing song
	push	cs
	call	near ptr endNoncombatSong

	push	[bp+songNumber]
	push	[bp+partySlotNumber]
	near_call	song_playSong, 4

	push	cs
	call	near ptr song_doNoncombatEffect
	mov	al, byte ptr [bp+subtractor]
	mov	cx, ax
	getCharP	[bp+partySlotNumber], bx
	sub	gs:roster.specAbil[bx],	cl
l_waitAndReturn:
	wait4IO
l_return:
	call	clearTextWindow
	mov	sp, bp
	pop	bp
	retf
song_singNonCombat	endp
