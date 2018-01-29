; Attributes: bp-based frame

mfunc_clearText proc far

	dataP= dword ptr 6

	FUNC_ENTER
	CALL(text_clear)
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_clearText endp
