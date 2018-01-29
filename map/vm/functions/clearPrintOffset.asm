; Attributes: bp-based frame

mfunc_clearPrintOffset proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	CALL(text_clear)
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_printOffset)
	FUNC_EXIT
	retf
mfunc_clearPrintOffset endp
