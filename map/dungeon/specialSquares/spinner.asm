; Attributes: bp-based frame

dunsq_doSpinner	proc far

	slotNumber= word ptr	-2

	FUNC_ENTER(2)

	mov	[bp+slotNumber], 0
l_loop:
	mov	ax, itemEff_noSpin
	push	ax
	push	[bp+slotNumber]
	CALL(hasEffectEquipped)
	or	ax, ax
	jz	short l_returnOne
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	l_loop

	CALL(random)
	and	ax, 3
	mov	g_direction, ax
	sub	ax, ax
	jmp	short l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
dunsq_doSpinner	endp
