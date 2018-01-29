; Attributes: bp-based frame

mfunc_parseNumber proc far

	registerNumber= word ptr	-4
	value= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(4)
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax
	PUSH_STACK_ADDRESS(value)
	PUSH_OFFSET(s_percentD)
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(sscanf)
	mov	ax, [bp+value]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	mov	g_vm_registers[bx], ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_parseNumber endp
