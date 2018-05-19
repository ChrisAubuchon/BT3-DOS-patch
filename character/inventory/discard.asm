; Attributes: bp-based frame

inventory_discard proc far

	slotNumber= word ptr	 6
	inventorySlotNumber= word ptr	 8

	FUNC_ENTER
	mov	ax, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(ax, cx)
	mov	gs:g_inventoryPackStart, ax
	mov	ax, [bp+slotNumber]
	mov	gs:g_inventoryPackTarget, ax
	CALL(inventory_pack)
	FUNC_EXIT
	retf
inventory_discard endp
