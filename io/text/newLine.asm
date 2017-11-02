; Attributes: bp-based frame

txt_newLine proc far
	FUNC_ENTER

	mov	gs:g_currentCharPosition, 0		; Move position to start of line
	mov	al, gs:txt_numLines
	inc	gs:txt_numLines
	cmp	al, 0Bh
	jb	short loc_16635
	CALL(text_scroll, near)
	mov	gs:txt_numLines, 0Bh
loc_16635:
	mov	sp, bp
	pop	bp
	retf
txt_newLine endp
