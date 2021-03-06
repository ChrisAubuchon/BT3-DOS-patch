; Attributes: bp-based frame

dropPartyMember	proc far

	slotNumber= word ptr	-2

	FUNC_ENTER(2)

	PUSH_OFFSET(s_whoToDrop)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	short l_doDrop
	PUSH_OFFSET(s_cantDropCharacter)
	PRINTSTRING(true)
	IOWAIT
	jmp	l_returnZero

l_doDrop:
	push	[bp+slotNumber]
	CALL(party_pack)
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
dropPartyMember	endp
