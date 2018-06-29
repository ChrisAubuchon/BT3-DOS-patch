; Attributes: bp-based frame

text_scroll proc far
	FUNC_ENTER
	mov	ax, 50h	
	push	ax
	call	far ptr	gfx_scrollTextWindow
	add	sp, 2
	mov	ax, 50h	
	push	ax
	call	far ptr	gfx_scrollTextWindow
	add	sp, 2
	FUNC_EXIT
	retf
text_scroll endp
