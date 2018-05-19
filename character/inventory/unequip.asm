; Attributes: bp-based frame

inventory_unequip proc far

	slotNumber= word ptr	 6
	inventorySlotNumber= word ptr	 8

	FUNC_ENTER
	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	and	gs:party.inventory.itemFlags[bx], 0FCh

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	sub	ah, ah
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	al, 0Fh
	cmp	al, itType_instrument
	jnz	short l_return

	push	[bp+slotNumber]
	CALL(song_stopPlaying)

l_return:
	FUNC_EXIT
	retf
inventory_unequip endp
