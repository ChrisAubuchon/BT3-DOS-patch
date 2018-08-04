; Attributes: bp-based frame

bat_monSortGroups proc far

	inOrderFlag= word ptr	-4		; Non-zero if two groups have been swapped
	loopCounter= word ptr	-2

	FUNC_ENTER(4)
	push	si

l_again:
	mov	[bp+inOrderFlag], 0
	mov	[bp+loopCounter], 3

l_loop:
	MONINDEX(ax, STACKVAR(loopCounter), si)
	test	gs:g_monGroups.groupSize[si], 1Fh
	jz	short l_next
	mov	al, gs:g_monGroups.distance[si]-monStruSize
	and	al, 0Fh
	mov	cl, gs:g_monGroups.distance[si]
	and	cl, 0Fh
	cmp	al, cl
	jbe	short l_next
	mov	[bp+inOrderFlag], 1
	mov	ax, [bp+loopCounter]
	dec	ax
	push	ax
	push	[bp+loopCounter]
	CALL(bat_monSwapGroups, near)

l_next:
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jg	short l_loop

loc_1CA37:
	cmp	[bp+inOrderFlag], 0
	jnz	short l_again

	pop	si
	FUNC_EXIT
	retf
bat_monSortGroups endp
