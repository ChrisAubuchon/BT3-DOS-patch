; Attributes: bp-based frame

spGeo_revealSquare proc far

	squareP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8

	FUNC_ENTER(4)

	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:g_rowOffset[bx]
	mov	dx, word ptr gs:(g_rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 4
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	lfs	bx, [bp+squareP]
	or	byte ptr fs:[bx], minimapFlag_discovered

	FUNC_EXIT
	retf
spGeo_revealSquare endp
