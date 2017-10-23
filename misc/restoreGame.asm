; Attributes: bp-based frame

restoreGame proc far

	var_4= word ptr	-4
	fd= word ptr	-2

	FUNC_ENTER
	CHKSTK(4)

	mov	buildingRvalMaybe, 1
	PUSH_OFFSET(s_confirmRestore)
	PRINTSTRING(true)
	CALL(getYesNo)
	or	ax, ax
	jz	l_return

	CALL(endNoncombatSong)
	PUSH_OFFSET(s_gameSav)
	CALL(openFile, 4)
	mov	[bp+fd], ax
	mov	ax, 348h
	push	ax
	mov	ax, offset party
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+fd]
	READ

	mov	ax, offset byte_4EECC
	mov	cx, offset currentLocationMaybe
	mov	bx, seg	dseg
	sub	ax, cx
	push	ax
	mov	ax, cx
	mov	dx, bx
	push	dx
	push	ax
	push	[bp+fd]
	READ

	push	[bp+fd]
	CLOSE

	mov	[bp+var_4], 0

l_durationSpellLoopEntry:
	mov	bx, [bp+var_4]
	cmp	lightDuration[bx], 0
	jz	short l_doNotActivate
	push	bx
	CALL(icon_activate, 2)
l_doNotActivate:
	inc	[bp+var_4]
	cmp	[bp+var_4], 5
	jl	l_durationSpellLoopEntry

	cmp	g_currentHour, 6
	jb	short l_isNight
	cmp	g_currentHour, 12h
	jbe	short l_isDay
l_isNight:
	mov	al, 1
	jmp	short l_setIsNight
l_isDay:
	sub	al, al
l_setIsNight:
	mov	gs:isNight, al
	mov	byte ptr word_44166,	0
l_return:
	mov	sp, bp
	pop	bp
	retf
restoreGame endp
