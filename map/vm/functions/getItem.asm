; Attributes: bp-based frame
;
; DWORD - var_10A & var_10C

mfunc_getItem proc far

	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
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
	STRCAT
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	push	[bp+var_108]
	push	[bp+var_2]
	push	dx
	push	ax
	CALL(item_getName)
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
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
	CALL(inven_addItem)
	or	ax, ax
	jz	short l_inventoryFull
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	PUSH_OFFSET(s_gotThe)
	push	dx
	push	[bp+var_10C]
	STRCAT
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	push	[bp+var_108]
	push	[bp+var_2]
	push	dx
	push	ax
	CALL(item_getName)
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
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
	STRCAT
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_10A]
	push	[bp+var_10C]
	STRCAT
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	PUSH_OFFSET(s_cantCarryAnyMore)
	push	dx
	push	[bp+var_10C]
	STRCAT
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	jmp	l_retry

l_return:
	FUNC_EXIT
	retf
mfunc_getItem endp
