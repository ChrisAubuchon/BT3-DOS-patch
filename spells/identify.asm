; Attributes: bp-based frame

sp_identifySpell proc far

	var_F4=	word ptr -0F4h
	var_34=	word ptr -34h
	var_32=	word ptr -32h
	inventorySlot= word ptr	-2
	spellCaster= word ptr	 6

	FUNC_ENTER(0F4h)

	CALL(text_clear)

	and	[bp+spellCaster], 7Fh

	PUSH_STACK_ADDRESS(var_32)
	PUSH_STACK_ADDRESS(var_F4)
	push	[bp+spellCaster]
	CALL(inventory_getItemList)

	mov	[bp+var_34], ax
	or	ax, ax
	jnz	short loc_22080

	PRINTOFFSET(s_pocketsAreEmpty)
	mov	[bp+inventorySlot], 0FFFFh
	jmp	short loc_22098

loc_22080:
	push	[bp+var_34]
	PUSH_STACK_ADDRESS(var_32)
	PUSH_OFFSET(s_whichItem)
	CALL(text_scrollingWindow)
	mov	[bp+inventorySlot], ax

loc_22098:
	cmp	[bp+inventorySlot], 0
	jge	short loc_220AD

	PRINTOFFSET(s_spellAborted, clear)
	jmp	short l_return

loc_220AD:
	CHARINDEX(ax, STACKVAR(spellCaster))
	mov	bx, [bp+inventorySlot]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	and	byte ptr gs:[bx+62h], 3Fh
	PRINTOFFSET(s_itemIdentified, clear)

l_return:
	FUNC_EXIT
	retf
sp_identifySpell endp

