; Attributes: bp-based frame

mfunc_ifHasItem proc far

	itemNumber= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(2)
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+itemNumber], ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	cmp	ax, [bp+itemNumber]
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
mfunc_ifHasItem endp
