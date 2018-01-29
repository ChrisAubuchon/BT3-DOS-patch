; Attributes: bp-based frame

item_doSpell proc far

	userSlotNumber=	word ptr  6
	itemSlotNumber= word ptr	 8
	targetSlotNumber= byte ptr	 0Ah
	spellNumber= word ptr	 0Ch
	arg_8= word ptr	 0Eh

	FUNC_ENTER

	mov	ax, [bp+itemSlotNumber]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	gs:g_usedItemSlotNumber, al
	mov	al, byte ptr [bp+userSlotNumber]
	mov	gs:g_userSlotNumber, al
	mov	al, [bp+targetSlotNumber]
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	push	[bp+arg_8]
	push	[bp+spellNumber]
	push	[bp+userSlotNumber]
	CALL(doCastSpell)
	push	[bp+itemSlotNumber]
	push	[bp+userSlotNumber]
	CALL(item_useCharge, near)

	FUNC_EXIT
	retf
item_doSpell endp
