; Attributes: bp-based frame

printMessageAndExit proc far

	arg_0= dword ptr	 6

	FUNC_ENTER
	CHKSTK

	CALL(text_clear)
	push	[bp+arg_0]
	PRINTSTRING
	IOWAIT
	CALL(cleanupAndExit)

	FUNC_EXIT
	retf
printMessageAndExit endp
