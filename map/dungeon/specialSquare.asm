
; Attributes: bp-based frame

dun_doSpecialSquare proc far

	counter= word ptr -6
	squareDataP= dword ptr -4
	rowBuf=	dword ptr  6
	sqEast=	word ptr  0Ah
	sqNorth= word ptr  0Ch

	FUNC_ENTER(6)
	push	si

	sub	al, al
	mov	gs:sqRegenHPFlag, al
	mov	gs:stuckFlag, al
	mov	gs:sq_antiMagicFlag, al
	mov	gs:regenSpptSq,	al
	mov	byte_4EECC, al
	mov	bx, [bp+sqNorth]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowBuf]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	mov	cx, [bp+sqEast]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+squareDataP], ax
	mov	word ptr [bp+squareDataP+2], dx

	mov	[bp+counter], 0
l_loop:
	mov	bx, [bp+counter]
	mov	bl, g_specialSquareByteList[bx]
	sub	bh, bh
	lfs	si, [bp+squareDataP]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cl, g_specialSquareMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next
	shl	bx, 1
	shl	bx, 1
	call	g_specialSquareFunctions[bx]

l_next:
	inc	[bp+counter]
	cmp	[bp+counter], 10h
	jl	short l_loop

	pop	si
	FUNC_EXIT
	retf
dun_doSpecialSquare endp
