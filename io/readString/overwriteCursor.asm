; Attributes: bp-based frame

readString_overwriteCursor proc far

	arg_0= byte ptr	 6

	FUNC_ENTER
	CHKSTK

	sub	ax, ax
	push	ax
	mov	ax, ch_OverwriteCursor
	push	ax
	NEAR_CALL(readString_echoChar, 4)
	mov	al, [bp+arg_0]
	sub	gs:g_currentCharPosition, al
	sub	ax, ax
	push	ax
	mov	ax, ch_OverwriteCursor
	push	ax
	NEAR_CALL(readString_echoChar, 4)

	FUNC_EXIT
	retf
readString_overwriteCursor endp
