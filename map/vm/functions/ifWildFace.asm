; Attributes: bp-based frame

mfunc_ifWildFace proc far

	sqN= word ptr	-6
	mapFace= word ptr	-4
	desiredFace= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(6)
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+desiredFace], ax

	mov	si, g_direction
	shl	si, 1
	mov	ax, g_sqNorth
	sub	ax, dirDeltaN[si]
	mov	[bp+sqN], ax

	mov	ax, dirDeltaE[si]
	add	ax, g_sqEast

	push	[bp+sqN]
	push	ax
	CALL(wild_getSquare)
	and	ax, 0Fh
	mov	[bp+mapFace], ax

	mov	ax, [bp+desiredFace]
	cmp	[bp+mapFace], ax
	jnz	short l_setToZero
	mov	ax, 1
	jmp	short l_return
l_setToZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	pop	si
	FUNC_EXIT
	retf
mfunc_ifWildFace endp
