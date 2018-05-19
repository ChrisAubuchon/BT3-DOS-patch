; Attributes: bp-based frame

character_getEquipmentAcBonus proc far

	inventorySlotNumber= word ptr	-4
	acBonus= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(4)

	mov	[bp+acBonus], 0
	mov	[bp+inventorySlotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, 1
	jnz	short l_next

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	bl, gs:party.inventory.itemNo[bx]
	sub	bh, bh
	mov	al, item_acBonWeapDam[bx]
	sub	ah, ah
	and	ax, 0Fh
	add	[bp+acBonus], ax

l_next:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], 36
	jl	short l_loop

	mov	ax, [bp+acBonus]
	FUNC_EXIT
	retf
character_getEquipmentAcBonus endp
