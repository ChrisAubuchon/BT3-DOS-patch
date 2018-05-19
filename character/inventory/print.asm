; Attributes: bp-based frame

inventory_print proc far

	containerNumber= word ptr -114h
	inventoryListBuffer= word ptr -112h
	inventoryActionNumber=	word ptr -52h
	inventoryCount=	word ptr -50h
	mouseLineCount=	word ptr -4Eh
	inventoryListP=	word ptr -4Ch
	inventorySlotNumber=	word ptr -1Ch
	optionCharacters=	word ptr -1Ah
	inventorySlotOptions=	word ptr -14h
	inKey= word ptr	-0Eh
	optionMouse= word ptr	-0Ch
	slotNumber= word ptr	 6

	FUNC_ENTER(114h)
	push	si

l_inventoryLoop:
	PUSH_STACK_ADDRESS(inventoryListP)
	PUSH_STACK_ADDRESS(inventoryListBuffer)
	push	[bp+slotNumber]
	CALL(inventory_getItemList, near)
	mov	[bp+inventoryCount], ax
	or	ax, ax
	jnz	short l_hasInventory

	PUSH_OFFSET(s_pocketsAreEmpty)
	PRINTSTRING
	IOWAIT
	jmp	l_return

l_hasInventory:
	push	[bp+inventoryCount]
	PUSH_STACK_ADDRESS(inventoryListP)
	PUSH_OFFSET(s_inventory)
	CALL(text_scrollingWindow)
	mov	[bp+inventorySlotNumber], ax

	CALL(text_clear)
	cmp	[bp+inventorySlotNumber], 0
	jl	l_return

	push	[bp+inventorySlotNumber]
	push	[bp+slotNumber]
	PUSH_STACK_ADDRESS(inventorySlotOptions)
	CALL(inventory_getOptions, near)
	CALL(text_clear)
	PUSH_STACK_ADDRESS(optionMouse)
	PUSH_STACK_ADDRESS(optionCharacters)
	PUSH_STACK_ADDRESS(inventorySlotOptions)
	PUSH_OFFSET(s_inventoryVarString)
	CALL(printVarString)
	mov	[bp+mouseLineCount], ax

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:party.inventory.itemNo[bx],	76h 
	jz	short l_isContainer

	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, cx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:party.inventory.itemNo[bx],	7Dh 
	jnz	short l_inputLoop

l_isContainer:
	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, [bp+inventorySlotNumber]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	shr	ax, 1
	shr	ax, 1
	and	ax, 0Fh
	mov	[bp+containerNumber], ax
	PUSH_OFFSET(s_itsFilledWith)
	PRINTSTRING
	mov	bx, [bp+containerNumber]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (wineskinString+2)[bx]
	push	word ptr wineskinString[bx]
	CALL(printString)

l_inputLoop:
	push	[bp+mouseLineCount]
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, dosKeys_ESC
	jz	l_inventoryLoop

	mov	[bp+inventoryActionNumber], 0
l_actionLoop:
	mov	si, [bp+inventoryActionNumber]
	cmp	byte ptr [bp+si+optionCharacters], 0
	jz	short l_inputLoop

	mov	al, byte ptr [bp+si+optionCharacters]
	cbw
	cmp	ax, [bp+inKey]
	jz	short l_performAction

	shl	si, 1
	mov	ax, [bp+inKey]
	cmp	[bp+si+optionMouse], ax
	jnz	short l_actionLoopNext

l_performAction:
	CALL(text_clear)
	push	[bp+inventorySlotNumber]
	push	[bp+slotNumber]
	mov	bx, [bp+inventoryActionNumber]
	shl	bx, 1
	shl	bx, 1
	call	g_inventoryActionFunctions[bx]
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	CALL(party_print)
	jmp	l_inventoryLoop

l_actionLoopNext:
	inc	[bp+inventoryActionNumber]
	jmp	short l_actionLoop

l_return:
	pop	si
	FUNC_EXIT
	retf
inventory_print endp
