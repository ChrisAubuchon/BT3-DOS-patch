; Attributes: bp-based frame

bat_monCountGroups proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)

	mov	[bp+loopCounter], 3

l_loop:
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:g_monGroups.groupSize[bx], 1Fh
	jz	short l_next

	mov	ax, [bp+loopCounter]
	jmp	short l_return

l_next:
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jge	short l_loop

	mov	ax, 0FFFFh

l_return:
	FUNC_EXIT
	retf
bat_monCountGroups endp
