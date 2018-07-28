; Attributes: bp-based frame

inventory_getItemName proc far

	arg_0= word ptr	 6
	itemNumber=	word ptr  0Ah
	itemFlags= byte	ptr  0Ch

	FUNC_ENTER

	test	[bp+itemFlags],	itemFlag_unidentified
	jz	short l_identifiedItem

	mov	bx, [bp+itemNumber]
	mov	al, itemTypeList[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_itemGenericStringList+2)[bx]
	push	word ptr g_itemGenericStringList[bx]
	PUSH_STACK_DWORD(arg_0)
	STRCAT
	jmp	short l_return

l_identifiedItem:
	mov	bx, [bp+itemNumber]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_itemStringList+2)[bx]
	push	word ptr g_itemStringList[bx]
	PUSH_STACK_DWORD(arg_0)
	STRCAT

l_return:
	FUNC_EXIT
	retf
inventory_getItemName endp
