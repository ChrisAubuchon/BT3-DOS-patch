; Attributes: bp-based frame

mfunc_doNothing	proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_doNothing	endp
