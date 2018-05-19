lseek proc far

	fileHandle= word ptr	 6
	offsetLo= word ptr	 8
	offsetHi= word ptr	 0Ah

	push	bp
	mov	bp, sp
	push	ds
	mov	bx, [bp+fileHandle]
	mov	cx, [bp+offsetHi]
	mov	dx, [bp+offsetLo]
	mov	ax, 4200h
	int	21h		; DOS -	2+ - MOVE FILE call(read)/call(write) POINTER (LSEEK)
				; AL = method: offset from beginning of	file
	jnb	short l_return
	sub	ax, ax
	dec	ax

l_return:
	pop	ds
	pop	bp
	retf
lseek endp
