; Attributes: bp-based frame

inventory_addItem proc far

	inventorySlotNumber= word ptr	-4
	itemEquipFlag= word ptr	-2
	slotNumber=	word ptr  6
	itemNumber= word ptr	 8
	itemFlags= byte ptr	 0Ah
	itemCount= byte ptr	 0Ch

	FUNC_ENTER(4)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_returnZero

	mov	[bp+inventorySlotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	cmp	gs:party.inventory.itemNo[bx],	0
	jz	short l_foundEmptySlot

	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], 36
	jl	short l_loop
	jmp	l_returnZero

l_foundEmptySlot:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, classEquipMask[bx]
	sub	ah, ah
	mov	bx, [bp+itemNumber]
	mov	cl, itemEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_setUnequippable

	sub	ax, ax
	jmp	short l_setFlags

l_setUnequippable:
	mov	ax, itemFlag_unequipable

l_setFlags:
	mov	[bp+itemEquipFlag], ax
	mov	al, [bp+itemFlags]
	or	al, byte ptr [bp+itemEquipFlag]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	gs:party.inventory.itemFlags[bx], cl

	mov	al, byte ptr [bp+itemNumber]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	gs:party.inventory.itemNo[bx],	cl

	mov	al, [bp+itemCount]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	gs:party.inventory.itemCount[bx], cl

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
inventory_addItem endp
