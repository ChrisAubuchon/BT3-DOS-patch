; This function	starts at the end of the roster	and
; returns the index of the last	slot that still	has
; a character active
; Attributes: bp-based frame

party_getLastSlot proc far

	loopCounter= word ptr	-2

	FUNC_ENTER
	CHKSTK(2)
	mov	[bp+loopCounter], 6
l_loopEntry:
	push	[bp+loopCounter]
	NEAR_CALL(party_isSlotActive, 2)
	or	ax, ax
	jnz	l_returnCounter
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jge	l_loopEntry
	mov	ax, 99
	jmp	l_return
l_returnCounter:
	mov	ax, [bp+loopCounter]
l_return:
	FUNC_EXIT
	retf
party_getLastSlot endp
