; Attributes: bp-based frame
vm_strcmp proc	far

	dataP= dword ptr  6
	stringBuffer= dword ptr  0Ah

	FUNC_ENTER
l_loop:
	lfs	bx, [bp+dataP]
	mov	al, fs:[bx]
	and	al, 7Fh
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	cmp	al, fs:[bx]
	jnz	short l_doneComparing
	inc	word ptr [bp+dataP]
	jmp	short l_loop
l_doneComparing:
	lfs	bx, [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jnz	short l_returnZero
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
vm_strcmp endp
