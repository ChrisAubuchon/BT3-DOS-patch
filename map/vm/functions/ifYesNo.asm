; Attributes: bp-based frame

mfunc_ifYesNo proc far

	dataP= dword ptr  6

	FUNC_ENTER
	CALL(getYesNo)
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifYesNo endp
