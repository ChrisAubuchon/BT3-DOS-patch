; Attributes: bp-based frame
mfunc_ifLiquid proc	far

	liquidIndex= word ptr	-4
	var_2= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(4)

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+liquidIndex], ax
	mov	al, charSize
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	sar	ax, 1
	sar	ax, 1
	and	ax, 0Fh
	mov	[bp+var_2], ax
	cmp	[bp+liquidIndex], ax
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
mfunc_ifLiquid endp
