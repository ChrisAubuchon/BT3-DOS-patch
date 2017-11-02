; Attributes: bp-based frame

map_readGraphics proc far

	var_4= word ptr	-4
	fd= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER
	CHKSTK(4)

	mov	ax, word_4414E
	cmp	[bp+arg_0], ax
	jz	l_return

l_retry:
	sub	ax, ax
	push	ax
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (map_graphicsTable+2)[bx]
	push	word ptr map_graphicsTable[bx]
	CALL(open)
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_17513
	mov	bx, [bp+arg_0]
	mov	al, byte_43F4A[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	PUSH_OFFSET(s_insertDisk)
	PRINTSTRING
	mov	bx, [bp+var_4]
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	PRINTSTRING
	IOWAIT
loc_17513:
	cmp	[bp+fd], 0FFFFh
	jz	short l_retry
	mov	ax, [bp+arg_0]
	mov	word_4414E, ax
	mov	ax, 4A38h
	push	ax
	mov	ax, offset graphicsBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+fd]
	CALL(read)
	push	[bp+fd]
	CALL(close)
l_return:
	mov	sp, bp
	pop	bp
	retf
map_readGraphics endp
