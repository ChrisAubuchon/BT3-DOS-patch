; Attributes: bp-based frame

bat_appendSpecialAttackString proc far

	arg_0= word ptr	 6

	FUNC_ENTER

	mov	bx, gs:g_specialAttackValue
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_specialAttackStringList+2)[bx]
	push	word ptr g_specialAttackStringList[bx]
	PUSH_STACK_DWORD(arg_0)
	STRCAT

	FUNC_EXIT
	retf
bat_appendSpecialAttackString endp
