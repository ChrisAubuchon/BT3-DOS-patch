; Attributes: bp-based frame

dun_buildView proc far

	viewStructP=		dword ptr -56h
	directionDeltaP=	dword ptr -52h
	counter=		word ptr -4Eh
	deltaSqN=		word ptr -4Ch
	squareList=		word ptr -4Ah
	currentSquareP=		word ptr -1Ch	; Index of the current square in squareList
	deltaSqE=		word ptr -6
	sqE=			word ptr  6
	sqN=			word ptr  8
	graphicsBuffer=		dword ptr  0Ah

	FUNC_ENTER(56h)
	push	si

	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr g_dun_deltaList[bx]
	mov	dx, word ptr (g_dun_deltaList+2)[bx]
	mov	word ptr [bp+directionDeltaP], ax
	mov	word ptr [bp+directionDeltaP+2],	dx

	; Fill indices 0-24 with the square "walls" value
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

	; Indices 25-33 are filled with the return value of sub_1156E
	mov	[bp+counter], 33
loc_113D2:
	mov	si, [bp+counter]
	shl	si, 1
	lfs	bx, [bp+directionDeltaP]
	mov	al, fs:[bx+viewStruct.deltaEast]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+deltaSqE], ax
	mov	al, fs:[bx+viewStruct.deltaNorth]
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

	PUSH_STACK_DWORD(graphicsBuffer)
	CALL(bigpic_setBackground)
	cmp	gs:wallIsPhased, 0
	jz	short loc_11444
	and	byte ptr [bp+currentSquareP], 0Fh
loc_11444:
	test	g_levelFlags, 20h
	jz	loc_dun_buildView_inDungeon

	mov	ax, 4
	jmp	loc_dun_buildView_loop_preamble

loc_dun_buildView_inDungeon:
	mov	bl, lightDistance
	sub	bh, bh

loc_dun_buildView_loop_preamble:
	mov	al, g_baseLightTopology[bx]
	sub	ah, ah
	mov	[bp+counter], ax
loc_1145F:
	cmp	[bp+counter], 61
	jge	short loc_114C4
	mov	bx, [bp+counter]
	cmp	g_topologyEnabled[bx], 0
	jz	short loc_114C2

	mov	al, g_topologyToSquare[bx]
	cbw
	mov	si, ax
	shl	si, 1
	mov	ax, [bp+si+squareList]
	mov	cl, g_topologySquareShift[bx]
	sar	ax, cl
	and	ax, 0Fh
	mov	bx, ax
	mov	al, g_topologySquareToFace[bx]
	cbw
	or	ax, ax
	jz	short loc_114C2
	PUSH_STACK_DWORD(graphicsBuffer)
	dec	ax
	push	ax
	push	[bp+counter]
	CALL(bigpic_drawTopology)

loc_114C2:
	inc	[bp+counter]
	jmp	short loc_1145F

loc_114C4:
	mov	gs:g_hideMouseInBigpicFlag, 0
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(vid_drawBigpic, far)
	mov	ax, [bp+currentSquareP]
	pop	si
	FUNC_EXIT
	retf
dun_buildView endp

