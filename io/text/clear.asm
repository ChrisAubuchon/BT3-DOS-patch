; Attributes: bp-based frame

text_clear	proc far
	FUNC_ENTER
	cmp	gs:g_text_clearFlag, 0
	jz	short l_return
	sub	al, al
	mov	gs:txt_numLines, al
	mov	gs:g_currentCharPosition, al
	mov	ax, 0Fh			; Fill color
	push	ax
	mov	ax, 66h			; Bottom (or length)
	push	ax
	mov	ax, 132h		; Right edge
	push	ax
	mov	ax, 6			; Top edge
	push	ax
	mov	ax, 0A7h 		; Left edge
	push	ax
	call	far ptr	gfx_fillRectangle
	add	sp, 0Ah
	mov	gs:g_text_clearFlag, 0
l_return:
	FUNC_EXIT
	retf
text_clear	endp
