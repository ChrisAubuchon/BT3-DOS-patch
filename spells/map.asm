; Attributes: bp-based frame

spGeo_removeTrap proc far

	squareP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8

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
	add	ax, 2
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	lfs	bx, [bp+squareP]
	and	byte ptr fs:[bx], 0EFh

	FUNC_EXIT
	retf
spGeo_removeTrap endp

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

; Attributes: bp-based frame

spGeo_revealSquare proc far

	squareP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8

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
	add	ax, 4
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	lfs	bx, [bp+squareP]
	or	byte ptr fs:[bx], 1

	FUNC_EXIT
	retf
spGeo_revealSquare endp

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
	mov	bl, geoSpMasks[bx-2]._byte
	sub	bh, bh
	lfs	si, [bp+sqP]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	bx, [bp+geoSpMaskIndex]
	mov	cl, geoSpMasks[bx-2].bitmask
	sub	ch, ch
	test	ax, cx
	jz	short l_nextSquare
	mov	bx, si
	or	byte ptr fs:[bx+4], 4
	jmp	short l_return
l_nextSquare:
	lfs	bx, [bp+sqP]
	and	byte ptr fs:[bx+4], 0FBh
l_return:
	pop	si

	FUNC_EXIT
	retf
dun_revealSpSquare endp

; Attributes: bp-based frame

sp_geomancerSpell proc far

	row= word ptr -8
	var_6= word ptr	-6
	geoSpellNumber= word ptr	-4
	column=	word ptr -2
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(8)

	cmp	inDungeonMaybe, 0
	jz	short l_return
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	sar	ax, 1
	mov	[bp+geoSpellNumber], ax
	mov	[bp+row], 0
	jmp	short loc_223DB
loc_223D8:
	inc	[bp+row]
loc_223DB:
	mov	al, g_dunHeight
	sub	ah, ah
	cmp	ax, [bp+row]
	jbe	short l_return
	mov	[bp+column], 0
	jmp	short loc_223F4
loc_223F1:
	inc	[bp+column]
loc_223F4:
	mov	al, g_dunWidth
	sub	ah, ah
	cmp	ax, [bp+column]
	jbe	short loc_2241C
	push	[bp+var_6]
	push	[bp+column]
	push	[bp+row]
	mov	bx, [bp+geoSpellNumber]
	shl	bx, 1
	shl	bx, 1
	call	geoSpList[bx]
	add	sp, 6
	jmp	short loc_223F1
loc_2241C:
	jmp	short loc_223D8

l_return:
	FUNC_EXIT
	retf
sp_geomancerSpell endp

