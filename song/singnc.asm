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
	NEAR_CALL(sing_getSongSubtractor, 2)
	mov	[bp+subtractor], ax

	push	[bp+partySlotNumber]
	NEAR_CALL(_canSingSong,2)
	or	ax, ax
	jz	short l_waitAndReturn

	cmp	[bp+subtractor], 0
	jl	short l_waitAndReturn

	CALL(text_clear)
	sub	ax, ax
	push	ax
	push	[bp+partySlotNumber]
	NEAR_CALL(song_getSong, 4)
	mov	[bp+songNumber], ax
	or	ax, ax
	jl	short l_waitAndReturn

	; End currently playing song
	NEAR_CALL(endNoncombatSong)

	push	[bp+songNumber]
	push	[bp+partySlotNumber]
	NEAR_CALL(song_playSong, 4)

	NEAR_CALL(song_doNoncombatEffect)
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
