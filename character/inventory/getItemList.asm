; Attributes: bp-based frame

inventory_getItemList proc far

	itemNumber= word ptr	-0Ah
	inventoryCount= word ptr	-8
	inventoryLength= word ptr	-6
	inventorySlotNumber= word ptr	-4
	savedItemFlags= word ptr	-2
	slotNumber= word ptr	 6
	listBuffer= dword ptr  8
	listBufferP= dword ptr  0Ch

	FUNC_ENTER(0Ah)
	push	si

	mov	[bp+inventoryLength], 0
	mov	[bp+inventorySlotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	cmp	gs:party.inventory.itemNo[bx],	0
	jz	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	mov	[bp+savedItemFlags], ax

	mov	bx, [bp+inventoryLength]
	inc	[bp+inventoryLength]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+listBufferP]
	mov	ax, word ptr [bp+listBuffer]
	mov	dx, word ptr [bp+listBuffer+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	cmp	[bp+savedItemFlags], itemFlag_unidentified
	jl	short l_itemIdentified

	test	byte ptr [bp+savedItemFlags], 3
	jnz	short l_itemIdentified

	; Set flags to 3 which is '?' for unidentified
	mov	[bp+savedItemFlags], 3

l_itemIdentified:
	lfs	bx, [bp+listBuffer]
	inc	word ptr [bp+listBuffer]
	mov	si, [bp+savedItemFlags]
	and	si, 3
	mov	al, g_itemFlagCharacters[si]
	mov	fs:[bx], al

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+itemNumber], ax

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	push	ax
	push	[bp+itemNumber]
	push	word ptr [bp+listBuffer+2]
	push	word ptr [bp+listBuffer]
	CALL(inventory_getItemName, near)
	mov	word ptr [bp+listBuffer], ax
	mov	word ptr [bp+listBuffer+2], dx

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemCount[bx]
	sub	ah, ah
	mov	[bp+inventoryCount], ax
	cmp	ax, 0FFh
	jz	short l_terminateString
	cmp	ax, 1
	jz	short l_addCharge
	push	ax
	push	word ptr [bp+listBuffer+2]
	push	word ptr [bp+listBuffer]
	CALL(inventory_appendCharges, near)
	mov	word ptr [bp+listBuffer], ax
	mov	word ptr [bp+listBuffer+2], dx
	jmp	short l_terminateString

l_addCharge:
	mov	bx, [bp+itemNumber]
	cmp	g_itemBaseCount[bx],	1
	jz	short l_terminateString
	push	[bp+inventoryCount]
	push	word ptr [bp+listBuffer+2]
	push	word ptr [bp+listBuffer]
	CALL(inventory_appendCharges, near)
	mov	word ptr [bp+listBuffer], ax
	mov	word ptr [bp+listBuffer+2], dx

l_terminateString:
	lfs	bx, [bp+listBuffer]
	inc	word ptr [bp+listBuffer]
	mov	byte ptr fs:[bx], 0

l_next:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], inventorySize
	jl	l_loop

l_return:
	mov	ax, [bp+inventoryLength]
	pop	si
	FUNC_EXIT
	retf
inventory_getItemList endp
