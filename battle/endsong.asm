; Attributes: bp-based frame

bat_endCombatSong proc far
	FUNC_ENTER

	cmp	gs:g_currentSongPlusOne, 0
	jz	short l_return
	mov	gs:g_currentSongPlusOne, 0
	mov	al, gs:g_currentSong
	sub	ah, ah
	jmp	short l_songSwitch
l_sirrobin:
	and	gs:g_disbelieveFlags, 0FDh
	jmp	short l_endAndReturn
l_shield:
	mov	gs:songHalfDamage, 0
	mov	gs:partySpellAcBonus, 0
	jmp	short l_endAndReturn
l_sanctuary:
	mov	gs:g_songAcBonus,	0
l_bringaround:
	mov	gs:songRegenHP,	0
	jmp	short l_endAndReturn
l_duotime:
	mov	gs:g_songExtraAttackFlag, 0
	jmp	short l_endAndReturn
l_songSwitch:
	or	ax, ax
	jz	short l_sirrobin
	cmp	ax, song_sanctuary
	jz	short l_sanctuary
	cmp	ax, song_bringaround
	jz	short l_bringaround
	cmp	ax, song_duotime
	jz	short l_duotime
	cmp	ax, song_shield
	jz	short l_shield
l_endAndReturn:
	CALL(sound_stop)
l_return:
	FUNC_EXIT
	retf
bat_endCombatSong endp
