; Attributes: bp-based frame

bat_endCombatSong proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	gs:byte_4266B, 0
	jz	short l_return
	mov	gs:byte_4266B, 0
	mov	al, gs:byte_42420
	sub	ah, ah
	jmp	short l_songSwitch
l_sirrobin:
	and	gs:disbelieveFlags, 0FDh
	jmp	short l_endAndReturn
l_shield:
	mov	gs:songHalfDamage, 0
	mov	gs:byte_4244E, 0
	jmp	short l_endAndReturn
l_sanctuary:
	mov	gs:songACBonus,	0
l_bringaround:
	mov	gs:songRegenHP,	0
	jmp	short l_endAndReturn
l_duotime:
	mov	gs:songExtraAttack, 0
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
	call	song_endMusic
l_return:
	mov	sp, bp
	pop	bp
	retf
bat_endCombatSong endp
