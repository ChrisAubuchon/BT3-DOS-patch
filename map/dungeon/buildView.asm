; Attributes: bp-based frame

dun_buildView proc far

	viewStructP=	dword ptr -56h
	directionDeltaP=	dword ptr -52h
	counter= word ptr -4Eh
	deltaSqN= word ptr -4Ch
	squareList=	word ptr -4Ah
	var_1E=	word ptr -1Ch
	deltaSqE= word ptr -6
	sqE= word ptr  6
	sqN= word ptr  8
	gbufOff= word ptr  0Ah
	gbufSeg= word ptr  0Ch

	FUNC_ENTER(56h)
	push	si

	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr g_dun_deltaList[bx]
	mov	dx, word ptr (g_dun_deltaList+2)[bx]
	mov	word ptr [bp+directionDeltaP], ax
	mov	word ptr [bp+directionDeltaP+2],	dx

	mov	[bp+counter], 24
l_getSquaresLoop:
	mov	ax, [bp+counter]
	shl	ax, 1
	add	ax, word ptr [bp+directionDeltaP]
	mov	dx, word ptr [bp+directionDeltaP+2]
	mov	word ptr [bp+viewStructP], ax
	mov	word ptr [bp+viewStructP+2],	dx
	lfs	bx, [bp+viewStructP]
	mov	al, fs:[bx+viewStruct.deltaEast]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+deltaSqE], ax
	mov	al, fs:[bx+viewStruct.deltaNorth]
	cbw
	add	ax, [bp+sqN]
	mov	[bp+deltaSqN], ax
	push	ax
	push	[bp+deltaSqE]
	CALL(dun_getWalls, near)

	push	g_direction
	push	ax
	CALL(dungeon_getWallInDirection)

	mov	si, [bp+counter]
	shl	si, 1
	mov	[bp+si+squareList], ax
	dec	[bp+counter]
	cmp	[bp+counter], 0
	jge	short l_getSquaresLoop

	mov	[bp+counter], 33
loc_113D2:
	mov	si, [bp+counter]
	shl	si, 1
	lfs	bx, [bp+directionDeltaP]
	mov	al, fs:[bx+si]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+deltaSqE], ax
	mov	al, fs:[bx+si+1]
	cbw
	add	ax, [bp+sqN]
	mov	[bp+deltaSqN], ax

	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	al, g_dunWidth
	push	ax
	push	[bp+deltaSqN]
	push	[bp+deltaSqE]
	mov	ax, offset rowOffset
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(sub_1156E, near)
	mov	[bp+si+squareList], ax
	dec	[bp+counter]
	cmp	[bp+counter], 24
	jg	short loc_113D2

	push	[bp+gbufSeg]
	push	[bp+gbufOff]
	CALL(bigpic_setBackground)
	cmp	gs:wallIsPhased, 0
	jz	short loc_11444
	and	byte ptr [bp+var_1E], 0Fh
loc_11444:
	test	g_levelFlags, 20h
	jz	loc_dun_buildView_inDungeon

	mov	ax, 4
	jmp	loc_dun_buildView_loop_preamble

loc_dun_buildView_inDungeon:
	mov	bl, lightDistance
	sub	bh, bh

loc_dun_buildView_loop_preamble:
	mov	al, byte_44494[bx]
	sub	ah, ah
	mov	[bp+counter], ax
	jmp	short loc_11462
loc_1145F:
	inc	[bp+counter]
loc_11462:
	cmp	[bp+counter], 61
	jge	short loc_114C4
	mov	bx, [bp+counter]
	cmp	byte_4460C[bx], 0
	jz	short loc_114C2
	mov	al, byte_44516[bx]
	cbw
	mov	si, ax
	shl	si, 1
	mov	ax, [bp+si+squareList]
	mov	cl, byte_44554[bx]
	sar	ax, cl
	and	ax, 0Fh
	mov	bx, ax
	mov	al, byte_44484[bx]
	cbw
	or	ax, ax
	jz	short loc_114C2
	push	[bp+gbufSeg]
	push	[bp+gbufOff]
	dec	ax
	push	ax
	push	[bp+counter]
	CALL(bigpic_drawTopology)
loc_114C2:
	jmp	short loc_1145F
loc_114C4:
	mov	gs:byte_422A0, 0
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(vid_drawBigpic, far)
	mov	ax, [bp+var_1E]
	pop	si
	FUNC_EXIT
	retf
dun_buildView endp

