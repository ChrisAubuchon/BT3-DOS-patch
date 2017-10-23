; Attributes: bp-based frame

printNoEffect proc far
	FUNC_ENTER
	CHKSTK

	PUSH_OFFSET(s_butItHadNoEffect)
	PRINTSTRING

	FUNC_EXIT
	retf
printNoEffect endp
