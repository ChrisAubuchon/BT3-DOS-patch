; Attributes: bp-based frame

bat_charUseAction proc far

	var_F8=	word ptr -0F6h
	var_34=	word ptr -34h
	inventorySlotNumber= word ptr	-4
	spellFlags= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(0F6h)

	PUSH_STACK_ADDRESS(var_34)
	PUSH_STACK_ADDRESS(var_F8)
	push	[bp+slotNumber]
	CALL(inventory_getItemList)
	or	ax, ax
	jz	l_emptyPockets

	push	ax
	PUSH_STACK_ADDRESS(var_34)
	PUSH_OFFSET(s_whichItem)
	CALL(text_scrollingWindow)
	mov	[bp+inventorySlotNumber], ax
	or	ax, ax
	jl	l_returnZero

	push	[bp+inventorySlotNumber]
	push	[bp+slotNumber]
	CALL(inventory_canBeUsed)
	or	ax, ax
	jz	short l_cantUseItem

	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharActionTarget[bx], al
	mov	al, byte ptr [bp+inventorySlotNumber]
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharUseISlotNumber[bx], al
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+spellFlags], ax
	cmp	ax, 4
	jge	short l_untargetted

	PUSH_OFFSET(s_nlUseOn)
	push	[bp+spellFlags]
	CALL(bat_charGetActionOptionsTarget, near)

	or	ax, ax
	jl	l_returnZero

	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharSpellTarget[bx], al
	jmp	short l_returnOne

l_untargetted:
	mov	al, byte ptr [bp+spellFlags]
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharSpellTarget[bx], al
	jmp	short l_returnOne

l_cantUseItem:
	PRINTOFFSET(s_youCantUseThatItem, clear)
	IOWAIT
	CALL(text_clear)
	jmp	short l_returnZero

l_emptyPockets:
	PRINTOFFSET(s_pocketsAreEmpty, clear)
	IOWAIT

l_returnZero:
	sub	ax, ax
	jmp	short l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
bat_charUseAction endp
