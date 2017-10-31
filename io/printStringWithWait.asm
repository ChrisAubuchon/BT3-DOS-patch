; DWORD - arg_0 & arg_2

; Attributes: bp-based frame
printStringWithWait proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER
	CHKSTK

	CALL(text_clear)
	push	[bp+arg_2]
	push	[bp+arg_0]
	PRINTSTRING
	IOWAIT

	FUNC_EXIT
	retf
printStringWithWait endp
