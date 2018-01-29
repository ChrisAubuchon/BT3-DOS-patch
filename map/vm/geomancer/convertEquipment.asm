; Attributes: bp-based frame

geomancer_convertEquipment proc far

	inventorySlotNumber= word ptr	-4
	newEquipableFlags= word ptr	-2
	slotNumber= word ptr	 6
	classNumber= word ptr	 8

	FUNC_ENTER(4)
	push	si

	mov	[bp+inventorySlotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	add	si, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	bx, ax
	mov	al, itemEquipMask[bx]
	mov	bx, [bp+classNumber]
	mov	cl, classEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_setUnequipable
	sub	ax, ax
	jmp	short l_setItemFlags
l_setUnequipable:
	mov	ax, 2
l_setItemFlags:
	mov	[bp+newEquipableFlags], ax
	mov	al, gs:party.inventory.itemFlags[si]
	and	al, 0FCh
	or	al, byte ptr [bp+newEquipableFlags]
	mov	gs:party.inventory.itemFlags[si], al
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], 24h	
	jl	short l_loop

l_return:
	pop	si
	FUNC_EXIT
	retf
geomancer_convertEquipment endp
