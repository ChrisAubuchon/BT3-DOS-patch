; Attributes: bp-based frame

findFirstFile proc far

	pathGlob= dword ptr  6
	bufferP= dword ptr  0Ah

	push	bp
	mov	bp, sp
	push	ds
	lds	dx, [bp+bufferP]
	mov	ah, 1Ah
	int	21h		; DOS -	SET DISK TRANSFER AREA ADDRESS
				; DS:DX	-> disk	transfer buffer
	lds	dx, [bp+pathGlob]
	mov	cx, 7
	mov	ah, 4Eh
	int	21h		; DOS -	2+ - FIND FIRST	ASCIZ (FINDFIRST)
				; CX = search attributes
				; DS:DX	-> ASCIZ filespec
				; (drive, path,	and wildcards allowed)
	mov	ax, 0
	jb	short l_return
	inc	ax

l_return:
	pop	ds
	pop	bp
	retf
findFirstFile endp
