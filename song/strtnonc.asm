; Attributes: bp-based frame

song_doNoncombatEffect proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	al, gs:g_currentSong
	sub	ah, ah
	jmp	l_songSwitch
l_safety:
	mov	gs:songAntiMonster, 1
	jmp	l_return
l_sanctuary:
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	cmp	gs:roster.level[bx], 60
	jnb	short l_maxFifteen
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	mov	ax, gs:roster.level[bx]
	shr	ax, 1
	shr	ax, 1
	jmp	short l_setBonus
l_maxFifteen:
	mov	al, 15
l_setBonus:
	mov	gs:songACBonus,	al
	or	al, al
	jnz	short l_setBonusIfZero
	inc	gs:songACBonus
l_setBonusIfZero:
	mov	byte ptr word_44166,	0
	jmp	l_return
l_duotime:
	mov	gs:songRegenSppt, 1
	jmp	l_return
l_watchwood:
	mov	lightDistance, 5
	mov	lightDuration, 0FFh
	mov	gs:gl_detectSecretDoorFlag, 0FFh
	sub	ax, ax
	push	ax
	std_call	icon_activate, 2
	jmp	short l_return
l_overture:
	mov	compassDuration, 0FFh
	mov	ax, 1
	push	ax
	std_call	icon_activate, 2
	jmp	short l_return
l_shield:
	mov	gs:songHalfDamage, 1
	mov	shieldDuration, 0FFh
	mov	ax, 3
	push	ax
	std_call	icon_activate, 2
	jmp	short l_return
l_songSwitch:
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
l_return:
	mov	sp, bp
	pop	bp
	retf
song_doNoncombatEffect endp

