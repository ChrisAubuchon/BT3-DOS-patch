; Attributes: bp-based frame

bat_monCopyBuffer proc far

	copySource= dword ptr	 6
	copyDestination= dword ptr	 0Ah

	FUNC_ENTER
	mov	ax, monStruSize

	push	ax
	PUSH_STACK_DWORD(copySource)
	PUSH_STACK_DWORD(copyDestination)
	CALL(memcpy)

	FUNC_EXIT
	retf
bat_monCopyBuffer endp
