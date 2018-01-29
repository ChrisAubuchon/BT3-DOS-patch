; Attributes: bp-based frame

mfunc_clearPrintString proc far

	arg_0= dword ptr	 6

	FUNC_ENTER
	CALL(text_clear)
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_printString, near)
	FUNC_EXIT
	retf
mfunc_clearPrintString endp
