; Attributes: bp-based frame

mfunc_ifNotFlag	proc far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	CALL(checkProgressFlags, near)
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifNotFlag	endp
