; Attributes: bp-based frame

text_nlWriteString proc far

	inString= dword ptr	 6

	FUNC_ENTER
	CHKSTK

	mov	gs:g_text_clearFlag, 1		; Mark text window as clearable
	cmp	gs:g_currentCharPosition, 0		; If not at the beginning of the line
	jz	short l_writeString
	CALL(txt_newLine, near)				;   Newline

l_writeString:
	push	[bp+inString]
	CALL(text_writeString, near)			; Write the string

	FUNC_EXIT
	retf
text_nlWriteString endp
