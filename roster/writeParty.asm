; Attributes: bp-based frame

roster_writeParty proc far

	emptySlot= word ptr -4
	counter= word ptr -2

	FUNC_ENTER
	CHKSTK(8)
	NEAR_CALL(party_findEmptySlot)
	mov	[bp+emptySlot],	ax
	mov	[bp+counter], 0
	jmp	short loc_13769
loc_13766:
	inc	[bp+counter]
loc_13769:
	mov	ax, [bp+emptySlot]
	cmp	[bp+counter], ax
	jge	l_return
	push	[bp+counter]
	CALL(roster_writeCharacter,2)
	jmp	loc_13766
l_return:
	FUNC_EXIT
	retf
roster_writeParty endp
