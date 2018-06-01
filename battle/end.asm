; Attributes: bp-based frame

bat_end	proc far

	var_2= word ptr	-2
	song= word ptr	6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	sub	al, al
	mov	gs:g_nonRandomBattleFlag, al
	mov	byte_4EECC, al
	mov	g_partyAttackFlag, al
	mov	[bp+var_2], 0
	jmp	short loc_1F1A5
loc_1F1A2:
	inc	[bp+var_2]
loc_1F1A5:
	cmp	[bp+var_2], 4
	jge	short loc_1F1C5
	getMonP	[bp+var_2], si
	mov	byte ptr gs:monGroups._name[si], 0
	mov	gs:monGroups.groupSize[si], 0
	jmp	short loc_1F1A2
loc_1F1C5:
	cmp	[bp+song], 0
	jz	short loc_1F1EF
	push	[bp+arg_2]
	call	_charCanPlaySong
	add	sp, 2
	or	ax, ax
	jz	short loc_1F1EF
	push	[bp+arg_4]
	push	[bp+arg_2]
	call	song_playSong
	add	sp, 4
	call	song_doNoncombatEffect
	jmp	short loc_1F1F4
loc_1F1EF:
	call	sound_stop
loc_1F1F4:
	call	bat_reset
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_end	endp
