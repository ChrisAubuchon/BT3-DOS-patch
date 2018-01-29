; Attributes: bp-based frame

mfunc_ifFlag proc far

	dataP= dword ptr  6

	FUNC_ENTER

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	CALL(checkProgressFlags, near)
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifFlag endp
