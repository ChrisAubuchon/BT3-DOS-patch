; Attributes: bp-based frame

inventory_equip proc	far
	itemType= word ptr -4
	loopCounter= word ptr -2
	slotNumber= word ptr  6
	inventorySlotNumber=	word ptr  8

	FUNC_ENTER(4)

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	sub	ah, ah

	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	mov	[bp+itemType], ax
	or	ax, ax
	jz	l_return

	CHARINDEX(ax, STACKVAR(slotNumber))
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	and	gs:party.inventory.itemFlags[bx], 0FCh

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	or	gs:party.inventory.itemFlags[bx], itemFlag_equipped

	mov	[bp+loopCounter], 0

l_unequipLoop:
	mov	ax, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(ax, cx)
	cmp	ax, [bp+loopCounter]
	jz	short l_unequipNext

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+loopCounter]
	mov	al, gs:party.inventory.itemNo[bx]
	sub	ah, ah
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	cmp	ax, [bp+itemType]
	jnz	short l_unequipNext
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+loopCounter]
	mov	al, gs:party.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, 2
	jz	short l_unequipNext
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+loopCounter]
	and	gs:party.inventory.itemFlags[bx], 0FCh

l_unequipNext:
	add	[bp+loopCounter], 3
	cmp	[bp+loopCounter], 36
	jl	short l_unequipLoop

l_return:
	FUNC_EXIT
	retf
inventory_equip endp
