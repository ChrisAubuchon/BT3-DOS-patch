; Attributes: bp-based frame

mfunc_printOffset proc far

	var_104= dword ptr -104h
	stringBuffer= word ptr -100h
	dataP= dword ptr	 6

	FUNC_ENTER(104h)

	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(map_getDataOffsetP)
	SAVE_STACK_DWORD(dx,ax,var_104)
	add	[bp+dataP], 2
	PUSH_STACK_ADDRESS(stringBuffer)
	PUSH_STACK_DWORD(var_104)
	CALL(_mfunc_getString)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_printOffset endp
