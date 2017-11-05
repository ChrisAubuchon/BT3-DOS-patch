; Attributes: bp-based frame

printCommandHelp proc far
	FUNC_ENTER

	CALL(text_clear)
	PUSH_OFFSET(s_helpMessage1)
	PRINTSTRING
	IOWAIT
	CALL(text_clear)
	PUSH_OFFSET(s_helpMessage2)
	PRINTSTRING
	IOWAIT

	FUNC_EXIT
	retf
printCommandHelp endp
