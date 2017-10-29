text_delayWithTable	proc far

	FUNC_ENTER

	mov	ax, 1
	push	ax
	mov	bl, txtDelayIndex
	sub	bh, bh
	mov	al, txtDelayTable[bx]
	sub	ah, ah
	push	ax
	CALL(getKeyWithDelay, 4)

	FUNC_EXIT
	retf
text_delayWithTable	endp
