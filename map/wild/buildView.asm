; Attributes: bp-based frame
;

wild_buildView proc far

	viewStructP=	dword ptr -3Ch
	directionDeltaP=	dword ptr -38h
	counter= word ptr -34h
	deltaNorth= word ptr -32h
	squareList= byte	ptr -30h
	var_22=	byte ptr -20h
	deltaEast= word	ptr -1Ah
	graphicsBufferP= dword ptr -18h
	sqEast=	word ptr  6
	sqNorth= word ptr  8

	FUNC_ENTER(3Ch)
	push	si

	mov	word ptr [bp+graphicsBufferP], offset graphicsBuf
	mov	word ptr [bp+graphicsBufferP+2], seg seg023
	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr g_wild_deltaList[bx]
	mov	dx, word ptr (g_wild_deltaList+2)[bx]
	mov	word ptr [bp+directionDeltaP], ax
	mov	word ptr [bp+directionDeltaP+2], dx

	mov	[bp+counter], 20
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
	add	ax, [bp+sqEast]
	mov	[bp+deltaEast],	ax

	mov	al, fs:[bx+viewStruct.deltaNorth]
	cbw
	add	ax, [bp+sqNorth]
	mov	[bp+deltaNorth], ax
	push	ax
	push	[bp+deltaEast]
	CALL(wild_getSquare, near)
	mov	si, [bp+counter]
	mov	[bp+si+squareList], al
	dec	[bp+counter]
	cmp	[bp+counter], 0
	jge	short l_getSquaresLoop

	mov	ax, 44h
	push	ax
	mov	ax, 0BBBBh
	push	ax
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(bigpic_memcpy)

	mov	[bp+counter], 0
l_drawTopologyLoop:
	mov	bx, [bp+counter]
	mov	al, g_wild_viewSquareIndexList[bx]
	cbw
	mov	si, ax
	mov	al, [bp+si+squareList]
	sub	ah, ah
	and	ax, 0Fh
	or	ax, ax
	jz	short l_drawTopologyNext

	push	[bp+graphicsBufferP+2]
	push	[bp+graphicsBufferP]
	dec	ax
	push	ax
	mov	al, g_wild_squareTopologyIndex[bx]
	cbw
	push	ax
	CALL(bigpic_drawTopology)

l_drawTopologyNext:
	inc	[bp+counter]
	cmp	[bp+counter], 17
	jl	short l_drawTopologyLoop

	mov	gs:g_hideMouseInBigpicFlag, 0
	cmp	gs:isNight, 0
	jz	short l_return
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(bigpic_makeNight)

l_return:
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	CALL(vid_drawBigpic, far)
	mov	al, [bp+var_22]
	sub	ah, ah

	pop	si
	FUNC_EXIT
	retf
wild_buildView endp
