; Attributes: bp-based frame

mfunc_setMapRval proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	mov	gs:mapRval, 1
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_setMapRval endp
