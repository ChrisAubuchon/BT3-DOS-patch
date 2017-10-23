; Attributes: bp-based frame

temple_getGoldPoolee proc far

	pooleeSlotNumber= word ptr	-2
	lastSlot= word ptr	 6

	FUNC_ENTER
	CHKSTK(2)

	PUSH_OFFSET(s_whomGathersGold)
	PRINTSTRING(true)
	NEAR_CALL(readSlotNumber)
	mov	[bp+pooleeSlotNumber], ax
	or	ax, ax
	jl	short l_return
	mov	ax, [bp+lastSlot]
	cmp	[bp+pooleeSlotNumber], ax
	jge	short l_return

	push	ax
	push	[bp+pooleeSlotNumber]
	NEAR_CALL(doPoolGold, 4)
	CHARINDEX(ax, STACKVAR(pooleeSlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PRINTSTRING(true)
	PUSH_OFFSET(s_hathAllTheGold)
	PRINTSTRING

l_return:
	FUNC_EXIT
	retf
temple_getGoldPoolee endp
