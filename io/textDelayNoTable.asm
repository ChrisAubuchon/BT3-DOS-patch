; Attributes: bp-based frame
text_delayNoTable	proc far

	delayTime= word ptr 6

	FUNC_ENTER

	sub	ax, ax
	push	ax
	mov	ax, [bp+delayTime]
	shl	ax, 1
	shl	ax, 1
	push	ax
	CALL(getKeyWithDelay)

	FUNC_EXIT
	retf
text_delayNoTable	endp
