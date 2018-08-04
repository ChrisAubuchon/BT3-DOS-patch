; Attributes: bp-based frame

saveGame proc far

	fd= word ptr	-2

	FUNC_ENTER(2)

	PUSH_OFFSET(s_confirmSave)
	PRINTSTRING(true)
	CALL(getYesNo)
	or	ax, ax
	jz	l_return
loc_11B2A:
	cmp	inDungeonMaybe, 0
	jz	short loc_11B3B
	mov	ax, 4
	jmp	short loc_11B3E
loc_11B3B:
	mov	ax, 2
loc_11B3E:
	mov	g_mapRval, ax
	mov	ax, 2
	push	ax
	PUSH_OFFSET(s_gameSav)
	CALL(open)
	mov	[bp+fd], ax
	inc	ax
	jnz	short l_doSave
	CALL(text_clear)
	PUSH_OFFSET(s_cantOpenGameSave)
	PRINTSTRING
	IOWAIT
	mov	g_mapRval, 0
	jmp	short l_return

l_doSave:
	PUSH_OFFSET(s_savingTheGame)
	PRINTSTRING(true)

	mov	ax, 348h
	push	ax
	mov	ax, offset party
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+fd]
	CALL(write)

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
	CALL(write)

	push	[bp+fd]
	CALL(close)

	PUSH_OFFSET(s_gameHasBeenSaved)
	PRINTSTRING(true)
	CALL(getYesNo)
	or	ax, ax
	jz	short loc_11BEF
	mov	ax, 0FFh
	jmp	short loc_11BF1
loc_11BEF:
	sub	ax, ax
loc_11BF1:
	mov	g_mapRval, ax
l_return:
	FUNC_EXIT
	retf
saveGame endp
