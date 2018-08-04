; Attributes: bp-based frame
printStringWithWait proc	far

	arg_0= dword ptr	 6

	FUNC_ENTER

	CALL(text_clear)
	PUSH_STACK_DWORD(arg_0)
	PRINTSTRING
	IOWAIT

	FUNC_EXIT
	retf
printStringWithWait endp
