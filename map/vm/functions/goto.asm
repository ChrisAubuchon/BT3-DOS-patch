; Attributes: bp-based frame
mfunc_goto proc	far
	dataP= dword ptr	 6

	FUNC_ENTER
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(map_getDataOffsetP)
	FUNC_EXIT
	retf
mfunc_goto endp
