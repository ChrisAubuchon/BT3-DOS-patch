; Attributes: bp-based frame

wanderer_join proc far

	emptySlotNumber= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER(2)

	CALL(party_findEmptySlot)			; find an empty slot number
	mov	[bp+emptySlotNumber], ax

	cmp	ax, 7					; no empty slot number?
	jl	short loc_25963
	CALL(dropPartyMember)				; pick a member to drop
	or	ax, ax
	jz	short l_returnZero			; return if not dropping
	CALL(party_findEmptySlot)
	mov	[bp+emptySlotNumber], ax
	mov	byte ptr g_printPartyFlag, 0

loc_25963:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+emptySlotNumber]
	CALL(_sp_convertMonToSummon)
	mov	byte ptr g_printPartyFlag, 0
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
wanderer_join endp
