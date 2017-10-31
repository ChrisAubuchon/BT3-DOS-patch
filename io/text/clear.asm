; Attributes: bp-based frame

text_clear	proc far
	FUNC_ENTER
	cmp	gs:g_text_clearFlag, 0
	jz	short l_return
	sub	al, al
	mov	gs:txt_numLines, al
	mov	gs:g_currentCharPosition, al
	mov	ax, 0Fh
	push	ax
	mov	ax, 66h	
	push	ax
	mov	ax, 132h
	push	ax
	mov	ax, 6
	push	ax
	mov	ax, 0A7h 
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	gs:g_text_clearFlag, 0
l_return:
	mov	sp, bp
	pop	bp
	retf
text_clear	endp
