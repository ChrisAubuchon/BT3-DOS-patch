; Attributes: bp-based frame

bat_doCombatSong proc far

	l_songLevel= word ptr	-2
	partySlotNumber= word ptr	 6
	songNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	[bp+songNumber]
	push	[bp+partySlotNumber]
	call	song_playSong
	add	sp, 4

	getCharP	[bp+partySlotNumber], bx
	cmp	gs:roster.class[bx], class_monster
	jb	short l_getCharSongLevel		; If singer is not a character
	mov	[bp+l_songLevel], 1			; set song level to 1
	jmp	short loc_1CF2C

l_getCharSongLevel:
	getCharP	[bp+partySlotNumber], bx	; Song level is
	mov	ax, gs:roster.level[bx]			; character level
	rangeWithMax 15, ax, cx				; with a max value of 15
	mov	[bp+l_songLevel], ax
loc_1CF2C:
	mov	ax, [bp+songNumber]
	jmp	l_songSwitch

l_sirrobin:
	mov	gs:songCanRun, 1
	or	gs:disbelieveFlags, disb_nohelp
	jmp	l_return

l_sanctuary:
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	cmp	gs:roster.level[bx], 60
	jnb	short loc_1CF7E
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	mov	ax, gs:roster.level[bx]
	shr	ax, 1
	shr	ax, 1
	jmp	short loc_1CF80
loc_1CF7E:
	mov	al, 0Fh
loc_1CF80:
	mov	gs:songACBonus,	al
	or	al, al
	jnz	short loc_1CF91
	inc	gs:songACBonus
loc_1CF91:
	jmp	short l_return

l_bringaround:
	mov	al, byte ptr [bp+l_songLevel]
	mov	gs:songRegenHP,	al
	or	al, al
	jnz	short loc_1CFA7
	inc	gs:songRegenHP
loc_1CFA7:
	jmp	short l_return

l_duotime:
	mov	gs:songExtraAttack, 1
	jmp	short l_return

l_overture:
	mov	gs:bat_curTarget, 80h
	mov	ax, 237
	push	ax
	push	[bp+partySlotNumber]
	call	_batchSpellCast
	add	sp, 4
	jmp	short l_return

l_shield:
	mov	gs:songHalfDamage, 1
	mov	al, byte ptr [bp+l_songLevel]
	mov	gs:partySpellAcBonus, al

l_songSwitch:
	or	ax, ax
	jz	l_sirrobin
	cmp	ax, song_sanctuary
	jz	l_sanctuary
	cmp	ax, song_bringaround
	jz	short l_bringaround
	cmp	ax, song_duotime
	jz	short l_duotime
	cmp	ax, song_overture
	jz	short l_overture
	cmp	ax, song_shield
	jz	short l_shield
l_return:
	mov	sp, bp
	pop	bp
	retf
bat_doCombatSong endp

