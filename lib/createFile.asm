; Attributes: bp-based frame

createFile proc far

	fileName= dword ptr  6

	push	bp
	mov	bp, sp
	push	ds
	lds	dx, [bp+fileName]
	sub	cx, cx
	mov	ah, 3Ch
	int	21h		; DOS -	2+ - CREATE A FILE WITH	HANDLE (CREAT)
				; CX = attributes for file
				; DS:DX	-> ASCIZ filename (may include drive and path)
	jnb	short l_return
	sub	ax, ax
	dec	ax

l_return:
	pop	ds
	pop	bp
	retf
createFile endp
