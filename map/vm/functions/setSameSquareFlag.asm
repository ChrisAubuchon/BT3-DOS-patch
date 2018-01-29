; Attributes: bp-based frame

mfunc_setSameSquareFlag	proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	mov	g_sameSquareFlag, 0
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_setSameSquareFlag	endp
