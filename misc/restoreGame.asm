; Attributes: bp-based frame

restoreGame proc far

	var_4= word ptr	-4
	fd= word ptr	-2

	FUNC_ENTER(4)

	mov	g_mapRval, 1
	PUSH_OFFSET(s_confirmRestore)
	PRINTSTRING(true)
	CALL(getYesNo)
	or	ax, ax
	jz	l_return

	CALL(endNoncombatSong)
	PUSH_OFFSET(s_gameSav)
	CALL(openFile)
	mov	[bp+fd], ax
	mov	ax, 348h
	push	ax
	mov	ax, offset party
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+fd]
	CALL(read)

	mov	ax, offset g_battleNoChest
	mov	cx, offset g_locationNumber
	mov	bx, seg	dseg
	sub	ax, cx
	push	ax
	mov	ax, cx
	mov	dx, bx
	push	dx
	push	ax
	push	[bp+fd]
	CALL(read)

	push	[bp+fd]
	CALL(close)

	mov	[bp+var_4], 0

l_durationSpellLoopEntry:
	mov	bx, [bp+var_4]
	cmp	lightDuration[bx], 0
	jz	short l_doNotActivate
	push	bx
	CALL(icon_activate)
l_doNotActivate:
	inc	[bp+var_4]
	cmp	[bp+var_4], 5
	jl	l_durationSpellLoopEntry

	cmp	g_currentHour, 6
	jb	short l_g_isNightFlag
	cmp	g_currentHour, 12h
	jbe	short l_isDay
l_g_isNightFlag:
	mov	al, 1
	jmp	short l_setIsNight
l_isDay:
	sub	al, al
l_setIsNight:
	mov	gs:g_isNightFlag, al
	mov	byte ptr g_printPartyFlag,	0
l_return:
	FUNC_EXIT
	retf
restoreGame endp
