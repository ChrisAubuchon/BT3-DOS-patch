; Returns the value at (sqNorth, sqEast)
; This is only called in the wilderness. The dungeon
; levels have 5	bytes per square, this assumes one
; byte.
; Attributes: bp-based frame

wild_getSquare proc far

	sqEast=	word ptr  6
	sqNorth= word ptr  8

	FUNC_ENTER
	push	si

	cmp	gs:g_wildWrapFlag, 0
	jz	short l_noWrap

	mov	al, gs:mapWidth
	sub	ah, ah
	push	ax
	push	[bp+sqEast]
	CALL(wrapNumber, near)
	mov	[bp+sqEast], ax

	mov	al, gs:mapHeight
	sub	ah, ah
	push	ax
	push	[bp+sqNorth]
	CALL(wrapNumber, near)
	mov	[bp+sqNorth], ax
	jmp	short loc_11649

l_noWrap:
	cmp	[bp+sqEast], 0
	jl	short l_returnZero
	mov	al, gs:mapWidth
	sub	ah, ah
	cmp	ax, [bp+sqEast]
	jbe	short l_returnZero
	cmp	[bp+sqNorth], 0
	jl	short l_returnZero
	mov	al, gs:mapHeight
	cmp	ax, [bp+sqNorth]
	ja	short loc_11649

l_returnZero:
	sub	ax, ax
	jmp	short l_return

loc_11649:
	mov	bx, [bp+sqNorth]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, gs:rowOffset[bx]
	mov	si, [bp+sqEast]
	mov	al, fs:[bx+si]
	sub	ah, ah

l_return:
	pop	si
	FUNC_EXIT
	retf
wild_getSquare endp
