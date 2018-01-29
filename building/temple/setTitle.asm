; Attributes: bp-based frame

temple_setTitle	proc far

	deltaNS= word ptr	-8
	loopCounter= word ptr	-6
	templeIndex= word ptr	-4
	deltaEW= word ptr	-2

	FUNC_ENTER(8)
	push	si

	mov	si, g_direction
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+deltaNS], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+deltaEW], ax
	mov	[bp+templeIndex], 3

	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	si, [bp+loopCounter]
	mov	cl, 2
	shl	si, cl
	mov	al, byte ptr templeLoc.sqN[si]
	sub	ah, ah
	cmp	ax, [bp+deltaNS]
	jnz	short l_loopIncrement

	mov	al, templeLoc.sqE[si]
	cmp	ax, [bp+deltaEW]
	jnz	short l_loopIncrement

	mov	al, templeLoc.location[si]
	cmp	ax, currentLocationMaybe
	jnz	short l_loopIncrement

	mov	ax, [bp+loopCounter]
	mov	[bp+templeIndex], ax
	jmp	short l_setTitle
l_loopIncrement:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	l_loopEntry
l_setTitle:
	mov	bx, [bp+templeIndex]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (templeTitles+2)[bx]
	push	word ptr templeTitles[bx]
	CALL(setTitle)

	pop	si
	FUNC_EXIT
	retf
temple_setTitle	endp
