; Attributes: bp-based frame

song_doNoncombatEffect proc far
	FUNC_ENTER

	mov	al, gs:g_currentSong
	sub	ah, ah
	cmp	ax, song_safety
	jz	l_safety
	cmp	ax, song_sanctuary
	jz	l_sanctuary
	cmp	ax, song_duotime
	jz	l_duotime
	cmp	ax, song_watchwood
	jz	l_watchwood
	cmp	ax, song_overture
	jz	short l_overture
	cmp	ax, song_shield
	jz	short l_shield
	jmp	l_return

l_safety:
	mov	gs:songAntiMonster, 1
	jmp	l_return

l_sanctuary:
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	cmp	gs:party.level[bx], 60
	jnb	short l_maxFifteen
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	shr	ax, 1
	jmp	short l_setBonus

l_maxFifteen:
	mov	al, 15

l_setBonus:
	mov	gs:g_songAcBonus, al
	or	al, al
	jnz	short l_setBonusIfZero
	inc	gs:g_songAcBonus

l_setBonusIfZero:
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_return

l_duotime:
	mov	gs:g_songRegenerateSppt, 1
	jmp	l_return

l_watchwood:
	mov	lightDistance, 5
	mov	lightDuration, 0FFh
	mov	gs:g_detectSecretDoorFlag, 0FFh
	sub	ax, ax
	push	ax
	CALL(icon_activate)
	jmp	short l_return

l_overture:
	mov	compassDuration, 0FFh
	mov	ax, 1
	push	ax
	CALL(icon_activate)
	jmp	short l_return

l_shield:
	mov	gs:songHalfDamage, 1
	mov	shieldDuration, 0FFh
	mov	ax, 3
	push	ax
	CALL(icon_activate)
	jmp	short l_return

l_return:
	FUNC_EXIT
	retf
song_doNoncombatEffect endp

