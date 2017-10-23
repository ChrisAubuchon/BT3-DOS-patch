; Attributes: bp-based frame

roster_partyExists proc far

	loopCounter= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER
	CHKSTK(2)
	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lea	ax, g_rosterPartyBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	STRCMP
	or	ax, ax
	jz	l_returnPartyIndex
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 0Ah
	jl	l_loopEntry
l_returnMinusOne:
	mov	ax, 0FFFFh
	jmp	short l_return
l_returnPartyIndex:
	mov	ax, [bp+loopCounter]
l_return:
	FUNC_EXIT
	retf
roster_partyExists endp

