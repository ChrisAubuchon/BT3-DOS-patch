; Attributes: bp-based frame

bat_monKill proc far

	loopCounter= word ptr -2
	groupNumber= word ptr  6
	slotNumber= word ptr	 8

	FUNC_ENTER(2)
	push	si

	mov	ax, [bp+slotNumber]
	mov	[bp+loopCounter], ax
l_loop:
	MONINDEX(ax, STACKVAR(groupNumber), bx)
	mov	al, gs:g_monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	cmp	ax, [bp+loopCounter]
	jb	short l_decrementGroupSize
	mov	si, [bp+groupNumber]
	mov	cl, 6
	shl	si, cl
	mov	ax, [bp+loopCounter]
	shl	ax, 1
	add	si, ax
	mov	ax, gs:(g_monHpList+2)[si]
	mov	gs:g_monHpList[si], ax
	mov	ax, gs:(bat_monPriorityList+2)[si]
	mov	gs:bat_monPriorityList[si], ax
	inc	[bp+loopCounter]
	jmp	short l_loop

l_decrementGroupSize:
	MONINDEX(ax, STACKVAR(groupNumber), si)
	dec	gs:g_monGroups.groupSize[si]
	test	gs:g_monGroups.groupSize[si], 1Fh
	jnz	short l_updateReward
	and	gs:g_monGroups.flags[si],	0FEh

l_updateReward:
	MONINDEX(ax, STACKVAR(groupNumber), si)
	mov	ah, gs:g_monGroups.rewardMid[si]
	sub	al, al
	mov	dl, gs:g_monGroups.rewardHi[si]
	sub	dh, dh
	mov	cl, 10h
	shl	dx, cl
	add	ax, dx
	mov	cl, gs:g_monGroups.rewardLo[si]
	sub	ch, ch
	add	ax, cx
	sub	dx, dx
	add	word ptr gs:g_battleXpReward, ax
	adc	word ptr gs:g_battleXpReward+2, dx

	pop	si
	FUNC_EXIT
	retf
bat_monKill endp
