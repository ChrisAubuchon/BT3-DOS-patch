; Attributes: bp-based frame

mfunc_printString proc far

	stringBuffer= word ptr -100h
	dataP= dword ptr  6

	FUNC_ENTER(100h)
	PUSH_STACK_ADDRESS(stringBuffer)
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(_mfunc_getString)
	mov	word ptr [bp+dataP], ax
	mov	word ptr [bp+dataP+2], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_printString endp
