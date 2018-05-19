undefine(`CALL')


; Attributes: bp-based frame

read proc far

	fileHandle= word ptr  6
	destBuffer=	dword ptr  8
	numBytes= word ptr  0Ch

	push	bp
	mov	bp, sp
	push	ds
	mov	bx, [bp+fileHandle]
	lds	dx, [bp+destBuffer]
	mov	cx, [bp+numBytes]
	mov	ah, 3Fh
	int	21h		; DOS -	2+ - call(read) FROM FILE WITH HANDLE
				; BX = file handle, CX = number	of bytes to read
				; DS:DX	-> buffer
	jnb	short l_return
	sub	ax, ax
	dec	ax

l_return:
	pop	ds
	pop	bp
	retf
read endp
