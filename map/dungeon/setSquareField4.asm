; Attributes: bp-based frame

dun_markDiscoveredSquares proc far

	loopCounter= word ptr	-6
	var_2= word ptr	-2
	rowBuf=	dword ptr  6
	sqE= word ptr  0Ah
	sqN= word ptr  0Ch
	_width=	word ptr  0Eh
	_height= word ptr  10h
	direction= word ptr  12h

	FUNC_ENTER(6)
	push	si

	; sqE * 5
	mov	bx, [bp+sqE]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx				; ax = sqE * 5

	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1				; bx = sqN * 4
	lfs	si, [bp+rowBuf]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	or	byte ptr fs:[bx+si+dunSq_t.extraFlags], BITMASK(minimapFlag_discovered, minimapFlag_visited)

	; Mark all squares straight ahead as discovered if they are within
	; the light distance. Stop at the light distance or if a wall is
	; encountered straight ahead.
	;
	mov	[bp+loopCounter], 0
l_lightDiscoveryLoop:
	mov	al, lightDistance
	sub	ah, ah
	cmp	ax, [bp+loopCounter]
	jna	l_return

	push	[bp+sqN]
	push	[bp+sqE]
	CALL(dun_getWalls, near)

	mov	[bp+var_2], ax
	mov	ax, [bp+direction]
	dec	ax
	push	ax
	push	[bp+var_2]
	CALL(dungeon_getWallInDirection)

	mov	bx, ax
	and	bx, 0Fh
	cmp	g_transparentFaces[bx], 0
	jnz	short l_return

	push	[bp+_width]
	mov	bx, [bp+direction]
	shl	bx, 1
	mov	ax, dirDeltaE[bx]
	add	ax, [bp+sqE]
	push	ax
	CALL(wrapNumber, near)
	mov	[bp+sqE], ax

	push	[bp+_height]
	mov	ax, [bp+sqN]
	mov	bx, [bp+direction]
	shl	bx, 1
	sub	ax, dirDeltaN[bx]
	push	ax
	CALL(wrapNumber)
	mov	[bp+sqN], ax

	mov	bx, [bp+sqE]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowBuf]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	or	byte ptr fs:[bx+si+dunSq_t.extraFlags], minimapFlag_discovered
	inc	[bp+loopCounter]
	jmp	l_lightDiscoveryLoop

l_return:
	pop	si
	FUNC_EXIT
	retf
dun_markDiscoveredSquares endp
