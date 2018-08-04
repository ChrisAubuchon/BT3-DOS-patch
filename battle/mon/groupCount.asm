; Attributes: bp-based frame

bat_monGroupCount proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)

	mov	[bp+loopCounter], 0

l_loop:
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:g_monGroups.groupSize[bx], 1Fh
	jnz	short l_next

	mov	ax, [bp+loopCounter]
	jmp	short l_return

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_loop

	mov	ax, 4

l_return:
	FUNC_EXIT
	retf
bat_monGroupCount endp
