; Attributes: bp-based frame

dun_setSquareField4 proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
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
	or	byte ptr fs:[bx+si+4], 9

	mov	[bp+var_6], 0
	jmp	short loc_10B74
loc_10B71:
	inc	[bp+var_6]
loc_10B74:
	mov	al, lightDistance
	sub	ah, ah
	cmp	ax, [bp+var_6]
	ja	short loc_10B86
	jmp	loc_10C1E
loc_10B86:
	push	[bp+sqN]
	push	[bp+sqE]
	CALL(dun_getWalls, near)
	mov	[bp+var_2], ax
	mov	ax, [bp+direction]
	dec	ax
	push	ax
	push	[bp+var_2]
	CALL(dungeon_getWallInDirection)
	mov	[bp+var_4], ax
	mov	bx, ax
	and	bx, 0Fh
	cmp	byte_44354[bx], 0
	jz	short loc_10BBC
	jmp	short loc_10C1E
loc_10BBC:
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
	or	byte ptr fs:[bx+si+4], 1
	jmp	loc_10B71

loc_10C1E:
	pop	si
	FUNC_EXIT
	retf
dun_setSquareField4 endp
