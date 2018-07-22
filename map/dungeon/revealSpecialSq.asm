; Attributes: bp-based frame
dun_revealSpSquare proc	far

	sqP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8
	geoSpMaskIndex= word ptr	 0Ah

	FUNC_ENTER(4)

	push	si
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
	mov	word ptr [bp+sqP], ax
	mov	word ptr [bp+sqP+2], dx
	mov	bx, [bp+geoSpMaskIndex]
	mov	bl, g_geomancerSpellMasks[bx-2]._byte
	sub	bh, bh
	lfs	si, [bp+sqP]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	bx, [bp+geoSpMaskIndex]
	mov	cl, g_geomancerSpellMasks[bx-2].bitmask
	sub	ch, ch
	test	ax, cx
	jz	short l_nextSquare
	mov	bx, si
	or	byte ptr fs:[bx+dunSq_t.extraFlags], minimapFlag_special
	jmp	short l_return
l_nextSquare:
	lfs	bx, [bp+sqP]
	and	byte ptr fs:[bx+4], 0FBh
l_return:
	pop	si

	FUNC_EXIT
	retf
dun_revealSpSquare endp
