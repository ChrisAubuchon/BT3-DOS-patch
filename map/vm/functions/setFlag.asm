; Attributes: bp-based frame

mfunc_setFlag proc far

	flagNo=	word ptr -2
	dataP= dword ptr  6

	FUNC_ENTER(2)
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+flagNo], ax
	mov	ax, 0FFh
	push	ax
	push	[bp+flagNo]
	CALL(_updateFlags, near)
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_setFlag endp
