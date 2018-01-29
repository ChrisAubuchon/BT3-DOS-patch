; Attributes: bp-based frame
;
; DWORD var_102 & 104

mfunc_printOffset proc far

	var_104= word ptr -104h
	var_102= word ptr -102h
	stringBuffer= word ptr -100h
	dataP= dword ptr	 6

	FUNC_ENTER(104h)

	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(map_getDataOffsetP)
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	add	[bp+dataP], 2
	PUSH_STACK_ADDRESS(stringBuffer)
	push	dx
	push	[bp+var_104]
	CALL(_mfunc_getString)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_printOffset endp
