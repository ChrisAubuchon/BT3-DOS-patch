; This function	returns	the slot number	of an equipped
; item that matches the	type requested
; Attributes: bp-based frame

character_getTypeEquippedSlot proc far

	itemNumber= word ptr	-4
	inventorySlotNumber= word ptr -2
	slotNumber= word ptr  6
	itemType= word ptr  8

	FUNC_ENTER(4)

	mov	[bp+inventorySlotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+itemNumber], ax
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	cmp	ax, [bp+itemType]
	jnz	short l_next

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, itemFlag_equipped
	jnz	short l_next

	mov	ax, [bp+itemNumber]
	jmp	short l_return

l_next:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], inventorySize
	jl	short l_loop

l_returnFail:
	mov	ax, 0FFFFh

l_return:
	FUNC_EXIT
	retf
character_getTypeEquippedSlot endp
