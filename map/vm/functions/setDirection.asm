; Attributes: bp-based frame
mfunc_setDirection proc	far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	g_direction, ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_setDirection endp
