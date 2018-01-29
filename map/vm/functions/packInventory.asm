; Attributes: bp-based frame
mfunc_packInventory proc	far

	dataP= dword ptr	 6

	FUNC_ENTER
	mov	al, gs:g_userSlotNumber
	sub	ah, ah
	mov	gs:g_inventoryPackTarget, ax
	mov	al, gs:g_usedItemSlotNumber
	mov	gs:g_inventoryPackStart, ax
	call	inven_pack
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_packInventory endp
