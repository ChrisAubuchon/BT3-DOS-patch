; Attributes: bp-based frame

writeStringAt proc far

	var_2= byte ptr	-2
	inString= dword ptr  6
	column= word ptr	 0Ah
	row= word ptr	 0Ch
	colorFlag= word ptr	 0Eh

	FUNC_ENTER
	CHKSTK(2)

l_loop:
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	mov	[bp+var_2], al
	or	al, al
	jz	short l_return
	push	[bp+colorFlag]
	cbw
	sub	ax, 20h	
	push	ax
	push	[bp+column]
	push	[bp+row]
	call	far ptr	gfx_writeCharacter
	add	sp, 8
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	cbw
	push	ax
	CALL(text_characterWidth, near)
	add	[bp+column], ax
	inc	word ptr [bp+inString]
	jmp	short l_loop
l_return:
	mov	sp, bp
	pop	bp
	retf
writeStringAt endp
