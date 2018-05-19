; This function	returns	1 if the item can be
; used.
; Attributes: bp-based frame

inventory_canBeUsed proc far

	itemNumber= word ptr	-2
	slotNumber=	word ptr  6
	inventorySlotNumber= word ptr	 8

	FUNC_ENTER(2)

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, 2
	jz	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+itemNumber], ax
	mov	bx, ax
	mov	al, itemSpellNo[bx]
	mov	g_curSpellNumber, ax
	cmp	ax, 0FFh
	jz	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(bx, cx)
	add	bx, ax
	cmp	gs:party.inventory.itemCount[bx], 0
	jz	short l_returnZero

	mov	bx, [bp+itemNumber]
	cmp	itemTypeList[bx], itType_quiver
	jnz	short l_returnOne

	mov	ax, itType_bow
	push	ax
	push	[bp+slotNumber]
	CALL(character_itemTypeCanBeUsed, near)
	jmp	short l_return

l_returnZero:
	sub	ax, ax
	jmp	short l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
inventory_canBeUsed endp
