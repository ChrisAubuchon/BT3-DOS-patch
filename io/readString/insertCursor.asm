; Attributes: bp-based frame

readString_insertCursor proc far
	FUNC_ENTER

	mov	ax, 1
	push	ax
	mov	ax, ch_InsertCursor
	push	ax
	CALL(readString_echoChar, near)

	FUNC_EXIT
	retf
readString_insertCursor endp
