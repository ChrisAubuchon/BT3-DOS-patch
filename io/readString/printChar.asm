; Attributes: bp-based frame

readString_printChar proc far

	inCharacter= word ptr	 6

	FUNC_ENTER
	CHKSTK

	mov	ax, 1
	push	ax
	mov	ax, [bp+inCharacter]
	sub	ax, ' '
	push	ax
	CALL(readString_echoChar, near)
	push	[bp+inCharacter]
	CALL(text_characterWidth, near)
	add	gs:g_currentCharPosition, al

	FUNC_EXIT
	retf
readString_printChar endp

