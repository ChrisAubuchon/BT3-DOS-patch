; Attributes: bp-based frame
mfunc_ifRegisterClear proc	far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	cmp	g_vm_registers[bx], 1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifRegisterClear endp
