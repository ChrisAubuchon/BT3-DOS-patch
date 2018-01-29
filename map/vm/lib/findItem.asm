; Attributes: bp-based frame

vm_findItem proc far

	slotNumber=	word ptr -4
	inventorySlotNumber= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER(4)
	mov	[bp+slotNumber], 0

l_characterLoop:
	mov	[bp+inventorySlotNumber], 1
l_inventoryLoop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	cmp	ax, [bp+arg_0]
	jnz	short l_inventoryLoopNext
	mov	al, byte ptr [bp+inventorySlotNumber]
	dec	al
	mov	gs:g_usedItemSlotNumber, al
	mov	al, byte ptr [bp+slotNumber]
	mov	gs:g_userSlotNumber, al
	mov	ax, 1
	jmp	short l_return
l_inventoryLoopNext:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], inventorySize
	jl	short l_inventoryLoop
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_characterLoop
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
vm_findItem endp
