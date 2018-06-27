; Attributes: bp-based frame

bat_convertSongToCombat	proc far

	singerLevel= word ptr	 6
	songNumber= word ptr	 8

	FUNC_ENTER

	mov	ax, [bp+songNumber]
	or	ax, ax
	jz	short l_sirRobin

	cmp	ax, song_sanctuary
	jz	short l_sanctuary

	cmp	ax, song_bringaround
	jz	short l_bringaround

	cmp	ax, song_duotime
	jz	short l_duotime

	cmp	ax, song_shield
	jz	short l_shield

	jmp	short l_return

l_sirRobin:
	mov	gs:songCanRun, 1
	or	gs:g_disbelieveFlags, disb_nohelp
	jmp	short l_return

l_sanctuary:
	mov	ax, 0Fh
	cmp	[bp+singerLevel], 60
	jg	l_setShieldBonus

	mov	ax, [bp+singerLevel]		; Shield bonus is (level / 4)
	sar	ax, 1
	sar	ax, 1
	
l_setShieldBonus:
	mov	gs:g_songAcBonus, al
	or	al, al
	jnz	short l_return
	inc	gs:g_songAcBonus
	jmp	short l_return

l_bringaround:
	mov	ax, [bp+singerLevel]
	cmp	ax, 0Fh

	jle	short l_setRegenAmout
	mov	ax, 0Fh

l_setRegenAmout:
	mov	gs:songRegenHP,	al
	jmp	short l_return

l_duotime:
	mov	gs:songExtraAttack, 1
	jmp	short l_return

l_shield:
	mov	gs:songHalfDamage, 1

l_return:
	FUNC_EXIT
	retf
bat_convertSongToCombat	endp
