_main proc far
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_27=	word ptr  2Dh

	FUNC_ENTER
	CHKSTK(6)

	mov	ax, 55h
	push	ax
	CALL(bigpic_initBuffers)

	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_thiefCfg)
	CALL(open)
	mov	[bp+var_4], ax

	inc	ax
	jnz	short loc_10039
	mov	ax, 4
	push	ax
	CALL(sub_28424, far)

loc_10039:
	mov	ax, 6
	push	ax
	mov	ax, offset word_4243A
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(read)
	push	[bp+var_4]
	CALL(close)
	mov	gs, seg027_x
	push	gs:word_4243E
	CALL(disk1Swap)
	add	sp, 2
	cmp	[bp+arg_0], 1
	jg	short loc_1007E
	cmp	gs:word_4243A, 0
	jnz	short loc_100E7
loc_1007E:
	mov	gs:word_4243A, 1
	push	[bp+arg_4]
	push	[bp+arg_2]
	push	[bp+arg_0]
	CALL(configureBT3)
	mov	gs:word_4243C, ax
	mov	ax, 2
	push	ax
	PUSH_OFFSET(s_thiefCfg)
	CALL(open)
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_100C5
	mov	ax, 4
	push	ax
	call	far ptr	sub_28424
	add	sp, 2
loc_100C5:
	mov	ax, 4
	push	ax
	mov	ax, offset word_4243A
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(write)
	push	[bp+var_4]
	CALL(close)
loc_100E7:
	sub	ax, ax
	push	ax
	mov	bx, gs:word_4243C
	and	bx, 0Fh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (graphicsDrivers+2)[bx]
	push	word ptr graphicsDrivers[bx]
	CALL(open)
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_1011C
	mov	ax, 4
	push	ax
	call	far ptr	sub_28424
	add	sp, 2
loc_1011C:
	mov	ax, 18h
	push	ax
	mov	ax, offset monsterBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(read)
	mov	ax, 1068h
	push	ax
	mov	ax, offset vid_setMode
	mov	dx, seg	seg024
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(read)
	push	[bp+var_4]
	CALL(close)
	mov	ax, 1
	push	ax
	call	far ptr	vid_setMode
	add	sp, 2
	sub	ax, ax
	push	ax
	call	far ptr j_nullsub_2
	add	sp, 2
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_firstTitle)
	CALL(open)
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_1018E
	mov	ax, 4
	push	ax
	call	far ptr	sub_28424
	add	sp, 2
loc_1018E:
	mov	ax, 33000
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(read)
	push	[bp+var_4]
	CALL(close)
	mov	[bp+var_6], 0
	jmp	short loc_101BD
loc_101BA:
	inc	[bp+var_6]
loc_101BD:
	cmp	[bp+var_6], 8
	jge	short loc_101E6
	mov	ax, 3200
	push	ax
	CALL(_mallocMaybe)
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	mov	word ptr gs:musicBufs._offset[bx], ax
	mov	gs:musicBufs._segment[bx], dx
	jmp	short loc_101BA
loc_101E6:
	mov	ax, 33000
	push	ax
	CALL(_mallocMaybe)
	mov	gs:word_42562, ax
	mov	gs:word_42564, dx
	push	dx
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	CALL(d3comp)
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, gs:word_42562
	mov	dx, gs:word_42564
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_titleScreen)
	CALL(open)
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_10266
	push	gs:word_42564
	push	gs:word_42562
	CALL(_freeMaybe)
	CALL(cleanupAndExit, near)
loc_10266:
	mov	ax, 33000
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(read)
	push	[bp+var_4]
	CALL(close)
	push	gs:word_42564
	push	gs:word_42562
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	CALL(d3comp)
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, gs:word_42562
	mov	dx, gs:word_42564
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_musicAll)
	CALL(open)
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_102FB
	push	gs:word_42564
	push	gs:word_42562
	CALL(_freeMaybe)
	CALL(cleanupAndExit, near)
loc_102FB:
	mov	ax, 0FFFFh
	push	ax
	mov	ax, gs:word_4243C
	mov	cl, 7
	sar	ax, cl
	add	ax, 10h
	cwd
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(lseek)
	mov	ax, 2
	push	ax
	lea	ax, [bp+var_2]
	push	ss
	push	ax
	push	[bp+var_4]
	CALL(read)
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	cwd
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(lseek)
	mov	ax, 9C4h
	push	ax
	mov	ax, 0
	mov	dx, seg	seg025
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(read)
	mov	[bp+var_6], 0
	jmp	short loc_10366
loc_10363:
	inc	[bp+var_6]
loc_10366:
	cmp	[bp+var_6], 8
	jge	short loc_103D4
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_6]
	cwd
	shl	ax, 1
	rcl	dx, 1
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(lseek)
	mov	ax, 2
	push	ax
	lea	ax, [bp+var_2]
	push	ss
	push	ax
	push	[bp+var_4]
	CALL(read)
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	cwd
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(lseek)
	mov	ax, 3200
	push	ax
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	push	gs:musicBufs._segment[bx]
	push	word ptr gs:musicBufs._offset[bx]
	push	[bp+var_4]
	CALL(read)
	jmp	short loc_10363
loc_103D4:
	push	[bp+var_4]
	CALL(close)
	CALL(sub_27F63)
	mov	ax, 7
	push	ax
	mov	ax, 0FFh
	push	ax
	CALL(song_playSong)
	CALL(icons_read)
	call	far ptr j_nullsub_3
	PUSH_OFFSET(s_titleText)
	CALL(intro_scrollText)
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_bardscr)
	CALL(open)
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_1043E
	push	gs:word_42564
	push	gs:word_42562
	CALL(_freeMaybe)
	CALL(cleanupAndExit, near)
loc_1043E:
	mov	ax, 80E8h
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	CALL(read)
	push	[bp+var_4]
	CALL(close)
	push	gs:word_42564
	push	gs:word_42562
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	CALL(d3comp)
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, gs:word_42562
	mov	dx, gs:word_42564
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	push	gs:word_42564
	push	gs:word_42562
	CALL(_freeMaybe)
	mov	ax, 4D0Ah
	push	ax
	CALL(_mallocMaybe)
	mov	gs:bigpicCellData_off, ax
	mov	gs:bigpicCellData_seg, dx
	CALL(sub_116CC, near)
	CALL(restoreGame)
	push	buildingRvalMaybe
	CALL(sub_10560, near)
	CALL(cleanupAndExit, near)
	mov	sp, bp
	pop	bp
	retf
_main endp
