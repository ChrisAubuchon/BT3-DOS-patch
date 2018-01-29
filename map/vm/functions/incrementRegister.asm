; Attributes: bp-based frame

mfunc_incrementRegister proc far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	inc	g_vm_registers[bx]
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_incrementRegister endp
