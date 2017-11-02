; Attributes: bp-based frame

tavern_getWineskin	proc far

	var_2= word ptr	-2
	partySlotNumber= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER
	CHKSTK(2)
	cmp	[bp+arg_2], 4
	jnz	short loc_13DF3
	sub	ax, ax
	jmp	short loc_13DF6
loc_13DF3:
	mov	ax, 4
loc_13DF6:
	mov	[bp+var_2], ax
	mov	ax, 1
	push	ax
	push	[bp+var_2]
	mov	ax, 76h	
	push	ax
	push	[bp+partySlotNumber]
	CALL(inven_addItem)
	or	ax, ax
	jz	short loc_13E22
	PUSH_OFFSET(s_barkeepFillsWineskin)
	PRINTSTRING
	jmp	short loc_13E55
loc_13E22:
	PUSH_OFFSET(s_sorryBut)
	PRINTSTRING
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PRINTSTRING
	PUSH_OFFSET(s_cantCarryAnyMore)
	PRINTSTRING
loc_13E55:
	IOWAIT
	FUNC_EXIT
	retf
tavern_getWineskin	endp

