; Attributes: bp-based frame

song_endNoncombatEffect	proc far
	FUNC_ENTER

	cmp	gs:g_currentSongPlusOne, 0
	jz	l_return

	mov	gs:g_currentSongPlusOne, 0
	cmp	gs:g_currentSinger, 7
	jnb	l_return
loc_22F03:
	mov	al, gs:g_currentSong
	sub	ah, ah
	jmp	short l_songSwitch
l_safety:
	mov	gs:songAntiMonster, 0
	jmp	short l_return
l_sanctuary:
	mov	gs:g_songAcBonus,	0
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_return
l_duotime:
	mov	gs:songRegenSppt, 0
	jmp	short l_return
l_watchwood:
	mov	lightDistance, 0
	sub	ax, ax
	push	ax
	CALL(icon_deactivate)
	mov	gs:gl_detectSecretDoorFlag, 0
	jmp	short l_return
l_overture:
	mov	ax, 1
	push	ax
	CALL(icon_deactivate)
	jmp	short l_return
l_shield:
	mov	gs:songHalfDamage, 0
	jmp	short l_return
l_songSwitch:
	cmp	ax, song_safety
	jz	short l_safety
	cmp	ax, song_sanctuary
	jz	short l_sanctuary
	cmp	ax, song_duotime
	jz	short l_duotime
	cmp	ax, song_watchwood
	jz	short l_watchwood
	cmp	ax, song_overture
	jz	short l_overture
	cmp	ax, song_shield
	jz	short l_shield
l_return:
	FUNC_EXIT
	retf
song_endNoncombatEffect	endp

