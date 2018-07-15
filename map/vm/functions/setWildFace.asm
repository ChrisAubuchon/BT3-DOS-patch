; Attributes: bp-based frame

mfunc_setWildFace proc far

	newFace= word ptr	-6
	sqE= word ptr	-4
	sqN= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(6)
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+newFace], ax

	mov	si, g_direction
	shl	si, 1
	mov	ax, g_sqNorth
	sub	ax, dirDeltaN[si]
	mov	[bp+sqN], ax

	mov	ax, dirDeltaE[si]
	add	ax, g_sqEast
	mov	[bp+sqE], ax

	cmp	gs:g_wildWrapFlag, 0
	jz	short l_skipWrap
	mov	al, gs:mapHeight
	sub	ah, ah
	push	ax
	push	[bp+sqN]
	CALL(wrapNumber)
	mov	[bp+sqN], ax
	mov	al, gs:mapWidth
	sub	ah, ah
	push	ax
	push	[bp+sqE]
	CALL(wrapNumber)
	mov	[bp+sqE], ax

l_skipWrap:
	cmp	[bp+sqN], 0
	jl	short l_return
	mov	al, gs:mapHeight
	sub	ah, ah
	cmp	ax, [bp+sqN]
	jb	short l_return
	cmp	[bp+sqE], 0
	jl	short l_return
	mov	al, gs:mapWidth
	cmp	ax, [bp+sqE]
	jb	short l_return
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, gs:rowOffset[bx]
	mov	si, [bp+sqE]
	mov	al, byte ptr [bp+newFace]
	mov	fs:[bx+si], al
l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	FUNC_EXIT
	retf
mfunc_setWildFace endp
