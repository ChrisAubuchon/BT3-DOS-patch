; Attributes: bp-based frame

readString_echoChar proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER

	push	[bp+arg_2]
	push	[bp+arg_0]
	mov	al, gs:g_currentCharPosition
	sub	ah, ah
	add	ax, 0A8h 
	push	ax
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	cl, 3
	shl	ax, cl
	add	ax, 6
	push	ax
	call	far ptr	gfx_writeCharacter
	add	sp, 8

	FUNC_EXIT
	retf
readString_echoChar endp
