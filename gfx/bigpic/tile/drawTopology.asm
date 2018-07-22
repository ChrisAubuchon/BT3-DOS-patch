; XXX - Revisit after bigpic_copyTopoElem
; Attributes: bp-based frame

bigpic_drawTopology proc far

	headerSize=		word ptr -1Eh
	height=			word ptr -1Ch
	tileOffset=		dword ptr -1Ah
	gfxSourceBufferP=	dword ptr -12h
	row=			word ptr -0Eh
	column=			word ptr -0Ch
	var_A=			word ptr -0Ah
	tileIndexNumber=	word ptr -8
	quadrantWidth=		word ptr -6
	srcSkip=		word ptr -2
	quadrant=		word ptr  6
	sq=			word ptr  8
	gfxSourceBuffer=	dword ptr 0Ah

	FUNC_ENTER(1Eh)
	push	di
	push	si

	cmp	inDungeonMaybe, 0
	jz	short l_notInDungeon
	mov	ax, 10h
	jmp	short l_setHeaderSize

l_notInDungeon:
	mov	ax, 14h

l_setHeaderSize:
	mov	[bp+headerSize], ax

	; Set column
	mov	si, [bp+quadrant]
	shl	si, 1
	mov	al, byte ptr g_tile_quadrantCoordinates.column[si]
	cbw
	mov	[bp+column], ax

	; Set row
	mov	al, g_tile_quadrantCoordinates.row[si]
	cbw
	mov	[bp+row], ax

	mov	bx, [bp+quadrant]
	mov	al, g_tile_quadrantWidthList[bx]
	cbw
	mov	[bp+quadrantWidth], ax

	mov	al, g_tile_quadrantAspectOffsetList[bx]
	cbw
	mov	cx, [bp+sq]
	shl	cx, 1
	shl	cx, 1
	add	ax, cx
	mov	[bp+tileIndexNumber], ax

	mov	ax, [bp+headerSize]
	cmp	[bp+tileIndexNumber], ax
	jge	l_return

loc_177A8:
	mov	di, [bp+tileIndexNumber]
	lfs	bx, [bp+gfxSourceBuffer]
	mov	ah, fs:[bx+di+1]
	sub	al, al
	mov	bx, di
	mov	di, word ptr [bp+gfxSourceBuffer]
	mov	cl, fs:[bx+di]
	sub	ch, ch
	add	ax, cx
	add	ax, di
	mov	dx, fs
	add	ax, 9
	mov	word ptr [bp+tileOffset], ax
	mov	word ptr [bp+tileOffset+2], dx
	lfs	bx, [bp+tileOffset]
	inc	word ptr [bp+tileOffset]
	mov	al, fs:[bx]
	cbw
	mov	[bp+srcSkip], ax

	mov	bx, word ptr [bp+tileOffset]
	inc	word ptr [bp+tileOffset]
	mov	al, fs:[bx]
	cbw
	mov	[bp+height], ax

	mov	ax, word ptr [bp+tileOffset]
	add	ax, 2
	mov	word ptr [bp+gfxSourceBufferP], ax
	mov	word ptr [bp+gfxSourceBufferP+2], dx
	cmp	[bp+column], 0
	jge	short loc_17813
	mov	ax, [bp+column]
	sub	word ptr [bp+gfxSourceBufferP], ax
	mov	ax, [bp+quadrantWidth]
	add	ax, [bp+column]
	jns	short loc_17809
	sub	ax, ax

loc_17809:
	mov	[bp+var_A], ax
	mov	[bp+column], 0
	jmp	short loc_1782F

loc_17813:
	mov	ax, [bp+column]
	add	ax, [bp+quadrantWidth]
	cmp	ax, 56
	jle	short loc_17829
	mov	ax, 55
	sub	ax, [bp+column]
	mov	[bp+var_A], ax
	jmp	short loc_1782F

loc_17829:
	mov	ax, [bp+quadrantWidth]
	mov	[bp+var_A], ax

loc_1782F:
	cmp	[bp+srcSkip], 0
	jz	short l_return
	mov	bx, [bp+quadrant]
	mov	al, g_quadrantRightFlagList[bx]
	cbw
	push	ax					; rightFlag
	mov	al, g_tile_quadrantScaleFactor[bx]
	cbw
	push	ax
	push	[bp+height]
	push	[bp+srcSkip]
	push	[bp+var_A]
	push	[bp+row]
	push	[bp+column]
	push	word ptr [bp+gfxSourceBufferP+2]
	push	word ptr [bp+gfxSourceBufferP]
	CALL(_bigpic_copyTopoElem)

l_return:
	pop	si
	pop	di
	FUNC_EXIT
	retf
bigpic_drawTopology endp
