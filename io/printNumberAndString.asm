; Attributes: bp-based frame

printNumberAndString proc far

	stringBufferP= dword ptr -4
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= dword ptr  0Eh

	FUNC_ENTER(4)

	PUSH_STACK_DWORD(arg_0)
	PUSH_STACK_DWORD(arg_8)
	STRCAT(stringBufferP)

	sub	ax, ax
	push	ax
	push	[bp+arg_6]
	push	[bp+arg_4]
	push	dx
	push	word ptr [bp+stringBufferP]
	ITOA(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_DWORD(arg_8)
	PRINTSTRING

	FUNC_EXIT
	retf
printNumberAndString endp
