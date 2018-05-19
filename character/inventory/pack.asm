; Attributes: bp-based frame

inventory_pack proc	far
	inventorySlotNumber= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	ax, gs:g_inventoryPackStart
	mov	[bp+inventorySlotNumber], ax
l_packLoop:
	CHARINDEX(ax, gs:g_inventoryPackTarget, si)
	add	si, [bp+inventorySlotNumber]
	mov	al, gs:(party.inventory.itemFlags+3)[si]
	mov	gs:party.inventory.itemFlags[si], al
	inc	[bp+inventorySlotNumber]
	cmp	[bp+inventorySlotNumber], 33
	jl	short l_packLoop

	mov	[bp+inventorySlotNumber], 33
l_clearLoop:
	CHARINDEX(ax, gs:g_inventoryPackTarget, bx)
	add	bx, [bp+inventorySlotNumber]
	mov	gs:party.inventory.itemFlags[bx], 0
	inc	[bp+inventorySlotNumber]
	cmp	[bp+inventorySlotNumber], 36
	jl	short l_clearLoop

l_return:
	pop	si
	FUNC_EXIT
	retf
inventory_pack endp
