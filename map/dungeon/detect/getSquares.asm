; This function	returns	a list of the square flags
; for the three	squares	ahead.
; Attributes: bp-based frame

detect_getSquares proc far

	sqFlagP= dword ptr -8
	counter= word ptr -4
	deltaSq= word ptr -2
	sqE= word ptr  6
	sqN= word ptr  8
	rSqList= dword ptr  0Ah

	FUNC_ENTER(8)
	push	si

	mov	[bp+deltaSq], 0
l_zeroRvalLoop:
	mov	bx, [bp+deltaSq]
	lfs	si, [bp+rSqList]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+deltaSq]
	cmp	[bp+deltaSq], 3
	jl	short l_zeroRvalLoop

	mov	[bp+deltaSq], 0
l_outerLoop:
	mov	si, g_direction
	shl	si, 1
	mov	ax, dirDeltaE[si]
	add	[bp+sqE], ax
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	push	[bp+sqE]
	CALL(wrapNumber)
	mov	[bp+sqE], ax
	mov	ax, dirDeltaN[si]
	sub	[bp+sqN], ax
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	push	[bp+sqN]
	CALL(wrapNumber)
	mov	[bp+sqN], ax
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+sqE]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+sqFlagP], ax
	mov	word ptr [bp+sqFlagP+2], dx

	mov	[bp+counter], 0
l_copyBytesLoop:
	mov	bx, [bp+counter]
	lfs	si, [bp+sqFlagP]
	mov	al, fs:[bx+si]
	lfs	si, [bp+rSqList]
	or	fs:[bx+si], al
	inc	[bp+counter]
	cmp	[bp+counter], 3
	jl	short l_copyBytesLoop

	inc	[bp+deltaSq]
	cmp	[bp+deltaSq], 3
	jl	l_outerLoop

	pop	si
	FUNC_EXIT
	retf
detect_getSquares endp
