; Attributes: bp-based frame

quitGame proc far
	FUNC_ENTER
	CHKSTK

	PUSH_OFFSET(s_confirmQuit)
	PRINTSTRING(true)

	CALL(getYesNo)
	or	ax, ax
	jz	short l_returnZero
	PUSH_OFFSET(s_loseProgressConfirm)
	PRINTSTRING(true)
	CALL(getYesNo)
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
quitGame endp


