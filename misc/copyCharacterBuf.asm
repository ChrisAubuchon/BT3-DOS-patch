; Attributes: bp-based frame

; DWORD - arg_0 & arg_2, arg_4 & arg_6

copyCharacterBuf proc far

	arg_0= dword ptr	 6
	arg_4= dword ptr	 0Ah

	FUNC_ENTER

	mov	ax, charSize
	push	ax
	PUSH_STACK_DWORD(arg_0)
	PUSH_STACK_DWORD(arg_4)
	CALL(memcpy)
	FUNC_EXIT
	retf
copyCharacterBuf endp

