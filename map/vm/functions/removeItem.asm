; Attributes: bp-based frame

mfunc_removeItem proc far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	CALL(vm_removeItem, near)
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_removeItem endp
