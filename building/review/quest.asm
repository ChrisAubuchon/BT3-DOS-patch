; Attributes: bp-based frame

review_quest proc far

	loopCounter= word ptr -2

	FUNC_ENTER(2)

	mov	[bp+loopCounter], 0

l_loop:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	questFuncs[bx]
	or	ax, ax
	jz	short l_next

	push	[bp+loopCounter]
	CALL(review_questPartySetFlag, near)

	cmp	[bp+loopCounter], 2
	jl	short l_next
	cmp	[bp+loopCounter], 7
	jge	short l_next
	CALL(review_questAwardXp)
l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 8
	jl	short l_loop

l_return:
	FUNC_EXIT
	retf
review_quest endp
