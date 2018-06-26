; Attributes: bp-based frame

bat_partyAdvanceAction proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	[bp+loopCounter], 0

l_decrementMonsterDistanceLoop:
	MONINDEX(ax, STACKVAR(loopCounter), si)
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short l_decrementMonsterDistanceNext
	dec	gs:monGroups.distance[si]

l_decrementMonsterDistanceNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_decrementMonsterDistanceLoop

	PRINTOFFSET(s_thePartyAdvances, clear)
	mov	[bp+loopCounter], 0
l_characterLoop:
	mov	bx, [bp+loopCounter]
	mov	gs:g_charActionList[bx], charAction_defend
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_characterLoop

	mov	ax, 1

	pop	si
	FUNC_EXIT
	retf
bat_partyAdvanceAction endp
