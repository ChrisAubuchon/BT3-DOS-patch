; Attributes: bp-based frame

mfunc_removeMonster proc far

	arg_0= dword ptr	 6

	FUNC_ENTER
	mov	al, gs:g_userSlotNumber
	sub	ah, ah
	push	ax
	CALL(party_pack)
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	FUNC_EXIT
	retf
mfunc_removeMonster endp
