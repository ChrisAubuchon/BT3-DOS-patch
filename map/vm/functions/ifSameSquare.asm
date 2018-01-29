; Attributes: bp-based frame

mfunc_ifSameSquare proc far

	dataP= dword ptr  6

	FUNC_ENTER
	mov	ax, g_sameSquareFlag
	mov	g_sameSquareFlag, 1
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifSameSquare endp
