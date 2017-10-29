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
	NEAR_CALL(readString_echoChar, 4)
	push	[bp+inCharacter]
	NEAR_CALL(txt_charSpacing, 2)
	add	gs:g_currentCharPosition, al

	FUNC_EXIT
	retf
readString_printChar endp

