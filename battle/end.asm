; Attributes: bp-based frame

bat_end	proc far

	loopCounter= word ptr	-2
	batCurrentSong= word ptr	6
	currentSinger= word ptr	 8
	currentSong= word ptr	 0Ah

	FUNC_ENTER(2)
	push	si

	sub	al, al
	mov	gs:g_nonRandomBattleFlag, al
	mov	byte_4EECC, al
	mov	g_partyAttackFlag, al
	mov	[bp+loopCounter], 0
l_resetMonsterGRoups:
	MONINDEX(ax, STACKVAR(loopCounter), si)
	mov	byte ptr gs:monGroups._name[si], 0
	mov	gs:monGroups.groupSize[si], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_resetMonsterGRoups

l_convertSong:
	cmp	[bp+batCurrentSong], 0
	jz	short l_stopSound
	push	[bp+currentSinger]
	CALL(_charCanPlaySong)
	or	ax, ax
	jz	short l_stopSound

	push	[bp+currentSong]
	push	[bp+currentSinger]
	CALL(song_playSong)
	CALL(song_doNoncombatEffect)
	jmp	short l_return

l_stopSound:
	CALL(sound_stop)

l_return:
	CALL(bat_reset)
	pop	si
	FUNC_EXIT
	retf
bat_end	endp
