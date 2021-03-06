; Attributes: bp-based frame

character_getGoldTradee proc far

	var_6= dword ptr	-6
	tradeeSlotNumber= word ptr	-2
	slotNumber= word ptr	 6
	lastSlotNumber= word ptr	 8

	FUNC_ENTER(6)
	push	si

	CALL(text_clear)
	PUSH_OFFSET(s_tradeGoldToWhom)
	PRINTSTRING
	CALL(readSlotNumber)
	mov	[bp+tradeeSlotNumber], ax
	or	ax, ax
	jl	l_return

	mov	ax, [bp+lastSlotNumber]
	cmp	[bp+tradeeSlotNumber], ax
	jg	l_return

	CALL(text_clear)
	PUSH_OFFSET(s_howMuchGoldToTrade)
	PRINTSTRING
	CALL(readGold)
	SAVE_STACK_DWORD(dx,ax,var_6)
	or	dx, ax
	jz	short l_return

	PUSH_STACK_DWORD(var_6)
	push	[bp+slotNumber]
	CALL(character_removeGold)
	or	ax, ax
	jnz	short l_enoughGold

	CALL(text_clear)
	PUSH_OFFSET(s_notEnoughGold)
	PRINTSTRING
	jmp	short l_return

l_enoughGold:
	mov	ax, word ptr [bp+var_6]
	mov	dx, word ptr [bp+var_6+2]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(tradeeSlotNumber), si)
	add	word ptr gs:party.gold[si], cx
	adc	word ptr gs:(party.gold+2)[si], bx
	CALL(text_clear)
	PUSH_OFFSET(s_done)
	PRINTSTRING
	IOWAIT
l_return:
	pop	si
	FUNC_EXIT
	retf
character_getGoldTradee endp
