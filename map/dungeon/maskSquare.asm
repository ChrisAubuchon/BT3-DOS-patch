dun_maskSquare proc far

	squareP=	dword ptr -4
	row=	word ptr 6
	column=	word ptr 8
	_byte=	word ptr 0Ah
	_mask=  byte ptr 0Ch

	FUNC_ENTER(4)

	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, [bp+_byte]
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	mov	al, [bp+_mask]
	lfs	bx, [bp+squareP]
	and	byte ptr fs:[bx], al

	FUNC_EXIT
	retf
dun_maskSquare endp
