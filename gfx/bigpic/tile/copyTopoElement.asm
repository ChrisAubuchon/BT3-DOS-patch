; Attributes: bp-based frame

_bigpic_copyTopoElem proc far

	graphicsBufferP= dword ptr	 6
	destBaseColumn=	word ptr  0Ah
	destBaseRow= word ptr  0Ch
	arg_8= word ptr	 0Eh
	srcSkip= word ptr	 10h
	height=	word ptr  12h
	scaleFactor= word ptr	 14h
	rightFlag= word	ptr  16h

	FUNC_ENTER
	push	di
	push	si
	push	ds
	push	es

	mov	ax, seg	seg021
	mov	ds, ax
	assume ds:seg021
	mov	es, ax
	assume es:seg021
	mov	g_tile_currentScaleValue, 0
	mov	g_tile_currentCount, 0

loc_27CCE:
	mov	ax, g_tile_currentScaleValue
	sub	ax, [bp+scaleFactor]
	mov	g_tile_currentScaleValue, ax
	jge	short loc_27D1D

	add	ax, 64
	mov	g_tile_currentScaleValue, ax
	mov	dx, [bp+destBaseRow]
	mov	ax, 56
	mul	dx
	add	ax, [bp+destBaseColumn]
	add	ax, offset bigpicBuf
	mov	si, ax

	mov	cx, [bp+arg_8]
	or	cx, cx
	jz	short l_return
	les	di, [bp+graphicsBufferP]
	assume es:nothing
	add	di, g_tile_currentCount
	mov	dx, [bp+scaleFactor]
	mov	dh, dl
	xor	dl, dl
	xor	bx, bx
	mov	ax, [bp+rightFlag]
	or	ax, ax
	jz	short l_copyLeft
	add	di, [bp+srcSkip]
	dec	di
	CALL(_bigpic_copyRightTopo)
	jmp	short l_nextRow

l_copyLeft:
	CALL(_bigpic_copyLeftTopo)

l_nextRow:
	inc	[bp+destBaseRow]

loc_27D1D:
	mov	ax, [bp+srcSkip]
	add	g_tile_currentCount, ax
	dec	[bp+height]
	jnz	short loc_27CCE

l_return:
	pop	es
	pop	ds
	assume ds:dseg
	pop	si
	pop	di
	pop	bp
	retf
_bigpic_copyTopoElem endp
