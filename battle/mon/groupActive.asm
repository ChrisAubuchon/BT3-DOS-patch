; Attributes: bp-based frame

bat_monGroupActive proc far

	loopCounter= word ptr -2

	FUNC_ENTER(2)

	mov	[bp+loopCounter], 0
l_loop:
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short l_next
	mov	ax, 1
	jmp	short l_return

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_loop

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_monGroupActive endp
