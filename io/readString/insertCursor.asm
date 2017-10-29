; Attributes: bp-based frame

readString_insertCursor proc far
	FUNC_ENTER

	mov	ax, 1
	push	ax
	mov	ax, ch_InsertCursor
	push	ax
	NEAR_CALL(readString_echoChar, 4)

	FUNC_EXIT
	retf
readString_insertCursor endp
