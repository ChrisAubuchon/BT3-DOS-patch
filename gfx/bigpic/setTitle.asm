; Attributes: bp-based frame

setTitle proc far

	startingColumn= word ptr	-2
	inString= dword ptr	 6

	FUNC_ENTER(2)

	sub	ax, ax
	push	ax
	mov	ax, 71h	
	push	ax
	mov	ax, 82h	
	push	ax
	mov	ax, 6Ah	
	push	ax
	mov	ax, 12h
	push	ax
	call	far ptr	gfx_fillRectangle
	add	sp, 0Ah

	mov	ax, 70h	
	push	ax
	push	[bp+inString]
	CALL(centerString, near)
	mov	[bp+startingColumn], ax
	sub	ax, ax
	push	ax
	mov	ax, 6Ah	
	push	ax
	mov	ax, [bp+startingColumn]
	add	ax, 12h
	push	ax
	push	[bp+inString]
	CALL(writeStringAt, near)

	FUNC_EXIT
	retf
setTitle endp
