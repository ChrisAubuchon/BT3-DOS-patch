; Attributes: bp-based frame

mfunc_ifRegisterEq proc far
	registerNumber= word ptr	-4
	comparisonAmount= word ptr	-2
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
	mov	[bp+comparisonAmount], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+comparisonAmount], ax
	mov	ax, [bp+comparisonAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	cmp	g_vm_registers[bx], ax
	jnz	short l_setToZero
	mov	ax, 1
	jmp	short l_return
l_setToZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifRegisterEq endp
