; Attributes: bp-based frame

mfunc_subtractFromRegister proc far

	registerNumber= word ptr -4
	subtractAmount= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(4)
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+subtractAmount], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+subtractAmount], ax

	mov	ax, [bp+subtractAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	sub	g_vm_registers[bx], ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_subtractFromRegister endp
