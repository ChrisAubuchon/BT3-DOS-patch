; Attributes: bp-based frame

bat_appendSpecialAttackString proc far

	arg_0= word ptr	 6

	FUNC_ENTER

	mov	bx, gs:specialAttackVal
	shl	bx, 1
	shl	bx, 1
	push	word ptr (specialAttString+2)[bx]
	push	word ptr specialAttString[bx]
	PUSH_STACK_DWORD(arg_0)
	STRCAT

	FUNC_EXIT
	retf
bat_appendSpecialAttackString endp
