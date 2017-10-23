; Attributes: bp-based frame

printCantFindUse proc far
	FUNC_ENTER
	CHKSTK

	PUSH_OFFSET(s_cantFindUse)
	PRINTSTRING

	FUNC_EXIT
	retf
printCantFindUse endp
