; Attributes: bp-based frame

tav_setTitle proc far
	deltaN=	word ptr -8
	counter= word ptr -6
	tavernIndex= word ptr	-4
	deltaE=	word ptr -2

	FUNC_ENTER(8)
	push	si

	mov	[bp+tavernIndex], 4
	mov	si, g_direction
	shl	si, 1
	mov	ax, g_sqNorth
	sub	ax, dirDeltaN[si]
	mov	[bp+deltaN], ax
	mov	ax, dirDeltaE[si]
	add	ax, g_sqEast
	mov	[bp+deltaE], ax

	mov	[bp+counter], 0
l_loopEntry:
	mov	ax, [bp+counter]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	si, ax
	mov	al, byte ptr g_tavernData.sqN[si]
	cbw
	cmp	ax, [bp+deltaN]
	jnz	short l_loopIncrement

	mov	al, g_tavernData.sqE[si]
	cbw
	cmp	ax, [bp+deltaE]
	jnz	short l_loopIncrement

	mov	al, g_tavernData.location[si]
	cbw
	cmp	ax, g_locationNumber
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
	mov	al, g_tavernData.sayingBase[bx]
	cbw

	pop	si
	FUNC_EXIT
	retf
tav_setTitle endp

