; Attributes: bp-based frame

mfunc_getItem proc far

	stringBufferP= dword ptr -10Ch
	var_108= word ptr -108h
	stringBuffer= word ptr -106h
	var_6= word ptr	-6
	slotNumber= word ptr	-4
	var_2= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(10Ch)

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_108], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+var_6], ax

l_retry:
	CALL(text_clear)
	PUSH_OFFSET(s_whoWantsToGetThe)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	push	[bp+var_108]
	push	[bp+var_2]
	PUSH_STACK_DWORD(stringBufferP)
	CALL(inventory_getItemName)
	SAVE_STACK_DWORD(dx,ax,stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jge	short l_addItem
	sub	ax, ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	jmp	l_return

l_addItem:
	push	[bp+var_6]
	push	[bp+var_108]
	push	[bp+var_2]
	push	[bp+slotNumber]
	CALL(inventory_addItem)
	or	ax, ax
	jz	l_inventoryFull
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	PUSH_OFFSET(s_gotThe)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	push	[bp+var_108]
	push	[bp+var_2]
	PUSH_STACK_DWORD(stringBufferP)
	CALL(inventory_getItemName)
	SAVE_STACK_DWORD(dx,ax,stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	ax, 1
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	jmp	short l_return

l_inventoryFull:
	PUSH_OFFSET(s_sorryBut)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_cantCarryAnyMore)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	jmp	l_retry

l_return:
	FUNC_EXIT
	retf
mfunc_getItem endp
