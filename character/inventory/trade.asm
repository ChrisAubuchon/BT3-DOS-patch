; Attributes: bp-based frame
;
; DWORD - var_42 & var_44
;
inventory_trade proc	far

	tradeeSlotNumber=	word ptr -4Ch
	var_4C=	word ptr -4Ah
	var_4A=	word ptr -48h
	var_46=	word ptr -46h
	var_44=	word ptr -44h
	var_42=	word ptr -42h
	stringBuffer=	word ptr -40h
	slotNumber= word ptr	 6
	inventorySlotNumber= word ptr	 8

	FUNC_ENTER(4Ch)

	PUSH_OFFSET(s_whoDoes)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT
	mov	[bp+var_44], ax
	mov	[bp+var_42], dx
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_42]
	push	[bp+var_44]
	STRCAT
	mov	[bp+var_44], ax
	mov	[bp+var_42], dx
	PUSH_OFFSET(s_wantToGiveItTo)
	push	dx
	push	[bp+var_44]
	STRCAT
	mov	[bp+var_44], ax
	mov	[bp+var_42], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	CALL(readSlotNumber)
	mov	[bp+tradeeSlotNumber], ax
	or	ax, ax
	jl	l_return

loc_183BD:
	mov	ax, [bp+inventorySlotNumber]
	REGISTER_TRIPLE(ax, cx)
	mov	[bp+var_4A], ax

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+var_4A]
	mov	al, gs:[bx+62h]
	sub	ah, ah
	and	ax, 0FCh
	mov	[bp+var_46], ax

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+var_4A]
	mov	al, gs:[bx+63h]
	sub	ah, ah
	mov	[bp+var_4C], ax

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+var_4A]
	mov	al, gs:[bx+64h]
	sub	ah, ah

	push	ax
	push	[bp+var_46]
	push	[bp+var_4C]
	push	[bp+tradeeSlotNumber]
	CALL(inventory_addItem, near)
	or	ax, ax
	jz	short l_noRoom

	push	[bp+inventorySlotNumber]
	push	[bp+slotNumber]
	CALL(inventory_discard, near)
	jmp	short l_return

l_noRoom:
	PUSH_OFFSET(s_allFull)
	PRINTSTRING(true)
	IOWAIT

l_return:
	FUNC_EXIT
	retf
inventory_trade endp
