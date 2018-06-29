write proc far

	fileHandle= word ptr	 6
	sourceP= dword ptr  8
	writeLength= word ptr	 0Ch

	FUNC_ENTER
	push	ds
	mov	bx, [bp+fileHandle]
	lds	dx, [bp+sourceP]
	mov	cx, [bp+writeLength]
	mov	ah, 40h
	int	21h		; DOS -	2+ - call(write) TO FILE WITH	HANDLE
				; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
	jnb	short l_return
	sub	ax, ax
	dec	ax

l_return:
	pop	ds
	FUNC_EXIT(false)
	retf
write endp
