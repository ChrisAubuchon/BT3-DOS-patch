; Attributes: bp-based frame
mfunc_ifCurSpellEQ proc	far

	dataP= dword ptr  6

	FUNC_ENTER
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	cmp	ax, g_curSpellNumber
	jnz	short l_returnZero
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifCurSpellEQ endp
