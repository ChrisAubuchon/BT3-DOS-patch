; Attributes: bp-based frame
sp_trapZap proc	far

	sqE= word ptr -0Ah
	loopCounter= word ptr	-8
	sqN= word	ptr -6
	dungeonSquareP= dword ptr -4

	FUNC_ENTER(0Ah)

	mov	ax, g_sqNorth
	mov	[bp+sqN],	ax
	mov	ax, g_sqEast
	mov	[bp+sqE], ax
	cmp	inDungeonMaybe, 0
	jz	l_return
	mov	[bp+loopCounter], 4
l_loop:
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	ax, [bp+sqN]
	mov	bx, g_direction
	shl	bx, 1
	sub	ax, dirDeltaN[bx]
	push	ax
	CALL(wrapNumber)
	mov	[bp+sqN],	ax
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	mov	bx, g_direction
	shl	bx, 1
	mov	ax, dirDeltaE[bx]
	add	ax, [bp+sqE]
	push	ax
	CALL(wrapNumber)
	mov	[bp+sqE], ax
	mov	bx, [bp+sqN]
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
	add	ax, 2
	mov	word ptr [bp+dungeonSquareP], ax
	mov	word ptr [bp+dungeonSquareP+2], dx
	lfs	bx, [bp+dungeonSquareP]
	and	byte ptr fs:[bx], 0EFh
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jg	l_loop
l_return:
	FUNC_EXIT
	retf
sp_trapZap endp
