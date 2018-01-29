; Attributes: bp-based frame

mfunc_setLiquid proc far

	inventoryP= dword ptr -6
	liquidNumber= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(6)
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	shl	ax, 1
	shl	ax, 1
	mov	[bp+liquidNumber], ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	cl, gs:g_usedItemSlotNumber
	sub	ch, ch
	add	ax, cx
	add	ax, offset party.inventory
	mov	word ptr [bp+inventoryP], ax
	mov	word ptr [bp+inventoryP+2], seg seg027
	lfs	bx, [bp+inventoryP]
	mov	al, fs:[bx]
	and	al, 0C3h
	or	al, byte ptr [bp+liquidNumber]
	mov	fs:[bx], al
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_setLiquid endp
