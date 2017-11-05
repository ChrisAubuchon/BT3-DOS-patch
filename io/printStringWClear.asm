; Attributes: bp-based frame

printStringWClear proc far

	inString= dword ptr	 6

	FUNC_ENTER

	CALL(text_clear, near)
	push	[bp+inString]
	PRINTSTRING

	mov	sp, bp
	pop	bp
	retf
printStringWClear endp
