; Attributes: bp-based frame

mfunc_readString proc far

	loopCounter= word ptr	-2
	dataP= dword ptr	 6

	FUNC_ENTER(2)
	mov	ax, 10h
	push	ax
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(readString)

	mov	[bp+loopCounter], 0
l_loop:
	mov	bx, [bp+loopCounter]
	mov	al, gs:mfunc_ioBuf[bx]
	sub	ah, ah
	push	ax
	CALL(toUpper)
	mov	bx, [bp+loopCounter]
	mov	gs:mfunc_ioBuf[bx], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_loop

	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_readString endp
