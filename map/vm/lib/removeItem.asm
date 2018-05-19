; Attributes: bp-based frame

vm_removeItem proc far

	slotNumber=	word ptr -4
	inventorySlotNumber= word ptr	-2
	itemNumber= word ptr	 6

	FUNC_ENTER(4)

	mov	[bp+slotNumber], 0

l_characterLoop:
	mov	[bp+inventorySlotNumber], 1

l_inventoryLoop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	cmp	ax, [bp+itemNumber]
	jnz	short l_inventoryLoopNext
	mov	ax, [bp+inventorySlotNumber]
	dec	ax
	mov	gs:g_inventoryPackStart, ax
	mov	ax, [bp+slotNumber]
	mov	gs:g_inventoryPackTarget, ax
	CALL(inventory_pack)
	jmp	short l_characterLoopNext

l_inventoryLoopNext:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], 24h	
	jl	short l_inventoryLoop

l_characterLoopNext:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_characterLoop

l_return:
	FUNC_EXIT
	retf
vm_removeItem endp
