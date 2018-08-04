; Attributes: bp-based frame

character_removeGold	proc far

	partySlotNumber= word ptr	 6
	arg_2= word ptr	 8
	goldAmount= word ptr	 0Ah

	FUNC_ENTER
	push	si

	mov	ax, [bp+arg_2]
	mov	dx, [bp+goldAmount]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_13CEF
	jb	short l_returnZero
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_13CEF

l_returnZero:
	sub	ax, ax
	jmp	short l_return

loc_13CEF:
	mov	ax, [bp+arg_2]
	mov	dx, bx
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	ax, 1

l_return:
	pop	si
	FUNC_EXIT
	retf
character_removeGold	endp
