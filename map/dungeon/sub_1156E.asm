; Attributes: bp-based frame

sub_1156E proc far

	g_rowOffsetP= dword ptr  6
	sqE= word ptr	 0Ah
	sqN= word ptr	 0Ch
	dunWidth= word ptr	 0Eh
	dunHeight= word ptr	 10h

	FUNC_ENTER
	push	si

	push	[bp+dunWidth]
	push	[bp+sqE]
	CALL(wrapNumber, near)
	mov	[bp+sqE], ax

	push	[bp+dunHeight]
	push	[bp+sqN]
	CALL(wrapNumber, near)
	mov	[bp+sqN], ax

	mov	bx, [bp+sqE]
	REGISTER_MULTIPLY_FIVE(bx, ax)	; ax = sqE * 5
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1			; bx = sqN * 4
	lfs	si, [bp+g_rowOffsetP]	; fs:si = sqN row pointer
	lfs	si, fs:[bx+si]		; fs:si = sqN row
	mov	bx, ax
	mov	al, fs:[bx+si+2]	; al = flags for (sqN, sqE)
	sub	ah, ah
	mov	bx, ax
	mov	cl, 5
	shr	bx, cl
	and	bx, 3
	mov	al, g_portalSquareValueList[bx]
	cbw

	pop	si
	FUNC_EXIT
	retf
sub_1156E endp
