; Attributes: bp-based frame

scroll_printArrows proc far
	FUNC_ENTER

	mov	ax, 1
	push	ax
	mov	ax, 61h	
	push	ax
	mov	ax, 0B2h 
	push	ax
	mov	ax, 5Eh	
	push	ax
	call	far ptr	gfx_writeCharacter
	add	sp, 8

	mov	ax, 1
	push	ax
	mov	ax, 62h	
	push	ax
	mov	ax, 120h
	push	ax
	mov	ax, 5Eh	
	push	ax
	call	far ptr	gfx_writeCharacter
	add	sp, 8

	mov	ax, 1
	push	ax
	mov	ax, 5Eh	
	push	ax
	mov	ax, 0E0h 
	push	ax
	PUSH_OFFSET(s_esc)
	CALL(writeStringAt, near)
	mov	sp, bp
	pop	bp
	retf
scroll_printArrows endp

