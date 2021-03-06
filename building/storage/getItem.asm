; Attributes: bp-based frame

storage_getItem proc far

	itemListP= word ptr -372h
	itemList= word ptr -302h
	stringBufferP= dword ptr -142h
	itemListLength= word ptr -13Eh
	var_13C= word ptr -13Ch
	var_13A= word ptr -13Ah
	stringBuffer= word ptr -138h
	var_38=	word ptr -38h
	arg_0= word ptr	 6

	FUNC_ENTER(372h)
	push	di
	push	si

loc_14A05:
	PUSH_STACK_ADDRESS(var_38)
	PUSH_STACK_ADDRESS(itemListP)
	PUSH_STACK_ADDRESS(itemList)
	CALL(storage_createItemList, near)
	mov	[bp+itemListLength], ax
	or	ax, ax
	jz	l_empty

	PUSH_OFFSET(s_would)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	CHARINDEX(ax, STACKVAR(arg_0), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_likeToPickup)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	push	[bp+itemListLength]
	PUSH_STACK_ADDRESS(itemListP)
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(text_scrollingWindow)
	mov	[bp+var_13A], ax
	or	ax, ax
	jl	l_return
	mov	di, ax
	shl	di, 1
	mov	ax, [bp+di+var_38]
	mov	[bp+var_13C], ax
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	si, ax
	mov	al, (g_storageInventory+2)[si]
	sub	ah, ah
	push	ax
	mov	al, (g_storageInventory+1)[si]
	push	ax
	mov	al, g_storageInventory[si]
	push	ax
	push	[bp+arg_0]
	CALL(inventory_addItem)
	or	ax, ax
	jz	short l_allFull
	mov	bx, [bp+var_13C]
	mov	ax, bx
	shl	bx, 1
	add	bx, ax
	mov	g_storageInventory[bx], 0
	PUSH_OFFSET(s_youPickUpItem)
	PRINTSTRING(true)
	jmp	short l_delayAndLoop
l_allFull:
	PUSH_OFFSET(s_allFull)
	PRINTSTRING(true)
	DELAY(4)
	jmp	short l_return
l_empty:
	PUSH_OFFSET(s_buildingIsEmpty)
	PRINTSTRING(true)
	DELAY(4)
	jmp	short l_return
l_delayAndLoop:
	DELAY(4)
	jmp	loc_14A05
l_return:
	pop	si
	pop	di
	FUNC_EXIT
	retf
storage_getItem endp
