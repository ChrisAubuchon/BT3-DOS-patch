; Attributes: bp-based frame

song_singNonCombat	proc far

	partySlotNumber= word ptr	-6
	subtractor= word ptr	-4
	songNumber= word ptr	-2

	FUNC_ENTER
	CHKSTK(6)

	CALL(text_clear)
	PUSH_OFFSET(s_whoWillPlay)
	PRINTSTRING

	CALL(readSlotNumber)
	mov	[bp+partySlotNumber], ax
	or	ax, ax
	jl	short l_return

	push	ax
	CALL(sing_getSongSubtractor, near)
	mov	[bp+subtractor], ax

	push	[bp+partySlotNumber]
	CALL(_canSingSong, near)
	or	ax, ax
	jz	short l_waitAndReturn

	cmp	[bp+subtractor], 0
	jl	short l_waitAndReturn

	CALL(text_clear)
	sub	ax, ax
	push	ax
	push	[bp+partySlotNumber]
	CALL(song_getSong, near)
	mov	[bp+songNumber], ax
	or	ax, ax
	jl	short l_waitAndReturn

	; End currently playing song
	CALL(endNoncombatSong, near)

	push	[bp+songNumber]
	push	[bp+partySlotNumber]
	CALL(song_playSong, near)

	CALL(song_doNoncombatEffect, near)
	mov	al, byte ptr [bp+subtractor]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	sub	gs:party.specAbil[bx],	cl
l_waitAndReturn:
	IOWAIT
l_return:
	CALL(text_clear)
	FUNC_EXIT
	retf
song_singNonCombat	endp
