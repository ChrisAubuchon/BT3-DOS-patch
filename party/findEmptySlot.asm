; This function	searches through the roster looking
; for an entry that has	0 as the first character of
; the name field.
; Attributes: bp-based frame

party_findEmptySlot proc	far

	loopCounter= word ptr	-2

	FUNC_ENTER
	CHKSTK(2)
	mov	[bp+loopCounter], 0
l_loopEntry:
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_returnCounter
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loopEntry
	mov	ax, 7
	jmp	short l_return
l_returnCounter:
	mov	ax, [bp+loopCounter]
l_return:
	FUNC_EXIT
	retf
party_findEmptySlot endp
