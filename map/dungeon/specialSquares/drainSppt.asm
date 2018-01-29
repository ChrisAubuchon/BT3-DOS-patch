; Attributes: bp-based frame

dunsq_drainSppt	proc far

	slotNumber= word ptr	-2

	FUNC_ENTER(2)

	mov	[bp+slotNumber], 0
l_loop:
	CALL(random)
	and	ax, 3
	mov	cl, levelNoMaybe
	sub	ch, ch
	add	ax, cx
	mov	cx, ax

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.currentSppt[bx], cx
	jbe	short l_zeroSppt

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	gs:party.currentSppt[bx], cx
	jmp	short l_next

l_zeroSppt:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	gs:party.currentSppt[bx], 0

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

	mov	byte ptr g_printPartyFlag,	0
	sub	ax, ax
	FUNC_EXIT
	retf
dunsq_drainSppt	endp
