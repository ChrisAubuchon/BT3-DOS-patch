; Attributes: bp-based frame

inventory_identify proc far

	inventoryIndex=	word ptr -46h
	stringBuffer=	word ptr -44h
	stringBufferP= dword ptr -4
	slotNumber= word ptr	 6
	inventorySlotNumber= word ptr	 8

	FUNC_ENTER(46h)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	test	gs:party.status[bx], 1Ch
	jnz	l_return

loc_185D7:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	mov	ax, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(ax, cx)
	mov	[bp+inventoryIndex], ax

	CALL(random)
	mov	cx, ax

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:(party.specAbil+1)[bx], cl
	jbe	short loc_18634

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventoryIndex]
	and	gs:party.inventory.itemFlags[bx], 3Fh
	jmp	short loc_18645

loc_18634:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventoryIndex]
	or	gs:party.inventory.itemFlags[bx], 40h

loc_18645:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+inventoryIndex]
	cmp	gs:party.inventory.itemFlags[bx], 80h
	jb	short loc_1865D
	mov	ax, 1
	jmp	short loc_1865F
loc_1865D:
	sub	ax, ax
loc_1865F:
	push	ax
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	PUSH_OFFSET(s_triesToIdentify)
	PLURALIZE(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	IOWAIT

l_return:
	FUNC_EXIT
	retf
inventory_identify endp
