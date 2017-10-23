; Attributes: bp-based frame

printCommandHelp proc far
	FUNC_ENTER
	CHKSTK

	CALL(clearTextWindow)
	PUSH_OFFSET(s_helpMessage1)
	PRINTSTRING
	IOWAIT
	CALL(clearTextWindow)
	PUSH_OFFSET(s_helpMessage2)
	PRINTSTRING
	IOWAIT

	FUNC_EXIT
	retf
printCommandHelp endp
