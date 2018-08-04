; Attributes: bp-based frame

dun_getWalls proc far

	var_4= dword ptr -4
	sqE= word ptr  6
	sqN= word ptr  8

	FUNC_ENTER(4)
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	push	[bp+sqE]
	CALL(wrapNumber, near)
	mov	[bp+sqE], ax
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	push	[bp+sqN]
	CALL(wrapNumber, near)
	mov	[bp+sqN], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:g_rowOffset[bx]
	mov	dx, word ptr gs:(g_rowOffset+2)[bx]
	mov	cx, [bp+sqE]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx

	FUNC_EXIT
	retf
dun_getWalls endp
