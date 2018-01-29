; Attributes: bp-based frame

doRealtimeEvents proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(4)
	push	si

	mov	ax, gs:word_42294
	cmp	_clockTicks, ax
	jz	short loc_15256
	mov	ax, _clockTicks
	mov	gs:word_42294, ax
	CALL(gfx_animate)
loc_15256:
	mov	ax, _clockTicks
	mov	cl, 5
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	gs:word_42410, ax
	jz	short loc_15296
	mov	gs:word_42410, ax
	mov	si, ax
	mov	cl, 4
	sar	si, cl

	cmp	gs:word_41E6C, si
	jz	short loc_15296
	mov	gs:word_41E6C, si

	cmp	gs:advanceTimeFlag, 0
	jnz	short loc_15296
	CALL(bat_doPoisonEffect)
loc_15296:
	cmp	gs:advanceTimeFlag, 0
	jz	short loc_152A5
	jmp	loc_1538E
loc_152A5:
	mov	si, gs:word_42410
	mov	cl, 4
	sar	si, cl
	cmp	gs:word_42456, si
	jz	loc_1538E
	mov	gs:word_42456, si

	cmp	g_songDuration, 0		; Song timer
	jz	short loc_152E3
	mov	al, g_songDuration
	dec	g_songDuration
	cmp	al, 1
	jnz	short loc_152E3
	CALL(endNoncombatSong)

loc_152E3:
	mov	ax, gs:word_4233E
	dec	gs:word_4233E
	cmp	ax, 1
	jg	short loc_1533E
	mov	gs:word_4233E, 0Ah
	mov	[bp+var_2], 0
l_iconLoopEntry:
	mov	bx, [bp+var_2]
	cmp	lightDuration[bx], 0
	jz	short l_iconLoopIncrement
	cmp	lightDuration[bx], 0FFh
	jz	short l_iconLoopIncrement
	mov	al, lightDuration[bx]
	dec	lightDuration[bx]
	cmp	al, 1
	jnz	short l_iconLoopIncrement
	push	[bp+var_2]
	CALL(icon_deactivate)
l_iconLoopIncrement:
	inc	[bp+var_2]
	cmp	[bp+var_2], 5
	jl	short l_iconLoopEntry

loc_1533E:
	cmp	inDungeonMaybe, 0
	jnz	short loc_15356
	cmp	gs:isNight, 0
	jz	short loc_15362
loc_15356:
	cmp	gs:regenSpptSq,	0
	jz	short loc_15378
loc_15362:
	CALL(regenSppt)
	cmp	gs:songRegenSppt, 0
	jz	short loc_15378
	CALL(regenSppt)
loc_15378:
	CALL(doEquipmentEffect)
	cmp	gs:sqRegenHPFlag, 0
	jz	loc_doRealtimeEvents_label_1
	CALL(party_regenHp)

loc_doRealtimeEvents_label_1:
	cmp	gs:byte_41E81, 0
	jz	short loc_1538E
	CALL(dunsq_drainHp)
loc_1538E:
	mov	ax, gs:word_42410
	mov	cl, 6
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	gs:word_42330, ax
	jz	short l_return
	mov	gs:word_42330, ax
	cmp	gs:advanceTimeFlag, 0
	jnz	short l_return

	mov	al, g_currentHour
	inc	g_currentHour
	cmp	al, 23
	jb	short loc_153CF
	mov	g_currentHour, 0		; Set to midnight
loc_153CF:
	cmp	g_currentHour, 6
	jb	short l_setIsNightTonight
	cmp	g_currentHour, 18
	jbe	short l_setIsNightToDay
l_setIsNightTonight:
	mov	al, 1
	jmp	short l_setIsNight
l_setIsNightToDay:
	sub	al, al
l_setIsNight:
	mov	gs:isNight, al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
doRealtimeEvents endp
