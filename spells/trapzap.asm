; Attributes: bp-based frame
sp_trapZap proc	far

	_sq_east= word ptr -0Ah
	loopCounter= word ptr	-8
	_sq_north= word	ptr -6
	dungeonSquareP= dword ptr -4

	FUNC_ENTER(0Ah)

	mov	ax, sq_north
	mov	[bp+_sq_north],	ax
	mov	ax, sq_east
	mov	[bp+_sq_east], ax
	cmp	inDungeonMaybe, 0
	jz	l_return
	mov	[bp+loopCounter], 4
l_loop:
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	ax, [bp+_sq_north]
	mov	bx, dirFacing
	shl	bx, 1
	sub	ax, dirDeltaN[bx]
	push	ax
	CALL(wrapNumber)
	mov	[bp+_sq_north],	ax
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	mov	bx, dirFacing
	shl	bx, 1
	mov	ax, dirDeltaE[bx]
	add	ax, [bp+_sq_east]
	push	ax
	CALL(wrapNumber)
	mov	[bp+_sq_east], ax
	mov	bx, [bp+_sq_north]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+_sq_east]
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
