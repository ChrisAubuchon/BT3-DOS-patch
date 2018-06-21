; Attributes: bp-based frame

tavern_getWineskin	proc far

	drinkFlags= word ptr	-2
	partySlotNumber= word ptr	 6
	drinkIndexNumber= word ptr	 8

	FUNC_ENTER(2)

	cmp	[bp+drinkIndexNumber], tavern_gingerAle
	jnz	short l_fillWithSpirits

	sub	ax, ax					; wineskin->water
	jmp	short l_addWindskin

l_fillWithSpirits:
	mov	ax, 4					; wineskin->spirits

l_addWindskin:
	mov	[bp+drinkFlags], ax
	mov	ax, 1
	push	ax
	push	[bp+drinkFlags]
	mov	ax, 76h	
	push	ax
	push	[bp+partySlotNumber]
	CALL(inventory_addItem)
	or	ax, ax
	jz	short l_inventoryFull

	PRINTOFFSET(s_barkeepFillsWineskin)
	jmp	short l_return

l_inventoryFull:
	PUSH_OFFSET(s_sorryBut)
	PRINTSTRING
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PRINTSTRING
	PUSH_OFFSET(s_cantCarryAnyMore)
	PRINTSTRING

l_return:
	IOWAIT
	FUNC_EXIT
	retf
tavern_getWineskin	endp

