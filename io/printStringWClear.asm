; Attributes: bp-based frame

printStringWClear proc far

	arg_0= dword ptr	 6

	FUNC_ENTER
	CHKSTK
	NEAR_CALL(clearTextWindow)
	push	[bp+arg_0]
	PRINTSTRING

	mov	sp, bp
	pop	bp
	retf
printStringWClear endp
