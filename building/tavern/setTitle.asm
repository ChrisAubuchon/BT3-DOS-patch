; Attributes: bp-based frame

tav_setTitle proc far
	deltaN=	word ptr -8
	counter= word ptr -6
	tavernIndex= word ptr	-4
	deltaE=	word ptr -2

	FUNC_ENTER
	CHKSTK(8)
	push	si

	mov	[bp+tavernIndex], 4
	mov	si, dirFacing
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+deltaN], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+deltaE], ax

	mov	[bp+counter], 0
l_loopEntry:
	mov	ax, [bp+counter]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	si, ax
	mov	al, byte ptr tavCoords.sqN[si]
	cbw
	cmp	ax, [bp+deltaN]
	jnz	short l_loopIncrement

	mov	al, tavCoords.sqE[si]
	cbw
	cmp	ax, [bp+deltaE]
	jnz	short l_loopIncrement

	mov	al, tavCoords.location[si]
	cbw
	cmp	ax, currentLocationMaybe
	jnz	short l_loopIncrement

	mov	ax, cx
	mov	[bp+tavernIndex], ax
	jmp	short l_setTitleAndReturn
l_loopIncrement:
	inc	[bp+counter]
	cmp	[bp+counter], 4
	jl	l_loopEntry

l_setTitleAndReturn:
	mov	bx, [bp+tavernIndex]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (tavernNames+2)[bx]
	push	word ptr tavernNames[bx]
	CALL(setTitle)
	mov	bx, [bp+tavernIndex]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	al, tavCoords.field_4[bx]
	cbw

	pop	si
	FUNC_EXIT
	retf
tav_setTitle endp

