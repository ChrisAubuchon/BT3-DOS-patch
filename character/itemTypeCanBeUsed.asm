; Attributes: bp-based frame

character_itemTypeCanBeUsed proc far

	inventorySlotNumber= word ptr -2
	slotNumber= word ptr  6
	itemType= word ptr	 8

	FUNC_ENTER(2)

	mov	[bp+inventorySlotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemNo[bx]
	sub	ah, ah
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh

	cmp	ax, [bp+itemType]
	jnz	short l_next

	cmp	[bp+itemType], itType_weapon
	jnz	short l_returnOne

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, itemFlag_equipped
	jz	short l_returnOne

l_next:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], inventorySize
	jge	short l_returnZero
	jmp	short l_loop
	

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
character_itemTypeCanBeUsed endp
